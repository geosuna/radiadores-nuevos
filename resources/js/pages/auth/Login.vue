<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import TextLink from '@/components/TextLink.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Spinner } from '@/components/ui/spinner';
import AuthBase from '@/layouts/AuthLayout.vue';
import { store } from '@/routes/login';
import { request } from '@/routes/password';
import { useForm, Head } from '@inertiajs/vue3';

interface Sucursal {
    id: number;
    nombre: string;
}

const props = defineProps<{
    status?: string;
    canResetPassword: boolean;
    sucursales: Sucursal[];
}>();

const form = useForm({
    usuario: '',
    password: '',
    sucursal_id: props.sucursales.length > 0 ? props.sucursales[0].id : null,
});

const submit = () => {
    form.post(store.url(), {
        onFinish: () => {
            form.reset('password');
        },
    });
};
</script>

<template>
    <AuthBase
        title="Iniciar sesión"
        description="Ingresa tu usuario y contraseña para acceder a tu cuenta."
    >
        <Head title="Iniciar sesión" />

        <div
            v-if="status"
            class="mb-4 text-center text-sm font-medium text-green-600"
        >
            {{ status }}
        </div>

        <form @submit.prevent="submit" class="flex flex-col gap-6">
            <div class="grid gap-6">
                <div class="grid gap-2">
                    <Label for="sucursal">Sucursal</Label>
                    <select
                        id="sucursal"
                        v-model="form.sucursal_id"
                        name="sucursal_id"
                        required
                        class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-base shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"
                    >
                        <option
                            v-for="sucursal in sucursales"
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
                        name="usuario"
                        required
                        autofocus
                        :tabindex="1"
                        autocomplete="username"
                        placeholder="admin"
                    />
                    <InputError :message="form.errors.usuario" />
                </div>

                <div class="grid gap-2">
                    <div class="flex items-center justify-between">
                        <Label for="password">Contraseña</Label>
                        <TextLink
                            v-if="canResetPassword"
                            :href="request()"
                            class="text-sm"
                            :tabindex="5"
                        >
                            ¿Olvidaste tu contraseña?
                        </TextLink>
                    </div>
                    <Input
                        id="password"
                        v-model="form.password"
                        type="password"
                        name="password"
                        required
                        :tabindex="2"
                        autocomplete="current-password"
                        placeholder="Contraseña"
                    />
                    <InputError :message="form.errors.password" />
                </div>

                <Button
                    type="submit"
                    class="mt-4 w-full"
                    :tabindex="3"
                    :disabled="form.processing"
                    data-test="login-button"
                >
                    <Spinner v-if="form.processing" />
                    Iniciar sesión
                </Button>
            </div>
        </form>
    </AuthBase>
</template>
