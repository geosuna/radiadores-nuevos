# 🚗 Sistema de Gestión de Inventario - Radiadores Nuevos

Sistema web completo para la gestión de inventario, ventas y usuarios en una empresa de radiadores automotrices. Desarrollado con Laravel 12, Vue 3, Inertia.js y TypeScript.

## 📋 Tabla de Contenidos

- [Estado del Proyecto](#-estado-del-proyecto)
- [Características Principales](#-características-principales)
- [Tecnologías](#️-tecnologías)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación](#-instalación)
- [Configuración](#️-configuración)
- [Uso](#-uso)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Sistema de Usuarios](#-sistema-de-usuarios)
- [Base de Datos](#️-base-de-datos)
- [Testing](#-testing)
- [Contribuir](#-contribuir)

## 🎯 Estado del Proyecto

Este proyecto se desarrolla en fases incrementales. A continuación el estado actual de cada módulo:

### Fase 1: Infraestructura Base ✅ COMPLETADA
- [x] Configuración inicial de Laravel 12
- [x] Integración de Vue 3 + TypeScript
- [x] Configuración de Inertia.js 2.0
- [x] Setup de Tailwind CSS 4
- [x] Configuración de Vite 7
- [x] Integración de shadcn/ui
- [x] Estructura de base de datos
- [x] Migraciones iniciales
- [x] Seeders de datos base

### Fase 2: Autenticación y Seguridad ✅ COMPLETADA
- [x] Sistema de autenticación con campo `usuario` (no email)
- [x] Mensajes de error diferenciados (usuario no existe, inactivo, contraseña incorrecta)
- [x] Integración de Laravel Fortify
- [x] Autenticación de dos factores (2FA)
- [x] Recuperación de contraseña
- [x] Rate limiting y protección contra fuerza bruta
- [x] Confirmación de contraseña para operaciones sensibles
- [x] Testing completo de autenticación

### Fase 3: Sistema de Usuarios ✅ COMPLETADA
- [x] Modelo de usuarios con 4 roles (administrador, supervisor, capturista, vendedor)
- [x] Registro de usuarios (admin/supervisor)
- [x] Lista de usuarios con búsqueda y paginación
- [x] Tabla de 13 columnas con toda la información
- [x] Cambio de contraseñas por rol
- [x] Activación/desactivación de usuarios
- [x] Eliminación de usuarios (solo admin)
- [x] Sistema de auditoría (creado por, modificado por, fechas)
- [x] Gestión de sucursales y accesos múltiples
- [x] Dropdown de sucursales con indicador ★ de principal
- [x] Validación de permisos por rol
- [x] Testing de gestión de usuarios

### Fase 4: Gestión de Perfil ✅ COMPLETADA
- [x] Página de perfil de usuario
- [x] Actualización de información personal
- [x] Cambio de contraseña (según rol)
- [x] Configuración de 2FA
- [x] Códigos de recuperación 2FA
- [x] Configuración de apariencia (modo oscuro/claro)
- [x] Testing de perfil

### Fase 5: Catálogos Base 🚧 EN DESARROLLO
- [x] Modelo y migración de Sucursales
- [x] Modelo y migración de Catálogo de Autos
- [x] Modelo y migración de Catálogo de Artículos
- [x] Modelo y migración de Compatibilidad
- [ ] CRUD de Catálogo de Autos
  - [ ] Listado con búsqueda y filtros
  - [ ] Registro de nuevos autos (marca, modelo, años, motor)
  - [ ] Edición de autos existentes
  - [ ] Eliminación lógica de autos
  - [ ] Importación masiva desde CSV/Excel
- [ ] CRUD de Catálogo de Artículos
  - [ ] Listado con búsqueda y filtros
  - [ ] Registro de nuevos artículos (código, descripción, precio, categoría)
  - [ ] Edición de artículos existentes
  - [ ] Gestión de imágenes de artículos
  - [ ] Control de precios y costos
  - [ ] Eliminación lógica de artículos
- [ ] Gestión de Compatibilidad
  - [ ] Asignación de artículos compatibles por auto
  - [ ] Búsqueda de compatibilidad auto → artículos
  - [ ] Búsqueda de compatibilidad artículo → autos
  - [ ] Importación masiva de compatibilidades

### Fase 6: Inventario 📋 PENDIENTE
- [ ] Dashboard de inventario
- [ ] Vista de stock por sucursal
- [ ] Registro de entradas de inventario
- [ ] Registro de salidas de inventario
- [ ] Transferencias entre sucursales
- [ ] Ajustes de inventario
- [ ] Historial de movimientos
- [ ] Alertas de stock bajo
- [ ] Reportes de inventario
- [ ] Búsqueda de artículos por compatibilidad
- [ ] Control de números de serie/lote
- [ ] Testing de inventario

### Fase 7: Punto de Venta (POS) 📋 PENDIENTE
- [ ] Interfaz de punto de venta
- [ ] Búsqueda rápida de artículos
- [ ] Búsqueda por compatibilidad (marca/modelo/año)
- [ ] Carrito de compra
- [ ] Aplicación de descuentos
- [ ] Cálculo de impuestos
- [ ] Múltiples formas de pago
- [ ] Generación de tickets/facturas
- [ ] Registro de ventas en base de datos
- [ ] Actualización automática de inventario
- [ ] Ventas a crédito
- [ ] Historial de ventas
- [ ] Testing de POS

### Fase 8: Reportes y Análisis 📋 PENDIENTE
- [ ] Dashboard principal con métricas
- [ ] Reporte de ventas por período
- [ ] Reporte de ventas por sucursal
- [ ] Reporte de ventas por usuario
- [ ] Reporte de ventas por artículo
- [ ] Análisis de productos más vendidos
- [ ] Análisis de compatibilidades más buscadas
- [ ] Reporte de inventario valorizado
- [ ] Reporte de movimientos de inventario
- [ ] Reporte de rotación de productos
- [ ] Reporte de cobranza
- [ ] Exportación a Excel/PDF
- [ ] Gráficas y visualizaciones

### Fase 9: Módulos Avanzados 📋 PENDIENTE
- [ ] Sistema de cotizaciones
- [ ] Control de cuentas por cobrar
- [ ] Sistema de compras a proveedores
- [ ] Control de cuentas por pagar
- [ ] Gestión de garantías
- [ ] Sistema de devoluciones
- [ ] Integración con facturación electrónica (SAT)
- [ ] Aplicación móvil (PWA)
- [ ] API RESTful para integraciones
- [ ] Notificaciones en tiempo real

### Leyenda de Estado
- ✅ **COMPLETADA**: Funcionalidad implementada, probada y en producción
- 🚧 **EN DESARROLLO**: Actualmente en implementación
- 📋 **PENDIENTE**: Planificada para desarrollo futuro
- ⚠️ **EN REVISIÓN**: Requiere ajustes o correcciones
- 🔄 **EN PRUEBAS**: Implementada pero en fase de testing



## ✨ Características Principales

### 🔐 Autenticación y Seguridad
- **Autenticación personalizada** con usuario (no email)
- **Mensajes de error diferenciados**:
  - Usuario no existe
  - Contraseña incorrecta
  - Usuario inactivo
- **Autenticación de dos factores (2FA)** con Laravel Fortify
- **Rate limiting** para protección contra ataques de fuerza bruta
- **Confirmación de contraseña** para operaciones sensibles

### 👥 Gestión de Usuarios
- **Sistema de roles completo**:
  - **Administrador**: Acceso total al sistema
  - **Supervisor**: Gestión de usuarios (excepto administradores)
  - **Capturista**: Registro de datos y operaciones
  - **Vendedor**: Realización de ventas
- **CRUD completo de usuarios** con:
  - Registro de usuarios (solo admin/supervisor)
  - Lista de usuarios con búsqueda y paginación
  - Cambio de contraseñas
  - Activación/desactivación de cuentas
  - Eliminación de usuarios (solo admin)
- **Auditoría completa**: Registro de quién creó/modificó cada usuario y cuándo
- **Gestión de sucursales**: Asignación de sucursales principales y accesos múltiples

### 📊 Gestión de Inventario
- Catálogo de artículos (radiadores, termostatos, ventiladores, etc.)
- Catálogo de automóviles (marca, modelo, años, motor)
- Sistema de compatibilidad entre artículos y automóviles
- Control de stock por sucursal
- Historial de movimientos de inventario

### 💰 Sistema de Ventas
- Registro de ventas con detalles completos
- Múltiples formas de pago (efectivo, tarjeta, transferencia, cheque)
- Control de descuentos e impuestos
- Historial de ventas por usuario y sucursal

### 🎨 Interfaz de Usuario
- **Diseño moderno y responsive** con Tailwind CSS
- **Modo oscuro/claro** configurable
- **Componentes UI reutilizables** con shadcn/ui
- **Navegación intuitiva** con Inertia.js (SPA sin recargas)
- **Tipografía uniforme** y diseño consistente

## 🛠️ Tecnologías

### Backend
- **Laravel 12** - Framework PHP
- **Laravel Fortify** - Autenticación
- **Laravel Wayfinder** - Generación de rutas TypeScript
- **MySQL** - Base de datos

### Frontend
- **Vue 3** - Framework JavaScript
- **Inertia.js 2.0** - Adaptador SPA
- **TypeScript** - Tipado estático
- **Tailwind CSS 4** - Estilos
- **Vite 7** - Build tool
- **shadcn/ui** - Componentes UI

### Herramientas de Desarrollo
- **Laravel Pint** - Code style
- **ESLint** - Linter JavaScript/TypeScript
- **Prettier** - Formateo de código
- **PHPUnit** - Testing PHP
- **Laravel Sail** - Entorno Docker (opcional)

## 📦 Requisitos Previos

- **PHP** >= 8.2
- **Composer** >= 2.0
- **Node.js** >= 20.19 o 22.12+
- **MySQL** >= 8.0
- **Git**

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/petterpotten/Inventario-Radiadores-Nuevos.git
cd Inventario-Radiadores-Nuevos
```

### 2. Instalar dependencias de PHP

```bash
composer install
```

### 3. Instalar dependencias de Node.js

```bash
npm install
```

### 4. Configurar el archivo de entorno

```bash
cp .env.example .env
```

### 5. Generar la clave de aplicación

```bash
php artisan key:generate
```

### 6. Configurar la base de datos

Edita el archivo `.env` con tus credenciales de base de datos:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=radiadores_nuevos_db
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña
```

### 7. Ejecutar las migraciones y seeders

```bash
php artisan migrate --seed
```

Esto creará:
- 2 sucursales de ejemplo
- 1 usuario administrador:
  - **Usuario**: `admin`
  - **Contraseña**: `password`
  - **Email**: `admin@test.com`

### 8. Compilar los assets

```bash
npm run build
```

### 9. Iniciar el servidor de desarrollo

```bash
php artisan serve
```

Y en otra terminal:

```bash
npm run dev
```

## ⚙️ Configuración

### Configuración de Idioma

El sistema está configurado en español por defecto. Para cambiar el idioma, edita en `.env`:

```env
APP_LOCALE=es
APP_FAKER_LOCALE=es_MX
```

### Configuración de Autenticación

La autenticación está configurada para usar el campo `usuario` en lugar de `email`. Esto se configura en:

- `config/fortify.php`:
```php
'username' => 'usuario',
```

- `app/Providers/CustomAuthServiceProvider.php`: Lógica personalizada de autenticación

### Configuración de Sucursales

Para agregar más sucursales, edita `database/seeders/SucursalSeeder.php` y ejecuta:

```bash
php artisan db:seed --class=SucursalSeeder
```

## 📖 Uso

### Iniciar Sesión

1. Accede a `http://localhost:8000`
2. Usa las credenciales del administrador:
   - Usuario: `admin`
   - Contraseña: `password`

### Gestión de Usuarios

#### Como Administrador o Supervisor:

1. Ve a **Configuración** → **Lista de usuarios**
2. Aquí puedes:
   - Ver todos los usuarios con sus detalles
   - Buscar usuarios por nombre, usuario, email o rol
   - Cambiar contraseñas
   - Activar/desactivar usuarios
   - Eliminar usuarios (solo administrador)

#### Registrar Nuevo Usuario:

1. Ve a **Configuración** → **Registrar usuario**
2. Completa el formulario:
   - Sucursal principal
   - Usuario (único)
   - Nombre completo
   - Email
   - Contraseña
   - Rol
   - Acceso a todas las sucursales (opcional)

### Configuración de Perfil

Todos los usuarios pueden:
- Actualizar su información personal
- Cambiar su contraseña (vendedor/capturista)
- Configurar autenticación de dos factores
- Cambiar el tema (claro/oscuro)

## 📁 Estructura del Proyecto

```
radiadores-nuevos/
├── app/
│   ├── Actions/Fortify/          # Acciones de autenticación
│   ├── Http/
│   │   ├── Controllers/
│   │   │   └── Settings/         # Controladores de configuración
│   │   ├── Middleware/           # Middlewares personalizados
│   │   └── Requests/             # Form requests
│   ├── Models/                   # Modelos Eloquent
│   └── Providers/                # Service providers
├── database/
│   ├── factories/                # Factories para testing
│   ├── migrations/               # Migraciones de BD
│   └── seeders/                  # Seeders de datos
├── resources/
│   ├── css/                      # Estilos globales
│   ├── js/
│   │   ├── components/           # Componentes Vue
│   │   ├── composables/          # Composables Vue
│   │   ├── layouts/              # Layouts de página
│   │   ├── pages/                # Páginas de la aplicación
│   │   └── types/                # Tipos TypeScript
│   └── views/                    # Vistas Blade
├── routes/
│   ├── web.php                   # Rutas principales
│   └── settings.php              # Rutas de configuración
└── tests/                        # Tests automatizados
```

## 👤 Sistema de Usuarios

### Roles y Permisos

| Rol               | Gestión Usuarios   | Registro  | Cambiar Contraseñas  | Eliminar Usuarios | Acceso Sucursales |
|-------------------|--------------------|-----------|----------------------|-------------------|-------------------|
| **Administrador** | ✅ Todos          | ✅        | ✅ Todos            | ✅                | ✅ Todas          |
| **Supervisor**    | ✅ Excepto admins | ✅        | ✅ Excepto admins   | ❌                | ✅ Asignadas      |
| **Capturista**    | ❌                | ❌        | ✅ Propia           | ❌                | ✅ Asignadas      |
| **Vendedor**      | ❌                | ❌        | ✅ Propia           | ❌                | ✅ Asignadas      |


## 🗄️ Base de Datos

### Tablas Principales

1. **sucursal** - Sucursales de la empresa
2. **users** - Usuarios del sistema
3. **usuario_sucursal_acceso** - Accesos de usuarios a sucursales
4. **catalogo_autos** - Catálogo de vehículos
5. **catalogo_articulos** - Productos/artículos
6. **compatibilidad** - Compatibilidad artículos-autos
7. **inventario** - Stock por sucursal
8. **movimientos_inventario** - Historial de movimientos
9. **ventas** - Ventas maestro
10. **ventas_detalle** - Detalle de ventas
11. **ventas_cobro** - Formas de pago

### Diagrama de Relaciones

```
sucursal
    ├── users (sucursal_id)
    ├── usuario_sucursal_acceso
    ├── inventario
    ├── movimientos_inventario
    └── ventas

users
    ├── catalogo_autos (creado_usuario_id, modificado_usuario_id)
    ├── catalogo_articulos (creado_usuario_id, modificado_usuario_id)
    ├── compatibilidad (modificado_usuario_id)
    ├── inventario (usuario_modificacion_id)
    ├── movimientos_inventario (usuario_movimiento_id)
    └── ventas (user_id)

catalogo_autos
    ├── catalogo_articulos (catalogo_auto_principal_id)
    └── compatibilidad (catalogo_auto_id)

catalogo_articulos
    ├── compatibilidad (catalogo_articulo_id)
    ├── inventario (catalogo_articulo_id)
    ├── movimientos_inventario (catalogo_articulo_id)
    └── ventas_detalle (catalogo_articulo_id)

ventas
    ├── ventas_detalle (venta_id)
    └── ventas_cobro (venta_id)
```

## 🧪 Testing

### Ejecutar todos los tests

```bash
php artisan test
```

### Ejecutar tests específicos

```bash
# Tests de autenticación
php artisan test --filter=Auth

# Tests de gestión de usuarios
php artisan test --filter=Settings

# Test específico
php artisan test --filter=LoginTest
```

### Tests Incluidos

- ✅ Autenticación con usuario
- ✅ Validación de contraseñas
- ✅ Usuarios inactivos
- ✅ Autenticación de dos factores
- ✅ Gestión de perfil
- ✅ Cambio de contraseñas
- ✅ Rate limiting

## 🔧 Comandos Útiles

### Desarrollo

```bash
# Limpiar caché
php artisan optimize:clear

# Generar rutas TypeScript
php artisan wayfinder:generate

# Ver logs en tiempo real
php artisan pail

# Formatear código PHP
./vendor/bin/pint

# Formatear código JavaScript/Vue
npm run format

# Lint JavaScript/Vue
npm run lint
```

### Base de Datos

```bash
# Refrescar base de datos y seeders
php artisan migrate:fresh --seed

# Crear una nueva migración
php artisan make:migration nombre_de_migracion

# Crear un nuevo seeder
php artisan make:seeder NombreSeeder

# Ejecutar un seeder específico
php artisan db:seed --class=NombreSeeder
```

### Testing

```bash
# Tests con coverage
php artisan test --coverage

# Tests en paralelo
php artisan test --parallel

# Tests específicos
php artisan test --filter=NombreTest
```

## 📝 Scripts NPM

```bash
# Desarrollo con hot reload
npm run dev

# Build para producción
npm run build

# Build con SSR
npm run build:ssr

# Formatear código
npm run format

# Verificar formato
npm run format:check

# Lint y fix
npm run lint
```

## 🚀 Despliegue

### Preparar para Producción

1. **Compilar assets**:
```bash
npm run build
```

2. **Optimizar autoload**:
```bash
composer install --optimize-autoloader --no-dev
```

3. **Cachear configuración**:
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

4. **Configurar `.env`**:
```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com
```

### Variables de Entorno Importantes

```env
# Aplicación
APP_NAME="Radiadores Nuevos"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com

# Base de Datos
DB_CONNECTION=mysql
DB_HOST=tu-host
DB_PORT=3306
DB_DATABASE=tu_bd
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña

# Seguridad
SESSION_DRIVER=database
SESSION_LIFETIME=120
BCRYPT_ROUNDS=12

# Cache
CACHE_STORE=database
```

## 🔒 Proyecto Privado

Este es un proyecto privado desarrollado para **Radiadores Nuevos**. El código fuente y la documentación son confidenciales y de uso exclusivo de la empresa.

## 👨‍💻 Desarrollador

**By: [petterpotten](https://github.com/petterpotten)**

- 💼 Proyecto: Sistema de Gestión de Inventario - Radiadores Nuevos
- 📦 Repositorio: [Inventario-Radiadores-Nuevos](https://github.com/petterpotten/Inventario-Radiadores-Nuevos)
- 🚧 Branch principal y de desarrollo: `develop`
- 🌿 Branch de produción: `production`

## 📄 Licencia

Este proyecto es **privado y propietario**. Todos los derechos reservados.

**Radiadores Nuevos** © 2025

El código, documentación y todos los archivos relacionados con este proyecto son propiedad exclusiva de Radiadores Nuevos. Está prohibida su reproducción, distribución, modificación o uso sin autorización expresa por escrito del propietario.

## 📞 Contacto y Soporte

Para consultas técnicas, soporte o información sobre el proyecto:

- 📧 **Email**: Contactar al administrador del sistema
- 👤 **Desarrollador**: [@petterpotten](https://github.com/petterpotten)
- 🏢 **Empresa**: Radiadores Nuevos

## 📊 Información del Repositorio

```bash
# Repositorio
https://github.com/petterpotten/Inventario-Radiadores-Nuevos

# Clonar (requiere permisos)
git clone https://github.com/petterpotten/Inventario-Radiadores-Nuevos.git

# Branches
production  - Producción (estable)
develop     - Desarrollo (activa)
```

---

<div align="center">

**Sistema de Gestión de Inventario - Radiadores Nuevos**

Desarrollado con ❤️ por [petterpotten](https://github.com/petterpotten)

Laravel 12 • Vue 3 • TypeScript • Inertia.js • Tailwind CSS

📅 Última actualización: Noviembre 2025

</div>
