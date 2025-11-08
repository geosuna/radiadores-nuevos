-- ============================================================================
-- SISTEMA DE GESTIÓN DE RADIADORES - MySQL Workbench
-- Compatible con Laravel 11
-- Base de datos: radiadores_nuevos_db
-- Generado: 2025-11-07
-- ============================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- ============================================================================
-- CREAR BASE DE DATOS (Descomentar si es necesario)
-- ============================================================================
-- DROP DATABASE IF EXISTS `radiadores_nuevos_db`;
-- CREATE DATABASE `radiadores_nuevos_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE `radiadores_nuevos_db`;

-- ============================================================================
-- TABLA: sucursal
-- Descripción: Almacena las sucursales de la empresa
-- Orden: 1 (Base - sin dependencias)
-- ============================================================================
DROP TABLE IF EXISTS `sucursal`;
CREATE TABLE `sucursal` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único de la sucursal',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre de la sucursal',
  `direccion` VARCHAR(200) DEFAULT NULL COMMENT 'Dirección física de la sucursal',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_sucursal_estatus` (`estatus`),
  INDEX `idx_sucursal_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Catálogo de sucursales';

-- ============================================================================
-- TABLA: users
-- Descripción: Usuarios del sistema con autenticación Laravel
-- Orden: 2 (Depende de: sucursal)
-- Nota: Esta tabla reemplaza a 'usuario' para compatibilidad con Laravel
-- ============================================================================
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del usuario',
  `sucursal_id` BIGINT UNSIGNED NOT NULL COMMENT 'Sucursal asignada al usuario',
  `usuario` VARCHAR(50) NOT NULL COMMENT 'Nombre de usuario para login',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre completo del usuario',
  `email` VARCHAR(100) UNIQUE DEFAULT NULL COMMENT 'Correo electrónico único',
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha verificación email (Laravel)',
  `password` VARCHAR(255) NOT NULL COMMENT 'Contraseña hasheada (bcrypt)',
  `rol` ENUM('administrador','supervisor','capturista','vendedor') NOT NULL DEFAULT 'vendedor' COMMENT 'Rol del usuario en el sistema',
  `acceso_todas_sucursales` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1=Acceso a todas, 0=Solo su sucursal',
  `creado_usuario_id` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Usuario que lo creó',
  `modificado_usuario_id` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Último usuario que lo modificó',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `remember_token` VARCHAR(100) DEFAULT NULL COMMENT 'Token "Recordarme" (Laravel)',
  `two_factor_secret` TEXT DEFAULT NULL COMMENT 'Secret para 2FA (Laravel Fortify)',
  `two_factor_recovery_codes` TEXT DEFAULT NULL COMMENT 'Códigos recuperación 2FA',
  `two_factor_confirmed_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha confirmación 2FA',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_usuario_unique` (`usuario`),
  UNIQUE KEY `users_email_unique` (`email`),
  INDEX `idx_users_sucursal` (`sucursal_id`),
  INDEX `idx_users_rol` (`rol`),
  INDEX `idx_users_estatus` (`estatus`),
  CONSTRAINT `fk_users_sucursal` 
    FOREIGN KEY (`sucursal_id`) 
    REFERENCES `sucursal` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_creador` 
    FOREIGN KEY (`creado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_modificador` 
    FOREIGN KEY (`modificado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Usuarios del sistema con autenticación Laravel';

-- ============================================================================
-- TABLA: usuario_sucursal_acceso
-- Descripción: Relación muchos a muchos entre usuarios y sucursales
-- Orden: 3 (Depende de: users, sucursal)
-- ============================================================================
DROP TABLE IF EXISTS `usuario_sucursal_acceso`;
CREATE TABLE `usuario_sucursal_acceso` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del acceso',
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID del usuario',
  `sucursal_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID de la sucursal',
  `usuario_modificacion_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario que otorgó el acceso',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_sucursal_unique` (`user_id`, `sucursal_id`),
  INDEX `idx_usuario_sucursal_user` (`user_id`),
  INDEX `idx_usuario_sucursal_sucursal` (`sucursal_id`),
  CONSTRAINT `fk_usuario_sucursal_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_sucursal_sucursal` 
    FOREIGN KEY (`sucursal_id`) 
    REFERENCES `sucursal` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_sucursal_modificacion` 
    FOREIGN KEY (`usuario_modificacion_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Acceso de usuarios a múltiples sucursales';

