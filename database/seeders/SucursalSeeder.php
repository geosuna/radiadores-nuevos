<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Sucursal;

class SucursalSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->command->info('Creando sucursales...');
        $sucursales = [
            [
                'id' => 1,
                'nombre' => 'Pinos',
                'direccion' => 'boulevard madero 16',
                'estatus' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'nombre' => 'Centro',
                'direccion' => 'boulevard central',
                'estatus' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'nombre' => 'Mexicali',
                'direccion' => 'boulevard aguacaliente',
                'estatus' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ];

        Sucursal::insert($sucursales);
    }
}
