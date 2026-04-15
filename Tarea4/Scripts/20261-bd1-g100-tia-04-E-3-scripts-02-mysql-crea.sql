-- Creacion de tablas

CREATE DATABASE scripts_02_mysql_crea; -- Crea la base de datos bajo el nombre de "tablasrelacionales"

USE scripts_02_mysql_crea; -- Ejecuta la base de datos creada de acuerdo al nombre que fue guardado en este caso "tablasrelacionales"

-- Creacion Tabla usuario
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol ENUM('estudiante', 'profesor', 'administrador', 'egresado', 'empleado') NOT NULL,
    correo VARCHAR(70) NOT NULL UNIQUE,
    sexo ENUM('masculino', 'femenino'),
    telefono BIGINT UNIQUE,
    fecha_nacimiento DATE,
    CONSTRAINT chk_correo_institucional CHECK (correo LIKE '%@pascualbravo.edu.co')
);

-- Creacion Tabla publicacion
CREATE TABLE publicacion (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_publicacion DATETIME NOT NULL,
    texto TEXT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla comentario
CREATE TABLE comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    texto VARCHAR(500) NOT NULL,
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla reaccion
CREATE TABLE reaccion (
    id_reaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    tipo_reaccion ENUM('me_gusta', 'me_encanta', 'me_asombra', 'me_entristece', 'me_enoja') NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion) ON DELETE CASCADE
);

-- Creacion Tabla grupo
CREATE TABLE grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    id_administrador INT NOT NULL,
    nombre VARCHAR(90),
    descripcion TEXT,
    tipo_grupo ENUM('mentoría', 'proyecto', 'egresados', 'apoyo_academico', 'interés') NOT NULL,
    fecha_creacion DATE,
    FOREIGN KEY (id_administrador) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla evento
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre_evento VARCHAR(100),
    fecha_hora_inicio DATETIME,
    fecha_hora_finalizacion DATETIME,
    ubicacion VARCHAR(100),
    tipo_evento ENUM('cultural', 'deportivo', 'conferencia', 'taller', 'seminario') NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (id_creador) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla servicio
CREATE TABLE servicio (
    id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_ofertante INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    tipo ENUM('servicio', 'producto') NOT NULL,
    descripcion TEXT,
    fecha_publicacion_oferta DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_oferta ENUM('disponible', 'en_reserva', 'no_hay') NOT NULL,
    FOREIGN KEY (id_usuario_ofertante) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla empresa
CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    actividad_comercial VARCHAR(100),
    ubicacion VARCHAR(250) NOT NULL,
    nit_empresa BIGINT UNIQUE 
);

-- Creacion Tabla oferta laboral
CREATE TABLE oferta_laboral (
     id_oferta INT AUTO_INCREMENT PRIMARY KEY,
     id_empresa INT NOT NULL,
     id_usuario INT NOT NULL,
     cargo VARCHAR(100) NOT NULL,
     salario DECIMAL(10, 2) NOT NULL,
     requisitos TEXT NOT NULL,
     fecha_apertura DATE NOT NULL,
     fecha_cierre DATE NOT NULL,
     FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE,
     FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Creacion Tabla seguidores
CREATE TABLE seguidores (
    id_seguidor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL,
    id_usuario_seguido INT NOT NULL,
    fecha_seguimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario_seguidor) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_seguido) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT chk_evitar_autoseguimiento CHECK (id_usuario_seguidor <> id_usuario_seguido)
);

-- Creacion Tabla usuario evento
CREATE TABLE usuario_evento (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    fecha_inscripcion DATETIME NOT NULL,
    estado_asistencia ENUM('confirmo', 'asistio', 'no_asistio'),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE
);

-- Creacion Tabla usuario servicio
CREATE TABLE usuario_servicio (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY, 
    id_usuario_ofertante INT NOT NULL,
    id_usuario_cliente INT NOT NULL,
    id_articulo INT NOT NULL,
    fecha_transaccion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario_ofertante) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_cliente) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_articulo) REFERENCES servicio(id_articulo) ON DELETE CASCADE
);

-- Creacion Tabla usuario oferta laboral
CREATE TABLE usuario_ofertalaboral (
    id_postulacion INT AUTO_INCREMENT PRIMARY KEY, 
    id_usuario INT NOT NULL,
    id_oferta INT NOT NULL,
    fecha_postulacion DATETIME NOT NULL,
    estado ENUM('postulado', 'entrevistado', 'aceptado', 'rechazado'),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_oferta) REFERENCES oferta_laboral(id_oferta) ON DELETE CASCADE
);

-- Creacion Tabla usuario grupo
CREATE TABLE usuario_grupo (
    id_inscripcion_grupo INT AUTO_INCREMENT PRIMARY KEY, 
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_ingreso DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo) ON DELETE CASCADE
);

-- Creacion Tabla perfil
CREATE TABLE perfil (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    biografia TEXT, -- Usamos TEXT para biografía según tu tabla comparativa
    edad INT,
    alias_usuario VARCHAR(50) UNIQUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    semestre_cursado INT,
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT chk_edad CHECK (edad >= 0),
    CONSTRAINT chk_semestre CHECK (semestre_cursado BETWEEN 1 AND 10)
);