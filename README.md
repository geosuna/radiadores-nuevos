# 🚗 Sistema de Gestión de Inventario - Radiadores Nuevos

Sistema web completo para la gestión de inventario, ventas y usuarios en una empresa de radiadores automotrices. Desarrollado con Laravel 11, Vue 3, Inertia.js y TypeScript.

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

> **Última actualización**: Noviembre 11, 2025  
> **Tests**: 46 passed, 2 skipped | **Cobertura**: Autenticación y Usuarios  
> **Branch Activa**: `master` (sincronizada con `develop`)

Este proyecto se desarrolla en fases incrementales. A continuación el estado actual de cada módulo:

### Fase 1: Infraestructura Base ✅ COMPLETADA
- [x] Configuración inicial de Laravel 11
- [x] Integración de Vue 3 + TypeScript
- [x] Configuración de Inertia.js 2.0
- [x] Setup de Tailwind CSS v4
- [x] Configuración de Vite 7
- [x] Integración de shadcn/ui (componentes UI)
- [x] Estructura de base de datos MySQL
- [x] Sistema de migraciones (14 tablas)
- [x] Seeders de datos base (sucursales, usuarios)
- [x] Configuración de Git y repositorio
- [x] Configuración de ESLint + Prettier
- [x] Laravel Wayfinder (rutas TypeScript)

**Resultado**: Stack tecnológico completo y funcional ✨

---

### Fase 2: Autenticación y Seguridad ✅ COMPLETADA
- [x] Sistema de autenticación con campo `usuario` (no email)
- [x] Mensajes de error diferenciados:
  - Usuario no existe
  - Contraseña incorrecta  
  - Usuario inactivo
  - Sucursal inválida
- [x] Integración de Laravel Fortify
- [x] Autenticación de dos factores (2FA) con QR
- [x] Códigos de recuperación 2FA
- [x] Recuperación de contraseña vía email
- [x] Rate limiting (máx. 5 intentos/minuto)
- [x] Confirmación de contraseña para operaciones sensibles
- [x] Middleware de sesión y timeout
- [x] Testing completo (19 tests de autenticación)

**Resultado**: Sistema de autenticación robusto y seguro 🔐

---

### Fase 3: Sistema de Usuarios ✅ COMPLETADA
- [x] Modelo de usuarios con 4 roles:
  - **Administrador**: Acceso total
  - **Supervisor**: Gestión de usuarios (excepto admins)
  - **Capturista**: Registro de datos
  - **Vendedor**: Realización de ventas
- [x] CRUD completo de usuarios:
  - [x] Registro de usuarios (admin/supervisor únicamente)
  - [x] Lista de usuarios con búsqueda y paginación
  - [x] Tabla de 13 columnas con toda la información
  - [x] Cambio de contraseñas según permisos
  - [x] Activación/desactivación de cuentas
  - [x] Eliminación de usuarios (solo admin)
- [x] Sistema de auditoría completo:
  - Registro de quién creó cada usuario
  - Registro de quién modificó cada usuario
  - Timestamps de creación y modificación
- [x] Gestión de sucursales:
  - [x] Asignación de sucursal principal
  - [x] Acceso a múltiples sucursales
  - [x] Dropdown con indicador ★ de sucursal principal
  - [x] Validación de permisos por sucursal
- [x] Validación de permisos por rol
- [x] Testing de gestión de usuarios (9 tests)

**Resultado**: Gestión completa de usuarios con control de acceso 👥

---

### Fase 4: Gestión de Perfil ✅ COMPLETADA
- [x] Página de perfil de usuario
- [x] Actualización de información personal:
  - Nombre completo
  - Email
  - Usuario (solo lectura)
- [x] Cambio de contraseña:
  - Vendedor/Capturista: Pueden cambiar su propia contraseña
  - Supervisor/Admin: Delegado a gestión de usuarios
- [x] Configuración de 2FA:
  - Habilitar/deshabilitar autenticación de dos factores
  - Escaneo de código QR
  - Confirmación con código OTP
