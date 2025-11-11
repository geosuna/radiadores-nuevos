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
        'auto_principal_id',
        'foto_url',
        'creado_usuario_id',
        'modificado_usuario_id',
        'estatus'
    ];

    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
            'precio_venta' => 'decimal:2',
        ];
    }

    /**
     * Relación: Auto principal para el cual fue diseñado
     */
    public function autoPrincipal()
    {
        return $this->belongsTo(Auto::class, 'auto_principal_id');
    }

    /**
     * Relación: Usuario que creó el artículo
     */
    public function creador()
    {
        return $this->belongsTo(User::class, 'creado_usuario_id');
    }

    /**
     * Relación: Usuario que modificó el artículo
     */
    public function modificador()
    {
        return $this->belongsTo(User::class, 'modificado_usuario_id');
    }

    /**
     * Relación: Compatibilidades del artículo
     */
    public function compatibilidades()
    {
        return $this->hasMany(Compatibilidad::class, 'articulo_id');
    }

    /**
     * Relación: Inventarios del artículo en diferentes sucursales
     */
    public function inventarios()
    {
        return $this->hasMany(Inventario::class, 'articulo_id');
    }

    /**
     * Relación: Detalles de ventas
     */
    public function ventaDetalles()
    {
        return $this->hasMany(VentaDetalle::class, 'articulo_id');
    }

    /**
     * Relación: Movimientos de inventario
     */
    public function movimientos()
    {
        return $this->hasMany(MovimientoInventario::class, 'articulo_id');
    }

    /**
     * Método helper: Stock total en todas las sucursales
     */
    public function stockTotal()
    {
        return $this->inventarios()->sum('cantidad');
    }

    /**
     * Método helper: Inventario en una sucursal específica
     */
    public function inventarioEnSucursal($sucursal_id)
    {
        return $this->inventarios()->where('sucursal_id', $sucursal_id)->first();
    }
}
