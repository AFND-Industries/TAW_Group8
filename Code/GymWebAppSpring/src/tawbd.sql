use tawbd;
create  table categoria
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    TIPOS_BASE  varchar(64)  not null,
    ICONO       varchar(256) not null
);

create  table dificultad
(
    ID     int auto_increment
        primary key,
    NOMBRE varchar(32)  not null,
    LOGO   varchar(256) not null
);

create  table musculo
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    IMAGEN      varchar(256) not null
);

create  table sesionentrenamiento
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null
);

create  table tipofuerza
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null
);

create  table ejercicio
(
    ID                 int auto_increment
        primary key,
    NOMBRE             varchar(32)  not null,
    DESCRIPCION        varchar(256) not null,
    MUSCULO            int          not null,
    EQUIPAMIENTO       varchar(32)  not null,
    TIPOFUERZA         int          not null,
    MUSCULO_SECUNDARIO int          null,
    VIDEO              varchar(256) not null,
    LOGO               varchar(256) not null,
    CATEGORIA          int          not null,
    constraint EJERCICIO_MUSCULO_ID_fk
        foreign key (MUSCULO) references musculo (ID),
    constraint EJERCICIO_MUSCULO_ID_fk_2
        foreign key (MUSCULO_SECUNDARIO) references musculo (ID),
    constraint EJERCICIO_TIPOFUERZA_ID_fk
        foreign key (TIPOFUERZA) references tipofuerza (ID),
    constraint EJERCICIO_ibfk_1
        foreign key (CATEGORIA) references categoria (ID)
);

create  table ejerciciosesion
(
    ID                     int auto_increment
        primary key,
    ORDEN                  int          not null,
    ESPECIFICACIONES       varchar(256) not null comment 'JSON syntax',
    SESIONENTRENAMIENTO_ID int          not null,
    EJERCICIO_ID           int          not null,
    constraint EJERCICIOSESION_ibfk_1
        foreign key (EJERCICIO_ID) references ejercicio (ID),
    constraint EJERCICIOSESION_ibfk_2
        foreign key (SESIONENTRENAMIENTO_ID) references sesionentrenamiento (ID)
);

create  table tipousuario
(
    ID     int auto_increment
        primary key,
    NOMBRE varchar(32) not null
);

create  table usuario
(
    ID        int auto_increment
        primary key,
    NOMBRE    varchar(32) not null,
    APELLIDOS varchar(32) not null,
    GENERO    char        not null,
    EDAD      int         not null,
    DNI       varchar(32) not null,
    CLAVE     varchar(64) not null,
    TIPO      int         not null,
    constraint USUARIO_TIPOUSUARIO_1
        foreign key (TIPO) references tipousuario (ID)
);

create  table entrenadorasignado
(
    ENTRENADOR int not null,
    CLIENTE    int not null,
    primary key (ENTRENADOR, CLIENTE),
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk
        foreign key (ENTRENADOR) references usuario (ID),
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk_2
        foreign key (CLIENTE) references usuario (ID)
);

create  table informacionsesion
(
    ID                     int auto_increment
        primary key,
    VALORACION             int          null,
    COMENTARIO             varchar(256) null,
    FECHA_FIN              date         null,
    SESIONENTRENAMIENTO_ID int          not null,
    USUARIO_ID             int          not null,
    constraint INFORMACIONSESION_USUARIO_2
        foreign key (USUARIO_ID) references usuario (ID),
    constraint INFORMACIONSESION_ibfk_1
        foreign key (SESIONENTRENAMIENTO_ID) references sesionentrenamiento (ID)
);

create  table informacionejercicio
(
    ID                   int auto_increment
        primary key,
    EVALUACION           varchar(256) not null comment 'JSON syntax',
    EJERCICIOSESION_ID   int          not null,
    INFORMACIONSESION_ID int          not null,
    constraint INFORMACIONEJERCICIO_ibfk_1
        foreign key (EJERCICIOSESION_ID) references ejerciciosesion (ID),
    constraint INFORMACIONEJERCICIO_ibfk_2
        foreign key (INFORMACIONSESION_ID) references informacionsesion (ID)
);

create  table rutina
(
    ID             int auto_increment
        primary key,
    NOMBRE         varchar(32)  not null,
    DESCRIPCION    varchar(256) not null,
    DIFICULTAD     int          not null,
    FECHA_CREACION date         not null,
    ENTRENADOR     int          not null,
    constraint RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk
        foreign key (DIFICULTAD) references dificultad (ID),
    constraint RUTINA_USUARIO_FK
        foreign key (ENTRENADOR) references usuario (ID)
);

create  table rutinacliente
(
    USUARIO_ID   int  not null,
    RUTINA_ID    int  not null,
    FECHA_INICIO date not null,
    primary key (USUARIO_ID, RUTINA_ID),
    constraint RUTINACLIENTE_RUTINA_1
        foreign key (RUTINA_ID) references rutina (ID),
    constraint RUTINACLIENTE_USUARIO_2
        foreign key (USUARIO_ID) references usuario (ID)
);

