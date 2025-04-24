import { executeWithIsolatedClient } from "../lib/prisma.js"

// Middleware para verificar la conexión a la base de datos
const ensureDatabaseConnection = async (req, res, next) => {
  try {
    // Verificar la conexión usando un cliente aislado
    await executeWithIsolatedClient(async (client) => {
      // Ejecutar una consulta simple para verificar la conexión
      await client.$queryRaw`SELECT 1`
    })

    // Si llegamos aquí, la conexión está bien
    next()
  } catch (error) {
    console.error("Error de conexión a la base de datos:", error)
    return res.status(503).json({
      error: "Servicio temporalmente no disponible. Por favor, inténtelo de nuevo.",
    })
  }
}

export { ensureDatabaseConnection }
