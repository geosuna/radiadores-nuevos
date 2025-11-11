<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Validation\ValidationException;
use Laravel\Fortify\Fortify;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class CustomAuthServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        // Configurar Fortify para autenticar con 'usuario' en lugar de 'email'
        Fortify::authenticateUsing(function (Request $request) {
            // Validar que el campo usuario y sucursal estén presentes
            $request->validate([
                'usuario' => 'required|string',
                'password' => 'required|string',
                'sucursal_id' => 'required|exists:sucursal,id',
            ]);

            // Buscar usuario por campo 'usuario' (sin filtrar por estatus)
            $user = User::where('usuario', $request->usuario)->first();

            // Si el usuario no existe
            if (!$user) {
                throw ValidationException::withMessages([
                    'usuario' => ['El usuario no existe.'],
                ]);
            }

            // Si el usuario está inactivo
            if (!$user->estatus) {
                throw ValidationException::withMessages([
                    'usuario' => ['Este usuario está inactivo. Contacta al supervisor / administrador.'],
                ]);
            }

            // Verificar la contraseña
            if (!Hash::check($request->password, $user->password)) {
                throw ValidationException::withMessages([
                    'password' => ['La contraseña es incorrecta.'],
                ]);
            }

            // Verificar que el usuario tenga acceso a la sucursal seleccionada
            $tieneAcceso = $user->acceso_todas_sucursales ||
                           $user->sucursal_id == $request->sucursal_id ||
                           $user->sucursalesAccesibles()->where('sucursal_id', $request->sucursal_id)->exists();

            if (!$tieneAcceso) {
                throw ValidationException::withMessages([
                    'sucursal_id' => ['No tienes acceso a esta sucursal.'],
                ]);
            }

            // Guardar la sucursal seleccionada en la sesión
            session([
                'sucursal_actual' => (int) $request->sucursal_id,
                'last_activity_time' => time(),
            ]);

            // Si todo está bien, retornar el usuario
            return $user;
        });
    }
}
