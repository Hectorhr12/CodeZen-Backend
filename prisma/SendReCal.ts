import { PrismaClient, Genero, EstadoReserva, EstadoOrden } from '@prisma/client';

const prisma = new PrismaClient();

// Función para generar fechas aleatorias en el pasado (para reservas completadas)
function generarFechasReservasPasadas() {
  const ahora = new Date();
  const seiseMesesAtras = new Date();
  seiseMesesAtras.setMonth(seiseMesesAtras.getMonth() - 6);
  
  const fecha_inicio = new Date(seiseMesesAtras.getTime() + Math.random() * (ahora.getTime() - seiseMesesAtras.getTime()));
  const fecha_fin = new Date(fecha_inicio.getTime() + (Math.random() * 7 + 1) * 24 * 60 * 60 * 1000); // 1-7 días después
  
  return { fecha_inicio, fecha_fin };
}

// Función para generar fechas de reservas futuras
function generarFechasReservasFuturas() {
  const ahora = new Date();
  const tresMesesDespues = new Date();
  tresMesesDespues.setMonth(tresMesesDespues.getMonth() + 3);
  
  const fecha_inicio = new Date(ahora.getTime() + Math.random() * (tresMesesDespues.getTime() - ahora.getTime()));
  const fecha_fin = new Date(fecha_inicio.getTime() + (Math.random() * 5 + 1) * 24 * 60 * 60 * 1000); // 1-5 días después
  
  return { fecha_inicio, fecha_fin };
}

// Función para generar valores aleatorios para ingresos y viajes
function generarValoresAleatorios() {
  const ingresoTotal = Math.floor(Math.random() * 8000) + 2000; // Entre 2000 y 10000
  const NumeroViajes = Math.floor(Math.random() * 30) + 5; // Entre 5 y 35 viajes
  return { ingresoTotal, NumeroViajes };
}

// Datos de ciudades y provincias
const ciudadesData = [
  {
    nombre: 'Santa Cruz',
    provincias: ['Andrés Ibáñez', 'Warnes', 'Sara', 'Ichilo', 'Chiquitos']
  },
  {
    nombre: 'Cochabamba', 
    provincias: ['Cercado', 'Quillacollo', 'Sacaba', 'Tiquipaya', 'Colcapirhua']
  },
  {
    nombre: 'Tarija',
    provincias: ['Cercado', 'Méndez', 'Avilés', 'Gran Chaco', 'Arce']
  },
  {
    nombre: 'Sucre',
    provincias: ['Oropeza', 'Yamparáez', 'Zudáñez', 'Tomina', 'Hernando Siles']
  }
];

