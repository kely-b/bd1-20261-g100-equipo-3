--
-- Scripts de Manipulación de una dato (campo) JSONB
-- Tabla: "perfil" de la Base de Datos  - SGBD PostgreSQL
--

-- Agregue un NUEVO campo tipo JSONB a la tabla “perfil” (otro JSONB DIFERENTE al original que creo en la tarea anterior).
-- Utilice la misma estructura del campo tipo JSON del ítem anterior. Nota: solo cambie el nombre del campo para diferenciarlo
-- Realice cada una de las operaciones con el dato campo creado

--
-- Instrucción "ALTER TABLE" para agregar campo JSONB en tabla "perfil"
--

ALTER TABLE perfil
    ADD COLUMN IF NOT EXISTS datos_dispositivo_b JSONB;


--
-- 1.- Inserción del dato semi estructurado en nuevo campo 
--

UPDATE perfil
SET datos_dispositivo_b = '{
    "dispositivo": {
        "marca": "Samsung",
        "modelo": "Galaxy A54",
        "sistema_operativo": "Android",
        "version_so": "13.0"
    },
    "aplicacion": {
        "nombre": "Red Pascualina",
        "version": "2.4.1",
        "idioma": "es-CO"
    },
    "acceso": {
        "ultimo_acceso": "2026-05-20",
        "hora_acceso": "08:35:00",
        "tipo_conexion": "WiFi",
        "ip_publica": "190.24.55.12"
    }
}'::JSONB WHERE id_perfil = 1;

UPDATE perfil
SET datos_dispositivo_b = '{
    "dispositivo": {
        "marca": "Apple",
        "modelo": "iPhone 14",
        "sistema_operativo": "iOS",
        "version_so": "17.2"
    },
    "aplicacion": {
        "nombre": "Red Pascualina",
        "version": "2.4.1",
        "idioma": "es-CO"
    },
    "acceso": {
        "ultimo_acceso": "2026-05-21",
        "hora_acceso": "14:10:22",
        "tipo_conexion": "4G",
        "ip_publica": "181.33.90.45"
    }
}'::JSONB WHERE id_perfil = 2;


--
-- 2.- Consulta de los datos del campo 
--

-- 2.1 Consultar todo el campo JSONB

SELECT id_perfil,
       datos_dispositivo_b
FROM perfil WHERE datos_dispositivo_b IS NOT NULL;

-- 2.2 Consultar marca y modelo (misma sintaxis que JSON con -> y ->>)

SELECT id_perfil,
       datos_dispositivo_b -> 'dispositivo' ->> 'marca'  AS marca,
       datos_dispositivo_b -> 'dispositivo' ->> 'modelo' AS modelo
FROM perfil WHERE datos_dispositivo_b IS NOT NULL;

-- 2.3 Filtrar por sistema operativo (aprovechando rendimiento JSONB con operador @>)

SELECT id_perfil,
       datos_dispositivo_b -> 'dispositivo' ->> 'sistema_operativo' AS so
FROM perfil WHERE datos_dispositivo_b @> '{"dispositivo": {"sistema_operativo": "Android"}}';

-- 2.4 Consultar tipo de conexión y versión de app

SELECT id_perfil,
       datos_dispositivo_b -> 'acceso'     ->> 'tipo_conexion' AS conexion,
       datos_dispositivo_b -> 'aplicacion' ->> 'version'       AS version_app
FROM perfil WHERE datos_dispositivo_b IS NOT NULL;

-- 2.5 Crear índice GIN (ventaja exclusiva de JSONB - acelera búsquedas en Big Data)

CREATE INDEX IF NOT EXISTS idx_gin_datos_dispositivo_b ON perfil USING GIN (datos_dispositivo_b);


--
-- 3.- Modificación de uno de los datos dentro la semi estructura
-- 

-- Actualizar la versión de la aplicación a "2.5.0" en el perfil 1

-- jsonb_set(campo, '{ruta, clave}', nuevo_valor, crear_si_no_existe)

UPDATE perfil
SET datos_dispositivo_b = jsonb_set(
        datos_dispositivo_b,
        '{aplicacion, version}',
        '"2.5.0"',
        FALSE
    )
WHERE id_perfil = 1;

-- Actualizar el tipo de conexión a "5G" en el perfil 2

UPDATE perfil
SET datos_dispositivo_b = jsonb_set(
        datos_dispositivo_b,
        '{acceso, tipo_conexion}',
        '"5G"',
        FALSE
    )
WHERE id_perfil = 2;

-- Verificar las modificaciones

SELECT id_perfil,
       datos_dispositivo_b -> 'aplicacion' ->> 'version'       AS version_app,
       datos_dispositivo_b -> 'acceso'     ->> 'tipo_conexion'  AS conexion
FROM perfil WHERE datos_dispositivo_b IS NOT NULL;


--
-- 4.- Eliminación de uno de los datos dentro la semi estructura
-- 

-- Eliminar la clave "ip_publica" del objeto "acceso" en el perfil 1
-- (simulando anonimización de datos por política HABEAS DATA)

UPDATE perfil
SET datos_dispositivo_b = datos_dispositivo_b #- '{acceso, ip_publica}'
WHERE id_perfil = 1;

-- Verificar que la clave fue eliminada

SELECT id_perfil,
       datos_dispositivo_b -> 'acceso' AS datos_acceso
FROM perfil WHERE id_perfil = 1;

-- Eliminar el nodo completo "acceso" del perfil 2

UPDATE perfil
SET datos_dispositivo_b = datos_dispositivo_b - 'acceso'
WHERE id_perfil = 2;

-- Verificar

SELECT id_perfil,
       datos_dispositivo_b
FROM perfil WHERE id_perfil = 2;