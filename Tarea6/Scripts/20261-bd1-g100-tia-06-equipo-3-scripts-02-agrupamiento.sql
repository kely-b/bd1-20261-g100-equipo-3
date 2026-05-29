--
-- Scripts de Consultas con agrupamientos y funciones de agregación de la Base de Datos  - SGBD PostgreSQL
-- 


--
-- Consulta #1: Grupos
-- 
SELECT
    g.id_grupo                        AS "ID Grupo",
    g.nombre                          AS "Nombre del Grupo",
    g.tipo_grupo                      AS "Tipo de Grupo",
    g.fecha_creacion                  AS "Fecha de Creación",
    u.nombre || ' ' || u.apellido     AS "Nombre Completo Creador",
    COUNT(ug.id_usuario)              AS "Total de Miembros"
FROM grupos g
INNER JOIN usuarios      u  ON u.id_usuario  = g.id_administrador
LEFT  JOIN usuario_grupo ug ON ug.id_grupo   = g.id_grupo
GROUP BY
    g.id_grupo,
    g.nombre,
    g.tipo_grupo,
    g.fecha_creacion,
    u.nombre,
    u.apellido
ORDER BY g.nombre ASC;
 


--
-- Consulta #2: Eventos
-- 
SELECT
    te.id_tipo_evento                     AS "ID Tipo Evento",
    te.nombre_tipo                        AS "Tipo de Evento",
    u.nombre || ' ' || u.apellido         AS "Nombre Promotor",
    e.nombre_evento                       AS "Descripción del Evento",
    e.fecha_hora_inicio                   AS "Fecha de Inicio",
    e.estado                              AS "Estado del Evento",
    COUNT(eu.id_usuario)                  AS "Total Usuarios Inscritos"
FROM eventos e
INNER JOIN tipos_evento    te ON te.id_tipo_evento = e.id_tipo_evento
INNER JOIN usuarios        u  ON u.id_usuario      = e.id_creador
LEFT  JOIN evento_usuarios eu ON eu.id_evento      = e.id_evento
GROUP BY
    te.id_tipo_evento,
    te.nombre_tipo,
    u.nombre,
    u.apellido,
    e.id_evento,
    e.nombre_evento,
    e.fecha_hora_inicio,
    e.estado
ORDER BY e.fecha_hora_inicio DESC;
 
 


--
-- Consulta #3: Tipos de Servicio
-- 

SELECT
    ts.id_tipo_servicio                   AS "ID Tipo Servicio",
    ts.nombre_tipo                        AS "Nombre Tipo Servicio",
    COUNT(tr.id_usuario_cliente)          AS "Total Usuarios que lo Consumieron",
    COUNT(DISTINCT tr.id_usuario_cliente) AS "Usuarios Únicos Consumidores"
FROM transacciones_servicio tr
INNER JOIN servicios     s  ON s.id_servicio      = tr.id_servicio
INNER JOIN tipos_servicio ts ON ts.id_tipo_servicio = s.id_tipo_servicio
WHERE tr.fecha_transaccion BETWEEN '2026-01-01 00:00:00'
                                AND '2026-03-31 23:59:59'
GROUP BY
    ts.id_tipo_servicio,
    ts.nombre_tipo
ORDER BY COUNT(tr.id_usuario_cliente) DESC;
 
 
--
-- Consulta #4: Productos
-- 
SELECT
    tp.nombre_tipo                        AS "Tipo de Producto",
    p.titulo                              AS "Nombre del Producto",
    u.nombre || ' ' || u.apellido         AS "Vendedor",
    u.correo                              AS "Correo Vendedor",
    COUNT(p.id_producto)                  AS "Cantidad Vendida",
    SUM(p.precio)                         AS "Monto Total Vendido (COP)"
FROM productos p
INNER JOIN tipos_producto tp ON tp.id_tipo_producto = p.id_tipo_producto
INNER JOIN usuarios       u  ON u.id_usuario        = p.id_usuario
WHERE p.estado_oferta    = 'vendido'
  AND p.fecha_publicacion BETWEEN '2026-04-01 00:00:00'
                               AND '2026-04-30 23:59:59'
GROUP BY
    tp.nombre_tipo,
    p.titulo,
    u.nombre,
    u.apellido,
    u.correo
ORDER BY SUM(p.precio) DESC
LIMIT 20;
 
--
-- Consulta #5: Tipos de Producto
-- 
SELECT
    tp.nombre_tipo                          AS "Tipo de Producto",
    COUNT(p.id_producto)                    AS "Total Productos Vendidos",
    COUNT(DISTINCT p.id_usuario)            AS "Total Vendedores Únicos",
    SUM(p.precio)                           AS "Monto Total de Ventas (COP)",
    ROUND(AVG(p.precio), 2)                 AS "Precio Promedio (COP)",
    MAX(p.precio)                           AS "Precio Máximo (COP)",
    MIN(p.precio)                           AS "Precio Mínimo (COP)"
FROM productos p
INNER JOIN tipos_producto tp ON tp.id_tipo_producto = p.id_tipo_producto
WHERE p.estado_oferta = 'vendido'
GROUP BY
    tp.nombre_tipo
ORDER BY SUM(p.precio) DESC;
 

--
-- Consulta #6: LIBRE DE PLANTEAMIENTO
-- 
SELECT
    pub.id_publicacion                    AS "ID Publicación",
    pub.tipo_contenido                    AS "Tipo de Contenido",
    pub.fecha_publicacion                 AS "Fecha de Publicación",
    u.nombre || ' ' || u.apellido         AS "Nombre Completo Autor",
    pf.alias_usuario                      AS "Alias del Autor",
    pf.semestre_cursado                   AS "Semestre del Autor",
    COUNT(c.id_comentario)                AS "Total de Comentarios"
FROM publicaciones pub
INNER JOIN usuarios    u  ON u.id_usuario    = pub.id_usuario
INNER JOIN perfil      pf ON pf.id_usuario   = u.id_usuario
INNER JOIN comentarios c  ON c.id_publicacion = pub.id_publicacion
WHERE pub.fecha_publicacion >= '2026-01-01'
GROUP BY
    pub.id_publicacion,
    pub.tipo_contenido,
    pub.fecha_publicacion,
    u.nombre,
    u.apellido,
    pf.alias_usuario,
    pf.semestre_cursado
HAVING COUNT(c.id_comentario) > 2
ORDER BY COUNT(c.id_comentario) DESC;
 