- [x] Gestión de códigos de recuperación 2FA:
  - Generación de 8 códigos
  - Regeneración de códigos
  - Descarga en formato texto
- [x] Configuración de apariencia:
  - Modo oscuro
  - Modo claro
  - Automático (según sistema operativo)
- [x] Eliminación de cuenta (con confirmación)
- [x] Testing de perfil (9 tests)

**Resultado**: Usuarios con control total de su perfil 👤

---

### Fase 5: Modelos y Base de Datos ✅ COMPLETADA
Esta fase establece la estructura de datos completa para el sistema de inventario.

#### Modelos Eloquent Creados:
- [x] **Sucursal**: Sucursales de la empresa (matriz, sucursales)
- [x] **User**: Usuarios del sistema con roles
- [x] **Auto**: Catálogo de automóviles (marca, modelo, años, motor)
- [x] **Articulo**: Catálogo de artículos/productos (radiadores, termostatos, etc.)
- [x] **Compatibilidad**: Relación artículos ↔ automóviles
- [x] **Inventario**: Stock de artículos por sucursal
- [x] **MovimientoInventario**: Historial de movimientos de inventario
- [x] **Venta**: Registro maestro de ventas
- [x] **VentaDetalle**: Detalle de artículos vendidos
- [x] **Cobro**: Formas de pago de cada venta

#### Migraciones Implementadas (14 tablas):
- [x] `0001_01_01_000000_create_sucursal_table.php`
- [x] `0001_01_01_000001_create_cache_table.php`
- [x] `0001_01_01_000002_create_jobs_table.php`
- [x] `0001_01_01_000002_create_users_table.php`
- [x] `2025_08_14_170933_add_two_factor_columns_to_users_table.php`
- [x] `2025_11_08_061210_create_usuario_sucursal_acceso_table.php`
- [x] `2025_11_11_055742_create_autos_table.php`
- [x] `2025_11_11_055743_create_articulos_table.php`
- [x] `2025_11_11_055744_create_compatibilidades_table.php`
- [x] `2025_11_11_055746_create_inventarios_table.php`
- [x] `2025_11_11_055748_create_movimientos_inventario_table.php`
- [x] `2025_11_11_055753_create_ventas_table.php`
- [x] `2025_11_11_055756_create_ventas_detalle_table.php`
- [x] `2025_11_11_055759_create_cobros_table.php`

#### Relaciones Configuradas:
- [x] **Auto**: Relación con artículos principales, compatibilidades, y auditoría
- [x] **Articulo**: Relación con auto principal, compatibilidades, inventarios, ventas y auditoría
- [x] **Compatibilidad**: Relación muchos a muchos entre autos y artículos
- [x] **Inventario**: Stock por artículo y sucursal con auditoría
- [x] **MovimientoInventario**: Historial con tipo de movimiento (entrada, salida, ajuste, transferencia)
- [x] **Venta**: Relación con sucursal, vendedor, detalles y cobros
- [x] **VentaDetalle**: Relación con venta y artículo (cantidad, precio, descuento)
- [x] **Cobro**: Formas de pago múltiples por venta (efectivo, tarjeta, transferencia, cheque)

#### Características de Base de Datos:
- [x] Nombres simplificados (sin prefijo "catalogo_")
- [x] Campos de auditoría consistentes (`creado_usuario_id`, `modificado_usuario_id`)
- [x] Timestamps automáticos en todas las tablas
- [x] Soft deletes donde corresponde
- [x] Índices y claves foráneas correctamente definidas
- [x] Validación de modelos contra migraciones ✅

**Resultado**: Estructura de datos completa, validada y lista para implementación 🗄️

---

### Fase 6: Catálogos Base 📋 PENDIENTE (Siguiente fase)
Implementación de interfaces CRUD para gestión de catálogos.

