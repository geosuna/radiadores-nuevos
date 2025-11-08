<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use App\Models\Sucursal;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class LoginTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        // Crear una sucursal de prueba
        Sucursal::create([
            'nombre' => 'Sucursal Test',
            'direccion' => 'Dirección Test',
            'ciudad' => 'Ciudad Test',
            'estado' => 'Estado Test',
            'codigo_postal' => '12345',
            'telefono' => '1234567890',
            'estatus' => 1,
        ]);
    }

    public function test_login_screen_can_be_rendered(): void
    {
        $response = $this->get('/login');

        $response->assertStatus(200);
    }

    public function test_users_can_authenticate_using_the_login_screen(): void
    {
        $user = User::factory()->create([
            'usuario' => 'testuser',
            'password' => bcrypt('password123'),
            'estatus' => 1,
        ]);

        $response = $this->post('/login', [
            'usuario' => 'testuser',
            'password' => 'password123',
        ]);

        $this->assertAuthenticated();
        $response->assertRedirect('/dashboard');
    }

    public function test_users_can_not_authenticate_with_invalid_password(): void
    {
        $user = User::factory()->create([
            'usuario' => 'testuser',
            'password' => bcrypt('password123'),
            'estatus' => 1,
        ]);

        $this->post('/login', [
            'usuario' => 'testuser',
            'password' => 'wrong-password',
        ]);

        $this->assertGuest();
    }

    public function test_inactive_users_cannot_authenticate(): void
    {
        $user = User::factory()->create([
            'usuario' => 'testuser',
            'password' => bcrypt('password123'),
            'estatus' => 0, // Usuario inactivo
        ]);

        $this->post('/login', [
            'usuario' => 'testuser',
            'password' => 'password123',
        ]);

        $this->assertGuest();
    }

    public function test_login_requires_usuario_field(): void
    {
        $response = $this->post('/login', [
            'password' => 'password123',
        ]);

        $response->assertSessionHasErrors(['usuario']);
    }

    public function test_login_requires_password_field(): void
    {
        $response = $this->post('/login', [
            'usuario' => 'testuser',
        ]);

        $response->assertSessionHasErrors(['password']);
    }
}
