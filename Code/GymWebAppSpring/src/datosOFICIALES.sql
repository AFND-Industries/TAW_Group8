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
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Fuerza','Categoria de fuerza','[\"Series\",\"Repeticiones\",\"Peso extra\"]','https://cdn-icons-png.flaticon.com/512/908/908893.png'),(2,'Resistencia','Categoria de resistencia','[\"Tiempo total\",\"Ritmo cardiaco medio\"]','https://cdn.icon-icons.com/icons2/2248/PNG/512/resistor_icon_136269.png'),(3,'Capacidad aeróbica','Categoria de Capacidad aeróbica','[\"Tiempo total\",\"Tiempo descanso\"]','https://migymencasa.com/wp-content/uploads/2019/12/282-1024x557.jpg'),(4,'Velocidad','Categoria de Velocidad','[\"Velocidad media\",\"Velocidad maxima\"]','https://cdn-icons-png.flaticon.com/512/84/84570.png'),(5,'Potencia','Categoria de Potencia','[\"Wattios\",\"Numero de repeticiones\"]','https://cdn-icons-png.flaticon.com/512/1923/1923514.png'),(6,'Estabilidad','Categoria de Estabilidad','[\"tiempo\"]','https://cdn-icons-png.flaticon.com/512/4792/4792284.png'),(7,'Movilidad','Categoria de Movilidad','[\"Tiempo medio\",\"Repeticiones\"]','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuRJgaKjd48e_PeRAZ1fEPmTXY9HoN7UtoHA&s');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dificultad`
--

LOCK TABLES `dificultad` WRITE;
/*!40000 ALTER TABLE `dificultad` DISABLE KEYS */;
INSERT INTO `dificultad` VALUES (1,'Principiante','/svg/dificultades/principiante.svg'),(2,'Intermedio','/svg/dificultades/intermedio.svg'),(3,'Avanzado','/svg/dificultades/avanzado.svg');
/*!40000 ALTER TABLE `dificultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ejercicio`
--

LOCK TABLES `ejercicio` WRITE;
/*!40000 ALTER TABLE `ejercicio` DISABLE KEYS */;
INSERT INTO `ejercicio` VALUES (1,'Press de banca','Ejercicio para trabajar el pectoral mayor acostado en un banco horizontal',1,'Barra, Pesas',1,3,'https://www.youtube.com/watch?v=br7XVh4AmUA&ab_channel=EntrenamientoySalud','https://blogscdn.thehut.net/app/uploads/sites/450/2016/03/shutterstock_336330497opt_hero_1620634941_1620820354.jpg',1),(2,'Carrera','A correr se ha dicho',3,'Cinta de correr',2,3,'https://www.youtube.com/watch?v=yBdMIy2WXRw&ab_channel=DeportesUncomo','https://eurofitness.com/wp-content/uploads/2020/05/correr-correctamente.jpg',2);
/*!40000 ALTER TABLE `ejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ejerciciosesion`
--

LOCK TABLES `ejerciciosesion` WRITE;
/*!40000 ALTER TABLE `ejerciciosesion` DISABLE KEYS */;
INSERT INTO `ejerciciosesion` VALUES (1,0,'{\"Series\":\"5\",\"Repeticiones\":\"3\",\"Peso extra\":\"12\"}',1,1),(2,0,'{\"Series\":\"12\",\"Repeticiones\":\"12\",\"Peso extra\":\"1\"}',2,1),(3,0,'{\"Tiempo total\":\"200\",\"Ritmo cardiaco medio\":\"150\"}',3,2);
/*!40000 ALTER TABLE `ejerciciosesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `entrenadorasignado`
--

LOCK TABLES `entrenadorasignado` WRITE;
/*!40000 ALTER TABLE `entrenadorasignado` DISABLE KEYS */;
INSERT INTO `entrenadorasignado` VALUES (2,4),(3,4);
/*!40000 ALTER TABLE `entrenadorasignado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `informacionejercicio`
--

LOCK TABLES `informacionejercicio` WRITE;
/*!40000 ALTER TABLE `informacionejercicio` DISABLE KEYS */;
INSERT INTO `informacionejercicio` VALUES (2,'{\"Series\":\"12\",\"Peso extra\":\"2\",\"Repeticiones\":\"3\"}',2,2),(3,'{\"Series\":\"5\",\"Peso extra\":\"1\",\"Repeticiones\":\"3\"}',1,3),(4,'{\"Ritmo cardiaco medio\":\"100\",\"Tiempo total\":\"300\"}',3,4);
/*!40000 ALTER TABLE `informacionejercicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `informacionsesion`
--

LOCK TABLES `informacionsesion` WRITE;
/*!40000 ALTER TABLE `informacionsesion` DISABLE KEYS */;
INSERT INTO `informacionsesion` VALUES (2,3,'Estoy demasaido cansado','2024-06-23',2,4),(3,4,'Me ha gustado pero un poco facil','2024-06-23',1,4),(4,3,'Regular','2024-06-23',3,4);
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
INSERT INTO `rutina` VALUES (1,'Rutina de crossfit basica','Rutina de crossfit basica para principiantes',1,'2024-06-23',2),(2,'Rutina de fuerza avanzada','Rutina de fuerza avanzada para los mas fuertes',2,'2024-06-23',3);
/*!40000 ALTER TABLE `rutina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rutinacliente`
--

LOCK TABLES `rutinacliente` WRITE;
/*!40000 ALTER TABLE `rutinacliente` DISABLE KEYS */;
INSERT INTO `rutinacliente` VALUES (4,1,'2024-06-23'),(4,2,'2024-06-23');
/*!40000 ALTER TABLE `rutinacliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sesionentrenamiento`
--

LOCK TABLES `sesionentrenamiento` WRITE;
/*!40000 ALTER TABLE `sesionentrenamiento` DISABLE KEYS */;
INSERT INTO `sesionentrenamiento` VALUES (1,'Sesion inicial','Sesion de toma de contacto!',1,1),(2,'Sesion de pecho','Sesion de pecho para los musculos del pecho',3,2),(3,'Sesion de resistencia','Sesion de resistencia',2,1);
/*!40000 ALTER TABLE `sesionentrenamiento` ENABLE KEYS */;
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
INSERT INTO `tipousuario` VALUES (1,'Cliente'),(2,'Entrenador de Fuerza'),(3,'Entrenador de Crossfit'),(4,'Administrador');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Antonio Blas','Morál Sánchez','m',20,'1','6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',4),(2,'Eulogio','Quemada Torres','m',21,'2','D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35',3),(3,'Alejandro','Román Sánchez','m',21,'3','4E07408562BEDB8B60CE05C1DECFE3AD16B72230967DE01F640B7E4729B49FCE',2),(4,'Antonio','Cañete Baena','m',20,'4','4B227777D4DD1FC61C6F884F48641D02B4D121D3FD328CB08B5531FCACDABF8A',1);
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

-- Dump completed on 2024-06-23 19:42:03
