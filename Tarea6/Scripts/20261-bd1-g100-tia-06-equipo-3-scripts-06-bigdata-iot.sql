--
-- Scripts de experimentación de escenarios Big Data e IoT
-- Red Social Pascualina - Base de Datos - SGBD PostgreSQL
--
-- La Directiva de la Red Socio Productiva requiere que se verifique el rendimiento
-- y velocidad de procesamiento de la base de datos de la Red Pascualina.
-- El Gobierno Nacional ha solicitado expandir la Red a todas las universidades del país.
--


--
-- 1.- CREAR UNA NUEVA TABLA: “usuario_test”. NO UTILIZAR la tabla actual de usuario de la base de datos.
--      Nota: coloque los datos básicos de un usuario. Puede tomar como referencia la tabla "usuarios" y 
--            colocar un mínimo de 5 campos de esa tabla si así lo desea.
--

DROP TABLE IF EXISTS usuario_test;

CREATE TABLE usuario_test (
    id             SERIAL        PRIMARY KEY,
    codigo_usuario VARCHAR(20)   NOT NULL,
    nombres        VARCHAR(80)   NOT NULL,
    apellidos      VARCHAR(80)   NOT NULL,
    correo         VARCHAR(120)  NOT NULL,
    ciudad         VARCHAR(60)   NOT NULL,
    activo         BOOLEAN       NOT NULL DEFAULT TRUE,
    fecha_registro DATE          NOT NULL DEFAULT CURRENT_DATE,
    datos_salud    JSON          NOT NULL  -- campo JSON con métricas de salud IoT
);


--
-- 2.- Utilice o elabore una función de generación de registros aleatorios en la tabla "usuario_test" 
--  Nota: recuerde los ejercicios y talleres realizados en los encuentros sincrónicos.
--

CREATE OR REPLACE FUNCTION generar_usuarios_test(n INTEGER)
RETURNS VOID
LANGUAGE plpgsql AS $$
DECLARE
    v_grupos  TEXT[] := ARRAY['A+','A-','B+','B-','AB+','AB-','O+','O-'];
    v_ciudad  TEXT[] := ARRAY['Medellín','Bogotá','Cali','Barranquilla','Manizales',
                               'Pereira','Bucaramanga','Cartagena','Cúcuta','Ibagué'];
    v_nombres TEXT[] := ARRAY['Carlos','María','Andrés','Laura','Juan','Valentina',
                               'Santiago','Camila','Daniel','Sofía','Felipe','Isabella'];
    v_apells  TEXT[] := ARRAY['García','Rodríguez','Martínez','López','González',
                               'Pérez','Sánchez','Ramírez','Torres','Flores'];
    v_base    TIMESTAMP := NOW() - INTERVAL '30 days';

BEGIN
    INSERT INTO usuario_test (
        codigo_usuario,
        nombres,
        apellidos,
        correo,
        ciudad,
        activo,
        fecha_registro,
        datos_salud
    )
    SELECT
        -- Código único: USR00000001 ... USR99999999
        'USR' || LPAD(s.i::TEXT, 8, '0'),

        -- Nombre aleatorio del arreglo (FLOOR evita índice fuera de rango)
        v_nombres[ 1 + FLOOR(RANDOM() * array_length(v_nombres, 1))::INT ],

        -- Apellido aleatorio
        v_apells[ 1 + FLOOR(RANDOM() * array_length(v_apells, 1))::INT ],

        -- Correo único usando el iterador i
        'usr' || s.i || '@pascualina.edu.co',

        -- Ciudad aleatoria
        v_ciudad[ 1 + FLOOR(RANDOM() * array_length(v_ciudad, 1))::INT ],

        -- Activo: TRUE en el 90% de los casos
        (RANDOM() > 0.1),

        -- Fecha aleatoria dentro de los últimos 30 días
        (v_base + (RANDOM() * INTERVAL '30 days'))::DATE,

        -- JSON con métricas de salud (simulación sensor IoT)
        json_build_object(
            'presion_sanguinea', json_build_object(
                'sistolica',  ( 90 + FLOOR(RANDOM() * 60)::INT )::TEXT || ' mmHg',
                'diastolica', ( 60 + FLOOR(RANDOM() * 40)::INT )::TEXT || ' mmHg'
            ),
            'temperatura_corporal',
                ROUND((36.0 + RANDOM() * 2.5)::NUMERIC, 1)::TEXT || ' C',
            'grupo_sanguineo',
                v_grupos[ 1 + FLOOR(RANDOM() * array_length(v_grupos, 1))::INT ],
            'nivel_azucar',
                ( 70 + FLOOR(RANDOM() * 130)::INT )::TEXT || ' mg/dL',
            'fecha_medicion',
                (v_base + (RANDOM() * INTERVAL '30 days'))::DATE::TEXT,
            'hora_medicion',
                TO_CHAR(
                    ('2026-01-01 00:00:00'::TIMESTAMP + (RANDOM() * INTERVAL '24 hours')),
                    'HH24:MI:SS'
                )
        )
    FROM generate_series(1, n) AS s(i);
