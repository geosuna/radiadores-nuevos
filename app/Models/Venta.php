<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Venta extends Model
{
    //
    protected $table = 'ventas';

    protected $fillable = [
        'sucursal_id',
        'user_id',
        'fecha_venta',
        'cliente',
        'total',
        'descuento',
        'subtotal',
        'impuestos',
        'estatus',
        'observaciones'
    ];

    protected function casts(): array
    {
        return [
            'estatus' => 'boolean',
        ];
    }

    public function sucursal()
    {
        return $this->belongsToMany(Sucursal::class, 'sucursal_id');
    }

    public function vendedor()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function detalles()
    {
        return $this->hasMany(VentaDetalle::class, 'venta_id');
    }

    public function cobros()
    {
        return $this->hasMany(Cobro::class, 'venta_id');
    }

    // Funcion para acceder a los articulos de la venta sin pasar por la tabla detalles
    public function articulos()
    {
        return $this->belongsToMany(Articulo::class, 'venta_detalles', 'venta_id', 'articulo_id')
            ->withPivot('cantidad', 'precio_unitario', 'subtotal', 'descuento')
            ->withTimestamps();
    }

    // Metodos utiles Scopes

    // Ventas de una sucursal
    public function scopePorSucursal($query, $sucursal_id)
    {
        return $query->where('sucursal_id', $sucursal_id);
    }

    // Ventas de un vendedor
    public function scopePorVendedor($query, $user_id)
    {
        return $query->where('user_id', $user_id);
    }

    // Ventas del día
    public function scopeHoy($query)
    {
        return $query->whereDate('fecha_venta', today());
    }

    // Calcular totales automáticamente desde los detalles
    public function calcularTotales(): void
    {
        $this->subtotal = $this->detalles()->sum('subtotal');
        $this->descuento = $this->detalles()->sum('descuento');
        $this->impuestos = $this->subtotal * 0.16; // 16% IVA
        $this->total = $this->subtotal - $this->descuento + $this->impuestos;
        $this->save();
    }

    // Agregar un cobro
    public function agregarCobro(string $formaPago, float $monto, ?string $referencia = null)
    {
        return $this->cobros()->create([
            'fecha_cobro' => now(),
            'forma_pago' => $formaPago,
            'monto' => $monto,
            'referencia' => $referencia,
        ]);
    }
}
