
LOCK TABLES `categoria` WRITE;
INSERT INTO `categoria` VALUES (1,'Cardio','Ejercicios para mejorar la resistencia cardiovascular','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_cardio.png'),(2,'Fuerza','Ejercicios para aumentar la fuerza muscular','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_fuerza.png'),(3,'Flexibilidad','Ejercicios para mejorar la flexibilidad','[\'Series\', \'Repeticiones\', \'Peso añadido\']','https://example.com/icono_flexibilidad.png');
UNLOCK TABLES;

LOCK TABLES `dificultad` WRITE;
INSERT INTO `dificultad` VALUES (1,'Principiante','https://example.com/logo_principiante.png'),(2,'Intermedio','https://example.com/logo_intermedio.png'),(3,'Avanzado','https://example.com/logo_avanzado.png');
UNLOCK TABLES;

LOCK TABLES `tipousuario` WRITE;
INSERT INTO `tipousuario` VALUES (1,'Cliente'),(2,'Entrenador de Fuerza'),(3,'Entrenador de Crossfit'),(4,'Administrador');
UNLOCK TABLES;

LOCK TABLES `tipofuerza` WRITE;
INSERT INTO `tipofuerza` VALUES (1,'Resistencia','Ejercicios para mejorar la resistencia muscular'),(2,'Potencia','Ejercicios para desarrollar la fuerza explosiva'),(3,'Hipertrofia','Ejercicios para aumentar el tamaño muscular');
UNLOCK TABLES;

LOCK TABLES `ejercicio` WRITE;
INSERT INTO `ejercicio` VALUES (1,'Curl de bíceps','Ejercicio para trabajar los bíceps usando pesas',1,'Pesas',3,NULL,'https://www.youtube.com/watch?v=ykJmrZ5v0Oo','https://example.com/logo_curl_biceps.png',2),(2,'Extensión de tríceps','Ejercicio para trabajar los tríceps usando una mancuerna',2,'Mancuerna',3,NULL,'https://www.youtube.com/watch?v=nRiJVZDpdL0','https://example.com/logo_extension_triceps.png',2),(3,'Sentadilla','Ejercicio compuesto para trabajar cuádriceps, glúteos y otros músculos de las piernas',3,'Barra',1,2,'https://www.youtube.com/watch?v=Dy28eq2PjcM','https://example.com/logo_sentadilla.png',2);
UNLOCK TABLES;

LOCK TABLES `ejerciciosesion` WRITE;
INSERT INTO `ejerciciosesion` VALUES (4,1,'{\"Series\":\"1\",\"Repeticiones\":\"2\",\"Peso añadido\":\"2\"}',1,1);
UNLOCK TABLES;

LOCK TABLES `informacionsesion` WRITE;
INSERT INTO `informacionsesion` VALUES (3,2,'sdadasa','2024-06-16',1,1);
UNLOCK TABLES;

LOCK TABLES `musculo` WRITE;
INSERT INTO `musculo` VALUES (1,'Bíceps','Músculo del brazo responsable de la flexión del codo','https://example.com/imagen_biceps.png'),(2,'Tríceps','Músculo del brazo responsable de la extensión del codo','https://example.com/imagen_triceps.png'),(3,'Cuádriceps','Grupo de músculos en la parte frontal del muslo','https://example.com/imagen_cuadriceps.png');
UNLOCK TABLES;


LOCK TABLES `usuario` WRITE;
INSERT INTO `usuario` VALUES (1,'Juan','Pérez','M',28,'1','6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',1),(2,'Ana','Martínez','F',32,'2','D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35',2),(3,'Carlos','López','M',25,'11223344X','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',1),(4,'Francisco','Domínguez','M',32,'22222222A','6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',4),(5,'Antonio','Cuervo','M',23,'3','4E07408562BEDB8B60CE05C1DECFE3AD16B72230967DE01F640B7E4729B49FCE',3);
UNLOCK TABLES;

LOCK TABLES `rutina` WRITE;
INSERT INTO `rutina` VALUES (1,'Rutina de fuerza','Rutina para mejorar la fuerza muscular',2,'2024-06-01',2),(2,'Rutina de cardio','Rutina para mejorar la resistencia cardiovascular',1,'2024-06-02',2);
UNLOCK TABLES;

LOCK TABLES `sesionentrenamiento` WRITE;
INSERT INTO `sesionentrenamiento` VALUES (1,'Sesión de fuerza 1','Primera sesión de la rutina de fuerza',1,1),(2,'Sesión de cardio 1','Primera sesión de la rutina de cardio',1,2);
UNLOCK TABLES;

LOCK TABLES `entrenadorasignado` WRITE;
INSERT INTO `entrenadorasignado` VALUES (2,1),(2,3);
UNLOCK TABLES;

LOCK TABLES `rutinacliente` WRITE;
INSERT INTO `rutinacliente` VALUES (1,1,'2024-06-10'),(3,2,'2024-06-15');
UNLOCK TABLES;

LOCK TABLES `informacionejercicio` WRITE;
INSERT INTO `informacionejercicio` VALUES (4,'{\"Series\":\"1\",\"Peso añadido\":\"2\",\"Repeticiones\":\"2\"}',4,3);
UNLOCK TABLES;