<script setup lang="ts">
import { Head, router, useForm, usePage } from '@inertiajs/vue3';
import { ref } from 'vue';
import settings from '@/routes/settings';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
} from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import HeadingSmall from '@/components/HeadingSmall.vue';
import InputError from '@/components/InputError.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import SettingsLayout from '@/layouts/settings/Layout.vue';
import { type BreadcrumbItem } from '@/types';

interface User {
    id: number;
    usuario: string;
    nombre: string;
    email: string;
    rol: string;
    estatus: boolean;
    sucursal_id: number;
    sucursal: {
        id: number;
        nombre: string;
    };
    sucursales?: Array<{
        id: number;
        nombre: string;
    }>;
    creado_usuario?: {
        usuario: string;
        nombre: string;
    } | null;
    created_at: string;
    modificado_usuario?: {
        usuario: string;
        nombre: string;
    } | null;
    updated_at: string;
}

interface Props {
    users: {
        data: User[];
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
        links: Array<{ url: string | null; label: string; active: boolean }>;
    };
    search: string;
    canDelete: boolean;
}

const props = defineProps<Props>();
const page = usePage();

// Obtener el usuario actual
const currentUser = page.props.auth.user as any;

// Verificar si el usuario actual puede modificar a otro usuario
const canModifyUser = (user: User) => {
    // Los administradores pueden modificar a cualquiera
    if (currentUser.rol === 'administrador') {
        return true;
    }
    // Los supervisores no pueden modificar administradores
    if (currentUser.rol === 'supervisor' && user.rol === 'administrador') {
        return false;
    }
    return true;
};

// Obtener mensaje de éxito del flash
const flashSuccess = (page.props.flash as any)?.success || null;

// Breadcrumbs
const breadcrumbItems: BreadcrumbItem[] = [
    {
        title: 'Lista de Usuarios',
        href: settings.users.index().url,
    },
];

// Estado del buscador
const searchQuery = ref(props.search);

// Estados de modales
const showChangePasswordModal = ref(false);
const showDeactivateModal = ref(false);
const showActivateModal = ref(false);
const showDeleteModal = ref(false);
const selectedUser = ref<User | null>(null);

// Formulario para cambiar contraseña
const passwordForm = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

// Formulario para desactivar
const deactivateForm = useForm({
    password: '',
});

// Formulario para activar
const activateForm = useForm({
    password: '',
});

// Formulario para eliminar
const deleteForm = useForm({
    password: '',
});

// Función de búsqueda
const performSearch = () => {
    router.get(
        settings.users.index({ query: { search: searchQuery.value } }).url,
        {},
        {
            preserveState: true,
            preserveScroll: true,
        },
    );
};

// Abrir modal de cambiar contraseña
const openChangePasswordModal = (user: User) => {
    selectedUser.value = user;
    passwordForm.reset();
    showChangePasswordModal.value = true;
};

// Cambiar contraseña
const changePassword = () => {
    if (!selectedUser.value) return;

    passwordForm.patch(settings.users.changePassword({ user: selectedUser.value.id }).url, {
        preserveScroll: true,
        onSuccess: () => {
            showChangePasswordModal.value = false;
            passwordForm.reset();
        },
    });
};

// Abrir modal de desactivar
const openDeactivateModal = (user: User) => {
    selectedUser.value = user;
    deactivateForm.reset();
    showDeactivateModal.value = true;
};

// Desactivar usuario
const deactivateUser = () => {
    if (!selectedUser.value) return;

    deactivateForm.patch(settings.users.deactivate({ user: selectedUser.value.id }).url, {
        preserveScroll: true,
        onSuccess: () => {
            showDeactivateModal.value = false;
            deactivateForm.reset();
        },
    });
};

// Abrir modal de activar
const openActivateModal = (user: User) => {
    selectedUser.value = user;
    activateForm.reset();
    showActivateModal.value = true;
};

// Activar usuario
const activateUser = () => {
    if (!selectedUser.value) return;

    activateForm.patch(settings.users.activate({ user: selectedUser.value.id }).url, {
        preserveScroll: true,
        onSuccess: () => {
            showActivateModal.value = false;
            activateForm.reset();
        },
    });
};

// Abrir modal de eliminar
const openDeleteModal = (user: User) => {
    selectedUser.value = user;
    deleteForm.reset();
    showDeleteModal.value = true;
};

