<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Auto extends Model
{
    //
    protected $table = 'autos';

    protected $fillable = [
        'marca',
        'modelo',
        'anios_rango',
        'motor',
        'descripcion',
        'creado_usuario_id',
        'modificado_usuario_id',
        'estatus'
    ];

    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
        ];
    }

    /**
     * Relación: Usuario que creó el auto
     */
    public function creador()
    {
        return $this->belongsTo(User::class, 'creado_usuario_id');
    }

    /**
     * Relación: Usuario que modificó el auto
     */
    public function modificador()
    {
        return $this->belongsTo(User::class, 'modificado_usuario_id');
    }

    /**
     * Relación: Compatibilidades del auto
     */
    public function compatibilidades()
    {
        return $this->hasMany(Compatibilidad::class, 'auto_id');
    }

    /**
     * Relación: Artículos para los que este auto es principal
     */
    public function articulosPrincipales()
    {
        return $this->hasMany(Articulo::class, 'auto_principal_id');
    }
}
