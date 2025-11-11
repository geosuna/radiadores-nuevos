<?php

use App\Http\Controllers\Auth\LoginController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome');
})->name('home');

Route::get('dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Ruta personalizada de login con sucursales
Route::get('/login', [LoginController::class, 'create'])->name('login');

// Rutas de registro deshabilitadas (el registro se hace desde configuración)
Route::get('/register', function () {
    return redirect('/login');
})->name('register');

Route::post('/register', function () {
    abort(404);
})->name('register.store');

require __DIR__.'/settings.php';
