 -- 1.1 Agregar un campo (columna) a la tabla Usuarios
ALTER TABLE usuario 
ADD COLUMN orientacion_sexual VARCHAR(20) CHECK (orientacion_sexual IN ('heterosexual', 'homosexual', 'bisexual', 'pansexual', 'asexual', 'prefiero_no_decir'));

-- 1.2 Modificar un campo de la tabla de usuarios
ALTER TABLE usuario RENAME COLUMN rol TO tipo_de_usuario

-- Gestionar una tabla "nueva" "perfil"
-- 1.- "agregar" una nueva tabla a la base de datos que tenga relación con el sistema
-- 2.- Darle un nombre "coherente"
-- 3.- Agregar campos coherentes con la tabla
-- 4.- Realizar todas las operaciones que se solicitan a continuación

-- 1.3.1
-- Crear una tabla "nueva" de su iniciativa (una tabla coherente con el sistema con su nombre, no coloque "nueva" como nombre)
CREATE TABLE perfil ();

-- 1.3.2
-- Agregar una clave primaria y otros 3 campos cualquiera a la tabla "nueva"
-- Mínimo un campo tipo texto y uno numérico
ALTER TABLE perfil
ADD COLUMN id_perfil SERIAL PRIMARY KEY,
ADD COLUMN id_usuario INT NOT NULL,
ADD COLUMN biografia TEXT,
ADD COLUMN edad INT,
ADD COLUMN habilidades TEXT,
ADD FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;

-- 1.3.3
-- Quitar uno de los campos de la tabla "nueva"
ALTER TABLE perfil DROP COLUMN habilidades;

-- 1.3.4
-- Cambiar el nombre de la tabla "nueva" a otro nombre "otro_nombre"
-- Todas las operaciones siguientes se realizan sobre la tabla renombrada
ALTER TABLE perfil RENAME TO perfil_usuario;

-- 1.3.5 
-- Agregar un campo único a la tabla 
ALTER TABLE perfil_usuario
ADD COLUMN alias_usuario VARCHAR(20) UNIQUE;

-- 1.3.6
-- Agregar 2 fechas de inicio y fin; y colocar un control de orden de fechas
ALTER TABLE perfil_usuario
ADD COLUMN fecha_creacion DATE,
ADD COLUMN fecha_eliminacion DATE,
ADD CONSTRAINT chk_orden_fechas_perfil CHECK (fecha_eliminacion IS NULL OR fecha_creacion <= fecha_eliminacion);

-- 1.3.7
-- Agregar 1 campo entero y colocar un control para que no sea negativo
ALTER TABLE perfil_usuario
ADD COLUMN semestre_cursado INT CHECK (semestre_cursado >= 1);

-- 1.3.8
-- Modificar el tamaño de un campo texto de la tabla renombra
ALTER TABLE perfil_usuario
ALTER COLUMN biografia TYPE VARCHAR(500);

-- 1.3.9
-- Modificar el campo numeríco y colocar un control de rango 
ALTER TABLE perfil_usuario ADD CONSTRAINT
semestre_cursado CHECK (semestre_cursado BETWEEN 1 AND 12);

-- 1.3.10
-- Agregar un índice a la tabla (cualquier campo)
CREATE INDEX idx_perfil_usuario_id ON perfil_usuario(id_usuario);

-- 1.3.11
-- Eliminar una de las fechas
ALTER TABLE perfil_usuario DROP COLUMN fecha_eliminacion;

-- 1.3.12
-- Borrar todos los datos de una tabla sin dejar traza
TRUNCATE TABLE perfil_usuario RESTART IDENTITY CASCADE;

