-- CreateTable
CREATE TABLE "Papitas" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "cantidad" INTEGER NOT NULL,

    CONSTRAINT "Papitas_pkey" PRIMARY KEY ("id")
);
