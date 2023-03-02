-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.24-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sisgeva
CREATE DATABASE IF NOT EXISTS `sisgeva` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `sisgeva`;

-- Volcando estructura para tabla sisgeva.area
CREATE TABLE IF NOT EXISTS `area` (
  `id_area` int(5) NOT NULL AUTO_INCREMENT,
  `nom_area` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.area: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`id_area`, `nom_area`) VALUES
	(1, 'Administrativa'),
	(2, 'Operativa');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `idCargo` int(2) NOT NULL AUTO_INCREMENT,
  `nombreCargo` varchar(50) NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.cargos: ~57 rows (aproximadamente)
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` (`idCargo`, `nombreCargo`) VALUES
	(1, 'Abogada'),
	(2, 'Agente'),
	(3, 'Asistente direccion laboratorio'),
	(4, 'ATM'),
	(6, 'Aux de Calidad'),
	(7, 'Aux Comercial'),
	(8, 'Aux de Compras'),
	(9, 'Aux de Contabilidad'),
	(10, 'Aux de Auditoría'),
	(11, 'Aux de Cartera'),
	(12, 'Aux de Facturación'),
	(13, 'Aux de Ingreso'),
	(14, 'Aux de Ingreso 24'),
	(15, 'Aux de Laboratorio 48 Asistencia'),
	(16, 'Aux de Laboratorio'),
	(17, 'Aux de Laboratorio 24'),
	(18, 'Aux de Laboratorio 48'),
	(19, 'Aux de Nómina'),
	(20, 'Aux de Recursos Físicos'),
	(21, 'Aux de Sistemas'),
	(22, 'Aux de  Tesorería'),
	(23, 'Bacteriologo'),
	(24, 'Cajero'),
	(25, 'Citohistología'),
	(26, 'Coordinadora de Sedes'),
	(27, 'Coordinador contable'),
	(28, 'Coordinador de Sede'),
	(29, 'Coordinador de Recursos Físicos'),
	(30, 'Coordinadora compras'),
	(31, 'Coordinadora contabilidad'),
	(32, 'Coordinadora de facturacion'),
	(33, 'Coordinador sistemas'),
	(34, 'Coordinadora talento humano'),
	(35, 'Director Admon'),
	(36, 'Director de Calidad'),
	(37, 'Director Comercial'),
	(38, 'Director de Laboratorio'),
	(39, 'Gerente'),
	(40, 'Gestión documental'),
	(41, 'Mercadeo'),
	(42, 'Orientación'),
	(43, 'Orientador de Sala'),
	(44, 'Prof Bacteriologo 36'),
	(45, 'Prof Bacteriologo 48'),
	(46, 'Prof Mantenimiento de Equipo Biomédico'),
	(47, 'Prof Auditora'),
	(48, 'Prof SG-SST'),
	(49, 'Recursos Físicos'),
	(50, 'Secretaria Cliníca Sede'),
	(51, 'Secretaria Cliníca'),
	(52, 'Secretario Cliníco'),
	(53, 'Servicios Generales'),
	(54, 'Sistemas'),
	(55, 'Supernumerario Admon'),
	(56, 'Tecn en Automatización Electrónica'),
	(57, 'Tecn en Mantenimiento de Equipo Biomédico'),
	(58, 'Tecn en Gestión Documental');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` int(10) NOT NULL,
  `empleado` varchar(50) NOT NULL,
  `cargo` int(3) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `fechaContrato` date NOT NULL,
  `area` int(1) NOT NULL,
  `roll` int(1) NOT NULL,
  `sede` int(2) NOT NULL,
  `dias_vac_apro` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_empleado`) USING BTREE,
  KEY `cargo` (`cargo`),
  KEY `area` (`area`),
  KEY `sede` (`sede`),
  KEY `roll` (`roll`),
  CONSTRAINT `area_fk2` FOREIGN KEY (`area`) REFERENCES `area` (`id_area`),
  CONSTRAINT `cargo_fk1` FOREIGN KEY (`cargo`) REFERENCES `cargos` (`idCargo`),
  CONSTRAINT `roll_fk4` FOREIGN KEY (`roll`) REFERENCES `rol` (`id_rol`),
  CONSTRAINT `sede_fk3` FOREIGN KEY (`sede`) REFERENCES `sede` (`id_sede`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.empleado: ~207 rows (aproximadamente)
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` (`id_empleado`, `empleado`, `cargo`, `email`, `password`, `fechaContrato`, `area`, `roll`, `sede`, `dias_vac_apro`) VALUES
	(6767, 'l', 12, NULL, '90', '2020-06-09', 1, 4, 1, 2),
	(9090, 'kk', 3, NULL, '70', '2022-06-10', 1, 2, 1, 0),
	(5258747, 'Gerardo Rodriguez', 51, NULL, '5258747', '2019-10-01', 1, 4, 1, 28),
	(12748138, 'Ever Frascisco Portilla Quelal', 8, NULL, '12748138', '2018-12-13', 1, 4, 1, 30),
	(12975554, 'Celio Cesar Martinez Guerrero', 57, NULL, '12975554', '2010-06-01', 1, 4, 1, 150),
	(13065567, 'Jesus Adrian Marcillo', 40, NULL, '13065567', '2018-06-18', 2, 4, 1, 15),
	(13068205, 'Omar Wilson Abaonza Ñanñez', 55, NULL, '13068205', '2021-08-09', 1, 4, 1, 0),
	(24336876, 'Ángela Inces Ceballos Pantoja', 47, NULL, '24336876', '2015-11-01', 2, 4, 3, 90),
	(27081684, 'Monica Sophia Lombana Salazar', 25, NULL, '27081684', '2016-02-01', 2, 4, 1, 75),
	(27087003, 'Carolina Alexandra Benavides Salazar', 17, NULL, '27087003', '2018-02-01', 2, 4, 1, 45),
	(27088303, 'Claudia Margoth Obando', 55, NULL, '27088303', '2016-07-14', 1, 4, 1, 68),
	(27090741, 'Bernarda Elizabeth Zarama ', 55, NULL, '27090741', '2018-10-01', 1, 4, 1, 45),
	(27091687, 'Magda Yamile Leon Eraso', 14, NULL, '27091687', '2021-01-14', 1, 4, 1, 15),
	(27091977, 'Janella Cristina López Zambrano', 38, NULL, '27091977', '2011-06-01', 1, 4, 1, 143),
	(27098287, 'Niye Faride Ceron Cordoba                         ', 7, NULL, NULL, '2017-08-05', 1, 4, 1, 45),
	(27105603, 'Rosa Milena Valencia', 19, NULL, NULL, '2017-10-02', 2, 4, 3, 45),
	(27110070, 'Dayra Liliana Rosero Erazo ', 17, NULL, NULL, '2019-02-19', 2, 4, 1, 30),
	(27197590, 'Graciela del Socorro Zamudio David', 41, NULL, NULL, '2010-11-01', 1, 4, 1, 150),
	(27221002, 'Daira Magaly Rosales Zuñiga', 44, NULL, NULL, '2021-10-20', 2, 4, 1, 0),
	(27255084, 'Nuri Patricia Quenguan Ascuntar', 18, NULL, NULL, '2021-08-06', 2, 4, 3, 0),
	(27281105, 'Annarbey Liliana Davila Burbano              ', 17, NULL, NULL, '2019-09-23', 2, 4, 6, 30),
	(27281486, 'Marinela Aguilar Rangel                           ', 17, NULL, NULL, '2019-09-23', 2, 4, 6, 30),
	(30725172, 'Gladys Soledad Zamudio David', 5, NULL, NULL, '2019-02-25', 1, 4, 1, NULL),
	(36751564, 'Laura Amanda Torres Lopez', 37, NULL, NULL, '2020-02-17', 1, 4, 1, 24),
	(36752850, 'Sandra Milena Campaña', 26, NULL, NULL, '2021-10-19', 1, 4, 1, 0),
	(36950781, 'Maritza Isabella Coral Chavez                     ', 17, NULL, NULL, '2016-06-01', 2, 4, 1, 75),
	(36953126, 'Mariluz Rivera Moncayo', 17, NULL, NULL, '2016-04-01', 2, 4, 1, 75),
	(37009249, 'Lidia del Carmen Bolaños ', 52, NULL, NULL, '2012-02-01', 2, 4, 3, 135),
	(37080145, 'Johanna Sirley Hache Lasso                        ', 17, NULL, NULL, '2018-12-03', 2, 4, 1, 45),
	(37080427, 'Yolima Viviana Betancourt Toro', 13, NULL, NULL, '2017-03-01', 1, 4, 1, 69),
	(37082054, 'Luz Dary Gomez Villota', 44, NULL, NULL, '2019-06-01', 2, 4, 1, 15),
	(37082745, 'Doris Emilse Madroñero Villota', 23, NULL, NULL, '2022-04-01', 1, 4, 1, 0),
	(38640609, 'Catalina Rios Escobar', 52, NULL, NULL, '2015-11-01', 2, 4, 2, 90),
	(42060059, 'María Orfa Montoya Carmona', 16, NULL, NULL, '2011-06-01', 2, 4, 3, 150),
	(52291163, 'Aida Stella Bastidas Bastidas', 55, NULL, NULL, '2019-10-16', 1, 4, 1, 15),
	(56085698, 'Ana Maria Niebles Rojas', 25, NULL, NULL, '2021-05-21', 2, 4, 1, 0),
	(59312036, 'Diana Yurani Acosta Patiño                        ', 17, NULL, NULL, '2019-04-29', 2, 4, 1, 30),
	(59312815, 'María Constanza Aguilar Rendón', 6, NULL, NULL, '2015-11-01', 1, 4, 1, 75),
	(59314476, 'Sandra Ruby Portilla Legarda', 17, NULL, NULL, '2021-04-09', 2, 4, 1, 0),
	(59670263, 'Julia Gonzalez Guevara', 19, NULL, NULL, '2018-07-03', 2, 4, 2, 45),
	(59677588, 'Delly Suleiby Magallanes Castro', 18, NULL, NULL, '2020-10-01', 2, 4, 2, 15),
	(59679495, 'Adriana Aguirre Solis', 19, NULL, NULL, '2020-10-05', 2, 4, 2, 0),
	(59680777, 'Ruby Anelsy Belalcazar Preciado', 55, NULL, NULL, '2021-03-15', 1, 4, 1, 15),
	(59686802, 'Aura Veronica Aguirre Micolta', 28, NULL, NULL, '2019-09-23', 2, 4, 2, 26),
	(59690264, 'Magola Elizabeth Cabrera Gustin', 17, NULL, NULL, '2021-01-05', 2, 4, 1, 4),
	(59706427, 'Maricela Cifuentes Rivera                  ', 17, NULL, NULL, '2019-09-23', 2, 4, 4, 26),
	(59794189, 'Maria Orfil Diaz Torres                         ', 17, NULL, NULL, '2011-06-14', 2, 4, 1, 150),
	(59814409, 'Sandra Mercedes Lopez Lopez', 55, NULL, NULL, '2020-10-01', 1, 4, 1, 15),
	(59816776, 'Myriam Yolanda Nieves Diaz', 42, NULL, NULL, '2019-06-01', 1, 4, 1, 15),
	(59816833, 'Martha Elisa Lopez Martinez', 17, NULL, NULL, '2021-06-21', 2, 4, 1, 0),
	(59817036, 'Liliana del Socorro Narvaez Albornos', 17, NULL, NULL, '2012-05-02', 2, 4, 1, 135),
	(59820068, 'Monica del Carmen Mejia Hidrobo', 55, NULL, NULL, '2020-11-17', 1, 4, 1, 0),
	(59820081, 'Ximena del Carmen Reina Ceballos', 17, NULL, NULL, '2017-07-25', 2, 4, 1, 60),
	(59822447, 'Sandra Patricia Gomajoa López', 26, NULL, NULL, '2015-11-01', 1, 4, 1, 75),
	(59823053, 'Victoria Eugenia Risueño Salazar', 25, NULL, NULL, '2014-03-03', 2, 4, 1, 105),
	(59824101, 'Lorena Patricia Velasquez Martinez', 17, NULL, NULL, '2017-02-20', 2, 4, 1, 60),
	(59826752, 'Paula Andrea Moncayo Zamudio', 53, NULL, NULL, '2019-07-08', 2, 4, 1, 30),
	(59828162, 'Andrea Eliana Ruano Pantoja', 2, NULL, NULL, '2021-06-02', 1, 4, 1, 0),
	(59832242, 'Andrea Marcela Bolaños Bravo', 25, NULL, NULL, '2016-06-01', 2, 4, 1, 75),
	(59832534, 'Nubia Liliana Burbano Eraso                      ', 17, NULL, NULL, '2016-04-14', 2, 4, 1, 75),
	(59837558, 'Floralba Portilla Armero', 32, NULL, NULL, '2011-01-11', 1, 4, 1, 150),
	(59837635, 'Sandra Patricia Enriquez Aza ', 17, NULL, NULL, '2021-04-09', 2, 4, 1, 15),
	(60410634, 'Luz Naeydu Sanchez Orozco', 33, NULL, NULL, '2019-09-05', 1, 4, 1, 30),
	(66862664, 'Ana Lidia Guerra Florez', 28, NULL, NULL, '2013-01-01', 2, 4, 3, 120),
	(67045008, 'Jennifer Alexandra Gallego Taimal', 25, NULL, NULL, '2015-11-01', 2, 4, 1, 75),
	(87066251, 'Darío Fernando Guerrero Quintero', 35, NULL, NULL, '2017-04-29', 1, 4, 1, 60),
	(87068752, 'Cesar Alexander Martinez Zamudio', 4, NULL, NULL, '2018-09-01', 2, 4, 1, 45),
	(87090162, 'Wilmar Javier Derazo Caliz', 55, NULL, NULL, '2021-03-10', 1, 4, 1, 15),
	(87103421, 'Jose Miguel Buesaco Vela', 41, NULL, NULL, '2022-02-01', 1, 4, 1, 0),
	(87303681, 'Javier Andres Solarte', 12, NULL, NULL, '2021-06-16', 2, 4, 1, 0),
	(87710936, 'JESUS HORACIO BENAVIDES MORENO', 15, NULL, NULL, '2022-03-08', 2, 4, 3, 0),
	(87948036, 'Jorge Enrique Rodriguez Carabali', 46, NULL, NULL, '2021-08-11', 2, 4, 2, 0),
	(98332479, 'José Fernando Zamudio David', 39, NULL, NULL, '2014-02-01', 1, 4, 1, 108),
	(98380887, 'Mario Fernando Insuasty Insuasty', 25, NULL, NULL, '2011-11-15', 2, 4, 1, 150),
	(98385449, 'Mauricio Hernando Martínez Botina', 59, NULL, NULL, '2019-04-15', 1, 4, 1, NULL),
	(98385645, 'Omar Arturo Mera ', 17, NULL, NULL, '2017-02-22', 2, 4, 1, 60),
	(98396726, 'Edwin John Rubio Trejo ', 56, NULL, NULL, '2018-02-05', 1, 4, 1, 45),
	(98398649, 'Nelson Omar Rivera Erazo', 17, NULL, NULL, '2017-10-21', 2, 4, 1, 60),
	(1004191142, 'Jonny Jamer Ruales Calderon', 8, NULL, NULL, '2021-10-04', 1, 4, 1, 0),
	(1004214122, 'Cristian David Portilla Estrada', 17, NULL, NULL, '2020-11-17', 2, 4, 1, 0),
	(1004438572, 'Roxana Stephanie Gonzales Botina', 53, NULL, NULL, '2019-01-15', 2, 4, 1, 45),
	(1004535303, 'Einer Alejandro Enriquez Vargas', 8, NULL, NULL, '2022-02-14', 1, 4, 1, 0),
	(1004770711, 'Angie Paola Arteaga Pantoja                       ', 2, NULL, NULL, '2019-11-25', 1, 4, 1, 30),
	(1010082290, 'Dayana Katherine Paz', 53, NULL, NULL, '2019-06-01', 2, 4, 1, 30),
	(1010108120, 'Alejandro Efrain Bravo', 17, NULL, NULL, '2021-06-17', 2, 4, 1, 0),
	(1010130363, 'Ingrid Dayana Lopez Vallejo', 12, NULL, NULL, '2021-07-06', 2, 4, 1, 0),
	(1010224627, 'Liana Katherine Diaz Rodriguez', 25, NULL, NULL, '2019-02-01', 2, 4, 1, 45),
	(1019061663, 'Yodi Vanessa  Cabrera Botin', 17, NULL, NULL, '2018-12-01', 2, 4, 1, 30),
	(1036401410, 'Laura Cristina Arcila Castrillon', 25, NULL, NULL, '2019-07-23', 2, 4, 1, 30),
	(1048274331, 'Cindy Lorena Castellanos Gonzales ', 30, NULL, NULL, '2018-04-06', 2, 4, 1, 45),
	(1053776108, 'Lorena Alexandra Ruiz Salas', 25, NULL, NULL, '2015-07-14', 2, 4, 1, 90),
	(1053825404, 'Nathalia Gamboa Agreda', 25, NULL, NULL, '2017-10-01', 2, 4, 1, 60),
	(1072700170, 'Daniela Bustos Ramirez', 2, NULL, NULL, '2020-11-03', 1, 4, 1, 7),
	(1080046963, 'Maria Camila Moreno', 26, NULL, NULL, '2021-10-26', 1, 4, 1, 0),
	(1082105193, 'Dora Ximena Caliz', 19, NULL, NULL, '2019-06-01', 2, 4, 3, 21),
	(1084223950, 'Danilo Andres Urbano Davila', 4, NULL, NULL, '2019-07-05', 2, 4, 1, 30),
	(1084227957, 'Maria Alejandra Portilla Rodriguez', 1, NULL, NULL, '2021-07-07', 1, 4, 1, 0),
	(1085248872, 'Yecsenia Elizabeth  Morales Zambrano', 21, NULL, NULL, '2021-10-01', 1, 4, 1, 0),
	(1085249944, 'Leidy Viviana Achicanoy Pantoja', 12, NULL, NULL, '2021-07-06', 2, 4, 1, 0),
	(1085250088, 'Daisy Johana Martinez Isacas', 17, NULL, NULL, '2015-02-01', 2, 4, 1, 90),
	(1085250558, 'Ana Elizabeth Rosero Cuastumal', 34, NULL, NULL, '2017-02-22', 1, 4, 1, 72),
	(1085250990, 'Nelly Alexandra Canchala Rosero                   ', 17, NULL, NULL, '2008-05-20', 2, 4, 1, 195),
	(1085252052, 'Erika Lorena Marcillo Villota                     ', 17, NULL, NULL, '2014-03-03', 2, 4, 1, 105),
	(1085252522, 'Andrea Liliana Burbano Chaves', 49, NULL, NULL, '2017-05-02', 1, 4, 1, 65),
	(1085258578, 'Liliana Cristina Enriquez Prado', 25, NULL, NULL, '2020-08-01', 2, 4, 1, 15),
	(1085260232, 'Mariam Amanda Gomez Villota', 44, NULL, NULL, '2019-12-22', 2, 4, 1, 30),
	(1085262461, 'Grace Sthefania Diaz Polo', 24, NULL, NULL, '2019-03-19', 1, 4, 1, 30),
	(1085262567, 'Nataly del Rocio Portilla Martinez', 3, NULL, NULL, '2010-07-01', 2, 4, 1, 150),
	(1085269472, 'Jesus Hernan Ceron Portilla', 9, NULL, NULL, '2018-07-05', 1, 4, 1, 30),
	(1085274489, 'Edwin Stiven Bernal', 56, NULL, NULL, '2019-11-29', 1, 4, 1, 30),
	(1085276178, 'Angie Elizabeth Bolaños Ortiez', 12, NULL, NULL, '2021-10-21', 2, 4, 1, 0),
	(1085279275, 'Nibia Mercedes Yaqueno Criollo', 17, NULL, NULL, '2021-01-20', 2, 4, 1, 15),
	(1085281137, 'Johana Catherine Chaves Obando', 53, NULL, NULL, '2021-04-14', 2, 4, 1, 15),
	(1085281859, 'Yubi Yesenia Chaves Lopez', 5, NULL, NULL, '2021-01-14', 1, 4, 1, NULL),
	(1085290016, 'Cristian Danilo Obando Pachicana', 4, NULL, NULL, '2017-02-01', 2, 4, 1, 60),
	(1085291052, 'Camila Alexandra Ortega Diaz', 17, NULL, NULL, '2021-01-04', 2, 4, 1, 15),
	(1085291247, 'Elizabeth Milena Meneses Narvaez', 25, NULL, NULL, '2017-07-01', 2, 4, 1, 60),
	(1085292022, 'Daniel Fernando Estrada Vallejo', 9, NULL, NULL, '2020-12-19', 1, 4, 1, 7),
	(1085293525, 'Jeraldine Estefanía Rodríguez Alvear', 53, NULL, NULL, '2018-12-01', 2, 4, 1, 45),
	(1085294228, 'Gavy Andrea Narvaez Rodriguez', 17, NULL, NULL, '2021-07-02', 2, 4, 1, 0),
	(1085295497, 'Ginna Camila Timaran Vallejo', 17, NULL, NULL, '2014-04-01', 2, 4, 1, 105),
	(1085295774, 'Juan David Ordoñez Reina', 2, NULL, NULL, '2020-07-23', 1, 4, 1, 0),
	(1085295979, 'Jeferson David Villota Benavides', 8, NULL, NULL, '2017-11-24', 1, 4, 1, 45),
	(1085297523, 'Bolivar Daniel David Medina ', 48, NULL, NULL, '2021-03-04', 1, 4, 1, 0),
	(1085297547, 'Jenny Milena Burbano Ardila', 50, NULL, NULL, '2021-08-13', 1, 4, 1, 0),
	(1085298655, 'Zaira Melina Estrada Tobar ', 43, NULL, NULL, '2022-01-06', 1, 4, 1, 0),
	(1085299623, 'Diana Marcela Timana Guerrero', 53, NULL, NULL, '2015-07-09', 2, 4, 1, 90),
	(1085302427, 'Oskar Daniel Guerrero Quintero', 58, NULL, NULL, '2021-08-02', 1, 4, 1, 0),
	(1085303335, 'Diana Carolina Bolaños Bolaños', 17, NULL, NULL, '2021-10-26', 2, 4, 1, 0),
	(1085305381, 'Geovanna Delgado Romero', 9, NULL, NULL, '2017-12-06', 1, 4, 1, 45),
	(1085306111, 'Carolina Estefania Portilla Gomojoa', 27, NULL, NULL, '2016-12-15', 2, 4, 1, 75),
	(1085307362, 'Johan Sebastian Guerrero Benavides', 13, NULL, NULL, '2019-03-18', 1, 4, 1, 38),
	(1085308139, 'Andres José Morales Pantoja', 29, NULL, NULL, '2021-02-08', 1, 4, 1, 0),
	(1085308674, 'Daniel Alejandro Nausil Gomez', 17, NULL, NULL, '2019-06-01', 2, 4, 1, 30),
	(1085309262, 'Lucy Andrea Arciniegas Pasuy', 12, NULL, NULL, '2021-09-13', 2, 4, 1, 0),
	(1085310151, 'Dayana Jisselle Delgado Andrade', 2, NULL, NULL, '2017-08-19', 1, 4, 1, 60),
	(1085314171, 'Laura Victoria Martinez Jurado', 13, NULL, NULL, '2021-07-12', 1, 4, 1, 0),
	(1085314964, 'Diana Carolina Aza Villacorte ', 17, NULL, NULL, '2020-02-05', 2, 4, 1, 15),
	(1085315181, 'Jhon Edisson Díaz Villota', 48, NULL, NULL, '2017-06-20', 1, 4, 1, 45),
	(1085315462, 'Catherine Camila Lopez Ipujan', 44, NULL, NULL, '2021-09-01', 2, 4, 1, 0),
	(1085318778, 'Tatiana Katherine Arciniegas Portilla', 12, NULL, NULL, '2021-07-07', 2, 4, 1, 0),
	(1085318953, 'Nelson Dario Larrera Benavides', 59, NULL, NULL, '2019-12-03', 1, 4, 1, NULL),
	(1085318986, 'Paola Andrea Ordoñez Ceron', 53, NULL, NULL, '2020-10-22', 2, 4, 1, 15),
	(1085319720, 'Ruben Dario Ordoñez Reina', 17, NULL, NULL, '2017-12-04', 2, 4, 1, 45),
	(1085321697, 'Maria Fernanda Lopez Potosi', 5, NULL, NULL, '2021-10-19', 1, 4, 1, NULL),
	(1085327903, 'Nathaly Martínez Barrera', 53, NULL, NULL, '2017-07-01', 2, 4, 1, 60),
	(1085328139, 'Helmer Adrián Almeida Almeida', 22, NULL, NULL, '2017-01-01', 1, 4, 1, 60),
	(1085329666, 'Einer Danilo Yarpaz Zambrano ', 17, NULL, NULL, '2015-11-01', 2, 4, 1, 90),
	(1085330506, 'Santiago Armando Jaramillo Lozano', 20, NULL, NULL, '2018-06-01', 1, 4, 1, 45),
	(1085331545, 'Ingrid Lorena Arcos Castillo                      ', 17, NULL, NULL, '2019-06-04', 2, 4, 1, 30),
	(1085332183, 'Ivan Andres Delgado Josa                          ', 17, NULL, NULL, '2019-06-01', 2, 4, 1, 30),
	(1085333569, 'Luisa Carmenza Bernal Londoño                     ', 17, NULL, NULL, '2019-11-18', 2, 4, 1, 30),
	(1085334011, 'Brayan Steven Rivera Chaves', 13, NULL, NULL, '2021-12-20', 1, 4, 1, 0),
	(1085335371, 'José Esteban Achicanoy Tulcán', 7, NULL, NULL, '2017-01-01', 1, 4, 1, 60),
	(1085337070, 'Jhon Carlos Rojas Pesillo', 4, NULL, NULL, '2019-02-01', 2, 4, 1, 30),
	(1085337670, 'Paola Andrea Morales Rodriguez              ', 11, NULL, NULL, '2021-11-25', 1, 4, 1, 0),
	(1085338450, 'Elisa Gabriela Chaves Lopez', 44, NULL, NULL, '2021-09-01', 2, 4, 1, 0),
	(1085338477, 'July Daniela Burbano Gonzales', 2, NULL, NULL, '2019-06-01', 1, 4, 1, 30),
	(1085339223, 'Jose Emilio  Martinez Barrera', 60, NULL, NULL, '2022-04-01', 1, 4, 1, NULL),
	(1085343025, 'Nathalia Estefania Pérdomo Solarte', 53, NULL, NULL, '2018-12-03', 2, 4, 1, 45),
	(1085343372, 'Adriana Yisela Bastidas Joajinoy', 17, NULL, NULL, '2021-02-02', 2, 4, 1, 15),
	(1085343438, 'Dayan Estefania Morales Romero', 17, NULL, NULL, '2022-01-18', 2, 4, 1, 0),
	(1085345449, 'Dilan Stiven Ojeda Osorio', 44, NULL, NULL, '2022-03-16', 2, 4, 1, 0),
	(1085660750, 'Sandra Marcela Farninango Bolaños                ', 17, NULL, NULL, '2019-09-23', 2, 4, 5, 30),
	(1085897940, 'Diego Fernando Guancha Chalapud', 24, NULL, NULL, '2021-05-10', 1, 4, 1, 15),
	(1085901777, 'Yovana Marcela Termal Trejo', 15, NULL, NULL, '2021-08-06', 2, 4, 3, 0),
	(1085903070, 'Yuly Carolina Palacios Ortega', 19, NULL, NULL, '2018-05-02', 2, 4, 3, 45),
	(1085904946, 'Diana cecilia vera cabrera', 52, NULL, NULL, '2015-11-01', 2, 4, 3, 90),
	(1085906212, 'Diana Elizabeth Murillo Patiño', 19, NULL, NULL, '2015-11-01', 2, 4, 3, 75),
	(1085908330, 'Ángela María Lara Figueroa ', 31, NULL, NULL, '2019-06-01', 1, 4, 1, 30),
	(1085910867, 'Yaneth Aracely Quiroz Bonilla', 26, NULL, NULL, '2019-06-01', 2, 4, 3, 30),
	(1085920002, 'Omar  Yucep Narvaez Segovia', 19, NULL, NULL, '2021-06-08', 2, 4, 3, 0),
	(1085938947, 'Gladys del Carmen Ibarra Escobar', 18, NULL, NULL, '2021-08-06', 2, 4, 3, 0),
	(1085948399, 'Paola Andrea Bastidas Lopez', 17, NULL, NULL, '2021-05-04', 2, 4, 1, 0),
	(1085951726, 'Neira Estefania Cuasapud Leon', 15, NULL, NULL, '2021-10-04', 2, 4, 3, 0),
	(1086019628, 'Neider Alexander Riascos Lopez', 53, NULL, NULL, '2021-08-02', 2, 4, 1, 0),
	(1086328793, 'Luis Alberto Ojeda Vásquez', 59, NULL, NULL, '2015-11-01', 1, 4, 1, NULL),
	(1086332730, 'Luisa fernanda ortega pinta', 17, NULL, NULL, '2017-11-07', 2, 4, 1, 60),
	(1086362089, 'Johana Milena Criollo', 7, NULL, NULL, '2019-03-01', 1, 4, 1, 45),
	(1086697364, 'Karen Yuliana Rojas Narvaez', 13, NULL, NULL, '2018-12-20', 1, 4, 1, 45),
	(1086754485, 'Yuri Paola Enriquez Figueroa                    ', 45, NULL, NULL, '2019-06-01', 2, 4, 3, 30),
	(1086754859, 'Maria Yesenia Quistial', 15, NULL, NULL, '2021-07-01', 2, 4, 3, 0),
	(1086756713, 'Maira Alejandra Vallejo Ortega         ', 18, NULL, NULL, '2021-11-26', 2, 4, 3, 0),
	(1087108308, 'Harry Quiñonez Quiñones', 45, NULL, NULL, '2022-01-28', 2, 4, 2, 0),
	(1087113950, 'Leidy  Natalia Biojo Angulo                       ', 17, NULL, NULL, '2016-06-01', 2, 4, 1, 75),
	(1087130630, 'Vanessa Yajaira Quiñones', 19, NULL, NULL, '2021-03-15', 2, 4, 2, 0),
	(1087188353, 'Daniela Yissell Hurtado Noguera', 19, NULL, NULL, '2021-08-06', 2, 4, 2, 0),
	(1087189134, 'Sandra Lorena Montaño Montaño', 10, NULL, NULL, '2021-04-06', 2, 4, 2, 0),
	(1087406270, 'Danitza Cuaces Erazo', 26, NULL, NULL, '2021-07-07', 1, 4, 1, 0),
	(1087423172, 'Eliana Andrea Cuastumal Mayag', 44, NULL, NULL, '2022-03-16', 2, 4, 1, 0),
	(1088590225, 'Doris Alicia Calderon Chuquizan', 25, NULL, NULL, '2018-06-15', 2, 4, 1, 45),
	(1088970907, 'Wilder Ricardo Bolaños Bolañoz             ', 54, NULL, NULL, '2019-09-24', 2, 4, 6, 30),
	(1089030529, 'Diana Marcela Yela Ortega', 25, NULL, NULL, '2018-12-01', 2, 4, 1, 30),
	(1089196982, 'Angie Carolina Pupiales Moreno', 53, NULL, NULL, '2019-03-06', 2, 4, 1, 30),
	(1100622070, 'Carmen Lucia Rambaut Donado', 25, NULL, NULL, '2019-03-01', 2, 4, 1, 45),
	(1107073090, 'Yury Amalfi Guevara Nuñez', 2, NULL, NULL, '2018-02-12', 1, 4, 1, 45),
	(1131084436, 'Manuel Alejandro Zamudio Enriquez', 54, NULL, NULL, '2021-02-15', 2, 4, 2, 0),
	(1143855367, 'Dayana Andrea Latorrez Corcho', 53, NULL, NULL, '2017-01-01', 2, 4, 1, 60),
	(1144063648, 'Stephanny Alejandra Rojas Trujillo', 36, NULL, NULL, '2018-01-16', 1, 4, 1, 45),
	(1144075915, 'Paula Fernanda Jurado Ortega', 12, NULL, NULL, '2021-10-19', 2, 4, 1, 0),
	(1193033051, 'Angie Lorena Urbano Cantuca', 17, NULL, NULL, '2021-06-17', 2, 4, 1, 0),
	(1193393535, 'Nathalia Lizeth Gualguan Gualguan', 13, NULL, NULL, '2021-06-01', 1, 4, 1, 0),
	(1193543201, 'Salas Mosquera  Jader Ivan', 54, NULL, NULL, '2021-08-13', 2, 4, 2, 0),
	(1233191612, 'Victor M. Benavides Estrada', 5, NULL, NULL, '2021-06-15', 1, 4, 1, NULL),
	(1233191770, 'Xiomara Karina Revelo Cordoba', 17, NULL, NULL, '2021-01-13', 2, 4, 1, 15),
	(1233193128, 'Juan Felipe Lasso Rosero', 44, NULL, NULL, '2022-02-07', 2, 4, 1, 0),
	(1233194173, 'Aura Jimena de la cruz Vallejos', 17, NULL, NULL, '2021-07-21', 2, 4, 1, 0),
	(2147483647, 'Prueba', 54, NULL, '0000', '2018-02-10', 2, 3, 1, 42);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.estado_solicitud
