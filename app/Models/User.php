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
            'estatus' => 'boolean',
            'acceso_todas_sucursales' => 'boolean',
        ];
    }

    /**
     * Relación: Sucursal principal del usuario
     */
    public function sucursalPrincipal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    /**
     * Relación: Sucursales a las que el usuario tiene acceso (Many-to-Many)
     */
    public function sucursales()
    {
        return $this->belongsToMany(Sucursal::class, 'sucursal_user', 'user_id', 'sucursal_id')
            ->withPivot('updated_by_user_id')
            ->withTimestamps();
    }

    /**
     * Relación: Usuario que creó este usuario
     */
    public function creador()
    {
        return $this->belongsTo(User::class, 'creado_usuario_id');
    }

    /**
     * Relación: Usuario que modificó este usuario
     */
    public function actualizador()
    {
        return $this->belongsTo(User::class, 'modificado_usuario_id');
    }

    /**
     * Relación: Usuarios creados por este usuario
     */
    public function usuariosCreados()
    {
        return $this->hasMany(User::class, 'creado_usuario_id');
    }

    /**
     * Relación: Usuarios modificados por este usuario
     */
    public function usuariosModificados()
    {
        return $this->hasMany(User::class, 'modificado_usuario_id');
    }

    /**
     * Relación: Artículos creados por este usuario
     */
    public function articulos()
    {
        return $this->hasMany(Articulo::class, 'user_id');
    }

    /**
     * Relación: Autos creados por este usuario
     */
    public function autos()
    {
        return $this->hasMany(Auto::class, 'user_id');
    }

    /**
     * Relación: Ventas realizadas por este usuario
     */
    public function ventas()
    {
        return $this->hasMany(Venta::class, 'user_id');
    }

    /**
     * Relación: Movimientos de inventario realizados por este usuario
     */
    public function movimientosInventario()
    {
        return $this->hasMany(MovimientoInventario::class, 'user_id');
    }

    /**
     * Relación: Sucursales creadas por este usuario
     */
    public function sucursalesCreadas()
    {
        return $this->hasMany(Sucursal::class, 'user_id');
    }

    public function compatibilidadesActualizadas()
    {
        return $this->hasMany(Compatibilidad::class, 'updated_by_user_id');
    }

    public function inventariosActualizados()
    {
        return $this->hasMany(Inventario::class, 'updated_by_user_id');
    }
}
