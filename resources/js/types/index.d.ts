import { InertiaLinkProps } from '@inertiajs/vue3';
import type { LucideIcon } from 'lucide-vue-next';

export interface Auth {
    user: User;
}

export interface Sucursal {
    id: number;
    nombre: string;
    modelo?: any;
}

export interface BreadcrumbItem {
    title: string;
    href: string;
}

export interface NavItem {
    title: string;
    href: NonNullable<InertiaLinkProps['href']>;
    icon?: LucideIcon;
    isActive?: boolean;
}

export type AppPageProps<
    T extends Record<string, unknown> = Record<string, unknown>,
> = T & {
    name: string;
    quote: { message: string; author: string };
    auth: Auth;
    sucursal_actual?: Sucursal;
    sidebarOpen: boolean;
};

export interface User {
    id: number;
    sucursal_id: number;
    usuario: string;
    nombre: string;
    email: string;
    avatar?: string;
    rol: 'administrador' | 'supervisor' | 'capturista' | 'vendedor';
    acceso_todas_sucursales: boolean;
    estatus: boolean;
    email_verified_at: string | null;
    created_at: string;
    updated_at: string;
}

export type BreadcrumbItemType = BreadcrumbItem;
