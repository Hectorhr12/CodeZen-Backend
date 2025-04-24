import express from "express"
import cors from "cors"
import prisma, { executeWithIsolatedClient, executeWithTransaction } from "./lib/prisma.js"
import { ensureDatabaseConnection } from "./middleware/database-connection.js"
import healthCheckRouter from "./health-check.js"

const app = express()
app.use(cors())
app.use(express.json())
// Aplicar el middleware a las rutas que usan la base de datos
app.use(["/api/usuario", "/api/rentas","/api/rentas/calificaciones"], ensureDatabaseConnection)
// Añadir el router de health check
app.use("/", healthCheckRouter)
// Get completed rentals
app.get("/api/rentas/completadas/:id", async (req, res) => {
  const userId = parseInt(req.params.id, 10); // ID del usuario desde los parámetros de la ruta
  if (isNaN(userId)) {
    return res.status(400).json({ error: "El ID del usuario debe ser un número válido." });
  }
  try {
    // Usar un cliente aislado para esta operación (solo lectura)
    const rentalDetails = await executeWithIsolatedClient(async (client) => {
      const rentals = await client.reserva.findMany({
        where: {
          estado: "completado",
          carro: {
            id_usuario_rol: userId, // Filtro por id_usuario_rol del auto
          },
        },
        include: {
          carro: { select: { modelo: true, marca: true } },
          usuario: { select: { nombre: true, id: true } },
        },
        orderBy: {
        fecha_fin: 'desc', // Ordenar por fecha_fin en orden descendente
        },
      });
      // Transformar los resultados
      return rentals.map((r) => ({
        idReserva: r.id,
        autoNombre: `${r.carro.marca} ${r.carro.modelo}`,
        usuarioNombre: r.usuario.nombre,
        usuarioId: r.usuario.id,
        fechaFin: r.fecha_fin,
        estado: r.estado,
      }));
    });

    res.json(rentalDetails); // Responder con las rentas completadas para el usuario específico
  } catch (error) {
    console.error("Error al obtener rentas completadas:", error);
    res.status(500).json({ error: "Error al obtener rentas completadas" });
  }
});

app.get('/api/usuario/:id', async (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número válido' });
  }
  try {
    // Usar un cliente aislado para esta operación (solo lectura)
    const usuarioDetails = await executeWithIsolatedClient(async (client) => {
      const usuario = await client.Usuario.findUnique({
        where: { id },
        include: {
          reservas: { include: { carro: { select: { marca: true, modelo: true } } } },
          ciudad: { select: { nombre: true } },
        },
      });
      if (!usuario) {
        throw new Error('Usuario no encontrado');
      }
      // Transformar los datos para coincidir con el formato de la imagen proporcionada
      return {
        id: usuario.id,
        nombre: usuario.nombre,
        correo: usuario.correo,
        fecha_nacimiento: usuario.fecha_nacimiento,
        genero: usuario.genero,
        id_ciudad: usuario.id_ciudad,
        nombre_ciudad: usuario.ciudad?.nombre || 'Ciudad no especificada',
        contraseña: usuario.contraseña, // Considera usar medidas de seguridad adicionales
        google_id: usuario.google_id,
        foto: usuario.foto,
        telefono: usuario.telefono,
      };
    });
    res.json(usuarioDetails);
  } catch (error) {
    console.error("Error al obtener usuario:", error);
    const statusCode = error.message === 'Usuario no encontrado' ? 404 : 500;
    res.status(statusCode).json({ error: error.message });
  }
});
// Ejemplo de operación de escritura con transacción
app.post("/api/rentas/calificaciones/:id", async (req, res) => {
  try {
    const { id_reserva, comportamiento, cuidadovehiculo, puntualidad, id_calificador, id_calificado } = req.body
    // Usar transacciones para operaciones de escritura
    const nuevaCalificacion = await executeWithTransaction(async (tx) => {
      // Verificar si ya existe una calificación para esta reserva
      const calificacionExistente = await tx.calificacionHostUsuario.findFirst({
        where: {
          id_reserva,
          id_calificador,
        },
      })
      if (calificacionExistente) {
        throw new Error("Ya existe una calificación para esta reserva")
      }
      // Crear la nueva calificación dentro de la transacción
      return await tx.calificacionHostUsuario.create({
        data: {
          id_reserva,
          comportamiento,
          cuidadovehiculo,
          puntualidad,
          id_calificador,
          id_calificado,
          fecha_creacion: new Date(),
        },
        include: {
          reserva: { include: { carro: true, usuario: true } },
          calificador: { select: { nombre: true } },
          calificado: { select: { nombre: true } },
        },
      })
    })
    res.status(201).json({
      idCalificacion: nuevaCalificacion.id,
      comportamiento: nuevaCalificacion.comportamiento,
      cuidadoVehiculo: nuevaCalificacion.cuidadovehiculo,
      puntualidad: nuevaCalificacion.puntualidad,
      comentario: nuevaCalificacion.comentario || "Sin comentario",
      reservaId: nuevaCalificacion.id_reserva,
      calificadorNombre: nuevaCalificacion.calificador.nombre,
      calificadoNombre: nuevaCalificacion.calificado.nombre,
      fechaCreacion: nuevaCalificacion.fecha_creacion,
    })
  } catch (error) {
    console.error("Error al crear calificación:", error)
    res.status(500).json({ error: "Error al crear calificación", message: error.message })
  }
});

