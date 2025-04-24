import express from "express"
import { executeWithIsolatedClient } from "./lib/prisma.js"

const router = express.Router()

// Endpoint para verificar el estado de la conexión a la base de datos
router.get("/health", async (req, res) => {
  try {
    // Verificar la conexión usando un cliente aislado
    await executeWithIsolatedClient(async (client) => {
      await client.$queryRaw`SELECT 1`
    })

    res.status(200).json({ status: "ok", database: "connected" })
  } catch (error) {
    console.error("Error en health check:", error)
    res.status(503).json({ status: "error", database: "disconnected", message: error.message })
  }
})

export default router
