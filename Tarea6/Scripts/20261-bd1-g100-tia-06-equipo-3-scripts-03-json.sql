------------------------
------------------------

--
-- Scripts de Manipulación de una dato (campo) JSON
-- Tabla: "perfil" de la Base de Datos  - SGBD PostgreSQL
--

-- Agregue un NUEVO  campo tipo JSON a la tabla “perfil” (otro JSON DIFERENTE al original que creo en la tarea anterior)
-- Proponga un contenido y nombre pertinente y coherente en ese campo; y construya una estructura de dato tipo semi-estructurado
-- Realice cada una de las operaciones con el dato campo creado


--
-- Instrucción "ALTER TABLE" para agregar campo JSON en tabla "perfil"
--

ALTER TABLE perfil
    ADD COLUMN IF NOT EXISTS datos_dispositivo JSON;


--
-- 1.- Inserción del dato semi estructurado en nuevo campo JSON
--

UPDATE perfil
SET datos_dispositivo = '{
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
}'::JSON WHERE id_perfil = 1;

-- Insertar datos de dispositivo para otro perfil
UPDATE perfil
SET datos_dispositivo = '{
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
}'::JSON WHERE id_perfil = 2;


--
-- 2.-- Consulta de los datos del campo 
-- 

2.1 -- Consultar todo el campo JSON

SELECT id_perfil,
       datos_dispositivo FROM perfil WHERE datos_dispositivo IS NOT NULL;

-- 2.2 Consultar solo la marca y modelo del dispositivo

SELECT id_perfil,
       datos_dispositivo -> 'dispositivo' ->> 'marca'  AS marca,
       datos_dispositivo -> 'dispositivo' ->> 'modelo' AS modelo FROM perfil WHERE datos_dispositivo IS NOT NULL;

-- 2.3 Consultar el tipo de conexión y la versión de la app

SELECT id_perfil,
       datos_dispositivo -> 'acceso'      ->> 'tipo_conexion' AS conexion,
       datos_dispositivo -> 'aplicacion'  ->> 'version' AS version_app FROM perfil WHERE datos_dispositivo IS NOT NULL;

-- 2.4 Filtrar perfiles que usan Android

SELECT id_perfil,
       datos_dispositivo -> 'dispositivo' ->> 'sistema_operativo' AS so FROM perfil WHERE datos_dispositivo -> 'dispositivo' ->> 'sistema_operativo' = 'Android';


--
-- 3.- Modificación de uno de los datos dentro la semi estructura
-- 

-- Actualizar la versión de la app en el perfil 1 (simulando una actualización de app)
-- En JSON no existe operador de modificación parcial directo; se reemplaza el objeto completo
-- o se usa jsonb_set (para eso se recomienda JSONB). Con JSON se hace así:

UPDATE perfil
SET datos_dispositivo = (
    datos_dispositivo::JSONB
    || '{"aplicacion": {"nombre": "Red Pascualina", "version": "2.5.0", "idioma": "es-CO"}}'::JSONB
)::JSON WHERE id_perfil = 1;

-- Verificar la modificación
SELECT id_perfil,
       datos_dispositivo -> 'aplicacion' ->> 'version' AS version_app FROM perfil WHERE id_perfil = 1;


--
-- 4.- Eliminación de uno de los datos dentro la semi estructura
-- 

-- Eliminar la clave "ip_publica" del objeto "acceso" en el perfil 1
-- (simulando anonimización de datos por política de privacidad)
UPDATE perfil
SET datos_dispositivo = (
    (datos_dispositivo::JSONB)
    #- '{acceso, ip_publica}'
)::JSON WHERE id_perfil = 1;

-- Verificar que la clave fue eliminada
SELECT id_perfil,
       datos_dispositivo -> 'acceso' AS datos_acceso FROM perfil WHERE id_perfil = 1;
