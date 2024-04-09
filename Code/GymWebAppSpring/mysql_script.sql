-- this sql script works for MariaDB

create table CATEGORIA
(
    ID          int auto_increment,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null,
    TIPOS_BASE  VARCHAR(64)  not null,
    ICONO       varchar(256) not null,
    constraint CATEGORIA_pk
        primary key (ID)
);

create table DIFICULTAD
(
    ID     int auto_increment,
    NOMBRE varchar(32)  not null,
    LOGO   varchar(256) not null,
    constraint DIFICULTAD_pk
        primary key (ID)
);

create table MUSCULO
(
    ID          int auto_increment,
    NOMBRE      VARCHAR(32)  not null,
    DESCRIPCION VARCHAR(256) not null,
    IMAGEN      VARCHAR(256) not null,
    constraint MUSCULO_pk
        primary key (ID)
);

create table RUTINA
(
    ID             int auto_increment
        primary key,
    NOMBRE         varchar(32)  not null,
    DESCRIPCION    varchar(256) not null,
    DIFICULTAD     int          not null,
    FECHA_CREACION DATE         not null,
    constraint RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk
        foreign key (DIFICULTAD) references DIFICULTAD (ID)
);

create table SESIONENTRENAMIENTO
(
    ID          int auto_increment
        primary key,
    NOMBRE      varchar(32)  not null,
    DESCRIPCION varchar(256) not null
);

create table SESIONRUTINAS
(
    SESIONENTRENAMIENTO_ID int not null,
    RUTINA_ID              int not null,
    DIA                    int not null,
    constraint SESIONRUTINAS_ibfk_1
        foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID),
    constraint SESIONRUTINAS_ibfk_2
        foreign key (RUTINA_ID) references RUTINA (ID)
);

create table TIPOFUERZA
(
    ID          int auto_increment,
    NOMBRE      VARCHAR(32)  not null,
    DESCRIPCION VARCHAR(256) not null,
    constraint TIPOFUERZA_pk
        primary key (ID)
);

create table EJERCICIO
(
    ID                 int auto_increment,
    NOMBRE             varchar(32)  not null,
    DESCRIPCION        varchar(256) not null,
    MUSCULO            INT          not null,
    EQUIPAMIENTO       varchar(32)  not null,
    TIPOFUERZA         INT          not null,
    MUSCULO_SECUNDARIO INT          null,
    VIDEO              varchar(256) not null,
    LOGO               varchar(256) not null,
    CATEGORIA          int          not null,
    constraint EJERCICIO_pk
        primary key (ID),
    constraint EJERCICIO_MUSCULO_ID_fk
        foreign key (MUSCULO) references MUSCULO (ID),
    constraint EJERCICIO_MUSCULO_ID_fk_2
        foreign key (MUSCULO_SECUNDARIO) references MUSCULO (ID),
    constraint EJERCICIO_TIPOFUERZA_ID_fk
        foreign key (TIPOFUERZA) references TIPOFUERZA (ID),
    constraint EJERCICIO_ibfk_1
        foreign key (CATEGORIA) references CATEGORIA (ID)
);

create table EJERCICIOSESION
(
    ID                     int auto_increment
        primary key,
    ORDEN                  int          not null,
    ESPECIFICACIONES       VARCHAR(256) not null comment 'JSON syntax',
    SESIONENTRENAMIENTO_ID int          not null,
    EJERCICIO_ID           int          not null,
    constraint EJERCICIOSESION_ibfk_1
        foreign key (EJERCICIO_ID) references EJERCICIO (ID),
    constraint EJERCICIOSESION_ibfk_2
        foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID)
);

create table TIPOUSUARIO
(
    ID     int auto_increment
        primary key,
    NOMBRE varchar(32) not null
);

create table USUARIO
(
    ID        int auto_increment
        primary key,
    NOMBRE    varchar(32) not null,
    APELLIDOS varchar(32) not null,
    GENERO    char        not null,
    EDAD      int         not null,
    DNI       varchar(32) not null,
    CLAVE     varchar(60) not null,
    TIPO      int         not null,
    constraint USUARIO_TIPOUSUARIO_1
        foreign key (TIPO) references TIPOUSUARIO (ID)
);

create table ENTRENADORASIGNADO
(
    ENTRENADOR int default NULL null,
    CLIENTE    int default NULL null,
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk
        foreign key (ENTRENADOR) references USUARIO (ID),
    constraint ENTRENADORASIGNADO_USUARIO_ID_fk_2
        foreign key (CLIENTE) references USUARIO (ID)
);

create table INFORMACIONSESION
(
    ID                     int auto_increment
        primary key,
    VALORACION             int          default NULL null,
    COMENTARIO             varchar(256) default NULL null,
    FECHA_FIN              DATE                      null,
    SESIONENTRENAMIENTO_ID int                       not null,
    USUARIO_ID             int                       not null,
    constraint INFORMACIONSESION_USUARIO_2
        foreign key (USUARIO_ID) references USUARIO (ID),
    constraint INFORMACIONSESION_ibfk_1
        foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID)
);

create table INFORMACIONEJERCICIO
(
    ID                   int auto_increment
        primary key,
    EVALUACION           VARCHAR(256) not null comment 'JSON syntax',
    EJERCICIOSESION_ID   int          not null,
    INFORMACIONSESION_ID int          not null,
    constraint INFORMACIONEJERCICIO_ibfk_1
        foreign key (EJERCICIOSESION_ID) references EJERCICIOSESION (ID),
    constraint INFORMACIONEJERCICIO_ibfk_2
        foreign key (INFORMACIONSESION_ID) references INFORMACIONSESION (ID)
);

create table RUTINACLIENTE
(
    USUARIO_ID   int  not null,
    RUTINA_ID    int  not null,
    FECHA_INICIO DATE not null,
    constraint RUTINACLIENTE_RUTINA_1
        foreign key (RUTINA_ID) references RUTINA (ID),
    constraint RUTINACLIENTE_USUARIO_2
        foreign key (USUARIO_ID) references USUARIO (ID)
);

create table RUTINAENTRENADOR
(
    USUARIO_ID int not null,
    RUTINA_ID  int not null,
    constraint RUTINAENTRENADOR_USUARIO_2
        foreign key (USUARIO_ID) references USUARIO (ID),
    constraint RUTINAENTRENADOR_ibfk_1
        foreign key (RUTINA_ID) references RUTINA (ID)
);

