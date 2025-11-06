<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            SucursalSeeder::class,
        ]);

        User::factory()->create([
            'usuario' => 'admin',
            'nombre' => 'Test User',
            'email' => 'test@example.com',
        ]);
    }
}
