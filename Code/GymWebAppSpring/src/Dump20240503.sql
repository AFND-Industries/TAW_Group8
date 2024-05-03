-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
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
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Fuerza','Ejercicios para aumentar la masa muscular','{\"peso\":\"integer\", \"series\":\"integer\", \"repeticiones\":\"integer\"}','img/categorias/fuerza.png'),(2,'Resistencia','Ejercicios para mejorar la capacidad aeróbica','Cardio, peso corporal','img/categorias/resistencia.png'),(3,'Flexibilidad','Ejercicios para mejorar la elasticidad muscular','Estiramientos','img/categorias/flexibilidad.png');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dificultad`
--

LOCK TABLES `dificultad` WRITE;
/*!40000 ALTER TABLE `dificultad` DISABLE KEYS */;
INSERT INTO `dificultad` VALUES (1,'Principiante','img/dificultades/principiante.png'),(2,'Intermedio','img/dificultades/intermedio.png'),(3,'Avanzado','img/dificultades/avanzado.png');
/*!40000 ALTER TABLE `dificultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ejercicio`
--

LOCK TABLES `ejercicio` WRITE;
/*!40000 ALTER TABLE `ejercicio` DISABLE KEYS */;
INSERT INTO `ejercicio` VALUES (1,'Press de banca','Ejercicio para trabajar el pectoral mayor acostado en un banco horizontal',1,'Barra',1,3,'img/ejercicio/press banca.mp4','img/ejercicio/press banca.jpg',1),(2,'Sentadillas con barra','Ejercicio para trabajar los cuádriceps, glúteos e isquiotibiales',2,'Barra',1,1,'img/ejercicio/sentadilla barra.mp4','img/ejercicio/sentadilla barra.jpg',1),(3,'Dominadas','Ejercicio para trabajar la espalda, bíceps y braquial anterior',3,'Sin equipo',1,NULL,'img/ejercicio/dominadas.mp4','img/ejercicio/dominadas.jpg',2),(4,'Remo con barra','Ejercicio para trabajar la espalda, bíceps y braquial anterior',2,'Barra',1,NULL,'img/ejercicio/remo barra.mp4','img/ejercicio/remo barra.jpg',2);
/*!40000 ALTER TABLE `ejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ejerciciosesion`
--

LOCK TABLES `ejerciciosesion` WRITE;
/*!40000 ALTER TABLE `ejerciciosesion` DISABLE KEYS */;
INSERT INTO `ejerciciosesion` VALUES (1,1,'{\"peso\":15,\"series\":5,\"repeticiones\":12}',1,2),(2,1,'{\"peso\":15,\"series\":5,\"repeticiones\":12}',2,1),(3,2,'{\"peso\":15,\"series\":7,\"repeticiones\":12}',1,3);
/*!40000 ALTER TABLE `ejerciciosesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `entrenadorasignado`
--

LOCK TABLES `entrenadorasignado` WRITE;
/*!40000 ALTER TABLE `entrenadorasignado` DISABLE KEYS */;
INSERT INTO `entrenadorasignado` VALUES (2,1);
/*!40000 ALTER TABLE `entrenadorasignado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `informacionejercicio`
--

LOCK TABLES `informacionejercicio` WRITE;
/*!40000 ALTER TABLE `informacionejercicio` DISABLE KEYS */;
INSERT INTO `informacionejercicio` VALUES (1,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',1,1),(2,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',3,1),(5,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',2,2);
/*!40000 ALTER TABLE `informacionejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `informacionsesion`
--

LOCK TABLES `informacionsesion` WRITE;
/*!40000 ALTER TABLE `informacionsesion` DISABLE KEYS */;
INSERT INTO `informacionsesion` VALUES (1,5,'Me ha gustado mucho este ejercicio,lo repetiría mil veces más','2024-04-25',1,1),(2,1,'Esto es una mierda','2024-05-18',2,1);
/*!40000 ALTER TABLE `informacionsesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `musculo`
--

LOCK TABLES `musculo` WRITE;
/*!40000 ALTER TABLE `musculo` DISABLE KEYS */;
INSERT INTO `musculo` VALUES (1,'Pectoral mayor','Músculo del pecho, responsable de empujar y rotar el brazo','img/musculos/pectoral.png'),(2,'Bíceps braquial','Músculo de la parte superior del brazo, responsable de flexionar el codo','img/musculos/biceps.png'),(3,'Tríceps braquial','Músculo de la parte posterior del brazo, responsable de extender el codo','img/musculos/triceps.png');
/*!40000 ALTER TABLE `musculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rutina`
--

LOCK TABLES `rutina` WRITE;
/*!40000 ALTER TABLE `rutina` DISABLE KEYS */;
INSERT INTO `rutina` VALUES (1,'Rutina para principiantes','Ejercicios básicos para tonificar todo el cuerpo',1,'2024-04-01',2),(2,'Rutina para quemar grasa','Ejercicios enfocados en el gasto calórico',2,'2024-04-05',2),(3,'Rutina para ganar músculo','Ejercicios para aumentar la masa muscular',3,'2024-04-10',2);
/*!40000 ALTER TABLE `rutina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rutinacliente`
--

LOCK TABLES `rutinacliente` WRITE;
/*!40000 ALTER TABLE `rutinacliente` DISABLE KEYS */;
INSERT INTO `rutinacliente` VALUES (1,1,'2024-04-25'),(1,2,'2024-04-12'),(1,3,'2024-04-12');
/*!40000 ALTER TABLE `rutinacliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sesionentrenamiento`
--

LOCK TABLES `sesionentrenamiento` WRITE;
/*!40000 ALTER TABLE `sesionentrenamiento` DISABLE KEYS */;
INSERT INTO `sesionentrenamiento` VALUES (1,'Piernas','Ejercicios enfocados en fortalecer los músculos de las piernas'),(2,'Tren superior','Ejercicios para trabajar pecho, espalda, hombros y brazos');
/*!40000 ALTER TABLE `sesionentrenamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sesionrutinas`
--

LOCK TABLES `sesionrutinas` WRITE;
/*!40000 ALTER TABLE `sesionrutinas` DISABLE KEYS */;
INSERT INTO `sesionrutinas` VALUES (1,1,1),(2,1,2);
/*!40000 ALTER TABLE `sesionrutinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipofuerza`
--

LOCK TABLES `tipofuerza` WRITE;
/*!40000 ALTER TABLE `tipofuerza` DISABLE KEYS */;
INSERT INTO `tipofuerza` VALUES (1,'Hipertrofia','Ejercicios para aumentar el tamaño muscular'),(2,'Resistencia','Ejercicios para mejorar la resistencia muscular'),(3,'Fuerza máxima','Ejercicios para levantar el máximo peso posible');
/*!40000 ALTER TABLE `tipofuerza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Cliente'),(2,'Entrenador'),(3,'Administrador');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Eulogo','Quemadisima','m',33,'1','6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',1),(2,'Tiko','Toko','m',33,'2','D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35',2),(3,'Paco','Fiestas','m',18,'admin','8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918',3);
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

-- Dump completed on 2024-05-03 19:18:34
