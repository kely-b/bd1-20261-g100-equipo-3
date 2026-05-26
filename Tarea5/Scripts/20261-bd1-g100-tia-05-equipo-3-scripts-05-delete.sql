-- =====================================================
-- Script 05-D — DELETE
-- Proyecto: Red Social 
-- =====================================================


-- -----------------------------------------------------
-- 1. Insertar y eliminar un producto
-- -----------------------------------------------------

INSERT INTO productos (
    id_usuario,
    id_tipo_producto,
    titulo,
    descripcion,
    precio,
    estado_oferta,
    fecha_publicacion
)
VALUES (
    1,
    2,
    'Portátil Lenovo i7',
    'Portátil en buen estado, ideal para estudiantes de ingeniería.',
    2500000,
    'disponible',
    CURRENT_TIMESTAMP
);

-- Eliminación del producto temporal
DELETE FROM productos
WHERE titulo = 'Portátil Lenovo i7';

-- Verificación
SELECT *
FROM productos
WHERE titulo = 'Portátil Lenovo i7';


-- -----------------------------------------------------
-- 2. Insertar y eliminar un evento
-- -----------------------------------------------------

INSERT INTO eventos (
    id_creador,
    id_tipo_evento,
    nombre_evento,
    fecha_hora_inicio,
    fecha_hora_fin,
    ubicacion,
    descripcion,
    estado
)
VALUES (
    1,
    3,
    'Prueba Técnica Plataforma Académica',
    '2026-07-10 08:00:00',
    '2026-07-10 10:00:00',
    'Sala Virtual Teams',
    'Evento académico temporal utilizado para validaciones internas.',
    'programado'
);

-- Eliminación del evento temporal
DELETE FROM eventos
WHERE nombre_evento = 'Prueba Técnica Plataforma Académica';

-- Verificación
SELECT *
FROM eventos
WHERE nombre_evento = 'Prueba Técnica Plataforma Académica';


-- -----------------------------------------------------
-- 3. Insertar y eliminar un servicio
-- -----------------------------------------------------

INSERT INTO servicios (
    id_usuario,
    id_tipo_servicio,
    titulo,
    descripcion,
    precio_referencia,
    estado_oferta,
    fecha_publicacion
)
VALUES (
    1,
    1,
    'Asesoría Académica Temporal',
    'Apoyo académico para estudiantes de primeros semestres.',
    80000,
    'disponible',
    CURRENT_TIMESTAMP
);

-- Eliminación del servicio temporal
DELETE FROM servicios
WHERE titulo = 'Asesoría Académica Temporal';

-- Verificación
SELECT *
FROM servicios
WHERE titulo = 'Asesoría Académica Temporal';