// Eliminar usuario
const deleteUser = () => {
    if (!selectedUser.value) return;

    deleteForm.delete(settings.users.destroy({ user: selectedUser.value.id }).url, {
        preserveScroll: true,
        onSuccess: () => {
            showDeleteModal.value = false;
            deleteForm.reset();
        },
    });
};

// Función para obtener el color del badge según el rol
const getRoleBadgeVariant = (rol: string) => {
    switch (rol) {
        case 'administrador':
            return 'default';
        case 'supervisor':
            return 'secondary';
        case 'capturista':
            return 'outline';
        case 'vendedor':
            return 'outline';
        default:
            return 'outline';
    }
};

// Función para obtener el texto del rol en español
const getRoleLabel = (rol: string) => {
    switch (rol) {
        case 'administrador':
            return 'Administrador';
        case 'supervisor':
            return 'Supervisor';
        case 'capturista':
            return 'Capturista';
        case 'vendedor':
            return 'Vendedor';
        default:
            return rol;
    }
};

// Función para formatear fecha
const formatDate = (dateString: string) => {
    if (!dateString) return '-';
    const date = new Date(dateString);
    return date.toLocaleDateString('es-MX', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    });
};

// Función para obtener todas las sucursales de un usuario (principal + asociadas)
const getAllSucursales = (user: User) => {
    const sucursales: Array<{ id: number; nombre: string; isPrincipal: boolean }> = [];
    
    // Agregar sucursal principal
    if (user.sucursal) {
        sucursales.push({
            id: user.sucursal.id,
            nombre: user.sucursal.nombre,
            isPrincipal: true
        });
    }
    
    // Agregar sucursales asociadas que no sean la principal
    if (user.sucursales && user.sucursales.length > 0) {
        user.sucursales.forEach(sucursal => {
            if (sucursal.id !== user.sucursal_id) {
                sucursales.push({
                    id: sucursal.id,
                    nombre: sucursal.nombre,
                    isPrincipal: false
                });
            }
        });
    }
    
    return sucursales;
};
</script>

