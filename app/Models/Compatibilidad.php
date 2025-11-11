<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Compatibilidad extends Model
{
    //
    protected $table = 'compatibilidades';

    protected $fillable = [
        'articulo_id',
        'auto_id',
        'tipo_compatibilidad',
        'observaciones',
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
     * Relación: Artículo
     */
    public function articulo()
    {
        return $this->belongsTo(Articulo::class, 'articulo_id');
    }

    /**
     * Relación: Auto
     */
    public function auto()
    {
        return $this->belongsTo(Auto::class, 'auto_id');
    }

    /**
     * Relación: Usuario que registró/modificó
     */
    public function actualizador()
    {
        return $this->belongsTo(User::class, 'modificado_usuario_id');
    }
}
