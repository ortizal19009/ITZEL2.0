--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-08-14 21:02:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 5732657)
-- Name: beneficiarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beneficiarios (
    idbene integer NOT NULL,
    codben character varying(10) NOT NULL,
    nomben character varying(100) NOT NULL,
    tpidben character(2) DEFAULT '04'::bpchar NOT NULL,
    rucben character varying(13) NOT NULL,
    ciben character varying(10),
    tlfben character varying(20) DEFAULT NULL::character varying,
    dirben character varying(50) DEFAULT NULL::character varying,
    mailben character varying(80) DEFAULT NULL::character varying,
    tpcueben smallint DEFAULT '1'::smallint,
    cuebanben character varying(18) DEFAULT NULL::character varying,
    foto character varying(30) DEFAULT NULL::character varying,
    b1 double precision DEFAULT '0'::double precision,
    b2 double precision DEFAULT '0'::double precision,
    b3 double precision DEFAULT '0'::double precision,
    idgrupo integer DEFAULT 1 NOT NULL,
    idifinan integer DEFAULT 1 NOT NULL,
    modulo character varying(10) NOT NULL,
    usucrea integer NOT NULL,
    feccrea date NOT NULL,
    usumodi integer,
    fecmodi date,
    swconsufin smallint DEFAULT '0'::smallint
);


ALTER TABLE public.beneficiarios OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 5732656)
-- Name: beneficiarios_idbene_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.beneficiarios_idbene_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.beneficiarios_idbene_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 223
-- Name: beneficiarios_idbene_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.beneficiarios_idbene_seq OWNED BY public.beneficiarios.idbene;


--
-- TOC entry 222 (class 1259 OID 5732641)
-- Name: clasificador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clasificador (
    idclasificador integer NOT NULL,
    codpar character varying(8) NOT NULL,
    nivpar smallint NOT NULL,
    grupar character varying(12) NOT NULL,
    nompar character varying(151) NOT NULL,
    despar character varying(500),
    cueejepresu character varying(35),
    presupuesto double precision DEFAULT 0,
    ejecucion double precision DEFAULT 0,
    devengado double precision DEFAULT 0,
    reforma double precision DEFAULT 0,
    asigna_ini double precision DEFAULT 0,
    grupo character(2),
    balancostos smallint,
    usucrea integer NOT NULL,
    feccrea timestamp without time zone NOT NULL,
    usumodi integer,
    fecmodi timestamp without time zone
);


ALTER TABLE public.clasificador OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 5732640)
-- Name: clasificador_idclasificador_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clasificador_idclasificador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clasificador_idclasificador_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 221
-- Name: clasificador_idclasificador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clasificador_idclasificador_seq OWNED BY public.clasificador.idclasificador;


--
-- TOC entry 220 (class 1259 OID 5732634)
-- Name: estructura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estructura (
    idestructura smallint NOT NULL,
    nivel smallint NOT NULL,
    nombre character varying(50) NOT NULL,
    longitud smallint NOT NULL
);


ALTER TABLE public.estructura OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 5732633)
-- Name: estructura_idestructura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estructura_idestructura_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estructura_idestructura_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 219
-- Name: estructura_idestructura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estructura_idestructura_seq OWNED BY public.estructura.idestructura;


--
-- TOC entry 226 (class 1259 OID 5732675)
-- Name: gruposbene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gruposbene (
    idgrupo integer NOT NULL,
    codgru character(1) NOT NULL,
    nomgru character varying(30) NOT NULL,
    modulo1 smallint DEFAULT 1,
    modulo2 smallint DEFAULT 0,
    modulo3 smallint DEFAULT 0,
    modulo4 smallint DEFAULT 0,
    modulo5 smallint DEFAULT 0,
    modulo6 smallint DEFAULT 0
);


ALTER TABLE public.gruposbene OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 5732674)
-- Name: gruposbene_idgrupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gruposbene_idgrupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gruposbene_idgrupo_seq OWNER TO postgres;

--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 225
-- Name: gruposbene_idgrupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gruposbene_idgrupo_seq OWNED BY public.gruposbene.idgrupo;


--
-- TOC entry 218 (class 1259 OID 5732629)
-- Name: ifinan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ifinan (
    idifinan integer NOT NULL,
    codifinan character varying(8) NOT NULL,
    nomifinan character varying(40) NOT NULL,
    foto character varying(40)
);


ALTER TABLE public.ifinan OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 5732628)
-- Name: ifinan_idifinan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ifinan_idifinan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ifinan_idifinan_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 217
-- Name: ifinan_idifinan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ifinan_idifinan_seq OWNED BY public.ifinan.idifinan;


--
-- TOC entry 216 (class 1259 OID 5732622)
-- Name: niveles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveles (
    idnivel smallint NOT NULL,
    nomniv character varying(50) NOT NULL,
    longniv smallint NOT NULL
);


ALTER TABLE public.niveles OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 5732621)
-- Name: niveles_idnivel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveles_idnivel_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.niveles_idnivel_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 215
-- Name: niveles_idnivel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveles_idnivel_seq OWNED BY public.niveles.idnivel;


--
-- TOC entry 230 (class 1259 OID 5732698)
-- Name: presupuesto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presupuesto (
    idpresupuesto integer NOT NULL,
    tippar smallint NOT NULL,
    codpar character varying(35) NOT NULL,
    codigo character varying(25) NOT NULL,
    nompar character varying(100) NOT NULL,
    inicia double precision DEFAULT 0 NOT NULL,
    totmod double precision DEFAULT 0 NOT NULL,
    totcerti double precision DEFAULT 0 NOT NULL,
    totmisos double precision DEFAULT 0 NOT NULL,
    totdeven double precision DEFAULT 0 NOT NULL,
    arrastre double precision DEFAULT 0 NOT NULL,
    arrastreaa double precision DEFAULT 0 NOT NULL,
    idproyecto smallint NOT NULL,
    idclasificador integer NOT NULL,
    usucrea smallint NOT NULL,
    feccrea timestamp without time zone NOT NULL,
    usumodi smallint,
    fecmodi timestamp without time zone
);


ALTER TABLE public.presupuesto OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 5732697)
-- Name: presupuesto_idpresupuesto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.presupuesto_idpresupuesto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.presupuesto_idpresupuesto_seq OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 229
-- Name: presupuesto_idpresupuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.presupuesto_idpresupuesto_seq OWNED BY public.presupuesto.idpresupuesto;


--
-- TOC entry 228 (class 1259 OID 5732686)
-- Name: proyectos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyectos (
    idproyecto integer NOT NULL,
    codigo character varying(20) NOT NULL,
    nombre character varying(50) NOT NULL,
    movimiento boolean NOT NULL,
    idestructura bigint NOT NULL,
    usucrea integer,
    feccrea timestamp without time zone,
    usumodi integer,
    fecmodi timestamp without time zone
);


ALTER TABLE public.proyectos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 5732685)
-- Name: proyectos_idproyecto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proyectos_idproyecto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proyectos_idproyecto_seq OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 227
-- Name: proyectos_idproyecto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proyectos_idproyecto_seq OWNED BY public.proyectos.idproyecto;


--
-- TOC entry 4732 (class 2604 OID 5732660)
-- Name: beneficiarios idbene; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios ALTER COLUMN idbene SET DEFAULT nextval('public.beneficiarios_idbene_seq'::regclass);


--
-- TOC entry 4726 (class 2604 OID 5732644)
-- Name: clasificador idclasificador; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificador ALTER COLUMN idclasificador SET DEFAULT nextval('public.clasificador_idclasificador_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 5732637)
-- Name: estructura idestructura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estructura ALTER COLUMN idestructura SET DEFAULT nextval('public.estructura_idestructura_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 5732678)
-- Name: gruposbene idgrupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gruposbene ALTER COLUMN idgrupo SET DEFAULT nextval('public.gruposbene_idgrupo_seq'::regclass);


--
-- TOC entry 4724 (class 2604 OID 5732632)
-- Name: ifinan idifinan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ifinan ALTER COLUMN idifinan SET DEFAULT nextval('public.ifinan_idifinan_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 5732625)
-- Name: niveles idnivel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles ALTER COLUMN idnivel SET DEFAULT nextval('public.niveles_idnivel_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 5732701)
-- Name: presupuesto idpresupuesto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto ALTER COLUMN idpresupuesto SET DEFAULT nextval('public.presupuesto_idpresupuesto_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 5732689)
-- Name: proyectos idproyecto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyectos ALTER COLUMN idproyecto SET DEFAULT nextval('public.proyectos_idproyecto_seq'::regclass);


--
-- TOC entry 4929 (class 0 OID 5732657)
-- Dependencies: 224
-- Data for Name: beneficiarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficiarios (idbene, codben, nomben, tpidben, rucben, ciben, tlfben, dirben, mailben, tpcueben, cuebanben, foto, b1, b2, b3, idgrupo, idifinan, modulo, usucrea, feccrea, usumodi, fecmodi, swconsufin) FROM stdin;
1	000000	(Ninguno)	04			\N	\N		1	\N	\N	0	0	0	2	1	1	1	2020-01-21	\N	\N	0
2	P-0001	ACERO COMERCIAL ECUATORIANO S.A.	04	1790008959001		022454333	Av. de la Prensa N45-14 y Telégrafo 1	pguayasamin@acerocomercial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
3	P-0002	ACOSTA VILLOTA JUAN CARLOS- VULCANIZADOR	04	0401526629001		0994790913	Av. Tulcanaza y Pío Montúfar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
4	P-0004	AGENCIA NAL. REGULACION CONTR. VIG. SANI	04	1768169530001		023824230	Comercio 280 y la Razón	alexandra.flores@controlsanitario.gov.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
5	P-0005	AGUILAR REVELO LUIS- TALLER AGUILAR HIGH	04	0400882668001		0994931463	Camilo Ponce y Carlos Oña	hernanaguilarrev1969@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
6	P-0006	AKI TULCAN	04	1790016919001		2960021	Ricardo del Hierro s/n y Av. Luciano Cor	comprobanteselectronicos@favorita.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
7	P-0007	ALMACEN "CRISTIAN " DOS- MONTENEGRO ISAC	04	0400999769001		2980213	Atahualpa y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
8	P-0009	ALMEIDA ERAZO LUIS ERNESTO	04	0400520474001		2590424	César Baquero N60-10 y Segundo Arauz	ealmeidadeportes@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
9	P-0010	ALMEIDA ROMERO JOHANNA - JARTRANSPORT	04	1716632573001		0998208641	Ulpiano Páez 468 N21jalmeida	jalmeida@jartransport.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
10	P-0011	ALMEIDA TERAN OSCAR IVAN	04	0400919809001		2981-959	Olmedo y Ayacucho	oscar_almeida1@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
11	P-0012	ALPASACHA CIA. LTDA.	04	1792548373001		0996570287	Pedro Pinto Guzmán 709 y Av. Napo	gerencia@alpasacha.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
12	P-0013	ALTAMIRA SERVICE - ALTAMIRANO LIDIA	04	0913575577001		0989923849	CC Bahía Norte Av. de las Américas 510	altamiraservice@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
13	P-0014	ALVAREZ CARLOS ANIBAL	04	0400813564001		0997455096	Calle 10 de agosto y Pasaje Sin Nombre.	carlitosanibal_1966@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
14	P-0017	ARCOTEL AGENCIA REGULACION Y CONTROL TEL	04	1768181900001		2947800	Av. 9 de Octubre N27 75 y Berlín 	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
15	P-0018	ARMAS PAEZ RICARDO NAYIB	04	0401731690001		0968715134	General Landázuri y Bolívar	enzonayos18@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
16	P-0019	ASEGURADORA DEL SUR	04	0190123626001		2997500	Av. de Los Naranjos N$$-463 y Azucenas	exseloyseguros@hotmial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
17	P-0020	ASEOTOTAL S.A.	04	1792018420001		0993631007	Betania 28 y San Vicente Paul	compras.publicas@aseototal.info	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
18	P-0021	ASOCIACION DE BOMBEROS 19 DE FEBRERO T	04	0491510722001		2960548	La Y. Av. Manabí s/n y Argentina	asociacion_bomberos19defebrero@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
19	P-0022	ASOCIACION ECONOMIA SOLIDARIA LOS PASTOS	04	0491512059001		0993939058	Av. Julio Robles s/n y Jorge Manrique	juangissi@textileslospastos.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
20	P-0023	ASOPROLICARC ASOC. PRODUCCION TEXTIL 	04	1792618185001		0986957238	Av. Coral y Argentina	asociacionemprendedoresc@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
21	P-0024	ASOPROSERVI ASOCIACION PROD.TEXTIL SERVIR	04	0491517107001		0980518210	26 de Mayo Nº 24 y Flavio Alfaro	asociacionservirparavivir@gmail.com	2	4008114893	\N	0	0	0	1	71	1	1	2020-01-21	\N	\N	0
22	P-0025	ASOSEINRO ASOCIACION PROD.TEXTIL Y SEG.	04	0190431045001		074084889	Calle de Los Cerezos s/n y de Los Babaco	bolo1492@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
23	P-0026	ASOTEXCARCHI	04	0491517190001		2960686	Ayacucho 758 y Rafael Arellano	mariaalvearo@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
24	P-0027	ASOTEXCOMATUL	04	0491517514001		062961431	Tulcanaza s/n y Centenario	asociacioncortemagico@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
25	P-0028	ASOTEXREMONT	04	0491517352001		0988266230	Panamericana s n e Isaac Acosta 	asociacionrelmontufar@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
26	P-0029	ASOVIPROG -ASOC. PRODUC. VIDA Y PROGRESO	04	1091748084001		062630963	Callejón SN y Tulipanes	vidayprogreso@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
27	P-0030	ASPROTEXESTUM ASOC. PROD. TEXTIL ECONOMI	04	0491519487001		0986932508	Rafael Arellano y Pasaje Riobamba 	asociaciontulcanmoda@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
28	P-0031	AUDITA & REPORTA AUDIREPORT CIA. LTDA.	04	0993034142001		0991444016	Francisco P. Icaza Nº407 y Gral. Córdova	nm_cpa@audireportec.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
29	P-0032	AUTOMEKANO CIA. LTDA.	04	1891715664001		032520182	Av. 10 de Agosto 10-814 y Tufiño	fbarahona@automekano.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
30	P-0033	AUTOPARTES Y AUTOGRUAS FCN S.A.	04	1792541743001		062985833	Av.El Centenario Nº654 y Av. Veintimilla	autopartescalannarvaez@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
31	P-0034	AYALA ENRIQUEZ JHON HENRY	04	0400994596001		062988748	Rafael Arellano s/n y Panamá	jhonayala1973@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
32	P-0035	AYALA FLORES CRISTIAN BLADIMIR	04	1003319041001		0994167482	Colón entre Roca y Atahualpa (Otavalo)	bladimir_1511_a@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
33	P-0036	AYALA GUERRERO JAIME RIGOBERTO	04	0400533527001		062985791	Av. Veintimilla y Juan Ramón Arellano	emiliach65@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
34	P-0037	AYALA GUERRERO JOSE MIGUEL- FERROTEX1	04	0400476990001		2983109	Av. Coral  59107 y Bolivia	jmayalag2088@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
35	P-0038	AYALA GUERRERO OSWALDO FERNANDO	04	0400719969001		0986234093	Roberto Sierra y Bolívar	jimmyayala123@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
36	P-0039	AZA TAIMAL GIRLENZA AURELIA	04	1750787044001		0986932508	García Moreno y Rafael Arellano	confecciones_elizabeth@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
37	P-0040	BASTIDAS LEON ANTONIO ESGARDO- MULTICARP	04	0491510986001		0997373375	Av. 24 de Mayo y Av. 26 de Mayo	multicarpascolombia@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
38	P-0041	BATALLAS LOMAS ORLANDO GERMAN	04	0400586137001		2205245	Calle Tarqui y Amazonas	malena_8523@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
39	P-0042	BECERRA DE LA CRUZ PEDRO IRRAEL	04	0400712717001		2986626	Junín 396 y Blolívar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
40	P-0043	BENITEZ TULCAN WILSON ARTURO 	04	0400587382001		0981091277	Cdla. Divino Niño Julio Robles s/n y Gra	wilsonbenitez@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
41	P-0044	BERMÚDEZ ARIAS OMAR JOSUÉ - SEGLOBAL 04	04	0400854394001		062980715	Av. Coral Nº 59039 y Venezuela	josuecurita@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
42	P-0045	BOLAÑOS ROSERO JOHNNY GABRIEL	04	0401232756001		0980333222	Pichincha S/N y Maldonado	gabobolaños2@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
43	P-0046	CABEZAS MOSQUERA JOFFRE PATRICIO	04	0400799490001		2-961-515	Bolívar s/n entre Junín y Ayacucho	pcabezas@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
44	P-0047	CADENA CEVALLOS NELSON IVAN	04	0400836573001		023265270	La Campiña del Inca - Calle 3 105 y Av. José Felix	tccc5@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
45	P-0048	CADENA CHUGA MANUEL BERNABE	04	0401019492001		0985316215	Afrodita s/n y Av. Julio Robles	bernabecadena74@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
46	P-0049	CADENA FIERRO CARLOS EFRAIN- DIDOPAST	04	1705255832001		0999663152	Maldonado 12-61 y Olmedo- Atuntaqui	carlcadenaf@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
47	P-0050	CADENA ROSERO WILMER OLIVER RENE	04	0400584983001		2285-466	Venezuela N13-31 y Antonio Ante	wilmer@renecadena.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
48	P-0051	CALAN NARVAEZ YOLANDA DEL ROCIO	04	0400930046001		0986990451	Calle Calderón y Paraguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
49	P-0052	CALZADO ANDINO, ANDICALZADO S.A.	04	1792190371001		2473968	Bartolomé Sánchez N72-223 y Antonio B.	contabilidad@andicalzado.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
50	P-0053	CAMINO MONTESDEOCA AMERICA ROCIO -PROLIM	04	1804133237001		0991341711	Humberto Fierro s/n y Pasaje Juan Abel	rociocamino1984@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
51	P-0054	CARPAS COL	04	0491515791001		0995823866	Ejido Sur, Av. Veintimilla	carpascol.myd@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
52	P-0055	CASA TOPOGRAFICA	04	1704110103001		22569355	Av. 6 de Diciembre s/n y La Niña	casatop@uio.satnet.net	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
53	P-0056	CASTILLO GOYES LUIS ANTONIO- FOTO ARTE	04	0400955324001		2962824	Ayacucho 367 y Sucre	fotoarte07@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
54	P-0057	CASTRO CASTILLO LUIS FERNANDO	04	0400735254001		2982-658	México s/n y Av. 24 de Mayo	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
55	P-0058	CASTRO CASTILLO SEGUNDO MEDARDO	04	0400539391001		2982333	Av. Veintimilla s/n y San Cristóbal	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
56	P-0059	CEDENO JURADO GABRIEL ANTONIO CSQ SOLUTI.	04	0916866767001		0993318746	Ciudadela Vernaza Norte Solar 7	gabriel_antonio_25@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
57	P-0060	CEMIMEX CIA. LTDA.	04	1790500039001		022549148	Ulloa N27-114 y Selva Alegre	cemimexcialtda@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
58	P-0061	CENADEPRO CIA. LTDA.	04	1792591783001		022227845	Díaz de la Madrid Oe5-105 y la Isla.    	contabilidadcenadepro@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
59	P-0062	CENTRO FERRETERO HUACA -IRUA H. VANESSA	04	0401729215001		062973039	Calle 8 de Diciembre y Cristóbal Colón	ariday1209@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
60	P-0063	CENTROLUZ	04	0400721387001		2981-771	Calle Colón 51018 y 10 de Agosto	centroluzquito@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
61	P-0064	CHAMORRO BUSTOS MARICELA ROCIO	04	0401771084001		0997945979	Calle Pichincha s/n y Maldonado	mary_chamorro88@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
62	P-0065	CHAMORRO POZO NEREIDA - COPYARTE	04	0400703088001		2988125	Ayacucho s/n y Bolívar	CopyArte_1974@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
63	P-0066	CHAMPUTIZ JARAMILLO GUIDO PATRICIO	04	0400583761001		0998132117	Av. Coral y Venezuela	gchamputiz@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
64	P-0067	CHAVEZ ENDARA EDISON JAVIER -MACRO PHOTO	04	0400947289001		0990406385	Calle Junín s/n y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
65	P-0069	CHERREZ PILLALAZA JORGE PATRICIO	04	1801635812001		0984582061	Imbabura SN y Gertrudis Esparza	pcherrez60@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
66	P-0070	CHICANGO BENÍTEZ WILMER FABIAN	04	0400957882001		0969364523	Julio Robles y El Oriental	wilmerchicango@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
67	P-0071	CHINGAL MELO EDGAR IVAN	04	0400881538001		2-983-380	Brasil No. 62-016 y Cotopaxi	principeivan1@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
68	P-0072	CHUNEZ MORILLO JOFFRE JAVIER- INFOTEC	04	0401050182001		0997534888	Sucre y Tarqui	infotec.sa@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
69	P-0073	CINECABLE TELEVISIÓN	04	0491500972001		2985-808	Bolívar s/n y Junín CC YOLIS	mreina@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
70	P-0074	CISNEROS BENAVIDES RENE NELSON	04	0401036124001		0999558253	Vía a Tufiño- La Ensillada	parcero100180@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
71	P-0075	CODYXO PAPER CIA. LTDA.	04	1791775643001		0983513186	Isla Fernandina (393) N42-117 y Tomás B.	facturacion@codyxopaper.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
72	P-0076	COGECOMSA S.A.	04	1790732657001		023814360	Francisco de Orellana L198 y Hernando M.	cogecomsa@cogecomsa.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
73	P-0077	COLLANTES HERVAS ALEX  - DOME SPORTS	04	1801713684001		0982867852	Lizardo Ruiz 02-64 y Maldonado - Ambato	alexcollantes2004@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
74	P-0078	COMERCIAL CARCHI -BENAVIDES REVELO SILVIA	04	0400579231001		062980645	Olmedo 52-069 y Junín	scabrera@comercialcarchi.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
75	P-0122	GOYES POZO ESTHELA MARIBEL	04	0400582060001		2982623	Av. Veintimilla	sagitario_luna1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
76	P-0079	COMPU.COM COLLAGUAZO SEGUNDO RAFAEL	04	1707510341001		0992063859	Av. Veintimilla y Centenario	rafael_collaguazo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
77	P-0080	CONSTRUALVID- CHUGA CHUUGA EDWIN	04	0400991592001		0985612058	Olmedo 54-035 y Boyacá	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
78	P-0081	CONSTRUCTORA V&M FRONNORT S.A.	04	0491521619001		0984264334	José María Urbina y Belén	vargas@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
79	P-0082	CONTINENTAL TIRE ANDINA S.A.	04	0190005070001		0984389490	Panamericana Norte Km. 2.8 ECO10105 	compraspublicas@continental.com	1	00070001855	\N	0	0	0	1	6	1	1	2020-01-21	\N	\N	0
80	P-0086	CORAL GUANCHA DORMAN ALIRIO	04	0401294731001		0993280925	Isla Fernandina 26 e Isla Pinzón	aliriocoral_2020@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
81	P-0087	CORAL RAMOS CRISTIAM FERNEY- NOTARIA 1ª	04	0400752432001		2988230	Bolívar Nº51-052, 10de Agosto y Ayacucho	info@notariaprimera.org	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
82	P-0088	ALS ECUADOR ALSECU S.A.	04	1791943783001		3414080	Los Eucaliptos E3-23 y de los Cipreses	karina.falcones@alsglobal.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
83	P-0089	CORPORACION FAVORITA C.A.	04	1790016919001		22996582	Av. General Enríquez Vía Cotogchoa	lfikar@favorita.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
84	P-0090	CORPORACION NACIONAL DE TELECOMUNICACION	04	1768152560001		5932 3666 100	Veintimilla E4-66 y Amazonas	germania.lomas@cntgob.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
85	P-0091	CORTEZ ROJAS FANNY MARITZA -MODAS LIZBET	04	0400671459001		062291887	Calle Rocafuerte y Maldonado	fannycortez@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
86	P-0092	CRUCERIRA VIVAS CESAR OMAR- TALLER AUTOC	04	0401019880001		062224980	Av. Calderón y Uruguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
87	P-0094	DELGADO LUCERO MANUEL MESIAS	04	0400445664001		062981225	Calle Pichincha Nº 469	manueldelgado54@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
88	P-0095	DIAZ RODRIGUEZ GONZALO JAVIER	04	1712195625001		0958845210	José María Guerrero N70-133 y Alonso.	gonzalojdr@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
89	P-0096	DIAZ VALLEJO JULIO CESAR	04	1001866985001		0993506916	Av. Manabí Nº 61045	audiosistemsjc@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
90	P-0097	DISTRIBUIDOR MATERIALES CONSTRUCCIÓN DIMAPO	04	1792931959001		2984092	Av. Veintimilla s/n y México	dimacotulcan@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
91	P-0098	ECUATORIANA DE MATRICERIA ECUAMATRIZ CIA	04	1890108241001		032755189	Santa Rosa Vía Ecológica sn Bernardino E	ventas2@ecuamatriz.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
92	P-0099	EDITORES MMA ASOCIADOS CIA. LTDA.	04	1790209113001		062982024	Bolívar y Junín Esquina	cbaez@elnorte.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
93	P-0100	EDITORIAL MINOTAURO S.A.	04	1790548287001		2984-646	Sucre Entre Ayacucho y Junín	cchamorro@lahora.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
94	P-0101	ELECTROLUX - DELGADO GUZMAN EDGAR	04	0400398137001		2981369	Av. Coral 2602 y Brasil	edgardelgado2015@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
95	P-0102	EMELNORTE	04	1090051721001		2980694	Juan Manuel Grijalva 6-54 y José Joaquín	ggarcia@emelnorte.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
96	P-0103	ENRIQUEZ NARVAEZ LUIS HUMBERTO	04	0400729836001		2980288	D9 y Pasaje G Parque Artesanal	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
97	P-0104	EP PETROECUADOR	04	1768153530001		  2994200	Av. Veintimilla y Av. Centenario	gerardo.piarpuezan@eppetroecuador.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
98	P-0106	ESERDING S.A.	04	1792458609001		0995006653	El Dorado- Vicente Solano E4-320 y Gran 	eserding@outlook.com	1	2100050267	\N	0	0	0	1	74	1	1	2020-01-21	\N	\N	0
99	P-0107	ESPINOZA GUERRERO HUGO FERNANDO	04	0401255443001		06-2-982-494	Tarqui 279 y Olmedo	hellavemaestra@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
100	P-0109	ESTRADA CHUGA DIEGO ARMANDO	04	0401245071001		2962647	Sucre 0620 y Roberto Grijalva	diegoestrada06@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
101	P-0110	ESTRELLA GRIJALVA LUIS SANTIAGO -CLEAN S	04	1709254468001		0992715362	Los Pinos Lt 70 y Av. General Rumiñahui	contable_ec@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
102	P-0111	ESTRELLA MAYA JORGE FERNANDO	04	0400959748001		0993615846	Ignacio Asin OE8-133 y Vicente Heredia	fernandoestre@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
103	P-0112	FALCONI CISNEROS JOSE LUIS- LA CONDAMINE	04	1715241525001		026008952	Los Eucaliptos OE3-105 y Real Audiencia	contabilidad@lacondamine.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
104	P-0113	FARMAENLACE CIA. LTDA 	04	1791984722001		0990539200	Veintimilla s/n y Arellano	ecotulcanveintimilla@farmaenlace.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
105	P-0114	FERRETERIA PROFEMAC S.C.	04	1792543894001		062960869	Rafael Arellano s/n y Junín	profemac1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
106	P-0115	FIERRO POZO NANCY NOEMY- LA OVEJA NEGRA	04	0400602934001		0992707056	Calle Cuenca s/n y Venezuela	ovejanegradesing@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
107	P-0116	FIGUEROA ORTEGA NELSON POLIVIO	04	0401109731001		2250323	Calle Colón entre 10 de Agosto y Pichincha	figueroanelson28@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
108	P-0117	GARCIA VALENCIA CYNTHIA STEFANIA	04	1716760382001		026008952	Eucaliptos OE3-105y Av. Real Audiencia	contabilidad@lacondamine.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
109	P-0118	GENSYSTEMS S.A.	04	0992238402001		45125636	Alpallana E/-123 y Whimper	angel@gs-ec.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
110	P-0119	GONZÁLEZ ALVAREZ MARÍA JOSÉ -INNOVAGUA	04	1712845880001		0992728952	1º de Mayo Cs-28 y 7 de Febrero 	comercial@innovagua.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
111	P-0120	GONZÁLEZ VARGAS JOSÉ MANUEL	04	1724313935001		022071013	Autopista General Rumiñahui 428 y Lucian	contabilidad@superinflables.net	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
112	P-0121	GORDON MORA NATALY JOHANA	04	0401412853001		0980339420	San Juan y Río Bobo	tallerdetorno1973@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
113	P-0123	GPDATA SERVICIOS AMBIENTALES  CIA. LTDA.	04	0691743063001		0987713054	Veloz 40-11 y Carlos Zambrano- Riobamba	gpdata-eia@outlook.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
114	P-0124	GRUPO EL COMERCIO	04	1790008851001		0987441013	Av. Pedro Vicente Maldonado 11515 y El T	clarco@elcomercio.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
115	P-0125	GUERRERO CABRERA MARIA F. -COLCHONMAR	04	0401199237001		0994491843	Av. Coral y Venezuela	mafergc7@hot.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
116	P-0126	GUERRERO CISNEROS ARTURO WASHINGTON 	04	0400736427001		2963094	Luis Cordero Crespo y Barrio San Vicente	yess-92@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
117	P-0127	GUERRERO IBARRA DAYANA GABRIELA	04	0401673884001		260077	Av. Coral 62091 y Paraguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
118	P-0128	GUERRERO NILO GERMAN	04	0400631453001		0993672730	Av. Víctor Manuel Guzmán 11-69 y Juan M.	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
119	P-0129	GUERRÓN MEJÍA SANTIAGO HERMEL- PINTACASA	04	0401255534001		0998480669	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
120	P-0130	GUERRON MORILLO MARCO ANTONIO	04	0400354866001		2985830	Ayacucho s/n y Olmedo	graficasguerron@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
121	P-0131	GUERRON VILLARREAL SEGUNDO -TALLER COLOR	04	0400396727001		062984148	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
122	P-0132	GUZMÁN BURBANO JOSÉ ANTONIO	04	0400541504001		0982593007	Av. Manabí s/n y Av. Brasil	jantonioguzman417@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
123	P-0133	HDM ELQUITECNICA CIA. LTDA.	04	1790990842001		2464587	Av. República del Salvador N35-182 y Sue	asesoriatecnica.hdm@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
124	P-0134	HERRERA NARVAEZ ADRIANA VERONICA	04	0401492731001		062987429	Guatemala y Av. Coral	adriana_veronicah@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
125	P-0135	HIDALGO FLORES ROBINSON CRUSOE	04	1002156873001		062558242	Av. 13 de Abril 18-64 	metalicasfortex@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
126	P-0136	HSEQ CONSULTING -PUETATE CASTRO ROSA E.	04	0401544259001		0997641549	San José San Francisco y Asdrubal B.	e.puetate87@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
127	P-0137	HYDROQUIM BALDEÓN JÁTIVA FANNY YOLANDA 	04	1703517605001		2645-510  26455	De Los Claveles S9-786 y Real Audiencia	hydroquim@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
128	P-0138	IDODIANDINA CIA. LTDA.	04	1792421551001		022552070	Av. Eloy Alfaro N28-49 y Av. 10 de Agost	jparedes@idodiandina.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
129	P-0140	IMBAQUINGO GUILLERMO EDMUNDO	04	0400461067001		2960077	Urb. Vista Hermosa- General Landázuri s/	gimbaquingo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
130	P-0141	IMBAUTO S.A.	04	1090077135001		2983-804	El Rosal Panamericana Norte	retenciones@imbauto.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
131	P-0143	INCINEROX CIA. LTDA.	04	1791414713001		026051494	Pichincha Quito Pintag Via Pifo SN y Vía	danielaboada@incinerox.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
132	P-0144	Ipial Diógenes	04	0400819884001		2224224	Via a Taquez No 195	diogenesipial@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
133	P-0145	JACOME BRAVO EDWIN RAMIRO	04	0401062674001		0986259912	Roberto Grijalva y Av. Coral	edwinjacome1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
134	P-0146	JIMENEZ TORRES MAURICIO FERNANDO	04	1709173106001		2-985-717	Olmedo s/n y Chile esquina	jimenezmauricio808@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
135	P-0147	JOELTRANS CIA. LTDA.	04	1792581184001		0995447148	Rancho Chico OE-103 y Ecuador	joeltrans@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
136	P-0148	JURADO VILLAGOMEZ EDISON ANCIZAR- EDIVA	04	1710059575001		022547761	José Tamayo N24-608 y Av. Colón	edison1jurado@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
137	P-0149	LA PRENSA INTERDIARIO DEL CARCHI	04	0491500778001		2984893	Olmedo y 10 de Agosto	prensatulcan@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
138	P-0150	LANDETA VILLARREAL XIMENA DEL PILAR 	04	0400822854001		0997392705	Sucre s/n y Rocafuerte	mariafernandateran@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
139	P-0151	LEMA CHAUCA JORGE RODRIGO- SIMPLIFIKAT	04	1715575591001		0997418888	Machala  N59-45 y Angel Ludeña	ventas@simplifikat.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
140	P-0152	LEORO PONCE JUAN CARLOS -COMERCIAL Z	04	1708976574001		022658251	General Eplicachima S9-236 y Jambelí	contabilidadcomercialz@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
141	P-0153	LEXIS S.A.	04	1790859177001		2417309	Av. Galo Plaza Laasso N47-190 y Pasaje F	jcamiloserna@lexis.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
142	P-0154	LOMAS AYALA LUCIA YOMAIRA DEL PILAR	04	0400776670001		062983888	La Rinconada- Nuevo Oriental s/n y André	washintonpantoja@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
143	P-0155	LOMAS TAPIA LUIS ALFONSO	04	0401594890001		0967540898	Eloy Alfaro y Juan Montalvo (Maldonado)	lomas_alfonso@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
144	P-0156	LOPEZ NARVÁEZ JAMES FABRICIO	04	0400962874001		2984-806	Juan Ramóm Arellano s/n y Río Napo	lopezfabricio@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
145	P-0157	LOPEZ PANTOJA ALEXANDER	04	1753845138001		0984782353	De las Alondras E15-90 y de las Higueril	alex.lopez@eurovix.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
146	P-0158	LOPEZ SOTO MARIA ELIZABETH - EL PARABRIS	04	0401295977001		0985356035	Av. 24 de Mayo  y Los Alamos	ricardofabiolc@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
147	P-0159	LUBRICANTES DEL SUR- HUERA TAPIA MARIA	04	0400932877001		2245452	Av. Veintimilla s/n y Pablo Muñoz Vega	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
148	P-0160	LUCERO LUCERO RENE- TALLER AUTOMUNDO	04	0400747630001		2985612	Av. Manabí y Los Alamos, Barrio La Y	renefabianlucero@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
149	P-0161	LUCERO MUESES EDISON ARMANDO	04	0401281043001		0981458758	Argentina s/n y Olmedo	luceroedison@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
150	P-0162	MALLAMA CUAICAL JAIME EDGAR- MUNDICOLOR	04	0400877908001		0980409784	Calle Bolívar y Carabobo	mundicoloredgar@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
151	P-0163	MARKET VIDRIOS- NARVAEZ MEDINA EDER	04	0401027537001		0997698894	Calle Bolívar s/n y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
152	P-0164	MARTINEZ ERAZO RAUL- ALMACENES MARTINEZ	04	0400999223001		2986355	Atahualpa 6-089 y Bolívar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
153	P-0165	MARTINEZ FUERTES SEGUNDO EMIGDIO	04	0400662904001		0990743799	Av. Calderón s n y Chile	nathyta_822@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
154	P-0166	MASABANDA CHANCUSI EDISON - MOBILIARIO M	04	1714949524001		0939824295	Calle Carlos Freire y Pasaje Libertadore	super_dj1983@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
155	P-0167	MAYA BENAVIDES LUIS FERNANDO- GRUPO MAYA	04	0400917886001		0997770444	Gran Colombia -Ayacucho 675 y Rafael A.	grupomaya69@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
156	P-0168	MEDINA YEPEZ BORIS GUISSEPE - TOSINORI	04	1001579687001		2611400	Sector Tenis Club Calle Venancio Gómez J	tosinorisa@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
157	P-0169	MELO FIERRO RUBÉN DARÍO	04	0400796439001		0996638601	Cepia- Coral y Brasil	rbdariomelofierro@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
158	P-0170	METALURGICA ECUATORIANA CIA. LTDA.	04	1790212734001		2644-550	San Bartolo Teodoro Gómez de la Torre 72	figueroa@interactive.net.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
159	P-0172	MINISTERIO DEL AMBIENTE, AGUA Y TRANSICIÓN ECOLÓGICA 	04	1760010460001		3987600	El Girón Madrid E12-102 y Andalucía	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
160	P-0173	MONTALVO PAREDES EFRÉN RENÉ- TECNISERVS	04	0100085109001		0999444263	Av. Julio Miguel Aguinaga y Río Amazonas	belen123456a@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
161	P-0174	MONTENEGRO EDGAR LIBARDO- PINTUCOLOR	04	0400774519001		062960391	Av. Veintimilla y Av. Universitaria	pintucolor_libardo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
162	P-0175	MONTENEGRO JIMÉNEZ DIEGO F. - SYSTAR.COM	04	0401800180001		0958819678	Bolívar s/n y 10 de Agosto	die_fer03@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
163	P-0176	MONTENEGRO TORO CARLOS	04	0400242830001		2980-277	Cdla. Kenedy General Urbina y Belén	elromanticoagma@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
164	P-0177	MONTERO ONOFRE RAUL ERNESTO	04	0400271524001		0996426720	Ecuador s/n y Urbina	raul48montero@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
165	P-0178	MONTGAR COMPAÑÍA ANÓNIMA	04	1791276779001		022306700	Calle Luis Calderón S/N y Av. Manuel C.	ventas1@montgard.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
166	P-0179	MORA CHINGUA MARITZA MARGARITA	04	0401396031001		2960377	RAFAEL ARELLANO S/N Y 10 DE AGOSTO	maritza_mora123@yahoo.com.ar	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
167	P-0180	MORENO ORTEGA LUIS - FERROALVID	04	0400741609001		2988200	Pasaje Riobamba s/n y Bolívar	ferroalvid@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
168	P-0181	MOSCOSO CÓRDOVA ALONZO MANUEL	04	1706733324001		0999582539	Calle S6 Consuelo Benavides Nº E20-99	alonzomoscoso@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
169	P-0182	MOVITECH- GUERRERO QUINTERO JAVIER	04	0401533955001		62982361	Sucre y Junín Esquina	jguerrero@movitech.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
170	P-0183	MUÑOZ MAYA EDGAR JAVIER	04	0401263439001		0983690367	Rafael Arellano y General Landázuri	edgarjavier2019@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
171	P-0184	NAINPASERVICES CIA. LTDA.	04	1792377110001		023465-496	De Los Guacamayos N60-06 y Juan Molinero	info@nainpa.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
172	P-0186	NARVÁEZ GORDÓN CARLOS EDUARDO 	04	0401733688001		0996801475	Rubén Darío s/n y Av. San Francisco	bon_jhon@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
173	P-0187	NARVAEZ TREJO BYRON VLADIMIR - LUMIDECOR	04	0400953550001		2962458	Calle Sucre Nº 45A036 y Quito	byron-narvaez@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
174	P-0188	NAVISOY REYES OSCAR ANDRES	04	0401049069001		0985369914	Antisana y Sumaco	oscarnavisoy@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
175	P-0189	NAZATE VILLARREAL RODRIGO ANTONIO	04	0400185310001		0622224709	Calle Antisana s/n y Zumaco	rodriantonazate@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
176	P-0190	NOGUERA MARTINEZ ROMEL JESUS 	04	0400577060001		0993958112	Calle Manuel Pólit y Julio Matovelle	romeljesusnoguera@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
177	P-0191	NOVACERO S.A.	04	0590038601001		022974163	Calle J Nº S60-87 y Calle Tercera	paredesp@novacero.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
178	P-0192	OBANDO MUÑOZ OSCAR MANUEL	04	0400652640001		062280317	Eugenio Espejo 917 y Leopoldo Chávez	sikomira@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
179	P-0194	ORTEGA CADENA SEGUNDO CARLOS	04	0400424024001		062983117	Juan José Flores S/N y Ayacucho	carlos1954ortega@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
180	P-0195	ORTIZ POZO AMANDA PAOLA- MEGAREPUESTOS	04	0400979878001		2983622	Av. Veintimilla y Pasaje Cenepa	paointercambio@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
181	P-0196	ORTIZ TARAMUEL HENRRY RAMIRO	04	0401156096001		0985184694	Calle Juan José Flores y Vía a Chapues	ramiroortiz1974@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
182	P-0197	PABON MIER ARACELY PAOLA - PROVEEDORA DE	04	1002786778001		2600592	Av. Cristobal de Troya Pasaje Heleodoro 	megarepuestos88@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
183	P-0198	PAGUAY ALPALA NESTOR FERNANDO	04	0401468707001		0986769178	Cerro Azul y Pasaje Zeus	paguaynestor@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
184	P-0199	PANAMERICANA VIAL S.A. PANAVIAL	04	1791317025001		3982500	Panamericana Norte	serviciocliente@panavial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
185	P-0200	PANTOJA GUAMÁ WILSON BAYARDO	04	0400617668001		0986440567	Rafael Arellano y Capitán Castillo	bayardo.pantoja@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
186	P-0202	PASPUEL PUETATE LIBARDO	04	1710259068001		0939935329	Calle 11 de Abril y Rocafuerte	libardopaspuel29@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
187	P-0203	PERGUEZA PUETATE HÉCTOR RAMIRO	04	0400642310001		0997721463	Av. Tulcanaza y Espejo	santiagopergueza93@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
188	P-0204	PETROWORLD S.A.	04	1791280792001		2960077	Av. República 1530 E Inglaterra	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
189	P-0205	PLASTILIMPIO S.A.	04	1792092108001		0987472673	Vicente Duque N77-433 y Juan Selis	prosania@plastilimpio.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
190	P-0206	PORTILLA MARCO ANTONIO	04	0400658118001		0991119337	Ciudadela Nuevo Tulcán, calle Dos Nº 18	portilla_marco@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
191	P-0207	POZO AYALA JOSE LUIS	04	0401432539001		0983694617	Sangay y Antisana	luisyunior3652@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
192	P-0208	POZO TARUPI MARCELO JAVIER	04	0400896973001		2961-092	Av. Veintimilla s/n y México	marcelopozo71@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
193	P-0209	PRINTEC - HIDALGO VASCONEZ RICHARD	04	1702536077001		022263977	El Batán Portugal 620 y 6 de Diciembre	printecuador@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
194	P-0210	PROAÑO JIMENEZ EDMUNDO DANTES	04	0400749321001		2988254	Olímpica Nº 37 	edmundoproaño@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
195	P-0211	PULLES JACOME IVAN VLADIMIR	04			\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
196	P-0212	PULLES JACOME LEONOR ELIZABETH	04			\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
197	P-0213	PULLES MINA LEONARDO JAVIER	05		0401480447	\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
198	P-0214	QUELAL NEJER HECTOR MARCIAL	04	0400867420001		2960807	Av. Expreso Oriental s/n y Andrés Bello	vulcanizadoraquelal@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
199	P-0215	QUIMIEM CIA. LTDA.	04	1791253728001		022461-500	Ignacio San María E3-30 y Juan González	info@quimiem.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
200	P-0216	QUIMPAC ECUADOR S.A.	04	0990344760001		2691-477	Panamericana Sur Km.14 s/n y Guajalo	mvelastegui@quimpac.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
201	P-0218	RADFANTASTICA S.A.	04	0491518383001		0999194175	Bolívar y Junín	mreina@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
202	P-0219	SERVICIOS DE RADIODIFUSION ALMEIDA & BENITEZ S.A	04	0491514442001		2981928	Olmedo y Ayacucho 	radiotulcan@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
203	P-0220	RAMÍREZ BENAVIDES JOHANA - TECNOMAQUINAR	04	0401633847001		2960077	Colón y 9 de Octubre	b13m232000@yahoo.com	1	2100034169	\N	0	0	0	1	74	1	1	2020-01-21	\N	\N	0
204	P-0221	REASCOS AGUILAR AMAYRA ELIZABETH	04	1002101655001		0984151837	Bolívar y Tarqui	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
205	P-0222	REASCOS ERAZO JORGE ARMANDO	04	0401276761001		0988937379	Calle Boívar s/n y Panamá	jorgearmandoreascoserazo@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
206	P-0223	REINA LLORENTE SEGUNDO FABIAN -TECNIMETA	04	0400661088001		0991680936	Juan de Velasco s/n y Av. Veintimilla	fabianreinall@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
207	P-0224	REINEC C. LTDA.	04	0992222905001		0987292293	Av. Rodrigo Chávez s/n y Av. Juan T.	info@ecuapagos.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
208	P-0225	REMACHADORA DE ZAPATAS SUPER BRAKE	04	0400776092001		2983520	Cdla. del Chofer Calle Juan Ramón Arella	carlosalmeida67@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
209	P-0226	REVELO ROSERO HUGO RAMIRO	04	0401303086001		2982-339	Bolívar 1051 y Tarqui	autronicautos@gmail.com	1	0029802270	\N	0	0	0	1	15	1	1	2020-01-21	\N	\N	0
210	P-0227	REYES TARAPUES ROBERTO FERNANDO	04	0401208665001		0997486662	Calle Boyacá S/N y Juan José Flores	robertoreyes662@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
211	P-0228	RIANDI CIA.LTDA.	04	1791035828001		0999100010	Inés Gangotena y Chillanes - Sangolquí	ventasriandi@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
212	P-0229	RIOFRIO BRAVO VICENTE FRANCISCO	04	1709350332001		2983882	10 de Agosto 51 A 009 y Gran Colombia	vicenteriofrio@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
213	P-0230	RODRIGUEZ HUERTAS JULIO HOMERO	04	0400593430001		2981-947	Río Amazonas s/n y Pasaje Cenepa	julio_rodriguez1959@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
214	P-0231	RODRIGUEZ YAR JOSE LUIS - MACROGLASS	04	0400983052001		0987048553	Av. Calderón y Panamá	luisrodriguez222@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
215	P-0232	ROMO LANDAZURI MARÍA JOSE	04	0401050505001		2981-464	Av. Centenario s/n Juan Ramón Arellano	tecnicentroromot@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
216	P-0233	ROSALES ROSERO MIRIAM ESTHER 	04	0400939484001		2984723	26 de Mayo y Av. 24 de Mayo	richardcer61@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
217	P-0234	ROSERO ENRÍQUEZ SEGUNDO GUILLERMO	04	0400356663001		0958645507	General Landázuri y José María Urbina	guillermoroseroenriquez@outlook.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
218	P-0235	ROSERO MALES CARMEN DEL ROCIO 	04	0401045554001		0989120199	10 de Agosto y Colón	carmenroserom174@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
219	P-0236	ROSERO POZO JUAN CARLOS	04	0401177522001		0987148191	Sucre y Pichincha	juan.rosero91@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
220	P-0237	ROSERO POZO TERESA CECILIA	04	0400679742001		2983708	Av. Coral s/n y Chile	lubricadorabarcelona@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
221	P-0238	RUEDA AGUILAR PATRICIA MANUELA	04	1706910047001		0998507316	Urb. Club Los Chillos Fucsias 144 y Av.	aguayriego@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
222	P-0239	RUEDA SALAZAR CARLOS VLADIMIR	04	0400415204001		2985-074	Centro Bolívar s/n y Junín	carlosvladimirrueda@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
223	P-0240	RUIZ PULE ARNULFO JOSELITO - AUTOLLANTAS	04	0400820700001		2242221	Av. Brasil s/n frente al Aeropuerto	joselo-ruiz@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
224	P-0241	SACOSGALLARDO CIA. LTDA.	04	1792227577001		022573520	Rocafuerte OE6-190 e Imbabura	facturacionsacosgallardo@gmail.som	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
225	P-0242	SALAZAR BOSMEDIANO ALEX RAMIRO	04	1718338443001		0983298341	Av. Mantilla s/n y García Moreno	alexsabo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
226	P-0243	SALAZAR HUERTAS NELSON RODOLFO	04	0401370788001		0987621001	Bolívar s/n y Ayacucho	newsystem09@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
227	P-0244	SALAZAR PORTILLA YAJAIRA - DISTRIFORROS	04	0401556246001		0985659933	Manabí s/n entre Paraguay y Uruguay	yaja9-@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
228	P-0245	SBSMORRIGAN S.A.	04	1792533953001		2433478	Inglaterra E3-106 y Av. República	info@sbsconsulting.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
229	P-0246	SERVICIO ECUATORIANO NORMALIZACION  INEN	04	1768046530001		2501885	Baquerizo Moreno E8-29 y Av. 6 de Diciem	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
230	P-0247	SERVIENTREGA	04	0991285679001		2960021	Av. Rafael Arellano s/n y García Moreno	kerly.rendon@servientrega.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
231	P-0248	SUAREZ MAZAMBA MERCEDES ALEXANDRA 	04	1310045578001		0959176260	Av. Veintimilla y Rafael Arellano	emiliach65@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
232	P-0249	SUPER ESTACION DEL VALLE - HERNANDEZ JOS	04	1001973070001		062673120	Comunidad El Juncal Panamericana Norte	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
233	P-0250	SUPERCENTRO FERRETERO KYWI	04	1790041220001		062598101	Av. Seminario y Av. Andrés Bello	andres.calderon@kywi.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
234	P-0251	SUQUILLO ANDRANGO MARCO VINICIO	04	1710201102001		2333920	Amaguaña Sincholagua S13-55	ms.distribuidores@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
235	P-0252	TALLER DEL COLOR- SOCIEDAD CIVIL ANONIMA	04	0491523298001		062250680	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
236	P-0253	TARUPI ROMAN JAVIER ARMANDO	04	0401287354001		0999570991	Av. Veintimilla y Portugal	ferreteriaconstructor002@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
237	P-0254	TECHNET	04	0400919866001		2987-145	Pichincha N544 y Bolívar	facturacion.electronica@grupotechnet.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
238	P-0255	TERÁN CALDERON ROSITA ADELA 	04	1711932549001		062963071	Av. 24 de Mayo Barrio Ejido Norte	mjrt0399@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
239	P-0256	TEVCOL CIA. LTDA.	04	1790023885001		2599509	La Concepción, Av. La Prensa 3558	facturacion.recepta@tevcol.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
240	P-0257	TRACTO MANGUERAS CHILIQUINGA OÑATE IRMA	04	0400966859001		2985681	Cristo Rey Av. Veintimilla y Portugal	tractomangueras@gmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
241	P-0259	URDIALES & PAZMIÑO CONSULTORES	04	1792476410001		022266843	Pedro Bedón OE3-42 y Antonio de Ulloa	purdialesg@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
242	P-0260	VACA PORTILLA EDISON MAURICIO 	04	0401148465001		2982724	Calle 10 de Agosto entre Rafael Arellano	imprentaeditar12@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
243	P-0261	VALENCIA BURBANO JANETH ALEXANDRA	04	1002863585001		0985147975	Av. Atahualpa 19-65 	alexa.valenciab@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
244	P-0262	VALENCIA LÓPEZ ROSA MARGARITA	04	1705399093001		062981475	CALLE ATAHUALPA 6079 Y BOLÍVAR	mvalencia.cpk@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
245	P-0263	VALLEJO YEPEZ NELSON GERMAN	04	0400667184001		2961744	Cdla. San Carlos, Calle Medardo Angel S.	nelsovalle.14@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
246	P-0264	VASQUEZ REINO EDGAR - DICOMSA	04	0301536090001		0999248691	Jardines de Turubamba S60 26-83 y Calle	dicomsa_ecuador@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
247	P-0265	VELASCO ROSERO EDGAR SIXTO	04	0400787008001		0997375770	Centro Tarqui s/n y Sucre	edgarintegracion@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
248	P-0266	TELLO ARTEAGA VICTOR HUGO- SERVICIOS Y COMERCIO	04	1700505835001		6003569	Agustín Guerrero S/N y Japón	vtserviciosycomercio@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
249	P-0267	VILLA VILLA JORGE GUSTAVO	04	0600927784001		097800500	Av. Veintimilla s/n y 24 de Mayo	jorge_gvv@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
250	P-0268	VILLAGOMEZ BUENAÑO SONIA MARLENE	04	0400769006001		0994278536	Bolívar y Pasaje Riobamba	sonivilla_04@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
251	P-0269	VILLOTA ACOSTA ELEN MERCEDES - EVA CLEAN	04	1719766808001		022080900	Urb. Club Los Chillos, Madroños Casa 2	evacleanfacturacion@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
252	P-0270	VIVEROS ENRIQUEZ SEGUNDO VICTORIANO	04	0400572012001		2986-468	Maldonado y Machala	segundoviveros@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
253	P-0272	VULCANIZADORA VICENTICO 	04	0401553698001		0939653263	Oriente y Río Cenepa	luisviccosta@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
254	P-0273	YAMBAY VALLEJO HECTOR VLADIMIR	04	0401126867001		2960605	Roberto Sierra y Cuenca	hectyam82@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
255	P-0274	ZAMBRANO BAZURTO JUAN PABLO	04	1722516513001		0988940246	Calle Guillermo Wickman OE1-649 y A.	info@reyrey.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
256	I-0001	Banco Central del Ecuador	04	1760002600001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
257	I-0002	Banco del Austro	04	0190055965001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
258	I-0003	JUNTA AGUA POTABLE MALDONADO	04	0491534453001		\N	Maldonado	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
259	I-0004	CONSEJO DE LA JUDICATURA CARCHI	04	0460016800001		062999300	Rafael Arellano 9-015 y Panamá	Karolina.Prado@funcionjudicial.gob.ec	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
260	I-0005	CONTRALORÍA GENERAL DEL ESTADO	04	1760002360001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
261	I-0006	CUERPO DE BOMBEROS DE TULCAN	04	0460010360001		2960077	Av. Manabí s/n y Argentina	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
262	I-0008	DIRECCION GENERAL DE REGISTRO CIVIL	04	1768049390001		063814290	Av. Amazonas 1014 y Av. Naciones Unidas	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
263	I-0009	EPMAPA-T	04	0460028810001		2980-487	Juan Ramón Arellano y Bolívar	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
264	I-0010	GAD PQ RURAL URBINA	04	0460021050001		\N	Urbina	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
265	T-0006	Almeida Ruano Carlos Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
266	I-0011	GAD PQ. RURAL SANTA MARTHA DE CUBA	04	0460022370001		062967112	Santa Martha de Cuba	jpsmc01@gmail.com	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
267	I-0012	GAD PR de Maldonado	04	0460024660001			Maldonado		1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
268	I-0013	GAD MUNICIPAL DE TULCÁN	04	0460000210001		2980-400	Olmedo y 10 de Agosto	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
269	I-0014	JUNTA ADMINIS. AGUA POTABLE TUFIÑO	04	0491518782001		062222061	Barrio Vicente Ponce,Calle Gran Colombia	paito.puetate123@hotmail.com	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
270	I-0015	Servicio de Rentas Internas SRI	04	1760013210001		02298307	Av. Amazonas y Unión  Nacional  de Periodistas	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
271	E-0001	Aguilar Montenegro Wilmer Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
272	E-0003	Anticipos de Sueldos	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
273	E-0004	Asocia. AFEEPMAPA-T	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
274	E-0005	Asociación de Empleados GMT	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
275	E-0006	Bolaños Cadena Ximena Magaly	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
276	E-0008	SKLDFJWEÓP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
277	E-0009	Cárdenas Hermosa  Jefferson	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
278	E-0010	Castro Benavides Luis Humberto	05		0400800876	\N	JUAN RAMON ARELLANO Y BOLIVAR	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
279	E-0011	Cevallos Castillo Santiago Libardo	05		0401576822	062960077	Tulcán	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
280	E-0012	KDÑVGHDFÑ	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
281	E-0013	Chávez Endara Andrea Elizabeth	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
282	E-0015	Chugá Chávez Emilia del Socorro	04		0400709960	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
283	E-0017	L,AQ	04			2985-736	Bolívar s/n y Junín	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
284	E-0018	NBFGM, 	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
285	E-0019	MNMBV	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
286	E-0020	Farmacia Municipal Tulcán	04	0460035510001		2980-400	10 de Agosto s/n y Olmedo	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
287	E-0021	JOPOPHIO	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
288	E-0024	Higuera Rosero Milton Wladimir	04	0400999686001		0986043808	Los Cipres y Los Alamos Barrio El Bosque	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
289	E-0027	IESS	04	0460026440001		\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
290	E-0029	Póliza de Fidelidad	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	1
291	E-0030	Mercado Municipal (Comisariato)	04	0491503211001		2961089	Andrés Bello s/n  Las Tejerias	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
292	E-0031	VHI	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
293	E-0032	Mora Larrea Mónica Fernanda	05		0401377478	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
294	E-0033	Morillo Vacas Saida Gabriela	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
295	E-0034	Multas Personal EPMAPA-T	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
296	E-0035	Narváez Caicedo Nelson Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
297	E-0036	Narváez Martínez Martha América	05		0400968269	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
298	E-0037	Narváez Nazate Johana Gabriela	05		0401579958	\N	Tulcán	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
299	E-0040	Obando Sánchez Jackson Guillermo	05		0400871919	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
300	E-0041	OPG	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
301	E-0042	Ortega Estacio Amparo de Lourdes	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
302	E-0043	Ortega Montenegro Nuby Liliana	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
303	E-0044	Chávez Concha Juan Carlos	05		1724403371				1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
304	E-0002	Patronato Municipal	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
305	E-0014	Personal Admin Financiero LOSEP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
306	E-0016	Personal Administrativo Financ CODIGO TRAB	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
307	E-0022	Personal Alcantarillado  Sane LOSEP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
308	E-0049	Perugachi Alvear Lenin Darío	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
309	E-0050	Perugachi Coral Joffre Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
310	E-0054	Puetate Pazmiño Pedro Edgardo	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
311	E-0055	Quezada Pozo Dario Javier	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
312	E-0056	Rodriguez Enríquez Nancy Lody	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
313	E-0057	Rosero Castillo Erika Tatiana	04		0401257191	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
314	E-0059	Sierra Osejos Yadira	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
315	E-0060	Sindicato EPMAPAT	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
316	E-0062	Tribunal de Menores Carchi	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
317	E-0066	Villarreal Martínez José René	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
318	T-0001	Aguilar Arboleda Jhon Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
319	T-0002	Aguilar Guerrón Luis Arturo	05		0400598363	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
320	T-0003	Almeida Reina Edwin Miguel	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
321	T-0004	Almeida Ruano Marcelo Bayardo	05		0401233861	\N	Juan Ramón Arellano y Bolívar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
322	E-0140	Almeida Ruano Edison Fernando	05		0401369665	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
323	T-0008	Arcos Perengüez Milton Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
324	T-0009	Ayala Hermosa Alvaro Mauricio	05		0401192950	\N	Juan Ramó Arellano y Bolívar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
325	T-0010	Benavides Canchala Anderson Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
326	T-0011	Benítez Tulcán Segundo Virgilio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
327	T-0012	Bernal Puetate José Alejandro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
328	T-0013	Cabezas Yanascual José Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
329	T-0014	Canacuan Tarapues José Kléver	05		0401255112	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
330	T-0015	Cando Pozo Segundo Fabián	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
331	T-0016	Cando Taquez Richard Santiago	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
332	T-0017	Cañar Viveros Luis Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
333	T-0018	Cardenas Obando Jorge Napoleon	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
334	T-0019	Chenás Paspuel Daniel Enrique	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
335	T-0020	Chenás Paspuel José Félix	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
336	T-0021	Chiles Paspuel Segundo Byron	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
337	T-0022	Chiles Ruano Luis Cirilo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
338	T-0023	Chiles Tarapués Julio César	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
339	T-0024	Chiles Villarreal Carlos Jonatan	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
340	T-0025	Chiles Yanascual Segundo Polivio 	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
341	T-0026	Chingal Ortega Ramiro Andrés	04		0401694906	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
342	T-0027	Cisneros Luis Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
343	T-0028	Cisneros Muñoz José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
344	T-0029	Coral Hernández Edmundo Vinicio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
345	T-0030	Cuases Pozo Marcelo Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
346	T-0031	Díaz Paucar Juan José	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
347	T-0032	Erazo Becerra Marlon Anibal	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
348	T-0033	Erazo Enríquez  Edison Darwin	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
349	T-0034	Yazan Reascos Carlos Orlando	05			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
350	T-0035	España Pozo Jonathan Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
351	T-0036	Estrada Reina Servio Libardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
352	T-0037	González González César Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
353	T-0039	Imbacuan Fuelagan José Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
354	T-0040	Imbacuán Malquín Segundo Salomón	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
355	T-0041	Ipial Paspuel Segundo Alirio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
356	T-0042	Lagos Arciniegas José Vicente	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
357	T-0043	Lima Calpa Jorge Hiraldo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
358	T-0044	Lima Quilismal Nixon Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
359	T-0045	López Chugá José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
360	T-0046	López Rosero José Luis	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
361	T-0047	Malte Tarapues Elsa Mariela	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
362	T-0048	Montenegro Narváez Edwin William	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
363	T-0049	Morillo Cuasquer José Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
364	T-0050	Muñoz Chávez Javier Soliz	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
365	T-0051	Narváez Salas Germán Bolívar	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
366	T-0052	Nasamuez Eche Luis Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
367	T-0053	Ortega Cuamacas Edgar Patricio	05		0401010228	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
368	T-0054	Ortega Cuamacas Iván Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
369	T-0055	Ortega Geovany Alejandro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
370	T-0056	Ortiz Pantoja Nelson Polivio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
371	T-0057	Paspuel Chiles Segundo Augusto	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
372	T-0058	Paspuel Paguay Luis Enrique	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
373	T-0059	Paspuel Paspuezán José Octaviano	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
374	T-0060	Paspuel Tarapués Daniel Alfonso	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
375	T-0061	Paspuel Tarapues Darwin Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
376	T-0062	Paspuezán Chiles Cesar Silvio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
377	T-0063	Paspuezán Malte Kevin Junior	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
378	T-0064	Paspuezán Paspuel Manuel Mesías	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
379	T-0065	Pastas Erira Byron Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
380	T-0066	Pérez Huera Ramiro Ricardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
381	T-0067	Pérez Peñate Hanoi	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
382	T-0068	Personal de Julio Andrade	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
383	T-0069	Pizanan Enriquez Nelly Esperanza	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
384	T-0070	Portilla Cuaical José Gilberto	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
385	T-0071	Pozo Guerrón Jefferson Ramón	04	1003934872		\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
386	T-0072	Puetate Guel Julio César	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
387	T-0073	Puetate Paspuezán Enrique Byron	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
388	T-0074	Reina Martínez Segundo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
389	T-0075	Reyes Díaz Franklin Rubén	04	0401224316		\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
390	T-0076	Rojas Chicango José Segundo	05		0400574620	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
391	T-0077	Rosero Chamorro Luis Abraham	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
392	T-0079	Rosero Rosero Edgar Aníbal	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
393	T-0080	Ruano López Jaime Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
394	T-0081	Tarapues Tatamues Luis Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
395	T-0082	Tatamués Chiles Segundo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
396	T-0083	Tatamues de la Cruz Javier	05		0401235296	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
397	T-0084	Tatamues Paspuezán Alvaro Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
398	T-0085	Tatamues Paspuezán Roberto Carlos	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
399	T-0086	Telag Pitacuar Juan Carlos	05		0401663513	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
400	T-0087	Trejo Viteri Jhonatan Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
401	T-0088	Tubon Escobar Luis Eduardo	05		0401017470	\N	Juan Ramon Arellano y Bolivar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
402	T-0089	Tupe Rosero Edwin Vladimir	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
403	T-0090	Valenzuela Charfuelán Bolívar	05		0400811014	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
404	T-0091	Villacorte Paucar Edwin Efrain	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
405	T-0092	Villagomez Paredes Raúl Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
406	T-0093	Yar Vela Cristian Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
407	T-0094	Yépez Benalcázar José Miguel	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
408	D-0002	LUCERO ORBE MYRIAM DEL ROCIO	04	0400825139001		2983-766	La Y Av. Manabí  70054 y Argentina	mama_myrilum@hotmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
409	D-0003	MONTENEGRO CHAMORRO VICTOR EFREN	04	0400997391001		0993256764	Calle Jerónimo Carrión y Antonio Borrero	vicefm1973@gmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
410	D-0005	VIZCAINO ESCOBAR CRISTIAN NORMAN	04	0401746391001		0996963280	23 de Mayo s/n y 2 de Noviembre	crisvizcaino89@gmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
411	G-0001	Agromundo SC	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
412	G-0002	Almeida Luis Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
413	G-0003	Alvarez Alvarez Nilo Felipe	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
414	G-0004	Alvarez Salazar Carlos Edison	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
415	G-0005	Arcos Reina Silvio Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
416	G-0006	Arellano Carranco Luis Ramiro.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
417	G-0007	Arellano Velasco Jaime Rodrigo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
418	G-0008	Artega Vilaña Jesús Homero	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
419	G-0009	Artiaga Paredes Verónica Marlene	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
420	G-0010	Ayala Matute Luz María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
421	G-0011	Bolaños López Laura María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
422	G-0012	Bolaños Yandún Luis René	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
423	G-0013	Burbano Mafla Galo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
424	G-0014	Bustillos Barragan Germán Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
425	G-0015	Cadena Ayala Ana Lidia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
426	G-0016	Cadena Mier Sandra Zulay.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
427	G-0017	Caicedo Rosero Cesar Roberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
428	G-0018	Caiño Lamar Vicenta	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
429	G-0019	Campo Flores Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
430	G-0020	Cando Enríquez Nelson Raúl.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
431	G-0021	Carpio Vega Liliana Cecilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
432	G-0022	Castillo Quiroz Dila Piedad	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
433	G-0023	Castillo Vallejo Marcia Elena	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
434	G-0024	Castro Cando Isabel Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
435	G-0025	Chamorro Reyes Omar Wilfrido	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
436	G-0026	Changuan Enríquez Lilia del Rocio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
437	G-0027	Chicango Segundo Homero	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
438	G-0028	Chisaguano Chisaguano Josefina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
439	G-0029	Chugá Coral Mónica Alexandra	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
440	G-0030	Chugá Martínez Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
441	G-0031	Cisneros García Alfredo Migue	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
442	G-0032	Compañia de Taxis Ejecutivos C.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
443	G-0033	Coop. ahorro y Cred. Educadores	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
444	G-0034	Coral Rivera Wilmer Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
445	G-0035	Coral Rosero Bernardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
446	G-0036	Coral Tapia Laureano Joel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
447	G-0037	Cordova Bertha Josefina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
448	G-0038	Cordova Pantoja Inocencio Elie	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
449	G-0039	Criollo Nazate Janneth Cecilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
450	G-0040	Cuadros Zambrano Norma Amada	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
451	G-0041	Cuaical  Iñiguez Ana Lucia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
452	G-0042	Culqui Pujos Angel Patricio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
453	G-0043	Curia de Tulcán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
454	G-0044	De La Torre Caceres Luis Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
455	G-0047	Direccion Provincial de la Judicatura	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
456	G-0048	Enríquez Enríquez María Elizabeth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
457	G-0049	Enríquez Ríos Yolanda del Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
458	G-0050	Erazo Díaz Digna del Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
459	G-0051	Erazo López Byron Javier.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
460	G-0052	Erazo Prado Carmelina Garista	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
461	G-0053	Estupiñan Jimenez Elina Magali	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
462	G-0054	Fernandez Lamar Pedro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
463	G-0055	Figueroa Enríquez Franklin Sigifredo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
464	G-0056	Flores Cuasatar Jorge Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
465	G-0057	Fuel Checa Rodrigo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
466	G-0058	Fuel Gómez Milton Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
467	G-0059	Gaón Pozo Fidelia OTilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
468	G-0060	Gonzáles Escobar Nora Catalina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
469	G-0061	Guacales Carvajal Edison Darwin	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
470	G-0062	Guacales Efraín Aucimiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
471	G-0063	Guaraca Vimos Delia María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
472	G-0064	Guerra Paucar Olga Guadalupe	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
473	G-0065	Guerrero Enríquez Rosario Del	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
474	G-0066	Guerrero Obando Jorge Bayardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
475	G-0067	Guerrero Peñafiel Martha Nel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
476	G-0068	Guerrón Araujo Byron Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
477	G-0069	Herrera Enríquez José Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
478	G-0070	Herrera Enríquez Segundo Jor	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
479	G-0071	Herrera Martínez Jefferson Paúl	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
480	G-0072	Herrera Narváez Nancy Cristina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
481	G-0073	Huera Narváez Luis Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
482	G-0074	Hurtado Armas Jorge Aníbal	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
483	G-0075	Imbacuan Fuertes Elvia Janneth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
484	G-0076	Imbacuan Pereguez María Flora	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
485	G-0077	Imbaquingo Ortiz Luis Alfredo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
486	G-0078	Jativa Gonzalo Gerardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
487	G-0079	Landazuri Cordova Iván Oswaldo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
488	G-0080	Landázuri Rosero Yolanda Isabel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
489	G-0081	Lucero Lima Irene	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
490	G-0082	Lucero Revelo Sandra Margarita	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
491	G-0083	Mafla Majía Arquimides Patricio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
492	G-0084	Mallama Chapi José Raúl	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
493	G-0085	Manguay Puetate Alberto Olmedo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
494	G-0086	Manosalva Pineda Saúl Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
495	G-0087	Mejía Navisoy Rolando Germán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
496	G-0088	Montalvo Enríquez Blanca Ismeria	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
497	G-0089	Montenegro Gómez Mary Margoth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
498	G-0090	Montenegro Larrea Hector Olmedo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
499	G-0091	Narváez Orbe Miguel Angel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
500	G-0092	Narváez Villagomez Luis Edison	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
501	G-0093	Nazate Fuel José Daniel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
502	G-0094	Nazate Paucar Mary Patricia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
503	G-0095	Olmedo Auz Danny Enríque	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
504	G-0096	Orbe Cadena Olmedo Gustavo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
505	G-0097	Ortega Chamorro Ana Paola|	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
506	G-0098	Ortega Pedro Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
507	G-0099	Osejo Becerra Tarcicio Renán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
508	G-0100	Palate Criolla Víctor Hugo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
509	G-0101	Pintado Mora Alex Manolo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
510	G-0102	Ponce Benavides Enma Lucía.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
511	G-0103	Portilla Mejía Carlos Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
512	G-0104	Portilla Pozo María Romina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
513	G-0105	Pozo Enríquez Jaime Hernán.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
514	G-0106	Quistanchala Yandar Jefferson Fernando|	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
515	G-0107	Reascos Quelal Olimpo Gustavo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
516	G-0108	Revelo Ascuntar Ana Zulay	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
517	G-0109	Revelo Ayala Hermógenes Marino	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
518	G-0110	Rodríquez Huaca María Matilde	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
519	G-0111	Rosero Loor Vicente Efraín	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
520	G-0112	Rosero Morán William Bayardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
521	G-0113	Ruíz Palacios Hilda Beatriz	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
522	G-0114	Ruíz Pule Arnulfo Joselito	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
523	G-0115	Salazar Burbano Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
524	G-0116	Santillan Males Julio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
525	G-0117	Serrano Martha Lucia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
526	G-0118	Servicio Integrado de Seguridad ECU 911	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
527	G-0119	Sindicato de Choferes	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
528	G-0120	Sisa José Manuel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
529	G-0121	Tapia Reina Miguel Ángel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
530	G-0122	Tashiguano Arisa Carolina Estefanía	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
531	G-0123	Tatés Fernandez José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
532	G-0124	Tepud cuasquer Edwin Fredy	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
533	G-0125	Terán Maldonado Rosa Elena	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
534	G-0126	Tigsi Yanza Juan Vinicio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
535	G-0127	Tucanes Narváez Anayss del	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
536	G-0128	Tulcanez Tapia Carmita del Pilar	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
537	P-0445	USIÑA LOMAS JHERSSON ANDRÉS- PAPELERÍA CARCHI	04	0401437934001		0963526351	Av. Seminario y Camilo Ponce	papeleria.carchi@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
538	G-0130	Vallejo Aguirre Ramiro Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
539	G-0131	Vallejo Dorado Edwin Jhobani	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
540	G-0132	Vallejo Yépez Edwin Fabián	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
541	G-0133	Vásquez Andrade Rosalía del Pilar	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
542	G-0134	Vasquez Rodriguez Sergio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
543	G-0135	Velasquez Perugachi Francisco	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
544	G-0136	Velasquez Velasquez Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
545	G-0137	Villarreal Chamorro Diana Katarine	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
546	G-0138	Villarreal Hernández Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
547	G-0139	Vinueza Bastidas Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
548	G-0140	Zabala Rosero Judith Alicia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
549	G-0141	Zambrano Montufar Camilo Adalberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
550	E-0067	MENESES ENRIQUEZ MARITZA CRISTINA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
551	E-0068	Gudino Cadena Richard Omar	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-22	\N	\N	0
552	E-0069	Ruales Calpa Saul Armando	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-22	\N	\N	0
553	C-0001	CLIENTE FINAL	04			\N	Tulcán	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-01-22	\N	\N	1
554	T-0095	Luna Chalacan Derek Leonardo	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-01-23	\N	\N	0
555	P-0275	HUERA LOPEZ ALDRIN ROBERTO	04	1002344784001		0993760911	Av. San Francisco s/n y Uruguay	tatyroserodome@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-01-31	\N	\N	0
556	T-0096	Malte Chenas Leonardo Fabio	05		0401847603	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-03	\N	\N	0
557	T-0097	Tatamuez Paspuezan Luis Arturo	05		0400636494	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-03	\N	\N	0
558	E-0007	Personal de Agua Potable Come LOSEP	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
559	E-0023	Personal de Agua Pota y comerc CODIGO TRAB	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
560	E-0025	Personal Alcantarillado y Sanea CODIGO TRAB	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
561	E-0026	Personal de Jubilados Agua P y Alcant 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
562	P-0003	CHOGLLO SIGUENCIA MARIO FABIAN	04	0103898896001		074199040	Pasaje 24 4 y Av. 24 de Mayo	mariofchogllo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-02-14	\N	\N	0
563	T-0005	Piarpuezan Mipaz Francisco Germán	05		0401113246	\N	Juan Ramón Arellano y Bolívar	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-17	\N	\N	0
564	E-0028	mnv	05		0401193636	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-17	\N	\N	0
565	E-0038	Hernandez Villa Francis Gabriel	05		0401233259	\N	\N	vflooy@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2020-02-27	\N	\N	0
566	I-0016	GAD PROVINCIAL DEL CARCHI	04	0460000130001		062980302	10 de Agosto y Sucre 	info@carchi.gob.ec	\N	\N	\N	0	0	0	3	1	1	1	2020-02-27	\N	\N	0
567	P-0008	CELTEL CONSTRUCCIONES Y SERVICIOS CIA. LTDA.	04	1791826698001		022279410	Luis Coloma N44-196 y Av. El Inca	pagos@celtelecuador.com	\N	\N	\N	0	0	0	1	1	1	1	2020-02-27	\N	\N	0
568	E-0070	Robles Yèpez Paola	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-28	\N	\N	0
569	C-0002	PAVON PORTILLA CARMITA DEL ROCIO	05		0400640124	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-03-05	\N	\N	0
570	P-0276	PILATASIG GERMAN NELSON MODESTO	04	0501695654001		0985812292	OTAVALO ECUADOR	german.pilatasig@hotmail.com	2	2202171729	\N	0	0	0	1	74	1	1	2020-03-09	\N	\N	0
571	P-0277	SEGOVIA MAYA RIBADENEIRA SEMAYARI CIA LTDA.	04	0590031801001		0999735498	Av. Eloy Alfaro 24-74 y Av. 5 de Junio	facturacion@semayari.com	1	3140462604	\N	0	0	0	1	74	1	1	2020-03-09	\N	\N	0
572	P-0278	COMERCIOS Y AFINES DEL NORTE COYANOR S.A	04	1091720821001		062957404	Panamericana Norte Km 1	coyanor.electronica@gmail.com	1	0018231190	\N	0	0	0	1	15	1	1	2020-03-10	\N	\N	0
573	T-0098	CHENAS PASPUEL SEGUNDO OLMEDO 	05		0400935698	\N	TUFIÑO	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-03-10	\N	\N	0
574	T-0099	Orbe Miguel Angel	05		0400485272	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-03-11	\N	\N	0
575	P-0279	INFINITY FM RADIO RADINFINTY S.A -RADIO AMERICA	04	1792483700001		062984411	Olmedo S/N y Ayacucho	radioamerica89.7mhz@americaestereo.com	1	7944241	\N	0	0	0	1	1	1	1	2020-03-12	\N	\N	0
576	P-0280	CENTRO AUTOMOTRIZ GUSTAVO MOYA BACA CIA LTDA	04	1790029131001		022236246	Queseras del Medio E11-123	pramirez@moyabaca.com.ec	1	3019761704	\N	0	0	0	1	74	1	1	2020-03-12	\N	\N	0
577	P-0281	Alvear Guerrero Angela Gabriela	04	0401638903001		2960951	Panamá y Manabí 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-03-13	\N	\N	0
578	E-0039	Pozo Castillo Livia Amparo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-03-17	\N	\N	0
579	P-0282	MORENO VILLARREAL JIMMY BAYARDO	04	0401356589001		0995951836	Tarqui s/n y Sucre	mvjmv@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-04-21	\N	\N	0
580	P-0283	Imbaquingo Andrade Carlos Amilio 	04	0400936704001		0994585380	Av. Vicentenario y Juan Ramón Arellano	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-04-28	\N	\N	0
581	P-0284	ALTO VOLTAJE	04	1002534855001		065000745	Sanchez y Cifuentes 15-27 y Zenon Villacis	altovoltajeibarra@hotmail.com	1	1002534855	\N	0	0	0	1	6	1	1	2020-05-12	\N	\N	0
582	P-0285	LUCERO LUCERO EDISON RAMIRO	04	0400747655001		062242112	Barrio el Rosal Av. Brasil	ramiroautentico@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-05-28	\N	\N	0
583	P-0286	RAMIREZ FLORES NEURIO EUTIMIO	04	0400142006001		2637202	Garcia Moreno 7-33 y Julio Andrade	cantera.ramirez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-06-04	\N	\N	0
584	E-0072	GHUGA HERRERA BRAYAN ANDRES	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-06-05	\N	\N	0
585	E-0073	CHUGA HERRERA BRAYAN ANDRES	05		0401542261	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-06-05	\N	\N	0
586	P-0287	GUAMINGA TACO KATHERINE YESENIA	04	1722126826001		0997349456	Pasaje A lote 10 y de los Rieles 	gygsuministros@outlook.es	\N	\N	\N	0	0	0	1	1	1	1	2020-06-11	\N	\N	0
587	P-0288	CAZARES MORALES ROBINSON SEBASTIAN	04	1004000152001		0980237920	Calle Ibarra 7-51 y Santa Isabel	robsoncaz1998@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-07-08	\N	\N	0
588	C-0003	MEJIA TAPIA KARLA MISHELLE-IMÁGEN GLOBAL	04	1723475073001		0995119929	Avda. Veintimilla y Portugal 	kamis1988@hotmail.com	2	2202449916	\N	0	0	0	2	74	1	1	2020-08-04	\N	\N	0
589	C-0004	CISNEROS GUERRÓN MAURICIO JAVIER	04	0400945325001		0988863232	Avda. Coral y Brasil	maodl07@hotmail.com	1	0029806233	\N	0	0	0	2	15	1	1	2020-08-05	\N	\N	0
590	C-0005	FERRICONSTRUCTOR- CANO MONTENEGRO ANDREA	04	0401580733001		0999069591	CALLE ARGENTINA Y CUENCA 	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-08-11	\N	\N	0
591	E-0074	PUETATE PASPUEZAN LUIS ORLANDO	05		0400666319	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-08-14	\N	\N	0
592	C-0006	TORNIPERNO- ROCIO DEL CARMEN GARCÍA PRADO 	04	0400604930001		062981852	Bolívar y Rocafuerte 	torniperno.info@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2020-08-19	\N	\N	0
593	E-0075	RUANO PUETATE CESAR ANTONIO 	05		0400694238	\N	\N	cesaruano1965@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2020-08-25	\N	\N	0
594	P-0290	MEJIA PEÑAFIEL CECILIA  JULIA 	04	0400561213001		2250690	9 DE OCTUBRE Y RAFAEL ARELLANO 	tallerdelcolor@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-04	\N	\N	0
595	P-0291	VALDIVIESO REINOSO WALKER BOLIVAR 	04	0400428793001		0992856179	Atahualpa 56076 y Bolivar 	andres83narvaez@hotmail.com	1	3112893604	\N	0	0	0	1	74	1	1	2020-09-09	\N	\N	0
596	E-0076	OBANDO MOSQUERA DANIEL ALEJANDRO	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-09-17	\N	\N	0
597	I-0017	BANCO DE DESARROLLO DEL ECUADOR 	04			\N	QUITO 	\N	1	\N	\N	0	0	0	3	1	1	1	2020-09-22	\N	\N	0
598	E-0077	TIPAZ LÓPEZ GALO ANÍBAL	05		0400699500	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-09-23	\N	\N	0
599	P-0292	GRANDA CUENCA BYRON FERNANDO 	04	1718181553001		2396259	Reino de Quito s/n y Catequilla	byron_475@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-28	\N	\N	0
600	P-0293	FUNDIRECICLAR  S.A	04	1791741897001		2825085	Calle 25 de Noviembre N4-363 Y Calle 1	fchavez@ceimec.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-09-28	\N	\N	0
601	E-0117	ROSA ELENA BENAVIDES BELALCÁZAR	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-24	\N	\N	0
602	P-0294	VERONICA VERENICE CAMPOVERDE TULCAN 	04	1712125416001		0986308859	JOSE LOPEZ S N Y MEJIA 	veronica.verenice@hotmail.com	5		\N	0	0	0	1	1	1	1	2020-09-29	\N	\N	0
603	P-0295	NARVAEZ LOPEZ BYRON HORACIO 	04	0400784161001		0962809313	AV. UNIVERSITARIA 25 Y AV. VEINTIMILLA	byronarlop@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-29	\N	\N	0
604	P-0296	MORENO VILLARREAL NATHALY ROSARIO 	04	0401636030001		0990242012	Quito y Olmedo Tulcán	nathymoreno@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-16	\N	\N	0
605	P-0297	CONFECCIONES CRISMA SPORT	04	0401199377001		0986621501	Olmedo 47-052 y 9 de Octubre	franklin.gustavo.yambay.@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-16	\N	\N	0
606	P-0298	CENTRO DE REPUESTOS JAPONES 	04	0400723490001		062982667	Bolivar s/n entre Rocafuerte y Pichincha 	crburbano@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-20	\N	\N	0
607	E-0078	Flores Vinueza Silvia Janeth 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-10-23	\N	\N	0
608	P-0299	PORTILLA MUEPAZ NELSON BLADIMIRO 	04	0401290531001		0997584350	Calle Colon s/n y Pichincha 	nelson.portilla@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
609	P-0300	PATY JANET 	04	0400635637001		0981338188	Barrio Centro Calle Bolivar 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
610	P-0301	BAZAR MERICITA 	04	0400685525001		0991512541	Boyaca 73 y Bolivar 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
611	P-0302	GOLDEN PUBLICITY	04	0401419924001		0987370604	AV. Veintimilla  y México	jhony_jf@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-11-11	\N	\N	0
612	P-0303	AGROAVILAB S.A 	04	0992716029001		3902603	Durán Km3.5 via Durán Tambo 	facturaelectronicaagroavilab@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-19	\N	\N	0
613	P-0304	ANDRES RAFAEL SOSA	04	1722432265001		023199028	CALLE R1 LT 18 Y CALLE R2 	netoyage96@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-26	\N	\N	0
614	E-0045	Goyes Puetate Clemente Bayardo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-12-01	\N	\N	0
615	E-0080	Yohanna Cadena 	05			222206977	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-12-02	\N	\N	0
616	P-0305	GARCÍA PUEDMAG CARMEN LILIANA 	04	0401595996001		0982826708	Roberto Andrade 22 y Carlos Oña 	gliliana014@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-03	\N	\N	0
617	P-0306	MARTINEZ POZO LUIS RAMIRO 	04	0400632592001		062290833	Bario Jardin del Norte calle Fraylejones y los Cei	ramisand@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-12-11	\N	\N	0
618	P-0307	YUNGA VILLA ALFONSO MARIA 	04	0101055762001		0987555942	Villlalobos SN y Panamericana sur 	contabilidad@pantanero.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-14	\N	\N	0
619	P-0308	BURI CARAGUAY VICTOR EMILIO	04	1708525678001		022075466	PONCE ENRIQUEZ LOTE 1 Y GARCIA MORENO 	contabilidad@kleiner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
620	P-0309	ASTAP CIA LTDA.	04	1790027740001		022262154	Av. Naciones Unidas 1084 y Av. Amazonas 	ariday1209@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
621	P-0310	CONSTRUCPIEDRA  CONSTRUCTORES	04	1791298594001		022554579	La niña E4-438 Y AMAZONAS	contabilidad@construpiedra.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
622	P-0311	NARVAEZ TERREROS BLANCA NOEMI (SINAMERT) 	04	0102664760001		2802994	Jaime Roldos 4-22 y Huayna - Capac 	sinaseg1@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
623	P-0312	UNION CEMENTERA NACIONAL UCEM S A	04	1792470293001		032998800	Panamericana Sur Km 14	pcarvajal@ucem.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-16	\N	\N	0
624	P-0313	LAGUNA RODRIGUEZ ESTEPHANY DAYANNA	04	0401505821001		0985597300	Juan Montalvo y 19 de Noviembre	estedayslag@live.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-16	\N	\N	0
625	P-0314	SANCHEZ VENEGAS GEOVANY SERAFIN 	04	1002440822001		062933331	Simón Bolívar 4-57 Tanguarín 	geovanyssanchez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-21	\N	\N	0
626	E-0081	AROCA RIVADENEIRA LUIS ANDRÉS 	04			\N	\N	andruaroca@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2021-01-19	\N	\N	0
627	T-0100	PUETATE PASPUEZAN JOSE PEDRO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-19	\N	\N	0
628	T-0101	CHILES YANASCUAL GERMÁN 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-19	\N	\N	0
629	P-0315	NARVÁEZ JARAMILLO EDELER FRANCISCO 	04	0401147327001		\N	EL carmelo 	\N	\N	\N	\N	0	0	0	1	1	1	1	2021-01-21	\N	\N	0
630	P-0316	MINISTERIO DE TRANSPORTE  OBRAS PÚBLICAS DEL CARCHI 	04	0460012570001		062980482	AV. Veintimilla frente Comercial Hidrobo	\N	1	3001041703	\N	0	0	0	1	71	1	1	2021-01-22	\N	\N	0
631	E-0082	PUETATE CAIPE ERIKA PAOLA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-27	\N	\N	0
632	E-0083	DELGADO MONTENEGRO NORALBA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-27	\N	\N	0
633	P-0317	HORMIGONES  DEL NORTE S.C.C	04	1792811082001		062511739	Calle Los Galeanos No. 328	anaga_54@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-01-28	\N	\N	0
634	E-0084	Bolaños Ipial Ana Magali	05		0401470927	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-28	\N	\N	0
635	T-0102	Cadena Arcos Henry Javier	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-28	\N	\N	0
636	P-0318	Rodriguez Rosero Narciza Germania	04	0401107206001		062982035	Sucre y Tarqui	aguilaimportacionestulcan@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-01-28	\N	\N	0
637	T-0103	Naranjo Tulcanaza Segundo Edmundo	05		0400831715	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-29	\N	\N	0
638	P-0319	Ibarra Cárdenas Zaidy Susana	04	0401340062001		0997010493	Av. Coral 62091 y Paraguay	zaidyibarra77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-01	\N	\N	0
639	P-0320	TALLER FERRO MADERA TACAN TUCANEZ ANIBAL	04	0400664454001		062245152	La Libertad 12 y la Concordia	anibal02051956@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-01	\N	\N	0
640	P-0321	MAFLA MARTINEZ ALEXANDRA PATRICIA 	04	0401545314001		0983435319	Guillermo Burbano 10y cabo Minacho	alexpmaflam@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-02	\N	\N	0
641	P-0322	BAGANT ECUATORIANA CIA LTDA	04	1790322491001		0986106580	Av Alfonso Moncayo y Panamericana Norte	machucaj@bagant.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-03	\N	\N	0
642	T-0104	Fuel Tulcanaza Alvaro Mauricio	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-02-05	\N	\N	0
643	P-0323	HIDROCENTRO CIA.LTDA  	04	1791248147001		2336166	Troncal E 35 Sin Transversal 	contabilidad@hidrocentro.net	\N	\N	\N	0	0	0	1	1	1	1	2021-02-08	\N	\N	0
644	P-0324	PASPUEL BASTIDAS LUIS ALBERTO 	04	0400646865001		022021588	14-15 y Av. Atahualpa 	lapaspuel@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-10	\N	\N	0
645	P-0325	SANIGROUP	04	2390014891001		09993373761	Matriz KM 3 via a Quito 	contabilidadsanigroup@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
646	P-0326	MEDINA ABRIL VANESSA MISHELL	04	1803190014001		0998597196	Ambato - Ecuador 	medina.industrias@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
647	P-0327	TARUPÍ ROSERO JUAN CARLOS 	04	0401333117001		0988708407	Av. Tulcanaza y Portugal 	juanca_14@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
648	P-0328	NORTVISIÓN 	04	0400731345001		062981387	Guayaquil 9034 y Manabí 	anaidgm@live.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-08	\N	\N	0
649	P-0329	REYES MUILEMA CARLOS ARTURO - AUTOMASIS	04	1712051760001		0996136564	Calle Alfredo Baquerizo Moreno y Pablo Palacio 	automasis@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-03-15	\N	\N	0
650	P-0330	BIOTOWER S.A 	04	1793028020001		0989763341	Pichincha Quito la Concepción 	facturas@biotower.net	\N	\N	\N	0	0	0	1	1	1	1	2021-03-24	\N	\N	0
651	P-0331	MARTINEZ PERDOMO JAIRO FABIAN 	04	0491526696001		0962614139	Av. Manabi y Paraguay 	produccion1factory@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-29	\N	\N	0
652	P-0332	CHANG AURIA VICTOR GUIDO 	04	0906466263001		042285163	Guayaquil Cuidadela Santa Leonor 	ceniferreecuador@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-04-14	\N	\N	0
653	I-0018	GAD Municipal San Pedro de Huaca	05			\N	Huaca 0460001020001		\N	\N	\N	0	0	0	3	1	1	1	2021-04-14	\N	\N	0
654	P-0333	ELIANA XIMENA CHAMPUTIZ ORDOÑEZ 	04	0401149026001		0987762753	Av. Universitaria y Ventimilla 	pakarinachamputiz@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-04-26	\N	\N	0
655	E-0085	ACOSTA PEREZ JEFFERSON ALEJANDRO	05		0402004410	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
656	E-0086	PAGUAY PASPUEL GABRIELA ELIZABETH	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
657	E-0087	DE LA CRUZ PAILLACHO DAMIAN ISRAEL 	05		0402004055	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
658	E-0088	GUEVARA LLORE MAURICIO SAMUEL 	05		0450176581	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
659	E-0089	LUCERO ESTRADA STALIN SEBASTIAN 	05		0402121347	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
660	E-0090	LUCERO SOLIS LUIS HUMBERTO 	05		0400990438	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
661	E-0091	LUMAÑA MORILLO MANUEL ANTONIO 	05		0400616454	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
662	E-0092	MORENO MORENO HUGO ARCESIO 	05		0401003512	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
663	E-0093	NARVAEZ MONTENEGRO EDWIN HOMERO 	05		0400698692	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
664	E-0094	PAILLACHO PEREZ JHONATAN ALEXIS 	05		0401904651	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
665	E-0095	PROAÑO CADENA JOSE LUIS 	05		0401062187	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
666	E-0096	PROAÑO JIMENEZ EDWIN MARCELO 	05		0400774535	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
667	E-0097	PROAÑO JIMENEZ JOSE LUIS 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
668	E-0098	PUETATE YAR ROBINSON ANDRES 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
669	P-0415	ROMO ARELLANO SEGUNDO VINICIO 	04	0400987814001		0997770356	Tulcán	viniromo2271@gmail.com	2	401110137525	\N	0	0	0	1	68	1	1	2021-04-28	\N	\N	0
670	E-0100	SIERRA ORTEGA JONATHAN ALEXANDER 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
671	E-0101	TATES PAILLACHO JONATHAN ISRAEL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
672	E-0102	TUNUBALA YALANDA ARCENIO VINICIO 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
673	E-0103	YAR PUETATE WILLAN ANIBAL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
674	E-0104	NARVAEZ PROAÑO EDWIN GEOVANNY	05		0401606439	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
675	E-0105	PERSONAL DEL PROYECTO DEL SISTEMA DE AGUA POTABLE JULIO ANDRADE 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
676	P-0334	FUNDIMETALES DEL NORTE LOPEZ MARTINEZ JOSE ALIRIO 	04	0401563812001		0983416844	AV. Brasil y Panama 	fundimetalesdelnorte@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-05	\N	\N	0
677	P-0335	BASTIDAS LEÓN ANTONIO ESGARDO ( MULTICARPAS COLOMBIA) 	04	1757098247001		0997373375	Av. 24 de mayo y 26 de mayo 	multicarpascolombia@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-05	\N	\N	0
678	P-0336	Almeida Villarreal Cristhian Ricardo 	04	0401456777001		2960951	Via interoceánica Sta Rosa 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-11	\N	\N	0
679	P-0337	NAVISOY REYES WILMER FERNANDO 	04	0400884755001		0986169051	Av. Universitaria y Antisana	fernandonavisoy@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-11	\N	\N	0
680	P-0338	PAUCAR ALMEIDA MONICA PAULINA -ADMON DISTRIBUCIONES	04	1713823365001		022603902	R1 LOTE 18 Y CALLE R2 	admon_distribuidores@hotmail.com	1	7536941	\N	0	0	0	1	16	1	1	2021-05-13	\N	\N	0
681	C-0007	LIMA ROJAS LOURDES GUADALUOE	05		0400453999	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2021-05-14	\N	\N	0
682	P-0339	AGROVENTAS RIEGO 	04	1792879698001		0997582673	Eloy Alfaro N30 -166 Y Av. Amazonas 	facturacion@agroventasriego.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-18	\N	\N	0
683	I-0019	GAD. PARROQUIAL RURAL PIOTER	04	0460024900001		\N	\N	\N	\N	\N	\N	0	0	0	3	1	1	1	2021-05-19	\N	\N	0
684	P-0340	TEXTIQUIM CIA. LTDA. 	04	1790824977001		022478062	VICENTE DUQUE N77-443 Y JUAN DE SELIS	prosania@textiquim.com	1	01019923247	\N	0	0	0	1	6	1	1	2021-05-26	\N	\N	0
685	P-0341	EDICIONES LEGALES EDLE SA 	04	1790924491001		022480800	Los Cipres y los Eucaliptos  	carterauio@corpmyl.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-07	\N	\N	0
686	P-0342	SEGURA BASTIDAS MARCO ANTONIO 	04	1711384451001		0997864160	Los Pinos y Giovani calles 	msegura@retgei.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-07	\N	\N	0
687	E-0106	JORGE CUMBAL 	04			\N	\N		\N	\N	\N	0	0	0	4	1	1	1	2021-06-11	\N	\N	0
688	C-0008	Cisneros Martínez Martha Guadalupe	05		0401089933	\N	Beker y Acuña San Miguel Norte	ns@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2021-06-14	\N	\N	0
689	C-0009	Cadena Quelal Geanette Arcelia	05		0400763975	2985352	Los Ceibos y Los Canelos	ns@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2021-06-14	\N	\N	0
690	P-0343	METALECTRI CIA. LTDA 	04	1792617073001		022828413	Quito calles Macana y Chasqui 	compraspublicas@metalectri.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-14	\N	\N	0
691	P-0344	EQUIPOS SUMINISTROS MANTENIMIENTO ESUMAN CIA LTDA 	04	1791122844001		0999741946	Nazcota puento Oe2-237 y av. Real Audiencia 	info@esuman.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-17	\N	\N	0
692	T-0105	TULCÁN ALMEIDA DIEGO FERNANDO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-08	\N	\N	0
693	E-0107	TULCÁN ALMEIDA JOHN JAIRO 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-07-08	\N	\N	0
694	T-0106	TULCÁN ALMEIDA LUIS ABERTO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-08	\N	\N	0
695	P-0345	PORTILLA MARTÍNEZ ARTEMIO CAMPOS 	04	0400585097001		0985584981	Calle Camilo Ponce y Santa Teresita	artemiocampos@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2021-07-13	\N	\N	0
696	E-0108	VINICIO ROLDÁN 	04	1001561453001		0999193608	Ibarra	vinicioroldan@hotmail.com	\N	\N	\N	0	0	0	4	1	1	1	2021-07-21	\N	\N	0
697	T-0107	Paguay Escobar Segundo Polibio 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-23	\N	\N	0
698	T-0108	Guel Paguay Segundo Jesus 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-23	\N	\N	0
699	E-0109	Marcillo Ramos Johanna Paola	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-07-29	\N	\N	0
700	P-0346	TRANSPORTE FUENTES LANDAZURI S.A 	04	0491513837001		2973608	Via  a Santa Marta de Cuba 	jonatani@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2021-08-04	\N	\N	0
701	E-0110	QUIMBIULCO PAILACHO ANDRÉS MEDARDO	05		0401884788	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-05	\N	\N	0
702	E-0111	ALTAMIRANO PINCHAO LEONARDO FABIO 	05		0401350269	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-05	\N	\N	0
703	E-0112	TOBAR ESPINOZA LUIS FERNANDO.	05		0400722773	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-11	\N	\N	0
704	E-0113	Oña Alquinga Edwin Rosendo 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-18	\N	\N	0
705	P-0347	SU FARMACIA INMACULADA	04	1792556309001		062962019	Av. America N31-42 Y PSJE San Gabriel  	sufarmaciainmaculada@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-08-23	\N	\N	0
706	C-0010	ERAZO BRAVO ALFONSO RENE	05		0400658027	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2021-08-30	\N	\N	0
707	P-0348	Roldan Ramirez Edwin Roberto 	04	1803843638001		0979140179	Calle Carlos Contreras 	otrebordanrez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-03	\N	\N	0
708	P-0349	Estrada Lima Yasmin Dayana 	04	0401858972001		0960239999	Panamá y Maldonado 	ydestrada1995@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-03	\N	\N	0
709	P-0350	MEMKADISH SA 	04	1792324556001		0997777663	Pedro Moncayo 2-67 y Pedro Vicente Maldonado 	dres@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-08	\N	\N	0
710	P-0351	ASIMBAYA NASIMBA JOHANNA TATIANA 	04	1712677218001		0995762807	Valle Hermoso, Autopista los Chillos 	jotasim01@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-09	\N	\N	0
711	P-0352	GUERRA CRUZ DIANA ALEXANDRA 	04	1721714424001		022835892	Antonio Astudillo y Pedro Bedon 	facturacioninsudagc@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-16	\N	\N	0
712	P-0353	ENRIQUEZ BUSTOS GRACE ALEJANDRA 	04	0401007646001		0996828499	Boyaca y Bolivar 	grace.1316@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-22	\N	\N	0
713	T-0109	SOFIA PILLAJO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-09-22	\N	\N	0
714	P-0354	KAM ALBAM JHONNY MARCO 	04	1002815494001		0987978881	Mira Panamericana y Portada 	kam.jalban@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-23	\N	\N	0
715	P-0355	ERAZO WILSON FERNANDO 	04	1002052627001		0994418843	Imbabura Antonio Ante Atuntaqui 	wilsonfernando_erazo@yahoo.com	2	1039750981	\N	0	0	0	1	16	1	1	2021-10-07	\N	\N	0
716	P-0356	IMPORFACTORY 	04	1792385512001		022080900	Sangolqui Av. General Enriquez 	asistente@imporfactory.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2021-10-11	\N	\N	0
717	P-0357	INSTRUMENTAL Y OPTICA REPRESENTACIONES MIGUEL PAZMIÑO CIA LTDA 	04	1790868044001		022554120	Quito, Av. Colón OE1 -100 Y Av. 10 de Agosto 	facturacion@instyopt.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-12	\N	\N	0
718	E-0114	PIARPUEZÁN MORÁN BRAYAN STIVEN 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-10-14	\N	\N	0
719	P-0358	ESPINOZA SEPÚLVEDA LUIS EDGAR 	04	1723494546001		0984250363	Tulcán Ecuador 	spinosaropadeportiva@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-14	\N	\N	0
720	P-0359	ISOLATOT S.A 	04	0992839155001		0980275385	KM 7.5 Via Duran Tambo	compraspublicas@isolatot.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-18	\N	\N	0
721	P-0360	PAGUAY GUILLEN MANUEL ABELARDO 	04	0300508942001		0981553351	Av.Guayaquil M20 Y SL DIEZ 25 DE NOVIEMBRE 	taxidvice.ec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-21	\N	\N	0
722	P-0361	CHAMORRO PAILLACHO NANCY ELIZABETH 	04	0401290952001		0980507640	Av. Veintimilla y Av.Portugal 	imagenglob@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-21	\N	\N	0
723	P-0362	PIEDRA LOAIZA MERCY ESMERALDA 	04	1103285464001		022349511	Conocoto Camilo Ponce y Gracía Moreno 	ventas@kleiner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2021-10-26	\N	\N	0
724	E-0115	PAZMIÑO QUIMBIULCO ERIK JOEL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-05	\N	\N	0
725	T-0110	ROSERO QUIMBIULCO ERICSSON STIVEN 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
726	E-0116	YAPUD GUIZ WILMER SANTIAGO 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-05	\N	\N	0
727	T-0111	ROSERO CURICHO ROMEL VINICIO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
728	T-0112	PORTILLA ROSERO EMILIO SANTIAGO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
729	T-0113	GUERRERO CARLOS ALFONSO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
730	T-0114	ALTAMIRANO  PINCHAO FRANCISCO JAVIER 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
731	P-0363	ESCOBAR CORONEL DANIEL ALEJANDRO	04	1720733920001		0992785221	Ricardo Izurita del Castillo	escobardaniel687@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-12	\N	\N	0
732	P-0364	GUDIÑO VALENZUELA NELSON OSWALDO 	04	0908459621001		0991980565	Alpachaca / San Salvador 	osvalengu@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-17	\N	\N	0
733	P-0365	CYA EMPRESARIAL NORU CIA.LTDA 	04	1792809975001		0987539603	OE11-1525 Y INTIRAYMI	empresarialnoru@gmail.com	1	0041244062	\N	0	0	0	1	15	1	1	2021-11-18	\N	\N	0
734	P-0366	BAROJA LASCANO ANA LUCIA 	04	1704262243001		0978877725	San José de Ayora Av. Victor Cartagena 	analuciabaroja@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-18	\N	\N	0
735	P-0367	LA NUEVA FM RADIO 	04	0491518413001		062962482	Colón y Chimborazo 	nuevafm97.7@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-24	\N	\N	0
736	P-0368	NOTARIA 2	04	0500916440001		062981289	OLMEDO Y AYACUCHO	troyanelson58@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-12-02	\N	\N	0
737	T-0115	Piarpuezan Yapud Jaime Antonio	04	0400598876001		0968660316	El Playon	jaimepiarpuezan11@hotmail.com	2	402110028034	\N	0	0	0	5	68	1	1	2021-12-10	\N	\N	0
738	T-0116	Belalcazar Estacio Luis Andino	05		0401101167	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
739	T-0117	Benalcazar Sánchez Eulalio Fermín	05		0401710751	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
740	T-0118	Pinchao Yarpaz Albaro Fabian	05		0401771290	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
741	T-0119	Benalcazar Sanchez Darwin Ermilio	05		0401621099	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
742	T-0120	Mueses Rosero Jaime Rolando	05		0401508809	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
743	P-0369	SANDRA CATALINA  BAEZ VILLOTA 	04	0400981924001		0999483520	Parque Artesanal M4 	k.at.ba@hotmail.com	2	3497904300	\N	0	0	0	1	74	1	1	2021-12-13	\N	\N	0
744	P-0370	CARCHI AL DIA	04	0491520809001		0622270039	Pio V Guzman entre Av. Atahualpa y los Andes	carchialdia1@gmail.com	2	404110128183	\N	0	0	0	1	68	1	1	2021-12-14	\N	\N	0
745	P-0507	Escobar Almeida Daniela Cristina	04	1716895006001		0999731108	Suiza N34-01 y Checoslovaquia	cortinashospitalarias@hotmail.com	1	2100164272	\N	0	0	0	1	74	1	1	2021-12-15	\N	\N	0
746	E-0118	Rosales Almeida Aida Camila	05		0401382403	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-12-16	\N	\N	0
747	P-0371	Seguros Alianza SA	04	1790551350001		0963145589	Av. 12 de octubre y Baquerizo Moreno Torre	kcalderon@segurosalianza.com	1	01006012459	\N	0	0	0	1	6	1	1	2021-12-21	\N	\N	0
748	P-0372	Arias Cedeno Ernesto Leonardo	04	1715243307001		0996982368	Calle C y Av. interoceánica Y  de Puembo	info@fibradevidrio.ec	2	4389591100	\N	0	0	0	1	74	1	1	2021-12-21	\N	\N	0
749	P-0373	BURBANO DELGADO CARLOS ANTONIO	04	0400310421001		0994297709	Luis Felipe Borja	gubeburbano@hotmail.com	2	3498343400	\N	0	0	0	1	74	1	1	2021-12-22	\N	\N	0
750	P-0374	Cadena Argoti Alvaro German	04	0400761789001		0999561368	General Plaza y Olmedo	alvcad@hotmail.com	1	0070-05089-1	\N	0	0	0	1	71	1	1	2022-01-13	\N	\N	0
751	T-0121	Valencia Paspuel Brayan Leonel 	05		0401807342	0983968021	Tulcan	bvalenciapaspuel@gmail.com	2	4239059	\N	0	0	0	5	20	1	1	2022-01-17	\N	\N	0
752	T-0122	Paspuel Chiles Wilfrido	05		0401041660	0983968021	Tulcan	wilfridopaspuelwilfrido@gmail.com	2	401110097397	\N	0	0	0	5	68	1	1	2022-01-19	\N	\N	0
753	T-0123	Puetate Fuel Milton Andres	05		0401590500	\N	Tulcan	\N	2	4709885500	\N	0	0	0	5	74	1	1	2022-01-25	\N	\N	0
754	P-0375	MEJIA ARGOTI OSWALDO FEDERICO	04	0400576310001		0997123093	Calle C No 29 Calle A	oswaldmejia@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-01-28	\N	\N	0
755	E-0119	Jácome Hernández Jefferson	05		0401096219	\N	Tulcan	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-01-28	\N	\N	0
756	P-0376	Ledesma lomas Wilson Favian	04	0400885547001		0995005857	Av. San Francisco y Ten. Luis Rosero	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-02-08	\N	\N	0
757	P-0377	ROMERO OBANDO MARLENE ADRIANA	04	0401027628001		062960951	Sucre y Chimborazo	daguilarjulian@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-02-10	\N	\N	0
758	P-0378	CAPCONTEL SEGURIDAD INDUSTRIAL CIA LTDA.	04	1791879198001		0996916125	Jóse Felix Barreiro y E 16-277 y Pasaje E16E	procesos@capcontel.com.ec	2	2201327116	\N	0	0	0	1	74	1	1	2022-02-15	\N	\N	0
759	P-0379	VERIFYCAR	04	0491532491001		\N	Barrio la Rinconada	\N	2	019037858207	\N	0	0	0	1	8	1	1	2022-02-16	\N	\N	0
760	P-0380	Lalaleo Chamba Alexandra Catalina	04	1803175478001		0986305559	Tungurahua	jdm.ec@outlook.com	2	1059439025	\N	0	0	0	1	16	1	1	2022-02-16	\N	\N	0
761	P-0381	FUNDIEC	04	1791157281001		02-242-4675	Calle Alfonso  Moncayo 455/pN Km101/2	fundiec@fundiec.com	1	7636768	\N	0	0	0	1	16	1	1	2022-02-23	\N	\N	0
762	P-0382	Suarez Castro Miguel Angel	04	0400362562001		0986153003	San Miguel del Sur	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2022-02-24	\N	\N	0
763	P-0383	Nazate Villarreal Narciza de Jésus	04	0400917456001		062983809	Paluz y Yanacocha	rene.mote1@hotmail.com	2	3497889700	\N	0	0	0	1	74	1	1	2022-03-25	\N	\N	0
764	P-0384	GUERRERO BRAVO MADELAINE -FERRETERÍA CASTILLO	04	0401562806001		0988075617	Av Coral y Roberto Grijalva	lilianague97@gmail.com	2	2100257343	\N	0	0	0	1	74	1	1	2022-03-29	\N	\N	0
765	P-0385	Flores Yaluzan Edison Patricio	04	0401857578001		0988872540	San Pablo y San Pedro	floresmathias181@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-03-30	\N	\N	0
766	P-0386	CONSORCIO GADS. PROVINCIALES Y MUNICIPALES DEL NORTE DEL PAIS CON-NOR	04	1060016180001		062952973	IMBABURA / IBARRA / SAN FRANCISCO / BOLIVAR 10-23 	connor_ibarra@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2022-04-04	\N	\N	0
767	P-0387	PERFOCONSUL CIA. LTDA	04	1792110483001		022560970	Av. La Coruña N27-88 y Av. Orellana	gerencia@perfoconsul.com	\N	\N	\N	0	0	0	1	1	1	1	2022-04-07	\N	\N	0
768	P-0388	LALAMA SALAZAR PABLO ALEJANDRO 	04	1718610437001		0999371372	San Jose E15-45	pa.lalama@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-04-14	\N	\N	0
769	P-0389	VAICILLA PORTILLA LUIS ALEXANDER 	04	0401433941001		\N	Av. Veintimilla y Juan Ramon Arellano 	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-04-21	\N	\N	0
770	P-0390	TONELLO-SOLUCIONES INTEGRALES CIA. LTDA	04	1792234549001		023956982	PICHINCHA/CAYAMBE/PANAMERICANA NORTE N11-01	alexandro@tonello.ec	1	7314450	\N	0	0	0	1	16	1	1	2022-05-13	\N	\N	0
771	P-0391	LATINOAMERICANA DE COMERCIO 	04	0401334545001		0999174913	Av. Coral y Robertho Grijalva	latinoamericanadecomercio@yahoo.es	1	2100005866	\N	0	0	0	1	74	1	1	2022-05-17	\N	\N	0
772	P-0392	COMERCIAL HIDROBO S.A. COMHIDROBO	04	1090084247001		062631633	Av Mariano Acosta - Ibarra	pcusangua@comhidrobo.com	1	3108541104	\N	0	0	0	1	74	1	1	2022-05-19	\N	\N	0
773	P-0393	SAUDE SCA	04	0491533293001		0963527637	CALDERON Y ARGENTINA	saudesca.ec@gmail.com	1	0029816620	\N	0	0	0	1	15	1	1	2022-05-19	\N	\N	0
774	P-0394	DUNAMIS- BONILLA BONILLA MONICA SUSANA	04	1708620925001		0997777663	Ricardo Sanchez 1-45 y pasaje A	monicabonilla01@hotmail.com	2	5590765600	\N	0	0	0	1	74	1	1	2022-05-25	\N	\N	0
775	P-0395	ESPINOZA MENESES LIXON LIBORIO-TECNIFUEGOS	04	1002358420001		0967937123	Av. Manabí y Argentina	tecnifuegos2014@hotmail.com	2	2203434575	\N	0	0	0	1	74	1	1	2022-05-26	\N	\N	0
776	I-0021	Junta Adm. Agua Potable y Saneamiento San Luis	04	0491529520001		0995255077	San Luis Santa Martha de Cuba	montu127@yahoo.com	\N	\N	\N	0	0	0	3	1	1	1	2022-05-31	\N	\N	0
777	I-0022	COMUNA LA ESPERANZA	04	0491506458001		\N	Comuna la Esperanza	comunalaesperanza2021@gmail.com	2	4-01638425-6	\N	0	0	0	3	71	1	1	2022-06-08	\N	\N	0
778	I-0023	ASOCIACIÓN AGRICOLA DE TUFIÑO	04	0491510404001		0962877831	Tufiño	ascagricolatufi@gmail.com	2	0-07012326-4	\N	0	0	0	3	71	1	1	2022-06-09	\N	\N	0
779	P-0396	FERRETERIA CASTRO -BASTIDAS ERAZO BLANCA ELISA	04	0400923892001		0969873920	Gran Colombia y Av. Julio Robles 	blancaelisabastidas@gmail.com	2	401110924204	\N	0	0	0	1	68	1	1	2022-06-10	\N	\N	0
780	P-0397	MEGA REPUESTOS	04	0400576633001		0989446221	AV. VEITIMILLA Y PASAJE CENEPA	paointercambio@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2022-06-15	\N	\N	0
781	E-0120	Villota Trujillo Tamara Gabriela	05		1003001953	\N	Tulcán	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-06-20	\N	\N	0
782	P-0398	BIORECICLAR	04	1792387280001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-06-22	\N	\N	0
783	P-0399	Cano Crucerira Génesis Carolina ( La Nueva)	04	0401702352001		0998931492	via expreso Oriental	caro24cano@gmail.com	2	01010139404	\N	0	0	0	1	67	1	1	2022-06-27	\N	\N	0
784	P-0400	ASOCIACIÓN DE PRODUCCIÓN TEXTIL ALDASHIRA SPORT - Margarita Deporte  Montufar ASOTEXALDSPORT	04	0491517883001		062220121	Montufar y Sucre	asotexaldsport.montu@yahoo.com	2	4008175815	\N	0	0	0	1	71	1	1	2022-07-11	\N	\N	0
785	P-0401	Coop. Transporte Huaca -Julio Andrade 	04	0490038485001		069888168	Av. Veintimilla y Centenario	cooptranshuacajulioandrade@hotmail.com	2	0104001998	\N	0	0	0	1	20	1	1	2022-07-13	\N	\N	0
786	P-0402	Ruano Ipial Alirio Gerardo	05		0401153960	\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-07-15	\N	\N	0
787	E-0121	Paspuezan Martinez Santiago Javier	05		0401681762	0992763722	Barrio gran Colombia	spjm1990@live.com	2	4501619911	\N	0	0	0	4	37	1	1	2022-07-15	\N	\N	0
788	A-0001	ORTIZ ROSERO ALEXIS LEONARDO 	04	0401501176001		0985096366	Bolívar y General Plaza 	alexis.ortiz81@outlook.com	\N	\N	\N	0	0	0	7	1	1	1	2022-07-25	\N	\N	0
789	P-0403	AGENCIA NACIONAL DE TRÁNSITO	04	1768173130001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-08-03	\N	\N	0
790	P-0404	Figueroa Salazar Jacqueline Bernardette	04	1707405807001		0992812643	Autopista Amaguaña #S/N secundaría	funymaq@hotmail.com	2	0013849689	\N	0	0	0	1	15	1	1	2022-08-08	\N	\N	0
791	P-0505	Latacela Zuñiga Alex Giovanny  HIDROSYS	04	0301432449001		072247033	Av. Luis Monsalve Pozo SN y Adolfo Palomeque	alexlatacela@hotmail.com	1	5622158	\N	0	0	0	1	16	1	1	2022-08-09	\N	\N	0
792	P-0405	Tamayo Bonilla Adriana Alejandra ( GRUPO INDUSTRIAL A&A)	04	1803804515001		0984480544	CELIANO MONGE Y CERVANTES	grupo.industrial.aa@gmail.com	1	8122628	\N	0	0	0	1	16	1	1	2022-08-15	\N	\N	0
793	P-0406	MERA HERRERA RODRIGO SANTIAGO	04	0401513817001		0988537377	Calle Coronel Jorge Narváez No. 14 y Félix Freire	santy21189@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-08-18	\N	\N	0
794	P-0407	Aulestia Bedoya Gabriela Patricia	04	1002219713001		0997340160	Maria Castelo Manzana 2	gaby_aulestia0224@hotmail.com	2	1020153910	\N	0	0	0	1	16	1	1	2022-08-24	\N	\N	0
795	P-0408	Estuardo Fabricio Carrera Cañadas	04	1717175796001		0995016923	La Josefina y Diamante  ( Quito). 	arkadiaena@gmail.com	2	06168025004	\N	0	0	0	1	6	1	1	2022-08-24	\N	\N	0
796	E-0122	Salgado Jimenez Edison Arturo	05		0400696860	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-09-07	\N	\N	0
797	P-0409	Sociedad civil y comercial KV Energy SCC	04	1091796413001		0969507183	eusebio Borrero 8-64 y chica Narváez	kv_energy@outlook.com	1	8182329	\N	0	0	0	1	16	1	1	2022-09-07	\N	\N	0
798	P-0410	ENRIQUEZ TATES MIRIAM DEL ROCIO	04	0401134572001		0988141602	Bolivar entre Junin y Ayacucho	carchinoticias7@hotmail.com	2	1051889358	\N	0	0	0	1	16	1	1	2022-09-08	\N	\N	0
799	P-0411	 ASOPROTERESEM -ASOC.PRODUC.TEXTIL MUJERES DEL EMPRENDIMIENTO	04	1091751948001		062641358	Sánchez y Cifuentes y Perez Guerrero	lsy.chiscueth@gmail.com	2	4008178059	\N	0	0	0	1	71	1	1	2022-09-09	\N	\N	0
800	P-0412	Salazar Portilla  Gandy Arturo	04	1712439114001		0987432657	Clemente Vallen y Lino Flores	gandysalazar_75@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-09-14	\N	\N	0
801	P-0413	ARIAS VELA WILLIAM ANTONIO	04	0401098678001		0995325793	Bolivar y Carabobo	afav@hotmail.com	2	01010578910	\N	0	0	0	1	67	1	1	2022-09-14	\N	\N	0
802	P-0414	Caiza Bravo Tania GOBERP	04	0104015748001		0992558815	Av. Ordoñez Lazo S/N	mariofabian83@hotmail.com	2	1044847726	\N	0	0	0	1	16	1	1	2022-09-21	\N	\N	0
803	P-0416	Tupiza Morales Joselyn Nicole	04	1751355163001		0983166423	Esperanza y Simbaya	multiservicios75@gmail.com	2	2202414564	\N	0	0	0	1	74	1	1	2022-10-04	\N	\N	0
804	P-0417	AGUAAMERICAN S.A.S	04	0491533694001		0981300312	Las Animas y Barrio Carchi	facturas.fronnort@gmail.com	2	12862001779	\N	0	0	0	1	6	1	1	2022-10-06	\N	\N	0
805	P-0418	CORPORACION BUDAK S.A	04	1792348137001		09998371613	Poder Judicial calle Francisco Orellana	contabilidad@corporacionbudak.com.ec	1	3514322204	\N	0	0	0	1	74	1	1	2022-10-07	\N	\N	0
806	P-0419	ASQUI ARMAS CARMEN LOURDES-GRUPO LOS HIDROS CD	04	0601688310001		0984061386	Canonigo Ramos y Miguel de Santiago	loshidroscd@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2022-10-07	\N	\N	0
807	P-0420	IASA S.A	04	0990011109001		043731777	Av Juan Tanca marengo y S/n	navas_santiago@iiasacat.com	1	01667238	\N	0	0	0	1	15	1	1	2022-10-12	\N	\N	0
808	P-0421	Yanez Lechon Carlos Patricio ( Surtividrio)	04	1002090072001		0992929270	Bolivar  y Roberto Sierra	ycarlos32@yahoo.es	2	4006040357	\N	0	0	0	1	71	1	1	2022-10-13	\N	\N	0
809	P-0422	ATENCIO AGUAS CRISTHIAN DAVID.	04	1715932610001		0995183298	Las Casas Calle OE9FD Polit Lasso	cristhian_atencio09@hotmail.com	2	2100153716	\N	0	0	0	1	74	1	1	2022-10-18	\N	\N	0
810	P-0423	Ante Estrada Segundo Gerardo.	04	0400732806001		062250324	Av. Veintimilla y la Cascada	segundo-ante@outlook.com	2	401118819950	\N	0	0	0	1	68	1	1	2022-10-26	\N	\N	0
811	E-0123	Avilés Meza Edwin Patricio 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-14	\N	\N	0
812	E-0124	Quiranza Arciniega Anthony Alexander	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-15	\N	\N	0
813	P-0424	KUNANSOFT S.A.	04	0190380009001		072810628	Latinoamericana y Brasil	contabilidad@kunansoft.net	2	2209875764	\N	0	0	0	1	74	1	1	2022-11-15	\N	\N	0
814	P-0426	Servicio Radio Difusión Almeida & Hurtado -Ondas Carchenses 	04	0491514426001		2982518	Olmedo y Ayacucho	ondascarchenses@gmail.com	1	0004036204	\N	0	0	0	1	20	1	1	2022-11-16	\N	\N	0
815	P-0427	Meneses Toro Luis Gonzalo	04	0400982997001		063012630	La cortadera	luisgonza.meneses@gmail.com	2	2207522325	\N	0	0	0	1	74	1	1	2022-11-24	\N	\N	0
816	I-0026	Junta Admi. de Agua Potable y Alcantarillado Santa Martha de Cuba	04	0491516836001		\N	Santa Martha de Cuba	marigpaspuel@hotmail.com	2	403110818568	\N	0	0	0	3	68	1	1	2022-11-24	\N	\N	0
817	E-0125	Lenin Daniel Freire Trujillo	05		0401603915	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-24	\N	\N	0
818	P-0428	Yomaira Vanessa Fuertes Cadena	04	0401746037001		0939919540	Av Veitimilla y Andres Bello	vanessa1903@gmail.com	2	2203990577	\N	0	0	0	1	74	1	1	2022-12-02	\N	\N	0
819	P-0429	TECHNOLOGY- GUERRERO QUINTERO HUGO FERNANDO	04	0401311295001		0983800587	Boyaca y Bolivar	hugoguerreroq22@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-12-08	\N	\N	0
820	I-0007	Junta Administradora Agua Potable El Chical	04	0491519339001		\N	El Chical	\N	\N	\N	\N	0	0	0	3	1	1	1	2022-12-08	\N	\N	0
821	P-0430	JÁCOME VALLEJOS GUSTAVO JORGE	04	1001193026001		0990257171	Julio Andrade Panamericana Norte, Sec. Las Manguer	gustavojacome77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-01-17	\N	\N	0
822	P-0431	PLUSAMBIENTE S.A	04	1792186277001		023938214	Pichincha Quito	gerencia@plusambiente.com	1	3465044304	\N	0	0	0	1	74	1	1	2023-01-17	\N	\N	0
823	P-0432	CHUGA ENRIQUEZ JORGE BAYARDO	04	0400634630001		0991328581	Maldonado y Boyaca	jorbache@hotmail.com	1	3568079000	\N	0	0	0	1	74	1	1	2023-01-17	\N	\N	0
824	E-0127	Morejón Morejón Marco Fabian	05		1001452034	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-01-18	\N	\N	0
825	P-0433	REPRESMUNDIAL CIA LTDA	04	1792113636001		0998585179	Tumbaco	marcoleguisamo@hotmail.com	1	0025418255	\N	0	0	0	1	15	1	1	2023-01-19	\N	\N	0
826	P-0434	Imbacuan Navarro Alexandra Esthefania 	04	0401849690001		0993466814	Las animas y Juan Montalvo	estrategidea@gmail.com	2	2208310787	\N	0	0	0	1	74	1	1	2023-01-19	\N	\N	0
827	P-0435	HERNANDEZ POZO MANUEL MESIAS	05		0400396503	\N	TULCÁN 	\N	2	01010219194	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
828	P-0436	MORILLO CHANGUÁN MARIA LAURA	05		0400616215	\N	TULCÁN	\N	2	01010041820	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
829	P-0437	CHUNEZ MORILLO MANUEL ANTONIO	05		0400879805	\N	TULCAN	\N	2	2202499347	\N	0	0	0	1	74	1	1	2023-01-23	\N	\N	0
830	P-0438	CHUNEZ MORILLO ROSA ANA	05		0400915997	\N	TULCAN	\N	2	01010027070	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
831	E-0128	CHUNEZ MORILLO MARTHA ELIZABETH	05		0401022157	\N	TULCAN	\N	2	2207305686	\N	0	0	0	4	74	1	1	2023-01-23	\N	\N	0
832	P-0439	CHUNEZ MORILLO JOFFRE JAVIER	05		0401050182	\N	TULCAN	\N	2	4297906200	\N	0	0	0	1	74	1	1	2023-01-23	\N	\N	0
833	P-0440	Puetate Ceron Segundo Jacinto	04	0400448684001		0997272793	Av. 21 de Marzo y Pedro Vicente	puetatesegundo1@gmail.com	2	6228171200	\N	0	0	0	1	74	1	1	2023-01-24	\N	\N	0
834	P-0441	ZUMBA ALFARO CARLOS ALEJANDRO.	04	1705674073001		0998645244	Calle Gonzalo Gallo OE7-288 y Jorge Piedra	czumba@hotmail.com	2	6129047400	\N	0	0	0	1	74	1	1	2023-02-01	\N	\N	0
835	T-0124	PUETATE PASPUEZAN JOSE ROSALINO	05		0400831574	\N	TUFIÑO	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-02-02	\N	\N	0
836	T-0125	GUAMAN CHILES BRAYAN ALEXANDER 	05		0450024161	\N	TUFIÑO 	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-02-02	\N	\N	0
837	P-0442	SOTO TAPIA MARIA FERNANDA-COPY SYSTEM	04	0401385760001		0993948172	Coral y Sucre	mfst3@hotmail.com	2	01010206572	\N	0	0	0	1	67	1	1	2023-02-10	\N	\N	0
838	P-0443	Gallegos  Bolaños Wilfrido Atahualpa	04	1708983158001		0997582952	Pichincha	wilfrido.gallegos@hotmail.com	2	2202226655	\N	0	0	0	1	74	1	1	2023-02-23	\N	\N	0
839	P-0444	AYALA JARAMILLO MARTIN ALEJANDRO - M&M QUÍMICOS	04	1717211716001		0983595701	La Pradera E7-59	maayalaj220789@gmail.com	2	12002181407	\N	0	0	0	1	6	1	1	2023-03-09	\N	\N	0
840	T-0126	Meneses Nasner Edison Andres	05		0401426697	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
841	T-0127	Meneses Nasner Jordan Gabriel	05		0450120399	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
842	T-0128	Portilla Jimenez Alvaro Eduardo	05		0401216007	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
843	P-0446	RUALES AUZ JUAN FRANCISCO	04	0401117387001		0986015988	ROCAFUERTE Y BOLIVAR 	rualesfrancisco@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-03-24	\N	\N	0
844	E-0129	Luis Aguilar Guerron	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-03-24	\N	\N	0
845	P-0447	Flores Yandún Victor Hugo 	04	0401723937001		0987293300	Juan José Flores y 10 de agosto	victorhogofloresyandun@gmail.com	2	01010598701	\N	0	0	0	1	67	1	1	2023-03-27	\N	\N	0
846	P-0448	Yepez Rosero Victor Manuel	04	0400637005001		0989880582	Carlos Urbina S N El Chical	vimyeros@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2023-03-27	\N	\N	0
847	P-0449	Vaca Cachimuela Julio Guillermo 	04	1726311739001		022354502	San miguel de alugulla / pasaje 21	julioguillermovaca@gmail.com	2	2202779076	\N	0	0	0	1	74	1	1	2023-03-28	\N	\N	0
848	P-0450	Martinez Rosero Dayana Anabel 	04	0402037741001		0995749821	Sucre y Gran Coliombia	dayanamartinez19982013@gmail.com	2	2209337643	\N	0	0	0	1	74	1	1	2023-03-28	\N	\N	0
849	T-0129	Almeida Rodriguez  Manuel Mesias 	05		0400459756	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-28	\N	\N	0
850	P-0451	Nazate Chamorro Carlos David	04	0401682695001		0980338866	Tarqui y Olmedo	charlestonlavozecuador@gmail.com	2	2205572826	\N	0	0	0	1	74	1	1	2023-04-18	\N	\N	0
851	P-0452	CUAYCAL REYES RAMIRO GERMÁN	04	0400633004001		\N	Juan Jose Flores y 10 de Agosto	noticierohora12@gmail.com	2	3497850500	\N	0	0	0	1	74	1	1	2023-04-19	\N	\N	0
852	P-0453	LA CASA DEL CONSTRUCTOR- FUERTES AGUILAR MARITZA	04	0401463815001		0999570991	Av. Veintimilla y México	maritzafuertesaguilar@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-04-26	\N	\N	0
853	P-0454	INGENIERIA ELECTRICA Y REDES INGELEC S.A	04	0993125784001		0992664867	Guayaquil -ciudad Olimpo 	oficina.ingelec@gmail.com	1	7908601	\N	0	0	0	1	16	1	1	2023-05-02	\N	\N	0
854	P-0455	NOROÑA ROJAS GRACIELA ELIZABETH	04	1715821508001		0995675372	Pichincha-Quito	uyuky_gnr@hotmail.com	2	2204009724	\N	0	0	0	1	74	1	1	2023-05-11	\N	\N	0
855	E-0130	Montesdeoca Espinoza Jocelyne Beatriz	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-05-11	\N	\N	0
856	T-0130	Fabiola Cando Aguirre	05		0401552401	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-05-19	\N	\N	0
857	P-0457	Mejia Viteri Alex David Notaria 22.	04	0201340650001		2503980	Av 12 de octubre N24-660 y Francisco Salazar	facturacioncorporativo@notaria22quito.com	1		\N	0	0	0	1	1	1	1	2023-06-15	\N	\N	0
858	E-0131	Aguilar Guerron Byron Danilo	05		0401185095	0981164129	Barrio el Carchi	daguilarjulian@hotmail.com	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
859	E-0132	CHUNES CHANGUAN MARIANA LUCILA	05		0400966750	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
860	E-0133	Rosero Benavides  Juan Carlos	04	0401167325001		\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
861	E-0134	Burbano Ortiz Northon Ramiro	05		0400993838	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-21	\N	\N	0
862	P-0458	ELICROM CIA. LTDA	04	0992216964001		0999337519	Guayaquil  solar 10 manzana 21 frente mall del sol	elicrom@elicrom.com	1	7415311	\N	0	0	0	1	16	1	1	2023-06-22	\N	\N	0
863	P-0459	ATIMASA S.A	04	0991331859001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
864	P-0460	Proaño Acosta Jorge Luis	04	1600234072001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
865	P-0461	Concesionaria Santo Domingo CRSD S.A	04	1793040012001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
866	P-0462	CONORTE S.A - EP 	04	0991503331001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
867	I-0028	GAD PROVINCIAL DE PICHINCHA	04	1760003330001		\N	\N	\N	\N	\N	\N	0	0	0	3	1	1	1	2023-06-30	\N	\N	0
868	P-0464	Molina Pruna Galo Alberto	04	1709264111001		023110793	Quito la Magdalena/ Aguirre	molinatires66@gmail.com	1	7740972	\N	0	0	0	1	16	1	1	2023-07-13	\N	\N	0
869	P-0465	VILLARREAL REVELO RAUL EFREN.	04	0400804084001		0985430964	9 de Octubre y Olmedo	raul_0767@hotmail.com	2	2100034740	\N	0	0	0	1	74	1	1	2023-07-13	\N	\N	0
870	E-0135	Velasco Escobar Jorge Alexander	04	0401125323001		0995370334	Parquue Artesanal y Upiano Rosero	Jorge_velasco11@hotmail.com	2	0021497147	\N	0	0	0	4	15	1	1	2023-07-14	\N	\N	0
871	P-0466	NAVARRETE DAVILA BETTI NARCISA 	04	0400686911001		0984627324	Nazareth y Av Gonzalo Plazo	bynrepresentaciones@hotmail.com	2	 3177185700	\N	0	0	0	1	74	1	1	2023-07-14	\N	\N	0
872	T-0131	Paspuezan Yanascual Carlos Fernando	05		0401858964	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-07-17	\N	\N	0
873	T-0132	Puetate Paguay Carlos Dorman	05		0401033261	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-07-17	\N	\N	0
874	P-0506	PEÑAFIEL RUANO LUIS EMILIO	04	0400691903001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-08-02	\N	\N	0
875	E-0136	Juan Diego Delgado Flores	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-08-16	\N	\N	0
876	P-0467	GERMAN MAURICIO LOPEZ SANTANA	04	1801338912001		\N	\N	eljardin.efactura@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-08-21	\N	\N	0
877	E-0137	Luis Fernado Ruano Cárdenas	05		0401864673	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-09-05	\N	\N	0
878	P-0468	CHICAIZA  TOAPANTA MARIA PATRICIA	04	1802456093001		0992195489	Santiago de Pillaro sector Baratillo VI a San Jose	sistemasymp@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-09-05	\N	\N	0
879	P-0469	INDUSTRIAS SISAILLA DEL ECUADOR	04	1792729823001		022094131	Conocoto	compras.publicas@sisailla.com	1	2100144488	\N	0	0	0	1	74	1	1	2023-09-06	\N	\N	0
880	E-0138	Jessika Esteffania Vivas Castillo 	05		0401745310	0960485000	Julio Andrade 	estefyvivas0128@gmail.com	2	\N	\N	0	0	0	4	74	1	1	2023-09-07	\N	\N	0
881	P-0470	Aguilar Villalva Giovanna Gabriela ( PROINDUSTRIAL SA)	04	1803784881001		0985210488	TUNGURAGUA	gerenciaproindustrial@gmail.com	2	0019517581	\N	0	0	0	1	15	1	1	2023-09-08	\N	\N	0
882	P-0471	MURILLO ALTAMIRANO MARIBEL OLIVIA- MERCAMAX	04	0914104708001		0999492005	Guayaquil	grandamurillo@hotmail.com	1	7695241	\N	0	0	0	1	16	1	1	2023-09-11	\N	\N	0
883	P-0472	Estación de Servicio Mundo Tuerca	04	0601809403001		\N	Diego Ibarra 21-55 Av Daniel Leon Borja	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-09-18	\N	\N	0
884	P-0473	Bonilla Ortiz Victoria Evelina	04	1800384826001		\N	\N	leon.efactura@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-09-20	\N	\N	0
885	E-0139	Jojoa Benavides Joana María	05		1752918217	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-09-25	\N	\N	0
886	P-0474	VÍVERES LA UNIVERSAL.	04	0400809596001		0983244452	Av veintimilla y Centenario	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-10-02	\N	\N	0
887	P-0475	Vargas Vizuete Angel Roberto	04	0602358087001		0999019680	Pichincha	importrepuestos001@outlook.com	1	8124264	\N	0	0	0	1	16	1	1	2023-10-06	\N	\N	0
888	P-0476	APROTEXRO -ASOC. PRODUCC.TEXTIL ROBLETEX	04	1091760386001		062950213	Pedro Rodríguez y José María Lequerica	aprotexro13@gmail.com	1	0010866383	\N	0	0	0	1	20	1	1	2023-10-12	\N	\N	0
889	P-0477	Topchay Topchay Victoria	04	0401352778001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-10-12	\N	\N	0
890	P-0478	EL HUERTO CIA. LTDA.	04	1891725198001		032823041	Tunguragua	clientes@elhuerto.com.ec	1	02080011159	\N	0	0	0	1	6	1	1	2023-10-18	\N	\N	0
891	P-0479	Omnibus B.B Transportes S.A	04	1790233979001		22977-700 ext 44245	Av. Galo Plaza Lasso OE1-277	bilma.davila@gmail.com	1	3041163504	\N	0	0	0	1	74	1	1	2023-10-24	\N	\N	0
892	P-0480	IASA-SERVICIO S.A	04	0990011117001		042237000	Guayaquil	navas_sunny@iiasacat.com	1	7503164	\N	0	0	0	1	16	1	1	2023-10-25	\N	\N	0
893	E-0141	Jairo Pozo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-10-31	\N	\N	0
894	T-0133	MENA SÁNCHEZ CESAR OSWALDO	05		1719676189	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-11-01	\N	\N	0
895	E-0142	POZO YANDUN JAIRO GIORDANO	05		0401918636	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-06	\N	\N	0
896	E-0143	Enriquez Jonathan	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-07	\N	\N	0
897	P-0481	Godoy Usiña Henry Vinicio	04	1003147467001		0963482092	Alta tensión s/n Av. Futura Padre Carolo	distribucioneshenrygodoy@gmail.com	2	0018633056	\N	0	0	0	1	15	1	1	2023-11-08	\N	\N	0
898	P-0482	Cajas y Empaques Industriales  Clusterpack CPK S.A.	04	1792722357001		0999800230	Pichincha	solmontalvocluster@gmail.com	1	1645006475	\N	0	0	0	1	17	1	1	2023-11-15	\N	\N	0
899	P-0483	AQUAKLEANER S.A.	04	0992638923001		0994495568	Km. 16 vía a Daule	gvera@aquakleaner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2023-11-20	\N	\N	0
900	E-0144	Rodriguez Huera Mishell Carolina	05		0401882360	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-21	\N	\N	0
901	P-0484	CARRO SEGURO CARSEG S.A.	04	0991259546001		042924050	Pichincha  C38 y 13 de abril	gmaldonado@carsegsa.com	1	3139591104	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
902	P-0485	BASSANTE CRUZ JOSÉ ANDRÉS -BELSSANTÉ	04	1717153579001		0984698502	Pichincha	jabassante@gmail.com	2	4444364200	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
903	P-0486	Saltos Demera  Rosa Leonor 	04	1713056610001		0959065711	Santo Domingo	imprentadkl@gmail.com	1	2100296200	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
904	E-0145	José Caicedo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-12-06	\N	\N	0
905	P-0487	PLÁSTICOS RIVAL CIA. LTDA.	04	0190050033001		72890-144	Zona 6/ Azuay/ Cuenca/ Ricaurte	auxtesoreria@plasticosrival.com	1	3001051470	\N	0	0	0	1	71	1	1	2023-12-07	\N	\N	0
906	P-0488	PAREDES BOLAÑOS JOSÉ DARWIN.	04	0401333190001		0995933022	Los Videños - Carchi	arq.paredesjose@gmail.com	1	0029816174	\N	0	0	0	1	15	1	1	2023-12-07	\N	\N	0
907	P-0489	Austral CIA LTDA	04	0190001628001		072809325	Azuay/Cuenca/El Vecino	facturacion@austral.com.ec	1	7243626	\N	0	0	0	1	16	1	1	2023-12-07	\N	\N	0
908	P-0490	Herrera Dávila Neptalí	04	1001416393001		0969776462	Imbabura	neptaliherrera63@hotmail.com	2	40711017	\N	0	0	0	1	68	1	1	2023-12-12	\N	\N	0
909	P-0491	Morales Chamorro Byron Andres	04	1722702600001		022350872	Pichincha	clubdeciencias2@hotmail.com	2	1055500218	\N	0	0	0	1	16	1	1	2023-12-15	\N	\N	0
910	P-0492	Cando Huertas Jhonny Ivan 	04	0401391347001		0989075951	Rafel Arellano y Panama	dimev2004@yahoo.com	2	3395722704	\N	0	0	0	1	74	1	1	2023-12-15	\N	\N	0
911	E-0146	Ing. Fernando Tiobar 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-10	\N	\N	0
912	E-0147	Lcdo. Vladimir Velasco	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-15	\N	\N	0
913	P-0493	SUAREZ MUÑOZ RITTA CECILIA.	04	1712213543001		0992527035	Urb. Pilanqui Juan de la Roca 7 - 42	diegoenantm@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-17	\N	\N	0
914	P-0494	NAVISOY REYES COLÓN GUSTAVO	04	0400503892001		0991956936	Barrio Centro calle Ayacucho 	gus_navreyes@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2024-01-17	\N	\N	0
915	E-0148	CAICEDO MERA JOSE HOMERO	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-18	\N	\N	0
916	P-0495	ENRIQUEZ CHICANGO JAIME JEAN	04	0400791166001		0993513881	Tulcán - Rafael Arellano y Junin 	jaime2273@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-18	\N	\N	0
917	E-0149	SERRANO TERÁN ANDRÉS GIOVANNY	05		0400876983	0995331799	\N	gordochelin2412@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2024-01-18	\N	\N	0
918	T-0134	COLIMBA NARVÁEZ CARLOS ARTURO 	05		1712082286	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
919	T-0135	GUEL PUETATE CARLOS ROBERTO 	05		0401616115	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
920	T-0136	CABRERA TERMAL BAIRON ALEXANDER	05		0401663976	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
921	T-0137	GONZALES GONZALES CÉSAR EDUARDO	05		0401442942	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
922	T-0138	CUACES CUELTAN GERMAN ALEXANDER	05		0401631916	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
923	T-0139	IMBAQUINGO PINCHAO WILSON HERNÁN	05		1724789647	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
924	E-0150	VELASCO BARBA JAIME VLADIMIR	05		0401036736	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-19	\N	\N	0
925	T-0140	MORAN ROSERO DANIEL ANÍBAL	05		0401819347	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-19	\N	\N	0
926	T-0141	CUACES POZO MARCELO ARMANDO	05		0401192729	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-19	\N	\N	0
927	E-0151	FUERTES LÓPEZ NORMA CECILIA	05		0400837878	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-19	\N	\N	0
928	P-0496	LOBATO CAMPOVERDE CHRISTIAN ANDRES	04	1722748215001		0958969848	Loja - calle Miguel Angel 	per.calobato@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-29	\N	\N	0
929	P-0504	Nazate Cadena Alicia Mireya 	04	0401171301001		2982407	Tarqui s/n y Olmedo 	\N	\N	\N	\N	0	0	0	1	1	1	1	2024-01-30	\N	\N	0
930	T-0142	Tatamues Chuquizán Vicente Hipólito 	05		0400642682	\N	Tufiño -  calle Gran Colombia 	chuquizan1962@gmail.com	\N	\N	\N	0	0	0	5	1	1	1	2024-02-02	\N	\N	0
931	T-0143	Cuesta Malte Jordan Estiven 	05		0402065734	0990978557	Tufiño- calle Gran Colombia 	estivenmalte@gmail.com	\N	\N	\N	0	0	0	5	1	1	1	2024-02-02	\N	\N	0
932	E-0152	ORBE LUCERO CINTHYA DANIELA 	05		0401913496	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-06	\N	\N	0
933	P-0497	SALCEDO  RODRIGUEZ CARLOS ANDRES 	04	0401588611001		0994515211	Barrio Norte calle 11 de Abril 	arq.andresalcedo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-06	\N	\N	0
934	E-0153	YACELGA FIGUEROA  JENNY ELIZABETH	05		0401463070	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-07	\N	\N	0
935	P-0498	MONTENEGRO ALMEIDA ALVARO GONZALO 	04	0400980686001		0992594175	Ciudadela Kennedy calle Jose Maria Urbina 	elromanticoagma11@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-08	\N	\N	0
936	E-0154	LARA BENALCÁZAR JOHANNA PAOLA 	05		0401798285	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-15	\N	\N	0
937	P-0499	ENRIQUEZ CHAPUEL ALICIA ANABELA 	04	0401660410001		0993716643	Tulcán - Calle Sucre 	edanielcanal1tv@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-15	\N	\N	0
938	T-0144	MORAN ROSERO AMILCAR GERARDO	05		0401641543	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-02-15	\N	\N	0
939	P-0500	Proveedores	05			\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2024-02-19	\N	\N	0
940	P-0501	EMULDEC - EMULSIONES DEL ECUADOR 	04	1791773268001		0995281413	Quito- Luis Calderon 	info@emuldec.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-02-21	\N	\N	0
941	E-0155	GUILCAMAIGUA FUENTES YOMAIRA PATRICIA 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-06	\N	\N	0
942	P-0502	DISTRIBUIDORA DEL CAJAS SA 	04	0391034250001		072599800	Calle Trajano Carrasco Baquero 	mobregon@ucem.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-03-12	\N	\N	0
943	E-0156	MONTENEGRO CHICAIZA KEVIN ANDRÉS	05		0401417985	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-13	\N	\N	0
944	P-0503	COPPERSYSTEMS IMPORTADORA CIA LTDA. 	04	1792357985001		023238251	YANEZ PINZON N°26-39 Y LA NIÑA 	alex@coppersytem.com	\N	\N	\N	0	0	0	1	1	1	1	2024-03-15	\N	\N	0
945	E-0157	LOPEZ MARTINEZ JEAN PIERRE 	05		0401775408	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-21	\N	\N	0
946	E-0158	CHILIQUINGA CHIRIBOGA JULIO EDUARDO 	05		0401697685	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-21	\N	\N	0
947	P-0508	ASSA - AUTOMOTORES DE LA SIERRA S.A 	04	1890000130001		032999800	Calle Av. Atahualpa y Rio Guayllabamba 	nlarrea@assa.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-03-25	\N	\N	0
948	T-0145	BELALCAZAR ESTACIO FRANKLIN ROLANDO	05		0401801451	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-04-04	\N	\N	0
949	P-0509	CMAGINET-EC CIA.LTDA.	04	1792548799001		0983920631	calle 10 de Agosto y Vicente Aguirre 	mj@cmaginet.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
950	P-0510	LOPEZ AYALA JORGE LUIS -ECUAPURE	04	1002074886001		0995018392	via  a Ajiloma	ecuapure@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
951	P-0511	ASOTEXANTEÑOS -ASOCIACION PROD.TEXTIL TRABAJADORES ANTEÑOS	04	1091754173001		0999339107	calle Luis Leoro Franco 	asnuevaera2015@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
952	P-0512	MORENO VILLACIS ANDRES GUILLERMO 	04	0101834596001		043805650	Brasil N 40 38 y Charles Darwin 	ventas@idconsultants.us	\N	\N	\N	0	0	0	1	1	1	1	2024-04-10	\N	\N	0
953	P-0513	FERRETERIA LA FRONTERA 	04	0401502711001		0939984094	El Carmelo 24 de mayo  y Bolivar	rafaamplificaciones@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-16	\N	\N	0
954	E-0159	TREJO VITERI MILENA GISSELA	05		0401721501	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
955	T-0146	LIMA QUILISMAL JEFFERSON HUMBERTO	05		0401702089	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-04-17	\N	\N	0
956	E-0160	CANACUAN VIZCAINO GISELLA NATALY	05		0401810767	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
957	E-0161	NARVAEZ LUIS RIGOBERTO	05		0400795498	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
958	P-0514	TELENLACES SISTEMAS Y TELECOMUNICACIONES  SA	04	0992558601001		062988556	Junin s/n y Sucre 	info@telenlaces.net	\N	\N	\N	0	0	0	1	1	1	1	2024-04-25	\N	\N	0
959	P-0515	AMBULUDI ALVAREZ JHAN MARCOS 	04	2101090344001		0939823800	Barrio 10 de Agosto- calle Pichincha 	mediartpublicidad2020@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-25	\N	\N	0
960	P-0516	NAJERA ALMEIDA EVA VERONICA 	04	1711754687001		062952711	Canton Ibarrra - Parroquia San Francisco 	favemsa@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2024-05-07	\N	\N	0
961	P-0517	LOPEZ CEVALLOS EVELYN NATHALY 	04	0401203955001		0963395449	Pasaje Jambeli y calle Gonzalo Araujo 	evelyn.lopez19@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-13	\N	\N	0
962	P-0518	COUNTELSEG PROFESSIONAL SOLUTIONS S.A.S.	04	1793194296001		062970077	Bolivar y Juan Ramón Arellano 	contabilidad@countelseg.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-14	\N	\N	0
963	T-0147	ALARCON QUISTANCHALA JOSELYN FERNANDA	05		0402092555	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-05-14	\N	\N	0
964	P-0519	ARTEAGA ROSERO ALEXIS IVAN	04	0401567516001		0986697145	Tulcán- calle Gonzalez Suarez 	alexiscap2330@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-15	\N	\N	0
965	P-0520	MENA BUSTAMANTE CARLOS EDUARDO 	04	1726687682001		0984073825	Panamericana Norte 	cemena.terra@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-16	\N	\N	0
966	P-0521	RODRIGUEZ FUENTES MARCO -NOTARIA 3	04	0400694287001		062985259	Calle Rafael Arellano y Garcia Moreno 	marcorodriguezfuentes2010@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-16	\N	\N	0
967	P-0522	ROSERO CASTRO ANDRES JAVIER 	04	0401590542001		0982618489	Av. Veintimilla y Padre Juan de Velasco 	andresjavierroserocastro@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-17	\N	\N	0
968	P-0523	SIMEC-CG S.A.S.	04	1793200538001		0998477054	Mariscal Foch y Diego de Almagro	contabilidad@simeccg.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-17	\N	\N	0
969	P-0524	INFOENERGY CONSTRUCTORA Y CONSULTORA S.A	04	1792257344001		0990983756	Quito , José Rafael Bustamente E7-62 y el Morán 	business@infoenergy.us	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
970	P-0525	INDUSTRIA TEXTIL TEXTIRODAL CIA. LTDA. 	04	1091744852001		062909377	Alejandro Andrade 	contador@textirodal.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
971	P-0526	AGUIRRE MAYORGA JEANETH PAULINA 	04	1707739023001		022523055	Urb. El Bosque , calle Edmundo Carvajal OE-67 	ventas@todolomedico.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
972	P-0527	POZO GARCIA TROTSKY LENIN	04	0400808887001		0997284349	Calle Inglaterra y Av. Andrés Bello	tipozo1967@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-28	\N	\N	0
973	P-0528	RAMIREZ ANDRADE NEURIO MARLON	04	0400798351001		0993996792	Calle Panamericana Norte Km. 147 y Playa de Ambuqu	ramirezmarlon@msn.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-30	\N	\N	0
974	T-0148	LUIS ALBERTO TELAG PITACUAR 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-05-31	\N	\N	0
975	P-0529	FERNANDEZ AGILA VERONICA LOURDES 	04	1724351844001		062245984	Barrio SOLANDA calle OE4K 	cpepmapatulcan@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-10	\N	\N	0
976	P-0530	INDUSTRIA MOBILIARIA FERRONOPAL S.A.S	04	1793209001001		0983578124	Pichincha - Quito 	industriasnopalsas@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-11	\N	\N	0
977	P-0531	CERVANTES TAFUR HENRY DANIEL ( MECNETEL)	04	1002581583001		0984970328	Cdla. del chofer , calles brasil 	henrycervantestafur@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-17	\N	\N	0
978	T-0149	ÑACASHAG RAMÍREZ ANDERSON DAVID	05		0401835459	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-06-17	\N	\N	0
979	P-0532	BASTIDAS REYES TITO FERNANDO	04	1713925681001		0995869813	PASJE. Y FCO DEL CAMPO QUITO ECUADOR 	titobastidas@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-19	\N	\N	0
980	P-0533	SALAZAR MONTENEGRO MARIA STACEY	04	0401583810001		0984698379	Bolivar y Rocafuerte 	orionsoluinfo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-25	\N	\N	0
981	P-0534	CUENCA URGILES MARIELA EMPERATRIZ 	04	1709146763001		0992478249	Pichincha Cayambe 	ticsotwareinfomatic@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-25	\N	\N	0
982	P-0535	YANDUN BOLAÑOS BOLIVAR ANDRES 	04	0401422316001		0984143198	Calles Antonio Jose de Sucre y Av. Brasil 	andresyandun77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-26	\N	\N	0
983	P-0536	CHICANGO BURBANO  MILTON MAURO	04	0400644506001		0999384587	Calle Colón y Junín	maomil5@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-03	\N	\N	0
984	P-0537	TUQUERES TUQUERES ALICIA DEL ROCIO 	04	1712831633001		0994253658	Los floripondios y Leonardo Murialdo 	info@digenesis.net	\N	\N	\N	0	0	0	1	1	1	1	2024-07-04	\N	\N	0
985	E-0162	LIZBETH  BENAVIDES	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-07-05	\N	\N	0
986	D-0006	RUANO PAREDES ANDRES SANTIAGO	05		0401432349	\N	TULCAN	\N	\N	\N	\N	0	0	0	6	1	1	1	2024-07-08	\N	\N	0
987	P-0538	ORDOÑEZ CHARFUELAN PIEDAD DEL CARMEN 	04	0400880696001		0979321154	Panamá y Av.Manabi 	carmencharfuelan1967@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-12	\N	\N	0
988	P-0539	BUESTAN CIA LTDA	04	1790554295001		0984199987	Av. Jose Andrade y Joaquín Mancheno 	gerenciageneral@buestan.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-17	\N	\N	0
989	P-0540	HARNISTH PINOS ODGUIL ANTONIO 	04	0912538519001		022860188	Los Romeros y Mariana de Jesús 	harpicorp@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-18	\N	\N	0
990	T-0150	DUQUE TUPE JUAN VINICIO 	05		0401206149	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-07-19	\N	\N	0
991	T-0151	CHENAS PASPUEL LUIS ALFONSO 	05		0400849527	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-07-19	\N	\N	0
992	P-0541	PARRA ROCHA ANA BELÉN -IMELEC	04	1712841020001		2428003	Pichincha Quito	contabilidad@imelec.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-07-19	\N	\N	0
993	D-0007	CABRERA ROMERO FLOR ESPERANZA 	04	0601240138001		0983705732	Las Gradas y Jose Maria Urbina 	florcabrera1957@gmail.com	\N	\N	\N	0	0	0	6	1	1	1	2024-07-23	\N	\N	0
994	E-0163	ORDOÑEZ BOLAÑOS BOLIVAR ALEJANDRO 	05		0401074620	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-07-24	\N	\N	0
995	C-0011	VALLEJO IBARRA AURELIZA	05		0400376141	062960052	Av. Coaral 59030 y Venezuela	\N	\N	\N	\N	0	0	0	2	1	1	1	2024-08-05	\N	\N	0
996	P-0542	LALALEO CHAMBA JOSE LUIS 	04	1803532314001		0983117797	VARON DE CARONDELET Y CALLE NUEVE DE OCTUBRE 	gladmarl@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2024-08-07	\N	\N	0
997	P-0543	ECUADORDOMAIN S.A	04	1792837626001		0983198683	Av. la Republica E7-55	facturacion@nic.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-08-08	\N	\N	0
998	P-0544	DAVILA CASTRO PABLO OSWALDO	04	1103739833001		0998072157	Av. Coruña y San Ignacio 	inacapecuador@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-08-15	\N	\N	0
999	E-0164	VIVANCO ENCARNACIÓN ROSTMAN MANUEL	05		1103673826	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-09-02	\N	\N	0
1000	P-0545	SOTOMAYOR RAMOS SAMUEL AGUSTÍN	04	1707783674001		0991798803	CALLE INTEROCEANICA L72	samuel.sotomayor@hidross.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-09-04	\N	\N	0
1001	P-0546	ERAZO TORRES HENRY MARCELO	04	0401558622001		0998559703	Calle Bolívar y General Landázuri	henryet19@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-06	\N	\N	0
1002	P-0547	VALENCIA Y VALENCIA CIA. LTDA.	04	0591722271001		0998330014	Av. Marco Aurelio Subia 6 81 y Calle Loja	valenciayvalencia.bcs@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-10	\N	\N	0
1003	E-0165	CALDERON GUZMAN GENNY TERESA	05		0401580956	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-09-11	\N	\N	0
1004	P-0548	FUENTES ENRIQUEZ DANIEL FERNANDO	04	0401540349001		09878998065	Barrio Las Tejerías y Andrés Bello	dany0900@icloud.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-12	\N	\N	0
1005	I-0029	GAD PQ RURAL JULIO ANDRADE	04	0460022020001		\N	Julio Andrade	\N	\N	\N	\N	0	0	0	3	1	1	1	2024-09-12	\N	\N	0
1006	P-0549	ROSERO LUCERO SANDRA MILENA -DACROS STUDIO	04	0401289020001		0997656360	Flavio Alfaro y 26 de Mayo	dacros@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2024-09-12	\N	\N	0
1007	P-0550	MEXICHEM ECUADOR S.A 	04	0990003769001		043716900	Guayas Parroquia Eloy Alfaro	luis.rosas@wavin.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-13	\N	\N	0
1008	P-0551	ALVAREZ VELEZ LUCERO MISHELL	04	2100956982001		0982622236	Via lago Agrio 	alucero275@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-25	\N	\N	0
1009	P-0552	RUEDA RAMIREZ ANDREA MADELEIN	04	0401700778001		0996461976	Avda. Veintimilla y el Carrizal	andrearueda86@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-01	\N	\N	0
1010	P-0553	ENRIQUEZ BOLAÑOS VERONICA ELIZABETH	04	1003780366001		0994932733	Calle Chica Narváez 6-48 y Oviedo	divquez94@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-07	\N	\N	0
1011	P-0554	MIRANDA ARCOS JORGE FERNANDO ( JYM DISTRIBUIDOR)	04	1004633523001		0981187912	Barrio la Quinta Luis Fernando Borja 	miranda.arcos.jorge.fernando@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-15	\N	\N	0
1012	P-0555	BARONA SANCHEZ ALVARO MARTIN	04	1718129552001		09844386288	La Laguna II C12 Mzn 6	albarona93@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-22	\N	\N	0
1013	P-0556	CEVALLOS GUERRERO PEDRO JOSÉ	04	1714257993001		0984596813	Calles La Florida y Av. los Shyris	pjcevallosg1994@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-25	\N	\N	0
1014	E-0166	ANDRADE AYALA NICOLE ANDREA	05		1756021927	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-11-06	\N	\N	0
1015	P-0557	LACOV S.A 	04	1891809702001		0958781083	Tunguragua Ambato 	facelectronica@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-12	\N	\N	0
1016	P-0558	MUÑOZ BRAVO FREDDY ARTURO	04	0102087798001		0987876462	Sucre 3-12 y Tomas Ordoñez	fmunozb@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-19	\N	\N	0
1017	P-0559	DELIVERY SUMINISTROS Y SUMINISTROS CIA. LTDA. 	04	1791714032001		6003350	Francisco Salazar E1022 Y Tamayo	soce@suministrosysuministros.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-20	\N	\N	0
1018	P-0560	CUSANGUA MONTENEGRO EDWIN LUZGARDO	04	0401031810001		0999675717	Av. Cementerio	edwincusangua73@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-04	\N	\N	0
1019	P-0561	CAMPOS HERNANDEZ DANIELA NOHEMI	04	0150550291001		0744215933	Republica de Brasil 	ventas@starinktoner.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-04	\N	\N	0
1020	P-0562	ERAZO HERNANDEZ TITO JAIME 	04	1714816301001		0987335351	Carchi - Tulcan 	info.proytec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-06	\N	\N	0
1021	P-0563	ERAZO Y ERAZO CONSTRUCTORES	04	0491517085001		0991448398	Calle Parguay y Cuenca	oedwineb@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1022	P-0564	DISPRATTSA S.A.	04	0992609575001		0988573771	Cdla. Garzota Solar	facelectronica@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1023	P-0565	ORTIZ LOMAS LUIS ALFREDO	04	0400681185001		0997282643	Calle Sucre y Quito- Tulcán	luisortizing@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1024	P-0566	AMAZING - GOLDEN -CONSTRUCTIONS S.A.S 	04	0491534369001		0984056079	Calle 8 de diciembre 	patriciodoradou@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1025	P-0567	FERRICONS CIA. LTDA. 	04	0491533374001		0982683257	Calle Montúfar y Ricaurte- San Gabriel	ferri.cons.sg@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-12	\N	\N	0
1026	P-0568	ORTEGA VASQUEZ PABLO ANDRES 	04	0401323779001		0993821337	Tulcan. Av. 24 de mayo 	pabloortega2512@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-12	\N	\N	0
1027	P-0569	CONSTRULCAN S.A.S 	04	0491534227001		0986288152	Calle Jose Joaquin Olmedo	construlcanec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-13	\N	\N	0
\.


--
-- TOC entry 4927 (class 0 OID 5732641)
-- Dependencies: 222
-- Data for Name: clasificador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clasificador (idclasificador, codpar, nivpar, grupar, nompar, despar, cueejepresu, presupuesto, ejecucion, devengado, reforma, asigna_ini, grupo, balancostos, usucrea, feccrea, usumodi, fecmodi) FROM stdin;
1	1	1	0	INGRESOS CORRIENTES			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
2	11	2	1	IMPUESTOS			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
3	11.01	3	11	Sobre la Renta, Utilidades y Ganancias de Capital			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
4	11.01.01	4	11.01	A la Renta Global			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
5	11.01.02	4	11.01	A la Utilidad por la Venta de Predios Urbanos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
6	11.01.03	4	11.01	A la Utilidad por la Venta de Predios Rurales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
7	11.01.04	4	11.01	A los Juegos de Azar			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
8	11.01.99	4	11.01	A Otras Rentas, Utilidades y Beneficios de Capital			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
9	11.02	3	11	Sobre la Propiedad			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
10	11.02.01	4	11.02	A los Predios Urbanos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
11	11.02.02	4	11.02	A los Predios Rústicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
12	11.02.03	4	11.02	A la Inscripción en el Registro de la Propiedad o en el Registro Mercantil			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
13	11.02.04	4	11.02	A las Transmisiones de Dominio			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
14	11.02.05	4	11.02	De Vehículos Motorizados de Transporte Terrestre			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
15	11.02.06	4	11.02	De Alcabalas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
16	11.02.07	4	11.02	A los Activos Totales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
17	11.02.08	4	11.02	De Vehículos Motorizados de Transporte Aéreo y Acuático			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
18	11.02.10	4	11.02	A la Propiedad de Inmuebles Urbanos para Vivienda de Interés Social			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
19	11.02.99	4	11.02	Otros Impuestos Sobre la Propiedad			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
20	11.03	3	11	Al Consumo de Bienes y Servicios			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
21	11.03.01	4	11.03	Al Consumo de Cigarrillos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
22	11.03.02	4	11.03	Al Consumo de Cerveza			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
23	11.03.03	4	11.03	Al Consumo de Bebidas Gaseosas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
24	11.03.04	4	11.03	Al Consumo de Alcohol y Productos Alcohólicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
25	11.03.05	4	11.03	Al Consumo de Bienes Suntuarios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
26	11.03.11	4	11.03	A las Telecomunicaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
27	11.03.12	4	11.03	A los Espectáculos Públicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
28	11.03.99	4	11.03	Otros impuestos al Consumo de Bienes y Servicios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
29	11.04	3	11	Al Valor Agregado			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
30	11.04.01	4	11.04	Débitos del Período			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
31	11.04.02	4	11.04	Créditos del Período			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
32	11.05	3	11	Sobre el Comercio Internacional			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
33	11.05.01	4	11.05	Arancelarios a la Importación			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
34	11.05.03	4	11.05	Tarifa de Salvaguardia			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
35	11.05.10	4	11.05	0.7% de Exportaciones de Banano			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
36	11.05.99	4	11.05	Otros Impuestos al Comercio Exterior			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
37	11.06	3	11	A la Actividad Hidrocarburífera			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
38	11.06.01	4	11.06	A la Renta de Empresas Petroleras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
39	11.06.02	4	11.06	A la Renta de Empreas Petroleras de Prestación de Servicios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
40	11.06.03	4	11.06	A la Renta de Empresas Petroleras de Contratos de Servicios Específicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
41	11.06.04	4	11.06	A la Renta por Ventas Internas de Derivados del Petróleo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
42	11.06.05	4	11.06	A dicional por Barril de Crudo Exportado			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
43	11.06.06	4	11.06	Gravamen a la Tarifa de Oleoducto			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
44	11.06.07	4	11.06	A la Facturación de las Empresas Nacionales y Extranjeras de Prestación de Serv.			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
45	11.06.99	4	11.06	Otros Impuestos a la Actividad Hidrocarburífera			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
46	11.07	3	11	Impuestos Diversos			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
47	11.07.02	4	11.07	A las Tarjetas de Crédito			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
48	11.07.03	4	11.07	A las Operaciones de Crédito			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
49	11.07.04	4	11.07	Patentes Comerciales, Industriales y de Servicios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
50	11.07.05	4	11.07	A la Salida del País			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
51	11.07.06	4	11.07	Sobre Contratos de Construcción o Estudios Celebrados con el Sector Público			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
52	11.07.08	4	11.07	Al Desposte de Ganado			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
53	11.07.09	4	11.07	Sobre Reajuste de Precios en la Contratación Pública			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
54	11.07.10	4	11.07	De Loterías y Juegos de Azar			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
55	11.07.11	4	11.07	1% a la Compra de Vehículos Usados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
56	11.07.12	4	11.07	Ingreso al Parque Nacional Galápagos y a su Reserva			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
57	11.07.99	4	11.07	Otros Impuestos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
58	11.08	3	11	Impuesto Provisional Neto			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
59	11.08.01	4	11.08	Impuesto a la Renta, Impuesto y Anticipos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
60	11.08.02	4	11.08	Impuesto a la Renta, Crédito Tributario (-)			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
870	61.05.13	4	61.05	Encargos			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
61	11.08.03	4	11.08	Impuesto a la Renta, Devoluciones de Excesos de Cobros (-)			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
62	12	2	1	SEGURIDAD SOCIAL			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
63	12.01	3	12	Aportes para Seguridad Social			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
64	12.01.01	4	12.01	Aportes al Seguro de Pensiones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
65	12.01.02	4	12.01	Aportes al Fondo de Reserva			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
66	12.01.03	4	12.01	Aportes al Seguro de Cesantía			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
67	12.01.04	4	12.01	Aportes al Seguro de Riesgos del Trabajo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
68	12.01.05	4	12.01	Aportes al Seguro de Mortuoria			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
69	12.01.06	4	12.01	Subsidio por Emfermedad			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
70	12.01.07	4	12.01	Aportes al Seguro Social Campesino			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
71	12.01.08	4	12.01	Aportes Atrasados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
72	12.01.09	4	12.01	Aportes al Seguro de Salud Individual y Familiar			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
73	12.01.10	4	12.01	Aportes al Fondo de Contingencias			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
74	13	2	1	TASAS Y CONTRIBUCIONES		113.13	306750	15.1	2563.87	-46000	71664	11	\N	1	2025-01-28 10:27:52	\N	\N
75	13.01	3	13	Tasas Generales			0	0	2563.87	-46000	71664	11	\N	1	2025-01-28 10:27:52	\N	\N
76	13.01.01	4	13.01	Peaje			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
77	13.01.02	4	13.01	Acceso a Lugares Públicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
78	13.01.03	4	13.01	Ocupación de Lugares Públicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
79	13.01.04	4	13.01	Tasas Aduaneras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
80	13.01.06	4	13.01	Especies Fiscales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
81	13.01.07	4	13.01	Venta de Bases			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
82	13.01.08	4	13.01	Prestación de Servicios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
83	13.01.09	4	13.01	Rodaje de Vehículos Motorizados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
84	13.01.10	4	13.01	Control y Vigilancia Municipal			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
85	13.01.11	4	13.01	Inscripciones, Registros y Matrículas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
86	13.01.12	4	13.01	Permisos, Licencias y Patentes			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
87	13.01.13	4	13.01	Registro Sanitario y Toxicología			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
88	13.01.14	4	13.01	Servicios de Camales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
89	13.01.15	4	13.01	Fiscalización de Obras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
90	13.01.16	4	13.01	Recolección de Basura			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
91	13.01.17	4	13.01	Aferición de Pesas y Medidas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
92	13.01.18	4	13.01	Aprobación de Planos e Inspecciòn de Construcciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
93	13.01.20	4	13.01	Conexión y Reconexión del Servicio de Alcantarillado y Canalización			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
94	13.01.21	4	13.01	Conexión y Reconexión del Servicio de Agua Potale			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
95	13.01.24	4	13.01	Alumbrado Público			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
96	13.01.27	4	13.01	Matrículas, Pensiones y Otros Derechos en Educación			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
97	13.01.99	4	13.01	Otras Tasas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
98	13.02	3	13	Tasas Portuarias y Aereoportuarias			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
99	13.02.01	4	13.02	Recepción y Despacho de Naves			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
100	13.02.02	4	13.02	Uso Fondeadero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
101	13.02.03	4	13.02	Uso de Infraestructura Portuaria y Aeroportuaria			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
102	13.02.04	4	13.02	Servicios de Cabotaje			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
103	13.02.05	4	13.02	Servicios y Suministros Varios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
104	13.02.99	4	13.02	Ootras Tasas Portuarias y Aeroportuarias			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
105	13.03	3	13	Tasas Diversas			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
106	13.03.01	4	13.03	Sector Financiero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
107	13.03.02	4	13.03	Sector Inddustrial y Comercial			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
108	13.03.03	4	13.03	Sector Agropecuario			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
109	13.03.04	4	13.03	Sector Turístico y Hotelero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
110	13.03.05	4	13.03	Superficiarios Hidrocarburíferos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
111	13.03.06	4	13.03	Regalías Hidrocarburíferas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
112	13.03.07	4	13.03	Superficiarios Mineros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
113	13.03.08	4	13.03	Regalías Mineras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
114	13.03.09	4	13.03	Derechos Consulares			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
115	13.03.10	4	13.03	Concesiones Aéreas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
116	13.03.11	4	13.03	Concesiones Portuarias			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
117	13.03.12	4	13.03	Concesiones en el Sector  de las Telecomunicaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
118	13.03.13	4	13.03	Concesiones en el Sector Eléctrico			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
119	13.03.14	4	13.03	Conncesiones Viales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
120	13.03.15	4	13.03	Concesiones Hidrocarburíferas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
121	13.03.99	4	13.03	Otras Concesiones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
122	13.04	3	13	Contribuciones			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
123	13.04.01	4	13.04	Sobre Nóminas de Empresas Privadas y Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
124	13.04.03	4	13.04	Contribuciones de las Compañías y las Entidades Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
125	13.04.04	4	13.04	Contribución en Contratos Sujetos a Licitaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
126	13.04.05	4	13.04	Sobre Contratos de Consultoría			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
127	13.04.06	4	13.04	Apertura, Pavimentación, Ensanche y Construcción de Vías de Toda Clase			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
128	13.04.07	4	13.04	Repavimentación Urbana			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
129	13.04.08	4	13.04	Aceras, Bordillos y Cercas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
130	13.04.09	4	13.04	Obras de Alcantarillado y Canalización			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
131	13.04.10	4	13.04	Obras de Alumbrado Público			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
132	13.04.11	4	13.04	Construcción y Ampliación de Obras y Sistemas de Agua Potable			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
133	13.04.12	4	13.04	Desecación de Pantanos y Rellenos de Quebradas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
134	13.04.13	4	13.04	Obras de Regeneración Urbana			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
135	13.04.99	4	13.04	Otras Contribuciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
136	14	2	1	VENTA DE BIENES Y SERVICIOS		113.14	2175799.2	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
137	14.01	3	14	Ventas de Derivados de Petróleo			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
138	14.01.06	4	14.01	Exportaciones de Derivados del Petróleo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
139	14.01.07	4	14.01	Ventas Internas de Derivados del Petróleo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
140	14.01.08	4	14.01	Tarifa de Transporte de Petróleo por el SOTE			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
141	14.01.10	4	14.01	Fondo de Inversión Petrolera			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
142	14.01.13	4	14.01	Fondo de Estabilización Petrolera			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
143	14.01.99	4	14.01	Otros No Especificados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
144	14.02	3	14	Ventas de Productos y Materiales			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
145	14.02.01	4	14.02	Agropecuarios y Forestales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
146	14.02.02	4	14.02	Industriales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
147	14.02.03	4	14.02	Del Mar			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
148	14.02.04	4	14.02	De Oficina, Didácticos y Publicaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
149	14.02.05	4	14.02	De Instrumental Médico Menor, Insumos Médicos y Medicinas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
150	14.02.06	4	14.02	Materiales y Accesorios de Instalaciones de Agua Potable			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
151	14.02.07	4	14.02	Materiales y Accesorios de Alcantarillado y Canalización			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
152	14.02.10	4	14.02	Materilaes de Construcción			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
153	14.02.99	4	14.02	Otras Ventas de Productos y Materiales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
154	14.03	3	14	Ventas no Industriales			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
155	14.03.01	4	14.03	Agua Potable			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
156	14.03.02	4	14.03	Agua de Riego			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
157	14.03.03	4	14.03	Alcantarillado			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
158	14.03.04	4	14.03	Energía Eléctrica			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
159	14.03.05	4	14.03	Telecomunicaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
160	14.03.06	4	14.03	De Correos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
161	14.03.07	4	14.03	Transporte Nacional de Pasajeros y Carga			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
162	14.03.08	4	14.03	Transporte Internacional de Pasajeros y Carga			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
163	14.03.09	4	14.03	Opèraciones Interlineales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
164	14.03.10	4	14.03	De Espectáculos Públicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
165	14.03.11	4	14.03	Financieros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
166	14.03.12	4	14.03	Tarjetas VIP			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
167	14.03.99	4	14.03	Otros Servicios Técnicos y Especializados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
168	14.04	3	14	Ventas de Desechos y Residuos			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
169	14.04.01	4	14.04	Agropecuarios y Forestales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
170	14.04.02	4	14.04	Industriales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
171	14.04.03	4	14.04	De Productos del Mar			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
172	14.09	3	14	Débitos por Impuesto al Valor Agregado			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
173	14.09.01	4	14.09	Débito Fiscal por Ventas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
174	17	2	1	RENTAS DE INVERSIONES Y MULTAS		113.17	26480	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
175	17.01	3	17	Rentas de Inversiones			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
176	17.01.01	4	17.01	Intereses por Depósitos a Plazo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
177	17.01.02	4	17.01	Intereses y Comisiones de Títulos y Valores			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
178	17.01.03	4	17.01	Intereses y Comisiones de Riesgo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
179	17.01.04	4	17.01	Reajustes de Inversiones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
180	17.01.05	4	17.01	Diferencial Cambiario			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
181	17.01.06	4	17.01	Dividendos de Sociedades y Empresas Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
182	17.01.07	4	17.01	Dividendos de Sociedades y Empreas Privadas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
183	17.01.08	4	17.01	Utilidades de Empresas y Entidades Financieras Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
184	17.01.09	4	17.01	Comisiones por Servicios Financieros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
185	17.01.10	4	17.01	Cargos por Operaciones Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
186	17.01.11	4	17.01	Primas por Seguros de Desgravamen y de Saldos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
187	17.01.12	4	17.01	Descuentos Obtenidos en Inversiones Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
188	17.01.99	4	17.01	Intereses por Otras Operciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
189	17.02	3	17	Rentas por Arrendamientos de Bienes			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
190	17.02.01	4	17.02	Terrenos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
191	17.02.02	4	17.02	Edificios, Locales y Residencias			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
192	17.02.03	4	17.02	Mobiliarios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
193	17.02.04	4	17.02	Maquinarias y Equipos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
194	17.02.05	4	17.02	Vehículos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
195	17.02.06	4	17.02	Herramientas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
196	17.02.07	4	17.02	Equipos, Sistemas y Paquetes Informáticos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
197	17.02.15	4	17.02	Bienes Biológicos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
198	17.02.99	4	17.02	Otros Arrendamientos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
199	17.03	3	17	Intereses por Mora			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
200	17.03.01	4	17.03	Tributaria			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
201	17.03.02	4	17.03	Ordenanzas Municipales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
202	17.03.03	4	17.03	Ordenanzas Provinciales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
203	17.03.05	4	17.03	Obligaciones a la Seguridad Social			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
204	17.03.06	4	17.03	Transacciones Comerciales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
205	17.03.99	4	17.03	Otros Intereses por Mora			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
206	17.04	3	17	Multas			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
207	17.04.01	4	17.04	Tributarias			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
208	17.04.02	4	17.04	Infración a Ordenanzas Municipales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
209	17.04.03	4	17.04	Infracción a Oredenanzas Municipales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
210	17.04.04	4	17.04	Incumplimientos de Contratos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
211	17.04.05	4	17.04	Infracciones a la Seguridad Social			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
212	17.04.06	4	17.04	Cheques Protestados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
213	17.04.07	4	17.04	Innfracciones a la Ley Orgánica de Defensa del Consumidor			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
214	17.04.99	4	17.04	Otras Multas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
215	18	2	1	TRANSFERENCIAS Y DONACIONES CORRIENTES			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
216	18.01	3	18	Transferencias Corrientes del Sector Público			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
217	18.01.01	4	18.01	Del Gobierno Central			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
218	18.01.02	4	18.01	De Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
219	18.01.03	4	18.01	De Empresas Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
220	18.01.04	4	18.01	De Entidades del Gobierno Seccional			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
221	18.01.05	4	18.01	De la Seguridad Social			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
222	18.01.06	4	18.01	De Entidades Financieras Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
223	18.01.08	4	18.01	De Cuentas o Fondos Especiales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
224	18.01.09	4	18.01	De Fondos de Uso Reservado			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
225	18.01.10	4	18.01	De Fondos de Contingencia			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
226	18.02	3	18	Donaciones Corrientes del Sector Privado Interno			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
227	18.02.03	4	18.02	Del Sector Privado Financiero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
228	18.02.04	4	18.02	Del Sector Privado No Financiero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
229	18.03	3	18	Donaciones Corrientes del Sector Externo			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
230	18.03.01	4	18.03	De Organismos Multilaterales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
231	18.03.02	4	18.03	De Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
232	18.03.03	4	18.03	Del Sector Privado Financiero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
233	18.03.04	4	18.03	Del Sector Privado No Financiero			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
234	18.04	3	18	Aportes y Participaciones del Sector Público			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
235	18.04.01	4	18.04	De la Actividad Hidrocarburífera, Excepto para Universidades y Escuelas Polit.			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
236	18.04.02	4	18.04	De Impuestos y Exportaciones de Crudo para Universidades y Escuelas Politécnicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
237	18.04.03	4	18.04	De Empresas Públicas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
238	18.04.04	4	18.04	De la Participación en Impuestos no Petroleros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
239	18.04.05	4	18.04	De Planillas de Telecomunicaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
240	18.04.07	4	18.04	De Fondos Ajenos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
241	18.04.08	4	18.04	De Cuentas y Fondos Especiales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
242	18.04.11	4	18.04	Rendimientos de los Sistemas Contables del Banco Centarl del Ecuador			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
243	18.04.14	4	18.04	Aportes Sobre Depósitos en Instituciones Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
244	18.04.15	4	18.04	Depósitos Inmobilizados en Instituciones Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
245	18.04.99	4	18.04	Otras Participaciones y Aportes			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
246	18.05	3	18	Subsidios			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
247	18.05.01	4	18.05	De Precios del Sector Público			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
248	18.05.03	4	18.05	De Tarifas del Sector Público			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
249	18.06	3	18	APORTES Y PARTICIPACIONES CORRIENTES DEL RÉGIMEN SECCIONAL AUTÓNOMO			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
250	18.06.01	4	18.06	De Compensaciones a Municipios por Leyes y Decretos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
251	18.06.02	4	18.06	De Compensaciones Consejos Provinciales por Leyes y Decretos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
252	18.06.04	4	18.06	Del FODESEC a Municipios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
253	18.06.05	4	18.06	Del FODESEC a Consejos Provinciales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
254	18.06.06	4	18.06	Del FODESEC al INGALA			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
255	18.06.07	4	18.06	Del FODESEC al CONCOPE			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
256	18.06.08	4	18.06	Aportes a Juntas Parroquiales Rurales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
257	18.06.10	4	18.06	Del FONDEPRO al CONCOPE			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
258	18.06.16	4	18.06	Del Fondo de Decentralización a Municipios			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
259	18.06.17	4	18.06	Del Fondo de Decentralización a Consejos Provinciales			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
260	18.07	3	18	Participaciones Corrientes de la Fuente Fiscal del Presupuesto ddel Gobierno Cen			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
261	18.07.01	4	18.07	De Exportaciones de Derivados de Petróleo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
262	18.07.02	4	18.07	De la Venta Interna de Derivados de Petróleo			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
263	18.07.03	4	18.07	De la Tarifa del Oleoducto de Empresas Privadas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
264	18.07.04	4	18.07	Del Fondo de Inversión Petrólera, 10% Exportación Directa de Crudo y Derivados y			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
265	18.07.05	4	18.07	Del Fondo de Inversión Petrolera de la Venta Interna de Derivados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
266	18.07.08	4	18.07	De Compensación Obligaciones Tributarias Bloque 15			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
267	18.07.09	4	18.07	Del Fondo de Estabilización Petrolera			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
268	18.07.10	4	18.07	De la Participación por Exportaciones de Crudo Ex-Consorcio			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
269	18.07.99	4	18.07	Otros no Especilizados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
270	18.08	3	18	Participaciones Corrientes de los Entes Públicos en los Ingresos Petroleros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
271	18.08.01	4	18.08	Participaciones Corrientes en los Ingresos Petroleros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
272	18.09	3	18	Prticipaciones Corrientes del Sector Público en Presignaciones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
273	18.09.01	4	18.09	Participaciones Corrientes en Presignaciones Establecidas por Ley			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
274	19	2	1	OTROS INGRESOS		113.19	500	0	22737.9	130939.63	12402.45	11	\N	1	2025-01-28 10:27:52	\N	\N
275	19.01	3	19	Garantías y Fianzas			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
276	19.01.01	4	19.01	Ejecución de Garantías			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
277	19.01.02	4	19.01	Ejecución de Fianzas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
278	19.02	3	19	Indemnizaciones y Valores no Reclamados			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
279	19.02.01	4	19.02	Indemnizaciones por Siniestros			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
280	19.02.02	4	19.02	Premios no Reclamados de Sorteos			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
281	19.02.99	4	19.02	Otras Indemnizaciones y Valores no Reclamados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
282	19.03	3	19	Remates de Bienes y Especies			0	0	0	0	0	11	\N	1	2025-01-28 10:27:52	\N	\N
283	19.03.01	4	19.03	Bienes y Especies Decomisadas			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
284	19.04	3	19	Otros no Operacionales			0	0	22737.9	130939.63	12402.45	11	\N	1	2025-01-28 10:27:52	\N	\N
285	19.04.01	4	19.04	Comisiones			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
286	19.04.03	4	19.04	Prima de Riego de Instituciones Financieras			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
287	19.04.99	4	19.04	Otros no Especificados			0	0	\N	\N	\N	11	\N	1	2025-01-28 10:27:52	\N	\N
288	2	1	0	INGRESOS DE CAPITAL			0	0	0	0	485200	22	\N	1	2025-01-28 10:27:52	\N	\N
289	24	2	2	VENTA DE ACTIVOS DE LARGA DURACION			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
290	24.01	3	24	Bienes Muebles			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
291	24.01.03	4	24.01	Mobiliarios			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
292	24.01.04	4	24.01	Maquinarias y Equipos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
293	24.01.05	4	24.01	Vehículos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
294	24.01.06	4	24.01	Herramientas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
295	24.01.07	4	24.01	Equipos, Sistemas y Paquetes Informáticos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
296	24.01.08	4	24.01	Bienes Artísticos y Culturales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
297	24.01.09	4	24.01	Libros y Colecciones			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
298	24.02	3	24	Bienes Inmuebles			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
299	24.02.01	4	24.02	Terrenos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
300	24.02.02	4	24.02	Edificios, Locales y Residencias			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
301	24.02.99	4	24.02	Otros Bienes Inmuebles			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
302	24.03	3	24	Bienes Biológicos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
303	24.03.12	4	24.03	Semovientes			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
304	24.03.13	4	24.03	Bosques			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
305	24.03.14	4	24.03	Acuáticos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
306	24.03.15	4	24.03	Plantas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
307	24.03.99	4	24.03	Otros Bienes Biológicos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
308	24.04	3	24	Intangibles			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
309	24.04.01	4	24.04	Intangibles			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
310	24.05	3	24	EXPORTACIONES DE PETRÓLEO CRUDO			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
311	24.05.01	4	24.05	Exportaciones de Petróleo de PETROECUADOR Ex-Consorcio			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
312	24.05.02	4	24.05	Exportaciones de Petróleo de PETROECUADOR de Nororiente			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
313	24.05.03	4	24.05	Exportaciones de Petróleo de Contratos de Prestación de Servicios			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
314	24.05.04	4	24.05	Exportaciones de Petroleo de Regalías			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
315	24.05.06	4	24.05	Exportaciones de Petróleo de Contratos de Participación			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
316	24.05.07	4	24.05	Exportaciones de Petróleo de Contratos de Campos Marginales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
317	24.05.08	4	24.05	Exportaciones de Petróleo de Contratos de Alianzas Operativas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
318	24.05.09	4	24.05	Exportaciones de Petróleo por Diferencial de Calidad			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
319	24.05.11	4	24.05	Exportaciones de Petróleo de Contratos de Servicios Específicos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
320	24.05.12	4	24.05	Exportaciones de Petróleo de Hasta 23 Grados API			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
321	24.05.99	4	24.05	Otros No Especificados			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
322	27	2	2	RECUPERACION DE INVERSIONES			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
323	27.01	3	27	Recuperación de Inversiones en Títulos y Valores			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
324	27.01.01	4	27.01	Certificados del Tesoro Nacional			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
325	27.01.02	4	27.01	Bonos del Estado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
326	27.01.03	4	27.01	Depósitos a Plazo, Moneda de Curso Legal			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
327	27.01.04	4	27.01	Venta de Acciones			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
328	27.01.06	4	27.01	Venta de Participaciones de Capital			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
329	27.01.07	4	27.01	Recuperación de Participaciones Fiduciarias			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
330	27.01.98	4	27.01	Otros Títulos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
331	27.01.99	4	27.01	Otros Valores			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
332	27.02	3	27	Recuperación de Préstamos			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
333	27.02.01	4	27.02	Gobierno Central			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
334	27.02.02	4	27.02	Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
335	27.02.03	4	27.02	Empresas Públicas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
336	27.02.04	4	27.02	Entidades del Gobierno Seccional			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
337	27.02.05	4	27.02	Seguridad Social			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
338	27.02.06	4	27.02	Entidades Financieras Públicas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
339	27.02.07	4	27.02	Sector Privado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
340	27.02.11	4	27.02	Servidores Públicos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
341	27.02.13	4	27.02	Cotratistas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
342	27.03	3	27	Recuperación de Inverciones Permanentes en Título y Valores			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
343	27.03.01	4	27.03	Certificados del Tesoro Nacional			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
344	27.03.02	4	27.03	Bonos del Estado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
345	27.03.04	4	27.03	Ventas de Acciones			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
346	27.03.06	4	27.03	Venta de Participaciones de Capital			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
347	27.03.07	4	27.03	Participaciones Fiduciarias			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
348	27.03.98	4	27.03	Otros Títulos			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
349	27.03.99	4	27.03	Otros Valores			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
350	28	2	2	TRANSFERENCIAS Y DONACIONES DE CAPITAL		113.28	199000	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
351	28.01	3	28	Transferencias de Capital del Sector Público			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
352	28.01.01	4	28.01	Del Gobierno Central			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
353	28.01.02	4	28.01	De Entidades Decentralizadas y Autónomas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
354	28.01.03	4	28.01	De Empresas Públicas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
355	28.01.04	4	28.01	De Entidades del Gobierno Seccional			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
356	28.01.05	4	28.01	De la Seguridad Social			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
357	28.01.06	4	28.01	De Entidades Financieras Públicas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
358	28.01.08	4	28.01	De Cuentas o Fondos Especiales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
359	28.01.10	4	28.01	De Fondos de Contingencias			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
360	28.02	3	28	Donaciones de Capital del Sector Privado Interno			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
361	28.02.03	4	28.02	Del Sector Privado Financiero			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
362	28.02.04	4	28.02	Del Sector Privado no Financiero			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
363	28.03	3	28	Donaciones de Capital del Sector Externo			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
364	28.03.01	4	28.03	De Organismos Multilaterales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
365	28.03.02	4	28.03	De Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
366	28.03.03	4	28.03	Del Sector Privado Financiero			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
367	28.03.04	4	28.03	Del Sector Privado no Financiero			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
368	28.04	3	28	Aportes y Participaciones del Sector Público			0	0	0	0	0	22	\N	1	2025-01-28 10:27:52	\N	\N
369	28.04.01	4	28.04	Del Fondo de Inversión Petrolera			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
370	28.04.02	4	28.04	De Exportación de Hidrocarburos y Derivados			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
371	28.04.08	4	28.04	De Cuentas y Fondos Especiales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
372	28.04.99	4	28.04	Otras Participaciones y Aportes			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
373	28.06	3	28	Aportes y Participaciones de Capital e Inversión del Régimen Seccional Autónomo			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
374	28.06.03	4	28.06	Del FODESEC al Fondo de Inversiones Municipales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
375	28.06.04	4	28.06	Del FODESEC a Municipios			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
376	28.06.05	4	28.06	Del FODESEC a Consejos Provinciales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
377	28.06.06	4	28.06	Del FODESEC al INGALA			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
378	28.06.09	4	28.06	Aporte según Ley 47 y su Reforma			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
379	28.06.11	4	28.06	Del FONDEPRO Aporte a Consejos Provinciales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
380	28.06.12	4	28.06	Del FONDEPRO Aporte al INGALA			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
381	28.06.13	4	28.06	Del FONDEPRO a Consejos Provincailes a Través del Banco del Estado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
382	28.06.14	4	28.06	Del FONDEPRO al INGALA a Través del Banco del Estado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
383	28.06.16	4	28.06	Del Fondo de Decentralización a Municipios			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
384	28.06.17	4	28.06	Del Fondo de Decentralización a Consejos Provinciales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
385	28.07	3	28	Participaciones de Capital de la Fuente Fiscal delo Presupuesto del Gobierno Cen			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
386	28.07.01	4	28.07	De Regalías de Petroecuador			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
387	28.07.02	4	28.07	De Regalías del Estado			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
388	28.07.03	4	28.07	De Regalías de Campos Marginales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
389	28.07.04	4	28.07	De Regalías de Alianzas Operativas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
390	28.07.05	4	28.07	De Exportaciones Directas de PetroecuadorEx-Consorcio			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
391	28.07.06	4	28.07	De Exportaciones Directas de Petroecuador Nororiente 28			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
392	28.07.07	4	28.07	De Exportaciones de Crudo Participación con City Oriente Bloque 27			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
393	28.07.08	4	28.07	De Exportaciones de Crudo Perticipación con YPF Bloque 16 y CAPIRON			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
394	28.07.09	4	28.07	De Exportaciones de Crudo Participación con Canadá Grande Bloque 1			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
395	28.07.10	4	28.07	De Exportaciones de Crudo Particippación con PERENCO Campo Payamino y Bloq.7 y27			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
396	28.07.11	4	28.07	De Exportaciones de Crudo Participación con Occidental Lim. y Bloque 15 y Edén Y			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
397	28.07.12	4	28.07	De Exportaciones de Crudo Participación Petroriental(Ex- ENCANADA) Bloq. 14 y 17			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
398	28.07.13	4	28.07	De Exportaciones de Crudo Participación con Ecuador TLC Bloq. 18 y Campo Compart			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
399	28.07.14	4	28.07	De Exportaciones de Crudo Participación con CNPC Bloq. 11 Cristal Rubí			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
400	28.07.15	4	28.07	De Exportaciones Directas de Campos Marginales			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
401	28.07.16	4	28.07	De Exportaciones Directas de Alianzas Operativas			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
402	28.07.17	4	28.07	De Exportaciones Directas de Diferencial de Calidad			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
403	28.07.19	4	28.07	De Exportaciones Directas de Compañias de Presentación de Servicios			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
404	28.07.20	4	28.07	De Exportaciones Directas d Compañias de Prestación de Servicios Especificos Tiv			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
405	28.07.21	4	28.07	De Participación de Excedentes de Precios de Contratos Pegroleros con Andes Petr			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
406	28.07.22	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros City  Oriental			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
407	28.07.23	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros  con Perenco 7			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
408	28.07.24	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros con Petrorient			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
409	28.07.25	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros con REPSOL YPF			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
410	28.07.26	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros con Ecuador TL			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
411	28.07.27	4	28.07	De Participación de Excedentes de Precios de Contratos Petroleros con Canadá Gra			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
412	28.08	3	28	Participaciones de Capital de los Entes Públicos en los Ingresos Petroleros			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
413	28.08.01	4	28.08	Participaciones de Capital en Los Ingresos Petroleros			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
414	28.09	3	28	Participaciones de Capital del Sector Público en Preasignaciones			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
415	28.09.01	4	28.09	Participaciones de Capital en Preasignaciones Establecidas por Ley			0	0	\N	\N	\N	22	\N	1	2025-01-28 10:27:52	\N	\N
416	3	1	0	INGRESOS DE FINANCIAMIENTO			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
417	36	2	3	FINANCIAMIENTO PUBLICO		113.36	600000	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
418	36.01	3	36	Colocación de Títulos y Valores			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
419	36.01.01	4	36.01	Certificados del Tesoro Nacional			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
420	36.01.02	4	36.01	Bonos del Estado			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
421	36.01.98	4	36.01	Otros Títulos			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
422	36.01.99	4	36.01	Otros  Valores			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
423	36.02	3	36	Financiamiento Público Interno			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
424	36.02.01	4	36.02	Del Sector Público Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
425	36.02.02	4	36.02	Del Sector Público No Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
426	36.02.03	4	36.02	Del Sector Privado Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
427	36.02.04	4	36.02	Del Sector Privado No Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
428	36.02.05	4	36.02	De la Seguridad Social			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
429	36.03	3	36	Financiamiento Público Externo			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
430	36.03.01	4	36.03	De Organismos Multilaterales			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
431	36.03.02	4	36.03	De Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
432	36.03.03	4	36.03	Del Sector Privado Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
433	36.03.04	4	36.03	Del Sector Privado No Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
434	36.04	3	36	Descuentos en Títulos y Valores			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
435	36.04.01	4	36.04	Descuentos en Certificados de Tesoreria			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
436	36.04.02	4	36.04	Descuentos en Bonos del Estado			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
437	36.05	3	36	Crédito de Proveedores Internos			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
438	36.05.02	4	36.05	Del Sector Público no Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
439	36.05.04	4	36.05	Del Sector Privado no Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
440	36.06	3	36	Créditos de Proveedores Externos			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
441	36.06.04	4	36.06	Del Sector Privado no Financiero			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
442	37	2	3	Saldos Disponibles		37	70000	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
443	37.01	3	37	Saldos en Caja y Bancos			0	0	0	0	0	33	\N	1	2025-01-28 10:27:52	\N	\N
444	37.01.01	4	37.01	De Fondos del Gobierno Central			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
445	37.01.02	4	37.01	De Fondos de Autogestión			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
446	37.01.03	4	37.01	De Fondos Preasignados			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
447	37.01.04	4	37.01	De Prestamos			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
448	37.01.99	4	37.01	Otros Saldos			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
449	38	2	3	Cuentas por Cobrar		113.97	77850	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
450	38.01	3	38	Cuentas Pendientes  por Cobrar			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
451	38.01.01	4	38.01	De Cuentas por Cobrar			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
452	38.01.02	4	38.01	De Anticipos de Fondos			0	0	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
453	38.01.07	4	38.01	ANTICIPOS DE AÑOS ANTERIORES			\N	\N	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
454	38.01.08	4	38.01	ANTICIPOS AÑOS ANTERIORES OBRAS			\N	\N	\N	\N	\N	33	\N	1	2025-01-28 10:27:52	\N	\N
455	5	1	0	GASTOS CORRIENTES			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
456	51	2	5	GASTOS EN PERSONAL		213.51	692096.4	519.38	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
457	51.01	3	51	Remuneraciones Básicas			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
458	51.01.01	4	51.01	Sueldos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
459	51.01.02	4	51.01	Salarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
460	51.01.03	4	51.01	Jornales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
461	51.01.05	4	51.01	Remuneraciones Unificadas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
462	51.01.06	4	51.01	Salarios Unificados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
463	51.01.07	4	51.01	Haber Militar y Policial			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
464	51.02	3	51	Remuneraciones Complementarias			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
465	51.02.01	4	51.02	Bonificación por Años de Servicio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
466	51.02.02	4	51.02	Bonificación por Responsabilidad			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
467	51.02.03	4	51.02	Decimotercer Sueldo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
468	51.02.04	4	51.02	Decimocuarto Sueldo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
469	51.02.05	4	51.02	Decimoquinto Sueldo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
470	51.02.06	4	51.02	Decimosexto Sueldo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
471	51.02.07	4	51.02	Bonificación Complementaria			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
472	51.02.08	4	51.02	Bonificación por Títulos Académicos, Especializaciones y Capacitación Adicional			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
473	51.02.09	4	51.02	Gastos de Representación			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
474	51.02.10	4	51.02	Sobresueldos y Bonificaciones Adicionales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
475	51.02.11	4	51.02	Estímulo Pecuniario			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
476	51.02.12	4	51.02	Bonificación de Aniversario			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
477	51.02.13	4	51.02	Aguinaldo Navideño			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
478	51.02.14	4	51.02	Porcentaje Funcional			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
479	51.02.15	4	51.02	Adicional sobre la Décima Categoría			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
480	51.02.16	4	51.02	Estímulo Económico Magisterio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
481	51.02.18	4	51.02	Bonificación Mensual Galápagos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
482	51.02.20	4	51.02	Bonificación Fronteriza			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
483	51.02.23	4	51.02	Bonificación por el Día del Médico			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
484	51.02.24	4	51.02	Bonificación por el Día Mudial de la Salud			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
485	51.02.25	4	51.02	Bonoficación para los Profesionales de la Salud			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
486	51.02.27	4	51.02	Adicional Región Amazónica			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
487	51.02.28	4	51.02	Remuneración Suplementaria Galápagos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
488	51.02.29	4	51.02	Actividad Extracurricular Galápagos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
489	51.02.30	4	51.02	Bonificación por el Día del Maestro			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
490	51.02.31	4	51.02	Bonificación por el Día del Servidor Público			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
491	51.02.32	4	51.02	Bonificación para Educadores Comunitarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
492	51.02.33	4	51.02	Bonificación para Profesionales Amparados o no por Leyes de Escalafón			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
493	51.02.34	4	51.02	Bonificación  Adicional Galápagos, Servidores de la LOSCA			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
494	51.02.35	4	51.02	Remuneracion variable por eficiencia			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
495	51.03	3	51	Remuneraciones Compensatorias			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
496	51.03.01	4	51.03	Gastos de Residencia			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
497	51.03.02	4	51.03	Subsidio por Circunstancias Geográficas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
498	51.03.03	4	51.03	Conpensación por Costo de Vida			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
499	51.03.04	4	51.03	Compensación por Transporte			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
500	51.03.05	4	51.03	Compensación en el Exterior			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
501	51.03.06	4	51.03	Refrigerio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
502	51.03.07	4	51.03	Comisariato			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
503	51.03.08	4	51.03	Compensación Pedagógica			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
504	51.03.09	4	51.03	Compensación por Trabajo de Alto Riesgo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
505	51.03.10	4	51.03	Subsidio Profesores Escuelas Fisc,Mision y Fiscom de las Reg.Amazónica e Insul			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
506	51.04	3	51	Subsidios			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
507	51.04.01	4	51.04	Por Cargas Familiares			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
508	51.04.02	4	51.04	De Educación			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
509	51.04.03	4	51.04	Por Maternidad			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
510	51.04.04	4	51.04	Por Fallecimiento			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
511	51.04.05	4	51.04	Por Guardería			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
512	51.04.06	4	51.04	Por Vacaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
513	51.04.07	4	51.04	Estimulo Economico por Años de Servicio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
514	51.04.08	4	51.04	Subsidio de Antiguedad			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
515	51.04.99	4	51.04	Otros Subsidios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
516	51.05	3	51	Remuneraciones Temporales			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
517	51.05.01	4	51.05	Sueldos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
518	51.05.03	4	51.05	Jornales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
519	51.05.04	4	51.05	Encargos y Subrogaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
520	51.05.05	4	51.05	Sustituciones de Personal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
521	51.05.06	4	51.05	Licencia Remunerada			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
522	51.05.07	4	51.05	Honorarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
523	51.05.08	4	51.05	Dietas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
524	51.05.09	4	51.05	Horas Extraordinarias y Suplementarias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
525	51.05.10	4	51.05	Servicios Personales por Contrato			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
526	51.05.11	4	51.05	Remuneraciones Especiales Sección Nocturna			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
527	51.05.12	4	51.05	Subrogación			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
528	51.05.13	4	51.05	Encargos			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
529	51.06	3	51	Aportes Patronales a la Seguridad Social			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
530	51.06.01	4	51.06	Aporte Patronal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
531	51.06.02	4	51.06	Fondo de Reserva			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
532	51.06.03	4	51.06	Jubilación Patronal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
533	51.06.04	4	51.06	Cesantía Privada			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
534	51.06.05	4	51.06	Jubilación Privada			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
535	51.06.06	4	51.06	ignación Global de Jubilación Patronal para Trabajadores Amparados por el Código			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
536	51.07	3	51	Indemnizaciones			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
537	51.07.02	4	51.07	Supresion de Puestos			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
538	51.07.03	4	51.07	Despido Intempestivo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
539	51.07.04	4	51.07	Compensación por Desahucio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
540	51.07.05	4	51.07	Restitución de Puesto			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
541	51.07.06	4	51.07	Por Jubilación			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
542	51.07.07	4	51.07	Compensación por Vacaciones no Gozadas por Cesación de Funciones			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
543	51.07.99	4	51.07	Otras Indemnizaciones Laborales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
544	51.99	3	51	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
545	51.99.01	4	51.99	Asignación a Distribuir en Gastos en Personal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
546	52	2	5	PRESTACIONES DE LA SEGURIDAD SOCIAL			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
547	52.01	3	52	Prestaciones			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
548	52.01.01	4	52.01	Pensiones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
549	52.01.02	4	52.01	Seguro Social Campesino			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
550	52.01.03	4	52.01	Seguro de Enfermedad y Maternidad			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
551	52.01.04	4	52.01	Seguro y Cooperativa Mortuoria			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
552	52.01.05	4	52.01	Seguro de Cesantía			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
553	52.01.06	4	52.01	Seguro de Vida y Riesgos Profesionales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
554	52.01.07	4	52.01	Fondos de Vivienda			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
555	52.01.08	4	52.01	Fondo de Contingencias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
556	52.01.09	4	52.01	Fondo de Reserva			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
557	52.01.11	4	52.01	Pensiones de Jubilación Patronal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
558	52.01.99	4	52.01	Otros Gastos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
559	52.99	3	52	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
560	52.99.01	4	52.99	Asignación a Distribuir para Prestaciones de la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
561	53	2	5	BIENES Y SERVICIOS DE CONSUMO		213.53	137230	52186.61	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
562	53.01	3	53	Servicios Básicos			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
563	53.01.01	4	53.01	Agua Potable			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
564	53.01.02	4	53.01	Agua de Riego			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
565	53.01.04	4	53.01	Energía Electrica			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
566	53.01.05	4	53.01	Telecomunicaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
567	53.01.06	4	53.01	Servicio de Correo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
568	53.02	3	53	Servicios Generales			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
569	53.02.01	4	53.02	Transporte de Personal			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
570	53.02.02	4	53.02	Fletes y Maniobras			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
571	53.02.03	4	53.02	Almacenamiento, Embalaje y Envase			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
572	53.02.04	4	53.02	Edición, Impresión, Reproducción y Publicaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
573	53.02.05	4	53.02	Espectáculos Culturales y Sociales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
574	53.02.06	4	53.02	Eventos Públicos y Oficiales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
575	53.02.07	4	53.02	Difusión, Información y Publicidad			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
576	53.02.08	4	53.02	Servicio de Vigilancia			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
577	53.02.09	4	53.02	Servicio de Aseo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
578	53.02.10	4	53.02	Servicio de Guardería			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
579	53.02.12	4	53.02	Investigaciones profesionales y analisis de laboratorio			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
580	53.02.18	4	53.02	Servicios de Publicidad y Propaganda en Medios de Comunicación Masiva			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
581	53.02.21	4	53.02	Servicios Personales Eventuales sin Relación de Dependencia 			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
582	53.02.26	4	53.02	Servicios Médicos Hospitalarios y Complementarios			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
583	53.02.49	4	53.02	Eventos Públicos Promocionales 			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
584	53.02.55	4	53.02	OJO NOMBRE			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
585	53.02.99	4	53.02	Otros Servicios Generales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
586	53.03	3	53	Traslados, Instalaciones, Viáticos y Subsistencias			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
587	53.03.01	4	53.03	Pasajes al Interior			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
588	53.03.02	4	53.03	Pasajes al Exterior			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
589	53.03.03	4	53.03	Viáticos y Subsistencias en el Interior			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
590	53.03.04	4	53.03	Viáticos y Subsistencias en el Exterior			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
591	53.03.05	4	53.03	Mudanzas e Instalaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
592	53.04	3	53	Instalación, Mantenimiento y Reparación			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
593	53.04.01	4	53.04	Terrenos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
594	53.04.02	4	53.04	Edificios, Locales y Residencias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
595	53.04.03	4	53.04	Mobiliarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
596	53.04.04	4	53.04	Maquinarias y Equipos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
597	53.04.05	4	53.04	Vehículos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
598	53.04.06	4	53.04	Herramientas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
599	53.04.08	4	53.04	Bienes Artísticos y Culturales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
600	53.04.09	4	53.04	Libros y Colecciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
601	53.04.10	4	53.04	Bienes de Uso Bélico y de Seguridad Pública			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
602	53.04.15	4	53.04	Bienes Biológicos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
603	53.04.17	4	53.04	Infraestructura			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
604	53.04.18	4	53.04	Mantenimiento de Areas verdes y Arreglo de vias Internas			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
605	53.04.20	4	53.04	Instalación Mantenimiento y Reparacionde Edificios Locales y Residencias Publica			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
606	53.04.99	4	53.04	Otras Instalaciones, Mantenimientos y Reparaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
607	53.05	3	53	Arrendamientos de Bienes			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
608	53.05.01	4	53.05	Terrenos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
609	53.05.02	4	53.05	Edificios, Locales y Residencias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
610	53.05.03	4	53.05	Mobiliarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
611	53.05.04	4	53.05	Maquinarias y Equipos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
612	53.05.05	4	53.05	Vehículos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
613	53.05.06	4	53.05	Herramientas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
614	53.05.15	4	53.05	Bienes Biológicos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
615	53.05.99	4	53.05	Otros Arrendamientos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
616	53.06	3	53	Contrataciones de Estudios e Investigaciones			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
617	53.06.01	4	53.06	Consultoría de Estudios e Insvestigaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
618	53.06.02	4	53.06	Servicio de Auditoría			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
619	53.06.03	4	53.06	Servicio de Capacitación			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
620	53.06.04	4	53.06	Fiscalización e Inspecciones Técnicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
621	53.06.05	4	53.06	Estudio y Diseño de Proyectos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
622	53.06.07	4	53.06	Servicios Técnicos Especializados 			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
623	53.06.12	4	53.06	Capacitación a Servidores Públicos			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
624	53.07	3	53	Gastos en Informática			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
625	53.07.01	4	53.07	Desarrollo de Sistemas Informáticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
626	53.07.02	4	53.07	Arrendamiento y Licencias de Uso de Paquetes Informáticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
627	53.07.03	4	53.07	Arrendamiento de Equipos Informáticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
628	53.07.04	4	53.07	Mantenimiento y Reparación de Equipos y Sistemas Infórmáticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
629	53.08	3	53	Bienes de Uso y Consumo Corriente			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
630	53.08.01	4	53.08	Alimentos y Bebidas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
631	53.08.02	4	53.08	Vestuario, Lencería y Prendas de Protección			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
632	53.08.03	4	53.08	Combustibles y Lubricantes			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
633	53.08.04	4	53.08	Materiales de Oficina			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
634	53.08.05	4	53.08	Materiales de Aseo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
635	53.08.06	4	53.08	Herramentas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
636	53.08.07	4	53.08	Materiales de Impresión, Fotografía, Reprodución y Publicaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
637	53.08.08	4	53.08	Instrumental Médico Menor			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
638	53.08.09	4	53.08	Medicinas y Productos Farmacéuticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
639	53.08.10	4	53.08	Materiales para Laboratorio y Uso Médico			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
640	53.08.11	4	53.08	Materiales de Construcción, Eléctricos, Plomería y Carpintería			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
641	53.08.12	4	53.08	Materiales Didácticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
642	53.08.13	4	53.08	Repuestos y Accesorios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
643	53.08.14	4	53.08	Suministros para Actividades Agropecuarias, Pesca y Caza			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
644	53.08.15	4	53.08	Acuñación de Monedas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
645	53.08.22	4	53.08	Condecoraciones y Homenajes en Actos Protocolarios			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
646	53.08.24	4	53.08	Insumos Bienes y materiales para la produccion de Programas de Radio y TV			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
647	53.08.26	4	53.08	Dispositivos medicos de uso general			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
648	53.08.32	4	53.08	Dispositivos Médicos para Odontología			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
649	53.08.37	4	53.08	Combustibles, lubricantes y aditivos en general para vehiculos terrestres			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
650	53.08.41	4	53.08	Repuestos y Accesorios para Vehiculos Terrestres			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
651	53.08.99	4	53.08	Material  informatico			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
652	53.09	3	53	Crédito por Impuesto al Valor Agregado			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
653	53.09.01	4	53.09	Crédito Fiscal por Compras			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
654	53.10	3	53	Pertrechos para la Defensa y Seguridad Pública			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
655	53.10.01	4	53.10	Logística			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
656	53.10.02	4	53.10	Suministros para la Defensa y Seguridad Pública			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
657	53.14	3	53	Bienes Muebles no Depreciables			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
658	53.14.03	4	53.14	Mobiliarios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
659	53.14.04	4	53.14	Maquinarias y Equipos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
660	53.14.06	4	53.14	Herramientas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
661	53.14.07	4	53.14	Equipos, Sistemas y Paquetes Informaticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
662	53.14.08	4	53.14	Bienes Artisticos y Culturales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
663	53.14.09	4	53.14	Libros y Colecciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
664	53.14.11	4	53.14	Partes y Repuestos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
665	53.15	3	53	Bienes Biológicos no Depreciables			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
666	53.15.12	4	53.15	Semovientes			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
667	53.15.14	4	53.15	Acuáticos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
668	53.15.15	4	53.15	Plantas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
669	53.16	3	53	Fondos de Reposicion			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
670	53.16.01	4	53.16	Fondos de Reposición Cajas Chicas			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
671	53.99	3	53	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
672	53.99.01	4	53.99	Asignación a Distribuir para Bienes y Servicios de Consumo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
673	56	2	5	GASTOS FINANCIEROS			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
674	56.01	3	56	Títulos y Valores en Circulación			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
675	56.01.01	4	56.01	Intereses en Certificados del Tesoro			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
676	56.01.02	4	56.01	Intereses por Bono del Estado			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
677	56.01.06	4	56.01	Descuentos, Comisiones y Otros Cargos en Títulos y Valores			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
678	56.01.99	4	56.01	Intereses Otros Títulos y Valores			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
679	56.02	3	56	Intereses de la Deuda Pública Interna			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
680	56.02.01	4	56.02	Sector Público Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
681	56.02.02	4	56.02	Sector Público No Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
682	56.02.03	4	56.02	Sector Privado Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
683	56.02.04	4	56.02	Sector Privado No Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
684	56.02.05	4	56.02	Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
685	56.02.06	4	56.02	Comisiones y Otros Cargos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
686	56.03	3	56	Intereses de la Deuda Pública Externa			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
687	56.03.01	4	56.03	A Organismos Multilaterales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
688	56.03.02	4	56.03	A Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
689	56.03.03	4	56.03	Al Sector Privado Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
690	56.03.04	4	56.03	Al Sector Privado No Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
691	56.03.06	4	56.03	Comisiones y Otros Cargos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
692	56.99	3	56	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
693	56.99.01	4	56.99	Asignación a Distribuir para Gastos Financieros			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
694	57	2	5	OTROS GASTOS CORRIENTES			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
695	57.01	3	57	Impuestos, Tasas y Contribuciones			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
696	57.01.01	4	57.01	Impuesto al Valor Agregado			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
697	57.01.02	4	57.01	Tasas Generales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
698	57.01.03	4	57.01	Tasas Portuarias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
699	57.01.04	4	57.01	Contribuciones Especiales y de Mejora			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
700	57.01.99	4	57.01	Otros Impuestos, Tasas Y Contribuciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
701	57.02	3	57	Seguros, Costos Financieros y Otros Gastos			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
702	57.02.01	4	57.02	Seguros			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
703	57.02.02	4	57.02	Seguros de Desgravamen y de Saldos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
704	57.02.03	4	57.02	Comisiones Bancarias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
705	57.02.04	4	57.02	Reajustes de Inversiones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
706	57.02.05	4	57.02	Diferencial Cambiario			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
707	57.02.06	4	57.02	Costas Judiciales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
708	57.02.07	4	57.02	Comisiones y Participaciones por Denuncias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
709	57.02.11	4	57.02	Prima de Riesgo de Instalaciones Financieras			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
710	57.02.13	4	57.02	Devolución de Garantías			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
711	57.02.14	4	57.02	Devolución de Fianzas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
712	57.02.16	4	57.02	Obligaciones con el IESS por Responsabilidad Patronal			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
713	57.02.18	4	57.02	Intereses por Mora Patronal al IESS			\N	\N	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
714	57.02.99	4	57.02	Otros Gastos Financieros			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
715	57.99	3	57	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
716	57.99.01	4	57.99	Asignación a Distribuir para Otros Gastos Corrientes			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
717	58	2	5	TRANSFERENCIAS CORRIENTES		213.58	17000	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
718	58.01	3	58	Transferencias Corrientes al Sector Público			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
719	58.01.01	4	58.01	Al Gobierno Central			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
720	58.01.02	4	58.01	A Entidades Decentralizadas y Autónomas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
721	58.01.03	4	58.01	A Empresas Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
722	58.01.04	4	58.01	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
723	58.01.05	4	58.01	A la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
724	58.01.06	4	58.01	A Entidades Financieras Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
725	58.01.08	4	58.01	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
726	58.01.09	4	58.01	A Fondos de Uso Reservado			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
727	58.01.10	4	58.01	Al Fondo de Contingencias			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
728	58.02	3	58	Transferencias Corrientes al Sector Privado Interno			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
729	58.02.03	4	58.02	Al Sector Privado Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
730	58.02.04	4	58.02	Al Sector Privado No Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
731	58.02.05	4	58.02	Indemnizaciones por Afectaciones a los Derechos Humanos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
732	58.02.06	4	58.02	Aporte a Favor Alumnos Maestros de Institutos Pedagógicos Hispanos y Bilingues			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
733	58.02.07	4	58.02	Aporte a Favor de Cada Pasante Que Acceda a la Formación en Practicas  Laborales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
734	58.03	3	58	Transferencias Corrientes al Sector Externo			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
735	58.03.01	4	58.03	A Organismos Multilaterales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
736	58.03.02	4	58.03	A Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
737	58.03.03	4	58.03	Al Sector Privado Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
738	58.03.04	4	58.03	Al Sector Privado No Financiero			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
739	58.04	3	58	Aportes y Participaciones al Sector Público			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
740	58.04.01	4	58.04	Por Exportación de Hidrocarburos y Derivados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
741	58.04.02	4	58.04	Por Impuestos y Exportaciones de Crudo para Universidades y Escuelas Politécnica			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
742	58.04.03	4	58.04	Para Empresas Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
743	58.04.04	4	58.04	Para Financiamiento de la Administración de la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
744	58.04.05	4	58.04	Para Financiamiento de la Administración de la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
745	58.04.06	4	58.04	Para el IECE por el 0.5% de las Planillas de Pago al IESS			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
746	58.04.07	4	58.04	Por Aplicación de Fondos Ajenos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
747	58.04.08	4	58.04	Por Aplicación de Cuentas y Fondos Especiales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
748	58.04.11	4	58.04	Rendimientos de los Sistemas Contables del Banco Central del Ecuador			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
749	58.04.14	4	58.04	Aportes Sobre Dépositos de Instituciones Fiancieras			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
750	58.04.15	4	58.04	Entrega de Dépositos Inmobilizados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
751	58.04.99	4	58.04	Otras Participaciones			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
752	58.05	3	58	Subsidios			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
753	58.05.01	4	58.05	De Precios a Entes Públicos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
754	58.05.02	4	58.05	De Precios a Entes Privados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
755	58.05.03	4	58.05	De Tarifas a Entes Públicos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
756	58.05.04	4	58.05	De Tarifas a Entes Privados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
757	58.05.05	4	58.05	Subsidio a la Vivienda			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
758	58.05.06	4	58.05	Bono de Solidaridad			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
759	58.05.99	4	58.05	Otros Subsidios			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
760	58.06	3	58	Aportes y Participaciones Corrientes al Régimen Seccional Autónomo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
761	58.06.01	4	58.06	Compensaciones a Municipios por Leyes y Decretos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
762	58.06.02	4	58.06	Compensaciones a Consejos Provinciales por Leyes y Decretos			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
763	58.06.04	4	58.06	A Municipios por Aportes del FODESEC			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
764	58.06.05	4	58.06	A Consejos Provinciales por Aporte del FODESEC			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
765	58.06.06	4	58.06	Al INGALA por Aporte del FODESEC			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
766	58.06.07	4	58.06	Al CONCOPE por Aporte del FODESEC			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
767	58.06.08	4	58.06	A Juntas Parroquiales Rurales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
768	58.06.10	4	58.06	Al CONCOPE por Aporte del FONDEPRO			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
769	58.06.16	4	58.06	A Municipios por Aporte del Fondo de Descentralización			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
770	58.06.17	4	58.06	A Consejos Provinciales del Fondo de Descentralización			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
771	58.07	3	58	Participaciones Corrientes en los Ingresos Petroleros a Favor de la Fuente			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
772	58.07.01	4	58.07	Por Exportaciones de Derivados de Petróleo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
773	58.07.02	4	58.07	Por Venta Interna de derivados de Petróleo			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
774	58.07.03	4	58.07	Por Tarifa del Oleoducto de Empresas Privadas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
775	58.07.04	4	58.07	Del Fondo de Inverción Petrolera 10% Exportación Directa de Crudo y Derivados y			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
776	58.07.05	4	58.07	Del Fondo de Inverción Petrolera de la Venta Interna de Derivados			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
777	58.07.08	4	58.07	Por Compensación Obligaciones Tributarias Bloque 15			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
778	58.07.09	4	58.07	Del Fondo de Estabilización Petrolera			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
779	58.07.10	4	58.07	Por la Participación en las Exportaciones de Crudo Ex-Consorcio			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
780	58.07.99	4	58.07	Por Participaciones no Especificadas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
781	58.08	3	58	Por Participaciones Corrientes de LOS Entes Públcos y Privados en los Ingresos P			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
782	58.08.01	4	58.08	Al Gobierno Central			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
783	58.08.02	4	58.08	A Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
784	58.08.03	4	58.08	A Empresas Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
785	58.08.04	4	58.08	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
786	58.08.05	4	58.08	A la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
787	58.08.06	4	58.08	A Entidades Financieras Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
788	58.08.08	4	58.08	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
789	58.08.11	4	58.08	Al Sector Privado			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
790	58.09	3	58	Por Participaciones Corrientes de los Entes Públicos y Privados en lo Ingresos P			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
791	58.09.01	4	58.09	Al Gobierno Central			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
792	58.09.02	4	58.09	A Descentralizadas y Autónomas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
793	58.09.03	4	58.09	A Empresas Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
794	58.09.04	4	58.09	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
795	58.09.05	4	58.09	A la Seguridad Social			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
796	58.09.06	4	58.09	A Entidades Financieras Públicas			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
797	58.09.07	4	58.09	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
798	58.09.10	4	58.09	Al Sector Privado			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
799	58.09.11	4	58.09	Al Sector Financiero Público			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
800	58.99	3	58	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
801	58.99.01	4	58.99	Asignación a Distribuir para Transferencias y Donaciones Corrientes			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
802	59	2	5	PREVISIONES PARA REASIGNACION			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
803	59.01	3	59	Asignaciones a Distribuir			0	0	0	0	0	15	\N	1	2025-01-28 10:27:52	\N	\N
804	59.01.01	4	59.01	Asignación a Distribuir			0	0	\N	\N	\N	15	\N	1	2025-01-28 10:27:52	\N	\N
805	6	1	0	GASTOS DE PRODUCCION			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
806	61	2	6	GASTOS EN PERSONAL DE PRODUCCION		213.61	694082	185.84	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
807	61.01	3	61	Remuneraciones Básicas			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
808	61.01.01	4	61.01	Sueldos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
809	61.01.02	4	61.01	Salarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
810	61.01.03	4	61.01	Jornales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
811	61.01.05	4	61.01	Remuneraciones Unificadas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
812	61.01.06	4	61.01	Salarios Unificados			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
813	61.02	3	61	Remuneraciones Complementarias			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
814	61.02.01	4	61.02	Bonificación por Años de Servicio			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
815	61.02.02	4	61.02	Bonificación por Responsabilidad			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
816	61.02.03	4	61.02	Decimotercer Sueldo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
817	61.02.04	4	61.02	Decimocuarto Sueldo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
818	61.02.07	4	61.02	Bonificación Complementaria			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
819	61.02.08	4	61.02	Bonificación por Títulos Académicos, Especializaciones y Capacitación Adicional			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
820	61.02.09	4	61.02	Gastos de Representación			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
821	61.02.10	4	61.02	Sobresueldos y Bonificaciones Adicionales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
822	61.02.11	4	61.02	Estimulo Pecunario			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
823	61.02.12	4	61.02	Bonificación de Aniversario			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
824	61.02.13	4	61.02	Aguinaldo Navideño			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
825	61.02.17	4	61.02	Bonificación por Millaje			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
826	61.02.18	4	61.02	Bonificación Mensual Galápagos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
827	61.02.19	4	61.02	Adicional Régimen Especial Galápagos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
828	61.02.20	4	61.02	Bonificación Franteriza			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
829	61.02.23	4	61.02	Bonificación por el Día del Médico			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
830	61.02.24	4	61.02	Bonificación por el Día Mundial de la Salud			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
831	61.02.25	4	61.02	Bonificación para los Profesionales de la Salud			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
832	61.02.27	4	61.02	Adicional Región Amazónica			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
833	61.02.28	4	61.02	Remuneración Suplementaria Galápagos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
834	61.02.29	4	61.02	Actividad Extracurricular Galápagos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
835	61.02.30	4	61.02	Bonificación por el Día del Maestro			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
836	61.02.31	4	61.02	Bonificación por el Día del Servidor Público			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
837	61.02.32	4	61.02	Bonificación para Educadores Comunitarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
838	61.02.33	4	61.02	Bonificación para Profesionales Amparados o no por Leyes de Escalafón			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
839	61.02.34	4	61.02	Bonificación Adicional Galápagos, Servidores de la LOSCCA			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
840	61.03	3	61	Remuneraciones Compensatorias			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
841	61.03.01	4	61.03	Gastos de Residencia			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
842	61.03.02	4	61.03	Subsidio por Circunstancias Geográficas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
843	61.03.03	4	61.03	Compensación por Costo de Vida			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
844	61.03.04	4	61.03	Compensación por Transporte			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
845	61.03.05	4	61.03	Compensación en el Exterior			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
846	61.03.06	4	61.03	Refrigerio			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
847	61.03.07	4	61.03	Comisariato			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
848	61.03.09	4	61.03	Compensación por Trabajo de Alto Riesgo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
849	61.03.13	4	61.03	Compensación por Cesación de Funciones			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
850	61.04	3	61	Subsidios			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
851	61.04.01	4	61.04	Por Cargas Familiares			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
852	61.04.02	4	61.04	De Educación			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
853	61.04.03	4	61.04	Por Maternidad			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
854	61.04.04	4	61.04	Por Fallecimiento			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
855	61.04.05	4	61.04	Por Guardería			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
856	61.04.06	4	61.04	Por Vacaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
857	61.04.07	4	61.04	Estímulo Económico por Años de Servicio			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
858	61.04.08	4	61.04	Subsidio de Antiguedad			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
859	61.04.99	4	61.04	Otros Subsidios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
860	61.05	3	61	Remuneraciones Temporales			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
861	61.05.01	4	61.05	Sueldos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
862	61.05.03	4	61.05	Jornales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
863	61.05.04	4	61.05	Encargos y Subrogaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
864	61.05.06	4	61.05	Licencia Remunerada			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
865	61.05.07	4	61.05	Honorarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
866	61.05.08	4	61.05	Dietas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
867	61.05.09	4	61.05	Horas Extraordinarias y Suplementarias			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
868	61.05.10	4	61.05	Servicios Personales por Contrato			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
869	61.05.12	4	61.05	Subrogación o Encargo			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
871	61.06	3	61	Aportes Patronales a la Seguridad Social			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
872	61.06.01	4	61.06	Aporte Patronal			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
873	61.06.02	4	61.06	Fondo de Reserva			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
874	61.06.03	4	61.06	Jubilación Patronal			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
875	61.06.04	4	61.06	Cesantía Privada			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
876	61.06.05	4	61.06	Jubilación Privada			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
877	61.07	3	61	Indemnizaciones			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
878	61.07.03	4	61.07	Despido Intempestivo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
879	61.07.04	4	61.07	Compensación por Desahucio			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
880	61.07.05	4	61.07	Restirución de Puesto			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
881	61.07.06	4	61.07	Por Jubilación			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
882	61.07.07	4	61.07	Compensación de Vacaciones no Gozadas por Cesación de Funciones			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
883	61.07.99	4	61.07	Otras Indemnizaciones Laborales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
884	61.99	3	61	Asignaciones a Distribuir			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
885	61.99.01	4	61.99	Asignación a Distribuir para Gastos en Personal de Producción			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
886	63	2	6	BIENES Y SERVICIOS DE PRODUCCION		213.63	362100	26421.34	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
887	63.01	3	63	Servicios Básicos			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
888	63.01.01	4	63.01	Agua Potable			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
889	63.01.02	4	63.01	Agua de Riego			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
890	63.01.04	4	63.01	Energía Eléctrica			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
891	63.01.05	4	63.01	Telecomunicaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
892	63.01.06	4	63.01	Servicio de Correo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
893	63.02	3	63	Servicios Generales			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
894	63.02.01	4	63.02	Transporte de Personal			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
895	63.02.02	4	63.02	Fletes y Maniobras			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
896	63.02.03	4	63.02	Almacenamiento, Embalaje y Envase			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
897	63.02.04	4	63.02	Edición, Impresión, Reproducción y Publicaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
898	63.02.07	4	63.02	Difusión, Información y Publicidad			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
899	63.02.08	4	63.02	Servicio de Vigilancia			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
900	63.02.09	4	63.02	Servicio de Aseo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
901	63.02.10	4	63.02	Servicio de Guardería			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
902	63.02.12	4	63.02	Investigaciones Profesionales y Exámenes de Laboratorio			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
903	63.02.18	4	63.02	Servicios de Publicidad y Propaganda en Medios de Comunicación Masiva			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
904	63.02.21	4	63.02	Servicios Personales Eventuales sin Relacion de Dependencia 			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
905	63.02.55	4	63.02	OJO NOMBRE			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
906	63.02.99	4	63.02	Otros Servicios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
907	63.03	3	63	Traslados, Instalaciones, Viáticos y Subsistencias			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
908	63.03.01	4	63.03	Pasajes al Interior			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
909	63.03.02	4	63.03	Pasajes al Exterior			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
910	63.03.03	4	63.03	Viáticos y Subsistencias en el Interior			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
911	63.03.04	4	63.03	Viáticos y Subsistencias en el Exterior			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
912	63.03.05	4	63.03	Mudanzas e Instalaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
913	63.03.12	4	63.03	ojo nombre			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
914	63.04	3	63	Instalación, Mantenimiento y Reparación			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
915	63.04.01	4	63.04	Terrenos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
916	63.04.02	4	63.04	Edificios, Locales y Residencias			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
917	63.04.03	4	63.04	Mobiliarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
918	63.04.04	4	63.04	Maquinarias y Equipos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
919	63.04.05	4	63.04	Vehículos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
920	63.04.06	4	63.04	Herramientas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
921	63.04.15	4	63.04	Bienes Biológicos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
922	63.04.17	4	63.04	Infraestructura			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
923	63.04.20	4	63.04	Instalacion y mantenimiento y reparacion de edificios, locales y Residencias			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
924	63.04.99	4	63.04	Otras Instalaciones, Mantenimiento y Reparaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
925	63.05	3	63	Arrendamientos de Bienes			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
926	63.05.01	4	63.05	Terrenos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
927	63.05.02	4	63.05	Edificios Locales y Residencias			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
928	63.05.03	4	63.05	Mobiliarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
929	63.05.04	4	63.05	Maquinarias y Equipos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
930	63.05.05	4	63.05	Vehículos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
931	63.05.06	4	63.05	Herramientas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
932	63.05.15	4	63.05	Bienes Biológicos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
933	63.05.99	4	63.05	Otros Arrendamientos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
934	63.06	3	63	Contrataciones de Estudios e Investigaciones			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
935	63.06.01	4	63.06	Consultoría, Asesoría e Investigación Especializada			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
936	63.06.02	4	63.06	Servicios de Auditoría			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
937	63.06.03	4	63.06	Servicios de Capacitación			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
938	63.06.04	4	63.06	Fiscalización e Inspecciones Técnicas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
939	63.06.05	4	63.06	Estudio y Diseño de Proyectos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
940	63.06.07	4	63.06	Servicios Técnicos Especializados			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
941	63.06.09	4	63.06	Investigaciones Profesionales y Análisis de Laboratorio 			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
942	63.07	3	63	Gastos en Informática			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
943	63.07.01	4	63.07	Desarrollo de Sistemas Informáticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
944	63.07.02	4	63.07	Arrendamiento y Licencias de Uso de Paquetes Informáticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
945	63.07.03	4	63.07	Arrendamiento de Equipos Informáticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
946	63.07.04	4	63.07	Mantenimiento y Reparación de Equipos y Sistemas Informáticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
947	63.08	3	63	Bienes de Uso y Consumo de Producción			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
948	63.08.01	4	63.08	Alimentos y Bebidas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
949	63.08.02	4	63.08	Vestuario, Lencería y Prendas de Protección			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
950	63.08.03	4	63.08	Commbustibles y Lubricantes			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
951	63.08.04	4	63.08	Materiales de Oficina			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
952	63.08.05	4	63.08	Maateriales de Aseo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
953	63.08.06	4	63.08	Herramientas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
954	63.08.07	4	63.08	Materiales de Impresión, Fotografía, Reproducción y Publicaciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
955	63.08.08	4	63.08	Instrumental Médico Menor			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
956	63.08.09	4	63.08	Medicinas y productos Farmaceuticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
957	63.08.10	4	63.08	Materiales para Laboratorio y Uso Médico			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
958	63.08.11	4	63.08	Materiales de Construcción, Eléctricos, Plomería y Carpintería			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
959	63.08.12	4	63.08	Materiales Didácticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
960	63.08.13	4	63.08	Repuestos y Accesorios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
961	63.08.19	4	63.08	Accesorios y Productos Químicos			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
962	63.08.29	4	63.08	Insumos bienes materiales y suministros para investigacion			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
963	63.08.32	4	63.08	Dispositivos Médicos para Odontología			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
964	63.08.37	4	63.08	Combustibles, lubricantes y aditivos en egenral para vehiculos terrestres			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
965	63.08.99	4	63.08	Otros de Uso y Consumo de Producción			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
966	63.09	3	63	Créditos por Impuesto al Valor Agregado			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
967	63.09.01	4	63.09	Crédito Fiscal por Compras			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
968	63.10	3	63	Adquisiciones de Materias Primas			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
969	63.10.01	4	63.10	Agropecuarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
970	63.10.02	4	63.10	Quimicos e Industriales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
971	63.10.03	4	63.10	Mineros			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
972	63.10.15	4	63.10	Bienes Biológicos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
973	63.10.99	4	63.10	Otras Materias Primas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
974	63.11	3	63	Adquisiciones de Productos Semielaborados			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
975	63.11.01	4	63.11	Agropecuarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
976	63.11.02	4	63.11	Quimicos e Industriales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
977	63.11.15	4	63.11	Bienes Biológicos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
978	63.11.99	4	63.11	Otros Productos Semielaborados			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
979	63.12	3	63	Adquisiciones de Productos Terminados			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
980	63.12.01	4	63.12	Agropecuarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
981	63.12.02	4	63.12	Químicos e Industriales no Petroleros			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
982	63.12.05	4	63.12	Petróleo Crudo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
983	63.12.07	4	63.12	Derivados de Petróleo			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
984	63.12.08	4	63.12	Instrumental Medico Menor			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
985	63.12.09	4	63.12	Medicinas y Productos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
986	63.12.15	4	63.12	Bienes Biológicos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
987	63.12.99	4	63.12	Otros Productos Terminados			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
988	63.14	3	63	Bienes Muebles no Depreciables			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
989	63.14.03	4	63.14	Mobiliarios			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
990	63.14.04	4	63.14	Maquinarias y Equipos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
991	63.14.06	4	63.14	Herramientas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
992	63.14.07	4	63.14	Equipos, Sistemas y Paquetes Informaticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
993	63.14.11	4	63.14	Partes y Repuestos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
994	63.15	3	63	Bienes Biológicos no Depreciables			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
995	63.15.12	4	63.15	Semovientes			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
996	63.15.14	4	63.15	Acuáticos			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
997	63.15.15	4	63.15	Plantas			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
998	63.16	3	63	Fondos de Reposición			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
999	63.16.01	4	63.16	Fondos de Reposición Cajas Chicas 			\N	\N	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1000	63.99	3	63	Asignaciones a Distribuir			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
1001	63.99.01	4	63.99	Asignación a Distribuir para Bienes y Servicios de Producción			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1002	67	2	6	OTROS GASTOS DE PRODUCCIÓN		213.67	3800	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
1003	67.01	3	67	Impuestos Tasas y Contribuciones			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
1004	67.01.01	4	67.01	Impuestos al Valor Agregado			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1005	67.01.02	4	67.01	Tasas Generales			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1006	67.01.03	4	67.01	Tasas Portuarias			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1007	67.01.04	4	67.01	Contribuciones Especiales y de Mejora			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1008	67.01.99	4	67.01	Otros Impuestos, Tasas y Contribuciones			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1009	67.02	3	67	Seguros Costos Financieros y Otros Gastos			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
1010	67.02.01	4	67.02	Seguros			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1011	67.02.99	4	67.02	Otros Gastos Financieros			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1012	67.99	3	67	Asignaciones a Distibuir			0	0	0	0	0	26	\N	1	2025-01-28 10:27:52	\N	\N
1013	67.99.01	4	67.99	Asignación a Distribuir para Otros Gastos de Producción			0	0	\N	\N	\N	26	\N	1	2025-01-28 10:27:52	\N	\N
1014	7	1	0	GASTOS DE INVERSION			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1015	71	2	7	GASTOS EN PERSONAL PARA INVERSION			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1016	71.01	3	71	Remuneraciones Básicas			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1017	71.01.01	4	71.01	Sueldos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1018	71.01.02	4	71.01	Salarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1019	71.01.03	4	71.01	Jornales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1020	71.01.05	4	71.01	Remuneraciones Unificadas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1021	71.01.06	4	71.01	Salarios Unificados			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1022	71.02	3	71	Remuneraciones Complementarias			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1023	71.02.01	4	71.02	Bonificación por Años de Servicio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1024	71.02.02	4	71.02	Bonificación por Responsabilidad			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1025	71.02.03	4	71.02	Decimotercer Sueldo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1026	71.02.04	4	71.02	Decimocuarto Sueldo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1027	71.02.05	4	71.02	Decimoqquinto Sueldo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1028	71.02.06	4	71.02	Decimosexto Sueldo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1029	71.02.07	4	71.02	Bonificación Complementaria			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1030	71.02.08	4	71.02	Bonificación por Títulos Académicos, Especializaciones y Capacitación Adicional			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1031	71.02.09	4	71.02	Gastos de Representación			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1032	71.02.10	4	71.02	Sobresueldos y Bonificaciones Adicionales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1033	71.02.11	4	71.02	Estímulo Pecuniario			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1034	71.02.12	4	71.02	Bonificación de Aniversario			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1035	71.02.13	4	71.02	Aguinaldo Navideño			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1036	71.02.14	4	71.02	Porcentaje Funcional			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1037	71.02.15	4	71.02	Adicional sobre la Décima Categoría			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1038	71.02.16	4	71.02	Estímulo Económico Magisterio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1039	71.02.18	4	71.02	Bonificación Mensual Galápagos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1040	71.02.20	4	71.02	Bonificación Fronteriza			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1041	71.02.23	4	71.02	Bonificación por el Día del Maestro			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1042	71.02.24	4	71.02	Bonificación por el Día Mundial de la Salud			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1043	71.02.25	4	71.02	Bonificación para los Profesionales de la Salud			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1044	71.02.27	4	71.02	Adicional Región Amazónica			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1045	71.02.28	4	71.02	Remuneración Suplementaria Galápagos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1046	71.02.29	4	71.02	Actividad Extracurricular Galápagos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1047	71.02.30	4	71.02	Bonificación por el Día del Maestro			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1048	71.02.31	4	71.02	Bonificación por el Día del Servidor Público			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1049	71.02.32	4	71.02	Bonificación para Educadores Comunitarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1050	71.02.33	4	71.02	Bonificación para Profesionales Amparados   o no por Leyes de Escalafón			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1051	71.02.34	4	71.02	Bonificación Adicional Galápagos, Servidores de la LOSCCA			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1052	71.03	3	71	Remuneraciones Compensatorias			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1053	71.03.01	4	71.03	Gastos de Residencia			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1054	71.03.02	4	71.03	Subsidio por Circunstancias Geográficas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1055	71.03.03	4	71.03	Compensación por Costo de Vida			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1056	71.03.04	4	71.03	Compensación por Transporte			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1057	71.03.05	4	71.03	Compensación en el Exterior			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1058	71.03.06	4	71.03	Refrigerio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1059	71.03.07	4	71.03	Comisariato			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1060	71.03.08	4	71.03	Compensación Pedagógica			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1061	71.03.09	4	71.03	Compensación por Trabajo de Alto Riesgo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1062	71.03.10	4	71.03	Subsidio Prof. Escuelas Fisc, Mision y Fiscom de Regiones Amazónica e Insular			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1063	71.04	3	71	Subsidios			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1064	71.04.01	4	71.04	Por Cargas Familiares			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1065	71.04.02	4	71.04	De Educación			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1066	71.04.03	4	71.04	Por Maternidad			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1067	71.04.04	4	71.04	Por Fallecimiento			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1068	71.04.05	4	71.04	Por Guardería			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1069	71.04.06	4	71.04	Por Vacaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1070	71.04.07	4	71.04	Estímulo Económico por Años de Servicio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1071	71.04.99	4	71.04	Otros Subsidios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1072	71.05	3	71	Remuneraciones Temporales			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1073	71.05.01	4	71.05	Sueldos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1074	71.05.03	4	71.05	Jornales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1075	71.05.04	4	71.05	Encargos y Subrogaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1076	71.05.05	4	71.05	Sustituciones de Personal			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1077	71.05.06	4	71.05	Licencia Remunerada			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1078	71.05.07	4	71.05	Honorarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1079	71.05.08	4	71.05	Dietas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1080	71.05.09	4	71.05	Horas Extraordinarias y Suplementarias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1081	71.05.10	4	71.05	Servicios Personales de Contrato			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1082	71.05.11	4	71.05	Remuneraciones Especiales Sección Nocturna			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1083	71.06	3	71	Aportes Patronales a la Seguridad Social			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1084	71.06.01	4	71.06	Aporte Patronal			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1085	71.06.02	4	71.06	Fondo de Reserva			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1086	71.06.03	4	71.06	Jubilación Patronal			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1087	71.06.04	4	71.06	Cesantía Privada			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1088	71.06.05	4	71.06	Jubilación Privada			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1089	71.07	3	71	Indemnizaciones			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1090	71.07.02	4	71.07	Supresión de Puesto			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1091	71.07.03	4	71.07	Despido Intempestivo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1092	71.07.04	4	71.07	Compensación por Desahucio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1093	71.07.05	4	71.07	Restitución de Puesto			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1094	71.07.06	4	71.07	Por Jubilación			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1095	71.07.99	4	71.07	Otras Indemnizaciones Laborales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1096	71.99	3	71	Asignaciones a Distribuir			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1097	71.99.01	4	71.99	Asignación a Distribuir para Gastos en Personal de Inversión			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1098	73	2	7	BIENES Y SERVICIOS PARA INVERSION		213.73	605000	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1099	73.01	3	73	Servicios Básicos			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1100	73.01.01	4	73.01	Agua Potable			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1101	73.01.02	4	73.01	Agua de Riego			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1102	73.01.04	4	73.01	Energía Electrica			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1103	73.01.05	4	73.01	Telecomunicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1104	73.01.06	4	73.01	Servicio de Correo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1105	73.02	3	73	Servicios Generales			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1106	73.02.01	4	73.02	Transporte de Personal			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1107	73.02.02	4	73.02	Fletes y Maniobras			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1108	73.02.03	4	73.02	Almacenamiento, Embalaje y Envase			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1109	73.02.04	4	73.02	Edición, Impresión, Reproducción y Publicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1110	73.02.05	4	73.02	Espectaculos Culturales y Sociales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1111	73.02.06	4	73.02	Eventos Públicos y Oficiales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1112	73.02.07	4	73.02	Difusión, Información y Publicidad			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1113	73.02.08	4	73.02	Servicio de Vigilancia			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1114	73.02.09	4	73.02	Servicio de Aseo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1115	73.02.10	4	73.02	Servicio de Guardería			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1116	73.02.12	4	73.02	Investigaciones Profesionales y Exámenes de Laboratorio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1117	73.02.99	4	73.02	Otros Servicios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1118	73.03	3	73	Traslados, Instalaciones, Viáticos y Subsistencias			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1119	73.03.01	4	73.03	Pasajes al Interior			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1120	73.03.02	4	73.03	Pasajes al Exterior			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1121	73.03.03	4	73.03	Viáticos y Subsistencias en el Interior			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1122	73.03.04	4	73.03	Viáticos y Subsistencias en el Exterior			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1123	73.03.05	4	73.03	Mudanzas e Instalaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1124	73.04	3	73	Instalación, Mantenimiento y Reparación			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1125	73.04.01	4	73.04	Terrenos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1126	73.04.02	4	73.04	Edificios Locales y Residencias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1127	73.04.03	4	73.04	Mobiliarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1128	73.04.04	4	73.04	Maquinarias y Equipos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1129	73.04.05	4	73.04	Vehículos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1130	73.04.06	4	73.04	Herramientas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1131	73.04.15	4	73.04	Bienes Biológicos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1132	73.04.17	4	73.04	Infraestructura			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1133	73.04.99	4	73.04	Otras Instalaciones, Mantenimientos y Reparaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1134	73.05	3	73	Arrendamientos de Bienes			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1135	73.05.01	4	73.05	Terrenos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1136	73.05.02	4	73.05	Edificios Locales y Residencias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1137	73.05.03	4	73.05	Mobiliarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1138	73.05.04	4	73.05	Maquinarias y Equipos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1139	73.05.05	4	73.05	Vehículos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1140	73.05.06	4	73.05	Herramientas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1141	73.05.15	4	73.05	Bienes Biológicos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1142	73.05.99	4	73.05	Otros Arrendamientos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1143	73.06	3	73	Contrataciones de Estudios e Investigaciones			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1144	73.06.01	4	73.06	Consultoría, Asesoría  e Investigación Especializada			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1145	73.06.02	4	73.06	Servicio de Auditoría			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1146	73.06.03	4	73.06	Servicio de Capacitación			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1147	73.06.04	4	73.06	Fiscalización e Inspecciones Técnicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1148	73.06.05	4	73.06	Estudio y Diseño de Proyectos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1149	73.07	3	73	Gastos en Informática			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1150	73.07.01	4	73.07	Desarrollo de Sistemas Informáticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1151	73.07.02	4	73.07	Arrendamiento y Licencias de Uso de Paquetes Infórmaticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1152	73.07.03	4	73.07	Arrendamiento de Paquetes Informáticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1153	73.07.04	4	73.07	Mantenimiento y Reparación de Equipos y Sistemas Informáticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1154	73.08	3	73	Bienes de Uso y Consumo de Inversión			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1155	73.08.01	4	73.08	Alimentos y Bebidas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1156	73.08.02	4	73.08	Vestuario, Lencería y Prendas de Protección			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1157	73.08.03	4	73.08	Combustibles y Lubricantes			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1158	73.08.04	4	73.08	Materiales de Oficina			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1159	73.08.05	4	73.08	Materiales de Aseo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1160	73.08.06	4	73.08	Herramientas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1161	73.08.07	4	73.08	Materiales de Impresión, Fotografía, Reproducción y Publicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1162	73.08.08	4	73.08	Instrumental Médico Menor			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1163	73.08.09	4	73.08	Medicinas y Productos Farmáceuticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1164	73.08.10	4	73.08	Materiales de Laboratorio y Uso Médico			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1165	73.08.11	4	73.08	Materiales de Construcción, Eléctricos, Plomería y Carpintería			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1166	73.08.12	4	73.08	Materiales Didácticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1167	73.08.13	4	73.08	Repuestos y Accesorios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1168	73.08.14	4	73.08	Suministros para Actividades Agropecuarias, Pesca y Caza			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1169	73.08.99	4	73.08	Otros de Uso y Consumo de Inversión			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1170	73.09	3	73	Crédito por Impuesto al Valor Agregado			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1171	73.09.01	4	73.09	Crédito Fiscal por Compras			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1172	73.14	3	73	Bienes Biológicos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1173	73.14.03	4	73.14	Mobiliarios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1174	73.14.04	4	73.14	Maquinarias y Equipos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1175	73.14.06	4	73.14	Herramientas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1176	73.14.07	4	73.14	Equipos, Sistemas y Paquetes Informaticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1177	73.14.08	4	73.14	Bienes Artisticos y Culturales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1178	73.14.09	4	73.14	Libros y Colecciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1179	73.14.11	4	73.14	Partes y Repuestos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1180	73.15	3	73	Bienes Biológicos no Depreciables			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1181	73.15.12	4	73.15	Semovientes			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1182	73.15.14	4	73.15	Acuáticos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1183	73.15.15	4	73.15	Plantas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1184	73.99	3	73	Asignaciones a Distribuir			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1185	73.99.01	4	73.99	Asignación a Distribuir para Bienes y Servicios de Inversión			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1186	75	2	7	OBRAS PUBLICAS		213.75	854670.8	13530.74	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1187	75.01	3	75	Obras de Infraestructura			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1188	75.01.01	4	75.01	De Agua Potable			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1189	75.01.02	4	75.01	De Riego y Manejo de Aguas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1190	75.01.03	4	75.01	De Alcantarrillado			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1191	75.01.04	4	75.01	De Urbanización y Embellecimiento			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1192	75.01.05	4	75.01	Obras Públicas de Transporte y Vías			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1193	75.01.06	4	75.01	Obras Públicas para Telecomunicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1194	75.01.07	4	75.01	Construcciones y Edificaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1195	75.01.08	4	75.01	Hospitales y Centros de Asistencia Social y Salud			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1196	75.01.09	4	75.01	Construcciones Agropecuarias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1197	75.01.10	4	75.01	Plantas Industriales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1198	75.01.11	4	75.01	Habilitamiento y Protección del Suelo, Subsuelo y Areas Ecológicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1199	75.01.12	4	75.01	Formación de Plantaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1200	75.01.13	4	75.01	Explotación de Aguas Subterráneas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1201	75.01.99	4	75.01	Otras Obras de Infraestructura			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1202	75.02	3	75	Obras para Generación de Energía			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1203	75.02.01	4	75.02	Obras para Generación Eléctrica Hidráulica			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1204	75.02.02	4	75.02	Obras para Generación Eléctrica Térmica			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1205	75.02.99	4	75.02	Otros Sistemas de Generación de Energía			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1206	75.03	3	75	Obras en Hidrocarburos y Minas			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1207	75.03.01	4	75.03	En Obras de Extracción			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1208	75.03.02	4	75.03	En Obras de Refinación			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1209	75.03.03	4	75.03	En Obras de Almacenamiento			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1210	75.03.04	4	75.03	En Obras de Comercialización			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1211	75.03.05	4	75.03	En Obras de Transporte de Materias Primas y Derivados			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1212	75.03.99	4	75.03	Otras Obras para el Sector Hidrocarburífero y Minero			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1213	75.04	3	75	Obras en Líneas, Redes e Instalaciones Eléctricas y de Telecomunicaciones			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1214	75.04.01	4	75.04	Líneas, Redes e Instalaciones Eléctricas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1215	75.04.02	4	75.04	Líneas, Redes e Instalaciones  de Telecomunicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1216	75.04.99	4	75.04	Otras Obras Eléctricas y de Telecomunicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1217	75.05	3	75	Mantenimiento y Reparaciones			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1218	75.05.01	4	75.05	En Obras de Infraestructura			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1219	75.05.02	4	75.05	En Obras para Generación de Energía			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1220	75.05.03	4	75.05	En Obras Hidrocarburíferos y Mineras			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1221	75.05.04	4	75.05	En Obras de Líneas, Redes e Instalaciones Eléctricas y de Telecomunicaciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1222	75.05.99	4	75.05	Otros Mantenimientos y Reparaciones de Obras			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1223	75.99	3	75	Asignaciones a Distribuir			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1224	75.99.01	4	75.99	Asignación a Distribuir para Obras Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1225	77	2	7	OTROS GASTOS DE INVERSIÓN		213.77	0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1226	77.01	3	77	Impuestos Tasas y Contribuciones			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1227	77.01.01	4	77.01	Impuesto al Valor Agregado			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1228	77.01.02	4	77.01	Tasas Generales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1229	77.01.03	4	77.01	Tasas Portuarias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1230	77.01.04	4	77.01	Contribuciones Especiales y de Mejora			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1231	77.01.99	4	77.01	Otros Impuestos, Tasas y Contribuciones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1232	77.02	3	77	Seguros Costos Financieros y Otros Gastos			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1233	77.02.01	4	77.02	Seguros			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1234	77.02.03	4	77.02	Comisiones Bancarias			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1235	77.02.04	4	77.02	Reajustes de Inversiones			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1236	77.02.05	4	77.02	Diferencial Cambiario			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1237	77.02.06	4	77.02	Costas Judiciales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1238	77.02.13	4	77.02	Devolución de Garantías			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1239	77.02.99	4	77.02	Otros Gastos Financieros			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1240	77.99	3	77	Asignaciones a Distribuir			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1241	77.99.01	4	77.99	Asignación sujeta a Distribución para Inversión			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1242	78	2	7	TRANSFERENCIAS PARA INVERSION			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1243	78.01	3	78	Transferencias para Inversión al Sector Público			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1244	78.01.01	4	78.01	Al Gobierno Central			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1245	78.01.02	4	78.01	A Entidades Decentralizadas y Autónomas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1246	78.01.03	4	78.01	A Empresas Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1247	78.01.04	4	78.01	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1248	78.01.06	4	78.01	A Entidades Financieras Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1249	78.01.08	4	78.01	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1250	78.02	3	78	Transferencias de Inversión al Sector Privado Interno			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1251	78.02.03	4	78.02	Al Sector Privado Financiero			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1252	78.02.04	4	78.02	Al Sector Privado No Financiero			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1253	78.02.06	4	78.02	Becas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1254	78.03	3	78	Transferencias y Donaciones de Inversión al Sector Externo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1255	78.03.01	4	78.03	Al Sector Externo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1256	78.06	3	78	Aportes y Participaciones para Inversión al Régmen Seccional Autónomo			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1257	78.06.03	4	78.06	Al Fondo de Inversiones Municipales por Aporte del FODESEC			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1258	78.06.04	4	78.06	A Municipios Capitales de Provincia por Aporte del FODESEC			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1259	78.06.05	4	78.06	A Consejos Provinciales por Aporte del FODESEC			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1260	78.06.06	4	78.06	Al INGALA por Aporte del FODESEC			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1261	78.07	3	78	Participaciones de Capital en los Ingresos Petroleros a Favor de la Fuente Fisca			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1262	78.07.01	4	78.07	Por Regalías de Petroecuador			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1263	78.07.02	4	78.07	Por Regalías de Participación del Estado			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1264	78.07.03	4	78.07	Por Regalías de Campos Marginales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1265	78.07.04	4	78.07	Por Regalías de Alianzas Operativas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1266	78.07.05	4	78.07	Por Exportaciones Directas de Petroecuador Ex-Consorcio			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1267	78.07.06	4	78.07	Por Exportaciones Directas de Petroecuador Nororiental 28			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1268	78.07.07	4	78.07	Por Exportaciones de Crudo Participación con City Oriente Bloque 27			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1269	78.07.08	4	78.07	Por Exportaciones de Crudo Participación con YPF Bloque 16 y CAPIRON			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1270	78.07.09	4	78.07	Por Exportaciones de Crudo Participación con Canadá Grande Bloque 1			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1271	78.07.10	4	78.07	Por Exportaciones de Crudo Participación con PERENCO Campo Payamino y Bloque 7 y			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1272	78.07.11	4	78.07	Por Exportaciones de Crudo Participación con Occidental Lim. y Bloque 15 de Edén			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1273	78.07.12	4	78.07	De Exportaciones de Crudo Participación Petroriental (Ex-ENCANA) Bloque 14 y 17			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1274	78.07.13	4	78.07	Por Exportaciones de Crudo Participación con Ecuador TLC Bloque 18 y Campo Compa			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1275	78.07.14	4	78.07	Por Exportaciones de Crudo Participación con CNPC Bloque 11 Cristal Rubí			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1276	78.07.15	4	78.07	Por Exportaciones Directas de Campos  Marginales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1277	78.07.16	4	78.07	Por Exportaciones Directas e Alianzas Operativas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1278	78.07.17	4	78.07	Por Exportaciones Directas Diferencial de Calidad			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1279	78.07.18	4	78.07	Por Expoetaciones Directas de Compañías de Prestación de Servicios			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1280	78.07.19	4	78.07	Por Exportaciones Directas de Compañías de Prestación de Servicios Especificos E			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1281	78.07.20	4	78.07	Por Exportaciones Directas de Compañías de Prestación de Servicios Específicos T			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1282	78.07.21	4	78.07	Por Participación Excedentes de Precios de Contratos Petroleros con Andes Petrol			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1283	78.07.22	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con City Orie			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1284	78.07.23	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con Perenco 7			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1285	78.07.24	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con Petririen			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1286	78.07.25	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con REPSOL YP			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1287	78.07.26	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con Ecuador T			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1288	78.07.27	4	78.07	Por Participación de Excedentes de Precios de Contratos Petroleros con Canadá G			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1289	78.08	3	78	Por Participaciones de Capital de los Entes Públicos y Privados en los Ingresos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1290	78.08.01	4	78.08	Al Gobierno Central			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1291	78.08.02	4	78.08	A Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1292	78.08.03	4	78.08	A Entidades Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1293	78.08.04	4	78.08	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1294	78.08.05	4	78.08	A la Seguridad Social			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1295	78.08.06	4	78.08	A Entidades Financieras Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1296	78.08.08	4	78.08	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1297	78.08.11	4	78.08	Al Sector Privado			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1298	78.09	3	78	Por Participaciones para Inversión de los Entes Públicos y Privados en Ingresos			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1299	78.09.01	4	78.09	Al Gobierno Central			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1300	78.09.02	4	78.09	A Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1301	78.09.03	4	78.09	A Empresas Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1302	78.09.04	4	78.09	A Entiadades del Gobierno Seccional			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1303	78.09.05	4	78.09	A la Seguridad Social			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1304	78.09.06	4	78.09	A Entidades Financieras Públicas			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1305	78.09.08	4	78.09	a Cuentas o Fondos Especiales			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1306	78.09.11	4	78.09	Al Sector Privado			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1307	78.99	3	78	Asignaciones a Distribuir			0	0	0	0	0	27	\N	1	2025-01-28 10:27:52	\N	\N
1308	78.99.01	4	78.99	Asignación a Distribuir para Transferencias y Donaciones de Inversión			0	0	\N	\N	\N	27	\N	1	2025-01-28 10:27:52	\N	\N
1309	8	1	0	GASTOS DE CAPITAL			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1310	84	2	8	ACTIVOS DE LARGA DURACION		213.84	88000	2464	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1311	84.01	3	84	Bienes Muebles			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1312	84.01.03	4	84.01	Mobiliarios			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1313	84.01.04	4	84.01	Maquinarias y Equipos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1314	84.01.05	4	84.01	Vehículos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1315	84.01.06	4	84.01	Herramientas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1316	84.01.07	4	84.01	Equipos, Sistemas y Paquetes Informáticos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1317	84.01.08	4	84.01	Bienes Artísticos y Culturales			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1318	84.01.09	4	84.01	Libros y Colecciones			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1319	84.01.10	4	84.01	Pertrechos para la Defensa y Seguridad Pública			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1320	84.01.11	4	84.01	Partes y Repuestos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1321	84.01.14	4	84.01	Instrumental Medico			\N	\N	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1322	84.01.15	4	84.01	Equipo Odontologico			\N	\N	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1323	84.02	3	84	Bienes Inmuebles			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1324	84.02.01	4	84.02	Terrenos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1325	84.02.02	4	84.02	Edificios, Locales y Residencias			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1326	84.02.99	4	84.02	Otros Bienes Inmuebles			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1327	84.03	3	84	Expropiaciones de Bienes			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1328	84.03.01	4	84.03	Terrenos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1329	84.03.02	4	84.03	Edificios , Locales y Residencias			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1330	84.03.99	4	84.03	Otras Expropiaciones de Bienes			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1331	84.04	3	84	Intangibles			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1332	84.04.01	4	84.04	Intangibles			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1333	84.04.02	4	84.04	Licencias Computacionales 			\N	\N	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1334	84.05	3	84	Bienes Biológicos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1335	84.05.12	4	84.05	Semovientes			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1336	84.05.13	4	84.05	Bosques			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1337	84.05.14	4	84.05	Acuáticos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1338	84.05.15	4	84.05	Plantas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1339	84.05.99	4	84.05	Otros Bienes Biológicos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1340	84.09	3	84	Créditos por Impuesto al Valor Agregado			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1341	84.09.01	4	84.09	Crédito Fiscal por Compras			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1342	84.99	3	84	Asignaciones a Distribuir			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1343	84.99.01	4	84.99	Asignación a Distribuir para Bienes de Larga Duración			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1344	87	2	8	INVERSIONES FINANCIERAS			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1345	87.01	3	87	Inversiones en Títulos y Valores			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1346	87.01.01	4	87.01	Certificados del Tesoro Nacional			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1347	87.01.02	4	87.01	Bonos del Estado			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1348	87.01.03	4	87.01	Depósitos a Plazo en Moneda de Curso Legal			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1349	87.01.04	4	87.01	Compra de Acciones			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1350	87.01.05	4	87.01	Depósitos a Plazo en Moneda Extranjera			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1351	87.01.06	4	87.01	Participaciones de Capital			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1352	87.01.07	4	87.01	Particpaciones Fiduciarias			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1353	87.01.98	4	87.01	Otros Títulos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1354	87.01.99	4	87.01	Otros Valores			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1355	87.02	3	87	Concesión de Préstamos			0	0	0	0	0	28	\N	1	2025-01-28 10:27:52	\N	\N
1356	87.02.01	4	87.02	Al Gobierno Central			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1357	87.02.02	4	87.02	A Entidades Decentralizadas y Autónomas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1358	87.02.03	4	87.02	A Empresas Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1359	87.02.04	4	87.02	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1360	87.02.05	4	87.02	A la Seguridad Social			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1361	87.02.06	4	87.02	A Entidades Financieras Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1362	87.02.07	4	87.02	Al Sector Privado			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1363	87.02.11	4	87.02	Anticipos a Servidores Públicos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1364	87.02.13	4	87.02	Anticipos a Contratistas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1365	87.03	3	87	Inverciones Permanentes en Títulos y Valores			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1366	87.03.01	4	87.03	Certificado del Tesoro Nacional			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1367	87.03.02	4	87.03	Bonos del Estado			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1368	87.03.04	4	87.03	Compra de Acciones			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1369	87.03.06	4	87.03	Participaciones de Capital			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1370	87.03.07	4	87.03	Participaciones Fiduciarias			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1371	87.03.98	4	87.03	Otros Títulos			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1372	87.03.99	4	87.03	Otros Valores			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:52	\N	\N
1373	87.99	3	87	Asignaciones a Distribuir			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1374	87.99.01	4	87.99	Asignación a Distribuir para Inversiones Financieras			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1375	88	2	8	TRANSFERENCIAS Y DONACIONES DE CAPITAL			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1376	88.01	3	88	Transferencias de Capital al Sector Público			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1377	88.01.01	4	88.01	Al Gobierno Central			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1378	88.01.02	4	88.01	A Entidades Decentralizadas y Autónomas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1379	88.01.03	4	88.01	A Empresas Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1380	88.01.04	4	88.01	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1381	88.01.05	4	88.01	A la Seguridad Social			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1382	88.01.06	4	88.01	A Entidades Financieras Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1383	88.01.08	4	88.01	A Fondos y Cuentas Especiales			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1384	88.01.10	4	88.01	Al Fondo de Contingencias			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1385	88.02	3	88	Donaciones de Capital al Sector Privado Interno			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1386	88.02.03	4	88.02	Al Sector Privado Financiero			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1387	88.02.04	4	88.02	Al Sector Privado No Financiero			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1388	88.04	3	88	Aportes y Participaciones al Sector Público			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1389	88.04.01	4	88.04	Por Exportación Hidrocarburos y Derivados			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1390	88.04.02	4	88.04	Por Aplicación del Fondo de Inversión Petrolera			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1391	88.04.08	4	88.04	Por Aplicación de Cuentas y Fondos Especiales			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1392	88.04.99	4	88.04	Por Otras Participaciones y Aportes			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1393	88.06	3	88	Aportes y Participaciones  para Capital e Inversión al Régimen Seccional Autónom			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1394	88.06.09	4	88.06	Aportes Según Ley 47 y su Reforma			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1395	88.06.11	4	88.06	A los Consejos Provinciales por Aporte del FONDEPRO			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1396	88.06.12	4	88.06	Al INGALA por Aporte del FODEPRO			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1397	88.06.13	4	88.06	A los Consejos Provinciales por Aporte del FONDEPRO a Través del Banco del Estad			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1398	88.06.14	4	88.06	Al INGALA del FONDEPRO a través del Banco del Estado			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1399	88.06.16	4	88.06	A Municipios por Aporte del Fondo de Decentralización			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1400	88.06.17	4	88.06	A Consejos Provinciales por Aporte del Fondo de Decentralización			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1401	88.09	3	88	Por Participacios de Capital de los Entes Públicos y Privados en los Ingresos Pr			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1402	88.09.01	4	88.09	Al Gobierno Central			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1403	88.09.02	4	88.09	A Entidades Descentralizadas y Autónomas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1404	88.09.03	4	88.09	A Empresas Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1405	88.09.04	4	88.09	A Entidades del Gobierno Seccional			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1406	88.09.05	4	88.09	A la Seguridad Social			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1407	88.09.06	4	88.09	A Entidades Financieras Públicas			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1408	88.09.08	4	88.09	A Cuentas o Fondos Especiales			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1409	88.09.11	4	88.09	Al Sector Privado			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1410	88.99	3	88	Asignaciones a Distribuir			0	0	0	0	0	28	\N	1	2025-01-28 10:27:53	\N	\N
1411	88.99.01	4	88.99	Asignación a Distribuir para Transferencias y Donaciones de Capital			0	0	\N	\N	\N	28	\N	1	2025-01-28 10:27:53	\N	\N
1412	9	1	0	APLICACION DEL FINANCIAMIENTO			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1413	96	2	9	AMORTIZACION DE LA DEUDA PUBLICA			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1414	96.01	3	96	Amortizaciones de Titulos y Valores			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1415	96.01.01	4	96.01	Certificados del Tesoro Nacional			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1416	96.01.02	4	96.01	Bonos del Estado			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1417	96.01.98	4	96.01	Otros Títulos			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1418	96.01.99	4	96.01	Otros  Valores			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1419	96.02	3	96	Deuda Interna			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1420	96.02.01	4	96.02	Al Sector Público Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1421	96.02.02	4	96.02	Al Sector Público No Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1422	96.02.03	4	96.02	Al Sector Privado Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1423	96.02.04	4	96.02	Al Sector Privado No Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1424	96.02.05	4	96.02	A la Seguridad Social			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1425	96.03	3	96	Amortizaciones Deuda Externa			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1426	96.03.01	4	96.03	A Organismos Multilaterales			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1427	96.03.02	4	96.03	A Gobiernos y Organismos Gubernamentales			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1428	96.03.03	4	96.03	Al Sector Privado Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1429	96.03.04	4	96.03	Al Sector Privado No Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1430	96.05	3	96	Amortización de credito de Proveedores Externos			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1431	96.05.02	4	96.05	A Sector Público no Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1432	96.05.04	4	96.05	Al Sector Privado no Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1433	96.06	3	96	Amortización de Crédito de Proveedores Externos			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1434	96.06.04	4	96.06	Al Sector Privado no Financiero			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1435	96.99	3	96	Asignaciones a  Distribuir			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1436	96.99.01	4	96.99	Asignación a Distribuir para Amortización de la Deuda Pública			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1437	97	2	9	PASIVO CIRCULANTE		213.97.02	0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1438	97.01	3	97	Deuda Flotante			0	0	0	0	0	39	\N	1	2025-01-28 10:27:53	\N	\N
1439	97.01.01	4	97.01	De Cuentas por Paagar			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1440	97.01.02	4	97.01	Depósitos de Terceros			0	0	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1441	99	2	9	OTROS PASIVOS			\N	\N	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1442	99.01	3	99	Obligaciones no Reconocidas ni Pagadas de Ejercicios Anteriores			\N	\N	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
1443	99.01.01	4	99.01	Obligaciones de Ejercicios Anteriores por Egresos de Personal			\N	\N	\N	\N	\N	39	\N	1	2025-01-28 10:27:53	\N	\N
\.


--
-- TOC entry 4925 (class 0 OID 5732634)
-- Dependencies: 220
-- Data for Name: estructura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estructura (idestructura, nivel, nombre, longitud) FROM stdin;
1	1	PROCESOS	2
2	2	PROYECTO O GESTION	2
3	3	UNIDAD DE GESTION	2
\.


--
-- TOC entry 4931 (class 0 OID 5732675)
-- Dependencies: 226
-- Data for Name: gruposbene; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gruposbene (idgrupo, codgru, nomgru, modulo1, modulo2, modulo3, modulo4, modulo5, modulo6) FROM stdin;
1	P	PROVEEDORES	1	0	0	0	0	0
2	C	CLIENTES	1	0	0	0	0	0
3	I	INSTITUCIONES	1	0	0	0	0	0
4	E	EMPLEADOS	1	0	0	0	0	0
5	T	TRABAJADORES	1	0	0	0	0	0
6	D	DIETAS	1	0	0	0	0	0
7	A	A CONTRATO	1	0	0	0	0	0
8	G	GARANTIAS	1	0	0	0	0	0
\.


--
-- TOC entry 4923 (class 0 OID 5732629)
-- Dependencies: 218
-- Data for Name: ifinan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ifinan (idifinan, codifinan, nomifinan, foto) FROM stdin;
1	00000000	(Ninguno)	\N
2	01600022	BANCO PICHINCHA	\N
3	01600063	BANCO AMAZONAS	\N
4	01600170	BANCO UNIBANCO S.A.	\N
5	01600204	BANCO DE LOS ANDES	\N
6	01600212	BANCO INTERNACIONAL	\N
7	01600303	BANCO PRODUCBANCO	\N
8	01600386	BANCO PROMERICA	\N
9	01600491	BANCO PROCREDIT	\N
10	01600782	BANCO RUMIÑAHUI	\N
11	01600824	BANCO SUDAMERICANO	\N
12	01600832	BANCO COFIEC	\N
13	01600873	BANCO CENTRO MUNDO	\N
14	01600907	BANCO SOLIDARIO	\N
15	02600013	BANCO TERRITORIAL	\N
16	02600021	BANCO DE GUAYAQUIL	\N
17	02600187	BANCO DEL PACIFICO	\N
18	02600344	BANCO BOLIVARIANO	\N
19	02600831	DELBANK	\N
20	02600856	BANCO DEL LITORAL	\N
21	03600186	BANCO DEL AUSTRO	\N
22	59600049	BANCO DE LOJA	\N
23	68600014	BANCO MACHALA	\N
24	75600064	BANCO COMERCIAL DE MANABI	\N
25	01600105	BANCO LLOYDS BANK	\N
26	01600147	BANCO CITY BANK	\N
27	01410034	BANCO DE FOMENTO	\N
28	01500016	BANCO DE LA VIVIENDA	\N
29	01700012	MUTUALISTA PICHINCHA	\N
30	01700020	MUTUALISTA BENALCAZAR	\N
31	03700028	MUTUALISTA AZUAY	\N
32	15700016	MUTUALISTA AMBATO	\N
33	47700018	MUTUALISTA IMBABURA	\N
34	01700417	COOP. PREVISION AHORRO Y DESARROLLO	\N
35	01700418	COOP. ANDALUCIA	\N
36	01700419	COOP. PEQ. EMPRESA DE PASTAZA	\N
37	01700426	COOP. PROGRESO	\N
38	01700427	COOP. 29 DE OCTUBRE	\N
39	01700434	COOP. COTOCOLLAO	\N
40	01700435	COOP. ALIANZA DEL VALLE LTDA.	\N
41	01700436	COOP. CAMARA DE COMERCIO DE QUITO	\N
42	01700880	COOP. DESARROLLO PUEBLOS	\N
43	01700885	COOP. 23 DE JULIO	\N
44	02710218	COOP. NACIONAL	\N
45	02710236	COOP. LA DOLOROSA	\N
46	03700113	COOP. JUV. ECUAT.PROGRESISTA LTDA.	\N
47	15700001	COOP. OSCUS	\N
48	15700017	COOP. EL SAGRARIO	\N
49	15700040	COOP. SAN FRANCISCO	\N
50	19700001	COOP. CACPE BIBLIAN LTDA.	\N
51	43700001	COOP. GUARANDA	\N
52	43700010	COOP. SAN JOSE	\N
53	47700037	COOP. ATUNTAQUI	\N
54	55700005	COOP. 9 DE OCTUBRE LTDA.	\N
55	55700010	COOP. CACPECO	\N
56	59700001	COOP. COOPMEGO	\N
57	59700002	COOP. EL PORVENIR (LOJA)	\N
58	59700003	COOP. PADRE JULIAN LORENTE	\N
59	68700054	COOP. ONCE DE JUNIO	\N
60	68700055	COOP. SANTA ROSA LTDA.	\N
61	75700001	COOP. CHONE LTDA.	\N
62	75710001	COOP. COMERCIO	\N
63	75710002	COOP. SANTA ANA	\N
64	75710003	COOP. CALCETA LTDA.	\N
65	75710004	COOP. 15 DE ABRIL(PORTOVIEJO)	\N
66	79700027	COOP. RIOBAMBA	\N
67	79700028	COOP. JESÚS DEL GRAN PODER	\N
68	89700001	COOP. PABLO MUÑOZ VEGA	\N
69	89700035	COOP. TULCAN	\N
70	15703021	COOP. MUSHUC RUNA	\N
71	79700035	COOP. FERNANDO DAQUILEMA	\N
72	01410036	BANECUADOR	\N
73	03700114	COOP. JARDIN AZUAYO	\N
74	01700511	COOP. DE AH.Y CRED.POLICIA NACIONAL 	\N
\.


--
-- TOC entry 4921 (class 0 OID 5732622)
-- Dependencies: 216
-- Data for Name: niveles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.niveles (idnivel, nomniv, longniv) FROM stdin;
1	TITULO	1
2	GRUPO	2
3	SUBGRUPO	3
4	Cuenta de nivel 1	6
5	Cuenta de nivel 2	9
6	Cuenta de nivel 3	13
7	Cuenta de nivel 4	16
\.


--
-- TOC entry 4935 (class 0 OID 5732698)
-- Dependencies: 230
-- Data for Name: presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.presupuesto (idpresupuesto, tippar, codpar, codigo, nompar, inicia, totmod, totcerti, totmisos, totdeven, arrastre, arrastreaa, idproyecto, idclasificador, usucrea, feccrea, usumodi, fecmodi) FROM stdin;
1	1	13.01.07.01.001	13.01.07.01.001	Venta de Bases	1200	0	0	0	0	0	0	1	81	1	2025-01-28 10:28:03	\N	\N
2	1	13.01.99.01.001	13.01.99.01.001	Por mantenimiento e incoporacion predios nuevo catastro	20000	0	0	0	0	0	0	1	97	1	2025-01-28 10:28:03	\N	\N
3	1	14.03.01.01.001	14.03.01.01.001	Agua Potable Suministros (cargo fijo)	1412931.94	0	0	0	0	0	0	1	155	1	2025-01-28 10:28:03	\N	\N
4	1	14.03.01.01.002	14.03.01.01.002	Agua Potable Suministros (cargo variable)	2895794.42	0	0	0	0	0	0	1	155	1	2025-01-28 10:28:03	\N	\N
5	1	14.03.01.02.001	14.03.01.02.001	Conexion y Reconexion de Agua Potable	226464.93	0	0	0	0	0	0	1	155	1	2025-01-28 10:28:03	\N	\N
6	1	14.03.01.03.001	14.03.01.03.001	Venta de Medidores	181168.09	0	0	0	0	0	0	1	155	1	2025-01-28 10:28:03	\N	\N
7	1	14.03.03.01.001	14.03.03.01.001	Alcantarillado Servicios (cargo variable)	2416067.72	0	0	0	0	0	0	1	157	1	2025-01-28 10:28:03	\N	\N
8	1	14.03.03.01.002	14.03.03.01.002	Alcantarillado Servicio (cargo fijo)	1038042.27	0	0	0	0	0	0	1	157	1	2025-01-28 10:28:03	\N	\N
9	1	14.03.03.02.001	14.03.03.02.001	Conexion y Reconexion de Alcantarillado	92840.85	0	0	0	0	0	0	1	157	1	2025-01-28 10:28:03	\N	\N
10	1	14.03.99.01.001	14.03.99.01.001	Servicios Tecnicos y Administrativos	149467.91	0	0	0	0	0	0	1	167	1	2025-01-28 10:28:03	\N	\N
11	1	17.03.99.01.001	17.03.99.01.001	Costos Emision Titulos de Credito en Computacion	1500	0	0	0	0	0	0	1	205	1	2025-01-28 10:28:03	\N	\N
12	1	17.03.99.03.001	17.03.99.03.001	Por costas Judiciales	9.9	0	0	0	0	0	0	1	205	1	2025-01-28 10:28:03	\N	\N
13	1	17.03.99.04.001	17.03.99.04.001	Interes por Mora	195933.22	0	0	0	0	0	0	1	205	1	2025-01-28 10:28:03	\N	\N
14	1	17.04.04.00.001	17.04.04.00.001	Incumplimientos de Contratos	33771.69	0	0	0	0	0	0	1	210	1	2025-01-28 10:28:03	\N	\N
15	1	17.04.99.01.001	17.04.99.01.001	Otras Multas	1636.39	0	0	0	0	0	0	1	214	1	2025-01-28 10:28:03	\N	\N
16	1	37.01.02.01.001	37.01.02.01.001	Saldo de Caja Bancos	1856209.71	0	0	0	0	0	0	1	445	1	2025-01-28 10:28:03	\N	\N
17	1	38.01.01.01.001	38.01.01.01.001	Cuentas por Cobrar Servicios Cartera Vencida	1204665.99	0	0	0	0	0	0	1	451	1	2025-01-28 10:28:03	\N	\N
18	1	38.01.07.00.001	38.01.07.00.001	Anticipos por devengar ejericios anteriores bienes y servicios	1742693.07	0	0	0	0	0	0	1	453	1	2025-01-28 10:28:03	\N	\N
19	1	38.01.08.00.001	38.01.08.00.001	Anticipos por devengar ejericios anteriores obras	87831.43	0	0	0	0	0	0	1	454	1	2025-01-28 10:28:03	\N	\N
20	2	010101.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	45576	0	0	0	0	0	0	4	461	1	2025-01-28 10:28:03	\N	\N
21	2	010101.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3798	0	0	0	0	0	0	4	467	1	2025-01-28 10:28:03	\N	\N
22	2	010101.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	475	0	0	0	0	0	0	4	468	1	2025-01-28 10:28:03	\N	\N
23	2	010101.51.06.01.000.000.001	51.06.01.000.000.001	  Aporte Patronal  	4398.08	0	0	0	0	0	0	4	530	1	2025-01-28 10:28:03	\N	\N
24	2	010101.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3796.48	0	0	0	0	0	0	4	531	1	2025-01-28 10:28:03	\N	\N
25	2	010101.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	3798	0	0	0	0	0	0	4	542	1	2025-01-28 10:28:03	\N	\N
26	2	010101.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	4	565	1	2025-01-28 10:28:03	\N	\N
27	2	010101.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	24.96	0	0	0	4	566	1	2025-01-28 10:28:03	\N	\N
28	2	010101.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	1500	0	0	0	0	0	0	4	575	1	2025-01-28 10:28:03	\N	\N
29	2	010101.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	5000	0	0	34832.8	0	150000	0	4	576	1	2025-01-28 10:28:03	\N	\N
30	2	010101.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	10000	0	0	0	0	0	0	4	597	1	2025-01-28 10:28:03	\N	\N
31	2	010101.53.07.02.000.000.001	53.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	0	0	0	0	0	0	0	4	626	1	2025-01-28 10:28:03	\N	\N
32	2	010101.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	9000	0	0	0	0	0	0	4	631	1	2025-01-28 10:28:03	\N	\N
33	2	010101.53.02.55.000.000.001	53.02.55.000.000.001	 Combustibles 	20000	0	0	4240.39	0	0	0	4	584	1	2025-01-28 10:28:03	\N	\N
34	2	010101.57.01.02.000.000.001	57.01.02.000.000.001	Tasas generales impuestos contribuciones permisos licencias y patentes 	1000	0	0	0	0	0	0	4	697	1	2025-01-28 10:28:03	\N	\N
35	2	010101.57.02.01.000.000.001	57.02.01.000.000.001	 Seguros  	5300	0	0	1156.53	0	0	0	4	702	1	2025-01-28 10:28:03	\N	\N
36	2	020101.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	57192	0	0	0	0	0	0	7	461	1	2025-01-28 10:28:03	\N	\N
37	2	020101.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	4766	0	0	0	0	0	0	7	467	1	2025-01-28 10:28:03	\N	\N
38	2	020101.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	7	468	1	2025-01-28 10:28:03	\N	\N
39	2	020101.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	5519.03	0	0	0	0	0	0	7	530	1	2025-01-28 10:28:03	\N	\N
40	2	020101.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	4764.09	0	0	0	0	0	0	7	531	1	2025-01-28 10:28:03	\N	\N
41	2	020101.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	7	565	1	2025-01-28 10:28:03	\N	\N
42	2	020101.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones 	1035.3	0	0	0	0	0	0	7	566	1	2025-01-28 10:28:03	\N	\N
43	2	020101.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	1000	0	0	0	0	0	0	7	575	1	2025-01-28 10:28:03	\N	\N
44	2	020101.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia  	2000	0	0	0	0	0	0	7	576	1	2025-01-28 10:28:03	\N	\N
45	2	020101.53.07.02.000.000.001	53.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	600	0	0	210	0	210	0	7	626	1	2025-01-28 10:28:03	\N	\N
46	2	020101.53.07.04.000.000.001	53.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	1500	0	0	0	0	0	0	7	628	1	2025-01-28 10:28:03	\N	\N
47	2	020101.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	1000	0	0	1336.84	0	2518.95	0	7	631	1	2025-01-28 10:28:03	\N	\N
48	2	020101.57.02.01.000.000.001	57.02.01.000.000.001	 Seguros 	3700	0	0	0	0	0	0	7	702	1	2025-01-28 10:28:03	\N	\N
49	2	020101.57.02.06.000.000.001	57.02.06.000.000.001	 Costas Judiciales tramites notariales legalizacion de documentos y arreglos  	23000	0	0	0	0	0	0	7	707	1	2025-01-28 10:28:03	\N	\N
50	2	020102.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	40608	0	0	0	0	0	0	35	461	1	2025-01-28 10:28:03	\N	\N
51	2	020102.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3384	0	0	0	0	0	0	35	467	1	2025-01-28 10:28:03	\N	\N
52	2	020102.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	35	468	1	2025-01-28 10:28:03	\N	\N
53	2	020102.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	3918.67	0	0	0	0	0	0	35	530	1	2025-01-28 10:28:03	\N	\N
54	2	020102.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3382.65	0	0	0	0	0	0	35	531	1	2025-01-28 10:28:03	\N	\N
55	2	020102.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	35	565	1	2025-01-28 10:28:03	\N	\N
56	2	020102.53.02.04.000.000.001	53.02.04.000.000.001	 edicion imprension reproduccion 	0	0	0	0	0	88	0	35	572	1	2025-01-28 10:28:03	\N	\N
57	2	020102.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones 	1035.3	0	0	0	0	0	0	35	566	1	2025-01-28 10:28:03	\N	\N
58	2	020102.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	1500	0	0	0	0	0	0	35	575	1	2025-01-28 10:28:03	\N	\N
59	2	020102.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia  	4000	0	0	0	0	3399.39	0	35	576	1	2025-01-28 10:28:03	\N	\N
60	2	020102.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	1000	0	0	0	0	0	0	35	597	1	2025-01-28 10:28:03	\N	\N
61	2	020102.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	1500	0	0	0	0	0	0	35	631	1	2025-01-28 10:28:03	\N	\N
62	2	020102.53.14.03.000.000.001	53.14.03.000.000.001	 Mobiliarios 	1000	0	0	0	0	0	0	35	658	1	2025-01-28 10:28:03	\N	\N
63	2	020102.53.14.07.000.000.001	53.14.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	500	0	0	0	0	0	0	35	661	1	2025-01-28 10:28:03	\N	\N
64	2	020102.84.01.03.000.000.001	84.01.03.000.000.001	 Mobiliarios  	5000	0	0	0	0	0	0	35	1312	1	2025-01-28 10:28:03	\N	\N
65	2	020102.84.04.02.000.000.001	84.04.02.000.000.001	 Licencias Computacionales 	300	0	0	0	0	0	0	35	1333	1	2025-01-28 10:28:03	\N	\N
66	2	020102.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	5000	0	0	0	0	0	0	35	1316	1	2025-01-28 10:28:03	\N	\N
67	2	020103.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	37056	0	0	0	0	0	0	36	461	1	2025-01-28 10:28:03	\N	\N
68	2	020103.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3088	0	0	0	0	0	0	36	467	1	2025-01-28 10:28:03	\N	\N
69	2	020103.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	950	0	0	0	0	0	0	36	468	1	2025-01-28 10:28:03	\N	\N
70	2	020103.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	3575.9	0	0	0	0	0	0	36	530	1	2025-01-28 10:28:03	\N	\N
71	2	020103.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3086.76	0	0	0	0	0	0	36	531	1	2025-01-28 10:28:03	\N	\N
72	2	020103.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	36	565	1	2025-01-28 10:28:03	\N	\N
73	2	020103.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones 	1035.3	0	0	0	0	0	0	36	566	1	2025-01-28 10:28:03	\N	\N
74	2	020103.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia  	3000	0	0	0	0	0	0	36	576	1	2025-01-28 10:28:03	\N	\N
75	2	020103.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	10000	0	0	0	0	0	0	36	597	1	2025-01-28 10:28:03	\N	\N
76	2	020103.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	12000	0	0	0	0	0	0	36	625	1	2025-01-28 10:28:03	\N	\N
77	2	020103.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	2000	0	0	0	0	0	0	36	631	1	2025-01-28 10:28:03	\N	\N
78	2	030101.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	107580	0	0	0	0	0	0	10	461	1	2025-01-28 10:28:03	\N	\N
79	2	030101.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	8965	0	0	0	0	0	0	10	467	1	2025-01-28 10:28:03	\N	\N
80	2	030101.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	4750	0	0	0	0	0	0	10	468	1	2025-01-28 10:28:03	\N	\N
81	2	030101.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	10381.47	0	0	0	0	0	0	10	530	1	2025-01-28 10:28:03	\N	\N
82	2	030101.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	8961.41	0	0	0	0	0	0	10	531	1	2025-01-28 10:28:03	\N	\N
83	2	030101.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	733	0	0	0	0	0	0	10	542	1	2025-01-28 10:28:03	\N	\N
84	2	030101.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	10	565	1	2025-01-28 10:28:03	\N	\N
85	2	030101.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	10	566	1	2025-01-28 10:28:03	\N	\N
86	2	030101.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	2000	0	0	0	0	0	0	10	575	1	2025-01-28 10:28:03	\N	\N
87	2	030101.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1000	0	0	0	0	0	0	10	576	1	2025-01-28 10:28:03	\N	\N
88	2	030101.53.04.03.000.000.001	53.04.03.000.000.001	 Mobiliarios  	1000	0	0	0	0	0	0	10	595	1	2025-01-28 10:28:03	\N	\N
89	2	030101.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	25000	0	0	0	0	0	0	10	597	1	2025-01-28 10:28:03	\N	\N
90	2	030101.53.05.02.000.000.001	53.05.02.000.000.001	 Edificios Locales y Residencias Parqueaderos Casilleros Judiciales y Bancari 	19200	0	0	3200	0	4800	0	10	609	1	2025-01-28 10:28:03	\N	\N
91	2	030101.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	8000	0	0	0	0	0	0	10	631	1	2025-01-28 10:28:03	\N	\N
92	2	030101.53.08.04.000.000.001	53.08.04.000.000.001	 Material de Oficina  	3000	0	0	0	0	0	0	10	633	1	2025-01-28 10:28:03	\N	\N
93	2	030101.53.08.05.000.000.001	53.08.05.000.000.001	 Material de aseo  	2000	0	0	0	0	0	0	10	634	1	2025-01-28 10:28:03	\N	\N
94	2	030101.53.16.01.000.000.001	53.16.01.000.000.001	 Fondos de Reposicion Cajas Chicas 	5000	0	0	0	0	0	0	10	670	1	2025-01-28 10:28:03	\N	\N
95	2	030101.57.01.02.000.000.001	57.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	1000	0	0	840	0	0	0	10	697	1	2025-01-28 10:28:03	\N	\N
96	2	030101.57.02.01.000.000.001	57.02.01.000.000.001	 Seguros  	2700	0	0	123781.29	0	123781.29	0	10	702	1	2025-01-28 10:28:03	\N	\N
97	2	030102.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	75576	0	0	0	0	0	0	11	461	1	2025-01-28 10:28:03	\N	\N
98	2	030102.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	6298	0	0	0	0	0	0	11	467	1	2025-01-28 10:28:03	\N	\N
99	2	030102.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	2375	0	0	0	0	0	0	11	468	1	2025-01-28 10:28:03	\N	\N
100	2	030102.51.05.07.000.000.001	51.05.07.000.000.001	 Honorarios 	4739.66	0	0	0	0	606	0	11	522	1	2025-01-28 10:28:03	\N	\N
101	2	030102.51.05.12.000.000.001	51.05.12.000.000.001	 Subrogacion  	58854.14	0	0	0	0	0	0	11	527	1	2025-01-28 10:28:03	\N	\N
102	2	030102.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	7293.08	0	0	0	0	0	0	11	530	1	2025-01-28 10:28:03	\N	\N
103	2	030102.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	6295.48	0	0	0	0	0	0	11	531	1	2025-01-28 10:28:03	\N	\N
104	2	030102.51.07.02.000.000.001	51.07.02.000.000.001	 Supresion de Puesto 	40000	0	0	0	0	0	0	11	537	1	2025-01-28 10:28:03	\N	\N
105	2	030102.51.07.03.000.000.001	51.07.03.000.000.001	 Despido Intempestivo 	70000	0	0	0	0	0	0	11	538	1	2025-01-28 10:28:03	\N	\N
106	2	030102.51.07.04.000.000.001	51.07.04.000.000.001	 Compensacion por Desahucio 	30000	0	0	0	0	0	0	11	539	1	2025-01-28 10:28:03	\N	\N
107	2	030102.51.07.06.000.000.001	51.07.06.000.000.001	 Beneficio por Jubilacion 	160000	0	0	0	0	0	0	11	541	1	2025-01-28 10:28:03	\N	\N
108	2	030102.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	19003	0	0	0	0	0	0	11	542	1	2025-01-28 10:28:03	\N	\N
109	2	030102.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	11	565	1	2025-01-28 10:28:03	\N	\N
110	2	030102.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	11	566	1	2025-01-28 10:28:03	\N	\N
111	2	030102.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	2500	0	0	0	0	0	0	11	575	1	2025-01-28 10:28:03	\N	\N
112	2	030102.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1000	0	0	0	0	0	0	11	576	1	2025-01-28 10:28:03	\N	\N
113	2	030102.53.03.01.000.000.001	53.03.01.000.000.001	 Pasajes al Interior  	500	0	0	3	0	0	0	11	587	1	2025-01-28 10:28:03	\N	\N
114	2	030102.53.03.03.000.000.001	53.03.03.000.000.001	 Viaticos y Subsistencias en el Interior  	4500	0	0	397	0	0	0	11	589	1	2025-01-28 10:28:03	\N	\N
115	2	030102.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	1500	0	0	0	0	0	0	11	597	1	2025-01-28 10:28:03	\N	\N
116	2	030102.53.06.12.000.000.001	53.06.12.000.000.001	 Capacitaci n a Servidores Publicos 	45443.06	0	0	0	0	21425	0	11	623	1	2025-01-28 10:28:03	\N	\N
117	2	030102.53.07.03.000.000.001	53.07.03.000.000.001	 Arrendamientos de Equipos Informaticos 	15000	0	0	7746.4	0	8700.11	0	11	627	1	2025-01-28 10:28:03	\N	\N
118	2	030102.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	10000	0	0	0	0	0	0	11	631	1	2025-01-28 10:28:03	\N	\N
119	2	030102.57.02.01.000.000.001	57.02.01.000.000.001	 Seguros  	1500	0	0	0	0	0	0	11	702	1	2025-01-28 10:28:03	\N	\N
120	2	030102.84.01.04.000.000.001	84.01.04.000.000.001	Maquinarias y Equipos	800	0	0	0	0	0	0	11	1313	1	2025-01-28 10:28:03	\N	\N
121	2	030103.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	49200	0	0	0	0	0	0	12	461	1	2025-01-28 10:28:03	\N	\N
122	2	030103.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	4100	0	0	0	0	0	0	12	467	1	2025-01-28 10:28:03	\N	\N
123	2	030103.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	12	468	1	2025-01-28 10:28:03	\N	\N
124	2	030103.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	4747.8	0	0	0	0	0	0	12	530	1	2025-01-28 10:28:03	\N	\N
125	2	030103.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	4098.36	0	0	0	0	0	0	12	531	1	2025-01-28 10:28:03	\N	\N
126	2	030103.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	1212	0	0	0	0	0	0	12	542	1	2025-01-28 10:28:03	\N	\N
127	2	030103.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	12	565	1	2025-01-28 10:28:03	\N	\N
128	2	030103.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	12	566	1	2025-01-28 10:28:03	\N	\N
129	2	030103.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	2000	0	0	0	0	0	0	12	576	1	2025-01-28 10:28:03	\N	\N
130	2	030103.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	13000	0	0	0	0	0	0	12	631	1	2025-01-28 10:28:03	\N	\N
131	2	030104.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	34536	0	0	0	0	0	0	13	461	1	2025-01-28 10:28:03	\N	\N
132	2	030104.51.01.06.000.000.001	51.01.06.000.000.001	 Salarios Unificados  	350673.6	0	0	0	0	0	0	13	462	1	2025-01-28 10:28:03	\N	\N
133	2	030104.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	37696.8	0	0	0	0	0	0	13	467	1	2025-01-28 10:28:03	\N	\N
134	2	030104.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	28025	0	0	0	0	0	0	13	468	1	2025-01-28 10:28:03	\N	\N
135	2	030104.51.03.04.000.000.001	51.03.04.000.000.001	 Compensacion por Transporte  	7128	0	0	0	0	0	0	13	499	1	2025-01-28 10:28:03	\N	\N
136	2	030104.51.03.06.000.000.001	51.03.06.000.000.001	 Alimentacion  	35640	0	0	0	0	0	0	13	501	1	2025-01-28 10:28:03	\N	\N
137	2	030104.51.04.08.000.000.001	51.04.08.000.000.001	 Subsidio de Antiguedad 	3246.47	0	0	0	0	0	0	13	514	1	2025-01-28 10:28:03	\N	\N
138	2	030104.51.05.10.000.000.001	51.05.10.000.000.001	 Servicios Personales por Contrato 	67152	0	0	0	0	0	0	13	525	1	2025-01-28 10:28:03	\N	\N
139	2	030104.51.06.01.000.000.001	51.06.01.000.000.001	  Aporte Patronal  	53300.23	0	0	0	0	0	0	13	530	1	2025-01-28 10:28:03	\N	\N
140	2	030104.51.06.02.000.000.001	51.06.02.000.000.001	  Fondo de Reserva  	37681.72	0	0	0	0	0	0	13	531	1	2025-01-28 10:28:03	\N	\N
141	2	030104.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	13	565	1	2025-01-28 10:28:03	\N	\N
142	2	030104.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	13	566	1	2025-01-28 10:28:03	\N	\N
143	2	030104.53.04.02.000.000.001	53.04.02.000.000.001	 Edificios Locales Residencias y Cableado Estructurado  	15000	0	0	0	0	12755.46	0	13	594	1	2025-01-28 10:28:03	\N	\N
144	2	030104.53.04.04.000.000.001	53.04.04.000.000.001	 Maquinarias y Equipos 	0	0	0	1430	0	1430	0	13	596	1	2025-01-28 10:28:03	\N	\N
145	2	030104.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	1000	0	0	0	0	45351.58	0	13	597	1	2025-01-28 10:28:03	\N	\N
146	2	030104.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	18000	0	0	0	0	0	0	13	631	1	2025-01-28 10:28:03	\N	\N
147	2	030104.53.02.55.000.000.001	53.02.55.000.000.001	 Combustibles 	5000	0	0	0	0	0	0	13	584	1	2025-01-28 10:28:03	\N	\N
148	2	030104.53.08.11.000.000.001	53.08.11.000.000.001	 Insumos Materiales y Suministros para Constr. Electr. 	10000	0	0	0	0	21434.12	0	13	640	1	2025-01-28 10:28:03	\N	\N
149	2	030104.53.08.13.000.000.001	53.08.13.000.000.001	 Repuestos y Accesorios  	0	0	0	12300	0	58024.33	0	13	642	1	2025-01-28 10:28:03	\N	\N
150	2	030104.57.01.02.000.000.001	57.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	272.75	0	0	0	0	0	0	13	697	1	2025-01-28 10:28:03	\N	\N
151	2	030105.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	47688	0	0	0	0	0	0	14	461	1	2025-01-28 10:28:03	\N	\N
152	2	030105.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3974	0	0	0	0	0	0	14	467	1	2025-01-28 10:28:03	\N	\N
153	2	030105.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	14	468	1	2025-01-28 10:28:03	\N	\N
154	2	030105.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	4601.89	0	0	0	0	0	0	14	530	1	2025-01-28 10:28:03	\N	\N
155	2	030105.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3972.41	0	0	0	0	0	0	14	531	1	2025-01-28 10:28:03	\N	\N
156	2	030105.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	14	565	1	2025-01-28 10:28:03	\N	\N
157	2	030105.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	14	566	1	2025-01-28 10:28:03	\N	\N
158	2	030105.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	3000	0	0	0	0	0	0	14	576	1	2025-01-28 10:28:03	\N	\N
198	2	030203.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	18	566	1	2025-01-28 10:28:03	\N	\N
159	2	030105.53.02.26.000.000.001	53.02.26.000.000.001	 Servicios Medicos Hospitalarios y Complementarios 	7000	0	0	0	0	0	0	14	582	1	2025-01-28 10:28:03	\N	\N
160	2	030105.53.08.02.000.000.001	53.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	7000	0	0	0	0	0	0	14	631	1	2025-01-28 10:28:03	\N	\N
161	2	030105.53.08.05.000.000.001	53.08.05.000.000.001	 Material de aseo  	2500	0	0	0	0	0	0	14	634	1	2025-01-28 10:28:03	\N	\N
162	2	030105.75.01.07.000.000.001	75.01.07.000.000.001	 CONSTRUCCIONES Y EDIFICACIONES  	0	0	0	0	0	0	0	14	1194	1	2025-01-28 10:28:03	\N	\N
163	2	030105.84.01.15.000.000.001	84.01.15.000.000.001	Equipos Odontologicos	11000	0	0	0	0	5000	0	14	1322	1	2025-01-28 10:28:03	\N	\N
164	2	030201.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	42960	0	0	0	0	0	0	16	461	1	2025-01-28 10:28:03	\N	\N
165	2	030201.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer sueldo  	3580	0	0	0	0	0	0	16	467	1	2025-01-28 10:28:03	\N	\N
166	2	030201.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto sueldo  	950	0	0	0	0	0	0	16	468	1	2025-01-28 10:28:03	\N	\N
167	2	030201.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	4145.64	0	0	0	0	0	0	16	530	1	2025-01-28 10:28:03	\N	\N
168	2	030201.51.06.02.000.000.001	51.06.02.000.000.001	 Fondos de Reserva  	3578.57	0	0	0	0	0	0	16	531	1	2025-01-28 10:28:03	\N	\N
169	2	030201.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	2368	0	0	0	0	0	0	16	542	1	2025-01-28 10:28:03	\N	\N
170	2	030201.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	16	565	1	2025-01-28 10:28:03	\N	\N
171	2	030201.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	16	566	1	2025-01-28 10:28:03	\N	\N
172	2	030201.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	3200	0	0	0	0	0	0	16	575	1	2025-01-28 10:28:03	\N	\N
173	2	030201.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	2000	0	0	0	0	1847.78	0	16	576	1	2025-01-28 10:28:03	\N	\N
174	2	030201.53.04.05.000.000.001	53.04.05.000.000.001	 Vehiculos  	15000	0	0	0	0	0	0	16	597	1	2025-01-28 10:28:03	\N	\N
175	2	030201.57.02.01.000.000.001	57.02.01.000.000.001	 Seguros  	3300	0	0	0	0	0	0	16	702	1	2025-01-28 10:28:03	\N	\N
176	2	030201.58.01.02.000.000.001	58.01.02.000.000.001	 A Entidades Descentralizadas y Autonomas  	60000	0	0	9639.64	0	0	0	16	720	1	2025-01-28 10:28:03	\N	\N
177	2	030201.78.01.02.000.200.001	78.01.02.000.200.001	 Capital Credito 65192 	934087.56	0	0	0	0	0	0	16	1245	1	2025-01-28 10:28:03	\N	\N
178	2	030201.78.01.02.000.201.001	78.01.02.000.201.001	 Interes Credito 65192 	1218458.23	0	0	0	0	0	0	16	1245	1	2025-01-28 10:28:03	\N	\N
179	2	030201.78.01.02.000.202.001	78.01.02.000.202.001	 Comision Bancaria Credito 65192 	10806.75	0	0	0	0	0	0	16	1245	1	2025-01-28 10:28:03	\N	\N
180	2	030201.97.01.01.000.000.001	97.01.01.000.000.001	 Cuentas por Pagar anos anteriores 	0	0	0	270122.64	0	277446.49	0	16	1439	1	2025-01-28 10:28:03	\N	\N
181	2	030202.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	55608	0	0	0	0	0	0	17	461	1	2025-01-28 10:28:03	\N	\N
182	2	030202.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer sueldo  	4634	0	0	0	0	0	0	17	467	1	2025-01-28 10:28:03	\N	\N
183	2	030202.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto sueldo  	1900	0	0	0	0	0	0	17	468	1	2025-01-28 10:28:03	\N	\N
184	2	030202.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	5366.17	0	0	0	0	0	0	17	530	1	2025-01-28 10:28:03	\N	\N
185	2	030202.51.06.02.000.000.001	51.06.02.000.000.001	 Fondos de Reserva  	4632.15	0	0	0	0	0	0	17	531	1	2025-01-28 10:28:03	\N	\N
186	2	030202.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	17	565	1	2025-01-28 10:28:03	\N	\N
187	2	030202.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	17	566	1	2025-01-28 10:28:03	\N	\N
188	2	030202.53.06.01.000.000.001	53.06.01.000.000.001	 Consultoria Asesoria e Investigacion Especializada 	38000	0	0	0	0	6800	0	17	617	1	2025-01-28 10:28:03	\N	\N
189	2	030202.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	3500	0	0	0	0	0	0	17	625	1	2025-01-28 10:28:03	\N	\N
190	2	030202.53.07.02.000.000.001	53.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos  	0	0	0	2420	0	2420	0	17	626	1	2025-01-28 10:28:03	\N	\N
191	2	030203.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	89208	0	0	0	0	0	0	18	461	1	2025-01-28 10:28:03	\N	\N
192	2	030203.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer sueldo  	7434	0	0	0	0	0	0	18	467	1	2025-01-28 10:28:03	\N	\N
193	2	030203.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto sueldo  	3800	0	0	0	0	0	0	18	468	1	2025-01-28 10:28:03	\N	\N
194	2	030203.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	8608.57	0	0	0	0	0	0	18	530	1	2025-01-28 10:28:03	\N	\N
195	2	030203.51.06.02.000.000.001	51.06.02.000.000.001	 Fondos de Reserva  	7431.03	0	0	0	0	0	0	18	531	1	2025-01-28 10:28:03	\N	\N
196	2	030203.51.07.07.000.000.001	51.07.07.000.000.001	 Compensacion por Vacaciones  	675	0	0	0	0	0	0	18	542	1	2025-01-28 10:28:03	\N	\N
197	2	030203.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	18	565	1	2025-01-28 10:28:03	\N	\N
199	2	030203.53.02.07.000.000.001	53.02.07.000.000.001	 Difusion Informacion  Publicidad 	4780	0	0	0	0	0	0	18	575	1	2025-01-28 10:28:03	\N	\N
200	2	030203.53.02.08.000.000.001	53.02.08.000.000.001	  Servicio de seguridad y vigilancia   	6865	0	0	2477.08	0	1166.06	0	18	576	1	2025-01-28 10:28:03	\N	\N
201	2	030203.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	800	0	0	0	0	0	0	18	625	1	2025-01-28 10:28:03	\N	\N
202	2	030203.53.07.04.000.000.001	53.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	100	0	0	0	0	0	0	18	628	1	2025-01-28 10:28:03	\N	\N
203	2	030203.53.08.04.000.000.001	53.08.04.000.000.001	 Material de Oficina  	0	0	0	308.7	0	308.7	0	18	633	1	2025-01-28 10:28:03	\N	\N
204	2	030203.53.14.04.000.000.001	53.14.04.000.000.001	 Maquinarias y Equipos 	2800	0	0	0	0	0	0	18	659	1	2025-01-28 10:28:03	\N	\N
205	2	030203.57.02.03.000.000.001	57.02.03.000.000.001	 Comisiones Bancarias  	4000	0	0	43.35	0	0	0	18	704	1	2025-01-28 10:28:03	\N	\N
206	2	030204.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	14544	0	0	0	0	0	0	19	461	1	2025-01-28 10:28:03	\N	\N
207	2	030204.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer sueldo  	1212	0	0	0	0	0	0	19	467	1	2025-01-28 10:28:03	\N	\N
208	2	030204.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto sueldo  	475	0	0	0	0	0	0	19	468	1	2025-01-28 10:28:03	\N	\N
209	2	030204.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	1403.5	0	0	0	0	0	0	19	530	1	2025-01-28 10:28:03	\N	\N
210	2	030204.51.06.02.000.000.001	51.06.02.000.000.001	 Fondos de Reserva  	1211.52	0	0	0	0	0	0	19	531	1	2025-01-28 10:28:03	\N	\N
211	2	030204.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	19	565	1	2025-01-28 10:28:03	\N	\N
212	2	030204.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	19	566	1	2025-01-28 10:28:03	\N	\N
213	2	030204.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	100	0	0	0	0	0	0	19	576	1	2025-01-28 10:28:03	\N	\N
214	2	030204.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	1200	0	0	0	0	0	0	19	625	1	2025-01-28 10:28:03	\N	\N
215	2	030204.53.07.04.000.000.001	53.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	1000	0	0	0	0	0	0	19	628	1	2025-01-28 10:28:03	\N	\N
216	2	030205.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	66144	0	0	0	0	0	0	20	461	1	2025-01-28 10:28:03	\N	\N
217	2	030205.51.01.06.000.000.001	51.01.06.000.000.001	  Salarios Unificados  	14040	0	0	0	0	0	0	20	462	1	2025-01-28 10:28:03	\N	\N
218	2	030205.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer sueldo  	6682	0	0	0	0	0	0	20	467	1	2025-01-28 10:28:03	\N	\N
219	2	030205.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto sueldo  	2850	0	0	0	0	0	0	20	468	1	2025-01-28 10:28:03	\N	\N
220	2	030205.51.03.04.000.000.001	51.03.04.000.000.001	 Compensacion por Transporte  	264	0	0	0	0	0	0	20	499	1	2025-01-28 10:28:03	\N	\N
221	2	030205.51.03.06.000.000.001	51.03.06.000.000.001	 Alimentacion  	1320	0	0	0	0	0	0	20	501	1	2025-01-28 10:28:03	\N	\N
222	2	030205.51.04.08.000.000.001	51.04.08.000.000.001	 Subsidio de Antiguedad 	67.39	0	0	0	0	0	0	20	514	1	2025-01-28 10:28:03	\N	\N
223	2	030205.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	8088.76	0	0	0	0	0	0	20	530	1	2025-01-28 10:28:03	\N	\N
224	2	030205.51.06.02.000.000.001	51.06.02.000.000.001	 Fondos de Reserva  	6679.33	0	0	0	0	0	0	20	531	1	2025-01-28 10:28:03	\N	\N
225	2	030205.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	20	565	1	2025-01-28 10:28:03	\N	\N
226	2	030205.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	20	566	1	2025-01-28 10:28:03	\N	\N
227	2	030205.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	8000	0	0	0	0	0	0	20	576	1	2025-01-28 10:28:03	\N	\N
228	2	030205.53.04.02.000.000.001	53.04.02.000.000.001	 Edificios Locales Residencias y Cableado Estructurado  	2000	0	0	0	0	0	0	20	594	1	2025-01-28 10:28:03	\N	\N
229	2	030205.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	1000	0	0	0	0	0	0	20	625	1	2025-01-28 10:28:03	\N	\N
230	2	030205.53.08.11.000.000.001	53.08.11.000.000.001	 Insumos Materiales y Suministros para Const. Elect. Plomeria 	13000	0	0	0	0	0	0	20	640	1	2025-01-28 10:28:03	\N	\N
231	2	030205.75.01.07.000.010.001	75.01.07.000.010.001	 Consrucciones y edificaciones  	150000	0	0	0	0	0	0	20	1194	1	2025-01-28 10:28:03	\N	\N
232	2	030205.84.01.04.000.000.001	84.01.04.000.000.001	Maquinarias y Equipos	500	0	0	0	0	0	0	20	1313	1	2025-01-28 10:28:03	\N	\N
233	2	030205.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	3000	0	0	0	0	0	0	20	1316	1	2025-01-28 10:28:03	\N	\N
234	2	030301.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	31944	0	0	0	0	0	0	39	461	1	2025-01-28 10:28:03	\N	\N
235	2	030301.51.01.06.000.000.001	51.01.06.000.000.001	  Salarios Unificados  	6732	0	0	0	0	0	0	39	462	1	2025-01-28 10:28:03	\N	\N
236	2	030301.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3223	0	0	0	0	0	0	39	467	1	2025-01-28 10:28:03	\N	\N
237	2	030301.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	39	468	1	2025-01-28 10:28:03	\N	\N
238	2	030301.51.03.04.000.000.001	51.03.04.000.000.001	 Compensacion por Transporte  	132	0	0	0	0	0	0	39	499	1	2025-01-28 10:28:03	\N	\N
239	2	030301.51.03.06.000.000.001	51.03.06.000.000.001	 Alimentacion  	660	0	0	0	0	0	0	39	501	1	2025-01-28 10:28:03	\N	\N
240	2	030301.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	3900.54	0	0	0	0	0	0	39	530	1	2025-01-28 10:28:04	\N	\N
241	2	030301.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3221.72	0	0	0	0	0	0	39	531	1	2025-01-28 10:28:04	\N	\N
242	2	030301.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	39	565	1	2025-01-28 10:28:04	\N	\N
243	2	030301.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	0	0	0	0	39	566	1	2025-01-28 10:28:04	\N	\N
244	2	030301.53.01.06.000.000.001	53.01.06.000.000.001	 Servicio de Correo 	250	0	0	0	0	0	0	39	567	1	2025-01-28 10:28:04	\N	\N
245	2	030301.53.04.03.000.000.001	53.04.03.000.000.001	 Mobiliarios  	250	0	0	0	0	0	0	39	595	1	2025-01-28 10:28:04	\N	\N
246	2	030301.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	400	0	0	0	0	0	0	39	576	1	2025-01-28 10:28:04	\N	\N
247	2	030301.53.08.04.000.000.001	53.08.04.000.000.001	 Material de Oficina  	250	0	0	2375	0	2375	0	39	633	1	2025-01-28 10:28:04	\N	\N
248	2	030301.53.14.03.000.000.001	53.14.03.000.000.001	 Mobiliarios  	250	0	0	0	0	0	0	39	658	1	2025-01-28 10:28:04	\N	\N
249	2	030302.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas  	46488	0	0	0	0	0	0	40	461	1	2025-01-28 10:28:04	\N	\N
250	2	030302.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo  	3874	0	0	0	0	0	0	40	467	1	2025-01-28 10:28:04	\N	\N
251	2	030302.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	0	0	0	0	40	468	1	2025-01-28 10:28:04	\N	\N
252	2	030302.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal  	4486.09	0	0	0	0	0	0	40	530	1	2025-01-28 10:28:04	\N	\N
253	2	030302.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva  	3872.45	0	0	0	0	0	0	40	531	1	2025-01-28 10:28:04	\N	\N
254	2	030302.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.18	0	0	0	0	0	0	40	565	1	2025-01-28 10:28:04	\N	\N
255	2	030302.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1500	0	0	0	0	0	0	40	566	1	2025-01-28 10:28:04	\N	\N
256	2	030302.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	6100	0	0	0	0	0	0	40	576	1	2025-01-28 10:28:04	\N	\N
257	2	030302.53.04.02.000.000.001	53.04.02.000.000.001	 Edificios Locales Residencias y Cableado Estructurado  	12500	0	0	0	0	0	0	40	594	1	2025-01-28 10:28:04	\N	\N
258	2	030302.53.07.01.000.000.001	53.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	25000	0	0	0	0	0	0	40	625	1	2025-01-28 10:28:04	\N	\N
259	2	030302.53.07.02.000.000.001	53.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	1000	0	0	1041.66	0	19076.38	0	40	626	1	2025-01-28 10:28:04	\N	\N
260	2	030302.53.08.13.000.000.001	53.08.13.000.000.001	 Repuestos y Accesorios 	5000	0	0	0	0	0	0	40	642	1	2025-01-28 10:28:04	\N	\N
261	2	030302.53.14.11.000.000.001	53.14.11.000.000.001	 Partes y Repuestos 	3000	0	0	0	0	0	0	40	664	1	2025-01-28 10:28:04	\N	\N
262	2	030302.84.04.02.000.000.001	84.04.02.000.000.001	 Licencias Computacionales 	10000	0	0	0	0	0	0	40	1333	1	2025-01-28 10:28:04	\N	\N
263	2	030302.84.01.04.000.000.001	84.01.04.000.000.001	 Maquinarias y Equipos 	10000	0	0	0	0	0	0	40	1313	1	2025-01-28 10:28:04	\N	\N
264	2	030302.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	10500	0	0	8239.55	0	21500	0	40	1316	1	2025-01-28 10:28:04	\N	\N
265	2	030303.51.01.05.000.000.001	51.01.05.000.000.001	 Remuneraciones Unificadas 	28776	0	0	0	0	0	0	41	461	1	2025-01-28 10:28:04	\N	\N
266	2	030303.51.02.03.000.000.001	51.02.03.000.000.001	 Decimotercer Sueldo 	2398	0	0	0	0	0	0	41	467	1	2025-01-28 10:28:04	\N	\N
267	2	030303.51.02.04.000.000.001	51.02.04.000.000.001	 Decimocuarto Sueldo 	950	0	0	0	0	0	0	41	468	1	2025-01-28 10:28:04	\N	\N
268	2	030303.51.06.01.000.000.001	51.06.01.000.000.001	 Aporte Patronal 	2776.88	0	0	0	0	0	0	41	530	1	2025-01-28 10:28:04	\N	\N
269	2	030303.51.06.02.000.000.001	51.06.02.000.000.001	 Fondo de Reserva 	2397.04	0	0	0	0	0	0	41	531	1	2025-01-28 10:28:04	\N	\N
270	2	030303.53.01.04.000.000.001	53.01.04.000.000.001	 Energia Electrica  	1492.1	0	0	0	0	0	0	41	565	1	2025-01-28 10:28:04	\N	\N
271	2	030303.53.01.05.000.000.001	53.01.05.000.000.001	 Telecomunicaciones  	1035.3	0	0	469.51	0	0	0	41	566	1	2025-01-28 10:28:04	\N	\N
272	2	030303.53.02.08.000.000.001	53.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1000	0	0	0	0	1392.75	0	41	576	1	2025-01-28 10:28:04	\N	\N
273	2	030303.53.04.02.000.000.001	53.04.02.000.000.001	 Edificios Locales Residencias y Cableado Estructurado  	2500	0	0	0	0	0	0	41	594	1	2025-01-28 10:28:04	\N	\N
274	2	030303.53.04.04.000.000.001	53.04.04.000.000.001	 Maquinarias y Equipos 	3500	0	0	0	0	2847	0	41	596	1	2025-01-28 10:28:04	\N	\N
275	2	030303.53.07.02.000.000.001	53.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	1000	0	0	0	0	0	0	41	626	1	2025-01-28 10:28:04	\N	\N
276	2	030303.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	1200	0	0	0	0	0	0	41	1316	1	2025-01-28 10:28:04	\N	\N
277	2	040101.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	57504	0	0	0	0	0	0	23	811	1	2025-01-28 10:28:04	\N	\N
278	2	040101.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer sueldo  	4792	0	0	-187.5	0	0	0	23	816	1	2025-01-28 10:28:04	\N	\N
279	2	040101.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	1425	0	0	-101	0	0	0	23	817	1	2025-01-28 10:28:04	\N	\N
280	2	040101.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	47224.08	0	0	0	0	0	0	23	872	1	2025-01-28 10:28:04	\N	\N
281	2	040101.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	4790.08	0	0	0	0	0	0	23	873	1	2025-01-28 10:28:04	\N	\N
282	2	040101.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	2368	0	0	0	0	0	0	23	882	1	2025-01-28 10:28:04	\N	\N
283	2	040101.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	43092.13	0	0	206.9	0	0	0	23	890	1	2025-01-28 10:28:04	\N	\N
284	2	040101.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	367.79	0	0	24.96	0	0	0	23	891	1	2025-01-28 10:28:04	\N	\N
285	2	040101.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	5690	0	0	0	0	0	0	23	898	1	2025-01-28 10:28:04	\N	\N
286	2	040101.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	2000	0	0	0	0	0	0	23	899	1	2025-01-28 10:28:04	\N	\N
287	2	040101.63.04.03.000.000.001	63.04.03.000.000.001	 Mobiliarios  	1000	0	0	0	0	0	0	23	917	1	2025-01-28 10:28:04	\N	\N
288	2	040101.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	7000	0	0	0	0	0	0	23	919	1	2025-01-28 10:28:04	\N	\N
289	2	040101.63.06.01.000.000.001	63.06.01.000.000.001	 Consultoria Asesoria e Investigacion Especializada 	0	0	0	0	0	72996	0	23	935	1	2025-01-28 10:28:04	\N	\N
290	2	040101.63.06.09.000.000.001	63.06.09.000.000.001	 Investigaciones Profesionales y Analisis de Laboratorio 	15000	0	0	11250	0	11250	0	23	941	1	2025-01-28 10:28:04	\N	\N
291	2	040101.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	2700	0	0	3299.01	0	7367.01	0	23	944	1	2025-01-28 10:28:04	\N	\N
292	2	040101.63.08.04.000.000.001	63.08.04.000.000.001	 Material de Oficina  	0	0	0	0	0	2703.48	0	23	951	1	2025-01-28 10:28:04	\N	\N
293	2	040101.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	361.78	0	0	0	0	0	0	23	960	1	2025-01-28 10:28:04	\N	\N
294	2	040101.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	480	0	0	340	0	0	0	23	1005	1	2025-01-28 10:28:04	\N	\N
295	2	040101.67.02.01.000.000.001	67.02.01.000.000.001	 Seguros  	4000	0	0	0	0	0	0	23	1010	1	2025-01-28 10:28:04	\N	\N
296	2	040101.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos y sistemas y paquetes informaticos  	8000	0	0	0	0	0	0	23	1316	1	2025-01-28 10:28:04	\N	\N
297	2	040102.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	139512	0	0	0	0	0	0	24	811	1	2025-01-28 10:28:04	\N	\N
298	2	040102.61.01.06.000.000.001	61.01.06.000.000.001	  Salarios Unificados  	36012	0	0	0	0	0	0	24	812	1	2025-01-28 10:28:04	\N	\N
299	2	040102.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer sueldo  	15839	0	0	0	0	0	0	24	816	1	2025-01-28 10:28:04	\N	\N
300	2	040102.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	7600	0	0	0	0	0	0	24	817	1	2025-01-28 10:28:04	\N	\N
301	2	040102.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	660	0	0	0	0	0	0	24	844	1	2025-01-28 10:28:04	\N	\N
302	2	040102.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	3300	0	0	0	0	0	0	24	846	1	2025-01-28 10:28:04	\N	\N
303	2	040102.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	582.15	0	0	0	0	0	0	24	858	1	2025-01-28 10:28:04	\N	\N
304	2	040102.61.05.10.000.000.001	61.05.10.000.000.001	 Servicios Personales por Contrato 	14544	0	0	0	0	0	0	24	868	1	2025-01-28 10:28:04	\N	\N
305	2	040102.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	19241.87	0	0	0	0	0	0	24	872	1	2025-01-28 10:28:04	\N	\N
306	2	040102.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	15832.67	0	0	0	0	0	0	24	873	1	2025-01-28 10:28:04	\N	\N
307	2	040102.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	1212	0	0	0	0	0	0	24	882	1	2025-01-28 10:28:04	\N	\N
308	2	040102.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	40000	0	0	0	0	0	0	24	890	1	2025-01-28 10:28:04	\N	\N
309	2	040102.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.71	0	0	0	0	0	0	24	891	1	2025-01-28 10:28:04	\N	\N
310	2	040102.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	500	0	0	0	0	0	0	24	898	1	2025-01-28 10:28:04	\N	\N
311	2	040102.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	3000	0	0	0	0	1442.91	0	24	899	1	2025-01-28 10:28:04	\N	\N
312	2	040102.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	0	0	0	0	0	208.38	0	24	919	1	2025-01-28 10:28:04	\N	\N
313	2	040102.63.06.01.000.000.001	63.06.01.000.000.001	 Consultoria Asesoria e Investigacion Especializada 	20000	0	0	0	0	0	0	24	935	1	2025-01-28 10:28:04	\N	\N
314	2	040102.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	3000	0	0	0	0	0	0	24	944	1	2025-01-28 10:28:04	\N	\N
315	2	040102.63.02.55.000.000.001	63.02.55.000.000.001	 Combustibles 	10200	0	0	4599.19	0	0	0	24	905	1	2025-01-28 10:28:04	\N	\N
316	2	040102.63.08.05.000.000.001	63.08.05.000.000.001	 Material de aseo  	0	0	0	0	0	186.78	0	24	952	1	2025-01-28 10:28:04	\N	\N
317	2	040102.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	100	0	0	0	0	0	0	24	960	1	2025-01-28 10:28:04	\N	\N
318	2	040102.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	1000	0	0	0	0	0	0	24	1005	1	2025-01-28 10:28:04	\N	\N
319	2	040103.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	26376	0	0	0	0	0	0	25	811	1	2025-01-28 10:28:04	\N	\N
320	2	040103.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer sueldo  	2198	0	0	0	0	0	0	25	816	1	2025-01-28 10:28:04	\N	\N
321	2	040103.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	950	0	0	0	0	0	0	25	817	1	2025-01-28 10:28:04	\N	\N
322	2	040103.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	2545.28	0	0	0	0	0	0	25	872	1	2025-01-28 10:28:04	\N	\N
323	2	040103.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	2197.12	0	0	0	0	0	0	25	873	1	2025-01-28 10:28:04	\N	\N
324	2	040103.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	63092.13	0	0	0	0	0	0	25	890	1	2025-01-28 10:28:04	\N	\N
325	2	040103.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.71	0	0	0	0	0	0	25	891	1	2025-01-28 10:28:04	\N	\N
326	2	040103.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	500	0	0	0	0	0	0	25	898	1	2025-01-28 10:28:04	\N	\N
327	2	040103.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1200	0	0	0	0	0	0	25	899	1	2025-01-28 10:28:04	\N	\N
328	2	040103.63.04.04.000.000.001	63.04.04.000.000.001	 Maquinarias y Equipos 	4500	0	0	0	0	0	0	25	918	1	2025-01-28 10:28:04	\N	\N
329	2	040103.63.06.09.000.000.001	63.06.09.000.000.001	 Investigaciones Profesionales y Analisis de Laboratorio 	5000	0	0	0	0	0	0	25	941	1	2025-01-28 10:28:04	\N	\N
330	2	040103.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	6000	0	0	0	0	0	0	25	944	1	2025-01-28 10:28:04	\N	\N
331	2	040103.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	1000	0	0	0	0	0	0	25	946	1	2025-01-28 10:28:04	\N	\N
332	2	040103.63.02.55.000.000.001	63.02.55.000.000.001	 Combustibles 	15000	0	0	0	0	0	0	25	905	1	2025-01-28 10:28:04	\N	\N
333	2	040103.63.08.11.000.000.001	63.08.11.000.000.001	 Insumos Materiales y Suministros para Construccion Elect. Plom. 	113528.58	0	0	42877	0	68077	0	25	958	1	2025-01-28 10:28:04	\N	\N
334	2	040103.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	361.78	0	0	0	0	0	0	25	960	1	2025-01-28 10:28:04	\N	\N
335	2	040103.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	1185	0	0	401.62	0	0	0	25	1005	1	2025-01-28 10:28:04	\N	\N
336	2	040103.84.01.04.000.000.001	84.01.04.000.000.001	 Maquinarias y Equipos 	15000	0	0	0	0	0	0	25	1313	1	2025-01-28 10:28:04	\N	\N
337	2	040201.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	28416	0	0	0	0	0	0	27	811	1	2025-01-28 10:28:04	\N	\N
338	2	040201.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	2368	0	0	0	0	0	0	27	816	1	2025-01-28 10:28:04	\N	\N
339	2	040201.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	475	0	0	0	0	0	0	27	817	1	2025-01-28 10:28:04	\N	\N
340	2	040201.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	2742.14	0	0	0	0	0	0	27	872	1	2025-01-28 10:28:04	\N	\N
341	2	040201.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	2367.05	0	0	0	0	0	0	27	873	1	2025-01-28 10:28:04	\N	\N
342	2	040201.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	2368	0	0	0	0	0	0	27	882	1	2025-01-28 10:28:04	\N	\N
343	2	040201.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	67668.45	0	0	0	0	0	0	27	890	1	2025-01-28 10:28:04	\N	\N
344	2	040201.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.71	0	0	0	0	0	0	27	891	1	2025-01-28 10:28:04	\N	\N
345	2	040201.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	1500	0	0	0	0	0	0	27	898	1	2025-01-28 10:28:04	\N	\N
346	2	040201.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1500	0	0	0	0	0	0	27	899	1	2025-01-28 10:28:04	\N	\N
347	2	040201.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	1500	0	0	0	0	0	0	27	919	1	2025-01-28 10:28:04	\N	\N
348	2	040201.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	100	0	0	0	0	0	0	27	946	1	2025-01-28 10:28:04	\N	\N
349	2	040201.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	1500	0	0	0	0	0	0	27	949	1	2025-01-28 10:28:04	\N	\N
350	2	040201.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	21000	0	0	0	0	0	0	27	960	1	2025-01-28 10:28:04	\N	\N
351	2	040202.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	92832	0	0	0	0	155000	0	28	811	1	2025-01-28 10:28:04	\N	\N
352	2	040202.61.01.06.000.000.001	61.01.06.000.000.001	 Salarios Unificados  	476316	0	0	0	0	0	0	28	812	1	2025-01-28 10:28:04	\N	\N
353	2	040202.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	48000.75	0	0	0	0	0	0	28	816	1	2025-01-28 10:28:04	\N	\N
354	2	040202.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	37050	0	0	0	0	0	0	28	817	1	2025-01-28 10:28:04	\N	\N
355	2	040202.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	9504	0	0	0	0	0	0	28	844	1	2025-01-28 10:28:04	\N	\N
356	2	040202.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	47520	0	0	0	0	0	0	28	846	1	2025-01-28 10:28:04	\N	\N
357	2	040202.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	6148.31	0	0	0	0	0	0	28	858	1	2025-01-28 10:28:04	\N	\N
358	2	040202.61.05.09.000.000.001	61.05.09.000.000.001	 Horas extraordinarias y Suplementarias  	83104.38	0	0	0	0	0	0	28	867	1	2025-01-28 10:28:04	\N	\N
359	2	040202.61.05.10.000.000.001	61.05.10.000.000.001	 Servicios Personales por Contrato 	27444	0	0	0	0	0	0	28	868	1	2025-01-28 10:28:04	\N	\N
360	2	040202.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	70165.13	0	0	0	0	0	0	28	872	1	2025-01-28 10:28:04	\N	\N
361	2	040202.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	49696.12	0	0	220.48	0	0	0	28	873	1	2025-01-28 10:28:04	\N	\N
362	2	040202.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	1676	0	0	0	0	0	0	28	882	1	2025-01-28 10:28:04	\N	\N
363	2	040202.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	63092.13	0	0	36578	0	0	0	28	890	1	2025-01-28 10:28:04	\N	\N
364	2	040202.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.71	0	0	24.96	0	0	0	28	891	1	2025-01-28 10:28:04	\N	\N
365	2	040202.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	2600	0	0	0	0	0	0	28	898	1	2025-01-28 10:28:04	\N	\N
366	2	040202.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1100	0	0	0	0	4278.3	0	28	899	1	2025-01-28 10:28:04	\N	\N
367	2	040202.63.04.04.000.002.001	63.04.04.000.002.001	 Mantenimiento de Pozos  	250000	0	0	0	0	243753.81	0	28	918	1	2025-01-28 10:28:04	\N	\N
368	2	040202.63.04.04.000.003.001	63.04.04.000.003.001	 MEJORAMIENTO DE LA SEGURIDAD IND EN LAS RESERVAS DE LA EP EMAPAR 	0	0	0	0	0	8878.46	0	28	918	1	2025-01-28 10:28:04	\N	\N
369	2	040202.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	0	0	0	7299.28	0	55008.29	0	28	919	1	2025-01-28 10:28:04	\N	\N
370	2	040202.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	1000	0	0	0	0	0	0	28	944	1	2025-01-28 10:28:04	\N	\N
371	2	040202.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	200	0	0	0	0	0	0	28	946	1	2025-01-28 10:28:04	\N	\N
372	2	040202.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	2000	0	0	0	0	0	0	28	949	1	2025-01-28 10:28:04	\N	\N
373	2	040202.63.02.55.000.000.001	63.02.55.000.000.001	 Combustibles 	4800	0	0	4761.06	0	4761.06	0	28	905	1	2025-01-28 10:28:04	\N	\N
374	2	040202.63.08.11.000.000.001	63.08.11.000.000.001	 Insumos Materiales y Suministros para Construccion Elect. Plom. 	87854.29	0	0	18050	0	48144.25	0	28	958	1	2025-01-28 10:28:04	\N	\N
375	2	040202.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios   	1000	0	0	515	0	5048	0	28	960	1	2025-01-28 10:28:04	\N	\N
376	2	040202.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	1000	0	0	576	0	0	0	28	1005	1	2025-01-28 10:28:04	\N	\N
377	2	040202.75.01.01.000.004.001	75.01.01.000.004.001	 CONTRATO COMPLEMENTARIO FISCALIZACION, TRANSPORTE Y PRUEBAS  	0	0	0	0	0	95000	0	28	1188	1	2025-01-28 10:28:04	\N	\N
378	2	040202.75.01.07.000.001.001	75.01.07.000.001.001	 CONSTRUCCION CERRAMIENTO PERIMETRAL TRATAMIENTO AIREADORES 	0	0	0	0	0	24344.21	0	28	1194	1	2025-01-28 10:28:04	\N	\N
379	2	040202.84.01.04.000.000.001	84.01.04.000.000.001	 Maquinarias y Equipos 	50000	0	0	0	0	0	0	28	1313	1	2025-01-28 10:28:04	\N	\N
380	2	040203.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	49200	0	0	0	0	0	0	29	811	1	2025-01-28 10:28:04	\N	\N
381	2	040203.61.01.06.000.000.001	61.01.06.000.000.001	 Salarios Unificados  	134064	0	0	0	0	0	0	29	812	1	2025-01-28 10:28:04	\N	\N
382	2	040203.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	17484	0	0	0	0	0	0	29	816	1	2025-01-28 10:28:04	\N	\N
383	2	040203.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	12350	0	0	0	0	0	0	29	817	1	2025-01-28 10:28:04	\N	\N
384	2	040203.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	3036	0	0	0	0	0	0	29	844	1	2025-01-28 10:28:04	\N	\N
385	2	040203.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	15180	0	0	0	0	0	0	29	846	1	2025-01-28 10:28:04	\N	\N
386	2	040203.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	1329.46	0	0	0	0	0	0	29	858	1	2025-01-28 10:28:04	\N	\N
387	2	040203.61.05.10.000.000.001	61.05.10.000.000.001	 Servicios Personales por Contrato 	26544	0	0	0	0	0	0	29	868	1	2025-01-28 10:28:04	\N	\N
388	2	040203.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	24261.68	0	0	0	0	0	0	29	872	1	2025-01-28 10:28:04	\N	\N
389	2	040203.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	17477.01	0	0	0	0	0	0	29	873	1	2025-01-28 10:28:04	\N	\N
390	2	040203.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	51642.57	0	0	0	0	0	0	29	890	1	2025-01-28 10:28:04	\N	\N
391	2	040203.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.71	0	0	0	0	0	0	29	891	1	2025-01-28 10:28:04	\N	\N
392	2	040203.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	4500	0	0	0	0	0	0	29	898	1	2025-01-28 10:28:04	\N	\N
393	2	040203.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	1000	0	0	0	0	0	0	29	899	1	2025-01-28 10:28:04	\N	\N
394	2	040203.63.04.17.000.000.001	63.04.17.000.000.001	 REPARACI N DEL EMISARIO NUEVO COLECTOR INMACULADA - 2022 	0	0	0	4086.09	0	77722.47	0	29	922	1	2025-01-28 10:28:04	\N	\N
395	2	040203.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	10000	0	0	0	0	0	0	29	919	1	2025-01-28 10:28:04	\N	\N
396	2	040203.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	500	0	0	0	0	0	0	29	944	1	2025-01-28 10:28:04	\N	\N
397	2	040203.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	100	0	0	0	0	0	0	29	946	1	2025-01-28 10:28:04	\N	\N
398	2	040203.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	10000	0	0	0	0	0	0	29	949	1	2025-01-28 10:28:04	\N	\N
399	2	040203.63.02.55.000.000.001	63.02.55.000.000.001	 Combustibles 	7000	0	0	0	0	0	0	29	905	1	2025-01-28 10:28:04	\N	\N
400	2	040203.63.08.11.000.000.001	63.08.11.000.000.001	 Insumos Materiales y Suministros para Construccion Electricidad Plomeria Carp 	162000	0	0	186770.53	0	321979.73	0	29	958	1	2025-01-28 10:28:04	\N	\N
401	2	040203.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios   	1000	0	0	0	0	0	0	29	960	1	2025-01-28 10:28:04	\N	\N
402	2	040203.63.14.06.000.000.001	63.14.06.000.000.001	 Herramientas y equipos menores 	8000	0	0	0	0	0	0	29	991	1	2025-01-28 10:28:04	\N	\N
403	2	040203.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	1000	0	0	0	0	0	0	29	1005	1	2025-01-28 10:28:04	\N	\N
404	2	040203.75.01.03.000.008.001	75.01.03.000.008.001	 Rehabilitacion del sistema de alcantarillado barrio Primavera Alta 	263200	0	0	0	0	0	0	29	1190	1	2025-01-28 10:28:04	\N	\N
405	2	040203.75.01.03.000.000.001	75.01.03.000.000.001	 Varias obras de Alcantarillado 	0	0	0	0	0	197388.06	0	29	1190	1	2025-01-28 10:28:04	\N	\N
406	2	040203.75.01.03.000.072.001	75.01.03.000.072.001	  ALCANTARILLADO PARA LOS BARRIOS NOROCCIDENTALES 	0	0	0	0	0	206714.81	0	29	1190	1	2025-01-28 10:28:04	\N	\N
407	2	040203.75.01.03.000.079.001	75.01.03.000.079.001	 MEJORAMIENTO DEL SISTEMA PLUVIAL  DE LA CIUDAD DE RIOBAMBA 	0	0	0	71864.22	0	398475	0	29	1190	1	2025-01-28 10:28:04	\N	\N
408	2	040203.75.01.03.000.009.001	75.01.03.000.009.001	Alcantarillado garcia moreno	80000	0	0	0	0	0	0	29	1190	1	2025-01-28 10:28:04	\N	\N
409	2	040203.84.01.04.000.000.001	84.01.04.000.000.001	 Maquinarias y Equipos 	50000	0	0	123240	0	123240	0	29	1313	1	2025-01-28 10:28:04	\N	\N
410	2	040203.84.01.05.000.000.001	84.01.05.000.000.001	 Vehiculos  	68239.19	0	0	0	0	503647.46	0	29	1314	1	2025-01-28 10:28:04	\N	\N
411	2	040204.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	49200	0	0	0	0	0	0	30	811	1	2025-01-28 10:28:04	\N	\N
412	2	040204.61.01.06.000.000.001	61.01.06.000.000.001	 Salarios Unificados  	123396	0	0	0	0	0	0	30	812	1	2025-01-28 10:28:04	\N	\N
413	2	040204.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	14383	0	0	0	0	0	0	30	816	1	2025-01-28 10:28:04	\N	\N
414	2	040204.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	9500	0	0	0	0	0	0	30	817	1	2025-01-28 10:28:04	\N	\N
415	2	040204.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	2244	0	0	0	0	0	0	30	844	1	2025-01-28 10:28:04	\N	\N
416	2	040204.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	11220	0	0	0	0	0	0	30	846	1	2025-01-28 10:28:04	\N	\N
417	2	040204.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	1367.24	0	0	0	0	0	0	30	858	1	2025-01-28 10:28:04	\N	\N
418	2	040204.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	19740.41	0	0	0	0	0	0	30	872	1	2025-01-28 10:28:04	\N	\N
419	2	040204.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	14377.25	0	0	0	0	0	0	30	873	1	2025-01-28 10:28:04	\N	\N
420	2	040204.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	63092.08	0	0	0	0	0	0	30	890	1	2025-01-28 10:28:04	\N	\N
421	2	040204.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	285.74	0	0	0	0	0	0	30	891	1	2025-01-28 10:28:04	\N	\N
422	2	040204.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	8000	0	0	0	0	0	0	30	898	1	2025-01-28 10:28:04	\N	\N
423	2	040204.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	700	0	0	0	0	0	0	30	899	1	2025-01-28 10:28:04	\N	\N
424	2	040204.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	200	0	0	0	0	0	0	30	944	1	2025-01-28 10:28:04	\N	\N
425	2	040204.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	100	0	0	0	0	0	0	30	946	1	2025-01-28 10:28:04	\N	\N
426	2	040204.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	7396	0	0	0	0	0	0	30	949	1	2025-01-28 10:28:04	\N	\N
427	2	040204.63.02.55.000.000.001	63.02.55.000.000.001	 Combustibles 	8000	0	0	0	0	0	0	30	905	1	2025-01-28 10:28:04	\N	\N
428	2	040204.63.08.11.000.000.001	63.08.11.000.000.001	 Insumos Materiales y Suministros para Construccion Elect. Plom. 	52000	0	0	0	0	0	0	30	958	1	2025-01-28 10:28:04	\N	\N
429	2	040204.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios   	2000	0	0	0	0	0	0	30	960	1	2025-01-28 10:28:04	\N	\N
430	2	040204.67.01.02.000.000.001	67.01.02.000.000.001	 Tasas generales impuestos contribuciones permisos licencias y patentes  	2860	0	0	0	0	0	0	30	1005	1	2025-01-28 10:28:04	\N	\N
431	2	040204.84.01.07.000.000.001	84.01.07.000.000.001	 Equipos Sistemas y Paquetes Informaticos 	3000	0	0	0	0	0	0	30	1316	1	2025-01-28 10:28:04	\N	\N
432	2	040204.84.01.04.000.000.001	84.01.04.000.000.001	 Maquinarias y Equipos 	140000	0	0	0	0	0	0	30	1313	1	2025-01-28 10:28:04	\N	\N
433	2	040301.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	28416	0	0	0	0	0	0	32	811	1	2025-01-28 10:28:04	\N	\N
434	2	040301.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	2368	0	0	0	0	0	0	32	816	1	2025-01-28 10:28:04	\N	\N
435	2	040301.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	475	0	0	0	0	0	0	32	817	1	2025-01-28 10:28:04	\N	\N
436	2	040301.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	2742.14	0	0	0	0	0	0	32	872	1	2025-01-28 10:28:04	\N	\N
437	2	040301.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	2367.05	0	0	0	0	0	0	32	873	1	2025-01-28 10:28:04	\N	\N
438	2	040301.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	2368	0	0	0	0	0	0	32	882	1	2025-01-28 10:28:04	\N	\N
439	2	040301.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	10996.05	0	0	44.24	0	0	0	32	890	1	2025-01-28 10:28:04	\N	\N
440	2	040301.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	200.98	0	0	0	0	0	0	32	891	1	2025-01-28 10:28:04	\N	\N
441	2	040301.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	4813.63	0	0	0	0	0	0	32	898	1	2025-01-28 10:28:04	\N	\N
442	2	040301.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	500	0	0	0	0	659.23	0	32	899	1	2025-01-28 10:28:04	\N	\N
443	2	040301.63.04.05.000.000.001	63.04.05.000.000.001	 Vehiculos  	5000	0	0	0	0	9045.44	0	32	919	1	2025-01-28 10:28:04	\N	\N
444	2	040301.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	600	0	0	0	0	0	0	32	944	1	2025-01-28 10:28:04	\N	\N
445	2	040301.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	100	0	0	0	0	0	0	32	946	1	2025-01-28 10:28:04	\N	\N
446	2	040301.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	10000	0	0	0	0	0	0	32	949	1	2025-01-28 10:28:04	\N	\N
447	2	040301.84.01.05.000.000.001	84.01.05.000.000.001	 Vehiculos  	0	0	0	0	0	23184	0	32	1314	1	2025-01-28 10:28:04	\N	\N
448	2	040302.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	58308	0	0	0	0	0	0	33	811	1	2025-01-28 10:28:04	\N	\N
449	2	040302.61.01.06.000.000.001	61.01.06.000.000.001	 Salarios Unificados  	48024	0	0	0	0	0	0	33	812	1	2025-01-28 10:28:04	\N	\N
450	2	040302.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	8861	0	0	0	0	0	0	33	816	1	2025-01-28 10:28:04	\N	\N
451	2	040302.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	5225	0	0	0	0	0	0	33	817	1	2025-01-28 10:28:04	\N	\N
452	2	040302.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	792	0	0	0	0	0	0	33	844	1	2025-01-28 10:28:04	\N	\N
453	2	040302.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	3960	0	0	0	0	0	0	33	846	1	2025-01-28 10:28:04	\N	\N
454	2	040302.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	1125.53	0	0	0	0	0	0	33	858	1	2025-01-28 10:28:04	\N	\N
455	2	040302.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	11461.64	0	0	0	0	0	0	33	872	1	2025-01-28 10:28:04	\N	\N
456	2	040302.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	8857.46	0	0	0	0	0	0	33	873	1	2025-01-28 10:28:04	\N	\N
457	2	040302.61.07.07.000.000.001	61.07.07.000.000.001	 Compensacion por Vacaciones  	225	0	0	0	0	0	0	33	882	1	2025-01-28 10:28:04	\N	\N
458	2	040302.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	10996.05	0	0	0	0	0	0	33	890	1	2025-01-28 10:28:04	\N	\N
459	2	040302.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	99.02	0	0	0	0	0	0	33	891	1	2025-01-28 10:28:04	\N	\N
460	2	040302.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	500	0	0	0	0	0	0	33	898	1	2025-01-28 10:28:04	\N	\N
461	2	040302.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	200	0	0	0	0	0	0	33	899	1	2025-01-28 10:28:04	\N	\N
462	2	040302.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	4000	0	0	0	0	0	0	33	944	1	2025-01-28 10:28:04	\N	\N
463	2	040302.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	300	0	0	0	0	0	0	33	946	1	2025-01-28 10:28:04	\N	\N
464	2	040302.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	6000	0	0	0	0	0	0	33	949	1	2025-01-28 10:28:04	\N	\N
465	2	040302.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	1700	0	0	0	0	0	0	33	960	1	2025-01-28 10:28:04	\N	\N
466	2	040303.61.01.05.000.000.001	61.01.05.000.000.001	 Remuneraciones Unificadas  	155916	0	0	0	0	0	0	34	811	1	2025-01-28 10:28:04	\N	\N
467	2	040303.61.01.06.000.000.001	61.01.06.000.000.001	 Salarios Unificados  	134643.6	0	0	0	0	0	0	34	812	1	2025-01-28 10:28:04	\N	\N
468	2	040303.61.02.03.000.000.001	61.02.03.000.000.001	 Decimotercer Sueldo  	29502.3	0	0	-242.09	0	0	0	34	816	1	2025-01-28 10:28:04	\N	\N
469	2	040303.61.02.04.000.000.001	61.02.04.000.000.001	 Decimocuarto Sueldo  	18050	0	0	-215	0	0	0	34	817	1	2025-01-28 10:28:04	\N	\N
470	2	040303.61.03.04.000.000.001	61.03.04.000.000.001	 Compensacion por Transporte  	3036	0	0	0	0	0	0	34	844	1	2025-01-28 10:28:04	\N	\N
471	2	040303.61.03.06.000.000.001	61.03.06.000.000.001	 Alimentacion  	15180	0	0	0	0	0	0	34	846	1	2025-01-28 10:28:04	\N	\N
472	2	040303.61.04.08.000.000.001	61.04.08.000.000.001	 Subsidio de Antiguedad 	1722.71	0	0	0	0	0	0	34	858	1	2025-01-28 10:28:04	\N	\N
473	2	040303.61.05.10.000.000.001	61.05.10.000.000.001	 Servicios Personales por Contrato 	63468	0	0	0	0	0	0	34	868	1	2025-01-28 10:28:04	\N	\N
474	2	040303.61.06.01.000.000.001	61.06.01.000.000.001	 Aporte Patronal  	39938.57	0	0	0	0	0	0	34	872	1	2025-01-28 10:28:04	\N	\N
475	2	040303.61.06.02.000.000.001	61.06.02.000.000.001	 Fondos de Reserva  	29490.51	0	0	0	0	0	0	34	873	1	2025-01-28 10:28:04	\N	\N
476	2	040303.63.01.04.000.000.001	63.01.04.000.000.001	 Energia Electrica  	10996.06	0	0	0	0	0	0	34	890	1	2025-01-28 10:28:04	\N	\N
477	2	040303.63.01.05.000.000.001	63.01.05.000.000.001	 Telecomunicaciones  	100	0	0	0	0	0	0	34	891	1	2025-01-28 10:28:04	\N	\N
478	2	040303.63.02.07.000.000.001	63.02.07.000.000.001	 Difusion e Informacion 	500	0	0	0	0	0	0	34	898	1	2025-01-28 10:28:04	\N	\N
479	2	040303.63.02.08.000.000.001	63.02.08.000.000.001	 Servicio de seguridad y vigilancia   	100	0	0	0	0	0	0	34	899	1	2025-01-28 10:28:04	\N	\N
480	2	040303.63.06.01.000.000.001	63.06.01.000.000.001	 Consultoria Asesoria e Investigacion Especializada 	0	0	0	35955.98	0	219525.67	0	34	935	1	2025-01-28 10:28:04	\N	\N
481	2	040303.63.07.01.000.000.001	63.07.01.000.000.001	 Desarrollo Actualizacion  Asistencia Tecnica y Soporte de Sistemas Informaticos	25000	0	0	0	0	0	0	34	943	1	2025-01-28 10:28:04	\N	\N
482	2	040303.63.07.02.000.000.001	63.07.02.000.000.001	 Arrendamiento y Licencias de uso de Paquetes Informaticos 	5000	0	0	0	0	0	0	34	944	1	2025-01-28 10:28:04	\N	\N
483	2	040303.63.07.04.000.000.001	63.07.04.000.000.001	 Mantenimiento y Reparacion de Equipos y Sistemas Informaticos  	500	0	0	0	0	0	0	34	946	1	2025-01-28 10:28:04	\N	\N
484	2	040303.63.08.02.000.000.001	63.08.02.000.000.001	 Vestuario Lenceria Prendas de Proteccion y Accesorios para uniformes del pers 	3500	0	0	0	0	0	0	34	949	1	2025-01-28 10:28:04	\N	\N
485	2	040303.63.08.13.000.000.001	63.08.13.000.000.001	 Repuestos y Accesorios  	3200	0	0	0	0	0	0	34	960	1	2025-01-28 10:28:04	\N	\N
486	2	040303.84.04.02.000.000.001	84.04.02.000.000.001	 Licencias Computacionales 	25000	0	0	0	0	0	0	34	1333	1	2025-01-28 10:28:04	\N	\N
\.


--
-- TOC entry 4933 (class 0 OID 5732686)
-- Dependencies: 228
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proyectos (idproyecto, codigo, nombre, movimiento, idestructura, usucrea, feccrea, usumodi, fecmodi) FROM stdin;
2	01	PROCESOS GOBERNANTE	f	1	1	2025-01-27 19:31:12	\N	\N
3	0101	GESTION GERENCIA GENERAL	f	2	1	2025-01-27 19:31:12	\N	\N
4	010101	Unidad de Gestión Gerencia General	t	3	1	2025-01-27 19:31:12	\N	\N
5	02	PROCESOS DE ASESORIA	f	1	1	2025-01-27 19:31:12	\N	\N
6	0201	GESTIÓN GERENCIA GENERAL	f	2	1	2025-01-27 19:31:12	\N	\N
7	020101	U.G Asesoria Juridica	t	3	1	2025-01-27 19:31:12	\N	\N
8	03	PROCESOS DE SOPORTE O APOYO	f	1	1	2025-01-27 19:31:12	\N	\N
9	0301	GESTIÓN ADMINISTRATIVA	f	2	1	2025-01-27 19:31:12	\N	\N
10	030101	U.G. Direccion Administrativa	t	3	1	2025-01-27 19:31:12	\N	\N
11	030102	U.G de Talento Humano	t	3	1	2025-01-27 19:31:12	\N	\N
12	030103	U.G. Contratación Publica	t	3	1	2025-01-27 19:31:12	\N	\N
13	030104	U.G Servicios Generales 	t	3	1	2025-01-27 19:31:12	\N	\N
14	030105	U.G. Servicio Médico	t	3	1	2025-01-27 19:31:12	\N	\N
15	0302	GESTION FINANCIERA	f	2	1	2025-01-27 19:31:12	\N	\N
16	030201	U.G. Direccion Financiera	t	3	1	2025-01-27 19:31:12	\N	\N
17	030202	U.G. Contabilidad	t	3	1	2025-01-27 19:31:12	\N	\N
18	030203	U.G. Tesoreria	t	3	1	2025-01-27 19:31:12	\N	\N
19	030204	U.G.  Presupuesto	t	3	1	2025-01-27 19:31:12	\N	\N
20	030205	U.G. Administración de Bienes	t	3	1	2025-01-27 19:31:12	\N	\N
21	04	PROCESOS AGREGADORES DE VALOR	f	1	1	2025-01-27 19:31:12	\N	\N
22	0401	GESTION DE INGENIERIA	f	2	1	2025-01-27 19:31:12	\N	\N
23	040101	U.G. Direccion de Ingenieria	t	3	1	2025-01-27 19:31:12	\N	\N
24	040102	U.G. Fiscalizacion Estudios y Diseño	t	3	1	2025-01-27 19:31:12	\N	\N
25	040103	U.G. Laboratorio	t	3	1	2025-01-27 19:31:12	\N	\N
26	0402	GESTION DE OPERACIONES	f	2	1	2025-01-27 19:31:12	\N	\N
27	040201	U.G. Direccion de Operaciones	t	3	1	2025-01-27 19:31:12	\N	\N
28	040202	U.G. Agua Potable	t	3	1	2025-01-27 19:31:12	\N	\N
29	040203	U.G. Alcantarrillado	t	3	1	2025-01-27 19:31:12	\N	\N
30	040204	U.G. Control de Perdidas	t	3	1	2025-01-27 19:31:12	\N	\N
31	0403	GESTION COMERCIAL	f	2	1	2025-01-27 19:31:12	\N	\N
32	040301	U.G. Direccion Comercial	t	3	1	2025-01-27 19:31:12	\N	\N
33	040302	U.G. Atencion al Cliente	t	3	1	2025-01-27 19:31:12	\N	\N
34	040303	U.G. Catastro y Medicion	t	3	1	2025-01-27 19:31:12	\N	\N
35	020102	U.G. Comunicacion	t	3	1	2025-01-27 19:31:12	\N	\N
36	020103	U.G. Planificacion	t	3	1	2025-01-27 19:31:12	\N	\N
37	020104	U.G. Auditoria Interna	t	3	1	2025-01-27 19:31:12	\N	\N
38	0303	GESTION GERENCIA GENERAL	f	2	1	2025-01-27 19:31:12	\N	\N
39	030301	U.G. Secretaria General	t	3	1	2025-01-27 19:31:12	\N	\N
40	030302	U.G. Tecnologias de la Informacion	t	3	1	2025-01-27 19:31:12	\N	\N
41	030303	U.G. Seguridad y Salud Ocupacional	t	3	1	2025-01-27 19:31:12	\N	\N
1	00	(Partidas de Ingreso)	f	1	1	2025-01-28 00:00:00	\N	\N
\.


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 223
-- Name: beneficiarios_idbene_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.beneficiarios_idbene_seq', 1027, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 221
-- Name: clasificador_idclasificador_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clasificador_idclasificador_seq', 1, false);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 219
-- Name: estructura_idestructura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estructura_idestructura_seq', 1, false);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 225
-- Name: gruposbene_idgrupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gruposbene_idgrupo_seq', 8, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 217
-- Name: ifinan_idifinan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ifinan_idifinan_seq', 74, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 215
-- Name: niveles_idnivel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.niveles_idnivel_seq', 1, false);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 229
-- Name: presupuesto_idpresupuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.presupuesto_idpresupuesto_seq', 1, false);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 227
-- Name: proyectos_idproyecto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proyectos_idproyecto_seq', 1, false);


--
-- TOC entry 4767 (class 2606 OID 5732653)
-- Name: clasificador clasificador_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificador
    ADD CONSTRAINT clasificador_pk PRIMARY KEY (idclasificador);


--
-- TOC entry 4771 (class 2606 OID 5732691)
-- Name: proyectos estrfunc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT estrfunc_pk PRIMARY KEY (idproyecto);


--
-- TOC entry 4765 (class 2606 OID 5732639)
-- Name: estructura estructura_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estructura
    ADD CONSTRAINT estructura_pk PRIMARY KEY (idestructura);


--
-- TOC entry 4763 (class 2606 OID 5732627)
-- Name: niveles niveles_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles
    ADD CONSTRAINT niveles_pk PRIMARY KEY (idnivel);


--
-- TOC entry 4773 (class 2606 OID 5732710)
-- Name: presupuesto presupue_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto
    ADD CONSTRAINT presupue_pk PRIMARY KEY (idpresupuesto);


--
-- TOC entry 4769 (class 2606 OID 5732655)
-- Name: clasificador uc_codpar; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificador
    ADD CONSTRAINT uc_codpar UNIQUE (codpar);


--
-- TOC entry 4774 (class 2606 OID 5732692)
-- Name: proyectos estrfunc_estructura_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT estrfunc_estructura_fk FOREIGN KEY (idestructura) REFERENCES public.estructura(idestructura) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4775 (class 2606 OID 5732711)
-- Name: presupuesto presupuesto_clasificador_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto
    ADD CONSTRAINT presupuesto_clasificador_fk FOREIGN KEY (idclasificador) REFERENCES public.clasificador(idclasificador);


--
-- TOC entry 4776 (class 2606 OID 5732716)
-- Name: presupuesto presupuesto_proyectos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto
    ADD CONSTRAINT presupuesto_proyectos_fk FOREIGN KEY (idproyecto) REFERENCES public.proyectos(idproyecto);


-- Completed on 2025-08-14 21:02:35

--
-- PostgreSQL database dump complete
--

