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
        Schema::create('ventas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('sucursal_id')->comment('Sucursal donde se realizó la venta');
            $table->unsignedBigInteger('user_id')->comment('Usuario vendedor');
            $table->dateTime('fecha_venta')->comment('Fecha y hora de la venta');
            $table->string('cliente', 100)->nullable()->comment('Nombre del cliente');
            $table->decimal('subtotal', 10, 2)->default(0.00)->comment('Subtotal sin impuestos ni descuentos');
            $table->decimal('descuento', 10, 2)->default(0.00)->comment('Descuento aplicado');
            $table->decimal('impuestos', 10, 2)->default(0.00)->comment('Impuestos (IVA, etc.)');
            $table->decimal('total', 10, 2)->default(0.00)->comment('Total final de la venta');
            $table->boolean('estatus')->default(1)->comment('1=Completada, 0=Cancelada');
            $table->text('observaciones')->nullable()->comment('Notas adicionales de la venta');
            $table->timestamps();

            $table->foreign('sucursal_id')->references('id')->on('sucursales')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('restrict')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ventas');
    }
};
