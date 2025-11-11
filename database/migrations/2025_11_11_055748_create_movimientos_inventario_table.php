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
        Schema::create('movimientos_inventario', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('sucursal_id')->comment('Sucursal del movimiento');
            $table->unsignedBigInteger('articulo_id')->comment('Artículo movido');
            $table->enum('tipo_movimiento', ['entrada', 'salida', 'ajuste', 'venta', 'devolucion'])->comment('Tipo de movimiento');
            $table->integer('cantidad')->comment('Cantidad del movimiento');
            $table->integer('cantidad_anterior')->comment('Cantidad antes del movimiento');
            $table->integer('cantidad_nueva')->comment('Cantidad después del movimiento');
            $table->unsignedBigInteger('usuario_movimiento_id')->comment('Usuario que realizó el movimiento');
            $table->string('referencia', 100)->nullable()->comment('Referencia externa (factura, orden, etc.)');
            $table->text('observaciones')->nullable()->comment('Notas adicionales del movimiento');
            $table->timestamps();

            $table->foreign('sucursal_id')->references('id')->on('sucursales')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('articulo_id')->references('id')->on('articulos')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('usuario_movimiento_id')->references('id')->on('users')->onDelete('restrict')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movimientos_inventario');
    }
};
