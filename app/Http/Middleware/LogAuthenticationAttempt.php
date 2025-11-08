<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class LogAuthenticationAttempt
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Solo logear intentos de login POST
        if ($request->is('login') && $request->isMethod('post')) {
            Log::info('Intento de login', [
                'usuario' => $request->input('usuario'),
                'ip' => $request->ip(),
                'user_agent' => $request->userAgent(),
                'timestamp' => now()->toDateTimeString(),
            ]);
        }

        $response = $next($request);

        // Logear resultado del login
        if ($request->is('login') && $request->isMethod('post')) {
            if (auth()->check()) {
                Log::info('Login exitoso', [
                    'usuario' => $request->input('usuario'),
                    'user_id' => auth()->id(),
                    'ip' => $request->ip(),
                ]);
            } else {
                Log::warning('Login fallido', [
                    'usuario' => $request->input('usuario'),
                    'ip' => $request->ip(),
                ]);
            }
        }

        return $response;
    }
}
