-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 06-11-2025 a las 07:09:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `radiadoresnuevos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogoarts`
--

CREATE TABLE `catalogoarts` (
  `iCatalogoArts` int(11) NOT NULL,
  `Dpi` varchar(20) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `PrecioVenta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Categoria` varchar(50) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Modelo` varchar(50) DEFAULT NULL,
  `iUsuario` int(11) NOT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `iUsuarioActualizo` int(11) DEFAULT NULL,
  `FechaActualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estatus` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalogoarts`
--

INSERT INTO `catalogoarts` (`iCatalogoArts`, `Dpi`, `Descripcion`, `PrecioVenta`, `Categoria`, `Marca`, `Modelo`, `iUsuario`, `FechaCreacion`, `iUsuarioActualizo`, `FechaActualizacion`, `Estatus`) VALUES
(1, '111111', 'Radiador Universal 24\"', 1500.00, 'Radiadores', 'Generic', 'Universal', 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(2, '123456', 'Manguera Superior Radiador', 150.00, 'Mangueras', 'Gates', 'Superior', 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(3, '123457', 'Bomba de Agua Automotriz', 800.00, 'Bombas', 'Aisin', 'WP-1001', 3, '2025-10-24 23:17:31', 3, '2025-10-24 23:17:31', 1),
(4, '222222', 'Termostato 180°F', 250.00, 'Termostatos', 'Stant', '13478', 3, '2025-10-24 23:17:31', 3, '2025-10-24 23:17:31', 1),
(5, '365524', 'Ventilador Eléctrico 12V', 950.00, 'Ventiladores', 'SPAL', 'VA01-AP70', 4, '2025-10-24 23:17:31', 4, '2025-10-24 23:17:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogoautos`
--

CREATE TABLE `catalogoautos` (
  `iCatalogoAutos` int(11) NOT NULL,
  `Marca` varchar(50) NOT NULL,
  `Modelo` varchar(50) NOT NULL,
  `Anio` int(4) NOT NULL,
  `Motor` varchar(30) DEFAULT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `iUsuario` int(11) NOT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `iUsuarioActualizo` int(11) DEFAULT NULL,
  `FechaActualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estatus` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalogoautos`
--

INSERT INTO `catalogoautos` (`iCatalogoAutos`, `Marca`, `Modelo`, `Anio`, `Motor`, `Descripcion`, `iUsuario`, `FechaCreacion`, `iUsuarioActualizo`, `FechaActualizacion`, `Estatus`) VALUES
(1, 'Toyota', 'Corolla', 2020, '1.8L', 'Sedán compacto', 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(2, 'Honda', 'Civic', 2019, '1.5L Turbo', 'Sedán deportivo', 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(3, 'Nissan', 'Sentra', 2021, '1.6L', 'Sedán familiar', 3, '2025-10-24 23:17:31', 3, '2025-10-24 23:17:31', 1),
(4, 'Chevrolet', 'Aveo', 2018, '1.4L', 'Sedán económico', 3, '2025-10-24 23:17:31', 3, '2025-10-24 23:17:31', 1),
(5, 'Ford', 'Focus', 2017, '2.0L', 'Hatchback', 3, '2025-10-24 23:17:31', 3, '2025-10-24 23:17:31', 1),
(6, 'Honda', 'Accord', 2002, '3.0L VTEC', 'Sedán de lujo', 2, '2025-10-24 23:17:31', 2, '2025-10-24 23:17:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compatibilidad`
--

CREATE TABLE `compatibilidad` (
  `iCompatibilidad` int(11) NOT NULL,
  `iCatalogoArts` int(11) NOT NULL,
  `iCatalogoAutos` int(11) NOT NULL,
  `TipoCompatibilidad` enum('original','compatible','universal') NOT NULL DEFAULT 'compatible',
  `Observaciones` varchar(200) DEFAULT NULL,
  `iUsuarioActualizo` int(11) NOT NULL,
  `FechaActualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estatus` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compatibilidad`
--

INSERT INTO `compatibilidad` (`iCompatibilidad`, `iCatalogoArts`, `iCatalogoAutos`, `TipoCompatibilidad`, `Observaciones`, `iUsuarioActualizo`, `FechaActualizacion`, `Estatus`) VALUES
(1, 1, 1, 'original', 'Radiador universal para Toyota Corolla 2020', 1, '2025-10-27 15:49:57', 1),
(2, 1, 2, 'compatible', 'Compatible con Honda Civic 2019', 1, '2025-10-24 23:17:31', 1),
(3, 1, 3, 'compatible', 'Compatible con Nissan Sentra 2021', 1, '2025-10-24 23:17:31', 1),
(4, 2, 2, 'original', 'Manguera original Honda Civic', 1, '2025-10-24 23:17:31', 1),
(5, 2, 6, 'compatible', 'Compatible Honda Accord 2002', 1, '2025-10-24 23:17:31', 1),
(6, 3, 1, 'compatible', 'Compatible Toyota Corolla', 3, '2025-10-24 23:17:31', 1),
(7, 3, 3, 'original', 'Bomba original Nissan Sentra', 3, '2025-10-24 23:17:31', 1),
(8, 4, 4, 'original', 'Termostato original Chevrolet Aveo', 3, '2025-10-24 23:17:31', 1),
(9, 4, 5, 'compatible', 'Compatible Ford Focus', 2, '2025-10-24 23:17:31', 1),
(10, 5, 5, 'original', 'Ventilador original Ford Focus', 4, '2025-10-24 23:17:31', 1),
(11, 5, 4, 'compatible', 'Compatible Chevrolet Aveo', 2, '2025-10-24 23:17:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `iInventario` int(11) NOT NULL,
  `iSucursal` int(11) NOT NULL,
  `iCatalogoArts` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL DEFAULT 0,
  `StockMinimo` int(11) NOT NULL DEFAULT 1,
  `Ubicacion` varchar(100) DEFAULT NULL,
  `FechaUltimaModificacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `iUsuarioModificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`iInventario`, `iSucursal`, `iCatalogoArts`, `Cantidad`, `StockMinimo`, `Ubicacion`, `FechaUltimaModificacion`, `iUsuarioModificacion`) VALUES
(1, 1, 1, 75, 2, 'Almacén A-1', '2025-11-06 00:08:20', 1),
(2, 1, 2, 46, 5, 'Almacén A-2', '2025-10-28 20:15:56', 1),
(3, 1, 3, 3, 1, 'Almacén B-1', '2025-10-24 23:17:31', 1),
(4, 2, 1, 4, 2, 'Bodega Norte', '2025-10-25 01:43:33', 4),
(5, 2, 4, 12, 3, 'Bodega Norte', '2025-10-24 23:17:31', 3),
(6, 3, 5, 6, 2, 'Área Sur', '2025-10-24 23:17:31', 1),
(7, 2, 5, 1, 1, NULL, '2025-10-25 01:28:42', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientosinventario`
--

CREATE TABLE `movimientosinventario` (
  `iMovimientosInventario` int(11) NOT NULL,
  `iSucursal` int(11) NOT NULL,
  `iCatalogoArts` int(11) NOT NULL,
  `TipoMovimiento` enum('entrada','salida','ajuste','venta','devolucion') NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `CantidadAnterior` int(11) NOT NULL,
  `CantidadNueva` int(11) NOT NULL,
  `FechaMovimiento` timestamp NOT NULL DEFAULT current_timestamp(),
  `iUsuarioMovimiento` int(11) NOT NULL,
  `Referencia` varchar(100) DEFAULT NULL,
  `Observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimientosinventario`
--

INSERT INTO `movimientosinventario` (`iMovimientosInventario`, `iSucursal`, `iCatalogoArts`, `TipoMovimiento`, `Cantidad`, `CantidadAnterior`, `CantidadNueva`, `FechaMovimiento`, `iUsuarioMovimiento`, `Referencia`, `Observaciones`) VALUES
(1, 1, 1, 'entrada', 10, 0, 10, '2025-10-24 23:17:31', 1, 'INV-001', 'Inventario inicial'),
(2, 1, 1, 'venta', 1, 10, 9, '2025-10-24 23:17:31', 1, 'VTA-001', 'Venta a Juan Carlos López'),
(3, 1, 2, 'entrada', 20, 0, 20, '2025-10-24 23:17:31', 1, 'INV-002', 'Inventario inicial'),
(4, 2, 2, 'venta', 1, 20, 19, '2025-10-24 23:17:31', 3, 'VTA-002', 'Venta a María González'),
(5, 1, 2, 'entrada', 1, 15, 16, '2025-10-24 23:38:58', 1, NULL, 'Aumento de stock manual'),
(6, 1, 2, 'entrada', 10, 16, 26, '2025-10-25 00:27:19', 1, NULL, 'Aumento de stock manual'),
(7, 2, 5, 'entrada', 1, 0, 1, '2025-10-25 01:28:42', 4, NULL, 'Aumento de stock manual'),
(8, 2, 1, 'venta', 1, 8, 7, '2025-10-25 01:43:24', 4, NULL, 'Venta - Cliente:'),
(9, 2, 1, 'venta', 1, 7, 6, '2025-10-25 01:43:27', 4, NULL, 'Venta - Cliente:'),
(10, 2, 1, 'venta', 1, 6, 5, '2025-10-25 01:43:30', 4, NULL, 'Venta - Cliente:'),
(11, 2, 1, 'venta', 1, 5, 4, '2025-10-25 01:43:33', 4, NULL, 'Venta - Cliente: asda'),
(12, 1, 2, 'entrada', 10, 26, 36, '2025-10-28 19:56:46', 1, NULL, 'Aumento de stock manual'),
(13, 1, 1, 'entrada', 10, 5, 15, '2025-10-28 20:07:28', 1, NULL, 'Aumento de stock manual'),
(14, 1, 2, 'entrada', 10, 36, 46, '2025-10-28 20:15:56', 1, NULL, 'Aumento de stock manual'),
(15, 1, 1, 'entrada', 10, 15, 25, '2025-11-04 16:09:26', 1, NULL, 'Aumento de stock manual'),
(16, 1, 1, 'entrada', 50, 25, 75, '2025-11-06 00:08:20', 1, NULL, 'Aumento de stock manual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `iSucursal` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `iUsuario` int(11) NOT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `iUsuarioActualizo` int(11) DEFAULT NULL,
  `FechaActualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estatus` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`iSucursal`, `Nombre`, `Direccion`, `iUsuario`, `FechaCreacion`, `iUsuarioActualizo`, `FechaActualizacion`, `Estatus`) VALUES
(1, 'Pinos', 'Av. Principal #123, Centro', 1, '2025-10-24 23:17:30', 1, '2025-10-25 01:02:05', 1),
(2, 'Centro', 'Calle Norte #456, Zona Norte', 1, '2025-10-24 23:17:30', 1, '2025-10-25 01:02:29', 1),
(3, 'Mexicali', 'Blvd. Sur #789, Zona Sur', 1, '2025-10-24 23:17:30', 1, '2025-10-25 01:02:50', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `iUsuario` int(11) NOT NULL,
  `iSucursal` int(11) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Rol` enum('administrador','supervisor','capturista','vendedor') NOT NULL DEFAULT 'vendedor',
  `AccesoTodasSucursales` tinyint(1) NOT NULL DEFAULT 0,
  `iUsuarioCreador` int(11) DEFAULT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `iUsuarioActualizo` int(11) DEFAULT NULL,
  `FechaActualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estatus` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`iUsuario`, `iSucursal`, `Usuario`, `Password`, `Nombre`, `Email`, `Rol`, `AccesoTodasSucursales`, `iUsuarioCreador`, `FechaCreacion`, `iUsuarioActualizo`, `FechaActualizacion`, `Estatus`) VALUES
(1, 1, 'admin', '$2y$10$Dh6VQ8qB/U1A/5e7c2sxp.RYK4y6BUdtr1STYbpUylxf2GDMF8YV.', 'Administrador', 'by.petterpotten@gmail.com', 'administrador', 1, NULL, '2025-10-24 23:17:31', NULL, '2025-10-24 23:17:31', 1),
(2, 1, 'supervisor', '$2y$10$Dh6VQ8qB/U1A/5e7c2sxp.RYK4y6BUdtr1STYbpUylxf2GDMF8YV.', 'Supervisor', 'supervisor@radiadores.com', 'supervisor', 0, 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(3, 2, 'capturista', '$2y$10$Dh6VQ8qB/U1A/5e7c2sxp.RYK4y6BUdtr1STYbpUylxf2GDMF8YV.', 'Capturista', 'capturista@radiadores.com', 'capturista', 0, 1, '2025-10-24 23:17:31', 1, '2025-10-24 23:17:31', 1),
(4, 2, 'vendedor', '$2y$10$Dh6VQ8qB/U1A/5e7c2sxp.RYK4y6BUdtr1STYbpUylxf2GDMF8YV.', 'Vendedor', 'vendedor@radiadores.com', 'vendedor', 0, 2, '2025-10-24 23:17:31', 2, '2025-10-24 23:17:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosucursalacceso`
--

CREATE TABLE `usuariosucursalacceso` (
  `iUsuarioSucursalAcceso` int(11) NOT NULL,
  `iUsuario` int(11) NOT NULL,
  `iSucursal` int(11) NOT NULL,
  `iUsuarioModificacion` int(11) NOT NULL,
  `FechaUltimaModificacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuariosucursalacceso`
--

INSERT INTO `usuariosucursalacceso` (`iUsuarioSucursalAcceso`, `iUsuario`, `iSucursal`, `iUsuarioModificacion`, `FechaUltimaModificacion`) VALUES
(1, 1, 1, 1, '2025-10-24 23:17:31'),
(2, 1, 2, 1, '2025-10-24 23:17:31'),
(3, 1, 3, 1, '2025-10-24 23:17:31'),
(4, 2, 1, 1, '2025-10-24 23:17:31'),
(5, 3, 2, 1, '2025-10-24 23:17:31'),
(6, 4, 2, 2, '2025-10-24 23:17:31'),
(7, 4, 3, 2, '2025-10-24 23:17:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `iVentas` int(11) NOT NULL,
  `iSucursal` int(11) NOT NULL,
  `iUsuario` int(11) NOT NULL,
  `FechaVenta` datetime NOT NULL DEFAULT current_timestamp(),
  `Cliente` varchar(100) DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Impuestos` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Estatus` tinyint(1) NOT NULL DEFAULT 1,
  `Observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`iVentas`, `iSucursal`, `iUsuario`, `FechaVenta`, `Cliente`, `Total`, `Descuento`, `Subtotal`, `Impuestos`, `Estatus`, `Observaciones`) VALUES
(1, 1, 1, '2025-10-23 14:30:00', 'Juan Carlos López', 1725.00, 0.00, 1500.00, 225.00, 1, 'Venta de radiador universal'),
(2, 2, 3, '2025-10-23 15:45:00', 'María González', 172.50, 0.00, 150.00, 22.50, 1, 'Manguera superior');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventascobro`
--

CREATE TABLE `ventascobro` (
  `iVentasCobro` int(11) NOT NULL,
  `iVentas` int(11) NOT NULL,
  `FechaCobro` datetime NOT NULL DEFAULT current_timestamp(),
  `FormaPago` enum('efectivo','tarjeta','transferencia','cheque') NOT NULL DEFAULT 'efectivo',
  `Monto` decimal(10,2) NOT NULL,
  `Referencia` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventascobro`
--

INSERT INTO `ventascobro` (`iVentasCobro`, `iVentas`, `FechaCobro`, `FormaPago`, `Monto`, `Referencia`) VALUES
(1, 1, '2025-10-23 14:30:00', 'efectivo', 1725.00, NULL),
(2, 2, '2025-10-23 15:45:00', 'tarjeta', 172.50, 'VISA-1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasdet`
--

CREATE TABLE `ventasdet` (
  `iVentasDet` int(11) NOT NULL,
  `iVentas` int(11) NOT NULL,
  `iCatalogoArts` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `PrecioUnitario` decimal(10,2) NOT NULL,
  `Subtotal` decimal(10,2) NOT NULL,
  `Descuento` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventasdet`
--

INSERT INTO `ventasdet` (`iVentasDet`, `iVentas`, `iCatalogoArts`, `Cantidad`, `PrecioUnitario`, `Subtotal`, `Descuento`) VALUES
(1, 1, 1, 1, 1500.00, 1500.00, 0.00),
(2, 2, 2, 1, 150.00, 150.00, 0.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catalogoarts`
--
ALTER TABLE `catalogoarts`
  ADD PRIMARY KEY (`iCatalogoArts`),
  ADD UNIQUE KEY `Dpi` (`Dpi`),
  ADD KEY `iUsuario` (`iUsuario`),
  ADD KEY `iUsuarioActualizo` (`iUsuarioActualizo`);

--
-- Indices de la tabla `catalogoautos`
--
ALTER TABLE `catalogoautos`
  ADD PRIMARY KEY (`iCatalogoAutos`),
  ADD KEY `iUsuario` (`iUsuario`),
  ADD KEY `iUsuarioActualizo` (`iUsuarioActualizo`);

--
-- Indices de la tabla `compatibilidad`
--
ALTER TABLE `compatibilidad`
  ADD PRIMARY KEY (`iCompatibilidad`),
  ADD UNIQUE KEY `articulo_auto` (`iCatalogoArts`,`iCatalogoAutos`),
  ADD KEY `iCatalogoArts` (`iCatalogoArts`),
  ADD KEY `iCatalogoAutos` (`iCatalogoAutos`),
  ADD KEY `iUsuarioActualizo` (`iUsuarioActualizo`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`iInventario`),
  ADD UNIQUE KEY `sucursal_producto` (`iSucursal`,`iCatalogoArts`),
  ADD KEY `iSucursal` (`iSucursal`),
  ADD KEY `iCatalogoArts` (`iCatalogoArts`),
  ADD KEY `iUsuarioModificacion` (`iUsuarioModificacion`);

--
-- Indices de la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  ADD PRIMARY KEY (`iMovimientosInventario`),
  ADD KEY `iSucursal` (`iSucursal`),
  ADD KEY `iCatalogoArts` (`iCatalogoArts`),
  ADD KEY `iUsuarioMovimiento` (`iUsuarioMovimiento`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`iSucursal`),
  ADD KEY `iUsuario` (`iUsuario`),
  ADD KEY `iUsuarioActualizo` (`iUsuarioActualizo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`iUsuario`),
  ADD UNIQUE KEY `Usuario` (`Usuario`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `iSucursal` (`iSucursal`),
  ADD KEY `iUsuarioCreador` (`iUsuarioCreador`),
  ADD KEY `iUsuarioActualizo` (`iUsuarioActualizo`);

--
-- Indices de la tabla `usuariosucursalacceso`
--
ALTER TABLE `usuariosucursalacceso`
  ADD PRIMARY KEY (`iUsuarioSucursalAcceso`),
  ADD UNIQUE KEY `usuario_sucursal` (`iUsuario`,`iSucursal`),
  ADD KEY `iUsuario` (`iUsuario`),
  ADD KEY `iSucursal` (`iSucursal`),
  ADD KEY `iUsuarioModificacion` (`iUsuarioModificacion`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`iVentas`),
  ADD KEY `iSucursal` (`iSucursal`),
  ADD KEY `iUsuario` (`iUsuario`);

--
-- Indices de la tabla `ventascobro`
--
ALTER TABLE `ventascobro`
  ADD PRIMARY KEY (`iVentasCobro`),
  ADD KEY `iVentas` (`iVentas`);

--
-- Indices de la tabla `ventasdet`
--
ALTER TABLE `ventasdet`
  ADD PRIMARY KEY (`iVentasDet`),
  ADD KEY `iVentas` (`iVentas`),
  ADD KEY `iCatalogoArts` (`iCatalogoArts`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `catalogoarts`
--
ALTER TABLE `catalogoarts`
  MODIFY `iCatalogoArts` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `catalogoautos`
--
ALTER TABLE `catalogoautos`
  MODIFY `iCatalogoAutos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `compatibilidad`
--
ALTER TABLE `compatibilidad`
  MODIFY `iCompatibilidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `iInventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  MODIFY `iMovimientosInventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `iSucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `iUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuariosucursalacceso`
--
ALTER TABLE `usuariosucursalacceso`
  MODIFY `iUsuarioSucursalAcceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `iVentas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventascobro`
--
ALTER TABLE `ventascobro`
  MODIFY `iVentasCobro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventasdet`
--
ALTER TABLE `ventasdet`
  MODIFY `iVentasDet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `catalogoarts`
--
ALTER TABLE `catalogoarts`
  ADD CONSTRAINT `fk_catalogoarts_usuario` FOREIGN KEY (`iUsuario`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_catalogoarts_usuario_actualizo` FOREIGN KEY (`iUsuarioActualizo`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `catalogoautos`
--
ALTER TABLE `catalogoautos`
  ADD CONSTRAINT `fk_catalogoautos_usuario` FOREIGN KEY (`iUsuario`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_catalogoautos_usuario_actualizo` FOREIGN KEY (`iUsuarioActualizo`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `compatibilidad`
--
ALTER TABLE `compatibilidad`
  ADD CONSTRAINT `fk_compatibilidad_catalogoarts` FOREIGN KEY (`iCatalogoArts`) REFERENCES `catalogoarts` (`iCatalogoArts`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_compatibilidad_catalogoautos` FOREIGN KEY (`iCatalogoAutos`) REFERENCES `catalogoautos` (`iCatalogoAutos`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_compatibilidad_usuario` FOREIGN KEY (`iUsuarioActualizo`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_catalogoarts` FOREIGN KEY (`iCatalogoArts`) REFERENCES `catalogoarts` (`iCatalogoArts`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventario_sucursal` FOREIGN KEY (`iSucursal`) REFERENCES `sucursal` (`iSucursal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventario_usuario_modificacion` FOREIGN KEY (`iUsuarioModificacion`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimientosinventario`
--
ALTER TABLE `movimientosinventario`
  ADD CONSTRAINT `fk_movimientos_catalogoarts` FOREIGN KEY (`iCatalogoArts`) REFERENCES `catalogoarts` (`iCatalogoArts`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_movimientos_sucursal` FOREIGN KEY (`iSucursal`) REFERENCES `sucursal` (`iSucursal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_movimientos_usuario` FOREIGN KEY (`iUsuarioMovimiento`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `fk_sucursal_usuario` FOREIGN KEY (`iUsuario`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sucursal_usuario_actualizo` FOREIGN KEY (`iUsuarioActualizo`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_actualizo` FOREIGN KEY (`iUsuarioActualizo`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_creador` FOREIGN KEY (`iUsuarioCreador`) REFERENCES `usuario` (`iUsuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`iSucursal`) REFERENCES `sucursal` (`iSucursal`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuariosucursalacceso`
--
ALTER TABLE `usuariosucursalacceso`
  ADD CONSTRAINT `fk_usuariosucursalacceso_modificacion` FOREIGN KEY (`iUsuarioModificacion`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuariosucursalacceso_sucursal` FOREIGN KEY (`iSucursal`) REFERENCES `sucursal` (`iSucursal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuariosucursalacceso_usuario` FOREIGN KEY (`iUsuario`) REFERENCES `usuario` (`iUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_ventas_sucursal` FOREIGN KEY (`iSucursal`) REFERENCES `sucursal` (`iSucursal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ventas_usuario` FOREIGN KEY (`iUsuario`) REFERENCES `usuario` (`iUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventascobro`
--
ALTER TABLE `ventascobro`
  ADD CONSTRAINT `fk_ventascobro_venta` FOREIGN KEY (`iVentas`) REFERENCES `ventas` (`iVentas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventasdet`
--
ALTER TABLE `ventasdet`
  ADD CONSTRAINT `fk_ventasdet_catalogoarts` FOREIGN KEY (`iCatalogoArts`) REFERENCES `catalogoarts` (`iCatalogoArts`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ventasdet_venta` FOREIGN KEY (`iVentas`) REFERENCES `ventas` (`iVentas`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
