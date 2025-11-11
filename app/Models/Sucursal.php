<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sucursal extends Model
{
    use HasFactory;

    protected $table = 'sucursales';

    protected $fillable = [
        'nombre',
        'direccion',
        'user_id',
        'updated_by_user_id',
        'estatus',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
        ];
    }

    /**
     * Relación: Usuario que creó la sucursal
     */
    public function creador()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * Relación: Usuario que actualizó la sucursal
     */
    public function actualizador()
    {
        return $this->belongsTo(User::class, 'updated_by_user_id');
    }

    /**
     * Relación: Usuarios que tienen esta sucursal como principal
     */
    public function usuariosPrincipales()
    {
        return $this->hasMany(User::class, 'sucursal_id');
    }

    /**
     * Relación: Usuarios con acceso a esta sucursal (Many-to-Many)
     */
    public function usuarios()
    {
        return $this->belongsToMany(User::class, 'sucursal_user', 'sucursal_id', 'user_id')
            ->withPivot('updated_by_user_id')
            ->withTimestamps();
    }

    /**
     * Relación: Inventarios de esta sucursal
     */
    public function inventarios()
    {
        return $this->hasMany(Inventario::class, 'sucursal_id');
    }

    /**
     * Relación: Ventas realizadas en esta sucursal
     */
    public function ventas()
    {
        return $this->hasMany(Venta::class, 'sucursal_id');
    }

    /**
     * Relación: Movimientos de inventario de esta sucursal
     */
    public function movimientosInventario()
    {
        return $this->hasMany(MovimientoInventario::class, 'sucursal_id');
    }
}
