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
        'updated_by_user_id',
        'estatus'
    ];

    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
        ];
    }

    public function articulo()
    {
        return $this->belongsTo(Articulo::class, 'articulo_id');
    }

    public function auto()
    {
        return $this->belongsTo(Auto::class, 'auto_id');
    }

    public function actualizador()
    {
        return $this->belongsTo(User::class, 'updated_by_user_id');
    }
}
