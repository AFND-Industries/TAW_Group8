create table categoria
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    TIPOS_BASE  varchar(64)  not null,
    ICONO       varchar(256) not null
);

create table dificultad
(
    ID     int auto_increment
        primary key,
    NOMBRE varchar(32)  not null,
    LOGO   varchar(256) not null
);

create table musculo
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    IMAGEN      varchar(256) not null
);

create table rutina
(
    ID             int auto_increment
        primary key,
    NOMBRE         varchar(32)  not null,
    DESCRIPCION    varchar(256) not null,
    DIFICULTAD     int          not null,
    FECHA_CREACION date         not null,
    constraint RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk
        foreign key (DIFICULTAD) references dificultad (ID)
);

create table sesionentrenamiento
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null
);

create table sesionrutinas
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

create table tipofuerza
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null
);

create table ejercicio
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

create table ejerciciosesion
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

create table tipousuario
(
    ID     int auto_increment
        primary key,
    NOMBRE varchar(32) not null
);

create table usuario
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

create table entrenadorasignado
(
    ENTRENADOR int not null,
    CLIENTE    int not null,
    primary key (ENTRENADOR, CLIENTE),
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk
        foreign key (ENTRENADOR) references usuario (ID),
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk_2
        foreign key (CLIENTE) references usuario (ID)
);

create table informacionsesion
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

create table informacionejercicio
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

create table rutinacliente
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

create table rutinaentrenador
(
    USUARIO_ID int not null,
    RUTINA_ID  int not null,
    primary key (RUTINA_ID, USUARIO_ID),
    constraint RUTINAENTRENADOR_USUARIO_2
        foreign key (USUARIO_ID) references usuario (ID),
    constraint RUTINAENTRENADOR_ibfk_1
        foreign key (RUTINA_ID) references rutina (ID)
);

use tawbd;

-- Insertar datos en la tabla 'categoria'
INSERT INTO categoria (NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO)
VALUES ('Fuerza', 'Ejercicios para aumentar la masa muscular', 'Peso corporal, máquinas', 'img/categorias/fuerza.png'),
       ('Resistencia', 'Ejercicios para mejorar la capacidad aeróbica', 'Cardio, peso corporal',
        'img/categorias/resistencia.png'),
       ('Flexibilidad', 'Ejercicios para mejorar la elasticidad muscular', 'Estiramientos',
        'img/categorias/flexibilidad.png');

-- Insertar datos en la tabla 'dificultad'
INSERT INTO dificultad (NOMBRE, LOGO)
VALUES ('Principiante', 'img/dificultades/principiante.png'),
       ('Intermedio', 'img/dificultades/intermedio.png'),
       ('Avanzado', 'img/dificultades/avanzado.png');

-- Insertar datos en la tabla 'musculo'
INSERT INTO musculo (NOMBRE, DESCRIPCION, IMAGEN)
VALUES ('Pectoral mayor', 'Músculo del pecho, responsable de empujar y rotar el brazo', 'img/musculos/pectoral.png'),
       ('Bíceps braquial', 'Músculo de la parte superior del brazo, responsable de flexionar el codo',
        'img/musculos/biceps.png'),
       ('Tríceps braquial', 'Músculo de la parte posterior del brazo, responsable de extender el codo',
        'img/musculos/triceps.png');

-- Insertar datos en la tabla 'rutina'
INSERT INTO rutina (NOMBRE, DESCRIPCION, DIFICULTAD, FECHA_CREACION)
VALUES ('Rutina para principiantes', 'Ejercicios básicos para tonificar todo el cuerpo', 1, '2024-04-01'),
       ('Rutina para quemar grasa', 'Ejercicios enfocados en el gasto calórico', 2, '2024-04-05'),
       ('Rutina para ganar músculo', 'Ejercicios para aumentar la masa muscular', 3, '2024-04-10');

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
VALUES ('Eulogo', 'Quemadisima', 'm', 33, '11111111A', '1B22CEE6348A210E0E9CAD705D35D7482378C08B743A515D8181635D27EF5841', 1),
       ('Tiko', 'Toko', 'm', 33, '22222222B', 'CEFF528A2A0202D27153524FE2DFEE5EA2F53CFA0107A7E13791ADCA00D05D0E', 1),
       ('Paco', 'Fiestas', 'm', 18, '33333333C', '3C6138A5C4C65E1C00ED79F2607C2B3B786403CF60798B4EF015F6F9EEFD6A85', 3);

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