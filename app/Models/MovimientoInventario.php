<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MovimientoInventario extends Model
{
    //
    protected $table = 'movimientos_inventario';

    protected $fillable = [
        'sucursal_id',
        'articulo_id',
        'tipo_movimiento',
        'cantidad',
        'cantidad_anterior',
        'cantidad_nueva',
        'user_id',
        'referencia',
        'observaciones'
    ];

    public function inventario()
    {
        return Inventario::where('sucursal_id', $this->sucursal_id)
            ->where('articulo_id', $this->articulo_id)
            ->first();
    }
}
