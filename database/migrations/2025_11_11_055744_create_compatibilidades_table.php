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
        Schema::create('compatibilidades', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('articulo_id')->comment('ID del artículo');
            $table->unsignedBigInteger('auto_id')->comment('ID del auto compatible');
            $table->enum('tipo_compatibilidad', ['original', 'compatible', 'universal'])->default('compatible')->comment('Tipo de compatibilidad');
            $table->string('observaciones', 200)->nullable()->comment('Notas adicionales sobre la compatibilidad');
            $table->unsignedBigInteger('modificado_usuario_id')->comment('Usuario que registró/modificó');
            $table->boolean('estatus')->default(1)->comment('1=Activo, 0=Inactivo');
            $table->timestamps();

            $table->unique(['articulo_id', 'auto_id'], 'compatibilidad_articulo_auto_unique');

            $table->foreign('articulo_id')->references('id')->on('articulos')->onDelete('cascade')->onUpdate('cascade');
            $table->foreign('auto_id')->references('id')->on('autos')->onDelete('cascade')->onUpdate('cascade');
            $table->foreign('modificado_usuario_id')->references('id')->on('users')->onDelete('restrict')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('compatibilidades');
    }
};
