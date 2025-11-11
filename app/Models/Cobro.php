<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cobro extends Model
{
    //
    protected $table = 'cobros';

    protected $fillable = [
        'venta_id',
        'fecha_cobro',
        'forma_pago',
        'monto',
        'referencia'
    ];

    public function venta()
    {
        return $this->belongsTo(Venta::class, 'venta_id');
    }
}