create  table sesionrutinas
(
    SESIONENTRENAMIENTO_ID int not null,
    RUTINA_ID              int not null,
    DIA                    int not null,
    primary key (RUTINA_ID, SESIONENTRENAMIENTO_ID),
    constraint SESIONRUTINAS_ibfk_1
        foreign key (SESIONENTRENAMIENTO_ID) references sesionentrenamiento (ID),
    constraint SESIONRUTINAS_ibfk_2
        foreign key (RUTINA_ID) references rutina (ID)
);

-- Insertar datos en la tabla 'categoria'
INSERT INTO categoria (NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO)
VALUES ('Fuerza', 'Ejercicios para aumentar la masa muscular', 'Peso corporal, máquinas', 'img/categorias/fuerza.png'),
       ('Resistencia', 'Ejercicios para mejorar la capacidad aeróbica', 'Cardio, peso corporal',
        'img/categorias/resistencia.png'),
       ('Flexibilidad', 'Ejercicios para mejorar la elasticidad muscular', 'Estiramientos',
        'img/categorias/flexibilidad.png');

-- Insertar datos en la tabla 'dificultad'
INSERT INTO dificultad (NOMBRE, LOGO)
VALUES ('Principiante', 'svg/dificultades/principiante.svg'),
       ('Intermedio', 'svg/dificultades/intermedio.svg'),
       ('Avanzado', 'svg/dificultades/avanzado.svg');

-- Insertar datos en la tabla 'musculo'
INSERT INTO musculo (NOMBRE, DESCRIPCION, IMAGEN)
VALUES ('Pectoral mayor', 'Músculo del pecho, responsable de empujar y rotar el brazo', 'img/musculos/pectoral.png'),
       ('Bíceps braquial', 'Músculo de la parte superior del brazo, responsable de flexionar el codo',
        'img/musculos/biceps.png'),
       ('Tríceps braquial', 'Músculo de la parte posterior del brazo, responsable de extender el codo',
        'img/musculos/triceps.png');

-- Insertar datos en la tabla 'sesionentrenamiento'
INSERT INTO sesionentrenamiento (NOMBRE, DESCRIPCION)
VALUES ('Piernas', 'Ejercicios enfocados en fortalecer los músculos de las piernas'),
       ('Tren superior', 'Ejercicios para trabajar pecho, espalda, hombros y brazos');

-- Insertar datos en la tabla 'tipofuerza'
INSERT INTO tipofuerza (NOMBRE, DESCRIPCION)
VALUES ('Hipertrofia', 'Ejercicios para aumentar el tamaño muscular'),
       ('Resistencia', 'Ejercicios para mejorar la resistencia muscular'),
       ('Fuerza máxima', 'Ejercicios para levantar el máximo peso posible');

INSERT INTO tawbd.tipousuario (NOMBRE)
VALUES ('Cliente'),
       ('Entrenador'),
       ('Administrador');

-- Clave de 'Eulogo' -> 'eullinqt'
-- Clave de 'Tiko' -> 'tikotoko'
-- Clave de 'Paco' -> 'pacofiestas'
INSERT INTO tawbd.usuario (NOMBRE, APELLIDOS, GENERO, EDAD, DNI, CLAVE, TIPO)
VALUES ('Eulogo', 'Quemadisima', 'm', 33, '1', '6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B', 1),
       ('Tiko', 'Toko', 'm', 33, '2', 'D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35', 2),
       ('Paco', 'Fiestas', 'm', 18, 'admin', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', 3);

-- Insertar datos en la tabla 'rutina'
INSERT INTO rutina (NOMBRE, DESCRIPCION, DIFICULTAD, FECHA_CREACION, ENTRENADOR)
VALUES ('Rutina para principiantes', 'Ejercicios básicos para tonificar todo el cuerpo', 1, '2024-04-01',2),
       ('Rutina para quemar grasa', 'Ejercicios enfocados en el gasto calórico', 2, '2024-04-05',2),
       ('Rutina para ganar músculo', 'Ejercicios para aumentar la masa muscular', 3, '2024-04-10',2);

-- Insertar datos en la tabla 'ejercicio' (no funciona)
INSERT INTO tawbd.ejercicio (NOMBRE, DESCRIPCION, MUSCULO, EQUIPAMIENTO, TIPOFUERZA, MUSCULO_SECUNDARIO, VIDEO, LOGO,
                       CATEGORIA)
VALUES ('Press de banca', 'Ejercicio para trabajar el pectoral mayor acostado en un banco horizontal', 1, 'Barra', 1, 3,
        'img/ejercicio/press banca.mp4', 'img/ejercicio/press banca.jpg', 1),
       ('Sentadillas con barra', 'Ejercicio para trabajar los cuádriceps, glúteos e isquiotibiales', 2, 'Barra', 1, 1,
        'img/ejercicio/sentadilla barra.mp4', 'img/ejercicio/sentadilla barra.jpg', 1),
       ('Dominadas', 'Ejercicio para trabajar la espalda, bíceps y braquial anterior', 3, 'Sin equipo', 1, NULL,
        'img/ejercicio/dominadas.mp4', 'img/ejercicio/dominadas.jpg', 2),
       ('Remo con barra', 'Ejercicio para trabajar la espalda, bíceps y braquial anterior', 2, 'Barra', 1, NULL,
        'img/ejercicio/remo barra.mp4', 'img/ejercicio/remo barra.jpg', 2);