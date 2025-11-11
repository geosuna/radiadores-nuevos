<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Sucursal;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class LoginController extends Controller
{
    /**
     * Mostrar la pantalla de login con las sucursales disponibles
     */
    public function create(Request $request): Response
    {
        // Obtener todas las sucursales activas ordenadas por nombre
        $sucursales = Sucursal::where('estatus', true)
            ->orderBy('nombre')
            ->get(['id', 'nombre']);

        return Inertia::render('auth/Login', [
            'canResetPassword' => true,
            'status' => session('status'),
            'sucursales' => $sucursales,
        ]);
    }
}
