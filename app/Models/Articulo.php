<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Articulo extends Model
{
    //
    protected $table = 'articulos';

    protected $fillable = [
        'dpi',
        'descripcion',
        'precio_venta',
        'categoria',
        'marca',
        'modelo',
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
        return $this->hasMany(Compatibilidad::class, 'articulo_id');
    }

    public function inventarios()
    {
        return $this->hasMany(Inventario::class, 'articulo_id');
    }

    public function stockTotal()
    {
        return $this->inventarios()->sum('cantidad');
    }

    public function inventarioEnSucursal($sucursal_id)
    {
        return $this->inventarios()->where('sucursal_id', $sucursal_id)->first();
    }

    public function ventaDetalles()
    {
        return $this->hasMany(VentaDetalle::class, 'articulo_id');
    }
}
