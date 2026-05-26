--
-- Scripts de RESPALDO de la Base de Datos  - SGBD PostgreSQL
--
-- Todas las instrucciones se DEBEN EJECUTAR EN SECUENCIA SIN ERRORES
-- NOTA: Ojo con los insert en tablas relacionadas. Primero los inserts de tablas independientes y después las dependientes
--

--
-- RESPALDO en ARCHIVO PLANO con extensión de archivo ".sql"
-- SE DEBEN COLOCAR "INSERTS" en este script de respaldo
-- Este script será utilizado por el docente para verificar el funcionamiento de sus consultas con la data propia 
-- de cada equipo. 
--
--
-- PostgreSQL database dump
--

\restrict gvQKdhGKFsaEpheMP3mo7yvOCP8YK5W6O1iuXGBqoLqwPUpKBpozxG1FzhSoc3g

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentarios (
    id_comentario integer NOT NULL,
    id_publicacion integer NOT NULL,
    id_usuario integer NOT NULL,
    texto text NOT NULL,
    fecha_hora_creacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comentarios OWNER TO postgres;

--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentarios_id_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentarios_id_comentario_seq OWNER TO postgres;

--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentarios_id_comentario_seq OWNED BY public.comentarios.id_comentario;


--
-- Name: empresas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresas (
    id_empresa integer NOT NULL,
    nombre_empresa character varying(100) NOT NULL,
    actividad_comercial character varying(100),
    ubicacion character varying(150),
    nit_empresa bigint,
    correo_contacto character varying(100),
    telefono character varying(20)
);


ALTER TABLE public.empresas OWNER TO postgres;

--
-- Name: empresas_id_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresas_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresas_id_empresa_seq OWNER TO postgres;

--
-- Name: empresas_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresas_id_empresa_seq OWNED BY public.empresas.id_empresa;


--
-- Name: evento_usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_usuarios (
    id_inscripcion integer NOT NULL,
    id_evento integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_suscripcion timestamp without time zone DEFAULT now() NOT NULL,
    estado_asistencia character varying(20) DEFAULT 'pendiente'::character varying NOT NULL,
    comentarios text,
    likes integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_evusr_estado CHECK (((estado_asistencia)::text = ANY ((ARRAY['confirmado'::character varying, 'asistio'::character varying, 'no_asistio'::character varying, 'pendiente'::character varying])::text[]))),
    CONSTRAINT chk_evusr_likes CHECK ((likes >= 0))
);


ALTER TABLE public.evento_usuarios OWNER TO postgres;

--
-- Name: evento_usuarios_id_inscripcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_usuarios_id_inscripcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evento_usuarios_id_inscripcion_seq OWNER TO postgres;

--
-- Name: evento_usuarios_id_inscripcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_usuarios_id_inscripcion_seq OWNED BY public.evento_usuarios.id_inscripcion;


--
-- Name: eventos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventos (
    id_evento integer NOT NULL,
    id_creador integer NOT NULL,
    id_tipo_evento integer NOT NULL,
    nombre_evento character varying(100) NOT NULL,
    fecha_hora_inicio timestamp without time zone NOT NULL,
    fecha_hora_fin timestamp without time zone NOT NULL,
    ubicacion character varying(150),
    descripcion text,
    estado character varying(20) DEFAULT 'programado'::character varying NOT NULL,
    CONSTRAINT chk_eventos_estado CHECK (((estado)::text = ANY ((ARRAY['programado'::character varying, 'en_curso'::character varying, 'finalizado'::character varying, 'cancelado'::character varying])::text[]))),
    CONSTRAINT chk_eventos_fechas CHECK ((fecha_hora_fin > fecha_hora_inicio))
);


ALTER TABLE public.eventos OWNER TO postgres;

--
-- Name: eventos_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventos_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eventos_id_evento_seq OWNER TO postgres;

--
-- Name: eventos_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventos_id_evento_seq OWNED BY public.eventos.id_evento;


--
-- Name: grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos (
    id_grupo integer NOT NULL,
    id_administrador integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text,
    tipo_grupo character varying(50) NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT chk_grupos_tipo CHECK (((tipo_grupo)::text = ANY ((ARRAY['mentoria'::character varying, 'proyecto'::character varying, 'egresados'::character varying, 'apoyo_academico'::character varying, 'interes'::character varying])::text[])))
);


ALTER TABLE public.grupos OWNER TO postgres;

--
-- Name: grupos_id_grupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupos_id_grupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grupos_id_grupo_seq OWNER TO postgres;

--
-- Name: grupos_id_grupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupos_id_grupo_seq OWNED BY public.grupos.id_grupo;


--
-- Name: ofertas_laborales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ofertas_laborales (
    id_oferta integer NOT NULL,
    id_empresa integer NOT NULL,
    cargo character varying(50) NOT NULL,
    salario_min numeric(20,0),
    salario_max numeric(20,0),
    requisitos text,
    fecha_apertura date NOT NULL,
    fecha_cierre date NOT NULL,
    estado character varying(20) DEFAULT 'activa'::character varying NOT NULL,
    CONSTRAINT chk_ofl_estado CHECK (((estado)::text = ANY ((ARRAY['activa'::character varying, 'cerrada'::character varying, 'pausada'::character varying])::text[]))),
    CONSTRAINT chk_ofl_fechas CHECK ((fecha_cierre > fecha_apertura)),
    CONSTRAINT chk_ofl_salario CHECK (((salario_max IS NULL) OR (salario_max >= salario_min))),
    CONSTRAINT ofertas_laborales_salario_min_check CHECK ((salario_min >= (0)::numeric))
);


ALTER TABLE public.ofertas_laborales OWNER TO postgres;

--
-- Name: ofertas_laborales_id_oferta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ofertas_laborales_id_oferta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ofertas_laborales_id_oferta_seq OWNER TO postgres;

--
-- Name: ofertas_laborales_id_oferta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ofertas_laborales_id_oferta_seq OWNED BY public.ofertas_laborales.id_oferta;


--
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    id_perfil integer NOT NULL,
    id_usuario integer NOT NULL,
    alias_usuario character varying(50) NOT NULL,
    biografia text,
    foto_url character varying(255),
    semestre_cursado integer,
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_perfil_semestre CHECK (((semestre_cursado >= 1) AND (semestre_cursado <= 12)))
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- Name: perfil_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_id_perfil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perfil_id_perfil_seq OWNER TO postgres;

--
-- Name: perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_id_perfil_seq OWNED BY public.perfil.id_perfil;


--
-- Name: postulaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postulaciones (
    id_postulacion integer NOT NULL,
    id_usuario integer NOT NULL,
    id_oferta integer NOT NULL,
    fecha_postulacion timestamp without time zone DEFAULT now() NOT NULL,
    estado character varying(20) DEFAULT 'en_revision'::character varying NOT NULL,
    carta_presentacion text,
    CONSTRAINT chk_post_estado CHECK (((estado)::text = ANY ((ARRAY['en_revision'::character varying, 'entrevista'::character varying, 'aceptado'::character varying, 'rechazado'::character varying])::text[])))
);


ALTER TABLE public.postulaciones OWNER TO postgres;

--
-- Name: postulaciones_id_postulacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postulaciones_id_postulacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.postulaciones_id_postulacion_seq OWNER TO postgres;

--
-- Name: postulaciones_id_postulacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.postulaciones_id_postulacion_seq OWNED BY public.postulaciones.id_postulacion;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tipo_producto integer NOT NULL,
    titulo character varying(60) NOT NULL,
    descripcion text,
    precio numeric(50,0),
    estado_oferta character varying(20) DEFAULT 'disponible'::character varying NOT NULL,
    fecha_publicacion timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_prod_estado CHECK (((estado_oferta)::text = ANY ((ARRAY['disponible'::character varying, 'en_reserva'::character varying, 'vendido'::character varying])::text[]))),
    CONSTRAINT productos_precio_check CHECK ((precio >= (0)::numeric))
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- Name: productos_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_producto_seq OWNER TO postgres;

--
-- Name: productos_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_producto_seq OWNED BY public.productos.id_producto;


--
-- Name: publicaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicaciones (
    id_publicacion integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_publicacion timestamp without time zone DEFAULT now() NOT NULL,
    texto text,
    tipo_contenido character varying(20) NOT NULL,
    media_url character varying(120),
    CONSTRAINT chk_pub_tipo CHECK (((tipo_contenido)::text = ANY ((ARRAY['texto'::character varying, 'imagen'::character varying, 'enlace'::character varying, 'video'::character varying])::text[])))
);


ALTER TABLE public.publicaciones OWNER TO postgres;

--
-- Name: publicaciones_id_publicacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publicaciones_id_publicacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publicaciones_id_publicacion_seq OWNER TO postgres;

--
-- Name: publicaciones_id_publicacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publicaciones_id_publicacion_seq OWNED BY public.publicaciones.id_publicacion;


--
-- Name: reacciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reacciones (
    id_reaccion integer NOT NULL,
    id_publicacion integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo_reaccion character varying(50) NOT NULL,
    fecha_reaccion timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_reac_tipo CHECK (((tipo_reaccion)::text = ANY ((ARRAY['me_gusta'::character varying, 'me_encanta'::character varying, 'me_divierte'::character varying, 'me_sorprende'::character varying, 'me_entristece'::character varying])::text[])))
);


ALTER TABLE public.reacciones OWNER TO postgres;

--
-- Name: reacciones_id_reaccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reacciones_id_reaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reacciones_id_reaccion_seq OWNER TO postgres;

--
-- Name: reacciones_id_reaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reacciones_id_reaccion_seq OWNED BY public.reacciones.id_reaccion;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_rol integer NOT NULL,
    nombre_rol character varying(30) NOT NULL,
    descripcion text,
    CONSTRAINT chk_roles_nombre CHECK (((nombre_rol)::text = ANY ((ARRAY['administrador'::character varying, 'auxiliar'::character varying, 'miembro'::character varying, 'visitante'::character varying])::text[])))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_rol_seq OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_rol_seq OWNED BY public.roles.id_rol;


--
-- Name: seguidores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seguidores (
    id_seguidor integer NOT NULL,
    id_usuario_seguidor integer NOT NULL,
    id_usuario_seguido integer NOT NULL,
    fecha_seguimiento timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_seg_no_self CHECK ((id_usuario_seguidor <> id_usuario_seguido))
);


ALTER TABLE public.seguidores OWNER TO postgres;

--
-- Name: seguidores_id_seguidor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seguidores_id_seguidor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seguidores_id_seguidor_seq OWNER TO postgres;

--
-- Name: seguidores_id_seguidor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seguidores_id_seguidor_seq OWNED BY public.seguidores.id_seguidor;


--
-- Name: servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicios (
    id_servicio integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tipo_servicio integer NOT NULL,
    titulo character varying(50) NOT NULL,
    descripcion text,
    precio_referencia numeric(20,0),
    estado_oferta character varying(20) DEFAULT 'disponible'::character varying NOT NULL,
    fecha_publicacion timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_serv_estado CHECK (((estado_oferta)::text = ANY ((ARRAY['disponible'::character varying, 'en_reserva'::character varying, 'no_disponible'::character varying])::text[]))),
    CONSTRAINT servicios_precio_referencia_check CHECK ((precio_referencia >= (0)::numeric))
);


ALTER TABLE public.servicios OWNER TO postgres;

--
-- Name: servicios_id_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicios_id_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicios_id_servicio_seq OWNER TO postgres;

--
-- Name: servicios_id_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicios_id_servicio_seq OWNED BY public.servicios.id_servicio;


--
-- Name: tipos_evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_evento (
    id_tipo_evento integer NOT NULL,
    nombre_tipo character varying(60) NOT NULL,
    id_creador_admin integer
);


ALTER TABLE public.tipos_evento OWNER TO postgres;

--
-- Name: tipos_evento_id_tipo_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_evento_id_tipo_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_evento_id_tipo_evento_seq OWNER TO postgres;

--
-- Name: tipos_evento_id_tipo_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_evento_id_tipo_evento_seq OWNED BY public.tipos_evento.id_tipo_evento;


--
-- Name: tipos_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_producto (
    id_tipo_producto integer NOT NULL,
    nombre_tipo character varying(60) NOT NULL,
    id_creador_admin integer
);


ALTER TABLE public.tipos_producto OWNER TO postgres;

--
-- Name: tipos_producto_id_tipo_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_producto_id_tipo_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_producto_id_tipo_producto_seq OWNER TO postgres;

--
-- Name: tipos_producto_id_tipo_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_producto_id_tipo_producto_seq OWNED BY public.tipos_producto.id_tipo_producto;


--
-- Name: tipos_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_servicio (
    id_tipo_servicio integer NOT NULL,
    nombre_tipo character varying(60) NOT NULL,
    id_creador_admin integer
);


ALTER TABLE public.tipos_servicio OWNER TO postgres;

--
-- Name: tipos_servicio_id_tipo_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_servicio_id_tipo_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_servicio_id_tipo_servicio_seq OWNER TO postgres;

--
-- Name: tipos_servicio_id_tipo_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_servicio_id_tipo_servicio_seq OWNED BY public.tipos_servicio.id_tipo_servicio;


--
-- Name: tipos_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_usuario (
    id_tipo_usuario integer NOT NULL,
    nombre_tipo character varying(50) NOT NULL,
    descripcion text,
    id_creador_admin integer
);


ALTER TABLE public.tipos_usuario OWNER TO postgres;

--
-- Name: tipos_usuario_id_tipo_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_usuario_id_tipo_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipos_usuario_id_tipo_usuario_seq OWNER TO postgres;

--
-- Name: tipos_usuario_id_tipo_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_usuario_id_tipo_usuario_seq OWNED BY public.tipos_usuario.id_tipo_usuario;


--
-- Name: transacciones_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacciones_servicio (
    id_transaccion integer NOT NULL,
    id_servicio integer NOT NULL,
    id_usuario_cliente integer NOT NULL,
    fecha_transaccion timestamp without time zone DEFAULT now() NOT NULL,
    estado_transaccion character varying(20) DEFAULT 'solicitado'::character varying NOT NULL,
    notas text,
    CONSTRAINT chk_trans_estado CHECK (((estado_transaccion)::text = ANY ((ARRAY['solicitado'::character varying, 'en_proceso'::character varying, 'completado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.transacciones_servicio OWNER TO postgres;

--
-- Name: transacciones_servicio_id_transaccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transacciones_servicio_id_transaccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transacciones_servicio_id_transaccion_seq OWNER TO postgres;

--
-- Name: transacciones_servicio_id_transaccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transacciones_servicio_id_transaccion_seq OWNED BY public.transacciones_servicio.id_transaccion;


--
-- Name: usuario_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_grupo (
    id_membresia integer NOT NULL,
    id_usuario integer NOT NULL,
    id_grupo integer NOT NULL,
    fecha_ingreso timestamp without time zone DEFAULT now() NOT NULL,
    rol_en_grupo character varying(20) DEFAULT 'miembro'::character varying NOT NULL,
    CONSTRAINT chk_ugr_rol CHECK (((rol_en_grupo)::text = ANY ((ARRAY['moderador'::character varying, 'miembro'::character varying])::text[])))
);


ALTER TABLE public.usuario_grupo OWNER TO postgres;

--
-- Name: usuario_grupo_id_membresia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_grupo_id_membresia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_grupo_id_membresia_seq OWNER TO postgres;

--
-- Name: usuario_grupo_id_membresia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_grupo_id_membresia_seq OWNED BY public.usuario_grupo.id_membresia;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    id_tipo_usuario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    correo character varying(70) NOT NULL,
    telefono character varying(20),
    fecha_nacimiento date,
    sexo character varying(15),
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_usuarios_sexo CHECK (((sexo)::text = ANY ((ARRAY['masculino'::character varying, 'femenino'::character varying, 'otro'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- Name: comentarios id_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios ALTER COLUMN id_comentario SET DEFAULT nextval('public.comentarios_id_comentario_seq'::regclass);


--
-- Name: empresas id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresas ALTER COLUMN id_empresa SET DEFAULT nextval('public.empresas_id_empresa_seq'::regclass);


--
-- Name: evento_usuarios id_inscripcion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_usuarios ALTER COLUMN id_inscripcion SET DEFAULT nextval('public.evento_usuarios_id_inscripcion_seq'::regclass);


--
-- Name: eventos id_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos ALTER COLUMN id_evento SET DEFAULT nextval('public.eventos_id_evento_seq'::regclass);


--
-- Name: grupos id_grupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos ALTER COLUMN id_grupo SET DEFAULT nextval('public.grupos_id_grupo_seq'::regclass);


--
-- Name: ofertas_laborales id_oferta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_laborales ALTER COLUMN id_oferta SET DEFAULT nextval('public.ofertas_laborales_id_oferta_seq'::regclass);


--
-- Name: perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.perfil_id_perfil_seq'::regclass);


--
-- Name: postulaciones id_postulacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones ALTER COLUMN id_postulacion SET DEFAULT nextval('public.postulaciones_id_postulacion_seq'::regclass);


--
-- Name: productos id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_id_producto_seq'::regclass);


--
-- Name: publicaciones id_publicacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones ALTER COLUMN id_publicacion SET DEFAULT nextval('public.publicaciones_id_publicacion_seq'::regclass);


--
-- Name: reacciones id_reaccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones ALTER COLUMN id_reaccion SET DEFAULT nextval('public.reacciones_id_reaccion_seq'::regclass);


--
-- Name: roles id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_id_rol_seq'::regclass);


--
-- Name: seguidores id_seguidor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores ALTER COLUMN id_seguidor SET DEFAULT nextval('public.seguidores_id_seguidor_seq'::regclass);


--
-- Name: servicios id_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios ALTER COLUMN id_servicio SET DEFAULT nextval('public.servicios_id_servicio_seq'::regclass);


--
-- Name: tipos_evento id_tipo_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_evento ALTER COLUMN id_tipo_evento SET DEFAULT nextval('public.tipos_evento_id_tipo_evento_seq'::regclass);


--
-- Name: tipos_producto id_tipo_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_producto ALTER COLUMN id_tipo_producto SET DEFAULT nextval('public.tipos_producto_id_tipo_producto_seq'::regclass);


--
-- Name: tipos_servicio id_tipo_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_servicio ALTER COLUMN id_tipo_servicio SET DEFAULT nextval('public.tipos_servicio_id_tipo_servicio_seq'::regclass);


--
-- Name: tipos_usuario id_tipo_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_usuario ALTER COLUMN id_tipo_usuario SET DEFAULT nextval('public.tipos_usuario_id_tipo_usuario_seq'::regclass);


--
-- Name: transacciones_servicio id_transaccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_servicio ALTER COLUMN id_transaccion SET DEFAULT nextval('public.transacciones_servicio_id_transaccion_seq'::regclass);


--
-- Name: usuario_grupo id_membresia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo ALTER COLUMN id_membresia SET DEFAULT nextval('public.usuario_grupo_id_membresia_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- Data for Name: comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comentarios VALUES (1, 27, 283, 'Me alegra saber que hay apoyo académico disponible. Lo necesitaba.', '2026-05-11 05:01:38');
INSERT INTO public.comentarios VALUES (2, 6, 492, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-05-19 17:51:12');
INSERT INTO public.comentarios VALUES (3, 1, 251, 'Me alegra saber que hay apoyo académico disponible. Lo necesitaba.', '2026-01-07 11:13:18');
INSERT INTO public.comentarios VALUES (4, 74, 219, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-04-24 16:08:53');
INSERT INTO public.comentarios VALUES (5, 59, 152, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-01-29 22:45:58');
INSERT INTO public.comentarios VALUES (6, 16, 228, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-04-21 15:16:05');
INSERT INTO public.comentarios VALUES (7, 18, 143, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-01-30 11:51:05');
INSERT INTO public.comentarios VALUES (8, 96, 407, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-20 10:10:32');
INSERT INTO public.comentarios VALUES (9, 43, 142, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-05-12 21:49:04');
INSERT INTO public.comentarios VALUES (10, 91, 353, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-01-10 13:06:59');
INSERT INTO public.comentarios VALUES (11, 91, 407, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-03-23 06:53:35');
INSERT INTO public.comentarios VALUES (12, 85, 429, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-01-10 20:40:00');
INSERT INTO public.comentarios VALUES (13, 32, 71, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-04-07 07:43:12');
INSERT INTO public.comentarios VALUES (14, 34, 241, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-05-05 05:46:31');
INSERT INTO public.comentarios VALUES (15, 37, 68, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-23 16:54:46');
INSERT INTO public.comentarios VALUES (16, 96, 110, 'Gracias por compartir, me fue muy útil esta información.', '2026-04-22 02:31:35');
INSERT INTO public.comentarios VALUES (17, 79, 107, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-02-15 01:26:44');
INSERT INTO public.comentarios VALUES (18, 34, 315, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-03-02 20:22:30');
INSERT INTO public.comentarios VALUES (19, 68, 337, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-03-18 07:56:18');
INSERT INTO public.comentarios VALUES (20, 86, 249, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-04-11 19:22:34');
INSERT INTO public.comentarios VALUES (21, 62, 152, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-02-26 03:56:57');
INSERT INTO public.comentarios VALUES (22, 97, 392, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-04-18 14:20:15');
INSERT INTO public.comentarios VALUES (23, 85, 218, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-02-15 14:20:42');
INSERT INTO public.comentarios VALUES (24, 15, 178, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-04-12 22:08:49');
INSERT INTO public.comentarios VALUES (25, 62, 431, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-05-06 19:26:43');
INSERT INTO public.comentarios VALUES (26, 31, 15, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-03-10 16:13:56');
INSERT INTO public.comentarios VALUES (27, 53, 32, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-03-24 08:43:20');
INSERT INTO public.comentarios VALUES (28, 53, 201, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-04-24 13:25:16');
INSERT INTO public.comentarios VALUES (29, 7, 138, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-02-26 10:40:52');
INSERT INTO public.comentarios VALUES (30, 6, 158, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-04-15 07:36:56');
INSERT INTO public.comentarios VALUES (31, 22, 275, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-29 19:39:21');
INSERT INTO public.comentarios VALUES (32, 17, 310, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-01-06 23:01:51');
INSERT INTO public.comentarios VALUES (33, 49, 47, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-03-27 11:49:49');
INSERT INTO public.comentarios VALUES (34, 71, 33, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-01-13 16:13:23');
INSERT INTO public.comentarios VALUES (35, 69, 102, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-05-18 12:55:45');
INSERT INTO public.comentarios VALUES (36, 30, 149, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-02-11 11:21:26');
INSERT INTO public.comentarios VALUES (37, 28, 284, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-03-05 00:02:54');
INSERT INTO public.comentarios VALUES (38, 3, 387, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-01-27 16:25:50');
INSERT INTO public.comentarios VALUES (39, 63, 22, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-03-14 09:01:14');
INSERT INTO public.comentarios VALUES (40, 81, 396, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-03-05 01:17:47');
INSERT INTO public.comentarios VALUES (41, 16, 417, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-04-07 20:25:08');
INSERT INTO public.comentarios VALUES (42, 95, 449, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-01-22 02:04:32');
INSERT INTO public.comentarios VALUES (43, 93, 361, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-04-17 00:00:47');
INSERT INTO public.comentarios VALUES (44, 70, 310, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-02-08 03:47:37');
INSERT INTO public.comentarios VALUES (45, 51, 100, 'Me alegra saber que hay apoyo académico disponible. Lo necesitaba.', '2026-03-21 10:27:32');
INSERT INTO public.comentarios VALUES (46, 96, 12, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-03-12 14:12:06');
INSERT INTO public.comentarios VALUES (47, 34, 497, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-05-01 12:18:27');
INSERT INTO public.comentarios VALUES (48, 12, 114, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-03-13 15:18:58');
INSERT INTO public.comentarios VALUES (49, 90, 274, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-03-04 12:01:31');
INSERT INTO public.comentarios VALUES (50, 94, 202, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-05-20 22:06:28');
INSERT INTO public.comentarios VALUES (51, 29, 296, 'Gracias por compartir, me fue muy útil esta información.', '2026-04-12 07:28:23');
INSERT INTO public.comentarios VALUES (52, 62, 289, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-03-21 10:09:51');
INSERT INTO public.comentarios VALUES (53, 81, 500, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-01-25 17:10:13');
INSERT INTO public.comentarios VALUES (54, 63, 304, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-22 04:25:39');
INSERT INTO public.comentarios VALUES (55, 61, 268, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-03-01 01:49:31');
INSERT INTO public.comentarios VALUES (56, 33, 211, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-03-28 04:02:20');
INSERT INTO public.comentarios VALUES (57, 89, 290, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-04-15 00:17:44');
INSERT INTO public.comentarios VALUES (58, 27, 387, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-05-06 17:31:20');
INSERT INTO public.comentarios VALUES (59, 84, 121, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-04-29 22:30:32');
INSERT INTO public.comentarios VALUES (60, 72, 440, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-01-21 03:27:44');
INSERT INTO public.comentarios VALUES (61, 10, 193, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-01-04 05:33:47');
INSERT INTO public.comentarios VALUES (62, 16, 86, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-04-23 03:02:56');
INSERT INTO public.comentarios VALUES (63, 55, 254, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-05-15 15:08:47');
INSERT INTO public.comentarios VALUES (64, 71, 215, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-01-03 09:07:27');
INSERT INTO public.comentarios VALUES (65, 38, 369, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-03-11 16:20:39');
INSERT INTO public.comentarios VALUES (66, 48, 289, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-02-12 04:18:33');
INSERT INTO public.comentarios VALUES (67, 88, 105, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-04-06 16:38:16');
INSERT INTO public.comentarios VALUES (68, 61, 237, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-03-26 23:46:54');
INSERT INTO public.comentarios VALUES (69, 18, 85, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-05-02 00:20:26');
INSERT INTO public.comentarios VALUES (70, 23, 77, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-01-18 00:19:44');
INSERT INTO public.comentarios VALUES (71, 25, 103, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-01-25 17:29:21');
INSERT INTO public.comentarios VALUES (72, 13, 32, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-04-30 19:10:04');
INSERT INTO public.comentarios VALUES (73, 45, 326, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-02-27 11:40:00');
INSERT INTO public.comentarios VALUES (74, 25, 141, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-04-20 18:46:19');
INSERT INTO public.comentarios VALUES (75, 48, 320, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-04-14 08:35:34');
INSERT INTO public.comentarios VALUES (76, 83, 338, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-20 18:09:06');
INSERT INTO public.comentarios VALUES (77, 94, 111, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-02-15 08:36:06');
INSERT INTO public.comentarios VALUES (78, 17, 409, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-04-09 10:36:49');
INSERT INTO public.comentarios VALUES (79, 76, 310, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-05-02 06:10:00');
INSERT INTO public.comentarios VALUES (80, 30, 111, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-02-07 04:10:30');
INSERT INTO public.comentarios VALUES (81, 1, 166, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-01-14 04:32:51');
INSERT INTO public.comentarios VALUES (82, 57, 218, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-05-01 10:19:32');
INSERT INTO public.comentarios VALUES (83, 98, 61, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-04-11 12:49:24');
INSERT INTO public.comentarios VALUES (84, 91, 243, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-03-21 16:20:33');
INSERT INTO public.comentarios VALUES (85, 11, 453, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-02-24 05:40:53');
INSERT INTO public.comentarios VALUES (86, 36, 365, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-04-22 17:28:31');
INSERT INTO public.comentarios VALUES (87, 89, 404, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-01-31 17:57:27');
INSERT INTO public.comentarios VALUES (88, 84, 179, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-01-07 11:54:29');
INSERT INTO public.comentarios VALUES (89, 99, 344, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-04-19 06:39:35');
INSERT INTO public.comentarios VALUES (90, 25, 196, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-02-15 23:00:12');
INSERT INTO public.comentarios VALUES (91, 57, 185, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-02-19 00:37:19');
INSERT INTO public.comentarios VALUES (92, 43, 49, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-04-05 08:32:58');
INSERT INTO public.comentarios VALUES (93, 2, 311, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-01-09 20:17:41');
INSERT INTO public.comentarios VALUES (94, 62, 204, 'Gracias por compartir, me fue muy útil esta información.', '2026-03-06 08:40:03');
INSERT INTO public.comentarios VALUES (95, 74, 422, 'Gracias por compartir, me fue muy útil esta información.', '2026-05-01 19:40:29');
INSERT INTO public.comentarios VALUES (96, 63, 89, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-05-20 03:02:23');
INSERT INTO public.comentarios VALUES (97, 4, 314, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-02-09 22:47:11');
INSERT INTO public.comentarios VALUES (98, 17, 43, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-01-31 01:28:40');
INSERT INTO public.comentarios VALUES (99, 91, 32, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-01-25 17:17:54');
INSERT INTO public.comentarios VALUES (100, 25, 336, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-01-05 10:53:43');
INSERT INTO public.comentarios VALUES (101, 41, 460, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-02-13 18:46:23');
INSERT INTO public.comentarios VALUES (102, 67, 8, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-04-14 13:53:42');
INSERT INTO public.comentarios VALUES (103, 86, 32, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-02-19 16:09:46');
INSERT INTO public.comentarios VALUES (104, 35, 43, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-04-24 01:17:38');
INSERT INTO public.comentarios VALUES (105, 26, 353, 'Gracias al equipo organizador por el esfuerzo, se nota la dedicación.', '2026-04-15 05:40:47');
INSERT INTO public.comentarios VALUES (106, 1, 160, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-03-31 03:21:29');
INSERT INTO public.comentarios VALUES (107, 73, 429, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-01-23 18:59:29');
INSERT INTO public.comentarios VALUES (108, 12, 60, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-01-24 05:46:05');
INSERT INTO public.comentarios VALUES (109, 24, 163, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-01-06 05:50:00');
INSERT INTO public.comentarios VALUES (110, 28, 327, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-04-28 02:56:46');
INSERT INTO public.comentarios VALUES (111, 32, 158, 'Me alegra saber que hay apoyo académico disponible. Lo necesitaba.', '2026-02-18 23:48:47');
INSERT INTO public.comentarios VALUES (112, 17, 159, 'Gracias por compartir, me fue muy útil esta información.', '2026-04-08 22:18:11');
INSERT INTO public.comentarios VALUES (113, 36, 72, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-03-22 13:14:53');
INSERT INTO public.comentarios VALUES (114, 25, 140, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-02-21 05:18:16');
INSERT INTO public.comentarios VALUES (115, 90, 226, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-01-24 15:22:37');
INSERT INTO public.comentarios VALUES (116, 47, 179, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-05-14 14:53:40');
INSERT INTO public.comentarios VALUES (117, 88, 426, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-01-10 18:24:09');
INSERT INTO public.comentarios VALUES (118, 69, 292, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-04-22 11:41:51');
INSERT INTO public.comentarios VALUES (119, 88, 408, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-02-23 10:44:32');
INSERT INTO public.comentarios VALUES (120, 71, 425, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-03-10 02:32:49');
INSERT INTO public.comentarios VALUES (121, 27, 133, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-04-30 08:02:59');
INSERT INTO public.comentarios VALUES (122, 15, 265, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-02-17 15:08:29');
INSERT INTO public.comentarios VALUES (123, 76, 166, 'Interesante reflexión. En mi carrera también notamos eso constantemente.', '2026-04-07 21:37:57');
INSERT INTO public.comentarios VALUES (124, 5, 166, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-01-27 20:22:55');
INSERT INTO public.comentarios VALUES (125, 2, 82, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-05-02 10:21:41');
INSERT INTO public.comentarios VALUES (126, 13, 96, 'El hackathon de este año estuvo increíble. Muy buen nivel de los participantes.', '2026-04-02 09:10:29');
INSERT INTO public.comentarios VALUES (127, 70, 96, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-01-06 14:51:39');
INSERT INTO public.comentarios VALUES (128, 59, 304, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-04-22 23:25:30');
INSERT INTO public.comentarios VALUES (129, 32, 130, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-04-06 19:21:30');
INSERT INTO public.comentarios VALUES (130, 87, 206, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-01-11 07:48:59');
INSERT INTO public.comentarios VALUES (131, 65, 56, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-04-20 08:36:25');
INSERT INTO public.comentarios VALUES (132, 76, 15, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-05-12 05:59:19');
INSERT INTO public.comentarios VALUES (133, 77, 495, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-05-15 06:36:48');
INSERT INTO public.comentarios VALUES (134, 18, 67, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-03-27 01:05:19');
INSERT INTO public.comentarios VALUES (135, 99, 73, 'Totalmente de acuerdo con lo que planteas en tu publicación.', '2026-03-30 14:25:10');
INSERT INTO public.comentarios VALUES (136, 59, 1, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-02-07 06:56:11');
INSERT INTO public.comentarios VALUES (137, 39, 158, 'Totalmente de acuerdo, el evento fue excelente y muy bien organizado.', '2026-02-17 07:54:13');
INSERT INTO public.comentarios VALUES (138, 56, 47, 'Qué orgullo ver el nivel de los proyectos en la expo de grado.', '2026-03-04 04:43:35');
INSERT INTO public.comentarios VALUES (139, 100, 192, 'Gracias por compartir, me fue muy útil esta información.', '2026-05-03 05:22:06');
INSERT INTO public.comentarios VALUES (140, 61, 282, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-04-11 22:13:58');
INSERT INTO public.comentarios VALUES (141, 61, 343, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-04-29 22:15:48');
INSERT INTO public.comentarios VALUES (142, 13, 199, '¿Alguien sabe si quedó grabación del taller? No pude asistir.', '2026-03-23 04:25:49');
INSERT INTO public.comentarios VALUES (143, 42, 460, 'Comparto el sentimiento, la institución hace un gran trabajo con estos espacios.', '2026-04-19 19:25:34');
INSERT INTO public.comentarios VALUES (144, 10, 178, 'El ponente estuvo muy bueno, explicó todo de manera muy clara.', '2026-01-07 07:56:38');
INSERT INTO public.comentarios VALUES (145, 23, 394, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-04-05 11:21:32');
INSERT INTO public.comentarios VALUES (146, 1, 313, 'Me parece importante visibilizar estos temas en el ambiente universitario.', '2026-04-12 02:41:14');
INSERT INTO public.comentarios VALUES (147, 18, 256, 'Yo participé y fue una experiencia transformadora. Lo recomiendo.', '2026-01-12 06:19:27');
INSERT INTO public.comentarios VALUES (148, 12, 174, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-02-16 13:09:18');
INSERT INTO public.comentarios VALUES (149, 40, 199, 'Busco información sobre los grupos de estudio mencionados aquí.', '2026-05-04 01:16:26');
INSERT INTO public.comentarios VALUES (150, 23, 84, '¿Cuándo abren las inscripciones para la siguiente edición?', '2026-05-13 03:29:51');


--
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: evento_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.evento_usuarios VALUES (1, 48, 495, '2026-04-19 21:20:58', 'pendiente', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (2, 17, 213, '2026-01-24 15:56:21', 'pendiente', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (3, 16, 263, '2026-05-07 08:58:12', 'pendiente', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (4, 50, 5, '2026-04-03 22:21:51', 'asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (5, 7, 248, '2026-05-09 06:13:09', 'asistio', 'Muy buen espacio de networking.', 8);
INSERT INTO public.evento_usuarios VALUES (6, 26, 456, '2026-05-16 18:39:59', 'pendiente', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (7, 30, 494, '2026-05-21 09:34:48', 'no_asistio', 'Excelente evento, muy bien organizado.', 4);
INSERT INTO public.evento_usuarios VALUES (8, 22, 10, '2026-04-15 18:40:50', 'confirmado', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (9, 30, 469, '2026-03-01 10:53:37', 'pendiente', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (10, 20, 457, '2026-01-10 07:42:57', 'asistio', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (11, 1, 272, '2026-02-28 01:14:52', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (12, 1, 221, '2026-01-13 02:51:51', 'asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (13, 33, 445, '2026-03-20 19:42:03', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (14, 43, 283, '2026-03-15 03:54:15', 'no_asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (15, 35, 336, '2026-02-21 00:43:27', 'confirmado', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (16, 16, 485, '2026-05-03 00:06:08', 'asistio', 'El ponente fue muy claro y dinámico.', 10);
INSERT INTO public.evento_usuarios VALUES (17, 19, 344, '2026-03-07 13:10:57', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 2);
INSERT INTO public.evento_usuarios VALUES (18, 24, 50, '2026-03-15 09:34:44', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 2);
INSERT INTO public.evento_usuarios VALUES (19, 8, 437, '2026-01-01 07:04:49', 'asistio', 'El ponente fue muy claro y dinámico.', 1);
INSERT INTO public.evento_usuarios VALUES (20, 49, 232, '2026-03-28 03:32:49', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (21, 43, 315, '2026-03-13 02:22:50', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (22, 25, 413, '2026-02-18 17:16:46', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 1);
INSERT INTO public.evento_usuarios VALUES (23, 11, 75, '2026-03-29 05:33:52', 'pendiente', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (24, 23, 16, '2026-03-29 12:50:48', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (25, 50, 416, '2026-04-14 06:10:12', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (26, 43, 479, '2026-05-07 17:49:29', 'no_asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (27, 24, 102, '2026-01-11 01:28:12', 'confirmado', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (28, 24, 333, '2026-03-28 13:47:53', 'confirmado', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (29, 6, 69, '2026-01-25 19:33:35', 'confirmado', 'El ponente fue muy claro y dinámico.', 7);
INSERT INTO public.evento_usuarios VALUES (30, 32, 284, '2026-03-29 03:39:51', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (31, 20, 275, '2026-04-19 09:02:54', 'confirmado', 'Excelente evento, muy bien organizado.', 4);
INSERT INTO public.evento_usuarios VALUES (32, 43, 494, '2026-02-05 22:16:52', 'no_asistio', 'El ponente fue muy claro y dinámico.', 4);
INSERT INTO public.evento_usuarios VALUES (33, 22, 436, '2026-04-16 02:33:23', 'confirmado', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (34, 48, 154, '2026-04-15 00:01:18', 'asistio', 'El ponente fue muy claro y dinámico.', 1);
INSERT INTO public.evento_usuarios VALUES (35, 9, 477, '2026-05-15 19:38:54', 'confirmado', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (36, 7, 500, '2026-03-09 10:20:56', 'confirmado', 'El ponente fue muy claro y dinámico.', 9);
INSERT INTO public.evento_usuarios VALUES (37, 14, 299, '2026-01-21 07:03:17', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (38, 37, 446, '2026-05-20 09:58:35', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 6);
INSERT INTO public.evento_usuarios VALUES (39, 49, 477, '2026-01-11 09:58:56', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 10);
INSERT INTO public.evento_usuarios VALUES (40, 22, 138, '2026-01-14 04:04:06', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (41, 3, 241, '2026-04-03 12:34:06', 'asistio', 'El ponente fue muy claro y dinámico.', 9);
INSERT INTO public.evento_usuarios VALUES (42, 36, 459, '2026-03-05 02:21:10', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 10);
INSERT INTO public.evento_usuarios VALUES (43, 2, 241, '2026-02-25 23:45:08', 'pendiente', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (44, 1, 349, '2026-05-14 08:36:50', 'pendiente', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (45, 16, 31, '2026-04-21 06:39:42', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (46, 19, 177, '2026-02-04 12:37:26', 'asistio', 'Muy buen espacio de networking.', 3);
INSERT INTO public.evento_usuarios VALUES (47, 40, 439, '2026-02-01 22:26:16', 'no_asistio', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (48, 26, 303, '2026-02-18 23:16:44', 'pendiente', 'El ponente fue muy claro y dinámico.', 10);
INSERT INTO public.evento_usuarios VALUES (49, 38, 62, '2026-03-05 04:45:02', 'pendiente', 'Me encantó la actividad, la recomiendo.', 0);
INSERT INTO public.evento_usuarios VALUES (50, 47, 37, '2026-04-12 04:13:17', 'confirmado', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (51, 14, 368, '2026-01-29 22:00:26', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (52, 29, 74, '2026-02-07 23:41:50', 'confirmado', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (53, 27, 194, '2026-05-13 21:17:28', 'pendiente', 'El ponente fue muy claro y dinámico.', 3);
INSERT INTO public.evento_usuarios VALUES (54, 25, 181, '2026-02-18 21:54:42', 'pendiente', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (55, 18, 224, '2026-01-13 08:00:27', 'no_asistio', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (56, 4, 384, '2026-04-28 16:18:13', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 4);
INSERT INTO public.evento_usuarios VALUES (57, 10, 146, '2026-03-13 05:27:49', 'confirmado', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (58, 5, 301, '2026-04-27 11:19:41', 'pendiente', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (59, 45, 443, '2026-03-12 15:24:17', 'pendiente', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (60, 29, 464, '2026-02-04 00:49:15', 'no_asistio', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (61, 36, 261, '2026-02-07 03:17:46', 'asistio', 'Muy buen espacio de networking.', 1);
INSERT INTO public.evento_usuarios VALUES (62, 18, 442, '2026-05-13 09:47:25', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 9);
INSERT INTO public.evento_usuarios VALUES (63, 7, 124, '2026-03-14 08:51:15', 'pendiente', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (64, 1, 77, '2026-01-06 10:49:44', 'no_asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (65, 31, 100, '2026-02-17 03:46:19', 'no_asistio', 'Muy buen espacio de networking.', 4);
INSERT INTO public.evento_usuarios VALUES (66, 38, 103, '2026-04-13 21:53:38', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 6);
INSERT INTO public.evento_usuarios VALUES (67, 31, 320, '2026-02-20 07:20:02', 'asistio', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (68, 49, 124, '2026-05-17 10:31:14', 'no_asistio', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (69, 7, 290, '2026-02-05 07:26:55', 'confirmado', 'Me encantó la actividad, la recomiendo.', 7);
INSERT INTO public.evento_usuarios VALUES (70, 27, 274, '2026-01-19 03:43:35', 'no_asistio', 'El ponente fue muy claro y dinámico.', 3);
INSERT INTO public.evento_usuarios VALUES (71, 48, 110, '2026-02-25 11:06:02', 'asistio', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (72, 27, 62, '2026-03-13 20:37:56', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (73, 22, 473, '2026-03-02 19:07:05', 'asistio', 'Me encantó la actividad, la recomiendo.', 0);
INSERT INTO public.evento_usuarios VALUES (74, 31, 353, '2026-03-12 17:10:42', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (75, 27, 455, '2026-03-26 03:05:32', 'pendiente', 'Muy buen espacio de networking.', 0);
INSERT INTO public.evento_usuarios VALUES (76, 28, 357, '2026-03-31 11:48:28', 'pendiente', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (77, 41, 293, '2026-01-06 21:17:12', 'pendiente', 'El ponente fue muy claro y dinámico.', 3);
INSERT INTO public.evento_usuarios VALUES (78, 48, 24, '2026-02-15 06:52:13', 'pendiente', 'El ponente fue muy claro y dinámico.', 4);
INSERT INTO public.evento_usuarios VALUES (79, 30, 32, '2026-04-26 07:39:08', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (80, 24, 322, '2026-03-18 21:27:09', 'confirmado', 'El ponente fue muy claro y dinámico.', 7);
INSERT INTO public.evento_usuarios VALUES (81, 25, 4, '2026-02-13 11:02:34', 'pendiente', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (82, 6, 392, '2026-02-10 06:04:09', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 6);
INSERT INTO public.evento_usuarios VALUES (83, 15, 359, '2026-02-12 08:45:33', 'asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (84, 39, 273, '2026-02-25 14:27:11', 'no_asistio', 'Muy buen espacio de networking.', 5);
INSERT INTO public.evento_usuarios VALUES (85, 17, 311, '2026-02-24 23:51:49', 'confirmado', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (86, 19, 193, '2026-05-18 14:59:05', 'confirmado', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (87, 15, 378, '2026-05-17 03:35:30', 'no_asistio', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (88, 34, 93, '2026-05-18 07:51:08', 'pendiente', 'Excelente evento, muy bien organizado.', 8);
INSERT INTO public.evento_usuarios VALUES (89, 39, 279, '2026-01-19 07:34:35', 'confirmado', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (90, 35, 48, '2026-03-08 08:21:35', 'pendiente', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (91, 28, 252, '2026-02-22 04:51:50', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (92, 10, 320, '2026-04-24 02:27:46', 'confirmado', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (93, 11, 349, '2026-03-12 10:01:02', 'confirmado', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (94, 45, 13, '2026-01-08 02:20:10', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (95, 31, 488, '2026-01-26 14:50:57', 'asistio', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (96, 48, 496, '2026-01-07 23:09:22', 'asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (97, 8, 407, '2026-05-10 20:18:48', 'asistio', 'Muy buen espacio de networking.', 2);
INSERT INTO public.evento_usuarios VALUES (98, 6, 280, '2026-02-07 19:42:36', 'no_asistio', 'Muy buen espacio de networking.', 7);
INSERT INTO public.evento_usuarios VALUES (99, 34, 467, '2026-01-20 04:11:52', 'asistio', 'Excelente evento, muy bien organizado.', 5);
INSERT INTO public.evento_usuarios VALUES (100, 25, 241, '2026-01-11 16:27:29', 'confirmado', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (101, 4, 2, '2026-03-08 07:24:22', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 5);
INSERT INTO public.evento_usuarios VALUES (102, 47, 265, '2026-03-12 16:09:25', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (103, 27, 77, '2026-03-10 16:14:20', 'asistio', 'Excelente evento, muy bien organizado.', 5);
INSERT INTO public.evento_usuarios VALUES (104, 20, 421, '2026-02-13 18:24:46', 'confirmado', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (105, 31, 28, '2026-04-15 06:15:26', 'no_asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (106, 50, 320, '2026-05-15 05:08:04', 'confirmado', 'Muy buen espacio de networking.', 0);
INSERT INTO public.evento_usuarios VALUES (107, 8, 444, '2026-04-11 08:53:33', 'confirmado', 'Excelente evento, muy bien organizado.', 4);
INSERT INTO public.evento_usuarios VALUES (108, 41, 376, '2026-03-08 20:11:35', 'no_asistio', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (109, 34, 100, '2026-04-07 22:48:12', 'confirmado', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (110, 16, 80, '2026-01-17 04:44:25', 'asistio', 'El ponente fue muy claro y dinámico.', 8);
INSERT INTO public.evento_usuarios VALUES (111, 37, 331, '2026-03-20 13:19:10', 'confirmado', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (112, 49, 368, '2026-02-03 11:46:46', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (113, 20, 492, '2026-03-06 02:29:55', 'confirmado', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (114, 41, 200, '2026-02-10 11:48:23', 'asistio', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (115, 26, 404, '2026-02-28 23:43:23', 'asistio', 'El ponente fue muy claro y dinámico.', 4);
INSERT INTO public.evento_usuarios VALUES (116, 13, 492, '2026-01-06 21:05:30', 'no_asistio', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (117, 19, 263, '2026-05-16 16:58:58', 'confirmado', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (118, 24, 124, '2026-05-09 16:11:53', 'asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (119, 30, 313, '2026-01-16 21:44:21', 'confirmado', 'Muy buen espacio de networking.', 10);
INSERT INTO public.evento_usuarios VALUES (120, 41, 30, '2026-03-16 07:13:58', 'pendiente', 'Me encantó la actividad, la recomiendo.', 5);
INSERT INTO public.evento_usuarios VALUES (121, 13, 425, '2026-05-15 08:37:20', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (122, 10, 413, '2026-01-27 02:06:45', 'no_asistio', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (123, 35, 25, '2026-02-20 07:37:05', 'pendiente', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (124, 9, 208, '2026-03-24 07:02:56', 'no_asistio', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (125, 6, 471, '2026-05-10 15:48:20', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (126, 33, 440, '2026-04-15 17:46:55', 'confirmado', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (127, 14, 421, '2026-01-07 00:37:06', 'asistio', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (128, 36, 66, '2026-05-15 00:15:44', 'no_asistio', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (129, 41, 360, '2026-05-08 08:46:18', 'confirmado', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (130, 40, 349, '2026-02-24 12:23:39', 'asistio', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (131, 5, 160, '2026-01-19 03:55:33', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (132, 19, 116, '2026-03-01 12:33:30', 'asistio', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (133, 9, 388, '2026-04-15 06:10:52', 'pendiente', 'Me encantó la actividad, la recomiendo.', 9);
INSERT INTO public.evento_usuarios VALUES (134, 39, 259, '2026-02-07 02:15:28', 'asistio', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (135, 27, 40, '2026-01-24 08:59:02', 'asistio', 'El ponente fue muy claro y dinámico.', 8);
INSERT INTO public.evento_usuarios VALUES (136, 35, 209, '2026-01-11 11:40:01', 'asistio', 'Me encantó la actividad, la recomiendo.', 7);
INSERT INTO public.evento_usuarios VALUES (137, 26, 220, '2026-04-22 23:02:33', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 2);
INSERT INTO public.evento_usuarios VALUES (138, 28, 400, '2026-01-05 01:12:55', 'confirmado', 'Me encantó la actividad, la recomiendo.', 5);
INSERT INTO public.evento_usuarios VALUES (139, 25, 204, '2026-01-23 00:24:09', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 5);
INSERT INTO public.evento_usuarios VALUES (140, 48, 109, '2026-01-26 05:49:13', 'asistio', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (141, 4, 419, '2026-04-21 16:35:11', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (142, 41, 434, '2026-05-05 13:48:35', 'pendiente', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (143, 17, 149, '2026-01-11 03:15:19', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (144, 22, 153, '2026-03-02 15:55:42', 'pendiente', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (145, 14, 120, '2026-04-06 19:46:07', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 10);
INSERT INTO public.evento_usuarios VALUES (146, 24, 232, '2026-01-05 19:52:03', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 4);
INSERT INTO public.evento_usuarios VALUES (147, 19, 294, '2026-02-16 00:45:28', 'asistio', 'El ponente fue muy claro y dinámico.', 6);
INSERT INTO public.evento_usuarios VALUES (148, 49, 307, '2026-04-18 19:36:51', 'no_asistio', 'Muy buen espacio de networking.', 8);
INSERT INTO public.evento_usuarios VALUES (149, 42, 310, '2026-04-27 02:56:33', 'asistio', 'El ponente fue muy claro y dinámico.', 8);
INSERT INTO public.evento_usuarios VALUES (150, 24, 297, '2026-04-09 20:36:15', 'pendiente', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (151, 7, 151, '2026-01-06 16:56:19', 'pendiente', 'El ponente fue muy claro y dinámico.', 3);
INSERT INTO public.evento_usuarios VALUES (152, 7, 95, '2026-02-27 09:49:09', 'no_asistio', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (153, 36, 492, '2026-01-15 13:39:44', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (154, 26, 328, '2026-01-31 14:48:26', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (155, 48, 111, '2026-03-21 17:46:14', 'pendiente', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (156, 43, 309, '2026-04-03 20:15:57', 'pendiente', 'Excelente evento, muy bien organizado.', 4);
INSERT INTO public.evento_usuarios VALUES (157, 1, 460, '2026-03-30 13:56:42', 'confirmado', 'El ponente fue muy claro y dinámico.', 9);
INSERT INTO public.evento_usuarios VALUES (158, 40, 223, '2026-03-29 00:35:51', 'pendiente', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (159, 49, 184, '2026-05-20 21:09:27', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (160, 25, 294, '2026-04-07 11:26:40', 'confirmado', 'Me encantó la actividad, la recomiendo.', 0);
INSERT INTO public.evento_usuarios VALUES (161, 36, 247, '2026-04-20 03:43:53', 'pendiente', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (162, 21, 293, '2026-03-28 03:16:53', 'pendiente', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (163, 35, 77, '2026-03-03 18:50:49', 'asistio', 'Muy buen espacio de networking.', 10);
INSERT INTO public.evento_usuarios VALUES (164, 3, 438, '2026-01-08 05:30:48', 'pendiente', 'Excelente evento, muy bien organizado.', 0);
INSERT INTO public.evento_usuarios VALUES (165, 43, 437, '2026-05-12 13:38:25', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 0);
INSERT INTO public.evento_usuarios VALUES (166, 8, 427, '2026-04-10 16:12:04', 'confirmado', 'Me encantó la actividad, la recomiendo.', 9);
INSERT INTO public.evento_usuarios VALUES (167, 22, 422, '2026-01-07 01:04:24', 'confirmado', 'Muy buen espacio de networking.', 1);
INSERT INTO public.evento_usuarios VALUES (168, 19, 323, '2026-01-19 23:20:03', 'no_asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (169, 41, 268, '2026-02-20 18:28:41', 'no_asistio', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (170, 47, 189, '2026-02-26 20:17:17', 'confirmado', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (171, 29, 307, '2026-03-14 12:10:03', 'no_asistio', 'El ponente fue muy claro y dinámico.', 6);
INSERT INTO public.evento_usuarios VALUES (172, 49, 442, '2026-04-16 21:08:38', 'pendiente', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (173, 36, 409, '2026-01-24 23:55:31', 'no_asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (174, 11, 290, '2026-01-18 08:01:25', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (175, 13, 104, '2026-04-27 07:05:59', 'pendiente', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (176, 46, 477, '2026-02-13 06:22:58', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (177, 35, 475, '2026-01-21 14:00:13', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 1);
INSERT INTO public.evento_usuarios VALUES (178, 39, 84, '2026-01-01 12:07:14', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (179, 43, 163, '2026-02-03 14:31:34', 'asistio', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (180, 13, 112, '2026-04-25 02:57:42', 'asistio', 'Muy buen espacio de networking.', 4);
INSERT INTO public.evento_usuarios VALUES (181, 38, 26, '2026-02-13 18:20:03', 'pendiente', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (182, 33, 23, '2026-01-25 13:17:18', 'confirmado', 'Me encantó la actividad, la recomiendo.', 7);
INSERT INTO public.evento_usuarios VALUES (183, 14, 350, '2026-03-06 03:25:30', 'confirmado', 'El ponente fue muy claro y dinámico.', 7);
INSERT INTO public.evento_usuarios VALUES (184, 48, 405, '2026-05-08 21:32:10', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 0);
INSERT INTO public.evento_usuarios VALUES (185, 11, 328, '2026-01-24 15:57:52', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 10);
INSERT INTO public.evento_usuarios VALUES (186, 13, 134, '2026-05-13 13:10:36', 'asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (187, 39, 225, '2026-03-01 13:55:52', 'pendiente', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (188, 33, 91, '2026-05-20 21:20:26', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (189, 37, 385, '2026-04-26 23:01:31', 'no_asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (190, 8, 233, '2026-05-03 22:03:25', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (191, 34, 400, '2026-02-07 00:23:48', 'confirmado', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (192, 10, 44, '2026-02-13 05:14:40', 'asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (193, 11, 45, '2026-04-11 21:55:42', 'asistio', 'Excelente evento, muy bien organizado.', 5);
INSERT INTO public.evento_usuarios VALUES (194, 35, 230, '2026-01-27 21:16:25', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (195, 42, 395, '2026-02-14 02:36:08', 'asistio', NULL, 7);
INSERT INTO public.evento_usuarios VALUES (196, 49, 305, '2026-01-11 17:37:34', 'asistio', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (197, 40, 312, '2026-05-19 09:50:34', 'confirmado', 'El ponente fue muy claro y dinámico.', 2);
INSERT INTO public.evento_usuarios VALUES (198, 3, 436, '2026-03-26 01:38:44', 'pendiente', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (199, 46, 355, '2026-03-06 16:18:41', 'pendiente', 'Muy buen espacio de networking.', 9);
INSERT INTO public.evento_usuarios VALUES (200, 22, 434, '2026-05-12 17:40:04', 'confirmado', 'Muy buen espacio de networking.', 5);
INSERT INTO public.evento_usuarios VALUES (201, 29, 321, '2026-05-20 16:29:51', 'confirmado', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (202, 23, 473, '2026-02-15 07:57:34', 'no_asistio', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (203, 31, 101, '2026-05-19 21:11:01', 'no_asistio', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (204, 50, 40, '2026-01-17 23:40:42', 'no_asistio', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (205, 35, 253, '2026-04-09 17:09:54', 'no_asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (206, 9, 164, '2026-05-13 18:12:31', 'confirmado', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (207, 34, 1, '2026-04-13 20:11:43', 'pendiente', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (208, 45, 138, '2026-01-08 21:57:55', 'asistio', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (209, 47, 318, '2026-03-26 21:29:36', 'confirmado', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (210, 8, 86, '2026-03-13 17:11:49', 'asistio', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (211, 17, 94, '2026-05-15 12:29:37', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 2);
INSERT INTO public.evento_usuarios VALUES (212, 23, 424, '2026-03-17 05:40:15', 'pendiente', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (213, 15, 444, '2026-02-19 17:57:59', 'confirmado', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (214, 11, 134, '2026-01-21 21:43:58', 'asistio', 'El ponente fue muy claro y dinámico.', 8);
INSERT INTO public.evento_usuarios VALUES (215, 49, 173, '2026-05-04 05:58:21', 'no_asistio', 'El ponente fue muy claro y dinámico.', 9);
INSERT INTO public.evento_usuarios VALUES (216, 11, 207, '2026-02-26 22:14:21', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (217, 33, 55, '2026-04-11 11:23:01', 'no_asistio', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (218, 36, 167, '2026-01-05 19:20:48', 'no_asistio', 'Muy buen espacio de networking.', 4);
INSERT INTO public.evento_usuarios VALUES (219, 15, 4, '2026-02-19 09:40:39', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 1);
INSERT INTO public.evento_usuarios VALUES (220, 31, 307, '2026-05-04 05:03:12', 'asistio', 'Me encantó la actividad, la recomiendo.', 4);
INSERT INTO public.evento_usuarios VALUES (221, 3, 45, '2026-04-04 06:25:19', 'confirmado', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (222, 30, 56, '2026-03-25 10:12:06', 'pendiente', 'El ponente fue muy claro y dinámico.', 5);
INSERT INTO public.evento_usuarios VALUES (223, 40, 454, '2026-02-24 13:30:46', 'confirmado', 'Me encantó la actividad, la recomiendo.', 6);
INSERT INTO public.evento_usuarios VALUES (224, 29, 436, '2026-03-23 01:01:39', 'asistio', 'El ponente fue muy claro y dinámico.', 10);
INSERT INTO public.evento_usuarios VALUES (225, 7, 146, '2026-01-23 01:49:22', 'pendiente', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (226, 40, 271, '2026-02-01 22:37:33', 'no_asistio', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (227, 47, 428, '2026-02-03 15:00:17', 'asistio', 'El ponente fue muy claro y dinámico.', 3);
INSERT INTO public.evento_usuarios VALUES (228, 33, 270, '2026-03-31 12:10:56', 'pendiente', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (229, 50, 220, '2026-04-17 01:20:55', 'no_asistio', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (230, 29, 144, '2026-03-18 05:08:31', 'asistio', NULL, 10);
INSERT INTO public.evento_usuarios VALUES (231, 18, 278, '2026-03-28 23:37:27', 'asistio', NULL, 9);
INSERT INTO public.evento_usuarios VALUES (232, 19, 92, '2026-05-09 04:19:39', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 6);
INSERT INTO public.evento_usuarios VALUES (233, 22, 14, '2026-02-04 00:56:02', 'confirmado', 'El ponente fue muy claro y dinámico.', 4);
INSERT INTO public.evento_usuarios VALUES (234, 24, 328, '2026-02-28 18:41:56', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (235, 9, 330, '2026-01-30 10:55:20', 'confirmado', 'Me encantó la actividad, la recomiendo.', 0);
INSERT INTO public.evento_usuarios VALUES (236, 21, 175, '2026-05-04 01:33:13', 'no_asistio', 'El ponente fue muy claro y dinámico.', 10);
INSERT INTO public.evento_usuarios VALUES (237, 20, 146, '2026-05-14 16:39:24', 'no_asistio', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (238, 32, 494, '2026-02-26 13:28:57', 'no_asistio', 'Muy buen espacio de networking.', 10);
INSERT INTO public.evento_usuarios VALUES (239, 48, 4, '2026-02-03 11:54:32', 'pendiente', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (240, 14, 487, '2026-01-18 16:13:51', 'pendiente', 'Aprendí mucho, espero que se repita pronto.', 2);
INSERT INTO public.evento_usuarios VALUES (241, 13, 429, '2026-01-17 04:12:38', 'pendiente', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (242, 20, 320, '2026-01-24 01:24:47', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (243, 16, 213, '2026-03-09 15:10:13', 'no_asistio', NULL, 0);
INSERT INTO public.evento_usuarios VALUES (244, 35, 85, '2026-05-01 12:33:45', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (245, 12, 461, '2026-03-31 15:29:20', 'asistio', NULL, 8);
INSERT INTO public.evento_usuarios VALUES (246, 41, 137, '2026-05-04 04:24:09', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (247, 40, 47, '2026-05-11 21:47:29', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (248, 26, 28, '2026-05-21 05:45:28', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (249, 5, 235, '2026-02-25 06:28:50', 'pendiente', 'El ponente fue muy claro y dinámico.', 0);
INSERT INTO public.evento_usuarios VALUES (250, 21, 94, '2026-02-14 04:36:36', 'pendiente', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (251, 7, 376, '2026-04-20 10:42:54', 'confirmado', 'Muy buen espacio de networking.', 3);
INSERT INTO public.evento_usuarios VALUES (252, 36, 282, '2026-02-06 07:57:10', 'asistio', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (253, 37, 439, '2026-05-19 06:20:35', 'asistio', 'Muy buen espacio de networking.', 6);
INSERT INTO public.evento_usuarios VALUES (254, 8, 251, '2026-04-29 23:47:56', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 2);
INSERT INTO public.evento_usuarios VALUES (255, 26, 149, '2026-03-05 00:36:21', 'asistio', 'Muy buen espacio de networking.', 9);
INSERT INTO public.evento_usuarios VALUES (256, 50, 256, '2026-01-30 05:57:28', 'no_asistio', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (257, 37, 90, '2026-04-23 02:10:03', 'asistio', 'Me encantó la actividad, la recomiendo.', 10);
INSERT INTO public.evento_usuarios VALUES (258, 39, 240, '2026-05-15 15:46:07', 'pendiente', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (259, 9, 297, '2026-05-13 07:08:09', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 2);
INSERT INTO public.evento_usuarios VALUES (260, 24, 204, '2026-01-14 17:12:11', 'confirmado', 'Excelente evento, muy bien organizado.', 4);
INSERT INTO public.evento_usuarios VALUES (261, 49, 284, '2026-05-06 19:51:43', 'no_asistio', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (262, 44, 108, '2026-04-06 21:32:22', 'pendiente', 'Me encantó la actividad, la recomiendo.', 10);
INSERT INTO public.evento_usuarios VALUES (263, 35, 202, '2026-01-16 01:12:01', 'asistio', 'Muy buen espacio de networking.', 3);
INSERT INTO public.evento_usuarios VALUES (264, 25, 331, '2026-01-21 18:54:50', 'asistio', 'Aprendí mucho, espero que se repita pronto.', 7);
INSERT INTO public.evento_usuarios VALUES (265, 5, 178, '2026-02-11 06:55:46', 'confirmado', 'Excelente evento, muy bien organizado.', 2);
INSERT INTO public.evento_usuarios VALUES (266, 42, 296, '2026-02-12 23:37:47', 'asistio', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (267, 20, 102, '2026-05-03 08:41:55', 'pendiente', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (268, 13, 467, '2026-01-02 18:26:30', 'confirmado', 'Me encantó la actividad, la recomiendo.', 10);
INSERT INTO public.evento_usuarios VALUES (269, 38, 256, '2026-01-24 19:07:09', 'no_asistio', 'Excelente evento, muy bien organizado.', 10);
INSERT INTO public.evento_usuarios VALUES (270, 10, 375, '2026-02-08 03:13:10', 'confirmado', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (271, 30, 386, '2026-02-05 01:07:38', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 1);
INSERT INTO public.evento_usuarios VALUES (272, 25, 207, '2026-01-27 04:58:11', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 9);
INSERT INTO public.evento_usuarios VALUES (273, 47, 17, '2026-04-25 04:46:21', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 3);
INSERT INTO public.evento_usuarios VALUES (274, 40, 383, '2026-02-24 01:18:36', 'pendiente', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (275, 22, 107, '2026-05-18 00:42:11', 'no_asistio', 'Muy buen espacio de networking.', 8);
INSERT INTO public.evento_usuarios VALUES (276, 7, 77, '2026-03-14 05:06:05', 'asistio', 'Excelente evento, muy bien organizado.', 8);
INSERT INTO public.evento_usuarios VALUES (277, 44, 203, '2026-05-15 04:59:21', 'confirmado', NULL, 2);
INSERT INTO public.evento_usuarios VALUES (278, 10, 306, '2026-03-15 12:08:01', 'pendiente', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (279, 47, 195, '2026-01-17 23:47:41', 'confirmado', 'Me encantó la actividad, la recomiendo.', 10);
INSERT INTO public.evento_usuarios VALUES (280, 37, 306, '2026-03-30 04:49:44', 'no_asistio', 'Excelente evento, muy bien organizado.', 1);
INSERT INTO public.evento_usuarios VALUES (281, 15, 497, '2026-04-27 03:09:17', 'pendiente', NULL, 5);
INSERT INTO public.evento_usuarios VALUES (282, 36, 168, '2026-05-19 11:24:19', 'pendiente', 'Me encantó la actividad, la recomiendo.', 0);
INSERT INTO public.evento_usuarios VALUES (283, 17, 483, '2026-01-20 23:49:09', 'confirmado', 'El ponente fue muy claro y dinámico.', 7);
INSERT INTO public.evento_usuarios VALUES (284, 4, 217, '2026-02-01 11:39:10', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 8);
INSERT INTO public.evento_usuarios VALUES (285, 32, 143, '2026-01-16 05:38:39', 'confirmado', NULL, 1);
INSERT INTO public.evento_usuarios VALUES (286, 28, 219, '2026-01-06 13:14:08', 'pendiente', 'Muy buen espacio de networking.', 8);
INSERT INTO public.evento_usuarios VALUES (287, 42, 484, '2026-01-28 10:20:16', 'pendiente', 'Excelente evento, muy bien organizado.', 3);
INSERT INTO public.evento_usuarios VALUES (288, 45, 364, '2026-03-15 01:15:03', 'confirmado', 'Excelente evento, muy bien organizado.', 9);
INSERT INTO public.evento_usuarios VALUES (289, 24, 465, '2026-04-14 15:36:58', 'no_asistio', NULL, 6);
INSERT INTO public.evento_usuarios VALUES (290, 20, 319, '2026-01-17 11:28:37', 'asistio', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (291, 28, 432, '2026-02-14 07:16:30', 'confirmado', 'El ponente fue muy claro y dinámico.', 4);
INSERT INTO public.evento_usuarios VALUES (292, 30, 223, '2026-01-01 03:02:35', 'confirmado', 'Aprendí mucho, espero que se repita pronto.', 8);
INSERT INTO public.evento_usuarios VALUES (293, 8, 20, '2026-02-23 00:51:58', 'no_asistio', 'Me encantó la actividad, la recomiendo.', 1);
INSERT INTO public.evento_usuarios VALUES (294, 29, 205, '2026-03-12 02:31:10', 'no_asistio', 'Excelente evento, muy bien organizado.', 8);
INSERT INTO public.evento_usuarios VALUES (295, 1, 265, '2026-01-25 23:42:23', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 2);
INSERT INTO public.evento_usuarios VALUES (296, 38, 16, '2026-01-28 10:45:03', 'no_asistio', 'Aprendí mucho, espero que se repita pronto.', 3);
INSERT INTO public.evento_usuarios VALUES (297, 33, 22, '2026-04-15 14:06:15', 'confirmado', NULL, 3);
INSERT INTO public.evento_usuarios VALUES (298, 22, 41, '2026-01-13 09:23:33', 'asistio', NULL, 4);
INSERT INTO public.evento_usuarios VALUES (299, 13, 411, '2026-04-13 05:07:45', 'pendiente', 'Excelente evento, muy bien organizado.', 0);
INSERT INTO public.evento_usuarios VALUES (300, 37, 223, '2026-02-16 11:34:55', 'asistio', NULL, 6);


--
-- Data for Name: eventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.eventos VALUES (1, 73, 14, 'Feria de Emprendimiento Pascual Bravo 2026', '2026-03-13 05:14:26', '2026-03-13 10:14:26', 'Laboratorio de Cómputo C-102', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'programado');
INSERT INTO public.eventos VALUES (2, 119, 3, 'Congreso de Ingeniería y Tecnología', '2026-01-14 18:41:50', '2026-01-14 21:41:50', 'Biblioteca Central – Sala Magna', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'cancelado');
INSERT INTO public.eventos VALUES (3, 483, 14, 'Hackathon ITPB – Soluciones Urbanas', '2026-02-12 07:01:51', '2026-02-12 11:01:51', 'Sala de Innovación – Bloque D', 'Actividad académica diseñada para fortalecer competencias y habilidades prácticas en entornos reales.', 'programado');
INSERT INTO public.eventos VALUES (4, 396, 4, 'Semana de la Innovación y el Diseño', '2026-03-10 05:34:07', '2026-03-10 13:34:07', 'Online – Microsoft Teams', 'Taller práctico con expertos del sector para desarrollar habilidades de alta demanda laboral.', 'en_curso');
INSERT INTO public.eventos VALUES (5, 79, 18, 'Torneo Deportivo Interfacultades 2026', '2026-02-17 07:50:00', '2026-02-17 13:50:00', 'Sala de Emprendimiento', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'finalizado');
INSERT INTO public.eventos VALUES (6, 263, 1, 'Concierto Cultural de Bienvenida', '2026-05-09 16:57:03', '2026-05-09 23:57:03', 'Laboratorio de Cómputo C-102', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'programado');
INSERT INTO public.eventos VALUES (7, 241, 5, 'Taller de Inteligencia Artificial Generativa', '2026-02-03 07:55:38', '2026-02-03 13:55:38', 'Sala de Innovación – Bloque D', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'cancelado');
INSERT INTO public.eventos VALUES (8, 126, 15, 'Conferencia de Egresados Destacados', '2026-02-14 22:07:45', '2026-02-15 02:07:45', 'Laboratorio de Cómputo C-102', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'programado');
INSERT INTO public.eventos VALUES (9, 35, 13, 'Foro de Seguridad Informática', '2026-02-04 00:18:29', '2026-02-04 08:18:29', 'Aula Magna – Bloque E', 'Conferencia magistral con panelistas nacionales e internacionales sobre temas de vanguardia.', 'cancelado');
INSERT INTO public.eventos VALUES (10, 456, 17, 'Expo Proyectos de Grado 2026', '2026-04-30 20:33:22', '2026-05-01 03:33:22', 'Laboratorio de Robótica', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'cancelado');
INSERT INTO public.eventos VALUES (11, 86, 17, 'Congreso de Energías Renovables', '2026-05-08 04:51:02', '2026-05-08 08:51:02', 'Sala de Conferencias B-305', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'finalizado');
INSERT INTO public.eventos VALUES (12, 432, 10, 'Carnaval Estudiantil 2026', '2026-01-30 19:57:26', '2026-01-31 02:57:26', 'Plazoleta Central', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'finalizado');
INSERT INTO public.eventos VALUES (13, 13, 11, 'Taller de Emprendimiento con IA', '2026-05-05 06:48:01', '2026-05-05 10:48:01', 'Plazoleta Central', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'cancelado');
INSERT INTO public.eventos VALUES (14, 443, 19, 'Semana de la Salud y el Bienestar', '2026-02-05 20:50:19', '2026-02-06 03:50:19', 'Polideportivo Pascual Bravo', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'programado');
INSERT INTO public.eventos VALUES (15, 462, 8, 'Congreso Internacional de Software Libre', '2026-04-23 08:31:25', '2026-04-23 16:31:25', 'Centro de Bienestar Universitario', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'finalizado');
INSERT INTO public.eventos VALUES (16, 452, 7, 'Festival de Robótica Educativa', '2026-04-29 04:26:03', '2026-04-29 08:26:03', 'Laboratorio de Cómputo C-102', 'Actividad académica diseñada para fortalecer competencias y habilidades prácticas en entornos reales.', 'finalizado');
INSERT INTO public.eventos VALUES (17, 192, 2, 'Taller de Diseño Gráfico Digital', '2026-03-31 14:58:24', '2026-03-31 21:58:24', 'Sala de Conferencias B-305', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'finalizado');
INSERT INTO public.eventos VALUES (18, 182, 17, 'Conferencia de Ciberseguridad para Pymes', '2026-05-03 01:59:55', '2026-05-03 09:59:55', 'Sala de Conferencias B-305', 'Taller práctico con expertos del sector para desarrollar habilidades de alta demanda laboral.', 'finalizado');
INSERT INTO public.eventos VALUES (19, 100, 10, 'Feria Laboral Pascual Bravo 2026', '2026-05-10 05:00:06', '2026-05-10 08:00:06', 'Centro de Bienestar Universitario', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'finalizado');
INSERT INTO public.eventos VALUES (20, 31, 1, 'Simposio de Manufactura Avanzada', '2026-05-11 06:40:33', '2026-05-11 12:40:33', 'Auditorio Principal – Bloque A', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'cancelado');
INSERT INTO public.eventos VALUES (21, 172, 20, 'Taller de Desarrollo Web con React', '2026-04-28 11:39:20', '2026-04-28 16:39:20', 'Teatro Universitario', 'Espacio de networking e intercambio de conocimientos entre estudiantes, docentes y sector productivo.', 'programado');
INSERT INTO public.eventos VALUES (22, 453, 15, 'Evento de Liderazgo Estudiantil', '2026-05-05 13:48:32', '2026-05-05 14:48:32', 'Aula Magna – Bloque E', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'programado');
INSERT INTO public.eventos VALUES (23, 496, 5, 'Olimpiadas de Matemáticas 2026', '2026-04-07 10:42:45', '2026-04-07 18:42:45', 'Centro de Bienestar Universitario', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'en_curso');
INSERT INTO public.eventos VALUES (24, 73, 7, 'Foro de Inclusión y Diversidad', '2026-01-24 19:24:17', '2026-01-25 02:24:17', 'Polideportivo Pascual Bravo', 'Espacio de networking e intercambio de conocimientos entre estudiantes, docentes y sector productivo.', 'programado');
INSERT INTO public.eventos VALUES (25, 156, 1, 'Conferencia de Blockchain y Fintech', '2026-02-04 06:26:36', '2026-02-04 10:26:36', 'Plazoleta Central', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'cancelado');
INSERT INTO public.eventos VALUES (26, 281, 19, 'Maratón de Programación – Code24h', '2026-03-07 06:00:04', '2026-03-07 09:00:04', 'Sala de Emprendimiento', 'Espacio de networking e intercambio de conocimientos entre estudiantes, docentes y sector productivo.', 'finalizado');
INSERT INTO public.eventos VALUES (27, 373, 16, 'Jornada de Inducción Nuevos Estudiantes', '2026-01-17 07:29:58', '2026-01-17 10:29:58', 'Pabellón de Tecnología', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'programado');
INSERT INTO public.eventos VALUES (28, 41, 15, 'Taller de Fotografía y Comunicación Visual', '2026-03-29 19:46:23', '2026-03-30 03:46:23', 'Biblioteca Central – Sala Magna', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'finalizado');
INSERT INTO public.eventos VALUES (29, 324, 11, 'Congreso de Automatización Industrial', '2026-05-15 04:42:43', '2026-05-15 09:42:43', 'Laboratorio de Robótica', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'en_curso');
INSERT INTO public.eventos VALUES (30, 116, 1, 'Festival Gastronómico Universitario', '2026-04-22 15:17:21', '2026-04-22 20:17:21', 'Campus Norte – Zona Verde', 'Conferencia magistral con panelistas nacionales e internacionales sobre temas de vanguardia.', 'programado');
INSERT INTO public.eventos VALUES (31, 488, 19, 'Simposio de Gestión de Proyectos', '2026-03-18 08:06:52', '2026-03-18 11:06:52', 'Online – Microsoft Teams', 'Jornada formativa enfocada en las últimas tendencias tecnológicas y su aplicación en la industria.', 'en_curso');
INSERT INTO public.eventos VALUES (32, 451, 8, 'Taller de Oratoria y Debate', '2026-04-29 04:59:06', '2026-04-29 10:59:06', 'Plazoleta Central', 'Conferencia magistral con panelistas nacionales e internacionales sobre temas de vanguardia.', 'cancelado');
INSERT INTO public.eventos VALUES (33, 291, 11, 'Encuentro de Semilleros de Investigación', '2026-03-18 02:15:10', '2026-03-18 10:15:10', 'Pabellón de Tecnología', 'Actividad académica diseñada para fortalecer competencias y habilidades prácticas en entornos reales.', 'finalizado');
INSERT INTO public.eventos VALUES (34, 475, 2, 'Conferencia de Machine Learning Aplicado', '2026-04-22 12:52:27', '2026-04-22 15:52:27', 'Plazoleta Central', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'programado');
INSERT INTO public.eventos VALUES (35, 171, 12, 'Jornada de Voluntariado y Responsabilidad Social', '2026-01-31 09:15:31', '2026-01-31 17:15:31', 'Pabellón de Tecnología', 'Conferencia magistral con panelistas nacionales e internacionales sobre temas de vanguardia.', 'en_curso');
INSERT INTO public.eventos VALUES (36, 208, 14, 'Foro Ambiental Universitario 2026', '2026-03-02 09:15:39', '2026-03-02 12:15:39', 'Teatro Universitario', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'finalizado');
INSERT INTO public.eventos VALUES (37, 304, 13, 'Taller de Marketing Digital', '2026-01-22 03:05:05', '2026-01-22 04:05:05', 'Laboratorio de Cómputo C-102', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'cancelado');
INSERT INTO public.eventos VALUES (38, 253, 3, 'Concierto de Música Clásica en el Campus', '2026-02-08 01:00:30', '2026-02-08 04:00:30', 'Auditorio Principal – Bloque A', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'finalizado');
INSERT INTO public.eventos VALUES (39, 432, 12, 'Seminario de Ética en Tecnología', '2026-04-02 21:36:05', '2026-04-02 22:36:05', 'Laboratorio de Cómputo C-102', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'finalizado');
INSERT INTO public.eventos VALUES (40, 52, 2, 'Taller de Contabilidad Básica', '2026-01-22 01:39:00', '2026-01-22 05:39:00', 'Laboratorio de Robótica', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'cancelado');
INSERT INTO public.eventos VALUES (41, 422, 16, 'Conferencia de Realidad Aumentada y VR', '2026-01-28 08:37:18', '2026-01-28 10:37:18', 'Sala de Emprendimiento', 'Feria de oportunidades laborales con empresas aliadas del sector tecnológico e industrial.', 'finalizado');
INSERT INTO public.eventos VALUES (42, 71, 3, 'Jornada de Salud Mental Estudiantil', '2026-04-29 19:54:16', '2026-04-29 22:54:16', 'Aula Magna – Bloque E', 'Competencia académica que estimula el pensamiento crítico, lógico y creativo de los participantes.', 'programado');
INSERT INTO public.eventos VALUES (43, 255, 20, 'Torneo de Ajedrez Universitario', '2026-02-27 22:18:02', '2026-02-28 05:18:02', 'Sala de Emprendimiento', 'Taller práctico con expertos del sector para desarrollar habilidades de alta demanda laboral.', 'en_curso');
INSERT INTO public.eventos VALUES (44, 356, 16, 'Feria de Ciencias Exactas', '2026-04-26 11:32:19', '2026-04-26 16:32:19', 'Aula Magna – Bloque E', 'Conferencia magistral con panelistas nacionales e internacionales sobre temas de vanguardia.', 'cancelado');
INSERT INTO public.eventos VALUES (45, 414, 8, 'Taller de Manufactura con Impresión 3D', '2026-03-21 21:20:13', '2026-03-22 01:20:13', 'Campus Norte – Zona Verde', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'en_curso');
INSERT INTO public.eventos VALUES (46, 19, 3, 'Congreso Latinoamericano de IoT', '2026-01-16 18:56:07', '2026-01-16 21:56:07', 'Sala de Conferencias B-305', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'en_curso');
INSERT INTO public.eventos VALUES (47, 77, 3, 'Encuentro de Alumni 2026', '2026-03-14 10:44:20', '2026-03-14 14:44:20', 'Centro de Bienestar Universitario', 'Actividad orientada al bienestar estudiantil, fomento de estilos de vida saludables y convivencia.', 'cancelado');
INSERT INTO public.eventos VALUES (48, 210, 4, 'Seminario de Finanzas Personales', '2026-03-19 22:13:57', '2026-03-20 06:13:57', 'Aula Magna – Bloque E', 'Espacio de networking e intercambio de conocimientos entre estudiantes, docentes y sector productivo.', 'finalizado');
INSERT INTO public.eventos VALUES (49, 81, 13, 'Taller de Comunicación Asertiva', '2026-02-19 11:04:03', '2026-02-19 12:04:03', 'Sala de Emprendimiento', 'Encuentro multidisciplinar para presentar avances investigativos y proyectos innovadores.', 'cancelado');
INSERT INTO public.eventos VALUES (50, 96, 16, 'Clausura del Semestre 2026-1', '2026-04-29 21:25:50', '2026-04-30 03:25:50', 'Campus Norte – Zona Verde', 'Evento de integración que promueve la cultura, el arte y el deporte en la comunidad universitaria.', 'finalizado');


--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.grupos VALUES (1, 1, 'Semillero de Inteligencia Artificial', 'Investigación en ML, Deep Learning y IA aplicada', 'proyecto', '2026-01-22');
INSERT INTO public.grupos VALUES (2, 2, 'Red de Egresados Ing. Sistemas', 'Comunidad de graduados del programa de Sistemas', 'egresados', '2026-01-26');
INSERT INTO public.grupos VALUES (3, 3, 'Equipo Hackathon 2026', 'Preparación multidisciplinar para competencias de innovación', 'proyecto', '2026-01-04');
INSERT INTO public.grupos VALUES (4, 4, 'Mentores Primer Semestre', 'Acompañamiento a estudiantes de nuevo ingreso', 'mentoria', '2026-05-10');
INSERT INTO public.grupos VALUES (5, 5, 'Apoyo Académico Cálculo I', 'Refuerzo en cálculo diferencial e integral', 'apoyo_academico', '2026-01-03');
INSERT INTO public.grupos VALUES (6, 6, 'Emprendedores ITPB', 'Red de estudiantes emprendedores e innovadores', 'interes', '2026-04-13');
INSERT INTO public.grupos VALUES (7, 7, 'Club de Robótica', 'Diseño y construcción de robots educativos', 'proyecto', '2026-03-19');
INSERT INTO public.grupos VALUES (8, 8, 'Alumni Electrónica', 'Red de egresados de Tecnología Electrónica', 'egresados', '2026-01-30');
INSERT INTO public.grupos VALUES (9, 9, 'Mentores Empleabilidad', 'Preparación para el mercado laboral TIC', 'mentoria', '2026-04-26');
INSERT INTO public.grupos VALUES (10, 10, 'Apoyo Académico Estadística', 'Refuerzo en estadística y probabilidad aplicada', 'apoyo_academico', '2026-05-02');


--
-- Data for Name: ofertas_laborales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.perfil VALUES (1, 1, 'campus0001007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0001.jpg', 9, '2026-03-25 14:44:01');
INSERT INTO public.perfil VALUES (2, 2, 'ing0002col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0002.jpg', 3, '2026-01-01 12:12:40');
INSERT INTO public.perfil VALUES (3, 3, 'pascal0003123', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0003.jpg', NULL, '2026-02-10 07:33:45');
INSERT INTO public.perfil VALUES (4, 4, 'dev0004007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0004.jpg', 3, '2026-03-08 05:43:37');
INSERT INTO public.perfil VALUES (5, 5, 'campus0005medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0005.jpg', NULL, '2026-04-05 05:25:56');
INSERT INTO public.perfil VALUES (6, 6, 'bravo0006itpb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0006.jpg', 9, '2026-02-28 02:29:12');
INSERT INTO public.perfil VALUES (7, 7, 'pascal0007col', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0007.jpg', 7, '2026-03-08 04:05:23');
INSERT INTO public.perfil VALUES (8, 8, 'dev0008pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0008.jpg', 7, '2026-04-27 21:31:07');
INSERT INTO public.perfil VALUES (9, 9, 'code0009itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0009.jpg', 5, '2026-03-15 23:31:24');
INSERT INTO public.perfil VALUES (10, 10, 'dev0010007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0010.jpg', 5, '2026-02-18 13:11:26');
INSERT INTO public.perfil VALUES (11, 11, 'dev00112026', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0011.jpg', 4, '2026-04-26 07:23:37');
INSERT INTO public.perfil VALUES (12, 12, 'uni0012pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0012.jpg', 6, '2026-04-12 21:13:45');
INSERT INTO public.perfil VALUES (13, 13, 'bravo0013007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0013.jpg', NULL, '2026-01-25 17:03:03');
INSERT INTO public.perfil VALUES (14, 14, 'campus0014itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0014.jpg', 10, '2026-01-12 00:16:32');
INSERT INTO public.perfil VALUES (15, 15, 'bravo0015medellin', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0015.jpg', 3, '2026-01-11 18:11:16');
INSERT INTO public.perfil VALUES (16, 16, 'dev0016star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0016.jpg', 3, '2026-01-23 10:45:33');
INSERT INTO public.perfil VALUES (17, 17, 'bravo0017col', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0017.jpg', NULL, '2026-01-12 04:31:55');
INSERT INTO public.perfil VALUES (18, 18, 'pascal0018123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0018.jpg', NULL, '2026-03-09 19:53:48');
INSERT INTO public.perfil VALUES (19, 19, 'pascal0019123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0019.jpg', 6, '2026-05-06 04:35:54');
INSERT INTO public.perfil VALUES (20, 20, 'uni00202026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0020.jpg', NULL, '2026-02-28 05:02:30');
INSERT INTO public.perfil VALUES (21, 21, 'pascal0021col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0021.jpg', 8, '2026-01-11 14:22:45');
INSERT INTO public.perfil VALUES (22, 22, 'uni0022star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0022.jpg', NULL, '2026-02-07 03:22:05');
INSERT INTO public.perfil VALUES (23, 23, 'code0023medellin', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0023.jpg', 9, '2026-03-11 18:57:42');
INSERT INTO public.perfil VALUES (24, 24, 'code00242026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0024.jpg', 3, '2026-04-17 02:15:49');
INSERT INTO public.perfil VALUES (25, 25, 'uni0025pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0025.jpg', NULL, '2026-02-01 12:23:37');
INSERT INTO public.perfil VALUES (26, 26, 'tech0026123', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0026.jpg', NULL, '2026-04-28 22:42:30');
INSERT INTO public.perfil VALUES (27, 27, 'uni0027medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0027.jpg', 6, '2026-01-12 20:39:28');
INSERT INTO public.perfil VALUES (28, 28, 'campus0028col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0028.jpg', 5, '2026-03-24 01:47:04');
INSERT INTO public.perfil VALUES (29, 29, 'bravo0029pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0029.jpg', NULL, '2026-03-03 12:05:01');
INSERT INTO public.perfil VALUES (30, 30, 'code0030col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0030.jpg', 5, '2026-02-09 03:19:31');
INSERT INTO public.perfil VALUES (31, 31, 'bravo0031medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0031.jpg', NULL, '2026-01-25 11:32:12');
INSERT INTO public.perfil VALUES (32, 32, 'uni0032star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0032.jpg', 10, '2026-04-19 02:48:27');
INSERT INTO public.perfil VALUES (33, 33, 'campus0033col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0033.jpg', 2, '2026-01-11 16:21:29');
INSERT INTO public.perfil VALUES (34, 34, 'code0034col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0034.jpg', 9, '2026-01-22 09:29:27');
INSERT INTO public.perfil VALUES (35, 35, 'tech0035star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0035.jpg', NULL, '2026-02-02 21:57:19');
INSERT INTO public.perfil VALUES (36, 36, 'code0036007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0036.jpg', 9, '2026-01-20 01:32:06');
INSERT INTO public.perfil VALUES (37, 37, 'bravo0037007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0037.jpg', 10, '2026-03-06 11:16:37');
INSERT INTO public.perfil VALUES (38, 38, 'tech00382026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0038.jpg', 8, '2026-02-15 05:53:25');
INSERT INTO public.perfil VALUES (39, 39, 'ing0039pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0039.jpg', 5, '2026-03-22 18:46:29');
INSERT INTO public.perfil VALUES (40, 40, 'uni0040medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0040.jpg', 3, '2026-02-24 05:05:47');
INSERT INTO public.perfil VALUES (41, 41, 'pascal0041pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0041.jpg', 1, '2026-04-12 03:00:10');
INSERT INTO public.perfil VALUES (42, 42, 'uni0042star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0042.jpg', 10, '2026-05-05 09:39:52');
INSERT INTO public.perfil VALUES (43, 43, 'campus0043007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0043.jpg', NULL, '2026-02-04 00:12:07');
INSERT INTO public.perfil VALUES (44, 44, 'ing0044itpb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0044.jpg', NULL, '2026-02-07 20:15:27');
INSERT INTO public.perfil VALUES (45, 45, 'code0045pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0045.jpg', 3, '2026-05-02 13:01:07');
INSERT INTO public.perfil VALUES (46, 46, 'dev0046col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0046.jpg', 8, '2026-01-06 14:37:15');
INSERT INTO public.perfil VALUES (47, 47, 'code0047medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0047.jpg', 7, '2026-01-14 10:00:06');
INSERT INTO public.perfil VALUES (48, 48, 'bravo0048007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0048.jpg', 10, '2026-03-16 01:31:25');
INSERT INTO public.perfil VALUES (49, 49, 'uni0049star', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0049.jpg', 9, '2026-01-05 13:36:20');
INSERT INTO public.perfil VALUES (50, 50, 'tech0050medellin', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0050.jpg', 2, '2026-05-07 19:41:22');
INSERT INTO public.perfil VALUES (51, 51, 'uni0051007', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0051.jpg', NULL, '2026-02-19 15:22:28');
INSERT INTO public.perfil VALUES (52, 52, 'code0052itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0052.jpg', 6, '2026-04-30 04:56:18');
INSERT INTO public.perfil VALUES (53, 53, 'bravo0053007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0053.jpg', 3, '2026-02-23 09:44:47');
INSERT INTO public.perfil VALUES (54, 54, 'tech0054star', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0054.jpg', NULL, '2026-02-10 19:31:06');
INSERT INTO public.perfil VALUES (55, 55, 'bravo0055star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0055.jpg', NULL, '2026-01-13 00:22:56');
INSERT INTO public.perfil VALUES (56, 56, 'pascal0056123', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0056.jpg', NULL, '2026-05-09 01:51:04');
INSERT INTO public.perfil VALUES (57, 57, 'campus0057007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0057.jpg', 2, '2026-02-27 15:16:21');
INSERT INTO public.perfil VALUES (58, 58, 'campus00582026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0058.jpg', NULL, '2026-02-08 22:55:32');
INSERT INTO public.perfil VALUES (59, 59, 'tech00592026', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0059.jpg', 2, '2026-01-28 19:39:50');
INSERT INTO public.perfil VALUES (60, 60, 'tech00602026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0060.jpg', NULL, '2026-01-31 06:58:23');
INSERT INTO public.perfil VALUES (61, 61, 'dev0061medellin', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0061.jpg', 8, '2026-01-26 04:41:23');
INSERT INTO public.perfil VALUES (62, 62, 'campus0062col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0062.jpg', 8, '2026-04-17 00:15:53');
INSERT INTO public.perfil VALUES (63, 63, 'uni0063123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0063.jpg', 2, '2026-03-10 11:45:48');
INSERT INTO public.perfil VALUES (64, 64, 'bravo0064123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0064.jpg', NULL, '2026-05-16 13:50:14');
INSERT INTO public.perfil VALUES (65, 65, 'dev0065007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0065.jpg', 8, '2026-05-13 21:23:01');
INSERT INTO public.perfil VALUES (66, 66, 'uni0066col', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0066.jpg', 9, '2026-01-18 02:21:20');
INSERT INTO public.perfil VALUES (67, 67, 'bravo0067col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0067.jpg', NULL, '2026-01-10 21:59:41');
INSERT INTO public.perfil VALUES (68, 68, 'dev00682026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0068.jpg', 7, '2026-04-13 21:44:35');
INSERT INTO public.perfil VALUES (69, 69, 'pascal0069123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0069.jpg', NULL, '2026-03-13 16:39:58');
INSERT INTO public.perfil VALUES (70, 70, 'dev0070007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0070.jpg', 9, '2026-04-24 22:22:56');
INSERT INTO public.perfil VALUES (71, 71, 'bravo0071itpb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0071.jpg', NULL, '2026-05-18 10:24:46');
INSERT INTO public.perfil VALUES (72, 72, 'dev0072medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0072.jpg', NULL, '2026-03-21 16:21:48');
INSERT INTO public.perfil VALUES (73, 73, 'dev00732026', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0073.jpg', 9, '2026-03-08 07:53:49');
INSERT INTO public.perfil VALUES (74, 74, 'pascal0074007', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0074.jpg', NULL, '2026-01-16 11:16:40');
INSERT INTO public.perfil VALUES (75, 75, 'campus0075pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0075.jpg', 2, '2026-04-25 09:36:47');
INSERT INTO public.perfil VALUES (76, 76, 'ing0076star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0076.jpg', 10, '2026-05-17 19:14:22');
INSERT INTO public.perfil VALUES (77, 77, 'pascal0077medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0077.jpg', 7, '2026-05-14 23:15:06');
INSERT INTO public.perfil VALUES (78, 78, 'campus0078itpb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0078.jpg', 3, '2026-04-19 13:05:05');
INSERT INTO public.perfil VALUES (79, 79, 'ing0079007', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0079.jpg', 8, '2026-01-20 11:43:33');
INSERT INTO public.perfil VALUES (80, 80, 'bravo0080007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0080.jpg', 7, '2026-04-23 22:59:31');
INSERT INTO public.perfil VALUES (81, 81, 'bravo0081col', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0081.jpg', 8, '2026-04-28 04:45:32');
INSERT INTO public.perfil VALUES (82, 82, 'tech0082itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0082.jpg', 3, '2026-04-05 03:38:54');
INSERT INTO public.perfil VALUES (83, 83, 'bravo0083pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0083.jpg', NULL, '2026-03-16 01:33:09');
INSERT INTO public.perfil VALUES (84, 84, 'tech0084123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0084.jpg', 5, '2026-03-17 15:01:50');
INSERT INTO public.perfil VALUES (85, 85, 'dev0085col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0085.jpg', 5, '2026-03-14 06:11:52');
INSERT INTO public.perfil VALUES (86, 86, 'uni00862026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0086.jpg', 2, '2026-01-12 13:30:36');
INSERT INTO public.perfil VALUES (87, 87, 'pascal0087star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0087.jpg', 8, '2026-02-03 04:32:40');
INSERT INTO public.perfil VALUES (88, 88, 'uni0088star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0088.jpg', NULL, '2026-03-25 02:51:39');
INSERT INTO public.perfil VALUES (89, 89, 'bravo0089007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0089.jpg', 6, '2026-05-19 01:42:56');
INSERT INTO public.perfil VALUES (90, 90, 'uni0090medellin', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0090.jpg', 1, '2026-03-21 17:41:07');
INSERT INTO public.perfil VALUES (91, 91, 'tech0091itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0091.jpg', 1, '2026-05-14 06:48:30');
INSERT INTO public.perfil VALUES (92, 92, 'ing0092pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0092.jpg', NULL, '2026-01-05 08:50:13');
INSERT INTO public.perfil VALUES (93, 93, 'code0093star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0093.jpg', 10, '2026-03-24 12:37:02');
INSERT INTO public.perfil VALUES (94, 94, 'uni00942026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0094.jpg', 7, '2026-01-07 16:20:24');
INSERT INTO public.perfil VALUES (95, 95, 'pascal0095pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0095.jpg', 9, '2026-02-13 09:09:11');
INSERT INTO public.perfil VALUES (96, 96, 'pascal0096pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0096.jpg', NULL, '2026-04-15 21:10:03');
INSERT INTO public.perfil VALUES (97, 97, 'campus0097col', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0097.jpg', 5, '2026-04-10 03:20:09');
INSERT INTO public.perfil VALUES (98, 98, 'bravo0098123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0098.jpg', NULL, '2026-01-31 01:12:15');
INSERT INTO public.perfil VALUES (99, 99, 'code0099star', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0099.jpg', 7, '2026-01-30 08:03:20');
INSERT INTO public.perfil VALUES (100, 100, 'uni0100007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0100.jpg', 7, '2026-03-01 00:17:35');
INSERT INTO public.perfil VALUES (101, 101, 'tech0101itpb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0101.jpg', 3, '2026-03-19 18:26:28');
INSERT INTO public.perfil VALUES (102, 102, 'tech0102itpb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0102.jpg', NULL, '2026-02-13 07:34:27');
INSERT INTO public.perfil VALUES (103, 103, 'uni01032026', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0103.jpg', 10, '2026-03-16 20:10:00');
INSERT INTO public.perfil VALUES (104, 104, 'ing0104star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0104.jpg', 7, '2026-03-31 20:13:37');
INSERT INTO public.perfil VALUES (105, 105, 'pascal01052026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0105.jpg', 10, '2026-01-18 09:05:25');
INSERT INTO public.perfil VALUES (106, 106, 'tech0106col', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0106.jpg', 7, '2026-02-23 19:32:51');
INSERT INTO public.perfil VALUES (107, 107, 'campus0107123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0107.jpg', 8, '2026-03-11 07:42:20');
INSERT INTO public.perfil VALUES (108, 108, 'campus0108itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0108.jpg', 6, '2026-01-05 22:08:41');
INSERT INTO public.perfil VALUES (109, 109, 'ing0109star', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0109.jpg', 3, '2026-04-16 17:57:44');
INSERT INTO public.perfil VALUES (110, 110, 'uni0110007', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0110.jpg', NULL, '2026-01-20 17:01:57');
INSERT INTO public.perfil VALUES (111, 111, 'uni0111pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0111.jpg', 7, '2026-04-02 12:11:53');
INSERT INTO public.perfil VALUES (112, 112, 'ing0112pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0112.jpg', NULL, '2026-02-19 14:00:14');
INSERT INTO public.perfil VALUES (113, 113, 'ing0113medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0113.jpg', NULL, '2026-03-19 22:14:14');
INSERT INTO public.perfil VALUES (114, 114, 'uni0114123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0114.jpg', NULL, '2026-02-23 00:12:52');
INSERT INTO public.perfil VALUES (115, 115, 'bravo0115pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0115.jpg', 8, '2026-02-13 17:12:42');
INSERT INTO public.perfil VALUES (116, 116, 'dev0116pb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0116.jpg', NULL, '2026-01-17 04:16:59');
INSERT INTO public.perfil VALUES (117, 117, 'code0117medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0117.jpg', 1, '2026-05-17 19:16:43');
INSERT INTO public.perfil VALUES (118, 118, 'uni01182026', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0118.jpg', 1, '2026-03-24 13:54:26');
INSERT INTO public.perfil VALUES (119, 119, 'pascal0119pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0119.jpg', 6, '2026-05-13 01:56:46');
INSERT INTO public.perfil VALUES (120, 120, 'code01202026', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0120.jpg', 9, '2026-04-25 10:00:25');
INSERT INTO public.perfil VALUES (121, 121, 'code0121123', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0121.jpg', 1, '2026-02-27 22:27:04');
INSERT INTO public.perfil VALUES (122, 122, 'code0122itpb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0122.jpg', NULL, '2026-01-17 20:40:06');
INSERT INTO public.perfil VALUES (123, 123, 'ing0123star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0123.jpg', 10, '2026-03-27 08:15:06');
INSERT INTO public.perfil VALUES (124, 124, 'uni0124itpb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0124.jpg', 6, '2026-05-14 07:04:49');
INSERT INTO public.perfil VALUES (125, 125, 'uni0125pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0125.jpg', 2, '2026-01-16 01:24:20');
INSERT INTO public.perfil VALUES (126, 126, 'tech0126col', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0126.jpg', 8, '2026-01-15 09:39:40');
INSERT INTO public.perfil VALUES (127, 127, 'bravo0127pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0127.jpg', 9, '2026-01-14 09:54:24');
INSERT INTO public.perfil VALUES (128, 128, 'bravo0128pb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0128.jpg', 4, '2026-01-03 14:24:29');
INSERT INTO public.perfil VALUES (129, 129, 'bravo0129pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0129.jpg', 1, '2026-04-27 16:21:37');
INSERT INTO public.perfil VALUES (130, 130, 'code0130pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0130.jpg', NULL, '2026-01-18 18:50:53');
INSERT INTO public.perfil VALUES (131, 131, 'code0131col', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0131.jpg', NULL, '2026-04-18 15:46:39');
INSERT INTO public.perfil VALUES (132, 132, 'uni0132col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0132.jpg', NULL, '2026-01-12 01:08:19');
INSERT INTO public.perfil VALUES (133, 133, 'bravo0133123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0133.jpg', 9, '2026-02-07 04:30:19');
INSERT INTO public.perfil VALUES (134, 134, 'campus0134medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0134.jpg', 9, '2026-02-07 01:15:32');
INSERT INTO public.perfil VALUES (135, 135, 'ing0135007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0135.jpg', NULL, '2026-02-21 20:58:12');
INSERT INTO public.perfil VALUES (136, 136, 'tech0136123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0136.jpg', 8, '2026-03-26 18:36:21');
INSERT INTO public.perfil VALUES (137, 137, 'pascal0137007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0137.jpg', NULL, '2026-04-27 01:31:14');
INSERT INTO public.perfil VALUES (138, 138, 'ing0138itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0138.jpg', 4, '2026-03-03 15:47:49');
INSERT INTO public.perfil VALUES (139, 139, 'campus0139007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0139.jpg', 1, '2026-04-03 00:04:22');
INSERT INTO public.perfil VALUES (140, 140, 'ing0140pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0140.jpg', NULL, '2026-02-19 20:37:58');
INSERT INTO public.perfil VALUES (141, 141, 'campus01412026', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0141.jpg', NULL, '2026-03-14 05:14:56');
INSERT INTO public.perfil VALUES (142, 142, 'pascal0142col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0142.jpg', 4, '2026-02-15 06:01:11');
INSERT INTO public.perfil VALUES (143, 143, 'pascal0143pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0143.jpg', 3, '2026-04-08 20:50:56');
INSERT INTO public.perfil VALUES (144, 144, 'tech0144123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0144.jpg', NULL, '2026-03-03 11:51:23');
INSERT INTO public.perfil VALUES (145, 145, 'dev0145007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0145.jpg', NULL, '2026-02-03 06:12:34');
INSERT INTO public.perfil VALUES (146, 146, 'bravo0146123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0146.jpg', 4, '2026-01-12 19:37:12');
INSERT INTO public.perfil VALUES (147, 147, 'pascal0147col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0147.jpg', NULL, '2026-03-13 04:54:32');
INSERT INTO public.perfil VALUES (148, 148, 'uni0148itpb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0148.jpg', 10, '2026-01-17 05:32:24');
INSERT INTO public.perfil VALUES (149, 149, 'campus0149star', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0149.jpg', 6, '2026-04-06 16:44:30');
INSERT INTO public.perfil VALUES (150, 150, 'uni0150star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0150.jpg', 10, '2026-01-10 06:14:57');
INSERT INTO public.perfil VALUES (151, 151, 'code0151star', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0151.jpg', NULL, '2026-03-20 13:56:24');
INSERT INTO public.perfil VALUES (152, 152, 'dev0152123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0152.jpg', 3, '2026-01-22 09:28:33');
INSERT INTO public.perfil VALUES (153, 153, 'campus0153itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0153.jpg', NULL, '2026-05-12 19:21:27');
INSERT INTO public.perfil VALUES (154, 154, 'uni0154star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0154.jpg', 8, '2026-03-23 08:24:01');
INSERT INTO public.perfil VALUES (155, 155, 'dev0155star', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0155.jpg', NULL, '2026-01-20 11:57:05');
INSERT INTO public.perfil VALUES (156, 156, 'pascal0156pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0156.jpg', 2, '2026-01-31 02:23:02');
INSERT INTO public.perfil VALUES (157, 157, 'code0157123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0157.jpg', 5, '2026-03-19 23:52:49');
INSERT INTO public.perfil VALUES (158, 158, 'pascal0158itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0158.jpg', 9, '2026-03-08 00:49:19');
INSERT INTO public.perfil VALUES (159, 159, 'pascal0159123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0159.jpg', 10, '2026-01-04 15:41:32');
INSERT INTO public.perfil VALUES (160, 160, 'dev0160007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0160.jpg', NULL, '2026-02-23 15:14:33');
INSERT INTO public.perfil VALUES (161, 161, 'uni0161star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0161.jpg', 6, '2026-02-18 13:49:44');
INSERT INTO public.perfil VALUES (162, 162, 'bravo0162itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0162.jpg', 9, '2026-01-08 11:08:36');
INSERT INTO public.perfil VALUES (163, 163, 'dev0163medellin', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0163.jpg', 6, '2026-03-28 07:26:27');
INSERT INTO public.perfil VALUES (164, 164, 'bravo0164medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0164.jpg', 10, '2026-01-09 04:09:21');
INSERT INTO public.perfil VALUES (165, 165, 'bravo0165007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0165.jpg', 2, '2026-05-17 12:12:30');
INSERT INTO public.perfil VALUES (166, 166, 'tech0166123', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0166.jpg', 5, '2026-01-24 05:06:43');
INSERT INTO public.perfil VALUES (167, 167, 'dev01672026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0167.jpg', 3, '2026-02-20 02:58:24');
INSERT INTO public.perfil VALUES (168, 168, 'pascal0168itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0168.jpg', NULL, '2026-05-15 02:29:03');
INSERT INTO public.perfil VALUES (169, 169, 'campus01692026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0169.jpg', NULL, '2026-04-16 12:10:07');
INSERT INTO public.perfil VALUES (170, 170, 'dev0170007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0170.jpg', 7, '2026-02-22 04:55:13');
INSERT INTO public.perfil VALUES (171, 171, 'pascal0171007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0171.jpg', NULL, '2026-03-21 18:12:32');
INSERT INTO public.perfil VALUES (172, 172, 'uni0172medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0172.jpg', NULL, '2026-02-06 14:04:52');
INSERT INTO public.perfil VALUES (173, 173, 'bravo0173itpb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0173.jpg', NULL, '2026-05-06 14:29:36');
INSERT INTO public.perfil VALUES (174, 174, 'ing0174pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0174.jpg', 8, '2026-03-30 22:53:45');
INSERT INTO public.perfil VALUES (175, 175, 'pascal0175007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0175.jpg', 3, '2026-04-17 07:11:57');
INSERT INTO public.perfil VALUES (176, 176, 'bravo0176star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0176.jpg', 3, '2026-01-25 12:44:02');
INSERT INTO public.perfil VALUES (177, 177, 'code0177col', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0177.jpg', 9, '2026-03-16 21:58:04');
INSERT INTO public.perfil VALUES (178, 178, 'code0178star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0178.jpg', 9, '2026-02-01 11:04:48');
INSERT INTO public.perfil VALUES (179, 179, 'tech0179123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0179.jpg', 5, '2026-02-23 16:02:29');
INSERT INTO public.perfil VALUES (180, 180, 'ing0180pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0180.jpg', NULL, '2026-04-13 06:25:02');
INSERT INTO public.perfil VALUES (181, 181, 'ing0181medellin', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0181.jpg', 3, '2026-03-25 21:47:29');
INSERT INTO public.perfil VALUES (182, 182, 'uni0182star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0182.jpg', NULL, '2026-03-04 22:28:08');
INSERT INTO public.perfil VALUES (183, 183, 'uni0183medellin', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0183.jpg', NULL, '2026-01-05 19:06:11');
INSERT INTO public.perfil VALUES (184, 184, 'pascal0184pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0184.jpg', 3, '2026-01-20 21:48:00');
INSERT INTO public.perfil VALUES (185, 185, 'pascal0185col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0185.jpg', NULL, '2026-02-25 22:02:57');
INSERT INTO public.perfil VALUES (186, 186, 'code0186star', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0186.jpg', 9, '2026-01-27 12:44:19');
INSERT INTO public.perfil VALUES (187, 187, 'uni01872026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0187.jpg', NULL, '2026-04-07 06:59:15');
INSERT INTO public.perfil VALUES (188, 188, 'campus0188itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0188.jpg', NULL, '2026-04-18 00:00:21');
INSERT INTO public.perfil VALUES (189, 189, 'code0189pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0189.jpg', 2, '2026-02-12 23:10:02');
INSERT INTO public.perfil VALUES (190, 190, 'bravo0190pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0190.jpg', NULL, '2026-02-18 19:13:59');
INSERT INTO public.perfil VALUES (191, 191, 'bravo0191007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0191.jpg', NULL, '2026-01-28 11:20:11');
INSERT INTO public.perfil VALUES (192, 192, 'ing0192007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0192.jpg', NULL, '2026-02-24 14:14:04');
INSERT INTO public.perfil VALUES (193, 193, 'pascal0193123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0193.jpg', NULL, '2026-02-25 13:19:49');
INSERT INTO public.perfil VALUES (194, 194, 'uni0194pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0194.jpg', 10, '2026-02-13 08:06:38');
INSERT INTO public.perfil VALUES (195, 195, 'campus0195007', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0195.jpg', NULL, '2026-03-23 21:30:04');
INSERT INTO public.perfil VALUES (196, 196, 'campus01962026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0196.jpg', 8, '2026-04-08 16:40:47');
INSERT INTO public.perfil VALUES (197, 197, 'code01972026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0197.jpg', NULL, '2026-02-01 09:15:47');
INSERT INTO public.perfil VALUES (198, 198, 'bravo0198itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0198.jpg', NULL, '2026-02-05 11:31:18');
INSERT INTO public.perfil VALUES (199, 199, 'code0199col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0199.jpg', NULL, '2026-01-10 07:59:46');
INSERT INTO public.perfil VALUES (200, 200, 'uni0200123', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0200.jpg', NULL, '2026-01-11 16:50:26');
INSERT INTO public.perfil VALUES (201, 201, 'pascal02012026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0201.jpg', 6, '2026-03-29 07:13:34');
INSERT INTO public.perfil VALUES (202, 202, 'ing0202itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0202.jpg', 7, '2026-05-14 10:11:28');
INSERT INTO public.perfil VALUES (203, 203, 'ing0203pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0203.jpg', NULL, '2026-02-19 01:40:09');
INSERT INTO public.perfil VALUES (204, 204, 'code0204col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0204.jpg', NULL, '2026-05-21 06:15:32');
INSERT INTO public.perfil VALUES (205, 205, 'tech0205007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0205.jpg', NULL, '2026-02-20 07:27:11');
INSERT INTO public.perfil VALUES (206, 206, 'code0206medellin', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0206.jpg', 4, '2026-03-11 15:05:23');
INSERT INTO public.perfil VALUES (207, 207, 'bravo0207007', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0207.jpg', 7, '2026-05-10 19:47:27');
INSERT INTO public.perfil VALUES (208, 208, 'dev0208star', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0208.jpg', 7, '2026-01-22 09:38:34');
INSERT INTO public.perfil VALUES (209, 209, 'dev0209col', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0209.jpg', NULL, '2026-03-20 14:18:24');
INSERT INTO public.perfil VALUES (210, 210, 'uni0210pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0210.jpg', NULL, '2026-05-01 06:09:58');
INSERT INTO public.perfil VALUES (211, 211, 'code02112026', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0211.jpg', 6, '2026-05-06 12:59:26');
INSERT INTO public.perfil VALUES (212, 212, 'bravo0212123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0212.jpg', 10, '2026-01-19 13:56:02');
INSERT INTO public.perfil VALUES (213, 213, 'tech0213007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0213.jpg', NULL, '2026-04-22 08:49:58');
INSERT INTO public.perfil VALUES (214, 214, 'campus0214star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0214.jpg', 7, '2026-04-19 23:15:15');
INSERT INTO public.perfil VALUES (215, 215, 'uni02152026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0215.jpg', 1, '2026-02-07 08:38:29');
INSERT INTO public.perfil VALUES (216, 216, 'dev0216medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0216.jpg', 3, '2026-01-04 03:49:05');
INSERT INTO public.perfil VALUES (217, 217, 'bravo0217007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0217.jpg', 2, '2026-05-13 06:56:27');
INSERT INTO public.perfil VALUES (218, 218, 'dev0218007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0218.jpg', 9, '2026-05-17 21:56:24');
INSERT INTO public.perfil VALUES (219, 219, 'pascal0219007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0219.jpg', NULL, '2026-03-30 04:17:47');
INSERT INTO public.perfil VALUES (220, 220, 'code0220007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0220.jpg', NULL, '2026-02-13 15:00:06');
INSERT INTO public.perfil VALUES (221, 221, 'tech0221007', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0221.jpg', 5, '2026-04-21 05:11:23');
INSERT INTO public.perfil VALUES (222, 222, 'dev0222col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0222.jpg', 9, '2026-01-29 14:36:52');
INSERT INTO public.perfil VALUES (223, 223, 'code0223col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0223.jpg', NULL, '2026-02-16 06:16:57');
INSERT INTO public.perfil VALUES (224, 224, 'bravo0224star', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0224.jpg', NULL, '2026-02-12 02:18:05');
INSERT INTO public.perfil VALUES (225, 225, 'bravo0225pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0225.jpg', NULL, '2026-01-08 18:15:30');
INSERT INTO public.perfil VALUES (226, 226, 'uni0226pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0226.jpg', NULL, '2026-01-02 21:37:50');
INSERT INTO public.perfil VALUES (227, 227, 'ing0227pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0227.jpg', 1, '2026-04-07 19:33:48');
INSERT INTO public.perfil VALUES (228, 228, 'pascal0228star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0228.jpg', 10, '2026-04-20 10:23:43');
INSERT INTO public.perfil VALUES (229, 229, 'campus0229123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0229.jpg', 7, '2026-04-07 19:03:22');
INSERT INTO public.perfil VALUES (230, 230, 'campus0230pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0230.jpg', 7, '2026-02-05 00:38:07');
INSERT INTO public.perfil VALUES (231, 231, 'pascal0231itpb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0231.jpg', 8, '2026-05-12 13:42:12');
INSERT INTO public.perfil VALUES (232, 232, 'ing0232123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0232.jpg', 1, '2026-03-25 21:28:14');
INSERT INTO public.perfil VALUES (233, 233, 'uni0233007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0233.jpg', 6, '2026-04-20 15:42:54');
INSERT INTO public.perfil VALUES (234, 234, 'tech0234007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0234.jpg', 3, '2026-05-14 18:50:54');
INSERT INTO public.perfil VALUES (235, 235, 'ing0235col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0235.jpg', 5, '2026-05-21 14:10:57');
INSERT INTO public.perfil VALUES (236, 236, 'uni0236pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0236.jpg', 4, '2026-03-04 06:10:48');
INSERT INTO public.perfil VALUES (237, 237, 'tech0237pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0237.jpg', 1, '2026-02-11 10:57:24');
INSERT INTO public.perfil VALUES (238, 238, 'pascal0238itpb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0238.jpg', 2, '2026-02-04 17:40:46');
INSERT INTO public.perfil VALUES (239, 239, 'uni0239pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0239.jpg', 10, '2026-01-17 20:21:24');
INSERT INTO public.perfil VALUES (240, 240, 'bravo0240007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0240.jpg', NULL, '2026-01-30 09:05:07');
INSERT INTO public.perfil VALUES (241, 241, 'tech0241123', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0241.jpg', 2, '2026-04-05 04:54:20');
INSERT INTO public.perfil VALUES (242, 242, 'bravo02422026', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0242.jpg', NULL, '2026-05-18 06:54:24');
INSERT INTO public.perfil VALUES (243, 243, 'bravo0243123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0243.jpg', 3, '2026-05-14 21:38:37');
INSERT INTO public.perfil VALUES (244, 244, 'code0244pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0244.jpg', NULL, '2026-04-28 10:09:52');
INSERT INTO public.perfil VALUES (245, 245, 'pascal0245itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0245.jpg', 3, '2026-03-14 04:47:42');
INSERT INTO public.perfil VALUES (246, 246, 'ing0246123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0246.jpg', 2, '2026-03-12 22:36:30');
INSERT INTO public.perfil VALUES (247, 247, 'code0247star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0247.jpg', 7, '2026-01-16 10:09:52');
INSERT INTO public.perfil VALUES (248, 248, 'code0248itpb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0248.jpg', 3, '2026-05-05 23:25:19');
INSERT INTO public.perfil VALUES (249, 249, 'dev02492026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0249.jpg', NULL, '2026-04-19 21:30:22');
INSERT INTO public.perfil VALUES (250, 250, 'bravo0250007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0250.jpg', 5, '2026-03-14 22:59:12');
INSERT INTO public.perfil VALUES (251, 251, 'bravo0251pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0251.jpg', NULL, '2026-01-14 22:19:29');
INSERT INTO public.perfil VALUES (252, 252, 'dev0252col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0252.jpg', 5, '2026-02-07 06:13:51');
INSERT INTO public.perfil VALUES (253, 253, 'code02532026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0253.jpg', 10, '2026-01-27 21:50:54');
INSERT INTO public.perfil VALUES (254, 254, 'dev0254007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0254.jpg', 3, '2026-01-15 03:22:30');
INSERT INTO public.perfil VALUES (255, 255, 'dev02552026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0255.jpg', 6, '2026-04-22 04:40:46');
INSERT INTO public.perfil VALUES (256, 256, 'bravo0256itpb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0256.jpg', NULL, '2026-04-12 15:19:44');
INSERT INTO public.perfil VALUES (257, 257, 'dev0257007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0257.jpg', 7, '2026-03-12 20:41:28');
INSERT INTO public.perfil VALUES (258, 258, 'campus02582026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0258.jpg', NULL, '2026-02-01 15:41:42');
INSERT INTO public.perfil VALUES (259, 259, 'code02592026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0259.jpg', 10, '2026-05-03 08:44:47');
INSERT INTO public.perfil VALUES (260, 260, 'tech0260col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0260.jpg', 7, '2026-03-18 18:08:06');
INSERT INTO public.perfil VALUES (261, 261, 'campus0261pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0261.jpg', NULL, '2026-01-06 12:35:52');
INSERT INTO public.perfil VALUES (262, 262, 'uni0262pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0262.jpg', 9, '2026-02-01 06:42:57');
INSERT INTO public.perfil VALUES (263, 263, 'tech0263col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0263.jpg', 1, '2026-04-25 10:07:02');
INSERT INTO public.perfil VALUES (264, 264, 'dev0264itpb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0264.jpg', NULL, '2026-03-07 01:05:07');
INSERT INTO public.perfil VALUES (265, 265, 'pascal0265123', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0265.jpg', NULL, '2026-01-01 07:19:02');
INSERT INTO public.perfil VALUES (266, 266, 'pascal0266star', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0266.jpg', 6, '2026-05-14 11:38:34');
INSERT INTO public.perfil VALUES (267, 267, 'code0267pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0267.jpg', NULL, '2026-02-18 04:19:54');
INSERT INTO public.perfil VALUES (268, 268, 'code0268col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0268.jpg', 10, '2026-04-02 08:08:46');
INSERT INTO public.perfil VALUES (269, 269, 'bravo0269pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0269.jpg', NULL, '2026-04-08 20:57:10');
INSERT INTO public.perfil VALUES (270, 270, 'bravo0270star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0270.jpg', 7, '2026-02-06 17:13:04');
INSERT INTO public.perfil VALUES (271, 271, 'pascal0271itpb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0271.jpg', 9, '2026-02-11 13:52:09');
INSERT INTO public.perfil VALUES (272, 272, 'campus0272007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0272.jpg', NULL, '2026-03-05 02:17:07');
INSERT INTO public.perfil VALUES (273, 273, 'tech0273007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0273.jpg', NULL, '2026-01-23 11:58:21');
INSERT INTO public.perfil VALUES (274, 274, 'pascal0274col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0274.jpg', NULL, '2026-01-26 12:14:24');
INSERT INTO public.perfil VALUES (275, 275, 'tech0275pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0275.jpg', 5, '2026-05-06 03:33:22');
INSERT INTO public.perfil VALUES (276, 276, 'pascal0276medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0276.jpg', NULL, '2026-01-13 05:20:48');
INSERT INTO public.perfil VALUES (277, 277, 'bravo0277col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0277.jpg', 9, '2026-04-14 15:37:08');
INSERT INTO public.perfil VALUES (278, 278, 'pascal02782026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0278.jpg', 3, '2026-02-06 12:36:47');
INSERT INTO public.perfil VALUES (279, 279, 'pascal02792026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0279.jpg', 4, '2026-04-18 22:29:11');
INSERT INTO public.perfil VALUES (280, 280, 'uni0280123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0280.jpg', 5, '2026-04-20 16:45:56');
INSERT INTO public.perfil VALUES (281, 281, 'code0281medellin', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0281.jpg', 7, '2026-03-22 02:40:05');
INSERT INTO public.perfil VALUES (282, 282, 'tech0282itpb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0282.jpg', NULL, '2026-01-15 02:47:18');
INSERT INTO public.perfil VALUES (283, 283, 'uni02832026', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0283.jpg', 3, '2026-05-03 15:32:43');
INSERT INTO public.perfil VALUES (284, 284, 'tech0284007', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0284.jpg', 1, '2026-04-19 22:34:47');
INSERT INTO public.perfil VALUES (285, 285, 'campus0285itpb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0285.jpg', 1, '2026-04-25 05:43:59');
INSERT INTO public.perfil VALUES (286, 286, 'code0286col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0286.jpg', NULL, '2026-02-04 16:22:03');
INSERT INTO public.perfil VALUES (287, 287, 'bravo0287star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0287.jpg', NULL, '2026-01-29 10:58:43');
INSERT INTO public.perfil VALUES (288, 288, 'code0288pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0288.jpg', NULL, '2026-03-17 08:13:00');
INSERT INTO public.perfil VALUES (289, 289, 'bravo0289itpb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0289.jpg', 9, '2026-01-10 14:57:39');
INSERT INTO public.perfil VALUES (290, 290, 'uni02902026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0290.jpg', NULL, '2026-04-28 10:19:22');
INSERT INTO public.perfil VALUES (291, 291, 'tech02912026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0291.jpg', 3, '2026-04-13 11:00:06');
INSERT INTO public.perfil VALUES (292, 292, 'bravo0292star', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0292.jpg', NULL, '2026-05-12 04:26:07');
INSERT INTO public.perfil VALUES (293, 293, 'uni02932026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0293.jpg', 5, '2026-02-27 15:25:23');
INSERT INTO public.perfil VALUES (294, 294, 'pascal0294123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0294.jpg', 9, '2026-03-10 03:28:42');
INSERT INTO public.perfil VALUES (295, 295, 'uni0295col', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0295.jpg', NULL, '2026-04-22 00:22:56');
INSERT INTO public.perfil VALUES (296, 296, 'code0296pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0296.jpg', NULL, '2026-02-04 12:26:47');
INSERT INTO public.perfil VALUES (297, 297, 'campus02972026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0297.jpg', 8, '2026-03-10 03:26:31');
INSERT INTO public.perfil VALUES (298, 298, 'uni0298col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0298.jpg', 7, '2026-05-09 23:59:47');
INSERT INTO public.perfil VALUES (299, 299, 'bravo0299col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0299.jpg', 1, '2026-02-02 04:22:32');
INSERT INTO public.perfil VALUES (300, 300, 'ing0300itpb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0300.jpg', 6, '2026-04-20 19:47:00');
INSERT INTO public.perfil VALUES (301, 301, 'bravo0301star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0301.jpg', NULL, '2026-01-22 13:15:39');
INSERT INTO public.perfil VALUES (302, 302, 'dev0302col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0302.jpg', NULL, '2026-01-30 08:44:15');
INSERT INTO public.perfil VALUES (303, 303, 'bravo0303itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0303.jpg', 2, '2026-05-09 19:11:12');
INSERT INTO public.perfil VALUES (304, 304, 'dev0304itpb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0304.jpg', NULL, '2026-01-10 08:12:59');
INSERT INTO public.perfil VALUES (305, 305, 'dev0305007', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0305.jpg', 2, '2026-01-14 12:26:33');
INSERT INTO public.perfil VALUES (306, 306, 'pascal0306itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0306.jpg', NULL, '2026-05-03 01:32:27');
INSERT INTO public.perfil VALUES (307, 307, 'ing0307medellin', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0307.jpg', NULL, '2026-03-13 11:45:26');
INSERT INTO public.perfil VALUES (308, 308, 'code0308123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0308.jpg', NULL, '2026-01-01 01:42:47');
INSERT INTO public.perfil VALUES (309, 309, 'campus0309itpb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0309.jpg', 10, '2026-01-26 13:11:16');
INSERT INTO public.perfil VALUES (310, 310, 'uni0310123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0310.jpg', NULL, '2026-01-25 21:00:43');
INSERT INTO public.perfil VALUES (311, 311, 'dev0311123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0311.jpg', 6, '2026-05-16 19:23:15');
INSERT INTO public.perfil VALUES (312, 312, 'pascal0312itpb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0312.jpg', NULL, '2026-01-28 04:40:47');
INSERT INTO public.perfil VALUES (313, 313, 'tech03132026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0313.jpg', 4, '2026-02-19 22:28:59');
INSERT INTO public.perfil VALUES (314, 314, 'tech0314pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0314.jpg', 5, '2026-05-02 06:34:46');
INSERT INTO public.perfil VALUES (315, 315, 'dev03152026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0315.jpg', NULL, '2026-05-21 22:16:57');
INSERT INTO public.perfil VALUES (316, 316, 'campus0316123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0316.jpg', 2, '2026-04-22 02:30:26');
INSERT INTO public.perfil VALUES (317, 317, 'ing0317col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0317.jpg', NULL, '2026-02-03 09:02:36');
INSERT INTO public.perfil VALUES (318, 318, 'ing0318itpb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0318.jpg', 9, '2026-05-12 02:10:28');
INSERT INTO public.perfil VALUES (319, 319, 'bravo0319007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0319.jpg', 4, '2026-02-17 00:10:36');
INSERT INTO public.perfil VALUES (320, 320, 'code03202026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0320.jpg', 9, '2026-03-08 09:54:14');
INSERT INTO public.perfil VALUES (321, 321, 'pascal0321medellin', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0321.jpg', NULL, '2026-02-27 01:34:15');
INSERT INTO public.perfil VALUES (322, 322, 'pascal03222026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0322.jpg', 5, '2026-02-04 08:55:50');
INSERT INTO public.perfil VALUES (323, 323, 'ing0323itpb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0323.jpg', 1, '2026-03-30 20:38:23');
INSERT INTO public.perfil VALUES (324, 324, 'campus0324pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0324.jpg', NULL, '2026-02-04 13:57:39');
INSERT INTO public.perfil VALUES (325, 325, 'pascal0325123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0325.jpg', 1, '2026-04-02 07:46:17');
INSERT INTO public.perfil VALUES (326, 326, 'dev0326medellin', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0326.jpg', 10, '2026-01-28 23:47:44');
INSERT INTO public.perfil VALUES (327, 327, 'bravo0327medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0327.jpg', 8, '2026-02-26 10:17:13');
INSERT INTO public.perfil VALUES (328, 328, 'bravo0328col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0328.jpg', NULL, '2026-04-22 11:09:57');
INSERT INTO public.perfil VALUES (329, 329, 'uni0329pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0329.jpg', NULL, '2026-02-17 05:12:36');
INSERT INTO public.perfil VALUES (330, 330, 'uni0330col', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0330.jpg', NULL, '2026-02-11 05:52:25');
INSERT INTO public.perfil VALUES (331, 331, 'code0331pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0331.jpg', NULL, '2026-03-04 14:58:41');
INSERT INTO public.perfil VALUES (332, 332, 'bravo0332pb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0332.jpg', NULL, '2026-01-04 19:06:24');
INSERT INTO public.perfil VALUES (333, 333, 'bravo03332026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0333.jpg', 1, '2026-02-03 07:49:05');
INSERT INTO public.perfil VALUES (334, 334, 'pascal0334col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0334.jpg', NULL, '2026-01-03 03:34:47');
INSERT INTO public.perfil VALUES (335, 335, 'campus0335pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0335.jpg', NULL, '2026-04-24 05:19:21');
INSERT INTO public.perfil VALUES (336, 336, 'uni0336col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0336.jpg', NULL, '2026-03-10 20:34:07');
INSERT INTO public.perfil VALUES (337, 337, 'ing03372026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0337.jpg', 2, '2026-05-11 13:09:00');
INSERT INTO public.perfil VALUES (338, 338, 'code03382026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0338.jpg', 3, '2026-04-01 20:18:14');
INSERT INTO public.perfil VALUES (339, 339, 'bravo0339pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0339.jpg', NULL, '2026-01-29 07:06:18');
INSERT INTO public.perfil VALUES (340, 340, 'campus0340pb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0340.jpg', NULL, '2026-04-03 02:57:02');
INSERT INTO public.perfil VALUES (341, 341, 'dev0341col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0341.jpg', 10, '2026-02-16 21:27:09');
INSERT INTO public.perfil VALUES (342, 342, 'pascal0342medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0342.jpg', 5, '2026-05-08 21:23:59');
INSERT INTO public.perfil VALUES (343, 343, 'pascal0343pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0343.jpg', 3, '2026-02-07 10:09:24');
INSERT INTO public.perfil VALUES (344, 344, 'uni0344star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0344.jpg', NULL, '2026-04-20 23:17:09');
INSERT INTO public.perfil VALUES (345, 345, 'tech0345123', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0345.jpg', NULL, '2026-04-09 11:20:31');
INSERT INTO public.perfil VALUES (346, 346, 'bravo0346star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0346.jpg', 6, '2026-02-05 20:58:15');
INSERT INTO public.perfil VALUES (347, 347, 'bravo0347007', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0347.jpg', 9, '2026-05-07 17:34:52');
INSERT INTO public.perfil VALUES (348, 348, 'code0348007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0348.jpg', 7, '2026-05-15 18:49:44');
INSERT INTO public.perfil VALUES (349, 349, 'code0349pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0349.jpg', NULL, '2026-02-22 00:23:35');
INSERT INTO public.perfil VALUES (350, 350, 'uni0350col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0350.jpg', NULL, '2026-03-31 11:54:54');
INSERT INTO public.perfil VALUES (351, 351, 'dev0351medellin', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0351.jpg', NULL, '2026-04-18 07:13:52');
INSERT INTO public.perfil VALUES (352, 352, 'code03522026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0352.jpg', NULL, '2026-02-06 12:46:01');
INSERT INTO public.perfil VALUES (353, 353, 'bravo0353123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0353.jpg', 10, '2026-01-19 15:53:38');
INSERT INTO public.perfil VALUES (354, 354, 'dev03542026', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0354.jpg', NULL, '2026-01-21 07:04:00');
INSERT INTO public.perfil VALUES (355, 355, 'bravo0355col', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0355.jpg', 3, '2026-05-16 22:19:30');
INSERT INTO public.perfil VALUES (356, 356, 'bravo0356123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0356.jpg', 1, '2026-03-15 03:09:03');
INSERT INTO public.perfil VALUES (357, 357, 'ing0357col', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0357.jpg', NULL, '2026-04-12 13:43:56');
INSERT INTO public.perfil VALUES (358, 358, 'uni0358medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0358.jpg', 4, '2026-04-19 05:17:05');
INSERT INTO public.perfil VALUES (359, 359, 'bravo0359col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0359.jpg', 1, '2026-02-26 12:11:52');
INSERT INTO public.perfil VALUES (360, 360, 'tech0360star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0360.jpg', NULL, '2026-04-14 12:10:03');
INSERT INTO public.perfil VALUES (361, 361, 'campus0361007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0361.jpg', NULL, '2026-01-27 02:23:38');
INSERT INTO public.perfil VALUES (362, 362, 'campus03622026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0362.jpg', NULL, '2026-05-19 03:04:13');
INSERT INTO public.perfil VALUES (363, 363, 'ing0363medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0363.jpg', 1, '2026-03-03 08:05:36');
INSERT INTO public.perfil VALUES (364, 364, 'ing0364star', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0364.jpg', NULL, '2026-01-24 09:00:22');
INSERT INTO public.perfil VALUES (365, 365, 'pascal0365007', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0365.jpg', NULL, '2026-04-11 23:22:08');
INSERT INTO public.perfil VALUES (366, 366, 'tech0366123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0366.jpg', 9, '2026-01-26 16:51:49');
INSERT INTO public.perfil VALUES (367, 367, 'dev03672026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0367.jpg', 8, '2026-01-10 09:10:09');
INSERT INTO public.perfil VALUES (368, 368, 'uni0368pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0368.jpg', 4, '2026-02-25 21:41:09');
INSERT INTO public.perfil VALUES (369, 369, 'dev0369123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0369.jpg', 6, '2026-03-16 11:39:54');
INSERT INTO public.perfil VALUES (370, 370, 'bravo03702026', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0370.jpg', NULL, '2026-01-20 04:36:40');
INSERT INTO public.perfil VALUES (371, 371, 'uni0371pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0371.jpg', NULL, '2026-03-21 17:55:51');
INSERT INTO public.perfil VALUES (372, 372, 'tech0372star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0372.jpg', 3, '2026-03-17 05:04:17');
INSERT INTO public.perfil VALUES (373, 373, 'campus0373123', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0373.jpg', NULL, '2026-04-28 08:30:16');
INSERT INTO public.perfil VALUES (374, 374, 'uni0374col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0374.jpg', 8, '2026-01-11 11:54:18');
INSERT INTO public.perfil VALUES (375, 375, 'bravo0375007', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0375.jpg', 3, '2026-04-23 11:32:54');
INSERT INTO public.perfil VALUES (376, 376, 'campus0376123', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0376.jpg', 9, '2026-04-26 08:56:56');
INSERT INTO public.perfil VALUES (377, 377, 'ing03772026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0377.jpg', 9, '2026-01-03 04:54:06');
INSERT INTO public.perfil VALUES (378, 378, 'pascal0378007', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0378.jpg', 2, '2026-02-27 12:55:29');
INSERT INTO public.perfil VALUES (379, 379, 'tech0379123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0379.jpg', 9, '2026-04-30 03:05:11');
INSERT INTO public.perfil VALUES (380, 380, 'tech0380007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0380.jpg', NULL, '2026-03-26 02:20:21');
INSERT INTO public.perfil VALUES (381, 381, 'uni0381itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0381.jpg', NULL, '2026-04-27 01:34:09');
INSERT INTO public.perfil VALUES (382, 382, 'uni0382col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0382.jpg', NULL, '2026-01-09 19:49:24');
INSERT INTO public.perfil VALUES (383, 383, 'ing0383123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0383.jpg', 4, '2026-01-14 06:55:01');
INSERT INTO public.perfil VALUES (384, 384, 'bravo0384medellin', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0384.jpg', 2, '2026-02-06 02:17:25');
INSERT INTO public.perfil VALUES (385, 385, 'tech0385medellin', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0385.jpg', 9, '2026-02-24 21:57:16');
INSERT INTO public.perfil VALUES (386, 386, 'dev03862026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0386.jpg', 7, '2026-03-29 09:10:12');
INSERT INTO public.perfil VALUES (387, 387, 'campus0387007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0387.jpg', 3, '2026-04-22 11:58:44');
INSERT INTO public.perfil VALUES (388, 388, 'bravo03882026', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0388.jpg', 10, '2026-02-20 02:46:42');
INSERT INTO public.perfil VALUES (389, 389, 'dev0389123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0389.jpg', NULL, '2026-04-28 04:31:55');
INSERT INTO public.perfil VALUES (390, 390, 'campus0390pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0390.jpg', NULL, '2026-01-01 14:53:54');
INSERT INTO public.perfil VALUES (391, 391, 'dev0391star', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0391.jpg', NULL, '2026-02-25 23:12:26');
INSERT INTO public.perfil VALUES (392, 392, 'dev0392007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0392.jpg', NULL, '2026-02-18 21:36:00');
INSERT INTO public.perfil VALUES (393, 393, 'campus0393123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0393.jpg', NULL, '2026-03-20 16:52:55');
INSERT INTO public.perfil VALUES (394, 394, 'tech0394star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0394.jpg', 6, '2026-04-01 17:27:33');
INSERT INTO public.perfil VALUES (395, 395, 'campus0395pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0395.jpg', 6, '2026-02-15 17:38:10');
INSERT INTO public.perfil VALUES (396, 396, 'bravo0396007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0396.jpg', 7, '2026-03-14 22:39:59');
INSERT INTO public.perfil VALUES (397, 397, 'tech0397pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0397.jpg', NULL, '2026-01-05 19:59:26');
INSERT INTO public.perfil VALUES (398, 398, 'tech0398star', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0398.jpg', 2, '2026-04-24 16:37:51');
INSERT INTO public.perfil VALUES (399, 399, 'ing0399medellin', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0399.jpg', NULL, '2026-04-27 17:24:07');
INSERT INTO public.perfil VALUES (400, 400, 'code0400star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0400.jpg', NULL, '2026-04-29 13:58:52');
INSERT INTO public.perfil VALUES (401, 401, 'bravo04012026', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0401.jpg', 9, '2026-03-14 08:56:42');
INSERT INTO public.perfil VALUES (402, 402, 'pascal0402medellin', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0402.jpg', 1, '2026-04-17 01:00:01');
INSERT INTO public.perfil VALUES (403, 403, 'dev0403123', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0403.jpg', 10, '2026-03-23 10:10:36');
INSERT INTO public.perfil VALUES (404, 404, 'bravo0404itpb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0404.jpg', 4, '2026-04-11 01:51:59');
INSERT INTO public.perfil VALUES (405, 405, 'bravo0405col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0405.jpg', 3, '2026-04-14 10:33:10');
INSERT INTO public.perfil VALUES (406, 406, 'bravo0406itpb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0406.jpg', 3, '2026-05-10 03:40:36');
INSERT INTO public.perfil VALUES (407, 407, 'bravo0407medellin', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0407.jpg', NULL, '2026-03-24 06:05:05');
INSERT INTO public.perfil VALUES (408, 408, 'ing0408007', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0408.jpg', 10, '2026-02-09 00:39:45');
INSERT INTO public.perfil VALUES (409, 409, 'tech0409007', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0409.jpg', 3, '2026-04-27 20:40:49');
INSERT INTO public.perfil VALUES (410, 410, 'campus0410col', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0410.jpg', 4, '2026-03-18 06:34:53');
INSERT INTO public.perfil VALUES (411, 411, 'code0411007', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0411.jpg', 5, '2026-01-22 04:40:01');
INSERT INTO public.perfil VALUES (412, 412, 'tech0412pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0412.jpg', 2, '2026-01-28 04:18:16');
INSERT INTO public.perfil VALUES (413, 413, 'dev0413pb', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0413.jpg', 6, '2026-02-23 12:06:31');
INSERT INTO public.perfil VALUES (414, 414, 'ing0414007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0414.jpg', 2, '2026-02-23 21:26:24');
INSERT INTO public.perfil VALUES (415, 415, 'campus0415star', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0415.jpg', NULL, '2026-01-03 05:42:36');
INSERT INTO public.perfil VALUES (416, 416, 'ing0416pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0416.jpg', 8, '2026-05-20 00:10:33');
INSERT INTO public.perfil VALUES (417, 417, 'pascal0417pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0417.jpg', 9, '2026-01-06 16:32:48');
INSERT INTO public.perfil VALUES (418, 418, 'dev0418itpb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0418.jpg', NULL, '2026-02-25 00:20:08');
INSERT INTO public.perfil VALUES (419, 419, 'code0419pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0419.jpg', NULL, '2026-05-04 06:05:22');
INSERT INTO public.perfil VALUES (420, 420, 'pascal0420star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0420.jpg', 7, '2026-02-19 08:11:12');
INSERT INTO public.perfil VALUES (421, 421, 'pascal0421007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0421.jpg', 10, '2026-03-21 05:50:13');
INSERT INTO public.perfil VALUES (422, 422, 'uni0422007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0422.jpg', 5, '2026-03-23 19:06:38');
INSERT INTO public.perfil VALUES (423, 423, 'bravo0423007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0423.jpg', 6, '2026-01-17 14:10:56');
INSERT INTO public.perfil VALUES (424, 424, 'ing0424medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0424.jpg', 10, '2026-05-16 11:25:01');
INSERT INTO public.perfil VALUES (425, 425, 'tech0425col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0425.jpg', 3, '2026-04-02 07:04:13');
INSERT INTO public.perfil VALUES (426, 426, 'campus0426123', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0426.jpg', 2, '2026-01-03 10:44:00');
INSERT INTO public.perfil VALUES (427, 427, 'campus0427itpb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0427.jpg', 6, '2026-03-01 17:04:24');
INSERT INTO public.perfil VALUES (428, 428, 'pascal0428itpb', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0428.jpg', NULL, '2026-03-13 22:38:56');
INSERT INTO public.perfil VALUES (429, 429, 'tech0429007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0429.jpg', NULL, '2026-03-23 06:12:03');
INSERT INTO public.perfil VALUES (430, 430, 'uni0430star', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0430.jpg', 7, '2026-01-31 03:28:10');
INSERT INTO public.perfil VALUES (431, 431, 'campus0431007', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0431.jpg', 5, '2026-01-05 20:50:54');
INSERT INTO public.perfil VALUES (432, 432, 'ing0432star', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0432.jpg', NULL, '2026-04-14 01:57:34');
INSERT INTO public.perfil VALUES (433, 433, 'ing0433123', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0433.jpg', NULL, '2026-01-25 13:46:19');
INSERT INTO public.perfil VALUES (434, 434, 'pascal0434123', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0434.jpg', 9, '2026-03-22 15:39:03');
INSERT INTO public.perfil VALUES (435, 435, 'bravo0435medellin', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0435.jpg', 2, '2026-04-06 19:06:01');
INSERT INTO public.perfil VALUES (436, 436, 'code04362026', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0436.jpg', NULL, '2026-03-24 22:46:27');
INSERT INTO public.perfil VALUES (437, 437, 'code0437col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0437.jpg', NULL, '2026-04-05 17:00:59');
INSERT INTO public.perfil VALUES (438, 438, 'ing0438medellin', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0438.jpg', NULL, '2026-03-19 02:16:21');
INSERT INTO public.perfil VALUES (439, 439, 'bravo0439medellin', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0439.jpg', 10, '2026-04-28 03:08:20');
INSERT INTO public.perfil VALUES (440, 440, 'dev0440007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0440.jpg', 9, '2026-05-16 07:36:30');
INSERT INTO public.perfil VALUES (441, 441, 'uni0441medellin', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0441.jpg', 8, '2026-02-27 02:16:49');
INSERT INTO public.perfil VALUES (442, 442, 'pascal0442pb', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0442.jpg', 4, '2026-02-22 22:04:04');
INSERT INTO public.perfil VALUES (443, 443, 'uni04432026', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0443.jpg', NULL, '2026-02-25 14:52:24');
INSERT INTO public.perfil VALUES (444, 444, 'code0444star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0444.jpg', NULL, '2026-05-16 16:54:20');
INSERT INTO public.perfil VALUES (445, 445, 'pascal0445star', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0445.jpg', 2, '2026-02-03 07:58:23');
INSERT INTO public.perfil VALUES (446, 446, 'bravo0446star', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0446.jpg', 7, '2026-02-18 02:17:27');
INSERT INTO public.perfil VALUES (447, 447, 'dev0447medellin', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0447.jpg', 3, '2026-04-29 03:47:07');
INSERT INTO public.perfil VALUES (448, 448, 'code04482026', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0448.jpg', NULL, '2026-01-08 15:42:33');
INSERT INTO public.perfil VALUES (449, 449, 'uni0449123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0449.jpg', NULL, '2026-05-21 02:22:27');
INSERT INTO public.perfil VALUES (450, 450, 'code0450col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0450.jpg', 9, '2026-03-27 01:28:17');
INSERT INTO public.perfil VALUES (451, 451, 'campus0451pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0451.jpg', 7, '2026-02-19 09:12:25');
INSERT INTO public.perfil VALUES (452, 452, 'dev0452medellin', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0452.jpg', 9, '2026-04-21 03:43:03');
INSERT INTO public.perfil VALUES (453, 453, 'code0453pb', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0453.jpg', NULL, '2026-01-10 18:17:15');
INSERT INTO public.perfil VALUES (454, 454, 'tech0454pb', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0454.jpg', NULL, '2026-04-14 12:25:06');
INSERT INTO public.perfil VALUES (455, 455, 'code0455medellin', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0455.jpg', NULL, '2026-02-22 11:40:18');
INSERT INTO public.perfil VALUES (456, 456, 'pascal04562026', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0456.jpg', NULL, '2026-05-03 23:19:54');
INSERT INTO public.perfil VALUES (457, 457, 'code0457col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0457.jpg', 3, '2026-02-17 10:57:29');
INSERT INTO public.perfil VALUES (458, 458, 'dev04582026', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0458.jpg', 1, '2026-02-15 08:56:04');
INSERT INTO public.perfil VALUES (459, 459, 'dev04592026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0459.jpg', NULL, '2026-05-02 18:00:31');
INSERT INTO public.perfil VALUES (460, 460, 'code0460star', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0460.jpg', NULL, '2026-01-05 18:43:18');
INSERT INTO public.perfil VALUES (461, 461, 'code0461col', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0461.jpg', 2, '2026-03-19 23:21:28');
INSERT INTO public.perfil VALUES (462, 462, 'uni0462123', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0462.jpg', NULL, '2026-05-05 08:23:29');
INSERT INTO public.perfil VALUES (463, 463, 'ing0463123', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0463.jpg', 9, '2026-05-04 03:17:43');
INSERT INTO public.perfil VALUES (464, 464, 'ing0464col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0464.jpg', 3, '2026-04-02 15:01:15');
INSERT INTO public.perfil VALUES (465, 465, 'bravo0465123', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0465.jpg', 4, '2026-04-07 20:06:17');
INSERT INTO public.perfil VALUES (466, 466, 'uni0466col', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0466.jpg', 6, '2026-03-26 12:37:26');
INSERT INTO public.perfil VALUES (467, 467, 'pascal0467medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0467.jpg', NULL, '2026-05-14 22:21:53');
INSERT INTO public.perfil VALUES (468, 468, 'tech0468007', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0468.jpg', 6, '2026-03-15 03:00:31');
INSERT INTO public.perfil VALUES (469, 469, 'dev0469star', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0469.jpg', 5, '2026-02-11 09:31:18');
INSERT INTO public.perfil VALUES (470, 470, 'tech0470medellin', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0470.jpg', 4, '2026-03-14 18:07:03');
INSERT INTO public.perfil VALUES (471, 471, 'uni0471medellin', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0471.jpg', 1, '2026-01-13 08:08:22');
INSERT INTO public.perfil VALUES (472, 472, 'pascal0472col', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0472.jpg', 3, '2026-02-20 13:37:58');
INSERT INTO public.perfil VALUES (473, 473, 'tech0473medellin', 'Apasionado por la robótica, la IA y el desarrollo de soluciones tecnológicas.', 'https://cdn.pascualbravo.edu.co/avatars/u0473.jpg', NULL, '2026-04-01 07:51:43');
INSERT INTO public.perfil VALUES (474, 474, 'bravo0474007', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0474.jpg', 2, '2026-03-08 09:38:19');
INSERT INTO public.perfil VALUES (475, 475, 'dev0475007', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0475.jpg', 3, '2026-02-21 08:08:26');
INSERT INTO public.perfil VALUES (476, 476, 'code0476medellin', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0476.jpg', NULL, '2026-04-29 17:11:24');
INSERT INTO public.perfil VALUES (477, 477, 'bravo0477pb', 'Egresado orgulloso del Pascual Bravo. Actualmente trabajo en el sector TIC.', 'https://cdn.pascualbravo.edu.co/avatars/u0477.jpg', 6, '2026-05-09 21:45:22');
INSERT INTO public.perfil VALUES (478, 478, 'uni0478123', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0478.jpg', 7, '2026-04-29 00:58:35');
INSERT INTO public.perfil VALUES (479, 479, 'ing0479007', 'Docente comprometido con la formación de ingenieros íntegros y creativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0479.jpg', 10, '2026-03-19 07:37:32');
INSERT INTO public.perfil VALUES (480, 480, 'campus0480col', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0480.jpg', 10, '2026-03-17 01:48:54');
INSERT INTO public.perfil VALUES (481, 481, 'bravo0481col', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0481.jpg', 8, '2026-05-13 14:53:03');
INSERT INTO public.perfil VALUES (482, 482, 'tech04822026', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0482.jpg', 2, '2026-03-27 19:06:52');
INSERT INTO public.perfil VALUES (483, 483, 'pascal0483star', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0483.jpg', 2, '2026-05-11 23:45:03');
INSERT INTO public.perfil VALUES (484, 484, 'code0484col', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0484.jpg', 8, '2026-02-04 07:57:43');
INSERT INTO public.perfil VALUES (485, 485, 'dev0485medellin', 'Gestora administrativa con amplia experiencia en entornos educativos.', 'https://cdn.pascualbravo.edu.co/avatars/u0485.jpg', 1, '2026-05-05 19:44:12');
INSERT INTO public.perfil VALUES (486, 486, 'tech0486pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0486.jpg', NULL, '2026-01-31 16:06:15');
INSERT INTO public.perfil VALUES (487, 487, 'code0487pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0487.jpg', NULL, '2026-05-10 14:25:03');
INSERT INTO public.perfil VALUES (488, 488, 'tech0488medellin', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0488.jpg', 3, '2026-03-02 17:16:52');
INSERT INTO public.perfil VALUES (489, 489, 'uni0489pb', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0489.jpg', NULL, '2026-01-06 05:09:52');
INSERT INTO public.perfil VALUES (490, 490, 'code0490col', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0490.jpg', 9, '2026-02-21 15:30:18');
INSERT INTO public.perfil VALUES (491, 491, 'pascal0491pb', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0491.jpg', 5, '2026-04-11 12:44:51');
INSERT INTO public.perfil VALUES (492, 492, 'tech0492star', 'Emprendedor en el sector tecnológico. Creo en la educación como motor de cambio.', 'https://cdn.pascualbravo.edu.co/avatars/u0492.jpg', 3, '2026-01-08 09:29:07');
INSERT INTO public.perfil VALUES (493, 493, 'bravo04932026', 'Docente de matemáticas con enfoque en pedagogía activa e innovación educativa.', 'https://cdn.pascualbravo.edu.co/avatars/u0493.jpg', NULL, '2026-04-24 01:58:58');
INSERT INTO public.perfil VALUES (494, 494, 'campus0494col', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0494.jpg', 8, '2026-03-12 00:10:22');
INSERT INTO public.perfil VALUES (495, 495, 'code0495123', 'Ex estudiante retomando su carrera con nuevas metas y mucha motivación.', 'https://cdn.pascualbravo.edu.co/avatars/u0495.jpg', NULL, '2026-01-17 05:41:09');
INSERT INTO public.perfil VALUES (496, 496, 'campus0496123', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0496.jpg', 3, '2026-03-13 21:19:59');
INSERT INTO public.perfil VALUES (497, 497, 'bravo0497pb', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0497.jpg', NULL, '2026-05-01 19:42:11');
INSERT INTO public.perfil VALUES (498, 498, 'pascal0498col', 'Estudiante de últimos semestres, enfocado en proyectos de inteligencia artificial.', 'https://cdn.pascualbravo.edu.co/avatars/u0498.jpg', 10, '2026-03-31 18:39:53');
INSERT INTO public.perfil VALUES (499, 499, 'bravo0499pb', 'Estudiante de tecnología con pasión por la innovación y el emprendimiento digital.', 'https://cdn.pascualbravo.edu.co/avatars/u0499.jpg', NULL, '2026-02-10 07:06:42');
INSERT INTO public.perfil VALUES (500, 500, 'tech0500star', 'Monitor académico y miembro activo del semillero de investigación.', 'https://cdn.pascualbravo.edu.co/avatars/u0500.jpg', NULL, '2026-03-01 23:50:15');


--
-- Data for Name: postulaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.productos VALUES (1, 84, 12, 'Cable HDMI 2m Alta Velocidad #1', 'Material didáctico completo, incluye marcadores y notas.', 1937564, 'disponible', '2026-03-24 23:40:22');
INSERT INTO public.productos VALUES (2, 209, 6, 'SSD 500GB Samsung #2', 'Prácticamente nuevo, usado solo un semestre.', 1314943, 'vendido', '2026-03-16 04:52:43');
INSERT INTO public.productos VALUES (3, 385, 16, 'Webcam Logitech C920 HD #3', 'Prácticamente nuevo, usado solo un semestre.', 1273944, 'vendido', '2026-01-23 19:16:56');
INSERT INTO public.productos VALUES (4, 71, 11, 'Cable HDMI 2m Alta Velocidad #4', 'Material didáctico completo, incluye marcadores y notas.', 1643612, 'en_reserva', '2026-02-12 01:21:32');
INSERT INTO public.productos VALUES (5, 471, 5, 'Disco Duro 1TB Portátil #5', 'En buen estado general, con detalles mínimos de uso.', 1899934, 'en_reserva', '2026-02-10 18:08:52');
INSERT INTO public.productos VALUES (6, 406, 7, 'Mouse Ergonómico Logitech #6', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 2885583, 'disponible', '2026-05-09 17:02:33');
INSERT INTO public.productos VALUES (7, 54, 19, 'Libro Ingeniería de Software #7', 'En buen estado general, con detalles mínimos de uso.', 3272078, 'en_reserva', '2026-02-12 23:14:43');
INSERT INTO public.productos VALUES (8, 364, 11, 'Tenis Nike Running #8', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1152696, 'vendido', '2026-05-21 12:33:42');
INSERT INTO public.productos VALUES (9, 420, 13, 'Uniforme ITPB Temporada 2025 #9', 'Producto funcional al 100%, se vende por cambio de equipo.', 1241948, 'vendido', '2026-01-28 07:40:41');
INSERT INTO public.productos VALUES (10, 233, 5, 'Mochila Técnica Portátil #10', 'Material didáctico completo, incluye marcadores y notas.', 22075, 'en_reserva', '2026-01-28 15:09:58');
INSERT INTO public.productos VALUES (11, 37, 10, 'Uniforme ITPB Temporada 2025 #11', 'Muy buen estado, vendo por no necesitarlo más.', 1433297, 'disponible', '2026-05-19 20:06:52');
INSERT INTO public.productos VALUES (12, 98, 1, 'Libro Ingeniería de Software #12', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1049329, 'disponible', '2026-02-17 21:04:04');
INSERT INTO public.productos VALUES (13, 130, 15, 'Tablet Samsung Galaxy A8 #13', 'Prácticamente nuevo, usado solo un semestre.', 3308164, 'en_reserva', '2026-04-14 00:44:38');
INSERT INTO public.productos VALUES (14, 154, 11, 'Mouse Ergonómico Logitech #14', 'En buen estado general, con detalles mínimos de uso.', 745400, 'vendido', '2026-05-03 20:39:37');
INSERT INTO public.productos VALUES (15, 22, 16, 'Libro Cálculo Multivariable #15', 'Prácticamente nuevo, usado solo un semestre.', 1132319, 'disponible', '2026-03-07 22:30:55');
INSERT INTO public.productos VALUES (16, 409, 13, 'Webcam Logitech C920 HD #16', 'Muy buen estado, vendo por no necesitarlo más.', 361064, 'en_reserva', '2026-03-31 21:31:01');
INSERT INTO public.productos VALUES (17, 195, 2, 'Tenis Nike Running #17', 'Muy buen estado, vendo por no necesitarlo más.', 3172446, 'vendido', '2026-03-06 17:05:05');
INSERT INTO public.productos VALUES (18, 126, 4, 'Bicicleta Estática Ejercicio #18', 'Prácticamente nuevo, usado solo un semestre.', 2626702, 'disponible', '2026-05-01 01:20:19');
INSERT INTO public.productos VALUES (19, 283, 15, 'Mochila Técnica Portátil #19', 'Producto funcional al 100%, se vende por cambio de equipo.', 1448913, 'disponible', '2026-02-02 18:55:43');
INSERT INTO public.productos VALUES (20, 400, 1, 'Calculadora Científica Casio fx-991 #20', 'Prácticamente nuevo, usado solo un semestre.', 260467, 'disponible', '2026-04-29 08:44:36');
INSERT INTO public.productos VALUES (21, 199, 18, 'Libro Cálculo Multivariable #21', 'En buen estado general, con detalles mínimos de uso.', 2058101, 'en_reserva', '2026-05-13 15:11:57');
INSERT INTO public.productos VALUES (22, 232, 10, 'iPhone SE 2024 #22', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1030198, 'vendido', '2026-04-20 03:43:09');
INSERT INTO public.productos VALUES (23, 496, 3, 'Mochila Técnica Portátil #23', 'Prácticamente nuevo, usado solo un semestre.', 1712141, 'disponible', '2026-04-10 23:51:41');
INSERT INTO public.productos VALUES (24, 464, 6, 'Mouse Ergonómico Logitech #24', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1071923, 'disponible', '2026-03-29 21:37:54');
INSERT INTO public.productos VALUES (25, 253, 8, 'Bicicleta Estática Ejercicio #25', 'Muy buen estado, vendo por no necesitarlo más.', 2458714, 'disponible', '2026-01-26 05:08:08');
INSERT INTO public.productos VALUES (26, 380, 20, 'SSD 500GB Samsung #26', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1544579, 'vendido', '2026-04-21 00:45:33');
INSERT INTO public.productos VALUES (27, 460, 12, 'Webcam Logitech C920 HD #27', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 1476814, 'disponible', '2026-03-13 13:35:44');
INSERT INTO public.productos VALUES (28, 217, 3, 'Portátil Lenovo IdeaPad 5 #28', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 934459, 'en_reserva', '2026-04-02 15:25:32');
INSERT INTO public.productos VALUES (29, 471, 8, 'Auriculares Sony WH-1000XM5 #29', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 103900, 'disponible', '2026-02-17 21:12:28');
INSERT INTO public.productos VALUES (30, 338, 18, 'Cable HDMI 2m Alta Velocidad #30', 'Producto funcional al 100%, se vende por cambio de equipo.', 935263, 'disponible', '2026-02-17 18:26:07');
INSERT INTO public.productos VALUES (31, 287, 2, 'Uniforme ITPB Temporada 2025 #31', 'Producto original con todos sus accesorios y caja.', 532908, 'disponible', '2026-04-11 00:23:03');
INSERT INTO public.productos VALUES (32, 262, 1, 'Tablet Samsung Galaxy A8 #32', 'Producto funcional al 100%, se vende por cambio de equipo.', 2337371, 'en_reserva', '2026-05-16 00:19:56');
INSERT INTO public.productos VALUES (33, 416, 5, 'Kit de Robótica Arduino #33', 'Producto original con todos sus accesorios y caja.', 3014838, 'disponible', '2026-02-18 21:30:30');
INSERT INTO public.productos VALUES (34, 246, 7, 'Tablet Samsung Galaxy A8 #34', 'Producto original con todos sus accesorios y caja.', 1369744, 'en_reserva', '2026-05-19 02:09:42');
INSERT INTO public.productos VALUES (35, 66, 17, 'Auriculares Sony WH-1000XM5 #35', 'Muy buen estado, vendo por no necesitarlo más.', 2666603, 'vendido', '2026-05-12 02:36:10');
INSERT INTO public.productos VALUES (36, 127, 14, 'Cable HDMI 2m Alta Velocidad #36', 'Producto original con todos sus accesorios y caja.', 2901355, 'vendido', '2026-01-16 13:02:55');
INSERT INTO public.productos VALUES (37, 165, 13, 'Libro Ingeniería de Software #37', 'Producto original con todos sus accesorios y caja.', 2357363, 'vendido', '2026-04-11 14:38:53');
INSERT INTO public.productos VALUES (38, 444, 8, 'Auriculares Sony WH-1000XM5 #38', 'Prácticamente nuevo, usado solo un semestre.', 2159837, 'en_reserva', '2026-04-15 20:55:48');
INSERT INTO public.productos VALUES (39, 326, 6, 'Uniforme ITPB Temporada 2025 #39', 'Producto funcional al 100%, se vende por cambio de equipo.', 1833980, 'vendido', '2026-01-20 13:38:01');
INSERT INTO public.productos VALUES (40, 214, 3, 'Webcam Logitech C920 HD #40', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 2471571, 'disponible', '2026-01-11 11:17:25');
INSERT INTO public.productos VALUES (41, 144, 15, 'Kit de Robótica Arduino #41', 'En buen estado general, con detalles mínimos de uso.', 2930409, 'en_reserva', '2026-03-25 09:54:30');
INSERT INTO public.productos VALUES (42, 262, 16, 'Mouse Ergonómico Logitech #42', 'Muy buen estado, vendo por no necesitarlo más.', 3051634, 'en_reserva', '2026-02-05 15:21:05');
INSERT INTO public.productos VALUES (43, 355, 16, 'Kit de Robótica Arduino #43', 'Producto funcional al 100%, se vende por cambio de equipo.', 1819152, 'en_reserva', '2026-01-17 08:40:17');
INSERT INTO public.productos VALUES (44, 479, 9, 'Monitor LG 24 Full HD #44', 'Producto funcional al 100%, se vende por cambio de equipo.', 1807042, 'vendido', '2026-03-24 07:36:12');
INSERT INTO public.productos VALUES (45, 179, 10, 'Mochila Técnica Portátil #45', 'Muy buen estado, vendo por no necesitarlo más.', 1185795, 'en_reserva', '2026-04-16 08:16:38');
INSERT INTO public.productos VALUES (46, 218, 7, 'Disco Duro 1TB Portátil #46', 'Muy buen estado, vendo por no necesitarlo más.', 504686, 'en_reserva', '2026-03-17 06:43:43');
INSERT INTO public.productos VALUES (47, 186, 18, 'Webcam Logitech C920 HD #47', 'En buen estado general, con detalles mínimos de uso.', 731536, 'vendido', '2026-05-14 05:07:46');
INSERT INTO public.productos VALUES (48, 371, 10, 'Uniforme ITPB Temporada 2025 #48', 'Producto original con todos sus accesorios y caja.', 2101497, 'en_reserva', '2026-03-28 05:56:41');
INSERT INTO public.productos VALUES (49, 415, 16, 'Cable HDMI 2m Alta Velocidad #49', 'Producto original con todos sus accesorios y caja.', 1382873, 'en_reserva', '2026-03-11 18:29:34');
INSERT INTO public.productos VALUES (50, 175, 5, 'Teclado Mecánico Gamer #50', 'Producto funcional al 100%, se vende por cambio de equipo.', 270735, 'disponible', '2026-04-07 17:25:00');
INSERT INTO public.productos VALUES (51, 35, 7, 'Teclado Mecánico Gamer #51', 'Prácticamente nuevo, usado solo un semestre.', 1602567, 'en_reserva', '2026-03-12 16:36:26');
INSERT INTO public.productos VALUES (52, 102, 9, 'Libro Cálculo Multivariable #52', 'Prácticamente nuevo, usado solo un semestre.', 2205832, 'vendido', '2026-01-28 15:27:24');
INSERT INTO public.productos VALUES (53, 161, 4, 'Auriculares Sony WH-1000XM5 #53', 'Producto original con todos sus accesorios y caja.', 447750, 'disponible', '2026-01-11 02:17:06');
INSERT INTO public.productos VALUES (54, 281, 18, 'Teclado Mecánico Gamer #54', 'Producto original con todos sus accesorios y caja.', 2747870, 'en_reserva', '2026-04-19 06:02:57');
INSERT INTO public.productos VALUES (55, 339, 19, 'Libro Cálculo Multivariable #55', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 407784, 'en_reserva', '2026-03-12 09:27:15');
INSERT INTO public.productos VALUES (56, 119, 8, 'Disco Duro 1TB Portátil #56', 'Producto funcional al 100%, se vende por cambio de equipo.', 2005748, 'vendido', '2026-04-01 07:09:01');
INSERT INTO public.productos VALUES (57, 284, 19, 'Kit de Robótica Arduino #57', 'Muy buen estado, vendo por no necesitarlo más.', 785156, 'vendido', '2026-02-22 17:39:01');
INSERT INTO public.productos VALUES (58, 489, 6, 'Portátil Lenovo IdeaPad 5 #58', 'Producto funcional al 100%, se vende por cambio de equipo.', 2596787, 'vendido', '2026-05-05 03:06:15');
INSERT INTO public.productos VALUES (59, 433, 14, 'Uniforme ITPB Temporada 2025 #59', 'Producto original con todos sus accesorios y caja.', 1619083, 'disponible', '2026-02-14 07:17:06');
INSERT INTO public.productos VALUES (60, 2, 8, 'Monitor LG 24 Full HD #60', 'Prácticamente nuevo, usado solo un semestre.', 2037139, 'en_reserva', '2026-04-09 14:13:14');
INSERT INTO public.productos VALUES (61, 52, 3, 'Libro Python para Ciencia de Datos #61', 'Material didáctico completo, incluye marcadores y notas.', 1565583, 'disponible', '2026-04-09 19:48:24');
INSERT INTO public.productos VALUES (62, 12, 18, 'Teclado Mecánico Gamer #62', 'Producto original con todos sus accesorios y caja.', 3088686, 'vendido', '2026-04-22 16:21:20');
INSERT INTO public.productos VALUES (63, 11, 16, 'Calculadora Científica Casio fx-991 #63', 'Producto funcional al 100%, se vende por cambio de equipo.', 1369894, 'vendido', '2026-02-22 11:09:45');
INSERT INTO public.productos VALUES (64, 40, 20, 'Mouse Ergonómico Logitech #64', 'Producto original con todos sus accesorios y caja.', 2762483, 'disponible', '2026-02-25 10:22:25');
INSERT INTO public.productos VALUES (65, 141, 8, 'Monitor LG 24 Full HD #65', 'Producto original con todos sus accesorios y caja.', 1340465, 'vendido', '2026-01-07 21:59:36');
INSERT INTO public.productos VALUES (66, 125, 3, 'Bicicleta Estática Ejercicio #66', 'Material didáctico completo, incluye marcadores y notas.', 2804350, 'vendido', '2026-03-30 11:24:01');
INSERT INTO public.productos VALUES (67, 252, 14, 'Bicicleta Estática Ejercicio #67', 'Prácticamente nuevo, usado solo un semestre.', 331324, 'vendido', '2026-03-31 07:17:23');
INSERT INTO public.productos VALUES (68, 467, 9, 'Tenis Nike Running #68', 'Producto original con todos sus accesorios y caja.', 606525, 'en_reserva', '2026-05-13 19:33:51');
INSERT INTO public.productos VALUES (69, 101, 2, 'Mouse Ergonómico Logitech #69', 'En buen estado general, con detalles mínimos de uso.', 186965, 'disponible', '2026-01-24 22:58:10');
INSERT INTO public.productos VALUES (70, 48, 20, 'Webcam Logitech C920 HD #70', 'Artículo en excelente estado, poco uso, ideal para estudiantes.', 891361, 'en_reserva', '2026-03-07 14:09:18');


--
-- Data for Name: publicaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.publicaciones VALUES (1, 54, '2026-02-14 23:57:24', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (2, 473, '2026-01-17 01:39:16', 'El equipo de robótica ganó el primer lugar en la competencia regional. ¡Orgullo ITPB!', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (3, 434, '2026-01-19 14:48:23', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (4, 473, '2026-02-14 10:06:44', 'Resumen de la conferencia sobre Blockchain aplicado a la cadena de suministro. Material adjunto.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (5, 69, '2026-02-21 06:16:31', 'Resumen de la conferencia sobre Blockchain aplicado a la cadena de suministro. Material adjunto.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0005.jpg');
INSERT INTO public.publicaciones VALUES (6, 116, '2026-02-21 23:10:27', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0006.jpg');
INSERT INTO public.publicaciones VALUES (7, 45, '2026-01-07 20:42:06', 'Se acerca la Feria Laboral 2026. Más de 30 empresas del sector TIC participarán.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (8, 415, '2026-02-05 00:23:49', 'El semillero de IA tiene cupos disponibles. Si te apasiona el aprendizaje automático, ¡únete!', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (9, 175, '2026-02-17 21:46:58', 'Recordatorio: Mañana es la entrega de proyectos integradores. No dejen para después.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (10, 98, '2026-02-23 18:52:30', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0010.jpg');
INSERT INTO public.publicaciones VALUES (11, 183, '2026-02-05 02:28:27', '¿Alguien más tomó el seminario de ética en tecnología? Me parece un tema urgente y necesario.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (12, 448, '2026-01-19 18:05:08', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0012.jpg');
INSERT INTO public.publicaciones VALUES (13, 52, '2026-01-31 15:14:03', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0013.jpg');
INSERT INTO public.publicaciones VALUES (14, 12, '2026-02-27 09:59:53', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (15, 361, '2026-04-02 02:55:55', 'Reflexión del día: La tecnología es solo tan buena como el propósito con el que la usamos.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0015.jpg');
INSERT INTO public.publicaciones VALUES (16, 39, '2026-05-17 18:15:54', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0016.jpg');
INSERT INTO public.publicaciones VALUES (17, 205, '2026-01-15 17:44:57', 'El equipo de robótica ganó el primer lugar en la competencia regional. ¡Orgullo ITPB!', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (18, 480, '2026-03-09 20:01:02', 'Invitados a la jornada de salud mental esta semana. La universidad cuida tu bienestar.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (19, 134, '2026-02-21 10:56:48', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0019.jpg');
INSERT INTO public.publicaciones VALUES (20, 105, '2026-05-21 23:21:59', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (21, 121, '2026-05-07 02:51:36', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (22, 178, '2026-01-19 13:38:47', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (23, 455, '2026-05-03 04:17:46', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (24, 19, '2026-05-08 16:14:41', 'Vendo libros de Ingeniería de Software en excelente estado. Ver perfil para precios.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (25, 245, '2026-03-19 07:01:59', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (26, 397, '2026-02-20 17:38:55', 'Ofrezco tutorías de inglés técnico para estudiantes de últimos semestres. Precios accesibles.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (27, 283, '2026-05-04 01:24:49', 'Ofrezco tutorías de inglés técnico para estudiantes de últimos semestres. Precios accesibles.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0027.jpg');
INSERT INTO public.publicaciones VALUES (28, 221, '2026-04-20 17:08:07', 'Resumen de la conferencia sobre Blockchain aplicado a la cadena de suministro. Material adjunto.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (29, 460, '2026-04-05 11:12:21', 'El semillero de IA tiene cupos disponibles. Si te apasiona el aprendizaje automático, ¡únete!', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (30, 122, '2026-03-01 02:37:00', 'Acabo de terminar mi proyecto de grado. Gracias a todos los que me apoyaron en este camino.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (31, 383, '2026-05-18 18:02:51', '¡El congreso de tecnología del próximo viernes tendrá cupos limitados! No olviden inscribirse.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0031.jpg');
INSERT INTO public.publicaciones VALUES (32, 417, '2026-01-15 02:03:08', 'Resumen de la conferencia sobre Blockchain aplicado a la cadena de suministro. Material adjunto.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0032.jpg');
INSERT INTO public.publicaciones VALUES (33, 145, '2026-01-12 10:22:38', '¿Alguien más tomó el seminario de ética en tecnología? Me parece un tema urgente y necesario.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0033.jpg');
INSERT INTO public.publicaciones VALUES (34, 150, '2026-02-03 19:25:30', 'Nuevo grupo de estudio para la certificación AWS. Si te interesa, escríbeme.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (35, 337, '2026-01-20 02:16:34', 'Se acerca la Feria Laboral 2026. Más de 30 empresas del sector TIC participarán.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (36, 362, '2026-04-02 07:28:45', 'Disponibles los resultados de las olimpiadas de matemáticas. Consulten en la plataforma.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0036.jpg');
INSERT INTO public.publicaciones VALUES (37, 400, '2026-03-16 20:15:33', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0037.jpg');
INSERT INTO public.publicaciones VALUES (38, 358, '2026-05-19 16:06:03', 'Vendo libros de Ingeniería de Software en excelente estado. Ver perfil para precios.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (39, 362, '2026-05-05 08:05:13', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0039.jpg');
INSERT INTO public.publicaciones VALUES (40, 157, '2026-02-23 03:23:46', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (41, 121, '2026-04-23 20:48:29', 'El equipo de robótica ganó el primer lugar en la competencia regional. ¡Orgullo ITPB!', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (42, 256, '2026-01-09 08:17:37', 'Ofrezco tutorías de inglés técnico para estudiantes de últimos semestres. Precios accesibles.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0042.jpg');
INSERT INTO public.publicaciones VALUES (43, 424, '2026-01-22 01:17:54', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (44, 254, '2026-01-05 12:24:28', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0044.jpg');
INSERT INTO public.publicaciones VALUES (45, 106, '2026-04-08 05:42:27', 'Abrieron convocatoria para monitores académicos del segundo semestre. Requisitos en la plataforma.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (46, 339, '2026-03-20 01:34:48', 'Vendo libros de Ingeniería de Software en excelente estado. Ver perfil para precios.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (47, 466, '2026-03-28 08:51:48', 'El festival gastronómico fue todo un éxito. La gastronomía también es cultura universitaria.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0047.jpg');
INSERT INTO public.publicaciones VALUES (48, 388, '2026-01-08 10:46:53', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (49, 444, '2026-04-20 23:59:47', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (50, 414, '2026-01-28 17:24:46', 'Nuevo grupo de estudio para la certificación AWS. Si te interesa, escríbeme.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0050.jpg');
INSERT INTO public.publicaciones VALUES (51, 440, '2026-05-17 14:27:36', 'Recordatorio: Mañana es la entrega de proyectos integradores. No dejen para después.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0051.jpg');
INSERT INTO public.publicaciones VALUES (52, 84, '2026-04-08 14:47:59', 'Acabo de terminar mi proyecto de grado. Gracias a todos los que me apoyaron en este camino.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0052.jpg');
INSERT INTO public.publicaciones VALUES (53, 465, '2026-01-04 08:51:43', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (54, 128, '2026-05-19 09:21:36', 'Ofrezco tutorías de inglés técnico para estudiantes de últimos semestres. Precios accesibles.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (55, 316, '2026-03-12 11:17:42', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (56, 64, '2026-03-20 18:42:20', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0056.jpg');
INSERT INTO public.publicaciones VALUES (57, 228, '2026-04-29 00:28:00', 'Resumen de la conferencia sobre Blockchain aplicado a la cadena de suministro. Material adjunto.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (58, 495, '2026-04-02 15:40:54', 'Abrieron convocatoria para monitores académicos del segundo semestre. Requisitos en la plataforma.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0058.jpg');
INSERT INTO public.publicaciones VALUES (59, 210, '2026-01-15 18:05:17', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0059.jpg');
INSERT INTO public.publicaciones VALUES (60, 489, '2026-01-17 14:11:16', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0060.jpg');
INSERT INTO public.publicaciones VALUES (61, 133, '2026-05-07 04:14:40', 'Reflexión del día: La tecnología es solo tan buena como el propósito con el que la usamos.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0061.jpg');
INSERT INTO public.publicaciones VALUES (62, 447, '2026-01-13 07:07:41', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0062.jpg');
INSERT INTO public.publicaciones VALUES (63, 351, '2026-05-10 14:37:20', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0063.jpg');
INSERT INTO public.publicaciones VALUES (64, 32, '2026-03-08 08:01:43', 'Vendo libros de Ingeniería de Software en excelente estado. Ver perfil para precios.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (65, 308, '2026-03-02 11:06:04', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (66, 58, '2026-05-11 02:15:13', 'Invitados a la jornada de salud mental esta semana. La universidad cuida tu bienestar.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0066.jpg');
INSERT INTO public.publicaciones VALUES (67, 425, '2026-04-17 02:41:27', 'Disponibles los resultados de las olimpiadas de matemáticas. Consulten en la plataforma.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0067.jpg');
INSERT INTO public.publicaciones VALUES (68, 13, '2026-03-25 19:50:23', 'Invitados a la jornada de salud mental esta semana. La universidad cuida tu bienestar.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (69, 460, '2026-04-06 15:18:39', '¡El congreso de tecnología del próximo viernes tendrá cupos limitados! No olviden inscribirse.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0069.jpg');
INSERT INTO public.publicaciones VALUES (70, 189, '2026-01-12 09:59:09', 'El festival gastronómico fue todo un éxito. La gastronomía también es cultura universitaria.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (71, 55, '2026-02-24 10:32:45', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0071.jpg');
INSERT INTO public.publicaciones VALUES (72, 482, '2026-02-25 12:53:37', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0072.jpg');
INSERT INTO public.publicaciones VALUES (73, 196, '2026-01-21 02:59:14', 'El festival gastronómico fue todo un éxito. La gastronomía también es cultura universitaria.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (74, 276, '2026-02-01 16:51:03', 'Comparto mis apuntes del taller de Machine Learning. Espero que les sirvan a todos.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (75, 338, '2026-05-15 16:28:20', 'El hackathon fue una experiencia transformadora. Aprendí más en 24 horas que en meses de clase.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0075.jpg');
INSERT INTO public.publicaciones VALUES (76, 429, '2026-03-17 07:21:15', 'Mis apuntes del congreso de energías renovables. Varios temas aplicables a proyectos de grado.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0076.jpg');
INSERT INTO public.publicaciones VALUES (77, 119, '2026-04-27 10:47:07', 'La marcha cultural del día del idioma fue hermosa. La diversidad enriquece nuestra institución.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0077.jpg');
INSERT INTO public.publicaciones VALUES (78, 228, '2026-04-15 11:05:22', 'Abrieron convocatoria para monitores académicos del segundo semestre. Requisitos en la plataforma.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (79, 469, '2026-04-03 20:30:38', 'Acabo de terminar mi proyecto de grado. Gracias a todos los que me apoyaron en este camino.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (80, 403, '2026-04-18 07:36:52', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0080.jpg');
INSERT INTO public.publicaciones VALUES (81, 398, '2026-04-15 21:37:42', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0081.jpg');
INSERT INTO public.publicaciones VALUES (82, 408, '2026-03-15 10:20:07', 'Busco compañero de estudio para el parcial de Cálculo II. Escríbeme por mensaje.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (83, 216, '2026-05-10 04:36:31', '¿Alguien más tomó el seminario de ética en tecnología? Me parece un tema urgente y necesario.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0083.jpg');
INSERT INTO public.publicaciones VALUES (84, 461, '2026-02-16 14:00:10', 'El equipo de robótica ganó el primer lugar en la competencia regional. ¡Orgullo ITPB!', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (85, 135, '2026-05-01 23:06:08', 'Compartiendo el resumen de la conferencia de ciberseguridad. Fue una experiencia increíble.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (86, 13, '2026-02-12 02:08:32', 'Hoy tuvimos una charla motivacional con egresados exitosos. El mensaje clave: la persistencia paga.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (87, 463, '2026-04-19 11:08:25', 'La marcha cultural del día del idioma fue hermosa. La diversidad enriquece nuestra institución.', 'imagen', 'https://cdn.pascualbravo.edu.co/media/p0087.jpg');
INSERT INTO public.publicaciones VALUES (88, 365, '2026-03-17 03:21:57', 'Invitados a la jornada de salud mental esta semana. La universidad cuida tu bienestar.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (89, 370, '2026-01-12 02:47:58', 'Vendo libros de Ingeniería de Software en excelente estado. Ver perfil para precios.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (90, 467, '2026-04-15 20:28:47', 'El semillero de IA tiene cupos disponibles. Si te apasiona el aprendizaje automático, ¡únete!', 'video', 'https://cdn.pascualbravo.edu.co/media/p0090.jpg');
INSERT INTO public.publicaciones VALUES (91, 388, '2026-05-03 22:08:46', 'Reflexión del día: La tecnología es solo tan buena como el propósito con el que la usamos.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (92, 78, '2026-01-02 18:37:23', 'Nuevo grupo de estudio para la certificación AWS. Si te interesa, escríbeme.', 'enlace', NULL);
INSERT INTO public.publicaciones VALUES (93, 195, '2026-03-24 14:11:32', 'Recordatorio: Mañana es la entrega de proyectos integradores. No dejen para después.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0093.jpg');
INSERT INTO public.publicaciones VALUES (94, 484, '2026-01-25 07:19:31', 'Invitados a la jornada de salud mental esta semana. La universidad cuida tu bienestar.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (95, 289, '2026-05-13 16:37:32', 'El semillero de IA tiene cupos disponibles. Si te apasiona el aprendizaje automático, ¡únete!', 'video', 'https://cdn.pascualbravo.edu.co/media/p0095.jpg');
INSERT INTO public.publicaciones VALUES (96, 166, '2026-04-09 10:48:11', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'texto', NULL);
INSERT INTO public.publicaciones VALUES (97, 417, '2026-02-23 13:33:17', 'El festival gastronómico fue todo un éxito. La gastronomía también es cultura universitaria.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0097.jpg');
INSERT INTO public.publicaciones VALUES (98, 51, '2026-03-30 09:10:07', 'Disponibles los resultados de las olimpiadas de matemáticas. Consulten en la plataforma.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0098.jpg');
INSERT INTO public.publicaciones VALUES (99, 250, '2026-04-23 07:56:10', 'Disponibles los resultados de las olimpiadas de matemáticas. Consulten en la plataforma.', 'video', 'https://cdn.pascualbravo.edu.co/media/p0099.jpg');
INSERT INTO public.publicaciones VALUES (100, 311, '2026-01-28 07:42:17', 'Nuevo taller de React disponible esta semana en el laboratorio de cómputo. Inscripciones abiertas.', 'texto', NULL);


--
-- Data for Name: reacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'administrador', 'Gestiona la configuración global y los usuarios en el BackOffice');
INSERT INTO public.roles VALUES (2, 'auxiliar', 'Apoya las operaciones administrativas en el BackOffice');
INSERT INTO public.roles VALUES (3, 'miembro', 'Participa en todas las actividades de la red social');
INSERT INTO public.roles VALUES (4, 'visitante', 'Acceso restringido, usuario en período de evaluación');


--
-- Data for Name: seguidores; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.servicios VALUES (1, 162, 8, 'Traducción Español-Inglés Técnico', 'Identidad visual profesional adaptada a tu marca personal o proyecto.', 126937, 'no_disponible', '2026-03-11 07:59:58');
INSERT INTO public.servicios VALUES (2, 112, 12, 'Asesoría en Cálculo Diferencial', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 310844, 'no_disponible', '2026-02-01 12:01:28');
INSERT INTO public.servicios VALUES (3, 445, 7, 'Elaboración de Presentaciones Profesionales', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 172980, 'no_disponible', '2026-02-20 06:49:24');
INSERT INTO public.servicios VALUES (4, 303, 4, 'Desarrollo de Aplicaciones Web', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 192145, 'en_reserva', '2026-05-13 03:10:48');
INSERT INTO public.servicios VALUES (5, 108, 4, 'Consultoría en Marketing Digital', 'Procesamiento y visualización de datos para informes y proyectos.', 144685, 'no_disponible', '2026-04-17 06:13:05');
INSERT INTO public.servicios VALUES (6, 410, 17, 'Diseño UX/UI Básico', 'Guía metodológica para estructurar y desarrollar tu proyecto de grado.', 111691, 'disponible', '2026-04-27 00:00:24');
INSERT INTO public.servicios VALUES (7, 412, 14, 'Elaboración de Presentaciones Profesionales', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 143498, 'no_disponible', '2026-01-17 13:54:41');
INSERT INTO public.servicios VALUES (8, 154, 8, 'Desarrollo de Aplicaciones Web', 'Traducción técnica precisa con terminología especializada en TI.', 310301, 'disponible', '2026-03-12 23:41:57');
INSERT INTO public.servicios VALUES (9, 166, 2, 'Reparación de Computadores', 'Identidad visual profesional adaptada a tu marca personal o proyecto.', 86755, 'disponible', '2026-02-02 16:09:08');
INSERT INTO public.servicios VALUES (10, 356, 16, 'Tutoría de Programación Python', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 220785, 'disponible', '2026-03-17 11:39:26');
INSERT INTO public.servicios VALUES (11, 422, 6, 'Edición de Video para Redes', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 85884, 'en_reserva', '2026-02-08 23:51:51');
INSERT INTO public.servicios VALUES (12, 343, 6, 'Diseño UX/UI Básico', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 281698, 'disponible', '2026-05-08 06:19:25');
INSERT INTO public.servicios VALUES (13, 321, 12, 'Clases de Inglés para Ingenieros', 'Procesamiento y visualización de datos para informes y proyectos.', 132743, 'disponible', '2026-03-26 00:56:30');
INSERT INTO public.servicios VALUES (14, 18, 5, 'Edición de Video para Redes', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 202632, 'en_reserva', '2026-05-15 05:10:06');
INSERT INTO public.servicios VALUES (15, 8, 12, 'Asesoría en Proyectos de Grado', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 164363, 'disponible', '2026-01-29 15:29:26');
INSERT INTO public.servicios VALUES (16, 439, 18, 'Impresión 3D de Prototipos', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 304213, 'en_reserva', '2026-01-01 09:30:30');
INSERT INTO public.servicios VALUES (17, 461, 9, 'Reparación de Computadores', 'Cobertura de alta calidad para tus eventos académicos y culturales.', 240040, 'no_disponible', '2026-01-25 15:31:47');
INSERT INTO public.servicios VALUES (18, 426, 19, 'Traducción Español-Inglés Técnico', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 100180, 'disponible', '2026-02-06 07:42:05');
INSERT INTO public.servicios VALUES (19, 381, 4, 'Elaboración de Presentaciones Profesionales', 'Diagnóstico, limpieza y reparación de hardware y software.', 313814, 'disponible', '2026-03-05 07:16:11');
INSERT INTO public.servicios VALUES (20, 374, 10, 'Soporte Técnico a Domicilio', 'Guía metodológica para estructurar y desarrollar tu proyecto de grado.', 243874, 'en_reserva', '2026-05-13 18:56:17');
INSERT INTO public.servicios VALUES (21, 390, 5, 'Soporte Técnico a Domicilio', 'Traducción técnica precisa con terminología especializada en TI.', 149927, 'disponible', '2026-01-09 23:57:51');
INSERT INTO public.servicios VALUES (22, 198, 2, 'Traducción Español-Inglés Técnico', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 34583, 'en_reserva', '2026-01-09 07:10:25');
INSERT INTO public.servicios VALUES (23, 166, 1, 'Mantenimiento de Redes LAN', 'Guía metodológica para estructurar y desarrollar tu proyecto de grado.', 184830, 'no_disponible', '2026-02-18 20:55:52');
INSERT INTO public.servicios VALUES (24, 498, 19, 'Elaboración de Presentaciones Profesionales', 'Guía metodológica para estructurar y desarrollar tu proyecto de grado.', 347664, 'no_disponible', '2026-03-09 17:28:07');
INSERT INTO public.servicios VALUES (25, 382, 9, 'Creación de Contenido para Redes Sociales', 'Cobertura de alta calidad para tus eventos académicos y culturales.', 137921, 'disponible', '2026-03-07 10:51:55');
INSERT INTO public.servicios VALUES (26, 250, 18, 'Impresión 3D de Prototipos', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 243764, 'no_disponible', '2026-05-13 08:04:50');
INSERT INTO public.servicios VALUES (27, 188, 14, 'Asesoría en Cálculo Diferencial', 'Vocabulario técnico, comprensión auditiva y pronunciación profesional.', 70393, 'disponible', '2026-04-28 03:07:35');
INSERT INTO public.servicios VALUES (28, 365, 10, 'Reparación de Computadores', 'Cobertura de alta calidad para tus eventos académicos y culturales.', 128250, 'no_disponible', '2026-01-22 16:11:25');
INSERT INTO public.servicios VALUES (29, 420, 17, 'Traducción Español-Inglés Técnico', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 298804, 'disponible', '2026-01-05 06:46:47');
INSERT INTO public.servicios VALUES (30, 182, 17, 'Producción de Podcast Institucional', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 210123, 'en_reserva', '2026-05-15 01:51:34');
INSERT INTO public.servicios VALUES (31, 186, 18, 'Asesoría en Proyectos de Grado', 'Vocabulario técnico, comprensión auditiva y pronunciación profesional.', 83361, 'disponible', '2026-01-26 21:10:40');
INSERT INTO public.servicios VALUES (32, 325, 20, 'Asesoría en Proyectos de Grado', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 203063, 'en_reserva', '2026-04-19 06:17:03');
INSERT INTO public.servicios VALUES (33, 492, 13, 'Análisis de Datos con Excel', 'Traducción técnica precisa con terminología especializada en TI.', 318306, 'no_disponible', '2026-05-02 14:20:08');
INSERT INTO public.servicios VALUES (34, 370, 10, 'Asesoría en Cálculo Diferencial', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 110425, 'en_reserva', '2026-03-21 06:59:46');
INSERT INTO public.servicios VALUES (35, 314, 20, 'Desarrollo de Aplicaciones Web', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 271654, 'disponible', '2026-02-06 15:52:10');
INSERT INTO public.servicios VALUES (36, 392, 8, 'Elaboración de Presentaciones Profesionales', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 236747, 'no_disponible', '2026-02-19 07:53:22');
INSERT INTO public.servicios VALUES (37, 37, 8, 'Clases de Inglés para Ingenieros', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 315644, 'disponible', '2026-02-08 06:28:09');
INSERT INTO public.servicios VALUES (38, 345, 9, 'Soporte Técnico a Domicilio', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 233762, 'en_reserva', '2026-03-21 16:06:49');
INSERT INTO public.servicios VALUES (39, 322, 20, 'Consultoría en Marketing Digital', 'Identidad visual profesional adaptada a tu marca personal o proyecto.', 241335, 'no_disponible', '2026-02-01 17:47:39');
INSERT INTO public.servicios VALUES (40, 233, 5, 'Desarrollo de Aplicaciones Web', 'Cobertura de alta calidad para tus eventos académicos y culturales.', 310075, 'disponible', '2026-04-08 08:07:40');
INSERT INTO public.servicios VALUES (41, 239, 14, 'Mantenimiento de Redes LAN', 'Soluciones funcionales, responsivas y con buenas prácticas de código.', 310398, 'en_reserva', '2026-05-05 09:14:33');
INSERT INTO public.servicios VALUES (42, 53, 3, 'Producción de Podcast Institucional', 'Procesamiento y visualización de datos para informes y proyectos.', 306827, 'disponible', '2026-05-07 22:27:26');
INSERT INTO public.servicios VALUES (43, 30, 4, 'Clases de Inglés para Ingenieros', 'Diagnóstico, limpieza y reparación de hardware y software.', 319514, 'en_reserva', '2026-05-11 10:26:42');
INSERT INTO public.servicios VALUES (44, 429, 9, 'Diseño UX/UI Básico', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 34136, 'en_reserva', '2026-05-05 07:37:31');
INSERT INTO public.servicios VALUES (45, 114, 19, 'Edición de Video para Redes', 'Diagnóstico, limpieza y reparación de hardware y software.', 63269, 'en_reserva', '2026-05-05 17:38:53');
INSERT INTO public.servicios VALUES (46, 290, 13, 'Producción de Podcast Institucional', 'Vocabulario técnico, comprensión auditiva y pronunciación profesional.', 308526, 'en_reserva', '2026-04-08 01:38:06');
INSERT INTO public.servicios VALUES (47, 303, 4, 'Mantenimiento de Redes LAN', 'Acompañamiento práctico con proyectos reales y ejemplos del sector.', 67591, 'disponible', '2026-04-03 18:43:45');
INSERT INTO public.servicios VALUES (48, 463, 20, 'Edición de Video para Redes', 'Traducción técnica precisa con terminología especializada en TI.', 259852, 'disponible', '2026-03-30 20:50:28');
INSERT INTO public.servicios VALUES (49, 437, 15, 'Mantenimiento de Redes LAN', 'Vocabulario técnico, comprensión auditiva y pronunciación profesional.', 41928, 'no_disponible', '2026-04-21 21:58:01');
INSERT INTO public.servicios VALUES (50, 111, 19, 'Fotografía para Eventos Universitarios', 'Sesiones personalizadas para reforzar conceptos y resolver ejercicios.', 231767, 'no_disponible', '2026-01-26 09:58:26');


--
-- Data for Name: tipos_evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos_evento VALUES (1, 'congreso', 1);
INSERT INTO public.tipos_evento VALUES (2, 'conferencia', 1);
INSERT INTO public.tipos_evento VALUES (3, 'taller', 1);
INSERT INTO public.tipos_evento VALUES (4, 'seminario', 1);
INSERT INTO public.tipos_evento VALUES (5, 'feria_tecnologica', 1);
INSERT INTO public.tipos_evento VALUES (6, 'deportivo', 1);
INSERT INTO public.tipos_evento VALUES (7, 'cultural', 1);
INSERT INTO public.tipos_evento VALUES (8, 'hackathon', 1);
INSERT INTO public.tipos_evento VALUES (9, 'simposio', 1);
INSERT INTO public.tipos_evento VALUES (10, 'foro', 1);
INSERT INTO public.tipos_evento VALUES (11, 'concierto', 1);
INSERT INTO public.tipos_evento VALUES (12, 'feria_laboral', 1);
INSERT INTO public.tipos_evento VALUES (13, 'olimpiada', 1);
INSERT INTO public.tipos_evento VALUES (14, 'encuentro', 1);
INSERT INTO public.tipos_evento VALUES (15, 'clausura', 1);
INSERT INTO public.tipos_evento VALUES (16, 'jornada_bienestar', 1);
INSERT INTO public.tipos_evento VALUES (17, 'expoproyectos', 1);
INSERT INTO public.tipos_evento VALUES (18, 'induccion', 1);
INSERT INTO public.tipos_evento VALUES (19, 'maratonprogramacion', 1);
INSERT INTO public.tipos_evento VALUES (20, 'festival', 1);


--
-- Data for Name: tipos_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos_producto VALUES (1, 'libro_texto', 1);
INSERT INTO public.tipos_producto VALUES (2, 'portatil', 1);
INSERT INTO public.tipos_producto VALUES (3, 'telefono_movil', 1);
INSERT INTO public.tipos_producto VALUES (4, 'tablet', 1);
INSERT INTO public.tipos_producto VALUES (5, 'articulo_deportivo', 1);
INSERT INTO public.tipos_producto VALUES (6, 'uniforme_institucional', 1);
INSERT INTO public.tipos_producto VALUES (7, 'accesorio_tecnico', 1);
INSERT INTO public.tipos_producto VALUES (8, 'instrumento_musical', 1);
INSERT INTO public.tipos_producto VALUES (9, 'calzado_deportivo', 1);
INSERT INTO public.tipos_producto VALUES (10, 'mochila', 1);
INSERT INTO public.tipos_producto VALUES (11, 'material_laboratorio', 1);
INSERT INTO public.tipos_producto VALUES (12, 'herramienta_taller', 1);
INSERT INTO public.tipos_producto VALUES (13, 'electrodomestico', 1);
INSERT INTO public.tipos_producto VALUES (14, 'videojuego', 1);
INSERT INTO public.tipos_producto VALUES (15, 'bicicleta', 1);
INSERT INTO public.tipos_producto VALUES (16, 'auriculares', 1);
INSERT INTO public.tipos_producto VALUES (17, 'camara_fotografica', 1);
INSERT INTO public.tipos_producto VALUES (18, 'suplemento_alimenticio', 1);
INSERT INTO public.tipos_producto VALUES (19, 'papeleria', 1);
INSERT INTO public.tipos_producto VALUES (20, 'ropa_casual', 1);


--
-- Data for Name: tipos_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos_servicio VALUES (1, 'asesoria_academica', 2);
INSERT INTO public.tipos_servicio VALUES (2, 'tutoria_matematicas', 2);
INSERT INTO public.tipos_servicio VALUES (3, 'tutoria_ingles', 2);
INSERT INTO public.tipos_servicio VALUES (4, 'diseno_grafico', 2);
INSERT INTO public.tipos_servicio VALUES (5, 'desarrollo_web', 2);
INSERT INTO public.tipos_servicio VALUES (6, 'reparacion_computadores', 2);
INSERT INTO public.tipos_servicio VALUES (7, 'fotografia_eventos', 2);
INSERT INTO public.tipos_servicio VALUES (8, 'traduccion_documentos', 2);
INSERT INTO public.tipos_servicio VALUES (9, 'clases_programacion', 2);
INSERT INTO public.tipos_servicio VALUES (10, 'asesoria_financiera', 2);
INSERT INTO public.tipos_servicio VALUES (11, 'elaboracion_tesis', 2);
INSERT INTO public.tipos_servicio VALUES (12, 'edicion_video', 2);
INSERT INTO public.tipos_servicio VALUES (13, 'impresion_3d', 2);
INSERT INTO public.tipos_servicio VALUES (14, 'soporte_tecnico', 2);
INSERT INTO public.tipos_servicio VALUES (15, 'clases_idiomas', 2);
INSERT INTO public.tipos_servicio VALUES (16, 'consultoria_empresarial', 2);
INSERT INTO public.tipos_servicio VALUES (17, 'diseno_ux_ui', 2);
INSERT INTO public.tipos_servicio VALUES (18, 'analisis_datos', 2);
INSERT INTO public.tipos_servicio VALUES (19, 'marketing_digital', 2);
INSERT INTO public.tipos_servicio VALUES (20, 'produccion_musical', 2);


--
-- Data for Name: tipos_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipos_usuario VALUES (1, 'estudiante', 'Estudiante activo matriculado en algún programa académico', 1);
INSERT INTO public.tipos_usuario VALUES (2, 'docente', 'Profesor o instructor vinculado a la institución', 1);
INSERT INTO public.tipos_usuario VALUES (3, 'egresado', 'Graduado de cualquier programa de la institución', 1);
INSERT INTO public.tipos_usuario VALUES (4, 'empleado', 'Personal administrativo u operativo activo', 1);
INSERT INTO public.tipos_usuario VALUES (5, 'empresario', 'Representante de una empresa externa aliada', 1);
INSERT INTO public.tipos_usuario VALUES (6, 'ex_empleado', 'Personal que ya no tiene vínculo laboral activo', 1);
INSERT INTO public.tipos_usuario VALUES (7, 'ex_estudiante', 'Estudiante que abandonó el programa sin graduarse', 1);
INSERT INTO public.tipos_usuario VALUES (8, 'ex_docente', 'Docente retirado o con contrato finalizado', 1);
INSERT INTO public.tipos_usuario VALUES (9, 'guest', 'Invitado externo con acceso temporal y limitado', 1);


--
-- Data for Name: transacciones_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.transacciones_servicio VALUES (1, 2, 374, '2026-04-27 08:22:52', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (2, 16, 142, '2026-04-25 01:20:29', 'completado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (3, 14, 286, '2026-05-21 20:20:47', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (4, 50, 418, '2026-02-14 15:54:05', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (5, 40, 276, '2026-02-28 10:53:19', 'solicitado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (6, 41, 208, '2026-03-22 19:31:40', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (7, 13, 136, '2026-05-05 11:21:51', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (8, 49, 82, '2026-02-13 10:01:07', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (9, 20, 466, '2026-05-10 22:41:35', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (10, 35, 92, '2026-04-12 19:44:04', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (11, 6, 365, '2026-04-14 08:09:45', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (12, 23, 204, '2026-02-04 12:06:54', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (13, 37, 498, '2026-01-22 10:14:28', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (14, 36, 80, '2026-03-12 00:31:14', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (15, 15, 226, '2026-02-25 04:00:18', 'en_proceso', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (16, 40, 248, '2026-04-23 13:35:35', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (17, 12, 435, '2026-05-13 18:25:40', 'cancelado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (18, 46, 408, '2026-04-04 08:27:23', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (19, 21, 277, '2026-04-02 02:44:08', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (20, 35, 297, '2026-02-02 03:58:50', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (21, 21, 54, '2026-02-28 23:22:45', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (22, 18, 295, '2026-01-14 14:39:28', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (23, 28, 34, '2026-02-13 00:35:28', 'solicitado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (24, 31, 445, '2026-02-07 02:43:22', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (25, 37, 130, '2026-01-08 22:38:31', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (26, 26, 111, '2026-04-26 09:34:44', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (27, 15, 292, '2026-05-11 13:09:49', 'completado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (28, 40, 28, '2026-04-02 18:07:49', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (29, 5, 272, '2026-04-16 23:10:46', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (30, 39, 397, '2026-02-15 05:01:41', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (31, 22, 46, '2026-01-25 12:36:44', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (32, 25, 357, '2026-05-02 04:54:21', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (33, 20, 182, '2026-02-15 22:27:56', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (34, 6, 95, '2026-03-08 12:12:14', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (35, 22, 232, '2026-01-25 16:16:01', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (36, 4, 350, '2026-04-06 03:10:00', 'solicitado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (37, 21, 197, '2026-03-20 00:51:57', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (38, 12, 97, '2026-05-08 05:34:13', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (39, 44, 468, '2026-02-09 19:23:36', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (40, 46, 434, '2026-02-15 16:09:52', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (41, 40, 20, '2026-05-18 03:51:59', 'completado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (42, 7, 179, '2026-02-16 18:33:10', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (43, 13, 309, '2026-02-09 19:58:21', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (44, 25, 402, '2026-04-25 03:42:35', 'solicitado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (45, 16, 188, '2026-02-06 07:52:31', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (46, 3, 184, '2026-01-16 15:51:53', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (47, 6, 340, '2026-03-24 16:36:36', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (48, 42, 103, '2026-03-14 10:08:28', 'en_proceso', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (49, 41, 219, '2026-04-14 13:24:05', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (50, 32, 54, '2026-03-24 17:30:39', 'cancelado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (51, 32, 403, '2026-03-15 21:44:03', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (52, 6, 158, '2026-05-19 05:41:20', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (53, 2, 25, '2026-03-19 12:12:22', 'solicitado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (54, 48, 261, '2026-05-15 05:32:23', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (55, 7, 235, '2026-02-17 07:45:20', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (56, 32, 106, '2026-01-04 01:59:24', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (57, 19, 3, '2026-03-03 21:52:58', 'completado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (58, 25, 424, '2026-02-28 11:58:53', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (59, 10, 73, '2026-03-05 19:42:16', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (60, 46, 443, '2026-03-21 06:56:41', 'completado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (61, 45, 6, '2026-04-17 13:24:17', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (62, 17, 308, '2026-01-03 20:44:25', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (63, 9, 340, '2026-02-27 02:40:07', 'solicitado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (64, 32, 35, '2026-02-16 17:20:10', 'completado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (65, 19, 275, '2026-03-15 09:54:36', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (66, 49, 62, '2026-04-12 06:05:35', 'cancelado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (67, 9, 266, '2026-01-10 15:30:06', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (68, 3, 427, '2026-04-10 05:05:48', 'solicitado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (69, 28, 316, '2026-04-05 14:47:09', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (70, 50, 22, '2026-05-09 06:49:13', 'completado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (71, 37, 8, '2026-02-09 10:55:16', 'en_proceso', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (72, 30, 103, '2026-01-15 12:24:09', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (73, 5, 116, '2026-02-17 20:12:21', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (74, 29, 36, '2026-03-04 19:33:18', 'en_proceso', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (75, 36, 494, '2026-03-23 01:07:43', 'solicitado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (76, 34, 274, '2026-01-05 19:46:10', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (77, 3, 74, '2026-01-27 21:14:00', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (78, 37, 30, '2026-04-10 18:07:54', 'en_proceso', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (79, 37, 280, '2026-01-19 00:41:52', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (80, 42, 198, '2026-03-14 21:39:24', 'cancelado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (81, 44, 252, '2026-03-06 11:40:29', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (82, 30, 275, '2026-04-03 07:09:18', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (83, 17, 452, '2026-02-11 11:47:01', 'cancelado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (84, 10, 22, '2026-04-28 13:45:56', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (85, 9, 431, '2026-04-01 06:25:26', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (86, 47, 232, '2026-04-24 12:29:23', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (87, 43, 205, '2026-02-04 23:33:13', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (88, 46, 98, '2026-02-19 23:42:50', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (89, 36, 442, '2026-04-15 11:41:19', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (90, 10, 241, '2026-01-28 17:41:28', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (91, 27, 27, '2026-02-21 06:21:35', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (92, 34, 222, '2026-02-16 14:01:44', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (93, 37, 342, '2026-02-14 08:47:43', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (94, 37, 401, '2026-02-20 04:26:20', 'cancelado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (95, 48, 67, '2026-05-05 10:39:59', 'solicitado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (96, 5, 44, '2026-01-06 00:58:55', 'solicitado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (97, 6, 161, '2026-04-02 06:47:09', 'en_proceso', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (98, 5, 186, '2026-03-22 18:57:53', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (99, 22, 361, '2026-02-14 09:19:06', 'en_proceso', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (100, 11, 213, '2026-01-31 17:58:39', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (101, 36, 283, '2026-05-01 22:17:44', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (102, 43, 485, '2026-02-07 14:06:48', 'solicitado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (103, 25, 243, '2026-04-08 15:10:49', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (104, 45, 419, '2026-04-03 14:37:36', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (105, 2, 497, '2026-05-06 21:36:22', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (106, 24, 36, '2026-02-15 04:39:19', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (107, 8, 479, '2026-02-20 20:20:18', 'solicitado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (108, 39, 410, '2026-05-07 00:39:57', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (109, 24, 436, '2026-03-06 06:32:17', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (110, 21, 464, '2026-02-12 01:41:15', 'completado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (111, 29, 222, '2026-03-28 01:17:47', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (112, 22, 283, '2026-01-09 04:55:59', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (113, 2, 155, '2026-04-08 06:57:30', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (114, 3, 356, '2026-03-11 22:24:21', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (115, 28, 209, '2026-03-29 04:22:46', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (116, 13, 251, '2026-03-14 08:05:58', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (117, 43, 468, '2026-03-23 16:57:07', 'solicitado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (118, 49, 55, '2026-03-04 02:11:23', 'solicitado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (119, 37, 411, '2026-03-02 02:55:04', 'solicitado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (120, 48, 414, '2026-03-29 19:04:09', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (121, 43, 55, '2026-02-01 01:45:08', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (122, 12, 47, '2026-01-24 00:27:50', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (123, 4, 368, '2026-01-21 12:20:40', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (124, 13, 363, '2026-05-07 19:45:11', 'cancelado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (125, 47, 347, '2026-01-16 14:11:32', 'solicitado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (126, 12, 499, '2026-02-20 08:09:56', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (127, 45, 390, '2026-01-20 06:11:54', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (128, 11, 203, '2026-03-17 19:26:32', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (129, 28, 129, '2026-03-30 23:15:33', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (130, 19, 387, '2026-02-11 02:03:04', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (131, 47, 31, '2026-04-21 02:43:48', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (132, 48, 346, '2026-01-23 10:37:49', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (133, 44, 492, '2026-01-17 18:16:46', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (134, 23, 381, '2026-05-03 11:31:19', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (135, 35, 382, '2026-02-18 07:37:10', 'solicitado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (136, 27, 239, '2026-04-29 10:59:50', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (137, 30, 232, '2026-02-09 04:47:48', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (138, 2, 448, '2026-02-05 10:24:55', 'en_proceso', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (139, 24, 8, '2026-04-22 21:57:11', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (140, 12, 112, '2026-01-25 00:25:30', 'en_proceso', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (141, 22, 102, '2026-01-06 15:25:10', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (142, 18, 117, '2026-02-18 15:38:46', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (143, 28, 486, '2026-02-10 15:42:03', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (144, 5, 488, '2026-03-24 22:30:38', 'completado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (145, 16, 266, '2026-05-07 06:26:31', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (146, 41, 82, '2026-03-28 20:19:43', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (147, 8, 307, '2026-02-03 16:18:21', 'completado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (148, 24, 290, '2026-05-02 02:01:28', 'completado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (149, 16, 108, '2026-03-25 22:14:58', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (150, 18, 285, '2026-03-29 18:50:21', 'en_proceso', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (151, 21, 401, '2026-02-28 22:37:39', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (152, 32, 289, '2026-05-01 00:20:32', 'solicitado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (153, 49, 76, '2026-03-24 02:33:31', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (154, 47, 137, '2026-01-18 14:24:49', 'en_proceso', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (155, 46, 74, '2026-04-04 01:30:15', 'en_proceso', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (156, 21, 183, '2026-05-04 17:09:50', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (157, 32, 161, '2026-05-18 06:52:51', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (158, 39, 62, '2026-03-17 23:03:47', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (159, 33, 145, '2026-03-05 12:27:44', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (160, 17, 105, '2026-02-06 09:01:01', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (161, 24, 239, '2026-02-07 14:40:24', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (162, 29, 389, '2026-03-22 03:59:17', 'cancelado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (163, 13, 362, '2026-04-27 09:10:37', 'en_proceso', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (164, 2, 64, '2026-01-14 10:35:30', 'completado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (165, 21, 426, '2026-04-07 17:01:40', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (166, 26, 92, '2026-03-25 19:53:48', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (167, 21, 290, '2026-01-11 16:03:46', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (168, 5, 475, '2026-01-18 04:09:06', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (169, 6, 387, '2026-04-03 11:21:05', 'cancelado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (170, 49, 36, '2026-05-07 12:34:03', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (171, 45, 80, '2026-05-21 02:52:13', 'cancelado', 'Se solicitó ajuste al entregable. Pendiente de revisión.');
INSERT INTO public.transacciones_servicio VALUES (172, 8, 391, '2026-03-08 07:15:03', 'solicitado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (173, 42, 432, '2026-02-27 15:02:02', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (174, 10, 489, '2026-02-05 16:20:20', 'cancelado', 'Entregado antes del plazo acordado. Excelente calidad.');
INSERT INTO public.transacciones_servicio VALUES (175, 2, 262, '2026-03-16 15:01:42', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (176, 5, 21, '2026-02-21 18:02:13', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (177, 32, 4, '2026-03-31 22:05:37', 'completado', NULL);
INSERT INTO public.transacciones_servicio VALUES (178, 11, 204, '2026-02-24 04:34:00', 'completado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (179, 36, 192, '2026-05-11 12:10:53', 'en_proceso', NULL);
INSERT INTO public.transacciones_servicio VALUES (180, 17, 172, '2026-02-20 10:57:16', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (181, 42, 147, '2026-04-26 00:28:38', 'cancelado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (182, 12, 58, '2026-01-11 12:51:06', 'en_proceso', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (183, 49, 292, '2026-03-18 22:43:13', 'completado', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (184, 30, 28, '2026-02-28 18:56:56', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (185, 33, 13, '2026-03-21 00:13:53', 'en_proceso', 'Se acordaron nuevas condiciones para continuar el servicio.');
INSERT INTO public.transacciones_servicio VALUES (186, 14, 256, '2026-04-10 23:20:29', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (187, 49, 85, '2026-05-06 15:35:38', 'completado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (188, 5, 316, '2026-01-28 00:54:01', 'solicitado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (189, 18, 477, '2026-01-01 09:28:24', 'en_proceso', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (190, 4, 189, '2026-02-25 20:12:27', 'completado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (191, 18, 214, '2026-01-06 09:49:02', 'solicitado', 'Servicio excelente, altamente recomendado.');
INSERT INTO public.transacciones_servicio VALUES (192, 10, 135, '2026-04-27 06:07:58', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (193, 12, 8, '2026-01-29 02:46:15', 'cancelado', NULL);
INSERT INTO public.transacciones_servicio VALUES (194, 45, 286, '2026-03-11 08:01:44', 'cancelado', 'El proveedor fue puntual y profesional en todo momento.');
INSERT INTO public.transacciones_servicio VALUES (195, 47, 355, '2026-02-09 06:04:25', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (196, 3, 255, '2026-04-21 14:26:11', 'solicitado', NULL);
INSERT INTO public.transacciones_servicio VALUES (197, 3, 337, '2026-01-17 08:45:18', 'cancelado', 'Cancelado por cambio de planes del solicitante.');
INSERT INTO public.transacciones_servicio VALUES (198, 18, 13, '2026-03-11 06:15:44', 'cancelado', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (199, 42, 23, '2026-04-22 17:44:31', 'en_proceso', 'Servicio prestado sin inconvenientes. Muy satisfecho.');
INSERT INTO public.transacciones_servicio VALUES (200, 19, 187, '2026-01-23 19:23:29', 'cancelado', NULL);


--
-- Data for Name: usuario_grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario_grupo VALUES (1, 284, 6, '2026-01-29 05:27:34', 'miembro');
INSERT INTO public.usuario_grupo VALUES (2, 456, 2, '2026-02-08 00:21:59', 'miembro');
INSERT INTO public.usuario_grupo VALUES (3, 143, 4, '2026-05-12 19:46:55', 'miembro');
INSERT INTO public.usuario_grupo VALUES (4, 35, 8, '2026-03-14 01:07:55', 'miembro');
INSERT INTO public.usuario_grupo VALUES (5, 198, 1, '2026-04-05 08:27:21', 'miembro');
INSERT INTO public.usuario_grupo VALUES (6, 403, 1, '2026-05-19 08:11:18', 'miembro');
INSERT INTO public.usuario_grupo VALUES (7, 19, 8, '2026-03-25 09:40:02', 'miembro');
INSERT INTO public.usuario_grupo VALUES (8, 193, 1, '2026-05-17 23:25:15', 'miembro');
INSERT INTO public.usuario_grupo VALUES (9, 284, 2, '2026-02-02 23:09:40', 'miembro');
INSERT INTO public.usuario_grupo VALUES (10, 468, 5, '2026-03-30 14:44:39', 'miembro');
INSERT INTO public.usuario_grupo VALUES (11, 433, 9, '2026-04-28 01:04:20', 'miembro');
INSERT INTO public.usuario_grupo VALUES (12, 86, 10, '2026-01-26 12:32:46', 'miembro');
INSERT INTO public.usuario_grupo VALUES (13, 485, 5, '2026-04-19 12:01:11', 'moderador');
INSERT INTO public.usuario_grupo VALUES (14, 142, 2, '2026-04-21 03:50:12', 'miembro');
INSERT INTO public.usuario_grupo VALUES (15, 166, 10, '2026-05-12 17:54:50', 'miembro');
INSERT INTO public.usuario_grupo VALUES (16, 420, 1, '2026-04-06 18:30:13', 'miembro');
INSERT INTO public.usuario_grupo VALUES (17, 234, 5, '2026-02-17 08:32:42', 'miembro');
INSERT INTO public.usuario_grupo VALUES (18, 215, 3, '2026-03-14 08:00:26', 'miembro');
INSERT INTO public.usuario_grupo VALUES (19, 411, 7, '2026-02-03 08:17:29', 'miembro');
INSERT INTO public.usuario_grupo VALUES (20, 336, 6, '2026-01-25 07:14:01', 'miembro');
INSERT INTO public.usuario_grupo VALUES (21, 124, 2, '2026-03-15 23:45:38', 'miembro');
INSERT INTO public.usuario_grupo VALUES (22, 312, 7, '2026-03-26 17:24:30', 'moderador');
INSERT INTO public.usuario_grupo VALUES (23, 17, 6, '2026-03-29 10:22:52', 'miembro');
INSERT INTO public.usuario_grupo VALUES (24, 247, 8, '2026-02-23 17:44:10', 'miembro');
INSERT INTO public.usuario_grupo VALUES (25, 141, 7, '2026-01-09 21:54:36', 'moderador');
INSERT INTO public.usuario_grupo VALUES (26, 334, 8, '2026-03-30 02:13:47', 'moderador');
INSERT INTO public.usuario_grupo VALUES (27, 200, 5, '2026-03-16 10:28:43', 'miembro');
INSERT INTO public.usuario_grupo VALUES (28, 90, 10, '2026-02-12 19:22:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (29, 402, 1, '2026-03-14 17:47:31', 'moderador');
INSERT INTO public.usuario_grupo VALUES (30, 203, 9, '2026-02-03 12:38:54', 'miembro');
INSERT INTO public.usuario_grupo VALUES (31, 213, 4, '2026-02-24 03:36:18', 'miembro');
INSERT INTO public.usuario_grupo VALUES (32, 92, 7, '2026-05-21 13:22:48', 'miembro');
INSERT INTO public.usuario_grupo VALUES (33, 472, 10, '2026-03-13 10:49:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (34, 351, 6, '2026-05-09 17:34:25', 'miembro');
INSERT INTO public.usuario_grupo VALUES (35, 217, 8, '2026-04-29 09:52:59', 'miembro');
INSERT INTO public.usuario_grupo VALUES (36, 484, 3, '2026-04-13 09:00:34', 'miembro');
INSERT INTO public.usuario_grupo VALUES (37, 401, 8, '2026-02-14 21:58:06', 'miembro');
INSERT INTO public.usuario_grupo VALUES (38, 345, 7, '2026-04-18 13:12:40', 'miembro');
INSERT INTO public.usuario_grupo VALUES (39, 125, 3, '2026-05-09 02:38:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (40, 495, 1, '2026-03-25 19:15:10', 'miembro');
INSERT INTO public.usuario_grupo VALUES (41, 252, 2, '2026-04-05 00:47:38', 'moderador');
INSERT INTO public.usuario_grupo VALUES (42, 293, 9, '2026-02-19 05:29:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (43, 133, 3, '2026-05-01 22:58:12', 'miembro');
INSERT INTO public.usuario_grupo VALUES (44, 161, 2, '2026-01-08 06:36:29', 'miembro');
INSERT INTO public.usuario_grupo VALUES (45, 361, 10, '2026-04-24 07:50:11', 'moderador');
INSERT INTO public.usuario_grupo VALUES (46, 267, 2, '2026-03-26 05:15:29', 'miembro');
INSERT INTO public.usuario_grupo VALUES (47, 46, 1, '2026-01-09 21:43:26', 'moderador');
INSERT INTO public.usuario_grupo VALUES (48, 251, 7, '2026-01-19 13:16:56', 'miembro');
INSERT INTO public.usuario_grupo VALUES (49, 72, 10, '2026-05-17 22:01:28', 'miembro');
INSERT INTO public.usuario_grupo VALUES (50, 382, 1, '2026-03-16 12:53:52', 'miembro');
INSERT INTO public.usuario_grupo VALUES (51, 31, 6, '2026-04-13 22:59:32', 'miembro');
INSERT INTO public.usuario_grupo VALUES (52, 236, 7, '2026-02-01 03:09:54', 'miembro');
INSERT INTO public.usuario_grupo VALUES (53, 433, 10, '2026-01-29 23:10:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (54, 184, 3, '2026-03-04 15:13:16', 'miembro');
INSERT INTO public.usuario_grupo VALUES (55, 339, 2, '2026-04-28 22:31:48', 'miembro');
INSERT INTO public.usuario_grupo VALUES (56, 144, 6, '2026-03-17 22:28:21', 'miembro');
INSERT INTO public.usuario_grupo VALUES (57, 369, 5, '2026-03-12 19:02:48', 'miembro');
INSERT INTO public.usuario_grupo VALUES (58, 278, 5, '2026-01-07 07:56:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (59, 376, 5, '2026-03-20 22:10:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (60, 254, 8, '2026-03-17 04:47:51', 'miembro');
INSERT INTO public.usuario_grupo VALUES (61, 160, 7, '2026-03-07 20:14:01', 'moderador');
INSERT INTO public.usuario_grupo VALUES (62, 309, 5, '2026-02-07 18:00:16', 'miembro');
INSERT INTO public.usuario_grupo VALUES (63, 271, 9, '2026-04-14 15:39:57', 'miembro');
INSERT INTO public.usuario_grupo VALUES (64, 187, 3, '2026-05-09 10:33:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (65, 485, 8, '2026-02-13 16:30:11', 'miembro');
INSERT INTO public.usuario_grupo VALUES (66, 205, 1, '2026-01-17 10:14:19', 'miembro');
INSERT INTO public.usuario_grupo VALUES (67, 87, 5, '2026-01-31 20:12:22', 'miembro');
INSERT INTO public.usuario_grupo VALUES (68, 302, 1, '2026-05-15 07:47:12', 'miembro');
INSERT INTO public.usuario_grupo VALUES (69, 27, 7, '2026-01-26 10:32:04', 'miembro');
INSERT INTO public.usuario_grupo VALUES (70, 284, 9, '2026-01-21 01:28:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (71, 136, 5, '2026-02-16 22:59:41', 'moderador');
INSERT INTO public.usuario_grupo VALUES (72, 127, 8, '2026-02-15 01:38:17', 'miembro');
INSERT INTO public.usuario_grupo VALUES (73, 57, 4, '2026-01-17 04:33:19', 'miembro');
INSERT INTO public.usuario_grupo VALUES (74, 127, 4, '2026-05-03 14:06:34', 'moderador');
INSERT INTO public.usuario_grupo VALUES (75, 37, 6, '2026-01-19 06:30:07', 'miembro');
INSERT INTO public.usuario_grupo VALUES (76, 254, 4, '2026-01-26 17:37:13', 'miembro');
INSERT INTO public.usuario_grupo VALUES (77, 164, 10, '2026-01-03 18:27:55', 'moderador');
INSERT INTO public.usuario_grupo VALUES (78, 379, 8, '2026-02-19 18:51:40', 'miembro');
INSERT INTO public.usuario_grupo VALUES (79, 244, 1, '2026-03-06 13:38:17', 'miembro');
INSERT INTO public.usuario_grupo VALUES (80, 101, 6, '2026-05-10 15:32:18', 'moderador');
INSERT INTO public.usuario_grupo VALUES (81, 164, 5, '2026-05-17 07:21:17', 'miembro');
INSERT INTO public.usuario_grupo VALUES (82, 268, 5, '2026-04-23 03:48:11', 'miembro');
INSERT INTO public.usuario_grupo VALUES (83, 174, 9, '2026-05-01 15:10:11', 'miembro');
INSERT INTO public.usuario_grupo VALUES (84, 232, 5, '2026-01-25 14:21:40', 'miembro');
INSERT INTO public.usuario_grupo VALUES (85, 432, 3, '2026-02-19 03:48:14', 'miembro');
INSERT INTO public.usuario_grupo VALUES (86, 267, 5, '2026-03-23 16:30:06', 'miembro');
INSERT INTO public.usuario_grupo VALUES (87, 485, 10, '2026-02-23 18:43:09', 'miembro');
INSERT INTO public.usuario_grupo VALUES (88, 109, 7, '2026-02-13 05:39:42', 'miembro');
INSERT INTO public.usuario_grupo VALUES (89, 500, 9, '2026-05-02 20:38:50', 'miembro');
INSERT INTO public.usuario_grupo VALUES (90, 382, 5, '2026-02-28 08:30:59', 'moderador');
INSERT INTO public.usuario_grupo VALUES (91, 166, 6, '2026-02-07 09:21:46', 'miembro');
INSERT INTO public.usuario_grupo VALUES (92, 392, 6, '2026-04-26 09:27:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (93, 224, 1, '2026-04-14 01:26:22', 'miembro');
INSERT INTO public.usuario_grupo VALUES (94, 82, 8, '2026-03-12 00:52:45', 'miembro');
INSERT INTO public.usuario_grupo VALUES (95, 349, 5, '2026-03-17 11:01:20', 'miembro');
INSERT INTO public.usuario_grupo VALUES (96, 206, 6, '2026-02-21 06:39:32', 'miembro');
INSERT INTO public.usuario_grupo VALUES (97, 151, 2, '2026-01-20 07:10:20', 'miembro');
INSERT INTO public.usuario_grupo VALUES (98, 493, 10, '2026-05-01 01:49:42', 'miembro');
INSERT INTO public.usuario_grupo VALUES (99, 476, 8, '2026-03-05 08:38:37', 'miembro');
INSERT INTO public.usuario_grupo VALUES (100, 62, 1, '2026-03-29 08:34:23', 'miembro');
INSERT INTO public.usuario_grupo VALUES (101, 156, 2, '2026-05-01 04:56:47', 'miembro');
INSERT INTO public.usuario_grupo VALUES (102, 407, 7, '2026-02-08 04:37:19', 'miembro');
INSERT INTO public.usuario_grupo VALUES (103, 298, 2, '2026-04-23 07:20:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (104, 296, 9, '2026-03-16 22:01:08', 'miembro');
INSERT INTO public.usuario_grupo VALUES (105, 45, 6, '2026-04-03 14:47:56', 'miembro');
INSERT INTO public.usuario_grupo VALUES (106, 175, 8, '2026-02-28 14:23:21', 'miembro');
INSERT INTO public.usuario_grupo VALUES (107, 371, 5, '2026-03-07 19:47:59', 'miembro');
INSERT INTO public.usuario_grupo VALUES (108, 72, 7, '2026-04-20 12:51:31', 'miembro');
INSERT INTO public.usuario_grupo VALUES (109, 436, 9, '2026-01-16 16:23:01', 'miembro');
INSERT INTO public.usuario_grupo VALUES (110, 27, 9, '2026-03-25 17:31:18', 'miembro');
INSERT INTO public.usuario_grupo VALUES (111, 335, 2, '2026-01-20 18:05:35', 'miembro');
INSERT INTO public.usuario_grupo VALUES (112, 283, 3, '2026-05-12 02:36:59', 'miembro');
INSERT INTO public.usuario_grupo VALUES (113, 343, 4, '2026-01-19 21:27:52', 'miembro');
INSERT INTO public.usuario_grupo VALUES (114, 242, 3, '2026-03-26 02:11:41', 'miembro');
INSERT INTO public.usuario_grupo VALUES (115, 243, 9, '2026-04-21 00:25:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (116, 330, 7, '2026-01-05 00:14:20', 'miembro');
INSERT INTO public.usuario_grupo VALUES (117, 310, 6, '2026-05-17 14:41:42', 'miembro');
INSERT INTO public.usuario_grupo VALUES (118, 431, 10, '2026-04-01 22:55:36', 'miembro');
INSERT INTO public.usuario_grupo VALUES (119, 406, 3, '2026-02-22 09:11:06', 'miembro');
INSERT INTO public.usuario_grupo VALUES (120, 319, 1, '2026-02-02 17:22:04', 'miembro');


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 3, 1, 'Steven', 'Valencia Obando', 'steven.valencia0001@pascualbravo.edu.co', '3168571795', '2004-09-04', 'masculino', '2026-04-09 18:12:16', true);
INSERT INTO public.usuarios VALUES (2, 3, 1, 'Nathalia', 'Reyes Nieto', 'nathalia.reyes0002@pascualbravo.edu.co', '3254318698', '2004-06-22', 'femenino', '2026-02-01 23:57:19', true);
INSERT INTO public.usuarios VALUES (3, 3, 1, 'Ricardo', 'Cárdenas Holguín', 'ricardo.cardenas0003@pascualbravo.edu.co', '3260888017', '1990-10-19', 'masculino', '2026-03-19 12:35:53', true);
INSERT INTO public.usuarios VALUES (4, 3, 1, 'Duván', 'Giraldo Posada', 'duvan.giraldo0004@pascualbravo.edu.co', '3138682516', '2001-08-26', 'masculino', '2026-02-13 21:05:18', true);
INSERT INTO public.usuarios VALUES (5, 3, 2, 'Camilo', 'Ruiz Ríos', 'camilo.ruiz0005@pascualbravo.edu.co', '3013278320', '1986-04-16', 'masculino', '2026-01-19 14:26:56', true);
INSERT INTO public.usuarios VALUES (6, 3, 7, 'Mariana', 'Medina Sierra', 'mariana.medina0006@pascualbravo.edu.co', NULL, '1985-02-25', 'femenino', '2026-04-19 07:11:51', true);
INSERT INTO public.usuarios VALUES (7, 3, 3, 'Camilo', 'Ramírez Cifuentes', 'camilo.ramirez0007@pascualbravo.edu.co', NULL, '1999-11-17', 'masculino', '2026-03-23 14:39:52', true);
INSERT INTO public.usuarios VALUES (8, 3, 1, 'Marcela', 'Suárez Lozano', 'marcela.suarez0008@pascualbravo.edu.co', '3170407340', '1993-04-27', 'femenino', '2026-03-12 16:31:40', true);
INSERT INTO public.usuarios VALUES (9, 3, 1, 'Alejandra', 'Mendoza Patiño', 'alejandra.mendoza0009@pascualbravo.edu.co', '3220814950', '1989-03-08', 'femenino', '2026-04-09 22:09:45', true);
INSERT INTO public.usuarios VALUES (10, 3, 1, 'Rodrigo', 'Cardona Correa', 'rodrigo.cardona0010@pascualbravo.edu.co', '3162274692', '2003-12-01', 'masculino', '2026-04-08 15:00:22', true);
INSERT INTO public.usuarios VALUES (11, 3, 2, 'Viviana', 'Arango Arias', 'viviana.arango0011@pascualbravo.edu.co', '3075529051', '1992-05-14', 'femenino', '2026-05-05 00:24:21', true);
INSERT INTO public.usuarios VALUES (12, 3, 5, 'Carolina', 'Torres Caro', 'carolina.torres0012@pascualbravo.edu.co', '3189442503', '2003-11-01', 'femenino', '2026-01-22 20:27:08', true);
INSERT INTO public.usuarios VALUES (13, 3, 1, 'Mauricio', 'Morales Cifuentes', 'mauricio.morales0013@pascualbravo.edu.co', '3147346970', '1998-05-27', 'masculino', '2026-01-21 15:01:47', true);
INSERT INTO public.usuarios VALUES (14, 3, 2, 'Jorge', 'Martínez Bernal', 'jorge.martinez0014@pascualbravo.edu.co', '3012735359', '2004-03-08', 'masculino', '2026-02-02 15:42:07', true);
INSERT INTO public.usuarios VALUES (15, 3, 6, 'Patricia', 'Vargas Campos', 'patricia.vargas0015@pascualbravo.edu.co', '3225372341', '1990-05-04', 'femenino', '2026-01-07 09:36:43', true);
INSERT INTO public.usuarios VALUES (16, 3, 1, 'Sara', 'García Calderón', 'sara.garcia0016@pascualbravo.edu.co', '3242594692', '1988-12-25', 'femenino', '2026-03-19 21:38:51', true);
INSERT INTO public.usuarios VALUES (17, 3, 8, 'Martha', 'Arango Gallego', 'martha.arango0017@pascualbravo.edu.co', '3077908907', '2005-06-01', 'femenino', '2026-04-18 15:06:27', true);
INSERT INTO public.usuarios VALUES (18, 3, 3, 'Diana', 'Valencia Naranjo', 'diana.valencia0018@pascualbravo.edu.co', '3246249845', '2004-09-25', 'femenino', '2026-05-04 14:27:52', true);
INSERT INTO public.usuarios VALUES (19, 3, 1, 'Camila', 'Mendoza Forero', 'camila.mendoza0019@pascualbravo.edu.co', '3186483924', '2004-11-13', 'femenino', '2026-03-28 00:31:54', true);
INSERT INTO public.usuarios VALUES (20, 3, 1, 'Julián', 'Murillo Vásquez', 'julian.murillo0020@pascualbravo.edu.co', '3247080140', '2002-01-17', 'masculino', '2026-02-18 02:15:46', true);
INSERT INTO public.usuarios VALUES (21, 3, 1, 'Fabio', 'Aguilar Forero', 'fabio.aguilar0021@pascualbravo.edu.co', '3049491631', '1992-07-23', 'masculino', '2026-03-04 09:42:37', true);
INSERT INTO public.usuarios VALUES (22, 3, 1, 'Fredy', 'Murillo Obando', 'fredy.murillo0022@pascualbravo.edu.co', '3151154241', '1993-04-04', 'masculino', '2026-02-19 10:07:47', true);
INSERT INTO public.usuarios VALUES (23, 3, 1, 'Santiago', 'Bedoya Vásquez', 'santiago.bedoya0023@pascualbravo.edu.co', '3290099897', '1994-02-27', 'masculino', '2026-02-19 09:14:23', false);
INSERT INTO public.usuarios VALUES (24, 3, 1, 'Milena', 'Martínez Correa', 'milena.martinez0024@pascualbravo.edu.co', '3226948946', '2005-08-04', 'femenino', '2026-01-04 18:18:30', true);
INSERT INTO public.usuarios VALUES (25, 4, 2, 'Jhonatan', 'Bedoya González', 'jhonatan.bedoya0025@pascualbravo.edu.co', '3176001106', '1987-10-21', 'otro', '2026-01-14 04:09:51', true);
INSERT INTO public.usuarios VALUES (26, 3, 9, 'Camilo', 'Cárdenas Henao', 'camilo.cardenas0026@pascualbravo.edu.co', '3240291214', '2001-07-15', 'otro', '2026-04-24 09:55:37', true);
INSERT INTO public.usuarios VALUES (27, 3, 1, 'Wendy', 'Sánchez Pineda', 'wendy.sanchez0027@pascualbravo.edu.co', '3198641164', '1987-03-08', 'femenino', '2026-02-14 17:04:10', true);
INSERT INTO public.usuarios VALUES (28, 3, 4, 'Lina', 'Martínez Ríos', 'lina.martinez0028@pascualbravo.edu.co', '3170939053', '1987-11-08', 'femenino', '2026-03-09 20:37:42', true);
INSERT INTO public.usuarios VALUES (29, 3, 2, 'Esteban', 'Flores Vásquez', 'esteban.flores0029@pascualbravo.edu.co', '3018004482', '1990-05-20', 'masculino', '2026-03-15 14:07:29', true);
INSERT INTO public.usuarios VALUES (30, 3, 8, 'Angélica', 'Arango Caballero', 'angelica.arango0030@pascualbravo.edu.co', '3215350023', '1998-12-11', 'femenino', '2026-03-06 00:05:14', true);
INSERT INTO public.usuarios VALUES (31, 3, 1, 'Valentina', 'Mendoza Alzate', 'valentina.mendoza0031@pascualbravo.edu.co', NULL, '1990-08-17', 'femenino', '2026-04-24 08:11:37', true);
INSERT INTO public.usuarios VALUES (32, 3, 4, 'Gloria', 'Ospina Henao', 'gloria.ospina0032@pascualbravo.edu.co', '3224039158', '1990-06-14', 'otro', '2026-05-07 09:42:25', true);
INSERT INTO public.usuarios VALUES (33, 3, 1, 'Mauricio', 'Díaz Posada', 'mauricio.diaz0033@pascualbravo.edu.co', NULL, '1997-09-27', 'masculino', '2026-01-01 21:55:34', true);
INSERT INTO public.usuarios VALUES (34, 3, 1, 'Wendy', 'Aguilar Forero', 'wendy.aguilar0034@pascualbravo.edu.co', '3045843681', '2002-03-10', 'femenino', '2026-04-23 22:31:07', true);
INSERT INTO public.usuarios VALUES (35, 3, 4, 'Paola', 'Ruiz Agudelo', 'paola.ruiz0035@pascualbravo.edu.co', NULL, '1998-02-08', 'femenino', '2026-01-30 14:07:41', true);
INSERT INTO public.usuarios VALUES (36, 3, 1, 'Angélica', 'Mendoza Henao', 'angelica.mendoza0036@pascualbravo.edu.co', '3142713008', '1999-09-05', 'femenino', '2026-04-09 06:58:38', true);
INSERT INTO public.usuarios VALUES (37, 3, 1, 'Milena', 'Cardona Patiño', 'milena.cardona0037@pascualbravo.edu.co', '3245859307', '1985-05-24', 'femenino', '2026-03-18 18:37:42', true);
INSERT INTO public.usuarios VALUES (38, 3, 5, 'Martha', 'Murillo Agudelo', 'martha.murillo0038@pascualbravo.edu.co', '3171115319', '1995-04-23', 'femenino', '2026-03-03 18:24:14', true);
INSERT INTO public.usuarios VALUES (39, 3, 1, 'Fabio', 'Ríos Mesa', 'fabio.rios0039@pascualbravo.edu.co', '3230415230', '2000-01-05', 'masculino', '2026-05-09 18:21:55', true);
INSERT INTO public.usuarios VALUES (40, 3, 1, 'Rodrigo', 'Rodríguez Jaramillo', 'rodrigo.rodriguez0040@pascualbravo.edu.co', '3230718012', '1987-08-26', 'masculino', '2026-03-09 10:39:44', true);
INSERT INTO public.usuarios VALUES (41, 3, 1, 'Edison', 'Ríos Posada', 'edison.rios0041@pascualbravo.edu.co', '3182613940', '1986-10-03', 'masculino', '2026-03-02 20:43:58', true);
INSERT INTO public.usuarios VALUES (42, 3, 1, 'David', 'Sánchez Forero', 'david.sanchez0042@pascualbravo.edu.co', '3113885234', '1986-06-26', 'masculino', '2026-01-15 09:22:23', true);
INSERT INTO public.usuarios VALUES (43, 3, 1, 'Nicolás', 'Vargas Naranjo', 'nicolas.vargas0043@pascualbravo.edu.co', NULL, '1997-10-22', 'masculino', '2026-03-03 15:58:37', true);
INSERT INTO public.usuarios VALUES (44, 3, 8, 'Julián', 'Rodríguez Cifuentes', 'julian.rodriguez0044@pascualbravo.edu.co', '3283363160', '1990-02-15', 'masculino', '2026-03-30 18:19:40', true);
INSERT INTO public.usuarios VALUES (45, 3, 8, 'Iván', 'Reyes Mesa', 'ivan.reyes0045@pascualbravo.edu.co', '3041837210', '1997-10-12', 'masculino', '2026-03-17 22:18:01', true);
INSERT INTO public.usuarios VALUES (46, 3, 3, 'Edinson', 'López Campos', 'edinson.lopez0046@pascualbravo.edu.co', '3140885967', '2004-06-08', 'masculino', '2026-02-18 19:16:43', true);
INSERT INTO public.usuarios VALUES (47, 3, 1, 'Juliana', 'Sánchez Castaño', 'juliana.sanchez0047@pascualbravo.edu.co', '3114478111', '2003-06-24', 'femenino', '2026-02-03 02:58:18', true);
INSERT INTO public.usuarios VALUES (48, 3, 4, 'Edison', 'Parra Arenas', 'edison.parra0048@pascualbravo.edu.co', '3132084778', '1993-08-26', 'masculino', '2026-03-17 23:55:21', true);
INSERT INTO public.usuarios VALUES (49, 3, 2, 'Esteban', 'Medina Agudelo', 'esteban.medina0049@pascualbravo.edu.co', '3111868130', '1993-09-04', 'masculino', '2026-04-27 11:43:47', true);
INSERT INTO public.usuarios VALUES (50, 3, 6, 'Patricia', 'Sánchez Ríos', 'patricia.sanchez0050@pascualbravo.edu.co', '3285350823', '1995-10-08', 'femenino', '2026-01-17 20:52:29', true);
INSERT INTO public.usuarios VALUES (51, 3, 2, 'Alejandro', 'Martínez Castaño', 'alejandro.martinez0051@pascualbravo.edu.co', '3125585427', '1988-04-18', 'masculino', '2026-02-04 12:29:23', true);
INSERT INTO public.usuarios VALUES (52, 3, 1, 'Viviana', 'Salazar Jaramillo', 'viviana.salazar0052@pascualbravo.edu.co', '3223290458', '2000-10-14', 'femenino', '2026-03-13 01:44:23', true);
INSERT INTO public.usuarios VALUES (53, 3, 1, 'Cristian', 'Sánchez Nieto', 'cristian.sanchez0053@pascualbravo.edu.co', '3258140388', '1986-07-09', 'masculino', '2026-02-18 03:54:52', true);
INSERT INTO public.usuarios VALUES (54, 3, 5, 'Cindy', 'Gómez Correa', 'cindy.gomez0054@pascualbravo.edu.co', '3026901217', '2003-04-03', 'femenino', '2026-02-23 18:13:52', true);
INSERT INTO public.usuarios VALUES (55, 3, 1, 'Steven', 'Rodríguez Vásquez', 'steven.rodriguez0055@pascualbravo.edu.co', '3027447248', '2002-05-26', 'masculino', '2026-02-14 03:42:55', false);
INSERT INTO public.usuarios VALUES (56, 3, 1, 'Alejandra', 'Salazar Posada', 'alejandra.salazar0056@pascualbravo.edu.co', NULL, '1993-01-05', 'femenino', '2026-04-18 16:07:47', true);
INSERT INTO public.usuarios VALUES (57, 3, 1, 'Duván', 'Sánchez Forero', 'duvan.sanchez0057@pascualbravo.edu.co', '3215820356', '2001-05-15', 'masculino', '2026-01-08 01:30:54', true);
INSERT INTO public.usuarios VALUES (58, 3, 9, 'Luz', 'García Escobar', 'luz.garcia0058@pascualbravo.edu.co', '3018815720', '1989-05-20', 'femenino', '2026-05-21 22:20:24', true);
INSERT INTO public.usuarios VALUES (59, 3, 1, 'Steven', 'Valencia Franco', 'steven.valencia0059@pascualbravo.edu.co', '3097874085', '2005-09-24', 'masculino', '2026-02-25 13:28:56', true);
INSERT INTO public.usuarios VALUES (60, 3, 1, 'Edwin', 'Sánchez Posada', 'edwin.sanchez0060@pascualbravo.edu.co', '3244210729', '1996-03-22', 'masculino', '2026-05-02 02:05:53', true);
INSERT INTO public.usuarios VALUES (61, 3, 2, 'Patricia', 'Torres Agudelo', 'patricia.torres0061@pascualbravo.edu.co', NULL, '2002-09-11', 'femenino', '2026-02-01 13:22:55', true);
INSERT INTO public.usuarios VALUES (62, 3, 1, 'Andrea', 'Álvarez Campos', 'andrea.alvarez0062@pascualbravo.edu.co', '3087566910', '2001-04-05', 'femenino', '2026-05-04 07:54:06', true);
INSERT INTO public.usuarios VALUES (63, 3, 4, 'Fernando', 'Mejía Ríos', 'fernando.mejia0063@pascualbravo.edu.co', '3293446356', '2004-11-21', 'masculino', '2026-01-07 19:59:42', true);
INSERT INTO public.usuarios VALUES (64, 3, 2, 'Iván', 'Murillo Obando', 'ivan.murillo0064@pascualbravo.edu.co', NULL, '1989-10-22', 'masculino', '2026-04-13 02:09:47', true);
INSERT INTO public.usuarios VALUES (65, 4, 3, 'Isabella', 'Ríos Henao', 'isabella.rios0065@pascualbravo.edu.co', '3059667685', '1994-12-11', 'femenino', '2026-01-22 01:09:10', true);
INSERT INTO public.usuarios VALUES (66, 3, 2, 'Hernando', 'Valencia Caballero', 'hernando.valencia0066@pascualbravo.edu.co', '3146663833', '1991-09-04', 'masculino', '2026-03-30 13:07:18', true);
INSERT INTO public.usuarios VALUES (67, 3, 1, 'Yolanda', 'Martínez Ríos', 'yolanda.martinez0067@pascualbravo.edu.co', '3217352710', '1985-04-10', 'femenino', '2026-02-24 04:48:16', true);
INSERT INTO public.usuarios VALUES (68, 3, 3, 'Adriana', 'Castro Holguín', 'adriana.castro0068@pascualbravo.edu.co', '3240884937', '2001-09-27', 'femenino', '2026-04-01 02:25:55', true);
INSERT INTO public.usuarios VALUES (69, 3, 4, 'Jorge', 'Cruz Alzate', 'jorge.cruz0069@pascualbravo.edu.co', '3195918360', '1998-05-04', 'masculino', '2026-04-14 00:20:10', true);
INSERT INTO public.usuarios VALUES (70, 3, 3, 'Patricia', 'Pérez Gallego', 'patricia.perez0070@pascualbravo.edu.co', '3068475513', '2003-07-17', 'femenino', '2026-01-21 12:55:19', true);
INSERT INTO public.usuarios VALUES (71, 3, 1, 'Natalia', 'Molina González', 'natalia.molina0071@pascualbravo.edu.co', '3056892354', '1996-12-27', 'femenino', '2026-02-07 07:06:09', true);
INSERT INTO public.usuarios VALUES (72, 3, 1, 'Jorge', 'Castro Caballero', 'jorge.castro0072@pascualbravo.edu.co', '3287774890', '1999-11-19', 'masculino', '2026-03-24 20:20:09', true);
INSERT INTO public.usuarios VALUES (73, 3, 1, 'Milena', 'Salazar Correa', 'milena.salazar0073@pascualbravo.edu.co', '3051662236', '1999-08-02', 'femenino', '2026-01-15 11:53:18', true);
INSERT INTO public.usuarios VALUES (74, 3, 1, 'Wendy', 'Giraldo Botero', 'wendy.giraldo0074@pascualbravo.edu.co', '3284399083', '1986-08-26', 'femenino', '2026-02-18 10:38:30', true);
INSERT INTO public.usuarios VALUES (75, 3, 1, 'Óscar', 'Pérez Botero', 'oscar.perez0075@pascualbravo.edu.co', '3043251599', '1999-08-17', 'masculino', '2026-05-14 19:10:23', true);
INSERT INTO public.usuarios VALUES (76, 3, 5, 'Óscar', 'Giraldo Correa', 'oscar.giraldo0076@pascualbravo.edu.co', '3254915875', '1987-06-04', 'masculino', '2026-04-09 09:16:46', true);
INSERT INTO public.usuarios VALUES (77, 3, 7, 'Diana', 'Murillo Escobar', 'diana.murillo0077@pascualbravo.edu.co', '3056952151', '1994-11-23', 'femenino', '2026-04-11 04:38:45', true);
INSERT INTO public.usuarios VALUES (78, 3, 7, 'Óscar', 'Torres Arenas', 'oscar.torres0078@pascualbravo.edu.co', NULL, '1998-09-12', 'masculino', '2026-01-05 11:19:11', true);
INSERT INTO public.usuarios VALUES (79, 3, 5, 'Sara', 'Jiménez Holguín', 'sara.jimenez0079@pascualbravo.edu.co', '3123574883', '2001-09-27', 'femenino', '2026-05-15 01:42:21', true);
INSERT INTO public.usuarios VALUES (80, 3, 8, 'Diana', 'Vargas Naranjo', 'diana.vargas0080@pascualbravo.edu.co', '3232218290', '1999-01-14', 'femenino', '2026-04-04 21:46:15', true);
INSERT INTO public.usuarios VALUES (81, 4, 3, 'Luz', 'Jiménez Arias', 'luz.jimenez0081@pascualbravo.edu.co', '3136040410', '1996-11-19', 'femenino', '2026-04-23 14:49:18', true);
INSERT INTO public.usuarios VALUES (82, 4, 1, 'Felipe', 'Reyes Campos', 'felipe.reyes0082@pascualbravo.edu.co', NULL, '1993-01-21', 'masculino', '2026-05-04 11:35:59', true);
INSERT INTO public.usuarios VALUES (83, 3, 1, 'Lina', 'Pérez Lozano', 'lina.perez0083@pascualbravo.edu.co', '3229776801', '1998-02-08', 'femenino', '2026-04-26 11:59:01', true);
INSERT INTO public.usuarios VALUES (84, 3, 6, 'Jairo', 'Pérez Nieto', 'jairo.perez0084@pascualbravo.edu.co', '3123298711', '2005-06-26', 'masculino', '2026-02-07 04:02:18', true);
INSERT INTO public.usuarios VALUES (85, 3, 2, 'Lorena', 'Suárez Caro', 'lorena.suarez0085@pascualbravo.edu.co', NULL, '1987-01-09', 'femenino', '2026-02-25 04:35:46', true);
INSERT INTO public.usuarios VALUES (86, 3, 6, 'Alejandra', 'Ruiz González', 'alejandra.ruiz0086@pascualbravo.edu.co', NULL, '1998-11-26', 'femenino', '2026-04-28 02:07:53', true);
INSERT INTO public.usuarios VALUES (87, 3, 2, 'Jhonatan', 'Mejía Sierra', 'jhonatan.mejia0087@pascualbravo.edu.co', '3167611469', '1985-10-12', 'masculino', '2026-03-03 18:26:11', true);
INSERT INTO public.usuarios VALUES (88, 3, 9, 'Alejandro', 'Quintero Arias', 'alejandro.quintero0088@pascualbravo.edu.co', '3284377016', '1985-07-28', 'otro', '2026-05-01 01:40:24', true);
INSERT INTO public.usuarios VALUES (89, 3, 1, 'Jorge', 'Ospina Sierra', 'jorge.ospina0089@pascualbravo.edu.co', '3223913528', '2003-12-25', 'masculino', '2026-03-27 04:02:22', true);
INSERT INTO public.usuarios VALUES (90, 3, 1, 'Rodrigo', 'Bedoya Naranjo', 'rodrigo.bedoya0090@pascualbravo.edu.co', '3071428713', '1986-05-07', 'masculino', '2026-01-12 06:56:02', true);
INSERT INTO public.usuarios VALUES (91, 3, 1, 'Edison', 'Bedoya Urrego', 'edison.bedoya0091@pascualbravo.edu.co', NULL, '2005-04-10', 'masculino', '2026-04-02 01:55:41', true);
INSERT INTO public.usuarios VALUES (92, 3, 3, 'Harold', 'Suárez Mesa', 'harold.suarez0092@pascualbravo.edu.co', '3076599269', '2000-06-26', 'masculino', '2026-05-13 08:51:05', true);
INSERT INTO public.usuarios VALUES (93, 3, 1, 'Laura', 'Arango Yepes', 'laura.arango0093@pascualbravo.edu.co', '3054012664', '1994-05-15', 'femenino', '2026-04-20 05:44:28', true);
INSERT INTO public.usuarios VALUES (94, 3, 7, 'Martha', 'Zapata Gallego', 'martha.zapata0094@pascualbravo.edu.co', '3020071854', '2005-07-12', 'femenino', '2026-05-12 23:43:10', true);
INSERT INTO public.usuarios VALUES (95, 3, 1, 'Luz', 'Martínez Holguín', 'luz.martinez0095@pascualbravo.edu.co', NULL, '2005-06-12', 'femenino', '2026-04-09 18:02:38', true);
INSERT INTO public.usuarios VALUES (96, 3, 3, 'Hernando', 'García Alzate', 'hernando.garcia0096@pascualbravo.edu.co', NULL, '1996-07-11', 'masculino', '2026-03-13 07:07:01', true);
INSERT INTO public.usuarios VALUES (97, 3, 5, 'Fredy', 'Ramírez Urrego', 'fredy.ramirez0097@pascualbravo.edu.co', '3269897763', '1991-10-10', 'masculino', '2026-05-06 06:07:08', true);
INSERT INTO public.usuarios VALUES (98, 3, 7, 'Luz', 'Pérez Posada', 'luz.perez0098@pascualbravo.edu.co', '3218715975', '2002-09-10', 'femenino', '2026-03-18 05:45:45', true);
INSERT INTO public.usuarios VALUES (99, 3, 1, 'Angélica', 'Jiménez González', 'angelica.jimenez0099@pascualbravo.edu.co', '3041774192', '2000-01-12', 'femenino', '2026-04-05 14:51:35', true);
INSERT INTO public.usuarios VALUES (100, 3, 1, 'Harold', 'Bedoya Arenas', 'harold.bedoya0100@pascualbravo.edu.co', '3187161840', '1987-03-11', 'masculino', '2026-01-19 14:29:43', true);
INSERT INTO public.usuarios VALUES (101, 3, 1, 'Marcela', 'Salazar Naranjo', 'marcela.salazar0101@pascualbravo.edu.co', '3068065043', '2001-01-27', 'femenino', '2026-02-01 16:09:19', true);
INSERT INTO public.usuarios VALUES (102, 3, 1, 'Martha', 'Quintero Yepes', 'martha.quintero0102@pascualbravo.edu.co', '3136347197', '2005-09-09', 'femenino', '2026-02-02 20:19:39', true);
INSERT INTO public.usuarios VALUES (103, 3, 3, 'Duván', 'Flores Lozano', 'duvan.flores0103@pascualbravo.edu.co', '3291220369', '1995-10-02', 'masculino', '2026-01-08 02:02:41', true);
INSERT INTO public.usuarios VALUES (104, 3, 4, 'Edinson', 'Cardona Caro', 'edinson.cardona0104@pascualbravo.edu.co', '3194176528', '2002-05-21', 'masculino', '2026-03-19 15:15:51', true);
INSERT INTO public.usuarios VALUES (105, 3, 9, 'Luis', 'Vargas Forero', 'luis.vargas0105@pascualbravo.edu.co', '3137383505', '1995-10-05', 'masculino', '2026-03-22 22:20:46', true);
INSERT INTO public.usuarios VALUES (106, 3, 1, 'Cristian', 'Molina Agudelo', 'cristian.molina0106@pascualbravo.edu.co', NULL, '1992-08-04', 'masculino', '2026-03-10 14:15:09', true);
INSERT INTO public.usuarios VALUES (107, 3, 1, 'Kevin', 'Cardona Sierra', 'kevin.cardona0107@pascualbravo.edu.co', '3053947691', '2003-12-11', 'masculino', '2026-02-18 05:31:32', true);
INSERT INTO public.usuarios VALUES (108, 3, 5, 'Camila', 'Medina Botero', 'camila.medina0108@pascualbravo.edu.co', '3038876195', '2003-06-02', 'femenino', '2026-01-13 09:31:38', true);
INSERT INTO public.usuarios VALUES (109, 3, 1, 'Edison', 'Rodríguez Franco', 'edison.rodriguez0109@pascualbravo.edu.co', '3159093843', '1997-06-02', 'masculino', '2026-04-13 01:36:35', true);
INSERT INTO public.usuarios VALUES (110, 3, 2, 'Jhonatan', 'Suárez Agudelo', 'jhonatan.suarez0110@pascualbravo.edu.co', '3292012822', '1988-03-04', 'masculino', '2026-04-11 11:50:21', true);
INSERT INTO public.usuarios VALUES (111, 3, 2, 'Steven', 'Molina Largo', 'steven.molina0111@pascualbravo.edu.co', '3015222944', '1989-12-11', 'masculino', '2026-05-02 16:29:09', true);
INSERT INTO public.usuarios VALUES (112, 3, 2, 'Kevin', 'Cruz Lozano', 'kevin.cruz0112@pascualbravo.edu.co', '3250162553', '2003-06-17', 'masculino', '2026-05-11 17:31:45', true);
INSERT INTO public.usuarios VALUES (113, 3, 2, 'Óscar', 'Ramírez Henao', 'oscar.ramirez0113@pascualbravo.edu.co', '3294457912', '1985-10-16', 'masculino', '2026-03-09 20:50:49', true);
INSERT INTO public.usuarios VALUES (114, 3, 1, 'Fabio', 'Vargas Arenas', 'fabio.vargas0114@pascualbravo.edu.co', '3261028283', '1989-11-08', 'masculino', '2026-01-09 18:44:07', true);
INSERT INTO public.usuarios VALUES (115, 3, 9, 'Edwin', 'Morales Henao', 'edwin.morales0115@pascualbravo.edu.co', '3273297813', '1986-12-05', 'masculino', '2026-05-13 06:35:20', true);
INSERT INTO public.usuarios VALUES (116, 3, 1, 'Nicolás', 'Rincón Arias', 'nicolas.rincon0116@pascualbravo.edu.co', '3196343485', '1993-10-16', 'masculino', '2026-02-19 07:17:35', true);
INSERT INTO public.usuarios VALUES (117, 3, 4, 'Edinson', 'Morales Caballero', 'edinson.morales0117@pascualbravo.edu.co', '3185227370', '1993-05-04', 'otro', '2026-05-20 12:57:25', true);
INSERT INTO public.usuarios VALUES (118, 3, 1, 'Lina', 'Martínez Yepes', 'lina.martinez0118@pascualbravo.edu.co', '3056488123', '1999-11-09', 'femenino', '2026-05-03 06:12:52', true);
INSERT INTO public.usuarios VALUES (119, 3, 1, 'Juliana', 'Sánchez Caro', 'juliana.sanchez0119@pascualbravo.edu.co', '3042542167', '1986-11-17', 'femenino', '2026-02-27 20:14:03', true);
INSERT INTO public.usuarios VALUES (120, 3, 2, 'Alejandro', 'Rodríguez Agudelo', 'alejandro.rodriguez0120@pascualbravo.edu.co', '3064614193', '2005-08-16', 'masculino', '2026-02-21 09:20:18', true);
INSERT INTO public.usuarios VALUES (121, 4, 3, 'Edinson', 'Jiménez Arias', 'edinson.jimenez0121@pascualbravo.edu.co', '3033496796', '1998-03-02', 'masculino', '2026-04-12 15:11:59', true);
INSERT INTO public.usuarios VALUES (122, 3, 7, 'Juan', 'Rodríguez Zuluaga', 'juan.rodriguez0122@pascualbravo.edu.co', '3054968591', '1994-08-21', 'masculino', '2026-05-20 16:31:56', true);
INSERT INTO public.usuarios VALUES (123, 3, 1, 'Diego', 'Ramírez Patiño', 'diego.ramirez0123@pascualbravo.edu.co', '3197011385', '1993-12-06', 'masculino', '2026-01-04 23:21:50', true);
INSERT INTO public.usuarios VALUES (124, 3, 1, 'Kevin', 'Medina Gallego', 'kevin.medina0124@pascualbravo.edu.co', '3063798927', '1988-03-05', 'masculino', '2026-05-03 10:59:15', true);
INSERT INTO public.usuarios VALUES (125, 3, 1, 'Fernando', 'Murillo Zuluaga', 'fernando.murillo0125@pascualbravo.edu.co', '3211534878', '1993-11-12', 'masculino', '2026-03-02 01:42:07', true);
INSERT INTO public.usuarios VALUES (126, 3, 1, 'Yolanda', 'Ramírez Yepes', 'yolanda.ramirez0126@pascualbravo.edu.co', '3039410942', '1989-08-05', 'femenino', '2026-04-27 23:38:23', true);
INSERT INTO public.usuarios VALUES (127, 3, 1, 'Edison', 'Morales Sierra', 'edison.morales0127@pascualbravo.edu.co', '3220988446', '2001-08-17', 'masculino', '2026-04-03 02:58:36', true);
INSERT INTO public.usuarios VALUES (128, 3, 2, 'Sara', 'Mejía Arias', 'sara.mejia0128@pascualbravo.edu.co', NULL, '1995-09-15', 'femenino', '2026-01-30 21:13:45', true);
INSERT INTO public.usuarios VALUES (129, 3, 1, 'Andrea', 'Rincón Holguín', 'andrea.rincon0129@pascualbravo.edu.co', '3185686878', '1986-09-15', 'femenino', '2026-03-20 23:01:25', false);
INSERT INTO public.usuarios VALUES (130, 3, 3, 'Jorge', 'Martínez Gallego', 'jorge.martinez0130@pascualbravo.edu.co', '3082633735', '1986-02-16', 'masculino', '2026-01-09 09:26:11', true);
INSERT INTO public.usuarios VALUES (131, 3, 1, 'Isabella', 'Parra Mesa', 'isabella.parra0131@pascualbravo.edu.co', '3160418290', '1987-11-22', 'otro', '2026-05-19 04:41:55', true);
INSERT INTO public.usuarios VALUES (132, 2, 4, 'Tatiana', 'Torres Ríos', 'tatiana.torres0132@pascualbravo.edu.co', '3050045602', '1999-11-24', 'femenino', '2026-05-20 13:34:24', true);
INSERT INTO public.usuarios VALUES (133, 3, 1, 'Fernando', 'Reyes González', 'fernando.reyes0133@pascualbravo.edu.co', NULL, '1998-10-25', 'masculino', '2026-01-05 07:13:04', true);
INSERT INTO public.usuarios VALUES (134, 3, 6, 'Andrea', 'Hernández Castaño', 'andrea.hernandez0134@pascualbravo.edu.co', '3082445335', '1991-01-05', 'femenino', '2026-05-09 09:14:52', true);
INSERT INTO public.usuarios VALUES (135, 3, 5, 'Gloria', 'Hernández Zuluaga', 'gloria.hernandez0135@pascualbravo.edu.co', '3279961132', '1992-07-10', 'femenino', '2026-03-12 01:35:37', true);
INSERT INTO public.usuarios VALUES (136, 3, 1, 'Adriana', 'Cárdenas Caballero', 'adriana.cardenas0136@pascualbravo.edu.co', NULL, '1996-11-22', 'femenino', '2026-04-08 16:20:44', true);
INSERT INTO public.usuarios VALUES (137, 3, 1, 'Edison', 'Bedoya Sierra', 'edison.bedoya0137@pascualbravo.edu.co', '3129374563', '1999-01-18', 'masculino', '2026-04-16 13:35:33', true);
INSERT INTO public.usuarios VALUES (138, 3, 1, 'Miguel', 'Suárez Nieto', 'miguel.suarez0138@pascualbravo.edu.co', NULL, '1991-01-09', 'masculino', '2026-04-07 21:38:38', true);
INSERT INTO public.usuarios VALUES (139, 3, 6, 'Jennifer', 'Cárdenas Pineda', 'jennifer.cardenas0139@pascualbravo.edu.co', '3150693207', '1985-04-07', 'femenino', '2026-01-31 23:48:30', true);
INSERT INTO public.usuarios VALUES (140, 3, 1, 'Claudia', 'Hernández Agudelo', 'claudia.hernandez0140@pascualbravo.edu.co', '3161091554', '1999-09-21', 'femenino', '2026-04-02 09:16:23', true);
INSERT INTO public.usuarios VALUES (141, 3, 7, 'Fabio', 'Cruz Pineda', 'fabio.cruz0141@pascualbravo.edu.co', '3116135823', '2003-04-24', 'masculino', '2026-02-07 00:16:35', true);
INSERT INTO public.usuarios VALUES (142, 3, 1, 'Sebastián', 'Reyes Patiño', 'sebastian.reyes0142@pascualbravo.edu.co', '3242981324', '2000-09-21', 'masculino', '2026-03-28 08:48:52', true);
INSERT INTO public.usuarios VALUES (143, 3, 4, 'Carolina', 'Vargas Obando', 'carolina.vargas0143@pascualbravo.edu.co', '3283356206', '2000-03-18', 'femenino', '2026-01-16 16:02:53', true);
INSERT INTO public.usuarios VALUES (144, 3, 2, 'María', 'Cardona Holguín', 'maria.cardona0144@pascualbravo.edu.co', '3019122502', '1989-01-07', 'femenino', '2026-05-10 14:23:03', true);
INSERT INTO public.usuarios VALUES (145, 3, 1, 'Lorena', 'Aguilar Bernal', 'lorena.aguilar0145@pascualbravo.edu.co', NULL, '2002-07-01', 'femenino', '2026-01-05 16:46:17', true);
INSERT INTO public.usuarios VALUES (146, 3, 1, 'Adriana', 'Castro Franco', 'adriana.castro0146@pascualbravo.edu.co', '3229984682', '1992-04-20', 'femenino', '2026-05-15 08:52:22', true);
INSERT INTO public.usuarios VALUES (147, 3, 3, 'Harold', 'Rincón Alzate', 'harold.rincon0147@pascualbravo.edu.co', '3240314047', '1994-11-27', 'masculino', '2026-01-21 20:54:41', true);
INSERT INTO public.usuarios VALUES (148, 3, 2, 'Fredy', 'Bedoya Correa', 'fredy.bedoya0148@pascualbravo.edu.co', '3233002714', '1987-08-28', 'masculino', '2026-04-22 20:50:21', true);
INSERT INTO public.usuarios VALUES (149, 3, 6, 'Wilmar', 'Martínez Ríos', 'wilmar.martinez0149@pascualbravo.edu.co', '3286072480', '2000-05-02', 'masculino', '2026-01-20 21:59:17', true);
INSERT INTO public.usuarios VALUES (150, 3, 1, 'Mauricio', 'Gómez Pineda', 'mauricio.gomez0150@pascualbravo.edu.co', '3263458386', '1987-05-06', 'masculino', '2026-03-03 18:53:54', true);
INSERT INTO public.usuarios VALUES (151, 3, 2, 'Alejandro', 'Pérez Botero', 'alejandro.perez0151@pascualbravo.edu.co', '3117207013', '1988-07-08', 'masculino', '2026-01-20 10:38:49', true);
INSERT INTO public.usuarios VALUES (152, 3, 2, 'Valentina', 'Gómez Vásquez', 'valentina.gomez0152@pascualbravo.edu.co', '3175847681', '1992-06-18', 'otro', '2026-04-07 13:11:43', true);
INSERT INTO public.usuarios VALUES (153, 3, 1, 'Lina', 'Hernández Duque', 'lina.hernandez0153@pascualbravo.edu.co', NULL, '1989-07-23', 'femenino', '2026-02-09 23:24:20', true);
INSERT INTO public.usuarios VALUES (154, 3, 1, 'Luz', 'Parra Vásquez', 'luz.parra0154@pascualbravo.edu.co', NULL, '1987-03-14', 'femenino', '2026-04-25 17:35:32', false);
INSERT INTO public.usuarios VALUES (155, 3, 6, 'Miguel', 'Giraldo Campos', 'miguel.giraldo0155@pascualbravo.edu.co', '3111656329', '1994-07-13', 'masculino', '2026-01-22 23:57:35', true);
INSERT INTO public.usuarios VALUES (156, 3, 1, 'Paola', 'Ríos Lozano', 'paola.rios0156@pascualbravo.edu.co', NULL, '1994-05-16', 'femenino', '2026-02-07 02:10:27', true);
INSERT INTO public.usuarios VALUES (157, 3, 7, 'Patricia', 'Díaz Sierra', 'patricia.diaz0157@pascualbravo.edu.co', '3189699345', '2004-04-15', 'femenino', '2026-01-28 04:19:00', true);
INSERT INTO public.usuarios VALUES (158, 3, 8, 'Ángela', 'Suárez Patiño', 'angela.suarez0158@pascualbravo.edu.co', '3289778067', '1989-05-11', 'femenino', '2026-02-21 15:20:11', true);
INSERT INTO public.usuarios VALUES (159, 3, 2, 'Jhon', 'Mejía Sierra', 'jhon.mejia0159@pascualbravo.edu.co', '3162738860', '1996-02-19', 'masculino', '2026-02-21 18:34:11', true);
INSERT INTO public.usuarios VALUES (160, 3, 1, 'Carolina', 'Morales Forero', 'carolina.morales0160@pascualbravo.edu.co', '3219282319', '1998-11-16', 'femenino', '2026-02-05 20:19:15', true);
INSERT INTO public.usuarios VALUES (161, 3, 8, 'Jairo', 'García Forero', 'jairo.garcia0161@pascualbravo.edu.co', '3188147469', '1997-09-17', 'masculino', '2026-04-18 17:02:50', true);
INSERT INTO public.usuarios VALUES (162, 3, 2, 'Cindy', 'Pérez Franco', 'cindy.perez0162@pascualbravo.edu.co', '3299213703', '1996-03-21', 'femenino', '2026-01-12 18:41:43', true);
INSERT INTO public.usuarios VALUES (163, 3, 2, 'Nelson', 'Sánchez Acosta', 'nelson.sanchez0163@pascualbravo.edu.co', NULL, '1992-09-24', 'masculino', '2026-05-13 17:37:44', true);
INSERT INTO public.usuarios VALUES (164, 3, 1, 'Duván', 'Molina Jaramillo', 'duvan.molina0164@pascualbravo.edu.co', '3074796438', '1988-05-14', 'masculino', '2026-01-22 03:53:46', true);
INSERT INTO public.usuarios VALUES (165, 3, 1, 'Santiago', 'Quintero Cano', 'santiago.quintero0165@pascualbravo.edu.co', '3068809636', '1999-06-03', 'masculino', '2026-03-18 01:51:45', true);
INSERT INTO public.usuarios VALUES (166, 3, 1, 'Paola', 'Hernández Arenas', 'paola.hernandez0166@pascualbravo.edu.co', '3054424679', '2002-07-15', 'femenino', '2026-03-01 12:40:11', true);
INSERT INTO public.usuarios VALUES (167, 3, 5, 'Kevin', 'Reyes Forero', 'kevin.reyes0167@pascualbravo.edu.co', '3110597274', '1991-04-09', 'masculino', '2026-01-17 18:06:51', true);
INSERT INTO public.usuarios VALUES (168, 3, 1, 'Rodrigo', 'Ramírez Urrego', 'rodrigo.ramirez0168@pascualbravo.edu.co', '3180828710', '2005-06-20', 'masculino', '2026-04-10 19:25:37', true);
INSERT INTO public.usuarios VALUES (169, 3, 2, 'Nicolás', 'Ruiz Caro', 'nicolas.ruiz0169@pascualbravo.edu.co', '3227978165', '1995-02-08', 'masculino', '2026-03-20 03:11:23', true);
INSERT INTO public.usuarios VALUES (170, 3, 1, 'Alejandro', 'Mejía Mesa', 'alejandro.mejia0170@pascualbravo.edu.co', '3195295586', '2002-12-21', 'masculino', '2026-02-14 17:10:31', true);
INSERT INTO public.usuarios VALUES (171, 3, 2, 'Wendy', 'López Obando', 'wendy.lopez0171@pascualbravo.edu.co', '3128325379', '1991-07-18', 'femenino', '2026-05-10 20:31:26', true);
INSERT INTO public.usuarios VALUES (172, 3, 1, 'Mariana', 'Vargas Escobar', 'mariana.vargas0172@pascualbravo.edu.co', '3049203644', '1986-05-08', 'femenino', '2026-05-18 09:10:49', true);
INSERT INTO public.usuarios VALUES (173, 3, 1, 'Marcela', 'Molina González', 'marcela.molina0173@pascualbravo.edu.co', '3182894477', '1996-09-27', 'femenino', '2026-01-11 23:28:34', true);
INSERT INTO public.usuarios VALUES (174, 3, 2, 'Alejandra', 'Ruiz Castaño', 'alejandra.ruiz0174@pascualbravo.edu.co', '3121674661', '1999-02-25', 'femenino', '2026-03-02 06:51:47', true);
INSERT INTO public.usuarios VALUES (175, 3, 1, 'Adriana', 'Vargas Caro', 'adriana.vargas0175@pascualbravo.edu.co', NULL, '1991-04-26', 'femenino', '2026-01-16 18:22:34', true);
INSERT INTO public.usuarios VALUES (176, 3, 5, 'Ricardo', 'Álvarez Alzate', 'ricardo.alvarez0176@pascualbravo.edu.co', '3222780905', '1989-07-02', 'masculino', '2026-03-12 20:08:44', true);
INSERT INTO public.usuarios VALUES (177, 3, 2, 'Alejandra', 'Medina Caballero', 'alejandra.medina0177@pascualbravo.edu.co', NULL, '2005-05-21', 'femenino', '2026-04-17 12:28:04', true);
INSERT INTO public.usuarios VALUES (178, 3, 2, 'Jhonatan', 'Mendoza Nieto', 'jhonatan.mendoza0178@pascualbravo.edu.co', '3153928023', '2003-01-28', 'masculino', '2026-01-24 23:29:40', true);
INSERT INTO public.usuarios VALUES (179, 3, 1, 'Edison', 'Medina Pineda', 'edison.medina0179@pascualbravo.edu.co', '3076399516', '1993-06-27', 'masculino', '2026-03-14 10:35:36', true);
INSERT INTO public.usuarios VALUES (180, 3, 9, 'Andrea', 'Martínez Franco', 'andrea.martinez0180@pascualbravo.edu.co', '3112185246', '1988-03-15', 'femenino', '2026-04-27 00:27:12', true);
INSERT INTO public.usuarios VALUES (181, 3, 1, 'Yolanda', 'Vargas Vásquez', 'yolanda.vargas0181@pascualbravo.edu.co', NULL, '1996-05-03', 'femenino', '2026-04-06 21:57:41', true);
INSERT INTO public.usuarios VALUES (182, 3, 1, 'Esteban', 'Valencia Escobar', 'esteban.valencia0182@pascualbravo.edu.co', '3038644905', '2000-02-05', 'masculino', '2026-02-27 16:43:28', true);
INSERT INTO public.usuarios VALUES (183, 3, 5, 'Adriana', 'Torres Cano', 'adriana.torres0183@pascualbravo.edu.co', NULL, '1997-02-24', 'femenino', '2026-01-27 03:20:23', true);
INSERT INTO public.usuarios VALUES (184, 3, 3, 'Juliana', 'Flores Duque', 'juliana.flores0184@pascualbravo.edu.co', '3091915661', '2005-03-15', 'femenino', '2026-03-31 23:13:40', true);
INSERT INTO public.usuarios VALUES (185, 3, 1, 'Luz', 'Morales Escobar', 'luz.morales0185@pascualbravo.edu.co', '3026529882', '2003-12-13', 'femenino', '2026-03-31 13:20:50', true);
INSERT INTO public.usuarios VALUES (186, 3, 1, 'Fredy', 'Giraldo Campos', 'fredy.giraldo0186@pascualbravo.edu.co', '3113600310', '1994-04-17', 'masculino', '2026-05-11 06:47:25', true);
INSERT INTO public.usuarios VALUES (187, 3, 9, 'Alejandra', 'Aguilar Mesa', 'alejandra.aguilar0187@pascualbravo.edu.co', NULL, '2000-11-20', 'femenino', '2026-01-19 16:56:00', true);
INSERT INTO public.usuarios VALUES (188, 3, 1, 'Edinson', 'Cardona Nieto', 'edinson.cardona0188@pascualbravo.edu.co', '3073218512', '1987-01-19', 'masculino', '2026-01-18 00:16:13', true);
INSERT INTO public.usuarios VALUES (189, 3, 1, 'Angélica', 'Álvarez Botero', 'angelica.alvarez0189@pascualbravo.edu.co', '3163992760', '1987-11-18', 'femenino', '2026-05-18 19:09:17', true);
INSERT INTO public.usuarios VALUES (190, 3, 1, 'Diana', 'Arango Posada', 'diana.arango0190@pascualbravo.edu.co', '3297219985', '2005-02-10', 'femenino', '2026-04-22 23:54:15', true);
INSERT INTO public.usuarios VALUES (191, 3, 1, 'Rodrigo', 'Zapata Campos', 'rodrigo.zapata0191@pascualbravo.edu.co', NULL, '1990-02-01', 'masculino', '2026-02-05 22:00:10', true);
INSERT INTO public.usuarios VALUES (192, 3, 1, 'Vanessa', 'Vargas Nieto', 'vanessa.vargas0192@pascualbravo.edu.co', NULL, '1993-12-04', 'femenino', '2026-01-08 10:51:27', true);
INSERT INTO public.usuarios VALUES (193, 3, 1, 'Liliana', 'García Caballero', 'liliana.garcia0193@pascualbravo.edu.co', '3117440911', '2000-10-06', 'femenino', '2026-04-05 05:16:49', true);
INSERT INTO public.usuarios VALUES (194, 3, 1, 'Sofia', 'Molina Acosta', 'sofia.molina0194@pascualbravo.edu.co', NULL, '1985-04-02', 'femenino', '2026-05-01 11:24:58', true);
INSERT INTO public.usuarios VALUES (195, 3, 6, 'Marcela', 'Cardona Ríos', 'marcela.cardona0195@pascualbravo.edu.co', '3152940967', '1993-02-19', 'femenino', '2026-04-06 03:32:43', true);
INSERT INTO public.usuarios VALUES (196, 3, 1, 'Luisa', 'Medina Duque', 'luisa.medina0196@pascualbravo.edu.co', '3151701149', '1995-02-18', 'femenino', '2026-04-27 00:23:12', true);
INSERT INTO public.usuarios VALUES (197, 3, 1, 'Alejandra', 'Rincón Nieto', 'alejandra.rincon0197@pascualbravo.edu.co', '3136229153', '2002-04-05', 'femenino', '2026-01-02 13:01:14', true);
INSERT INTO public.usuarios VALUES (198, 3, 8, 'María', 'Murillo Acosta', 'maria.murillo0198@pascualbravo.edu.co', '3151273379', '1988-04-17', 'femenino', '2026-03-02 13:31:03', true);
INSERT INTO public.usuarios VALUES (199, 3, 1, 'Juan', 'Jiménez Arenas', 'juan.jimenez0199@pascualbravo.edu.co', '3171533194', '1987-10-04', 'masculino', '2026-05-10 04:40:52', true);
INSERT INTO public.usuarios VALUES (200, 3, 1, 'Alejandro', 'Hernández Yepes', 'alejandro.hernandez0200@pascualbravo.edu.co', '3162741214', '1995-06-15', 'masculino', '2026-03-11 07:04:12', true);
INSERT INTO public.usuarios VALUES (201, 3, 1, 'David', 'Vargas Forero', 'david.vargas0201@pascualbravo.edu.co', '3126205010', '2002-06-25', 'masculino', '2026-02-23 14:19:29', true);
INSERT INTO public.usuarios VALUES (202, 3, 2, 'Iván', 'Giraldo Castaño', 'ivan.giraldo0202@pascualbravo.edu.co', '3129907683', '1987-12-08', 'masculino', '2026-04-02 12:32:03', true);
INSERT INTO public.usuarios VALUES (203, 3, 4, 'Luis', 'Medina Forero', 'luis.medina0203@pascualbravo.edu.co', '3243534652', '1988-08-04', 'otro', '2026-02-05 03:00:03', true);
INSERT INTO public.usuarios VALUES (204, 3, 4, 'Harold', 'Parra Escobar', 'harold.parra0204@pascualbravo.edu.co', '3120064609', '1985-02-07', 'masculino', '2026-04-24 04:05:57', true);
INSERT INTO public.usuarios VALUES (205, 3, 6, 'Rodrigo', 'López Lozano', 'rodrigo.lopez0205@pascualbravo.edu.co', '3163015826', '2000-01-13', 'masculino', '2026-04-20 05:22:13', true);
INSERT INTO public.usuarios VALUES (206, 3, 1, 'Sebastián', 'Martínez Caro', 'sebastian.martinez0206@pascualbravo.edu.co', '3096876236', '1994-08-14', 'masculino', '2026-05-21 15:03:05', true);
INSERT INTO public.usuarios VALUES (207, 3, 1, 'Wilmar', 'Hernández Arias', 'wilmar.hernandez0207@pascualbravo.edu.co', '3158199211', '2000-09-26', 'masculino', '2026-05-05 11:58:36', true);
INSERT INTO public.usuarios VALUES (208, 3, 2, 'Mauricio', 'Giraldo Ríos', 'mauricio.giraldo0208@pascualbravo.edu.co', NULL, '1993-01-26', 'masculino', '2026-05-01 16:22:49', true);
INSERT INTO public.usuarios VALUES (209, 3, 9, 'Camilo', 'Hernández Vásquez', 'camilo.hernandez0209@pascualbravo.edu.co', '3217503932', '1992-10-28', 'masculino', '2026-04-10 11:59:53', true);
INSERT INTO public.usuarios VALUES (210, 3, 9, 'Mauricio', 'Ospina Calderón', 'mauricio.ospina0210@pascualbravo.edu.co', NULL, '1996-10-19', 'masculino', '2026-02-06 18:12:53', true);
INSERT INTO public.usuarios VALUES (211, 3, 1, 'Yolanda', 'Castro Caballero', 'yolanda.castro0211@pascualbravo.edu.co', NULL, '1986-04-20', 'femenino', '2026-02-26 00:33:30', true);
INSERT INTO public.usuarios VALUES (212, 3, 5, 'Alejandro', 'Murillo Naranjo', 'alejandro.murillo0212@pascualbravo.edu.co', '3117993466', '1985-03-19', 'masculino', '2026-02-06 03:54:33', true);
INSERT INTO public.usuarios VALUES (213, 3, 3, 'Harold', 'Salazar Franco', 'harold.salazar0213@pascualbravo.edu.co', '3128314232', '1990-12-14', 'masculino', '2026-05-05 20:20:11', true);
INSERT INTO public.usuarios VALUES (214, 3, 1, 'Wendy', 'Ospina Ríos', 'wendy.ospina0214@pascualbravo.edu.co', '3060785855', '1994-12-23', 'femenino', '2026-03-17 04:11:46', true);
INSERT INTO public.usuarios VALUES (215, 3, 1, 'Liliana', 'Martínez Naranjo', 'liliana.martinez0215@pascualbravo.edu.co', '3239648058', '2005-10-04', 'femenino', '2026-05-08 04:21:47', true);
INSERT INTO public.usuarios VALUES (216, 3, 1, 'Miguel', 'Murillo Forero', 'miguel.murillo0216@pascualbravo.edu.co', NULL, '1991-04-23', 'masculino', '2026-01-18 11:16:50', false);
INSERT INTO public.usuarios VALUES (217, 3, 2, 'Edwin', 'Vargas Henao', 'edwin.vargas0217@pascualbravo.edu.co', '3157141449', '2002-07-04', 'masculino', '2026-05-03 18:41:48', true);
INSERT INTO public.usuarios VALUES (218, 3, 7, 'Juan', 'Álvarez Bernal', 'juan.alvarez0218@pascualbravo.edu.co', '3019959009', '1995-03-13', 'masculino', '2026-02-11 23:04:35', true);
INSERT INTO public.usuarios VALUES (219, 3, 8, 'Kevin', 'Bedoya Bernal', 'kevin.bedoya0219@pascualbravo.edu.co', '3232145548', '2004-07-06', 'masculino', '2026-01-14 03:21:13', true);
INSERT INTO public.usuarios VALUES (220, 3, 1, 'Nathalia', 'Díaz Yepes', 'nathalia.diaz0220@pascualbravo.edu.co', '3016661956', '1997-10-18', 'femenino', '2026-05-06 04:03:23', true);
INSERT INTO public.usuarios VALUES (221, 3, 1, 'Cindy', 'Bedoya Ochoa', 'cindy.bedoya0221@pascualbravo.edu.co', NULL, '1991-03-21', 'femenino', '2026-03-16 02:30:54', true);
INSERT INTO public.usuarios VALUES (222, 3, 1, 'Julián', 'Pérez Arias', 'julian.perez0222@pascualbravo.edu.co', '3161196706', '1996-03-15', 'masculino', '2026-01-12 08:28:29', true);
INSERT INTO public.usuarios VALUES (223, 3, 1, 'Diana', 'Sánchez Escobar', 'diana.sanchez0223@pascualbravo.edu.co', '3265564347', '2003-04-18', 'femenino', '2026-01-16 12:52:33', true);
INSERT INTO public.usuarios VALUES (224, 3, 1, 'Lorena', 'Mejía Sierra', 'lorena.mejia0224@pascualbravo.edu.co', '3062989744', '1986-09-19', 'femenino', '2026-05-13 18:43:39', true);
INSERT INTO public.usuarios VALUES (225, 3, 1, 'Felipe', 'Morales Ochoa', 'felipe.morales0225@pascualbravo.edu.co', NULL, '1998-02-22', 'masculino', '2026-04-22 06:52:40', true);
INSERT INTO public.usuarios VALUES (226, 3, 1, 'Jorge', 'Pérez Mesa', 'jorge.perez0226@pascualbravo.edu.co', '3253771998', '1993-09-15', 'masculino', '2026-01-04 22:39:37', true);
INSERT INTO public.usuarios VALUES (227, 3, 5, 'Sebastián', 'Mejía Calderón', 'sebastian.mejia0227@pascualbravo.edu.co', '3024178065', '2003-02-26', 'masculino', '2026-03-15 17:56:22', true);
INSERT INTO public.usuarios VALUES (228, 3, 5, 'Liliana', 'Giraldo Cano', 'liliana.giraldo0228@pascualbravo.edu.co', NULL, '1993-07-05', 'femenino', '2026-04-13 01:25:56', true);
INSERT INTO public.usuarios VALUES (229, 3, 8, 'Fabio', 'Mendoza Nieto', 'fabio.mendoza0229@pascualbravo.edu.co', NULL, '1994-05-09', 'masculino', '2026-05-06 22:43:06', true);
INSERT INTO public.usuarios VALUES (230, 3, 3, 'Hernando', 'Cruz Vásquez', 'hernando.cruz0230@pascualbravo.edu.co', '3296644900', '1987-04-15', 'masculino', '2026-02-24 13:47:31', true);
INSERT INTO public.usuarios VALUES (231, 3, 4, 'Angélica', 'Vargas Duque', 'angelica.vargas0231@pascualbravo.edu.co', '3264141437', '1989-09-19', 'femenino', '2026-01-08 05:12:56', true);
INSERT INTO public.usuarios VALUES (232, 3, 1, 'Rodrigo', 'López Nieto', 'rodrigo.lopez0232@pascualbravo.edu.co', '3159439358', '1999-09-13', 'masculino', '2026-02-01 21:01:15', true);
INSERT INTO public.usuarios VALUES (233, 3, 2, 'Fabio', 'Salazar Agudelo', 'fabio.salazar0233@pascualbravo.edu.co', '3044716747', '1987-05-01', 'masculino', '2026-04-09 01:10:54', true);
INSERT INTO public.usuarios VALUES (234, 3, 1, 'Sofia', 'Morales Vásquez', 'sofia.morales0234@pascualbravo.edu.co', '3212691381', '1985-08-05', 'femenino', '2026-02-14 19:51:00', true);
INSERT INTO public.usuarios VALUES (235, 3, 1, 'Milena', 'Valencia Mesa', 'milena.valencia0235@pascualbravo.edu.co', '3143822694', '1991-08-10', 'femenino', '2026-05-14 19:25:37', true);
INSERT INTO public.usuarios VALUES (236, 3, 1, 'Patricia', 'Cárdenas Campos', 'patricia.cardenas0236@pascualbravo.edu.co', '3124509544', '2000-02-11', 'femenino', '2026-03-12 20:20:55', true);
INSERT INTO public.usuarios VALUES (237, 3, 1, 'Yolanda', 'Reyes Jaramillo', 'yolanda.reyes0237@pascualbravo.edu.co', '3017620167', '2004-07-22', 'femenino', '2026-03-23 21:08:46', true);
INSERT INTO public.usuarios VALUES (238, 3, 4, 'Edwin', 'Medina Mesa', 'edwin.medina0238@pascualbravo.edu.co', '3286778235', '1991-06-24', 'masculino', '2026-02-26 21:34:40', true);
INSERT INTO public.usuarios VALUES (239, 3, 4, 'Angélica', 'Ruiz Lozano', 'angelica.ruiz0239@pascualbravo.edu.co', '3234311643', '1994-02-16', 'femenino', '2026-02-02 23:16:46', true);
INSERT INTO public.usuarios VALUES (240, 3, 5, 'Óscar', 'Pérez Ríos', 'oscar.perez0240@pascualbravo.edu.co', '3251216287', '1998-06-12', 'masculino', '2026-03-08 18:18:29', true);
INSERT INTO public.usuarios VALUES (241, 3, 1, 'Jennifer', 'Salazar Caro', 'jennifer.salazar0241@pascualbravo.edu.co', NULL, '1991-09-04', 'femenino', '2026-04-08 16:19:26', true);
INSERT INTO public.usuarios VALUES (242, 3, 9, 'Diego', 'Murillo Henao', 'diego.murillo0242@pascualbravo.edu.co', '3129223220', '1995-12-06', 'masculino', '2026-01-21 15:21:40', true);
INSERT INTO public.usuarios VALUES (243, 3, 2, 'Hernando', 'Mendoza Pineda', 'hernando.mendoza0243@pascualbravo.edu.co', '3087346846', '1990-08-26', 'masculino', '2026-01-23 04:39:27', true);
INSERT INTO public.usuarios VALUES (244, 3, 1, 'Diana', 'Rodríguez Castaño', 'diana.rodriguez0244@pascualbravo.edu.co', '3260076822', '1985-06-25', 'otro', '2026-05-16 06:01:43', true);
INSERT INTO public.usuarios VALUES (245, 3, 1, 'Pablo', 'Ruiz Holguín', 'pablo.ruiz0245@pascualbravo.edu.co', NULL, '2001-10-10', 'masculino', '2026-02-12 02:52:02', true);
INSERT INTO public.usuarios VALUES (246, 3, 4, 'Cindy', 'Quintero Patiño', 'cindy.quintero0246@pascualbravo.edu.co', '3227956913', '1995-08-12', 'femenino', '2026-02-18 05:58:58', false);
INSERT INTO public.usuarios VALUES (247, 3, 1, 'Alejandro', 'Morales Bernal', 'alejandro.morales0247@pascualbravo.edu.co', '3026530521', '1996-12-21', 'masculino', '2026-01-10 12:56:40', true);
INSERT INTO public.usuarios VALUES (248, 3, 1, 'Luis', 'Sánchez Bernal', 'luis.sanchez0248@pascualbravo.edu.co', NULL, '1988-07-15', 'masculino', '2026-04-08 03:35:16', true);
INSERT INTO public.usuarios VALUES (249, 3, 1, 'María', 'Ruiz Henao', 'maria.ruiz0249@pascualbravo.edu.co', '3279834723', '1993-10-20', 'femenino', '2026-02-05 13:53:57', true);
INSERT INTO public.usuarios VALUES (250, 3, 1, 'Daniel', 'Sánchez Caballero', 'daniel.sanchez0250@pascualbravo.edu.co', '3045298445', '2001-04-12', 'masculino', '2026-04-15 09:10:02', true);
INSERT INTO public.usuarios VALUES (251, 3, 1, 'Lorena', 'Murillo Sierra', 'lorena.murillo0251@pascualbravo.edu.co', NULL, '1987-02-27', 'femenino', '2026-05-07 04:05:49', true);
INSERT INTO public.usuarios VALUES (252, 3, 1, 'Julián', 'Jiménez Cifuentes', 'julian.jimenez0252@pascualbravo.edu.co', '3145450260', '1999-01-04', 'masculino', '2026-02-14 01:54:18', true);
INSERT INTO public.usuarios VALUES (253, 3, 1, 'Daniel', 'Sánchez Castaño', 'daniel.sanchez0253@pascualbravo.edu.co', NULL, '1989-11-21', 'masculino', '2026-02-13 10:22:57', true);
INSERT INTO public.usuarios VALUES (254, 3, 4, 'Camila', 'Parra Patiño', 'camila.parra0254@pascualbravo.edu.co', '3163720675', '1999-05-27', 'femenino', '2026-04-09 22:54:30', true);
INSERT INTO public.usuarios VALUES (255, 3, 3, 'Paula', 'Torres Correa', 'paula.torres0255@pascualbravo.edu.co', '3023920137', '1998-10-16', 'femenino', '2026-04-23 05:39:24', true);
INSERT INTO public.usuarios VALUES (256, 3, 1, 'Juliana', 'Bedoya Caballero', 'juliana.bedoya0256@pascualbravo.edu.co', NULL, '1998-08-02', 'femenino', '2026-01-17 08:41:20', true);
INSERT INTO public.usuarios VALUES (257, 3, 1, 'Liliana', 'Mejía Ríos', 'liliana.mejia0257@pascualbravo.edu.co', '3255405943', '2001-09-23', 'femenino', '2026-01-25 13:42:46', true);
INSERT INTO public.usuarios VALUES (258, 3, 5, 'Sandra', 'Flores Agudelo', 'sandra.flores0258@pascualbravo.edu.co', '3217323740', '1985-11-06', 'femenino', '2026-05-10 15:54:31', true);
INSERT INTO public.usuarios VALUES (259, 3, 1, 'Alejandra', 'Murillo Vásquez', 'alejandra.murillo0259@pascualbravo.edu.co', NULL, '1992-09-21', 'femenino', '2026-04-07 12:52:15', true);
INSERT INTO public.usuarios VALUES (260, 3, 1, 'Camila', 'Aguilar Forero', 'camila.aguilar0260@pascualbravo.edu.co', '3197694240', '1985-02-13', 'femenino', '2026-04-16 01:35:35', true);
INSERT INTO public.usuarios VALUES (261, 3, 1, 'Wendy', 'Ruiz Botero', 'wendy.ruiz0261@pascualbravo.edu.co', '3271231190', '1995-06-27', 'femenino', '2026-01-14 07:54:29', true);
INSERT INTO public.usuarios VALUES (262, 3, 1, 'Patricia', 'Suárez González', 'patricia.suarez0262@pascualbravo.edu.co', NULL, '1992-01-11', 'femenino', '2026-04-01 20:51:18', true);
INSERT INTO public.usuarios VALUES (263, 3, 5, 'Felipe', 'Aguilar Holguín', 'felipe.aguilar0263@pascualbravo.edu.co', '3264923338', '1988-05-20', 'masculino', '2026-02-20 06:07:59', true);
INSERT INTO public.usuarios VALUES (264, 3, 7, 'Sara', 'Murillo Franco', 'sara.murillo0264@pascualbravo.edu.co', '3094992096', '2003-02-25', 'femenino', '2026-04-26 14:42:37', true);
INSERT INTO public.usuarios VALUES (265, 3, 1, 'Tatiana', 'López Agudelo', 'tatiana.lopez0265@pascualbravo.edu.co', '3274818030', '2001-03-23', 'femenino', '2026-02-14 23:52:08', true);
INSERT INTO public.usuarios VALUES (266, 3, 1, 'Gloria', 'Molina Mesa', 'gloria.molina0266@pascualbravo.edu.co', '3243318046', '1993-07-11', 'femenino', '2026-03-17 14:51:08', true);
INSERT INTO public.usuarios VALUES (267, 3, 2, 'Angélica', 'Ruiz Agudelo', 'angelica.ruiz0267@pascualbravo.edu.co', '3284300459', '2005-04-07', 'femenino', '2026-02-23 19:45:18', true);
INSERT INTO public.usuarios VALUES (268, 3, 4, 'Nicolás', 'Molina Arias', 'nicolas.molina0268@pascualbravo.edu.co', '3125489430', '1996-09-16', 'masculino', '2026-04-17 21:47:57', true);
INSERT INTO public.usuarios VALUES (269, 3, 4, 'María', 'Quintero Franco', 'maria.quintero0269@pascualbravo.edu.co', NULL, '1989-01-22', 'femenino', '2026-01-15 06:17:48', true);
INSERT INTO public.usuarios VALUES (270, 4, 1, 'Diana', 'López Yepes', 'diana.lopez0270@pascualbravo.edu.co', '3214336089', '1996-08-04', 'femenino', '2026-02-27 23:41:35', true);
INSERT INTO public.usuarios VALUES (271, 3, 4, 'Lina', 'López Mesa', 'lina.lopez0271@pascualbravo.edu.co', '3251963706', '2002-01-01', 'femenino', '2026-03-06 06:39:55', true);
INSERT INTO public.usuarios VALUES (272, 3, 1, 'Patricia', 'Salazar Arias', 'patricia.salazar0272@pascualbravo.edu.co', '3035970823', '1994-08-06', 'femenino', '2026-01-20 05:11:47', true);
INSERT INTO public.usuarios VALUES (273, 3, 1, 'Fredy', 'Díaz Holguín', 'fredy.diaz0273@pascualbravo.edu.co', '3110757677', '1995-08-23', 'masculino', '2026-02-09 01:09:59', true);
INSERT INTO public.usuarios VALUES (274, 3, 1, 'Wendy', 'Ruiz Caballero', 'wendy.ruiz0274@pascualbravo.edu.co', '3258061434', '1987-12-11', 'femenino', '2026-05-15 07:11:33', true);
INSERT INTO public.usuarios VALUES (275, 3, 1, 'Edison', 'Medina Escobar', 'edison.medina0275@pascualbravo.edu.co', '3099031246', '1995-06-12', 'masculino', '2026-03-17 06:48:39', true);
INSERT INTO public.usuarios VALUES (276, 3, 7, 'María', 'Ramírez Obando', 'maria.ramirez0276@pascualbravo.edu.co', '3292369566', '2004-04-02', 'femenino', '2026-03-24 12:58:50', true);
INSERT INTO public.usuarios VALUES (277, 3, 1, 'Lina', 'Gómez Arenas', 'lina.gomez0277@pascualbravo.edu.co', '3179029393', '2001-08-16', 'femenino', '2026-01-12 09:57:41', true);
INSERT INTO public.usuarios VALUES (278, 3, 1, 'Paola', 'Arango Arias', 'paola.arango0278@pascualbravo.edu.co', NULL, '1987-04-22', 'femenino', '2026-02-24 21:27:53', true);
INSERT INTO public.usuarios VALUES (279, 3, 1, 'Adriana', 'García Jaramillo', 'adriana.garcia0279@pascualbravo.edu.co', NULL, '1995-01-03', 'femenino', '2026-01-19 01:11:50', true);
INSERT INTO public.usuarios VALUES (280, 3, 3, 'Vanessa', 'Cardona Mesa', 'vanessa.cardona0280@pascualbravo.edu.co', '3168119636', '1995-01-13', 'femenino', '2026-01-31 17:00:41', true);
INSERT INTO public.usuarios VALUES (281, 3, 4, 'Luisa', 'García Obando', 'luisa.garcia0281@pascualbravo.edu.co', '3048901209', '1994-10-03', 'femenino', '2026-03-14 14:24:25', true);
INSERT INTO public.usuarios VALUES (282, 3, 2, 'Esteban', 'Torres Largo', 'esteban.torres0282@pascualbravo.edu.co', '3249591339', '2005-03-10', 'masculino', '2026-04-06 00:35:55', true);
INSERT INTO public.usuarios VALUES (283, 3, 2, 'Steven', 'Medina Arias', 'steven.medina0283@pascualbravo.edu.co', '3050894954', '1991-12-24', 'masculino', '2026-03-30 06:26:57', true);
INSERT INTO public.usuarios VALUES (284, 3, 1, 'Esteban', 'Zapata Urrego', 'esteban.zapata0284@pascualbravo.edu.co', '3086140729', '1986-09-15', 'masculino', '2026-05-21 02:18:42', true);
INSERT INTO public.usuarios VALUES (285, 3, 1, 'Mariana', 'Murillo Obando', 'mariana.murillo0285@pascualbravo.edu.co', NULL, '2005-04-04', 'femenino', '2026-03-14 19:04:57', true);
INSERT INTO public.usuarios VALUES (286, 3, 3, 'Iván', 'Salazar Jaramillo', 'ivan.salazar0286@pascualbravo.edu.co', '3152457517', '1998-03-01', 'masculino', '2026-03-22 07:50:14', true);
INSERT INTO public.usuarios VALUES (287, 3, 1, 'Cristian', 'Torres Patiño', 'cristian.torres0287@pascualbravo.edu.co', '3169774935', '1996-05-16', 'masculino', '2026-01-28 05:41:38', true);
INSERT INTO public.usuarios VALUES (288, 3, 2, 'Nathalia', 'Reyes Urrego', 'nathalia.reyes0288@pascualbravo.edu.co', '3220262606', '1987-01-28', 'femenino', '2026-05-10 20:01:52', true);
INSERT INTO public.usuarios VALUES (289, 3, 2, 'Luisa', 'Cárdenas Urrego', 'luisa.cardenas0289@pascualbravo.edu.co', '3273364719', '2005-03-12', 'femenino', '2026-04-11 07:57:49', true);
INSERT INTO public.usuarios VALUES (290, 3, 1, 'Jhonatan', 'Molina Escobar', 'jhonatan.molina0290@pascualbravo.edu.co', '3211421591', '1992-10-22', 'masculino', '2026-02-12 16:08:28', true);
INSERT INTO public.usuarios VALUES (291, 3, 2, 'Diana', 'Bedoya Obando', 'diana.bedoya0291@pascualbravo.edu.co', NULL, '2000-04-03', 'femenino', '2026-03-09 11:14:02', true);
INSERT INTO public.usuarios VALUES (292, 3, 4, 'Sandra', 'Bedoya Cifuentes', 'sandra.bedoya0292@pascualbravo.edu.co', '3097043518', '1995-02-23', 'femenino', '2026-05-14 20:53:17', true);
INSERT INTO public.usuarios VALUES (293, 3, 4, 'Laura', 'Ríos Mesa', 'laura.rios0293@pascualbravo.edu.co', '3220447168', '2001-05-13', 'femenino', '2026-02-27 16:25:22', true);
INSERT INTO public.usuarios VALUES (294, 3, 1, 'Cindy', 'Rodríguez Botero', 'cindy.rodriguez0294@pascualbravo.edu.co', '3132227237', '1992-02-17', 'femenino', '2026-03-13 06:09:11', true);
INSERT INTO public.usuarios VALUES (295, 3, 1, 'Sofia', 'Cardona Patiño', 'sofia.cardona0295@pascualbravo.edu.co', '3174265413', '2000-04-19', 'femenino', '2026-02-11 20:53:26', true);
INSERT INTO public.usuarios VALUES (296, 3, 1, 'Paola', 'Torres Botero', 'paola.torres0296@pascualbravo.edu.co', NULL, '2003-03-02', 'femenino', '2026-02-12 08:59:11', true);
INSERT INTO public.usuarios VALUES (297, 3, 2, 'Juan', 'Álvarez Escobar', 'juan.alvarez0297@pascualbravo.edu.co', '3273272042', '2000-03-08', 'otro', '2026-04-16 19:09:50', true);
INSERT INTO public.usuarios VALUES (298, 3, 1, 'Angélica', 'Díaz Lozano', 'angelica.diaz0298@pascualbravo.edu.co', '3170863732', '2004-10-03', 'femenino', '2026-02-28 12:24:08', true);
INSERT INTO public.usuarios VALUES (299, 3, 1, 'Angélica', 'Cardona Jaramillo', 'angelica.cardona0299@pascualbravo.edu.co', '3073870080', '2004-10-02', 'femenino', '2026-05-17 16:48:07', true);
INSERT INTO public.usuarios VALUES (300, 3, 4, 'Nathalia', 'Rodríguez Gallego', 'nathalia.rodriguez0300@pascualbravo.edu.co', '3115830187', '2001-07-08', 'femenino', '2026-05-04 12:22:37', true);
INSERT INTO public.usuarios VALUES (301, 3, 1, 'Liliana', 'Sánchez Gallego', 'liliana.sanchez0301@pascualbravo.edu.co', NULL, '2000-04-28', 'femenino', '2026-01-22 09:38:56', true);
INSERT INTO public.usuarios VALUES (302, 3, 1, 'Carlos', 'Mejía Arenas', 'carlos.mejia0302@pascualbravo.edu.co', NULL, '1985-07-21', 'masculino', '2026-02-22 22:51:20', true);
INSERT INTO public.usuarios VALUES (303, 3, 4, 'Duván', 'Díaz Urrego', 'duvan.diaz0303@pascualbravo.edu.co', '3185788756', '1996-10-09', 'masculino', '2026-04-12 06:26:35', true);
INSERT INTO public.usuarios VALUES (304, 3, 4, 'Fredy', 'Bedoya Urrego', 'fredy.bedoya0304@pascualbravo.edu.co', '3256218720', '1997-12-05', 'masculino', '2026-01-31 23:14:28', true);
INSERT INTO public.usuarios VALUES (305, 4, 1, 'Jhonatan', 'Medina Patiño', 'jhonatan.medina0305@pascualbravo.edu.co', '3216986408', '1990-07-21', 'masculino', '2026-01-02 02:52:09', true);
INSERT INTO public.usuarios VALUES (306, 3, 1, 'Julián', 'Jiménez Nieto', 'julian.jimenez0306@pascualbravo.edu.co', NULL, '1986-12-13', 'masculino', '2026-04-13 19:41:33', true);
INSERT INTO public.usuarios VALUES (307, 3, 2, 'Nicolás', 'Aguilar Forero', 'nicolas.aguilar0307@pascualbravo.edu.co', NULL, '2001-05-07', 'masculino', '2026-01-09 19:32:33', true);
INSERT INTO public.usuarios VALUES (308, 3, 1, 'Patricia', 'Hernández Acosta', 'patricia.hernandez0308@pascualbravo.edu.co', '3047035619', '1997-06-22', 'femenino', '2026-04-12 12:37:12', true);
INSERT INTO public.usuarios VALUES (309, 1, 1, 'Miguel', 'Cárdenas Yepes', 'miguel.cardenas0309@pascualbravo.edu.co', '3288239864', '1996-06-27', 'masculino', '2026-03-12 07:38:12', true);
INSERT INTO public.usuarios VALUES (310, 3, 7, 'Nicolás', 'Cardona Botero', 'nicolas.cardona0310@pascualbravo.edu.co', NULL, '1987-09-10', 'masculino', '2026-03-29 03:51:32', true);
INSERT INTO public.usuarios VALUES (311, 3, 2, 'Liliana', 'Díaz Forero', 'liliana.diaz0311@pascualbravo.edu.co', '3274911705', '1992-06-25', 'femenino', '2026-04-28 21:29:57', false);
INSERT INTO public.usuarios VALUES (312, 3, 1, 'Jorge', 'Ríos Ríos', 'jorge.rios0312@pascualbravo.edu.co', '3052376656', '1998-06-17', 'masculino', '2026-05-18 00:44:53', true);
INSERT INTO public.usuarios VALUES (313, 3, 7, 'Óscar', 'García Agudelo', 'oscar.garcia0313@pascualbravo.edu.co', '3152127291', '1996-04-19', 'masculino', '2026-03-10 05:47:43', true);
INSERT INTO public.usuarios VALUES (314, 3, 2, 'Alejandra', 'Hernández Urrego', 'alejandra.hernandez0314@pascualbravo.edu.co', '3043513553', '2004-06-05', 'femenino', '2026-01-28 03:58:05', true);
INSERT INTO public.usuarios VALUES (315, 3, 1, 'Nathalia', 'Martínez Cano', 'nathalia.martinez0315@pascualbravo.edu.co', '3176080806', '2003-05-16', 'femenino', '2026-02-16 16:17:25', true);
INSERT INTO public.usuarios VALUES (316, 3, 1, 'Nelson', 'Bedoya Arias', 'nelson.bedoya0316@pascualbravo.edu.co', NULL, '1996-07-28', 'masculino', '2026-02-14 14:07:44', true);
INSERT INTO public.usuarios VALUES (317, 3, 1, 'Santiago', 'Ríos Calderón', 'santiago.rios0317@pascualbravo.edu.co', NULL, '1996-10-28', 'masculino', '2026-03-08 05:35:16', true);
INSERT INTO public.usuarios VALUES (318, 3, 8, 'Patricia', 'Castro Caballero', 'patricia.castro0318@pascualbravo.edu.co', '3159970552', '1996-07-09', 'femenino', '2026-04-26 05:36:08', true);
INSERT INTO public.usuarios VALUES (319, 3, 1, 'Milena', 'Hernández Agudelo', 'milena.hernandez0319@pascualbravo.edu.co', '3136315159', '1989-12-05', 'femenino', '2026-05-02 00:11:26', true);
INSERT INTO public.usuarios VALUES (320, 3, 1, 'Tatiana', 'Arango Posada', 'tatiana.arango0320@pascualbravo.edu.co', '3143685164', '2002-10-02', 'femenino', '2026-04-12 03:44:10', true);
INSERT INTO public.usuarios VALUES (321, 3, 5, 'David', 'Suárez Patiño', 'david.suarez0321@pascualbravo.edu.co', '3185208908', '2002-05-12', 'masculino', '2026-01-06 13:07:22', true);
INSERT INTO public.usuarios VALUES (322, 3, 1, 'Edinson', 'Arango Naranjo', 'edinson.arango0322@pascualbravo.edu.co', '3157661928', '1995-11-17', 'masculino', '2026-05-05 23:28:56', true);
INSERT INTO public.usuarios VALUES (323, 3, 1, 'Sebastián', 'Vargas Patiño', 'sebastian.vargas0323@pascualbravo.edu.co', '3286723896', '1997-02-03', 'masculino', '2026-02-11 10:14:20', true);
INSERT INTO public.usuarios VALUES (324, 2, 1, 'Harold', 'Mendoza Forero', 'harold.mendoza0324@pascualbravo.edu.co', '3188775038', '2001-08-14', 'masculino', '2026-02-12 05:54:01', true);
INSERT INTO public.usuarios VALUES (325, 3, 9, 'Miguel', 'Morales Lozano', 'miguel.morales0325@pascualbravo.edu.co', '3018562070', '2000-09-02', 'masculino', '2026-01-07 12:33:48', true);
INSERT INTO public.usuarios VALUES (326, 3, 1, 'Camila', 'Ríos Zuluaga', 'camila.rios0326@pascualbravo.edu.co', '3248141360', '1999-11-05', 'femenino', '2026-02-03 16:53:10', true);
INSERT INTO public.usuarios VALUES (327, 3, 1, 'Gloria', 'Bedoya Cifuentes', 'gloria.bedoya0327@pascualbravo.edu.co', '3246562845', '2002-08-05', 'femenino', '2026-05-19 05:37:38', true);
INSERT INTO public.usuarios VALUES (328, 3, 1, 'Adriana', 'Quintero Arias', 'adriana.quintero0328@pascualbravo.edu.co', '3174646194', '2002-04-26', 'femenino', '2026-01-23 14:19:23', true);
INSERT INTO public.usuarios VALUES (329, 3, 2, 'Wilmar', 'Torres Obando', 'wilmar.torres0329@pascualbravo.edu.co', '3211116303', '2000-08-10', 'masculino', '2026-01-03 13:51:18', true);
INSERT INTO public.usuarios VALUES (330, 3, 1, 'Sara', 'Cardona Agudelo', 'sara.cardona0330@pascualbravo.edu.co', '3031913660', '2005-07-27', 'femenino', '2026-04-07 07:16:05', true);
INSERT INTO public.usuarios VALUES (331, 3, 1, 'Wendy', 'Mendoza Yepes', 'wendy.mendoza0331@pascualbravo.edu.co', '3246080681', '1998-04-28', 'femenino', '2026-01-18 05:08:18', true);
INSERT INTO public.usuarios VALUES (332, 3, 3, 'Kevin', 'Aguilar Ochoa', 'kevin.aguilar0332@pascualbravo.edu.co', '3016661503', '2002-01-06', 'masculino', '2026-01-27 09:17:08', true);
INSERT INTO public.usuarios VALUES (333, 3, 3, 'Sebastián', 'Rodríguez Caballero', 'sebastian.rodriguez0333@pascualbravo.edu.co', '3151819114', '2000-06-15', 'masculino', '2026-01-09 10:05:53', true);
INSERT INTO public.usuarios VALUES (334, 3, 1, 'Harold', 'García Arias', 'harold.garcia0334@pascualbravo.edu.co', '3043565097', '1997-01-04', 'masculino', '2026-03-05 12:49:28', true);
INSERT INTO public.usuarios VALUES (335, 4, 1, 'David', 'Quintero Pineda', 'david.quintero0335@pascualbravo.edu.co', '3251890609', '1995-03-21', 'masculino', '2026-01-11 23:59:35', true);
INSERT INTO public.usuarios VALUES (336, 3, 1, 'Sara', 'Parra Correa', 'sara.parra0336@pascualbravo.edu.co', '3025157001', '1992-11-14', 'femenino', '2026-03-25 00:10:50', true);
INSERT INTO public.usuarios VALUES (337, 3, 1, 'María', 'Martínez Calderón', 'maria.martinez0337@pascualbravo.edu.co', '3190022258', '1989-06-25', 'femenino', '2026-01-23 07:10:31', true);
INSERT INTO public.usuarios VALUES (338, 3, 2, 'Andrea', 'López Obando', 'andrea.lopez0338@pascualbravo.edu.co', '3281988124', '1988-03-16', 'femenino', '2026-03-01 10:35:50', true);
INSERT INTO public.usuarios VALUES (339, 3, 2, 'Sara', 'Gómez Mesa', 'sara.gomez0339@pascualbravo.edu.co', '3043647879', '1986-08-23', 'femenino', '2026-04-23 17:18:34', true);
INSERT INTO public.usuarios VALUES (340, 3, 1, 'Pablo', 'Cruz Cifuentes', 'pablo.cruz0340@pascualbravo.edu.co', '3284426456', '1990-02-17', 'masculino', '2026-02-09 14:18:52', true);
INSERT INTO public.usuarios VALUES (341, 3, 1, 'Jhonatan', 'Ríos Naranjo', 'jhonatan.rios0341@pascualbravo.edu.co', '3258865345', '2004-04-11', 'masculino', '2026-01-17 21:34:52', true);
INSERT INTO public.usuarios VALUES (342, 3, 4, 'Marcela', 'Flores Caro', 'marcela.flores0342@pascualbravo.edu.co', '3196020669', '1995-02-04', 'femenino', '2026-05-14 21:04:02', true);
INSERT INTO public.usuarios VALUES (343, 3, 2, 'Sara', 'Sánchez Caballero', 'sara.sanchez0343@pascualbravo.edu.co', '3086639957', '2005-07-22', 'femenino', '2026-05-06 16:39:44', true);
INSERT INTO public.usuarios VALUES (344, 3, 1, 'Jorge', 'Rodríguez Pineda', 'jorge.rodriguez0344@pascualbravo.edu.co', '3072821834', '2005-01-12', 'masculino', '2026-04-17 11:50:45', true);
INSERT INTO public.usuarios VALUES (345, 3, 1, 'Natalia', 'Ruiz Duque', 'natalia.ruiz0345@pascualbravo.edu.co', '3223035125', '1988-12-08', 'femenino', '2026-05-17 12:12:12', true);
INSERT INTO public.usuarios VALUES (346, 3, 5, 'Laura', 'Cárdenas Agudelo', 'laura.cardenas0346@pascualbravo.edu.co', '3095714702', '2003-06-22', 'femenino', '2026-04-28 22:42:27', true);
INSERT INTO public.usuarios VALUES (347, 3, 1, 'Harold', 'Molina Patiño', 'harold.molina0347@pascualbravo.edu.co', '3290519326', '1999-06-11', 'masculino', '2026-05-21 10:54:23', true);
INSERT INTO public.usuarios VALUES (348, 3, 1, 'Gloria', 'Giraldo Sierra', 'gloria.giraldo0348@pascualbravo.edu.co', '3060340113', '2002-12-09', 'femenino', '2026-04-03 14:28:25', true);
INSERT INTO public.usuarios VALUES (349, 3, 7, 'Andrés', 'Quintero Holguín', 'andres.quintero0349@pascualbravo.edu.co', '3110881653', '1994-04-07', 'masculino', '2026-03-22 00:49:52', true);
INSERT INTO public.usuarios VALUES (350, 3, 5, 'Angélica', 'Cárdenas Alzate', 'angelica.cardenas0350@pascualbravo.edu.co', '3022655004', '1986-08-12', 'femenino', '2026-02-09 04:16:23', true);
INSERT INTO public.usuarios VALUES (351, 3, 4, 'Iván', 'Pérez Alzate', 'ivan.perez0351@pascualbravo.edu.co', '3020361818', '1995-08-06', 'masculino', '2026-05-05 22:44:36', true);
INSERT INTO public.usuarios VALUES (352, 3, 1, 'Luisa', 'Mejía Mesa', 'luisa.mejia0352@pascualbravo.edu.co', NULL, '1986-06-12', 'femenino', '2026-04-22 13:59:55', true);
INSERT INTO public.usuarios VALUES (353, 3, 1, 'Cindy', 'Rodríguez Mesa', 'cindy.rodriguez0353@pascualbravo.edu.co', NULL, '2001-01-11', 'femenino', '2026-05-19 18:09:20', true);
INSERT INTO public.usuarios VALUES (354, 3, 1, 'Harold', 'Suárez Campos', 'harold.suarez0354@pascualbravo.edu.co', '3039807828', '1998-05-26', 'masculino', '2026-04-11 04:08:21', true);
INSERT INTO public.usuarios VALUES (355, 3, 2, 'Harold', 'Díaz Escobar', 'harold.diaz0355@pascualbravo.edu.co', '3127498659', '1989-08-18', 'masculino', '2026-02-20 15:25:41', true);
INSERT INTO public.usuarios VALUES (356, 3, 1, 'Adriana', 'Hernández Sierra', 'adriana.hernandez0356@pascualbravo.edu.co', NULL, '1998-06-22', 'otro', '2026-01-23 03:42:26', true);
INSERT INTO public.usuarios VALUES (357, 3, 1, 'Steven', 'Gómez Zuluaga', 'steven.gomez0357@pascualbravo.edu.co', '3192707781', '1999-10-05', 'masculino', '2026-04-23 01:59:52', true);
INSERT INTO public.usuarios VALUES (358, 3, 1, 'Miguel', 'Ramírez Correa', 'miguel.ramirez0358@pascualbravo.edu.co', '3229820881', '1994-01-11', 'masculino', '2026-01-29 09:28:30', true);
INSERT INTO public.usuarios VALUES (359, 3, 2, 'Isabella', 'Arango Arenas', 'isabella.arango0359@pascualbravo.edu.co', '3274830696', '2004-12-05', 'femenino', '2026-01-05 12:37:57', true);
INSERT INTO public.usuarios VALUES (360, 3, 2, 'Ricardo', 'Reyes Caro', 'ricardo.reyes0360@pascualbravo.edu.co', '3197880113', '1985-02-13', 'masculino', '2026-03-11 21:54:58', true);
INSERT INTO public.usuarios VALUES (361, 3, 1, 'Jairo', 'Jiménez Mesa', 'jairo.jimenez0361@pascualbravo.edu.co', '3223368583', '1995-08-28', 'masculino', '2026-05-17 02:11:12', true);
INSERT INTO public.usuarios VALUES (362, 3, 1, 'Valentina', 'Martínez Sierra', 'valentina.martinez0362@pascualbravo.edu.co', '3154770958', '2000-07-24', 'femenino', '2026-02-10 00:22:43', true);
INSERT INTO public.usuarios VALUES (363, 3, 2, 'Jhonatan', 'Mendoza Correa', 'jhonatan.mendoza0363@pascualbravo.edu.co', '3113954845', '2002-05-08', 'masculino', '2026-02-08 10:57:25', true);
INSERT INTO public.usuarios VALUES (364, 3, 2, 'Kevin', 'Jiménez Henao', 'kevin.jimenez0364@pascualbravo.edu.co', '3067239162', '1994-10-11', 'masculino', '2026-04-25 17:08:13', true);
INSERT INTO public.usuarios VALUES (365, 3, 1, 'Sara', 'Torres Zuluaga', 'sara.torres0365@pascualbravo.edu.co', '3228153282', '1998-03-21', 'femenino', '2026-02-10 10:04:35', true);
INSERT INTO public.usuarios VALUES (366, 3, 1, 'Sebastián', 'Gómez Posada', 'sebastian.gomez0366@pascualbravo.edu.co', '3165197277', '1994-08-24', 'masculino', '2026-03-12 04:49:12', true);
INSERT INTO public.usuarios VALUES (367, 3, 3, 'Wendy', 'Zapata Vásquez', 'wendy.zapata0367@pascualbravo.edu.co', '3240992396', '2004-04-08', 'femenino', '2026-01-07 11:05:44', true);
INSERT INTO public.usuarios VALUES (368, 3, 8, 'Lorena', 'Parra Naranjo', 'lorena.parra0368@pascualbravo.edu.co', '3173598657', '1989-03-07', 'femenino', '2026-02-27 01:26:48', true);
INSERT INTO public.usuarios VALUES (369, 3, 1, 'Sofia', 'Reyes Pineda', 'sofia.reyes0369@pascualbravo.edu.co', NULL, '1999-10-16', 'femenino', '2026-03-25 14:56:15', true);
INSERT INTO public.usuarios VALUES (370, 3, 1, 'Sandra', 'Cruz Largo', 'sandra.cruz0370@pascualbravo.edu.co', '3286763742', '2004-09-17', 'femenino', '2026-01-10 16:06:28', true);
INSERT INTO public.usuarios VALUES (371, 3, 1, 'Alejandra', 'Quintero Arias', 'alejandra.quintero0371@pascualbravo.edu.co', '3215268263', '2002-07-17', 'femenino', '2026-01-13 06:18:28', true);
INSERT INTO public.usuarios VALUES (372, 3, 1, 'Carolina', 'Vargas Gallego', 'carolina.vargas0372@pascualbravo.edu.co', '3079386491', '1989-08-27', 'femenino', '2026-04-26 02:46:32', true);
INSERT INTO public.usuarios VALUES (373, 3, 1, 'Nathalia', 'Torres Largo', 'nathalia.torres0373@pascualbravo.edu.co', '3113343647', '1990-08-19', 'femenino', '2026-02-21 14:05:16', true);
INSERT INTO public.usuarios VALUES (374, 3, 3, 'Paola', 'Ramírez Escobar', 'paola.ramirez0374@pascualbravo.edu.co', NULL, '1999-11-12', 'femenino', '2026-01-22 16:45:24', true);
INSERT INTO public.usuarios VALUES (375, 3, 1, 'Paola', 'Ríos Agudelo', 'paola.rios0375@pascualbravo.edu.co', '3054988861', '2003-11-28', 'femenino', '2026-02-08 05:55:09', true);
INSERT INTO public.usuarios VALUES (376, 3, 5, 'Iván', 'Suárez Yepes', 'ivan.suarez0376@pascualbravo.edu.co', '3027659164', '1991-01-20', 'masculino', '2026-03-06 00:29:31', true);
INSERT INTO public.usuarios VALUES (377, 3, 1, 'Jhon', 'Hernández Pineda', 'jhon.hernandez0377@pascualbravo.edu.co', '3170899748', '1998-08-03', 'masculino', '2026-01-02 07:56:35', true);
INSERT INTO public.usuarios VALUES (378, 3, 4, 'Isabella', 'López Naranjo', 'isabella.lopez0378@pascualbravo.edu.co', NULL, '2005-06-02', 'femenino', '2026-02-07 01:42:36', true);
INSERT INTO public.usuarios VALUES (379, 3, 1, 'Andrea', 'Sánchez Henao', 'andrea.sanchez0379@pascualbravo.edu.co', '3048168910', '2004-11-23', 'femenino', '2026-02-15 14:47:37', true);
INSERT INTO public.usuarios VALUES (380, 3, 1, 'Gloria', 'Parra Mesa', 'gloria.parra0380@pascualbravo.edu.co', '3183882978', '1987-05-16', 'femenino', '2026-02-04 03:44:55', true);
INSERT INTO public.usuarios VALUES (381, 3, 7, 'Isabella', 'Zapata Correa', 'isabella.zapata0381@pascualbravo.edu.co', NULL, '2005-09-03', 'femenino', '2026-05-04 23:44:38', true);
INSERT INTO public.usuarios VALUES (382, 3, 1, 'Steven', 'Cruz Urrego', 'steven.cruz0382@pascualbravo.edu.co', '3257493391', '1989-10-19', 'masculino', '2026-05-08 16:46:40', true);
INSERT INTO public.usuarios VALUES (383, 3, 4, 'Sofia', 'Álvarez Ochoa', 'sofia.alvarez0383@pascualbravo.edu.co', NULL, '1985-08-21', 'femenino', '2026-01-31 23:54:13', true);
INSERT INTO public.usuarios VALUES (384, 3, 1, 'Óscar', 'Ospina Agudelo', 'oscar.ospina0384@pascualbravo.edu.co', '3011516293', '2005-04-23', 'masculino', '2026-03-14 08:50:04', true);
INSERT INTO public.usuarios VALUES (385, 3, 1, 'Carlos', 'Ramírez Patiño', 'carlos.ramirez0385@pascualbravo.edu.co', '3286359356', '2004-01-27', 'masculino', '2026-02-14 06:21:53', true);
INSERT INTO public.usuarios VALUES (386, 3, 1, 'Luisa', 'Torres Cano', 'luisa.torres0386@pascualbravo.edu.co', '3182070563', '1995-08-26', 'femenino', '2026-04-16 23:03:53', true);
INSERT INTO public.usuarios VALUES (387, 3, 2, 'Marcela', 'Arango Bernal', 'marcela.arango0387@pascualbravo.edu.co', '3254522609', '1996-02-05', 'femenino', '2026-03-13 00:21:24', true);
INSERT INTO public.usuarios VALUES (388, 3, 1, 'Sandra', 'Castro Campos', 'sandra.castro0388@pascualbravo.edu.co', NULL, '1994-12-28', 'femenino', '2026-03-22 22:02:17', true);
INSERT INTO public.usuarios VALUES (389, 3, 1, 'Hernando', 'Ruiz Pineda', 'hernando.ruiz0389@pascualbravo.edu.co', '3025063426', '1996-01-25', 'masculino', '2026-02-21 02:28:32', true);
INSERT INTO public.usuarios VALUES (390, 3, 1, 'Sara', 'Murillo Cano', 'sara.murillo0390@pascualbravo.edu.co', '3251655640', '1995-03-25', 'femenino', '2026-01-26 16:43:08', true);
INSERT INTO public.usuarios VALUES (391, 3, 2, 'Wilmar', 'Ramírez Acosta', 'wilmar.ramirez0391@pascualbravo.edu.co', '3089763928', '1987-06-15', 'masculino', '2026-01-12 03:33:49', true);
INSERT INTO public.usuarios VALUES (392, 3, 1, 'Yolanda', 'Morales Posada', 'yolanda.morales0392@pascualbravo.edu.co', '3147131272', '2002-06-25', 'femenino', '2026-04-23 21:07:17', true);
INSERT INTO public.usuarios VALUES (393, 3, 4, 'Kevin', 'Cárdenas Botero', 'kevin.cardenas0393@pascualbravo.edu.co', NULL, '2002-06-18', 'masculino', '2026-03-23 08:09:45', true);
INSERT INTO public.usuarios VALUES (394, 3, 1, 'Iván', 'Zapata Patiño', 'ivan.zapata0394@pascualbravo.edu.co', '3027458237', '1985-08-22', 'masculino', '2026-01-13 03:24:03', true);
INSERT INTO public.usuarios VALUES (395, 3, 4, 'Jennifer', 'Suárez Caro', 'jennifer.suarez0395@pascualbravo.edu.co', '3136594858', '2002-02-25', 'femenino', '2026-04-30 18:08:05', true);
INSERT INTO public.usuarios VALUES (396, 3, 2, 'Rodrigo', 'Ruiz Cifuentes', 'rodrigo.ruiz0396@pascualbravo.edu.co', '3029289997', '2004-05-12', 'masculino', '2026-04-11 05:44:58', true);
INSERT INTO public.usuarios VALUES (397, 3, 1, 'Carolina', 'Aguilar Bernal', 'carolina.aguilar0397@pascualbravo.edu.co', NULL, '1988-06-16', 'femenino', '2026-04-29 05:18:49', true);
INSERT INTO public.usuarios VALUES (398, 3, 1, 'Claudia', 'Sánchez Posada', 'claudia.sanchez0398@pascualbravo.edu.co', '3050549608', '2002-08-13', 'femenino', '2026-04-16 07:39:15', true);
INSERT INTO public.usuarios VALUES (399, 3, 1, 'Óscar', 'Morales Calderón', 'oscar.morales0399@pascualbravo.edu.co', '3186129797', '1995-09-23', 'masculino', '2026-03-02 05:42:42', true);
INSERT INTO public.usuarios VALUES (400, 3, 1, 'Mariana', 'Ramírez Calderón', 'mariana.ramirez0400@pascualbravo.edu.co', '3184502610', '1988-08-06', 'femenino', '2026-03-20 12:04:38', true);
INSERT INTO public.usuarios VALUES (401, 3, 1, 'Sandra', 'Cruz Caballero', 'sandra.cruz0401@pascualbravo.edu.co', '3022151134', '1991-03-19', 'femenino', '2026-01-01 04:42:09', true);
INSERT INTO public.usuarios VALUES (402, 3, 9, 'Luz', 'Reyes Pineda', 'luz.reyes0402@pascualbravo.edu.co', '3150229795', '2003-11-10', 'femenino', '2026-04-22 22:58:22', true);
INSERT INTO public.usuarios VALUES (403, 3, 5, 'Angélica', 'Medina Holguín', 'angelica.medina0403@pascualbravo.edu.co', '3059556257', '2002-01-01', 'femenino', '2026-04-02 03:55:18', true);
INSERT INTO public.usuarios VALUES (404, 3, 1, 'Claudia', 'Cruz Mesa', 'claudia.cruz0404@pascualbravo.edu.co', '3183164605', '1991-11-06', 'femenino', '2026-05-02 04:12:35', true);
INSERT INTO public.usuarios VALUES (405, 3, 2, 'Diana', 'Álvarez Holguín', 'diana.alvarez0405@pascualbravo.edu.co', NULL, '1987-11-01', 'femenino', '2026-02-06 23:56:31', true);
INSERT INTO public.usuarios VALUES (406, 3, 4, 'Alejandro', 'Cardona Cifuentes', 'alejandro.cardona0406@pascualbravo.edu.co', '3291125155', '1998-10-06', 'masculino', '2026-04-27 16:27:35', true);
INSERT INTO public.usuarios VALUES (407, 3, 8, 'Nelson', 'Giraldo Acosta', 'nelson.giraldo0407@pascualbravo.edu.co', '3241776042', '2001-05-14', 'masculino', '2026-05-20 18:23:02', true);
INSERT INTO public.usuarios VALUES (408, 3, 2, 'Paula', 'Salazar Cano', 'paula.salazar0408@pascualbravo.edu.co', '3029070658', '2001-05-15', 'femenino', '2026-05-13 02:33:56', true);
INSERT INTO public.usuarios VALUES (409, 3, 2, 'Natalia', 'Arango Calderón', 'natalia.arango0409@pascualbravo.edu.co', '3056109986', '2002-01-16', 'femenino', '2026-04-27 16:57:30', true);
INSERT INTO public.usuarios VALUES (410, 3, 2, 'Ricardo', 'Álvarez Lozano', 'ricardo.alvarez0410@pascualbravo.edu.co', NULL, '2004-12-10', 'masculino', '2026-03-08 01:40:30', true);
INSERT INTO public.usuarios VALUES (411, 3, 1, 'Lina', 'Zapata Bernal', 'lina.zapata0411@pascualbravo.edu.co', '3027021671', '2001-02-28', 'femenino', '2026-03-13 08:08:39', true);
INSERT INTO public.usuarios VALUES (412, 3, 1, 'Daniel', 'Giraldo Naranjo', 'daniel.giraldo0412@pascualbravo.edu.co', '3230285078', '1999-06-26', 'masculino', '2026-02-14 08:50:44', true);
INSERT INTO public.usuarios VALUES (413, 3, 3, 'Luisa', 'Murillo Escobar', 'luisa.murillo0413@pascualbravo.edu.co', '3230689702', '2000-07-25', 'femenino', '2026-04-09 07:42:28', true);
INSERT INTO public.usuarios VALUES (414, 3, 7, 'Martha', 'López Urrego', 'martha.lopez0414@pascualbravo.edu.co', '3017049544', '1990-08-13', 'femenino', '2026-05-02 09:30:47', true);
INSERT INTO public.usuarios VALUES (415, 3, 8, 'Jairo', 'Bedoya Urrego', 'jairo.bedoya0415@pascualbravo.edu.co', NULL, '1998-01-10', 'masculino', '2026-04-25 12:43:20', true);
INSERT INTO public.usuarios VALUES (416, 3, 1, 'Edison', 'Ospina Gallego', 'edison.ospina0416@pascualbravo.edu.co', '3246586490', '1995-05-09', 'masculino', '2026-01-26 08:41:37', true);
INSERT INTO public.usuarios VALUES (417, 3, 1, 'Jennifer', 'Reyes Arenas', 'jennifer.reyes0417@pascualbravo.edu.co', '3234148004', '1995-09-01', 'femenino', '2026-01-03 02:00:26', true);
INSERT INTO public.usuarios VALUES (418, 3, 3, 'Esteban', 'Álvarez Urrego', 'esteban.alvarez0418@pascualbravo.edu.co', '3093134088', '1987-01-20', 'masculino', '2026-02-25 19:40:07', true);
INSERT INTO public.usuarios VALUES (419, 3, 2, 'Juliana', 'Ríos Alzate', 'juliana.rios0419@pascualbravo.edu.co', '3024877375', '1990-05-10', 'femenino', '2026-04-30 21:59:04', true);
INSERT INTO public.usuarios VALUES (420, 3, 1, 'Nelson', 'Cruz Urrego', 'nelson.cruz0420@pascualbravo.edu.co', '3047216895', '1986-07-13', 'masculino', '2026-03-27 01:16:52', true);
INSERT INTO public.usuarios VALUES (421, 3, 1, 'Sara', 'Zapata Largo', 'sara.zapata0421@pascualbravo.edu.co', '3124553291', '1989-09-25', 'femenino', '2026-04-21 06:39:41', true);
INSERT INTO public.usuarios VALUES (422, 3, 1, 'Juan', 'García Duque', 'juan.garcia0422@pascualbravo.edu.co', '3169845276', '1985-08-05', 'masculino', '2026-01-01 01:42:24', true);
INSERT INTO public.usuarios VALUES (423, 3, 1, 'Liliana', 'Rodríguez Botero', 'liliana.rodriguez0423@pascualbravo.edu.co', '3174174787', '1998-07-28', 'femenino', '2026-01-18 17:14:00', true);
INSERT INTO public.usuarios VALUES (424, 3, 8, 'Paula', 'Mejía Arias', 'paula.mejia0424@pascualbravo.edu.co', '3154753520', '1994-07-02', 'femenino', '2026-01-24 11:34:54', true);
INSERT INTO public.usuarios VALUES (425, 3, 1, 'Ricardo', 'Reyes Naranjo', 'ricardo.reyes0425@pascualbravo.edu.co', '3198682228', '1991-05-23', 'masculino', '2026-04-10 03:40:44', true);
INSERT INTO public.usuarios VALUES (426, 3, 1, 'Sara', 'Torres Castaño', 'sara.torres0426@pascualbravo.edu.co', '3289583788', '1992-08-13', 'femenino', '2026-01-17 17:41:19', true);
INSERT INTO public.usuarios VALUES (427, 3, 1, 'Valentina', 'Martínez Patiño', 'valentina.martinez0427@pascualbravo.edu.co', NULL, '1986-07-04', 'femenino', '2026-02-24 20:42:33', true);
INSERT INTO public.usuarios VALUES (428, 3, 3, 'Diana', 'Salazar Ríos', 'diana.salazar0428@pascualbravo.edu.co', '3029003951', '2000-11-01', 'femenino', '2026-05-01 19:02:15', true);
INSERT INTO public.usuarios VALUES (429, 3, 1, 'Luis', 'Ruiz Franco', 'luis.ruiz0429@pascualbravo.edu.co', '3089328380', '1987-02-04', 'masculino', '2026-05-08 19:51:39', true);
INSERT INTO public.usuarios VALUES (430, 3, 1, 'Harold', 'Cruz González', 'harold.cruz0430@pascualbravo.edu.co', '3283267417', '1989-06-27', 'masculino', '2026-02-24 01:37:11', true);
INSERT INTO public.usuarios VALUES (431, 3, 3, 'Edwin', 'Vargas Nieto', 'edwin.vargas0431@pascualbravo.edu.co', '3142701425', '2003-01-05', 'masculino', '2026-01-26 20:39:24', false);
INSERT INTO public.usuarios VALUES (432, 3, 1, 'María', 'Rodríguez Naranjo', 'maria.rodriguez0432@pascualbravo.edu.co', '3297477181', '2003-05-14', 'femenino', '2026-05-02 22:08:13', true);
INSERT INTO public.usuarios VALUES (433, 3, 2, 'Camilo', 'Castro Caro', 'camilo.castro0433@pascualbravo.edu.co', '3234159253', '2000-10-03', 'masculino', '2026-03-19 11:26:00', true);
INSERT INTO public.usuarios VALUES (434, 3, 1, 'Diego', 'Zapata Nieto', 'diego.zapata0434@pascualbravo.edu.co', '3278120967', '1992-08-25', 'otro', '2026-02-23 08:03:12', true);
INSERT INTO public.usuarios VALUES (435, 3, 2, 'Lorena', 'Aguilar Naranjo', 'lorena.aguilar0435@pascualbravo.edu.co', '3017251463', '2005-06-10', 'femenino', '2026-02-23 13:16:21', true);
INSERT INTO public.usuarios VALUES (436, 3, 2, 'David', 'López Arias', 'david.lopez0436@pascualbravo.edu.co', '3075103838', '2001-02-03', 'masculino', '2026-03-02 23:28:37', true);
INSERT INTO public.usuarios VALUES (437, 3, 1, 'Gloria', 'Jiménez González', 'gloria.jimenez0437@pascualbravo.edu.co', '3041825487', '1998-04-13', 'femenino', '2026-02-26 02:30:37', true);
INSERT INTO public.usuarios VALUES (438, 3, 1, 'Kevin', 'Rincón Naranjo', 'kevin.rincon0438@pascualbravo.edu.co', '3071436848', '1991-11-12', 'masculino', '2026-03-11 06:21:08', true);
INSERT INTO public.usuarios VALUES (439, 3, 1, 'Daniel', 'Rincón Cifuentes', 'daniel.rincon0439@pascualbravo.edu.co', '3139508245', '1994-10-06', 'masculino', '2026-02-13 18:35:54', true);
INSERT INTO public.usuarios VALUES (440, 3, 2, 'Isabella', 'Salazar Cano', 'isabella.salazar0440@pascualbravo.edu.co', '3111946674', '1998-12-28', 'femenino', '2026-03-05 07:20:27', true);
INSERT INTO public.usuarios VALUES (441, 3, 1, 'Diana', 'Mejía Acosta', 'diana.mejia0441@pascualbravo.edu.co', '3015376584', '2000-12-25', 'femenino', '2026-05-10 01:27:33', true);
INSERT INTO public.usuarios VALUES (442, 3, 9, 'Daniela', 'Suárez Caballero', 'daniela.suarez0442@pascualbravo.edu.co', '3211667385', '1998-04-05', 'femenino', '2026-04-02 09:15:41', false);
INSERT INTO public.usuarios VALUES (443, 3, 1, 'Paola', 'Rincón Alzate', 'paola.rincon0443@pascualbravo.edu.co', '3071047698', '1999-03-28', 'femenino', '2026-04-14 05:50:55', true);
INSERT INTO public.usuarios VALUES (444, 3, 4, 'Natalia', 'Ríos Patiño', 'natalia.rios0444@pascualbravo.edu.co', '3167163632', '1993-12-20', 'femenino', '2026-05-19 18:50:13', true);
INSERT INTO public.usuarios VALUES (445, 3, 2, 'Andrea', 'Molina Nieto', 'andrea.molina0445@pascualbravo.edu.co', '3061399349', '1996-08-20', 'femenino', '2026-01-11 11:23:11', true);
INSERT INTO public.usuarios VALUES (446, 3, 1, 'Isabella', 'Torres Patiño', 'isabella.torres0446@pascualbravo.edu.co', '3097112459', '2000-12-25', 'femenino', '2026-02-23 23:48:14', true);
INSERT INTO public.usuarios VALUES (447, 3, 1, 'Adriana', 'Mendoza Correa', 'adriana.mendoza0447@pascualbravo.edu.co', NULL, '1996-08-16', 'femenino', '2026-05-09 16:53:07', true);
INSERT INTO public.usuarios VALUES (448, 3, 1, 'Lina', 'Suárez Caro', 'lina.suarez0448@pascualbravo.edu.co', '3218808386', '1991-08-03', 'femenino', '2026-01-21 12:57:11', true);
INSERT INTO public.usuarios VALUES (449, 3, 1, 'Fernando', 'Ramírez Jaramillo', 'fernando.ramirez0449@pascualbravo.edu.co', '3079885511', '2005-01-10', 'masculino', '2026-04-17 21:34:59', true);
INSERT INTO public.usuarios VALUES (450, 3, 2, 'Andrés', 'Álvarez Ochoa', 'andres.alvarez0450@pascualbravo.edu.co', NULL, '1992-09-21', 'masculino', '2026-03-27 13:37:21', true);
INSERT INTO public.usuarios VALUES (451, 3, 8, 'Tatiana', 'Cárdenas Forero', 'tatiana.cardenas0451@pascualbravo.edu.co', '3227710599', '1994-03-26', 'femenino', '2026-03-08 07:30:23', true);
INSERT INTO public.usuarios VALUES (452, 3, 2, 'Pablo', 'Álvarez Cifuentes', 'pablo.alvarez0452@pascualbravo.edu.co', '3231580852', '2002-05-06', 'masculino', '2026-02-14 22:44:57', true);
INSERT INTO public.usuarios VALUES (453, 3, 2, 'Juan', 'Cruz Alzate', 'juan.cruz0453@pascualbravo.edu.co', NULL, '1993-06-06', 'masculino', '2026-02-22 17:45:02', true);
INSERT INTO public.usuarios VALUES (454, 3, 1, 'Hernando', 'Arango Lozano', 'hernando.arango0454@pascualbravo.edu.co', '3013345404', '1997-08-25', 'masculino', '2026-02-07 14:59:20', true);
INSERT INTO public.usuarios VALUES (455, 3, 3, 'Angélica', 'Murillo Yepes', 'angelica.murillo0455@pascualbravo.edu.co', '3187004412', '1989-10-24', 'femenino', '2026-04-24 10:44:07', true);
INSERT INTO public.usuarios VALUES (456, 3, 2, 'Fredy', 'Ramírez Zuluaga', 'fredy.ramirez0456@pascualbravo.edu.co', NULL, '2004-04-15', 'masculino', '2026-04-02 02:20:03', true);
INSERT INTO public.usuarios VALUES (457, 3, 1, 'Milena', 'Reyes Bernal', 'milena.reyes0457@pascualbravo.edu.co', NULL, '1999-11-22', 'femenino', '2026-01-23 16:25:12', true);
INSERT INTO public.usuarios VALUES (458, 3, 1, 'Andrea', 'Parra Largo', 'andrea.parra0458@pascualbravo.edu.co', NULL, '1998-06-13', 'femenino', '2026-04-06 00:18:22', true);
INSERT INTO public.usuarios VALUES (459, 3, 1, 'Camila', 'Morales Forero', 'camila.morales0459@pascualbravo.edu.co', '3169391930', '1994-03-26', 'femenino', '2026-04-19 23:57:26', true);
INSERT INTO public.usuarios VALUES (460, 3, 2, 'Santiago', 'Ruiz Cano', 'santiago.ruiz0460@pascualbravo.edu.co', '3255018873', '1987-10-25', 'masculino', '2026-04-07 02:00:26', true);
INSERT INTO public.usuarios VALUES (461, 3, 2, 'Rodrigo', 'Mejía Holguín', 'rodrigo.mejia0461@pascualbravo.edu.co', '3148851088', '2002-08-02', 'masculino', '2026-03-19 18:19:31', true);
INSERT INTO public.usuarios VALUES (462, 4, 6, 'Carlos', 'Flores Urrego', 'carlos.flores0462@pascualbravo.edu.co', '3295437748', '2000-02-21', 'masculino', '2026-03-15 13:11:31', true);
INSERT INTO public.usuarios VALUES (463, 3, 8, 'Fernando', 'Aguilar Duque', 'fernando.aguilar0463@pascualbravo.edu.co', '3187989327', '2000-10-14', 'masculino', '2026-03-08 20:43:30', true);
INSERT INTO public.usuarios VALUES (464, 3, 1, 'Edinson', 'Gómez Urrego', 'edinson.gomez0464@pascualbravo.edu.co', '3029614192', '1995-08-23', 'masculino', '2026-02-04 11:10:03', true);
INSERT INTO public.usuarios VALUES (465, 3, 1, 'Martha', 'López Yepes', 'martha.lopez0465@pascualbravo.edu.co', '3220311502', '2001-04-25', 'femenino', '2026-02-16 03:38:48', true);
INSERT INTO public.usuarios VALUES (466, 3, 1, 'Iván', 'Mendoza Nieto', 'ivan.mendoza0466@pascualbravo.edu.co', NULL, '2003-06-27', 'masculino', '2026-02-06 00:08:33', true);
INSERT INTO public.usuarios VALUES (467, 3, 3, 'Felipe', 'Sánchez Pineda', 'felipe.sanchez0467@pascualbravo.edu.co', '3035288872', '2002-10-23', 'masculino', '2026-05-15 17:45:35', true);
INSERT INTO public.usuarios VALUES (468, 3, 1, 'Jorge', 'Ramírez Holguín', 'jorge.ramirez0468@pascualbravo.edu.co', '3156735943', '1994-12-12', 'masculino', '2026-02-05 14:56:38', true);
INSERT INTO public.usuarios VALUES (469, 3, 2, 'Iván', 'Gómez González', 'ivan.gomez0469@pascualbravo.edu.co', '3229107146', '1992-05-05', 'masculino', '2026-02-23 04:05:27', true);
INSERT INTO public.usuarios VALUES (470, 3, 1, 'Fabio', 'Valencia Castaño', 'fabio.valencia0470@pascualbravo.edu.co', '3098555359', '2001-10-02', 'masculino', '2026-05-01 03:58:16', true);
INSERT INTO public.usuarios VALUES (471, 3, 1, 'David', 'Ramírez Campos', 'david.ramirez0471@pascualbravo.edu.co', '3034800996', '1996-01-03', 'masculino', '2026-02-07 23:17:37', true);
INSERT INTO public.usuarios VALUES (472, 3, 3, 'Wendy', 'Hernández Botero', 'wendy.hernandez0472@pascualbravo.edu.co', '3087595788', '1985-09-07', 'femenino', '2026-02-19 09:10:57', false);
INSERT INTO public.usuarios VALUES (473, 3, 1, 'Isabella', 'Molina Cano', 'isabella.molina0473@pascualbravo.edu.co', '3234847161', '1999-11-04', 'femenino', '2026-02-16 11:24:27', true);
INSERT INTO public.usuarios VALUES (474, 3, 3, 'Mauricio', 'Ramírez Cifuentes', 'mauricio.ramirez0474@pascualbravo.edu.co', NULL, '1989-08-25', 'masculino', '2026-04-03 22:18:35', true);
INSERT INTO public.usuarios VALUES (475, 3, 1, 'Sandra', 'Álvarez Cifuentes', 'sandra.alvarez0475@pascualbravo.edu.co', '3169586748', '1992-09-14', 'femenino', '2026-03-16 13:12:54', true);
INSERT INTO public.usuarios VALUES (476, 3, 1, 'Cristian', 'Castro Acosta', 'cristian.castro0476@pascualbravo.edu.co', '3124115931', '1997-08-17', 'masculino', '2026-01-22 03:09:25', true);
INSERT INTO public.usuarios VALUES (477, 3, 1, 'Felipe', 'García Nieto', 'felipe.garcia0477@pascualbravo.edu.co', '3136878911', '2004-07-04', 'masculino', '2026-03-01 13:46:31', true);
INSERT INTO public.usuarios VALUES (478, 3, 1, 'Milena', 'Medina Obando', 'milena.medina0478@pascualbravo.edu.co', '3264283500', '2000-09-09', 'femenino', '2026-02-07 14:06:07', true);
INSERT INTO public.usuarios VALUES (479, 3, 2, 'Juliana', 'Gómez Franco', 'juliana.gomez0479@pascualbravo.edu.co', '3076858535', '1985-03-13', 'femenino', '2026-03-25 04:19:39', true);
INSERT INTO public.usuarios VALUES (480, 3, 1, 'Tatiana', 'Aguilar Cifuentes', 'tatiana.aguilar0480@pascualbravo.edu.co', '3276826878', '2000-09-09', 'femenino', '2026-05-19 10:51:55', false);
INSERT INTO public.usuarios VALUES (481, 3, 3, 'Adriana', 'Ramírez Mesa', 'adriana.ramirez0481@pascualbravo.edu.co', '3169398880', '1999-01-02', 'femenino', '2026-02-15 17:42:55', true);
INSERT INTO public.usuarios VALUES (482, 3, 2, 'Nelson', 'Torres Zuluaga', 'nelson.torres0482@pascualbravo.edu.co', '3124681002', '2003-11-16', 'masculino', '2026-05-19 18:30:30', true);
INSERT INTO public.usuarios VALUES (483, 3, 4, 'Julián', 'Aguilar Calderón', 'julian.aguilar0483@pascualbravo.edu.co', '3257347151', '1994-06-02', 'masculino', '2026-01-08 18:02:08', true);
INSERT INTO public.usuarios VALUES (484, 3, 1, 'Valentina', 'Murillo Mesa', 'valentina.murillo0484@pascualbravo.edu.co', NULL, '1996-06-14', 'femenino', '2026-03-31 01:42:15', true);
INSERT INTO public.usuarios VALUES (485, 3, 1, 'Natalia', 'Ruiz González', 'natalia.ruiz0485@pascualbravo.edu.co', '3082265081', '1995-01-15', 'femenino', '2026-04-19 18:32:57', false);
INSERT INTO public.usuarios VALUES (486, 3, 4, 'Andrés', 'Cruz Mesa', 'andres.cruz0486@pascualbravo.edu.co', '3186844836', '1988-08-04', 'masculino', '2026-02-22 10:31:32', true);
INSERT INTO public.usuarios VALUES (487, 3, 1, 'Iván', 'Parra Gallego', 'ivan.parra0487@pascualbravo.edu.co', '3220109437', '2002-04-10', 'masculino', '2026-03-09 01:19:36', true);
INSERT INTO public.usuarios VALUES (488, 3, 1, 'Camila', 'Salazar Franco', 'camila.salazar0488@pascualbravo.edu.co', '3119028796', '2003-09-16', 'femenino', '2026-04-20 06:22:50', true);
INSERT INTO public.usuarios VALUES (489, 3, 1, 'Yolanda', 'Valencia Arias', 'yolanda.valencia0489@pascualbravo.edu.co', '3163995920', '1993-10-17', 'femenino', '2026-04-27 21:48:35', false);
INSERT INTO public.usuarios VALUES (490, 3, 1, 'Laura', 'Mejía Caballero', 'laura.mejia0490@pascualbravo.edu.co', '3272719315', '1993-11-18', 'femenino', '2026-04-22 18:46:40', true);
INSERT INTO public.usuarios VALUES (491, 3, 2, 'Camilo', 'Flores Zuluaga', 'camilo.flores0491@pascualbravo.edu.co', '3152768905', '1987-11-07', 'masculino', '2026-04-16 08:52:18', true);
INSERT INTO public.usuarios VALUES (492, 3, 9, 'Claudia', 'Hernández González', 'claudia.hernandez0492@pascualbravo.edu.co', NULL, '1985-04-26', 'femenino', '2026-03-21 14:31:35', true);
INSERT INTO public.usuarios VALUES (493, 3, 1, 'Sara', 'Vargas Vásquez', 'sara.vargas0493@pascualbravo.edu.co', NULL, '1993-05-22', 'femenino', '2026-05-21 05:41:54', true);
INSERT INTO public.usuarios VALUES (494, 3, 4, 'Andrea', 'Pérez Posada', 'andrea.perez0494@pascualbravo.edu.co', '3064627534', '1996-11-22', 'femenino', '2026-01-24 12:53:46', true);
INSERT INTO public.usuarios VALUES (495, 3, 4, 'Angélica', 'Ramírez Arenas', 'angelica.ramirez0495@pascualbravo.edu.co', '3280499222', '1993-08-03', 'femenino', '2026-03-02 19:07:49', true);
INSERT INTO public.usuarios VALUES (496, 3, 1, 'Sandra', 'Hernández Gallego', 'sandra.hernandez0496@pascualbravo.edu.co', '3033508806', '1991-05-15', 'femenino', '2026-04-15 08:55:37', true);
INSERT INTO public.usuarios VALUES (497, 3, 1, 'Paula', 'Cruz Arias', 'paula.cruz0497@pascualbravo.edu.co', '3243064092', '1993-03-12', 'femenino', '2026-05-02 22:23:52', true);
INSERT INTO public.usuarios VALUES (498, 4, 5, 'Luisa', 'López Sierra', 'luisa.lopez0498@pascualbravo.edu.co', '3151509315', '2005-12-12', 'femenino', '2026-02-01 17:55:15', true);
INSERT INTO public.usuarios VALUES (499, 3, 5, 'Claudia', 'Díaz Zuluaga', 'claudia.diaz0499@pascualbravo.edu.co', NULL, '1992-05-07', 'femenino', '2026-02-11 14:40:20', true);
INSERT INTO public.usuarios VALUES (500, 3, 2, 'Juan', 'Mendoza Escobar', 'juan.mendoza0500@pascualbravo.edu.co', '3173228801', '1998-06-23', 'masculino', '2026-04-19 03:52:10', true);


--
-- Name: comentarios_id_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentarios_id_comentario_seq', 150, true);


--
-- Name: empresas_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresas_id_empresa_seq', 1, false);


--
-- Name: evento_usuarios_id_inscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_usuarios_id_inscripcion_seq', 300, true);


--
-- Name: eventos_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventos_id_evento_seq', 50, true);


--
-- Name: grupos_id_grupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupos_id_grupo_seq', 10, true);


--
-- Name: ofertas_laborales_id_oferta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ofertas_laborales_id_oferta_seq', 1, false);


--
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_id_perfil_seq', 500, true);


--
-- Name: postulaciones_id_postulacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.postulaciones_id_postulacion_seq', 1, false);


--
-- Name: productos_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_producto_seq', 70, true);


--
-- Name: publicaciones_id_publicacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publicaciones_id_publicacion_seq', 100, true);


--
-- Name: reacciones_id_reaccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reacciones_id_reaccion_seq', 1, false);


--
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_rol_seq', 4, true);


--
-- Name: seguidores_id_seguidor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seguidores_id_seguidor_seq', 1, false);


--
-- Name: servicios_id_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicios_id_servicio_seq', 50, true);


--
-- Name: tipos_evento_id_tipo_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_evento_id_tipo_evento_seq', 20, true);


--
-- Name: tipos_producto_id_tipo_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_producto_id_tipo_producto_seq', 20, true);


--
-- Name: tipos_servicio_id_tipo_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_servicio_id_tipo_servicio_seq', 20, true);


--
-- Name: tipos_usuario_id_tipo_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_usuario_id_tipo_usuario_seq', 9, true);


--
-- Name: transacciones_servicio_id_transaccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transacciones_servicio_id_transaccion_seq', 200, true);


--
-- Name: usuario_grupo_id_membresia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_grupo_id_membresia_seq', 120, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 500, true);


--
-- Name: comentarios comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_pkey PRIMARY KEY (id_comentario);


--
-- Name: empresas empresas_correo_contacto_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_correo_contacto_key UNIQUE (correo_contacto);


--
-- Name: empresas empresas_nit_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_nit_empresa_key UNIQUE (nit_empresa);


--
-- Name: empresas empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_pkey PRIMARY KEY (id_empresa);


--
-- Name: evento_usuarios evento_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_usuarios
    ADD CONSTRAINT evento_usuarios_pkey PRIMARY KEY (id_inscripcion);


--
-- Name: eventos eventos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id_evento);


--
-- Name: grupos grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (id_grupo);


--
-- Name: ofertas_laborales ofertas_laborales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_laborales
    ADD CONSTRAINT ofertas_laborales_pkey PRIMARY KEY (id_oferta);


--
-- Name: perfil perfil_alias_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_alias_usuario_key UNIQUE (alias_usuario);


--
-- Name: perfil perfil_id_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_id_usuario_key UNIQUE (id_usuario);


--
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- Name: postulaciones postulaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT postulaciones_pkey PRIMARY KEY (id_postulacion);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_producto);


--
-- Name: publicaciones publicaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT publicaciones_pkey PRIMARY KEY (id_publicacion);


--
-- Name: reacciones reacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT reacciones_pkey PRIMARY KEY (id_reaccion);


--
-- Name: roles roles_nombre_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_rol_key UNIQUE (nombre_rol);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- Name: seguidores seguidores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT seguidores_pkey PRIMARY KEY (id_seguidor);


--
-- Name: servicios servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_pkey PRIMARY KEY (id_servicio);


--
-- Name: tipos_evento tipos_evento_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_evento
    ADD CONSTRAINT tipos_evento_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- Name: tipos_evento tipos_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_evento
    ADD CONSTRAINT tipos_evento_pkey PRIMARY KEY (id_tipo_evento);


--
-- Name: tipos_producto tipos_producto_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_producto
    ADD CONSTRAINT tipos_producto_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- Name: tipos_producto tipos_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_producto
    ADD CONSTRAINT tipos_producto_pkey PRIMARY KEY (id_tipo_producto);


--
-- Name: tipos_servicio tipos_servicio_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_servicio
    ADD CONSTRAINT tipos_servicio_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- Name: tipos_servicio tipos_servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_servicio
    ADD CONSTRAINT tipos_servicio_pkey PRIMARY KEY (id_tipo_servicio);


--
-- Name: tipos_usuario tipos_usuario_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_usuario
    ADD CONSTRAINT tipos_usuario_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- Name: tipos_usuario tipos_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_usuario
    ADD CONSTRAINT tipos_usuario_pkey PRIMARY KEY (id_tipo_usuario);


--
-- Name: transacciones_servicio transacciones_servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_servicio
    ADD CONSTRAINT transacciones_servicio_pkey PRIMARY KEY (id_transaccion);


--
-- Name: evento_usuarios uq_evusr_par; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_usuarios
    ADD CONSTRAINT uq_evusr_par UNIQUE (id_evento, id_usuario);


--
-- Name: postulaciones uq_post_par; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT uq_post_par UNIQUE (id_usuario, id_oferta);


--
-- Name: reacciones uq_reac_par; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT uq_reac_par UNIQUE (id_publicacion, id_usuario);


--
-- Name: seguidores uq_seguidor_par; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT uq_seguidor_par UNIQUE (id_usuario_seguidor, id_usuario_seguido);


--
-- Name: usuario_grupo uq_ugr_par; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT uq_ugr_par UNIQUE (id_usuario, id_grupo);


--
-- Name: usuario_grupo usuario_grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT usuario_grupo_pkey PRIMARY KEY (id_membresia);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: usuarios usuarios_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_telefono_key UNIQUE (telefono);


--
-- Name: comentarios fk_com_pub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT fk_com_pub FOREIGN KEY (id_publicacion) REFERENCES public.publicaciones(id_publicacion);


--
-- Name: comentarios fk_com_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT fk_com_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: eventos fk_eventos_creador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT fk_eventos_creador FOREIGN KEY (id_creador) REFERENCES public.usuarios(id_usuario);


--
-- Name: eventos fk_eventos_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT fk_eventos_tipo FOREIGN KEY (id_tipo_evento) REFERENCES public.tipos_evento(id_tipo_evento);


--
-- Name: evento_usuarios fk_evusr_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_usuarios
    ADD CONSTRAINT fk_evusr_evento FOREIGN KEY (id_evento) REFERENCES public.eventos(id_evento);


--
-- Name: evento_usuarios fk_evusr_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_usuarios
    ADD CONSTRAINT fk_evusr_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: grupos fk_grupos_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT fk_grupos_admin FOREIGN KEY (id_administrador) REFERENCES public.usuarios(id_usuario);


--
-- Name: ofertas_laborales fk_ofl_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertas_laborales
    ADD CONSTRAINT fk_ofl_empresa FOREIGN KEY (id_empresa) REFERENCES public.empresas(id_empresa);


--
-- Name: perfil fk_perfil_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: postulaciones fk_post_oferta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT fk_post_oferta FOREIGN KEY (id_oferta) REFERENCES public.ofertas_laborales(id_oferta);


--
-- Name: postulaciones fk_post_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT fk_post_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: productos fk_prod_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_prod_tipo FOREIGN KEY (id_tipo_producto) REFERENCES public.tipos_producto(id_tipo_producto);


--
-- Name: productos fk_prod_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_prod_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: publicaciones fk_pub_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicaciones
    ADD CONSTRAINT fk_pub_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: reacciones fk_reac_pub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT fk_reac_pub FOREIGN KEY (id_publicacion) REFERENCES public.publicaciones(id_publicacion);


--
-- Name: reacciones fk_reac_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacciones
    ADD CONSTRAINT fk_reac_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: seguidores fk_seg_seguido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT fk_seg_seguido FOREIGN KEY (id_usuario_seguido) REFERENCES public.usuarios(id_usuario);


--
-- Name: seguidores fk_seg_seguidor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT fk_seg_seguidor FOREIGN KEY (id_usuario_seguidor) REFERENCES public.usuarios(id_usuario);


--
-- Name: servicios fk_serv_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT fk_serv_tipo FOREIGN KEY (id_tipo_servicio) REFERENCES public.tipos_servicio(id_tipo_servicio);


--
-- Name: servicios fk_serv_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT fk_serv_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: tipos_evento fk_tipos_evento_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_evento
    ADD CONSTRAINT fk_tipos_evento_admin FOREIGN KEY (id_creador_admin) REFERENCES public.usuarios(id_usuario);


--
-- Name: tipos_producto fk_tipos_producto_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_producto
    ADD CONSTRAINT fk_tipos_producto_admin FOREIGN KEY (id_creador_admin) REFERENCES public.usuarios(id_usuario);


--
-- Name: tipos_servicio fk_tipos_servicio_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_servicio
    ADD CONSTRAINT fk_tipos_servicio_admin FOREIGN KEY (id_creador_admin) REFERENCES public.usuarios(id_usuario);


--
-- Name: tipos_usuario fk_tipos_usuario_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_usuario
    ADD CONSTRAINT fk_tipos_usuario_admin FOREIGN KEY (id_creador_admin) REFERENCES public.usuarios(id_usuario);


--
-- Name: transacciones_servicio fk_trans_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_servicio
    ADD CONSTRAINT fk_trans_cliente FOREIGN KEY (id_usuario_cliente) REFERENCES public.usuarios(id_usuario);


--
-- Name: transacciones_servicio fk_trans_servicio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_servicio
    ADD CONSTRAINT fk_trans_servicio FOREIGN KEY (id_servicio) REFERENCES public.servicios(id_servicio);


--
-- Name: usuario_grupo fk_ugr_grupo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT fk_ugr_grupo FOREIGN KEY (id_grupo) REFERENCES public.grupos(id_grupo);


--
-- Name: usuario_grupo fk_ugr_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT fk_ugr_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- Name: usuarios fk_usuarios_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol);


--
-- Name: usuarios fk_usuarios_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_tipo FOREIGN KEY (id_tipo_usuario) REFERENCES public.tipos_usuario(id_tipo_usuario);


--
-- PostgreSQL database dump complete
--

\unrestrict gvQKdhGKFsaEpheMP3mo7yvOCP8YK5W6O1iuXGBqoLqwPUpKBpozxG1FzhSoc3g


