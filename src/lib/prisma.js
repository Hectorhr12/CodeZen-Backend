import { PrismaClient } from "@prisma/client"

// Configuración para el cliente Prisma
const prismaClientSingleton = () => {
  return new PrismaClient({
    // Configuración de logging
    log: process.env.NODE_ENV === "development" ? ["query", "error", "warn"] : ["error"],
    // Configuración de la fuente de datos
    datasources: {
      db: {
        url: process.env.DATABASE_URL,
      },
    },
    // Configuración interna (opcional)
    __internal: {
      engine: {
        // Configuración de reintentos para la conexión
        retry: {
          maxRetries: 3,
          initialDelay: 100, // ms
          maxDelay: 1000, // ms
        },
      },
    },
  })
}

// Usar un objeto global para almacenar la instancia de PrismaClient
const globalForPrisma = global
const prisma = globalForPrisma.prisma || prismaClientSingleton()

// Solo guardar la instancia en desarrollo para evitar múltiples instancias durante hot reload
if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = prisma

// Función para crear un cliente aislado para operaciones específicas
function createIsolatedPrismaClient() {
  const isolatedClient = new PrismaClient({
    datasources: {
      db: {
        url: process.env.DATABASE_URL,
      },
    },
  })

  return {
    client: isolatedClient,
    async disconnect() {
      await isolatedClient.$disconnect()
    },
  }
}

// Función para ejecutar una operación con un cliente aislado
async function executeWithIsolatedClient(operation) {
  const { client, disconnect } = createIsolatedPrismaClient()

  try {
    const result = await operation(client)
    return result
  } finally {
    // Siempre desconectar el cliente aislado después de usarlo
    await disconnect()
  }
}

// Función para ejecutar operaciones con transacciones
async function executeWithTransaction(operation, maxRetries = 3) {
  let retries = 0

  while (retries < maxRetries) {
    try {
      return await executeWithIsolatedClient(async (client) => {
        // Iniciar una transacción para asegurar consistencia
        return await client.$transaction(async (tx) => {
          return await operation(tx)
        })
      })
    } catch (error) {
      // Si es un error de concurrencia (podría ser un error de serialización en PostgreSQL)
      if (
        error.code === "P2034" ||
        error.message?.includes("could not serialize access") ||
        error.message?.includes("deadlock detected")
      ) {
        retries++
        if (retries < maxRetries) {
          // Esperar un tiempo aleatorio antes de reintentar (backoff exponencial)
          const delay = Math.floor(100 * Math.pow(2, retries) * (0.5 + Math.random() * 0.5))
          console.log(`Conflicto de concurrencia detectado. Reintentando en ${delay}ms...`)
          await new Promise((resolve) => setTimeout(resolve, delay))
          continue
        }
      }
      // Si no es un error de concurrencia o se agotaron los reintentos, propagar el error
      throw error
    }
  }
}

// Función para reintentar la conexión a la base de datos
async function executeWithConnectionRetry(operation, maxRetries = 3, delay = 1000) {
  let retries = 0
  while (retries < maxRetries) {
    try {
      return await operation()
    } catch (error) {
      console.error(`Error en la operación (intento ${retries + 1}):`, error)
      retries++
      if (retries < maxRetries) {
        console.log(`Reintentando en ${delay / 1000} segundos...`)
        await new Promise((resolve) => setTimeout(resolve, delay))
      } else {
        throw error // Lanzar el error después del último intento
      }
    }
  }
}

export { prisma, executeWithIsolatedClient, executeWithConnectionRetry, executeWithTransaction }

export default prisma
