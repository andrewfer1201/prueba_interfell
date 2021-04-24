-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-04-2021 a las 03:40:18
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `epayco`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `billetera`
--

CREATE TABLE `billetera` (
  `id` int(11) NOT NULL,
  `documento` varchar(50) NOT NULL,
  `celular` varchar(50) NOT NULL,
  `cantidad_disponible` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `billetera`
--

INSERT INTO `billetera` (`id`, `documento`, `celular`, `cantidad_disponible`) VALUES
(2, '22998241', '04248749778', 40.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `documento` varchar(50) NOT NULL,
  `nombre` varchar(500) NOT NULL,
  `celular` varchar(50) NOT NULL,
  `email` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `documento`, `nombre`, `celular`, `email`) VALUES
(6, '22998241', 'Andrew', '04248749778', 'andrewxfx@gmail.com'),
(16, '2', '2', '2', 'andrewxfx2@gmail.com'),
(17, '1234', 'Jose perez', '12345', 'jose@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `confirmacion`
--

CREATE TABLE `confirmacion` (
  `id` int(11) NOT NULL,
  `token` varchar(20) NOT NULL,
  `id_sesion` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `confirmacion`
--

INSERT INTO `confirmacion` (`id`, `token`, `id_sesion`) VALUES
(1, '593778', 'XYZ'),
(2, '266796', 'XYZ'),
(3, '960310', 'XYZ'),
(4, '302156', 'XYZ'),
(5, '288018', 'XYZ'),
(6, '301280', 'XYZ'),
(7, '257768', 'XYZ'),
(8, '532692', 'XYZ'),
(9, '554938', 'XYZ'),
(10, '468530', 'XYZ'),
(11, '504160', 'XYZ');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `billetera`
--
ALTER TABLE `billetera`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento` (`documento`),
  ADD KEY `celular` (`celular`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD KEY `celular` (`celular`);

--
-- Indices de la tabla `confirmacion`
--
ALTER TABLE `confirmacion`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `billetera`
--
ALTER TABLE `billetera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `confirmacion`
--
ALTER TABLE `confirmacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `billetera`
--
ALTER TABLE `billetera`
  ADD CONSTRAINT `billetera_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `cliente` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `billetera_ibfk_2` FOREIGN KEY (`celular`) REFERENCES `cliente` (`celular`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
