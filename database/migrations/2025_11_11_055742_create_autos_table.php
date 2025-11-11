<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('autos', function (Blueprint $table) {
            $table->id();
            $table->string('marca', 50)->comment('Marca del vehículo (Toyota, Honda, etc.)');
            $table->string('modelo', 50)->nullable()->comment('Modelo del vehículo (Corolla, Civic, etc.)');
            $table->string('anios_rango', 20)->comment('Rango de años (ej: "98-99", "2017-2022")');
            $table->string('motor', 30)->nullable()->comment('Especificación del motor (ej: "1.8L", "3.0L VTEC")');
            $table->string('descripcion', 200)->nullable()->comment('Descripción adicional del vehículo');
            $table->unsignedBigInteger('creado_usuario_id')->comment('Usuario que lo creó');
            $table->unsignedBigInteger('modificado_usuario_id')->nullable()->comment('Último usuario que lo modificó');
            $table->boolean('estatus')->default(1)->comment('1=Activo, 0=Inactivo');
            $table->timestamps();

            $table->foreign('creado_usuario_id')->references('id')->on('users')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('modificado_usuario_id')->references('id')->on('users')->onDelete('set null')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('autos');
    }
};
