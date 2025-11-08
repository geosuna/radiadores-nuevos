<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SucursalSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        echo "Creando sucursales...\n";

        DB::table('sucursal')->insert([
            [
                'id' => 1,
                'nombre' => 'Sucursal 1',
                'direccion' => 'Blvd. Sucursales 802, P-69',
                'ciudad' => 'Tijuana',
                'estado' => 'Baja California',
                'codigo_postal' => '22000',
                'telefono' => '(664) 123-4567',
                'estatus' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'nombre' => 'Sucursal 2',
                'direccion' => 'Blvd. Lázaro Cárdenas 3039, Mirasol',
                'ciudad' => 'Mexicali',
                'estado' => 'Baja California',
                'codigo_postal' => '21396',
                'telefono' => '(686) 987-6543',
                'estatus' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        echo "✓ Sucursales creadas correctamente.\n";
    }
}
