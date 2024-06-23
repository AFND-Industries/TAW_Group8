use tawbd;
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

create table rutina
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

create table sesionentrenamiento
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    DIA         int          not null,
    RUTINA      int          not null,
    constraint rutina_id___fk
        foreign key (RUTINA) references rutina (ID)
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

-- Insertar datos en la tabla 'categoria'
-- INSERT INTO categoria (NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO)
-- VALUES ('Fuerza', 'Ejercicios para aumentar la masa muscular', 'Peso corporal, máquinas', 'img/categorias/fuerza.png'),
--     ('Resistencia', 'Ejercicios para mejorar la capacidad aeróbica', 'Cardio, peso corporal',
--    'img/categorias/resistencia.png'),
--  ('Flexibilidad', 'Ejercicios para mejorar la elasticidad muscular', 'Estiramientos',
-- 'img/categorias/flexibilidad.png');

-- Insertar datos en la tabla 'dificultad'
INSERT INTO dificultad (NOMBRE, LOGO)
VALUES ('Principiante', '/svg/dificultades/principiante.svg'),
       ('Intermedio', '/svg/dificultades/intermedio.svg'),
       ('Avanzado', '/svg/dificultades/avanzado.svg');

-- Insertar datos en la tabla 'musculo'
INSERT INTO musculo (NOMBRE, DESCRIPCION, IMAGEN)
VALUES ('Pectoral mayor', 'Músculo del pecho, responsable de empujar y rotar el brazo', 'img/musculos/pectoral.png'),
       ('Bíceps braquial', 'Músculo de la parte superior del brazo, responsable de flexionar el codo',
        'img/musculos/biceps.png'),
       ('Tríceps braquial', 'Músculo de la parte posterior del brazo, responsable de extender el codo',
        'img/musculos/triceps.png');

-- Insertar datos en la tabla 'tipofuerza'
INSERT INTO tipofuerza (NOMBRE, DESCRIPCION)
VALUES ('Hipertrofia', 'Ejercicios para aumentar el tamaño muscular'),
       ('Resistencia', 'Ejercicios para mejorar la resistencia muscular'),
       ('Fuerza máxima', 'Ejercicios para levantar el máximo peso posible');

INSERT INTO tawbd.tipousuario (NOMBRE)
VALUES ('Cliente'),
       ('Entrenador'),
       ('Administrador');