CREATE TABLE IF NOT EXISTS `estado_solicitud` (
  `id_estado` int(5) NOT NULL AUTO_INCREMENT,
  `nom_estado` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.estado_solicitud: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `estado_solicitud` DISABLE KEYS */;
INSERT INTO `estado_solicitud` (`id_estado`, `nom_estado`) VALUES
	(1, 'Enviada'),
	(2, 'En revisión'),
	(3, 'Aprobada'),
	(4, 'Suspendida'),
	(5, 'Rechazada');
/*!40000 ALTER TABLE `estado_solicitud` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.feriados
CREATE TABLE IF NOT EXISTS `feriados` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fecha_mes_dia` varchar(5) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.feriados: ~18 rows (aproximadamente)
/*!40000 ALTER TABLE `feriados` DISABLE KEYS */;
INSERT INTO `feriados` (`id`, `fecha_mes_dia`, `tipo`, `descripcion`) VALUES
	(1, '01-01', 'Fijo', 'Año nuevo'),
	(2, '01-06', 'Móvil', 'Día de los Reyes Magos'),
	(3, '03-19', 'Móvil', 'Día de San José '),
	(4, '04-14', 'Fijo', 'Semana Santa '),
	(5, '04-15', 'Fijo', 'Semana Santa '),
	(6, '05-01', 'Fijo', 'Día de los Trabajadores'),
	(7, '05-26', 'Móvil', 'Día de la Ascensión'),
	(8, '06-16', 'Móvil', 'Corpus Christi'),
	(9, '06-27', 'Fijo', 'Día del Sagrado Corazón de Jesús'),
	(10, '06-29', 'Móvil', 'Día de San Pedro y San Pablo'),
	(11, '07-20', 'Fijo', 'Independencia de Colombia'),
	(12, '08-07', 'Fijo', 'Batalla de Boyacá'),
	(13, '08-15', 'Fijo', 'Día de la Asunción de la Virgen María'),
	(14, '10-12', 'Móvil', 'Día de la Raza'),
	(15, '11-01', 'Móvil', 'Día de todos los santos'),
	(16, '11-11', 'Móvil', 'Independencia de Cartagena'),
	(17, '12-08', 'Fijo', 'Día de la Inmaculada Concepción'),
	(18, '12-25', 'Fijo', 'Navidad');
/*!40000 ALTER TABLE `feriados` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(10) NOT NULL AUTO_INCREMENT,
  `nom_rol` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.rol: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`id_rol`, `nom_rol`) VALUES
	(1, 'Súper Admi Op'),
	(2, 'Súper Admi'),
	(3, 'Admi'),
	(4, 'Usuario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.sede
CREATE TABLE IF NOT EXISTS `sede` (
  `id_sede` int(5) NOT NULL AUTO_INCREMENT,
  `nom_sede` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.sede: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `sede` DISABLE KEYS */;
INSERT INTO `sede` (`id_sede`, `nom_sede`) VALUES
	(1, 'Pasto'),
	(2, 'Tumaco'),
	(3, 'Ipiales'),
	(4, 'La Unión'),
	(5, 'San Pablo'),
	(6, 'La Cruz');
/*!40000 ALTER TABLE `sede` ENABLE KEYS */;

-- Volcando estructura para tabla sisgeva.solicitud
CREATE TABLE IF NOT EXISTS `solicitud` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` date DEFAULT current_timestamp(),
  `id_empleado` int(10) DEFAULT NULL,
  `tipo_solicitud` varchar(50) DEFAULT NULL,
  `fecha_vac_start` date DEFAULT NULL,
  `fecha_vac_end` date DEFAULT NULL,
  `dias_solicitados` int(11) DEFAULT NULL,
  `periodo_ini` date DEFAULT NULL,
  `periodo_fin` date DEFAULT NULL,
  `estado_solicitud` int(11) DEFAULT NULL,
  `fecha_aprobacion` date DEFAULT NULL,
  `fecha_rechazo` date DEFAULT NULL,
  `fecha_suspension` date DEFAULT NULL,
  `motivo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_empleado` (`id_empleado`),
  KEY `estado_solicitud` (`estado_solicitud`),
  CONSTRAINT `FK_solicitud_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_solicitud_estado_solicitud` FOREIGN KEY (`estado_solicitud`) REFERENCES `estado_solicitud` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla sisgeva.solicitud: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `solicitud` DISABLE KEYS */;
INSERT INTO `solicitud` (`id`, `fecha_solicitud`, `id_empleado`, `tipo_solicitud`, `fecha_vac_start`, `fecha_vac_end`, `dias_solicitados`, `periodo_ini`, `periodo_fin`, `estado_solicitud`, `fecha_aprobacion`, `fecha_rechazo`, `fecha_suspension`, `motivo`) VALUES
	(170, '2022-05-20', 2147483647, 'Remunerada', '2022-05-20', '2022-11-20', 2, '2022-06-08', '2022-06-08', 2, NULL, NULL, NULL, NULL),
	(174, '2022-06-08', 2147483647, 'No remunerada', '2022-06-07', '2022-06-12', 4, '2021-06-08', '2022-06-11', 3, '2022-06-08', NULL, '2022-06-09', 'm'),
	(180, '2022-06-10', 2147483647, 'No remunerada', '2022-06-11', '2022-07-01', 1, '2020-06-09', '2021-06-09', 1, NULL, NULL, NULL, NULL),
	(183, '2022-06-10', 6767, 'No remunerada', '2022-06-11', '2022-06-12', 1, '2020-06-09', '2021-06-09', 1, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `solicitud` ENABLE KEYS */;

-- Volcando estructura para vista sisgeva.vempleado
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vempleado` (
	`id_empleado` INT(10) NOT NULL,
	`empleado` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nom_area` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`nom_cargo` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nom_sede` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`fechaContrato` DATE NOT NULL,
	`nom_rol` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`anios_trab` BIGINT(21) NULL,
	`dias_vac_apro` INT(11) NULL,
	`dias_vac` BIGINT(23) NULL,
	`dias_dis` BIGINT(24) NULL,
	`periodos_dis` DECIMAL(25,0) NULL,
	`periodo_ini` DATE NULL,
	`periodo_fin` DATE NULL,
	`periodo_fin_1` DATE NULL,
	`dias_dis_periodo_1` BIGINT(24) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista sisgeva.vsolicitud
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vsolicitud` (
	`id` INT(5) NOT NULL,
	`fecha_solicitud` DATE NULL,
	`tipo_solicitud` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`id_empleado` INT(10) NOT NULL,
	`empleado` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fechaContrato` DATE NOT NULL,
	`nom_area` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`nom_cargo` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nom_sede` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`fecha_vac_start` DATE NULL,
	`fecha_vac_end` DATE NULL,
	`dias_solicitados` INT(11) NULL,
	`dias_dis_periodo_1` BIGINT(24) NULL,
	`periodo_ini` DATE NULL,
	`periodo_fin` DATE NULL,
	`estado_solicitud` VARCHAR(15) NULL COLLATE 'utf8mb4_general_ci',
	`fecha_aprobacion` DATE NULL,
	`fecha_suspension` DATE NULL,
	`fecha_rechazo` DATE NULL,
	`motivo` VARCHAR(250) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista sisgeva.vempleado
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vempleado`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vempleado` AS SELECT e.id_empleado, e.empleado, a.nom_area 'nom_area', c.nombreCargo 'nom_cargo', s.nom_sede 'nom_sede', e.fechaContrato, r.nom_rol 'nom_rol', TIMESTAMPDIFF(YEAR,e.fechaContrato, CURDATE()) anios_trab, e.dias_vac_apro,
TIMESTAMPDIFF(YEAR,e.fechaContrato, CURDATE()) * 15 dias_vac, ((TIMESTAMPDIFF(YEAR,e.fechaContrato, CURDATE()) * 15) - e.dias_vac_apro) dias_dis,
ROUND((((TIMESTAMPDIFF(YEAR,e.fechaContrato, CURDATE()) * 15) - e.dias_vac_apro)/15)+ 0.45) periodos_dis, 
DATE_ADD(e.fechaContrato, INTERVAL (e.dias_vac_apro DIV 15) YEAR) periodo_ini,
DATE_ADD(e.fechaContrato, INTERVAL TIMESTAMPDIFF(YEAR,e.fechaContrato, CURDATE()) YEAR) periodo_fin,
DATE_ADD((DATE_ADD(e.fechaContrato, INTERVAL (e.dias_vac_apro DIV 15) YEAR)), INTERVAL 1 YEAR) periodo_fin_1,
((TIMESTAMPDIFF(YEAR,e.fechaContrato, DATE_ADD((DATE_ADD(e.fechaContrato, INTERVAL (e.dias_vac_apro DIV 15) YEAR)), INTERVAL 1 YEAR)) * 15) - e.dias_vac_apro) dias_dis_periodo_1
FROM empleado e, area a, cargos c, sede s, rol r
WHERE e.area = a.id_area AND e.cargo = c.idCargo AND e.sede = s.id_sede AND e.roll = r.id_rol ;

-- Volcando estructura para vista sisgeva.vsolicitud
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vsolicitud`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vsolicitud` AS SELECT 
s.id, s.fecha_solicitud, s.tipo_solicitud, e.id_empleado, e.empleado, e.fechaContrato, e.nom_area, e.nom_cargo, e.nom_sede, s.fecha_vac_start, s.fecha_vac_end,
s.dias_solicitados, e.dias_dis_periodo_1, s.periodo_ini, s.periodo_fin, t.nom_estado 'estado_solicitud', s.fecha_aprobacion, s.fecha_suspension, s.fecha_rechazo, s.motivo
FROM solicitud s, vempleado e, estado_solicitud t
WHERE s.id_empleado = e.id_empleado AND t.id_estado = s.estado_solicitud ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
