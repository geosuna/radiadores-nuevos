<?php

use App\Http\Controllers\Settings\PasswordController;
use App\Http\Controllers\Settings\ProfileController;
use App\Http\Controllers\Settings\TwoFactorAuthenticationController;
use App\Http\Controllers\Settings\UserManagementController;
use App\Http\Controllers\Settings\UserRegistrationController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware('auth')->group(function () {
    Route::redirect('settings', '/settings/profile');

    Route::get('settings/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('settings/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('settings/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('settings/password', [PasswordController::class, 'edit'])->name('user-password.edit');

    Route::put('settings/password', [PasswordController::class, 'update'])
        ->middleware('throttle:6,1')
        ->name('user-password.update');

    Route::get('settings/appearance', function () {
        return Inertia::render('settings/Appearance');
    })->name('appearance.edit');

    Route::get('settings/two-factor', [TwoFactorAuthenticationController::class, 'show'])
        ->name('two-factor.show');

    // Registro de usuarios - Solo administradores y supervisores
    Route::get('settings/users/create', [UserRegistrationController::class, 'create'])
        ->name('settings.users.create');
    Route::post('settings/users', [UserRegistrationController::class, 'store'])
        ->name('settings.users.store');

    // Gestión de usuarios - Solo administradores y supervisores
    Route::get('settings/users', [UserManagementController::class, 'index'])
        ->name('settings.users.index');
    Route::patch('settings/users/{user}/password', [UserManagementController::class, 'changePassword'])
        ->name('settings.users.change-password');
    Route::patch('settings/users/{user}/deactivate', [UserManagementController::class, 'deactivate'])
        ->name('settings.users.deactivate');
    Route::patch('settings/users/{user}/activate', [UserManagementController::class, 'activate'])
        ->name('settings.users.activate');
    Route::delete('settings/users/{user}', [UserManagementController::class, 'destroy'])
        ->name('settings.users.destroy');
});
