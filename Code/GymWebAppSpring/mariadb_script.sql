-- this sql script should work for MySQL 8.3.0

create table CATEGORIA (
    ID int auto_increment,
    NOMBRE varchar(32) not null,
    DESCRIPCION varchar(256) not null,
    TIPOS_BASE VARCHAR(64) not null,
    ICONO varchar(256) not null
);

alter table CATEGORIA
add constraint CATEGORIA_pk primary key (ID);

create table DIFICULTAD (
    ID int auto_increment, NOMBRE varchar(32) not null, LOGO varchar(256) not null
);

alter table DIFICULTAD
add constraint DIFICULTAD_pk primary key (ID);

create table MUSCULO (
    ID int auto_increment, NOMBRE VARCHAR(32) not null, DESCRIPCION VARCHAR(256) not null, IMAGEN VARCHAR(256) not null
);

alter table MUSCULO
add constraint MUSCULO_pk primary key (ID);

create table TIPOFUERZA (
    ID int auto_increment, NOMBRE VARCHAR(32) not null, DESCRIPCION VARCHAR(256) not null
);

alter table TIPOFUERZA
add constraint TIPOFUERZA_pk primary key (ID);

create table EJERCICIO (
    ID int auto_increment, NOMBRE varchar(32) not null, DESCRIPCION varchar(256) not null, MUSCULO INT not null, EQUIPAMIENTO varchar(32) not null, TIPOFUERZA INT not null, MUSCULO_SECUNDARIO INT null, VIDEO varchar(256) not null, LOGO varchar(256) not null, CATEGORIA int not null
);

alter table EJERCICIO
add constraint EJERCICIO_pk primary key (ID);

alter table EJERCICIO
add constraint EJERCICIO_MUSCULO_ID_fk foreign key (MUSCULO) references MUSCULO (ID);

alter table EJERCICIO
add constraint EJERCICIO_MUSCULO_ID_fk_2 foreign key (MUSCULO_SECUNDARIO) references MUSCULO (ID);

alter table EJERCICIO
add constraint EJERCICIO_TIPOFUERZA_ID_fk foreign key (TIPOFUERZA) references TIPOFUERZA (ID);

alter table EJERCICIO
add constraint EJERCICIO_ibfk_1 foreign key (CATEGORIA) references CATEGORIA (ID);

create table EJERCICIOSESION (
    ID int auto_increment, ORDEN int not null,
    ESPECIFICACIONES VARCHAR(256) not null comment 'JSON syntax',
    SESIONENTRENAMIENTO_ID int not null,
    EJERCICIO_ID int not null
);

alter table EJERCICIOSESION add primary key (ID);

alter table EJERCICIOSESION
add constraint EJERCICIOSESION_ibfk_1 foreign key (EJERCICIO_ID) references ejercicio (ID);

create table ENTRENADORASIGNADO (
    ENTRENADOR int default NULL null,
    CLIENTE int default NULL null
) ;

create table INFORMACIONEJERCICIO (
    ID int auto_increment,
    EVALUACION VARCHAR(256) not null comment 'JSON syntax',
    EJERCICIOSESION_ID int not null,
    INFORMACIONSESION_ID int not null
);

alter table INFORMACIONEJERCICIO add primary key (ID);

alter table INFORMACIONEJERCICIO
add constraint INFORMACIONEJERCICIO_ibfk_1 foreign key (EJERCICIOSESION_ID) references EJERCICIOSESION (ID);

create table INFORMACIONSESION (
    ID int auto_increment,
    VALORACION int default NULL null,
    COMENTARIO varchar(256) default NULL null,
    FECHA_FIN DATE null,
    SESIONENTRENAMIENTO_ID int not null,
    USUARIO_ID int not null
);

alter table INFORMACIONSESION add primary key (ID);

alter table INFORMACIONEJERCICIO
add constraint INFORMACIONEJERCICIO_ibfk_2 foreign key (INFORMACIONSESION_ID) references INFORMACIONSESION (ID);

create table RUTINA (
    ID int auto_increment, NOMBRE varchar(32) not null, DESCRIPCION varchar(256) not null, DIFICULTAD int not null, FECHA_CREACION DATE not null
);

alter table RUTINA add primary key (ID);

alter table RUTINA
add constraint RUTINA_DIFICULTADRUTINA_DIFICULTAD_fk foreign key (DIFICULTAD) references DIFICULTAD (ID);

create table RUTINACLIENTE (
    USUARIO_ID int not null, RUTINA_ID int not null, FECHA_INICIO DATE not null
);

alter table RUTINACLIENTE
add constraint RUTINACLIENTE_RUTINA_1 foreign key (RUTINA_ID) references RUTINA (ID);

create table RUTINAENTRENADOR (
    USUARIO_ID int not null, RUTINA_ID int not null
);

alter table RUTINAENTRENADOR
add constraint RUTINAENTRENADOR_ibfk_1 foreign key (RUTINA_ID) references RUTINA (ID);

create table SESIONENTRENAMIENTO (
    ID int auto_increment, NOMBRE varchar(32) not null, DESCRIPCION varchar(256) not null
);

alter table SESIONENTRENAMIENTO add primary key (ID);

alter table EJERCICIOSESION
add constraint EJERCICIOSESION_ibfk_2 foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID);

alter table INFORMACIONSESION
add constraint INFORMACIONSESION_ibfk_1 foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID);

create table SESIONRUTINAS (
    SESIONENTRENAMIENTO_ID int not null, RUTINA_ID int not null, DIA int not null
);

alter table SESIONRUTINAS
add constraint SESIONRUTINAS_ibfk_1 foreign key (SESIONENTRENAMIENTO_ID) references SESIONENTRENAMIENTO (ID);

alter table SESIONRUTINAS
add constraint SESIONRUTINAS_ibfk_2 foreign key (RUTINA_ID) references RUTINA (ID);

create table TIPOUSUARIO (
    ID int auto_increment, NOMBRE varchar(32) not null
);

alter table TIPOUSUARIO add primary key (ID);

create table USUARIO (
    ID int auto_increment, NOMBRE varchar(32) not null, APELLIDOS varchar(32) not null, GENERO char not null, EDAD int not null, DNI varchar(32) not null, CLAVE varchar(60) not null, TIPO int not null
);

alter table USUARIO add primary key (ID);

alter table ENTRENADORASIGNADO
add constraint ENTRENADORASIGNADO_USUARIO_ID_fk foreign key (ENTRENADOR) references USUARIO (ID);

alter table ENTRENADORASIGNADO
add constraint ENTRENADORASIGNADO_USUARIO_ID_fk_2 foreign key (CLIENTE) references USUARIO (ID);

alter table INFORMACIONSESION
add constraint INFORMACIONSESION_USUARIO_2 foreign key (USUARIO_ID) references USUARIO (ID);

alter table RUTINACLIENTE
add constraint RUTINACLIENTE_USUARIO_2 foreign key (USUARIO_ID) references USUARIO (ID);

alter table RUTINAENTRENADOR
add constraint RUTINAENTRENADOR_USUARIO_2 foreign key (USUARIO_ID) references USUARIO (ID);

alter table USUARIO
add constraint USUARIO_TIPOUSUARIO_1 foreign key (TIPO) references TIPOUSUARIO (ID);