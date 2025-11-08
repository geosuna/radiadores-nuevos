<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Sucursal>
 */
class SucursalFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'nombre' => fake()->company(),
            'direccion' => fake()->streetAddress(),
            'ciudad' => fake()->city(),
            'estado' => fake()->state(),
            'codigo_postal' => fake()->postcode(),
            'telefono' => fake()->phoneNumber(),
            'estatus' => 1,
        ];
    }

    /**
     * Indicate that the sucursal is inactive.
     */
    public function inactive(): static
    {
        return $this->state(fn(array $attributes) => [
            'estatus' => 0,
        ]);
    }
}
