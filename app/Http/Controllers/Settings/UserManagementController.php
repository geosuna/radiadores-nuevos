<?php

namespace App\Http\Controllers\Settings;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;
use Inertia\Inertia;

class UserManagementController extends Controller
{
    /**
     * Mostrar la lista de usuarios
     */
    public function index(Request $request)
    {
        // Verificar que el usuario tenga rol de administrador o supervisor
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para gestionar usuarios.');
        }

        $search = $request->input('search', '');

        $users = User::with([
                'sucursal',
                'sucursales',
                'creadoUsuario:id,usuario,nombre',
                'modificadoUsuario:id,usuario,nombre'
            ])
            ->when($search, function ($query, $search) {
                $query->where(function ($q) use ($search) {
                    $q->where('usuario', 'like', "%{$search}%")
                        ->orWhere('nombre', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('rol', 'like', "%{$search}%");
                });
            })
            ->orderBy('nombre')
            ->paginate(15)
            ->withQueryString();

        return Inertia::render('settings/UserList', [
            'users' => $users,
            'search' => $search,
            'canDelete' => auth()->user()->esAdministrador(),
        ]);
    }

    /**
     * Cambiar la contraseña de un usuario
     */
    public function changePassword(Request $request, User $user)
    {
        // Solo administradores y supervisores pueden cambiar contraseñas
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para cambiar contraseñas.');
        }

        // Los supervisores no pueden modificar administradores
        if (auth()->user()->esSupervisor() && $user->esAdministrador()) {
            abort(403, 'Los supervisores no pueden modificar administradores.');
        }

        // Verificar la contraseña del usuario actual
        if (!Hash::check($request->current_password, auth()->user()->password)) {
            return back()->withErrors([
                'current_password' => 'La contraseña actual es incorrecta.',
            ]);
        }

        $validated = $request->validate([
            'current_password' => 'required',
            'password' => ['required', 'confirmed', Password::defaults()],
        ]);

        $user->update([
            'password' => Hash::make($validated['password']),
            'modificado_usuario_id' => auth()->id(),
        ]);

        return back()->with('success', 'Contraseña actualizada exitosamente.');
    }

    /**
     * Desactivar (dar de baja) un usuario
     */
    public function deactivate(Request $request, User $user)
    {
        // Solo administradores y supervisores pueden desactivar usuarios
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para desactivar usuarios.');
        }

        // Los supervisores no pueden modificar administradores
        if (auth()->user()->esSupervisor() && $user->esAdministrador()) {
            abort(403, 'Los supervisores no pueden modificar administradores.');
        }

        // No permitir desactivarse a sí mismo
        if ($user->id === auth()->id()) {
            return back()->withErrors([
                'error' => 'No puedes desactivar tu propia cuenta.',
            ]);
        }

        // Verificar la contraseña del usuario actual
        if (!Hash::check($request->password, auth()->user()->password)) {
            return back()->withErrors([
                'password' => 'La contraseña es incorrecta.',
            ]);
        }

        $user->update([
            'estatus' => 0,
            'modificado_usuario_id' => auth()->id(),
        ]);

        return back()->with('success', 'Usuario desactivado exitosamente.');
    }

    /**
     * Activar un usuario
     */
    public function activate(Request $request, User $user)
    {
        // Solo administradores y supervisores pueden activar usuarios
        if (!auth()->user()->esAdministrador() && !auth()->user()->esSupervisor()) {
            abort(403, 'No tienes permisos para activar usuarios.');
        }

        // Los supervisores no pueden modificar administradores
        if (auth()->user()->esSupervisor() && $user->esAdministrador()) {
            abort(403, 'Los supervisores no pueden modificar administradores.');
        }

        // Verificar la contraseña del usuario actual
        if (!Hash::check($request->password, auth()->user()->password)) {
            return back()->withErrors([
                'password' => 'La contraseña es incorrecta.',
            ]);
        }

        $user->update([
            'estatus' => 1,
            'modificado_usuario_id' => auth()->id(),
        ]);

        return back()->with('success', 'Usuario activado exitosamente.');
    }

    /**
     * Eliminar permanentemente un usuario
     */
    public function destroy(Request $request, User $user)
    {
        // Solo administradores pueden eliminar usuarios
        if (!auth()->user()->esAdministrador()) {
            abort(403, 'Solo los administradores pueden eliminar usuarios.');
        }

        // No permitir eliminarse a sí mismo
        if ($user->id === auth()->id()) {
            return back()->withErrors([
                'error' => 'No puedes eliminar tu propia cuenta.',
            ]);
        }

        // Verificar la contraseña del usuario actual
        if (!Hash::check($request->password, auth()->user()->password)) {
            return back()->withErrors([
                'password' => 'La contraseña es incorrecta.',
            ]);
        }

        $user->delete();

        return back()->with('success', 'Usuario eliminado exitosamente.');
    }
}
