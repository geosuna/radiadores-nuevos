<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Fortify\TwoFactorAuthenticatable;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, TwoFactorAuthenticatable;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'users';

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'sucursal_id',
        'usuario',
        'nombre',
        'email',
        'password',
        'rol',
        'acceso_todas_sucursales',
        'creado_usuario_id',
        'modificado_usuario_id',
        'estatus',
        'email_verified_at',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'two_factor_secret',
        'two_factor_recovery_codes',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'two_factor_confirmed_at' => 'datetime',
            'acceso_todas_sucursales' => 'boolean',
            'estatus' => 'boolean',
        ];
    }

    /**
     * Get the name of the unique identifier for the user.
     *
     * @return string
     */
    public function username()
    {
        return 'usuario';
    }

    /**
     * Relación con la sucursal principal del usuario
     */
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    /**
     * Relación muchos a muchos con sucursales accesibles
     */
    public function sucursalesAccesibles()
    {
        return $this->belongsToMany(
            Sucursal::class,
            'usuario_sucursal_acceso',
            'user_id',
            'sucursal_id'
        )->withTimestamps();
    }

    /**
     * Alias para sucursalesAccesibles (para uso en frontend)
     */
    public function sucursales()
    {
        return $this->sucursalesAccesibles();
    }

    /**
     * Usuario que creó este usuario
     */
    public function creadoUsuario()
    {
        return $this->belongsTo(User::class, 'creado_usuario_id');
    }

    /**
     * Usuario que modificó este usuario
     */
    public function modificadoUsuario()
    {
        return $this->belongsTo(User::class, 'modificado_usuario_id');
    }

    /**
     * Usuario que creó este usuario (alias legacy)
     */
    public function creador()
    {
        return $this->creadoUsuario();
    }

    /**
     * Usuario que modificó este usuario (alias legacy)
     */
    public function modificador()
    {
        return $this->modificadoUsuario();
    }

    /**
     * Scope para obtener solo usuarios activos
     */
    public function scopeActivos($query)
    {
        return $query->where('estatus', 1);
    }

    /**
     * Scope para filtrar por rol
     */
    public function scopeConRol($query, $rol)
    {
        return $query->where('rol', $rol);
    }

    /**
     * Verificar si el usuario tiene acceso a una sucursal específica
     */
    public function tieneAccesoASucursal($sucursalId): bool
    {
        if ($this->acceso_todas_sucursales) {
            return true;
        }

        return $this->sucursalesAccesibles()->where('sucursal_id', $sucursalId)->exists();
    }

    /**
     * Verificar si el usuario es administrador
     */
    public function esAdministrador(): bool
    {
        return $this->rol === 'administrador';
    }

    /**
     * Verificar si el usuario es supervisor
     */
    public function esSupervisor(): bool
    {
        return $this->rol === 'supervisor';
    }

    /**
     * Verificar si el usuario es capturista
     */
    public function esCapturista(): bool
    {
        return $this->rol === 'capturista';
    }

    /**
     * Verificar si el usuario es vendedor
     */
    public function esVendedor(): bool
    {
        return $this->rol === 'vendedor';
    }
}
