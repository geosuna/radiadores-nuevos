<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        echo "\n🌱 Iniciando seeders...\n\n";

        // 1. Crear sucursales primero
        $this->call([
            SucursalSeeder::class,
        ]);

        echo "\n👤 Creando usuario administrador...\n";

        // 2. Crear usuario admin
        $admin = User::create([
            'sucursal_id' => 1, // Almacen Pinos
            'usuario' => 'admin',
            'nombre' => 'Administrador del Sistema',
            'email' => 'admin@test.com',
            'password' => Hash::make('password'),
            'rol' => 'administrador',
            'acceso_todas_sucursales' => true,
            'estatus' => 1,
            'email_verified_at' => now(),
        ]);

        echo "✓ Usuario admin creado correctamente.\n";
        echo "  Usuario: admin\n";
        echo "  Contraseña: password\n";
        echo "  Email: admin@test.com\n\n";

        // 3. Registrar accesos a ambas sucursales en usuario_sucursal_acceso
        echo "🔗 Asignando accesos a sucursales...\n";

        DB::table('usuario_sucursal_acceso')->insert([
            [
                'user_id' => $admin->id,
                'sucursal_id' => 1, // Almacen Pinos
                'usuario_modificacion_id' => $admin->id,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'user_id' => $admin->id,
                'sucursal_id' => 2, // Mexicali
                'usuario_modificacion_id' => $admin->id,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        echo "✓ Accesos a sucursales asignados correctamente.\n";
        echo "  - Almacen Pinos\n";
        echo "  - Mexicali\n\n";

        echo "✅ Seeders completados exitosamente!\n\n";
    }
}
