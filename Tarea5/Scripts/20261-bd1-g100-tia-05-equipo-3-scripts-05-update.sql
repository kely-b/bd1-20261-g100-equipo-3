-- -----------------------------------------------------
-- UPDATE 1: Actualización de teléfono de usuario
-- -----------------------------------------------------
-- Se actualiza el número telefónico del usuario
-- para mantener la información de contacto actualizada.

UPDATE usuarios
SET telefono = '3001234567'
WHERE id_usuario = 1;

SELECT id_usuario, nombre, apellido, telefono
FROM usuarios
WHERE id_usuario = 1;

-- -----------------------------------------------------
-- UPDATE 2: Cambio de ubicación de evento
-- -----------------------------------------------------
-- Se actualiza la ubicación del evento debido
-- a un cambio logístico institucional.

UPDATE eventos
SET ubicacion = 'Auditorio Principal – Sede Central'
WHERE id_evento = 1;

SELECT id_evento, nombre_evento, ubicacion
FROM eventos
WHERE id_evento = 1;

-- -----------------------------------------------------
-- UPDATE 3: Cambio de precio producto 1
-- -----------------------------------------------------
-- Se actualiza el precio del producto debido
-- a ajustes comerciales y estado del artículo.

UPDATE productos
SET precio = 1850000
WHERE id_producto = 1;

SELECT id_producto, titulo, precio
FROM productos
WHERE id_producto = 1;

-- -----------------------------------------------------
-- UPDATE 4: Cambio de precio producto 2
-- -----------------------------------------------------
-- Se modifica el precio del producto
-- según disponibilidad y condiciones del mercado.

UPDATE productos
SET precio = 1750000
WHERE id_producto = 5;

SELECT id_producto, titulo, precio
FROM productos
WHERE id_producto = 5;

-- -----------------------------------------------------
-- UPDATE 5: Cambio de precio producto 3
-- -----------------------------------------------------
-- Se ajusta el precio del producto para
-- mantener competitividad en la publicación.

UPDATE productos
SET precio = 990000
WHERE id_producto = 8;

SELECT id_producto, titulo, precio
FROM productos
WHERE id_producto = 8;

-- -----------------------------------------------------
-- UPDATE 6: Reprogramación de fecha de evento
-- -----------------------------------------------------
-- Se actualizan las fechas del evento debido
-- a cambios organizacionales y disponibilidad logística.

UPDATE eventos
SET fecha_hora_inicio = '2026-02-20 09:00:00',
    fecha_hora_fin = '2026-02-20 13:00:00'
WHERE id_evento = 2;

SELECT id_evento, nombre_evento,
       fecha_hora_inicio, fecha_hora_fin
FROM eventos
WHERE id_evento = 2;

-- -----------------------------------------------------
-- UPDATE 7: Cambio de fecha de evento académico
-- -----------------------------------------------------
-- Se ajustan las fechas del evento para
-- mejorar la organización y asistencia de participantes.

UPDATE eventos
SET fecha_hora_inicio = '2026-04-10 08:00:00',
    fecha_hora_fin = '2026-04-10 16:00:00'
WHERE id_evento = 4;

SELECT id_evento, nombre_evento,
       fecha_hora_inicio, fecha_hora_fin
FROM eventos
WHERE id_evento = 4;