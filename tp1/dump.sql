-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 16, 2013 at 05:50 AM
-- Server version: 5.5.29
-- PHP Version: 5.4.6-1ubuntu1.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `linea-aerea`
--

-- --------------------------------------------------------

--
-- Table structure for table `Aeropuerto`
--

CREATE TABLE IF NOT EXISTS `Aeropuerto` (
  `id_a` int(11) NOT NULL AUTO_INCREMENT,
  `tasa` float NOT NULL,
  `transporte` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  PRIMARY KEY (`id_a`),
  KEY `FK_Aeropuerto` (`id_ciudad`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `Aeropuerto`
--

INSERT INTO `Aeropuerto` (`id_a`, `tasa`, `transporte`, `nombre`, `id_ciudad`) VALUES
(1, 21, 'colectivos', 'aeroparque jorge newbery', 1),
(2, 10, 'colectivos', 'aeropuerto de cordoba', 2),
(3, 20, 'colectivos', 'aeropuerto de rosario', 3),
(4, 20, 'colectivos', 'aeropuerto de mendoza', 4),
(5, 10, 'colectivos', 'aeropuerto de rio de janeiro', 5),
(6, 10, 'colectivos', 'aeropuerto de san pablo', 6);

-- --------------------------------------------------------

--
-- Table structure for table `Atiende`
--

CREATE TABLE IF NOT EXISTS `Atiende` (
  `id_user` int(11) NOT NULL,
  `nro_tel` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`nro_tel`),
  KEY `FK_Atiende_Tel` (`nro_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Avion`
--

CREATE TABLE IF NOT EXISTS `Avion` (
  `id_avion` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `anio_fabricacion` int(11) NOT NULL,
  `millas` int(11) NOT NULL,
  `asiestos` int(11) NOT NULL,
  `origen` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_avion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `Avion`
--

INSERT INTO `Avion` (`id_avion`, `modelo`, `anio_fabricacion`, `millas`, `asiestos`, `origen`) VALUES
(1, 'boeing 737', 2005, 1000, 80, 'usa'),
(2, 'airbus a320', 2004, 2000, 70, 'francia'),
(3, 'airbus a380', 2010, 1000, 80, 'francia'),
(4, 'boeing 767', 2003, 20000, 100, 'usa'),
(5, 'embraer 190', 2010, 1000, 70, 'brasil');

-- --------------------------------------------------------

--
-- Table structure for table `Brinda`
--

CREATE TABLE IF NOT EXISTS `Brinda` (
  `id_serv` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id_serv`,`id_clase`),
  KEY `FK_Brinda_Clase` (`id_clase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Ciudad`
--

CREATE TABLE IF NOT EXISTS `Ciudad` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `FK_Ciudad` (`id_pais`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `Ciudad`
--

INSERT INTO `Ciudad` (`id_ciudad`, `id_pais`, `nombre`) VALUES
(1, 1, 'buenos aires'),
(2, 1, 'cordoba'),
(3, 1, 'rosario'),
(4, 1, 'mendoza'),
(5, 2, 'rio de janeiro'),
(6, 2, 'san pablo');

-- --------------------------------------------------------

--
-- Table structure for table `Clase`
--

CREATE TABLE IF NOT EXISTS `Clase` (
  `id_clase` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_clase`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `Clase`
--

INSERT INTO `Clase` (`id_clase`, `descripcion`) VALUES
(1, 'economica'),
(2, 'business');

-- --------------------------------------------------------

--
-- Table structure for table `DatosPersonales`
--

CREATE TABLE IF NOT EXISTS `DatosPersonales` (
  `id_user` int(11) NOT NULL DEFAULT '0',
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `profesion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `nacimiento` datetime NOT NULL,
  PRIMARY KEY (`id_user`,`nombre`,`apellido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `DatosPersonales`
--

INSERT INTO `DatosPersonales` (`id_user`, `nombre`, `apellido`, `email`, `profesion`, `nacimiento`) VALUES
(1, 'Pablo', 'Antonio', 'pabloa@pabloa.com', 'estudiante', '2013-07-10 00:00:00'),
(2, 'Vanesa', 'Stricker', 'vane@vane.com', 'camarera', '2013-07-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `DatosTarjeta`
--

CREATE TABLE IF NOT EXISTS `DatosTarjeta` (
  `id_user` int(11) NOT NULL DEFAULT '0',
  `nro_tarjeta` int(11) NOT NULL,
  `vencimiento` datetime NOT NULL,
  PRIMARY KEY (`id_user`,`nro_tarjeta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Direccion`
--

CREATE TABLE IF NOT EXISTS `Direccion` (
  `calle` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nro` int(11) NOT NULL,
  `localidad` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `codigo_postal` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`calle`,`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Distribuido`
--

CREATE TABLE IF NOT EXISTS `Distribuido` (
  `id_av` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `asientos` int(11) NOT NULL,
  PRIMARY KEY (`id_av`,`id_clase`),
  KEY `FK_Distribuido_Clase` (`id_clase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Encuesta`
--

CREATE TABLE IF NOT EXISTS `Encuesta` (
  `id_encuesta` int(11) NOT NULL AUTO_INCREMENT,
  `viaja_frecuentemente` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `preferencias_de_comida` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `ciudades_elegidas` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `clase_mas_frecuente` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `epoca_mas_frecuente` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `acompaniantes` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_encuesta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Esta`
--

CREATE TABLE IF NOT EXISTS `Esta` (
  `id_av` int(11) NOT NULL,
  `calle` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nro` int(11) NOT NULL,
  PRIMARY KEY (`id_av`,`calle`,`nro`),
  KEY `FK_Esta_Calle` (`calle`,`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Estado`
--

CREATE TABLE IF NOT EXISTS `Estado` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `Estado`
--

INSERT INTO `Estado` (`id_estado`, `descripcion`) VALUES
(1, 'activa'),
(2, 'caducada');

-- --------------------------------------------------------

--
-- Table structure for table `Factura`
--

CREATE TABLE IF NOT EXISTS `Factura` (
  `id_user` int(11) NOT NULL,
  `calle` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nro` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`calle`,`nro`),
  KEY `FK_Factura_Calle` (`calle`,`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Hace`
--

CREATE TABLE IF NOT EXISTS `Hace` (
  `id_reserva` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_reserva`,`id_user`),
  KEY `FK_Hace_User` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Hace`
--

INSERT INTO `Hace` (`id_reserva`, `id_user`) VALUES
(7, 1),
(8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Pais`
--

CREATE TABLE IF NOT EXISTS `Pais` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `Pais`
--

INSERT INTO `Pais` (`id_pais`, `nombre`) VALUES
(1, 'argentina'),
(2, 'brasil');

-- --------------------------------------------------------

--
-- Table structure for table `Reserva`
--

CREATE TABLE IF NOT EXISTS `Reserva` (
  `id_reserva` int(11) NOT NULL AUTO_INCREMENT,
  `caducidad` datetime NOT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `FK_Reserva` (`id_estado`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `Reserva`
--

INSERT INTO `Reserva` (`id_reserva`, `caducidad`, `id_estado`) VALUES
(7, '2013-07-01 00:00:00', 1),
(8, '2013-07-02 00:00:00', 1),
(9, '2013-07-01 00:00:00', 1),
(10, '2013-07-01 00:00:00', 1),
(11, '2013-07-01 00:00:00', 1),
(12, '2013-07-01 00:00:00', 1),
(13, '2013-07-01 00:00:00', 1),
(14, '2013-07-01 00:00:00', 1),
(15, '2013-07-01 00:00:00', 1),
(16, '2013-07-01 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Responde`
--

CREATE TABLE IF NOT EXISTS `Responde` (
  `id_av` int(11) NOT NULL,
  `nro_tel` int(11) NOT NULL,
  PRIMARY KEY (`id_av`,`nro_tel`),
  KEY `FK_Responde_Tel` (`nro_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Servicio`
--

CREATE TABLE IF NOT EXISTS `Servicio` (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `salida` datetime NOT NULL,
  `llegada` datetime NOT NULL,
  `id_vuelo` int(11) NOT NULL,
  `id_av` int(11) NOT NULL,
  PRIMARY KEY (`id_servicio`),
  KEY `FK_Servicio_Vuelo` (`id_vuelo`),
  KEY `FK_Servicio_Avion` (`id_av`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `Servicio`
--

INSERT INTO `Servicio` (`id_servicio`, `salida`, `llegada`, `id_vuelo`, `id_av`) VALUES
(1, '2013-07-01 00:00:00', '2013-07-02 00:00:00', 1, 1),
(3, '2013-07-02 00:00:00', '2013-07-03 00:00:00', 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Telefono`
--

CREATE TABLE IF NOT EXISTS `Telefono` (
  `nro_tel` int(11) NOT NULL,
  PRIMARY KEY (`nro_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Tiene`
--

CREATE TABLE IF NOT EXISTS `Tiene` (
  `id_res` int(11) NOT NULL,
  `id_serv` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  PRIMARY KEY (`id_res`,`id_serv`,`id_clase`),
  KEY `FK_Tiene_Serv` (`id_serv`),
  KEY `FK_Tiene_Clase` (`id_clase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `Tiene`
--

INSERT INTO `Tiene` (`id_res`, `id_serv`, `id_clase`) VALUES
(7, 1, 1),
(8, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Tripulado`
--

CREATE TABLE IF NOT EXISTS `Tripulado` (
  `id_trip` int(11) NOT NULL,
  `id_av` int(11) NOT NULL,
  PRIMARY KEY (`id_trip`,`id_av`),
  KEY `FK_TripuladoAvion` (`id_av`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Tripulante`
--

CREATE TABLE IF NOT EXISTS `Tripulante` (
  `id_trip` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_trip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Usuario`
--

CREATE TABLE IF NOT EXISTS `Usuario` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nacionalidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  KEY `FK_Usuario` (`nacionalidad`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `Usuario`
--

INSERT INTO `Usuario` (`id_user`, `username`, `clave`, `nacionalidad`) VALUES
(1, 'pablo', 'pablo', 1),
(2, 'vane', 'vane', 1),
(3, 'nadia', 'nadia', 2),
(4, 'agus', 'agus', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Vive`
--

CREATE TABLE IF NOT EXISTS `Vive` (
  `id_user` int(11) NOT NULL,
  `calle` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nro` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`calle`,`nro`),
  KEY `FK_Vive_Calle` (`calle`,`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Vuelo`
--

CREATE TABLE IF NOT EXISTS `Vuelo` (
  `id_vuelo` int(11) NOT NULL AUTO_INCREMENT,
  `a_salida` int(11) NOT NULL,
  `a_llegada` int(11) NOT NULL,
  PRIMARY KEY (`id_vuelo`),
  KEY `FK_Vuelo_Salida` (`a_salida`),
  KEY `FK_Vuelo_Llega` (`a_llegada`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `Vuelo`
--

INSERT INTO `Vuelo` (`id_vuelo`, `a_salida`, `a_llegada`) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 1, 4),
(4, 1, 5);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Aeropuerto`
--
ALTER TABLE `Aeropuerto`
  ADD CONSTRAINT `FK_Aeropuerto` FOREIGN KEY (`id_ciudad`) REFERENCES `Ciudad` (`id_ciudad`);

--
-- Constraints for table `Atiende`
--
ALTER TABLE `Atiende`
  ADD CONSTRAINT `FK_Atiende_Tel` FOREIGN KEY (`nro_tel`) REFERENCES `Telefono` (`nro_tel`),
  ADD CONSTRAINT `FK_Atiende_User` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `Brinda`
--
ALTER TABLE `Brinda`
  ADD CONSTRAINT `FK_Brinda_Clase` FOREIGN KEY (`id_clase`) REFERENCES `Clase` (`id_clase`),
  ADD CONSTRAINT `FK_Brinda_Serv` FOREIGN KEY (`id_serv`) REFERENCES `Servicio` (`id_servicio`);

--
-- Constraints for table `Ciudad`
--
ALTER TABLE `Ciudad`
  ADD CONSTRAINT `FK_Ciudad` FOREIGN KEY (`id_pais`) REFERENCES `Pais` (`id_pais`);

--
-- Constraints for table `DatosPersonales`
--
ALTER TABLE `DatosPersonales`
  ADD CONSTRAINT `FK_Personales` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `DatosTarjeta`
--
ALTER TABLE `DatosTarjeta`
  ADD CONSTRAINT `FK_Tarjeta` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `Distribuido`
--
ALTER TABLE `Distribuido`
  ADD CONSTRAINT `FK_Distribuido_Avion` FOREIGN KEY (`id_av`) REFERENCES `Avion` (`id_avion`),
  ADD CONSTRAINT `FK_Distribuido_Clase` FOREIGN KEY (`id_clase`) REFERENCES `Clase` (`id_clase`);

--
-- Constraints for table `Esta`
--
ALTER TABLE `Esta`
  ADD CONSTRAINT `FK_Esta_Avion` FOREIGN KEY (`id_av`) REFERENCES `Avion` (`id_avion`),
  ADD CONSTRAINT `FK_Esta_Calle` FOREIGN KEY (`calle`, `nro`) REFERENCES `Direccion` (`calle`, `nro`);

--
-- Constraints for table `Factura`
--
ALTER TABLE `Factura`
  ADD CONSTRAINT `FK_Factura_Calle` FOREIGN KEY (`calle`, `nro`) REFERENCES `Direccion` (`calle`, `nro`),
  ADD CONSTRAINT `FK_Factura_User` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `Hace`
--
ALTER TABLE `Hace`
  ADD CONSTRAINT `FK_Hace_Reserva` FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`),
  ADD CONSTRAINT `FK_Hace_User` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `Reserva`
--
ALTER TABLE `Reserva`
  ADD CONSTRAINT `FK_Reserva` FOREIGN KEY (`id_estado`) REFERENCES `Estado` (`id_estado`);

--
-- Constraints for table `Responde`
--
ALTER TABLE `Responde`
  ADD CONSTRAINT `FK_Responde_Avion` FOREIGN KEY (`id_av`) REFERENCES `Avion` (`id_avion`),
  ADD CONSTRAINT `FK_Responde_Tel` FOREIGN KEY (`nro_tel`) REFERENCES `Telefono` (`nro_tel`);

--
-- Constraints for table `Servicio`
--
ALTER TABLE `Servicio`
  ADD CONSTRAINT `FK_Servicio_Avion` FOREIGN KEY (`id_av`) REFERENCES `Avion` (`id_avion`),
  ADD CONSTRAINT `FK_Servicio_Vuelo` FOREIGN KEY (`id_vuelo`) REFERENCES `Vuelo` (`id_vuelo`);

--
-- Constraints for table `Tiene`
--
ALTER TABLE `Tiene`
  ADD CONSTRAINT `FK_Tiene_Clase` FOREIGN KEY (`id_clase`) REFERENCES `Clase` (`id_clase`),
  ADD CONSTRAINT `FK_Tiene_Res` FOREIGN KEY (`id_res`) REFERENCES `Reserva` (`id_reserva`),
  ADD CONSTRAINT `FK_Tiene_Serv` FOREIGN KEY (`id_serv`) REFERENCES `Servicio` (`id_servicio`);

--
-- Constraints for table `Tripulado`
--
ALTER TABLE `Tripulado`
  ADD CONSTRAINT `FK_TripuladoAvion` FOREIGN KEY (`id_av`) REFERENCES `Avion` (`id_avion`),
  ADD CONSTRAINT `FK_TripuladoTrip` FOREIGN KEY (`id_trip`) REFERENCES `Tripulante` (`id_trip`);

--
-- Constraints for table `Usuario`
--
ALTER TABLE `Usuario`
  ADD CONSTRAINT `FK_Usuario` FOREIGN KEY (`nacionalidad`) REFERENCES `Pais` (`id_pais`);

--
-- Constraints for table `Vive`
--
ALTER TABLE `Vive`
  ADD CONSTRAINT `FK_Vive_Calle` FOREIGN KEY (`calle`, `nro`) REFERENCES `Direccion` (`calle`, `nro`),
  ADD CONSTRAINT `FK_Vive_User` FOREIGN KEY (`id_user`) REFERENCES `Usuario` (`id_user`);

--
-- Constraints for table `Vuelo`
--
ALTER TABLE `Vuelo`
  ADD CONSTRAINT `FK_Vuelo_Llega` FOREIGN KEY (`a_llegada`) REFERENCES `Aeropuerto` (`id_a`),
  ADD CONSTRAINT `FK_Vuelo_Salida` FOREIGN KEY (`a_salida`) REFERENCES `Aeropuerto` (`id_a`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
