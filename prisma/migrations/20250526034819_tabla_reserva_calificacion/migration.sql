/*
  Warnings:

  - You are about to drop the `CalificacionHostUsuario` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "CalificacionHostUsuario" DROP CONSTRAINT "CalificacionHostUsuario_id_calificado_fkey";

-- DropForeignKey
ALTER TABLE "CalificacionHostUsuario" DROP CONSTRAINT "CalificacionHostUsuario_id_calificador_fkey";

-- DropForeignKey
ALTER TABLE "CalificacionHostUsuario" DROP CONSTRAINT "CalificacionHostUsuario_id_reserva_fkey";

-- DropTable
DROP TABLE "CalificacionHostUsuario";

-- CreateTable
CREATE TABLE "CalificacionReserva" (
    "id" SERIAL NOT NULL,
    "id_reserva" INTEGER NOT NULL,
    "comportamiento" INTEGER NOT NULL,
    "cuidado_vehiculo" INTEGER NOT NULL,
    "puntualidad" INTEGER NOT NULL,
    "comentario" TEXT,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CalificacionReserva_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "CalificacionReserva_id_reserva_idx" ON "CalificacionReserva"("id_reserva");

-- AddForeignKey
ALTER TABLE "CalificacionReserva" ADD CONSTRAINT "CalificacionReserva_id_reserva_fkey" FOREIGN KEY ("id_reserva") REFERENCES "Reserva"("id") ON DELETE CASCADE ON UPDATE CASCADE;