<template>
    <Head title="Lista de Usuarios" />

    <AppLayout :breadcrumb-items="breadcrumbItems">
        <SettingsLayout>
            <div class="space-y-6 w-full">
                <HeadingSmall
                    title="Lista de Usuarios"
                    description="Gestiona los usuarios del sistema"
                />

                <!-- Buscador -->
                <div class="flex gap-2">
                    <Input
                        v-model="searchQuery"
                        type="text"
                        placeholder="Buscar por usuario, nombre, email o rol..."
                        class="flex-1"
                        @keyup.enter="performSearch"
                    />
                    <Button @click="performSearch">Buscar</Button>
                </div>

                <!-- Mensaje de éxito -->
                <div
                    v-if="flashSuccess"
                    class="rounded-md bg-green-50 p-4 text-sm text-green-800 dark:bg-green-900/20 dark:text-green-400"
                >
                    {{ flashSuccess }}
                </div>

                <!-- Tabla de usuarios -->
                <div class="w-full rounded-md border">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="border-b bg-muted/50">
                                <tr>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Usuario</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Nombre</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Email</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Rol</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium w-48">Sucursales</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Estatus</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Usuario Creó</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Fecha Creación</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Usuario Modificó</th>
                                    <th class="px-3 py-3 text-left text-xs font-medium">Fecha Modificó</th>
                                    <th class="px-3 py-3 text-center text-xs font-medium whitespace-nowrap">
                                        Contraseña
                                    </th>
                                    <th class="px-3 py-3 text-center text-xs font-medium">Acción Estatus</th>
                                    <th
                                        v-if="canDelete"
                                        class="px-3 py-3 text-center text-xs font-medium"
                                    >
                                        Eliminar Cuenta
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="user in users.data"
                                    :key="user.id"
                                    class="border-b last:border-0 hover:bg-muted/50"
                                >
                                    <td class="px-3 py-3 text-xs font-medium">{{ user.usuario }}</td>
                                    <td class="px-3 py-3 text-xs">{{ user.nombre }}</td>
                                    <td class="px-3 py-3 text-xs">{{ user.email }}</td>
                                    <td class="px-3 py-3 text-xs">
                                        <Badge :variant="getRoleBadgeVariant(user.rol)">
                                            {{ getRoleLabel(user.rol) }}
                                        </Badge>
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        <select 
                                            v-if="getAllSucursales(user).length > 0"
                                            class="w-full rounded-md border border-input bg-background px-2 py-1 text-xs ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 cursor-pointer"
                                        >
                                            <option 
                                                v-for="sucursal in getAllSucursales(user)" 
                                                :key="sucursal.id"
                                                :value="sucursal.id"
                                            >
                                                {{ sucursal.isPrincipal ? '★ ' : '' }}{{ sucursal.nombre }}
                                            </option>
                                        </select>
                                        <span v-else class="text-muted-foreground">Sin sucursales</span>
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        <Badge :variant="user.estatus ? 'default' : 'destructive'">
                                            {{ user.estatus ? 'Activo' : 'Inactivo' }}
                                        </Badge>
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        {{ user.creado_usuario?.usuario || '-' }}
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        {{ formatDate(user.created_at) }}
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        {{ user.modificado_usuario?.usuario || '-' }}
                                    </td>
                                    <td class="px-3 py-3 text-xs">
                                        {{ formatDate(user.updated_at) }}
                                    </td>
                                    <td class="px-3 py-3 text-center whitespace-nowrap text-xs">
                                        <Button
                                            size="sm"
                                            variant="outline"
                                            class="text-xs"
                                            :disabled="!canModifyUser(user)"
                                            @click="openChangePasswordModal(user)"
                                        >
                                            Cambiar
                                        </Button>
                                    </td>
                                    <td class="px-3 py-3 text-center whitespace-nowrap text-xs">
                                        <Button
                                            v-if="user.estatus"
                                            size="sm"
                                            variant="outline"
                                            class="text-xs"
                                            :disabled="!canModifyUser(user)"
                                            @click="openDeactivateModal(user)"
                                        >
                                            Desactivar
                                        </Button>
                                        <Button
                                            v-else
                                            size="sm"
                                            variant="outline"
                                            class="text-xs"
                                            :disabled="!canModifyUser(user)"
                                            @click="openActivateModal(user)"
                                        >
                                            Activar
                                        </Button>
                                    </td>
                                <td v-if="canDelete" class="px-3 py-3 text-center whitespace-nowrap text-xs">
                                    <Button
                                        size="sm"
                                        variant="destructive"
                                        class="text-xs"
                                        @click="openDeleteModal(user)"
                                    >
                                        Eliminar Cuenta
                                    </Button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                </div>

                <!-- Paginación -->
                <div v-if="users.last_page > 1" class="flex justify-center gap-2">
                    <Button
                        v-for="link in users.links"
                        :key="link.label"
                        :variant="link.active ? 'default' : 'outline'"
                        :disabled="!link.url"
                        size="sm"
                        @click="link.url && router.get(link.url)"
                    >
                        <span v-html="link.label"></span>
                    </Button>
                </div>
            </div>
        </SettingsLayout>
    </AppLayout>

    <!-- Modal: Cambiar Contraseña -->
    <Dialog v-model:open="showChangePasswordModal">
        <DialogContent>
            <DialogHeader>
                <DialogTitle>Cambiar Contraseña</DialogTitle>
                <DialogDescription>
                    Cambia la contraseña de
                    <strong>{{ selectedUser?.nombre }}</strong>
                </DialogDescription>
            </DialogHeader>

            <form @submit.prevent="changePassword" class="space-y-4">
                <div class="space-y-2">
                    <Label for="current_password">Ingresa tu contraseña para continuar</Label>
                    <Input
                        id="current_password"
                        v-model="passwordForm.current_password"
                        type="password"
                        required
                    />
                    <InputError :message="passwordForm.errors.current_password" />
                </div>

                <div class="space-y-2">
                    <Label for="new_password">Nueva Contraseña del Usuario seleccionado</Label>
                    <Input
                        id="new_password"
                        v-model="passwordForm.password"
                        type="password"
                        required
                    />
                    <InputError :message="passwordForm.errors.password" />
                </div>

                <div class="space-y-2">
                    <Label for="password_confirmation"
                        >Confirmar Nueva Contraseña del Usuario seleccionado</Label
                    >
                    <Input
                        id="password_confirmation"
                        v-model="passwordForm.password_confirmation"
                        type="password"
                        required
                    />
                </div>

                <DialogFooter>
                    <Button
                        type="button"
                        variant="outline"
                        @click="showChangePasswordModal = false"
                    >
                        Cancelar
                    </Button>
                    <Button type="submit" :disabled="passwordForm.processing">
                        Cambiar Contraseña
                    </Button>
                </DialogFooter>
            </form>
        </DialogContent>
    </Dialog>

    <!-- Modal: Desactivar Usuario -->
    <Dialog v-model:open="showDeactivateModal">
        <DialogContent>
            <DialogHeader>
                <DialogTitle>Desactivar Usuario</DialogTitle>
                <DialogDescription>
                    ¿Estás seguro de que deseas desactivar a
                    <strong>{{ selectedUser?.nombre }}</strong
                    >? El usuario no podrá acceder al sistema.
                </DialogDescription>
            </DialogHeader>

            <form @submit.prevent="deactivateUser" class="space-y-4">
                <div class="space-y-2">
                    <Label for="deactivate_password">Ingresa tu contraseña para continuar</Label>
                    <Input
                        id="deactivate_password"
                        v-model="deactivateForm.password"
                        type="password"
                        required
                        placeholder="Ingresa tu contraseña para confirmar"
                    />
                    <InputError :message="deactivateForm.errors.password" />
                </div>

                <DialogFooter>
                    <Button type="button" variant="outline" @click="showDeactivateModal = false">
                        Cancelar
                    </Button>
                    <Button
                        type="submit"
                        variant="destructive"
                        :disabled="deactivateForm.processing"
                    >
                        Desactivar
                    </Button>
                </DialogFooter>
            </form>
        </DialogContent>
    </Dialog>

    <!-- Modal: Activar Usuario -->
    <Dialog v-model:open="showActivateModal">
        <DialogContent>
            <DialogHeader>
                <DialogTitle>Activar Usuario</DialogTitle>
                <DialogDescription>
                    ¿Estás seguro de que deseas activar a
                    <strong>{{ selectedUser?.nombre }}</strong
                    >? El usuario podrá acceder al sistema nuevamente.
                </DialogDescription>
            </DialogHeader>

            <form @submit.prevent="activateUser" class="space-y-4">
                <div class="space-y-2">
                    <Label for="activate_password">Ingresa tu contraseña para continuar</Label>
                    <Input
                        id="activate_password"
                        v-model="activateForm.password"
                        type="password"
                        required
                        placeholder="Ingresa tu contraseña para confirmar"
                    />
                    <InputError :message="activateForm.errors.password" />
                </div>

                <DialogFooter>
                    <Button type="button" variant="outline" @click="showActivateModal = false">
                        Cancelar
                    </Button>
                    <Button type="submit" :disabled="activateForm.processing">
                        Activar
                    </Button>
                </DialogFooter>
            </form>
        </DialogContent>
    </Dialog>

    <!-- Modal: Eliminar Usuario -->
    <Dialog v-model:open="showDeleteModal">
        <DialogContent>
            <DialogHeader>
                <DialogTitle>Eliminar Usuario</DialogTitle>
                <DialogDescription>
                    <span class="text-red-600 dark:text-red-400">
                        ¡Advertencia! Esta acción no se puede deshacer.
                    </span>
                    <br />
                    ¿Estás seguro de que deseas eliminar permanentemente a
                    <strong>{{ selectedUser?.nombre }}</strong
                    >?
                </DialogDescription>
            </DialogHeader>

            <form @submit.prevent="deleteUser" class="space-y-4">
                <div class="space-y-2">
                    <Label for="delete_password">Ingresa tu contraseña para continuar</Label>
                    <Input
                        id="delete_password"
                        v-model="deleteForm.password"
                        type="password"
                        required
                        placeholder="Ingresa tu contraseña para confirmar"
                    />
                    <InputError :message="deleteForm.errors.password" />
                </div>

                <DialogFooter>
                    <Button type="button" variant="outline" @click="showDeleteModal = false">
                        Cancelar
                    </Button>
                    <Button type="submit" variant="destructive" :disabled="deleteForm.processing">
                        Eliminar Permanentemente
                    </Button>
                </DialogFooter>
            </form>
        </DialogContent>
    </Dialog>
</template>
