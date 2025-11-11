<?php

use App\Models\Sucursal;

if (! function_exists('sucursal_actual')) {
    /**
     * Obtener el ID de la sucursal actual de la sesión
     *
     * @return int|null
     */
    function sucursal_actual(): ?int
    {
        return session('sucursal_actual');
    }
}

if (! function_exists('sucursal_actual_modelo')) {
    /**
     * Obtener el modelo completo de la sucursal actual
     *
     * @return Sucursal|null
     */
    function sucursal_actual_modelo(): ?Sucursal
    {
        $sucursalId = sucursal_actual();

        if ($sucursalId) {
            return Sucursal::find($sucursalId);
        }

        return null;
    }
}

if (! function_exists('sucursal_actual_nombre')) {
    /**
     * Obtener el nombre de la sucursal actual
     *
     * @return string|null
     */
    function sucursal_actual_nombre(): ?string
    {
        $sucursal = sucursal_actual_modelo();

        return $sucursal?->nombre;
    }
}