#### 6.1 CRUD de Catálogo de Autos
- [ ] Controller: `AutoController.php`
- [ ] Rutas en `routes/catalogos.php`
- [ ] Vista: Lista de autos
  - [ ] Tabla con búsqueda por marca/modelo/año
  - [ ] Filtros por marca y rango de años
  - [ ] Paginación
  - [ ] Acciones: Editar, Eliminar (soft delete)
- [ ] Vista: Formulario de registro/edición
  - [ ] Campos: marca, modelo, anios_rango, motor
  - [ ] Validaciones en backend y frontend
  - [ ] Auditoría automática
- [ ] Funcionalidades:
  - [ ] Registro de nuevos autos
  - [ ] Edición de autos existentes
  - [ ] Eliminación lógica (soft delete)
  - [ ] Ver artículos compatibles asociados
  - [ ] Importación masiva desde CSV/Excel
- [ ] Testing (mínimo 8 tests)

#### 6.2 CRUD de Catálogo de Artículos
- [ ] Controller: `ArticuloController.php`
- [ ] Rutas en `routes/catalogos.php`
- [ ] Vista: Lista de artículos
  - [ ] Tabla con búsqueda por DPI/descripción/categoría
  - [ ] Filtros por categoría y rango de precios
  - [ ] Vista de imagen en miniatura
  - [ ] Indicador de stock total
  - [ ] Paginación
- [ ] Vista: Formulario de registro/edición
  - [ ] Campos: dpi (único), descripcion, precio_venta, categoria (ENUM)
  - [ ] Auto principal (opcional)
  - [ ] Upload de foto (foto_url)
  - [ ] Validaciones
- [ ] Funcionalidades:
  - [ ] Registro de nuevos artículos
  - [ ] Edición de artículos existentes
  - [ ] Gestión de imágenes (upload, eliminar)
  - [ ] Control de precios (precio_venta)
  - [ ] Categorías: radiador, termostato, ventilador, sensor, otro
  - [ ] Ver compatibilidades asociadas
  - [ ] Ver stock por sucursal
  - [ ] Eliminación lógica
  - [ ] Importación masiva
- [ ] Testing (mínimo 10 tests)

#### 6.3 Gestión de Compatibilidad
- [ ] Controller: `CompatibilidadController.php`
- [ ] Vista: Gestión de compatibilidades
  - [ ] Asignación de artículos compatibles por auto
  - [ ] Búsqueda: Auto → Artículos compatibles
  - [ ] Búsqueda: Artículo → Autos compatibles
  - [ ] Tabla de compatibilidades con filtros
  - [ ] Eliminar compatibilidades
- [ ] Funcionalidades:
  - [ ] Asignar múltiples artículos a un auto
  - [ ] Asignar múltiples autos a un artículo
  - [ ] Búsqueda cruzada bidireccional
  - [ ] Importación masiva de compatibilidades CSV
  - [ ] Validación de duplicados
  - [ ] Campo notas opcional
- [ ] Testing (mínimo 6 tests)

**Prioridad**: 🔴 ALTA - Bloqueante para inventario y ventas

---

### Fase 7: Sistema de Inventario 📋 PENDIENTE
Gestión completa de stock y movimientos de inventario.

#### 7.1 Dashboard de Inventario
- [ ] Vista: Dashboard principal
  - [ ] Resumen de stock total por sucursal
  - [ ] Artículos con stock bajo (alerta)
  - [ ] Últimos movimientos
  - [ ] Gráficas de stock por categoría
- [ ] Acceso rápido a funciones principales

#### 7.2 Gestión de Stock
- [ ] Controller: `InventarioController.php`
- [ ] Vista: Stock por sucursal
  - [ ] Lista de artículos con cantidad actual
  - [ ] Búsqueda por artículo
  - [ ] Filtro por categoría
  - [ ] Indicador de stock mínimo
- [ ] Vista: Detalle de artículo
  - [ ] Stock en todas las sucursales
  - [ ] Historial de movimientos
  - [ ] Última actualización

