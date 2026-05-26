--
-- Script de VIEW de la Base de Datos  - SGBD PostgreSQL
-- 
-- PRIMERO: ELABORE LA VISTA

CREATE OR REPLACE VIEW vw_detalle_eventos AS
SELECT
    -- Tipo de evento
    te.id_tipo_evento AS cod_tipo_evento,
    te.nombre_tipo AS tipo_evento,

    -- Datos del evento
    e.id_evento AS cod_evento,
    e.nombre_evento,
    e.descripcion AS descripcion_evento,
    e.fecha_hora_inicio AS fecha_inicio,
    e.fecha_hora_fin AS fecha_fin,
    e.estado AS estado_evento,
    e.ubicacion,

    -- Usuario creador del evento
    uc.id_usuario AS cod_creador,
    uc.nombre ||' '|| uc.apellido AS nombre_creador,
    pf.alias_usuario AS alias_creador,

    -- Participante inscrito
    up.id_usuario AS cod_participante,
    up.nombre ||' '|| up.apellido AS nombre_participante,

    -- Detalle de la inscripción
    eu.estado_asistencia,
    eu.fecha_suscripcion AS fecha_inscripcion,
    eu.likes AS likes_participante

FROM eventos AS e
    JOIN tipos_evento AS te ON e.id_tipo_evento = te.id_tipo_evento
    JOIN usuarios AS uc ON e.id_creador = uc.id_usuario
	JOIN perfil AS pf ON uc.id_usuario = pf.id_usuario
    JOIN evento_usuarios AS eu ON e.id_evento = eu.id_evento
    JOIN usuarios AS up ON eu.id_usuario = up.id_usuario;

-- SEGUNDO: UTILICE LA VISTA

SELECT
    cod_tipo_evento,
    tipo_evento,
    fecha_inicio,
    cod_evento,
    nombre_evento,
    descripcion_evento,
    estado_evento,
    ubicacion,
    cod_creador,
    nombre_creador,
    alias_creador,
    cod_participante,
    nombre_participante,
    estado_asistencia,
    fecha_inscripcion,
    likes_participante
FROM vw_detalle_eventos
WHERE fecha_inicio >= NOW() - INTERVAL '3 months'
ORDER BY
    tipo_evento DESC,
    fecha_inicio DESC;


