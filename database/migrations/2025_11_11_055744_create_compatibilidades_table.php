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
            $table->unsignedBigInteger('articulo_id');
            $table->unsignedBigInteger('auto_id');
            $table->enum('tipo_compatibilidad', ['original', 'compatible', 'universal'])->default('compatible');
            $table->string('observaciones', 200)->nullable();
            $table->unsignedBigInteger('updated_by_user_id');
            $table->boolean('estatus')->default(1);
            $table->timestamps();

            $table->unique(['articulo_id', 'auto_id'], 'articulo_auto_unique');

            $table->foreign('articulo_id')->references('id')->on('articulos')->onDelete('cascade')->onUpdate('cascade');
            $table->foreign('auto_id')->references('id')->on('autos')->onDelete('cascade')->onUpdate('cascade');
            $table->foreign('updated_by_user_id')->references('id')->on('users')->onUpdate('cascade');
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