app.get("/api/rentas/calificaciones/:id", async (req, res) => {
  const userId = parseInt(req.params.id, 10); // ID del usuario obtenido desde la ruta
  if (isNaN(userId)) {
    return res.status(400).json({ error: "El ID del usuario debe ser un número válido." });
  }
  try {
    // Usar cliente aislado para consulta
    const calificacionDetails = await executeWithIsolatedClient(async (client) => {
      const calificaciones = await client.calificacionHostUsuario.findMany({
        where: {
          reserva: {
            carro:{
              id_usuario_rol:userId,
            }
          },
        },
        include: {
          reserva: {
            include: {
              carro: { select: { modelo: true, marca: true } },
              usuario: { select: { nombre: true, id: true } },
            },
          },
          calificador: { select: { nombre: true, id: true } },
          calificado: { select: { nombre: true, id: true } },
        },
      });
      // Transformar los resultados para enriquecer los datos
      return calificaciones.map((c) => ({
        idCalificacion: c.id,
        comportamiento: c.comportamiento,
        cuidadoVehiculo: c.cuidadovehiculo,
        puntualidad: c.puntualidad,
        comentario: c.comentario || "Sin comentario",
        reservaId: c.id_reserva,
        autoNombre: `${c.reserva.carro.marca} ${c.reserva.carro.modelo}`,
        usuarioNombre: c.reserva.usuario.nombre,
        usuarioId: c.reserva.usuario.id,
        calificadorNombre: c.calificador.nombre,
        calificadorId: c.calificador.id,
        calificadoNombre: c.calificado.nombre,
        calificadoId: c.calificado.id,
        fechaCreacion: c.fecha_creacion,
      }));
    });
    // Respuesta exitosa
    if (calificacionDetails.length === 0) {
      return res.status(404).json({ message: "No se encontraron calificaciones para este usuario." });
    }
    res.json(calificacionDetails);
  } catch (error) {
    console.error("Error al obtener calificaciones:", error);
    res.status(500).json({ error: "Error al obtener calificaciones", message: error.message });
  }
});

app.put("/api/rentas/calificaciones/:idUser/:id", async (req, res) => {
  const { idUser, id } = req.params;
  const { comportamiento, cuidadovehiculo, puntualidad } = req.body;

  try {
    // Verificar que la calificación existe y pertenece al calificador
    const calificacionExistente = await prisma.calificacionHostUsuario.findFirst({
      where: {
        id: Number(id),
        id_calificador: Number(idUser),
      },
    });

    if (!calificacionExistente) {
      return res.status(404).json({ error: "Calificación no encontrada o no pertenece al usuario especificado." });
    }

    // Actualizar la calificación
    const calificacionActualizada = await prisma.calificacionHostUsuario.update({
      where: { id: Number(id) },
      data: {
        comportamiento,
        cuidadovehiculo,
        puntualidad,
      },
      include: {
        reserva: { include: { carro: true, usuario: true } },
        calificador: { select: { nombre: true } },
        calificado: { select: { nombre: true } },
      },
    });
    res.json({
      idCalificacion: calificacionActualizada.id,
      comportamiento: calificacionActualizada.comportamiento,
      cuidadoVehiculo: calificacionActualizada.cuidadovehiculo,
      puntualidad: calificacionActualizada.puntualidad,
      comentario: calificacionActualizada.comentario || "Sin comentario",
      reservaId: calificacionActualizada.id_reserva,
      calificadorNombre: calificacionActualizada.calificador.nombre,
      calificadoNombre: calificacionActualizada.calificado.nombre,
      fechaCreacion: calificacionActualizada.fecha_creacion,
    });
  } catch (error) {
    console.error("Error al actualizar calificación:", error);
    res.status(500).json({ error: "Error al actualizar calificación" });
  }
});

