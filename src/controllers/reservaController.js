const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const getAllReservas = async (req, res) => {
  try {
    const reservas = await prisma.reserva.findMany({
      include: {
        carro: true,
        usuario: true,
        descuento: true
      }
    });
    
    res.json({
      success: true,
      data: reservas
    });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({
      success: false,
      error: 'Error al obtener reservas'
    });
  }
};

module.exports = {
  getAllReservas
};