// Datos de usuarios renters
const usuariosRentersData = [
  {
    nombre: 'María González Pérez',
    correo: 'maria.gonzalez@email.com',
    fecha_nacimiento: new Date('1992-05-15'),
    genero: Genero.FEMENINO,
    telefono: '+591 70123456',
    ocupacion: 'Ingeniera de Software',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('María González Pérez')}`,

  },
  {
    nombre: 'Carlos Mendoza Silva',
    correo: 'carlos.mendoza@email.com',
    fecha_nacimiento: new Date('1988-11-22'),
    genero: Genero.MASCULINO,
    telefono: '+591 71234567',
    ocupacion: 'Médico Cirujano',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Carlos Mendoza Silva')}`,
  },
  {
    nombre: 'Ana Rodríguez López',
    correo: 'ana.rodriguez@email.com',
    fecha_nacimiento: new Date('1995-03-08'),
    genero: Genero.FEMENINO,
    telefono: '+591 72345678',
    ocupacion: 'Abogada',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Ana Rodríguez López')}`

  },
  {
    nombre: 'Luis Fernández Castro',
    correo: 'luis.fernandez@email.com',
    fecha_nacimiento: new Date('1990-07-12'),
    genero: Genero.MASCULINO,
    telefono: '+591 73456789',
    ocupacion: 'Arquitecto',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Luis Fernández Castro')}`

  },
  {
    nombre: 'Sofia Vargas Morales',
    correo: 'sofia.vargas@email.com',
    fecha_nacimiento: new Date('1993-09-25'),
    genero: Genero.FEMENINO,
    telefono: '+591 74567890',
    ocupacion: 'Diseñadora Gráfica',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Sofia Vargas Morales')}`
  },
  {
    nombre: 'Diego Morales Quispe',
    correo: 'diego.morales@email.com',
    fecha_nacimiento: new Date('1987-12-03'),
    genero: Genero.MASCULINO,
    telefono: '+591 75678901',
    ocupacion: 'Contador Público',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Diego Morales Quispe')}`
  },
  {
    nombre: 'Valentina Cruz Mamani',
    correo: 'valentina.cruz@email.com',
    fecha_nacimiento: new Date('1994-06-18'),
    genero: Genero.FEMENINO,
    telefono: '+591 76789012',
    ocupacion: 'Psicóloga Clínica',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Valentina Cruz Mamani')}`
  },
  {
    nombre: 'Roberto Silva Condori',
    correo: 'roberto.silva@email.com',
    fecha_nacimiento: new Date('1989-04-30'),
    genero: Genero.MASCULINO,
    telefono: '+591 77890123',
    ocupacion: 'Profesor Universitario',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent( 'Roberto Silva Condori')}`
  },
  {
    nombre: 'Camila Herrera Vega',
    correo: 'camila.herrera@email.com',
    fecha_nacimiento: new Date('1991-08-14'),
    genero: Genero.FEMENINO,
    telefono: '+591 78901234',
    ocupacion: 'Administradora de Empresas',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Camila Herrera Vega')}`
  },
  {
    nombre: 'Andrés Gutiérrez Rojas',
    correo: 'andres.gutierrez@email.com',
    fecha_nacimiento: new Date('1986-02-28'),
    genero: Genero.MASCULINO,
    telefono: '+591 79012345',
    ocupacion: 'Ingeniero Civil',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Andrés Gutiérrez Rojas')}`
  }
];

// Datos adicionales de hosts
const usuariosHostsData = [
  {
    nombre: 'Patricia Mamani Quispe',
    correo: 'patricia.mamani@email.com',
    fecha_nacimiento: new Date('1985-07-20'),
    genero: Genero.FEMENINO,
    telefono: '+591 68123456',
    ocupacion: 'Empresaria',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Andrés Gutiérrez Rojas')}`

  },
  {
    nombre: 'Fernando Choque Apaza',
    correo: 'fernando.choque@email.com',
    fecha_nacimiento: new Date('1982-10-15'),
    genero: Genero.MASCULINO,
    telefono: '+591 69234567',
    ocupacion: 'Comerciante',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Fernando Choque Apaza')}`
  },
  {
    nombre: 'Gabriela Torrez Mendez',
    correo: 'gabriela.torrez@email.com',
    fecha_nacimiento: new Date('1990-04-12'),
    genero: Genero.FEMENINO,
    telefono: '+591 67345678',
    ocupacion: 'Gerente de Ventas',
    foto:`https://ui-avatars.com/api/?name=${encodeURIComponent('Gabriela Torrez Mendez')}`
  }
];

