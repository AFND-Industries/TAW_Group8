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

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  `TIPOS_BASE` varchar(64) NOT NULL,
  `ICONO` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `dificultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dificultad` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `LOGO` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `ejercicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejercicio` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  `MUSCULO` int NOT NULL,
  `EQUIPAMIENTO` varchar(32) NOT NULL,
  `TIPOFUERZA` int NOT NULL,
  `MUSCULO_SECUNDARIO` int DEFAULT NULL,
  `VIDEO` varchar(256) NOT NULL,
  `LOGO` varchar(256) NOT NULL,
  `CATEGORIA` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `EJERCICIO_MUSCULO_ID_fk` (`MUSCULO`),
  KEY `EJERCICIO_MUSCULO_ID_fk_2` (`MUSCULO_SECUNDARIO`),
  KEY `EJERCICIO_TIPOFUERZA_ID_fk` (`TIPOFUERZA`),
  KEY `EJERCICIO_ibfk_1` (`CATEGORIA`),
  CONSTRAINT `EJERCICIO_ibfk_1` FOREIGN KEY (`CATEGORIA`) REFERENCES `categoria` (`ID`),
  CONSTRAINT `EJERCICIO_MUSCULO_ID_fk` FOREIGN KEY (`MUSCULO`) REFERENCES `musculo` (`ID`),
  CONSTRAINT `EJERCICIO_MUSCULO_ID_fk_2` FOREIGN KEY (`MUSCULO_SECUNDARIO`) REFERENCES `musculo` (`ID`),
  CONSTRAINT `EJERCICIO_TIPOFUERZA_ID_fk` FOREIGN KEY (`TIPOFUERZA`) REFERENCES `tipofuerza` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `ejerciciosesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejerciciosesion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ORDEN` int NOT NULL,
  `ESPECIFICACIONES` varchar(256) NOT NULL COMMENT 'JSON syntax',
  `SESIONENTRENAMIENTO_ID` int NOT NULL,
  `EJERCICIO_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `EJERCICIOSESION_ibfk_1` (`EJERCICIO_ID`),
  KEY `EJERCICIOSESION_ibfk_2` (`SESIONENTRENAMIENTO_ID`),
  CONSTRAINT `EJERCICIOSESION_ibfk_1` FOREIGN KEY (`EJERCICIO_ID`) REFERENCES `ejercicio` (`ID`),
  CONSTRAINT `EJERCICIOSESION_ibfk_2` FOREIGN KEY (`SESIONENTRENAMIENTO_ID`) REFERENCES `sesionentrenamiento` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `entrenadorasignado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrenadorasignado` (
  `ENTRENADOR` int NOT NULL,
  `CLIENTE` int NOT NULL,
  PRIMARY KEY (`ENTRENADOR`,`CLIENTE`),
  KEY `ENTRENADORASIGNADO_USUARIO_ID_fk_2` (`CLIENTE`),
  CONSTRAINT `ENTRENADORASIGNADO_USUARIO_ID_fk` FOREIGN KEY (`ENTRENADOR`) REFERENCES `usuario` (`ID`),
  CONSTRAINT `ENTRENADORASIGNADO_USUARIO_ID_fk_2` FOREIGN KEY (`CLIENTE`) REFERENCES `usuario` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `informacionejercicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `informacionejercicio` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EVALUACION` varchar(256) NOT NULL COMMENT 'JSON syntax',
  `EJERCICIOSESION_ID` int NOT NULL,
  `INFORMACIONSESION_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `INFORMACIONEJERCICIO_ibfk_1` (`EJERCICIOSESION_ID`),
  KEY `INFORMACIONEJERCICIO_ibfk_2` (`INFORMACIONSESION_ID`),
  CONSTRAINT `INFORMACIONEJERCICIO_ibfk_1` FOREIGN KEY (`EJERCICIOSESION_ID`) REFERENCES `ejerciciosesion` (`ID`),
  CONSTRAINT `INFORMACIONEJERCICIO_ibfk_2` FOREIGN KEY (`INFORMACIONSESION_ID`) REFERENCES `informacionsesion` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `informacionsesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `informacionsesion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `VALORACION` int DEFAULT NULL,
  `COMENTARIO` varchar(256) DEFAULT NULL,
  `FECHA_FIN` date DEFAULT NULL,
  `SESIONENTRENAMIENTO_ID` int NOT NULL,
  `USUARIO_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `INFORMACIONSESION_USUARIO_2` (`USUARIO_ID`),
  KEY `INFORMACIONSESION_ibfk_1` (`SESIONENTRENAMIENTO_ID`),
  CONSTRAINT `INFORMACIONSESION_ibfk_1` FOREIGN KEY (`SESIONENTRENAMIENTO_ID`) REFERENCES `sesionentrenamiento` (`ID`),
  CONSTRAINT `INFORMACIONSESION_USUARIO_2` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `musculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musculo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  `IMAGEN` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `rutina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutina` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  `DIFICULTAD` int NOT NULL,
  `FECHA_CREACION` date NOT NULL,
  `ENTRENADOR` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk` (`DIFICULTAD`),
  KEY `RUTINA_USUARIO_FK` (`ENTRENADOR`),
  CONSTRAINT `RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk` FOREIGN KEY (`DIFICULTAD`) REFERENCES `dificultad` (`ID`),
  CONSTRAINT `RUTINA_USUARIO_FK` FOREIGN KEY (`ENTRENADOR`) REFERENCES `usuario` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `rutinacliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinacliente` (
  `USUARIO_ID` int NOT NULL,
  `RUTINA_ID` int NOT NULL,
  `FECHA_INICIO` date NOT NULL,
  PRIMARY KEY (`USUARIO_ID`,`RUTINA_ID`),
  KEY `RUTINACLIENTE_RUTINA_1` (`RUTINA_ID`),
  CONSTRAINT `RUTINACLIENTE_RUTINA_1` FOREIGN KEY (`RUTINA_ID`) REFERENCES `rutina` (`ID`),
  CONSTRAINT `RUTINACLIENTE_USUARIO_2` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `sesionentrenamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesionentrenamiento` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  `DIA` int NOT NULL,
  `RUTINA` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `rutina_id___fk` (`RUTINA`),
  CONSTRAINT `rutina_id___fk` FOREIGN KEY (`RUTINA`) REFERENCES `rutina` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `tipofuerza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipofuerza` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `DESCRIPCION` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(32) NOT NULL,
  `APELLIDOS` varchar(32) NOT NULL,
  `GENERO` char(1) NOT NULL,
  `EDAD` int NOT NULL,
  `DNI` varchar(32) NOT NULL,
  `CLAVE` varchar(64) NOT NULL,
  `TIPO` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `USUARIO_TIPOUSUARIO_1` (`TIPO`),
  CONSTRAINT `USUARIO_TIPOUSUARIO_1` FOREIGN KEY (`TIPO`) REFERENCES `tipousuario` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan','Pérez','M',28,'1','6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',1),(2,'Ana','Martínez','F',32,'2','D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35',2),(3,'Carlos','López','M',25,'11223344X','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',1),(4,'Francisco','Domínguez','M',32,'22222222A','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-16 23:19:43