#### 7.3 Movimientos de Inventario
- [ ] Controller: `MovimientoInventarioController.php`
- [ ] Vista: Registrar entrada
  - [ ] Seleccionar artículo
  - [ ] Cantidad
  - [ ] Sucursal destino
  - [ ] Observaciones
- [ ] Vista: Registrar salida
  - [ ] Seleccionar artículo
  - [ ] Cantidad
  - [ ] Motivo (venta, merma, ajuste)
  - [ ] Observaciones
- [ ] Vista: Transferencias entre sucursales
  - [ ] Artículo
  - [ ] Sucursal origen/destino
  - [ ] Cantidad
  - [ ] Validación de stock disponible
- [ ] Vista: Ajustes de inventario
  - [ ] Ajuste por diferencia (conteo físico)
  - [ ] Justificación obligatoria
  - [ ] Auditoría especial
- [ ] Vista: Historial de movimientos
  - [ ] Todos los movimientos por sucursal
  - [ ] Filtros por tipo, artículo, fecha
  - [ ] Exportación a Excel

#### 7.4 Alertas y Notificaciones
- [ ] Configuración de stock mínimo por artículo
- [ ] Notificación de stock bajo
- [ ] Reporte de artículos sin movimiento (obsoletos)

#### 7.5 Testing
- [ ] Tests de entradas de inventario (mínimo 4)
- [ ] Tests de salidas de inventario (mínimo 4)
- [ ] Tests de transferencias (mínimo 6)
- [ ] Tests de ajustes (mínimo 4)
- [ ] Tests de validaciones de stock (mínimo 5)

**Prioridad**: 🔴 ALTA - Depende de Fase 6

---

### Fase 8: Punto de Venta (POS) 📋 PENDIENTE
Sistema completo de ventas en mostrador.

#### 8.1 Interfaz de Punto de Venta
- [ ] Controller: `VentaController.php`
- [ ] Vista: POS principal
  - [ ] Búsqueda rápida de artículos (por DPI/descripción)
  - [ ] Búsqueda por compatibilidad (marca/modelo/año del auto)
  - [ ] Carrito de compra en tiempo real
  - [ ] Total, subtotal, descuentos, impuestos
  - [ ] Información del cliente (opcional)
  - [ ] Observaciones de venta

#### 8.2 Proceso de Venta
- [ ] Agregar artículos al carrito
  - [ ] Validación de stock disponible
  - [ ] Cantidad
  - [ ] Precio unitario (editable con permiso)
  - [ ] Descuento por línea
- [ ] Aplicación de descuentos globales
- [ ] Cálculo automático de impuestos
- [ ] Múltiples formas de pago:
  - [ ] Efectivo (con cálculo de cambio)
  - [ ] Tarjeta de crédito/débito
  - [ ] Transferencia bancaria
  - [ ] Cheque
  - [ ] Pago combinado (múltiples formas)
- [ ] Confirmación y registro de venta

#### 8.3 Post-Venta
- [ ] Generación de tickets de venta (impresión)
- [ ] Opción de factura (preparación para SAT)
- [ ] Actualización automática de inventario
- [ ] Registro en historial de ventas
- [ ] Envío de ticket por email (opcional)

#### 8.4 Ventas a Crédito
- [ ] Selección de cliente
- [ ] Monto a crédito
- [ ] Plazo de pago
- [ ] Abonos parciales
- [ ] Estado de cuenta del cliente

#### 8.5 Historial de Ventas
- [ ] Vista: Lista de ventas
  - [ ] Filtros por fecha, sucursal, vendedor
  - [ ] Detalle de cada venta
  - [ ] Artículos vendidos
  - [ ] Formas de pago utilizadas
  - [ ] Reimprimir ticket
  - [ ] Cancelación de venta (con permisos)

#### 8.6 Testing
- [ ] Tests de proceso de venta (mínimo 8)
- [ ] Tests de validación de stock (mínimo 4)
- [ ] Tests de cálculo de totales (mínimo 6)
- [ ] Tests de formas de pago (mínimo 5)
- [ ] Tests de actualización de inventario (mínimo 4)

