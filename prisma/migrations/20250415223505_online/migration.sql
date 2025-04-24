-- CreateTable
CREATE TABLE "CalificacionHostUsuario" (
    "id" SERIAL NOT NULL,
    "comportamiento" INTEGER NOT NULL,
    "cuidadovehiculo" INTEGER NOT NULL,
    "puntualidad" INTEGER NOT NULL,
    "comentario" TEXT,
    "id_reserva" INTEGER NOT NULL,
    "id_calificador" INTEGER NOT NULL,
    "id_calificado" INTEGER NOT NULL,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CalificacionHostUsuario_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CalificacionHostUsuario" ADD CONSTRAINT "CalificacionHostUsuario_id_reserva_fkey" FOREIGN KEY ("id_reserva") REFERENCES "Reserva"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalificacionHostUsuario" ADD CONSTRAINT "CalificacionHostUsuario_id_calificador_fkey" FOREIGN KEY ("id_calificador") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalificacionHostUsuario" ADD CONSTRAINT "CalificacionHostUsuario_id_calificado_fkey" FOREIGN KEY ("id_calificado") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
