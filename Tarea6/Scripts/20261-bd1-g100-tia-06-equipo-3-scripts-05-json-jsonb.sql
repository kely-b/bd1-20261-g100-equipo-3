--
-- Scripts de comparación de rendimiento de datos semi estructurados: JSON y JSONB
-- de la Base de Datos  - SGBD PostgreSQL
-- 
CREATE TABLE datos_json (
    id SERIAL PRIMARY KEY,
    informacion JSON
);

CREATE TABLE datos_jsonb (
    id SERIAL PRIMARY KEY,
    informacion JSONB
);

EXPLAIN ANALYZE
INSERT INTO datos_json (informacion)
SELECT
json_build_object(
    'nombre', 'Daniel',
    'edad', 20,
    'ciudad', 'Girardota',
    'activo', true
)
FROM generate_series(1,500);

EXPLAIN ANALYZE
SELECT *
FROM datos_json;

EXPLAIN ANALYZE
INSERT INTO datos_jsonb (informacion)
SELECT
jsonb_build_object(
    'nombre', 'Daniel',
    'edad', 20,
    'ciudad', 'Girardota',
    'activo', true
)
FROM generate_series(1,500);

EXPLAIN ANALYZE
SELECT *
FROM datos_jsonb;