-- ============================================================================
-- TABLA: catalogo_autos
-- Descripción: Catálogo de automóviles (marca, modelo, años, motor)
-- Orden: 4 (Depende de: users)
-- ============================================================================
DROP TABLE IF EXISTS `catalogo_autos`;
CREATE TABLE `catalogo_autos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del auto',
  `marca` VARCHAR(50) NOT NULL COMMENT 'Marca del vehículo (Toyota, Honda, etc.)',
  `modelo` VARCHAR(50) DEFAULT NULL COMMENT 'Modelo del vehículo (Corolla, Civic, etc.)',
  `anios_rango` VARCHAR(20) NOT NULL COMMENT 'Rango de años (ej: "98-99", "2017-2022")',
  `motor` VARCHAR(30) DEFAULT NULL COMMENT 'Especificación del motor (ej: "1.8L", "3.0L VTEC")',
  `descripcion` VARCHAR(200) DEFAULT NULL COMMENT 'Descripción adicional del vehículo',
  `creado_usuario_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario que lo creó',
  `modificado_usuario_id` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Último usuario que lo modificó',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_catalogo_autos_marca` (`marca`),
  INDEX `idx_catalogo_autos_modelo` (`modelo`),
  INDEX `idx_catalogo_autos_anios` (`anios_rango`),
  INDEX `idx_catalogo_autos_estatus` (`estatus`),
  CONSTRAINT `fk_catalogo_autos_creador` 
    FOREIGN KEY (`creado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_catalogo_autos_modificador` 
    FOREIGN KEY (`modificado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Catálogo de automóviles compatibles';

-- ============================================================================
-- TABLA: catalogo_articulos
-- Descripción: Catálogo de artículos/productos (radiadores, termostatos, etc.)
-- Orden: 5 (Depende de: users, catalogo_autos)
-- ============================================================================
DROP TABLE IF EXISTS `catalogo_articulos`;
CREATE TABLE `catalogo_articulos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del artículo',
  `dpi` VARCHAR(20) NOT NULL COMMENT 'Código DPI único del artículo',
  `descripcion` VARCHAR(200) DEFAULT NULL COMMENT 'Descripción del producto',
  `precio_venta` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Precio de venta al público',
  `categoria` ENUM('Radiador','Termostato','Ventilador','Manguera','Bomba','Otro') NOT NULL DEFAULT 'Radiador' COMMENT 'Categoría del producto',
  `catalogo_auto_principal_id` BIGINT UNSIGNED NOT NULL COMMENT 'Auto principal para el cual fue diseñado',
  `foto_url` VARCHAR(255) DEFAULT NULL COMMENT 'URL de la foto: /storage/productos/{id}.jpg',
  `creado_usuario_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario que lo creó',
  `modificado_usuario_id` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Último usuario que lo modificó',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `catalogo_articulos_dpi_unique` (`dpi`),
  INDEX `idx_catalogo_articulos_categoria` (`categoria`),
  INDEX `idx_catalogo_articulos_precio` (`precio_venta`),
  INDEX `idx_catalogo_articulos_estatus` (`estatus`),
  CONSTRAINT `fk_catalogo_articulos_auto_principal` 
    FOREIGN KEY (`catalogo_auto_principal_id`) 
    REFERENCES `catalogo_autos` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_catalogo_articulos_creador` 
    FOREIGN KEY (`creado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_catalogo_articulos_modificador` 
    FOREIGN KEY (`modificado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Catálogo de artículos y productos';

-- ============================================================================
-- TABLA: compatibilidad
-- Descripción: Relación de compatibilidad entre artículos y autos
-- Orden: 6 (Depende de: catalogo_articulos, catalogo_autos, users)
-- Nota: Se crea automáticamente como "original" al capturar artículo
--       Usuario puede agregar compatibilidades adicionales como "compatible" o "universal"
-- ============================================================================
DROP TABLE IF EXISTS `compatibilidad`;
CREATE TABLE `compatibilidad` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único de compatibilidad',
  `catalogo_articulo_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID del artículo',
  `catalogo_auto_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID del auto compatible',
  `tipo_compatibilidad` ENUM('original','compatible','universal') NOT NULL DEFAULT 'compatible' COMMENT 'Tipo de compatibilidad',
  `observaciones` VARCHAR(200) DEFAULT NULL COMMENT 'Notas adicionales sobre la compatibilidad',
  `modificado_usuario_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario que registró/modificó',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `compatibilidad_articulo_auto_unique` (`catalogo_articulo_id`, `catalogo_auto_id`),
  INDEX `idx_compatibilidad_articulo` (`catalogo_articulo_id`),
  INDEX `idx_compatibilidad_auto` (`catalogo_auto_id`),
  INDEX `idx_compatibilidad_tipo` (`tipo_compatibilidad`),
  INDEX `idx_compatibilidad_estatus` (`estatus`),
  CONSTRAINT `fk_compatibilidad_articulo` 
    FOREIGN KEY (`catalogo_articulo_id`) 
    REFERENCES `catalogo_articulos` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compatibilidad_auto` 
    FOREIGN KEY (`catalogo_auto_id`) 
    REFERENCES `catalogo_autos` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compatibilidad_usuario` 
    FOREIGN KEY (`modificado_usuario_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Compatibilidad entre artículos y autos';

-- ============================================================================
-- TABLA: inventario
-- Descripción: Stock de artículos por sucursal
-- Orden: 7 (Depende de: sucursal, catalogo_articulos, users)
-- ============================================================================
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único de inventario',
  `sucursal_id` BIGINT UNSIGNED NOT NULL COMMENT 'Sucursal donde está el stock',
  `catalogo_articulo_id` BIGINT UNSIGNED NOT NULL COMMENT 'Artículo en inventario',
  `cantidad` INT NOT NULL DEFAULT 0 COMMENT 'Cantidad actual en stock',
  `stock_minimo` INT NOT NULL DEFAULT 1 COMMENT 'Stock mínimo de alerta',
  `ubicacion` VARCHAR(100) DEFAULT NULL COMMENT 'Ubicación física en almacén',
  `usuario_modificacion_id` BIGINT UNSIGNED DEFAULT NULL COMMENT 'Usuario última modificación',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventario_sucursal_articulo_unique` (`sucursal_id`, `catalogo_articulo_id`),
  INDEX `idx_inventario_sucursal` (`sucursal_id`),
  INDEX `idx_inventario_articulo` (`catalogo_articulo_id`),
  INDEX `idx_inventario_cantidad` (`cantidad`),
  INDEX `idx_inventario_stock_minimo` (`stock_minimo`),
  CONSTRAINT `fk_inventario_sucursal` 
    FOREIGN KEY (`sucursal_id`) 
    REFERENCES `sucursal` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventario_articulo` 
    FOREIGN KEY (`catalogo_articulo_id`) 
    REFERENCES `catalogo_articulos` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventario_usuario` 
    FOREIGN KEY (`usuario_modificacion_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Inventario de productos por sucursal';

-- ============================================================================
-- TABLA: movimientos_inventario
-- Descripción: Historial de movimientos de inventario
-- Orden: 8 (Depende de: sucursal, catalogo_articulos, users)
-- ============================================================================
DROP TABLE IF EXISTS `movimientos_inventario`;
CREATE TABLE `movimientos_inventario` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del movimiento',
  `sucursal_id` BIGINT UNSIGNED NOT NULL COMMENT 'Sucursal del movimiento',
  `catalogo_articulo_id` BIGINT UNSIGNED NOT NULL COMMENT 'Artículo movido',
  `tipo_movimiento` ENUM('entrada','salida','ajuste','venta','devolucion') NOT NULL COMMENT 'Tipo de movimiento',
  `cantidad` INT NOT NULL COMMENT 'Cantidad del movimiento',
  `cantidad_anterior` INT NOT NULL COMMENT 'Cantidad antes del movimiento',
  `cantidad_nueva` INT NOT NULL COMMENT 'Cantidad después del movimiento',
  `usuario_movimiento_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario que realizó el movimiento',
  `referencia` VARCHAR(100) DEFAULT NULL COMMENT 'Referencia externa (factura, orden, etc.)',
  `observaciones` TEXT DEFAULT NULL COMMENT 'Notas adicionales del movimiento',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha del movimiento (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_movimientos_sucursal` (`sucursal_id`),
  INDEX `idx_movimientos_articulo` (`catalogo_articulo_id`),
  INDEX `idx_movimientos_tipo` (`tipo_movimiento`),
  INDEX `idx_movimientos_fecha` (`created_at`),
  INDEX `idx_movimientos_usuario` (`usuario_movimiento_id`),
  CONSTRAINT `fk_movimientos_sucursal` 
    FOREIGN KEY (`sucursal_id`) 
    REFERENCES `sucursal` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movimientos_articulo` 
    FOREIGN KEY (`catalogo_articulo_id`) 
    REFERENCES `catalogo_articulos` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movimientos_usuario` 
    FOREIGN KEY (`usuario_movimiento_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Historial de movimientos de inventario';

-- ============================================================================
-- TABLA: ventas
-- Descripción: Registro de ventas realizadas
-- Orden: 9 (Depende de: sucursal, users)
-- ============================================================================
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único de la venta',
  `sucursal_id` BIGINT UNSIGNED NOT NULL COMMENT 'Sucursal donde se realizó la venta',
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Usuario vendedor',
  `fecha_venta` DATETIME NOT NULL COMMENT 'Fecha y hora de la venta',
  `cliente` VARCHAR(100) DEFAULT NULL COMMENT 'Nombre del cliente',
  `subtotal` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Subtotal sin impuestos ni descuentos',
  `descuento` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Descuento aplicado',
  `impuestos` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Impuestos (IVA, etc.)',
  `total` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Total final de la venta',
  `estatus` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Completada, 0=Cancelada',
  `observaciones` TEXT DEFAULT NULL COMMENT 'Notas adicionales de la venta',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_ventas_sucursal` (`sucursal_id`),
  INDEX `idx_ventas_usuario` (`user_id`),
  INDEX `idx_ventas_fecha` (`fecha_venta`),
  INDEX `idx_ventas_estatus` (`estatus`),
  INDEX `idx_ventas_total` (`total`),
  CONSTRAINT `fk_ventas_sucursal` 
    FOREIGN KEY (`sucursal_id`) 
    REFERENCES `sucursal` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ventas_usuario` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Registro maestro de ventas';

-- ============================================================================
-- TABLA: ventas_detalle
-- Descripción: Detalle de artículos vendidos en cada venta
-- Orden: 10 (Depende de: ventas, catalogo_articulos)
-- ============================================================================
DROP TABLE IF EXISTS `ventas_detalle`;
CREATE TABLE `ventas_detalle` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del detalle',
  `venta_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID de la venta',
  `catalogo_articulo_id` BIGINT UNSIGNED NOT NULL COMMENT 'Artículo vendido',
  `cantidad` INT NOT NULL COMMENT 'Cantidad vendida',
  `precio_unitario` DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario al momento de la venta',
  `subtotal` DECIMAL(10,2) NOT NULL COMMENT 'Subtotal (cantidad * precio_unitario)',
  `descuento` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Descuento aplicado al artículo',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_ventas_detalle_venta` (`venta_id`),
  INDEX `idx_ventas_detalle_articulo` (`catalogo_articulo_id`),
  CONSTRAINT `fk_ventas_detalle_venta` 
    FOREIGN KEY (`venta_id`) 
    REFERENCES `ventas` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ventas_detalle_articulo` 
    FOREIGN KEY (`catalogo_articulo_id`) 
    REFERENCES `catalogo_articulos` (`id`) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Detalle de artículos por venta';

-- ============================================================================
-- TABLA: ventas_cobro
-- Descripción: Registro de cobros/pagos de ventas
-- Orden: 11 (Depende de: ventas)
-- Nota: Una venta puede tener múltiples formas de pago
-- ============================================================================
DROP TABLE IF EXISTS `ventas_cobro`;
CREATE TABLE `ventas_cobro` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único del cobro',
  `venta_id` BIGINT UNSIGNED NOT NULL COMMENT 'ID de la venta',
  `fecha_cobro` DATETIME NOT NULL COMMENT 'Fecha y hora del cobro',
  `forma_pago` ENUM('efectivo','tarjeta','transferencia','cheque') NOT NULL DEFAULT 'efectivo' COMMENT 'Forma de pago utilizada',
  `monto` DECIMAL(10,2) NOT NULL COMMENT 'Monto cobrado',
  `referencia` VARCHAR(100) DEFAULT NULL COMMENT 'Referencia del pago (núm. tarjeta, cheque, etc.)',
  `created_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de creación (Laravel)',
  `updated_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Fecha de actualización (Laravel)',
  PRIMARY KEY (`id`),
  INDEX `idx_ventas_cobro_venta` (`venta_id`),
  INDEX `idx_ventas_cobro_fecha` (`fecha_cobro`),
  INDEX `idx_ventas_cobro_forma_pago` (`forma_pago`),
  CONSTRAINT `fk_ventas_cobro_venta` 
    FOREIGN KEY (`venta_id`) 
    REFERENCES `ventas` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cobros y formas de pago de ventas';

-- ============================================================================
-- TABLAS DE LARAVEL (Sistema)
-- ============================================================================

-- Tabla: cache (Laravel)
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` VARCHAR(255) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cache de Laravel';

-- Tabla: cache_locks (Laravel)
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` VARCHAR(255) NOT NULL,
  `owner` VARCHAR(255) NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Locks de cache de Laravel';

-- Tabla: jobs (Laravel Queue)
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` VARCHAR(255) NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `attempts` TINYINT UNSIGNED NOT NULL,
  `reserved_at` INT UNSIGNED DEFAULT NULL,
  `available_at` INT UNSIGNED NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cola de trabajos de Laravel';

-- Tabla: job_batches (Laravel Queue)
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `total_jobs` INT NOT NULL,
  `pending_jobs` INT NOT NULL,
  `failed_jobs` INT NOT NULL,
  `failed_job_ids` LONGTEXT NOT NULL,
  `options` MEDIUMTEXT DEFAULT NULL,
  `cancelled_at` INT DEFAULT NULL,
  `created_at` INT NOT NULL,
  `finished_at` INT DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lotes de trabajos de Laravel';

-- Tabla: failed_jobs (Laravel)
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trabajos fallidos de Laravel';

-- Tabla: password_reset_tokens (Laravel)
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tokens de reseteo de contraseña';

-- Tabla: sessions (Laravel)
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` VARCHAR(255) NOT NULL,
  `user_id` BIGINT UNSIGNED DEFAULT NULL,
  `ip_address` VARCHAR(45) DEFAULT NULL,
  `user_agent` TEXT DEFAULT NULL,
  `payload` LONGTEXT NOT NULL,
  `last_activity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sessions_user_id_index` (`user_id`),
  INDEX `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Sesiones de Laravel';

-- Tabla: migrations (Laravel)
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Control de migraciones de Laravel';

-- ============================================================================
-- DATOS DE EJEMPLO (Opcional - Descomentar para usar)
-- ============================================================================

/*
-- Sucursales
INSERT INTO `sucursal` (`id`, `nombre`, `direccion`, `estatus`, `created_at`, `updated_at`) VALUES
(1, 'Pinos', 'Av. Principal #123, Centro', 1, NOW(), NOW()),
(2, 'Centro', 'Calle Norte #456, Zona Norte', 1, NOW(), NOW()),
(3, 'Mexicali', 'Blvd. Sur #789, Zona Sur', 1, NOW(), NOW());

-- Usuario Admin (password: password)
INSERT INTO `users` (`id`, `sucursal_id`, `usuario`, `nombre`, `email`, `password`, `rol`, `acceso_todas_sucursales`, `estatus`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'Administrador', 'admin@radiadores.com', '$2y$12$LQv3c1yycaGdCgzS9X2PheX4Hm4s7Bz3rjp6nqvN5u7xV8w9M0a1O', 'administrador', 1, 1, NOW(), NOW());

-- Más datos de ejemplo...
*/

-- ============================================================================
-- RESUMEN DE CAMBIOS RESPECTO A LA BASE ORIGINAL
-- ============================================================================
/*
CAMBIOS PRINCIPALES:

1. NOMENCLATURA LARAVEL:
   - Tabla 'usuario' → 'users' (convención Laravel)
   - Campos 'iTabla' → 'id' (BIGINT UNSIGNED AUTO_INCREMENT)
   - Campos 'FechaCreacion/FechaActualizacion' → 'created_at/updated_at'
   - Campos 'iUsuario' → 'user_id' (relaciones)
   - snake_case en todos los nombres de campos

2. CLAVES FORÁNEAS:
   - Todas las FK tienen nombres descriptivos (fk_tabla_relacion)
   - ON DELETE RESTRICT para datos críticos (evita borrados accidentales)
   - ON DELETE CASCADE para relaciones dependientes
   - ON DELETE SET NULL para referencias opcionales

3. ÍNDICES:
   - Añadidos índices en campos de búsqueda frecuente
   - Índices compuestos para consultas optimizadas
   - Índices UNIQUE para restricciones de negocio

4. TIPOS DE DATOS:
   - INT(11) → BIGINT UNSIGNED (más capacidad, compatible Laravel)
   - TINYINT(1) para booleanos (0/1)
   - DECIMAL(10,2) para monedas
   - VARCHAR con longitudes específicas
   - TEXT para campos largos

5. COMENTARIOS:
   - Todos los campos documentados
   - Comentarios en tablas explicando su propósito
   - Notas sobre dependencias y relaciones

6. COMPATIBILIDAD:
   - 100% compatible con Laravel Eloquent ORM
   - Soporta soft deletes si se agregan campos deleted_at
   - Preparado para timestamps automáticos
   - Compatible con Laravel Fortify (2FA)

7. CATEGORÍAS:
   - Expandido ENUM de categorías en catalogo_articulos
   - Añadidos: 'Ventilador', 'Manguera', 'Bomba', 'Otro'

8. SEGURIDAD:
   - Campos password preparados para bcrypt
   - Soporte para two-factor authentication
   - Email verification integrado
   - Remember token para sesiones

ORDEN DE CREACIÓN DE TABLAS (Respeta dependencias):
1. sucursal
2. users
3. usuario_sucursal_acceso
4. catalogo_autos
5. catalogo_articulos
6. compatibilidad
7. inventario
8. movimientos_inventario
9. ventas
10. ventas_detalle
11. ventas_cobro
12. Tablas de sistema Laravel

RECOMENDACIONES:
- Crear migraciones Laravel desde esta estructura
- Implementar seeders para datos de prueba
- Configurar Eloquent Models con relaciones
- Implementar Observers para movimientos de inventario automáticos
- Crear Policies para control de acceso basado en roles
*/

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ============================================================================
-- FIN DEL SCRIPT
-- ============================================================================
