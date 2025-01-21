--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-01-18 19:57:04

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
-- TOC entry 431 (class 1259 OID 3140076)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    idcargo integer NOT NULL,
    descripcion character varying NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    sueldo numeric
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 436 (class 1259 OID 3140131)
-- Name: cargos_idcargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cargos ALTER COLUMN idcargo ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cargos_idcargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 432 (class 1259 OID 3140089)
-- Name: contemergencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contemergencia (
    idcontemergencia integer NOT NULL,
    nombre character varying NOT NULL,
    celular character varying NOT NULL,
    parentesco character varying
);


ALTER TABLE public.contemergencia OWNER TO postgres;

--
-- TOC entry 434 (class 1259 OID 3140129)
-- Name: contemergencia_idcontemergencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contemergencia ALTER COLUMN idcontemergencia ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contemergencia_idcontemergencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 433 (class 1259 OID 3140096)
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
    idpersonal integer NOT NULL,
    nombres character varying NOT NULL,
    apellidos character varying NOT NULL,
    identificacion character varying,
    email character varying,
    celular character varying,
    direccion character varying,
    idcontemergencia_contemergencias integer,
    idcargo_cargos integer,
    idtpcontrato_tpcontratos integer,
    usucrea integer NOT NULL,
    feccrea date NOT NULL,
    usumodi integer,
    fecmodi date,
    estado boolean DEFAULT true NOT NULL,
    codigo character varying,
    fecnacimiento date NOT NULL
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- TOC entry 435 (class 1259 OID 3140130)
-- Name: personal_idpersonal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.personal ALTER COLUMN idpersonal ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personal_idpersonal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 430 (class 1259 OID 3140069)
-- Name: tpcontratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tpcontratos (
    idtpcontratos integer NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE public.tpcontratos OWNER TO postgres;

--
-- TOC entry 437 (class 1259 OID 3140132)
-- Name: tpcontratos_idtpcontratos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tpcontratos ALTER COLUMN idtpcontratos ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tpcontratos_idtpcontratos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5299 (class 0 OID 3140076)
-- Dependencies: 431
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (idcargo, descripcion, estado, sueldo) FROM stdin;
1	Gerente general	t	0.00
2	Director comercial	t	0
3	Asesor legal	t	0
4	Jefe de coactivas	t	0
\.


--
-- TOC entry 5300 (class 0 OID 3140089)
-- Dependencies: 432
-- Data for Name: contemergencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contemergencia (idcontemergencia, nombre, celular, parentesco) FROM stdin;
1	NINGUNO	0000000000	NINGUNO
2	Annie Guerrero	0995533429	Esposa
3	Fabio	0986411421	Primo
4	Miguel Guerrero	099907001	Hermano
5	javier ortiz	2942738	wife
6	asdfasdf	asdf	asdf
7	oooooo	5555	5555
8	aaaaaaaaaaaa	d233333	4444444
\.


--
-- TOC entry 5301 (class 0 OID 3140096)
-- Dependencies: 433
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal (idpersonal, nombres, apellidos, identificacion, email, celular, direccion, idcontemergencia_contemergencias, idcargo_cargos, idtpcontrato_tpcontratos, usucrea, feccrea, usumodi, fecmodi, estado, codigo, fecnacimiento) FROM stdin;
1	DELGADO	DIEGO	046586654	diego@gmail.com	0985225458	Tulcan	8	2	4	1	2025-01-16	\N	\N	t	045545	1990-12-16
\.


--
-- TOC entry 5298 (class 0 OID 3140069)
-- Dependencies: 430
-- Data for Name: tpcontratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tpcontratos (idtpcontratos, descripcion) FROM stdin;
1	Nombramiento permanente
2	Nombramiento provisional
3	Indefinido
4	Temporal
5	Formación y aprendizaje
6	Prácticas
7	Obra o servicio
\.


--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 436
-- Name: cargos_idcargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargos_idcargo_seq', 1, false);


--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 434
-- Name: contemergencia_idcontemergencia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contemergencia_idcontemergencia_seq', 8, true);


--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 435
-- Name: personal_idpersonal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_idpersonal_seq', 1, true);


--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 437
-- Name: tpcontratos_idtpcontratos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tpcontratos_idtpcontratos_seq', 1, false);


--
-- TOC entry 5147 (class 2606 OID 3140083)
-- Name: cargos cargos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pk PRIMARY KEY (idcargo);


--
-- TOC entry 5149 (class 2606 OID 3140095)
-- Name: contemergencia contemergencia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contemergencia
    ADD CONSTRAINT contemergencia_pk PRIMARY KEY (idcontemergencia);


--
-- TOC entry 5151 (class 2606 OID 3140102)
-- Name: personal personal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pk PRIMARY KEY (idpersonal);


--
-- TOC entry 5145 (class 2606 OID 3140075)
-- Name: tpcontratos tpcontratos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tpcontratos
    ADD CONSTRAINT tpcontratos_pk PRIMARY KEY (idtpcontratos);


--
-- TOC entry 5152 (class 2606 OID 3140113)
-- Name: personal personal_cargos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_cargos_fk FOREIGN KEY (idcargo_cargos) REFERENCES public.cargos(idcargo);


--
-- TOC entry 5153 (class 2606 OID 3140108)
-- Name: personal personal_contemergencia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_contemergencia_fk FOREIGN KEY (idcontemergencia_contemergencias) REFERENCES public.contemergencia(idcontemergencia);


--
-- TOC entry 5154 (class 2606 OID 3140123)
-- Name: personal personal_tpcontratos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_tpcontratos_fk FOREIGN KEY (idtpcontrato_tpcontratos) REFERENCES public.tpcontratos(idtpcontratos);


-- Completed on 2025-01-18 19:57:04

--
-- PostgreSQL database dump complete
--

