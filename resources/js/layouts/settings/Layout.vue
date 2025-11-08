<script setup lang="ts">
import Heading from '@/components/Heading.vue';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { toUrl, urlIsActive } from '@/lib/utils';
import { edit as editAppearance } from '@/routes/appearance';
import { edit as editProfile } from '@/routes/profile';
import { show } from '@/routes/two-factor';
import { edit as editPassword } from '@/routes/user-password';
import settings from '@/routes/settings';
import { type NavItem } from '@/types';
import { Link, usePage } from '@inertiajs/vue3';

const page = usePage();
const user = page.props.auth.user;

// Verificar si el usuario puede registrar nuevos usuarios
const canRegisterUsers = user.rol === 'administrador' || user.rol === 'supervisor';

// Verificar si el usuario debe ver la opción de cambiar contraseña (vendedor y capturista)
const showPasswordOption = user.rol === 'vendedor' || user.rol === 'capturista';

const sidebarNavItems: NavItem[] = [
    {
        title: 'Perfil',
        href: editProfile(),
    },
];

// Agregar opción de contraseña solo para vendedor y capturista
if (showPasswordOption) {
    sidebarNavItems.push({
        title: 'Contraseña',
        href: editPassword(),
    });
}

// Agregar autenticación de dos factores y apariencia para todos
sidebarNavItems.push(
    {
        title: 'Autenticación de dos factores',
        href: show(),
    },
    {
        title: 'Apariencia',
        href: editAppearance(),
    }
);

// Agregar opciones de gestión de usuarios para administradores y supervisores
if (canRegisterUsers) {
    sidebarNavItems.push({
        title: 'Registrar usuario',
        href: settings.users.create(),
    });
    sidebarNavItems.push({
        title: 'Lista de usuarios',
        href: settings.users.index(),
    });
}

const currentPath = typeof window !== undefined ? window.location.pathname : '';
</script>

<template>
    <div class="px-4 py-6">
        <Heading
            title="Configuración"
            description="Administra tu perfil y configuración de cuenta"
        />

        <div class="flex flex-col lg:flex-row lg:space-x-12">
            <aside class="w-full max-w-xl lg:w-48">
                <nav class="flex flex-col space-y-1 space-x-0">
                    <Button
                        v-for="item in sidebarNavItems"
                        :key="toUrl(item.href)"
                        variant="ghost"
                        :class="[
                            'w-full justify-start',
                            { 'bg-muted': urlIsActive(item.href, currentPath) },
                        ]"
                        as-child
                    >
                        <Link :href="item.href">
                            <component :is="item.icon" class="h-4 w-4" />
                            {{ item.title }}
                        </Link>
                    </Button>
                </nav>
            </aside>

            <Separator class="my-6 lg:hidden" />

            <div class="flex-1 w-full">
                <section class="w-full space-y-12">
                    <slot />
                </section>
            </div>
        </div>
    </div>
</template>
