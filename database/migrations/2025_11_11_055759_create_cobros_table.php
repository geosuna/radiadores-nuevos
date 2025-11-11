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
        Schema::create('cobros', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('venta_id')->comment('ID de la venta');
            $table->dateTime('fecha_cobro')->comment('Fecha y hora del cobro');
            $table->enum('forma_pago', ['efectivo', 'tarjeta', 'transferencia', 'cheque'])->default('efectivo')->comment('Forma de pago utilizada');
            $table->decimal('monto', 10, 2)->comment('Monto cobrado');
            $table->string('referencia', 100)->nullable()->comment('Referencia del pago (núm. tarjeta, cheque, etc.)');
            $table->timestamps();

            $table->foreign('venta_id')->references('id')->on('ventas')->onDelete('cascade')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cobros');
    }
};
