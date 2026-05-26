--
-- Script de Verificar cada una de las 4 propiedades ACID en la Base de Datos  - SGBD PostgreSQL
-- 
-- ATOMICIDAD: BEGIN-ROLLBACK

-- ANTES

SELECT id_evento, nombre_evento, estado
FROM eventos
WHERE id_evento = 1;

SELECT id_usuario, nombre, apellido, activo
FROM usuarios
WHERE id_usuario = 1;

-- EJECUCIÓN ROLLBACK

BEGIN;

    UPDATE eventos
    SET estado = 'cancelado'
    WHERE id_evento = 1;

    UPDATE usuarios
    SET activo = FALSE
    WHERE id_usuario = 1;

ROLLBACK;

-- DESPUÉS

SELECT id_evento, nombre_evento, estado
FROM eventos
WHERE id_evento = 1;

SELECT id_usuario, nombre, apellido, activo
FROM usuarios
WHERE id_usuario = 1;

-- CONSISTENCIA: INSERT, UPDATE, DELETE 

INSERT INTO usuarios (id_usuario, id_rol, id_tipo_usuario, nombre, apellido, correo)
VALUES (1, 3, 1, 'Pedro', 'Prueba', 'prueba@pascualbravo.edu.co');

UPDATE usuarios
SET sexo = 'desconocido'
WHERE id_usuario = 1;

DELETE FROM eventos
WHERE id_evento = 1;


-- AISLAMIENTO 

-- Caso hipoético:
-- Dos administradores (Admin1 y Admin2) acceden al sistema al mismo tiempo.

-- Transacción A (Admin1):
-- Está actualizando el estado del evento 5 de 'programado' a 'en_curso' pero aún no ha hecho COMMIT.

-- Transacción B (Admin2): Al mismo tiempo consulta el evento 5 para verificar su estado.

-- ¿Qué ve Admin2?

-- Con nivel de aislamiento READ COMMITTED (por defecto en PostgreSQL):
-- -> Admin2 ve el estado ORIGINAL 'programado'
-- -> No ve los cambios de Admin1 hasta que haga COMMIT
-- -> Esto evita lecturas sucias (dirty reads)

-- Si Admin1 hace ROLLBACK:
-- -> El cambio desaparece
-- -> Admin2 nunca vio datos incorrectos
-- -> La BD mantuvo la consistencia entre sesiones


-- DURABILIDAD: COMMIT

-- ANTES

SELECT id_evento, nombre_evento, estado
FROM eventos
WHERE id_evento = 2;

SELECT id_usuario, nombre, apellido, activo
FROM usuarios
WHERE id_usuario = 2;

-- EJECUCIÓN COMMIT

BEGIN;

    UPDATE eventos
    SET estado = 'finalizado'
    WHERE id_evento = 2;

    UPDATE usuarios
    SET activo = FALSE
    WHERE id_usuario = 2;

COMMIT;

-- DESPUÉS

SELECT id_evento, nombre_evento, estado
FROM eventos
WHERE id_evento = 2;

SELECT id_usuario, nombre, apellido, activo
FROM usuarios
WHERE id_usuario = 2;
