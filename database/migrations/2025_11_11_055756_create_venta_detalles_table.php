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
        Schema::create('venta_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('venta_id')->comment('ID de la venta');
            $table->unsignedBigInteger('articulo_id')->comment('Artículo vendido');
            $table->integer('cantidad')->comment('Cantidad vendida');
            $table->decimal('precio_unitario', 10, 2)->comment('Precio unitario al momento de la venta');
            $table->decimal('subtotal', 10, 2)->comment('Subtotal (cantidad * precio_unitario)');
            $table->decimal('descuento', 10, 2)->default(0.00)->comment('Descuento aplicado al artículo');
            $table->timestamps();

            $table->foreign('venta_id')->references('id')->on('ventas')->onDelete('cascade')->onUpdate('cascade');
            $table->foreign('articulo_id')->references('id')->on('articulos')->onDelete('restrict')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('venta_detalles');
    }
};
