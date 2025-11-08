<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sucursal extends Model
{
    use HasFactory;

    protected $table = 'sucursal';

    protected $fillable = [
        'nombre',
        'direccion',
        'ciudad',
        'estado',
        'codigo_postal',
        'telefono',
        'estatus'
    ];

    protected $casts = [
        'estatus' => 'boolean',
    ];

    /**
     * Relación con usuarios de la sucursal
     */
    public function usuarios()
    {
        return $this->hasMany(User::class, 'sucursal_id');
    }

    /**
     * Relación muchos a muchos con usuarios que tienen acceso
     */
    public function usuariosConAcceso()
    {
        return $this->belongsToMany(
            User::class,
            'usuario_sucursal_acceso',
            'sucursal_id',
            'user_id'
        )->withTimestamps();
    }

    /**
     * Scope para obtener solo sucursales activas
     */
    public function scopeActivas($query)
    {
        return $query->where('estatus', 1);
    }
}
