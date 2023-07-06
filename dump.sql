--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5b6a710b559a66b9666b191059da965f8';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 12.15

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

--
-- PostgreSQL database dump complete
--

--
-- Database "genesysdb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 12.15

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

--
-- Name: genesysdb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE genesysdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE genesysdb OWNER TO postgres;

\connect genesysdb

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity (
    name character varying(160) NOT NULL,
    secondary_id character varying(80) NOT NULL,
    nb_entities_out integer,
    parent_id uuid,
    project_id uuid NOT NULL,
    entity_type_id uuid NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.entity OWNER TO postgres;

--
-- Name: entity_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_link (
    entity_in_id uuid NOT NULL,
    entity_out_id uuid NOT NULL,
    nb_occurences integer,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.entity_link OWNER TO postgres;

--
-- Name: entity_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_type (
    name character varying(30) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.entity_type OWNER TO postgres;

--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    name character varying(80) NOT NULL,
    task_id uuid NOT NULL,
    software_version_id uuid NOT NULL,
    suffix character varying(20),
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.file OWNER TO postgres;

--
-- Name: file_tool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_tool (
    file_id uuid,
    tool_id uuid
);


ALTER TABLE public.file_tool OWNER TO postgres;

--
-- Name: milestone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.milestone (
    date date,
    name character varying(40) NOT NULL,
    project_id uuid,
    svn_revision integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.milestone OWNER TO postgres;

--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    secondary_id character varying(80) NOT NULL,
    name character varying(80) NOT NULL,
    project_status_id uuid,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: project_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_status (
    name character varying(20) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.project_status OWNER TO postgres;

--
-- Name: project_tool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_tool (
    project_id uuid,
    tool_id uuid
);


ALTER TABLE public.project_tool OWNER TO postgres;

--
-- Name: software; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software (
    name character varying(80) NOT NULL,
    extension character varying(20) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.software OWNER TO postgres;

--
-- Name: software_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software_version (
    software_id uuid NOT NULL,
    version character varying(20) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.software_version OWNER TO postgres;

--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    name character varying(80) NOT NULL,
    secondary_id character varying(80) NOT NULL,
    entity_id uuid NOT NULL,
    project_id uuid,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.task OWNER TO postgres;

--
-- Name: tool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool (
    name character varying(80) NOT NULL,
    tool_type_id uuid NOT NULL,
    software_version_id uuid,
    version character varying(20) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.tool OWNER TO postgres;

--
-- Name: tool_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_type (
    name character varying(30) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.tool_type OWNER TO postgres;

--
-- Name: version_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.version_log (
    name character varying(80) NOT NULL,
    file_id uuid,
    svn_revision integer NOT NULL,
    comment character varying(80) NOT NULL,
    auther character varying(80) NOT NULL,
    date timestamp without time zone NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.version_log OWNER TO postgres;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
2398bdae41dc
\.


--
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity (name, secondary_id, nb_entities_out, parent_id, project_id, entity_type_id, id, created_at, updated_at) FROM stdin;
ant	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	0	\N	8ee3e59f-951d-4fda-8651-38659469d090	8a08ebdd-7949-492d-aa5b-be22e3380661	01e180eb-931a-4920-ba51-8fb2032032fd	2023-06-21 14:21:53.030174	2023-06-21 14:21:53.030176
\.


--
-- Data for Name: entity_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_link (entity_in_id, entity_out_id, nb_occurences, id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: entity_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_type (name, id, created_at, updated_at) FROM stdin;
character	8a08ebdd-7949-492d-aa5b-be22e3380661	2023-06-21 14:19:32.811923	2023-06-21 14:19:32.811926
prop	07ad61a3-6636-4b68-b618-67baccd68bcc	2023-06-21 14:19:32.816681	2023-06-21 14:19:32.816684
environment	7590b177-3b16-4a87-a81e-68299ba84289	2023-06-21 14:19:32.819691	2023-06-21 14:19:32.819695
fx	a372b963-a32e-49b9-96d1-1346d0218f72	2023-06-21 14:19:32.822775	2023-06-21 14:19:32.822779
set	72823fe3-6c00-4070-841c-f6aab82df009	2023-06-21 14:19:32.825558	2023-06-21 14:19:32.825561
shot	6ca02880-a796-467b-99db-756df41abf6a	2023-06-21 14:19:32.828313	2023-06-21 14:19:32.828316
sequence	da5ba2b2-1abe-4987-b34c-128ad760e713	2023-06-21 14:19:32.831245	2023-06-21 14:19:32.831248
episode	9f710d57-218b-434f-865e-518fa1bb379e	2023-06-21 14:19:32.833991	2023-06-21 14:19:32.833994
edit	d2cbe8d3-fe22-4beb-9919-5bdfb7707dae	2023-06-21 14:19:32.836979	2023-06-21 14:19:32.836983
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file (name, task_id, software_version_id, suffix, id, created_at, updated_at) FROM stdin;
ant_modeling	892aec19-84a8-4643-b9ad-0cdbbc22414b	53dd077b-c4d4-4f66-9c3c-2cbd1249bf05		a5a7264b-bd1e-4353-8ac7-6343330037af	2023-06-21 14:21:53.222068	2023-06-21 14:21:53.222071
ant_rigging	41eeed8d-02be-4d67-9344-eaca41370f5d	53dd077b-c4d4-4f66-9c3c-2cbd1249bf05		c0732424-125f-46bc-8211-aa7db5e8fdd7	2023-06-21 14:21:53.382024	2023-06-21 14:21:53.382028
ant_shading	49035866-6d27-46ed-a778-28b437f17584	53dd077b-c4d4-4f66-9c3c-2cbd1249bf05		594d6d5e-8318-457b-b576-de04f704f849	2023-06-21 14:21:53.530222	2023-06-21 14:21:53.530225
ant_concept	9300265d-f6c3-49d3-984c-b144b97ed3da	53dd077b-c4d4-4f66-9c3c-2cbd1249bf05		f29cc7b3-4b43-4648-8bd3-3e7311864711	2023-06-21 14:21:53.686796	2023-06-21 14:21:53.686799
\.


--
-- Data for Name: file_tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file_tool (file_id, tool_id) FROM stdin;
\.


--
-- Data for Name: milestone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.milestone (date, name, project_id, svn_revision, id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (secondary_id, name, project_status_id, id, created_at, updated_at) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	Project Animals	d38ca130-014c-4227-9818-215391a59fb4	8ee3e59f-951d-4fda-8651-38659469d090	2023-06-21 14:21:43.963515	2023-06-21 14:21:43.96352
\.


--
-- Data for Name: project_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_status (name, id, created_at, updated_at) FROM stdin;
Open	d38ca130-014c-4227-9818-215391a59fb4	2023-06-21 14:19:32.794639	2023-06-21 14:19:32.793147
Closed	3a3072c6-0d08-49b3-807b-351ecfe23f26	2023-06-21 14:19:32.802163	2023-06-21 14:19:32.801746
Achieved	88270bf8-4ee1-4f7d-8a5c-6a39c08173b1	2023-06-21 14:19:32.806685	2023-06-21 14:19:32.806442
\.


--
-- Data for Name: project_tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_tool (project_id, tool_id) FROM stdin;
\.


--
-- Data for Name: software; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.software (name, extension, id, created_at, updated_at) FROM stdin;
blender	blend	8b1dfcbf-a3a2-442d-a341-f9dfc3d8e374	2023-06-21 14:19:32.857646	2023-06-21 14:19:32.857651
affinity Designer	afdesign	5f7cdcb5-35c5-4191-8886-10e190d86906	2023-06-21 14:19:32.861943	2023-06-21 14:19:32.861946
fL studio	flp	bcac1080-0017-49c6-8ba1-242ed8f88b02	2023-06-21 14:19:32.86578	2023-06-21 14:19:32.865785
clip studio paint	clip	120f2aa3-901c-49e7-8c9c-cd0435e67d77	2023-06-21 14:19:32.871363	2023-06-21 14:19:32.871367
sketch book	tif	cb977d1d-f535-4ee2-b90a-1f7b445fcd76	2023-06-21 14:19:32.87531	2023-06-21 14:19:32.875314
\.


--
-- Data for Name: software_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.software_version (software_id, version, id, created_at, updated_at) FROM stdin;
8b1dfcbf-a3a2-442d-a341-f9dfc3d8e374	2.80	53dd077b-c4d4-4f66-9c3c-2cbd1249bf05	2023-06-21 14:19:32.887974	2023-06-21 14:19:32.890277
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (name, secondary_id, entity_id, project_id, id, created_at, updated_at) FROM stdin;
ant_modeling	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	01e180eb-931a-4920-ba51-8fb2032032fd	8ee3e59f-951d-4fda-8651-38659469d090	892aec19-84a8-4643-b9ad-0cdbbc22414b	2023-06-21 14:21:53.194394	2023-06-21 14:21:53.19195
ant_rigging	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	01e180eb-931a-4920-ba51-8fb2032032fd	8ee3e59f-951d-4fda-8651-38659469d090	41eeed8d-02be-4d67-9344-eaca41370f5d	2023-06-21 14:21:53.369007	2023-06-21 14:21:53.367889
ant_shading	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	01e180eb-931a-4920-ba51-8fb2032032fd	8ee3e59f-951d-4fda-8651-38659469d090	49035866-6d27-46ed-a778-28b437f17584	2023-06-21 14:21:53.51868	2023-06-21 14:21:53.518188
ant_concept	67492971-ef53-4a46-8554-5c6248341169	01e180eb-931a-4920-ba51-8fb2032032fd	8ee3e59f-951d-4fda-8651-38659469d090	9300265d-f6c3-49d3-984c-b144b97ed3da	2023-06-21 14:21:53.675437	2023-06-21 14:21:53.674934
\.


--
-- Data for Name: tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool (name, tool_type_id, software_version_id, version, id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tool_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_type (name, id, created_at, updated_at) FROM stdin;
software	83fa2ada-950d-4873-bdac-35b3ad6a4291	2023-06-21 14:19:32.842081	2023-06-21 14:19:32.842086
hardware	6318ea59-6fce-4b23-b45a-fe1c6ea0cea7	2023-06-21 14:19:32.846161	2023-06-21 14:19:32.846164
service	e188deb9-903a-4a30-94e0-7db863c3770f	2023-06-21 14:19:32.84967	2023-06-21 14:19:32.849675
plugin	23b82878-562f-451a-be02-02d6eace1eca	2023-06-21 14:19:32.852846	2023-06-21 14:19:32.852849
\.


--
-- Data for Name: version_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.version_log (name, file_id, svn_revision, comment, auther, date, id, created_at, updated_at) FROM stdin;
\.


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: entity_link entity_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_pkey PRIMARY KEY (entity_in_id, entity_out_id, id);


--
-- Name: entity_link entity_link_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_uc UNIQUE (entity_in_id, entity_out_id);


--
-- Name: entity entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: entity_type entity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_type
    ADD CONSTRAINT entity_type_pkey PRIMARY KEY (id);


--
-- Name: entity entity_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_uc UNIQUE (name, project_id, entity_type_id);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- Name: file file_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_uc UNIQUE (name, suffix, task_id);


--
-- Name: milestone milestone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_pkey PRIMARY KEY (id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_status project_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_status
    ADD CONSTRAINT project_status_pkey PRIMARY KEY (id);


--
-- Name: software software_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pkey PRIMARY KEY (id);


--
-- Name: software_version software_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software_version
    ADD CONSTRAINT software_version_pkey PRIMARY KEY (id);


--
-- Name: software_version software_version_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software_version
    ADD CONSTRAINT software_version_uc UNIQUE (version, software_id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: task task_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_uc UNIQUE (name, project_id, entity_id);


--
-- Name: tool tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool
    ADD CONSTRAINT tool_pkey PRIMARY KEY (id);


--
-- Name: tool_type tool_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_type
    ADD CONSTRAINT tool_type_pkey PRIMARY KEY (id);


--
-- Name: version_log version_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.version_log
    ADD CONSTRAINT version_log_pkey PRIMARY KEY (id);


--
-- Name: ix_entity_entity_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_entity_type_id ON public.entity USING btree (entity_type_id);


--
-- Name: ix_entity_link_entity_in_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_link_entity_in_id ON public.entity_link USING btree (entity_in_id);


--
-- Name: ix_entity_link_entity_out_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_link_entity_out_id ON public.entity_link USING btree (entity_out_id);


--
-- Name: ix_entity_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_name ON public.entity USING btree (name);


--
-- Name: ix_entity_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_parent_id ON public.entity USING btree (parent_id);


--
-- Name: ix_entity_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_project_id ON public.entity USING btree (project_id);


--
-- Name: ix_entity_secondary_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_entity_secondary_id ON public.entity USING btree (secondary_id);


--
-- Name: ix_entity_type_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_entity_type_name ON public.entity_type USING btree (name);


--
-- Name: ix_file_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_name ON public.file USING btree (name);


--
-- Name: ix_file_software_version_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_software_version_id ON public.file USING btree (software_version_id);


--
-- Name: ix_file_suffix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_suffix ON public.file USING btree (suffix);


--
-- Name: ix_file_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_task_id ON public.file USING btree (task_id);


--
-- Name: ix_file_tool_file_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_tool_file_id ON public.file_tool USING btree (file_id);


--
-- Name: ix_file_tool_tool_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_file_tool_tool_id ON public.file_tool USING btree (tool_id);


--
-- Name: ix_milestone_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_milestone_project_id ON public.milestone USING btree (project_id);


--
-- Name: ix_project_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_project_name ON public.project USING btree (name);


--
-- Name: ix_project_project_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_project_project_status_id ON public.project USING btree (project_status_id);


--
-- Name: ix_project_secondary_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_project_secondary_id ON public.project USING btree (secondary_id);


--
-- Name: ix_project_status_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_project_status_name ON public.project_status USING btree (name);


--
-- Name: ix_project_tool_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_project_tool_project_id ON public.project_tool USING btree (project_id);


--
-- Name: ix_project_tool_tool_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_project_tool_tool_id ON public.project_tool USING btree (tool_id);


--
-- Name: ix_software_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_software_name ON public.software USING btree (name);


--
-- Name: ix_software_version_software_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_software_version_software_id ON public.software_version USING btree (software_id);


--
-- Name: ix_task_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_entity_id ON public.task USING btree (entity_id);


--
-- Name: ix_task_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_task_name ON public.task USING btree (name);


--
-- Name: ix_task_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_project_id ON public.task USING btree (project_id);


--
-- Name: ix_task_secondary_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_task_secondary_id ON public.task USING btree (secondary_id);


--
-- Name: ix_tool_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_tool_name ON public.tool USING btree (name);


--
-- Name: ix_tool_software_version_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tool_software_version_id ON public.tool USING btree (software_version_id);


--
-- Name: ix_tool_tool_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tool_tool_type_id ON public.tool USING btree (tool_type_id);


--
-- Name: ix_tool_type_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_tool_type_name ON public.tool_type USING btree (name);


--
-- Name: ix_version_log_auther; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_version_log_auther ON public.version_log USING btree (auther);


--
-- Name: ix_version_log_comment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_version_log_comment ON public.version_log USING btree (comment);


--
-- Name: ix_version_log_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_version_log_date ON public.version_log USING btree (date);


--
-- Name: ix_version_log_file_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_version_log_file_id ON public.version_log USING btree (file_id);


--
-- Name: ix_version_log_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_version_log_name ON public.version_log USING btree (name);


--
-- Name: entity entity_entity_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_entity_type_id_fkey FOREIGN KEY (entity_type_id) REFERENCES public.entity_type(id);


--
-- Name: entity_link entity_link_entity_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_entity_in_id_fkey FOREIGN KEY (entity_in_id) REFERENCES public.entity(id);


--
-- Name: entity_link entity_link_entity_out_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_entity_out_id_fkey FOREIGN KEY (entity_out_id) REFERENCES public.entity(id);


--
-- Name: entity entity_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.entity(id);


--
-- Name: entity entity_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: file file_software_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_software_version_id_fkey FOREIGN KEY (software_version_id) REFERENCES public.software_version(id);


--
-- Name: file file_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: file_tool file_tool_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_tool
    ADD CONSTRAINT file_tool_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(id);


--
-- Name: file_tool file_tool_tool_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_tool
    ADD CONSTRAINT file_tool_tool_id_fkey FOREIGN KEY (tool_id) REFERENCES public.tool(id);


--
-- Name: milestone milestone_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project project_project_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_project_status_id_fkey FOREIGN KEY (project_status_id) REFERENCES public.project_status(id);


--
-- Name: project_tool project_tool_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_tool
    ADD CONSTRAINT project_tool_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_tool project_tool_tool_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_tool
    ADD CONSTRAINT project_tool_tool_id_fkey FOREIGN KEY (tool_id) REFERENCES public.tool(id);


--
-- Name: software_version software_version_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software_version
    ADD CONSTRAINT software_version_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(id);


--
-- Name: task task_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: task task_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: tool tool_software_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool
    ADD CONSTRAINT tool_software_version_id_fkey FOREIGN KEY (software_version_id) REFERENCES public.software_version(id);


--
-- Name: tool tool_tool_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool
    ADD CONSTRAINT tool_tool_type_id_fkey FOREIGN KEY (tool_type_id) REFERENCES public.tool_type(id);


--
-- Name: version_log version_log_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.version_log
    ADD CONSTRAINT version_log_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 12.15

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

--
-- PostgreSQL database dump complete
--

--
-- Database "turbomeddb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 12.15

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

--
-- Name: turbomeddb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE turbomeddb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE turbomeddb OWNER TO postgres;

\connect turbomeddb

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: login_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_log (
    person_id uuid NOT NULL,
    date timestamp without time zone NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.login_log OWNER TO postgres;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    person_id uuid NOT NULL,
    past_medical_history text,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- Name: patient_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_type (
    name character varying(80) NOT NULL,
    description character varying(200) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.patient_type OWNER TO postgres;

--
-- Name: patient_type_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_type_link (
    patient_id uuid,
    patient_type_id uuid
);


ALTER TABLE public.patient_type_link OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    first_name character varying(80) NOT NULL,
    last_name character varying(80) NOT NULL,
    other_name character varying(80),
    date_of_birth date,
    marital_status character varying(255),
    email character varying(255),
    secondary_email character varying(255),
    phone character varying(30),
    secondary_phone character varying(30),
    street character varying(80),
    city character varying(80),
    state character varying(80),
    zip_code character varying(10),
    country character varying(80),
    active boolean,
    archived boolean,
    last_presence date,
    password bytea,
    login_failed_attemps integer,
    last_login_failed timestamp without time zone,
    timezone character varying(50),
    locale character varying(10),
    data jsonb,
    has_avatar boolean,
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    totp_enabled boolean,
    totp_secret character varying(32),
    email_otp_enabled boolean,
    email_otp_secret character varying(32)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
d90551a2975d
\.


--
-- Data for Name: login_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_log (person_id, date, id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient (person_id, past_medical_history, id, created_at, updated_at) FROM stdin;
004d739d-d103-4c03-90f4-1809c77bfd19	\N	c99f2277-7ac8-4b96-a061-18985102826b	2023-07-04 12:01:24.398253	2023-07-04 12:01:24.398253
\.


--
-- Data for Name: patient_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient_type (name, description, id, created_at, updated_at) FROM stdin;
acute	Acute patients have a sudden onset of symptoms and typically require immediate medical attention	0c088009-f96e-40c3-ac8b-6e0c32876f2c	2023-07-03 16:31:59.8263	2023-07-03 16:31:59.8263
chronic	Chronic patients have long-term or recurring conditions that require ongoing management	5b69c8f0-436f-4013-9e91-9216790f936f	2023-07-03 16:31:59.8353	2023-07-03 16:31:59.8353
pediatric	Pediatric patients are typically defined as those who have not reached the age of 18	0d96be43-2338-44d9-87fb-5e92b2ef32c3	2023-07-03 16:31:59.840298	2023-07-03 16:31:59.840298
adult	Adult are over age of 18	69e1bba8-1511-4782-a82e-b7f7e8b31ded	2023-07-03 16:31:59.8453	2023-07-03 16:31:59.8453
geriatric	Geriatric patients are elderly individuals who require specialized care due to age-related conditions, multiple chronic illnesses, or functional limitations associated with aging	933d6d39-9742-42c4-ab61-a0a915ccd919	2023-07-03 16:31:59.8503	2023-07-03 16:31:59.8503
surgical	Surgical patients have conditions or injuries that necessitate a surgical procedure	0def94cf-2d36-4f6f-95dd-beac386b737d	2023-07-03 16:31:59.855301	2023-07-03 16:31:59.855301
non-surgical	non-surgical patients may receive medical treatment, medication, or other non-invasive interventions.	36882b00-51ba-47ef-8c79-7be9f79989be	2023-07-03 16:31:59.89817	2023-07-03 16:31:59.89817
emergency	Emergency patients are those who require immediate medical attention due to life-threatening conditions or severe injuries. 	677d0efc-fcb7-4e9e-9e39-0f823a94cbba	2023-07-03 16:31:59.915168	2023-07-03 16:31:59.915168
mental health	Patients with mental health conditions, such as depression, anxiety disorders, bipolar disorder, or schizophrenia, fall into this category	5704c6f7-1b7f-4b99-8748-43e08b0b8e0a	2023-07-03 16:31:59.921167	2023-07-03 16:31:59.921167
specialty care	Specialty care patients require the expertise of specialists in specific medical fields to address complex or specialized health conditions	97bc0428-3ddb-4cc0-b110-d76aff850459	2023-07-03 16:31:59.926168	2023-07-03 16:31:59.926168
primary care	Primary care patients receive routine and general healthcare services	95a22976-710e-4b4a-81b2-511f4160e2b5	2023-07-03 16:31:59.931168	2023-07-03 16:31:59.931168
\.


--
-- Data for Name: patient_type_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient_type_link (patient_id, patient_type_id) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (first_name, last_name, other_name, date_of_birth, marital_status, email, secondary_email, phone, secondary_phone, street, city, state, zip_code, country, active, archived, last_presence, password, login_failed_attemps, last_login_failed, timezone, locale, data, has_avatar, id, created_at, updated_at, totp_enabled, totp_secret, email_otp_enabled, email_otp_secret) FROM stdin;
bolu	abatan	09098764321	2019-09-04	single	bolu@eaxum.com	\N	\N	cail@eac.com	1, aiyegbami	sango ota	ogun state	134267	Nigeria	t	f	\N	\\x243262243132246c4c66564f2f66422f5553617537586a5a396a57662e4f6c6e467975766c426f48484f534c567a474a494336417461336850755765	0	\N	Europe/Paris	en_US	\N	f	004d739d-d103-4c03-90f4-1809c77bfd19	2023-07-04 12:01:24.378263	2023-07-04 12:01:24.378263	\N	\N	\N	\N
\.


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: login_log login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_log
    ADD CONSTRAINT login_log_pkey PRIMARY KEY (id);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- Name: patient_type patient_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_type
    ADD CONSTRAINT patient_type_pkey PRIMARY KEY (id);


--
-- Name: person person_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_email_key UNIQUE (email);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: person person_secondary_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_secondary_email_key UNIQUE (secondary_email);


--
-- Name: ix_login_log_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_login_log_person_id ON public.login_log USING btree (person_id);


--
-- Name: login_log login_log_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_log
    ADD CONSTRAINT login_log_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: patient patient_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: patient_type_link patient_type_link_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_type_link
    ADD CONSTRAINT patient_type_link_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(id);


--
-- Name: patient_type_link patient_type_link_patient_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_type_link
    ADD CONSTRAINT patient_type_link_patient_type_id_fkey FOREIGN KEY (patient_type_id) REFERENCES public.patient_type(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "zoudb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 12.15

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

--
-- Name: zoudb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE zoudb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE zoudb OWNER TO postgres;

\connect zoudb

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

--
-- Name: import_source_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.import_source_enum AS ENUM (
    'csv',
    'shotgun'
);


ALTER TYPE public.import_source_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: api_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_event (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    user_id uuid,
    data jsonb,
    project_id uuid
);


ALTER TABLE public.api_event OWNER TO postgres;

--
-- Name: asset_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_instance (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    asset_id uuid NOT NULL,
    entity_id uuid,
    entity_type_id uuid,
    name character varying(80),
    number integer,
    description character varying(200),
    data jsonb,
    active boolean,
    scene_id uuid,
    target_asset_id uuid
);


ALTER TABLE public.asset_instance OWNER TO postgres;

--
-- Name: asset_instance_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_instance_link (
    entity_id uuid NOT NULL,
    asset_instance_id uuid NOT NULL
);


ALTER TABLE public.asset_instance_link OWNER TO postgres;

--
-- Name: assignations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignations (
    task uuid NOT NULL,
    person uuid NOT NULL
);


ALTER TABLE public.assignations OWNER TO postgres;

--
-- Name: attachment_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment_file (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(250),
    size integer,
    extension character varying(6),
    comment_id uuid,
    mimetype character varying(255)
);


ALTER TABLE public.attachment_file OWNER TO postgres;

--
-- Name: build_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.build_job (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    status character varying(255),
    job_type character varying(255),
    ended_at timestamp without time zone,
    playlist_id uuid NOT NULL
);


ALTER TABLE public.build_job OWNER TO postgres;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    shotgun_id integer,
    object_id uuid NOT NULL,
    object_type character varying(80) NOT NULL,
    text text,
    data jsonb,
    task_status_id uuid,
    person_id uuid NOT NULL,
    preview_file_id uuid,
    checklist jsonb,
    pinned boolean,
    replies jsonb
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_acknoledgments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_acknoledgments (
    comment uuid NOT NULL,
    person uuid NOT NULL
);


ALTER TABLE public.comment_acknoledgments OWNER TO postgres;

--
-- Name: comment_mentions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_mentions (
    comment uuid NOT NULL,
    person uuid NOT NULL
);


ALTER TABLE public.comment_mentions OWNER TO postgres;

--
-- Name: comment_preview_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_preview_link (
    comment uuid NOT NULL,
    preview_file uuid NOT NULL
);


ALTER TABLE public.comment_preview_link OWNER TO postgres;

--
-- Name: custom_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_action (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    url character varying(400),
    entity_type character varying(40),
    is_ajax boolean
);


ALTER TABLE public.custom_action OWNER TO postgres;

--
-- Name: data_import_error; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_import_error (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    event_data jsonb NOT NULL,
    source public.import_source_enum
);


ALTER TABLE public.data_import_error OWNER TO postgres;

--
-- Name: day_off; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.day_off (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    date date NOT NULL,
    person_id uuid
);


ALTER TABLE public.day_off OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_link (
    person_id uuid,
    department_id uuid
);


ALTER TABLE public.department_link OWNER TO postgres;

--
-- Name: department_metadata_descriptor_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_metadata_descriptor_link (
    metadata_descriptor_id uuid,
    department_id uuid
);


ALTER TABLE public.department_metadata_descriptor_link OWNER TO postgres;

--
-- Name: desktop_login_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.desktop_login_log (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id uuid NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.desktop_login_log OWNER TO postgres;

--
-- Name: entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity (
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id uuid NOT NULL,
    name character varying(160) NOT NULL,
    description character varying(1200),
    shotgun_id integer,
    canceled boolean,
    project_id uuid NOT NULL,
    entity_type_id uuid NOT NULL,
    parent_id uuid,
    data jsonb,
    preview_file_id uuid,
    source_id uuid,
    code character varying(160),
    nb_frames integer,
    ready_for uuid,
    nb_entities_out integer,
    is_casting_standby boolean,
    status character varying(255)
);


ALTER TABLE public.entity OWNER TO postgres;

--
-- Name: entity_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_link (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    entity_in_id uuid NOT NULL,
    entity_out_id uuid NOT NULL,
    nb_occurences integer,
    label character varying(80),
    data jsonb
);


ALTER TABLE public.entity_link OWNER TO postgres;

--
-- Name: entity_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_type (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(30) NOT NULL
);


ALTER TABLE public.entity_type OWNER TO postgres;

--
-- Name: entity_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_version (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(160) NOT NULL,
    data jsonb,
    entity_id uuid,
    person_id uuid
);


ALTER TABLE public.entity_version OWNER TO postgres;

--
-- Name: file_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file_status (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(40) NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.file_status OWNER TO postgres;

--
-- Name: login_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_log (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id uuid NOT NULL,
    ip_address character varying(50),
    origin character varying(255)
);


ALTER TABLE public.login_log OWNER TO postgres;

--
-- Name: metadata_descriptor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metadata_descriptor (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    project_id uuid NOT NULL,
    entity_type character varying(60) NOT NULL,
    name character varying(120) NOT NULL,
    field_name character varying(120) NOT NULL,
    choices jsonb,
    for_client boolean
);


ALTER TABLE public.metadata_descriptor OWNER TO postgres;

--
-- Name: milestone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.milestone (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    date date,
    name character varying(40) NOT NULL,
    project_id uuid,
    task_type_id uuid
);


ALTER TABLE public.milestone OWNER TO postgres;

--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    change boolean NOT NULL,
    author_id uuid NOT NULL,
    comment_id uuid,
    task_id uuid NOT NULL,
    preview_file_id uuid
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    read boolean NOT NULL,
    change boolean NOT NULL,
    person_id uuid NOT NULL,
    author_id uuid NOT NULL,
    comment_id uuid,
    task_id uuid NOT NULL,
    type character varying(255),
    reply_id uuid
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: organisation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organisation (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    hours_by_day integer NOT NULL,
    has_avatar boolean,
    use_original_file_name boolean,
    chat_token_slack character varying(80),
    timesheets_locked boolean,
    hd_by_default boolean,
    chat_webhook_mattermost character varying(80),
    chat_token_discord character varying(80)
);


ALTER TABLE public.organisation OWNER TO postgres;

--
-- Name: output_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.output_file (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    shotgun_id integer,
    name character varying(250) NOT NULL,
    extension character varying(10),
    description text,
    comment text,
    revision integer NOT NULL,
    size integer,
    checksum character varying(32),
    source character varying(40),
    path character varying(400),
    representation character varying(20),
    nb_elements integer,
    canceled boolean NOT NULL,
    file_status_id uuid NOT NULL,
    entity_id uuid,
    asset_instance_id uuid,
    output_type_id uuid,
    task_type_id uuid,
    person_id uuid,
    source_file_id uuid,
    temporal_entity_id uuid,
    data jsonb
);


ALTER TABLE public.output_file OWNER TO postgres;

--
-- Name: output_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.output_type (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(40) NOT NULL,
    short_name character varying(20) NOT NULL
);


ALTER TABLE public.output_type OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(80) NOT NULL,
    last_name character varying(80) NOT NULL,
    email character varying(255),
    phone character varying(30),
    active boolean,
    last_presence date,
    password bytea,
    desktop_login character varying(80),
    shotgun_id integer,
    timezone character varying(50),
    locale character varying(10),
    data jsonb,
    role character varying(30),
    has_avatar boolean,
    notifications_enabled boolean,
    notifications_slack_enabled boolean,
    notifications_slack_userid character varying(60),
    notifications_mattermost_enabled boolean,
    notifications_mattermost_userid character varying(60),
    notifications_discord_enabled boolean,
    notifications_discord_userid character varying(60),
    archived boolean,
    is_generated_from_ldap boolean,
    login_failed_attemps integer,
    last_login_failed timestamp without time zone,
    totp_enabled boolean,
    totp_secret character varying(32),
    otp_recovery_codes bytea[],
    email_otp_enabled boolean,
    email_otp_secret character varying(32),
    preferred_two_factor_authentication character varying(255),
    fido_enabled boolean,
    fido_credentials jsonb[]
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: playlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlist (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    shots jsonb,
    project_id uuid,
    episode_id uuid,
    for_client boolean,
    for_entity character varying(10),
    is_for_all boolean,
    task_type_id uuid
);


ALTER TABLE public.playlist OWNER TO postgres;

--
-- Name: preview_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preview_file (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(250),
    revision integer,
    description text,
    source character varying(40),
    shotgun_id integer,
    is_movie boolean,
    url character varying(600),
    uploaded_movie_url character varying(600),
    uploaded_movie_name character varying(150),
    task_id uuid,
    person_id uuid,
    source_file_id uuid,
    path character varying(400),
    extension character varying(6),
    annotations jsonb,
    original_name character varying(250),
    "position" integer,
    status character varying(255),
    file_size bigint,
    validation_status character varying(255)
);


ALTER TABLE public.preview_file OWNER TO postgres;

--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    description text,
    shotgun_id integer,
    file_tree jsonb,
    data jsonb,
    project_status_id uuid,
    has_avatar boolean,
    fps character varying(10),
    ratio character varying(10),
    resolution character varying(12),
    production_type character varying(20),
    code character varying(80),
    end_date date,
    start_date date,
    man_days integer,
    episode_span integer,
    nb_episodes integer,
    is_clients_isolated boolean,
    max_retakes integer,
    production_style character varying(255)
);


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: project_asset_type_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_asset_type_link (
    project_id uuid NOT NULL,
    asset_type_id uuid NOT NULL
);


ALTER TABLE public.project_asset_type_link OWNER TO postgres;

--
-- Name: project_person_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_person_link (
    project_id uuid NOT NULL,
    person_id uuid NOT NULL,
    shotgun_id integer
);


ALTER TABLE public.project_person_link OWNER TO postgres;

--
-- Name: project_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_status (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(20) NOT NULL,
    color character varying(7) NOT NULL
);


ALTER TABLE public.project_status OWNER TO postgres;

--
-- Name: project_status_automation_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_status_automation_link (
    project_id uuid NOT NULL,
    status_automation_id uuid NOT NULL
);


ALTER TABLE public.project_status_automation_link OWNER TO postgres;

--
-- Name: project_task_status_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_task_status_link (
    project_id uuid NOT NULL,
    task_status_id uuid NOT NULL
);


ALTER TABLE public.project_task_status_link OWNER TO postgres;

--
-- Name: project_task_type_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_task_type_link (
    project_id uuid NOT NULL,
    task_type_id uuid NOT NULL,
    created_at timestamp without time zone,
    id uuid NOT NULL,
    updated_at timestamp without time zone,
    priority integer
);


ALTER TABLE public.project_task_type_link OWNER TO postgres;

--
-- Name: schedule_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule_item (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    start_date date,
    end_date date,
    project_id uuid,
    task_type_id uuid,
    man_days integer,
    object_id uuid
);


ALTER TABLE public.schedule_item OWNER TO postgres;

--
-- Name: search_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.search_filter (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    list_type character varying(80) NOT NULL,
    name character varying(200) NOT NULL,
    search_query character varying(500) NOT NULL,
    person_id uuid,
    project_id uuid,
    entity_type character varying(80)
);


ALTER TABLE public.search_filter OWNER TO postgres;

--
-- Name: software; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(40) NOT NULL,
    short_name character varying(20) NOT NULL,
    file_extension character varying(20) NOT NULL,
    secondary_extensions jsonb
);


ALTER TABLE public.software OWNER TO postgres;

--
-- Name: status_automation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_automation (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    entity_type character varying(40),
    in_task_type_id uuid,
    in_task_status_id uuid,
    out_field_type character varying(255),
    out_task_type_id uuid,
    out_task_status_id uuid
);


ALTER TABLE public.status_automation OWNER TO postgres;

--
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id uuid NOT NULL,
    task_id uuid,
    entity_id uuid,
    task_type_id uuid
);


ALTER TABLE public.subscription OWNER TO postgres;

--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(80) NOT NULL,
    description character varying(200),
    duration integer,
    estimation integer,
    completion_rate integer,
    sort_order integer,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    due_date timestamp without time zone,
    real_start_date timestamp without time zone,
    shotgun_id integer,
    project_id uuid,
    task_type_id uuid,
    task_status_id uuid,
    entity_id uuid,
    assigner_id uuid,
    priority integer,
    last_comment_date timestamp without time zone,
    retake_count integer,
    data jsonb,
    nb_assets_ready integer
);


ALTER TABLE public.task OWNER TO postgres;

--
-- Name: task_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_status (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(40) NOT NULL,
    short_name character varying(10) NOT NULL,
    color character varying(7) NOT NULL,
    is_done boolean,
    shotgun_id integer,
    is_artist_allowed boolean,
    is_retake boolean,
    is_client_allowed boolean,
    is_feedback_request boolean,
    is_default boolean,
    archived boolean
);


ALTER TABLE public.task_status OWNER TO postgres;

--
-- Name: task_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_type (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(40) NOT NULL,
    short_name character varying(20),
    color character varying(7),
    priority integer,
    shotgun_id integer,
    department_id uuid,
    for_entity character varying(30),
    allow_timelog boolean,
    archived boolean
);


ALTER TABLE public.task_type OWNER TO postgres;

--
-- Name: task_type_asset_type_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_type_asset_type_link (
    asset_type_id uuid,
    task_type_id uuid
);


ALTER TABLE public.task_type_asset_type_link OWNER TO postgres;

--
-- Name: time_spent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.time_spent (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    duration integer NOT NULL,
    date date NOT NULL,
    task_id uuid,
    person_id uuid
);


ALTER TABLE public.time_spent OWNER TO postgres;

--
-- Name: working_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.working_file (
    id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    shotgun_id integer,
    name character varying(250),
    description character varying(200),
    comment text,
    revision integer,
    size integer,
    checksum integer,
    path character varying(400),
    task_id uuid,
    entity_id uuid,
    person_id uuid,
    software_id uuid,
    data jsonb
);


ALTER TABLE public.working_file OWNER TO postgres;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
2baede80b111
\.


--
-- Data for Name: api_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_event (id, created_at, updated_at, name, user_id, data, project_id) FROM stdin;
606873f1-7662-4d78-b19c-bcd5b42a19dd	2023-06-21 14:19:25.794289	2023-06-21 14:19:25.794293	asset-type:new	\N	{"id": "66e5367e-4ccb-40f9-a590-f5e1ae6ea872", "name": "Character"}	\N
877dad1a-07e2-43d2-8649-2561f18cda0b	2023-06-21 14:19:25.804881	2023-06-21 14:19:25.804886	asset-type:new	\N	{"id": "98dc45c2-53f4-4f27-bfb9-0c92254aa6c0", "name": "Prop"}	\N
3e61cf77-6ea2-4e70-baa4-88b204514301	2023-06-21 14:19:25.813899	2023-06-21 14:19:25.813904	asset-type:new	\N	{"id": "1eb8659a-446d-4519-afce-388372d66f87", "name": "Environment"}	\N
72da01be-5b97-49ad-b8e4-3cd39b2eb332	2023-06-21 14:19:25.823455	2023-06-21 14:19:25.823459	asset-type:new	\N	{"id": "1cda1d73-ed42-4b6b-acc4-8c2a98da1941", "name": "FX"}	\N
7cf9cf4f-2aa2-44b1-9b6c-ffe4ebcbc1fa	2023-06-21 14:19:25.867412	2023-06-21 14:19:25.867418	department:new	\N	{"department_id": "e09c4428-dc93-4ec3-9983-163127d2fc7a"}	\N
cc554d65-94f0-41fd-8e2f-bda6cfcbfeb1	2023-06-21 14:19:25.879915	2023-06-21 14:19:25.879922	department:new	\N	{"department_id": "c6f9290a-b231-4d6b-b60f-e46bdd05c43a"}	\N
151160ee-8035-4f03-aa8d-aae5cb5db161	2023-06-21 14:19:25.89116	2023-06-21 14:19:25.891165	department:new	\N	{"department_id": "fcbd85f3-b487-4aa2-b9db-66a94327a42e"}	\N
4738c89b-62eb-452c-89d4-41019989c095	2023-06-21 14:19:25.903063	2023-06-21 14:19:25.903068	department:new	\N	{"department_id": "edd0bdd7-a5e0-457e-8cc2-81089e14db4d"}	\N
3dd2486c-b670-4d5a-8e15-d66f6b1f63fd	2023-06-21 14:19:25.914694	2023-06-21 14:19:25.914699	department:new	\N	{"department_id": "0839dd18-c942-4cac-8dcf-993635f03625"}	\N
0249a0ed-9435-468f-8e88-41b1efbee304	2023-06-21 14:19:25.922369	2023-06-21 14:19:25.922374	department:new	\N	{"department_id": "e790b577-f12d-4cdf-b255-db5fa251f34b"}	\N
a04dcbb1-012e-4701-b431-8f6dd45098bf	2023-06-21 14:19:25.931874	2023-06-21 14:19:25.931878	task-type:new	\N	{"task_type_id": "e3b6cbda-d851-42ae-838c-3e6aea439e97"}	\N
bcd1ccec-244b-4dd3-8a6e-300c3ddbb5f7	2023-06-21 14:19:25.939372	2023-06-21 14:19:25.939377	task-type:new	\N	{"task_type_id": "b4a56a30-bf04-4e01-9431-80674323f97d"}	\N
409a2356-c504-4af6-b2ad-5224600bfec9	2023-06-21 14:19:25.946986	2023-06-21 14:19:25.94699	task-type:new	\N	{"task_type_id": "411d4294-8004-4dd7-9258-feabd8ee2662"}	\N
70e2e174-e043-4920-a1cb-601db01471a3	2023-06-21 14:19:25.954843	2023-06-21 14:19:25.954847	task-type:new	\N	{"task_type_id": "37ae0ce9-c445-4967-8aee-1b525409cd70"}	\N
5bd82ab6-7283-4b93-baa6-68f366889c73	2023-06-21 14:19:25.961734	2023-06-21 14:19:25.961738	task-type:new	\N	{"task_type_id": "e1100869-7a6d-4b3e-a27c-37f16af057e4"}	\N
0e9608a9-b435-4e34-b399-014b60e2a2dc	2023-06-21 14:19:25.968583	2023-06-21 14:19:25.968587	task-type:new	\N	{"task_type_id": "9e883abf-0826-4172-9191-10987254fb32"}	\N
dfd3e077-6ea8-4696-a492-a1fb0449be29	2023-06-21 14:19:25.975607	2023-06-21 14:19:25.975611	task-type:new	\N	{"task_type_id": "0a6dca9f-dc67-4d68-8d21-78004afe8dcd"}	\N
77de819b-5054-47b6-90d1-5e38cb4ab957	2023-06-21 14:19:25.982536	2023-06-21 14:19:25.982543	task-type:new	\N	{"task_type_id": "b11923b2-1009-48dc-93be-bf18b8815d5c"}	\N
ee32a842-4feb-4142-ab3e-69d1e2bad871	2023-06-21 14:19:25.990059	2023-06-21 14:19:25.990063	task-type:new	\N	{"task_type_id": "16e1ac85-480f-46a1-8267-0d08dc57a923"}	\N
47a1f406-b5f3-4ebb-9e3b-2ecc2353fb21	2023-06-21 14:19:25.997701	2023-06-21 14:19:25.997704	task-type:new	\N	{"task_type_id": "6f54d762-2904-4f92-8f05-4a7a19bdc158"}	\N
6a30e9cf-eb23-43f0-8dee-d0360555af92	2023-06-21 14:19:26.008306	2023-06-21 14:19:26.00831	task-type:new	\N	{"task_type_id": "168f989e-a4b2-41aa-ae80-99e6395464dc"}	\N
3db226a2-296c-4cb2-a2f6-484eadaf271a	2023-06-21 14:19:26.015353	2023-06-21 14:19:26.015357	task-type:new	\N	{"task_type_id": "e09e1180-f6e7-4b74-a34f-d8312de23ec4"}	\N
15edfddb-3d75-4b93-a1f5-07f2e614cfcf	2023-06-21 14:19:26.028152	2023-06-21 14:19:26.028157	task-status:new	\N	{"task_status_id": "6213296a-71f3-4fab-9665-16e7cd8a3101"}	\N
f9191aaf-1d01-4a4a-bf7f-e96e2a10940c	2023-06-21 14:19:26.03824	2023-06-21 14:19:26.038244	task-status:new	\N	{"task_status_id": "19f673d5-cd49-4682-b1c9-b11f8fb11e38"}	\N
fd7e17a7-9a42-4770-a826-74900fdb824e	2023-06-21 14:19:26.048012	2023-06-21 14:19:26.048017	task-status:new	\N	{"task_status_id": "9e0d135f-1e7d-4b61-b6e4-3d6dcc65eb4e"}	\N
d04beed5-d22e-4b5b-93c5-d2da0831db4a	2023-06-21 14:19:26.057145	2023-06-21 14:19:26.057149	task-status:new	\N	{"task_status_id": "1fe0b283-525b-4d2e-9702-9d84abcff7ff"}	\N
cfc66017-f1e1-47ec-b2ae-f1da03089885	2023-06-21 14:19:26.066735	2023-06-21 14:19:26.066739	task-status:new	\N	{"task_status_id": "3b66c6f4-21db-4670-aae4-66be773b6e52"}	\N
54676e97-a689-4f47-b542-25cd39f93027	2023-06-21 14:19:26.074513	2023-06-21 14:19:26.074517	task-status:new	\N	{"task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	\N
10c3b77e-6132-4c94-8136-043ea963d302	2023-06-21 14:19:28.331475	2023-06-21 14:19:28.331479	person:new	\N	{"person_id": "103f4373-52f3-4e71-97c9-0272bad7a176"}	\N
88861903-9bf2-4c6e-a980-7ac2594f51fb	2023-06-21 14:19:36.246325	2023-06-21 14:19:36.246329	person:new	\N	{"person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a"}	\N
9a5de546-1ca3-4625-9cb8-f1489aabcfff	2023-06-21 14:19:36.294575	2023-06-21 14:19:36.29458	person:new	\N	{"person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293"}	\N
597a2ef3-c1b5-4e60-9e1d-1085f7d5a35d	2023-06-21 14:21:43.741673	2023-06-21 14:21:43.741677	project:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	\N
e3795dec-9f43-4964-86d7-07478b992d7d	2023-06-21 14:21:43.809917	2023-06-21 14:21:43.809921	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
70671dd0-d38b-40eb-9c07-fcaddbb00f1e	2023-06-21 14:21:43.846132	2023-06-21 14:21:43.846137	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
291bf2af-4712-4702-b4d0-0e1bdba9aca9	2023-06-21 14:21:43.84967	2023-06-21 14:21:43.849676	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
4f03eb68-e8be-405e-9bcd-668e05574b1a	2023-06-21 14:21:43.861376	2023-06-21 14:21:43.861384	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
38289013-2553-4f8d-95f5-a4f18705e11a	2023-06-21 14:21:43.868259	2023-06-21 14:21:43.868263	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
1ae9f472-9025-4fd1-98a4-a56ef0af4ca3	2023-06-21 14:21:43.878179	2023-06-21 14:21:43.878184	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
d6e1657d-4442-4f7b-8529-bb894cd5f71e	2023-06-21 14:21:43.9363	2023-06-21 14:21:43.936306	project:update	\N	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6c38f547-584d-48d4-b3ae-f64ab9c3fd0f	2023-06-21 14:21:43.946365	2023-06-21 14:21:43.94637	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
78d27472-6a7d-4ed8-a64b-f7610d6fc6d4	2023-06-21 14:21:43.962019	2023-06-21 14:21:43.962027	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
eced4a61-4f90-4b17-957a-55247505ab41	2023-06-21 14:21:43.977993	2023-06-21 14:21:43.977998	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9919d86b-0371-404b-a1be-2d30416db829	2023-06-21 14:21:44.001871	2023-06-21 14:21:44.001881	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
ae3e0a96-7f5e-44f1-8e9e-34d99b1fd6a9	2023-06-21 14:21:44.001146	2023-06-21 14:21:44.001151	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9cfbf314-ca8b-4799-a68b-a16804a194b1	2023-06-21 14:21:44.021462	2023-06-21 14:21:44.021467	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
4950df48-5d45-4be6-a9a3-5f35ff8d9ded	2023-06-21 14:21:44.061135	2023-06-21 14:21:44.061142	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
82f1dd97-045d-4fca-ab5e-b379acd9720f	2023-06-21 14:21:44.074713	2023-06-21 14:21:44.074718	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
cf420706-0891-4d68-9f68-191bda5833f3	2023-06-21 14:21:44.100071	2023-06-21 14:21:44.100076	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
3cff63c2-5bd2-4461-b6f0-6005543e55f3	2023-06-21 14:21:44.185719	2023-06-21 14:21:44.185725	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e4748e99-9ffe-473d-bbe1-8578569b4363	2023-06-21 14:21:44.260018	2023-06-21 14:21:44.260022	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
349a3777-ec98-4d59-9a63-8f4f33cb3a49	2023-06-21 14:21:44.305108	2023-06-21 14:21:44.305114	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
ae07b167-0f90-41f0-9b1b-10f4fa0e658a	2023-06-21 14:21:44.328806	2023-06-21 14:21:44.32881	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
40a888e7-3d9a-4311-ac7b-64997c3565da	2023-06-21 14:21:44.357887	2023-06-21 14:21:44.357892	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
229e5d31-9fc5-477e-a600-2f0f7b78cf3c	2023-06-21 14:21:52.815265	2023-06-21 14:21:52.815269	asset:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"asset_id": "df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c", "asset_type": "66e5367e-4ccb-40f9-a590-f5e1ae6ea872", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
ac2bdb75-9b00-4067-8c81-6af962a4b824	2023-06-21 14:21:52.872671	2023-06-21 14:21:52.872675	task:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
3089b804-0c82-4330-92a5-87e517496bf4	2023-06-21 14:21:52.874853	2023-06-21 14:21:52.874858	task:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
adaf89ce-89ef-47eb-9e69-6ca9b3bd4c45	2023-06-21 14:22:03.123958	2023-06-21 14:22:03.123962	task:status-changed	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "new_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106", "previous_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
de05172f-8b6d-46d2-9cc7-be9586b9fa25	2023-06-21 14:22:03.154849	2023-06-21 14:22:03.154853	news:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"news_id": "25d67b1d-17a6-48e8-8993-5155d715f1f4", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "task_type_id": "e3b6cbda-d851-42ae-838c-3e6aea439e97", "task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
2201f158-e243-4e99-8a95-203e60195a1d	2023-06-21 14:22:03.193874	2023-06-21 14:22:03.193879	comment:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "comment_id": "3307e21f-0eb2-4b7d-9137-231345d975e7", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9f59f608-051e-44a1-ab1b-8114cc56dd1f	2023-06-21 14:22:03.220302	2023-06-21 14:22:03.220306	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
61b71bfa-d126-46ea-909e-38faf3ff779a	2023-06-21 14:22:03.352519	2023-06-21 14:22:03.352523	task:status-changed	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "new_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106", "previous_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
b630fb8f-9a0b-47f7-90b6-ee87c25dcbed	2023-06-21 14:22:03.378528	2023-06-21 14:22:03.378532	news:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"news_id": "7d2ea237-636f-42bb-93a5-85c12d78508f", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "task_type_id": "b4a56a30-bf04-4e01-9431-80674323f97d", "task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
399b2ae3-e246-49c6-a042-eee75ce238c4	2023-06-21 14:22:03.41557	2023-06-21 14:22:03.415574	comment:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "comment_id": "f8dfd0b8-c2cb-447e-8b07-2a3529fc3014", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
d7e8829d-519b-426d-b43c-c91e26d65758	2023-06-21 14:22:03.444609	2023-06-21 14:22:03.444614	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
1dea23bc-344d-4332-a085-0bc7ce9c427a	2023-06-21 14:21:52.875091	2023-06-21 14:21:52.875097	task:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
186f796c-4b70-4119-b4a3-4c42e43abde3	2023-06-21 14:22:07.787859	2023-06-21 14:22:07.787864	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9ec42cba-965a-4dc4-aab2-4d6218a28ed4	2023-06-21 14:22:07.942415	2023-06-21 14:22:07.942419	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
17014286-0c43-4785-8499-c7c92d02f3bd	2023-06-21 14:21:52.904696	2023-06-21 14:21:52.9047	task:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
f50c3eef-9ad0-4850-92dc-d581fb47e716	2023-06-21 14:22:07.853917	2023-06-21 14:22:07.853923	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
dc916cf6-acc7-44dc-a250-c82d517556be	2023-06-21 14:22:07.922829	2023-06-21 14:22:07.922834	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
d3af44bf-1940-41ad-a3a3-f3e677b5f49d	2023-06-21 14:22:08.014845	2023-06-21 14:22:08.014849	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
3d157858-a32f-4dce-9d4d-910bb2dcbafd	2023-06-21 14:22:08.054759	2023-06-21 14:22:08.054764	project:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
90f9c04f-d77b-4643-b46b-80a5145487a9	2023-06-21 14:22:02.98758	2023-06-21 14:22:02.987585	comment:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "comment_id": "ea57e92d-3b3c-4a00-92f3-6a3b687bebe0", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6561ad67-fbb3-423f-b6a3-7a8fa51b86e1	2023-06-21 14:22:03.020901	2023-06-21 14:22:03.020905	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
5943946d-f672-429f-b8c1-8776528674dd	2023-06-21 14:22:03.236033	2023-06-21 14:22:03.236037	task:status-changed	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "new_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106", "previous_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
a440fc33-69c4-40e7-8c91-1ba6f0bc5672	2023-06-21 14:22:03.262383	2023-06-21 14:22:03.262387	news:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"news_id": "5c602afd-d743-4b92-a982-76bac8e6a17b", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "task_type_id": "37ae0ce9-c445-4967-8aee-1b525409cd70", "task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e9eeef72-d31e-4011-bfc1-01bacfb1e794	2023-06-21 14:22:03.304641	2023-06-21 14:22:03.304645	comment:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "comment_id": "65f46e1e-ae8e-4ef1-8a3d-8c88ae6442cf", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9eb207ac-0f4a-4bb6-972a-74ad0cbc9c60	2023-06-21 14:22:03.33335	2023-06-21 14:22:03.333356	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
4254a09d-054f-4928-9243-68a2613c5560	2023-06-21 14:22:03.462783	2023-06-21 14:22:03.46279	task:status-changed	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "new_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106", "previous_task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
c7e6205d-67d2-4d22-8b6c-339da075a46b	2023-06-21 14:22:03.492599	2023-06-21 14:22:03.492603	news:new	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"news_id": "82c38553-1b65-487f-9fa0-ff9a6a1610ec", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686", "task_type_id": "411d4294-8004-4dd7-9258-feabd8ee2662", "task_status_id": "59a5e386-f3ac-4963-848f-735be9831106"}	b778fddb-916a-41bf-8bfd-f0b57193a686
f38cebae-e29a-4a3c-bd2f-9c6dece71b7b	2023-06-21 14:22:07.808364	2023-06-21 14:22:07.808369	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
8a882458-2c70-49c7-b125-866c35d207d5	2023-06-21 14:22:07.877021	2023-06-21 14:22:07.877025	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0bb738e3-e2aa-48ba-babb-9bb44ebd317f	2023-06-21 14:22:07.99691	2023-06-21 14:22:07.996919	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
b543389a-e027-4932-8392-fbe4809cc1b6	2023-06-21 14:32:03.33863	2023-06-21 14:32:03.338634	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
08a7f5d1-0833-4ea5-bc64-0c7ba3586df2	2023-06-21 14:32:03.338897	2023-06-21 14:32:03.338902	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
f7728467-7e23-45d9-b3a7-294be3167273	2023-06-21 14:32:03.345498	2023-06-21 14:32:03.345503	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0223d4fa-d349-45b2-9c43-19478cc6b4b2	2023-06-21 14:32:03.354782	2023-06-21 14:32:03.354786	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
a0becacf-f1c8-4cdd-84e4-97930a3fa950	2023-06-21 14:32:03.355827	2023-06-21 14:32:03.355831	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
389038a5-91ea-4543-b993-18f826520db1	2023-06-21 14:32:03.379131	2023-06-21 14:32:03.379135	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
28530b78-1f23-437c-a192-1b4c76319316	2023-06-21 14:32:03.399855	2023-06-21 14:32:03.39986	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
beec358b-a051-4115-9bf7-5252a25c9ea7	2023-06-21 14:32:03.416561	2023-06-21 14:32:03.416565	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
c65915fe-5a08-4e30-83fe-c24a40094265	2023-06-21 14:32:05.371725	2023-06-21 14:32:05.37173	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e7f19543-b149-4213-94f3-2642dffbd522	2023-06-21 14:32:05.390203	2023-06-21 14:32:05.390207	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
31bfeaa3-aa2f-42df-946a-69918b2bce49	2023-06-21 14:32:05.43401	2023-06-21 14:32:05.434014	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
280402bd-04b0-40d3-ba6d-ba4bfeb2842f	2023-06-21 14:32:05.451717	2023-06-21 14:32:05.451722	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
be0f8204-ce3f-4b7e-8b70-51cb1172ce0b	2023-06-21 14:32:05.496241	2023-06-21 14:32:05.496246	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
baddd58a-a988-464f-819d-ff808ff23baa	2023-06-21 14:32:05.513014	2023-06-21 14:32:05.513018	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
676cb19d-0ab6-49bd-806c-8abf628c7f44	2023-06-21 14:32:05.573912	2023-06-21 14:32:05.573928	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9f5de8e4-ea09-410d-b543-e96760d06ea4	2023-06-21 14:32:05.597983	2023-06-21 14:32:05.597988	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
1b6ba3e8-668d-4288-bad8-841c2f28afd6	2023-06-21 14:32:51.284849	2023-06-21 14:32:51.284853	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
76e6afe2-9a01-44e2-b034-b890e5c34318	2023-06-21 14:32:51.300089	2023-06-21 14:32:51.300093	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
37b80e1b-cf43-4470-a671-a66886e12566	2023-06-21 14:32:51.327196	2023-06-21 14:32:51.327201	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
407bf9b7-3189-4b17-b44f-98fe15916b7d	2023-06-21 14:32:51.341258	2023-06-21 14:32:51.341263	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
069e5dc1-2150-4899-9d93-b1a65a8fcefe	2023-06-21 14:32:51.367354	2023-06-21 14:32:51.367359	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
3d79d926-0dd1-44f0-87d4-ba9bfe8a3aec	2023-06-21 14:32:51.382693	2023-06-21 14:32:51.382697	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
16fe87c8-36c3-42c8-906a-84fb4fd6640e	2023-06-21 14:32:51.408991	2023-06-21 14:32:51.408998	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
a1194c3b-22ed-4adb-a63e-e7aaacbef098	2023-06-21 14:32:51.422952	2023-06-21 14:32:51.422956	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
58c9e1ed-8d90-4f54-a37b-8807629223e9	2023-06-21 14:40:15.364421	2023-06-21 14:40:15.364426	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
914f1594-ba0d-4317-a5e7-da9736cd7d1b	2023-06-21 14:40:15.385325	2023-06-21 14:40:15.38533	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
27c30a72-3c46-4be8-8421-1ebeaf200609	2023-06-21 14:40:15.439551	2023-06-21 14:40:15.439556	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
c4b5a04a-ece9-444e-82f0-8b203e35f0e8	2023-06-21 14:40:15.455835	2023-06-21 14:40:15.455839	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0837a22c-d7aa-4d68-949e-e435e96d0ebd	2023-06-21 14:40:15.502534	2023-06-21 14:40:15.502538	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
8c3b8dd6-60c0-443b-8f40-3d02fb8b225f	2023-06-21 14:40:15.518279	2023-06-21 14:40:15.518283	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6c26fb80-a4ab-47c2-9f5c-e43c5e19eae1	2023-06-21 14:40:15.564073	2023-06-21 14:40:15.564078	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
1d776d03-be2d-43e3-9266-4363c04d6219	2023-06-21 14:41:54.358128	2023-06-21 14:41:54.358132	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
837b20df-1ca1-4ba3-b534-9bd561c9a136	2023-06-21 14:41:59.402334	2023-06-21 14:41:59.402339	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
ff20c8bd-1b29-4538-a95c-21f9898fe6e6	2023-06-21 15:02:26.59119	2023-06-21 15:02:26.591194	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
f5767b5b-a773-49ae-b8ac-d73f31c550ba	2023-06-21 14:40:15.581849	2023-06-21 14:40:15.581853	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
972b7b67-088e-4b98-b984-82e3a595c546	2023-06-21 14:41:54.373431	2023-06-21 14:41:54.373436	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
48d2614a-3afb-456d-8ba2-195ae110daf8	2023-06-21 14:41:57.352488	2023-06-21 14:41:57.352493	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
bae1b90d-fc30-4a27-be25-a5ca64930944	2023-06-21 14:47:32.646341	2023-06-21 14:47:32.646345	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0c34799f-dc45-4ded-a464-eee409b73f1d	2023-06-21 14:40:22.063811	2023-06-21 14:40:22.063816	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
84fdb14c-57e6-4ea7-891a-4cf5d2d7d59d	2023-06-21 14:41:46.89545	2023-06-21 14:41:46.895456	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
b91f565e-3bec-42de-b42f-7236be4d65c8	2023-06-21 14:47:17.18483	2023-06-21 14:47:17.184836	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
b3739f92-e97c-4225-9e97-81b05441c564	2023-06-21 14:53:22.883108	2023-06-21 14:53:22.883113	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
50c2075c-50bc-4737-a02f-1c3823517484	2023-06-21 14:53:36.559673	2023-06-21 14:53:36.559677	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
a0583166-c990-4f90-a44f-ab68337c62f2	2023-06-21 15:00:37.521107	2023-06-21 15:00:37.521111	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
b4412c16-0690-4c44-a41f-ec10439e2b9c	2023-06-21 15:00:37.579551	2023-06-21 15:00:37.579555	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
8b595c34-526f-4fdd-aaf2-b95ffea411e9	2023-06-21 15:00:37.604901	2023-06-21 15:00:37.604906	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0a66f228-c3ec-45b2-9e92-05393fdbcd6d	2023-06-21 15:00:37.663656	2023-06-21 15:00:37.66366	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
2a2e66d6-41c4-4b9e-93dc-3cadd646ca41	2023-06-21 15:02:53.330959	2023-06-21 15:02:53.330963	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
73011ce6-0179-4b72-9fa0-1e61e34d7695	2023-06-21 14:40:22.082759	2023-06-21 14:40:22.082764	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
104f73c0-ad7d-478a-9b70-d88eaa6cfe0e	2023-06-21 14:41:46.916293	2023-06-21 14:41:46.916297	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
575942eb-6cc2-4ff1-a17c-7e2b8ab424be	2023-06-21 14:47:17.204461	2023-06-21 14:47:17.204466	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
2840499c-5244-4280-bce1-867af2c9353d	2023-06-21 14:53:22.898809	2023-06-21 14:53:22.898814	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
22079114-b6d3-4adb-94a2-0c12f3fa473f	2023-06-21 14:53:36.576624	2023-06-21 14:53:36.576628	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
9122103a-607d-4740-9442-6bddb192e800	2023-06-21 15:00:37.536371	2023-06-21 15:00:37.536375	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e627cdd4-cd24-48c5-9db9-8cc67a1c259f	2023-06-21 15:00:37.565414	2023-06-21 15:00:37.565419	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6eaf339b-e7aa-4600-8684-cdca4188ca6f	2023-06-21 15:00:37.619107	2023-06-21 15:00:37.619111	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
66f102ca-2f36-4b18-a516-36db88c33d00	2023-06-21 15:00:37.648778	2023-06-21 15:00:37.648783	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
502ea9be-0ae4-4879-b3ab-244c4e12062d	2023-06-21 15:02:53.347272	2023-06-21 15:02:53.347277	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
876f81a6-af09-43a7-81e1-50800a875b88	2023-06-21 14:41:57.368384	2023-06-21 14:41:57.368389	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
5cc4001f-61e4-4142-af06-acebbf45c236	2023-06-21 14:41:59.385064	2023-06-21 14:41:59.385068	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e78beef8-e0b0-4b85-9510-50783434c769	2023-06-21 14:47:32.664067	2023-06-21 14:47:32.664071	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
e7abe834-fa28-45f2-b09d-f16264c03aaa	2023-06-21 15:02:26.575046	2023-06-21 15:02:26.57505	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0047b02f-4a72-40c8-a497-8c3345f8c422	2023-06-21 15:03:38.339024	2023-06-21 15:03:38.339029	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
765e3840-0f46-4616-98d7-6d5050ad4f29	2023-06-21 15:03:38.355477	2023-06-21 15:03:38.355482	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6a5d485a-5225-4109-9def-3e4e353023db	2023-06-21 15:04:00.706126	2023-06-21 15:04:00.70613	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
4dc37c9d-719e-4992-83d8-0e85fe088635	2023-06-21 15:04:00.720755	2023-06-21 15:04:00.720759	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
445a7121-97e5-4483-926c-f86f9b97aacc	2023-06-21 15:05:57.334366	2023-06-21 15:05:57.33437	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
27706197-7147-40b4-8625-a9fd0b23df19	2023-06-21 15:05:57.351208	2023-06-21 15:05:57.351213	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
6762f6c9-f4ca-4613-a2fc-05817d8e1f87	2023-06-21 15:05:57.396356	2023-06-21 15:05:57.39636	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
0c42c882-9dfb-464c-bee9-f111cc778bb9	2023-06-21 15:05:57.413552	2023-06-21 15:05:57.413556	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "67492971-ef53-4a46-8554-5c6248341169", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
dffae697-5f12-4040-a2f8-4386385b96ef	2023-06-21 15:05:57.457828	2023-06-21 15:05:57.457834	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
8180c441-a818-438c-9dda-625105bacdcf	2023-06-21 15:05:57.474182	2023-06-21 15:05:57.474187	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "6db83d88-2590-4cc1-bf47-a3d3c62b5c28", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
f0a89b37-f936-40eb-9db6-75f22ca975e0	2023-06-21 15:05:57.513682	2023-06-21 15:05:57.513687	task:assign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
bfbd0eab-2987-4efa-9dc6-bab1c8f0f05b	2023-06-21 15:05:57.530496	2023-06-21 15:05:57.5305	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "13b86d8a-85a6-40a0-bf67-11b3c823d4ea", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
3f0dada4-4625-4373-9369-1cc7cbc53983	2023-06-21 15:06:10.876646	2023-06-21 15:06:10.876651	task:unassign	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
04bc3fbc-5ab3-4469-9e8f-7b4cda92fd98	2023-06-21 15:06:10.892048	2023-06-21 15:06:10.892053	task:update	bc560a1e-c50e-44b3-93a3-a58151bf742a	{"task_id": "d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89", "project_id": "b778fddb-916a-41bf-8bfd-f0b57193a686"}	b778fddb-916a-41bf-8bfd-f0b57193a686
8a0183ec-0361-49be-8138-234256e67d18	2023-07-03 13:41:38.348103	2023-07-03 13:41:38.348109	person:update	\N	{"person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a"}	\N
9a1d8488-bd4f-450a-b4e2-0a3ad540f949	2023-07-03 13:41:39.758739	2023-07-03 13:41:39.758744	person:update	\N	{"person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293"}	\N
731937f8-1bd8-4eed-b378-260666de7ecc	2023-07-05 13:00:52.380991	2023-07-05 13:00:52.380998	person:update	\N	{"person_id": "bc560a1e-c50e-44b3-93a3-a58151bf742a"}	\N
37c3adf6-2960-48f1-8bbb-4d158112bf09	2023-07-05 13:00:52.442323	2023-07-05 13:00:52.442331	person:update	\N	{"person_id": "f94a5f53-881f-4fa7-98a4-5006c0017293"}	\N
\.


--
-- Data for Name: asset_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_instance (id, created_at, updated_at, asset_id, entity_id, entity_type_id, name, number, description, data, active, scene_id, target_asset_id) FROM stdin;
\.


--
-- Data for Name: asset_instance_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asset_instance_link (entity_id, asset_instance_id) FROM stdin;
\.


--
-- Data for Name: assignations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assignations (task, person) FROM stdin;
67492971-ef53-4a46-8554-5c6248341169	f94a5f53-881f-4fa7-98a4-5006c0017293
13b86d8a-85a6-40a0-bf67-11b3c823d4ea	f94a5f53-881f-4fa7-98a4-5006c0017293
6db83d88-2590-4cc1-bf47-a3d3c62b5c28	f94a5f53-881f-4fa7-98a4-5006c0017293
\.


--
-- Data for Name: attachment_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachment_file (id, created_at, updated_at, name, size, extension, comment_id, mimetype) FROM stdin;
\.


--
-- Data for Name: build_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.build_job (id, created_at, updated_at, status, job_type, ended_at, playlist_id) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, created_at, updated_at, shotgun_id, object_id, object_type, text, data, task_status_id, person_id, preview_file_id, checklist, pinned, replies) FROM stdin;
ea57e92d-3b3c-4a00-92f3-6a3b687bebe0	2023-06-21 14:22:02.951625	2023-06-21 14:22:02.951629	\N	67492971-ef53-4a46-8554-5c6248341169	Task		\N	59a5e386-f3ac-4963-848f-735be9831106	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	[]	\N	[]
3307e21f-0eb2-4b7d-9137-231345d975e7	2023-06-21 14:22:03.170917	2023-06-21 14:22:03.170922	\N	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	Task		\N	59a5e386-f3ac-4963-848f-735be9831106	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	[]	\N	[]
65f46e1e-ae8e-4ef1-8a3d-8c88ae6442cf	2023-06-21 14:22:03.285813	2023-06-21 14:22:03.285817	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	Task		\N	59a5e386-f3ac-4963-848f-735be9831106	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	[]	\N	[]
f8dfd0b8-c2cb-447e-8b07-2a3529fc3014	2023-06-21 14:22:03.393789	2023-06-21 14:22:03.393793	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	Task		\N	59a5e386-f3ac-4963-848f-735be9831106	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	[]	\N	[]
\.


--
-- Data for Name: comment_acknoledgments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_acknoledgments (comment, person) FROM stdin;
\.


--
-- Data for Name: comment_mentions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_mentions (comment, person) FROM stdin;
\.


--
-- Data for Name: comment_preview_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_preview_link (comment, preview_file) FROM stdin;
\.


--
-- Data for Name: custom_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_action (id, created_at, updated_at, name, url, entity_type, is_ajax) FROM stdin;
\.


--
-- Data for Name: data_import_error; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_import_error (id, created_at, updated_at, event_data, source) FROM stdin;
\.


--
-- Data for Name: day_off; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.day_off (id, created_at, updated_at, date, person_id) FROM stdin;
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, created_at, updated_at, name, color) FROM stdin;
e09c4428-dc93-4ec3-9983-163127d2fc7a	2023-06-21 14:19:25.860923	2023-06-21 14:19:25.860105	Modeling	#78909C
c6f9290a-b231-4d6b-b60f-e46bdd05c43a	2023-06-21 14:19:25.874059	2023-06-21 14:19:25.873656	Animation	#009688
fcbd85f3-b487-4aa2-b9db-66a94327a42e	2023-06-21 14:19:25.886116	2023-06-21 14:19:25.885823	FX	#26C6DA
edd0bdd7-a5e0-457e-8cc2-81089e14db4d	2023-06-21 14:19:25.896615	2023-06-21 14:19:25.896285	Compositing	#F06292
0839dd18-c942-4cac-8dcf-993635f03625	2023-06-21 14:19:25.908878	2023-06-21 14:19:25.908624	Concept	#8D6E63
e790b577-f12d-4cdf-b255-db5fa251f34b	2023-06-21 14:19:25.918457	2023-06-21 14:19:25.918255	Layout	#7CB342
\.


--
-- Data for Name: department_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_link (person_id, department_id) FROM stdin;
\.


--
-- Data for Name: department_metadata_descriptor_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_metadata_descriptor_link (metadata_descriptor_id, department_id) FROM stdin;
\.


--
-- Data for Name: desktop_login_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.desktop_login_log (id, created_at, updated_at, person_id, date) FROM stdin;
\.


--
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity (created_at, updated_at, id, name, description, shotgun_id, canceled, project_id, entity_type_id, parent_id, data, preview_file_id, source_id, code, nb_frames, ready_for, nb_entities_out, is_casting_standby, status) FROM stdin;
2023-06-21 14:21:52.782919	2023-06-21 14:21:52.945321	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	ant		\N	f	b778fddb-916a-41bf-8bfd-f0b57193a686	66e5367e-4ccb-40f9-a590-f5e1ae6ea872	\N	{"file_name": "ant"}	\N	\N	\N	\N	\N	0	f	running
\.


--
-- Data for Name: entity_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_link (id, created_at, updated_at, entity_in_id, entity_out_id, nb_occurences, label, data) FROM stdin;
\.


--
-- Data for Name: entity_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_type (id, created_at, updated_at, name) FROM stdin;
66e5367e-4ccb-40f9-a590-f5e1ae6ea872	2023-06-21 14:19:25.788762	2023-06-21 14:19:25.78877	Character
98dc45c2-53f4-4f27-bfb9-0c92254aa6c0	2023-06-21 14:19:25.801421	2023-06-21 14:19:25.801427	Prop
1eb8659a-446d-4519-afce-388372d66f87	2023-06-21 14:19:25.810505	2023-06-21 14:19:25.810509	Environment
1cda1d73-ed42-4b6b-acc4-8c2a98da1941	2023-06-21 14:19:25.819933	2023-06-21 14:19:25.819937	FX
41731361-ed2b-4130-898b-c15c458d2cc8	2023-06-21 14:19:25.830948	2023-06-21 14:19:25.830954	Episode
d91870fe-fcdc-42ca-b5ac-eacf826f0bda	2023-06-21 14:19:25.83885	2023-06-21 14:19:25.838855	Sequence
83ca4fcd-4fa2-499f-9f01-6c4860a7e5b0	2023-06-21 14:19:25.847014	2023-06-21 14:19:25.847019	Shot
af79abb7-0b75-4076-be68-17e71117cedb	2023-06-21 14:19:25.855616	2023-06-21 14:19:25.855621	Edit
68099188-3110-4f7e-8858-875401c46011	2023-06-21 14:20:30.963055	2023-06-21 14:20:30.96306	Scene
\.


--
-- Data for Name: entity_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_version (id, created_at, updated_at, name, data, entity_id, person_id) FROM stdin;
\.


--
-- Data for Name: file_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file_status (id, created_at, updated_at, name, color) FROM stdin;
\.


--
-- Data for Name: login_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_log (id, created_at, updated_at, person_id, ip_address, origin) FROM stdin;
fc841c0d-40cf-4cea-90fd-54076197f75e	2023-06-21 14:20:30.371848	2023-06-21 14:20:30.371852	f94a5f53-881f-4fa7-98a4-5006c0017293	172.27.0.1	web
0ca810c4-834b-40b9-9d07-a613ba66a40c	2023-06-21 14:20:49.439964	2023-06-21 14:20:49.439969	bc560a1e-c50e-44b3-93a3-a58151bf742a	172.27.0.1	web
b6d46939-c8cd-4531-a158-d7b940310e85	2023-06-21 14:23:43.104735	2023-06-21 14:23:43.104739	f94a5f53-881f-4fa7-98a4-5006c0017293	172.27.0.1	script
\.


--
-- Data for Name: metadata_descriptor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metadata_descriptor (id, created_at, updated_at, project_id, entity_type, name, field_name, choices, for_client) FROM stdin;
\.


--
-- Data for Name: milestone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.milestone (id, created_at, updated_at, date, name, project_id, task_type_id) FROM stdin;
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, created_at, updated_at, change, author_id, comment_id, task_id, preview_file_id) FROM stdin;
25d67b1d-17a6-48e8-8993-5155d715f1f4	2023-06-21 14:22:02	2023-06-21 14:22:03.139336	t	bc560a1e-c50e-44b3-93a3-a58151bf742a	ea57e92d-3b3c-4a00-92f3-6a3b687bebe0	67492971-ef53-4a46-8554-5c6248341169	\N
5c602afd-d743-4b92-a982-76bac8e6a17b	2023-06-21 14:22:03	2023-06-21 14:22:03.247629	t	bc560a1e-c50e-44b3-93a3-a58151bf742a	3307e21f-0eb2-4b7d-9137-231345d975e7	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	\N
7d2ea237-636f-42bb-93a5-85c12d78508f	2023-06-21 14:22:03	2023-06-21 14:22:03.362488	t	bc560a1e-c50e-44b3-93a3-a58151bf742a	65f46e1e-ae8e-4ef1-8a3d-8c88ae6442cf	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	\N
82c38553-1b65-487f-9fa0-ff9a6a1610ec	2023-06-21 14:22:03	2023-06-21 14:22:03.475374	t	bc560a1e-c50e-44b3-93a3-a58151bf742a	f8dfd0b8-c2cb-447e-8b07-2a3529fc3014	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	\N
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, created_at, updated_at, read, change, person_id, author_id, comment_id, task_id, type, reply_id) FROM stdin;
6de0b190-ceb1-430d-95bc-8fe257617fbf	2023-06-21 14:22:07.814571	2023-06-21 14:22:07.814575	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
e0b11f89-29d6-475a-b076-103538eeb4dc	2023-06-21 14:22:07.881545	2023-06-21 14:22:07.881549	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	assignation	\N
6640d190-8087-46c5-98a4-89ae1998fd3d	2023-06-21 14:22:07.947389	2023-06-21 14:22:07.947393	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
3f6bad72-5561-49ac-8742-4c016dff583d	2023-06-21 14:22:08.019539	2023-06-21 14:22:08.019543	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
5cf79dd2-b2a8-4eb5-97b3-0cc698de9f2f	2023-06-21 14:32:05.395041	2023-06-21 14:32:05.395045	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
08e948f5-e08e-4e5e-8ebf-0f0148295e56	2023-06-21 14:32:05.45583	2023-06-21 14:32:05.455834	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	assignation	\N
19cacaa2-0bb7-4f86-a5d1-d89999c3cedf	2023-06-21 14:32:05.517558	2023-06-21 14:32:05.517562	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
6107e080-e9e2-4394-8aba-0797f64f51c1	2023-06-21 14:32:05.603204	2023-06-21 14:32:05.603209	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
054d4492-04c6-4b03-890a-ff3b6037a368	2023-06-21 14:40:15.390761	2023-06-21 14:40:15.390765	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
315e109a-32cc-4561-8b12-266c3aa73bc0	2023-06-21 14:40:15.460136	2023-06-21 14:40:15.460141	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	assignation	\N
69affe32-1a1c-493a-86fe-d08c18c65604	2023-06-21 14:40:15.52304	2023-06-21 14:40:15.523045	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
19cf724d-dcd6-4caf-b4c1-83e83d187c5b	2023-06-21 14:40:15.586694	2023-06-21 14:40:15.5867	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
3ef9dccd-88e2-48e2-99d4-691b00bdd332	2023-06-21 14:41:46.924108	2023-06-21 14:41:46.924112	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
da8bf35f-da04-400b-865d-5362a77c54f7	2023-06-21 14:41:59.407502	2023-06-21 14:41:59.407507	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
2fa8f29a-9169-4571-895c-83c969938510	2023-06-21 14:47:17.209265	2023-06-21 14:47:17.20927	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
a1316e3a-ad6c-48f0-8602-e54aea9c3e48	2023-06-21 14:47:32.669596	2023-06-21 14:47:32.6696	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
070b3b83-0f7c-4fa1-8dff-4e8c2d987b9f	2023-06-21 14:53:36.580291	2023-06-21 14:53:36.580295	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
50be69c5-19d3-4f35-a5c2-04df5869f895	2023-06-21 15:02:26.596052	2023-06-21 15:02:26.596056	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
e2dfd036-16be-4ae2-8ebd-eeb3fd1d43c5	2023-06-21 15:02:53.351501	2023-06-21 15:02:53.351506	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
2ef113b4-156e-44a5-9441-45962ca93e3e	2023-06-21 15:03:38.360491	2023-06-21 15:03:38.360496	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
4eeeb052-2f32-47b5-a7c1-f4f0567b7f5a	2023-06-21 15:05:57.355247	2023-06-21 15:05:57.355251	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	assignation	\N
b6577ff8-461f-44ba-9af3-26975dd2f14e	2023-06-21 15:05:57.417351	2023-06-21 15:05:57.417355	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	67492971-ef53-4a46-8554-5c6248341169	assignation	\N
76a9ee50-a74e-4ea8-acb7-332729343e1a	2023-06-21 15:05:57.478263	2023-06-21 15:05:57.478268	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	6db83d88-2590-4cc1-bf47-a3d3c62b5c28	assignation	\N
a8a37950-d923-4d65-af36-b6925179f7d0	2023-06-21 15:05:57.535019	2023-06-21 15:05:57.535023	f	f	f94a5f53-881f-4fa7-98a4-5006c0017293	bc560a1e-c50e-44b3-93a3-a58151bf742a	\N	13b86d8a-85a6-40a0-bf67-11b3c823d4ea	assignation	\N
\.


--
-- Data for Name: organisation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organisation (id, created_at, updated_at, name, hours_by_day, has_avatar, use_original_file_name, chat_token_slack, timesheets_locked, hd_by_default, chat_webhook_mattermost, chat_token_discord) FROM stdin;
04f8faf4-d36c-497b-a9cf-c22566641a6f	2023-06-21 14:20:30.364266	2023-06-21 14:20:30.364276	Kitsu	8	f	f		f	f		
\.


--
-- Data for Name: output_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.output_file (id, created_at, updated_at, shotgun_id, name, extension, description, comment, revision, size, checksum, source, path, representation, nb_elements, canceled, file_status_id, entity_id, asset_instance_id, output_type_id, task_type_id, person_id, source_file_id, temporal_entity_id, data) FROM stdin;
\.


--
-- Data for Name: output_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.output_type (id, created_at, updated_at, name, short_name) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, created_at, updated_at, first_name, last_name, email, phone, active, last_presence, password, desktop_login, shotgun_id, timezone, locale, data, role, has_avatar, notifications_enabled, notifications_slack_enabled, notifications_slack_userid, notifications_mattermost_enabled, notifications_mattermost_userid, notifications_discord_enabled, notifications_discord_userid, archived, is_generated_from_ldap, login_failed_attemps, last_login_failed, totp_enabled, totp_secret, otp_recovery_codes, email_otp_enabled, email_otp_secret, preferred_two_factor_authentication, fido_enabled, fido_credentials) FROM stdin;
103f4373-52f3-4e71-97c9-0272bad7a176	2023-06-21 14:19:28.304745	2023-06-21 14:19:28.304751	Super	Admin	admin@example.com		t	\N	\\x2432622431322430795373734f6e6f464e7256756d3837315a6f30644f5859567550414a4c6b643665666752344330366a47536b6457704b336e7971		\N	Europe/Paris	en_US	\N	admin	f	f	f		f		f		f	f	0	\N	f	\N	\N	f	\N	\N	f	\N
f94a5f53-881f-4fa7-98a4-5006c0017293	2023-06-21 14:19:36.282422	2023-07-05 13:00:52.42606	Aderemi	Adesada	aderemi@eaxum.com		t	\N	\\x64656661756c74	aderemi-adesada	\N	Europe/Paris	en_US	\N	user	f	f	f		f		f		f	t	0	\N	f	\N	\N	f	\N	\N	f	\N
bc560a1e-c50e-44b3-93a3-a58151bf742a	2023-06-21 14:19:36.217935	2023-07-05 13:00:52.349121	super	user	super-user@email.com		t	\N	\\x64656661756c74	super-user	\N	Europe/Paris	en_US	\N	admin	f	f	f		f		f		f	t	0	\N	f	\N	\N	f	\N	\N	f	\N
\.


--
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlist (id, created_at, updated_at, name, shots, project_id, episode_id, for_client, for_entity, is_for_all, task_type_id) FROM stdin;
\.


--
-- Data for Name: preview_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preview_file (id, created_at, updated_at, name, revision, description, source, shotgun_id, is_movie, url, uploaded_movie_url, uploaded_movie_name, task_id, person_id, source_file_id, path, extension, annotations, original_name, "position", status, file_size, validation_status) FROM stdin;
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (id, created_at, updated_at, name, description, shotgun_id, file_tree, data, project_status_id, has_avatar, fps, ratio, resolution, production_type, code, end_date, start_date, man_days, episode_span, nb_episodes, is_clients_isolated, max_retakes, production_style) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	2023-06-21 14:21:43.717927	2023-06-21 14:22:08.034949	Project Animals	\N	\N	{"output": {"root": "previews", "file_name": {"shot": "<Project>_<Sequence>_<Shot>_<OutputType>_<OutputFile>", "asset": "<Project>_<AssetType>_<Asset>_<OutputType>_<OutputFile>", "scene": "<Project>_<Sequence>_<Scene>_<OutputType>_<OutputFile>", "style": "lowercase", "sequence": "<Project>_<Sequence>_<OuputType>_<OutputFile>"}, "mountpoint": "//rukia/render", "folder_path": {"shot": "<Project>/shots/<Sequence>/<Shot>/<OutputType>", "asset": "<Project>/assets/<AssetType>/<Asset>/<OutputType>", "scene": "<Project>/scenes/<Sequence>/<Scene>/<OutputType>", "style": "lowercase", "sequence": "<Project>/sequences/<Sequence>/<OutputType>"}}, "preview": {"root": "productions/previews", "file_name": {"shot": "<Project>_<Sequence>_<Shot>_<TaskType>", "asset": "<Project>_<AssetType>_<Asset>_<TaskType>", "scene": "<Project>_<Scene>_<TaskType>", "style": "lowercase", "sequence": "<Project>_<Sequence>_<TaskType>"}, "mountpoint": "/simple", "folder_path": {"shot": "<Project>/shots/<Sequence>/<Shot>/<TaskType>", "asset": "<Project>/assets/<AssetType>/<Asset>/<TaskType>", "scene": "<Project>/scene/<Scene>/<TaskType>", "style": "lowercase", "sequence": "<Project>/sequences/<Sequence>/<TaskType>"}}, "working": {"root": "projects", "file_name": {"shot": "<Sequence>_<Shot>", "asset": "<Asset>", "scene": "<Scene>", "style": "lowercase", "sequence": "<Sequence>"}, "mountpoint": "~", "folder_path": {"shot": "<Project>/scenes/<Sequence>/<Shot>", "asset": "<Project>/lib/<AssetType>", "scene": "<Project>/scenes/<Sequence>/<Scene>/<TaskType>", "style": "lowercase", "sequence": "<Project>/sequences/<Sequence>/<TaskType>"}}}	{"file_map": {"fx": {"file": "fx", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "sound": {"file": "sound", "softwares": [{"name": "flstudio", "alternate": "none", "extension": "flp", "use_default": true}]}, "layout": {"file": "layout", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "previz": {"file": "layout", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "concept": {"file": "base", "softwares": [{"name": "sketchbook", "alternate": "none", "extension": "tif", "use_default": true}]}, "rigging": {"file": "rigging", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "shading": {"file": "shading", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "staging": {"file": "base", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "grooming": {"file": "grooming", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "lighting": {"file": "lighting", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "modeling": {"file": "modeling", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "animation": {"file": "anim", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "rendering": {"file": "lighting", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}, "storyboard": {"file": "base", "softwares": [{"name": "clipstudio", "alternate": "none", "extension": "clip", "use_default": true}]}, "compositing": {"file": "comp", "softwares": [{"name": "blender", "alternate": "none", "extension": "blend", "use_default": true}]}}, "file_name": "project_animals", "svn_repositories": {"default": "http://localhost/svn/project_animals"}}	866f8470-5357-4138-947f-4f5449152153	f	25	16:9	1920x1080	short	\N	2023-06-21	2023-06-01	\N	0	0	f	0	2d
\.


--
-- Data for Name: project_asset_type_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_asset_type_link (project_id, asset_type_id) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	1eb8659a-446d-4519-afce-388372d66f87
b778fddb-916a-41bf-8bfd-f0b57193a686	66e5367e-4ccb-40f9-a590-f5e1ae6ea872
b778fddb-916a-41bf-8bfd-f0b57193a686	1cda1d73-ed42-4b6b-acc4-8c2a98da1941
b778fddb-916a-41bf-8bfd-f0b57193a686	98dc45c2-53f4-4f27-bfb9-0c92254aa6c0
\.


--
-- Data for Name: project_person_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_person_link (project_id, person_id, shotgun_id) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	f94a5f53-881f-4fa7-98a4-5006c0017293	\N
\.


--
-- Data for Name: project_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_status (id, created_at, updated_at, name, color) FROM stdin;
866f8470-5357-4138-947f-4f5449152153	2023-06-21 14:19:25.771925	2023-06-21 14:19:25.771077	Open	#000000
f608f659-88e6-4f12-947d-6ba87b8c6c1f	2023-06-21 14:19:25.778008	2023-06-21 14:19:25.777781	Closed	#000000
\.


--
-- Data for Name: project_status_automation_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_status_automation_link (project_id, status_automation_id) FROM stdin;
\.


--
-- Data for Name: project_task_status_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_task_status_link (project_id, task_status_id) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	3b66c6f4-21db-4670-aae4-66be773b6e52
b778fddb-916a-41bf-8bfd-f0b57193a686	59a5e386-f3ac-4963-848f-735be9831106
b778fddb-916a-41bf-8bfd-f0b57193a686	9e0d135f-1e7d-4b61-b6e4-3d6dcc65eb4e
b778fddb-916a-41bf-8bfd-f0b57193a686	19f673d5-cd49-4682-b1c9-b11f8fb11e38
b778fddb-916a-41bf-8bfd-f0b57193a686	1fe0b283-525b-4d2e-9702-9d84abcff7ff
\.


--
-- Data for Name: project_task_type_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_task_type_link (project_id, task_type_id, created_at, id, updated_at, priority) FROM stdin;
b778fddb-916a-41bf-8bfd-f0b57193a686	b4a56a30-bf04-4e01-9431-80674323f97d	2023-06-21 14:21:43.782528	e1b12de0-8c16-40f1-9d35-d64a1e44c64b	2023-06-21 14:21:43.782538	2
b778fddb-916a-41bf-8bfd-f0b57193a686	e3b6cbda-d851-42ae-838c-3e6aea439e97	2023-06-21 14:21:43.785575	ce0bd19e-fe0c-4848-8b9f-cfba205c8e71	2023-06-21 14:21:43.785579	1
b778fddb-916a-41bf-8bfd-f0b57193a686	37ae0ce9-c445-4967-8aee-1b525409cd70	2023-06-21 14:21:43.787907	1a145e7d-2da5-4ad8-944d-b34d303e46a5	2023-06-21 14:21:43.787911	4
b778fddb-916a-41bf-8bfd-f0b57193a686	411d4294-8004-4dd7-9258-feabd8ee2662	2023-06-21 14:21:43.810756	50480ca7-646a-42a2-ba5b-010771e70c47	2023-06-21 14:21:43.810761	3
b778fddb-916a-41bf-8bfd-f0b57193a686	e1100869-7a6d-4b3e-a27c-37f16af057e4	2023-06-21 14:21:43.815856	275afdbb-6cf8-457d-b0fe-7f57ec5d253b	2023-06-21 14:21:43.815864	1
b778fddb-916a-41bf-8bfd-f0b57193a686	9e883abf-0826-4172-9191-10987254fb32	2023-06-21 14:21:43.827972	df2053ef-f2da-4a80-b057-df8e08746b73	2023-06-21 14:21:43.827981	2
b778fddb-916a-41bf-8bfd-f0b57193a686	0a6dca9f-dc67-4d68-8d21-78004afe8dcd	2023-06-21 14:21:43.878282	1b172614-15a4-4262-9c06-35aa83a45457	2023-06-21 14:21:43.878289	3
b778fddb-916a-41bf-8bfd-f0b57193a686	16e1ac85-480f-46a1-8267-0d08dc57a923	2023-06-21 14:21:43.93583	d40a2fbf-a48c-4521-acf3-1dafd0ecd1f9	2023-06-21 14:21:43.935835	5
b778fddb-916a-41bf-8bfd-f0b57193a686	6f54d762-2904-4f92-8f05-4a7a19bdc158	2023-06-21 14:21:43.936778	9bf78737-6582-489e-8f5d-6e583b85b482	2023-06-21 14:21:43.936783	6
b778fddb-916a-41bf-8bfd-f0b57193a686	b11923b2-1009-48dc-93be-bf18b8815d5c	2023-06-21 14:21:43.947279	ab9d973c-ccbb-4e27-9f34-0b969affc717	2023-06-21 14:21:43.947283	4
b778fddb-916a-41bf-8bfd-f0b57193a686	168f989e-a4b2-41aa-ae80-99e6395464dc	2023-06-21 14:21:43.954175	d85cc8b2-a1d3-440d-9e9a-f9b75d2d778f	2023-06-21 14:21:43.954181	7
\.


--
-- Data for Name: schedule_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule_item (id, created_at, updated_at, start_date, end_date, project_id, task_type_id, man_days, object_id) FROM stdin;
\.


--
-- Data for Name: search_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.search_filter (id, created_at, updated_at, list_type, name, search_query, person_id, project_id, entity_type) FROM stdin;
\.


--
-- Data for Name: software; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.software (id, created_at, updated_at, name, short_name, file_extension, secondary_extensions) FROM stdin;
\.


--
-- Data for Name: status_automation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status_automation (id, created_at, updated_at, entity_type, in_task_type_id, in_task_status_id, out_field_type, out_task_type_id, out_task_status_id) FROM stdin;
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription (id, created_at, updated_at, person_id, task_id, entity_id, task_type_id) FROM stdin;
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (id, created_at, updated_at, name, description, duration, estimation, completion_rate, sort_order, start_date, end_date, due_date, real_start_date, shotgun_id, project_id, task_type_id, task_status_id, entity_id, assigner_id, priority, last_comment_date, retake_count, data, nb_assets_ready) FROM stdin;
6db83d88-2590-4cc1-bf47-a3d3c62b5c28	2023-06-21 14:21:52.854471	2023-06-21 15:05:57.438236	main	\N	0	0	0	0	\N	\N	\N	\N	\N	b778fddb-916a-41bf-8bfd-f0b57193a686	b4a56a30-bf04-4e01-9431-80674323f97d	59a5e386-f3ac-4963-848f-735be9831106	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	bc560a1e-c50e-44b3-93a3-a58151bf742a	0	2023-06-21 14:22:03	0	\N	0
13b86d8a-85a6-40a0-bf67-11b3c823d4ea	2023-06-21 14:21:52.855295	2023-06-21 15:05:57.49498	main	\N	0	0	0	0	\N	\N	\N	\N	\N	b778fddb-916a-41bf-8bfd-f0b57193a686	411d4294-8004-4dd7-9258-feabd8ee2662	59a5e386-f3ac-4963-848f-735be9831106	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	bc560a1e-c50e-44b3-93a3-a58151bf742a	0	2023-06-21 14:22:03	0	\N	0
67492971-ef53-4a46-8554-5c6248341169	2023-06-21 14:21:52.887625	2023-06-21 15:05:57.375458	main	\N	0	0	0	0	\N	\N	\N	\N	\N	b778fddb-916a-41bf-8bfd-f0b57193a686	e3b6cbda-d851-42ae-838c-3e6aea439e97	59a5e386-f3ac-4963-848f-735be9831106	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	bc560a1e-c50e-44b3-93a3-a58151bf742a	0	2023-06-21 14:22:02	0	\N	0
d2d68f0e-7f4f-4510-9fc7-13bc32d0ea89	2023-06-21 14:21:52.854431	2023-06-21 15:06:10.85898	main	\N	0	0	0	0	\N	\N	\N	\N	\N	b778fddb-916a-41bf-8bfd-f0b57193a686	37ae0ce9-c445-4967-8aee-1b525409cd70	59a5e386-f3ac-4963-848f-735be9831106	df4d0dc4-e14b-4b0e-b42b-fe7414e2c93c	bc560a1e-c50e-44b3-93a3-a58151bf742a	0	2023-06-21 14:22:03	0	\N	0
\.


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_status (id, created_at, updated_at, name, short_name, color, is_done, shotgun_id, is_artist_allowed, is_retake, is_client_allowed, is_feedback_request, is_default, archived) FROM stdin;
6213296a-71f3-4fab-9665-16e7cd8a3101	2023-06-21 14:19:26.024172	2023-06-21 14:19:26.024178	Todo	todo	#f5f5f5	f	\N	t	f	t	f	t	f
19f673d5-cd49-4682-b1c9-b11f8fb11e38	2023-06-21 14:19:26.034415	2023-06-21 14:19:26.034419	Work In Progress	wip	#3273dc	f	\N	t	f	t	f	f	f
9e0d135f-1e7d-4b61-b6e4-3d6dcc65eb4e	2023-06-21 14:19:26.043806	2023-06-21 14:19:26.043811	Waiting For Approval	wfa	#ab26ff	f	\N	t	f	t	t	f	f
1fe0b283-525b-4d2e-9702-9d84abcff7ff	2023-06-21 14:19:26.053551	2023-06-21 14:19:26.053555	Retake	retake	#ff3860	f	\N	t	t	t	f	f	f
3b66c6f4-21db-4670-aae4-66be773b6e52	2023-06-21 14:19:26.063275	2023-06-21 14:19:26.063279	Done	done	#22d160	t	\N	t	f	t	f	f	f
59a5e386-f3ac-4963-848f-735be9831106	2023-06-21 14:19:26.071502	2023-06-21 14:19:26.071506	Ready To Start	ready	#fbc02d	f	\N	t	f	t	f	f	f
\.


--
-- Data for Name: task_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_type (id, created_at, updated_at, name, short_name, color, priority, shotgun_id, department_id, for_entity, allow_timelog, archived) FROM stdin;
e3b6cbda-d851-42ae-838c-3e6aea439e97	2023-06-21 14:19:25.928138	2023-06-21 14:19:25.928142	Concept		#8D6E63	1	\N	0839dd18-c942-4cac-8dcf-993635f03625	Asset	t	f
b4a56a30-bf04-4e01-9431-80674323f97d	2023-06-21 14:19:25.935741	2023-06-21 14:19:25.935746	Modeling		#78909C	2	\N	e09c4428-dc93-4ec3-9983-163127d2fc7a	Asset	t	f
411d4294-8004-4dd7-9258-feabd8ee2662	2023-06-21 14:19:25.943806	2023-06-21 14:19:25.94381	Shading		#64B5F6	3	\N	e09c4428-dc93-4ec3-9983-163127d2fc7a	Asset	t	f
37ae0ce9-c445-4967-8aee-1b525409cd70	2023-06-21 14:19:25.95095	2023-06-21 14:19:25.950955	Rigging		#9CCC65	4	\N	c6f9290a-b231-4d6b-b60f-e46bdd05c43a	Asset	t	f
e1100869-7a6d-4b3e-a27c-37f16af057e4	2023-06-21 14:19:25.958781	2023-06-21 14:19:25.958785	Storyboard		#43A047	1	\N	0839dd18-c942-4cac-8dcf-993635f03625	Shot	t	f
9e883abf-0826-4172-9191-10987254fb32	2023-06-21 14:19:25.965446	2023-06-21 14:19:25.96545	Layout		#7CB342	2	\N	e790b577-f12d-4cdf-b255-db5fa251f34b	Shot	t	f
0a6dca9f-dc67-4d68-8d21-78004afe8dcd	2023-06-21 14:19:25.972448	2023-06-21 14:19:25.972452	Animation		#009688	3	\N	c6f9290a-b231-4d6b-b60f-e46bdd05c43a	Shot	t	f
b11923b2-1009-48dc-93be-bf18b8815d5c	2023-06-21 14:19:25.979253	2023-06-21 14:19:25.979257	Lighting		#F9A825	4	\N	edd0bdd7-a5e0-457e-8cc2-81089e14db4d	Shot	t	f
16e1ac85-480f-46a1-8267-0d08dc57a923	2023-06-21 14:19:25.986694	2023-06-21 14:19:25.986698	FX		#26C6DA	5	\N	fcbd85f3-b487-4aa2-b9db-66a94327a42e	Shot	t	f
6f54d762-2904-4f92-8f05-4a7a19bdc158	2023-06-21 14:19:25.994273	2023-06-21 14:19:25.994276	Rendering		#F06292	6	\N	edd0bdd7-a5e0-457e-8cc2-81089e14db4d	Shot	t	f
168f989e-a4b2-41aa-ae80-99e6395464dc	2023-06-21 14:19:26.003033	2023-06-21 14:19:26.003038	Compositing		#ff5252	7	\N	edd0bdd7-a5e0-457e-8cc2-81089e14db4d	Shot	t	f
e09e1180-f6e7-4b74-a34f-d8312de23ec4	2023-06-21 14:19:26.012211	2023-06-21 14:19:26.012215	Edit		#9b298c	8	\N	edd0bdd7-a5e0-457e-8cc2-81089e14db4d	Edit	t	f
\.


--
-- Data for Name: task_type_asset_type_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_type_asset_type_link (asset_type_id, task_type_id) FROM stdin;
\.


--
-- Data for Name: time_spent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.time_spent (id, created_at, updated_at, duration, date, task_id, person_id) FROM stdin;
\.


--
-- Data for Name: working_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.working_file (id, created_at, updated_at, shotgun_id, name, description, comment, revision, size, checksum, path, task_id, entity_id, person_id, software_id, data) FROM stdin;
\.


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: api_event api_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_event
    ADD CONSTRAINT api_event_pkey PRIMARY KEY (id);


--
-- Name: asset_instance_link asset_instance_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance_link
    ADD CONSTRAINT asset_instance_link_pkey PRIMARY KEY (entity_id, asset_instance_id);


--
-- Name: asset_instance asset_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_pkey PRIMARY KEY (id);


--
-- Name: asset_instance asset_instance_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_uc UNIQUE (asset_id, target_asset_id, scene_id, number);


--
-- Name: assignations assignations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignations
    ADD CONSTRAINT assignations_pkey PRIMARY KEY (task, person);


--
-- Name: attachment_file attachment_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment_file
    ADD CONSTRAINT attachment_file_pkey PRIMARY KEY (id);


--
-- Name: attachment_file attachment_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment_file
    ADD CONSTRAINT attachment_uc UNIQUE (name, comment_id);


--
-- Name: build_job build_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_job
    ADD CONSTRAINT build_job_pkey PRIMARY KEY (id);


--
-- Name: comment_acknoledgments comment_acknoledgments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_acknoledgments
    ADD CONSTRAINT comment_acknoledgments_pkey PRIMARY KEY (comment, person);


--
-- Name: comment_mentions comment_mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_mentions
    ADD CONSTRAINT comment_mentions_pkey PRIMARY KEY (comment, person);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: comment_preview_link comment_preview_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_preview_link
    ADD CONSTRAINT comment_preview_link_pkey PRIMARY KEY (comment, preview_file);


--
-- Name: custom_action custom_action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custom_action
    ADD CONSTRAINT custom_action_pkey PRIMARY KEY (id);


--
-- Name: data_import_error data_import_error_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_import_error
    ADD CONSTRAINT data_import_error_pkey PRIMARY KEY (id);


--
-- Name: day_off day_off_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.day_off
    ADD CONSTRAINT day_off_pkey PRIMARY KEY (id);


--
-- Name: day_off day_off_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.day_off
    ADD CONSTRAINT day_off_uc UNIQUE (person_id, date);


--
-- Name: department department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_name_key UNIQUE (name);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: desktop_login_log desktop_login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.desktop_login_log
    ADD CONSTRAINT desktop_login_log_pkey PRIMARY KEY (id);


--
-- Name: entity_link entity_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_pkey PRIMARY KEY (id, entity_in_id, entity_out_id);


--
-- Name: entity_link entity_link_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_uc UNIQUE (entity_in_id, entity_out_id);


--
-- Name: entity entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: entity_type entity_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_type
    ADD CONSTRAINT entity_type_pkey PRIMARY KEY (id);


--
-- Name: entity entity_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_uc UNIQUE (name, project_id, entity_type_id, parent_id);


--
-- Name: entity_version entity_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_version
    ADD CONSTRAINT entity_version_pkey PRIMARY KEY (id);


--
-- Name: file_status file_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_status
    ADD CONSTRAINT file_status_name_key UNIQUE (name);


--
-- Name: file_status file_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_status
    ADD CONSTRAINT file_status_pkey PRIMARY KEY (id);


--
-- Name: login_log login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_log
    ADD CONSTRAINT login_log_pkey PRIMARY KEY (id);


--
-- Name: metadata_descriptor metadata_descriptor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata_descriptor
    ADD CONSTRAINT metadata_descriptor_pkey PRIMARY KEY (id);


--
-- Name: metadata_descriptor metadata_descriptor_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata_descriptor
    ADD CONSTRAINT metadata_descriptor_uc UNIQUE (project_id, entity_type, name);


--
-- Name: metadata_descriptor metadata_descriptor_uc2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata_descriptor
    ADD CONSTRAINT metadata_descriptor_uc2 UNIQUE (project_id, entity_type, field_name);


--
-- Name: milestone milestone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification notification_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_uc UNIQUE (person_id, author_id, comment_id, reply_id, type);


--
-- Name: organisation organisation_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organisation
    ADD CONSTRAINT organisation_name_key UNIQUE (name);


--
-- Name: organisation organisation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (id);


--
-- Name: output_file output_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_pkey PRIMARY KEY (id);


--
-- Name: output_file output_file_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_uc UNIQUE (name, entity_id, asset_instance_id, output_type_id, task_type_id, temporal_entity_id, representation, revision);


--
-- Name: output_type output_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_type
    ADD CONSTRAINT output_type_pkey PRIMARY KEY (id);


--
-- Name: person person_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_email_key UNIQUE (email);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: person person_shotgun_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_shotgun_id_key UNIQUE (shotgun_id);


--
-- Name: playlist playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: playlist playlist_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_uc UNIQUE (name, project_id, episode_id);


--
-- Name: preview_file preview_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_file_pkey PRIMARY KEY (id);


--
-- Name: preview_file preview_file_shotgun_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_file_shotgun_id_key UNIQUE (shotgun_id);


--
-- Name: preview_file preview_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_uc UNIQUE (name, task_id, revision);


--
-- Name: project_asset_type_link project_asset_type_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_asset_type_link
    ADD CONSTRAINT project_asset_type_link_pkey PRIMARY KEY (project_id, asset_type_id);


--
-- Name: project_person_link project_person_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_person_link
    ADD CONSTRAINT project_person_link_pkey PRIMARY KEY (project_id, person_id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_status_automation_link project_status_automation_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_status_automation_link
    ADD CONSTRAINT project_status_automation_link_pkey PRIMARY KEY (project_id, status_automation_id);


--
-- Name: project_status project_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_status
    ADD CONSTRAINT project_status_pkey PRIMARY KEY (id);


--
-- Name: project_task_status_link project_task_status_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_status_link
    ADD CONSTRAINT project_task_status_link_pkey PRIMARY KEY (project_id, task_status_id);


--
-- Name: project_task_type_link project_task_type_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_type_link
    ADD CONSTRAINT project_task_type_link_pkey PRIMARY KEY (project_id, task_type_id);


--
-- Name: project_task_type_link project_tasktype_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_type_link
    ADD CONSTRAINT project_tasktype_uc UNIQUE (project_id, task_type_id);


--
-- Name: schedule_item schedule_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_item
    ADD CONSTRAINT schedule_item_pkey PRIMARY KEY (id);


--
-- Name: schedule_item schedule_item_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_item
    ADD CONSTRAINT schedule_item_uc UNIQUE (project_id, task_type_id, object_id);


--
-- Name: search_filter search_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_filter
    ADD CONSTRAINT search_filter_pkey PRIMARY KEY (id);


--
-- Name: software software_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_name_key UNIQUE (name);


--
-- Name: software software_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pkey PRIMARY KEY (id);


--
-- Name: status_automation status_automation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_automation
    ADD CONSTRAINT status_automation_pkey PRIMARY KEY (id);


--
-- Name: subscription subscription_entity_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_entity_uc UNIQUE (person_id, task_type_id, entity_id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: subscription subscription_task_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_task_uc UNIQUE (person_id, task_id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: task_type task_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_type
    ADD CONSTRAINT task_type_pkey PRIMARY KEY (id);


--
-- Name: task_type task_type_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_type
    ADD CONSTRAINT task_type_uc UNIQUE (name, for_entity, department_id);


--
-- Name: task task_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_uc UNIQUE (name, project_id, task_type_id, entity_id);


--
-- Name: time_spent time_spent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_spent
    ADD CONSTRAINT time_spent_pkey PRIMARY KEY (id);


--
-- Name: time_spent time_spent_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_spent
    ADD CONSTRAINT time_spent_uc UNIQUE (person_id, task_id, date);


--
-- Name: working_file working_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_pkey PRIMARY KEY (id);


--
-- Name: working_file working_file_uc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_uc UNIQUE (name, task_id, entity_id, revision);


--
-- Name: ix_api_event_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_api_event_name ON public.api_event USING btree (name);


--
-- Name: ix_api_event_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_api_event_project_id ON public.api_event USING btree (project_id);


--
-- Name: ix_api_event_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_api_event_user_id ON public.api_event USING btree (user_id);


--
-- Name: ix_asset_instance_asset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_asset_instance_asset_id ON public.asset_instance USING btree (asset_id);


--
-- Name: ix_asset_instance_scene_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_asset_instance_scene_id ON public.asset_instance USING btree (scene_id);


--
-- Name: ix_asset_instance_target_asset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_asset_instance_target_asset_id ON public.asset_instance USING btree (target_asset_id);


--
-- Name: ix_attachment_file_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_attachment_file_comment_id ON public.attachment_file USING btree (comment_id);


--
-- Name: ix_build_job_playlist_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_build_job_playlist_id ON public.build_job USING btree (playlist_id);


--
-- Name: ix_comment_object_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_comment_object_id ON public.comment USING btree (object_id);


--
-- Name: ix_comment_object_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_comment_object_type ON public.comment USING btree (object_type);


--
-- Name: ix_day_off_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_day_off_person_id ON public.day_off USING btree (person_id);


--
-- Name: ix_desktop_login_log_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_desktop_login_log_person_id ON public.desktop_login_log USING btree (person_id);


--
-- Name: ix_entity_entity_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_entity_type_id ON public.entity USING btree (entity_type_id);


--
-- Name: ix_entity_link_entity_in_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_link_entity_in_id ON public.entity_link USING btree (entity_in_id);


--
-- Name: ix_entity_link_entity_out_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_link_entity_out_id ON public.entity_link USING btree (entity_out_id);


--
-- Name: ix_entity_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_parent_id ON public.entity USING btree (parent_id);


--
-- Name: ix_entity_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_project_id ON public.entity USING btree (project_id);


--
-- Name: ix_entity_source_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_source_id ON public.entity USING btree (source_id);


--
-- Name: ix_entity_type_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_entity_type_name ON public.entity_type USING btree (name);


--
-- Name: ix_entity_version_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_version_entity_id ON public.entity_version USING btree (entity_id);


--
-- Name: ix_entity_version_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_entity_version_person_id ON public.entity_version USING btree (person_id);


--
-- Name: ix_login_log_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_login_log_person_id ON public.login_log USING btree (person_id);


--
-- Name: ix_metadata_descriptor_entity_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_metadata_descriptor_entity_type ON public.metadata_descriptor USING btree (entity_type);


--
-- Name: ix_metadata_descriptor_for_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_metadata_descriptor_for_client ON public.metadata_descriptor USING btree (for_client);


--
-- Name: ix_metadata_descriptor_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_metadata_descriptor_project_id ON public.metadata_descriptor USING btree (project_id);


--
-- Name: ix_milestone_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_milestone_project_id ON public.milestone USING btree (project_id);


--
-- Name: ix_milestone_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_milestone_task_type_id ON public.milestone USING btree (task_type_id);


--
-- Name: ix_news_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_author_id ON public.news USING btree (author_id);


--
-- Name: ix_news_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_comment_id ON public.news USING btree (comment_id);


--
-- Name: ix_news_preview_file_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_preview_file_id ON public.news USING btree (preview_file_id);


--
-- Name: ix_news_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_news_task_id ON public.news USING btree (task_id);


--
-- Name: ix_notification_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notification_author_id ON public.notification USING btree (author_id);


--
-- Name: ix_notification_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notification_comment_id ON public.notification USING btree (comment_id);


--
-- Name: ix_notification_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notification_person_id ON public.notification USING btree (person_id);


--
-- Name: ix_notification_reply_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notification_reply_id ON public.notification USING btree (reply_id);


--
-- Name: ix_notification_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notification_task_id ON public.notification USING btree (task_id);


--
-- Name: ix_output_file_asset_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_output_file_asset_instance_id ON public.output_file USING btree (asset_instance_id);


--
-- Name: ix_output_file_output_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_output_file_output_type_id ON public.output_file USING btree (output_type_id);


--
-- Name: ix_output_file_representation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_output_file_representation ON public.output_file USING btree (representation);


--
-- Name: ix_output_file_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_output_file_task_type_id ON public.output_file USING btree (task_type_id);


--
-- Name: ix_output_type_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_output_type_name ON public.output_type USING btree (name);


--
-- Name: ix_playlist_episode_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_playlist_episode_id ON public.playlist USING btree (episode_id);


--
-- Name: ix_playlist_for_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_playlist_for_client ON public.playlist USING btree (for_client);


--
-- Name: ix_playlist_for_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_playlist_for_entity ON public.playlist USING btree (for_entity);


--
-- Name: ix_playlist_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_playlist_project_id ON public.playlist USING btree (project_id);


--
-- Name: ix_playlist_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_playlist_task_type_id ON public.playlist USING btree (task_type_id);


--
-- Name: ix_preview_file_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_preview_file_task_id ON public.preview_file USING btree (task_id);


--
-- Name: ix_project_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_project_name ON public.project USING btree (name);


--
-- Name: ix_project_project_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_project_project_status_id ON public.project USING btree (project_status_id);


--
-- Name: ix_project_status_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_project_status_name ON public.project_status USING btree (name);


--
-- Name: ix_schedule_item_object_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_schedule_item_object_id ON public.schedule_item USING btree (object_id);


--
-- Name: ix_schedule_item_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_schedule_item_project_id ON public.schedule_item USING btree (project_id);


--
-- Name: ix_schedule_item_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_schedule_item_task_type_id ON public.schedule_item USING btree (task_type_id);


--
-- Name: ix_search_filter_list_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_search_filter_list_type ON public.search_filter USING btree (list_type);


--
-- Name: ix_status_automation_in_task_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_automation_in_task_status_id ON public.status_automation USING btree (in_task_status_id);


--
-- Name: ix_status_automation_in_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_automation_in_task_type_id ON public.status_automation USING btree (in_task_type_id);


--
-- Name: ix_status_automation_out_task_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_automation_out_task_status_id ON public.status_automation USING btree (out_task_status_id);


--
-- Name: ix_status_automation_out_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_automation_out_task_type_id ON public.status_automation USING btree (out_task_type_id);


--
-- Name: ix_subscription_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_entity_id ON public.subscription USING btree (entity_id);


--
-- Name: ix_subscription_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_person_id ON public.subscription USING btree (person_id);


--
-- Name: ix_subscription_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_task_id ON public.subscription USING btree (task_id);


--
-- Name: ix_subscription_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subscription_task_type_id ON public.subscription USING btree (task_type_id);


--
-- Name: ix_task_assigner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_assigner_id ON public.task USING btree (assigner_id);


--
-- Name: ix_task_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_entity_id ON public.task USING btree (entity_id);


--
-- Name: ix_task_project_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_project_id ON public.task USING btree (project_id);


--
-- Name: ix_task_status_is_default; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_status_is_default ON public.task_status USING btree (is_default);


--
-- Name: ix_task_status_is_done; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_status_is_done ON public.task_status USING btree (is_done);


--
-- Name: ix_task_status_is_feedback_request; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_status_is_feedback_request ON public.task_status USING btree (is_feedback_request);


--
-- Name: ix_task_status_short_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_task_status_short_name ON public.task_status USING btree (short_name);


--
-- Name: ix_task_task_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_task_status_id ON public.task USING btree (task_status_id);


--
-- Name: ix_task_task_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_task_type_id ON public.task USING btree (task_type_id);


--
-- Name: ix_task_type_shotgun_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_task_type_shotgun_id ON public.task_type USING btree (shotgun_id);


--
-- Name: ix_time_spent_person_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_time_spent_person_id ON public.time_spent USING btree (person_id);


--
-- Name: ix_time_spent_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_time_spent_task_id ON public.time_spent USING btree (task_id);


--
-- Name: ix_working_file_entity_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_working_file_entity_id ON public.working_file USING btree (entity_id);


--
-- Name: ix_working_file_shotgun_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_working_file_shotgun_id ON public.working_file USING btree (shotgun_id);


--
-- Name: ix_working_file_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_working_file_task_id ON public.working_file USING btree (task_id);


--
-- Name: api_event api_event_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_event
    ADD CONSTRAINT api_event_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: api_event api_event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_event
    ADD CONSTRAINT api_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.person(id);


--
-- Name: asset_instance asset_instance_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.entity(id);


--
-- Name: asset_instance asset_instance_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: asset_instance asset_instance_entity_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_entity_type_id_fkey FOREIGN KEY (entity_type_id) REFERENCES public.entity_type(id);


--
-- Name: asset_instance_link asset_instance_link_asset_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance_link
    ADD CONSTRAINT asset_instance_link_asset_instance_id_fkey FOREIGN KEY (asset_instance_id) REFERENCES public.asset_instance(id);


--
-- Name: asset_instance_link asset_instance_link_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance_link
    ADD CONSTRAINT asset_instance_link_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: asset_instance asset_instance_scene_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_scene_id_fkey FOREIGN KEY (scene_id) REFERENCES public.entity(id);


--
-- Name: asset_instance asset_instance_target_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_instance
    ADD CONSTRAINT asset_instance_target_asset_id_fkey FOREIGN KEY (target_asset_id) REFERENCES public.entity(id);


--
-- Name: assignations assignations_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignations
    ADD CONSTRAINT assignations_person_fkey FOREIGN KEY (person) REFERENCES public.person(id);


--
-- Name: assignations assignations_task_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignations
    ADD CONSTRAINT assignations_task_fkey FOREIGN KEY (task) REFERENCES public.task(id);


--
-- Name: attachment_file attachment_file_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment_file
    ADD CONSTRAINT attachment_file_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: build_job build_job_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_job
    ADD CONSTRAINT build_job_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES public.playlist(id);


--
-- Name: comment_acknoledgments comment_acknoledgments_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_acknoledgments
    ADD CONSTRAINT comment_acknoledgments_comment_fkey FOREIGN KEY (comment) REFERENCES public.comment(id);


--
-- Name: comment_acknoledgments comment_acknoledgments_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_acknoledgments
    ADD CONSTRAINT comment_acknoledgments_person_fkey FOREIGN KEY (person) REFERENCES public.person(id);


--
-- Name: comment_mentions comment_mentions_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_mentions
    ADD CONSTRAINT comment_mentions_comment_fkey FOREIGN KEY (comment) REFERENCES public.comment(id);


--
-- Name: comment_mentions comment_mentions_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_mentions
    ADD CONSTRAINT comment_mentions_person_fkey FOREIGN KEY (person) REFERENCES public.person(id);


--
-- Name: comment comment_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: comment comment_preview_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_preview_file_id_fkey FOREIGN KEY (preview_file_id) REFERENCES public.preview_file(id);


--
-- Name: comment_preview_link comment_preview_link_comment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_preview_link
    ADD CONSTRAINT comment_preview_link_comment_fkey FOREIGN KEY (comment) REFERENCES public.comment(id);


--
-- Name: comment_preview_link comment_preview_link_preview_file_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_preview_link
    ADD CONSTRAINT comment_preview_link_preview_file_fkey FOREIGN KEY (preview_file) REFERENCES public.preview_file(id);


--
-- Name: comment comment_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_task_status_id_fkey FOREIGN KEY (task_status_id) REFERENCES public.task_status(id);


--
-- Name: day_off day_off_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.day_off
    ADD CONSTRAINT day_off_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: department_link department_link_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_link
    ADD CONSTRAINT department_link_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: department_link department_link_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_link
    ADD CONSTRAINT department_link_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: department_metadata_descriptor_link department_metadata_descriptor_link_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_metadata_descriptor_link
    ADD CONSTRAINT department_metadata_descriptor_link_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: department_metadata_descriptor_link department_metadata_descriptor_link_metadata_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_metadata_descriptor_link
    ADD CONSTRAINT department_metadata_descriptor_link_metadata_descriptor_id_fkey FOREIGN KEY (metadata_descriptor_id) REFERENCES public.metadata_descriptor(id);


--
-- Name: desktop_login_log desktop_login_log_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.desktop_login_log
    ADD CONSTRAINT desktop_login_log_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: entity entity_entity_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_entity_type_id_fkey FOREIGN KEY (entity_type_id) REFERENCES public.entity_type(id);


--
-- Name: entity_link entity_link_entity_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_entity_in_id_fkey FOREIGN KEY (entity_in_id) REFERENCES public.entity(id);


--
-- Name: entity_link entity_link_entity_out_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_link
    ADD CONSTRAINT entity_link_entity_out_id_fkey FOREIGN KEY (entity_out_id) REFERENCES public.entity(id);


--
-- Name: entity entity_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.entity(id);


--
-- Name: entity entity_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: entity entity_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT entity_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.entity(id);


--
-- Name: entity_version entity_version_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_version
    ADD CONSTRAINT entity_version_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: entity_version entity_version_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_version
    ADD CONSTRAINT entity_version_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: entity fk_main_preview; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT fk_main_preview FOREIGN KEY (preview_file_id) REFERENCES public.preview_file(id);


--
-- Name: entity fk_ready_for; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity
    ADD CONSTRAINT fk_ready_for FOREIGN KEY (ready_for) REFERENCES public.task_type(id);


--
-- Name: login_log login_log_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_log
    ADD CONSTRAINT login_log_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: metadata_descriptor metadata_descriptor_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata_descriptor
    ADD CONSTRAINT metadata_descriptor_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: milestone milestone_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: milestone milestone_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: news news_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.person(id);


--
-- Name: news news_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: news news_preview_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_preview_file_id_fkey FOREIGN KEY (preview_file_id) REFERENCES public.preview_file(id);


--
-- Name: news news_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: notification notification_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.person(id);


--
-- Name: notification notification_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: notification notification_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: notification notification_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: output_file output_file_asset_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_asset_instance_id_fkey FOREIGN KEY (asset_instance_id) REFERENCES public.asset_instance(id);


--
-- Name: output_file output_file_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: output_file output_file_file_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_file_status_id_fkey FOREIGN KEY (file_status_id) REFERENCES public.file_status(id);


--
-- Name: output_file output_file_output_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_output_type_id_fkey FOREIGN KEY (output_type_id) REFERENCES public.output_type(id);


--
-- Name: output_file output_file_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: output_file output_file_source_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_source_file_id_fkey FOREIGN KEY (source_file_id) REFERENCES public.working_file(id);


--
-- Name: output_file output_file_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: output_file output_file_temporal_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.output_file
    ADD CONSTRAINT output_file_temporal_entity_id_fkey FOREIGN KEY (temporal_entity_id) REFERENCES public.entity(id);


--
-- Name: playlist playlist_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.entity(id);


--
-- Name: playlist playlist_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: playlist playlist_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: preview_file preview_file_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_file_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: preview_file preview_file_source_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_file_source_file_id_fkey FOREIGN KEY (source_file_id) REFERENCES public.output_file(id);


--
-- Name: preview_file preview_file_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preview_file
    ADD CONSTRAINT preview_file_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: project_asset_type_link project_asset_type_link_asset_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_asset_type_link
    ADD CONSTRAINT project_asset_type_link_asset_type_id_fkey FOREIGN KEY (asset_type_id) REFERENCES public.entity_type(id);


--
-- Name: project_asset_type_link project_asset_type_link_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_asset_type_link
    ADD CONSTRAINT project_asset_type_link_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_person_link project_person_link_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_person_link
    ADD CONSTRAINT project_person_link_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: project_person_link project_person_link_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_person_link
    ADD CONSTRAINT project_person_link_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project project_project_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_project_status_id_fkey FOREIGN KEY (project_status_id) REFERENCES public.project_status(id);


--
-- Name: project_status_automation_link project_status_automation_link_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_status_automation_link
    ADD CONSTRAINT project_status_automation_link_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_status_automation_link project_status_automation_link_status_automation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_status_automation_link
    ADD CONSTRAINT project_status_automation_link_status_automation_id_fkey FOREIGN KEY (status_automation_id) REFERENCES public.status_automation(id);


--
-- Name: project_task_status_link project_task_status_link_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_status_link
    ADD CONSTRAINT project_task_status_link_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_task_status_link project_task_status_link_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_status_link
    ADD CONSTRAINT project_task_status_link_task_status_id_fkey FOREIGN KEY (task_status_id) REFERENCES public.task_status(id);


--
-- Name: project_task_type_link project_task_type_link_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_type_link
    ADD CONSTRAINT project_task_type_link_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_task_type_link project_task_type_link_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_type_link
    ADD CONSTRAINT project_task_type_link_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: schedule_item schedule_item_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_item
    ADD CONSTRAINT schedule_item_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: schedule_item schedule_item_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule_item
    ADD CONSTRAINT schedule_item_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: search_filter search_filter_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_filter
    ADD CONSTRAINT search_filter_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: search_filter search_filter_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_filter
    ADD CONSTRAINT search_filter_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: status_automation status_automation_in_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_automation
    ADD CONSTRAINT status_automation_in_task_status_id_fkey FOREIGN KEY (in_task_status_id) REFERENCES public.task_status(id);


--
-- Name: status_automation status_automation_in_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_automation
    ADD CONSTRAINT status_automation_in_task_type_id_fkey FOREIGN KEY (in_task_type_id) REFERENCES public.task_type(id);


--
-- Name: status_automation status_automation_out_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_automation
    ADD CONSTRAINT status_automation_out_task_status_id_fkey FOREIGN KEY (out_task_status_id) REFERENCES public.task_status(id);


--
-- Name: status_automation status_automation_out_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_automation
    ADD CONSTRAINT status_automation_out_task_type_id_fkey FOREIGN KEY (out_task_type_id) REFERENCES public.task_type(id);


--
-- Name: subscription subscription_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: subscription subscription_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: subscription subscription_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: subscription subscription_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: task task_assigner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_assigner_id_fkey FOREIGN KEY (assigner_id) REFERENCES public.person(id);


--
-- Name: task task_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: task task_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: task task_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_task_status_id_fkey FOREIGN KEY (task_status_id) REFERENCES public.task_status(id);


--
-- Name: task task_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: task_type_asset_type_link task_type_asset_type_link_asset_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_type_asset_type_link
    ADD CONSTRAINT task_type_asset_type_link_asset_type_id_fkey FOREIGN KEY (asset_type_id) REFERENCES public.entity_type(id);


--
-- Name: task_type_asset_type_link task_type_asset_type_link_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_type_asset_type_link
    ADD CONSTRAINT task_type_asset_type_link_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_type(id);


--
-- Name: task_type task_type_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_type
    ADD CONSTRAINT task_type_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: time_spent time_spent_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_spent
    ADD CONSTRAINT time_spent_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: time_spent time_spent_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_spent
    ADD CONSTRAINT time_spent_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- Name: working_file working_file_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.entity(id);


--
-- Name: working_file working_file_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- Name: working_file working_file_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(id);


--
-- Name: working_file working_file_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_file
    ADD CONSTRAINT working_file_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

