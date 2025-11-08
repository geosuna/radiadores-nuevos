<?php

namespace App\Http\Controllers\Settings;

use App\Http\Controllers\Controller;
use App\Models\Sucursal;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;
use Inertia\Inertia;

class UserRegistrationController extends Controller
{
    /**
     * Mostrar el formulario de registro de usuarios
     */
    public function create()
    {
        // Verificar que el usuario tenga rol de administrador o supervisor
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para registrar usuarios.');
        }

        $sucursales = Sucursal::activas()->get();

        return Inertia::render('settings/UserRegistration', [
            'sucursales' => $sucursales,
        ]);
    }

    /**
     * Registrar un nuevo usuario
     */
    public function store(Request $request)
    {
        // Verificar que el usuario tenga rol de administrador o supervisor
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para registrar usuarios.');
        }

        $validated = $request->validate([
            'sucursal_id' => 'required|exists:sucursal,id',
            'usuario' => 'required|string|max:255|unique:users,usuario',
            'nombre' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email',
            'password' => ['required', 'confirmed', Password::defaults()],
            'rol' => 'required|in:administrador,supervisor,capturista,vendedor',
            'acceso_todas_sucursales' => 'boolean',
        ]);

        // Crear el usuario
        $user = User::create([
            'sucursal_id' => $validated['sucursal_id'],
            'usuario' => $validated['usuario'],
            'nombre' => $validated['nombre'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'rol' => $validated['rol'],
            'acceso_todas_sucursales' => $request->boolean('acceso_todas_sucursales'),
            'creado_usuario_id' => auth()->id(),
            'estatus' => 1,
        ]);

        // Registrar las sucursales de acceso
        if ($request->boolean('acceso_todas_sucursales')) {
            // Si tiene acceso a todas las sucursales, registrar todas
            $todasSucursales = Sucursal::activas()->pluck('id')->toArray();
            $accesoData = [];
            
            foreach ($todasSucursales as $sucursalId) {
                $accesoData[$sucursalId] = [
                    'usuario_modificacion_id' => auth()->id(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
            
            $user->sucursalesAccesibles()->attach($accesoData);
        } else {
            // Si no, solo registrar la sucursal principal
            $user->sucursalesAccesibles()->attach($validated['sucursal_id'], [
                'usuario_modificacion_id' => auth()->id(),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        return redirect()->route('settings.users.create')->with('success', 'Usuario creado exitosamente.');
    }
}
