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
        Schema::create('usuario_sucursal_acceso', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('sucursal_id');
            $table->unsignedBigInteger('usuario_modificacion_id');
            $table->timestamps();

            // Índices
            $table->unique(['user_id', 'sucursal_id']);
            $table->index('user_id');
            $table->index('sucursal_id');

            // Claves foráneas
            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->onDelete('cascade');

            $table->foreign('sucursal_id')
                ->references('id')
                ->on('sucursal')
                ->onDelete('cascade');

            $table->foreign('usuario_modificacion_id')
                ->references('id')
                ->on('users')
                ->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('usuario_sucursal_acceso');
    }
};
