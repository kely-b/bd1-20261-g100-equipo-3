-- Creacion y ejecucion de Tablas Relacionales en SQLServer
-- Creación de Tabla usuario
CREATE TABLE usuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol VARCHAR(50) NOT NULL CHECK (rol IN ('estudiante', 'profesor', 'administrador', 'egresado', 'empleado')),
    correo VARCHAR(70) NOT NULL UNIQUE CHECK (correo LIKE '%@pascualbravo.edu.co'),
    sexo VARCHAR(20) CHECK (sexo IN ('masculino', 'femenino')),
    telefono BIGINT UNIQUE,
    fecha_nacimiento DATE
);

-- Creación de Tabla publicacion
CREATE TABLE publicacion (
    id_publicacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_publicacion DATETIME2 NOT NULL,
    texto VARCHAR(MAX) NOT NULL,
	
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);


-- Creación de Tabla comentario
CREATE TABLE comentario (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME2 NOT NULL,
    texto VARCHAR(500) NOT NULL,
	
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE NO ACTION
);

-- Creación de Tabla reaccion
CREATE TABLE reaccion (
    id_reaccion INT IDENTITY(1,1) PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_publicacion DATETIME2,
    tipo_reaccion VARCHAR(50) NOT NULL CHECK (tipo_reaccion IN ('me_gusta', 'me_encanta', 'me_asombra', 'me_entristece', 'me_enoja')),
    fecha_creacion DATE,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion) ON DELETE NO ACTION
);

-- Creación de Tabla grupo
CREATE TABLE grupo (
    id_grupo INT IDENTITY(1,1) PRIMARY KEY,
    id_administrador INT NOT NULL,
    nombre VARCHAR(90),
    descripcion VARCHAR(MAX),
    tipo_grupo VARCHAR(50) NOT NULL CHECK (tipo_grupo IN ('mentoría', 'proyecto', 'egresados', 'apoyo_academico', 'interés')),
    fecha_creacion DATE,

    FOREIGN KEY (id_administrador) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creación de Tabla evento
CREATE TABLE evento (
    id_evento INT IDENTITY(1,1) PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre_evento VARCHAR(100),
    fecha_hora_inicio DATETIME2,
    fecha_hora_finalizacion DATETIME2,
    ubicacion VARCHAR(100),
    tipo_evento VARCHAR(50) NOT NULL CHECK (tipo_evento IN ('cultural', 'deportivo', 'conferencia', 'taller', 'seminario')),
    descripcion VARCHAR(MAX),

    FOREIGN KEY (id_creador) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creación de Tabla servicio
CREATE TABLE servicio (
    id_articulo INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_ofertante INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('servicio', 'producto')),
    descripcion VARCHAR(MAX),
    fecha_publicacion_oferta DATETIME2,
    estado_oferta VARCHAR(50) NOT NULL CHECK (estado_oferta IN ('disponible', 'en_reserva', 'no_hay')),
	
    FOREIGN KEY (id_usuario_ofertante) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creación de Tabla empresa
CREATE TABLE empresa (
    id_empresa INT IDENTITY(1,1) PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    actividad_comercial VARCHAR(100),
    ubicacion VARCHAR(250) NOT NULL,
    nit_empresa BIGINT UNIQUE 
);

-- Creación de Tabla oferta_laboral
CREATE TABLE oferta_laboral (
    id_oferta INT IDENTITY(1,1) PRIMARY KEY,
    id_empresa INT NOT NULL,
    id_usuario INT NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    requisitos VARCHAR(MAX) NOT NULL,
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE NOT NULL,

    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creación de Tabla seguidores
CREATE TABLE seguidores (
    id_seguidor INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL,
    id_usuario_seguido INT NOT NULL,
    fecha_seguimiento DATETIME2 NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (id_usuario_seguidor) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_seguido) REFERENCES usuario(id_usuario) ON DELETE NO ACTION,
    CHECK (id_usuario_seguidor != id_usuario_seguido)
);

-- Creación de Tabla usuario_evento
CREATE TABLE usuario_evento (
    id_inscripcion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    fecha_inscripcion DATETIME2 NOT NULL,
    estado_asistencia VARCHAR(20) CHECK (estado_asistencia IN ('confirmo', 'asistio', 'no_asistio')),

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE NO ACTION
);

-- Creación de Tabla usuario_servicio
CREATE TABLE usuario_servicio (
    id_transaccion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario_ofertante INT NOT NULL,
    id_usuario_cliente INT NOT NULL,
    id_articulo INT NOT NULL,
    fecha_transaccion DATETIME2 NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (id_usuario_ofertante) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_cliente) REFERENCES usuario(id_usuario) ON DELETE NO ACTION,
    FOREIGN KEY (id_articulo) REFERENCES servicio(id_articulo) ON DELETE NO ACTION 
);

-- Creación de Tabla usuario_ofertalaboral
CREATE TABLE usuario_ofertalaboral (
    id_postulacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_oferta INT NOT NULL,
    fecha_postulacion DATETIME2 NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('postulado', 'entrevistado', 'aceptado', 'rechazado')),

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_oferta) REFERENCES oferta_laboral(id_oferta) ON DELETE NO ACTION
);

-- Creación de Tabla usuario_grupo
CREATE TABLE usuario_grupo (
    id_inscripcion_grupo INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_ingreso DATETIME2 NOT NULL,
	
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo) ON DELETE NO ACTION
);

CREATE TABLE perfil (
    id_perfil INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    biografia VARCHAR(MAX) NULL, 
    edad INT NULL CHECK (edad >= 0),
    alias_usuario VARCHAR(50) NOT NULL UNIQUE,
    fecha_creacion DATE NOT NULL DEFAULT GETDATE(),
    semestre_cursado INT NULL CHECK (semestre_cursado BETWEEN 1 AND 12),

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);