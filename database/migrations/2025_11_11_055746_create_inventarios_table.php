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
            $table->unsignedBigInteger('sucursal_id');
            $table->unsignedBigInteger('articulo_id');
            $table->integer('cantidad')->default(0);
            $table->integer('stock_minimo')->default(1);
            $table->string('ubicacion', 100)->nullable();
            $table->unsignedBigInteger('updated_by_user_id')->nullable();
            $table->timestamps();

            $table->unique(['sucursal_id', 'articulo_id'], 'sucursal_articulo_unique');

            $table->foreign('sucursal_id')->references('id')->on('sucursales')->onUpdate('cascade');
            $table->foreign('articulo_id')->references('id')->on('articulos')->onUpdate('cascade');
            $table->foreign('updated_by_user_id')->references('id')->on('users')->onDelete('set null')->onUpdate('cascade');
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