END;
$$;



--
-- 3.- Utilice la función para realizar las siguientes simulaciones de "inserción" en la tabla "usuario_test"
--
-- Simulación 1:      1.000 registros de usuarios
-- Simulación 2:     10.000     "       "
-- Simulación 3:    100.000     "       "
-- Simulación 4:  1.000.000     "       "
-- Simulación 5: 10.000.000     "       "

-- 
-- SIMULACIÓN 1: 1.000 registros
-- 

TRUNCATE TABLE usuario_test RESTART IDENTITY;

-- Escritura (INSERT masivo)
EXPLAIN ANALYZE SELECT generar_usuarios_test(1000);

-- Tamaño de la tabla tras la inserción
SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0, 2) AS tamanio_mb;

-- Lectura (SELECT con extracción de campos JSON)
EXPLAIN ANALYZE
SELECT id,
       codigo_usuario,
       datos_salud ->> 'grupo_sanguineo'                    AS grupo_sanguineo,
       datos_salud ->> 'temperatura_corporal'                AS temperatura,
       datos_salud -> 'presion_sanguinea' ->> 'sistolica'    AS presion_sistolica
FROM usuario_test LIMIT 100;

TRUNCATE TABLE usuario_test RESTART IDENTITY;

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0,  2) AS tamaño_mb;


-- 
-- SIMULACIÓN 2: 10.000 registros
-- 

EXPLAIN ANALYZE SELECT generar_usuarios_test(10000);

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0, 2) AS tamanio_mb;

EXPLAIN ANALYZE
SELECT id,
       codigo_usuario,
       datos_salud ->> 'grupo_sanguineo'                    AS grupo_sanguineo,
       datos_salud ->> 'temperatura_corporal'                AS temperatura,
       datos_salud -> 'presion_sanguinea' ->> 'sistolica'    AS presion_sistolica
FROM usuario_test LIMIT 100;

TRUNCATE TABLE usuario_test RESTART IDENTITY;

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0,  2) AS tamaño_mb;


-- 
-- SIMULACIÓN 3: 100.000 registros
-- 

EXPLAIN ANALYZE SELECT generar_usuarios_test(100000);

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0, 2) AS tamanio_mb;

EXPLAIN ANALYZE
SELECT id,
       codigo_usuario,
       datos_salud ->> 'grupo_sanguineo'                    AS grupo_sanguineo,
       datos_salud ->> 'temperatura_corporal'                AS temperatura,
       datos_salud -> 'presion_sanguinea' ->> 'sistolica'    AS presion_sistolica
FROM usuario_test LIMIT 100;

TRUNCATE TABLE usuario_test RESTART IDENTITY;

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0,  2) AS tamaño_mb;

-- 
-- SIMULACIÓN 4: 1.000.000 registros
-- 

EXPLAIN ANALYZE SELECT generar_usuarios_test(1000000);

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0, 2) AS tamanio_mb;

EXPLAIN ANALYZE
SELECT id,
       codigo_usuario,
       datos_salud ->> 'grupo_sanguineo'                    AS grupo_sanguineo,
       datos_salud ->> 'temperatura_corporal'                AS temperatura,
       datos_salud -> 'presion_sanguinea' ->> 'sistolica'    AS presion_sistolica
FROM usuario_test LIMIT 100;

TRUNCATE TABLE usuario_test RESTART IDENTITY;

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0,  2) AS tamaño_mb;

-- 
-- SIMULACIÓN 5: 10.000.000 registros
-- ADVERTENCIA: puede tardar varios minutos según el hardware disponible.
-- 

EXPLAIN ANALYZE SELECT generar_usuarios_test(10000000);

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0, 2) AS tamanio_mb;

EXPLAIN ANALYZE
SELECT id,
       codigo_usuario,
       datos_salud ->> 'grupo_sanguineo'                    AS grupo_sanguineo,
       datos_salud ->> 'temperatura_corporal'                AS temperatura,
       datos_salud -> 'presion_sanguinea' ->> 'sistolica'    AS presion_sistolica
FROM usuario_test LIMIT 100;

TRUNCATE TABLE usuario_test RESTART IDENTITY;

SELECT ROUND(pg_total_relation_size('usuario_test') / 1024.0 / 1024.0,  2) AS tamaño_mb;
