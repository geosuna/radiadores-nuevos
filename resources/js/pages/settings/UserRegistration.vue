<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import HeadingSmall from '@/components/HeadingSmall.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Checkbox } from '@/components/ui/checkbox';
import { Spinner } from '@/components/ui/spinner';
import AppLayout from '@/layouts/AppLayout.vue';
import SettingsLayout from '@/layouts/settings/Layout.vue';
import { create, store } from '@/routes/settings/users';
import { type BreadcrumbItem } from '@/types';
import { useForm, Head } from '@inertiajs/vue3';

interface Sucursal {
    id: number;
    nombre: string;
}

interface Props {
    sucursales: Sucursal[];
}

const props = defineProps<Props>();

const breadcrumbItems: BreadcrumbItem[] = [
    {
        title: 'Registrar usuario',
        href: create().url,
    },
];

const form = useForm({
    sucursal_id: '',
    usuario: '',
    nombre: '',
    email: '',
    password: '',
    password_confirmation: '',
    rol: 'vendedor',
    acceso_todas_sucursales: false,
});

const submit = () => {
    form.post(store.url(), {
        onSuccess: () => {
            form.reset();
        },
    });
};
</script>

<template>
    <AppLayout :breadcrumbs="breadcrumbItems">
        <Head>
            <title>Registrar usuario</title>
        </Head>

        <SettingsLayout>
            <div class="space-y-6">
                <HeadingSmall
                    title="Registrar nuevo usuario"
                    description="Crea una cuenta para un nuevo usuario del sistema"
                />

                <form @submit.prevent="submit" class="space-y-6">
                    <div class="grid gap-4 md:grid-cols-2">
                        <div class="grid gap-2">
                            <Label for="sucursal_id">Sucursal principal</Label>
                            <select
                                id="sucursal_id"
                                v-model="form.sucursal_id"
                                required
                                class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                            >
                                <option value="">Selecciona una sucursal</option>
                                <option
                                    v-for="sucursal in props.sucursales"
                                    :key="sucursal.id"
                                    :value="sucursal.id"
                                >
                                    {{ sucursal.nombre }}
                                </option>
                            </select>
                            <InputError :message="form.errors.sucursal_id" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="usuario">Usuario</Label>
                            <Input
                                id="usuario"
                                v-model="form.usuario"
                                type="text"
                                required
                                autocomplete="username"
                                placeholder="Usuario"
                            />
                            <InputError :message="form.errors.usuario" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="nombre">Nombre completo</Label>
                            <Input
                                id="nombre"
                                v-model="form.nombre"
                                type="text"
                                required
                                autocomplete="name"
                                placeholder="Juan Pérez"
                            />
                            <InputError :message="form.errors.nombre" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="email">Correo electrónico</Label>
                            <Input
                                id="email"
                                v-model="form.email"
                                type="email"
                                required
                                autocomplete="email"
                                placeholder="correo@ejemplo.com"
                            />
                            <InputError :message="form.errors.email" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="password">Contraseña</Label>
                            <Input
                                id="password"
                                v-model="form.password"
                                type="password"
                                required
                                autocomplete="new-password"
                                placeholder="Contraseña"
                            />
                            <InputError :message="form.errors.password" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="password_confirmation">Confirmar contraseña</Label>
                            <Input
                                id="password_confirmation"
                                v-model="form.password_confirmation"
                                type="password"
                                required
                                autocomplete="new-password"
                                placeholder="Confirmar contraseña"
                            />
                            <InputError :message="form.errors.password_confirmation" />
                        </div>

                        <div class="grid gap-2">
                            <Label for="rol">Rol</Label>
                            <select
                                id="rol"
                                v-model="form.rol"
                                required
                                class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                            >
                                <option value="administrador">Administrador</option>
                                <option value="supervisor">Supervisor</option>
                                <option value="capturista">Capturista</option>
                                <option value="vendedor">Vendedor</option>
                            </select>
                            <InputError :message="form.errors.rol" />
                        </div>

                        <div class="grid gap-2 items-center">
                            <Label for="acceso_todas_sucursales" class="flex items-center space-x-3">
                                <Checkbox
                                    id="acceso_todas_sucursales"
                                    v-model:checked="form.acceso_todas_sucursales"
                                />
                                <span>Acceso a todas las sucursales</span>
                            </Label>
                            <InputError :message="form.errors.acceso_todas_sucursales" />
                        </div>
                    </div>

                    <div class="flex items-center gap-4">
                        <Button
                            type="submit"
                            :disabled="form.processing"
                        >
                            <Spinner v-if="form.processing" />
                            Registrar usuario
                        </Button>

                        <Transition
                            enter-active-class="transition ease-in-out"
                            enter-from-class="opacity-0"
                            leave-active-class="transition ease-in-out"
                            leave-to-class="opacity-0"
                        >
                            <p
                                v-show="form.recentlySuccessful"
                                class="text-sm text-green-600"
                            >
                                Usuario registrado exitosamente.
                            </p>
                        </Transition>
                    </div>
                </form>
            </div>
        </SettingsLayout>
    </AppLayout>
</template>