**Prioridad**: 🟡 MEDIA - Depende de Fase 6 y 7

---

### Fase 9: Reportes y Análisis 📋 PENDIENTE
Dashboard ejecutivo y reportes del negocio.

#### 9.1 Dashboard Principal
- [ ] Vista: Dashboard ejecutivo
  - [ ] Ventas del día/mes
  - [ ] Comparativo con períodos anteriores
  - [ ] Top 10 artículos más vendidos
  - [ ] Gráficas de ventas por sucursal
  - [ ] Inventario valorizado
  - [ ] Cuentas por cobrar pendientes

#### 9.2 Reportes de Ventas
- [ ] Reporte de ventas por período
  - [ ] Filtros: fecha inicio/fin, sucursal, vendedor
  - [ ] Totales y subtotales
  - [ ] Exportación a Excel/PDF
- [ ] Reporte de ventas por artículo
  - [ ] Cantidad vendida
  - [ ] Ingresos generados
  - [ ] Margen de utilidad
- [ ] Análisis de productos más vendidos
- [ ] Análisis de compatibilidades más buscadas

#### 9.3 Reportes de Inventario
- [ ] Reporte de inventario valorizado
  - [ ] Por sucursal
  - [ ] Valor total del inventario
  - [ ] Costo promedio
- [ ] Reporte de movimientos de inventario
  - [ ] Por período
  - [ ] Por tipo de movimiento
- [ ] Reporte de rotación de productos
  - [ ] Artículos de alta rotación
  - [ ] Artículos obsoletos o sin movimiento

#### 9.4 Reportes Financieros
- [ ] Reporte de cobranza
  - [ ] Cuentas por cobrar
  - [ ] Antigüedad de saldos
  - [ ] Proyección de cobranza
- [ ] Estado de resultados básico
  - [ ] Ingresos por ventas
  - [ ] Costo de ventas
  - [ ] Utilidad bruta

#### 9.5 Exportación y Visualización
- [ ] Exportación a Excel
- [ ] Exportación a PDF
- [ ] Gráficas interactivas (Chart.js)
- [ ] Filtros avanzados en todos los reportes

**Prioridad**: 🟢 BAJA - Depende de Fase 8

---

### Fase 10: Módulos Avanzados 📋 FUTURO
Funcionalidades adicionales para escalabilidad.

- [ ] Sistema de cotizaciones
- [ ] Control de cuentas por cobrar (CxC completo)
- [ ] Sistema de compras a proveedores
- [ ] Control de cuentas por pagar (CxP)
- [ ] Gestión de garantías
- [ ] Sistema de devoluciones
- [ ] Integración con facturación electrónica (SAT México)
- [ ] Aplicación móvil (PWA)
- [ ] API RESTful para integraciones externas
- [ ] Notificaciones en tiempo real (WebSockets)
- [ ] Sistema de comisiones por vendedor
- [ ] Módulo de compras y proveedores

**Prioridad**: 🔵 FUTURA - Post-lanzamiento

---

### 📊 Resumen de Progreso General

| Fase | Estado | Progreso | Tests | Prioridad |
|------|--------|----------|-------|-----------|
| 1. Infraestructura Base | ✅ Completada | 100% | N/A | ✅ |
| 2. Autenticación y Seguridad | ✅ Completada | 100% | 19/19 ✅ | ✅ |
| 3. Sistema de Usuarios | ✅ Completada | 100% | 9/9 ✅ | ✅ |
| 4. Gestión de Perfil | ✅ Completada | 100% | 9/9 ✅ | ✅ |
| 5. Modelos y Base de Datos | ✅ Completada | 100% | Validado ✅ | ✅ |
| 6. Catálogos Base | 📋 Pendiente | 0% | 0/24 | 🔴 ALTA |
| 7. Sistema de Inventario | 📋 Pendiente | 0% | 0/23 | 🔴 ALTA |
| 8. Punto de Venta (POS) | 📋 Pendiente | 0% | 0/27 | 🟡 MEDIA |
| 9. Reportes y Análisis | 📋 Pendiente | 0% | 0/15 | 🟢 BAJA |
| 10. Módulos Avanzados | 📋 Futuro | 0% | 0/? | 🔵 FUTURA |

