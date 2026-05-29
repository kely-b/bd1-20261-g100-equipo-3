--
-- Script de Consulta con Parámtros a partir de una Vista (VIEW) de la Base de Datos  - SGBD PostgreSQL
--
-- 


--
-- 1.- Crea la vista (VIEW)
--      No debe tener ni WHERE ni GROUP BY ni ORDER BY (no tendría sentido para la reutilización)
--
-- Vista de actividad de eventos con sus creadores y participantes

CREATE OR REPLACE VIEW vw_actividad_eventos AS
SELECT
    -- Datos del creador
    uc.id_usuario AS cod_creador,
    uc.nombre ||' '|| uc.apellido AS nombre_creador,
    uc.correo AS correo_creador,

    -- Datos del tipo de evento
    te.id_tipo_evento AS cod_tipo_evento,
    te.nombre_tipo AS tipo_evento,

    -- Datos del evento
    e.id_evento AS cod_evento,
    e.nombre_evento,
    e.estado AS estado_evento,
    e.fecha_hora_inicio AS fecha_inicio,

    -- Datos del participante
    up.id_usuario AS cod_participante,
    up.nombre ||' '|| up.apellido AS nombre_participante,

    -- Detalle de participación
    eu.estado_asistencia,
    eu.likes AS likes_participante

FROM eventos AS e
    JOIN tipos_evento AS te ON e.id_tipo_evento = te.id_tipo_evento 
    JOIN usuarios AS uc ON e.id_creador = uc.id_usuario 
    JOIN evento_usuarios AS eu ON e.id_evento = eu.id_evento 
    JOIN usuarios AS up ON eu.id_usuario = up.id_usuario; 


--
-- 2.- Preparar la consulta (utilizando la vista)
--      Aquí se colocan los parámetros
--      Se aplican los parámetros a un dato en el WHERE y un dato en el HAVING
--
-- Consulta reutilizable:

PREPARE analisis_actividad_eventos(VARCHAR, INTEGER) AS

SELECT
    cod_creador, 
    nombre_creador, 
    correo_creador, 
    tipo_evento, 
    COUNT(DISTINCT cod_evento) AS total_eventos, -- cuántos eventos creó
    COUNT(cod_participante) AS total_participantes -- cuántos participantes tuvo

FROM vw_actividad_eventos

WHERE estado_evento = $1 -- parámetro 1: filtra por estado del evento

GROUP BY
    cod_creador,
    nombre_creador,
    correo_creador,
    tipo_evento

HAVING COUNT(cod_participante) > $2 -- parámetro 2: mínimo de participantes

ORDER BY
    total_participantes DESC,
    total_eventos DESC;


--
-- 3.- Ejecutar 3 consultas con diferentes parámetros (EXECUTE)
--
-- EXECUTE 1:
EXECUTE analisis_actividad_eventos('finalizado', 3); -- Eventos finalizados con más de 3 participantes

-- EXECUTE 2:
EXECUTE analisis_actividad_eventos('programado', 1); -- Eventos programados con más de 1 participante inscrito

-- EXECUTE 3:
EXECUTE analisis_actividad_eventos('en_curso', 2); -- Eventos en curso con más de 2 participantes activos

-- Analisis del plan de ejecución
EXPLAIN ANALYZE
EXECUTE analisis_actividad_eventos('finalizado', 5);

--
-- 4.-  Explicar la importancia de esta experiencia 
--
-- La realización de este trabajo fue una experiencia que me ayudó a comprender mejor cómo funcionan las consultas y la importancia de hacer las cosas de forma organizada, aunque al principio algunas partes me confundían, luego fui entendiendo todo y eso hizo que el ejercicio fuera más interesante, además sentí que fue una buena práctica porque me permitió aprender de una manera más aplicada y cercana a situaciones reales.





