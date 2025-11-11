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
        'usuario_modificacion_id'
    ];

    /**
     * Relación: Sucursal donde está el stock
     */
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    /**
     * Relación: Artículo en inventario
     */
    public function articulo()
    {
        return $this->belongsTo(Articulo::class, 'articulo_id');
    }

    /**
     * Relación: Usuario que modificó
     */
    public function actualizador()
    {
        return $this->belongsTo(User::class, 'usuario_modificacion_id');
    }

    /**
     * Relación: Movimientos de inventario
     */
    public function movimientos()
    {
        return $this->hasMany(MovimientoInventario::class, 'articulo_id')
            ->where('sucursal_id', $this->sucursal_id)
            ->orderBy('created_at', 'desc');
    }
}
