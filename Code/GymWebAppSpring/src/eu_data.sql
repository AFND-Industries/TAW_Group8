
INSERT INTO tawbd.Usuario (NOMBRE, APELLIDOS, GENERO, EDAD, DNI, CLAVE, TIPO)
VALUES ('El Megalodon','Suarez','m', 22,'4','4B227777D4DD1FC61C6F884F48641D02B4D121D3FD328CB08B5531FCACDABF8A', 2);

INSERT INTO rutina (NOMBRE, DESCRIPCION, DIFICULTAD, FECHA_CREACION, ENTRENADOR)
VALUES ('Rutina de El Megalodon', 'Ejercicios básicos para torneo de badbintom', 1, '2024-04-29', 4);

INSERT INTO tawbd.categoria (ID, NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO) VALUES (1, 'Fuerza', 'Ejercicios para aumentar la masa muscular', '[\'Series\', \'Repeticiones\', \'Peso añadido\']', 'https://static.vecteezy.com/system/resources/previews/012/713/701/non_2x/strength-icon-design-free-vector.jpg');
INSERT INTO tawbd.categoria (ID, NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO) VALUES (2, 'Resistencia', 'Ejercicios para mejorar la capacidad aeróbica', '[\'Series\', \'Repeticiones\', \'Peso añadido\', \'Descanso\']', 'https://cdn1.iconfinder.com/data/icons/finger-line-vol1/64/icn_finger_resistance-512.png');
INSERT INTO tawbd.categoria (ID, NOMBRE, DESCRIPCION, TIPOS_BASE, ICONO)
VALUES (3, 'Flexibilidad', 'Ejercicios para mejorar la elasticidad muscular',
        '[\'Repeticiones\', \'Tiempo de estiramiento\']',
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.com%2Fde%2Fkostenloses-icon%2Ftrainieren_2216811&psig=AOvVaw3YEfYpKioPJtVHizAUsNBg&ust=1715016063430000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCODysO6C94UDFQAAAAAdAAAAABAR');


INSERT INTO tawbd.ejercicio (ID, NOMBRE, DESCRIPCION, MUSCULO, EQUIPAMIENTO, TIPOFUERZA, MUSCULO_SECUNDARIO, VIDEO, LOGO, CATEGORIA) VALUES (1, 'Press de banca', 'Ejercicio para trabajar el pectoral mayor acostado en un banco horizontal', 1, 'Barra', 1, 3, 'https://www.youtube.com/embed/48L0oQApm_0?autoplay=1&mute=1', 'https://blogscdn.thehut.net/app/uploads/sites/450/2016/03/shutterstock_336330497opt_hero_1620634941_1620820354.jpg', 1);
INSERT INTO tawbd.ejercicio (ID, NOMBRE, DESCRIPCION, MUSCULO, EQUIPAMIENTO, TIPOFUERZA, MUSCULO_SECUNDARIO, VIDEO, LOGO, CATEGORIA) VALUES (2, 'Sentadillas con barra', 'Ejercicio para trabajar los cuádriceps, glúteos e isquiotibiales', 2, 'Barra', 1, 1, 'https://www.youtube.com/embed/NHD0vH7XXgw?autoplay=1&mute=1', 'https://vidafit.movix.com/wp-content/uploads/2022/02/VF_2022_02_24.jpg', 1);
INSERT INTO tawbd.ejercicio (ID, NOMBRE, DESCRIPCION, MUSCULO, EQUIPAMIENTO, TIPOFUERZA, MUSCULO_SECUNDARIO, VIDEO, LOGO, CATEGORIA) VALUES (3, 'Dominadas', 'Ejercicio para trabajar la espalda, bíceps y braquial anterior', 3, 'Sin equipo', 1, null, 'https://www.youtube.com/embed/_9rGBwreteE?autoplay=1&mute=1', 'https://www.calistenia.net/wp-content/uploads/2016/07/Aumentar-Dominadas.jpg', 2);
INSERT INTO tawbd.ejercicio (ID, NOMBRE, DESCRIPCION, MUSCULO, EQUIPAMIENTO, TIPOFUERZA, MUSCULO_SECUNDARIO, VIDEO, LOGO, CATEGORIA) VALUES (4, 'Remo con barra', 'Ejercicio para trabajar la espalda, bíceps y braquial anterior', 2, 'Barra', 1, null, 'https://www.youtube.com/embed/sr_U0jBE89A?autoplay=1&mute=1', 'https://go-fit.es/wp-content/uploads/2023/02/REMO_BARRA_1200X800-1024x683.jpg', 2);