app.delete("/api/rentas/calificaciones/:id/:idCal", async (req, res) => {
  const userId = parseInt(req.params.id, 10);     // ID of the calificador
  const calificacionId = parseInt(req.params.idCal, 10); // ID of the calificación
  if (isNaN(userId) || isNaN(calificacionId)) {
    return res.status(400).json({ error: "IDs inválidos. Los parámetros deben ser números válidos." });
  }
  try {
    await executeWithIsolatedClient(async (client) => {
      // Verify that the calificación belongs to the calificador
      const calificacionExistente = await client.calificacionHostUsuario.findFirst({
        where: {
          id: calificacionId,
          id_calificador: userId,
        },
      });
      if (!calificacionExistente) {
        throw new Error("La calificación no pertenece al usuario o no existe.");
      }
      // Delete the calificación
      await client.calificacionHostUsuario.delete({
        where: { id: calificacionId },
      });
    });
    res.json({ message: "Calificación eliminada correctamente." });
  } catch (error) {
    console.error("Error al eliminar calificación:", error);
    res.status(500).json({
      error: "Error al eliminar calificación.",
      message: error.message,
    });
  }
});
app.get('/api/comentarios/:id', async (req, res) => {
  const id = parseInt(req.params.id)

  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número válido' })
  }

  try {
    const comentarios = await executeWithIsolatedClient(async (client) => {
      const encontrados = await client.calificacionHostUsuario.findMany({
        where: { id_calificado: id },
        include: {
          calificador: {
            select: {
              id: true,
              nombre: true,
              foto: true,
            },
          },
        },
        orderBy: {
          fecha_creacion: 'desc',
        },
      })

      if (!encontrados || encontrados.length === 0) {
        throw new Error('No se encontraron comentarios para este usuario')
      }

      return encontrados
    })

    res.json(comentarios)
  } catch (error) {
    console.error('Error al obtener comentarios:', error)
    const statusCode = error.message.includes('comentarios') ? 404 : 500
    res.status(statusCode).json({ error: error.message })
  }
})
//Api de historial-4 
app.get("/api/host-history", async (req, res) => {
  try {
    const { hostId, page = 1, limit = 10 } = req.query;
    
    if (!hostId) {
      return res.status(400).json({
        success: false,
        error: "Se requiere el parámetro hostId"
      });
    }
    
    const skip = (parseInt(page) - 1) * parseInt(limit);
    
    const [data, total] = await Promise.all([
      prisma.reserva.findMany({
        where: {
          carro: {
            usuario: {
              id: parseInt(hostId)
            }
          }
        },
        select: {
          fecha_inicio: true,
          fecha_fin: true,
          estado: true,
          usuario: {
            select: {
              id: true, // 📌 Se agregó la selección del ID del usuario
              nombre: true
            }
          },
          carro: {
            select: {
              marca: true,
              modelo: true,
              imagenes: {
                take: 1,
                select: {
                  url: true
                }
              }
            }
          }
        },
        orderBy: {
          fecha_inicio: 'desc'
        },
        skip,
        take: parseInt(limit)
      }),
      prisma.reserva.count({
        where: {
          carro: {
            usuario: {
              id: parseInt(hostId)
            }
          }
        }
      })
    ]);

    // Agregamos el ID del usuario a la respuesta
    const formattedData = data.map(reserva => ({
      nombre_usuario: reserva.usuario.nombre,
      imagen_url: reserva.carro.imagenes[0]?.url || null,
      marca: reserva.carro.marca,
      modelo: reserva.carro.modelo,
      fecha_inicio: reserva.fecha_inicio,
      fecha_fin: reserva.fecha_fin,
      estado: reserva.estado,
      user_id: reserva.usuario.id, // 📌 Se agregó el ID del usuario
    }));

    res.json({
      success: true,
      data: formattedData,
      pagination: {
        total,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(total / parseInt(limit))
      }
    });
  } catch (error) {
    console.error("Error en /api/host-history:", error);
    res.status(500).json({ 
      success: false,
      error: "Error al obtener el historial del host",
      details: error.message
    });
  }
});




// Iniciar el servidor
async function startServer() {
  try {
    // Verificar la conexión inicial
    await executeWithIsolatedClient(async (client) => {
      await client.$queryRaw`SELECT 1`
    })

    console.log("Conexión con la base de datos establecida correctamente.")

    // Iniciar el servidor
    const PORT = process.env.PORT
    app.listen(PORT, () => {
      console.log(`Servidor corriendo en http://localhost:${PORT}`)
    })

    // Manejar el cierre del servidor
    process.on("SIGINT", async () => {
      console.log("Cerrando conexión a la base de datos...")
      await prisma.$disconnect()
      console.log("Conexión cerrada correctamente")
      process.exit(0)
    })
  } catch (error) {
    console.error("Error crítico al conectar con la base de datos:", error)
    console.log("Reintentando conexión en 5 segundos...")
    setTimeout(startServer, 5000)
  }
}

// Iniciar el servidor
startServer()
