-- public.niveles definition

-- Drop table

-- DROP TABLE public.niveles;

CREATE TABLE public.niveles ( idnivel smallserial NOT NULL, nomniv varchar(50) NOT NULL, longniv int2 NOT NULL, CONSTRAINT niveles_pk PRIMARY KEY (idnivel));
-- public.ifinan definition

-- Drop table

-- DROP TABLE public.ifinan;

CREATE TABLE public.ifinan ( idifinan serial4 NOT NULL, codifinan varchar(8) NOT NULL, nomifinan varchar(40) NOT NULL, foto varchar(40) NULL);

-- public.estructura definition

-- Drop table

-- DROP TABLE public.estructura;

CREATE TABLE public.estructura ( idestructura smallserial NOT NULL, nivel int2 NOT NULL, nombre varchar(50) NOT NULL, longitud int2 NOT NULL, CONSTRAINT estructura_pk PRIMARY KEY (idestructura));

-- public.clasificador definition

-- Drop table

-- DROP TABLE public.clasificador;

CREATE TABLE public.clasificador ( idclasificador serial4 NOT NULL, codpar varchar(8) NOT NULL, nivpar int2 NOT NULL, grupar varchar(12) NOT NULL, nompar varchar(151) NOT NULL, despar varchar(500) NULL, cueejepresu varchar(35) NULL, presupuesto float8 DEFAULT 0 NULL, ejecucion float8 DEFAULT 0 NULL, devengado float8 DEFAULT 0 NULL, reforma float8 DEFAULT 0 NULL, asigna_ini float8 DEFAULT 0 NULL, grupo bpchar(2) NULL, balancostos int2 NULL, usucrea int4 NOT NULL, feccrea timestamp NOT NULL, usumodi int4 NULL, fecmodi timestamp NULL, CONSTRAINT clasificador_pk PRIMARY KEY (idclasificador), CONSTRAINT uc_codpar UNIQUE (codpar));
-- public.beneficiarios definition

-- Drop table

-- DROP TABLE public.beneficiarios;

CREATE TABLE public.beneficiarios ( idbene serial4 NOT NULL, codben varchar(10) NOT NULL, nomben varchar(100) NOT NULL, tpidben bpchar(2) DEFAULT '04'::bpchar NOT NULL, rucben varchar(13) NOT NULL, ciben varchar(10) NULL, tlfben varchar(20) DEFAULT NULL::character varying NULL, dirben varchar(50) DEFAULT NULL::character varying NULL, mailben varchar(80) DEFAULT NULL::character varying NULL, tpcueben int2 DEFAULT '1'::smallint NULL, cuebanben varchar(18) DEFAULT NULL::character varying NULL, foto varchar(30) DEFAULT NULL::character varying NULL, b1 float8 DEFAULT '0'::double precision NULL, b2 float8 DEFAULT '0'::double precision NULL, b3 float8 DEFAULT '0'::double precision NULL, idgrupo int4 DEFAULT 1 NOT NULL, idifinan int4 DEFAULT 1 NOT NULL, modulo varchar(10) NOT NULL, usucrea int4 NOT NULL, feccrea date NOT NULL, usumodi int4 NULL, fecmodi date NULL, swconsufin int2 DEFAULT '0'::smallint NULL);
-- public.gruposbene definition

-- Drop table

-- DROP TABLE public.gruposbene;

CREATE TABLE public.gruposbene ( idgrupo serial4 NOT NULL, codgru bpchar(1) NOT NULL, nomgru varchar(30) NOT NULL, modulo1 int2 DEFAULT 1 NULL, modulo2 int2 DEFAULT 0 NULL, modulo3 int2 DEFAULT 0 NULL, modulo4 int2 DEFAULT 0 NULL, modulo5 int2 DEFAULT 0 NULL, modulo6 int2 DEFAULT 0 NULL);
-- public.proyectos definition

-- Drop table

-- DROP TABLE public.proyectos;

CREATE TABLE public.proyectos ( idproyecto serial4 NOT NULL, codigo varchar(20) NOT NULL, nombre varchar(50) NOT NULL, movimiento bool NOT NULL, idestructura int8 NOT NULL, usucrea int4 NULL, feccrea timestamp NULL, usumodi int4 NULL, fecmodi timestamp NULL, CONSTRAINT estrfunc_pk PRIMARY KEY (idproyecto));


-- public.proyectos foreign keys

ALTER TABLE public.proyectos ADD CONSTRAINT estrfunc_estructura_fk FOREIGN KEY (idestructura) REFERENCES public.estructura(idestructura) ON DELETE CASCADE ON UPDATE CASCADE;
-- public.presupuesto definition

-- Drop table

-- DROP TABLE public.presupuesto;

CREATE TABLE public.presupuesto ( idpresupuesto serial4 NOT NULL, tippar int2 NOT NULL, codpar varchar(35) NOT NULL, codigo varchar(25) NOT NULL, nompar varchar(100) NOT NULL, inicia float8 DEFAULT 0 NOT NULL, totmod float8 DEFAULT 0 NOT NULL, totcerti float8 DEFAULT 0 NOT NULL, totmisos float8 DEFAULT 0 NOT NULL, totdeven float8 DEFAULT 0 NOT NULL, arrastre float8 DEFAULT 0 NOT NULL, arrastreaa float8 DEFAULT 0 NOT NULL, idproyecto int2 NOT NULL, idclasificador int4 NOT NULL, usucrea int2 NOT NULL, feccrea timestamp NOT NULL, usumodi int2 NULL, fecmodi timestamp NULL, CONSTRAINT presupue_pk PRIMARY KEY (idpresupuesto));


-- public.presupuesto foreign keys

ALTER TABLE public.presupuesto ADD CONSTRAINT presupuesto_clasificador_fk FOREIGN KEY (idclasificador) REFERENCES public.clasificador(idclasificador);
ALTER TABLE public.presupuesto ADD CONSTRAINT presupuesto_proyectos_fk FOREIGN KEY (idproyecto) REFERENCES public.proyectos(idproyecto);