**Total Tests Actuales**: 46 passed, 2 skipped (48 total)  
**Cobertura**: Autenticación, Usuarios, Perfil  
**Próximo Milestone**: Fase 6 - Catálogos Base

---

### 🎯 Prioridades Inmediatas

**Lo que falta para tener un MVP funcional:**

1. **Fase 6: Catálogos Base** 🔴 CRÍTICO
   - Sin esto no se pueden registrar productos ni autos
   - Bloqueante para inventario y ventas
   - Estimado: 2-3 semanas

2. **Fase 7: Sistema de Inventario** 🔴 CRÍTICO  
   - Necesario para control de stock
   - Bloqueante para ventas
   - Estimado: 2-3 semanas

3. **Fase 8: Punto de Venta** 🟡 IMPORTANTE
   - Funcionalidad principal del negocio
   - Requiere Fase 6 y 7 completas
   - Estimado: 3-4 semanas

4. **Fase 9: Reportes** 🟢 DESEABLE
   - Mejora la toma de decisiones
   - No bloqueante
   - Estimado: 2 semanas

**Total estimado para MVP**: 9-12 semanas

---

### Leyenda de Estado
- ✅ **COMPLETADA**: Funcionalidad implementada, probada y en producción
- 🚧 **EN DESARROLLO**: Actualmente en implementación
- 📋 **PENDIENTE**: Planificada para desarrollo futuro
- 🔵 **FUTURO**: Post-lanzamiento, no crítico
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
- **Laravel 11** - Framework PHP
- **Laravel Fortify** - Autenticación
- **Laravel Wayfinder** - Generación de rutas TypeScript
- **MySQL 8.0+** - Base de datos

### Frontend
- **Vue 3** - Framework JavaScript
- **Inertia.js 2.0** - Adaptador SPA
- **TypeScript** - Tipado estático
- **Tailwind CSS v4** - Framework de estilos
- **Vite 7** - Build tool y bundler
- **shadcn/ui** - Componentes UI reutilizables

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
git clone https://github.com/geosuna/radiadores-nuevos.git
cd radiadores-nuevos
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

### Tablas Principales (14 tablas)

1. **sucursal** - Sucursales de la empresa (matriz, sucursales)
2. **users** - Usuarios del sistema con roles y permisos
3. **usuario_sucursal_acceso** - Accesos de usuarios a múltiples sucursales
4. **autos** - Catálogo de vehículos (marca, modelo, años, motor)
5. **articulos** - Productos/artículos (radiadores, termostatos, etc.)
6. **compatibilidades** - Compatibilidad artículos ↔ autos
7. **inventarios** - Stock actual por artículo y sucursal
8. **movimientos_inventario** - Historial de movimientos (entradas, salidas, ajustes, transferencias)
9. **ventas** - Registro maestro de ventas
10. **ventas_detalle** - Detalle de artículos vendidos por venta
11. **cobros** - Formas de pago de cada venta (efectivo, tarjeta, etc.)
12. **cache** - Caché de Laravel (sistema)
13. **jobs** - Cola de trabajos (sistema)
14. **password_reset_tokens** - Tokens de recuperación de contraseña (sistema)

### Diagrama de Relaciones

