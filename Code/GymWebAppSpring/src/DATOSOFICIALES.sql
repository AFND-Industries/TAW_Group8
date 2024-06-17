-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tawbd
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Cardio','Ejercicios para mejorar la resistencia cardiovascular','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_cardio.png'),(2,'Fuerza','Ejercicios para aumentar la fuerza muscular','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_fuerza.png'),(3,'Flexibilidad','Ejercicios para mejorar la flexibilidad','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_flexibilidad.png');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dificultad`
--


--
-- Dumping data for table `dificultad`
--

LOCK TABLES `dificultad` WRITE;
/*!40000 ALTER TABLE `dificultad` DISABLE KEYS */;
INSERT INTO `dificultad` VALUES (1,'Principiante','https://example.com/logo_principiante.png'),(2,'Intermedio','https://example.com/logo_intermedio.png'),(3,'Avanzado','https://example.com/logo_avanzado.png');
/*!40000 ALTER TABLE `dificultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejercicio`
--


--
-- Dumping data for table `ejercicio`
--

LOCK TABLES `ejercicio` WRITE;
/*!40000 ALTER TABLE `ejercicio` DISABLE KEYS */;
INSERT INTO `ejercicio` VALUES (1,'Curl de bíceps','Ejercicio para trabajar los bíceps usando pesas',1,'Pesas',3,NULL,'https://www.youtube.com/watch?v=ykJmrZ5v0Oo','https://example.com/logo_curl_biceps.png',2),(2,'Extensión de tríceps','Ejercicio para trabajar los tríceps usando una mancuerna',2,'Mancuerna',3,NULL,'https://www.youtube.com/watch?v=nRiJVZDpdL0','https://example.com/logo_extension_triceps.png',2),(3,'Sentadilla','Ejercicio compuesto para trabajar cuádriceps, glúteos y otros músculos de las piernas',3,'Barra',1,2,'https://www.youtube.com/watch?v=Dy28eq2PjcM','https://example.com/logo_sentadilla.png',2);
/*!40000 ALTER TABLE `ejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejerciciosesion`
--


--
-- Dumping data for table `ejerciciosesion`
--

LOCK TABLES `ejerciciosesion` WRITE;
/*!40000 ALTER TABLE `ejerciciosesion` DISABLE KEYS */;
INSERT INTO `ejerciciosesion` VALUES (4,1,'{\"Series\":\"1\",\"Repeticiones\":\"2\",\"Peso añadido\":\"2\"}',1,1);
/*!40000 ALTER TABLE `ejerciciosesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrenadorasignado`


--
-- Dumping data for table `entrenadorasignado`
--

LOCK TABLES `entrenadorasignado` WRITE;
/*!40000 ALTER TABLE `entrenadorasignado` DISABLE KEYS */;
INSERT INTO `entrenadorasignado` VALUES (2,1),(2,3);
/*!40000 ALTER TABLE `entrenadorasignado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informacionejercicio`
--


--
-- Dumping data for table `informacionejercicio`
--

LOCK TABLES `informacionejercicio` WRITE;
/*!40000 ALTER TABLE `informacionejercicio` DISABLE KEYS */;
INSERT INTO `informacionejercicio` VALUES (4,'{\"Series\":\"1\",\"Peso añadido\":\"2\",\"Repeticiones\":\"2\"}',4,3);
/*!40000 ALTER TABLE `informacionejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informacionsesion`
--

--
-- Dumping data for table `informacionsesion`
--

LOCK TABLES `informacionsesion` WRITE;
/*!40000 ALTER TABLE `informacionsesion` DISABLE KEYS */;
INSERT INTO `informacionsesion` VALUES (3,2,'sdadasa','2024-06-16',1,1);
/*!40000 ALTER TABLE `informacionsesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musculo`
--


--
-- Dumping data for table `musculo`
--

LOCK TABLES `musculo` WRITE;
/*!40000 ALTER TABLE `musculo` DISABLE KEYS */;
INSERT INTO `musculo` VALUES (1,'Bíceps','Músculo del brazo responsable de la flexión del codo','https://example.com/imagen_biceps.png'),(2,'Tríceps','Músculo del brazo responsable de la extensión del codo','https://example.com/imagen_triceps.png'),(3,'Cuádriceps','Grupo de músculos en la parte frontal del muslo','https://example.com/imagen_cuadriceps.png');
/*!40000 ALTER TABLE `musculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutina`
--
--
-- Dumping data for table `rutina`
--

LOCK TABLES `rutina` WRITE;
/*!40000 ALTER TABLE `rutina` DISABLE KEYS */;
INSERT INTO `rutina` VALUES (1,'Rutina de fuerza','Rutina para mejorar la fuerza muscular',2,'2024-06-01',2),(2,'Rutina de cardio','Rutina para mejorar la resistencia cardiovascular',1,'2024-06-02',2);
/*!40000 ALTER TABLE `rutina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutinacliente`
--


--
-- Dumping data for table `rutinacliente`
--

LOCK TABLES `rutinacliente` WRITE;
/*!40000 ALTER TABLE `rutinacliente` DISABLE KEYS */;
INSERT INTO `rutinacliente` VALUES (1,1,'2024-06-10'),(3,2,'2024-06-15');
/*!40000 ALTER TABLE `rutinacliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesionentrenamiento`
--


--
-- Dumping data for table `sesionentrenamiento`
--

LOCK TABLES `sesionentrenamiento` WRITE;
/*!40000 ALTER TABLE `sesionentrenamiento` DISABLE KEYS */;
INSERT INTO `sesionentrenamiento` VALUES (1,'Sesión de fuerza 1','Primera sesión de la rutina de fuerza',1,1),(2,'Sesión de cardio 1','Primera sesión de la rutina de cardio',1,2);
/*!40000 ALTER TABLE `sesionentrenamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipofuerza`
--


--
-- Dumping data for table `tipofuerza`
--

LOCK TABLES `tipofuerza` WRITE;
/*!40000 ALTER TABLE `tipofuerza` DISABLE KEYS */;
INSERT INTO `tipofuerza` VALUES (1,'Resistencia','Ejercicios para mejorar la resistencia muscular'),(2,'Potencia','Ejercicios para desarrollar la fuerza explosiva'),(3,'Hipertrofia','Ejercicios para aumentar el tamaño muscular');
/*!40000 ALTER TABLE `tipofuerza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--
--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Cliente'),(2,'Entrenador'),(3,'Administrador');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--


--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan','Pérez','M',28,'1','6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',1),(2,'Ana','Martínez','F',32,'2','D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35',2),(3,'Carlos','López','M',25,'11223344X','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',1),(4,'Francisco','Domínguez','M',32,'22222222A','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',3);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2024-06-16 23:19:43
