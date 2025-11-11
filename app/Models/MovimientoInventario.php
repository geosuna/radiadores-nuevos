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
        'usuario_movimiento_id',
        'referencia',
        'observaciones'
    ];

    /**
     * Relación: Sucursal del movimiento
     */
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    /**
     * Relación: Artículo movido
     */
    public function articulo()
    {
        return $this->belongsTo(Articulo::class, 'articulo_id');
    }

    /**
     * Relación: Usuario que realizó el movimiento
     */
    public function usuario()
    {
        return $this->belongsTo(User::class, 'usuario_movimiento_id');
    }

    /**
     * Método helper: Obtener el inventario relacionado
     */
    public function inventario()
    {
        return Inventario::where('sucursal_id', $this->sucursal_id)
            ->where('articulo_id', $this->articulo_id)
            ->first();
    }
}
