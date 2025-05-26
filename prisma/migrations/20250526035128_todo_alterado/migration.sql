/*
  Warnings:

  - You are about to drop the column `id_carro` on the `CarasteristicasAdicionales` table. All the data in the column will be lost.
  - You are about to drop the column `año` on the `Carro` table. All the data in the column will be lost.
  - You are about to drop the column `transmicion` on the `Carro` table. All the data in the column will be lost.
  - The `estado` column on the `Carro` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `fecha` on the `Descuento` table. All the data in the column will be lost.
  - You are about to drop the column `porcentaje` on the `Descuento` table. All the data in the column will be lost.
  - You are about to drop the column `direccion` on the `Direccion` table. All the data in the column will be lost.
  - You are about to drop the column `id_ciudad` on the `Direccion` table. All the data in the column will be lost.
  - You are about to drop the column `id_pais` on the `Direccion` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `Imagen` table. All the data in the column will be lost.
  - You are about to drop the column `id_descuento` on the `Reserva` table. All the data in the column will be lost.
  - The `estado` column on the `Reserva` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `genero` column on the `Usuario` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `Combustible` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[placa]` on the table `Carro` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id_usuario_rol,id_carro]` on the table `Favorito` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[rol]` on the table `Rol` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[google_id]` on the table `Usuario` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `anio` to the `Carro` table without a default value. This is not possible if the table is not empty.
  - Added the required column `transmision` to the `Carro` table without a default value. This is not possible if the table is not empty.
  - Added the required column `calle` to the `Direccion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_ciudad` to the `Provincia` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fecha_actualizacion` to the `Usuario` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "EstadoReserva" AS ENUM ('PENDIENTE', 'CONFIRMADA', 'EN_CURSO', 'COMPLETADA', 'CANCELADA');

-- CreateEnum
CREATE TYPE "EstadoCarro" AS ENUM ('DISPONIBLE', 'RESERVADO', 'MANTENIMIENTO');

-- DropForeignKey
ALTER TABLE "Busqueda" DROP CONSTRAINT "Busqueda_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Calificacion" DROP CONSTRAINT "Calificacion_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Calificacion" DROP CONSTRAINT "Calificacion_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "CarasteristicasAdicionales" DROP CONSTRAINT "CarasteristicasAdicionales_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Combustible" DROP CONSTRAINT "Combustible_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Direccion" DROP CONSTRAINT "Direccion_id_ciudad_fkey";

-- DropForeignKey
ALTER TABLE "Direccion" DROP CONSTRAINT "Direccion_id_pais_fkey";

-- DropForeignKey
ALTER TABLE "Favorito" DROP CONSTRAINT "Favorito_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Favorito" DROP CONSTRAINT "Favorito_id_usuario_rol_fkey";

-- DropForeignKey
ALTER TABLE "Imagen" DROP CONSTRAINT "Imagen_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Notificacion" DROP CONSTRAINT "Notificacion_id_usuario_rol_fkey";

-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_carro_fkey";

-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_descuento_fkey";

-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Usuario" DROP CONSTRAINT "Usuario_id_ciudad_fkey";

-- DropForeignKey
ALTER TABLE "UsuarioRol" DROP CONSTRAINT "UsuarioRol_id_usuario_fkey";

-- AlterTable
ALTER TABLE "Calificacion" ADD COLUMN     "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "calf_carro" DROP NOT NULL,
ALTER COLUMN "calf_usuario" DROP NOT NULL,
ALTER COLUMN "comentario" DROP DEFAULT;

-- AlterTable
ALTER TABLE "CarasteristicasAdicionales" DROP COLUMN "id_carro";

-- AlterTable
ALTER TABLE "Carro" DROP COLUMN "año",
DROP COLUMN "transmicion",
ADD COLUMN     "NumeroViajes" INTEGER DEFAULT 0,
ADD COLUMN     "anio" INTEGER NOT NULL,
ADD COLUMN     "color" TEXT,
ADD COLUMN     "descripcion" TEXT,
ADD COLUMN     "disponible_desde" TIMESTAMP(3),
ADD COLUMN     "disponible_hasta" TIMESTAMP(3),
ADD COLUMN     "fecha_ingreso" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "id_tipodeDescuento" INTEGER,
ADD COLUMN     "ingresoTotal" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "transmision" TEXT NOT NULL,
DROP COLUMN "estado",
ADD COLUMN     "estado" "EstadoCarro" NOT NULL DEFAULT 'DISPONIBLE';

-- AlterTable
ALTER TABLE "Ciudad" ADD COLUMN     "id_pais" INTEGER;

-- AlterTable
ALTER TABLE "Descuento" DROP COLUMN "fecha",
DROP COLUMN "porcentaje",
ADD COLUMN     "id_descuentoTipo" INTEGER,
ADD COLUMN     "montoDescontado" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Direccion" DROP COLUMN "direccion",
DROP COLUMN "id_ciudad",
DROP COLUMN "id_pais",
ADD COLUMN     "calle" TEXT NOT NULL,
ADD COLUMN     "latitud" DOUBLE PRECISION,
ADD COLUMN     "longitud" DOUBLE PRECISION,
ADD COLUMN     "zona" TEXT,
ALTER COLUMN "num_casa" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Garantia" ADD COLUMN     "descripcion" TEXT,
ADD COLUMN     "id_reserva" INTEGER,
ADD COLUMN     "pagoPorDanos" BOOLEAN;

-- AlterTable
ALTER TABLE "Imagen" DROP COLUMN "url",
ADD COLUMN     "data" TEXT,
ADD COLUMN     "format" TEXT,
ADD COLUMN     "height" INTEGER,
ADD COLUMN     "public_id" TEXT,
ADD COLUMN     "width" INTEGER;

-- AlterTable
ALTER TABLE "Notificacion" ADD COLUMN     "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "leida" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Provincia" ADD COLUMN     "id_ciudad" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Reserva" DROP COLUMN "id_descuento",
ADD COLUMN     "hora_fin" INTEGER,
ADD COLUMN     "hora_inicio" INTEGER,
ADD COLUMN     "kilometraje" INTEGER,
ADD COLUMN     "montoPagoInicial" DOUBLE PRECISION,
ADD COLUMN     "montoTotalConDescuento" DOUBLE PRECISION,
DROP COLUMN "estado",
ADD COLUMN     "estado" "EstadoReserva" NOT NULL DEFAULT 'PENDIENTE',
ALTER COLUMN "fecha_fin" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Usuario" ADD COLUMN     "fecha_actualizacion" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "ocupacion" TEXT,
ALTER COLUMN "fecha_nacimiento" DROP NOT NULL,
ALTER COLUMN "id_ciudad" DROP NOT NULL,
ALTER COLUMN "telefono" DROP NOT NULL,
DROP COLUMN "genero",
ADD COLUMN     "genero" "Genero";

-- DropTable
DROP TABLE "Combustible";

-- CreateTable
CREATE TABLE "PasswordRecoveryCode" (
    "id" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "correo" TEXT NOT NULL,
    "codigo" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "PasswordRecoveryCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SeguroCarro" (
    "id" SERIAL NOT NULL,
    "fechaInicio" TIMESTAMP(3) NOT NULL,
    "fechaFin" TIMESTAMP(3) NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_seguro" INTEGER NOT NULL,

    CONSTRAINT "SeguroCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Seguro" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "tipoSeguro" TEXT NOT NULL,
    "empresa" TEXT NOT NULL,

    CONSTRAINT "Seguro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CombustibleCarro" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_combustible" INTEGER NOT NULL,

    CONSTRAINT "CombustibleCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TipoCombustible" (
    "id" SERIAL NOT NULL,
    "tipoDeCombustible" TEXT NOT NULL,
    "id_carro" INTEGER NOT NULL,

    CONSTRAINT "TipoCombustible_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "caracteristicasAdicionalesCarro" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_carasteristicasAdicionales" INTEGER NOT NULL,

    CONSTRAINT "caracteristicasAdicionalesCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipodeDescuento" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "porcentaje" DOUBLE PRECISION NOT NULL,
    "fecha_inicio" TIMESTAMP(3),
    "fecha_fin" TIMESTAMP(3),

    CONSTRAINT "tipodeDescuento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contratodeAlquiler" (
    "id" SERIAL NOT NULL,
    "id_reserva" INTEGER NOT NULL,
    "kilometraje" INTEGER NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'pendiente',

    CONSTRAINT "contratodeAlquiler_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aeropuerto" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "latitud" DOUBLE PRECISION,
    "longitud" DOUBLE PRECISION,
    "id_ciudad" INTEGER NOT NULL,

    CONSTRAINT "aeropuerto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ubicacion" (
    "id" SERIAL NOT NULL,
    "id_direccion" INTEGER NOT NULL,
    "coordenadas" JSONB NOT NULL,
    "radio_cobertura" INTEGER NOT NULL DEFAULT 5000,

    CONSTRAINT "Ubicacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComentarioCarro" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "comentario" TEXT NOT NULL,
    "calificacion" INTEGER NOT NULL DEFAULT 0,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ComentarioCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reporte" (
    "id" SERIAL NOT NULL,
    "id_reportado" INTEGER NOT NULL,
    "id_reportador" INTEGER NOT NULL,
    "motivo" TEXT NOT NULL,
    "informacion_adicional" TEXT,
    "estado" TEXT NOT NULL DEFAULT 'PENDIENTE',
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Reporte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_DescuentoToReserva" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_DescuentoToReserva_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "PasswordRecoveryCode_id_usuario_idx" ON "PasswordRecoveryCode"("id_usuario");

-- CreateIndex
CREATE INDEX "PasswordRecoveryCode_codigo_idx" ON "PasswordRecoveryCode"("codigo");

-- CreateIndex
CREATE INDEX "SeguroCarro_id_carro_idx" ON "SeguroCarro"("id_carro");

-- CreateIndex
CREATE INDEX "SeguroCarro_id_seguro_idx" ON "SeguroCarro"("id_seguro");

-- CreateIndex
CREATE INDEX "CombustibleCarro_id_carro_idx" ON "CombustibleCarro"("id_carro");

-- CreateIndex
CREATE INDEX "CombustibleCarro_id_combustible_idx" ON "CombustibleCarro"("id_combustible");

-- CreateIndex
CREATE INDEX "caracteristicasAdicionalesCarro_id_carro_idx" ON "caracteristicasAdicionalesCarro"("id_carro");

-- CreateIndex
CREATE INDEX "caracteristicasAdicionalesCarro_id_carasteristicasAdicional_idx" ON "caracteristicasAdicionalesCarro"("id_carasteristicasAdicionales");

-- CreateIndex
CREATE INDEX "contratodeAlquiler_id_carro_idx" ON "contratodeAlquiler"("id_carro");

-- CreateIndex
CREATE INDEX "aeropuerto_id_ciudad_idx" ON "aeropuerto"("id_ciudad");

-- CreateIndex
CREATE INDEX "Ubicacion_id_direccion_idx" ON "Ubicacion"("id_direccion");

-- CreateIndex
CREATE INDEX "ComentarioCarro_id_carro_idx" ON "ComentarioCarro"("id_carro");

-- CreateIndex
CREATE INDEX "ComentarioCarro_id_usuario_idx" ON "ComentarioCarro"("id_usuario");

-- CreateIndex
CREATE INDEX "Reporte_id_reportado_idx" ON "Reporte"("id_reportado");

-- CreateIndex
CREATE INDEX "Reporte_id_reportador_idx" ON "Reporte"("id_reportador");

-- CreateIndex
CREATE INDEX "_DescuentoToReserva_B_index" ON "_DescuentoToReserva"("B");

-- CreateIndex
CREATE INDEX "Busqueda_id_usuario_idx" ON "Busqueda"("id_usuario");

-- CreateIndex
CREATE INDEX "Calificacion_id_carro_idx" ON "Calificacion"("id_carro");

-- CreateIndex
CREATE INDEX "Calificacion_id_usuario_idx" ON "Calificacion"("id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "Carro_placa_key" ON "Carro"("placa");

-- CreateIndex
CREATE INDEX "Carro_marca_modelo_idx" ON "Carro"("marca", "modelo");

-- CreateIndex
CREATE INDEX "Carro_id_direccion_idx" ON "Carro"("id_direccion");

-- CreateIndex
CREATE INDEX "Carro_id_usuario_rol_idx" ON "Carro"("id_usuario_rol");

-- CreateIndex
CREATE INDEX "Carro_id_tipodeDescuento_idx" ON "Carro"("id_tipodeDescuento");

-- CreateIndex
CREATE INDEX "Carro_estado_idx" ON "Carro"("estado");

-- CreateIndex
CREATE INDEX "Ciudad_id_pais_idx" ON "Ciudad"("id_pais");

-- CreateIndex
CREATE INDEX "Descuento_id_descuentoTipo_idx" ON "Descuento"("id_descuentoTipo");

-- CreateIndex
CREATE INDEX "Direccion_id_provincia_idx" ON "Direccion"("id_provincia");

-- CreateIndex
CREATE INDEX "Favorito_id_usuario_rol_idx" ON "Favorito"("id_usuario_rol");

-- CreateIndex
CREATE INDEX "Favorito_id_carro_idx" ON "Favorito"("id_carro");

-- CreateIndex
CREATE INDEX "Favorito_id_usuario_idx" ON "Favorito"("id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "Favorito_id_usuario_rol_id_carro_key" ON "Favorito"("id_usuario_rol", "id_carro");

-- CreateIndex
CREATE INDEX "Garantia_id_reserva_idx" ON "Garantia"("id_reserva");

-- CreateIndex
CREATE INDEX "Imagen_id_carro_idx" ON "Imagen"("id_carro");

-- CreateIndex
CREATE INDEX "Notificacion_id_usuario_rol_idx" ON "Notificacion"("id_usuario_rol");

-- CreateIndex
CREATE INDEX "Provincia_id_ciudad_idx" ON "Provincia"("id_ciudad");

-- CreateIndex
CREATE INDEX "Reserva_id_carro_idx" ON "Reserva"("id_carro");

-- CreateIndex
CREATE INDEX "Reserva_id_usuario_idx" ON "Reserva"("id_usuario");

-- CreateIndex
CREATE INDEX "Reserva_fecha_inicio_fecha_fin_idx" ON "Reserva"("fecha_inicio", "fecha_fin");

-- CreateIndex
CREATE INDEX "Reserva_estado_idx" ON "Reserva"("estado");

-- CreateIndex
CREATE UNIQUE INDEX "Rol_rol_key" ON "Rol"("rol");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_google_id_key" ON "Usuario"("google_id");

-- CreateIndex
CREATE INDEX "Usuario_correo_idx" ON "Usuario"("correo");

-- CreateIndex
CREATE INDEX "Usuario_google_id_idx" ON "Usuario"("google_id");

-- CreateIndex
CREATE INDEX "Usuario_id_ciudad_idx" ON "Usuario"("id_ciudad");

-- CreateIndex
CREATE INDEX "UsuarioRol_id_usuario_idx" ON "UsuarioRol"("id_usuario");

-- CreateIndex
CREATE INDEX "UsuarioRol_id_rol_idx" ON "UsuarioRol"("id_rol");

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsuarioRol" ADD CONSTRAINT "UsuarioRol_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PasswordRecoveryCode" ADD CONSTRAINT "PasswordRecoveryCode_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "UsuarioRol"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notificacion" ADD CONSTRAINT "Notificacion_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carro" ADD CONSTRAINT "Carro_id_tipodeDescuento_fkey" FOREIGN KEY ("id_tipodeDescuento") REFERENCES "tipodeDescuento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeguroCarro" ADD CONSTRAINT "SeguroCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeguroCarro" ADD CONSTRAINT "SeguroCarro_id_seguro_fkey" FOREIGN KEY ("id_seguro") REFERENCES "Seguro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CombustibleCarro" ADD CONSTRAINT "CombustibleCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CombustibleCarro" ADD CONSTRAINT "CombustibleCarro_id_combustible_fkey" FOREIGN KEY ("id_combustible") REFERENCES "TipoCombustible"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" ADD CONSTRAINT "caracteristicasAdicionalesCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" ADD CONSTRAINT "caracteristicasAdicionalesCarro_id_carasteristicasAdiciona_fkey" FOREIGN KEY ("id_carasteristicasAdicionales") REFERENCES "CarasteristicasAdicionales"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Imagen" ADD CONSTRAINT "Imagen_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Descuento" ADD CONSTRAINT "Descuento_id_descuentoTipo_fkey" FOREIGN KEY ("id_descuentoTipo") REFERENCES "tipodeDescuento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Garantia" ADD CONSTRAINT "Garantia_id_reserva_fkey" FOREIGN KEY ("id_reserva") REFERENCES "Reserva"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contratodeAlquiler" ADD CONSTRAINT "contratodeAlquiler_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ciudad" ADD CONSTRAINT "Ciudad_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "Pais"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aeropuerto" ADD CONSTRAINT "aeropuerto_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ubicacion" ADD CONSTRAINT "Ubicacion_id_direccion_fkey" FOREIGN KEY ("id_direccion") REFERENCES "Direccion"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Provincia" ADD CONSTRAINT "Provincia_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Busqueda" ADD CONSTRAINT "Busqueda_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComentarioCarro" ADD CONSTRAINT "ComentarioCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComentarioCarro" ADD CONSTRAINT "ComentarioCarro_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reporte" ADD CONSTRAINT "Reporte_id_reportado_fkey" FOREIGN KEY ("id_reportado") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reporte" ADD CONSTRAINT "Reporte_id_reportador_fkey" FOREIGN KEY ("id_reportador") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DescuentoToReserva" ADD CONSTRAINT "_DescuentoToReserva_A_fkey" FOREIGN KEY ("A") REFERENCES "Descuento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DescuentoToReserva" ADD CONSTRAINT "_DescuentoToReserva_B_fkey" FOREIGN KEY ("B") REFERENCES "Reserva"("id") ON DELETE CASCADE ON UPDATE CASCADE;