-- Clave de 'Eulogo' -> '1'
-- Clave de 'Tiko' -> '2'
-- Clave de 'Paco' -> 'admin'
-- Clave de los randoms -> 'clave'
insert into tawbd.usuario (ID, NOMBRE, APELLIDOS, GENERO, EDAD, DNI, CLAVE, TIPO)
values (1, 'Eulogo', 'Quemadisima', 'm', 33, '1', '6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B',
        1),
       (2, 'Tiko', 'Toko', 'm', 33, '2', 'D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35', 2),
       (3, 'Paco', 'Fiestas', 'm', 18, 'admin', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', 3),
       (4, 'Kévina', 'Brodley', 'm', 33, '49-4620362',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (5, 'Lyséa', 'Waterstone', 'f', 60, '55-8532760',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (6, 'Liè', 'Sarfas', 'm', 27, '43-5820929', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        1),
       (7, 'Océanne', 'Corriea', 'f', 57, '37-8761281',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (8, 'Eugénie', 'Tilberry', 'f', 31, '35-0665079',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (9, 'Angélique', 'Shyre', 'm', 27, '97-0215286',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (10, 'Magdalène', 'Aymes', 'f', 52, '76-9164923',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (11, 'Garçon', 'Voaden', 'f', 40, '06-4524914',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (12, 'Eloïse', 'Creeber', 'm', 18, '57-9619850',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (13, 'Valérie', 'Ewen', 'f', 18, '67-8078474',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (14, 'Léane', 'Whiteford', 'f', 35, '32-4901144',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (15, 'Clémence', 'Tunniclisse', 'm', 47, '92-2714974',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (16, 'Dà', 'Enns', 'm', 20, '49-6620492', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (17, 'Mélissandre', 'Trammel', 'f', 27, '41-2613797',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (18, 'Bécassine', 'Lyptratt', 'm', 39, '65-2480520',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (19, 'Michèle', 'Wayt', 'm', 51, '18-6604587',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (20, 'Ruò', 'Royle', 'f', 34, '27-4606899', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        1),
       (21, 'Méng', 'Adamiak', 'f', 52, '77-6419540',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (22, 'Marie-josée', 'Dran', 'f', 27, '57-9789977',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (23, 'Danièle', 'Coal', 'f', 19, '13-7151192',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (24, 'Miléna', 'Tomaszewicz', 'f', 35, '86-1884660',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (25, 'Táng', 'Szubert', 'm', 44, '70-8776964',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (26, 'Tú', 'Greensall', 'm', 36, '74-3916779',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (27, 'Hélèna', 'McParland', 'f', 47, '43-1143445',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (28, 'Mélissandre', 'Mungin', 'f', 58, '15-2161740',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (29, 'Eugénie', 'Bagott', 'f', 47, '48-6806352',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (30, 'Mà', 'Conant', 'f', 19, '51-1925758', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        2),
       (31, 'Märta', 'De Ambrosis', 'f', 49, '88-2499854',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (32, 'Yú', 'De Bruijne', 'f', 38, '50-1379471',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (33, 'Estève', 'Papps', 'f', 36, '15-0988278',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (34, 'Mélina', 'Ankers', 'f', 58, '42-0677708',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (35, 'Åsa', 'Eastlake', 'f', 43, '87-5299628',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (36, 'Måns', 'Elvey', 'f', 30, '80-7896972', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        2),
       (37, 'Renée', 'Lambdean', 'f', 20, '36-0462919',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (38, 'Håkan', 'Leavens', 'f', 27, '97-3964177',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (39, 'Yú', 'Tellett', 'm', 53, '97-2675947', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        3),
       (40, 'Faîtes', 'Thridgould', 'f', 42, '86-2243647',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (41, 'Eléa', 'O''Brogane', 'm', 52, '72-5725930',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (42, 'Mà', 'Gonthard', 'f', 55, '82-0514420', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        3),
       (43, 'Michèle', 'Videler', 'f', 34, '76-6362958',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (44, 'Publicité', 'Choffin', 'f', 55, '35-3318911',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (45, 'Vénus', 'Sanderson', 'm', 33, '25-8970013',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (46, 'Intéressant', 'De Bischof', 'm', 19, '35-7644541',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (47, 'Marie-ève', 'Crichmer', 'm', 50, '77-0225936',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (48, 'Håkan', 'Mancer', 'f', 43, '87-2042714',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (49, 'Eloïse', 'Wrightem', 'f', 42, '59-4039353',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (50, 'Mårten', 'Archbald', 'm', 42, '28-6756229',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (51, 'Yénora', 'Sweetsur', 'm', 38, '77-0841407',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (52, 'Méline', 'De Domenico', 'f', 53, '60-9777387',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (53, 'Anaël', 'Simionato', 'm', 36, '80-4196073',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (54, 'Marie-ève', 'Broomhall', 'm', 21, '35-2712507',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (55, 'Lài', 'Goulden', 'f', 46, '78-5887430', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        3),
       (56, 'Noëlla', 'Verrills', 'm', 21, '27-0756932',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (57, 'Faîtes', 'Showell', 'm', 49, '51-4143499',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (58, 'Hélène', 'Shovell', 'm', 58, '39-2471302',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (59, 'Estée', 'Pendergrast', 'm', 44, '85-2776228',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (60, 'Mélina', 'Aubry', 'f', 20, '19-1732321',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (61, 'Adèle', 'Kingham', 'f', 33, '19-5026829',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (62, 'Magdalène', 'Aveline', 'f', 23, '77-7792224',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (63, 'Marie-josée', 'Molan', 'f', 29, '07-4490603',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (64, 'Audréanne', 'Kleiner', 'f', 32, '79-1967190',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (65, 'Liè', 'Marxsen', 'f', 30, '52-0088831', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        1),
       (66, 'Maëlyss', 'Illiston', 'f', 52, '18-3262246',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (67, 'Örjan', 'Tissiman', 'f', 40, '81-5477773',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (68, 'Maïly', 'Goldes', 'f', 28, '16-5917489',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (69, 'Maëlys', 'Gove', 'f', 31, '88-5057140', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        3),
       (70, 'Gösta', 'Chippindall', 'f', 47, '60-9900203',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (71, 'Gaïa', 'Congreave', 'm', 37, '36-8112674',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (72, 'Léana', 'Calken', 'f', 53, '62-7615388',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (73, 'Marie-ève', 'Legendre', 'm', 52, '11-0720109',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (74, 'Solène', 'Lafaye', 'f', 58, '29-7623020',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (75, 'Lucrèce', 'Huddle', 'm', 22, '45-7657605',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (76, 'Géraldine', 'Calton', 'm', 49, '81-1094857',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (77, 'Desirée', 'Ten Broek', 'f', 20, '31-8970711',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (78, 'Börje', 'Le Marquis', 'f', 36, '96-1291928',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (79, 'Östen', 'Stadden', 'f', 60, '06-8038270',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (80, 'Maëlle', 'Figliovanni', 'f', 19, '98-9512137',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (81, 'Hélène', 'Grievson', 'f', 50, '89-2022046',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (82, 'Léone', 'Jakubovsky', 'f', 60, '43-3549739',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (83, 'Annotée', 'Bradbeer', 'f', 34, '11-5110407',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (84, 'Naëlle', 'Grills', 'm', 54, '99-1893112',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (85, 'Léone', 'Tustin', 'm', 24, '33-5789383',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (86, 'Zhì', 'Stiggers', 'f', 43, '85-1559057',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (87, 'Faîtes', 'Cuerdale', 'f', 53, '30-4908109',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (88, 'Marylène', 'Toyne', 'm', 46, '81-6614024',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (89, 'Ophélie', 'Shearmer', 'f', 44, '52-4388864',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 3),
       (90, 'Pål', 'Yeoland', 'm', 57, '68-1402671', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        2),
       (91, 'Tán', 'McGunley', 'm', 53, '22-4616373',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (92, 'Méng', 'Battle', 'f', 19, '49-0062777', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        1),
       (93, 'Solène', 'Bartolic', 'm', 34, '82-7931585',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (94, 'Lauréna', 'McArthur', 'f', 33, '69-4993113',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (95, 'Maïté', 'Jayme', 'f', 54, '84-5002404', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        1),
       (96, 'Publicité', 'Burhill', 'm', 43, '78-5084849',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (97, 'Valérie', 'Melsome', 'f', 58, '03-2076207',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (98, 'Adèle', 'Lung', 'm', 42, '35-0329449', '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06',
        2),
       (99, 'Réjane', 'Dowty', 'f', 33, '57-5487463',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 2),
       (100, 'Táng', 'Dudeney', 'f', 22, '14-3975071',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (101, 'Laurélie', 'Mowat', 'f', 44, '54-7658223',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (102, 'Maéna', 'Summerell', 'f', 39, '33-6258889',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1),
       (103, 'Gwenaëlle', 'McKevany', 'm', 60, '68-7923463',
        '6D5074B4BF2B913866157D7674F1EDA042C5C614876DE876F7512702D2572A06', 1);

-- Insertar datos en la tabla 'rutina'
INSERT INTO rutina (NOMBRE, DESCRIPCION, DIFICULTAD, FECHA_CREACION, ENTRENADOR)
VALUES ('Rutina para principiantes', 'Ejercicios básicos para tonificar todo el cuerpo', 1, '2024-04-01', 2),
       ('Rutina para quemar grasa', 'Ejercicios enfocados en el gasto calórico', 2, '2024-04-05', 2),
       ('Rutina para ganar músculo', 'Ejercicios para aumentar la masa muscular', 3, '2024-04-10', 2),
       ('Rutina de El Megalodon', 'Ejercicios básicos para torneo de badbintom', 1, '2024-04-29', 4);


-- Insertar datos en la tabla 'sesionentrenamiento'
INSERT INTO sesionentrenamiento (NOMBRE, DESCRIPCION, DIA, RUTINA)
VALUES ('Piernas', 'Ejercicios enfocados en fortalecer los músculos de las piernas', 1, 1),
       ('Tren superior', 'Ejercicios para trabajar pecho, espalda, hombros y brazos', 2, 1);

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

-- INSERT INTO `ejerciciosesion` VALUES (1,1,'{\"peso\":15,\"series\":5,\"repeticiones\":12}',1,2),(2,1,'{\"peso\":15,\"series\":5,\"repeticiones\":12}',2,1),(3,2,'{\"peso\":15,\"series\":7,\"repeticiones\":12}',1,3);
INSERT INTO `entrenadorasignado`
VALUES (2, 1);
-- INSERT INTO `informacionejercicio` VALUES (1,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',1,1),(2,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',3,1),(5,'[{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 12,\"mpeso\": \"NO\"},{\"repeticiones\": 11,\"mpeso\": \"NO\"},{\"repeticiones\": 10,\"mpeso\": \"NO\"},{\"repeticiones\": 9,\"mpeso\": \"NO\"}]',2,2);
-- INSERT INTO `informacionsesion` VALUES (1,5,'Me ha gustado mucho este ejercicio,lo repetiría mil veces más','2024-04-25',1,1),(2,1,'Esto es una mierda','2024-05-18',2,1);
INSERT INTO `rutinacliente`
VALUES (1, 1, '2024-04-25'),
       (1, 2, '2024-04-12'),
       (1, 3, '2024-04-12');
-- Por alguna razón esta línea da error
-- INSERT INTO `sesionrutinas` VALUES (1,1,1),(2,1,2);