// Datos de carros adicionales
const carrosAdicionales = [
  {
    vim: '1HGCM82633A123456',
    año: 2019,
    marca: 'TOYOTA',
    modelo: 'RAV4',
    placa: 'ABC-1234',
    asientos: 5,
    puertas: 4,
    soat: true,
    precio_por_dia: 65.0,
    num_mantenimientos: 1,
    transmicion: 'Automática',
    estado: 'Disponible',
    descripcion: 'SUV Toyota RAV4 en excelente estado, ideal para viajes familiares'
  },
  {
    vim: '2C3KA53G76H234567',
    año: 2020,
    marca: 'HYUNDAI',
    modelo: 'TUCSON',
    placa: 'DEF-5678',
    asientos: 5,
    puertas: 4,
    soat: true,
    precio_por_dia: 70.0,
    num_mantenimientos: 0,
    transmicion: 'Automática',
    estado: 'Disponible',
    descripcion: 'Hyundai Tucson 2020, SUV moderno con todas las comodidades'
  },
  {
    vim: '3N1AB7AP5KY345678',
    año: 2018,
    marca: 'NISSAN',
    modelo: 'VERSA',
    placa: 'GHI-9012',
    asientos: 5,
    puertas: 4,
    soat: true,
    precio_por_dia: 42.0,
    num_mantenimientos: 2,
    transmicion: 'Manual',
    estado: 'Disponible',
    descripcion: 'Nissan Versa económico y confiable para la ciudad'
  },
  {
    vim: '1FTFW1ET4EK456789',
    año: 2021,
    marca: 'CHEVROLET',
    modelo: 'ONIX',
    placa: 'JKL-3456',
    asientos: 5,
    puertas: 4,
    soat: true,
    precio_por_dia: 38.0,
    num_mantenimientos: 0,
    transmicion: 'Manual',
    estado: 'Disponible',
    descripcion: 'Chevrolet Onix nuevo, perfecto para uso urbano'
  },
  {
    vim: '5YJ3E1EA7KF567890',
    año: 2017,
    marca: 'KIA',
    modelo: 'SPORTAGE',
    placa: 'MNO-7890',
    asientos: 5,
    puertas: 4,
    soat: true,
    precio_por_dia: 58.0,
    num_mantenimientos: 3,
    transmicion: 'Automática',
    estado: 'Disponible',
    descripcion: 'KIA Sportage SUV espacioso y cómodo'
  },
  {
    vim: '1G1ZD5ST8JF678901',
    año: 2022,
    marca: 'VOLKSWAGEN',
    modelo: 'TIGUAN',
    placa: 'PQR-1234',
    asientos: 7,
    puertas: 4,
    soat: true,
    precio_por_dia: 75.0,
    num_mantenimientos: 0,
    transmicion: 'Automática',
    estado: 'Disponible',
    descripcion: 'Volkswagen Tiguan 7 asientos, ideal para grupos grandes'
  }
];

