const { prisma } = require('../config/prisma.js');

const HistoryModel = {
  async getHistory({ userId, search, status, page, limit }) {
    const skip = (page - 1) * limit;
    
    const where = {
      id_usuario: userId,
      ...(search && {
        OR: [
          { carro: { marca: { contains: search, mode: 'insensitive' } } },
          { carro: { modelo: { contains: search, mode: 'insensitive' } } },
          { usuario: { nombre: { contains: search, mode: 'insensitive' } } }
        ]
      }),
      ...(status && { estado: status }) 
    };
    
    const [reservas, total] = await Promise.all([
      prisma.reserva.findMany({
        where,
        include: {
          carro: {
            include: {
              direccion: {
                include: {
                  ciudad: true,
                  provincia: true,
                  pais: true
                }
              },
              combustibles: true,
              caracteristicas: true,
              imagenes: { take: 1 }
            }
          },
          usuario: true,
          descuento: true
        },
        orderBy: { fecha_creacion: 'desc' },
        skip,
        take: limit
      }),
      prisma.reserva.count({ where })
    ]);
    
    return {
      data: reservas.map(reserva => ({
        ...reserva,
        carro: {
          ...reserva.carro,
          imagen_principal: reserva.carro.imagenes[0]?.url || null
        }
      })),
      pagination: {
        total,
        pages: Math.ceil(total / limit),
        currentPage: page,
        perPage: limit
      }
    };
  },

  async getHostHistory({ hostId, search, status, page, limit }) {
    const skip = (page - 1) * limit;
    
    const where = {
      carro: {
        id_usuario_rol: parseInt(hostId),
        ...(search && {
          OR: [
            { marca: { contains: search, mode: 'insensitive' } },
            { modelo: { contains: search, mode: 'insensitive' } }
          ]
        })
      },
      ...(status && { estado: status })
    };
    
    const [reservas, total] = await Promise.all([
      prisma.reserva.findMany({
        where,
        select: {
          id: true,
          fecha_inicio: true,
          fecha_fin: true,
          estado: true,
          carro: {
            select: {
              marca: true,
              modelo: true,
              imagenes: {
                select: {
                  url: true
                },
                take: 1
              }
            }
          },
          usuario: {
            select: {
              nombre: true,
              foto: true
            }
          }
        },
        orderBy: { fecha_creacion: 'desc' },
        skip,
        take: limit
      }),
      prisma.reserva.count({ 
        where: {
          carro: {
            id_usuario_rol: parseInt(hostId),
            ...(search && {
              OR: [
                { marca: { contains: search, mode: 'insensitive' } },
                { modelo: { contains: search, mode: 'insensitive' } }
              ]
            })
          },
          ...(status && { estado: status })
        }
      })
    ]);
    
    return {
      data: reservas.map(reserva => ({
        id: reserva.id,
        fecha_inicio: reserva.fecha_inicio,
        fecha_fin: reserva.fecha_fin,
        estado: reserva.estado,
        marca: reserva.carro.marca,
        modelo: reserva.carro.modelo,
        imagen: reserva.carro.imagenes[0]?.url || null,
        nombre_usuario: reserva.usuario.nombre,
        foto_usuario: reserva.usuario.foto
      })),
      pagination: {
        total,
        pages: Math.ceil(total / limit),
        currentPage: page,
        perPage: limit
      }
    };
  },

  async getReservationDetails(id, userId) {
    return await prisma.reserva.findFirst({
      where: {
        id: parseInt(id),
        OR: [
          { id_usuario: userId },
          { carro: { id_usuario_rol: userId } }
        ]
      },
      include: {
        carro: {
          include: {
            direccion: {
              include: {
                ciudad: true,
                provincia: true,
                pais: true
              }
            },
            combustibles: true,
            caracteristicas: true,
            imagenes: true
          }
        },
        usuario: true,
        descuento: true
      }
    });
  }
};

module.exports = { HistoryModel };