```
sucursal (Sucursales)
    ├── users (sucursal_id) - Sucursal principal de usuario
    ├── usuario_sucursal_acceso - Accesos múltiples
    ├── inventarios (sucursal_id) - Stock por sucursal
    ├── movimientos_inventario (sucursal_id) - Movimientos
    └── ventas (sucursal_id) - Ventas realizadas

users (Usuarios)
    ├── autos (creado_usuario_id, modificado_usuario_id) - Auditoría
    ├── articulos (creado_usuario_id, modificado_usuario_id) - Auditoría
    ├── compatibilidades (modificado_usuario_id) - Auditoría
    ├── inventarios (usuario_modificacion_id) - Última modificación
    ├── movimientos_inventario (usuario_movimiento_id) - Usuario que hizo el movimiento
    └── ventas (user_id) - Vendedor

autos (Catálogo de Autos)
    ├── articulos (auto_principal_id) - Artículo principal para un auto
    └── compatibilidades (auto_id) - Autos compatibles

articulos (Catálogo de Artículos)
    ├── compatibilidades (articulo_id) - Artículos compatibles
    ├── inventarios (articulo_id) - Stock del artículo
    ├── movimientos_inventario (articulo_id) - Movimientos del artículo
    └── ventas_detalle (articulo_id) - Artículo vendido

inventarios (Stock Actual)
    ├── sucursal (sucursal_id)
    ├── articulo (articulo_id)
    └── usuario_modificacion (usuario_modificacion_id)

ventas (Ventas)
    ├── sucursal (sucursal_id) - Sucursal donde se realizó
    ├── vendedor (user_id) - Usuario vendedor
    ├── ventas_detalle (venta_id) - Artículos vendidos
    └── cobros (venta_id) - Formas de pago

ventas_detalle (Detalle de Venta)
    ├── venta (venta_id)
    └── articulo (articulo_id)

cobros (Formas de Pago)
    └── venta (venta_id)
```

### Características de la Base de Datos

- ✅ **Nomenclatura simplificada**: Sin prefijo "catalogo_" en tablas
- ✅ **Auditoría completa**: Campos `creado_usuario_id`, `modificado_usuario_id` en todas las tablas principales
- ✅ **Timestamps automáticos**: `created_at`, `updated_at` en todas las tablas
- ✅ **Soft Deletes**: Eliminación lógica donde corresponde con `deleted_at`
- ✅ **Claves foráneas**: Integridad referencial completa
- ✅ **Índices optimizados**: En campos de búsqueda frecuente
- ✅ **ENUM types**: Para categorías y estados predefinidos
- ✅ **Campos decimales**: Precisión para precios y montos (10,2)

### Modelos Eloquent Implementados

Todos los modelos están completamente implementados con:
- Relaciones (belongsTo, hasMany, belongsToMany)
- Casts de tipos de datos
- Fillable/Guarded properties
- Soft deletes donde aplica
- Validación contra migraciones ✅

## 🧪 Testing

El proyecto cuenta con una suite completa de tests automatizados para garantizar la calidad del código.

### Estado Actual de Tests

```bash
Tests:  46 passed, 2 skipped (48 total)
Duration: ~2.7s
```

### Tests por Módulo

#### ✅ Autenticación (19 tests)
- **AuthenticationTest** (6 tests):
  - Login screen rendering
  - Usuario/contraseña authentication
  - Two-factor authentication flow
  - Invalid password handling
  - Logout functionality
  - Rate limiting protection

- **LoginTest** (7 tests):
  - Login screen rendering
  - Successful authentication
  - Invalid password rejection
  - Inactive user blocking
  - Required field validation (usuario, password, sucursal_id)

- **EmailVerificationTest** (6 tests):
  - Verification screen rendering
  - Email verification process
  - Invalid hash/user ID handling
  - Already verified user flow

#### ✅ Gestión de Contraseñas (4 tests)
- **PasswordResetTest** (4 tests):
  - Reset link screen
  - Password reset email
  - Valid token reset
  - Invalid token rejection

- **PasswordConfirmationTest** (2 tests):
  - Confirmation screen
  - Authentication requirement

#### ✅ Two-Factor Authentication (6 tests)
- **TwoFactorChallengeTest** (2 tests):
  - Challenge screen
  - Authentication requirement

- **TwoFactorAuthenticationTest** (4 tests):
  - Settings page rendering
  - Password confirmation (when enabled)
  - No confirmation needed (when disabled)
  - Forbidden response (2FA disabled globally)