async function main() {
  console.log('🚀 Iniciando generación completa de datos con relaciones Usuario-Carro correctas...');

  // 1. Crear o verificar país Bolivia
  let paisBolivia = await prisma.pais.findFirst({ where: { nombre: 'Bolivia' } });
  if (!paisBolivia) {
    paisBolivia = await prisma.pais.create({ data: { nombre: 'Bolivia' } });
    console.log('✅ País Bolivia creado');
  }

  // 2. Crear ciudades y provincias
  const ciudadesCreadas = [];
  for (const ciudadData of ciudadesData) {
    let ciudad = await prisma.ciudad.findFirst({ where: { nombre: ciudadData.nombre } });
    if (!ciudad) {
      ciudad = await prisma.ciudad.create({
        data: {
          nombre: ciudadData.nombre,
          id_pais: paisBolivia.id
        }
      });
      console.log(`✅ Ciudad creada: ${ciudad.nombre}`);
    }

    // Crear provincias para esta ciudad
    for (const provinciaNombre of ciudadData.provincias) {
      let provincia = await prisma.provincia.findFirst({
        where: { 
          nombre: provinciaNombre,
          id_ciudad: ciudad.id 
        }
      });
      if (!provincia) {
        provincia = await prisma.provincia.create({
          data: {
            nombre: provinciaNombre,
            id_ciudad: ciudad.id
          }
        });
        console.log(`✅ Provincia creada: ${provinciaNombre} en ${ciudad.nombre}`);
      }
    }

    ciudadesCreadas.push(ciudad);
  }

  // 3. Obtener o crear roles
  const rolesBase = ['RENTER', 'HOST', 'DRIVER'];
  const roles: Record<string, { id: number; rol: string }> = {};

  for (const rolName of rolesBase) {
    let rol = await prisma.rol.findFirst({ where: { rol: rolName } });
    if (!rol) {
      rol = await prisma.rol.create({ data: { rol: rolName } });
    }
    roles[rolName] = rol;
  }

  // 4. Crear usuarios renters
  const usuariosRenters = [];
  const usuarioRolesRenters = [];
  
  for (const userData of usuariosRentersData) {
    const ciudadAleatoria = ciudadesCreadas[Math.floor(Math.random() * ciudadesCreadas.length)];
    
    const usuario = await prisma.usuario.create({
      data: {
        ...userData,
        id_ciudad: ciudadAleatoria.id,
        contraseña: 'password123',
        saldo: Math.floor(Math.random() * 2000) + 1000, // Saldo entre 1000-3000
      }
    });

    // Asignar rol de RENTER
    const usuarioRol = await prisma.usuarioRol.create({
      data: {
        id_usuario: usuario.id,
        id_rol: roles['RENTER'].id,
      }
    });

    usuariosRenters.push(usuario);
    usuarioRolesRenters.push(usuarioRol);
    console.log(`✅ Usuario renter creado: ${usuario.nombre} (ID: ${usuario.id})`);
  }

  // 5. Crear usuarios hosts adicionales
  const usuariosHosts = [];
  
  for (const userData of usuariosHostsData) {
    const ciudadAleatoria = ciudadesCreadas[Math.floor(Math.random() * ciudadesCreadas.length)];
    
    const usuario = await prisma.usuario.create({
      data: {
        ...userData,
        id_ciudad: ciudadAleatoria.id,
        contraseña: '$2b$10$2qPa21fUyak.hfVD8maAju0mmrVouIqK269oS2Vdpn2inG6S3uGZy', // Contraseña encriptada="Contra123."
        saldo: Math.floor(Math.random() * 5000) + 2000, // Saldo entre 2000-7000
      }
    });

    // Asignar rol de HOST
    await prisma.usuarioRol.create({
      data: {
        id_usuario: usuario.id,
        id_rol: roles['HOST'].id,
      }
    });

    usuariosHosts.push(usuario);
    console.log(`✅ Usuario host creado: ${usuario.nombre} (ID: ${usuario.id})`);
  }

  // 6. Obtener TODOS los usuarios que tienen rol de HOST
  const usuariosConRolHost = await prisma.usuario.findMany({
    where: {
      roles: {
        some: {
          id_rol: roles['HOST'].id
        }
      }
    },
    include: {
      roles: {
        where: {
          id_rol: roles['HOST'].id
        }
      }
    }
  });

  console.log(`📊 Total de usuarios con rol HOST: ${usuariosConRolHost.length}`);

  // 7. Obtener todas las provincias para crear direcciones
  const todasLasProvincias = await prisma.provincia.findMany();

  // 8. Crear características adicionales y tipos de combustible
  const caracteristicasAdicionales = [
    'Aire acondicionado', 'Bluetooth', 'GPS', 'Portabicicletas',
    'Soporte para esquís', 'Pantalla táctil', 'Sillas para bebé',
    'Cámara de reversa', 'Asientos de cuero', 'Sistema antirrobo',
    'Toldo o rack de techo', 'Vidrios polarizados', 'Sistema de sonido',
    'Control de crucero', 'Sensores de estacionamiento'
  ];

  const tiposCombustible = ['Gasolina', 'GNV', 'Eléctrico', 'Diesel'];

  const caracteristicasMap: Record<string, number> = {};
  for (const nombre of caracteristicasAdicionales) {
    const existente = await prisma.carasteristicasAdicionales.findFirst({
      where: { nombre },
    });
    const created = existente ?? await prisma.carasteristicasAdicionales.create({
      data: { nombre },
    });
    caracteristicasMap[nombre] = created.id;
  }

  const combustibleMap: Record<string, number> = {};
  for (const nombre of tiposCombustible) {
    const existente = await prisma.tipoCombustible.findFirst({
      where: { tipoDeCombustible: nombre },
    });
    const created = existente ?? await prisma.tipoCombustible.create({
      data: { tipoDeCombustible: nombre, id_carro: 0 },
    });
    combustibleMap[nombre] = created.id;
  }

  // 9. Crear carros adicionales para los hosts
  const carrosCreados = [];
  for (let i = 0; i < carrosAdicionales.length; i++) {
    const carroData = carrosAdicionales[i];
    const hostUsuario = usuariosConRolHost[i % usuariosConRolHost.length]; // Distribuir entre todos los hosts
    const provinciaAleatoria = todasLasProvincias[Math.floor(Math.random() * todasLasProvincias.length)];

    // Crear dirección para el carro
    const direccion = await prisma.direccion.create({
      data: {
        id_provincia: provinciaAleatoria.id,
        calle: `Av. Principal ${Math.floor(Math.random() * 1000) + 100}`,
        zona: `Zona ${Math.floor(Math.random() * 20) + 1}`,
        num_casa: `${Math.floor(Math.random() * 999) + 100}`,
        latitud: -16.5 + (Math.random() - 0.5) * 0.1,
        longitud: -68.15 + (Math.random() - 0.5) * 0.1,
      }
    });

    // ✅ CORRECTO: Crear el carro con id_usuario_rol = Usuario.id del HOST
    const carro = await prisma.carro.create({
      data: {
        ...carroData,
        id_direccion: direccion.id,
        id_usuario_rol: hostUsuario.id, // ✅ ID del Usuario que tiene rol HOST
        ...generarValoresAleatorios(),
        disponible_desde: new Date(),
        disponible_hasta: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000), // 1 año
        calificacionpromedio: 4.0 + Math.random() * 1.0, // Entre 4.0 y 5.0
      },
    });

    // Asignar características adicionales al carro
    const caracteristicasSeleccionadas = [...caracteristicasAdicionales]
      .sort(() => 0.5 - Math.random())
      .slice(0, Math.floor(Math.random() * 5) + 3); // 3-7 características

    for (const caracteristica of caracteristicasSeleccionadas) {
      await prisma.caracteristicasAdicionalesCarro.create({
        data: {
          id_carro: carro.id,
          id_carasteristicasAdicionales: caracteristicasMap[caracteristica],
        },
      });
    }

    // Asignar tipos de combustible
    const combustiblesSeleccionados = [...tiposCombustible]
      .sort(() => 0.5 - Math.random())
      .slice(0, Math.random() > 0.7 ? 2 : 1); // Mayormente 1, a veces 2

    for (const combustible of combustiblesSeleccionados) {
      await prisma.combustibleCarro.create({
        data: {
          id_carro: carro.id,
          id_combustible: combustibleMap[combustible],
        },
      });
    }

    carrosCreados.push({ carro, hostUsuario });
    console.log(`🚗 Carro creado: ${carro.marca} ${carro.modelo} para HOST ${hostUsuario.nombre} (Usuario ID: ${hostUsuario.id})`);
  }

  // 10. Obtener todos los carros existentes con sus propietarios
  const carrosExistentes = await prisma.carro.findMany({
    include: {
      Usuario: true // Relación directa con Usuario
    }
  });

  console.log(`📊 Total de carros disponibles: ${carrosExistentes.length}`);

  // 11. Crear reservas COMPLETADAS
  const reservasCompletadas = [];
  const numReservas = 30; // Crear 30 reservas completadas

  for (let i = 0; i < numReservas; i++) {
    const renterAleatorio = usuariosRenters[Math.floor(Math.random() * usuariosRenters.length)];
    const carroAleatorio = carrosExistentes[Math.floor(Math.random() * carrosExistentes.length)];
    const { fecha_inicio, fecha_fin } = generarFechasReservasPasadas();
    
    const diasAlquiler = Math.ceil((fecha_fin.getTime() - fecha_inicio.getTime()) / (1000 * 60 * 60 * 24));
    const montoTotal = carroAleatorio.precio_por_dia * diasAlquiler;
    
    const reserva = await prisma.reserva.create({
      data: {
        id_carro: carroAleatorio.id,
        id_usuario: renterAleatorio.id,
        fecha_inicio,
        fecha_fin,
        estado: 'COMPLETADA',
        Estado: EstadoReserva.COMPLETADA, // ✅ Estado COMPLETADA
        kilometraje: Math.floor(Math.random() * 800) + 200, // 200-1000 km
        montoPagoInicial: montoTotal * 0.3, // 30% como pago inicial
        montoTotalConDescuento: montoTotal,
        hora_inicio: Math.floor(Math.random() * 12) + 8, // Entre 8 AM y 8 PM
        hora_fin: Math.floor(Math.random() * 12) + 8,
        fecha_expiracion: new Date(fecha_fin.getTime() + 24 * 60 * 60 * 1000), // 1 día después
      }
    });

    reservasCompletadas.push({
      reserva,
      renter: renterAleatorio,
      host: carroAleatorio.Usuario, // ✅ Usuario propietario del carro (HOST)
      carro: carroAleatorio
    });

    console.log(`📅 Reserva COMPLETADA: RENTER ${renterAleatorio.nombre} -> ${carroAleatorio.marca} ${carroAleatorio.modelo} (${diasAlquiler} días) - HOST: ${carroAleatorio.Usuario.nombre}`);
  }

  // 12. Crear algunas reservas futuras
  for (let i = 0; i < 12; i++) {
    const renterAleatorio = usuariosRenters[Math.floor(Math.random() * usuariosRenters.length)];
    const carroAleatorio = carrosExistentes[Math.floor(Math.random() * carrosExistentes.length)];
    const { fecha_inicio, fecha_fin } = generarFechasReservasFuturas();
    
    const diasAlquiler = Math.ceil((fecha_fin.getTime() - fecha_inicio.getTime()) / (1000 * 60 * 60 * 24));
    const montoTotal = carroAleatorio.precio_por_dia * diasAlquiler;
    
    await prisma.reserva.create({
      data: {
        id_carro: carroAleatorio.id,
        id_usuario: renterAleatorio.id,
        fecha_inicio,
        fecha_fin,
        estado: 'confirmada',
        Estado: EstadoReserva.CONFIRMADA,
        montoPagoInicial: montoTotal * 0.3,
        montoTotalConDescuento: montoTotal,
        hora_inicio: Math.floor(Math.random() * 12) + 8,
        hora_fin: Math.floor(Math.random() * 12) + 8,
        fecha_expiracion: new Date(fecha_inicio.getTime() - 24 * 60 * 60 * 1000), // 1 día antes
      }
    });

    console.log(`📅 Reserva FUTURA: RENTER ${renterAleatorio.nombre} -> ${carroAleatorio.marca} ${carroAleatorio.modelo} - HOST: ${carroAleatorio.Usuario.nombre}`);
  }

  // 13. Crear calificaciones de hosts hacia renters (SOLO para reservas completadas)
  const comentariosPositivos = [
    'Excelente renter, muy cuidadoso con el vehículo y puntual en las entregas',
    'Persona muy responsable, devolvió el carro en perfectas condiciones',
    'Comunicación excelente durante todo el proceso, muy recomendable',
    'Renter ejemplar, sin ningún problema durante el alquiler',
    'Muy cuidadoso con el vehículo, respetó todas las condiciones del contrato',
    'Persona confiable y respetuosa, excelente experiencia',
    'Puntual tanto en la recogida como en la devolución del vehículo',
    'Trato muy profesional, definitivamente volvería a alquilarle',
    'Cuidó el carro como si fuera propio, muy satisfecho con el servicio',
    'Renter responsable que siguió todas las instrucciones al pie de la letra'
  ];

  for (const { reserva, renter, host, carro } of reservasCompletadas) {
    // Calificación del host hacia el renter
    const calificacionCarro = Math.floor(Math.random() * 2) + 4; // 4-5 estrellas
    const calificacionUsuario = Math.floor(Math.random() * 2) + 4; // 4-5 estrellas
    
    const calificacion = await prisma.calificacion.create({
      data: {
        id_usuario_rol: host.id, // ✅ ID del Usuario HOST que califica
        calf_carro: calificacionCarro,
        calf_usuario: calificacionUsuario,
        id_carro: carro.id,
        id_usuario: renter.id, // ✅ ID del Usuario RENTER que es calificado
      }
    });

    // Comentario de la calificación
    await prisma.comentarios.create({
      data: {
        contenido: comentariosPositivos[Math.floor(Math.random() * comentariosPositivos.length)],
        id_usuario: host.id, // ✅ Usuario HOST que comenta
        id_carro: carro.id,
        id_calificacion: calificacion.id,
        likes: Math.floor(Math.random() * 15) + 5, // 5-20 likes
        dont_likes: Math.floor(Math.random() * 3), // 0-2 dislikes
      }
    });

    // Calificación detallada de la reserva
    await prisma.calificacionReserva.create({
      data: {
        id_reserva: reserva.id,
        comportamiento: Math.floor(Math.random() * 2) + 4, // 4-5
        cuidado_vehiculo: Math.floor(Math.random() * 2) + 4, // 4-5
        puntualidad: Math.floor(Math.random() * 2) + 4, // 4-5
        comentario: `${renter.nombre} demostró ser un renter excepcional. Muy responsable y cuidadoso con el vehículo.`,
      }
    });

    console.log(`⭐ Calificación creada: HOST ${host.nombre} (ID: ${host.id}) calificó a RENTER ${renter.nombre} (ID: ${renter.id}) - ${calificacionUsuario}/5`);
  }

  // 14. Crear órdenes de pago para las reservas completadas
  for (const { reserva, renter, host, carro } of reservasCompletadas) {
    const ordenPago = await prisma.ordenPago.create({
      data: {
        codigo: `ORD-${Date.now()}-${Math.floor(Math.random() * 10000)}`,
        id_usuario_host: host.id, // ✅ ID del Usuario HOST
        id_usuario_renter: renter.id, // ✅ ID del Usuario RENTER
        id_carro: carro.id,
        monto_a_pagar: reserva.montoTotalConDescuento || carro.precio_por_dia,
        estado: EstadoOrden.COMPLETADO,
      }
    });

    // Crear comprobante de pago
    await prisma.comprobanteDePago.create({
      data: {
        id_orden: ordenPago.id,
        numero_transaccion: `TXN-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
      }
    });
  }

  // 15. Crear favoritos (renters que marcan carros como favoritos)
  for (let i = 0; i < 25; i++) {
    const renterAleatorio = usuariosRenters[Math.floor(Math.random() * usuariosRenters.length)];
    const carroAleatorio = carrosExistentes[Math.floor(Math.random() * carrosExistentes.length)];
    
    const usuarioRolRenter = usuarioRolesRenters.find(ur => ur.id_usuario === renterAleatorio.id);

    if (usuarioRolRenter) {
      try {
        await prisma.favorito.create({
          data: {
            id_usuario_rol: usuarioRolRenter.id, // ✅ ID del UsuarioRol del RENTER
            id_carro: carroAleatorio.id,
            id_usuario: renterAleatorio.id, // ✅ ID del Usuario RENTER
          }
        });
        console.log(`❤️ Favorito: RENTER ${renterAleatorio.nombre} -> ${carroAleatorio.marca} ${carroAleatorio.modelo} (HOST: ${carroAleatorio.Usuario.nombre})`);
      } catch (error) {
        // Ignorar duplicados
      }
    }
  }

  console.log('\n🎉 ¡Generación completa de datos finalizada exitosamente!');
  console.log(`📊 Resumen completo:`);
  console.log(`   - ${ciudadesData.length} ciudades con sus provincias`);
  console.log(`   - ${usuariosRenters.length} usuarios RENTERS`);
  console.log(`   - ${usuariosHosts.length} usuarios HOSTS adicionales`);
  console.log(`   - ${usuariosConRolHost.length} HOSTS totales disponibles`);
  console.log(`   - ${carrosAdicionales.length} carros adicionales creados`);
  console.log(`   - ${carrosExistentes.length} carros totales disponibles`);
  console.log(`   - ${reservasCompletadas.length} reservas COMPLETADAS`);
  console.log(`   - 12 reservas futuras`);
  console.log(`   - ${reservasCompletadas.length} calificaciones de HOSTS hacia RENTERS`);
  console.log(`   - ${reservasCompletadas.length} órdenes de pago COMPLETADAS`);
  console.log(`   - ~25 favoritos`);
  
  console.log('\n✅ RELACIONES CORRECTAS:');
  console.log('   - Carro.id_usuario_rol = Usuario.id (donde Usuario tiene rol HOST)');
  console.log('   - Calificacion.id_usuario_rol = Usuario.id del HOST que califica');
  console.log('   - Calificacion.id_usuario = Usuario.id del RENTER calificado');
  console.log('   - OrdenPago: HOST recibe, RENTER paga');
  console.log('   - Favorito.id_usuario_rol = UsuarioRol.id del RENTER');
  console.log('   - Favorito.id_usuario = Usuario.id del RENTER');
}

main()
  .catch((e) => {
    console.error('❌ Error durante la generación:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });