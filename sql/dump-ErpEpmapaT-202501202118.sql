--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-01-20 21:18:33

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
-- TOC entry 231 (class 1259 OID 2988664)
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
-- TOC entry 232 (class 1259 OID 2988680)
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
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 232
-- Name: beneficiarios_idbene_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.beneficiarios_idbene_seq OWNED BY public.beneficiarios.idbene;


--
-- TOC entry 308 (class 1259 OID 2988901)
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
-- TOC entry 309 (class 1259 OID 2988910)
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
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 309
-- Name: gruposbene_idgrupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gruposbene_idgrupo_seq OWNED BY public.gruposbene.idgrupo;


--
-- TOC entry 310 (class 1259 OID 2988911)
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
-- TOC entry 311 (class 1259 OID 2988914)
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
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 311
-- Name: ifinan_idifinan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ifinan_idifinan_seq OWNED BY public.ifinan.idifinan;


--
-- TOC entry 5142 (class 2604 OID 2989232)
-- Name: beneficiarios idbene; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios ALTER COLUMN idbene SET DEFAULT nextval('public.beneficiarios_idbene_seq'::regclass);


--
-- TOC entry 5156 (class 2604 OID 2989265)
-- Name: gruposbene idgrupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gruposbene ALTER COLUMN idgrupo SET DEFAULT nextval('public.gruposbene_idgrupo_seq'::regclass);


--
-- TOC entry 5163 (class 2604 OID 2989266)
-- Name: ifinan idifinan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ifinan ALTER COLUMN idifinan SET DEFAULT nextval('public.ifinan_idifinan_seq'::regclass);


--
-- TOC entry 5313 (class 0 OID 2988664)
-- Dependencies: 231
-- Data for Name: beneficiarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficiarios (idbene, codben, nomben, tpidben, rucben, ciben, tlfben, dirben, mailben, tpcueben, cuebanben, foto, b1, b2, b3, idgrupo, idifinan, modulo, usucrea, feccrea, usumodi, fecmodi, swconsufin) FROM stdin;
1	000000	(Ninguno)	04			\N	\N		1	\N	\N	0	0	0	2	1	1	1	2020-01-21	\N	\N	0
2	P-0001	ACERO COMERCIAL ECUATORIANO S.A.	04	1790008959001		022454333	Av. de la Prensa N45-14 y Telégrafo 1	pguayasamin@acerocomercial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
3	P-0002	ACOSTA VILLOTA JUAN CARLOS- VULCANIZADOR	04	0401526629001		0994790913	Av. Tulcanaza y Pío Montúfar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
5	P-0004	AGENCIA NAL. REGULACION CONTR. VIG. SANI	04	1768169530001		023824230	Comercio 280 y la Razón	alexandra.flores@controlsanitario.gov.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
6	P-0005	AGUILAR REVELO LUIS- TALLER AGUILAR HIGH	04	0400882668001		0994931463	Camilo Ponce y Carlos Oña	hernanaguilarrev1969@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
7	P-0006	AKI TULCAN	04	1790016919001		2960021	Ricardo del Hierro s/n y Av. Luciano Cor	comprobanteselectronicos@favorita.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
8	P-0007	ALMACEN "CRISTIAN " DOS- MONTENEGRO ISAC	04	0400999769001		2980213	Atahualpa y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
10	P-0009	ALMEIDA ERAZO LUIS ERNESTO	04	0400520474001		2590424	César Baquero N60-10 y Segundo Arauz	ealmeidadeportes@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
11	P-0010	ALMEIDA ROMERO JOHANNA - JARTRANSPORT	04	1716632573001		0998208641	Ulpiano Páez 468 N21jalmeida	jalmeida@jartransport.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
12	P-0011	ALMEIDA TERAN OSCAR IVAN	04	0400919809001		2981-959	Olmedo y Ayacucho	oscar_almeida1@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
13	P-0012	ALPASACHA CIA. LTDA.	04	1792548373001		0996570287	Pedro Pinto Guzmán 709 y Av. Napo	gerencia@alpasacha.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
14	P-0013	ALTAMIRA SERVICE - ALTAMIRANO LIDIA	04	0913575577001		0989923849	CC Bahía Norte Av. de las Américas 510	altamiraservice@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
15	P-0014	ALVAREZ CARLOS ANIBAL	04	0400813564001		0997455096	Calle 10 de agosto y Pasaje Sin Nombre.	carlitosanibal_1966@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
18	P-0017	ARCOTEL AGENCIA REGULACION Y CONTROL TEL	04	1768181900001		2947800	Av. 9 de Octubre N27 75 y Berlín 	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
19	P-0018	ARMAS PAEZ RICARDO NAYIB	04	0401731690001		0968715134	General Landázuri y Bolívar	enzonayos18@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
20	P-0019	ASEGURADORA DEL SUR	04	0190123626001		2997500	Av. de Los Naranjos N$$-463 y Azucenas	exseloyseguros@hotmial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
21	P-0020	ASEOTOTAL S.A.	04	1792018420001		0993631007	Betania 28 y San Vicente Paul	compras.publicas@aseototal.info	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
22	P-0021	ASOCIACION DE BOMBEROS 19 DE FEBRERO T	04	0491510722001		2960548	La Y. Av. Manabí s/n y Argentina	asociacion_bomberos19defebrero@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
23	P-0022	ASOCIACION ECONOMIA SOLIDARIA LOS PASTOS	04	0491512059001		0993939058	Av. Julio Robles s/n y Jorge Manrique	juangissi@textileslospastos.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
24	P-0023	ASOPROLICARC ASOC. PRODUCCION TEXTIL 	04	1792618185001		0986957238	Av. Coral y Argentina	asociacionemprendedoresc@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
25	P-0024	ASOPROSERVI ASOCIACION PROD.TEXTIL SERVIR	04	0491517107001		0980518210	26 de Mayo Nº 24 y Flavio Alfaro	asociacionservirparavivir@gmail.com	2	4008114893	\N	0	0	0	1	71	1	1	2020-01-21	\N	\N	0
26	P-0025	ASOSEINRO ASOCIACION PROD.TEXTIL Y SEG.	04	0190431045001		074084889	Calle de Los Cerezos s/n y de Los Babaco	bolo1492@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
27	P-0026	ASOTEXCARCHI	04	0491517190001		2960686	Ayacucho 758 y Rafael Arellano	mariaalvearo@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
28	P-0027	ASOTEXCOMATUL	04	0491517514001		062961431	Tulcanaza s/n y Centenario	asociacioncortemagico@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
29	P-0028	ASOTEXREMONT	04	0491517352001		0988266230	Panamericana s n e Isaac Acosta 	asociacionrelmontufar@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
30	P-0029	ASOVIPROG -ASOC. PRODUC. VIDA Y PROGRESO	04	1091748084001		062630963	Callejón SN y Tulipanes	vidayprogreso@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
31	P-0030	ASPROTEXESTUM ASOC. PROD. TEXTIL ECONOMI	04	0491519487001		0986932508	Rafael Arellano y Pasaje Riobamba 	asociaciontulcanmoda@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
32	P-0031	AUDITA & REPORTA AUDIREPORT CIA. LTDA.	04	0993034142001		0991444016	Francisco P. Icaza Nº407 y Gral. Córdova	nm_cpa@audireportec.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
33	P-0032	AUTOMEKANO CIA. LTDA.	04	1891715664001		032520182	Av. 10 de Agosto 10-814 y Tufiño	fbarahona@automekano.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
34	P-0033	AUTOPARTES Y AUTOGRUAS FCN S.A.	04	1792541743001		062985833	Av.El Centenario Nº654 y Av. Veintimilla	autopartescalannarvaez@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
35	P-0034	AYALA ENRIQUEZ JHON HENRY	04	0400994596001		062988748	Rafael Arellano s/n y Panamá	jhonayala1973@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
36	P-0035	AYALA FLORES CRISTIAN BLADIMIR	04	1003319041001		0994167482	Colón entre Roca y Atahualpa (Otavalo)	bladimir_1511_a@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
37	P-0036	AYALA GUERRERO JAIME RIGOBERTO	04	0400533527001		062985791	Av. Veintimilla y Juan Ramón Arellano	emiliach65@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
38	P-0037	AYALA GUERRERO JOSE MIGUEL- FERROTEX1	04	0400476990001		2983109	Av. Coral  59107 y Bolivia	jmayalag2088@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
39	P-0038	AYALA GUERRERO OSWALDO FERNANDO	04	0400719969001		0986234093	Roberto Sierra y Bolívar	jimmyayala123@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
40	P-0039	AZA TAIMAL GIRLENZA AURELIA	04	1750787044001		0986932508	García Moreno y Rafael Arellano	confecciones_elizabeth@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
41	P-0040	BASTIDAS LEON ANTONIO ESGARDO- MULTICARP	04	0491510986001		0997373375	Av. 24 de Mayo y Av. 26 de Mayo	multicarpascolombia@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
42	P-0041	BATALLAS LOMAS ORLANDO GERMAN	04	0400586137001		2205245	Calle Tarqui y Amazonas	malena_8523@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
43	P-0042	BECERRA DE LA CRUZ PEDRO IRRAEL	04	0400712717001		2986626	Junín 396 y Blolívar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
44	P-0043	BENITEZ TULCAN WILSON ARTURO 	04	0400587382001		0981091277	Cdla. Divino Niño Julio Robles s/n y Gra	wilsonbenitez@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
45	P-0044	BERMÚDEZ ARIAS OMAR JOSUÉ - SEGLOBAL 04	04	0400854394001		062980715	Av. Coral Nº 59039 y Venezuela	josuecurita@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
46	P-0045	BOLAÑOS ROSERO JOHNNY GABRIEL	04	0401232756001		0980333222	Pichincha S/N y Maldonado	gabobolaños2@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
47	P-0046	CABEZAS MOSQUERA JOFFRE PATRICIO	04	0400799490001		2-961-515	Bolívar s/n entre Junín y Ayacucho	pcabezas@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
48	P-0047	CADENA CEVALLOS NELSON IVAN	04	0400836573001		023265270	La Campiña del Inca - Calle 3 105 y Av. José Felix	tccc5@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
49	P-0048	CADENA CHUGA MANUEL BERNABE	04	0401019492001		0985316215	Afrodita s/n y Av. Julio Robles	bernabecadena74@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
50	P-0049	CADENA FIERRO CARLOS EFRAIN- DIDOPAST	04	1705255832001		0999663152	Maldonado 12-61 y Olmedo- Atuntaqui	carlcadenaf@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
51	P-0050	CADENA ROSERO WILMER OLIVER RENE	04	0400584983001		2285-466	Venezuela N13-31 y Antonio Ante	wilmer@renecadena.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
52	P-0051	CALAN NARVAEZ YOLANDA DEL ROCIO	04	0400930046001		0986990451	Calle Calderón y Paraguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
53	P-0052	CALZADO ANDINO, ANDICALZADO S.A.	04	1792190371001		2473968	Bartolomé Sánchez N72-223 y Antonio B.	contabilidad@andicalzado.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
54	P-0053	CAMINO MONTESDEOCA AMERICA ROCIO -PROLIM	04	1804133237001		0991341711	Humberto Fierro s/n y Pasaje Juan Abel	rociocamino1984@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
55	P-0054	CARPAS COL	04	0491515791001		0995823866	Ejido Sur, Av. Veintimilla	carpascol.myd@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
56	P-0055	CASA TOPOGRAFICA	04	1704110103001		22569355	Av. 6 de Diciembre s/n y La Niña	casatop@uio.satnet.net	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
57	P-0056	CASTILLO GOYES LUIS ANTONIO- FOTO ARTE	04	0400955324001		2962824	Ayacucho 367 y Sucre	fotoarte07@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
58	P-0057	CASTRO CASTILLO LUIS FERNANDO	04	0400735254001		2982-658	México s/n y Av. 24 de Mayo	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
59	P-0058	CASTRO CASTILLO SEGUNDO MEDARDO	04	0400539391001		2982333	Av. Veintimilla s/n y San Cristóbal	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
60	P-0059	CEDENO JURADO GABRIEL ANTONIO CSQ SOLUTI.	04	0916866767001		0993318746	Ciudadela Vernaza Norte Solar 7	gabriel_antonio_25@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
61	P-0060	CEMIMEX CIA. LTDA.	04	1790500039001		022549148	Ulloa N27-114 y Selva Alegre	cemimexcialtda@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
62	P-0061	CENADEPRO CIA. LTDA.	04	1792591783001		022227845	Díaz de la Madrid Oe5-105 y la Isla.    	contabilidadcenadepro@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
63	P-0062	CENTRO FERRETERO HUACA -IRUA H. VANESSA	04	0401729215001		062973039	Calle 8 de Diciembre y Cristóbal Colón	ariday1209@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
64	P-0063	CENTROLUZ	04	0400721387001		2981-771	Calle Colón 51018 y 10 de Agosto	centroluzquito@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
65	P-0064	CHAMORRO BUSTOS MARICELA ROCIO	04	0401771084001		0997945979	Calle Pichincha s/n y Maldonado	mary_chamorro88@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
66	P-0065	CHAMORRO POZO NEREIDA - COPYARTE	04	0400703088001		2988125	Ayacucho s/n y Bolívar	CopyArte_1974@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
67	P-0066	CHAMPUTIZ JARAMILLO GUIDO PATRICIO	04	0400583761001		0998132117	Av. Coral y Venezuela	gchamputiz@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
68	P-0067	CHAVEZ ENDARA EDISON JAVIER -MACRO PHOTO	04	0400947289001		0990406385	Calle Junín s/n y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
70	P-0069	CHERREZ PILLALAZA JORGE PATRICIO	04	1801635812001		0984582061	Imbabura SN y Gertrudis Esparza	pcherrez60@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
71	P-0070	CHICANGO BENÍTEZ WILMER FABIAN	04	0400957882001		0969364523	Julio Robles y El Oriental	wilmerchicango@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
72	P-0071	CHINGAL MELO EDGAR IVAN	04	0400881538001		2-983-380	Brasil No. 62-016 y Cotopaxi	principeivan1@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
73	P-0072	CHUNEZ MORILLO JOFFRE JAVIER- INFOTEC	04	0401050182001		0997534888	Sucre y Tarqui	infotec.sa@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
74	P-0073	CINECABLE TELEVISIÓN	04	0491500972001		2985-808	Bolívar s/n y Junín CC YOLIS	mreina@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
75	P-0074	CISNEROS BENAVIDES RENE NELSON	04	0401036124001		0999558253	Vía a Tufiño- La Ensillada	parcero100180@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
76	P-0075	CODYXO PAPER CIA. LTDA.	04	1791775643001		0983513186	Isla Fernandina (393) N42-117 y Tomás B.	facturacion@codyxopaper.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
77	P-0076	COGECOMSA S.A.	04	1790732657001		023814360	Francisco de Orellana L198 y Hernando M.	cogecomsa@cogecomsa.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
78	P-0077	COLLANTES HERVAS ALEX  - DOME SPORTS	04	1801713684001		0982867852	Lizardo Ruiz 02-64 y Maldonado - Ambato	alexcollantes2004@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
79	P-0078	COMERCIAL CARCHI -BENAVIDES REVELO SILVIA	04	0400579231001		062980645	Olmedo 52-069 y Junín	scabrera@comercialcarchi.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
123	P-0122	GOYES POZO ESTHELA MARIBEL	04	0400582060001		2982623	Av. Veintimilla	sagitario_luna1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
80	P-0079	COMPU.COM COLLAGUAZO SEGUNDO RAFAEL	04	1707510341001		0992063859	Av. Veintimilla y Centenario	rafael_collaguazo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
81	P-0080	CONSTRUALVID- CHUGA CHUUGA EDWIN	04	0400991592001		0985612058	Olmedo 54-035 y Boyacá	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
82	P-0081	CONSTRUCTORA V&M FRONNORT S.A.	04	0491521619001		0984264334	José María Urbina y Belén	vargas@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
83	P-0082	CONTINENTAL TIRE ANDINA S.A.	04	0190005070001		0984389490	Panamericana Norte Km. 2.8 ECO10105 	compraspublicas@continental.com	1	00070001855	\N	0	0	0	1	6	1	1	2020-01-21	\N	\N	0
87	P-0086	CORAL GUANCHA DORMAN ALIRIO	04	0401294731001		0993280925	Isla Fernandina 26 e Isla Pinzón	aliriocoral_2020@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
88	P-0087	CORAL RAMOS CRISTIAM FERNEY- NOTARIA 1ª	04	0400752432001		2988230	Bolívar Nº51-052, 10de Agosto y Ayacucho	info@notariaprimera.org	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
89	P-0088	ALS ECUADOR ALSECU S.A.	04	1791943783001		3414080	Los Eucaliptos E3-23 y de los Cipreses	karina.falcones@alsglobal.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
90	P-0089	CORPORACION FAVORITA C.A.	04	1790016919001		22996582	Av. General Enríquez Vía Cotogchoa	lfikar@favorita.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
91	P-0090	CORPORACION NACIONAL DE TELECOMUNICACION	04	1768152560001		5932 3666 100	Veintimilla E4-66 y Amazonas	germania.lomas@cntgob.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
92	P-0091	CORTEZ ROJAS FANNY MARITZA -MODAS LIZBET	04	0400671459001		062291887	Calle Rocafuerte y Maldonado	fannycortez@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
93	P-0092	CRUCERIRA VIVAS CESAR OMAR- TALLER AUTOC	04	0401019880001		062224980	Av. Calderón y Uruguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
95	P-0094	DELGADO LUCERO MANUEL MESIAS	04	0400445664001		062981225	Calle Pichincha Nº 469	manueldelgado54@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
96	P-0095	DIAZ RODRIGUEZ GONZALO JAVIER	04	1712195625001		0958845210	José María Guerrero N70-133 y Alonso.	gonzalojdr@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
97	P-0096	DIAZ VALLEJO JULIO CESAR	04	1001866985001		0993506916	Av. Manabí Nº 61045	audiosistemsjc@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
98	P-0097	DISTRIBUIDOR MATERIALES CONSTRUCCIÓN DIMAPO	04	1792931959001		2984092	Av. Veintimilla s/n y México	dimacotulcan@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
99	P-0098	ECUATORIANA DE MATRICERIA ECUAMATRIZ CIA	04	1890108241001		032755189	Santa Rosa Vía Ecológica sn Bernardino E	ventas2@ecuamatriz.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
100	P-0099	EDITORES MMA ASOCIADOS CIA. LTDA.	04	1790209113001		062982024	Bolívar y Junín Esquina	cbaez@elnorte.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
101	P-0100	EDITORIAL MINOTAURO S.A.	04	1790548287001		2984-646	Sucre Entre Ayacucho y Junín	cchamorro@lahora.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
102	P-0101	ELECTROLUX - DELGADO GUZMAN EDGAR	04	0400398137001		2981369	Av. Coral 2602 y Brasil	edgardelgado2015@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
103	P-0102	EMELNORTE	04	1090051721001		2980694	Juan Manuel Grijalva 6-54 y José Joaquín	ggarcia@emelnorte.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
104	P-0103	ENRIQUEZ NARVAEZ LUIS HUMBERTO	04	0400729836001		2980288	D9 y Pasaje G Parque Artesanal	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
105	P-0104	EP PETROECUADOR	04	1768153530001		  2994200	Av. Veintimilla y Av. Centenario	gerardo.piarpuezan@eppetroecuador.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
107	P-0106	ESERDING S.A.	04	1792458609001		0995006653	El Dorado- Vicente Solano E4-320 y Gran 	eserding@outlook.com	1	2100050267	\N	0	0	0	1	74	1	1	2020-01-21	\N	\N	0
108	P-0107	ESPINOZA GUERRERO HUGO FERNANDO	04	0401255443001		06-2-982-494	Tarqui 279 y Olmedo	hellavemaestra@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
110	P-0109	ESTRADA CHUGA DIEGO ARMANDO	04	0401245071001		2962647	Sucre 0620 y Roberto Grijalva	diegoestrada06@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
111	P-0110	ESTRELLA GRIJALVA LUIS SANTIAGO -CLEAN S	04	1709254468001		0992715362	Los Pinos Lt 70 y Av. General Rumiñahui	contable_ec@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
112	P-0111	ESTRELLA MAYA JORGE FERNANDO	04	0400959748001		0993615846	Ignacio Asin OE8-133 y Vicente Heredia	fernandoestre@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
113	P-0112	FALCONI CISNEROS JOSE LUIS- LA CONDAMINE	04	1715241525001		026008952	Los Eucaliptos OE3-105 y Real Audiencia	contabilidad@lacondamine.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
114	P-0113	FARMAENLACE CIA. LTDA 	04	1791984722001		0990539200	Veintimilla s/n y Arellano	ecotulcanveintimilla@farmaenlace.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
115	P-0114	FERRETERIA PROFEMAC S.C.	04	1792543894001		062960869	Rafael Arellano s/n y Junín	profemac1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
116	P-0115	FIERRO POZO NANCY NOEMY- LA OVEJA NEGRA	04	0400602934001		0992707056	Calle Cuenca s/n y Venezuela	ovejanegradesing@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
117	P-0116	FIGUEROA ORTEGA NELSON POLIVIO	04	0401109731001		2250323	Calle Colón entre 10 de Agosto y Pichincha	figueroanelson28@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
118	P-0117	GARCIA VALENCIA CYNTHIA STEFANIA	04	1716760382001		026008952	Eucaliptos OE3-105y Av. Real Audiencia	contabilidad@lacondamine.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
119	P-0118	GENSYSTEMS S.A.	04	0992238402001		45125636	Alpallana E/-123 y Whimper	angel@gs-ec.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
120	P-0119	GONZÁLEZ ALVAREZ MARÍA JOSÉ -INNOVAGUA	04	1712845880001		0992728952	1º de Mayo Cs-28 y 7 de Febrero 	comercial@innovagua.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
121	P-0120	GONZÁLEZ VARGAS JOSÉ MANUEL	04	1724313935001		022071013	Autopista General Rumiñahui 428 y Lucian	contabilidad@superinflables.net	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
122	P-0121	GORDON MORA NATALY JOHANA	04	0401412853001		0980339420	San Juan y Río Bobo	tallerdetorno1973@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
124	P-0123	GPDATA SERVICIOS AMBIENTALES  CIA. LTDA.	04	0691743063001		0987713054	Veloz 40-11 y Carlos Zambrano- Riobamba	gpdata-eia@outlook.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
125	P-0124	GRUPO EL COMERCIO	04	1790008851001		0987441013	Av. Pedro Vicente Maldonado 11515 y El T	clarco@elcomercio.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
126	P-0125	GUERRERO CABRERA MARIA F. -COLCHONMAR	04	0401199237001		0994491843	Av. Coral y Venezuela	mafergc7@hot.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
127	P-0126	GUERRERO CISNEROS ARTURO WASHINGTON 	04	0400736427001		2963094	Luis Cordero Crespo y Barrio San Vicente	yess-92@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
128	P-0127	GUERRERO IBARRA DAYANA GABRIELA	04	0401673884001		260077	Av. Coral 62091 y Paraguay	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
129	P-0128	GUERRERO NILO GERMAN	04	0400631453001		0993672730	Av. Víctor Manuel Guzmán 11-69 y Juan M.	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
130	P-0129	GUERRÓN MEJÍA SANTIAGO HERMEL- PINTACASA	04	0401255534001		0998480669	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
131	P-0130	GUERRON MORILLO MARCO ANTONIO	04	0400354866001		2985830	Ayacucho s/n y Olmedo	graficasguerron@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
132	P-0131	GUERRON VILLARREAL SEGUNDO -TALLER COLOR	04	0400396727001		062984148	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
133	P-0132	GUZMÁN BURBANO JOSÉ ANTONIO	04	0400541504001		0982593007	Av. Manabí s/n y Av. Brasil	jantonioguzman417@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
134	P-0133	HDM ELQUITECNICA CIA. LTDA.	04	1790990842001		2464587	Av. República del Salvador N35-182 y Sue	asesoriatecnica.hdm@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
135	P-0134	HERRERA NARVAEZ ADRIANA VERONICA	04	0401492731001		062987429	Guatemala y Av. Coral	adriana_veronicah@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
136	P-0135	HIDALGO FLORES ROBINSON CRUSOE	04	1002156873001		062558242	Av. 13 de Abril 18-64 	metalicasfortex@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
137	P-0136	HSEQ CONSULTING -PUETATE CASTRO ROSA E.	04	0401544259001		0997641549	San José San Francisco y Asdrubal B.	e.puetate87@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
138	P-0137	HYDROQUIM BALDEÓN JÁTIVA FANNY YOLANDA 	04	1703517605001		2645-510  26455	De Los Claveles S9-786 y Real Audiencia	hydroquim@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
139	P-0138	IDODIANDINA CIA. LTDA.	04	1792421551001		022552070	Av. Eloy Alfaro N28-49 y Av. 10 de Agost	jparedes@idodiandina.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
141	P-0140	IMBAQUINGO GUILLERMO EDMUNDO	04	0400461067001		2960077	Urb. Vista Hermosa- General Landázuri s/	gimbaquingo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
142	P-0141	IMBAUTO S.A.	04	1090077135001		2983-804	El Rosal Panamericana Norte	retenciones@imbauto.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
144	P-0143	INCINEROX CIA. LTDA.	04	1791414713001		026051494	Pichincha Quito Pintag Via Pifo SN y Vía	danielaboada@incinerox.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
145	P-0144	Ipial Diógenes	04	0400819884001		2224224	Via a Taquez No 195	diogenesipial@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
146	P-0145	JACOME BRAVO EDWIN RAMIRO	04	0401062674001		0986259912	Roberto Grijalva y Av. Coral	edwinjacome1@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
147	P-0146	JIMENEZ TORRES MAURICIO FERNANDO	04	1709173106001		2-985-717	Olmedo s/n y Chile esquina	jimenezmauricio808@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
148	P-0147	JOELTRANS CIA. LTDA.	04	1792581184001		0995447148	Rancho Chico OE-103 y Ecuador	joeltrans@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
149	P-0148	JURADO VILLAGOMEZ EDISON ANCIZAR- EDIVA	04	1710059575001		022547761	José Tamayo N24-608 y Av. Colón	edison1jurado@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
150	P-0149	LA PRENSA INTERDIARIO DEL CARCHI	04	0491500778001		2984893	Olmedo y 10 de Agosto	prensatulcan@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
151	P-0150	LANDETA VILLARREAL XIMENA DEL PILAR 	04	0400822854001		0997392705	Sucre s/n y Rocafuerte	mariafernandateran@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
152	P-0151	LEMA CHAUCA JORGE RODRIGO- SIMPLIFIKAT	04	1715575591001		0997418888	Machala  N59-45 y Angel Ludeña	ventas@simplifikat.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
153	P-0152	LEORO PONCE JUAN CARLOS -COMERCIAL Z	04	1708976574001		022658251	General Eplicachima S9-236 y Jambelí	contabilidadcomercialz@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
154	P-0153	LEXIS S.A.	04	1790859177001		2417309	Av. Galo Plaza Laasso N47-190 y Pasaje F	jcamiloserna@lexis.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
155	P-0154	LOMAS AYALA LUCIA YOMAIRA DEL PILAR	04	0400776670001		062983888	La Rinconada- Nuevo Oriental s/n y André	washintonpantoja@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
156	P-0155	LOMAS TAPIA LUIS ALFONSO	04	0401594890001		0967540898	Eloy Alfaro y Juan Montalvo (Maldonado)	lomas_alfonso@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
157	P-0156	LOPEZ NARVÁEZ JAMES FABRICIO	04	0400962874001		2984-806	Juan Ramóm Arellano s/n y Río Napo	lopezfabricio@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
158	P-0157	LOPEZ PANTOJA ALEXANDER	04	1753845138001		0984782353	De las Alondras E15-90 y de las Higueril	alex.lopez@eurovix.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
159	P-0158	LOPEZ SOTO MARIA ELIZABETH - EL PARABRIS	04	0401295977001		0985356035	Av. 24 de Mayo  y Los Alamos	ricardofabiolc@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
160	P-0159	LUBRICANTES DEL SUR- HUERA TAPIA MARIA	04	0400932877001		2245452	Av. Veintimilla s/n y Pablo Muñoz Vega	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
161	P-0160	LUCERO LUCERO RENE- TALLER AUTOMUNDO	04	0400747630001		2985612	Av. Manabí y Los Alamos, Barrio La Y	renefabianlucero@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
162	P-0161	LUCERO MUESES EDISON ARMANDO	04	0401281043001		0981458758	Argentina s/n y Olmedo	luceroedison@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
163	P-0162	MALLAMA CUAICAL JAIME EDGAR- MUNDICOLOR	04	0400877908001		0980409784	Calle Bolívar y Carabobo	mundicoloredgar@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
164	P-0163	MARKET VIDRIOS- NARVAEZ MEDINA EDER	04	0401027537001		0997698894	Calle Bolívar s/n y Sucre	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
165	P-0164	MARTINEZ ERAZO RAUL- ALMACENES MARTINEZ	04	0400999223001		2986355	Atahualpa 6-089 y Bolívar	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
166	P-0165	MARTINEZ FUERTES SEGUNDO EMIGDIO	04	0400662904001		0990743799	Av. Calderón s n y Chile	nathyta_822@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
167	P-0166	MASABANDA CHANCUSI EDISON - MOBILIARIO M	04	1714949524001		0939824295	Calle Carlos Freire y Pasaje Libertadore	super_dj1983@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
168	P-0167	MAYA BENAVIDES LUIS FERNANDO- GRUPO MAYA	04	0400917886001		0997770444	Gran Colombia -Ayacucho 675 y Rafael A.	grupomaya69@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
169	P-0168	MEDINA YEPEZ BORIS GUISSEPE - TOSINORI	04	1001579687001		2611400	Sector Tenis Club Calle Venancio Gómez J	tosinorisa@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
170	P-0169	MELO FIERRO RUBÉN DARÍO	04	0400796439001		0996638601	Cepia- Coral y Brasil	rbdariomelofierro@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
171	P-0170	METALURGICA ECUATORIANA CIA. LTDA.	04	1790212734001		2644-550	San Bartolo Teodoro Gómez de la Torre 72	figueroa@interactive.net.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
173	P-0172	MINISTERIO DEL AMBIENTE, AGUA Y TRANSICIÓN ECOLÓGICA 	04	1760010460001		3987600	El Girón Madrid E12-102 y Andalucía	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
174	P-0173	MONTALVO PAREDES EFRÉN RENÉ- TECNISERVS	04	0100085109001		0999444263	Av. Julio Miguel Aguinaga y Río Amazonas	belen123456a@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
175	P-0174	MONTENEGRO EDGAR LIBARDO- PINTUCOLOR	04	0400774519001		062960391	Av. Veintimilla y Av. Universitaria	pintucolor_libardo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
176	P-0175	MONTENEGRO JIMÉNEZ DIEGO F. - SYSTAR.COM	04	0401800180001		0958819678	Bolívar s/n y 10 de Agosto	die_fer03@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
177	P-0176	MONTENEGRO TORO CARLOS	04	0400242830001		2980-277	Cdla. Kenedy General Urbina y Belén	elromanticoagma@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
178	P-0177	MONTERO ONOFRE RAUL ERNESTO	04	0400271524001		0996426720	Ecuador s/n y Urbina	raul48montero@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
179	P-0178	MONTGAR COMPAÑÍA ANÓNIMA	04	1791276779001		022306700	Calle Luis Calderón S/N y Av. Manuel C.	ventas1@montgard.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
180	P-0179	MORA CHINGUA MARITZA MARGARITA	04	0401396031001		2960377	RAFAEL ARELLANO S/N Y 10 DE AGOSTO	maritza_mora123@yahoo.com.ar	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
181	P-0180	MORENO ORTEGA LUIS - FERROALVID	04	0400741609001		2988200	Pasaje Riobamba s/n y Bolívar	ferroalvid@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
182	P-0181	MOSCOSO CÓRDOVA ALONZO MANUEL	04	1706733324001		0999582539	Calle S6 Consuelo Benavides Nº E20-99	alonzomoscoso@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
183	P-0182	MOVITECH- GUERRERO QUINTERO JAVIER	04	0401533955001		62982361	Sucre y Junín Esquina	jguerrero@movitech.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
184	P-0183	MUÑOZ MAYA EDGAR JAVIER	04	0401263439001		0983690367	Rafael Arellano y General Landázuri	edgarjavier2019@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
185	P-0184	NAINPASERVICES CIA. LTDA.	04	1792377110001		023465-496	De Los Guacamayos N60-06 y Juan Molinero	info@nainpa.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
187	P-0186	NARVÁEZ GORDÓN CARLOS EDUARDO 	04	0401733688001		0996801475	Rubén Darío s/n y Av. San Francisco	bon_jhon@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
188	P-0187	NARVAEZ TREJO BYRON VLADIMIR - LUMIDECOR	04	0400953550001		2962458	Calle Sucre Nº 45A036 y Quito	byron-narvaez@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
189	P-0188	NAVISOY REYES OSCAR ANDRES	04	0401049069001		0985369914	Antisana y Sumaco	oscarnavisoy@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
190	P-0189	NAZATE VILLARREAL RODRIGO ANTONIO	04	0400185310001		0622224709	Calle Antisana s/n y Zumaco	rodriantonazate@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
191	P-0190	NOGUERA MARTINEZ ROMEL JESUS 	04	0400577060001		0993958112	Calle Manuel Pólit y Julio Matovelle	romeljesusnoguera@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
192	P-0191	NOVACERO S.A.	04	0590038601001		022974163	Calle J Nº S60-87 y Calle Tercera	paredesp@novacero.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
193	P-0192	OBANDO MUÑOZ OSCAR MANUEL	04	0400652640001		062280317	Eugenio Espejo 917 y Leopoldo Chávez	sikomira@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
195	P-0194	ORTEGA CADENA SEGUNDO CARLOS	04	0400424024001		062983117	Juan José Flores S/N y Ayacucho	carlos1954ortega@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
196	P-0195	ORTIZ POZO AMANDA PAOLA- MEGAREPUESTOS	04	0400979878001		2983622	Av. Veintimilla y Pasaje Cenepa	paointercambio@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
197	P-0196	ORTIZ TARAMUEL HENRRY RAMIRO	04	0401156096001		0985184694	Calle Juan José Flores y Vía a Chapues	ramiroortiz1974@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
198	P-0197	PABON MIER ARACELY PAOLA - PROVEEDORA DE	04	1002786778001		2600592	Av. Cristobal de Troya Pasaje Heleodoro 	megarepuestos88@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
199	P-0198	PAGUAY ALPALA NESTOR FERNANDO	04	0401468707001		0986769178	Cerro Azul y Pasaje Zeus	paguaynestor@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
200	P-0199	PANAMERICANA VIAL S.A. PANAVIAL	04	1791317025001		3982500	Panamericana Norte	serviciocliente@panavial.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
201	P-0200	PANTOJA GUAMÁ WILSON BAYARDO	04	0400617668001		0986440567	Rafael Arellano y Capitán Castillo	bayardo.pantoja@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
203	P-0202	PASPUEL PUETATE LIBARDO	04	1710259068001		0939935329	Calle 11 de Abril y Rocafuerte	libardopaspuel29@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
204	P-0203	PERGUEZA PUETATE HÉCTOR RAMIRO	04	0400642310001		0997721463	Av. Tulcanaza y Espejo	santiagopergueza93@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
205	P-0204	PETROWORLD S.A.	04	1791280792001		2960077	Av. República 1530 E Inglaterra	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
206	P-0205	PLASTILIMPIO S.A.	04	1792092108001		0987472673	Vicente Duque N77-433 y Juan Selis	prosania@plastilimpio.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
207	P-0206	PORTILLA MARCO ANTONIO	04	0400658118001		0991119337	Ciudadela Nuevo Tulcán, calle Dos Nº 18	portilla_marco@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
208	P-0207	POZO AYALA JOSE LUIS	04	0401432539001		0983694617	Sangay y Antisana	luisyunior3652@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
209	P-0208	POZO TARUPI MARCELO JAVIER	04	0400896973001		2961-092	Av. Veintimilla s/n y México	marcelopozo71@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
210	P-0209	PRINTEC - HIDALGO VASCONEZ RICHARD	04	1702536077001		022263977	El Batán Portugal 620 y 6 de Diciembre	printecuador@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
211	P-0210	PROAÑO JIMENEZ EDMUNDO DANTES	04	0400749321001		2988254	Olímpica Nº 37 	edmundoproaño@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
212	P-0211	PULLES JACOME IVAN VLADIMIR	04			\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
213	P-0212	PULLES JACOME LEONOR ELIZABETH	04			\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
214	P-0213	PULLES MINA LEONARDO JAVIER	05		0401480447	\N	\N	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
215	P-0214	QUELAL NEJER HECTOR MARCIAL	04	0400867420001		2960807	Av. Expreso Oriental s/n y Andrés Bello	vulcanizadoraquelal@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
216	P-0215	QUIMIEM CIA. LTDA.	04	1791253728001		022461-500	Ignacio San María E3-30 y Juan González	info@quimiem.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
217	P-0216	QUIMPAC ECUADOR S.A.	04	0990344760001		2691-477	Panamericana Sur Km.14 s/n y Guajalo	mvelastegui@quimpac.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
219	P-0218	RADFANTASTICA S.A.	04	0491518383001		0999194175	Bolívar y Junín	mreina@cinecabletv.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
220	P-0219	SERVICIOS DE RADIODIFUSION ALMEIDA & BENITEZ S.A	04	0491514442001		2981928	Olmedo y Ayacucho 	radiotulcan@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
221	P-0220	RAMÍREZ BENAVIDES JOHANA - TECNOMAQUINAR	04	0401633847001		2960077	Colón y 9 de Octubre	b13m232000@yahoo.com	1	2100034169	\N	0	0	0	1	74	1	1	2020-01-21	\N	\N	0
222	P-0221	REASCOS AGUILAR AMAYRA ELIZABETH	04	1002101655001		0984151837	Bolívar y Tarqui	b13m232000@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
223	P-0222	REASCOS ERAZO JORGE ARMANDO	04	0401276761001		0988937379	Calle Boívar s/n y Panamá	jorgearmandoreascoserazo@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
224	P-0223	REINA LLORENTE SEGUNDO FABIAN -TECNIMETA	04	0400661088001		0991680936	Juan de Velasco s/n y Av. Veintimilla	fabianreinall@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
225	P-0224	REINEC C. LTDA.	04	0992222905001		0987292293	Av. Rodrigo Chávez s/n y Av. Juan T.	info@ecuapagos.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
226	P-0225	REMACHADORA DE ZAPATAS SUPER BRAKE	04	0400776092001		2983520	Cdla. del Chofer Calle Juan Ramón Arella	carlosalmeida67@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
227	P-0226	REVELO ROSERO HUGO RAMIRO	04	0401303086001		2982-339	Bolívar 1051 y Tarqui	autronicautos@gmail.com	1	0029802270	\N	0	0	0	1	15	1	1	2020-01-21	\N	\N	0
228	P-0227	REYES TARAPUES ROBERTO FERNANDO	04	0401208665001		0997486662	Calle Boyacá S/N y Juan José Flores	robertoreyes662@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
229	P-0228	RIANDI CIA.LTDA.	04	1791035828001		0999100010	Inés Gangotena y Chillanes - Sangolquí	ventasriandi@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
230	P-0229	RIOFRIO BRAVO VICENTE FRANCISCO	04	1709350332001		2983882	10 de Agosto 51 A 009 y Gran Colombia	vicenteriofrio@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
231	P-0230	RODRIGUEZ HUERTAS JULIO HOMERO	04	0400593430001		2981-947	Río Amazonas s/n y Pasaje Cenepa	julio_rodriguez1959@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
232	P-0231	RODRIGUEZ YAR JOSE LUIS - MACROGLASS	04	0400983052001		0987048553	Av. Calderón y Panamá	luisrodriguez222@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
233	P-0232	ROMO LANDAZURI MARÍA JOSE	04	0401050505001		2981-464	Av. Centenario s/n Juan Ramón Arellano	tecnicentroromot@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
234	P-0233	ROSALES ROSERO MIRIAM ESTHER 	04	0400939484001		2984723	26 de Mayo y Av. 24 de Mayo	richardcer61@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
235	P-0234	ROSERO ENRÍQUEZ SEGUNDO GUILLERMO	04	0400356663001		0958645507	General Landázuri y José María Urbina	guillermoroseroenriquez@outlook.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
236	P-0235	ROSERO MALES CARMEN DEL ROCIO 	04	0401045554001		0989120199	10 de Agosto y Colón	carmenroserom174@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
237	P-0236	ROSERO POZO JUAN CARLOS	04	0401177522001		0987148191	Sucre y Pichincha	juan.rosero91@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
238	P-0237	ROSERO POZO TERESA CECILIA	04	0400679742001		2983708	Av. Coral s/n y Chile	lubricadorabarcelona@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
239	P-0238	RUEDA AGUILAR PATRICIA MANUELA	04	1706910047001		0998507316	Urb. Club Los Chillos Fucsias 144 y Av.	aguayriego@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
240	P-0239	RUEDA SALAZAR CARLOS VLADIMIR	04	0400415204001		2985-074	Centro Bolívar s/n y Junín	carlosvladimirrueda@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
241	P-0240	RUIZ PULE ARNULFO JOSELITO - AUTOLLANTAS	04	0400820700001		2242221	Av. Brasil s/n frente al Aeropuerto	joselo-ruiz@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
242	P-0241	SACOSGALLARDO CIA. LTDA.	04	1792227577001		022573520	Rocafuerte OE6-190 e Imbabura	facturacionsacosgallardo@gmail.som	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
243	P-0242	SALAZAR BOSMEDIANO ALEX RAMIRO	04	1718338443001		0983298341	Av. Mantilla s/n y García Moreno	alexsabo@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
244	P-0243	SALAZAR HUERTAS NELSON RODOLFO	04	0401370788001		0987621001	Bolívar s/n y Ayacucho	newsystem09@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
245	P-0244	SALAZAR PORTILLA YAJAIRA - DISTRIFORROS	04	0401556246001		0985659933	Manabí s/n entre Paraguay y Uruguay	yaja9-@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
246	P-0245	SBSMORRIGAN S.A.	04	1792533953001		2433478	Inglaterra E3-106 y Av. República	info@sbsconsulting.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
247	P-0246	SERVICIO ECUATORIANO NORMALIZACION  INEN	04	1768046530001		2501885	Baquerizo Moreno E8-29 y Av. 6 de Diciem	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
248	P-0247	SERVIENTREGA	04	0991285679001		2960021	Av. Rafael Arellano s/n y García Moreno	kerly.rendon@servientrega.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
249	P-0248	SUAREZ MAZAMBA MERCEDES ALEXANDRA 	04	1310045578001		0959176260	Av. Veintimilla y Rafael Arellano	emiliach65@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
250	P-0249	SUPER ESTACION DEL VALLE - HERNANDEZ JOS	04	1001973070001		062673120	Comunidad El Juncal Panamericana Norte	\N	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
251	P-0250	SUPERCENTRO FERRETERO KYWI	04	1790041220001		062598101	Av. Seminario y Av. Andrés Bello	andres.calderon@kywi.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
252	P-0251	SUQUILLO ANDRANGO MARCO VINICIO	04	1710201102001		2333920	Amaguaña Sincholagua S13-55	ms.distribuidores@hotmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
253	P-0252	TALLER DEL COLOR- SOCIEDAD CIVIL ANONIMA	04	0491523298001		062250680	9 de Octubre y Rafael Arellano	tallerdelcolor@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
254	P-0253	TARUPI ROMAN JAVIER ARMANDO	04	0401287354001		0999570991	Av. Veintimilla y Portugal	ferreteriaconstructor002@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
255	P-0254	TECHNET	04	0400919866001		2987-145	Pichincha N544 y Bolívar	facturacion.electronica@grupotechnet.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
256	P-0255	TERÁN CALDERON ROSITA ADELA 	04	1711932549001		062963071	Av. 24 de Mayo Barrio Ejido Norte	mjrt0399@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
257	P-0256	TEVCOL CIA. LTDA.	04	1790023885001		2599509	La Concepción, Av. La Prensa 3558	facturacion.recepta@tevcol.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
258	P-0257	TRACTO MANGUERAS CHILIQUINGA OÑATE IRMA	04	0400966859001		2985681	Cristo Rey Av. Veintimilla y Portugal	tractomangueras@gmail.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
260	P-0259	URDIALES & PAZMIÑO CONSULTORES	04	1792476410001		022266843	Pedro Bedón OE3-42 y Antonio de Ulloa	purdialesg@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
261	P-0260	VACA PORTILLA EDISON MAURICIO 	04	0401148465001		2982724	Calle 10 de Agosto entre Rafael Arellano	imprentaeditar12@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
262	P-0261	VALENCIA BURBANO JANETH ALEXANDRA	04	1002863585001		0985147975	Av. Atahualpa 19-65 	alexa.valenciab@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
263	P-0262	VALENCIA LÓPEZ ROSA MARGARITA	04	1705399093001		062981475	CALLE ATAHUALPA 6079 Y BOLÍVAR	mvalencia.cpk@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
264	P-0263	VALLEJO YEPEZ NELSON GERMAN	04	0400667184001		2961744	Cdla. San Carlos, Calle Medardo Angel S.	nelsovalle.14@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
265	P-0264	VASQUEZ REINO EDGAR - DICOMSA	04	0301536090001		0999248691	Jardines de Turubamba S60 26-83 y Calle	dicomsa_ecuador@yahoo.es	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
266	P-0265	VELASCO ROSERO EDGAR SIXTO	04	0400787008001		0997375770	Centro Tarqui s/n y Sucre	edgarintegracion@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
267	P-0266	TELLO ARTEAGA VICTOR HUGO- SERVICIOS Y COMERCIO	04	1700505835001		6003569	Agustín Guerrero S/N y Japón	vtserviciosycomercio@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
268	P-0267	VILLA VILLA JORGE GUSTAVO	04	0600927784001		097800500	Av. Veintimilla s/n y 24 de Mayo	jorge_gvv@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
269	P-0268	VILLAGOMEZ BUENAÑO SONIA MARLENE	04	0400769006001		0994278536	Bolívar y Pasaje Riobamba	sonivilla_04@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
270	P-0269	VILLOTA ACOSTA ELEN MERCEDES - EVA CLEAN	04	1719766808001		022080900	Urb. Club Los Chillos, Madroños Casa 2	evacleanfacturacion@gmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
271	P-0270	VIVEROS ENRIQUEZ SEGUNDO VICTORIANO	04	0400572012001		2986-468	Maldonado y Machala	segundoviveros@yahoo.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
273	P-0272	VULCANIZADORA VICENTICO 	04	0401553698001		0939653263	Oriente y Río Cenepa	luisviccosta@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
274	P-0273	YAMBAY VALLEJO HECTOR VLADIMIR	04	0401126867001		2960605	Roberto Sierra y Cuenca	hectyam82@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
275	P-0274	ZAMBRANO BAZURTO JUAN PABLO	04	1722516513001		0988940246	Calle Guillermo Wickman OE1-649 y A.	info@reyrey.com.ec	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
277	I-0001	Banco Central del Ecuador	04	1760002600001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
278	I-0002	Banco del Austro	04	0190055965001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
279	I-0003	JUNTA AGUA POTABLE MALDONADO	04	0491534453001		\N	Maldonado	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
280	I-0004	CONSEJO DE LA JUDICATURA CARCHI	04	0460016800001		062999300	Rafael Arellano 9-015 y Panamá	Karolina.Prado@funcionjudicial.gob.ec	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
281	I-0005	CONTRALORÍA GENERAL DEL ESTADO	04	1760002360001		\N	\N	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
282	I-0006	CUERPO DE BOMBEROS DE TULCAN	04	0460010360001		2960077	Av. Manabí s/n y Argentina	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
284	I-0008	DIRECCION GENERAL DE REGISTRO CIVIL	04	1768049390001		063814290	Av. Amazonas 1014 y Av. Naciones Unidas	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
285	I-0009	EPMAPA-T	04	0460028810001		2980-487	Juan Ramón Arellano y Bolívar	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
286	I-0010	GAD PQ RURAL URBINA	04	0460021050001		\N	Urbina	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
363	T-0006	Almeida Ruano Carlos Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
287	I-0011	GAD PQ. RURAL SANTA MARTHA DE CUBA	04	0460022370001		062967112	Santa Martha de Cuba	jpsmc01@gmail.com	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
288	I-0012	GAD PR de Maldonado	04	0460024660001			Maldonado		1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
289	I-0013	GAD MUNICIPAL DE TULCÁN	04	0460000210001		2980-400	Olmedo y 10 de Agosto	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
290	I-0014	JUNTA ADMINIS. AGUA POTABLE TUFIÑO	04	0491518782001		062222061	Barrio Vicente Ponce,Calle Gran Colombia	paito.puetate123@hotmail.com	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
291	I-0015	Servicio de Rentas Internas SRI	04	1760013210001		02298307	Av. Amazonas y Unión  Nacional  de Periodistas	\N	1	\N	\N	0	0	0	3	1	1	1	2020-01-21	\N	\N	0
292	E-0001	Aguilar Montenegro Wilmer Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
294	E-0003	Anticipos de Sueldos	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
295	E-0004	Asocia. AFEEPMAPA-T	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
296	E-0005	Asociación de Empleados GMT	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
297	E-0006	Bolaños Cadena Ximena Magaly	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
299	E-0008	SKLDFJWEÓP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
300	E-0009	Cárdenas Hermosa  Jefferson	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
301	E-0010	Castro Benavides Luis Humberto	05		0400800876	\N	JUAN RAMON ARELLANO Y BOLIVAR	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
302	E-0011	Cevallos Castillo Santiago Libardo	05		0401576822	062960077	Tulcán	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
303	E-0012	KDÑVGHDFÑ	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
304	E-0013	Chávez Endara Andrea Elizabeth	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
306	E-0015	Chugá Chávez Emilia del Socorro	04		0400709960	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
308	E-0017	L,AQ	04			2985-736	Bolívar s/n y Junín	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
309	E-0018	NBFGM, 	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
310	E-0019	MNMBV	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
311	E-0020	Farmacia Municipal Tulcán	04	0460035510001		2980-400	10 de Agosto s/n y Olmedo	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
312	E-0021	JOPOPHIO	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
315	E-0024	Higuera Rosero Milton Wladimir	04	0400999686001		0986043808	Los Cipres y Los Alamos Barrio El Bosque	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
318	E-0027	IESS	04	0460026440001		\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
320	E-0029	Póliza de Fidelidad	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	1
321	E-0030	Mercado Municipal (Comisariato)	04	0491503211001		2961089	Andrés Bello s/n  Las Tejerias	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
322	E-0031	VHI	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
323	E-0032	Mora Larrea Mónica Fernanda	05		0401377478	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
324	E-0033	Morillo Vacas Saida Gabriela	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
325	E-0034	Multas Personal EPMAPA-T	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
326	E-0035	Narváez Caicedo Nelson Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
327	E-0036	Narváez Martínez Martha América	05		0400968269	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
328	E-0037	Narváez Nazate Johana Gabriela	05		0401579958	\N	Tulcán	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
331	E-0040	Obando Sánchez Jackson Guillermo	05		0400871919	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
332	E-0041	OPG	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
333	E-0042	Ortega Estacio Amparo de Lourdes	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
334	E-0043	Ortega Montenegro Nuby Liliana	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
335	E-0044	Chávez Concha Juan Carlos	05		1724403371				1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
336	E-0002	Patronato Municipal	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
337	E-0014	Personal Admin Financiero LOSEP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
338	E-0016	Personal Administrativo Financ CODIGO TRAB	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
339	E-0022	Personal Alcantarillado  Sane LOSEP	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
340	E-0049	Perugachi Alvear Lenin Darío	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
341	E-0050	Perugachi Coral Joffre Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
345	E-0054	Puetate Pazmiño Pedro Edgardo	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
346	E-0055	Quezada Pozo Dario Javier	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
347	E-0056	Rodriguez Enríquez Nancy Lody	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
348	E-0057	Rosero Castillo Erika Tatiana	04		0401257191	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
350	E-0059	Sierra Osejos Yadira	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
351	E-0060	Sindicato EPMAPAT	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
353	E-0062	Tribunal de Menores Carchi	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
357	E-0066	Villarreal Martínez José René	04			\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
358	T-0001	Aguilar Arboleda Jhon Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
359	T-0002	Aguilar Guerrón Luis Arturo	05		0400598363	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
360	T-0003	Almeida Reina Edwin Miguel	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
361	T-0004	Almeida Ruano Marcelo Bayardo	05		0401233861	\N	Juan Ramón Arellano y Bolívar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
364	E-0140	Almeida Ruano Edison Fernando	05		0401369665	\N	\N	\N	1	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
365	T-0008	Arcos Perengüez Milton Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
366	T-0009	Ayala Hermosa Alvaro Mauricio	05		0401192950	\N	Juan Ramó Arellano y Bolívar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
367	T-0010	Benavides Canchala Anderson Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
368	T-0011	Benítez Tulcán Segundo Virgilio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
369	T-0012	Bernal Puetate José Alejandro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
370	T-0013	Cabezas Yanascual José Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
371	T-0014	Canacuan Tarapues José Kléver	05		0401255112	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
372	T-0015	Cando Pozo Segundo Fabián	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
373	T-0016	Cando Taquez Richard Santiago	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
374	T-0017	Cañar Viveros Luis Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
375	T-0018	Cardenas Obando Jorge Napoleon	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
376	T-0019	Chenás Paspuel Daniel Enrique	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
377	T-0020	Chenás Paspuel José Félix	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
378	T-0021	Chiles Paspuel Segundo Byron	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
379	T-0022	Chiles Ruano Luis Cirilo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
380	T-0023	Chiles Tarapués Julio César	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
381	T-0024	Chiles Villarreal Carlos Jonatan	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
382	T-0025	Chiles Yanascual Segundo Polivio 	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
383	T-0026	Chingal Ortega Ramiro Andrés	04		0401694906	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
384	T-0027	Cisneros Luis Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
385	T-0028	Cisneros Muñoz José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
386	T-0029	Coral Hernández Edmundo Vinicio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
387	T-0030	Cuases Pozo Marcelo Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
388	T-0031	Díaz Paucar Juan José	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
389	T-0032	Erazo Becerra Marlon Anibal	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
390	T-0033	Erazo Enríquez  Edison Darwin	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
391	T-0034	Yazan Reascos Carlos Orlando	05			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
392	T-0035	España Pozo Jonathan Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
393	T-0036	Estrada Reina Servio Libardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
394	T-0037	González González César Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
396	T-0039	Imbacuan Fuelagan José Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
397	T-0040	Imbacuán Malquín Segundo Salomón	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
398	T-0041	Ipial Paspuel Segundo Alirio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
399	T-0042	Lagos Arciniegas José Vicente	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
400	T-0043	Lima Calpa Jorge Hiraldo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
401	T-0044	Lima Quilismal Nixon Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
402	T-0045	López Chugá José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
403	T-0046	López Rosero José Luis	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
404	T-0047	Malte Tarapues Elsa Mariela	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
405	T-0048	Montenegro Narváez Edwin William	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
406	T-0049	Morillo Cuasquer José Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
407	T-0050	Muñoz Chávez Javier Soliz	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
408	T-0051	Narváez Salas Germán Bolívar	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
409	T-0052	Nasamuez Eche Luis Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
410	T-0053	Ortega Cuamacas Edgar Patricio	05		0401010228	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
411	T-0054	Ortega Cuamacas Iván Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
412	T-0055	Ortega Geovany Alejandro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
413	T-0056	Ortiz Pantoja Nelson Polivio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
414	T-0057	Paspuel Chiles Segundo Augusto	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
415	T-0058	Paspuel Paguay Luis Enrique	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
416	T-0059	Paspuel Paspuezán José Octaviano	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
417	T-0060	Paspuel Tarapués Daniel Alfonso	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
418	T-0061	Paspuel Tarapues Darwin Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
419	T-0062	Paspuezán Chiles Cesar Silvio	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
420	T-0063	Paspuezán Malte Kevin Junior	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
421	T-0064	Paspuezán Paspuel Manuel Mesías	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
422	T-0065	Pastas Erira Byron Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
423	T-0066	Pérez Huera Ramiro Ricardo	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
424	T-0067	Pérez Peñate Hanoi	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
425	T-0068	Personal de Julio Andrade	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
426	T-0069	Pizanan Enriquez Nelly Esperanza	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
427	T-0070	Portilla Cuaical José Gilberto	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
428	T-0071	Pozo Guerrón Jefferson Ramón	04	1003934872		\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
429	T-0072	Puetate Guel Julio César	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
430	T-0073	Puetate Paspuezán Enrique Byron	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
431	T-0074	Reina Martínez Segundo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
432	T-0075	Reyes Díaz Franklin Rubén	04	0401224316		\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
433	T-0076	Rojas Chicango José Segundo	05		0400574620	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
434	T-0077	Rosero Chamorro Luis Abraham	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
436	T-0079	Rosero Rosero Edgar Aníbal	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
437	T-0080	Ruano López Jaime Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
438	T-0081	Tarapues Tatamues Luis Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
439	T-0082	Tatamués Chiles Segundo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
440	T-0083	Tatamues de la Cruz Javier	05		0401235296	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
441	T-0084	Tatamues Paspuezán Alvaro Fernando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
442	T-0085	Tatamues Paspuezán Roberto Carlos	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
443	T-0086	Telag Pitacuar Juan Carlos	05		0401663513	\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
444	T-0087	Trejo Viteri Jhonatan Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
445	T-0088	Tubon Escobar Luis Eduardo	05		0401017470	\N	Juan Ramon Arellano y Bolivar	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
446	T-0089	Tupe Rosero Edwin Vladimir	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
447	T-0090	Valenzuela Charfuelán Bolívar	05		0400811014	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
448	T-0091	Villacorte Paucar Edwin Efrain	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
449	T-0092	Villagomez Paredes Raúl Armando	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
450	T-0093	Yar Vela Cristian Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
451	T-0094	Yépez Benalcázar José Miguel	04			\N	\N	\N	1	\N	\N	0	0	0	5	1	1	1	2020-01-21	\N	\N	0
453	D-0002	LUCERO ORBE MYRIAM DEL ROCIO	04	0400825139001		2983-766	La Y Av. Manabí  70054 y Argentina	mama_myrilum@hotmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
454	D-0003	MONTENEGRO CHAMORRO VICTOR EFREN	04	0400997391001		0993256764	Calle Jerónimo Carrión y Antonio Borrero	vicefm1973@gmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
456	D-0005	VIZCAINO ESCOBAR CRISTIAN NORMAN	04	0401746391001		0996963280	23 de Mayo s/n y 2 de Noviembre	crisvizcaino89@gmail.com	1	\N	\N	0	0	0	6	1	1	1	2020-01-21	\N	\N	0
459	G-0001	Agromundo SC	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
460	G-0002	Almeida Luis Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
461	G-0003	Alvarez Alvarez Nilo Felipe	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
462	G-0004	Alvarez Salazar Carlos Edison	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
463	G-0005	Arcos Reina Silvio Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
464	G-0006	Arellano Carranco Luis Ramiro.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
465	G-0007	Arellano Velasco Jaime Rodrigo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
466	G-0008	Artega Vilaña Jesús Homero	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
467	G-0009	Artiaga Paredes Verónica Marlene	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
468	G-0010	Ayala Matute Luz María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
469	G-0011	Bolaños López Laura María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
470	G-0012	Bolaños Yandún Luis René	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
471	G-0013	Burbano Mafla Galo Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
472	G-0014	Bustillos Barragan Germán Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
473	G-0015	Cadena Ayala Ana Lidia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
474	G-0016	Cadena Mier Sandra Zulay.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
475	G-0017	Caicedo Rosero Cesar Roberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
476	G-0018	Caiño Lamar Vicenta	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
477	G-0019	Campo Flores Andrés	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
478	G-0020	Cando Enríquez Nelson Raúl.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
479	G-0021	Carpio Vega Liliana Cecilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
480	G-0022	Castillo Quiroz Dila Piedad	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
481	G-0023	Castillo Vallejo Marcia Elena	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
482	G-0024	Castro Cando Isabel Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
483	G-0025	Chamorro Reyes Omar Wilfrido	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
484	G-0026	Changuan Enríquez Lilia del Rocio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
485	G-0027	Chicango Segundo Homero	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
486	G-0028	Chisaguano Chisaguano Josefina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
487	G-0029	Chugá Coral Mónica Alexandra	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
488	G-0030	Chugá Martínez Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
489	G-0031	Cisneros García Alfredo Migue	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
490	G-0032	Compañia de Taxis Ejecutivos C.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
491	G-0033	Coop. ahorro y Cred. Educadores	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
492	G-0034	Coral Rivera Wilmer Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
493	G-0035	Coral Rosero Bernardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
494	G-0036	Coral Tapia Laureano Joel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
495	G-0037	Cordova Bertha Josefina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
496	G-0038	Cordova Pantoja Inocencio Elie	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
497	G-0039	Criollo Nazate Janneth Cecilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
498	G-0040	Cuadros Zambrano Norma Amada	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
499	G-0041	Cuaical  Iñiguez Ana Lucia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
500	G-0042	Culqui Pujos Angel Patricio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
501	G-0043	Curia de Tulcán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
502	G-0044	De La Torre Caceres Luis Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
505	G-0047	Direccion Provincial de la Judicatura	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
506	G-0048	Enríquez Enríquez María Elizabeth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
507	G-0049	Enríquez Ríos Yolanda del Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
508	G-0050	Erazo Díaz Digna del Rocío	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
509	G-0051	Erazo López Byron Javier.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
510	G-0052	Erazo Prado Carmelina Garista	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
511	G-0053	Estupiñan Jimenez Elina Magali	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
512	G-0054	Fernandez Lamar Pedro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
513	G-0055	Figueroa Enríquez Franklin Sigifredo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
514	G-0056	Flores Cuasatar Jorge Arturo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
515	G-0057	Fuel Checa Rodrigo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
516	G-0058	Fuel Gómez Milton Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
517	G-0059	Gaón Pozo Fidelia OTilia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
518	G-0060	Gonzáles Escobar Nora Catalina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
519	G-0061	Guacales Carvajal Edison Darwin	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
520	G-0062	Guacales Efraín Aucimiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
521	G-0063	Guaraca Vimos Delia María	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
522	G-0064	Guerra Paucar Olga Guadalupe	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
523	G-0065	Guerrero Enríquez Rosario Del	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
524	G-0066	Guerrero Obando Jorge Bayardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
525	G-0067	Guerrero Peñafiel Martha Nel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
526	G-0068	Guerrón Araujo Byron Ramiro	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
527	G-0069	Herrera Enríquez José Guillermo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
528	G-0070	Herrera Enríquez Segundo Jor	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
529	G-0071	Herrera Martínez Jefferson Paúl	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
530	G-0072	Herrera Narváez Nancy Cristina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
531	G-0073	Huera Narváez Luis Alexander	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
532	G-0074	Hurtado Armas Jorge Aníbal	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
533	G-0075	Imbacuan Fuertes Elvia Janneth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
534	G-0076	Imbacuan Pereguez María Flora	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
535	G-0077	Imbaquingo Ortiz Luis Alfredo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
536	G-0078	Jativa Gonzalo Gerardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
537	G-0079	Landazuri Cordova Iván Oswaldo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
538	G-0080	Landázuri Rosero Yolanda Isabel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
539	G-0081	Lucero Lima Irene	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
540	G-0082	Lucero Revelo Sandra Margarita	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
541	G-0083	Mafla Majía Arquimides Patricio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
542	G-0084	Mallama Chapi José Raúl	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
543	G-0085	Manguay Puetate Alberto Olmedo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
544	G-0086	Manosalva Pineda Saúl Marcelo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
545	G-0087	Mejía Navisoy Rolando Germán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
546	G-0088	Montalvo Enríquez Blanca Ismeria	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
547	G-0089	Montenegro Gómez Mary Margoth	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
548	G-0090	Montenegro Larrea Hector Olmedo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
549	G-0091	Narváez Orbe Miguel Angel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
550	G-0092	Narváez Villagomez Luis Edison	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
551	G-0093	Nazate Fuel José Daniel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
552	G-0094	Nazate Paucar Mary Patricia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
553	G-0095	Olmedo Auz Danny Enríque	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
554	G-0096	Orbe Cadena Olmedo Gustavo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
555	G-0097	Ortega Chamorro Ana Paola|	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
556	G-0098	Ortega Pedro Orlando	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
557	G-0099	Osejo Becerra Tarcicio Renán	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
558	G-0100	Palate Criolla Víctor Hugo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
559	G-0101	Pintado Mora Alex Manolo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
560	G-0102	Ponce Benavides Enma Lucía.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
561	G-0103	Portilla Mejía Carlos Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
562	G-0104	Portilla Pozo María Romina	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
563	G-0105	Pozo Enríquez Jaime Hernán.	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
564	G-0106	Quistanchala Yandar Jefferson Fernando|	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
565	G-0107	Reascos Quelal Olimpo Gustavo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
566	G-0108	Revelo Ascuntar Ana Zulay	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
567	G-0109	Revelo Ayala Hermógenes Marino	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
568	G-0110	Rodríquez Huaca María Matilde	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
569	G-0111	Rosero Loor Vicente Efraín	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
570	G-0112	Rosero Morán William Bayardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
571	G-0113	Ruíz Palacios Hilda Beatriz	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
572	G-0114	Ruíz Pule Arnulfo Joselito	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
573	G-0115	Salazar Burbano Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
574	G-0116	Santillan Males Julio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
575	G-0117	Serrano Martha Lucia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
576	G-0118	Servicio Integrado de Seguridad ECU 911	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
577	G-0119	Sindicato de Choferes	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
578	G-0120	Sisa José Manuel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
579	G-0121	Tapia Reina Miguel Ángel	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
580	G-0122	Tashiguano Arisa Carolina Estefanía	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
581	G-0123	Tatés Fernandez José Antonio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
582	G-0124	Tepud cuasquer Edwin Fredy	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
583	G-0125	Terán Maldonado Rosa Elena	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
584	G-0126	Tigsi Yanza Juan Vinicio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
585	G-0127	Tucanes Narváez Anayss del	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
586	G-0128	Tulcanez Tapia Carmita del Pilar	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
587	P-0445	USIÑA LOMAS JHERSSON ANDRÉS- PAPELERÍA CARCHI	04	0401437934001		0963526351	Av. Seminario y Camilo Ponce	papeleria.carchi@hotmail.com	1	\N	\N	0	0	0	1	1	1	1	2020-01-21	\N	\N	0
588	G-0130	Vallejo Aguirre Ramiro Eduardo	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
589	G-0131	Vallejo Dorado Edwin Jhobani	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
590	G-0132	Vallejo Yépez Edwin Fabián	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
591	G-0133	Vásquez Andrade Rosalía del Pilar	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
592	G-0134	Vasquez Rodriguez Sergio	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
593	G-0135	Velasquez Perugachi Francisco	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
594	G-0136	Velasquez Velasquez Alberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
595	G-0137	Villarreal Chamorro Diana Katarine	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
596	G-0138	Villarreal Hernández Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
597	G-0139	Vinueza Bastidas Luis	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
598	G-0140	Zabala Rosero Judith Alicia	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
599	G-0141	Zambrano Montufar Camilo Adalberto	04			\N	\N	\N	1	\N	\N	0	0	0	8	1	1	1	2020-01-21	\N	\N	0
600	E-0067	MENESES ENRIQUEZ MARITZA CRISTINA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-21	\N	\N	0
601	E-0068	Gudino Cadena Richard Omar	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-22	\N	\N	0
602	E-0069	Ruales Calpa Saul Armando	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-01-22	\N	\N	0
603	C-0001	CLIENTE FINAL	04			\N	Tulcán	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-01-22	\N	\N	1
604	T-0095	Luna Chalacan Derek Leonardo	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-01-23	\N	\N	0
605	P-0275	HUERA LOPEZ ALDRIN ROBERTO	04	1002344784001		0993760911	Av. San Francisco s/n y Uruguay	tatyroserodome@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-01-31	\N	\N	0
606	T-0096	Malte Chenas Leonardo Fabio	05		0401847603	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-03	\N	\N	0
607	T-0097	Tatamuez Paspuezan Luis Arturo	05		0400636494	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-03	\N	\N	0
608	E-0007	Personal de Agua Potable Come LOSEP	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
609	E-0023	Personal de Agua Pota y comerc CODIGO TRAB	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
610	E-0025	Personal Alcantarillado y Sanea CODIGO TRAB	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
611	E-0026	Personal de Jubilados Agua P y Alcant 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-06	\N	\N	0
612	P-0003	CHOGLLO SIGUENCIA MARIO FABIAN	04	0103898896001		074199040	Pasaje 24 4 y Av. 24 de Mayo	mariofchogllo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-02-14	\N	\N	0
613	T-0005	Piarpuezan Mipaz Francisco Germán	05		0401113246	\N	Juan Ramón Arellano y Bolívar	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-02-17	\N	\N	0
614	E-0028	mnv	05		0401193636	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-17	\N	\N	0
615	E-0038	Hernandez Villa Francis Gabriel	05		0401233259	\N	\N	vflooy@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2020-02-27	\N	\N	0
616	I-0016	GAD PROVINCIAL DEL CARCHI	04	0460000130001		062980302	10 de Agosto y Sucre 	info@carchi.gob.ec	\N	\N	\N	0	0	0	3	1	1	1	2020-02-27	\N	\N	0
617	P-0008	CELTEL CONSTRUCCIONES Y SERVICIOS CIA. LTDA.	04	1791826698001		022279410	Luis Coloma N44-196 y Av. El Inca	pagos@celtelecuador.com	\N	\N	\N	0	0	0	1	1	1	1	2020-02-27	\N	\N	0
618	E-0070	Robles Yèpez Paola	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-02-28	\N	\N	0
620	C-0002	PAVON PORTILLA CARMITA DEL ROCIO	05		0400640124	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-03-05	\N	\N	0
621	P-0276	PILATASIG GERMAN NELSON MODESTO	04	0501695654001		0985812292	OTAVALO ECUADOR	german.pilatasig@hotmail.com	2	2202171729	\N	0	0	0	1	74	1	1	2020-03-09	\N	\N	0
622	P-0277	SEGOVIA MAYA RIBADENEIRA SEMAYARI CIA LTDA.	04	0590031801001		0999735498	Av. Eloy Alfaro 24-74 y Av. 5 de Junio	facturacion@semayari.com	1	3140462604	\N	0	0	0	1	74	1	1	2020-03-09	\N	\N	0
623	P-0278	COMERCIOS Y AFINES DEL NORTE COYANOR S.A	04	1091720821001		062957404	Panamericana Norte Km 1	coyanor.electronica@gmail.com	1	0018231190	\N	0	0	0	1	15	1	1	2020-03-10	\N	\N	0
624	T-0098	CHENAS PASPUEL SEGUNDO OLMEDO 	05		0400935698	\N	TUFIÑO	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-03-10	\N	\N	0
625	T-0099	Orbe Miguel Angel	05		0400485272	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2020-03-11	\N	\N	0
626	P-0279	INFINITY FM RADIO RADINFINTY S.A -RADIO AMERICA	04	1792483700001		062984411	Olmedo S/N y Ayacucho	radioamerica89.7mhz@americaestereo.com	1	7944241	\N	0	0	0	1	1	1	1	2020-03-12	\N	\N	0
627	P-0280	CENTRO AUTOMOTRIZ GUSTAVO MOYA BACA CIA LTDA	04	1790029131001		022236246	Queseras del Medio E11-123	pramirez@moyabaca.com.ec	1	3019761704	\N	0	0	0	1	74	1	1	2020-03-12	\N	\N	0
628	P-0281	Alvear Guerrero Angela Gabriela	04	0401638903001		2960951	Panamá y Manabí 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-03-13	\N	\N	0
629	E-0039	Pozo Castillo Livia Amparo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-03-17	\N	\N	0
630	P-0282	MORENO VILLARREAL JIMMY BAYARDO	04	0401356589001		0995951836	Tarqui s/n y Sucre	mvjmv@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-04-21	\N	\N	0
631	P-0283	Imbaquingo Andrade Carlos Amilio 	04	0400936704001		0994585380	Av. Vicentenario y Juan Ramón Arellano	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-04-28	\N	\N	0
632	P-0284	ALTO VOLTAJE	04	1002534855001		065000745	Sanchez y Cifuentes 15-27 y Zenon Villacis	altovoltajeibarra@hotmail.com	1	1002534855	\N	0	0	0	1	6	1	1	2020-05-12	\N	\N	0
633	P-0285	LUCERO LUCERO EDISON RAMIRO	04	0400747655001		062242112	Barrio el Rosal Av. Brasil	ramiroautentico@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-05-28	\N	\N	0
634	P-0286	RAMIREZ FLORES NEURIO EUTIMIO	04	0400142006001		2637202	Garcia Moreno 7-33 y Julio Andrade	cantera.ramirez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-06-04	\N	\N	0
635	E-0072	GHUGA HERRERA BRAYAN ANDRES	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-06-05	\N	\N	0
636	E-0073	CHUGA HERRERA BRAYAN ANDRES	05		0401542261	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-06-05	\N	\N	0
637	P-0287	GUAMINGA TACO KATHERINE YESENIA	04	1722126826001		0997349456	Pasaje A lote 10 y de los Rieles 	gygsuministros@outlook.es	\N	\N	\N	0	0	0	1	1	1	1	2020-06-11	\N	\N	0
638	P-0288	CAZARES MORALES ROBINSON SEBASTIAN	04	1004000152001		0980237920	Calle Ibarra 7-51 y Santa Isabel	robsoncaz1998@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-07-08	\N	\N	0
640	C-0003	MEJIA TAPIA KARLA MISHELLE-IMÁGEN GLOBAL	04	1723475073001		0995119929	Avda. Veintimilla y Portugal 	kamis1988@hotmail.com	2	2202449916	\N	0	0	0	2	74	1	1	2020-08-04	\N	\N	0
641	C-0004	CISNEROS GUERRÓN MAURICIO JAVIER	04	0400945325001		0988863232	Avda. Coral y Brasil	maodl07@hotmail.com	1	0029806233	\N	0	0	0	2	15	1	1	2020-08-05	\N	\N	0
642	C-0005	FERRICONSTRUCTOR- CANO MONTENEGRO ANDREA	04	0401580733001		0999069591	CALLE ARGENTINA Y CUENCA 	\N	\N	\N	\N	0	0	0	2	1	1	1	2020-08-11	\N	\N	0
643	E-0074	PUETATE PASPUEZAN LUIS ORLANDO	05		0400666319	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-08-14	\N	\N	0
644	C-0006	TORNIPERNO- ROCIO DEL CARMEN GARCÍA PRADO 	04	0400604930001		062981852	Bolívar y Rocafuerte 	torniperno.info@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2020-08-19	\N	\N	0
645	E-0075	RUANO PUETATE CESAR ANTONIO 	05		0400694238	\N	\N	cesaruano1965@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2020-08-25	\N	\N	0
646	P-0290	MEJIA PEÑAFIEL CECILIA  JULIA 	04	0400561213001		2250690	9 DE OCTUBRE Y RAFAEL ARELLANO 	tallerdelcolor@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-04	\N	\N	0
647	P-0291	VALDIVIESO REINOSO WALKER BOLIVAR 	04	0400428793001		0992856179	Atahualpa 56076 y Bolivar 	andres83narvaez@hotmail.com	1	3112893604	\N	0	0	0	1	74	1	1	2020-09-09	\N	\N	0
648	E-0076	OBANDO MOSQUERA DANIEL ALEJANDRO	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-09-17	\N	\N	0
649	I-0017	BANCO DE DESARROLLO DEL ECUADOR 	04			\N	QUITO 	\N	1	\N	\N	0	0	0	3	1	1	1	2020-09-22	\N	\N	0
650	E-0077	TIPAZ LÓPEZ GALO ANÍBAL	05		0400699500	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-09-23	\N	\N	0
651	P-0292	GRANDA CUENCA BYRON FERNANDO 	04	1718181553001		2396259	Reino de Quito s/n y Catequilla	byron_475@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-28	\N	\N	0
652	P-0293	FUNDIRECICLAR  S.A	04	1791741897001		2825085	Calle 25 de Noviembre N4-363 Y Calle 1	fchavez@ceimec.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-09-28	\N	\N	0
789	E-0117	ROSA ELENA BENAVIDES BELALCÁZAR	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-24	\N	\N	0
653	P-0294	VERONICA VERENICE CAMPOVERDE TULCAN 	04	1712125416001		0986308859	JOSE LOPEZ S N Y MEJIA 	veronica.verenice@hotmail.com	5		\N	0	0	0	1	1	1	1	2020-09-29	\N	\N	0
654	P-0295	NARVAEZ LOPEZ BYRON HORACIO 	04	0400784161001		0962809313	AV. UNIVERSITARIA 25 Y AV. VEINTIMILLA	byronarlop@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2020-09-29	\N	\N	0
655	P-0296	MORENO VILLARREAL NATHALY ROSARIO 	04	0401636030001		0990242012	Quito y Olmedo Tulcán	nathymoreno@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-16	\N	\N	0
656	P-0297	CONFECCIONES CRISMA SPORT	04	0401199377001		0986621501	Olmedo 47-052 y 9 de Octubre	franklin.gustavo.yambay.@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-16	\N	\N	0
657	P-0298	CENTRO DE REPUESTOS JAPONES 	04	0400723490001		062982667	Bolivar s/n entre Rocafuerte y Pichincha 	crburbano@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2020-10-20	\N	\N	0
658	E-0078	Flores Vinueza Silvia Janeth 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-10-23	\N	\N	0
659	P-0299	PORTILLA MUEPAZ NELSON BLADIMIRO 	04	0401290531001		0997584350	Calle Colon s/n y Pichincha 	nelson.portilla@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
660	P-0300	PATY JANET 	04	0400635637001		0981338188	Barrio Centro Calle Bolivar 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
661	P-0301	BAZAR MERICITA 	04	0400685525001		0991512541	Boyaca 73 y Bolivar 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-05	\N	\N	0
662	P-0302	GOLDEN PUBLICITY	04	0401419924001		0987370604	AV. Veintimilla  y México	jhony_jf@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-11-11	\N	\N	0
663	P-0303	AGROAVILAB S.A 	04	0992716029001		3902603	Durán Km3.5 via Durán Tambo 	facturaelectronicaagroavilab@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-19	\N	\N	0
664	P-0304	ANDRES RAFAEL SOSA	04	1722432265001		023199028	CALLE R1 LT 18 Y CALLE R2 	netoyage96@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-11-26	\N	\N	0
666	E-0045	Goyes Puetate Clemente Bayardo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-12-01	\N	\N	0
667	E-0080	Yohanna Cadena 	05			222206977	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2020-12-02	\N	\N	0
668	P-0305	GARCÍA PUEDMAG CARMEN LILIANA 	04	0401595996001		0982826708	Roberto Andrade 22 y Carlos Oña 	gliliana014@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-03	\N	\N	0
669	P-0306	MARTINEZ POZO LUIS RAMIRO 	04	0400632592001		062290833	Bario Jardin del Norte calle Fraylejones y los Cei	ramisand@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-12-11	\N	\N	0
670	P-0307	YUNGA VILLA ALFONSO MARIA 	04	0101055762001		0987555942	Villlalobos SN y Panamericana sur 	contabilidad@pantanero.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-14	\N	\N	0
671	P-0308	BURI CARAGUAY VICTOR EMILIO	04	1708525678001		022075466	PONCE ENRIQUEZ LOTE 1 Y GARCIA MORENO 	contabilidad@kleiner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
672	P-0309	ASTAP CIA LTDA.	04	1790027740001		022262154	Av. Naciones Unidas 1084 y Av. Amazonas 	ariday1209@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
673	P-0310	CONSTRUCPIEDRA  CONSTRUCTORES	04	1791298594001		022554579	La niña E4-438 Y AMAZONAS	contabilidad@construpiedra.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
674	P-0311	NARVAEZ TERREROS BLANCA NOEMI (SINAMERT) 	04	0102664760001		2802994	Jaime Roldos 4-22 y Huayna - Capac 	sinaseg1@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-15	\N	\N	0
675	P-0312	UNION CEMENTERA NACIONAL UCEM S A	04	1792470293001		032998800	Panamericana Sur Km 14	pcarvajal@ucem.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2020-12-16	\N	\N	0
676	P-0313	LAGUNA RODRIGUEZ ESTEPHANY DAYANNA	04	0401505821001		0985597300	Juan Montalvo y 19 de Noviembre	estedayslag@live.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-16	\N	\N	0
678	P-0314	SANCHEZ VENEGAS GEOVANY SERAFIN 	04	1002440822001		062933331	Simón Bolívar 4-57 Tanguarín 	geovanyssanchez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2020-12-21	\N	\N	0
679	E-0081	AROCA RIVADENEIRA LUIS ANDRÉS 	04			\N	\N	andruaroca@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2021-01-19	\N	\N	0
680	T-0100	PUETATE PASPUEZAN JOSE PEDRO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-19	\N	\N	0
681	T-0101	CHILES YANASCUAL GERMÁN 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-19	\N	\N	0
682	P-0315	NARVÁEZ JARAMILLO EDELER FRANCISCO 	04	0401147327001		\N	EL carmelo 	\N	\N	\N	\N	0	0	0	1	1	1	1	2021-01-21	\N	\N	0
683	P-0316	MINISTERIO DE TRANSPORTE  OBRAS PÚBLICAS DEL CARCHI 	04	0460012570001		062980482	AV. Veintimilla frente Comercial Hidrobo	\N	1	3001041703	\N	0	0	0	1	71	1	1	2021-01-22	\N	\N	0
684	E-0082	PUETATE CAIPE ERIKA PAOLA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-27	\N	\N	0
685	E-0083	DELGADO MONTENEGRO NORALBA	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-27	\N	\N	0
686	P-0317	HORMIGONES  DEL NORTE S.C.C	04	1792811082001		062511739	Calle Los Galeanos No. 328	anaga_54@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-01-28	\N	\N	0
687	E-0084	Bolaños Ipial Ana Magali	05		0401470927	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-01-28	\N	\N	0
688	T-0102	Cadena Arcos Henry Javier	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-28	\N	\N	0
689	P-0318	Rodriguez Rosero Narciza Germania	04	0401107206001		062982035	Sucre y Tarqui	aguilaimportacionestulcan@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-01-28	\N	\N	0
690	T-0103	Naranjo Tulcanaza Segundo Edmundo	05		0400831715	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-01-29	\N	\N	0
691	P-0319	Ibarra Cárdenas Zaidy Susana	04	0401340062001		0997010493	Av. Coral 62091 y Paraguay	zaidyibarra77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-01	\N	\N	0
692	P-0320	TALLER FERRO MADERA TACAN TUCANEZ ANIBAL	04	0400664454001		062245152	La Libertad 12 y la Concordia	anibal02051956@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-01	\N	\N	0
693	P-0321	MAFLA MARTINEZ ALEXANDRA PATRICIA 	04	0401545314001		0983435319	Guillermo Burbano 10y cabo Minacho	alexpmaflam@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-02	\N	\N	0
694	P-0322	BAGANT ECUATORIANA CIA LTDA	04	1790322491001		0986106580	Av Alfonso Moncayo y Panamericana Norte	machucaj@bagant.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-03	\N	\N	0
695	T-0104	Fuel Tulcanaza Alvaro Mauricio	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-02-05	\N	\N	0
696	P-0323	HIDROCENTRO CIA.LTDA  	04	1791248147001		2336166	Troncal E 35 Sin Transversal 	contabilidad@hidrocentro.net	\N	\N	\N	0	0	0	1	1	1	1	2021-02-08	\N	\N	0
697	P-0324	PASPUEL BASTIDAS LUIS ALBERTO 	04	0400646865001		022021588	14-15 y Av. Atahualpa 	lapaspuel@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-02-10	\N	\N	0
698	P-0325	SANIGROUP	04	2390014891001		09993373761	Matriz KM 3 via a Quito 	contabilidadsanigroup@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
699	P-0326	MEDINA ABRIL VANESSA MISHELL	04	1803190014001		0998597196	Ambato - Ecuador 	medina.industrias@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
700	P-0327	TARUPÍ ROSERO JUAN CARLOS 	04	0401333117001		0988708407	Av. Tulcanaza y Portugal 	juanca_14@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-03-05	\N	\N	0
701	P-0328	NORTVISIÓN 	04	0400731345001		062981387	Guayaquil 9034 y Manabí 	anaidgm@live.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-08	\N	\N	0
702	P-0329	REYES MUILEMA CARLOS ARTURO - AUTOMASIS	04	1712051760001		0996136564	Calle Alfredo Baquerizo Moreno y Pablo Palacio 	automasis@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-03-15	\N	\N	0
703	P-0330	BIOTOWER S.A 	04	1793028020001		0989763341	Pichincha Quito la Concepción 	facturas@biotower.net	\N	\N	\N	0	0	0	1	1	1	1	2021-03-24	\N	\N	0
704	P-0331	MARTINEZ PERDOMO JAIRO FABIAN 	04	0491526696001		0962614139	Av. Manabi y Paraguay 	produccion1factory@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-03-29	\N	\N	0
705	P-0332	CHANG AURIA VICTOR GUIDO 	04	0906466263001		042285163	Guayaquil Cuidadela Santa Leonor 	ceniferreecuador@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-04-14	\N	\N	0
706	I-0018	GAD Municipal San Pedro de Huaca	05			\N	Huaca 0460001020001		\N	\N	\N	0	0	0	3	1	1	1	2021-04-14	\N	\N	0
707	P-0333	ELIANA XIMENA CHAMPUTIZ ORDOÑEZ 	04	0401149026001		0987762753	Av. Universitaria y Ventimilla 	pakarinachamputiz@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-04-26	\N	\N	0
708	E-0085	ACOSTA PEREZ JEFFERSON ALEJANDRO	05		0402004410	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
709	E-0086	PAGUAY PASPUEL GABRIELA ELIZABETH	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
710	E-0087	DE LA CRUZ PAILLACHO DAMIAN ISRAEL 	05		0402004055	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
711	E-0088	GUEVARA LLORE MAURICIO SAMUEL 	05		0450176581	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
712	E-0089	LUCERO ESTRADA STALIN SEBASTIAN 	05		0402121347	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
713	E-0090	LUCERO SOLIS LUIS HUMBERTO 	05		0400990438	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
714	E-0091	LUMAÑA MORILLO MANUEL ANTONIO 	05		0400616454	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
715	E-0092	MORENO MORENO HUGO ARCESIO 	05		0401003512	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
716	E-0093	NARVAEZ MONTENEGRO EDWIN HOMERO 	05		0400698692	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
717	E-0094	PAILLACHO PEREZ JHONATAN ALEXIS 	05		0401904651	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
718	E-0095	PROAÑO CADENA JOSE LUIS 	05		0401062187	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
719	E-0096	PROAÑO JIMENEZ EDWIN MARCELO 	05		0400774535	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
720	E-0097	PROAÑO JIMENEZ JOSE LUIS 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
721	E-0098	PUETATE YAR ROBINSON ANDRES 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
722	P-0415	ROMO ARELLANO SEGUNDO VINICIO 	04	0400987814001		0997770356	Tulcán	viniromo2271@gmail.com	2	401110137525	\N	0	0	0	1	68	1	1	2021-04-28	\N	\N	0
723	E-0100	SIERRA ORTEGA JONATHAN ALEXANDER 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
724	E-0101	TATES PAILLACHO JONATHAN ISRAEL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
725	E-0102	TUNUBALA YALANDA ARCENIO VINICIO 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
726	E-0103	YAR PUETATE WILLAN ANIBAL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
727	E-0104	NARVAEZ PROAÑO EDWIN GEOVANNY	05		0401606439	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
728	E-0105	PERSONAL DEL PROYECTO DEL SISTEMA DE AGUA POTABLE JULIO ANDRADE 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-04-28	\N	\N	0
729	P-0334	FUNDIMETALES DEL NORTE LOPEZ MARTINEZ JOSE ALIRIO 	04	0401563812001		0983416844	AV. Brasil y Panama 	fundimetalesdelnorte@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-05	\N	\N	0
730	P-0335	BASTIDAS LEÓN ANTONIO ESGARDO ( MULTICARPAS COLOMBIA) 	04	1757098247001		0997373375	Av. 24 de mayo y 26 de mayo 	multicarpascolombia@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-05	\N	\N	0
731	P-0336	Almeida Villarreal Cristhian Ricardo 	04	0401456777001		2960951	Via interoceánica Sta Rosa 	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-11	\N	\N	0
732	P-0337	NAVISOY REYES WILMER FERNANDO 	04	0400884755001		0986169051	Av. Universitaria y Antisana	fernandonavisoy@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-11	\N	\N	0
733	P-0338	PAUCAR ALMEIDA MONICA PAULINA -ADMON DISTRIBUCIONES	04	1713823365001		022603902	R1 LOTE 18 Y CALLE R2 	admon_distribuidores@hotmail.com	1	7536941	\N	0	0	0	1	16	1	1	2021-05-13	\N	\N	0
734	C-0007	LIMA ROJAS LOURDES GUADALUOE	05		0400453999	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2021-05-14	\N	\N	0
735	P-0339	AGROVENTAS RIEGO 	04	1792879698001		0997582673	Eloy Alfaro N30 -166 Y Av. Amazonas 	facturacion@agroventasriego.com	\N	\N	\N	0	0	0	1	1	1	1	2021-05-18	\N	\N	0
736	I-0019	GAD. PARROQUIAL RURAL PIOTER	04	0460024900001		\N	\N	\N	\N	\N	\N	0	0	0	3	1	1	1	2021-05-19	\N	\N	0
737	P-0340	TEXTIQUIM CIA. LTDA. 	04	1790824977001		022478062	VICENTE DUQUE N77-443 Y JUAN DE SELIS	prosania@textiquim.com	1	01019923247	\N	0	0	0	1	6	1	1	2021-05-26	\N	\N	0
738	P-0341	EDICIONES LEGALES EDLE SA 	04	1790924491001		022480800	Los Cipres y los Eucaliptos  	carterauio@corpmyl.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-07	\N	\N	0
739	P-0342	SEGURA BASTIDAS MARCO ANTONIO 	04	1711384451001		0997864160	Los Pinos y Giovani calles 	msegura@retgei.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-07	\N	\N	0
740	E-0106	JORGE CUMBAL 	04			\N	\N		\N	\N	\N	0	0	0	4	1	1	1	2021-06-11	\N	\N	0
741	C-0008	Cisneros Martínez Martha Guadalupe	05		0401089933	\N	Beker y Acuña San Miguel Norte	ns@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2021-06-14	\N	\N	0
742	C-0009	Cadena Quelal Geanette Arcelia	05		0400763975	2985352	Los Ceibos y Los Canelos	ns@gmail.com	\N	\N	\N	0	0	0	2	1	1	1	2021-06-14	\N	\N	0
743	P-0343	METALECTRI CIA. LTDA 	04	1792617073001		022828413	Quito calles Macana y Chasqui 	compraspublicas@metalectri.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-14	\N	\N	0
744	P-0344	EQUIPOS SUMINISTROS MANTENIMIENTO ESUMAN CIA LTDA 	04	1791122844001		0999741946	Nazcota puento Oe2-237 y av. Real Audiencia 	info@esuman.com	\N	\N	\N	0	0	0	1	1	1	1	2021-06-17	\N	\N	0
745	T-0105	TULCÁN ALMEIDA DIEGO FERNANDO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-08	\N	\N	0
746	E-0107	TULCÁN ALMEIDA JOHN JAIRO 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-07-08	\N	\N	0
747	T-0106	TULCÁN ALMEIDA LUIS ABERTO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-08	\N	\N	0
748	P-0345	PORTILLA MARTÍNEZ ARTEMIO CAMPOS 	04	0400585097001		0985584981	Calle Camilo Ponce y Santa Teresita	artemiocampos@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2021-07-13	\N	\N	0
749	E-0108	VINICIO ROLDÁN 	04	1001561453001		0999193608	Ibarra	vinicioroldan@hotmail.com	\N	\N	\N	0	0	0	4	1	1	1	2021-07-21	\N	\N	0
750	T-0107	Paguay Escobar Segundo Polibio 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-23	\N	\N	0
751	T-0108	Guel Paguay Segundo Jesus 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-07-23	\N	\N	0
752	E-0109	Marcillo Ramos Johanna Paola	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-07-29	\N	\N	0
753	P-0346	TRANSPORTE FUENTES LANDAZURI S.A 	04	0491513837001		2973608	Via  a Santa Marta de Cuba 	jonatani@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2021-08-04	\N	\N	0
754	E-0110	QUIMBIULCO PAILACHO ANDRÉS MEDARDO	05		0401884788	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-05	\N	\N	0
755	E-0111	ALTAMIRANO PINCHAO LEONARDO FABIO 	05		0401350269	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-05	\N	\N	0
756	E-0112	TOBAR ESPINOZA LUIS FERNANDO.	05		0400722773	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-11	\N	\N	0
757	E-0113	Oña Alquinga Edwin Rosendo 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-08-18	\N	\N	0
758	P-0347	SU FARMACIA INMACULADA	04	1792556309001		062962019	Av. America N31-42 Y PSJE San Gabriel  	sufarmaciainmaculada@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2021-08-23	\N	\N	0
759	C-0010	ERAZO BRAVO ALFONSO RENE	05		0400658027	\N	\N	\N	\N	\N	\N	0	0	0	2	1	1	1	2021-08-30	\N	\N	0
760	P-0348	Roldan Ramirez Edwin Roberto 	04	1803843638001		0979140179	Calle Carlos Contreras 	otrebordanrez@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-03	\N	\N	0
761	P-0349	Estrada Lima Yasmin Dayana 	04	0401858972001		0960239999	Panamá y Maldonado 	ydestrada1995@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-03	\N	\N	0
762	P-0350	MEMKADISH SA 	04	1792324556001		0997777663	Pedro Moncayo 2-67 y Pedro Vicente Maldonado 	dres@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-08	\N	\N	0
763	P-0351	ASIMBAYA NASIMBA JOHANNA TATIANA 	04	1712677218001		0995762807	Valle Hermoso, Autopista los Chillos 	jotasim01@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-09	\N	\N	0
764	P-0352	GUERRA CRUZ DIANA ALEXANDRA 	04	1721714424001		022835892	Antonio Astudillo y Pedro Bedon 	facturacioninsudagc@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-16	\N	\N	0
765	P-0353	ENRIQUEZ BUSTOS GRACE ALEJANDRA 	04	0401007646001		0996828499	Boyaca y Bolivar 	grace.1316@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-22	\N	\N	0
766	T-0109	SOFIA PILLAJO 	04			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-09-22	\N	\N	0
767	P-0354	KAM ALBAM JHONNY MARCO 	04	1002815494001		0987978881	Mira Panamericana y Portada 	kam.jalban@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-09-23	\N	\N	0
768	P-0355	ERAZO WILSON FERNANDO 	04	1002052627001		0994418843	Imbabura Antonio Ante Atuntaqui 	wilsonfernando_erazo@yahoo.com	2	1039750981	\N	0	0	0	1	16	1	1	2021-10-07	\N	\N	0
769	P-0356	IMPORFACTORY 	04	1792385512001		022080900	Sangolqui Av. General Enriquez 	asistente@imporfactory.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2021-10-11	\N	\N	0
770	P-0357	INSTRUMENTAL Y OPTICA REPRESENTACIONES MIGUEL PAZMIÑO CIA LTDA 	04	1790868044001		022554120	Quito, Av. Colón OE1 -100 Y Av. 10 de Agosto 	facturacion@instyopt.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-12	\N	\N	0
771	E-0114	PIARPUEZÁN MORÁN BRAYAN STIVEN 	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-10-14	\N	\N	0
772	P-0358	ESPINOZA SEPÚLVEDA LUIS EDGAR 	04	1723494546001		0984250363	Tulcán Ecuador 	spinosaropadeportiva@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-14	\N	\N	0
773	P-0359	ISOLATOT S.A 	04	0992839155001		0980275385	KM 7.5 Via Duran Tambo	compraspublicas@isolatot.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-18	\N	\N	0
774	P-0360	PAGUAY GUILLEN MANUEL ABELARDO 	04	0300508942001		0981553351	Av.Guayaquil M20 Y SL DIEZ 25 DE NOVIEMBRE 	taxidvice.ec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-21	\N	\N	0
775	P-0361	CHAMORRO PAILLACHO NANCY ELIZABETH 	04	0401290952001		0980507640	Av. Veintimilla y Av.Portugal 	imagenglob@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-10-21	\N	\N	0
776	P-0362	PIEDRA LOAIZA MERCY ESMERALDA 	04	1103285464001		022349511	Conocoto Camilo Ponce y Gracía Moreno 	ventas@kleiner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2021-10-26	\N	\N	0
777	E-0115	PAZMIÑO QUIMBIULCO ERIK JOEL 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-05	\N	\N	0
778	T-0110	ROSERO QUIMBIULCO ERICSSON STIVEN 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
779	E-0116	YAPUD GUIZ WILMER SANTIAGO 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-11-05	\N	\N	0
780	T-0111	ROSERO CURICHO ROMEL VINICIO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
781	T-0112	PORTILLA ROSERO EMILIO SANTIAGO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
782	T-0113	GUERRERO CARLOS ALFONSO 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
783	T-0114	ALTAMIRANO  PINCHAO FRANCISCO JAVIER 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-11-05	\N	\N	0
784	P-0363	ESCOBAR CORONEL DANIEL ALEJANDRO	04	1720733920001		0992785221	Ricardo Izurita del Castillo	escobardaniel687@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-12	\N	\N	0
785	P-0364	GUDIÑO VALENZUELA NELSON OSWALDO 	04	0908459621001		0991980565	Alpachaca / San Salvador 	osvalengu@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-17	\N	\N	0
786	P-0365	CYA EMPRESARIAL NORU CIA.LTDA 	04	1792809975001		0987539603	OE11-1525 Y INTIRAYMI	empresarialnoru@gmail.com	1	0041244062	\N	0	0	0	1	15	1	1	2021-11-18	\N	\N	0
787	P-0366	BAROJA LASCANO ANA LUCIA 	04	1704262243001		0978877725	San José de Ayora Av. Victor Cartagena 	analuciabaroja@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-18	\N	\N	0
788	P-0367	LA NUEVA FM RADIO 	04	0491518413001		062962482	Colón y Chimborazo 	nuevafm97.7@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-11-24	\N	\N	0
790	P-0368	NOTARIA 2	04	0500916440001		062981289	OLMEDO Y AYACUCHO	troyanelson58@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2021-12-02	\N	\N	0
791	T-0115	Piarpuezan Yapud Jaime Antonio	04	0400598876001		0968660316	El Playon	jaimepiarpuezan11@hotmail.com	2	402110028034	\N	0	0	0	5	68	1	1	2021-12-10	\N	\N	0
792	T-0116	Belalcazar Estacio Luis Andino	05		0401101167	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
793	T-0117	Benalcazar Sánchez Eulalio Fermín	05		0401710751	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
794	T-0118	Pinchao Yarpaz Albaro Fabian	05		0401771290	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
795	T-0119	Benalcazar Sanchez Darwin Ermilio	05		0401621099	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
796	T-0120	Mueses Rosero Jaime Rolando	05		0401508809	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2021-12-10	\N	\N	0
797	P-0369	SANDRA CATALINA  BAEZ VILLOTA 	04	0400981924001		0999483520	Parque Artesanal M4 	k.at.ba@hotmail.com	2	3497904300	\N	0	0	0	1	74	1	1	2021-12-13	\N	\N	0
798	P-0370	CARCHI AL DIA	04	0491520809001		0622270039	Pio V Guzman entre Av. Atahualpa y los Andes	carchialdia1@gmail.com	2	404110128183	\N	0	0	0	1	68	1	1	2021-12-14	\N	\N	0
799	P-0507	Escobar Almeida Daniela Cristina	04	1716895006001		0999731108	Suiza N34-01 y Checoslovaquia	cortinashospitalarias@hotmail.com	1	2100164272	\N	0	0	0	1	74	1	1	2021-12-15	\N	\N	0
800	E-0118	Rosales Almeida Aida Camila	05		0401382403	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2021-12-16	\N	\N	0
801	P-0371	Seguros Alianza SA	04	1790551350001		0963145589	Av. 12 de octubre y Baquerizo Moreno Torre	kcalderon@segurosalianza.com	1	01006012459	\N	0	0	0	1	6	1	1	2021-12-21	\N	\N	0
802	P-0372	Arias Cedeno Ernesto Leonardo	04	1715243307001		0996982368	Calle C y Av. interoceánica Y  de Puembo	info@fibradevidrio.ec	2	4389591100	\N	0	0	0	1	74	1	1	2021-12-21	\N	\N	0
803	P-0373	BURBANO DELGADO CARLOS ANTONIO	04	0400310421001		0994297709	Luis Felipe Borja	gubeburbano@hotmail.com	2	3498343400	\N	0	0	0	1	74	1	1	2021-12-22	\N	\N	0
804	P-0374	Cadena Argoti Alvaro German	04	0400761789001		0999561368	General Plaza y Olmedo	alvcad@hotmail.com	1	0070-05089-1	\N	0	0	0	1	71	1	1	2022-01-13	\N	\N	0
805	T-0121	Valencia Paspuel Brayan Leonel 	05		0401807342	0983968021	Tulcan	bvalenciapaspuel@gmail.com	2	4239059	\N	0	0	0	5	20	1	1	2022-01-17	\N	\N	0
806	T-0122	Paspuel Chiles Wilfrido	05		0401041660	0983968021	Tulcan	wilfridopaspuelwilfrido@gmail.com	2	401110097397	\N	0	0	0	5	68	1	1	2022-01-19	\N	\N	0
807	T-0123	Puetate Fuel Milton Andres	05		0401590500	\N	Tulcan	\N	2	4709885500	\N	0	0	0	5	74	1	1	2022-01-25	\N	\N	0
808	P-0375	MEJIA ARGOTI OSWALDO FEDERICO	04	0400576310001		0997123093	Calle C No 29 Calle A	oswaldmejia@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-01-28	\N	\N	0
809	E-0119	Jácome Hernández Jefferson	05		0401096219	\N	Tulcan	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-01-28	\N	\N	0
810	P-0376	Ledesma lomas Wilson Favian	04	0400885547001		0995005857	Av. San Francisco y Ten. Luis Rosero	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-02-08	\N	\N	0
811	P-0377	ROMERO OBANDO MARLENE ADRIANA	04	0401027628001		062960951	Sucre y Chimborazo	daguilarjulian@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-02-10	\N	\N	0
812	P-0378	CAPCONTEL SEGURIDAD INDUSTRIAL CIA LTDA.	04	1791879198001		0996916125	Jóse Felix Barreiro y E 16-277 y Pasaje E16E	procesos@capcontel.com.ec	2	2201327116	\N	0	0	0	1	74	1	1	2022-02-15	\N	\N	0
813	P-0379	VERIFYCAR	04	0491532491001		\N	Barrio la Rinconada	\N	2	019037858207	\N	0	0	0	1	8	1	1	2022-02-16	\N	\N	0
814	P-0380	Lalaleo Chamba Alexandra Catalina	04	1803175478001		0986305559	Tungurahua	jdm.ec@outlook.com	2	1059439025	\N	0	0	0	1	16	1	1	2022-02-16	\N	\N	0
815	P-0381	FUNDIEC	04	1791157281001		02-242-4675	Calle Alfonso  Moncayo 455/pN Km101/2	fundiec@fundiec.com	1	7636768	\N	0	0	0	1	16	1	1	2022-02-23	\N	\N	0
816	P-0382	Suarez Castro Miguel Angel	04	0400362562001		0986153003	San Miguel del Sur	b13m232000@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2022-02-24	\N	\N	0
817	P-0383	Nazate Villarreal Narciza de Jésus	04	0400917456001		062983809	Paluz y Yanacocha	rene.mote1@hotmail.com	2	3497889700	\N	0	0	0	1	74	1	1	2022-03-25	\N	\N	0
818	P-0384	GUERRERO BRAVO MADELAINE -FERRETERÍA CASTILLO	04	0401562806001		0988075617	Av Coral y Roberto Grijalva	lilianague97@gmail.com	2	2100257343	\N	0	0	0	1	74	1	1	2022-03-29	\N	\N	0
819	P-0385	Flores Yaluzan Edison Patricio	04	0401857578001		0988872540	San Pablo y San Pedro	floresmathias181@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-03-30	\N	\N	0
820	P-0386	CONSORCIO GADS. PROVINCIALES Y MUNICIPALES DEL NORTE DEL PAIS CON-NOR	04	1060016180001		062952973	IMBABURA / IBARRA / SAN FRANCISCO / BOLIVAR 10-23 	connor_ibarra@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2022-04-04	\N	\N	0
821	P-0387	PERFOCONSUL CIA. LTDA	04	1792110483001		022560970	Av. La Coruña N27-88 y Av. Orellana	gerencia@perfoconsul.com	\N	\N	\N	0	0	0	1	1	1	1	2022-04-07	\N	\N	0
822	P-0388	LALAMA SALAZAR PABLO ALEJANDRO 	04	1718610437001		0999371372	San Jose E15-45	pa.lalama@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-04-14	\N	\N	0
823	P-0389	VAICILLA PORTILLA LUIS ALEXANDER 	04	0401433941001		\N	Av. Veintimilla y Juan Ramon Arellano 	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-04-21	\N	\N	0
824	P-0390	TONELLO-SOLUCIONES INTEGRALES CIA. LTDA	04	1792234549001		023956982	PICHINCHA/CAYAMBE/PANAMERICANA NORTE N11-01	alexandro@tonello.ec	1	7314450	\N	0	0	0	1	16	1	1	2022-05-13	\N	\N	0
825	P-0391	LATINOAMERICANA DE COMERCIO 	04	0401334545001		0999174913	Av. Coral y Robertho Grijalva	latinoamericanadecomercio@yahoo.es	1	2100005866	\N	0	0	0	1	74	1	1	2022-05-17	\N	\N	0
826	P-0392	COMERCIAL HIDROBO S.A. COMHIDROBO	04	1090084247001		062631633	Av Mariano Acosta - Ibarra	pcusangua@comhidrobo.com	1	3108541104	\N	0	0	0	1	74	1	1	2022-05-19	\N	\N	0
827	P-0393	SAUDE SCA	04	0491533293001		0963527637	CALDERON Y ARGENTINA	saudesca.ec@gmail.com	1	0029816620	\N	0	0	0	1	15	1	1	2022-05-19	\N	\N	0
828	P-0394	DUNAMIS- BONILLA BONILLA MONICA SUSANA	04	1708620925001		0997777663	Ricardo Sanchez 1-45 y pasaje A	monicabonilla01@hotmail.com	2	5590765600	\N	0	0	0	1	74	1	1	2022-05-25	\N	\N	0
829	P-0395	ESPINOZA MENESES LIXON LIBORIO-TECNIFUEGOS	04	1002358420001		0967937123	Av. Manabí y Argentina	tecnifuegos2014@hotmail.com	2	2203434575	\N	0	0	0	1	74	1	1	2022-05-26	\N	\N	0
830	I-0021	Junta Adm. Agua Potable y Saneamiento San Luis	04	0491529520001		0995255077	San Luis Santa Martha de Cuba	montu127@yahoo.com	\N	\N	\N	0	0	0	3	1	1	1	2022-05-31	\N	\N	0
831	I-0022	COMUNA LA ESPERANZA	04	0491506458001		\N	Comuna la Esperanza	comunalaesperanza2021@gmail.com	2	4-01638425-6	\N	0	0	0	3	71	1	1	2022-06-08	\N	\N	0
832	I-0023	ASOCIACIÓN AGRICOLA DE TUFIÑO	04	0491510404001		0962877831	Tufiño	ascagricolatufi@gmail.com	2	0-07012326-4	\N	0	0	0	3	71	1	1	2022-06-09	\N	\N	0
833	P-0396	FERRETERIA CASTRO -BASTIDAS ERAZO BLANCA ELISA	04	0400923892001		0969873920	Gran Colombia y Av. Julio Robles 	blancaelisabastidas@gmail.com	2	401110924204	\N	0	0	0	1	68	1	1	2022-06-10	\N	\N	0
834	P-0397	MEGA REPUESTOS	04	0400576633001		0989446221	AV. VEITIMILLA Y PASAJE CENEPA	paointercambio@yahoo.com	\N	\N	\N	0	0	0	1	1	1	1	2022-06-15	\N	\N	0
835	E-0120	Villota Trujillo Tamara Gabriela	05		1003001953	\N	Tulcán	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-06-20	\N	\N	0
836	P-0398	BIORECICLAR	04	1792387280001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-06-22	\N	\N	0
837	P-0399	Cano Crucerira Génesis Carolina ( La Nueva)	04	0401702352001		0998931492	via expreso Oriental	caro24cano@gmail.com	2	01010139404	\N	0	0	0	1	67	1	1	2022-06-27	\N	\N	0
838	P-0400	ASOCIACIÓN DE PRODUCCIÓN TEXTIL ALDASHIRA SPORT - Margarita Deporte  Montufar ASOTEXALDSPORT	04	0491517883001		062220121	Montufar y Sucre	asotexaldsport.montu@yahoo.com	2	4008175815	\N	0	0	0	1	71	1	1	2022-07-11	\N	\N	0
839	P-0401	Coop. Transporte Huaca -Julio Andrade 	04	0490038485001		069888168	Av. Veintimilla y Centenario	cooptranshuacajulioandrade@hotmail.com	2	0104001998	\N	0	0	0	1	20	1	1	2022-07-13	\N	\N	0
840	P-0402	Ruano Ipial Alirio Gerardo	05		0401153960	\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-07-15	\N	\N	0
841	E-0121	Paspuezan Martinez Santiago Javier	05		0401681762	0992763722	Barrio gran Colombia	spjm1990@live.com	2	4501619911	\N	0	0	0	4	37	1	1	2022-07-15	\N	\N	0
842	A-0001	ORTIZ ROSERO ALEXIS LEONARDO 	04	0401501176001		0985096366	Bolívar y General Plaza 	alexis.ortiz81@outlook.com	\N	\N	\N	0	0	0	7	1	1	1	2022-07-25	\N	\N	0
843	P-0403	AGENCIA NACIONAL DE TRÁNSITO	04	1768173130001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2022-08-03	\N	\N	0
844	P-0404	Figueroa Salazar Jacqueline Bernardette	04	1707405807001		0992812643	Autopista Amaguaña #S/N secundaría	funymaq@hotmail.com	2	0013849689	\N	0	0	0	1	15	1	1	2022-08-08	\N	\N	0
845	P-0505	Latacela Zuñiga Alex Giovanny  HIDROSYS	04	0301432449001		072247033	Av. Luis Monsalve Pozo SN y Adolfo Palomeque	alexlatacela@hotmail.com	1	5622158	\N	0	0	0	1	16	1	1	2022-08-09	\N	\N	0
846	P-0405	Tamayo Bonilla Adriana Alejandra ( GRUPO INDUSTRIAL A&A)	04	1803804515001		0984480544	CELIANO MONGE Y CERVANTES	grupo.industrial.aa@gmail.com	1	8122628	\N	0	0	0	1	16	1	1	2022-08-15	\N	\N	0
847	P-0406	MERA HERRERA RODRIGO SANTIAGO	04	0401513817001		0988537377	Calle Coronel Jorge Narváez No. 14 y Félix Freire	santy21189@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-08-18	\N	\N	0
848	P-0407	Aulestia Bedoya Gabriela Patricia	04	1002219713001		0997340160	Maria Castelo Manzana 2	gaby_aulestia0224@hotmail.com	2	1020153910	\N	0	0	0	1	16	1	1	2022-08-24	\N	\N	0
849	P-0408	Estuardo Fabricio Carrera Cañadas	04	1717175796001		0995016923	La Josefina y Diamante  ( Quito). 	arkadiaena@gmail.com	2	06168025004	\N	0	0	0	1	6	1	1	2022-08-24	\N	\N	0
850	E-0122	Salgado Jimenez Edison Arturo	05		0400696860	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-09-07	\N	\N	0
851	P-0409	Sociedad civil y comercial KV Energy SCC	04	1091796413001		0969507183	eusebio Borrero 8-64 y chica Narváez	kv_energy@outlook.com	1	8182329	\N	0	0	0	1	16	1	1	2022-09-07	\N	\N	0
852	P-0410	ENRIQUEZ TATES MIRIAM DEL ROCIO	04	0401134572001		0988141602	Bolivar entre Junin y Ayacucho	carchinoticias7@hotmail.com	2	1051889358	\N	0	0	0	1	16	1	1	2022-09-08	\N	\N	0
853	P-0411	 ASOPROTERESEM -ASOC.PRODUC.TEXTIL MUJERES DEL EMPRENDIMIENTO	04	1091751948001		062641358	Sánchez y Cifuentes y Perez Guerrero	lsy.chiscueth@gmail.com	2	4008178059	\N	0	0	0	1	71	1	1	2022-09-09	\N	\N	0
854	P-0412	Salazar Portilla  Gandy Arturo	04	1712439114001		0987432657	Clemente Vallen y Lino Flores	gandysalazar_75@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-09-14	\N	\N	0
855	P-0413	ARIAS VELA WILLIAM ANTONIO	04	0401098678001		0995325793	Bolivar y Carabobo	afav@hotmail.com	2	01010578910	\N	0	0	0	1	67	1	1	2022-09-14	\N	\N	0
856	P-0414	Caiza Bravo Tania GOBERP	04	0104015748001		0992558815	Av. Ordoñez Lazo S/N	mariofabian83@hotmail.com	2	1044847726	\N	0	0	0	1	16	1	1	2022-09-21	\N	\N	0
857	P-0416	Tupiza Morales Joselyn Nicole	04	1751355163001		0983166423	Esperanza y Simbaya	multiservicios75@gmail.com	2	2202414564	\N	0	0	0	1	74	1	1	2022-10-04	\N	\N	0
858	P-0417	AGUAAMERICAN S.A.S	04	0491533694001		0981300312	Las Animas y Barrio Carchi	facturas.fronnort@gmail.com	2	12862001779	\N	0	0	0	1	6	1	1	2022-10-06	\N	\N	0
859	P-0418	CORPORACION BUDAK S.A	04	1792348137001		09998371613	Poder Judicial calle Francisco Orellana	contabilidad@corporacionbudak.com.ec	1	3514322204	\N	0	0	0	1	74	1	1	2022-10-07	\N	\N	0
860	P-0419	ASQUI ARMAS CARMEN LOURDES-GRUPO LOS HIDROS CD	04	0601688310001		0984061386	Canonigo Ramos y Miguel de Santiago	loshidroscd@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2022-10-07	\N	\N	0
861	P-0420	IASA S.A	04	0990011109001		043731777	Av Juan Tanca marengo y S/n	navas_santiago@iiasacat.com	1	01667238	\N	0	0	0	1	15	1	1	2022-10-12	\N	\N	0
863	P-0421	Yanez Lechon Carlos Patricio ( Surtividrio)	04	1002090072001		0992929270	Bolivar  y Roberto Sierra	ycarlos32@yahoo.es	2	4006040357	\N	0	0	0	1	71	1	1	2022-10-13	\N	\N	0
864	P-0422	ATENCIO AGUAS CRISTHIAN DAVID.	04	1715932610001		0995183298	Las Casas Calle OE9FD Polit Lasso	cristhian_atencio09@hotmail.com	2	2100153716	\N	0	0	0	1	74	1	1	2022-10-18	\N	\N	0
865	P-0423	Ante Estrada Segundo Gerardo.	04	0400732806001		062250324	Av. Veintimilla y la Cascada	segundo-ante@outlook.com	2	401118819950	\N	0	0	0	1	68	1	1	2022-10-26	\N	\N	0
866	E-0123	Avilés Meza Edwin Patricio 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-14	\N	\N	0
867	E-0124	Quiranza Arciniega Anthony Alexander	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-15	\N	\N	0
868	P-0424	KUNANSOFT S.A.	04	0190380009001		072810628	Latinoamericana y Brasil	contabilidad@kunansoft.net	2	2209875764	\N	0	0	0	1	74	1	1	2022-11-15	\N	\N	0
870	P-0426	Servicio Radio Difusión Almeida & Hurtado -Ondas Carchenses 	04	0491514426001		2982518	Olmedo y Ayacucho	ondascarchenses@gmail.com	1	0004036204	\N	0	0	0	1	20	1	1	2022-11-16	\N	\N	0
871	P-0427	Meneses Toro Luis Gonzalo	04	0400982997001		063012630	La cortadera	luisgonza.meneses@gmail.com	2	2207522325	\N	0	0	0	1	74	1	1	2022-11-24	\N	\N	0
872	I-0026	Junta Admi. de Agua Potable y Alcantarillado Santa Martha de Cuba	04	0491516836001		\N	Santa Martha de Cuba	marigpaspuel@hotmail.com	2	403110818568	\N	0	0	0	3	68	1	1	2022-11-24	\N	\N	0
873	E-0125	Lenin Daniel Freire Trujillo	05		0401603915	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2022-11-24	\N	\N	0
874	P-0428	Yomaira Vanessa Fuertes Cadena	04	0401746037001		0939919540	Av Veitimilla y Andres Bello	vanessa1903@gmail.com	2	2203990577	\N	0	0	0	1	74	1	1	2022-12-02	\N	\N	0
875	P-0429	TECHNOLOGY- GUERRERO QUINTERO HUGO FERNANDO	04	0401311295001		0983800587	Boyaca y Bolivar	hugoguerreroq22@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2022-12-08	\N	\N	0
876	I-0007	Junta Administradora Agua Potable El Chical	04	0491519339001		\N	El Chical	\N	\N	\N	\N	0	0	0	3	1	1	1	2022-12-08	\N	\N	0
877	P-0430	JÁCOME VALLEJOS GUSTAVO JORGE	04	1001193026001		0990257171	Julio Andrade Panamericana Norte, Sec. Las Manguer	gustavojacome77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-01-17	\N	\N	0
878	P-0431	PLUSAMBIENTE S.A	04	1792186277001		023938214	Pichincha Quito	gerencia@plusambiente.com	1	3465044304	\N	0	0	0	1	74	1	1	2023-01-17	\N	\N	0
880	P-0432	CHUGA ENRIQUEZ JORGE BAYARDO	04	0400634630001		0991328581	Maldonado y Boyaca	jorbache@hotmail.com	1	3568079000	\N	0	0	0	1	74	1	1	2023-01-17	\N	\N	0
881	E-0127	Morejón Morejón Marco Fabian	05		1001452034	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-01-18	\N	\N	0
882	P-0433	REPRESMUNDIAL CIA LTDA	04	1792113636001		0998585179	Tumbaco	marcoleguisamo@hotmail.com	1	0025418255	\N	0	0	0	1	15	1	1	2023-01-19	\N	\N	0
883	P-0434	Imbacuan Navarro Alexandra Esthefania 	04	0401849690001		0993466814	Las animas y Juan Montalvo	estrategidea@gmail.com	2	2208310787	\N	0	0	0	1	74	1	1	2023-01-19	\N	\N	0
884	P-0435	HERNANDEZ POZO MANUEL MESIAS	05		0400396503	\N	TULCÁN 	\N	2	01010219194	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
885	P-0436	MORILLO CHANGUÁN MARIA LAURA	05		0400616215	\N	TULCÁN	\N	2	01010041820	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
886	P-0437	CHUNEZ MORILLO MANUEL ANTONIO	05		0400879805	\N	TULCAN	\N	2	2202499347	\N	0	0	0	1	74	1	1	2023-01-23	\N	\N	0
887	P-0438	CHUNEZ MORILLO ROSA ANA	05		0400915997	\N	TULCAN	\N	2	01010027070	\N	0	0	0	1	67	1	1	2023-01-23	\N	\N	0
888	E-0128	CHUNEZ MORILLO MARTHA ELIZABETH	05		0401022157	\N	TULCAN	\N	2	2207305686	\N	0	0	0	4	74	1	1	2023-01-23	\N	\N	0
889	P-0439	CHUNEZ MORILLO JOFFRE JAVIER	05		0401050182	\N	TULCAN	\N	2	4297906200	\N	0	0	0	1	74	1	1	2023-01-23	\N	\N	0
890	P-0440	Puetate Ceron Segundo Jacinto	04	0400448684001		0997272793	Av. 21 de Marzo y Pedro Vicente	puetatesegundo1@gmail.com	2	6228171200	\N	0	0	0	1	74	1	1	2023-01-24	\N	\N	0
891	P-0441	ZUMBA ALFARO CARLOS ALEJANDRO.	04	1705674073001		0998645244	Calle Gonzalo Gallo OE7-288 y Jorge Piedra	czumba@hotmail.com	2	6129047400	\N	0	0	0	1	74	1	1	2023-02-01	\N	\N	0
892	T-0124	PUETATE PASPUEZAN JOSE ROSALINO	05		0400831574	\N	TUFIÑO	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-02-02	\N	\N	0
893	T-0125	GUAMAN CHILES BRAYAN ALEXANDER 	05		0450024161	\N	TUFIÑO 	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-02-02	\N	\N	0
894	P-0442	SOTO TAPIA MARIA FERNANDA-COPY SYSTEM	04	0401385760001		0993948172	Coral y Sucre	mfst3@hotmail.com	2	01010206572	\N	0	0	0	1	67	1	1	2023-02-10	\N	\N	0
895	P-0443	Gallegos  Bolaños Wilfrido Atahualpa	04	1708983158001		0997582952	Pichincha	wilfrido.gallegos@hotmail.com	2	2202226655	\N	0	0	0	1	74	1	1	2023-02-23	\N	\N	0
896	P-0444	AYALA JARAMILLO MARTIN ALEJANDRO - M&M QUÍMICOS	04	1717211716001		0983595701	La Pradera E7-59	maayalaj220789@gmail.com	2	12002181407	\N	0	0	0	1	6	1	1	2023-03-09	\N	\N	0
897	T-0126	Meneses Nasner Edison Andres	05		0401426697	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
898	T-0127	Meneses Nasner Jordan Gabriel	05		0450120399	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
899	T-0128	Portilla Jimenez Alvaro Eduardo	05		0401216007	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-16	\N	\N	0
900	P-0446	RUALES AUZ JUAN FRANCISCO	04	0401117387001		0986015988	ROCAFUERTE Y BOLIVAR 	rualesfrancisco@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-03-24	\N	\N	0
901	E-0129	Luis Aguilar Guerron	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-03-24	\N	\N	0
902	P-0447	Flores Yandún Victor Hugo 	04	0401723937001		0987293300	Juan José Flores y 10 de agosto	victorhogofloresyandun@gmail.com	2	01010598701	\N	0	0	0	1	67	1	1	2023-03-27	\N	\N	0
903	P-0448	Yepez Rosero Victor Manuel	04	0400637005001		0989880582	Carlos Urbina S N El Chical	vimyeros@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2023-03-27	\N	\N	0
904	P-0449	Vaca Cachimuela Julio Guillermo 	04	1726311739001		022354502	San miguel de alugulla / pasaje 21	julioguillermovaca@gmail.com	2	2202779076	\N	0	0	0	1	74	1	1	2023-03-28	\N	\N	0
905	P-0450	Martinez Rosero Dayana Anabel 	04	0402037741001		0995749821	Sucre y Gran Coliombia	dayanamartinez19982013@gmail.com	2	2209337643	\N	0	0	0	1	74	1	1	2023-03-28	\N	\N	0
906	T-0129	Almeida Rodriguez  Manuel Mesias 	05		0400459756	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-03-28	\N	\N	0
907	P-0451	Nazate Chamorro Carlos David	04	0401682695001		0980338866	Tarqui y Olmedo	charlestonlavozecuador@gmail.com	2	2205572826	\N	0	0	0	1	74	1	1	2023-04-18	\N	\N	0
908	P-0452	CUAYCAL REYES RAMIRO GERMÁN	04	0400633004001		\N	Juan Jose Flores y 10 de Agosto	noticierohora12@gmail.com	2	3497850500	\N	0	0	0	1	74	1	1	2023-04-19	\N	\N	0
909	P-0453	LA CASA DEL CONSTRUCTOR- FUERTES AGUILAR MARITZA	04	0401463815001		0999570991	Av. Veintimilla y México	maritzafuertesaguilar@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-04-26	\N	\N	0
910	P-0454	INGENIERIA ELECTRICA Y REDES INGELEC S.A	04	0993125784001		0992664867	Guayaquil -ciudad Olimpo 	oficina.ingelec@gmail.com	1	7908601	\N	0	0	0	1	16	1	1	2023-05-02	\N	\N	0
911	P-0455	NOROÑA ROJAS GRACIELA ELIZABETH	04	1715821508001		0995675372	Pichincha-Quito	uyuky_gnr@hotmail.com	2	2204009724	\N	0	0	0	1	74	1	1	2023-05-11	\N	\N	0
912	E-0130	Montesdeoca Espinoza Jocelyne Beatriz	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-05-11	\N	\N	0
913	T-0130	Fabiola Cando Aguirre	05		0401552401	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-05-19	\N	\N	0
915	P-0457	Mejia Viteri Alex David Notaria 22.	04	0201340650001		2503980	Av 12 de octubre N24-660 y Francisco Salazar	facturacioncorporativo@notaria22quito.com	1		\N	0	0	0	1	1	1	1	2023-06-15	\N	\N	0
916	E-0131	Aguilar Guerron Byron Danilo	05		0401185095	0981164129	Barrio el Carchi	daguilarjulian@hotmail.com	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
917	E-0132	CHUNES CHANGUAN MARIANA LUCILA	05		0400966750	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
918	E-0133	Rosero Benavides  Juan Carlos	04	0401167325001		\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-19	\N	\N	0
919	E-0134	Burbano Ortiz Northon Ramiro	05		0400993838	\N	JUAN RAMON ARELLANO Y BOLIVAR 	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-06-21	\N	\N	0
920	P-0458	ELICROM CIA. LTDA	04	0992216964001		0999337519	Guayaquil  solar 10 manzana 21 frente mall del sol	elicrom@elicrom.com	1	7415311	\N	0	0	0	1	16	1	1	2023-06-22	\N	\N	0
921	P-0459	ATIMASA S.A	04	0991331859001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
922	P-0460	Proaño Acosta Jorge Luis	04	1600234072001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
923	P-0461	Concesionaria Santo Domingo CRSD S.A	04	1793040012001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
924	P-0462	CONORTE S.A - EP 	04	0991503331001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-06-30	\N	\N	0
925	I-0028	GAD PROVINCIAL DE PICHINCHA	04	1760003330001		\N	\N	\N	\N	\N	\N	0	0	0	3	1	1	1	2023-06-30	\N	\N	0
926	P-0464	Molina Pruna Galo Alberto	04	1709264111001		023110793	Quito la Magdalena/ Aguirre	molinatires66@gmail.com	1	7740972	\N	0	0	0	1	16	1	1	2023-07-13	\N	\N	0
927	P-0465	VILLARREAL REVELO RAUL EFREN.	04	0400804084001		0985430964	9 de Octubre y Olmedo	raul_0767@hotmail.com	2	2100034740	\N	0	0	0	1	74	1	1	2023-07-13	\N	\N	0
928	E-0135	Velasco Escobar Jorge Alexander	04	0401125323001		0995370334	Parquue Artesanal y Upiano Rosero	Jorge_velasco11@hotmail.com	2	0021497147	\N	0	0	0	4	15	1	1	2023-07-14	\N	\N	0
929	P-0466	NAVARRETE DAVILA BETTI NARCISA 	04	0400686911001		0984627324	Nazareth y Av Gonzalo Plazo	bynrepresentaciones@hotmail.com	2	 3177185700	\N	0	0	0	1	74	1	1	2023-07-14	\N	\N	0
930	T-0131	Paspuezan Yanascual Carlos Fernando	05		0401858964	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-07-17	\N	\N	0
931	T-0132	Puetate Paguay Carlos Dorman	05		0401033261	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-07-17	\N	\N	0
932	P-0506	PEÑAFIEL RUANO LUIS EMILIO	04	0400691903001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-08-02	\N	\N	0
933	E-0136	Juan Diego Delgado Flores	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-08-16	\N	\N	0
934	P-0467	GERMAN MAURICIO LOPEZ SANTANA	04	1801338912001		\N	\N	eljardin.efactura@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-08-21	\N	\N	0
935	E-0137	Luis Fernado Ruano Cárdenas	05		0401864673	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-09-05	\N	\N	0
936	P-0468	CHICAIZA  TOAPANTA MARIA PATRICIA	04	1802456093001		0992195489	Santiago de Pillaro sector Baratillo VI a San Jose	sistemasymp@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-09-05	\N	\N	0
937	P-0469	INDUSTRIAS SISAILLA DEL ECUADOR	04	1792729823001		022094131	Conocoto	compras.publicas@sisailla.com	1	2100144488	\N	0	0	0	1	74	1	1	2023-09-06	\N	\N	0
938	E-0138	Jessika Esteffania Vivas Castillo 	05		0401745310	0960485000	Julio Andrade 	estefyvivas0128@gmail.com	2	\N	\N	0	0	0	4	74	1	1	2023-09-07	\N	\N	0
939	P-0470	Aguilar Villalva Giovanna Gabriela ( PROINDUSTRIAL SA)	04	1803784881001		0985210488	TUNGURAGUA	gerenciaproindustrial@gmail.com	2	0019517581	\N	0	0	0	1	15	1	1	2023-09-08	\N	\N	0
940	P-0471	MURILLO ALTAMIRANO MARIBEL OLIVIA- MERCAMAX	04	0914104708001		0999492005	Guayaquil	grandamurillo@hotmail.com	1	7695241	\N	0	0	0	1	16	1	1	2023-09-11	\N	\N	0
941	P-0472	Estación de Servicio Mundo Tuerca	04	0601809403001		\N	Diego Ibarra 21-55 Av Daniel Leon Borja	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-09-18	\N	\N	0
942	P-0473	Bonilla Ortiz Victoria Evelina	04	1800384826001		\N	\N	leon.efactura@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2023-09-20	\N	\N	0
943	E-0139	Jojoa Benavides Joana María	05		1752918217	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-09-25	\N	\N	0
944	P-0474	VÍVERES LA UNIVERSAL.	04	0400809596001		0983244452	Av veintimilla y Centenario	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-10-02	\N	\N	0
945	P-0475	Vargas Vizuete Angel Roberto	04	0602358087001		0999019680	Pichincha	importrepuestos001@outlook.com	1	8124264	\N	0	0	0	1	16	1	1	2023-10-06	\N	\N	0
946	P-0476	APROTEXRO -ASOC. PRODUCC.TEXTIL ROBLETEX	04	1091760386001		062950213	Pedro Rodríguez y José María Lequerica	aprotexro13@gmail.com	1	0010866383	\N	0	0	0	1	20	1	1	2023-10-12	\N	\N	0
947	P-0477	Topchay Topchay Victoria	04	0401352778001		\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2023-10-12	\N	\N	0
948	P-0478	EL HUERTO CIA. LTDA.	04	1891725198001		032823041	Tunguragua	clientes@elhuerto.com.ec	1	02080011159	\N	0	0	0	1	6	1	1	2023-10-18	\N	\N	0
949	P-0479	Omnibus B.B Transportes S.A	04	1790233979001		22977-700 ext 44245	Av. Galo Plaza Lasso OE1-277	bilma.davila@gmail.com	1	3041163504	\N	0	0	0	1	74	1	1	2023-10-24	\N	\N	0
950	P-0480	IASA-SERVICIO S.A	04	0990011117001		042237000	Guayaquil	navas_sunny@iiasacat.com	1	7503164	\N	0	0	0	1	16	1	1	2023-10-25	\N	\N	0
951	E-0141	Jairo Pozo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-10-31	\N	\N	0
952	T-0133	MENA SÁNCHEZ CESAR OSWALDO	05		1719676189	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2023-11-01	\N	\N	0
953	E-0142	POZO YANDUN JAIRO GIORDANO	05		0401918636	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-06	\N	\N	0
954	E-0143	Enriquez Jonathan	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-07	\N	\N	0
955	P-0481	Godoy Usiña Henry Vinicio	04	1003147467001		0963482092	Alta tensión s/n Av. Futura Padre Carolo	distribucioneshenrygodoy@gmail.com	2	0018633056	\N	0	0	0	1	15	1	1	2023-11-08	\N	\N	0
956	P-0482	Cajas y Empaques Industriales  Clusterpack CPK S.A.	04	1792722357001		0999800230	Pichincha	solmontalvocluster@gmail.com	1	1645006475	\N	0	0	0	1	17	1	1	2023-11-15	\N	\N	0
957	P-0483	AQUAKLEANER S.A.	04	0992638923001		0994495568	Km. 16 vía a Daule	gvera@aquakleaner.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2023-11-20	\N	\N	0
958	E-0144	Rodriguez Huera Mishell Carolina	05		0401882360	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-11-21	\N	\N	0
959	P-0484	CARRO SEGURO CARSEG S.A.	04	0991259546001		042924050	Pichincha  C38 y 13 de abril	gmaldonado@carsegsa.com	1	3139591104	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
960	P-0485	BASSANTE CRUZ JOSÉ ANDRÉS -BELSSANTÉ	04	1717153579001		0984698502	Pichincha	jabassante@gmail.com	2	4444364200	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
961	P-0486	Saltos Demera  Rosa Leonor 	04	1713056610001		0959065711	Santo Domingo	imprentadkl@gmail.com	1	2100296200	\N	0	0	0	1	74	1	1	2023-11-27	\N	\N	0
962	E-0145	José Caicedo	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2023-12-06	\N	\N	0
963	P-0487	PLÁSTICOS RIVAL CIA. LTDA.	04	0190050033001		72890-144	Zona 6/ Azuay/ Cuenca/ Ricaurte	auxtesoreria@plasticosrival.com	1	3001051470	\N	0	0	0	1	71	1	1	2023-12-07	\N	\N	0
964	P-0488	PAREDES BOLAÑOS JOSÉ DARWIN.	04	0401333190001		0995933022	Los Videños - Carchi	arq.paredesjose@gmail.com	1	0029816174	\N	0	0	0	1	15	1	1	2023-12-07	\N	\N	0
965	P-0489	Austral CIA LTDA	04	0190001628001		072809325	Azuay/Cuenca/El Vecino	facturacion@austral.com.ec	1	7243626	\N	0	0	0	1	16	1	1	2023-12-07	\N	\N	0
966	P-0490	Herrera Dávila Neptalí	04	1001416393001		0969776462	Imbabura	neptaliherrera63@hotmail.com	2	40711017	\N	0	0	0	1	68	1	1	2023-12-12	\N	\N	0
967	P-0491	Morales Chamorro Byron Andres	04	1722702600001		022350872	Pichincha	clubdeciencias2@hotmail.com	2	1055500218	\N	0	0	0	1	16	1	1	2023-12-15	\N	\N	0
968	P-0492	Cando Huertas Jhonny Ivan 	04	0401391347001		0989075951	Rafel Arellano y Panama	dimev2004@yahoo.com	2	3395722704	\N	0	0	0	1	74	1	1	2023-12-15	\N	\N	0
969	E-0146	Ing. Fernando Tiobar 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-10	\N	\N	0
970	E-0147	Lcdo. Vladimir Velasco	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-15	\N	\N	0
971	P-0493	SUAREZ MUÑOZ RITTA CECILIA.	04	1712213543001		0992527035	Urb. Pilanqui Juan de la Roca 7 - 42	diegoenantm@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-17	\N	\N	0
972	P-0494	NAVISOY REYES COLÓN GUSTAVO	04	0400503892001		0991956936	Barrio Centro calle Ayacucho 	gus_navreyes@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2024-01-17	\N	\N	0
973	E-0148	CAICEDO MERA JOSE HOMERO	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-18	\N	\N	0
974	P-0495	ENRIQUEZ CHICANGO JAIME JEAN	04	0400791166001		0993513881	Tulcán - Rafael Arellano y Junin 	jaime2273@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-18	\N	\N	0
975	E-0149	SERRANO TERÁN ANDRÉS GIOVANNY	05		0400876983	0995331799	\N	gordochelin2412@gmail.com	\N	\N	\N	0	0	0	4	1	1	1	2024-01-18	\N	\N	0
976	T-0134	COLIMBA NARVÁEZ CARLOS ARTURO 	05		1712082286	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
977	T-0135	GUEL PUETATE CARLOS ROBERTO 	05		0401616115	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
978	T-0136	CABRERA TERMAL BAIRON ALEXANDER	05		0401663976	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
979	T-0137	GONZALES GONZALES CÉSAR EDUARDO	05		0401442942	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
980	T-0138	CUACES CUELTAN GERMAN ALEXANDER	05		0401631916	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
981	T-0139	IMBAQUINGO PINCHAO WILSON HERNÁN	05		1724789647	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-18	\N	\N	0
982	E-0150	VELASCO BARBA JAIME VLADIMIR	05		0401036736	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-19	\N	\N	0
983	T-0140	MORAN ROSERO DANIEL ANÍBAL	05		0401819347	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-19	\N	\N	0
984	T-0141	CUACES POZO MARCELO ARMANDO	05		0401192729	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-01-19	\N	\N	0
985	E-0151	FUERTES LÓPEZ NORMA CECILIA	05		0400837878	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-01-19	\N	\N	0
986	P-0496	LOBATO CAMPOVERDE CHRISTIAN ANDRES	04	1722748215001		0958969848	Loja - calle Miguel Angel 	per.calobato@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-01-29	\N	\N	0
987	P-0504	Nazate Cadena Alicia Mireya 	04	0401171301001		2982407	Tarqui s/n y Olmedo 	\N	\N	\N	\N	0	0	0	1	1	1	1	2024-01-30	\N	\N	0
988	T-0142	Tatamues Chuquizán Vicente Hipólito 	05		0400642682	\N	Tufiño -  calle Gran Colombia 	chuquizan1962@gmail.com	\N	\N	\N	0	0	0	5	1	1	1	2024-02-02	\N	\N	0
989	T-0143	Cuesta Malte Jordan Estiven 	05		0402065734	0990978557	Tufiño- calle Gran Colombia 	estivenmalte@gmail.com	\N	\N	\N	0	0	0	5	1	1	1	2024-02-02	\N	\N	0
990	E-0152	ORBE LUCERO CINTHYA DANIELA 	05		0401913496	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-06	\N	\N	0
991	P-0497	SALCEDO  RODRIGUEZ CARLOS ANDRES 	04	0401588611001		0994515211	Barrio Norte calle 11 de Abril 	arq.andresalcedo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-06	\N	\N	0
992	E-0153	YACELGA FIGUEROA  JENNY ELIZABETH	05		0401463070	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-07	\N	\N	0
993	P-0498	MONTENEGRO ALMEIDA ALVARO GONZALO 	04	0400980686001		0992594175	Ciudadela Kennedy calle Jose Maria Urbina 	elromanticoagma11@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-08	\N	\N	0
994	E-0154	LARA BENALCÁZAR JOHANNA PAOLA 	05		0401798285	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-02-15	\N	\N	0
995	P-0499	ENRIQUEZ CHAPUEL ALICIA ANABELA 	04	0401660410001		0993716643	Tulcán - Calle Sucre 	edanielcanal1tv@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-02-15	\N	\N	0
996	T-0144	MORAN ROSERO AMILCAR GERARDO	05		0401641543	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-02-15	\N	\N	0
997	P-0500	Proveedores	05			\N	\N	\N	\N	\N	\N	0	0	0	1	1	1	1	2024-02-19	\N	\N	0
998	P-0501	EMULDEC - EMULSIONES DEL ECUADOR 	04	1791773268001		0995281413	Quito- Luis Calderon 	info@emuldec.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-02-21	\N	\N	0
999	E-0155	GUILCAMAIGUA FUENTES YOMAIRA PATRICIA 	05			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-06	\N	\N	0
1000	P-0502	DISTRIBUIDORA DEL CAJAS SA 	04	0391034250001		072599800	Calle Trajano Carrasco Baquero 	mobregon@ucem.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-03-12	\N	\N	0
1001	E-0156	MONTENEGRO CHICAIZA KEVIN ANDRÉS	05		0401417985	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-13	\N	\N	0
1002	P-0503	COPPERSYSTEMS IMPORTADORA CIA LTDA. 	04	1792357985001		023238251	YANEZ PINZON N°26-39 Y LA NIÑA 	alex@coppersytem.com	\N	\N	\N	0	0	0	1	1	1	1	2024-03-15	\N	\N	0
1003	E-0157	LOPEZ MARTINEZ JEAN PIERRE 	05		0401775408	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-21	\N	\N	0
1004	E-0158	CHILIQUINGA CHIRIBOGA JULIO EDUARDO 	05		0401697685	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-03-21	\N	\N	0
1005	P-0508	ASSA - AUTOMOTORES DE LA SIERRA S.A 	04	1890000130001		032999800	Calle Av. Atahualpa y Rio Guayllabamba 	nlarrea@assa.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-03-25	\N	\N	0
1006	T-0145	BELALCAZAR ESTACIO FRANKLIN ROLANDO	05		0401801451	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-04-04	\N	\N	0
1007	P-0509	CMAGINET-EC CIA.LTDA.	04	1792548799001		0983920631	calle 10 de Agosto y Vicente Aguirre 	mj@cmaginet.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
1008	P-0510	LOPEZ AYALA JORGE LUIS -ECUAPURE	04	1002074886001		0995018392	via  a Ajiloma	ecuapure@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
1009	P-0511	ASOTEXANTEÑOS -ASOCIACION PROD.TEXTIL TRABAJADORES ANTEÑOS	04	1091754173001		0999339107	calle Luis Leoro Franco 	asnuevaera2015@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-05	\N	\N	0
1010	P-0512	MORENO VILLACIS ANDRES GUILLERMO 	04	0101834596001		043805650	Brasil N 40 38 y Charles Darwin 	ventas@idconsultants.us	\N	\N	\N	0	0	0	1	1	1	1	2024-04-10	\N	\N	0
1011	P-0513	FERRETERIA LA FRONTERA 	04	0401502711001		0939984094	El Carmelo 24 de mayo  y Bolivar	rafaamplificaciones@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-16	\N	\N	0
1012	E-0159	TREJO VITERI MILENA GISSELA	05		0401721501	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
1013	T-0146	LIMA QUILISMAL JEFFERSON HUMBERTO	05		0401702089	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-04-17	\N	\N	0
1014	E-0160	CANACUAN VIZCAINO GISELLA NATALY	05		0401810767	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
1015	E-0161	NARVAEZ LUIS RIGOBERTO	05		0400795498	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-04-17	\N	\N	0
1016	P-0514	TELENLACES SISTEMAS Y TELECOMUNICACIONES  SA	04	0992558601001		062988556	Junin s/n y Sucre 	info@telenlaces.net	\N	\N	\N	0	0	0	1	1	1	1	2024-04-25	\N	\N	0
1017	P-0515	AMBULUDI ALVAREZ JHAN MARCOS 	04	2101090344001		0939823800	Barrio 10 de Agosto- calle Pichincha 	mediartpublicidad2020@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-04-25	\N	\N	0
1018	P-0516	NAJERA ALMEIDA EVA VERONICA 	04	1711754687001		062952711	Canton Ibarrra - Parroquia San Francisco 	favemsa@yahoo.es	\N	\N	\N	0	0	0	1	1	1	1	2024-05-07	\N	\N	0
1019	P-0517	LOPEZ CEVALLOS EVELYN NATHALY 	04	0401203955001		0963395449	Pasaje Jambeli y calle Gonzalo Araujo 	evelyn.lopez19@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-13	\N	\N	0
1020	P-0518	COUNTELSEG PROFESSIONAL SOLUTIONS S.A.S.	04	1793194296001		062970077	Bolivar y Juan Ramón Arellano 	contabilidad@countelseg.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-14	\N	\N	0
1021	T-0147	ALARCON QUISTANCHALA JOSELYN FERNANDA	05		0402092555	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-05-14	\N	\N	0
1022	P-0519	ARTEAGA ROSERO ALEXIS IVAN	04	0401567516001		0986697145	Tulcán- calle Gonzalez Suarez 	alexiscap2330@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-15	\N	\N	0
1023	P-0520	MENA BUSTAMANTE CARLOS EDUARDO 	04	1726687682001		0984073825	Panamericana Norte 	cemena.terra@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-16	\N	\N	0
1024	P-0521	RODRIGUEZ FUENTES MARCO -NOTARIA 3	04	0400694287001		062985259	Calle Rafael Arellano y Garcia Moreno 	marcorodriguezfuentes2010@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-16	\N	\N	0
1025	P-0522	ROSERO CASTRO ANDRES JAVIER 	04	0401590542001		0982618489	Av. Veintimilla y Padre Juan de Velasco 	andresjavierroserocastro@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-17	\N	\N	0
1026	P-0523	SIMEC-CG S.A.S.	04	1793200538001		0998477054	Mariscal Foch y Diego de Almagro	contabilidad@simeccg.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-17	\N	\N	0
1027	P-0524	INFOENERGY CONSTRUCTORA Y CONSULTORA S.A	04	1792257344001		0990983756	Quito , José Rafael Bustamente E7-62 y el Morán 	business@infoenergy.us	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
1028	P-0525	INDUSTRIA TEXTIL TEXTIRODAL CIA. LTDA. 	04	1091744852001		062909377	Alejandro Andrade 	contador@textirodal.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
1029	P-0526	AGUIRRE MAYORGA JEANETH PAULINA 	04	1707739023001		022523055	Urb. El Bosque , calle Edmundo Carvajal OE-67 	ventas@todolomedico.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-20	\N	\N	0
1030	P-0527	POZO GARCIA TROTSKY LENIN	04	0400808887001		0997284349	Calle Inglaterra y Av. Andrés Bello	tipozo1967@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-28	\N	\N	0
1031	P-0528	RAMIREZ ANDRADE NEURIO MARLON	04	0400798351001		0993996792	Calle Panamericana Norte Km. 147 y Playa de Ambuqu	ramirezmarlon@msn.com	\N	\N	\N	0	0	0	1	1	1	1	2024-05-30	\N	\N	0
1032	T-0148	LUIS ALBERTO TELAG PITACUAR 	05			\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-05-31	\N	\N	0
1033	P-0529	FERNANDEZ AGILA VERONICA LOURDES 	04	1724351844001		062245984	Barrio SOLANDA calle OE4K 	cpepmapatulcan@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-10	\N	\N	0
1034	P-0530	INDUSTRIA MOBILIARIA FERRONOPAL S.A.S	04	1793209001001		0983578124	Pichincha - Quito 	industriasnopalsas@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-11	\N	\N	0
1035	P-0531	CERVANTES TAFUR HENRY DANIEL ( MECNETEL)	04	1002581583001		0984970328	Cdla. del chofer , calles brasil 	henrycervantestafur@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-17	\N	\N	0
1036	T-0149	ÑACASHAG RAMÍREZ ANDERSON DAVID	05		0401835459	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-06-17	\N	\N	0
1037	P-0532	BASTIDAS REYES TITO FERNANDO	04	1713925681001		0995869813	PASJE. Y FCO DEL CAMPO QUITO ECUADOR 	titobastidas@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-19	\N	\N	0
1038	P-0533	SALAZAR MONTENEGRO MARIA STACEY	04	0401583810001		0984698379	Bolivar y Rocafuerte 	orionsoluinfo@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-25	\N	\N	0
1039	P-0534	CUENCA URGILES MARIELA EMPERATRIZ 	04	1709146763001		0992478249	Pichincha Cayambe 	ticsotwareinfomatic@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-25	\N	\N	0
1040	P-0535	YANDUN BOLAÑOS BOLIVAR ANDRES 	04	0401422316001		0984143198	Calles Antonio Jose de Sucre y Av. Brasil 	andresyandun77@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-06-26	\N	\N	0
1041	P-0536	CHICANGO BURBANO  MILTON MAURO	04	0400644506001		0999384587	Calle Colón y Junín	maomil5@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-03	\N	\N	0
1042	P-0537	TUQUERES TUQUERES ALICIA DEL ROCIO 	04	1712831633001		0994253658	Los floripondios y Leonardo Murialdo 	info@digenesis.net	\N	\N	\N	0	0	0	1	1	1	1	2024-07-04	\N	\N	0
1043	E-0162	LIZBETH  BENAVIDES	04			\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-07-05	\N	\N	0
1044	D-0006	RUANO PAREDES ANDRES SANTIAGO	05		0401432349	\N	TULCAN	\N	\N	\N	\N	0	0	0	6	1	1	1	2024-07-08	\N	\N	0
1045	P-0538	ORDOÑEZ CHARFUELAN PIEDAD DEL CARMEN 	04	0400880696001		0979321154	Panamá y Av.Manabi 	carmencharfuelan1967@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-12	\N	\N	0
1046	P-0539	BUESTAN CIA LTDA	04	1790554295001		0984199987	Av. Jose Andrade y Joaquín Mancheno 	gerenciageneral@buestan.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-17	\N	\N	0
1047	P-0540	HARNISTH PINOS ODGUIL ANTONIO 	04	0912538519001		022860188	Los Romeros y Mariana de Jesús 	harpicorp@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-07-18	\N	\N	0
1048	T-0150	DUQUE TUPE JUAN VINICIO 	05		0401206149	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-07-19	\N	\N	0
1049	T-0151	CHENAS PASPUEL LUIS ALFONSO 	05		0400849527	\N	\N	\N	\N	\N	\N	0	0	0	5	1	1	1	2024-07-19	\N	\N	0
1050	P-0541	PARRA ROCHA ANA BELÉN -IMELEC	04	1712841020001		2428003	Pichincha Quito	contabilidad@imelec.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-07-19	\N	\N	0
1051	D-0007	CABRERA ROMERO FLOR ESPERANZA 	04	0601240138001		0983705732	Las Gradas y Jose Maria Urbina 	florcabrera1957@gmail.com	\N	\N	\N	0	0	0	6	1	1	1	2024-07-23	\N	\N	0
1052	E-0163	ORDOÑEZ BOLAÑOS BOLIVAR ALEJANDRO 	05		0401074620	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-07-24	\N	\N	0
1053	C-0011	VALLEJO IBARRA AURELIZA	05		0400376141	062960052	Av. Coaral 59030 y Venezuela	\N	\N	\N	\N	0	0	0	2	1	1	1	2024-08-05	\N	\N	0
1054	P-0542	LALALEO CHAMBA JOSE LUIS 	04	1803532314001		0983117797	VARON DE CARONDELET Y CALLE NUEVE DE OCTUBRE 	gladmarl@outlook.com	\N	\N	\N	0	0	0	1	1	1	1	2024-08-07	\N	\N	0
1055	P-0543	ECUADORDOMAIN S.A	04	1792837626001		0983198683	Av. la Republica E7-55	facturacion@nic.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-08-08	\N	\N	0
1056	P-0544	DAVILA CASTRO PABLO OSWALDO	04	1103739833001		0998072157	Av. Coruña y San Ignacio 	inacapecuador@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-08-15	\N	\N	0
1057	E-0164	VIVANCO ENCARNACIÓN ROSTMAN MANUEL	05		1103673826	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-09-02	\N	\N	0
1058	P-0545	SOTOMAYOR RAMOS SAMUEL AGUSTÍN	04	1707783674001		0991798803	CALLE INTEROCEANICA L72	samuel.sotomayor@hidross.com.ec	\N	\N	\N	0	0	0	1	1	1	1	2024-09-04	\N	\N	0
1059	P-0546	ERAZO TORRES HENRY MARCELO	04	0401558622001		0998559703	Calle Bolívar y General Landázuri	henryet19@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-06	\N	\N	0
1060	P-0547	VALENCIA Y VALENCIA CIA. LTDA.	04	0591722271001		0998330014	Av. Marco Aurelio Subia 6 81 y Calle Loja	valenciayvalencia.bcs@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-10	\N	\N	0
1061	E-0165	CALDERON GUZMAN GENNY TERESA	05		0401580956	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-09-11	\N	\N	0
1062	P-0548	FUENTES ENRIQUEZ DANIEL FERNANDO	04	0401540349001		09878998065	Barrio Las Tejerías y Andrés Bello	dany0900@icloud.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-12	\N	\N	0
1063	I-0029	GAD PQ RURAL JULIO ANDRADE	04	0460022020001		\N	Julio Andrade	\N	\N	\N	\N	0	0	0	3	1	1	1	2024-09-12	\N	\N	0
1064	P-0549	ROSERO LUCERO SANDRA MILENA -DACROS STUDIO	04	0401289020001		0997656360	Flavio Alfaro y 26 de Mayo	dacros@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2024-09-12	\N	\N	0
1065	P-0550	MEXICHEM ECUADOR S.A 	04	0990003769001		043716900	Guayas Parroquia Eloy Alfaro	luis.rosas@wavin.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-13	\N	\N	0
1066	P-0551	ALVAREZ VELEZ LUCERO MISHELL	04	2100956982001		0982622236	Via lago Agrio 	alucero275@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-09-25	\N	\N	0
1067	P-0552	RUEDA RAMIREZ ANDREA MADELEIN	04	0401700778001		0996461976	Avda. Veintimilla y el Carrizal	andrearueda86@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-01	\N	\N	0
1068	P-0553	ENRIQUEZ BOLAÑOS VERONICA ELIZABETH	04	1003780366001		0994932733	Calle Chica Narváez 6-48 y Oviedo	divquez94@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-07	\N	\N	0
1069	P-0554	MIRANDA ARCOS JORGE FERNANDO ( JYM DISTRIBUIDOR)	04	1004633523001		0981187912	Barrio la Quinta Luis Fernando Borja 	miranda.arcos.jorge.fernando@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-15	\N	\N	0
1070	P-0555	BARONA SANCHEZ ALVARO MARTIN	04	1718129552001		09844386288	La Laguna II C12 Mzn 6	albarona93@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-22	\N	\N	0
1071	P-0556	CEVALLOS GUERRERO PEDRO JOSÉ	04	1714257993001		0984596813	Calles La Florida y Av. los Shyris	pjcevallosg1994@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-10-25	\N	\N	0
1072	E-0166	ANDRADE AYALA NICOLE ANDREA	05		1756021927	\N	\N	\N	\N	\N	\N	0	0	0	4	1	1	1	2024-11-06	\N	\N	0
1073	P-0557	LACOV S.A 	04	1891809702001		0958781083	Tunguragua Ambato 	facelectronica@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-12	\N	\N	0
1074	P-0558	MUÑOZ BRAVO FREDDY ARTURO	04	0102087798001		0987876462	Sucre 3-12 y Tomas Ordoñez	fmunozb@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-19	\N	\N	0
1075	P-0559	DELIVERY SUMINISTROS Y SUMINISTROS CIA. LTDA. 	04	1791714032001		6003350	Francisco Salazar E1022 Y Tamayo	soce@suministrosysuministros.com	\N	\N	\N	0	0	0	1	1	1	1	2024-11-20	\N	\N	0
1076	P-0560	CUSANGUA MONTENEGRO EDWIN LUZGARDO	04	0401031810001		0999675717	Av. Cementerio	edwincusangua73@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-04	\N	\N	0
1077	P-0561	CAMPOS HERNANDEZ DANIELA NOHEMI	04	0150550291001		0744215933	Republica de Brasil 	ventas@starinktoner.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-04	\N	\N	0
1078	P-0562	ERAZO HERNANDEZ TITO JAIME 	04	1714816301001		0987335351	Carchi - Tulcan 	info.proytec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-06	\N	\N	0
1079	P-0563	ERAZO Y ERAZO CONSTRUCTORES	04	0491517085001		0991448398	Calle Parguay y Cuenca	oedwineb@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1080	P-0564	DISPRATTSA S.A.	04	0992609575001		0988573771	Cdla. Garzota Solar	facelectronica@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1081	P-0565	ORTIZ LOMAS LUIS ALFREDO	04	0400681185001		0997282643	Calle Sucre y Quito- Tulcán	luisortizing@hotmail.es	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1082	P-0566	AMAZING - GOLDEN -CONSTRUCTIONS S.A.S 	04	0491534369001		0984056079	Calle 8 de diciembre 	patriciodoradou@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-09	\N	\N	0
1083	P-0567	FERRICONS CIA. LTDA. 	04	0491533374001		0982683257	Calle Montúfar y Ricaurte- San Gabriel	ferri.cons.sg@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-12	\N	\N	0
1084	P-0568	ORTEGA VASQUEZ PABLO ANDRES 	04	0401323779001		0993821337	Tulcan. Av. 24 de mayo 	pabloortega2512@hotmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-12	\N	\N	0
1085	P-0569	CONSTRULCAN S.A.S 	04	0491534227001		0986288152	Calle Jose Joaquin Olmedo	construlcanec@gmail.com	\N	\N	\N	0	0	0	1	1	1	1	2024-12-13	\N	\N	0
\.


--
-- TOC entry 5315 (class 0 OID 2988901)
-- Dependencies: 308
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
-- TOC entry 5317 (class 0 OID 2988911)
-- Dependencies: 310
-- Data for Name: ifinan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ifinan (idifinan, codifinan, nomifinan, foto) FROM stdin;
1	00000000	(Ninguno)	\N
74	01600022	BANCO PICHINCHA	\N
2	01600063	BANCO AMAZONAS	\N
3	01600170	BANCO UNIBANCO S.A.	\N
4	01600204	BANCO DE LOS ANDES	\N
5	01600212	BANCO INTERNACIONAL	\N
6	01600303	BANCO PRODUCBANCO	\N
7	01600386	BANCO PROMERICA	\N
8	01600491	BANCO PROCREDIT	\N
9	01600782	BANCO RUMIÑAHUI	\N
10	01600824	BANCO SUDAMERICANO	\N
11	01600832	BANCO COFIEC	\N
12	01600873	BANCO CENTRO MUNDO	\N
13	01600907	BANCO SOLIDARIO	\N
14	02600013	BANCO TERRITORIAL	\N
15	02600021	BANCO DE GUAYAQUIL	\N
16	02600187	BANCO DEL PACIFICO	\N
17	02600344	BANCO BOLIVARIANO	\N
18	02600831	DELBANK	\N
19	02600856	BANCO DEL LITORAL	\N
20	03600186	BANCO DEL AUSTRO	\N
21	59600049	BANCO DE LOJA	\N
22	68600014	BANCO MACHALA	\N
23	75600064	BANCO COMERCIAL DE MANABI	\N
24	01600105	BANCO LLOYDS BANK	\N
25	01600147	BANCO CITY BANK	\N
26	01410034	BANCO DE FOMENTO	\N
27	01500016	BANCO DE LA VIVIENDA	\N
28	01700012	MUTUALISTA PICHINCHA	\N
29	01700020	MUTUALISTA BENALCAZAR	\N
30	03700028	MUTUALISTA AZUAY	\N
31	15700016	MUTUALISTA AMBATO	\N
32	47700018	MUTUALISTA IMBABURA	\N
33	01700417	COOP. PREVISION AHORRO Y DESARROLLO	\N
34	01700418	COOP. ANDALUCIA	\N
35	01700419	COOP. PEQ. EMPRESA DE PASTAZA	\N
36	01700426	COOP. PROGRESO	\N
37	01700427	COOP. 29 DE OCTUBRE	\N
38	01700434	COOP. COTOCOLLAO	\N
39	01700435	COOP. ALIANZA DEL VALLE LTDA.	\N
40	01700436	COOP. CAMARA DE COMERCIO DE QUITO	\N
41	01700880	COOP. DESARROLLO PUEBLOS	\N
42	01700885	COOP. 23 DE JULIO	\N
43	02710218	COOP. NACIONAL	\N
44	02710236	COOP. LA DOLOROSA	\N
45	03700113	COOP. JUV. ECUAT.PROGRESISTA LTDA.	\N
46	15700001	COOP. OSCUS	\N
47	15700017	COOP. EL SAGRARIO	\N
48	15700040	COOP. SAN FRANCISCO	\N
49	19700001	COOP. CACPE BIBLIAN LTDA.	\N
50	43700001	COOP. GUARANDA	\N
51	43700010	COOP. SAN JOSE	\N
52	47700037	COOP. ATUNTAQUI	\N
53	55700005	COOP. 9 DE OCTUBRE LTDA.	\N
54	55700010	COOP. CACPECO	\N
55	59700001	COOP. COOPMEGO	\N
56	59700002	COOP. EL PORVENIR (LOJA)	\N
57	59700003	COOP. PADRE JULIAN LORENTE	\N
58	68700054	COOP. ONCE DE JUNIO	\N
59	68700055	COOP. SANTA ROSA LTDA.	\N
60	75700001	COOP. CHONE LTDA.	\N
61	75710001	COOP. COMERCIO	\N
62	75710002	COOP. SANTA ANA	\N
63	75710003	COOP. CALCETA LTDA.	\N
64	75710004	COOP. 15 DE ABRIL(PORTOVIEJO)	\N
65	79700027	COOP. RIOBAMBA	\N
66	79700028	COOP. JESÚS DEL GRAN PODER	\N
67	89700001	COOP. PABLO MUÑOZ VEGA	\N
68	89700035	COOP. TULCAN	\N
69	15703021	COOP. MUSHUC RUNA	\N
70	79700035	COOP. FERNANDO DAQUILEMA	\N
71	01410036	BANECUADOR	\N
72	03700114	COOP. JARDIN AZUAYO	\N
73	01700511	COOP. DE AH.Y CRED.POLICIA NACIONAL 	\N
\.


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 232
-- Name: beneficiarios_idbene_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.beneficiarios_idbene_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 309
-- Name: gruposbene_idgrupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gruposbene_idgrupo_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 311
-- Name: ifinan_idifinan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ifinan_idifinan_seq', 1, false);


--
-- TOC entry 5165 (class 2606 OID 3139309)
-- Name: beneficiarios beneficiario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiario_pk PRIMARY KEY (idbene);


--
-- TOC entry 5167 (class 2606 OID 3139385)
-- Name: gruposbene gruposbene_pk_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gruposbene
    ADD CONSTRAINT gruposbene_pk_1 PRIMARY KEY (idgrupo);


--
-- TOC entry 5169 (class 2606 OID 3139387)
-- Name: ifinan ifinan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ifinan
    ADD CONSTRAINT ifinan_pk PRIMARY KEY (idifinan);


-- Completed on 2025-01-20 21:18:34

--
-- PostgreSQL database dump complete
--

