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
        'anio',
        'motor',
        'descripcion',
        'user_id',
        'updated_by_user_id',
        'estatus'
    ];

    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
        ];
    }

    public function compatibilidades()
    {
        return $this->hasMany(Compatibilidad::class, 'auto_id');
    }
}
