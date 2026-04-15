--
-- Scripst de Creación de la Base de Datos  - SGBD PostgreSQL
--
-- Todas las instrucciones se DEBEN EJECUTAR EN SECUENCIA SIN ERRORES
-- NOTA: Ojo con las tablas relacionadas. Primero las independientes y después las dependientes
--

--
-- Creación de las tablas
-- 

--Creacion de Tabla usuario

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol VARCHAR(50) NOT NULL CHECK (rol IN ('estudiante', 'profesor', 'administrador', 'egresado', 'empleado')),
    correo VARCHAR(70) NOT NULL UNIQUE CHECK (correo LIKE '%@pascualbravo.edu.co'),
    sexo VARCHAR(20) CHECK (sexo IN ('masculino', 'femenino')),
    telefono BIGINT UNIQUE,
    fecha_nacimiento DATE
);

--Creacion de Tabla publicacion
CREATE TABLE publicacion (
    id_publicacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL,
    texto TEXT NOT NULL,
	
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla comentario
CREATE TABLE comentario (
    id_comentario SERIAL PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    texto VARCHAR(500) NOT NULL,
	
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla reaccion
CREATE TABLE reaccion (
    id_reaccion serial primary key,
    id_publicacion int not null,
    id_usuario int not null,
    fecha_publicacion timestamp,
    tipo_reaccion varchar(50) not null check (tipo_reaccion IN ('me_gusta', 'me_encanta', 'me_asombra', 'me_entristece', 'me_enoja')),
    fecha_creacion date,

    foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE,
    foreign key (id_publicacion) references publicacion(id_publicacion) ON DELETE CASCADE
);

--Creacion de Tabla grupo
CREATE TABLE grupo (
    id_grupo serial primary key,
    id_administrador int not null,
    nombre varchar(90),
    descripcion text,
    tipo_grupo varchar(50) not null check (tipo_grupo IN ('mentoría', 'proyecto', 'egresados', 'apoyo_academico', 'interés')),
    fecha_creacion date,

    foreign key (id_administrador) references usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla evento
CREATE TABLE evento (
    id_evento serial primary key,
    id_creador int not null,
    nombre_evento varchar(100),
    fecha_hora_inicio timestamp,
    fecha_hora_finalizacion timestamp,
    ubicacion varchar(100),
    tipo_evento varchar(50) not null check (tipo_evento IN ('cultural', 'deportivo', 'conferencia', 'taller', 'seminario')),
    descripcion text,

    foreign key (id_creador) references usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla servicio
CREATE TABLE servicio (
    id_articulo SERIAL PRIMARY KEY,
    id_usuario_ofertante INT not null,
    titulo VARCHAR(100) not null,
    tipo VARCHAR(50) not null check (tipo IN ('servicio', 'producto')),
    descripcion TEXT,
    fecha_publicacion_oferta TIMESTAMP ,
    estado_oferta VARCHAR(50) not null check (estado_oferta IN ('disponible', 'en_reserva', 'no_hay')),
	
	foreign key (id_usuario_ofertante) references usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla empresa
CREATE TABLE empresa (
    id_empresa SERIAL PRIMARY KEY,
    nombre_empresa VARCHAR (100) not null,
    actividad_comercial VARCHAR (100),
    ubicacion VARCHAR(250) not null,
    nit_empresa BIGINT UNIQUE 

);

--Creacion de Tabla oferta_laboral
CREATE TABLE oferta_laboral (
     id_oferta SERIAL PRIMARY KEY,
	 id_empresa INT not null,
	 id_usuario INT not null,
	 cargo VARCHAR (100) not null,
	 salario DECIMAL (10, 2) not null,
	 requisitos TEXT not null,
	 fecha_apertura DATE not null,
	 fecha_cierre DATE not null,

	foreign key (id_empresa) references empresa(id_empresa) ON DELETE CASCADE,
	foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE
);

--Creacion de Tabla seguidores
CREATE TABLE seguidores (
    id_seguidor SERIAL PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL,
    id_usuario_seguido INT NOT NULL,
    fecha_seguimiento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario_seguidor) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_seguido) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CHECK (id_usuario_seguidor != id_usuario_seguido)
);

--Creacion de Tabla usuario_evento
CREATE TABLE usuario_evento (
	id_inscripcion SERIAL PRIMARY KEY,
	id_usuario INT not null,
	id_evento INT not null,
	fecha_inscripcion TIMESTAMP not null,
	estado_asistencia VARCHAR(20) CHECK (estado_asistencia IN ('confirmo', 'asistio', 'no_asistio')),

	foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE,
	foreign key (id_evento) references evento(id_evento) ON DELETE CASCADE
);

--Creacion de Tabla usuario_servicio
CREATE TABLE usuario_servicio (
	id_transaccion SERIAL PRIMARY KEY, 
	id_usuario_ofertante INT not null,
	id_usuario_cliente INT not null,
	id_articulo INT not null,
	fecha_transaccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	foreign key (id_usuario_ofertante) references usuario(id_usuario) ON DELETE CASCADE,
	foreign key (id_usuario_cliente) references usuario(id_usuario) ON DELETE CASCADE,
	foreign key (id_articulo) references servicio(id_articulo) ON DELETE CASCADE
);

--Creacion de Tabla usuario_ofertalaboral
CREATE TABLE usuario_ofertalaboral (
	id_postulacion SERIAL PRIMARY KEY, 
	id_usuario INT not null,
	id_oferta INT not null,
	fecha_postulacion TIMESTAMP not null,
	estado VARCHAR(20) CHECK (estado IN ('postulado', 'entrevistado', 'aceptado', 'rechazado')),

	foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE,
	foreign key (id_oferta) references oferta_laboral(id_oferta) ON DELETE CASCADE
);

--Creacion de Tabla usuario_grupo
CREATE TABLE usuario_grupo (
	id_inscripcion_grupo SERIAL PRIMARY KEY, 
	id_usuario INT not null,
	id_grupo INT not null,
	fecha_ingreso TIMESTAMP not null,
	
	foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE,
	foreign key (id_grupo) references grupo(id_grupo) ON DELETE CASCADE
);