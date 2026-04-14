--Creacion de Tabla usuario para evitar errores al momento de su ejecución y verificar este ejercicio
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


-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Todas las instrucciones se deben realizar en secuencia sin errores
-- Probar los scripts en detalle

-- Modificación de la Base de Datos

-- 1.- DATOS SEMI-ESTRUCTURADOS PARA DATOS PARA BIG DATA
-- Gestionar el campo "perfil_usuario" en tabla "usuarios" 
-- Debe incluir otros datos diferentes al ejemplo del Anexo B
-- 1.- "agregar" un campo tipo JSON o JSNOB
ALTER TABLE usuario
ADD COLUMN perfil_usuario JSONB;

-- 2.- Agregar un par de registros
INSERT INTO usuario (nombre, apellido, rol, correo, sexo, telefono, fecha_nacimiento, perfil_usuario) VALUES
('Andrea' , 'Granda' , 'estudiante' , 'amg@pascualbravo.edu.co' , 'femenino' , '3001112455' , '1998-12-17',
 ' { "Hobbies" : [ "Voleibol", "Baile" ], "Ciudad" : {"Medellin" : "Calazans"}, "Nivel" : "Avanzado"}'),

('Abraham' , 'Linconln' , 'profesor' , 'abralin@pascualbravo.edu.co' , 'masculino' , '38954212' , '1975-08-01',
' { "Hobbies" : [ "Lectura", "Musica"], "Ciudad" : {"Bello" : "Cabañas"}, "Nivel" : "Profeesional"}');

-- 3.- Consultar la información agregada
SELECT nombre, rol FROM usuario

-- 4.- Describir el campo y explicar su propósito
-- El campo perfil_usuario es util para almacenar ampliamente la informacion que se desee registrar y consultar. Tambien 
-- gracias al formato JSON podemos agregar eficiencia al integrar una base de datos relacional con la flexibilidad, 
-- escalabilidad y alto rendimiento de una Base de Datos No Relacional "NoSQL"; sin tener la necesidad de crear otras columnas adicionales
-- en la tabla.


--------------------------------------------------------------------
--------------------------------------------------------------------
--Creacion de Tabla usuario para evitar errores al momento de su ejecución y verificar este ejercicio
CREATE TABLE publicacion (
    id_publicacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL,
    texto TEXT NOT NULL,
	
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- 2.- DATOS SEMI-ESTRUCTURADOS (PARA BIG DATA o IOT)
-- Gestionar un nuevo campo "nombre_campo" (de su propia creación) en cualquier tabla (de las existentes) que considere adecuada
-- 1.- "agregar" un campo tipo JSON o JSONB
ALTER TABLE publicacion
ADD COLUMN metricas JSONB;

-- 2.- Agregar un par de registros de información
INSERT INTO publicacion (id_usuario, fecha_publicacion, texto, metricas) VALUES
(1, CURRENT_TIMESTAMP, 'Gonzando mis vacaciones' , '{"Likes" : 108, "Comentarios" : 41, "Compartidos" : 37, 
"Dispositivo" : "Android", "Ubicacion" : {"Ciudad" : "Santa Marta"}}')

INSERT INTO publicacion (id_usuario, fecha_publicacion, texto, metricas) VALUES
(2, CURRENT_TIMESTAMP,'Aprendiendo a Conducir', '{"Likes" : 86, "Comentarios" : 54, "Compartidos" : 34,
"Dispositivo" : "Laptop", "Ubicacion" : {"Ciudad" : "Medellin"}}')

-- 3.- Consultar la información agregada
SELECT id_usuario, publicacion, metricas FROM publicacion

-- 4.- Describir el campo y explicar su propósito
-- El campo "metricas" nos permite agregar datos dinamicos de interaccion en tiempo real, sin necesidad
-- de anexar otro campo o columnas adicionales en la tabla, permitiendo un manejo oraganizacional y esclable.