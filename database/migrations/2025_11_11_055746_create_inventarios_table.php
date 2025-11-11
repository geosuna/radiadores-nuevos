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
        Schema::create('inventarios', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('sucursal_id')->comment('Sucursal donde está el stock');
            $table->unsignedBigInteger('articulo_id')->comment('Artículo en inventario');
            $table->integer('cantidad')->default(0)->comment('Cantidad actual en stock');
            $table->integer('stock_minimo')->default(1)->comment('Stock mínimo de alerta');
            $table->string('ubicacion', 100)->nullable()->comment('Ubicación física en almacén');
            $table->unsignedBigInteger('usuario_modificacion_id')->nullable()->comment('Usuario última modificación');
            $table->timestamps();

            $table->unique(['sucursal_id', 'articulo_id'], 'inventario_sucursal_articulo_unique');

            $table->foreign('sucursal_id')->references('id')->on('sucursales')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('articulo_id')->references('id')->on('articulos')->onDelete('restrict')->onUpdate('cascade');
            $table->foreign('usuario_modificacion_id')->references('id')->on('users')->onDelete('set null')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inventarios');
    }
};