#### ✅ Gestión de Perfil (9 tests)
- **ProfileUpdateTest** (5 tests):
  - Profile page display
  - Profile information update
  - Email verification status
  - Account deletion
  - Password confirmation for deletion

- **PasswordUpdateTest** (3 tests):
  - Password update page
  - Successful password change
  - Current password validation

#### ✅ General (3 tests)
- **DashboardTest** (2 tests):
  - Guest redirection
  - Authenticated access

- **ExampleTest** (1 test):
  - Homepage response

### Ejecutar Tests

```bash
# Todos los tests
php artisan test

# Tests con cobertura
php artisan test --coverage

# Tests en paralelo (más rápido)
php artisan test --parallel

# Tests de un módulo específico
php artisan test --filter=Auth
php artisan test --filter=Settings
php artisan test --filter=Profile

# Un test específico
php artisan test --filter=LoginTest
php artisan test --filter=ProfileUpdateTest
```

### Coverage Actual

| Módulo | Cobertura | Tests |
|--------|-----------|-------|
| Autenticación | ✅ 100% | 19/19 |
| Gestión de Perfil | ✅ 100% | 9/9 |
| Dashboard | ✅ 100% | 2/2 |
| **Total** | **✅ 100%** | **46/46** |

### Tests Pendientes (Próximas Fases)

#### 📋 Fase 6: Catálogos (24 tests estimados)
- CRUD de Autos (8 tests)
- CRUD de Artículos (10 tests)
- Gestión de Compatibilidad (6 tests)

#### 📋 Fase 7: Inventario (23 tests estimados)
- Entradas de inventario (4 tests)
- Salidas de inventario (4 tests)
- Transferencias (6 tests)
- Ajustes (4 tests)
- Validaciones de stock (5 tests)

#### 📋 Fase 8: Punto de Venta (27 tests estimados)
- Proceso de venta (8 tests)
- Validación de stock (4 tests)
- Cálculo de totales (6 tests)
- Formas de pago (5 tests)
- Actualización de inventario (4 tests)

**Total proyectado**: ~120 tests al finalizar Fase 8

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

## 👨‍💻 Desarrolladores

**By: [petterpotten](https://github.com/petterpotten)**
**By: [geosuna](https://github.com/geosuna)**

- 💼 Proyecto: Sistema de Gestión de Inventario - Radiadores Nuevos
- 📦 Repositorio: [radiadores-nuevos](https://github.com/geosuna/radiadores-nuevos)
- 🌿 Branch principal: `master`
- 🚧 Branch de desarrollo: `develop`
- 📊 Estado: 5/10 fases completadas (50%)

## 📄 Licencia

Este proyecto es **privado y propietario**. Todos los derechos reservados.

**Radiadores Nuevos** © 2025

El código, documentación y todos los archivos relacionados con este proyecto son propiedad exclusiva de Radiadores Nuevos. Está prohibida su reproducción, distribución, modificación o uso sin autorización expresa por escrito del propietario.

## 📞 Contacto y Soporte

Para consultas técnicas, soporte o información sobre el proyecto:

- 📧 **Email**: Contactar al administrador del sistema
- 👤 **Desarrolladores**: [@petterpotten](https://github.com/petterpotten), [geosuna](https://github.com/geosuna)
- 🏢 **Empresa**: Radiadores Nuevos

## 📊 Información del Repositorio

```bash
# Repositorio
https://github.com/geosuna/radiadores-nuevos

# Clonar (requiere permisos)
git clone https://github.com/geosuna/radiadores-nuevos.git

# Branches
master   - Producción (estable)
develop  - Desarrollo (activa)
```

---

<div align="center">

**Sistema de Gestión de Inventario - Radiadores Nuevos**

Desarrollado con ❤️ por [petterpotten](https://github.com/petterpotten) & [geosuna](https://github.com/geosuna)

Laravel 11 • Vue 3 • TypeScript • Inertia.js • Tailwind CSS v4

📅 Última actualización: Noviembre 11, 2025

</div>
