DROP DATABASE IF EXISTS ETS20262;
CREATE DATABASE ETS20262 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ETS20262;

CREATE TABLE carrera (
    id_carrera INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre ENUM('Ingenieria en Sistemas Computacionales',
				'Ingenieria en Inteligencia Artificial',
				'Licenciatura en Ciencia de Datos',
				'Ingenieria en Sistemas Automotrices',
				'N/A') NOT NULL DEFAULT 'N/A',
    iniciales ENUM('ISC','IIA','LCD','ISISA','N/A') NOT NULL DEFAULT 'N/A',
    descripcion VARCHAR(512) NOT NULL DEFAULT ''
);

INSERT INTO carrera (nombre, iniciales, descripcion) VALUES ('Ingenieria en Sistemas Computacionales', 'ISC', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Earum nobis atque similique voluptatum enim aliquid placeat nam cupiditate impedit doloremque?');
INSERT INTO carrera (nombre, iniciales, descripcion) VALUES ('Ingenieria en Inteligencia Artificial', 'IIA', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Earum nobis atque similique voluptatum enim aliquid placeat nam cupiditate impedit doloremque?');
INSERT INTO carrera (nombre, iniciales, descripcion) VALUES ('Licenciatura en Ciencia de Datos', 'LCD', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Earum nobis atque similique voluptatum enim aliquid placeat nam cupiditate impedit doloremque?');
INSERT INTO carrera (nombre, iniciales, descripcion) VALUES ('Ingenieria en Sistemas Automotrices', 'ISISA', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Earum nobis atque similique voluptatum enim aliquid placeat nam cupiditate impedit doloremque?');
INSERT INTO carrera (nombre, iniciales, descripcion) VALUES ('N/A', 'N/A', 'N/A');
SELECT * FROM carrera;

CREATE TABLE coordinador (
    id_coordinador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    primer_nombre VARCHAR(64) NOT NULL,
    segundo_nombre VARCHAR(64) DEFAULT NULL,
    primer_apellido VARCHAR(64) NOT NULL,
    segundo_apellido VARCHAR(64) NOT NULL,
    email VARCHAR(128) NOT NULL,
    CONSTRAINT uq_coordinador_email UNIQUE (email)
);

INSERT INTO coordinador (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email) VALUES
('Carlos',    'Eduardo',  'García',     'López',      'cgarcia@ipn.mx'),
('María',     'Fernanda', 'Martínez',   'Hernández',  'mmartinez@ipn.mx'),
('José',      'Luis',     'Rodríguez',  'Pérez',      'jrodriguez@ipn.mx'),
('Ana',       'Sofía',    'López',      'González',   'alopez@ipn.mx'),
('Luis',      'Miguel',   'Hernández',  'Ramírez',    'lhernandez@ipn.mx'),
('Patricia',  'Elena',    'González',   'Torres',     'pgonzalez@ipn.mx'),
('Roberto',   'Andrés',   'Pérez',      'Flores',     'rperez@ipn.mx'),
('Laura',     'Isabel',   'Sánchez',    'Rivera',     'lsanchez@ipn.mx'),
('Fernando',  'Javier',   'Ramírez',    'Cruz',       'framirez@ipn.mx'),
('Gabriela',  'Monserrat','Torres',     'Morales',    'gtorres@ipn.mx'),
('Miguel',    'Ángel',    'Flores',     'Ortiz',      'mflores@ipn.mx'),
('Alejandra', 'Paola',    'Rivera',     'Gutiérrez',  'arivera@ipn.mx'),
('Ricardo',   'Alonso',   'Cruz',       'Vargas',     'rcruz@ipn.mx'),
('Verónica',  'Lizbeth',  'Morales',    'Castillo',   'vmorales@ipn.mx'),
('Sergio',    'Iván',     'Ortiz',      'Jiménez',    'sortiz@ipn.mx'),
('Diana',     'Lucía',    'Gutiérrez',  'Mendoza',    'dgutierrez@ipn.mx'),
('Héctor',    'Manuel',   'Vargas',     'Reyes',      'hvargas@ipn.mx'),
('Claudia',   'Berenice', 'Castillo',   'Herrera',    'ccastillo@ipn.mx'),
('Arturo',    'Emilio',   'Jiménez',    'Medina',     'ajimenez@ipn.mx'),
('Silvia',    'Guadalupe','Mendoza',    'Ruiz',       'smendoza@ipn.mx'),
('Jorge',     'Alberto',  'Reyes',      'Aguilar',    'jreyes@ipn.mx'),
('Mónica',    'Adriana',  'Herrera',    'Vega',       'mherrera@ipn.mx'),
('Eduardo',   'Rafael',   'Medina',     'Soto',       'emedina@ipn.mx'),
('Sandra',    'Cristina', 'Ruiz',       'Ramos',      'sruiz@ipn.mx'),
('Alejandro', 'David',    'Aguilar',    'Ríos',       'aaguilar@ipn.mx'),
('Irene',     'Valeria',  'Vega',       'Delgado',    'ivega@ipn.mx'),
('Raúl',      'Ernesto',  'Soto',       'Fuentes',    'rsoto@ipn.mx'),
('Norma',     'Angélica', 'Ramos',      'Peña',       'nramos@ipn.mx'),
('Óscar',     'Gerardo',  'Ríos',       'Navarro',    'orios@ipn.mx'),
('Leticia',   'Rocío',    'Delgado',    'Domínguez',  'ldelgado@ipn.mx'),
('Enrique',   'César',    'Fuentes',    'Cervantes',  'efuentes@ipn.mx'),
('Brenda',    'Natalia',  'Peña',       'Sandoval',   'bpena@ipn.mx'),
('Víctor',    'Hugo',     'Navarro',    'Cabrera',    'vnavarro@ipn.mx'),
('Karla',     'Denisse',  'Domínguez',  'Rojas',      'kdominguez@ipn.mx'),
('Rubén',     'Octavio',  'Cervantes',  'Guerrero',   'rcervantes@ipn.mx'),
('Yolanda',   'Marisol',  'Sandoval',   'Lara',       'ysandoval@ipn.mx'),
('Ignacio',   'Patricio', 'Cabrera',    'Campos',     'icabrera@ipn.mx'),
('Marcela',   'Esther',   'Rojas',      'Espinoza',   'mrojas@ipn.mx'),
('Benjamín',  'Saúl',     'Guerrero',   'Contreras',  'bguerrero@ipn.mx'),
('Esperanza', 'Dolores',  'Lara',       'Miranda',    'elara@ipn.mx');

SELECT * FROM coordinador;

CREATE TABLE materia (
    id_materia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_carrera INT NOT NULL,
    nombre VARCHAR(128) NOT NULL,
    creditos FLOAT NOT NULL,
    nivel INT NOT NULL,
    plan ENUM('2020','2009', '2006','1999','N/A') NOT NULL DEFAULT '2020',

    CONSTRAINT chk_nivel CHECK (nivel BETWEEN 1 AND 8),
    CONSTRAINT chk_creditos CHECK (creditos >= 0.0),

    CONSTRAINT fk_materia_carrera
        FOREIGN KEY (id_carrera) REFERENCES carrera (id_carrera)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


--  ISC Plan 2020
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
--  Primero
(1,'Calculo',7.5,1,'2020'),
(1,'Analisis Vectorial',7.5,1,'2020'),
(1,'Matematicas Discretas',10.5,1,'2020'),
(1,'Comunicacion Oral y Escrita',7.5,1,'2020'),
(1,'Fundamentos de Programacion',7.5,1,'2020'),

--  Segundo
(1,'Algebra Lineal',9.0,2,'2020'),
(1,'Calculo Aplicado',7.5,2,'2020'),
(1,'Mecanica y Electromagnetismo',10.5,2,'2020'),
(1,'Ingenieria, Etica y Sociedad',9,2,'2020'),
(1,'Fundamentos Economicos',7.5,2,'2020'),
(1,'Algoritmos y Estructuras de Datos',7.5,2,'2020'),

--  Tercero
(1,'Ecuaciones Diferenciales',9.0,3,'2020'),
(1,'Circuitos Electricos',7.5,3,'2020'),
(1,'Fundamentos de Diseño Digital',7.5,3,'2020'),
(1,'Bases de Datos',7.5,3,'2020'),
(1,'Finanzas Empresariales',7.5,3,'2020'),
(1,'Paradigmas de Programacion',7.5,3,'2020'),
(1,'Analisis y Diseño de Algoritmos',7.5,3,'2020'),

--  Cuarto
(1,'Probabilidad y Estadistica',9.0,4,'2020'),
(1,'Matematicas Avanzadas para la Ingenieria',9.0,4,'2020'),
(1,'Electronica Analogica',7.5,4,'2020'),
(1,'Diseño de Sistemas Digitales',7.5,4,'2020'),
(1,'Tecnologias para el Desarrollo de Aplicaciones Web',7.5,4,'2020'),
(1,'Sistemas Operativos',7.5,4,'2020'),
(1,'Teoria de la Computacion',7.5,4,'2020'),

--  Quinto
(1,'Procesamiento Digital de Señales',7.5,5,'2020'),
(1,'Instrumentacion y Control',7.5,5,'2020'),
(1,'Arquitectura de Computadoras',7.5,5,'2020'),
(1,'Analisis y Diseño de Sistemas',7.5,5,'2020'),
(1,'Formulacion y Evaluacion de Proyectos Informaticos',6.0,5,'2020'),
(1,'Compiladores',7.5,5,'2020'),
(1,'Redes de Computadoras',7.5,5,'2020'),

--  Sexto
(1,'Sistemas en Chip',7.5,6,'2020'),
(1,'Metodos Cuantitativos para la Toma de Decisiones',7.5,6,'2020'),
(1,'Ingenieria de Software',7.5,6,'2020'),
(1,'Inteligencia Artificial',7.5,6,'2020'),
(1,'Aplicaciones para Comunicaciones en Red',7.5,6,'2020'),

-- Optativas de Sexto
(1,'Cellular Automata',7.5,6,'2020'),
(1,'Computer Graphics',7.5,6,'2020'),
(1,'Genetic Algorithms',7.5,6,'2020'),
(1,'Non-Relational Databases',7.5,6,'2020'),
(1,'Machine Learning',7.5,6,'2020'),
(1,'Software Quality Assurance and Design Patterns',7.5,6,'2020'),
(1,'Statical Tools for Data Analytics',7.5,6,'2020'),
(1,'Embedded Systems',7.5,6,'2020'),
(1,'Virtual Instrumentation',7.5,6,'2020'),
(1,'Introduction to Cryptography',7.5,6,'2020'),
(1,'Computer Security',7.5,6,'2020'),
(1,'High Technology Enterprise Management',7.5,6,'2020'),
(1,'Computing Selected Topics I',7.5,6,'2020'),

--  Septimo
(1,'Desarrollo de Aplicaciones Moviles Nativas',7.5,7,'2020'),
(1,'Trabajo Terminal I',12.0,7,'2020'),
(1,'Sistemas Distribuidos',7.5,7,'2020'),
(1,'Administracion de Servicios en Red',7.5,7,'2020'),

--  Optativas de Septimo
(1,'Complex Systems',7.5,7,'2020'),
(1,'Virtual and Augmented Reaility',7.5,7,'2020'),
(1,'Bioinformatics',7.5,7,'2020'),
(1,'Big Data',7.5,7,'2020'),
(1,'Natural Language Processing',7.5,7,'2020'),
(1,'Image Analysis',7.5,7,'2020'),
(1,'Web Client and Backend Development Frameworks',7.5,7,'2020'),
(1,'Data Mining',7.5,7,'2020'),
(1,'Internet of Things',7.5,7,'2020'),
(1,'Virtual Instrumentation Applications',7.5,7,'2020'),
(1,'Selected Topics in Cryptography',7.5,7,'2020'),
(1,'IT Governance',7.5,7,'2020'),
(1,'Economic Engineering',7.5,7,'2020'),
(1,'Computing Selected Topics II',7.5,7,'2020'),

--  Octavo
(1,'Estancia Profesional',3.0,8,'2020'),
(1,'Desarrollo de Habilidades Sociales para la Alta Direccion',3.0,8,'2020'),
(1,'Trabajo Terminal II',12.0,8,'2020'),
(1,'Gestion Empresarial',7.5,8,'2020'),
(1,'Liderazgo Personal',7.5,8,'2020');


--  ISC Plan 2009
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
--  Primero
(1,'Analisis Vectorial',4.39,1,'2009'),
(1,'Calculo',4.39,1,'2009'),
(1,'Matematicas Discretas',5.85,1,'2009'),
(1,'Algoritmia y Programacion Estructurada',4.45,1,'2009'),
(1,'Fisica',4.39,1,'2009'),
(1,'Ingenieria, Etica y Sociedad',4.39,1,'2009'),

--  Segundo
(1,'Ecuaciones Diferenciales',4.39,2,'2009'),
(1,'Algebra Lineal',4.39,2,'2009'),
(1,'Calculo Aplicado',4.44,2,'2009'),
(1,'Estructuras de Datos',4.39,2,'2009'),
(1,'Comunicacion Oral y Escrita',4.39,2,'2009'),
(1,'Analisis Fundamental de Circuitos',4.33,2,'2009'),

--  Tercero
(1,'Matematicas Avanzadas para la Ingenieria',4.46,3,'2009'),
(1,'Fundamentos Economicos',4.33,3,'2009'),
(1,'Fundamentos de Diseño Digital',4.48,3,'2009'),
(1,'Teoria Computacional',4.30,3,'2009'),
(1,'Bases de Datos',4.44,3,'2009'),
(1,'Programacion Orientada a Objetos',4.34,3,'2009'),
(1,'Electronica Analogica',4.35,3,'2009'),

--  Cuarto
(1,'Redes de Computadoras',4.46,4,'2009'),
(1,'Diseño de Sistemas Digitales',4.50,4,'2009'),
(1,'Probabilidad y Estadistica',4.39,4,'2009'),
(1,'Sistemas Operativos',4.39,4,'2009'),
(1,'Analisis y Diseño Orientado a Objetos',4.39,4,'2009'),
(1,'Tecnologias para la Web',4.49,4,'2009'),
(1,'Administracion Financiera',4.36,4,'2009'),

--  Quinto
(1,'Arquitectura de Computadoras',4.39,5,'2009'),
(1,'Analisis de Algoritmos',4.39,5,'2009'),
(1,'Ingenieria de Software',4.39,5,'2009'),
(1,'Administracion de Proyectos',4.39,5,'2009'),
(1,'Instrumentacion',4.39,5,'2009'),

--  Optativas
(1,'Advanced Architectures',4.39,5,'2009'),
(1,'Advanced FPGA Devices Programming',4.39,5,'2009'),
(1,'Analysis and Design of Parallel Algorithms',4.39,5,'2009'),
(1,'Artificial Intelligence',4.39,5,'2009'),
(1,'Bioinformatics',4.39,5,'2009'),
(1,'Computational Intelligence in Control Engineering',4.39,5,'2009'),
(1,'Computer Graphics',4.39,5,'2009'),
(1,'Cryptography',4.39,5,'2009'),
(1,'Data Mining',4.39,5,'2009'),
(1,'Digital Processing of Voice and Image',4.39,5,'2009'),
(1,'e-Commerce',4.39,5,'2009'),
(1,'Embedded Systems',4.39,5,'2009'),
(1,'Fuzzy Systems Applied to Engineering',4.39,5,'2009'),
(1,'Graphical User Interfaces',4.39,5,'2009'),
(1,'Image Analysis',4.39,5,'2009'),
(1,'IT Financial Engineering',4.39,5,'2009'),
(1,'Mobile Communications',4.39,5,'2009'),
(1,'Parallel and Concurrent Programming',4.39,5,'2009'),
(1,'SCADA Systems',4.39,5,'2009'),
(1,'Supervised Learning Neural Networks',4.39,5,'2009'),
(1,'Unsupervised Neural Networks',4.39,5,'2009'),
(1,'Web Security',4.39,5,'2009'),
(1,'Advanced Computing Systems Programming',4.39,5,'2009'),
(1,'Advanced Signal Processing',4.39,5,'2009'),
(1,'Application Development for Mobile Devices',4.39,5,'2009'),
(1,'Basic Signal Processing',4.39,5,'2009'),
(1,'Computational Geometry',4.39,5,'2009'),
(1,'Computer Animation',4.39,5,'2009'),
(1,'Computing Selected Topics',4.39,5,'2009'),
(1,'Data Base Selected Topics',4.39,5,'2009'),
(1,'Digital Control',4.39,5,'2009'),
(1,'Distributed Data Base',4.39,5,'2009'),
(1,'Economic Engineering',4.39,5,'2009'),
(1,'Evolutionary Computing',4.39,5,'2009'),
(1,'Genetic Algorithms',4.39,5,'2009'),
(1,'High Technology Enterprise Management',4.39,5,'2009'),
(1,'Intelligent Systems',4.39,5,'2009'),
(1,'IT Governance',4.39,5,'2009'),
(1,'Neural Networks',4.39,5,'2009'),
(1,'Pattern Recognition',4.39,5,'2009'),
(1,'Software Engineering for Mobile Devices',4.39,5,'2009'),
(1,'Systems Simulation',4.39,5,'2009'),
(1,'Web Application Development',4.39,5,'2009'),

--  Sexto
(1,'Teoria de Comunicaciones y Señales',4.39,6,'2009'),
(1,'Aplicaciones para Comunicaciones en Red',4.39,6,'2009'),
(1,'Metodos Cuantitativos para la Toma de Decisiones',4.39,6,'2009'),
(1,'Introduccion a los Microcontroladores',4.39,6,'2009'),
(1,'Compiladores',4.39,6,'2009'),

-- Septimo
(1,'Desarrollo de Sistemas Distribuidos',4.39,7,'2009'),
(1,'Administracion de Servicios en Red',4.39,7,'2009'),
(1,'Gestion Empresarial',4.39,7,'2009'),
(1,'Liderazgo y Desarrollo Profesional',4.39,7,'2009'),
(1,'Trabajo Terminal I',11.25,7,'2009'),

-- Octavo
(1,'Trabajo Terminal II',11.25,8,'2009');


--  ISC Plan 1999
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
(1,'Investigacion de Operaciones',0.0,6,'1999');

--  IIA Plan 2020
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
--  Primero
(2,'Fundamentos de Programacion',7.5,1,'2020'),
(2,'Matematicas Discretas',7.5,1,'2020'),
(2,'Calculo',7.5,1,'2020'),
(2,'Comunicacion Oral y Escrita',7.5,1,'2020'),
(2,'Mecanica y Electromagnetismo',10.5,1,'2020'),
(2,'Fundamentos Economicos',7.5,1,'2020'),

--  Segundo
(2,'Algoritmos y Estructuras de Datos',7.5,2,'2020'),
(2,'Fundamentos de Diseño de Digital',7.5,2,'2020'),
(2,'Calculo Multivariable',7.5,2,'2020'),
(2,'Ingenieria, Etica y Sociedad',9.0,2,'2020'),
(2,'Algebra Lineal',9.0,2,'2020'),
(2,'Finanzas Empresariales',7.5,2,'2020'),

--  Tercero
(2,'Bases de Datos',7.5,3,'2020'),
(2,'Paradigmas de Programacion',7.5,3,'2020'),
(2,'Analisis y Diseño de Algoritmos',7.5,3,'2020'),
(2,'Ecuaciones Diferenciales',7.5,3,'2020'),
(2,'Diseño de Sistemas Digitales',7.5,3,'2020'),
(2,'Liderazgo Personal',7.5,3,'2020'),

--  Cuarto
(2,'Fundamentos de Inteligencia Artificial',7.5,4,'2020'),
(2,'Probabilidad y Estadistica',9.0,4,'2020'),
(2,'Matematicas Avanzadas para la Ingenieria',9.0,4,'2020'),
(2,'Tecnologias para el Desarrollo de Aplicaciones Web',7.5,4,'2020'),
(2,'Procesamiento Digital de Señales',7.5,4,'2020'),
(2,'Analisis y Diseño de Sistemas',7.5,4,'2020'),

--  Quinto
(2,'Aprendizaje de Maquina',7.5,5,'2020'),
(2,'Teoria de la Computacion',7.5,5,'2020'),
(2,'Vision Artificial',7.5,5,'2020'),
(2,'Procesamiento de Señales',7.5,5,'2020'),
(2,'Algoritmos Bioinspirados',7.5,5,'2020'),
(2,'Tecnologias de Lenguaje Natural',7.5,5,'2020'),

--  Sexto
(2,'Computo Paralelo',7.5,6,'2020'),
(2,'Redes Neuronales y Aprendizaje Profundo',7.5,6,'2020'),
(2,'Ingenieria de Software para Sistemas Inteligentes',7.5,6,'2020'),
(2,'Metodologia de la Investigacion y Divulgacion Cientifica',7.5,6,'2020'),

--  Optativas de Sexto
(2,'Innovación y emprendimiento tecnológico',7.5,6,'2020'),
(2,'Propiedad Intelectual',7.5,6,'2020'),
(2,'Aplicaciones de lenguaje natural',7.5,6,'2020'),
(2,'Sistemas multiagentes',7.5,6,'2020'),
(2,'Aplicaciones de sistemas multiagentes',7.5,6,'2020'),
(2,'Minería de datos',7.5,6,'2020'),
(2,'Big data',7.5,6,'2020'),
(2,'Temas selectos de inteligencia artificial',7.5,6,'2020'),
(2,'Cómputo en la nube',7.5,6,'2020'),
(2,'Técnicas de programaión para robots móviles',7.5,6,'2020'),
(2,'Interacción humano-máquina',7.5,6,'2020'),
(2,'Programación de dispositivos móviles',7.5,6,'2020'),
(2,'Aplicaciones de inteligencia artificial en sistemas embebidos',7.5,6,'2020'),
(2,'Tópicos selectos de algoritmos bioinspirados',7.5,6,'2020'),

--  Septimo
(2,'Trabajo Terminal I',12.0,7,'2020'),
(2,'Reconocimiento de Voz',7.5,7,'2020'),
(2,'Formulacion y Evaluacion de Proyectos Informaticos',7.5,7,'2020'),

--  Optativas de Septimo
(2,'Innovación y emprendimiento tecnológico',7.5,7,'2020'),
(2,'Propiedad Intelectual',7.5,7,'2020'),
(2,'Aplicaciones de lenguaje natural',7.5,7,'2020'),
(2,'Sistemas multiagentes',7.5,7,'2020'),
(2,'Aplicaciones de sistemas multiagentes',7.5,7,'2020'),
(2,'Minería de datos',7.5,7,'2020'),
(2,'Big data',7.5,7,'2020'),
(2,'Temas selectos de inteligencia artificial',7.5,7,'2020'),
(2,'Cómputo en la nube',7.5,7,'2020'),
(2,'Técnicas de programaión para robots móviles',7.5,7,'2020'),
(2,'Interacción humano-máquina',7.5,7,'2020'),
(2,'Programación de dispositivos móviles',7.5,7,'2020'),
(2,'Aplicaciones de inteligencia artificial en sistemas embebidos',7.5,7,'2020'),
(2,'Tópicos selectos de algoritmos bioinspirados',7.5,7,'2020'),

--  Octavo
(2,'Trabajo Terminal II',12.0,8,'2020'),
(2,'Gestion Empresarial',7.5,8,'2020'),
(2,'Desarrollo de Habilidades Sociales para la Alta Direccion',3.0,8,'2020'),
(2,'Estancia Profesional',3.0,8,'2020');


--  LCD Plan 2020
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
--  Primero
(3,'Fundamentos de Programacion',7.5,1,'2020'),
(3,'Calculo',7.5,1,'2020'),
(3,'Matematicas Discretas',10.5,1,'2020'),
(3,'Comunicacion Oral y Escrita',7.5,1,'2020'),
(3,'Introduccion a la Ciencia de Datos',6.0,1,'2020'),

--  Segundo
(3,'Algebra Lineal',7.5,2,'2020'),
(3,'Fundamentos Economicos',7.5,2,'2020'),
(3,'Algoritmos y Estructuras de Datos',7.5,2,'2020'),
(3,'Calculo Multivariable',10.5,2,'2020'),
(3,'Etica y Legalidad',9.0,2,'2020'),

--  Tercero
(3,'Bases de Datos',7.5,3,'2020'),
(3,'Probabilidad',10.5,3,'2020'),
(3,'Metodos Numericos',10.5,3,'2020'),
(3,'Programacion para Ciencias de Datos',7.5,3,'2020'),
(3,'Analisis y Diseño de Algoritmos',7.5,3,'2020'),
(3,'Finanzas Empresariales',7.5,3,'2020'),

--  Cuarto
(3,'Desarrollo de Aplicaciones Web',7.5,4,'2020'),
(3,'Computo de Alto Desempeño',9.0,4,'2020'),
(3,'Estadistica',10.5,4,'2020'),
(3,'Bases de Datos Avanzadas',10.5,4,'2020'),
(3,'Desarrollo de Aplicaiones para Analisis de Datos',7.5,4,'2020'),
(3,'Liderazgo Personal',7.5,4,'2020'),

-- Quinto
(3,'Mineria de Datos',7.5,5,'2020'),
(3,'Matematicas Avanzadas para Ciencia de Datos',10.5,5,'2020'),
(3,'Procesos Estocasticos',10.5,5,'2020'),
(3,'Aprendizaje de Maquina e Inteligencia Artificial',7.5,5,'2020'),
(3,'Analitica y Visualizacion de Datos',7.5,5,'2020'),
(3,'Metodologia de la Investigacion y Divulgacion Cientifica',7.5,5,'2020'),

--  Sexto
(3,'Modelo Predicativo',7.5,6,'2020'),
(3,'Procesamiento de Lenguaje Natural',4.5,6,'2020'),
(3,'Analisis de Series de Tiempo',4.5,6,'2020'),
(3,'Analitica Avanzada de Datos',7.5,6,'2020'),

--  Optativas de Sexto
(3,'Bioinformática Básica',7.5,6,'2020'),
(3,'Ciberseguridad',7.5,6,'2020'),
(3,'Estadística Avanzada',7.5,6,'2020'),
(3,'Propiedad Intelectual',7.5,6,'2020'),
(3,'Simulación Básica',7.5,6,'2020'),
(3,'Sistemas de Información Geográfica',7.5,6,'2020'),

--  Septimo
(3,'Trabajo Terminal I',12.0,7,'2020'),
(3,'Big Data',7.5,7,'2020'),
(3,'Modelos Econometricos',7.5,7,'2020'),
(3,'Administracion de Proyectos de TI',10.5,7,'2020'),

--  Optativas de Septimo
(3,'Bioinformática Avanzada',7.5,7,'2020'),
(3,'Protección de Datos',7.5,7,'2020'),
(3,'Temas Selectos de Aprendizaje Profundo',7.5,7,'2020'),
(3,'Innovación y Emprendimiento Tecnológico',7.5,7,'2020'),
(3,'Simulación Avanzada',7.5,7,'2020'),
(3,'Temas Selectos de Inteligencia Artificial',7.5,7,'2020'),
(3,'Temas Selectos de Procesamiento de Lenguaje Natural',7.5,7,'2020'),

--  Octavo
(3,'Trabajo Terminal II',12.0,8,'2020'),
(3,'Estancia Profesional',4.5,8,'2020'),
(3,'Desarrollo de Habilidades Sociales para la Alta Direccion',6.0,8,'2020'),
(3,'Gestion Empresarial',10.5,8,'2020');

--  ISISA (Algunas Materias)
INSERT INTO materia (id_carrera, nombre, creditos, nivel, plan) VALUES
(4,'Aplicaciones de Inteligencia Artificial en Sistemas Embedidos',0.0,6,'2009'),
(4,'Aplicaciones de Microcontroladores para el Automovil',0.0,6,'2009'),
(4,'Arquitectiras Embebidas Automotrices',0.0,6,'2009'),
(4,'Comunicaciones Embebidas Automotrices',0.0,6,'2009'),
(4,'Evaluacion Economica de Proyectos',0.0,6,'2009'),
(4,'Humanidades IV',0.0,6,'2009'),
(4,'Humanidades V',0.0,6,'2009'),
(4,'Ingenieria Ambiental Automotriz',0.0,6,'2009'),
(4,'Programacion de Dispositivos Moviles Automotrices',0.0,6,'2009'),
(4,'Proyecto Integrador',0.0,6,'2006'),
(4,'Sistemas Digitales',0.0,6,'2009'),
(4,'Sistemas Inteligentes del Automovil',0.0,6,'2009'),
(4,'Topicos Selectos de Ingenieria I',0.0,6,'2009'),
(4,'Topicos Selectos de Ingenieria II',0.0,6,'2009');

SELECT * FROM materia;

CREATE TABLE alumno (
    id_alumno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    primer_nombre VARCHAR(64) NOT NULL,
    segundo_nombre VARCHAR(64) DEFAULT NULL,
    primer_apellido VARCHAR(64) NOT NULL,
    segundo_apellido VARCHAR(64) NOT NULL,
    email VARCHAR(128) NOT NULL,
    -- Almacenar el hash SHA-256
    contrasena CHAR(64) NOT NULL,
    CONSTRAINT uq_alumno_email UNIQUE (email)
);

/*
DATE Formato: (YYYY-MM-DD) -> Se obtiene con CURDATE()
TIME Formato: (HH:MM:SS) -> Se obtiene con DATE(NOW())
*/

CREATE TABLE ets (
    id_ets INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_materia INT NOT NULL,
    id_coordinador INT NOT NULL,
    fecha DATE NOT NULL, 
    hora TIME NOT NULL,
    salon VARCHAR(16) NOT NULL,
    proyecto_archivo VARCHAR(512) DEFAULT NULL,
    guia_archivo VARCHAR(512) DEFAULT NULL,
    nota VARCHAR(512) NOT NULL DEFAULT '',

    CONSTRAINT fk_ets_materia
        FOREIGN KEY (id_materia) REFERENCES materia (id_materia)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ets_coordinador
        FOREIGN KEY (id_coordinador) REFERENCES coordinador (id_coordinador)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO ets (id_materia, id_coordinador, fecha, hora, salon, nota) VALUES
( 1,  3, '2025-01-15','08:00:00', 'A-101', 'Primera convocatoria'),
( 2,  7, '2025-01-16','10:00:00', 'A-102', 'Primera convocatoria'),
( 3, 12, '2025-01-17','12:00:00', 'B-201', 'Traer calculadora científica'),
( 4, 18, '2025-01-20','08:00:00', 'B-202', 'Primera convocatoria'),
( 5, 24, '2025-01-21','10:00:00', 'C-301', 'Permitido uso de apuntes'),
( 6, 30, '2025-01-22','12:00:00', 'C-302', 'Primera convocatoria'),
( 7,  5, '2025-01-23','08:00:00', 'Lab-1', 'Examen práctico en laboratorio'),
( 8, 11, '2025-01-24','10:00:00', 'A-103', 'Primera convocatoria'),
( 9, 16, '2025-01-27','12:00:00', 'B-203', 'Segunda convocatoria'),
(10, 22, '2025-01-28','08:00:00', 'C-303', 'Primera convocatoria'),
(11, 28, '2025-01-29','10:00:00', 'Lab-2', 'Examen práctico en laboratorio'),
(12, 34, '2025-01-30','12:00:00', 'A-104', 'Primera convocatoria'),
(13, 39, '2025-02-03','08:00:00', 'Lab-3', 'Examen práctico en laboratorio'),
(14,  2, '2025-02-04','10:00:00', 'B-204', 'Traer laptop con ambiente configurado'),
(15,  8, '2025-02-05','12:00:00', 'C-304', 'Primera convocatoria'),
(16, 14, '2025-02-06','08:00:00', 'Lab-1', 'Segunda convocatoria'),
(17, 20, '2025-02-07','10:00:00', 'A-105', 'Primera convocatoria'),
(18, 26, '2025-02-10','12:00:00', 'B-205', 'Traer calculadora científica'),
(19, 32, '2025-02-11','08:00:00', 'C-305', 'Primera convocatoria'),
(20, 38, '2025-02-12','10:00:00', 'Lab-2', 'Examen práctico en laboratorio'),
(47,  6, '2025-02-17','08:00:00', 'A-201', 'Primera convocatoria'),
(102, 13,'2025-02-18','10:00:00','B-301','Traer calculadora científica'),
(158, 19,'2025-02-19','12:00:00','C-401','Segunda convocatoria'),
(213, 25,'2025-02-20','08:00:00','Lab-3','Examen práctico en laboratorio'),
( 89,  1,'2025-02-21','10:00:00','A-202','Primera convocatoria'),
(234, 31,'2025-02-24','12:00:00','B-302','Permitido uso de apuntes'),
( 73, 37,'2025-02-25','08:00:00','C-402','Primera convocatoria'),
(185, 10,'2025-02-26','10:00:00','Lab-1','Examen práctico en laboratorio'),
(261,  4,'2025-02-27','12:00:00','A-203','Primera convocatoria'),
(120, 17,'2025-02-28','08:00:00','B-303','Traer laptop con ambiente configurado'),
( 55, 23,'2025-03-03','10:00:00','C-403','Segunda convocatoria'),
(290, 29,'2025-03-04','12:00:00','Lab-2','Primera convocatoria'),
(144, 35,'2025-03-05','08:00:00','A-204','Traer calculadora científica'),
( 38, 40,'2025-03-06','10:00:00','B-304','Primera convocatoria'),
(200,  9,'2025-03-07','12:00:00','C-404','Segunda convocatoria'),
(275, 15,'2025-03-10','08:00:00','Lab-3','Examen práctico en laboratorio'),
( 66, 21,'2025-03-11','10:00:00','A-205','Primera convocatoria'),
(177, 27,'2025-03-12','12:00:00','B-305','Permitido uso de apuntes'),
(243, 33,'2025-03-13','08:00:00','Lab-1','Examen práctico en laboratorio'),
( 91, 36,'2025-03-14','10:00:00','C-405','Primera convocatoria');


--  Query (Para PHP)
SELECT 
    m.nombre AS materia,
    c.iniciales AS carrera,
    m.plan,
    e.fecha,
    e.hora,
    CONCAT(co.primer_nombre, ' ', co.primer_apellido) AS coordinador,
    co.email AS email_coordinador,
    e.salon,
    e.proyecto_archivo AS proyecto,
    e.guia_archivo AS guia,
    e.nota
FROM ets e
JOIN materia m ON e.id_materia = m.id_materia
JOIN carrera c ON m.id_carrera = c.id_carrera
JOIN coordinador co ON e.id_coordinador = co.id_coordinador;

--  Roles
DROP ROLE IF EXISTS 'rol_admin';
DROP ROLE IF EXISTS 'rol_alumno';

CREATE ROLE 'rol_admin';
CREATE ROLE 'rol_alumno';

-- Administrador
GRANT ALL PRIVILEGES ON ETS20262.* TO 'rol_admin';

-- Alumno
GRANT SELECT ON ETS20262.ets TO 'rol_alumno';
GRANT SELECT ON ETS20262.materia TO 'rol_alumno';
GRANT SELECT ON ETS20262.carrera TO 'rol_alumno';
GRANT SELECT ON ETS20262.coordinador TO 'rol_alumno';
GRANT SELECT, UPDATE (primer_nombre, segundo_nombre,
					  primer_apellido, segundo_apellido,
					  email, contrasena) ON ETS20262.alumno TO 'rol_alumno';

--  Usuarios
DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'alumno'@'localhost';

/*

Hostname: 127.0.0.1
Port: 3307
Username: <usuario>
Password: <contraseña>
Default Schema: ETS20262

<usuario>@localhost IDENIFIED BY <contraseña>

*/
CREATE USER 'admin'@'localhost'  IDENTIFIED BY 'admin';  
CREATE USER 'alumno'@'localhost' IDENTIFIED BY 'alumno';  

GRANT 'rol_admin'  TO 'admin'@'localhost';
SET DEFAULT ROLE rol_admin FOR 'admin'@'localhost';
GRANT 'rol_alumno' TO 'alumno'@'localhost'; 
SET DEFAULT ROLE 'rol_alumno' FOR 'alumno'@'localhost';