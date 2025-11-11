<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Inventario extends Model
{
    //
    protected $table = 'inventarios';

    protected $fillable = [
        'sucursal_id',
        'articulo_id',
        'cantidad',
        'stock_minimo',
        'ubicacion',
        'updated_by_user_id'
    ];

    // El inventario pertenece a una sucursal especifica. Un registro de inventario es unico por combinacion sucursal-articulo
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    public function articulo()
    {
        return $this->belongsTo(Articulo::class, 'articulo_id');
    }

    public function actualizador()
    {
        return $this->belongsTo(User::class, 'updated_by_user_id');
    }

    public function movimientos()
    {
        return $this->hasMany(MovimientoInventario::class, 'articulo_id')
            ->where('sucursal_id', $this->sucursal_id)
            ->orderBy('created_at', 'desc');
    }
}
