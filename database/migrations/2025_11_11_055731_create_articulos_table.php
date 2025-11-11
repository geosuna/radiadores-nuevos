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
        Schema::create('articulos', function (Blueprint $table) {
            $table->id();
            $table->string('dpi', 20)->unique()->comment('Código DPI único del artículo');
            $table->string('descripcion', 200)->nullable()->comment('Descripción del producto');
            $table->decimal('precio_venta', 10, 2)->default(0.00)->comment('Precio de venta al público');
            $table->enum('categoria', ['Radiador', 'Termostato', 'Ventilador', 'Manguera', 'Bomba', 'Otro'])->default('Radiador')->comment('Categoría del producto');
            $table->unsignedBigInteger('auto_principal_id')->comment('Auto principal para el cual fue diseñado');
            $table->string('foto_url', 255)->nullable()->comment('URL de la foto: /storage/productos/{id}.jpg');
            $table->unsignedBigInteger('creado_usuario_id')->comment('Usuario que lo creó');
            $table->unsignedBigInteger('modificado_usuario_id')->nullable()->comment('Último usuario que lo modificó');
            $table->boolean('estatus')->default(1)->comment('1=Activo, 0=Inactivo');
            $table->timestamps();

            $table->foreign('auto_principal_id')->references('id')->on('autos')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('creado_usuario_id')->references('id')->on('users')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('modificado_usuario_id')->references('id')->on('users')->onDelete('set null')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('articulos');
    }
};
