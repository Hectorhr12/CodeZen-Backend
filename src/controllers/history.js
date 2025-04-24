const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const historyController = {
  async getHistory(req, res) {
    try {   
      const { userId, search, status, page = 1, limit = 10 } = req.query;
      
      if (!userId) {
        return res.status(400).json({
          success: false,
          error: 'Se requiere el parámetro userId'
        });
      }

      const skip = (parseInt(page) - 1) * parseInt(limit);
      
      // Consulta segura usando Prisma Client (no raw queries)
      const where = {
        usuario: {
          usuarioRoles: {
            some: {
              id: parseInt(userId)
            }
          }
        },
        ...(status && { estado: status }),
        ...(search && {
          OR: [
            { carro: { marca: { contains: search, mode: 'insensitive' } } },
            { carro: { modelo: { contains: search, mode: 'insensitive' } } },
            { usuario: { nombre: { contains: search, mode: 'insensitive' } } }
          ]
        })
      };
      
      const [data, total] = await Promise.all([
        prisma.reserva.findMany({
          where,
          skip,
          take: parseInt(limit),
          include: {
            carro: {
              include: {
                imagenes: {
                  take: 1 // Solo traer la primera imagen
                }
              }
            },
            usuario: {
              select: {
                nombre: true,
                correo: true
              }
            }
          },
          orderBy: {
            fecha_inicio: 'desc'
          }
        }),
        prisma.reserva.count({ where })
      ]);
      
      res.json({
        success: true,
        data: data.map(reserva => ({
          ...reserva,
          imagen_url: reserva.carro.imagenes[0]?.url || null,
          precio_dia: reserva.carro.precio_por_dia
        })),
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / parseInt(limit))
        }
      });
    } catch (error) {
      console.error('Error en getHistory:', error);
      res.status(500).json({ 
        success: false,
        error: 'Error al obtener el historial',
        details: error.message
      });
    }
  },

  async getHostHistory(req, res) {
    try {
      const { hostId, page = 1, limit = 10 } = req.query;
      
      if (!hostId) {
        return res.status(400).json({
          success: false,
          error: 'Se requiere el parámetro hostId'
        });
      }
  
      const skip = (parseInt(page) - 1) * parseInt(limit);
      
      const [data, total] = await Promise.all([
        prisma.reserva.findMany({
          where: {
            carro: {
              id_usuario_rol: parseInt(hostId) // Corrected field name
            }
          },
          skip,
          take: parseInt(limit),
          select: {
            fecha_inicio: true,
            fecha_fin: true,
            estado: true,
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
            },
            usuario: {
              select: {
                nombre: true
              }
            }
          },
          orderBy: {
            fecha_inicio: 'desc'
          }
        }),
        prisma.reserva.count({
          where: {
            carro: {
              id_usuario_rol: parseInt(hostId) // Corrected field name
            }
          }
        })
      ]);
  
      const formattedData = data.map(reserva => ({
        imagen_url: reserva.carro.imagenes[0]?.url || null,
        marca: reserva.carro.marca,
        modelo: reserva.carro.modelo,
        nombre_usuario: reserva.usuario.nombre,
        fecha_inicio: reserva.fecha_inicio,
        fecha_fin: reserva.fecha_fin,
        estado: reserva.estado
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
      console.error('Error en getHostHistory:', error);
      res.status(500).json({ 
        success: false,
        error: 'Error al obtener el historial del host',
        details: error.message
      });
    }
  },

  async getReservationDetails(req, res) {
    try {
      const { id } = req.params;
      
      const reservation = await prisma.reserva.findUnique({
        where: { id: parseInt(id) },
        include: {
          carro: {
            include: {
              imagenes: true,
              UsuarioRol: {
                include: {
                  usuario: true
                }
              }
            }
          },
          usuario: true,
          descuento: true
        }
      });
      
      if (!reservation) {
        return res.status(404).json({
          success: false,
          error: 'Reserva no encontrada'
        });
      }
      
      res.json({
        success: true,
        data: {
          ...reservation,
          host_info: reservation.carro.usuarioRol.usuario
        }
      });
    } catch (error) {
      console.error('Error en getReservationDetails:', error);
      res.status(500).json({ 
        success: false,
        error: 'Error al obtener detalles de la reserva',
        details: error.message
      });
    }
  }
};

module.exports = { historyController };