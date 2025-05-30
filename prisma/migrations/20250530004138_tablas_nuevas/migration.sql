/*
  Warnings:

  - You are about to drop the column `comentario` on the `Calificacion` table. All the data in the column will be lost.
  - You are about to drop the column `fecha_creacion` on the `Calificacion` table. All the data in the column will be lost.
  - You are about to drop the column `anio` on the `Carro` table. All the data in the column will be lost.
  - You are about to drop the column `color` on the `Carro` table. All the data in the column will be lost.
  - You are about to drop the column `transmision` on the `Carro` table. All the data in the column will be lost.
  - You are about to drop the column `pagoPorDanos` on the `Garantia` table. All the data in the column will be lost.
  - You are about to drop the column `fecha_creacion` on the `Notificacion` table. All the data in the column will be lost.
  - You are about to drop the column `leida` on the `Notificacion` table. All the data in the column will be lost.
  - The `estado` column on the `Reserva` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `Aux123` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Papitas` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[id_condiciones_uso]` on the table `Carro` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `año` to the `Carro` table without a default value. This is not possible if the table is not empty.
  - Added the required column `transmicion` to the `Carro` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `estado` on the `Carro` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "EstadoOrden" AS ENUM ('PENDIENTE', 'PROCESANDO', 'COMPLETADO', 'CANCELADO');

-- CreateEnum
CREATE TYPE "EstadoConductor" AS ENUM ('NO_REQUESTED', 'PENDING', 'APPROVED');

-- CreateEnum
CREATE TYPE "EstadoLicencia" AS ENUM ('ACTIVA', 'VENCIDA', 'SUSPENDIDA');

-- CreateEnum
CREATE TYPE "EstadoSolicitud" AS ENUM ('PENDIENTE', 'APROBADA', 'RECHAZADA');

-- CreateEnum
CREATE TYPE "CategoriaLicencia" AS ENUM ('M', 'P', 'A', 'B', 'C', 'T');

-- CreateEnum
CREATE TYPE "TipoSolicitudAsociacion" AS ENUM ('RENTER_A_DRIVER', 'DRIVER_A_RENTER');

-- CreateEnum
CREATE TYPE "EstadoSolicitudAsociacion" AS ENUM ('PENDIENTE', 'ACEPTADA', 'RECHAZADA', 'CANCELADA');

-- AlterEnum
ALTER TYPE "Roles" ADD VALUE 'ADMIN';

-- DropForeignKey
ALTER TABLE "Busqueda" DROP CONSTRAINT "Busqueda_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Calificacion" DROP CONSTRAINT "Calificacion_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Calificacion" DROP CONSTRAINT "Calificacion_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "CombustibleCarro" DROP CONSTRAINT "CombustibleCarro_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Favorito" DROP CONSTRAINT "Favorito_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Favorito" DROP CONSTRAINT "Favorito_id_usuario_rol_fkey";

-- DropForeignKey
ALTER TABLE "Imagen" DROP CONSTRAINT "Imagen_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Notificacion" DROP CONSTRAINT "Notificacion_id_usuario_rol_fkey";

-- DropForeignKey
ALTER TABLE "PasswordRecoveryCode" DROP CONSTRAINT "PasswordRecoveryCode_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Provincia" DROP CONSTRAINT "Provincia_id_ciudad_fkey";

-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "SeguroCarro" DROP CONSTRAINT "SeguroCarro_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Ubicacion" DROP CONSTRAINT "Ubicacion_id_direccion_fkey";

-- DropForeignKey
ALTER TABLE "UsuarioRol" DROP CONSTRAINT "UsuarioRol_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "aeropuerto" DROP CONSTRAINT "aeropuerto_id_ciudad_fkey";

-- DropForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" DROP CONSTRAINT "caracteristicasAdicionalesCarro_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "contratodeAlquiler" DROP CONSTRAINT "contratodeAlquiler_id_carro_fkey";

-- DropIndex
DROP INDEX "Busqueda_id_usuario_idx";

-- DropIndex
DROP INDEX "Calificacion_id_carro_idx";

-- DropIndex
DROP INDEX "Calificacion_id_usuario_idx";

-- DropIndex
DROP INDEX "Carro_estado_idx";

-- DropIndex
DROP INDEX "Carro_id_direccion_idx";

-- DropIndex
DROP INDEX "Carro_id_tipodeDescuento_idx";

-- DropIndex
DROP INDEX "Carro_id_usuario_rol_idx";

-- DropIndex
DROP INDEX "Carro_marca_modelo_idx";

-- DropIndex
DROP INDEX "Carro_placa_key";

-- DropIndex
DROP INDEX "Ciudad_id_pais_idx";

-- DropIndex
DROP INDEX "CombustibleCarro_id_carro_idx";

-- DropIndex
DROP INDEX "CombustibleCarro_id_combustible_idx";

-- DropIndex
DROP INDEX "Descuento_id_descuentoTipo_idx";

-- DropIndex
DROP INDEX "Direccion_id_provincia_idx";

-- DropIndex
DROP INDEX "Favorito_id_carro_idx";

-- DropIndex
DROP INDEX "Favorito_id_usuario_idx";

-- DropIndex
DROP INDEX "Favorito_id_usuario_rol_id_carro_key";

-- DropIndex
DROP INDEX "Favorito_id_usuario_rol_idx";

-- DropIndex
DROP INDEX "Garantia_id_reserva_idx";

-- DropIndex
DROP INDEX "Imagen_id_carro_idx";

-- DropIndex
DROP INDEX "Notificacion_id_usuario_rol_idx";

-- DropIndex
DROP INDEX "PasswordRecoveryCode_codigo_idx";

-- DropIndex
DROP INDEX "PasswordRecoveryCode_id_usuario_idx";

-- DropIndex
DROP INDEX "Provincia_id_ciudad_idx";

-- DropIndex
DROP INDEX "Reserva_estado_idx";

-- DropIndex
DROP INDEX "Reserva_fecha_inicio_fecha_fin_idx";

-- DropIndex
DROP INDEX "Reserva_id_carro_idx";

-- DropIndex
DROP INDEX "Reserva_id_usuario_idx";

-- DropIndex
DROP INDEX "Rol_rol_key";

-- DropIndex
DROP INDEX "SeguroCarro_id_carro_idx";

-- DropIndex
DROP INDEX "SeguroCarro_id_seguro_idx";

-- DropIndex
DROP INDEX "Ubicacion_id_direccion_idx";

-- DropIndex
DROP INDEX "Usuario_correo_idx";

-- DropIndex
DROP INDEX "Usuario_google_id_idx";

-- DropIndex
DROP INDEX "Usuario_google_id_key";

-- DropIndex
DROP INDEX "Usuario_id_ciudad_idx";

-- DropIndex
DROP INDEX "UsuarioRol_id_rol_idx";

-- DropIndex
DROP INDEX "UsuarioRol_id_usuario_idx";

-- DropIndex
DROP INDEX "aeropuerto_id_ciudad_idx";

-- DropIndex
DROP INDEX "caracteristicasAdicionalesCarro_id_carasteristicasAdicional_idx";

-- DropIndex
DROP INDEX "caracteristicasAdicionalesCarro_id_carro_idx";

-- DropIndex
DROP INDEX "contratodeAlquiler_id_carro_idx";

-- AlterTable
ALTER TABLE "Calificacion" DROP COLUMN "comentario",
DROP COLUMN "fecha_creacion";

-- AlterTable
ALTER TABLE "Carro" DROP COLUMN "anio",
DROP COLUMN "color",
DROP COLUMN "transmision",
ADD COLUMN     "año" INTEGER NOT NULL,
ADD COLUMN     "calificacionpromedio" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "id_condiciones_uso" INTEGER,
ADD COLUMN     "notificaion_confirmacion_id" INTEGER,
ADD COLUMN     "transmicion" TEXT NOT NULL,
DROP COLUMN "estado",
ADD COLUMN     "estado" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Garantia" DROP COLUMN "pagoPorDanos",
ADD COLUMN     "pagoPorDaños" BOOLEAN;

-- AlterTable
ALTER TABLE "Notificacion" DROP COLUMN "fecha_creacion",
DROP COLUMN "leida";

-- AlterTable
ALTER TABLE "Reserva" ADD COLUMN     "Estado" "EstadoReserva" NOT NULL DEFAULT 'PENDIENTE',
DROP COLUMN "estado",
ADD COLUMN     "estado" TEXT NOT NULL DEFAULT 'pendiente';

-- AlterTable
ALTER TABLE "SeguroCarro" ADD COLUMN     "enlace" VARCHAR(255),
ADD COLUMN     "enlaceSeguro" TEXT;

-- AlterTable
ALTER TABLE "Usuario" ADD COLUMN     "busquedas" TEXT,
ADD COLUMN     "estadoConductor" "EstadoConductor" DEFAULT 'NO_REQUESTED',
ADD COLUMN     "saldo" DOUBLE PRECISION NOT NULL DEFAULT 0,
ALTER COLUMN "fecha_actualizacion" DROP NOT NULL,
ALTER COLUMN "fecha_creacion" DROP NOT NULL;

-- DropTable
DROP TABLE "Aux123";

-- DropTable
DROP TABLE "Papitas";

-- CreateTable
CREATE TABLE "OrdenPago" (
    "id" SERIAL NOT NULL,
    "codigo" TEXT NOT NULL,
    "id_usuario_host" INTEGER NOT NULL,
    "id_usuario_renter" INTEGER NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "fecha_de_emision" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "monto_a_pagar" DOUBLE PRECISION NOT NULL,
    "estado" "EstadoOrden" NOT NULL DEFAULT 'PENDIENTE',

    CONSTRAINT "OrdenPago_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComprobanteDePago" (
    "id" SERIAL NOT NULL,
    "fecha_emision" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id_orden" INTEGER NOT NULL,
    "numero_transaccion" TEXT NOT NULL,

    CONSTRAINT "ComprobanteDePago_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SolicitudConductor" (
    "id" SERIAL NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "front" TEXT NOT NULL,
    "back" TEXT NOT NULL,
    "estado" "EstadoSolicitud" NOT NULL DEFAULT 'PENDIENTE',
    "categoria" "CategoriaLicencia" NOT NULL,
    "numeroLicencia" TEXT NOT NULL,
    "fechaEmision" TIMESTAMP(3) NOT NULL,
    "fechaVencimiento" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SolicitudConductor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LicenciaConducir" (
    "id" SERIAL NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "numeroLicencia" TEXT NOT NULL,
    "fechaEmision" TIMESTAMP(3) NOT NULL,
    "fechaVencimiento" TIMESTAMP(3) NOT NULL,
    "categoria" "CategoriaLicencia" NOT NULL,
    "estado" "EstadoLicencia" NOT NULL DEFAULT 'ACTIVA',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LicenciaConducir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SolicitudAsociacion" (
    "id" SERIAL NOT NULL,
    "solicitanteId" INTEGER NOT NULL,
    "receptorId" INTEGER NOT NULL,
    "tipo" "TipoSolicitudAsociacion" NOT NULL,
    "mensaje" VARCHAR(150),
    "estado" "EstadoSolicitud" NOT NULL DEFAULT 'PENDIENTE',
    "fechaSolicitud" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fechaRespuesta" TIMESTAMP(3),

    CONSTRAINT "SolicitudAsociacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Asociacion" (
    "id" SERIAL NOT NULL,
    "renterId" INTEGER NOT NULL,
    "driverId" INTEGER NOT NULL,
    "fechaInicio" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "activa" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Asociacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comentarios" (
    "id" SERIAL NOT NULL,
    "contenido" TEXT,
    "id_comentariorespondido" INTEGER,
    "comentado_en" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "id_usuario" INTEGER,
    "id_usuariorol" INTEGER,
    "id_carro" INTEGER,
    "id_calificacion" INTEGER,
    "likes" INTEGER,
    "dont_likes" INTEGER,

    CONSTRAINT "comentarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "condiciones_generales" (
    "id" SERIAL NOT NULL,
    "edad_minima" INTEGER NOT NULL,
    "edad_maxima" INTEGER NOT NULL,
    "kilometraje_max_dia" DOUBLE PRECISION NOT NULL,
    "fumar" BOOLEAN NOT NULL,
    "mascota" BOOLEAN NOT NULL,
    "dev_mismo_conb" BOOLEAN NOT NULL,
    "uso_fuera_ciudad" BOOLEAN NOT NULL,
    "multa_conductor" BOOLEAN NOT NULL,
    "dev_mismo_lugar" BOOLEAN NOT NULL,
    "uso_comercial" BOOLEAN NOT NULL,

    CONSTRAINT "condiciones_generales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "condiciones_uso" (
    "id" SERIAL NOT NULL,
    "id_condiciones_generales" INTEGER,
    "id_devolucion_auto" INTEGER,
    "id_entrega_auto" INTEGER,

    CONSTRAINT "condiciones_uso_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "devolucion_auto" (
    "id" SERIAL NOT NULL,
    "interior_limpio" BOOLEAN NOT NULL,
    "exterior_limpio" BOOLEAN NOT NULL,
    "rayones" BOOLEAN NOT NULL,
    "herramientas" BOOLEAN NOT NULL,
    "cobrar_daños" BOOLEAN NOT NULL,
    "combustible_igual" BOOLEAN NOT NULL,

    CONSTRAINT "devolucion_auto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "entrega_auto" (
    "id" SERIAL NOT NULL,
    "estado_combustible" VARCHAR(255) NOT NULL,
    "esterior_limpio" BOOLEAN NOT NULL,
    "inter_limpio" BOOLEAN NOT NULL,
    "rayones" BOOLEAN NOT NULL,
    "llanta_estado" BOOLEAN NOT NULL,
    "interior_daño" BOOLEAN NOT NULL,

    CONSTRAINT "entrega_auto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "herramientas_basicas" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "cantidad" DOUBLE PRECISION NOT NULL,
    "id_entrega_auto" INTEGER NOT NULL,

    CONSTRAINT "herramientas_basicas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificaion_confirmacion" (
    "id" SERIAL NOT NULL,
    "mensaje" TEXT NOT NULL,
    "fecha" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "estado" BOOLEAN,
    "id_renter" INTEGER,
    "id_host" INTEGER,

    CONSTRAINT "notificacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tiposeguro" (
    "id" SERIAL NOT NULL,
    "tipodaño" VARCHAR(255),
    "descripcion" TEXT,
    "segurocarro_id" INTEGER,
    "valides" VARCHAR(255),
    "cantidadCobertura" VARCHAR(255),

    CONSTRAINT "tiposeguro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReservaConductor" (
    "id" SERIAL NOT NULL,
    "id_reserva" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "ReservaConductor_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "OrdenPago_codigo_key" ON "OrdenPago"("codigo");

-- CreateIndex
CREATE UNIQUE INDEX "condiciones_uso_id_condiciones_generales_key" ON "condiciones_uso"("id_condiciones_generales");

-- CreateIndex
CREATE UNIQUE INDEX "condiciones_uso_id_devolucion_auto_key" ON "condiciones_uso"("id_devolucion_auto");

-- CreateIndex
CREATE UNIQUE INDEX "condiciones_uso_id_entrega_auto_key" ON "condiciones_uso"("id_entrega_auto");

-- CreateIndex
CREATE UNIQUE INDEX "uq_carro_condiciones_uso" ON "Carro"("id_condiciones_uso");

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carro" ADD CONSTRAINT "Carro_id_condiciones_uso_fkey" FOREIGN KEY ("id_condiciones_uso") REFERENCES "condiciones_uso"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CombustibleCarro" ADD CONSTRAINT "CombustibleCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "UsuarioRol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Imagen" ADD CONSTRAINT "Imagen_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notificacion" ADD CONSTRAINT "Notificacion_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordRecoveryCode" ADD CONSTRAINT "PasswordRecoveryCode_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Provincia" ADD CONSTRAINT "Provincia_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrdenPago" ADD CONSTRAINT "OrdenPago_id_usuario_host_fkey" FOREIGN KEY ("id_usuario_host") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrdenPago" ADD CONSTRAINT "OrdenPago_id_usuario_renter_fkey" FOREIGN KEY ("id_usuario_renter") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrdenPago" ADD CONSTRAINT "OrdenPago_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComprobanteDePago" ADD CONSTRAINT "ComprobanteDePago_id_orden_fkey" FOREIGN KEY ("id_orden") REFERENCES "OrdenPago"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeguroCarro" ADD CONSTRAINT "SeguroCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ubicacion" ADD CONSTRAINT "Ubicacion_id_direccion_fkey" FOREIGN KEY ("id_direccion") REFERENCES "Direccion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SolicitudConductor" ADD CONSTRAINT "SolicitudConductor_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LicenciaConducir" ADD CONSTRAINT "LicenciaConducir_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SolicitudAsociacion" ADD CONSTRAINT "SolicitudAsociacion_solicitanteId_fkey" FOREIGN KEY ("solicitanteId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SolicitudAsociacion" ADD CONSTRAINT "SolicitudAsociacion_receptorId_fkey" FOREIGN KEY ("receptorId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Asociacion" ADD CONSTRAINT "Asociacion_renterId_fkey" FOREIGN KEY ("renterId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Asociacion" ADD CONSTRAINT "Asociacion_driverId_fkey" FOREIGN KEY ("driverId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsuarioRol" ADD CONSTRAINT "UsuarioRol_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aeropuerto" ADD CONSTRAINT "aeropuerto_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" ADD CONSTRAINT "caracteristicasAdicionalesCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comentarios" ADD CONSTRAINT "comentarios_id_comentariorespondido_fkey" FOREIGN KEY ("id_comentariorespondido") REFERENCES "comentarios"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentarios" ADD CONSTRAINT "comentarios_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentarios" ADD CONSTRAINT "comentarios_id_usuariorol_fkey" FOREIGN KEY ("id_usuariorol") REFERENCES "UsuarioRol"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentarios" ADD CONSTRAINT "id_calificacion" FOREIGN KEY ("id_calificacion") REFERENCES "Calificacion"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentarios" ADD CONSTRAINT "id_carro" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "condiciones_uso" ADD CONSTRAINT "condiciones_uso_id_condiciones_generales_fkey" FOREIGN KEY ("id_condiciones_generales") REFERENCES "condiciones_generales"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "condiciones_uso" ADD CONSTRAINT "condiciones_uso_id_devolucion_auto_fkey" FOREIGN KEY ("id_devolucion_auto") REFERENCES "devolucion_auto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "condiciones_uso" ADD CONSTRAINT "condiciones_uso_id_entrega_auto_fkey" FOREIGN KEY ("id_entrega_auto") REFERENCES "entrega_auto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contratodeAlquiler" ADD CONSTRAINT "contratodeAlquiler_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tiposeguro" ADD CONSTRAINT "tiposeguro_segurocarro_id_fkey" FOREIGN KEY ("segurocarro_id") REFERENCES "SeguroCarro"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ReservaConductor" ADD CONSTRAINT "ReservaConductor_id_reserva_fkey" FOREIGN KEY ("id_reserva") REFERENCES "Reserva"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReservaConductor" ADD CONSTRAINT "ReservaConductor_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
