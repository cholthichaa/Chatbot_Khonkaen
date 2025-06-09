--
-- PostgreSQL database cluster dump
--

-- Started on 2025-04-09 22:13:11

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE chatbot_user;
ALTER ROLE chatbot_user WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:yOMYhTur81zasBZ3JgGUUw==$ktFEsD34tZvMf8CVhRK3idtpBlSWi7KpzadCEh7NvtI=:QZhUkfz5GL8xTr8BIC5DnWsJL+wgJgl5VQpwzJ2Ks4I=';

--
-- User Configurations
--






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

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

-- Started on 2025-04-09 22:13:11

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


-- Completed on 2025-04-09 22:13:11

--
-- PostgreSQL database dump complete
--

--
-- Database "chatbot_pg" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

-- Started on 2025-04-09 22:13:11

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
-- TOC entry 3463 (class 1262 OID 16384)
-- Name: chatbot_pg; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE chatbot_pg WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


\connect chatbot_pg

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
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- TOC entry 4 (class 3079 OID 30281)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 2 (class 3079 OID 28214)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- TOC entry 3 (class 3079 OID 30274)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 31598)
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversations (
    id integer NOT NULL,
    answer_text text,
    question_text text NOT NULL,
    user_id integer NOT NULL,
    web_answer_id integer,
    place_id integer,
    event_id integer,
    source_type character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 216 (class 1259 OID 31597)
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 216
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- TOC entry 220 (class 1259 OID 31643)
-- Name: event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event (
    id integer NOT NULL,
    event_name character varying(255) NOT NULL,
    description text,
    event_month text,
    activity_time text,
    opening_hours character varying(255),
    address text,
    image_link text,
    image_detail text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rank integer
);


--
-- TOC entry 219 (class 1259 OID 31642)
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 219
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- TOC entry 224 (class 1259 OID 31662)
-- Name: place_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.place_images (
    id integer NOT NULL,
    place_id integer,
    image_link text NOT NULL,
    image_detail character varying(255)
);


--
-- TOC entry 223 (class 1259 OID 31661)
-- Name: place_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.place_images ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.place_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 31653)
-- Name: places; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.places (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    admission_fee text,
    address text,
    contact_link text,
    opening_hours character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    latitude double precision,
    longitude double precision
);


--
-- TOC entry 221 (class 1259 OID 31652)
-- Name: places_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.places ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 31629)
-- Name: table_counts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.table_counts (
    table_name character varying(255) NOT NULL,
    row_count integer,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 226 (class 1259 OID 31675)
-- Name: tourist_destinations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tourist_destinations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    place_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 225 (class 1259 OID 31674)
-- Name: tourist_destinations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tourist_destinations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 225
-- Name: tourist_destinations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tourist_destinations_id_seq OWNED BY public.tourist_destinations.id;


--
-- TOC entry 213 (class 1259 OID 31544)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    line_id character varying(255) NOT NULL,
    display_name character varying(255),
    picture_url character varying(255),
    status_message character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 212 (class 1259 OID 31543)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 215 (class 1259 OID 31588)
-- Name: web_answer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_answer (
    id integer NOT NULL,
    place_name character varying(255),
    answer_text text NOT NULL,
    intent_type character varying(50) NOT NULL,
    image_link text,
    image_detail character varying(255),
    contact_link text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 214 (class 1259 OID 31587)
-- Name: web_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.web_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 214
-- Name: web_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.web_answer_id_seq OWNED BY public.web_answer.id;


--
-- TOC entry 3272 (class 2604 OID 31601)
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 31646)
-- Name: event id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 31678)
-- Name: tourist_destinations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tourist_destinations ALTER COLUMN id SET DEFAULT nextval('public.tourist_destinations_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 31547)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 31591)
-- Name: web_answer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_answer ALTER COLUMN id SET DEFAULT nextval('public.web_answer_id_seq'::regclass);


--
-- TOC entry 3448 (class 0 OID 31598)
-- Dependencies: 217
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conversations (id, answer_text, question_text, user_id, web_answer_id, place_id, event_id, source_type, created_at) FROM stdin;
561	คาเฟ่สไตล์ญี่ปุ่นในขอนแก่น มีมุมถ่ายรูปที่ให้ฟีลญี่ปุ่นสุดๆ พร้อมเสิร์ฟโดนัทโฮมเมดและ Soft Cream แสนอร่อย	Kyoto Shi Cafe รีวิว	1	\N	13	\N	database	2025-03-09 17:35:48.61227
562	อีกร้านกาแฟขอนแก่น ที่ใครมาเที่ยวขอนแก่นไม่ควรพลาดครับ มาพร้อมการตกแต่งร้านแนวโลกอวกาศ และเครื่องดื่มสไตล์ร้านฉิมพลีที่ไม่เหมือนใคร ซึ่งพอตกเย็นร้านนี้ก็จะกลายเป็นร้านนั่งชิล เสิร์ฟเบียร์เย็นๆ และดนตรีสดฟังสบาย อยากสัมผัสสไตล์ไหน ก็เลือกเอาได้ตามใจเลยครับ	กาแฟฉิมพลี รีวิว	1	156	\N	\N	web_database	2025-03-09 17:36:10.470109
563	อีกร้านกาแฟขอนแก่น ที่ใครมาเที่ยวขอนแก่นไม่ควรพลาดครับ มาพร้อมการตกแต่งร้านแนวโลกอวกาศ และเครื่องดื่มสไตล์ร้านฉิมพลีที่ไม่เหมือนใคร ซึ่งพอตกเย็นร้านนี้ก็จะกลายเป็นร้านนั่งชิล เสิร์ฟเบียร์เย็นๆ และดนตรีสดฟังสบาย อยากสัมผัสสไตล์ไหน ก็เลือกเอาได้ตามใจเลยครับ	กาแฟฉิมพลี รีวิว	1	156	\N	\N	web_database	2025-03-09 17:39:02.218309
564	Flex message (ร้านอาหารบุฟเฟ่)	2k บุฟเฟ่ต์ เปิดยัง	1	\N	\N	\N	Flex Message	2025-03-09 17:53:18.019851
565	Flex message (ร้านอาหารบุฟเฟ่)	2k บุฟเฟ่ต์ หมูกระทะ & ซีฟู้ด เปิดยัง	1	\N	\N	\N	Flex Message	2025-03-09 17:54:02.68484
566	Flex message (ร้านอาหารบุฟเฟ่)	2k บุฟเฟ่ต์ หมูกระทะ เปิดตอนไหน	1	\N	\N	\N	Flex Message	2025-03-09 17:54:35.581883
567	17.00 – 22.00 น.	2k บุฟเฟ่ต์ หมูกระทะ เปิดตอนไหน	1	\N	30	\N	database	2025-03-09 17:55:35.369042
568	เวลา เปิด-ปิด : ทุกวัน 17.00-23.00 น.	2k บุฟเฟ่ต์ หมูกระทะ เปิดตอนไหน	1	\N	\N	\N	website	2025-03-09 18:02:58.888647
569	ไม่พบข้อมูลเวลาเปิดทำการ	ช.เขียว คาเฟ่ เปิดยัง	1	\N	29	\N	database	2025-03-09 18:05:37.957537
570	ไม่พบข้อมูลเวลาเปิดทำการ	Kyoto Shi Cafe เปิดยัง	1	\N	13	\N	database	2025-03-09 18:06:12.42487
571	เวลาเปิด-ปิด : 16.30 – 05.00 น.	มิ่งหมูกะทะ มข. เปิดยัง	1	\N	\N	\N	website	2025-03-09 18:11:39.784458
572	16.30 – 05.00 น.	มิ่งหมูกะทะ มข. เปิดยัง	1	\N	23	\N	database	2025-03-09 18:13:34.014665
573	20.00 – 04.30 น.	ฟ้าสางหมูกระทะเปิดยัง	1	\N	35	\N	database	2025-03-09 18:13:53.516821
574	16.00 – 23.00 น.	S Bar BQ เปิดยัง	1	\N	31	\N	database	2025-03-09 18:14:16.56205
575	ราคา : 245 บาท	S Bar BQ ราคาเท่าไหร่	1	\N	\N	\N	website	2025-03-09 18:14:33.470893
576	ร้านสะอาด บริการเร็วฉับไวด้วยพนักงานที่แข็งขันเสมอ เอกลักษณ์ของร้านหมูกระทะปิ้งย่างบนกระทะทองเหลืองคือน้ำจิ้มบาร์บีคิวรสเลิศ จิ้มกับเบคอนย่างกรอบ ๆ หอม ๆ พร้อมทั้งหมูสามชั้นและเนื้อโคขุนสไลซ์ ใครกินก็ติดใจทุกราย ตบท้ายด้วยของหวานเป็นไอศกรีมหลากหลายรส ได้มื้อใหญ่จบวันที่ทำให้กลับบ้านอย่างมีความสุข	S Bar BQ รีวิว	1	\N	31	\N	database	2025-03-09 18:14:46.022426
577	เปิดให้เข้าชม : 08.00-17.00 น.	คีรี ธารา เปิดยัง	1	\N	89	\N	database	2025-03-09 18:18:37.785733
578	เปิดให้เข้าชม : 08.00-17.00 น.	คีรี ธารา เขื่อนอุบลรัตน์ เปิดยัง	1	\N	89	\N	database	2025-03-09 18:19:06.493087
579	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดอกไม้ฟาร์มเปิดยัง	1	\N	\N	\N	Flex Message	2025-03-09 18:24:24.783561
580	08:00 - 18:00 น.	ดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง เปิดยัง	1	\N	72	\N	database	2025-03-09 18:24:37.642491
581	8:00–18:00 น.	ร้านอาหารดอกไม้ฟาร์ม ฃเปิดยัง	1	\N	203	\N	database	2025-03-09 19:01:29.848364
582	8:00–18:00 น.	ร้านอาหารดอกไม้ฟาร์มเปิดยัง	1	\N	203	\N	database	2025-03-09 19:01:42.927562
583	Flex message (ประเภทอาหารอีสาน)	อาหารอีสานน่าไป	1	\N	\N	\N	Flex Message	2025-03-12 18:52:33.362036
584	Flex message (เลือกประเภทสถานที่)	เลือกประเภทสถานที่ท่องเที่ยว	1	\N	\N	\N	Flex Message	2025-03-12 18:54:08.338971
585	Flex message (แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก)	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	1	\N	\N	\N	Flex Message	2025-03-12 18:54:21.169047
586	สถานที่ใกล้เคียง	สถานที่ใกล้เคียงบึงแก่นนคร	1	\N	\N	\N	Flex Message	2025-03-13 18:39:52.768842
587	Flex Message เดือน มีนาคม	ปฎิทินกิจกรรมประจำเดือน	1	\N	\N	\N	database	2025-03-15 19:45:07.757548
588	สถานที่ใกล้เคียง	สถานที่ใกล้ภูผาม่าน	1	\N	\N	\N	Flex Message	2025-03-16 09:54:12.836665
589	สถานที่ใกล้เคียง	สถานที่ใกล้ผาชมตะวัน	324	\N	\N	\N	Flex Message	2025-03-16 09:54:16.494317
590	สถานที่ใกล้เคียง	สถานที่ใกล้ผาชมตะวัน	1	\N	\N	\N	Flex Message	2025-03-16 09:54:44.662574
591	สถานที่ใกล้เคียง	สถานที่ใกล้วันหนองแวง	1	\N	\N	\N	Flex Message	2025-03-16 18:05:49.030598
592	สถานที่ใกล้เคียง	สถานที่ใกล้แฟรี่พลาซ่า	1	\N	\N	\N	Flex Message	2025-03-16 18:08:30.805891
593	สถานที่ใกล้เคียง	สถานที่ใกล้แฟรี่พลาซ่า	1	\N	\N	\N	Flex Message	2025-03-16 18:09:15.330889
594	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:18:54.355791
595	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:21:33.584123
596	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:24:00.606363
597	สถานที่ใกล้เคียง	สถานที่ใกล้ผาชมตะวัน	1	\N	\N	\N	Flex Message	2025-03-16 18:26:37.835377
598	Flex Message เดือน มีนาคม	ปฎิทินกิจกรรมประจำเดือน	1	\N	\N	\N	database	2025-03-16 18:26:54.55621
599	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:39:42.976126
600	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:41:05.011387
601	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:43:28.265672
602	สถานที่ใกล้เคียง	สถานที่ใกล้ผาชมตะวัน	324	\N	\N	\N	Flex Message	2025-03-16 18:45:21.716657
603	สถานที่ใกล้เคียง	สถานที่ใกล้เซนทรัลขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-16 18:55:19.544477
604	ไม่พบข้อมูลที่ตรงกับคำถาม	ค่าเข้าผาชมตะวัน	1	\N	\N	\N	website	2025-03-17 15:43:56.206663
605	ค่าเข้าชม : ผู้ใหญ่ 20 บาท เด็ก 10 บาท , ชาวต่างชาติ ผู้ใหญ่ 100 บาท เด็ก 50 บาท	ค่าเข้าจุดชมวิวเขาหินช้าง	1	\N	\N	\N	website	2025-03-17 15:44:43.313941
607	ค่าเข้าชม : ผู้ใหญ่ 20 บาท เด็ก 10 บาท , ชาวต่างชาติ ผู้ใหญ่ 100 บาท เด็ก 50 บาท	ค่าเข้าจุดชมวิวเขาหินช้างสี	588	\N	\N	\N	website	2025-03-17 16:02:28.330035
608	Flex message (เที่ยวขอนแก่น)	เที่ยวขอนแก่น	588	\N	\N	\N	Flex Message	2025-03-17 16:02:36.917923
609	Flex Message เดือน มีนาคม	กิจกรรมประจำเดือนนี้	1	\N	\N	\N	database	2025-03-17 16:28:38.907524
612	Flex message (แหล่งท่องเที่ยวทางธรรมชาติ)	เที่ยวธรรมชาติ	1	\N	\N	\N	Flex Message	2025-03-17 18:39:58.180455
613	Flex message (แหล่งท่องเที่ยวเพื่อนันทนาการ)	ไปช็อปปิ้ง	1	\N	\N	\N	Flex Message	2025-03-17 18:40:11.49469
614	Flex message (แหล่งท่องเที่ยวเพื่อนันทนาการ)	ไปช็อปปิ้ง	1	\N	\N	\N	Flex Message	2025-03-17 18:45:13.946426
615	Flex message (แหล่งท่องเที่ยวทางธรรมชาติ)	เที่ยวธรรมชาติ	1	\N	\N	\N	Flex Message	2025-03-17 18:47:39.774996
616	Flex message (แหล่งท่องเที่ยวสำหรับช็อปปิ้ง)	ไปช็อปปิ้ง	1	\N	\N	\N	Flex Message	2025-03-17 18:53:11.285468
617	Flex message (อำเภอเวียงเก่า)	เที่ยวอำเภอเมือง	1	\N	\N	\N	Flex Message	2025-03-17 18:53:24.404689
618	Flex message (แหล่งท่องเที่ยวทางศาสนา)	ไปเที่ยววัด	1	\N	\N	\N	Flex Message	2025-03-17 19:00:52.836909
619	Flex message (แหล่งท่องเที่ยวเพื่อนันทนาการ)	ไปเล่นน้ำ	1	\N	\N	\N	Flex Message	2025-03-17 19:01:08.631398
620	Flex message (อำเภอเวียงเก่า)	เที่ยวอำเภอเมือง	1	\N	\N	\N	Flex Message	2025-03-17 19:01:35.802487
621	Flex message (อำเภอเวียงเก่า)	เที่ยวอำเภอเมือง	1	\N	\N	\N	Flex Message	2025-03-17 19:02:32.718736
622	Flex message (อำเภอเวียงเก่า)	เที่ยวอำเภอเมืองขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-17 19:03:03.434157
623	Flex message (อำเภอเมืองขอนแก่น)	เที่ยวอำเภอเมืองขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-17 19:03:47.465556
624	Flex message (อำเภอน้ำพอง)	เที่ยวน้ำพอง	1	\N	\N	\N	Flex Message	2025-03-17 19:04:01.331241
625	Flex message (อำเภอภูผาม่าน)	เที่ยวภูผาม่าน	1	\N	\N	\N	Flex Message	2025-03-17 19:04:11.29204
626	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดัง	1	\N	\N	\N	Flex Message	2025-03-17 19:04:27.640024
627	Flex message (คาเฟ่ยอดฮิต)	คาเฟ่ยอดฮิต	1	\N	\N	\N	Flex Message	2025-03-17 19:04:38.417679
628	Flex message (ร้านอาหารบุฟเฟ่)	บุฟเฟ่ชาบู หมูกะทะเจ้าดังขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-17 19:04:53.858153
629	Flex message (ประเภทอาหารอีสาน)	ร้านอาหารข้างทาง	1	\N	\N	\N	Flex Message	2025-03-17 19:05:05.267879
630	Flex message (ประเภทอาหารทั่วไป)	อาหารริมทาง	1	\N	\N	\N	Flex Message	2025-03-17 19:06:57.442544
631	Flex message (ประเภทอาหารอีสาน)	อาหารอีสาน	1	\N	\N	\N	Flex Message	2025-03-17 19:07:13.312226
632	Flex message (ประเภทอาหารอินเตอร์)	อาหารต่างชาติ	1	\N	\N	\N	Flex Message	2025-03-17 19:07:38.756483
633	Flex message (ประเภทอาหารไทย)	อาหารไทยๆ	1	\N	\N	\N	Flex Message	2025-03-17 19:08:48.254653
634	Flex message (ร้านอาหารในเมืองขอนแก่น)	ร้านอาหารในเมืองขอนแก่น	1	\N	\N	\N	Flex Message	2025-03-17 19:09:12.122955
635	Flex message (ประเภทอาหารไทย)	ไม่พบช่องทางการติดต่อ	1	\N	\N	\N	Flex Message	2025-03-17 19:16:08.584968
636	Flex message (ประเภทอาหารไทย)	อาหารไทย	1	\N	\N	\N	Flex Message	2025-03-17 19:18:41.683777
637	Flex message (ประเภทอาหารไทย)	อาหารไทย	1	\N	\N	\N	Flex Message	2025-03-17 19:20:43.964745
638	Flex message (ประเภทอาหารอีสาน)	อาหารอีสาน	1	\N	\N	\N	Flex Message	2025-03-17 19:23:58.485094
639	Flex message (ประเภทอาหารไทย)	อาหารไทย	1	\N	\N	\N	Flex Message	2025-03-17 19:25:10.955543
640	คาเฟ่มินิมอลสไตล์เกาหลี มีหลายโซนให้เลือกนั่ง พร้อมเครื่องดื่มและเบเกอรีโฮมเมดสุดละมุน	11AM Cafe and Space รีวิว	1	\N	15	\N	database	2025-03-17 19:27:38.386332
641	ขอนแก่น คอหมูย่าง เป็นร้านที่มีสูตรเด็ดในการหมักหมูด้วยน้ำซอสสูตรพิเศษ เพื่อให้ได้คอหมูย่างที่มีกลิ่นหอม และรสชาติที่เป็นเอกลักษณ์ไม่เหมือนใคร นอกจากนี้ที่ร้านยังมีเมนูอื่นๆ ให้เลือกมากมาย เป็นอีกร้านที่ไม่ควรพลาด	ขอนแก่น คอหมูย่าง รีวิว	1	\N	56	\N	database	2025-03-17 19:28:42.161511
642	ขอนแก่น คอหมูย่าง เป็นร้านที่มีสูตรเด็ดในการหมักหมูด้วยน้ำซอสสูตรพิเศษ เพื่อให้ได้คอหมูย่างที่มีกลิ่นหอม และรสชาติที่เป็นเอกลักษณ์ไม่เหมือนใคร นอกจากนี้ที่ร้านยังมีเมนูอื่นๆ ให้เลือกมากมาย เป็นอีกร้านที่ไม่ควรพลาด	ขอนแก่น คอหมูย่าง รีวิว	1	\N	56	\N	database	2025-03-17 19:29:13.19927
643	Flex message (อำเภอ)	เลือกอำเภอกันเลย	324	\N	\N	\N	Flex Message	2025-03-17 19:31:57.041604
644	Flex message (อำเภอบ้านฝาง)	อำเภอบ้านฝาง	324	\N	\N	\N	Flex Message	2025-03-17 19:32:01.668698
645	Flex message (เลือกประเภทสถานที่)	เลือกประเภทสถานที่	324	\N	\N	\N	Flex Message	2025-03-17 19:33:24.262027
646	Flex message (แหล่งท่องเที่ยวทางธรรมชาติ)	แหล่งท่องเที่ยวทางธรรมชาติ	324	\N	\N	\N	Flex Message	2025-03-17 19:33:30.230866
647	ใครอยากลองสไตล์จากเที่ยวแบบสงบ ไปเที่ยวแบบตื่นเต้น ต้องไปล่องแก่งผาเทวดา อำเภอภูผาม่าน ที่เที่ยวธรรมชาติขอนแก่นยอดฮิตในตอนนี้ที่ไม่ควรพลาด จะไปล่องแก่งกับเพื่อนก็ดีหรือจะไปกับครอบครัวก็สนุกไม่แพ้กัน ระหว่างทางจะคดเคี้ยวซักหน่อย แต่วิวข้างทางที่ร่มรื่นกับสายน้ำที่เย็นฉ่ำ ไปพร้อมกับการผจญภัยสุดมันส์ ทำให้เราสนุกและเพลิดเพลินจนลืมเวลาแน่นอนครับ	รีวิวล่องแก่งผาเทวดา	324	\N	88	\N	database	2025-03-17 19:33:58.180357
648	คาเฟ่มินิมอลสไตล์เกาหลี มีหลายโซนให้เลือกนั่ง พร้อมเครื่องดื่มและเบเกอรีโฮมเมดสุดละมุน	11AM Cafe and Space รีวิว	1	\N	15	\N	database	2025-03-17 19:34:16.890642
649	ขอนแก่น คอหมูย่าง เป็นร้านที่มีสูตรเด็ดในการหมักหมูด้วยน้ำซอสสูตรพิเศษ เพื่อให้ได้คอหมูย่างที่มีกลิ่นหอม และรสชาติที่เป็นเอกลักษณ์ไม่เหมือนใคร นอกจากนี้ที่ร้านยังมีเมนูอื่นๆ ให้เลือกมากมาย เป็นอีกร้านที่ไม่ควรพลาด	ขอนแก่น คอหมูย่าง รีวิว	1	\N	56	\N	database	2025-03-17 19:34:31.219423
650	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:35:27.796719
651	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	รีวิวจุดชมวิวหนองสมอ	324	\N	83	\N	database	2025-03-17 19:35:31.753278
719	Flex message (ประเภทอาหารอีสาน)	ร้านอาหารอีสาน	755	\N	\N	\N	Flex Message	2025-03-19 04:44:01.371115
652	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	รีวิวจุดชมวิวหนองสมอ	324	\N	83	\N	database	2025-03-17 19:35:41.483838
653	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:37:50.157557
654	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:39:40.968192
655	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:40:08.277617
656	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:42:07.848199
657	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:46:30.562718
658	Flex message (อำเภอ)	เลือกอำเภอกันเลย	324	\N	\N	\N	Flex Message	2025-03-17 19:48:13.445291
659	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:48:49.611658
660	Flex message (อำเภอเมืองขอนแก่น)	อำเภอเมือง	324	\N	\N	\N	Flex Message	2025-03-17 19:50:27.824981
661	Flex message (อำเภอน้ำพอง)	อำเภอน้ำพอง	324	\N	\N	\N	Flex Message	2025-03-17 19:51:07.633517
662	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:51:45.641975
663	Flex message (อำเภอภูเวียง)	อำเภอภูเวียง	324	\N	\N	\N	Flex Message	2025-03-17 19:53:09.773433
664	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:55:05.4983
665	Flex message (อำเภอหนองเรือ)	อำเภอหนองเรือ	324	\N	\N	\N	Flex Message	2025-03-17 19:55:25.807915
666	Flex message (อำเภอชุมแพ)	อำเภอชุมแพ	324	\N	\N	\N	Flex Message	2025-03-17 19:55:49.466265
720	Flex message (ประเภทอาหารอีสาน)	ร้านลาบเป็ด	751	\N	\N	\N	Flex Message	2025-03-19 04:44:04.250511
667	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:56:04.261255
668	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:57:29.8262
669	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:58:25.876736
670	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 19:59:16.020147
671	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	จุดชมวิวหนองสมอ รีวิว	1	\N	83	\N	database	2025-03-17 20:00:46.374266
672	อีกร้านกาแฟขอนแก่น ที่ใครมาเที่ยวขอนแก่นไม่ควรพลาดครับ มาพร้อมการตกแต่งร้านแนวโลกอวกาศ และเครื่องดื่มสไตล์ร้านฉิมพลีที่ไม่เหมือนใคร ซึ่งพอตกเย็นร้านนี้ก็จะกลายเป็นร้านนั่งชิล เสิร์ฟเบียร์เย็นๆ และดนตรีสดฟังสบาย อยากสัมผัสสไตล์ไหน ก็เลือกเอาได้ตามใจเลยครับ	กาแฟฉิมพลี รีวิว	1	156	\N	\N	web_database	2025-03-17 20:01:46.21371
673	ไม่พบข้อมูลที่ตรงกับคำถาม	ค่าเข้าน้ำตกบ๋าหลวง	1	\N	\N	\N	website	2025-03-18 14:07:12.826762
674	เปิดทำการทุกวัน เวลา 15.00 – 23.00 น.	เดอะนัวเปิดกี่โมง	1	\N	20	\N	database	2025-03-18 14:27:12.129911
675	เปิดทำการทุกวัน เวลา 15.00 – 23.00 น.	เดอะนัวหมูกระทะเปิดกี่โมง	1	\N	20	\N	database	2025-03-18 14:27:32.729872
676	เปิดให้บริการวันจันทร์ - วันศุกร์: 11:00 น. - 21:00 น. วันเสาร์ - วันอาทิตย์ และวันหยุดนักขัตฤกษ์: 09:00 น. - 21:00 น.	สวนน้ำไดโนวอเตอร์ปาร์คเปิดยัง	1	\N	91	\N	database	2025-03-18 14:33:02.626302
677	เปิดทำการเวลา 6.00 – 21.00 น.	บึงแก่นนครปิดตอนไหน	324	\N	93	\N	database	2025-03-18 14:33:21.216478
678	เปิดให้เข้าชมทุกวัน : 08.30-16.30 น.	ผาชมตะวันเปิดกี่โมง	1	\N	80	\N	database	2025-03-18 14:57:10.84465
679	ไม่พบข้อมูลที่ตรงกับคำถาม	ผาชมตะวันมีค่าเข้ามั้ย	1	\N	\N	\N	website	2025-03-18 14:57:21.692069
680	ติดตามเวลาเปิดลสนนับดาวที่ที่เพจ อุทยานแห่งชาติน้ำพอง	ลานนับดาว เปิดกี่โมง	1	\N	162	\N	database	2025-03-18 15:05:44.387053
681	ราคา : 149 บาท / ชุด	ฟ้าสางหมูกระทะ ราคาเท่าไหร่	1	\N	\N	\N	website	2025-03-18 15:10:08.966132
682	เข้าชมฟรี	ลานนับดาว ค่าเข้ากี่บาท	1	\N	162	\N	database	2025-03-18 15:21:33.650025
683	สามารถเข้าชมถ้ำค้างคาวได้ฟรีไม่เสียใช้จ่าย	ถ้ำค้างคาวค่าเข้ากี่บาท	1	\N	161	\N	database	2025-03-18 15:21:46.299165
684	ผู้ใหญ่: 400 บาท เด็กสูง 120-140 เซนติเมตร: 300 บาท เด็กต่ำกว่า 120 เซนติเมตร เข้าฟรี	สวนน้ำไดโนวอเตอร์ปาร์ค ค่าเข้าแพงมั้ย	1	\N	91	\N	database	2025-03-18 15:21:56.938643
685	เปิดให้บริการวันจันทร์ - วันศุกร์: 11:00 น. - 21:00 น. วันเสาร์ - วันอาทิตย์ และวันหยุดนักขัตฤกษ์: 09:00 น. - 21:00 น.	สวนน้ำไดโนเปิดตอนไหน	1	\N	91	\N	database	2025-03-18 15:22:10.227454
686	เป็นสวนน้ำที่เหมาะสำหรับครอบครัว มีเครื่องเล่นหลากหลาย ทั้งสไลเดอร์และสระว่ายน้ำที่เหมาะกับเด็กและผู้ใหญ่ การตกแต่งธีมไดโนเสาร์ทำให้บรรยากาศน่าสนใจ นอกจากนี้ยังมีบริการอาหารและสิ่งอำนวยความสะดวกเพียงพอ	รีวิวสวนน้ำไดโนเป	1	\N	91	\N	database	2025-03-18 15:22:22.806654
687	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	588	\N	\N	\N	Flex Message	2025-03-18 16:21:44.086701
688	Flex message (แหล่งท่องเที่ยวทางธรรมชาติ)	แหล่งท่องเที่ยวประเภทน้ำตก	588	\N	\N	\N	Flex Message	2025-03-19 03:36:56.105162
689	Flex message (เลือกประเภทสถานที่)	ประเภทสถานที่ท่องเที่ยว	588	\N	\N	\N	Flex Message	2025-03-19 03:38:20.040884
690	Flex Message เดือน มกราคม	กิจกรรมเดือนมกราคม	588	\N	\N	\N	database	2025-03-19 03:42:29.424935
691	Flex Message ภูผาม่าน เฟสติวัล	ภูผาม่าน เฟสติวัล	588	\N	\N	\N	database	2025-03-19 03:42:57.45408
692	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	744	\N	\N	\N	Flex Message	2025-03-19 04:39:42.501834
693	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	744	\N	\N	\N	Flex Message	2025-03-19 04:40:11.73933
694	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดัง	744	\N	\N	\N	Flex Message	2025-03-19 04:41:15.536006
695	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดัง	744	\N	\N	\N	Flex Message	2025-03-19 04:42:16.310602
696	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	749	\N	\N	\N	database	2025-03-19 04:42:55.375675
697	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	748	\N	\N	\N	Flex Message	2025-03-19 04:42:57.226295
698	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	749	\N	\N	\N	Flex Message	2025-03-19 04:43:06.103953
699	Flex message (อำเภอเมืองขอนแก่น)	อยากเที่ยวแถวๆนอกเมือง	751	\N	\N	\N	Flex Message	2025-03-19 04:43:06.158511
700	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	752	\N	\N	\N	Flex Message	2025-03-19 04:43:08.175632
701	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	749	\N	\N	\N	Flex Message	2025-03-19 04:43:08.89592
702	อุทยานแห่งชาติภูผาม่าน อากาศร้อนๆ แบบนี้ หนีทะเล มาหาสถานที่ไปนอนแช่น้ำใสๆ ไหลเย็นๆ จากธรรมชาติ เอาให้ฉ่ำหนำใจไปเลย ที่มีน้ำไหลเย็นชุ่มฉ่ำตลอดทั้งปี ท่ามกลางบรรยากาศของธรรมชาติที่สงบร่มรื่นงดงาม และโดดเด่นด้วยเทือกเขาหินปูนที่มีหน้าผาตัดตรงลงมาคล้ายผ้าม่าน ภายในมีจุดท่องเที่ยวที่น่าสนใจหลายจุดทั้งถ้ำน้ำตก รวมถึงพื้นที่กางเต็นท์ที่บรรยากาศสวยงาม	แนะนำที่ท่องเที่ยวภูผาม่าน	755	\N	96	\N	database	2025-03-19 04:43:13.564501
703	Flex message (อำเภอ)	เลือกอำเภอกันเลย	749	\N	\N	\N	Flex Message	2025-03-19 04:43:13.66579
704	Flex message (อำเภอกระนวน)	อำเภอกระนวน	749	\N	\N	\N	Flex Message	2025-03-19 04:43:16.475556
705	Flex message (อำเภอกระนวน)	อำเภอกระนวน	749	\N	\N	\N	Flex Message	2025-03-19 04:43:16.646415
706	Flex message (อำเภอภูผาม่าน)	อำเภอภูผาม่าน	749	\N	\N	\N	Flex Message	2025-03-19 04:43:19.516073
707	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ให้ฉันหน่อย	753	\N	\N	\N	Flex Message	2025-03-19 04:43:20.40483
708	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	763	\N	\N	\N	Flex Message	2025-03-19 04:43:25.743511
709	Flex message (ประเภทอาหารอีสาน)	กินอะไรดี	757	\N	\N	\N	Flex Message	2025-03-19 04:43:26.662054
710	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	588	\N	\N	\N	database	2025-03-19 04:43:28.64338
711	Flex message (อำเภอเปือยน้อย)	ออกเเบบดาต้าเบสสำหรับ เเอปทำข้อสอบ	766	\N	\N	\N	Flex Message	2025-03-19 04:43:30.661259
712	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	767	\N	\N	\N	database	2025-03-19 04:43:33.353184
713	Flex message (แหล่งท่องเที่ยวทางศาสนา)	ร้านขายพอดในขอนแก่นที่ไหนเปิดบ้าง	753	\N	\N	\N	Flex Message	2025-03-19 04:43:37.572829
714	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	752	\N	\N	\N	Flex Message	2025-03-19 04:43:38.481287
715	Flex message (เลือกประเภทสถานที่)	เลือกประเภทสถานที่	763	\N	\N	\N	Flex Message	2025-03-19 04:43:38.871107
716	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	752	\N	\N	\N	Flex Message	2025-03-19 04:43:44.313453
717	Flex message (แหล่งท่องเที่ยวทางศาสนา)	แหล่งท่องเที่ยวทางศาสนา	763	\N	\N	\N	Flex Message	2025-03-19 04:43:46.913851
718	Flex message (ประเภทอาหารอีสาน)	ร้านอาหารอีสาน	751	\N	\N	\N	Flex Message	2025-03-19 04:43:51.912208
721	Flex message (อำเภอ)	เลือกอำเภอกันเลย	748	\N	\N	\N	Flex Message	2025-03-19 04:44:08.601009
722	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารที่มีเเต่เนื้อ	766	\N	\N	\N	Flex Message	2025-03-19 04:44:14.829899
723	Flex message (อำเภอภูเวียง)	อำเภอภูเวียง	748	\N	\N	\N	Flex Message	2025-03-19 04:44:17.880623
724	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	779	\N	\N	\N	database	2025-03-19 04:44:18.828494
725	Flex message (ประเภทอาหารอีสาน)	อยากกินผัดหมูกรอบ	749	\N	\N	\N	Flex Message	2025-03-19 04:44:18.882596
726	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดัง	753	\N	\N	\N	Flex Message	2025-03-19 04:44:19.860774
727	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	780	\N	\N	\N	database	2025-03-19 04:44:28.058489
728	Flex message (ประเภทอาหารทั่วไป)	ร้านอาหารริมทาง	753	\N	\N	\N	Flex Message	2025-03-19 04:44:33.887679
729	Flex message (อำเภออุบลรัตน์)	อำเภออุบลรัตน์	748	\N	\N	\N	Flex Message	2025-03-19 04:44:44.75688
730	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	782	\N	\N	\N	Flex Message	2025-03-19 04:44:46.477106
731	Flex message (ประเภทอาหารอีสาน)	ร้านอาหารอีสาน	751	\N	\N	\N	Flex Message	2025-03-19 04:44:46.637027
732	Flex message (ร้านอาหารบุฟเฟ่)	บุฟเฟ่ชาบู หมูกะทะเจ้าดังขอนแก่น	753	\N	\N	\N	Flex Message	2025-03-19 04:44:50.926751
733	Flex message (ประเภทอาหารทั่วไป)	ร้านอาหารริมทาง	782	\N	\N	\N	Flex Message	2025-03-19 04:44:56.446716
734	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	755	\N	\N	\N	database	2025-03-19 04:45:00.471606
735	Flex message (ร้านอาหารบุฟเฟ่)	อยากกินหมูทะ	753	\N	\N	\N	Flex Message	2025-03-19 04:45:03.274608
736	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	755	\N	\N	\N	Flex Message	2025-03-19 04:45:03.328845
737	Flex message (ประเภทอาหารไทย)	ร้านอาหารไทย	751	\N	\N	\N	Flex Message	2025-03-19 04:45:07.65375
738	Flex message (ประเภทอาหารอีสาน)	อยากกินปิ้งๆ	753	\N	\N	\N	Flex Message	2025-03-19 04:45:13.705139
739	Flex message (เที่ยวขอนแก่น)	แนะนำสถานที่ท่องเที่ยวจังหวัดขอนแก่น	780	\N	\N	\N	Flex Message	2025-03-19 04:45:25.662494
740	Flex message (ประเภทอาหารอินเตอร์)	ร้านอาหารโกอินเตอร์	755	\N	\N	\N	Flex Message	2025-03-19 04:45:26.842885
741	Flex message (ร้านอาหารดังยอดฮิต)	ร้านอาหารดังยอดฮิต	779	\N	\N	\N	Flex Message	2025-03-19 04:45:30.112503
742	Flex message (อำเภอเวียงเก่า)	อำเภอเวียงเก่า	748	\N	\N	\N	Flex Message	2025-03-19 04:45:32.861692
743	Flex message (เลือกประเภทสถานที่)	เลือกประเภทสถานที่	780	\N	\N	\N	Flex Message	2025-03-19 04:45:59.371331
744	Flex message (ประเภทอาหารอีสาน)	ลาบภูเวียง	755	\N	\N	\N	Flex Message	2025-03-19 04:46:16.628661
745	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	752	\N	\N	\N	database	2025-03-19 04:46:33.207812
746	Flex message (แหล่งท่องเที่ยวทางธรรมชาติ)	แหล่งท่องเที่ยวทางธรรมชาติ	780	\N	\N	\N	Flex Message	2025-03-19 04:46:34.626221
747	ร้านอาหารไทยและอาหารอีสานที่รสชาติดีเกินมาตรฐานทั่วไปในขอนแก่น เมนูห้ามพลาดคือปลาช่อนเผา เสิร์ฟพร้อมผักลวกสีสวย และน้ำจิ้มแจ่วทั้งสูตรธรรมดาและสูตรปลาร้า นอกจากนี้ทางร้านยังมีดนตรีสดไว้ขับกล่อมในช่วงมื้อเย็นอีกด้วย	ข้อข้อมูลร้านสีนานวล	751	\N	63	\N	database	2025-03-19 04:47:25.113667
748	Flex message (อาหารระดับมิชลินไกด์)	ร้านอาหารมิชลินไกด์	588	\N	\N	\N	Flex Message	2025-03-19 04:47:27.221065
749	185/41 ม.16 ต.ในเมือง อ.เมือง จ.ขอนแก่น	เส้นทางไปยัง 11AM Cafe and Space	757	\N	15	\N	Location message	2025-03-19 04:47:48.253095
750	Flex message (คาเฟ่ยอดฮิต)	คาเฟ่ยอดฮิต	588	\N	\N	\N	Flex Message	2025-03-19 04:47:58.589986
751	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	751	\N	\N	\N	database	2025-03-19 04:48:41.605722
752	Flex message (คาเฟ่ยอดฮิต)	คาเฟ่ยอดฮิต	744	\N	\N	\N	Flex Message	2025-03-19 04:48:45.527827
753	Flex message (อำเภอชุมแพ)	อำเภอชุมแพ	588	\N	\N	\N	Flex Message	2025-03-20 17:36:11.360578
754	Flex message (อำเภอเปือยน้อย)	อำเภอเปือยน้อย	588	\N	\N	\N	Flex Message	2025-03-20 17:45:17.13769
755	Flex message (อำเภอเปือยน้อย)	อำเภอเปือยน้อย	588	\N	\N	\N	Flex Message	2025-03-20 17:46:24.596123
756	Flex message (อำเภอเปือยน้อย)	อำเภอเปือยน้อย	588	\N	\N	\N	Flex Message	2025-03-20 17:47:37.319264
757	Flex Message เดือน มกราคม	อีเว้นเดือนมกราคม	588	\N	\N	\N	database	2025-03-26 14:36:06.64038
758	Flex Message เดือน มีนาคม	กิจกรรมเดือนนี้	588	\N	\N	\N	database	2025-03-26 14:37:50.827399
759	Flex Message เดือน กุมภาพันธ์	กิจกรรมเดือนกุมภา	588	\N	\N	\N	database	2025-03-26 14:54:22.466643
760	ค่าเข้า : ผู้ใหญ่ 100 บาท เด็ก 20 บาท ผู้สูงอายุ 60 ปีขึ้นไปเข้าฟรี อัตราค่าเข้าสวนน้ำ ผู้ใหญ่ 30 บาท เด็ก 20 บาท	ค่าเข้าสวนสัตว์ขอนแก่น	588	\N	85	\N	database	2025-03-27 06:59:44.036572
761	เวลาทำการ: 08.00 น. – 17.00 น.	หมู่บ้านงูจงอางเปิดกี่โมง	588	\N	\N	\N	website	2025-03-27 07:07:51.727092
762	เวลาทำการ: 08.00 น. – 17.00 น.	หมู่บ้านงูจงอางเปิดกี่โมง	588	168	\N	\N	web_database	2025-03-27 07:14:54.849647
\.


--
-- TOC entry 3451 (class 0 OID 31643)
-- Dependencies: 220
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event (id, event_name, description, event_month, activity_time, opening_hours, address, image_link, image_detail, created_at, rank) FROM stdin;
5	ต้นตาล ขอนแก่นบาลานซ์ไบค์ เรซซิ่ง 2025	ต้นตาล ขอนแก่นบาลานซ์ไบค์ เรซซิ่ง 2025” กับการแข่งขันหนูน้อยขาไถ เพื่อการกุศล\nโดยรายได้หลักจากให้ค่าใช้จ่าย ทางฝ่ายจัดการแข่งขันจะนำไปมอบ ให้โรงเรียนการศึกษาคนตาบอดขอนแก่น และนักแข่งทุกคนจะได้รับเหรียญรางวัลและประกาศนียบัตร	กุมภาพันธ์	วันที่ 8 ก.พ. 68	13.00 – 22.00 น.	ลานจอดรถ ตลาดต้นตาล จ.ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475484911_1259368405140772_4059395156446145445_n.jpg	ขอบคุณภาพจาก : เพจ ต้นตาล ขอนแก่น	2025-02-18 07:57:16.778187	1
31	WORLD COSPLAY SUMMIT THAILAND 2025	เหล่าคอสเพลเยอร์ห้ามพลาด กับการเฟ้นหาตัวแทนไปแข่งขันระดับโลก ภายในงาน JAPAN WEEK x WORLD COSPLAY SUMMIT THAILAND 2025 รับเงินรางวัลพร้อมบินตรงสู่เมืองนาโกย่า ณ ประเทศญี่ปุ่น สมัครได้แล้วตั้งแต่วันนี้ – 7 มีนาคม 2568	มีนาคม	22 มีนาคม - 23 มีนาคม	ไม่ระบุเวลา	ขอนแก่นฮอลล์ ชั้น 5 Central Khonkaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480979367_1231286681955506_7074819988340019988_n-1229x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	19
4	ช่างคึด	‼️พบงานกิจกรรม ” Cosplay” ครั้งที่ 4 ✨️\nกิจกรรม ” Cover Dance พร้อมเอนจอยไปกับเสียงดนตรี\nจากวง Folk song และ Full band\n✨️ท่องไปในโลกป่าพิศวง ของคนช่างคึด 🦋\nพร้อมสนุกไปกับ Zone Food & Handmade\nและกิจกรรมอื่นๆ อีกมากมาย	กุมภาพันธ์	ระหว่างวันที่ 7-9 กุมภาพันธ์ 2568	เวลา 17:00 – 23:00 น.	ณ บริเวณหน้าคณะสถาปัตยกรรมศาสตร์ มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475579411_1211550383929136_4015357673306697023_n-1024x1536.jpg	ขอบคุณภาพจาก: เพจ ช่างคึด ARCH KKU	2025-02-18 07:55:32.126428	2
13	เทศกาลหนังสือขอนแก่น ครั้งที่ 1	พบกิจกรรมต่างๆมากมายภายในงาน อาทิ —\n◍ 𝘽𝙤𝙤𝙠 𝙨𝙚𝙡𝙚𝙘𝙩𝙞𝙤𝙣 : ช้อปหนังสือตามสไตล์ จากสำนักพิมพ์กว่า 60 รายที่จะยกขบวนขนหนังสือมาให้นักอ่านได้เลือกหาเล่มโปรดของคุณ พร้อมรับโปรโมชั่นพิเศษสุด\n◍ 𝙋𝙐𝘽𝘼𝙏 𝘾𝙤𝙣𝙩𝙚𝙨𝙩 : ร่วมกิจกรรมการประกวดเล่านิทานระดับอายุ 4-7 ปีและ 8-12 ปี และลุ้นไปกับการแข่งขันตอบปัญหาวรรณกรรมไทยระดับมัธยมต้นและมัธยมปลาย\n◍ 𝘾𝙤𝙨𝙥𝙡𝙖𝙮 𝙨𝙝𝙤𝙬 : สนุกไปกับสีสันของการแสดง Cosplay freestage และ Random dance\n◍ 𝙕𝙤𝙣𝙚 𝙒𝙤𝙧𝙠𝙨𝙝𝙤𝙥 𝙖𝙣𝙙 𝘼𝙧𝙩&𝘾𝙧𝙖𝙛𝙩 : ฝึกฝีมือกับเวิร์คช็อปหลากหลาย และงานอาร์ตแอนด์คราฟท์มากมายหลายร้าน	กุมภาพันธ์	24 มกราคม – 2 กุมภาพันธ์ 2568	เวลา 10.00 – 21.00 น.	ณ ขอนแก่น ฮอลล์ ชั้น 5 Central Khonkaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/472082424_1190572442693597_7098593941503949504_n.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:16:42.833273	8
11	ภูผาม่าน เฟสติวัล	มหกรรมดนตรี กวีศิลป์ ท่ามกลางขุนเขา 🌳⛰️🎶\nภูผาม่าน เฟสติวัล\nพบกับศิลป์ 20 วง ณ.ภูผาม่าน จ.ขอนแก่น	มกราคม	วันที่ 24-25 มกราคม 2568	\N	ณ ไร่ข้าวน้ำซ่ามปลา ภูผาม่านขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/472098285_1190572466026928_1860464420868609952_n-1086x1536.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:15:08.335148	2
10	งานวันเกษตรภาคอีสาน ประจำปี 2568	งานวันเกษตรภาคอีสาน ประจำปี 2568 กลับมาแล้ว ✨ \nมาเดินช้อป เดินชิม กันให้จุใจ แล้วอย่าลืม แวะไปถ่ายรูปกับแปลงดอกไม้สวยๆ กันด้วยนะ\n.\nทุกๆ ปีก็จะมีทั้งโซนอาหาร, โซนแสดงนวัตกรรม, ต้นไม้และจัดสวน, สัตว์เลี้ยง, ของเบ็ดเตล็ด, เวทีการประกวดต่าง ๆ, KKU SMART Flower Farm  และไฮไลต์เด็ดคือโซนอาหารที่ขนทัพร้านดัง มาแบบจุก ๆ กาปฏิทินไว้ แล้วเตรียมตัวไปกันโลด	กุมภาพันธ์	 ระหว่างวันที่ 24 มกราคม – 2 กุมภาพันธ์ 2568	\N	ณ อุทยานเทคโนโลยีการเกษตร มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/471614299_1190571466027028_1869978307620706989_n-1536x614.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:13:19.218802	3
17	ละครเวทีสุดสร้างสรรค์จากสถาปัตย์ มข. “มาเด้อ ขวัญเอ้ย”	กลับมาอีกครั้งกับละครเวทีสุดสร้างสรรค์จากสถาปัตย์ มข.\n“มาเด้อ ขวัญเอ้ย” ผีบ้านนี้…มีอะไรมากกว่าที่คุณคิด เตรียมตัวมาพบกับความสนุกสุดหลอนปนฮา ที่จะทำให้คุณต้องทึ่งและหัวเราะไปพร้อมกัน!	กุมภาพันธ์	รอบการแสดง : 25 กุมภาพันธ์ – 1 มีนาคม 2568	\N	📍 คณะสถาปัตยกรรมศาสตร์ มข.	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475595842_1211550087262499_8351301859811394481_n-1086x1536.jpg	ขอบคุณภาพจาก : เพจขอนแก่นอีเว้นต์	2025-02-24 16:28:54.503751	4
16	เต้ย FRESHTIVAL ครั้งที่ 8	เต้ย FRESHTIVAL ครั้งที่ 8\nงานดนตรีที่จะทำให้ทุกคนสนุกสนานและในงานยัง\nมีน้องข้าวโพดที่จะชวนทุกคน แต่ง Dresscode “อาชีพในฝัน” พร้อมพบกับ 9 ศิลปิน	กุมภาพันธ์	🗓️22 กุมภาพันธ์ 2568	\N	📍ศูนย์ค้าส่งอู้ฟู่ ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475529516_1211550463929128_1006876235693049317_n-1-1232x1536.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้น	2025-02-24 16:23:07.029506	5
15	ARTLANTINE เทศกาลถนนศิลปะ ครั้งที่ 22	ภายในงานมีทั้งนิทรรศการภาพถ่าย หนังกลางแปลง งานศิลปะ ของแฮนด์เมด โซนดนตรีในสวนและสตรีทฟู้ดต่างๆ	กุมภาพันธ์	📅 วันที่ 14-16 กุมภาพันธ์ 2568	⏰ ตั้งแต่ 16:30 น. เป็นต้นไป	📍สะพานขาว คณะศิลปกรรมศาสตร์ มข.	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475754103_1211550570595784_3359820900038596945_n-1229x1536.jpg	ขอบคุณภาพและข้อมูลจากเว็บไซต์มหาวิทยาลัยขอนแก่น	2025-02-24 16:22:04.956629	6
9	งานวันเกษตรภาคอีสาน ประจำปี 2568	งานวันเกษตรภาคอีสาน ประจำปี 2568 กลับมาแล้ว ✨ \nมาเดินช้อป เดินชิม กันให้จุใจ แล้วอย่าลืม แวะไปถ่ายรูปกับแปลงดอกไม้สวยๆ กันด้วยนะ\n.\nทุกๆ ปีก็จะมีทั้งโซนอาหาร, โซนแสดงนวัตกรรม, ต้นไม้และจัดสวน, สัตว์เลี้ยง, ของเบ็ดเตล็ด, เวทีการประกวดต่าง ๆ, KKU SMART Flower Farm  และไฮไลต์เด็ดคือโซนอาหารที่ขนทัพร้านดัง มาแบบจุก ๆ กาปฏิทินไว้ แล้วเตรียมตัวไปกันโลด	มกราคม	ตั้งแต่ 24 มกราคม - 2 กุมภาพันธ์ 2568 	\N	อุทยานเทคโนโลยีการเกษตร มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/471614299_1190571466027028_1869978307620706989_n-1536x614.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:12:07.974713	5
7	งานสมโภชพุทธมณฑลอีสาน จังหวัดขอนแก่น	🎉✨จัดใหญ่ จัดเต็ม! งานสมโภชพุทธมณฑลอีสาน จังหวัดขอนแก่น 9-15 มกราคม 2568 นี้!✨🎉\n🛍️ พบกับคาราวานร้านค้ามากมาย  กับมหรสพสุดอลังการ 🎤 และการแสดงสดจากศิลปินชื่อดังทุกคืน ฟรี! ตลอด 7 วัน 7 คืน 🎶🎤 \n📍 สถานที่: บริเวณถนนทางเลี่ยงเมืองขอนแก่น-กาฬสินธุ์ (ตำบลศิลา)\n🎆 มาร่วมกันสัมผัสบรรยากาศเสียง สี เสียง แบบจัดเต็มที่เดียวในขอนแก่น!	มกราคม	9 มกราคม 2568 - 15 มกราคม 2568	\N	บริเวณถนนทางเลี่ยงเมืองขอนแก่น-กาฬสินธุ์ (ตำบลศิลา)	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/135109.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:02:47.001553	6
18	PROXIE (เจอ) XIE อิน KHONKAEN	ด้วยเสียงตอบรับที่ดีของ วันนี้เจอพ้อกสีหน่อยไหม\nทำให้ #PROXIEth อยากชวนทุกคนมา ‘เจอกันสิ้’ ทั่วไทย โดยเริ่มต้นกันที่ขอนแก่น!	มีนาคม	1 มีนาคม 2568	\N	ลานซังเคน ชั้น G, Central Khonkaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481076830_1231287298622111_1041285196080933671_n.jpg	ขอบคุณภาพจาก : เว็บไซต์ ขอนแก่นอีเวนท์	2025-03-01 11:24:30.084396	14
20	แถลงข่าวปิดเทอมสร้างสรรค์ อัศจรรย์วันว่าง 2568	ปิดเทอมสร้างสรรค์ อัศจรรย์วันว่าง 2568 กำลังจะกลับมา! 🎉 สร้างพื้นที่แห่งโอกาสให้เด็กและเยาวชนได้เรียนรู้ผ่านกิจกรรมที่หลากหลาย ปีนี้พิเศษกว่าที่เคย พบกับ มากกว่า 1,000 กิจกรรม จาก 954 พื้นที่การเรียนรู้	มีนาคม	📅 วันอาทิตย์ที่ 2 มีนาคม 2568	🕐 13:00 – 16:00 น. (แถลงข่าว & ลงนาม MOU)\n🎡 16:30 – 21:00 น. (เฟสติวัล)	📍 หอศิลปวัฒนธรรม มหาวิทยาลัยขอนแก่น Map	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481004482_1231287311955443_6291785707223763096_n-1229x1536.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-03-01 11:27:24.843525	15
22	Found Mar’ket ฟ้าวมา’เก็ต	งานตลาดศิลปะดนตรีสด สุด Exclusive เริ่มต้น Workshop ไปกับ Studio ชื่อดัง เดินตลาดงานคราฟต์ และแฟชั่นสุดชิค สุดคูล พร้อมดนตรีและอาหารเครื่องดื่มแบบครบครัน เตรียมพร้อมกันได้เลยวัยรุ่น ✨ \nWorkshop\n-Ceramic painting จาก Chu.pot Ceramics\n-ระบายสีแก้วดินเผา จาก KOON Studio By Clay.Koon\n-Stencil สกรีน เสื้อและกระเป๋า จาก Mango Studio\n-Woodcut พร้อมสกรีน จาก เอกภาพพิมพ์ ศิลปกรรม มข.	มีนาคม	🗓️ 8-9 มีนาคม 2568	⏰ 14.00-21.30 น.	📍Picasso Nite-Out Cafe ( กังสดาล มข )	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481226051_1231286155288892_5709241634914490957_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-01 11:31:22.06576	11
23	ไหมไทย หัวใจศิลป์	นี่คือจอมยุทธ์ พระเอกใหญ่\n#ไหมไทยหัวใจศิลป์\n13 มีนาคม 68\n📍Tontann Market khonkaen	มีนาคม	13 มี.ค. 68	ติดตามได้ที่เพจ ตลาดต้นตาล 	ตลาดต้นตาล	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480887068_1231287421955432_7761617366767765400_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-01 11:33:22.781534	12
24	ตลาดนัดโชห่วยครั้งที่ 15 “เเดนเนรมิตร – เนรมิตรทุกสิ่งเป็นจริงเพื่อโชห่วย”	🚩จัดหนักสินค้าจากเเบรนด์พันธมิตรมากมาย ยกขบวนพาเหรดมา ลด-เเลก-เเจก-แถม!\n🚩จัดเต็มกิจกรรมต่อยอดความรู้ ขายอะไรปัง อัพเดตเทรนเเละเทคโนโลยีใหม่ๆ ให้กับร้านโชห่วย!\n🚩จัดให้กับกองทัพศิลปิน ดารา ที่จะมาสร้างความสุขและความสนุก ตลอดทั้ง 4 วัน! ให้มันส์ตั้งเเต่เที่ยงวันยันเที่ยงคืน!\n🚩จัดไปกับโซนใหม่ Outdoor	มีนาคม	🗓️20 มี.ค. 2568 – 23 มี.ค. 2568	⏰10.00 – 00.00 น.	🏢KICE ศูนย์การประชุมและแสดงสินค้านานาชาติไคซ์-ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480959716_1231286158622225_5319148633022191285_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-01 11:34:44.446906	13
19	อีสานแฟร์	ม่วนซื่นอีสานแฟร์! มาสัมผัสบรรยากาศงานอีสานสุดม่วน พร้อมอาหารอีสานรสเลิศ และดนตรีสดเพราะๆ ทุกวัน!\nพบกับร้านอาหารอีสานชื่อดังมากมาย และสนุกไปกับการแสดงสุดอลังการ ในงานอีสานแฟร์	มีนาคม	🗓️1-9 มีนาคม 2568	⏰10:30 – 21:00 น.	📍หอกาญจนาภิเษก ม.ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481142785_1231286928622148_2618192170237202107_n.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-03-01 11:26:03.730217	18
30	COVER DANCE JAPAN WEEK x WORLD COSPLAY SUMMIT THAILAND 2025	สายแดนซ์ห้ามพลาด!!💃 เปิดรับสมัครทีม “COVER DANCE” มาร่วมสร้างสีสันโชว์สเต็ปลีลาการเต้นบนเวทีงาน JAPAN WEEK x WORLD COSPLAY SUMMIT THAILAND 2025 ทั้ง 4 จังหวัด (ระยอง, ขอนแก่น, นครสวรรค์, กรุงเทพมหานคร)	มีนาคม	22 มีนาคม - 23 มีนาคม	ไม่ระบุเวลา	Central Khonkaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480838344_1231286408622200_3230665201390446873_n-1.jpg.0	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	8
29	“เติมใจให้ตน” ปัจจุบันขณะกับดอกไม้สู่ใจ : ศิลปะแห่งการดูแลตนเอง	“เติมใจให้ตน” ปัจจุบันขณะกับดอกไม้สู่ใจ : ศิลปะแห่งการดูแลตนเอง ชวนทุกคนมาเติมเต็มหัวใจและดูแลตัวเองกับ KKU Academy TALK ครั้งที่ 5 พบกับเสวนาและเวิร์กช็อปสุดพิเศษ KKU Academy TALK WORKSHOP ดอกไม้สู่ใจ (รับจำนวนจำกัด 15 ท่าน) มาเรียนรู้ศิลปะแห่งการดูแลตัวเองด้วยกันนะ!	มีนาคม	20 มีนาคม 2568	13.30 – 16.30 น.	สถาบัน KKU Academy ชั้น 9 อาคารศูนย์สารสนเทศ (สำนักหอสมุด)	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480831104_1051310030365351_1108261923095316077_n-1536x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	9
28	ตลาดนัดโชห่วยครั้งที่ 15 “เเดนเนรมิตร – เนรมิตรทุกสิ่งเป็นจริงเพื่อโชห่วย	กลับมาอีกครั้งแบบยิ่งใหญ่กว่าเดิม กับงาน “ตลาดนัดโชห่วยครั้งที่ 15” “เเดนเนรมิตร – เนรมิตรทุกสิ่งเป็นจริงเพื่อโชห่วย” จัดหนักสินค้าจากเเบรนด์พันธมิตรมากมาย ยกขบวนพาเหรดมา ลด-เเลก-เเจก-แถม! จัดเต็มกิจกรรมต่อยอดความรู้ ขายอะไรปัง อัพเดตเทรนเเละเทคโนโลยีใหม่ๆ ให้กับร้านโชห่วย! จัดให้กับกองทัพศิลปิน ดารา ที่จะมาสร้างความสุขและความสนุก ตลอดทั้ง 4 วัน! ให้มันส์ตั้งเเต่เที่ยงวันยันเที่ยงคืน! จัดไปกับโซนใหม่ Outdoor	มีนาคม	20 มีนาคม 2568 – 23 มีนาคม 2568	10.00 – 00.00 น.	KICE ศูนย์การประชุมและแสดงสินค้านานาชาติไคซ์-ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/480959716_1231286158622225_5319148633022191285_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	10
26	ยกระดับการศึกษาสู่มาตรฐานสากล กับการอบรมเชิงปฏิบัติการ PLO & CLO	สำนักบริการวิชาการ ร่วมกับ คณะวิทยาศาสตร์ มหาวิทยาลัยขอนแก่น ขอเชิญคณาจารย์ เข้าร่วมอบรมหลักสูตร “ยกระดับการศึกษาสู่มาตรฐานสากล กับการอบรมเชิงปฏิบัติการ PLO & CLO” พัฒนาการเรียนการสอนอย่างมืออาชีพ กับหลักสูตรที่จะช่วยให้คุณ กำหนดผลลัพธ์การเรียนรู้อย่างเป็นระบบ สร้างมาตรฐานการศึกษาระดับสากล เพิ่มประสิทธิภาพการจัดการเรียนการสอน พิเศษ! รับจำนวนจำกัดเพียง 40 ท่านเท่านั้น วิทยากรผู้เชี่ยวชาญ พร้อมถ่ายทอดประสบการณ์	มีนาคม	17 มีนาคม - 18 มีนาคม	ไม่ระบุเวลา	โรงแรมบายาสิตา มข.	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/PLO-CLO-1086x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	16
25	BOB The Nice Guy	ชาวขอนแก่นเตรียมพบกับนิทรรศการใหญ่ครั้งแรกในภาคอีสานที่ต้นตาลขอนแก่น “BOB The Nice Guy” โดยศิลปิน แพรว-ฉันทิศา เตตานนทร์สกุล น้อง BOB สุดคิวท์ ตัวโตหนุบหนับ คาแรคเตอร์ก้อนกลมอมยิ้มสีขาวสุดป่วน ที่เดินทางไกลมาจากกรุงเทพฯ😍 และบุกคาเฟ่ในขอนแก่นกว่า 30 ร้าน	มีนาคม	12 กุมภาพันธ์ – 31 มีนาคม 2568	ไม่ระบุเวลา	Tontann Artspace ต้นตาลขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481357551_1231287445288763_5843564868440937010_n-1086x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	3
37	E-SAN CRAFT ขอนเเก่น	พบกันงาน E-SAN CRAFT ขอนเเก่น🥂 ปาร์ตี้เครื่องดื่มเเละดีเจมาม่วนมามันส์	มีนาคม	28-29 มีนาคม 2568 (เข้าฟรี)	15:00 - 23:30 น.	กระติบมาร์เก็ต บึงเเก่นนคร	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481219379_1231287478622093_1926260101379898515_n-1104x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	4
36	“ตรุษไทภูผาม่าน” ประจำปี 2568	อำเภอภูผาม่านขอเชิญร่วมสืบสานวัฒนธรรมประเพณีวิถีถิ่นไทภูผาม่าน “ตรุษไทภูผาม่าน” ประจำปี 2568	มีนาคม	28 มีนาคม - 30 มีนาคม	ไม่ระบุเวลา	สนามหน้าที่ว่าการอำเภอภูผาม่าน อำเภอภูผาม่าน จังหวัดขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481662969_1231286328622208_9165056305605045745_n-1458x820.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	5
34	ISAN Wellness Connect	Wellness to ISAN – เจาะตลาด Wellness สู่ภูมิภาคอีสาน “ISAN Wellness Summit” การรวมตัวผู้บริหาร C-level ของโรงพยาบาล, เจ้าของคลินิกด้านความงามและสุขภาพ, ผู้บริหารโรงแรมและสปา, แพทย์, นักวิจัย, ผู้ให้บริการโซลูชัน, หน่วยงานรัฐบาล, สมาคม, และผู้เชี่ยวชาญด้านสุขภาพ โดยมีการบรรยายและนำเสนอแนวคิดใหม่ๆ พร้อมกิจกรรมเวิร์กช็อปพิเศษอีกมากมาย โดยมีเป้าหมายหลักในการส่งเสริมอุตสาหกรรมสุขภาพในภาคอีสาน พร้อมสนับสนุนวิสัยทัศน์ของประเทศไทยในการเป็นศูนย์กลางด้านสุขภาพ – Wellness ในเอเชีย	มีนาคม	27-28 มีนาคม 2568	8:30 - 16:00 น.	Pullman Khon Kaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2024/08/462534249_545822414663819_8497932096477312275_n.png	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	7
6	งานวันเกษตรภาคอีสาน ประจำปี 2568	งานวันเกษตรภาคอีสาน ประจำปี 2568 กลับมาแล้ว ✨ \n10 วันเต็ม ตั้งแต่ 24 มกราคม - 2 กุมภาพันธ์ 2568 เจอกันที่เดิม มาเดินช้อป เดินชิม กันให้จุใจ แล้วอย่าลืม แวะไปถ่ายรูปกับแปลงดอกไม้สวยๆ กันด้วยนะ\nทุกๆ ปีก็จะมีทั้งโซนอาหาร, โซนแสดงนวัตกรรม, ต้นไม้และจัดสวน, สัตว์เลี้ยง, ของเบ็ดเตล็ด, เวทีการประกวดต่าง ๆ, KKU SMART Flower Farm  และไฮไลต์เด็ดคือโซนอาหารที่ขนทัพร้านดัง มาแบบจุก ๆ กาปฏิทินไว้ แล้วเตรียมตัวไปกันโลด	มกราคม	วันที่ 24 มกราคม – 2 กุมภาพันธ์ 2568	10.00-22.00	สถานที่ ณ อุทยานเทคโนโลยีการเกษตร มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/471614299_1190571466027028_1869978307620706989_n-2048x819.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-02-23 11:51:53.510282	1
8	งานสร้างคน คนสร้างงาน @ม.ภาคฯ ขอนแก่น	ภายในงานพบกับ\n✅ ตำแหน่งงานว่างจาก 40 บริษัท ตำแหน่งงานมากกว่า 1,000 อัตรา หลากหลายวิชาชีพ ทุกระดับวุฒิการศึกษา\n✅ สาธิตและทดลองปฏิบัติอาชีพอิสระ 10 อาชีพ/วัน\n✅ ผลิตภัณฑ์ของผู้รับงานไปทำที่บ้านจากจังหวัดขอนแก่นและจังหวัดใกล้เคียง\n✅โอกาสสำหรับผู้ที่อยากประกอบธุรกิจ ฟู้ดทรัค แฟรนไชส์ 🚛\n✅ และอื่นๆอีกมากมายย	มกราคม	วันที่ 17 – 18 มกราคม 2568	เวลาประมาณ 09.00-16.00 น.	หอประชุมประภากรคอนเวนชั่นฮอลล์ มหาวิทยาลัยภาคตะวันออกเฉียงเหนือ อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/471600686_1190572186026956_4586508035201016435_n.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:10:25.935871	3
12	เทศกาลหนังสือขอนแก่น ครั้งที่ 1	พบกิจกรรมต่างๆมากมายภายในงาน อาทิ —\n◍ 𝘽𝙤𝙤𝙠 𝙨𝙚𝙡𝙚𝙘𝙩𝙞𝙤𝙣 : ช้อปหนังสือตามสไตล์ จากสำนักพิมพ์กว่า 60 รายที่จะยกขบวนขนหนังสือมาให้นักอ่านได้เลือกหาเล่มโปรดของคุณ พร้อมรับโปรโมชั่นพิเศษสุด\n◍ 𝙋𝙐𝘽𝘼𝙏 𝘾𝙤𝙣𝙩𝙚𝙨𝙩 : ร่วมกิจกรรมการประกวดเล่านิทานระดับอายุ 4-7 ปีและ 8-12 ปี และลุ้นไปกับการแข่งขันตอบปัญหาวรรณกรรมไทยระดับมัธยมต้นและมัธยมปลาย\n◍ 𝘾𝙤𝙨𝙥𝙡𝙖𝙮 𝙨𝙝𝙤𝙬 : สนุกไปกับสีสันของการแสดง Cosplay freestage และ Random dance\n◍ 𝙕𝙤𝙣𝙚 𝙒𝙤𝙧𝙠𝙨𝙝𝙤𝙥 𝙖𝙣𝙙 𝘼𝙧𝙩&𝘾𝙧𝙖𝙛𝙩 : ฝึกฝีมือกับเวิร์คช็อปหลากหลาย และงานอาร์ตแอนด์คราฟท์มากมายหลายร้าน	มกราคม	24 มกราคม – 2 กุมภาพันธ์ 2568	 เวลา 10.00 – 21.00 น.	ณ ขอนแก่น ฮอลล์ ชั้น 5 Central Khonkaen	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/01/472082424_1190572442693597_7098593941503949504_n.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-02-24 16:16:06.13802	4
14	International Food Fest 2025 by TEKKU	กลับมาอีกครั้งกับงานเทศกาลอาหารนานาชาติที่ทุกคนรอคอย!\n“International Food Fest 2025 by TEKKU”\n.\nภายใต้แนวคิด “INNOVATIVE x COZY FOOD: Craft the Wellness”\nนวัตกรรมอาหารสุขภาพแสนอบอุ่นสู่วิถีดูแลกายใจอย่างยั่งยืน\nเตรียมตัวพบกับประสบการณ์การกินอาหารสุดพิเศษที่ผสมผสานนวัตกรรมและความอบอุ่น พร้อมกิจกรรมหลากหลายที่ทุกคนไม่ควรพลาด!	กุมภาพันธ์	📅 วันที่ 14-16 กุมภาพันธ์ 2568	⏰ ตั้งแต่ 16:30 น. เป็นต้นไป	บริเวณถนนหน้า TE Outlet คณะเทคโนโลยี มข.	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/02/475775118_1211550143929160_8100840716901975803_n-1-1229x1536.jpg	ขอบคุณภาพจาก : เว็บไซต์มหาวิทยาลัยขอนแก่น	2025-02-24 16:19:38.158203	7
27	Workshop เรียนรู้ศาสตร์ Aromatherapy และ Tibetan Sound Healing เพื่อความผ่อนคลายกายใจจากความเครียด	ใครที่สนใจ Workshop เรียนรู้ศาสตร์ Aromatherapy และ Tibetan Sound Healing เพื่อความผ่อนคลายกายใจจากความเครียด โดยครูเอื้อย กนกพร ชิโนรักษ์ และครูอิ๊บ สุรดา ศุภดิเรกกุล ผู้เชี่ยวชาญด้าน Aromatherapy และ Sound Healing ชวนมาร่วมกิจกรรม Breathe Happiness: Aromatherapy Workshop **รับจำกัดเพียง 15 ท่านเท่านั้น** ค่าเข้าร่วม Workshop 290 บาท/ท่าน	มีนาคม	18 มีนาคม 2568	13:00 – 15:00 น.	ร้าน 12 นาฬิกา Home Café ซอยประชาสโมสร 52 หลัง ม.ราชมงคล	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/483164714_2406187083066236_8383783401041242168_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	1
35	คณะสถาปัตยกรรมศาสตร์ มข. จัดอบรม “แนะแนวตรงเป้า รับเข้าสถาปัตย์ มข.”	ติวเข้มครูแนะแนว เจาะลึกเทคนิคการเตรียมตัวสอบ โครงการอบรมระยะสั้น “แนะแนวตรงเป้า รับเข้าสถาปัตย์ มข.” โครงการนี้จัดขึ้นเพื่อเพิ่มศักยภาพครูแนะแนวให้มีความรู้ความเข้าใจในการแนะนำนักเรียนเข้าศึกษาต่อคณะสถาปัตยกรรมศาสตร์อย่างมีประสิทธิภาพ โดยผู้เข้าอบรมจะได้รับความรู้เข้มข้นจากคณาจารย์ผู้เชี่ยวชาญและสถาปนิกมืออาชีพ\nค่าลงทะเบียนเพียง 2,900 บาท รับจำนวนจำกัดเพียง 50 ท่านเท่านั้น! รับสมัครได้ตั้งแต่วันนี้ ถึงวันที่ 18 มีนาคม 2568\nสนใจสมัครหรือสอบถามรายละเอียดเพิ่มเติมได้ที่ งานบริการวิชาการและวิจัย คณะสถาปัตยกรรมศาสตร์ มหาวิทยาลัยขอนแก่น\nโทรสอบถามรายละเอียด : 083-1515454\nติดต่อ : คุณพิมพ์ชนก\nสมัครที่เว็บไซต์ : https://kku.world/guidearkku	มีนาคม	28 มีนาคม - 29 มีนาคม	\N	ณ อาคารสิม คณะสถาปัตยกรรมศาสตร์ มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/poster-scaled-1-1086x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	2
33	โครงการฝึกอบรมหลักสูตร ทักษะศิลปะมวยไทย มวยไทยโบราณ นานาชาติ KKU SOFT POWER ที่จะพาท่านฝึกฝนศิลปะการต่อสู้	เชิญท่านสัมผัส ศาสตร์แห่งมวยไทยโบราณ ประสบการณ์อันล้ำค่า กับโครงการฝึกอบรมหลักสูตร ทักษะศิลปะมวยไทย มวยไทยโบราณ นานาชาติ KKU SOFT POWER ที่จะพาท่านฝึกฝนศิลปะการต่อสู้ ากกว่าการต่อสู้ ยังเป็นการฝึกฝนร่างกาย จิตใจ จิตวิญญาณ ให้เป็นคนกล้า มีความอดทน ถ่ายทอดวิชาโดยผู้เชี่ยวชาญ ที่มีประสบการณ์มวยไทยยาวนาน เนื้อหาครอบคลุม ท่าพื้นฐาน การต่อสู้ป้องกันตัว ฝึกพลังภายใน พัฒนาตนเองเพื่ออนาคต สุขภาพที่ดี พัฒนาทักษะที่นำไปประยุกต์ใช้ และต่อยอดอาชีพได้	มีนาคม	25 มีนาคม - 27 มีนาคม	ไม่ระบุเวลา	ณ อาคารพลศึกษา ม.ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/471977075_1169378711857590_6888604600377961392_n-1086x1536.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	6
32	คอนเสิร์ตสุดพิเศษ AYLA’s Concert ที่ Somewhere Only We Know	คอนเสิร์ตสุดพิเศษ AYLA’s Concert ที่ Somewhere Only We Know เตรียมตัวให้พร้อมสำหรับค่ำคืนแห่งเสียงดนตรีสุดมันส์กับวง AYLA’s ที่จะมาสร้างความสนุกแบบใกล้ชิดในบรรยากาศสุดชิล!\nบัตรเข้าชม\nEarly Bird: ราคา 250 บาท (ซื้อได้ถึงวันที่ 17 มีนาคมนี้เท่านั้น!)\nบัตรหน้างาน: ราคา 350 บาท พิเศษสำหรับโต๊ะ 4 แถวหน้าเวที ต้องมีผู้เข้าชมตั้งแต่ 4 ท่านขึ้นไปเท่านั้นวิธีการจองบัตร\nสำรองบัตรได้ที่ร้าน Somewhere Only We Know\nหรือจองผ่านช่องทางออนไลน์: Facebook Instagram Inbox ของร้าน	มีนาคม	24 มีนาคม 2025	18:00 น. - 23:30 น. ประตูเปิดเวลา: 18:00 น. (ที่นั่งแบบ First Come First Serve มาก่อนเลือกก่อน)	Somewhere only we know ขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481272334_1231286845288823_1789854530442903574_n.jpg	ขอบคุณข้อมูลจาก : ขอนแก่นอีเว้นต์	2025-03-18 14:09:24.686697	17
21	งาน Japan Education Fair in Khon Kaen แนะแนวการศึกษาต่อประเทศญี่ปุ่น ครั้งที่ 24	📣 ขอเชิญร่วมงาน Japan Education Fair in Khon Kaen แนะแนวการศึกษาต่อประเทศญี่ปุ่น ครั้งที่ 24\n✅ รับคำแนะนำโดยตรงจากสถานเอกอัครราชทูตญี่ปุ่น และ JASSO\n✅ พบกับผู้แทนจากมหาวิทยาลัยและองค์กรชั้นนำของญี่ปุ่น\n📚 พบกับบูธแนะแนวการศึกษาจากมหาวิทยาลัยชั้นนำของญี่ปุ่น \n❗️ฟรี! ไม่มีค่าใช้จ่าย เปิดโอกาสสำหรับผู้ที่สนใจศึกษาต่อประเทศญี่ปุ่น	มีนาคม	📅 วันที่: 7 มีนาคม 2568 	⏰ เวลา: 10.00 – 12.00 น.	ห้องประชุมสายสุรี จุติกุล คณะศึกษาศาสตร์ มหาวิทยาลัยขอนแก่น	https://kkdata.khonkaenlink.info/wp-content/uploads/2025/03/481229754_1054417946721226_8682673740352267334_n.jpg	ขอบคุณภาพจาก : เพจ ขอนแก่นอีเว้นต์	2025-03-01 11:29:04.415091	20
\.


--
-- TOC entry 3455 (class 0 OID 31662)
-- Dependencies: 224
-- Data for Name: place_images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.place_images (id, place_id, image_link, image_detail) FROM stdin;
1336	173	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanTaCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านตาคาเฟ่ เวียงเก่า
1337	173	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanTaCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านตาคาเฟ่ เวียงเก่า
1338	173	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanTaCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านตาคาเฟ่ เวียงเก่า
725	144	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%E0%B9%80%E0%B8%A1%E0%B8%B5%E0%B8%A2%E0%B8%9B%E0%B9%8B%E0%B8%B2.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจ ตำเมียป๋า
726	144	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%E0%B9%80%E0%B8%A1%E0%B8%B5%E0%B8%A2%E0%B8%9B%E0%B9%8B%E0%B8%B201.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจ ตำเมียป๋า
1536	101	https://pukmudmuangthai.com/wp-content/uploads/2021/02/S__7962854.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ pukmudmuangthai
1134	166	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaChuangwelaCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ณ ช่วงเวลา - cafe and farm
1135	166	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaChuangwelaCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ณ ช่วงเวลา - cafe and farm
1136	166	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaChuangwelaCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ณ ช่วงเวลา - cafe and farm
1137	166	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaChuangwelaCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ณ ช่วงเวลา - cafe and farm
1537	101	https://pukmudmuangthai.com/wp-content/uploads/2021/02/IMG_6148-scaled.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ pukmudmuangthai
1142	174	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/Bangsan2_1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
1143	174	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/Bangsan2_2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
1144	174	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/Bangsan2_3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
1145	174	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/Bangsan2_4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
727	144	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%E0%B9%80%E0%B8%A1%E0%B8%B5%E0%B8%A2%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B9%80%E0%B8%A1%E0%B8%99%E0%B8%B9.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจ ตำเมียป๋า
1150	178	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanNokKhokKhwaiCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านนอก คอกควาย
1151	178	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanNokKhokKhwaiCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านนอก คอกควาย
1152	178	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanNokKhokKhwaiCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านนอก คอกควาย
1153	178	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanNokKhokKhwaiCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านนอก คอกควาย
1339	173	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanTaCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านตาคาเฟ่ เวียงเก่า
1538	101	https://i0.wp.com/pukmudmuangthai.com/wp-content/uploads/2021/02/IMG_3226-scaled.jpg?resize=1536%2C1024&ssl=1	ขอบคุณรูปภาพจาก: เว็บไซต์ pukmudmuangthai
1539	101	https://i0.wp.com/pukmudmuangthai.com/wp-content/uploads/2021/02/IMG_6167-scaled.jpg?resize=1024%2C683&ssl=1	ขอบคุณรูปภาพจาก: เว็บไซต์ pukmudmuangthai
1718	28	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TongToeyKoreanBBQ1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โต้งเต้ยเนื้อย่างเกาหลี ตลาดจอมพล
1158	180	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Baanpaimai1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Bobo Nutchanok
1159	180	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Baanpaimai2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Bobo Nutchanok
1160	180	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Baanpaimai3.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Bobo Nutchanok
1719	28	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TongToeyKoreanBBQ2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โต้งเต้ยเนื้อย่างเกาหลี ตลาดจอมพล
1161	180	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Baanpaimai4.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Bobo Nutchanok
1723	22	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Tommy1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อยากกินหมูกะทะ
1724	22	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Tommy2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อยากกินหมูกะทะ
1725	22	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Tommy3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อยากกินหมูกะทะ
609	140	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaoBoySoiThi1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ่าวบอยซอยถี่ สาขาขอนแก่น
610	140	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaoBoySoiThi2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ่าวบอยซอยถี่ สาขาขอนแก่น
611	140	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaoBoySoiThi3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ่าวบอยซอยถี่ สาขาขอนแก่น
612	140	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaoBoySoiThi4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ่าวบอยซอยถี่ สาขาขอนแก่น
728	144	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%E0%B9%80%E0%B8%A1%E0%B8%B5%E0%B8%A2%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B9%80%E0%B8%A1%E0%B8%99%E0%B8%B902.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจ ตำเมียป๋า
1166	194	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Phamanfun1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ผาม่านฝัน Pha Man Fun
1167	194	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Phamanfun2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ผาม่านฝัน Pha Man Fun
617	141	https://github.com/cholthicha61/Picture/blob/main/Charm.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ชาม Charm K Kitchen
1168	194	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Phamanfun3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ผาม่านฝัน Pha Man Fun
1169	194	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Phamanfun4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ผาม่านฝัน Pha Man Fun
1544	59	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhoThaBo1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เฝอท่าบ่อ ขอนแก่น
1344	199	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ThaibanCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Thaiban cafe
1345	199	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ThaibanCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Thaiban cafe
1173	202	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaiYangYaiPaeng1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างยายแพง อ.เขาสวนกวาง จ.ขอนแก่น
1174	202	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaiYangYaiPaeng2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างยายแพง อ.เขาสวนกวาง จ.ขอนแก่น
1175	202	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaiYangYaiPaeng3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างยายแพง อ.เขาสวนกวาง จ.ขอนแก่น
1346	199	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ThaibanCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Thaiban cafe
1347	199	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ThaibanCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Thaiban cafe
1545	59	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhoThaBo2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เฝอท่าบ่อ ขอนแก่น
1730	24	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaiTong1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายตอง หมูกระทะ
1180	203	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Dokmaifarm2-1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง
1181	203	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Dokmaifarm2-2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง
1182	203	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Dokmaifarm2-3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง
1183	203	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Dokmaifarm2-4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง
1731	24	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaiTong2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายตอง หมูกระทะ
1732	24	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaiTong3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายตอง หมูกระทะ
1733	24	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NaiTong4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายตอง หมูกระทะ
1188	177	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/RimKhueanCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ริมเขื่อน coffee
1189	177	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/RimKhueanCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ริมเขื่อน coffee
1190	177	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/RimKhueanCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ริมเขื่อน coffee
1191	177	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/RimKhueanCafe.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ริมเขื่อน coffee
1196	182	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Vareecafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Varee Cafe'&Restaurant-วารีคาเฟ่&ร้านอาหาร ขอนแก่น
1197	182	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Vareecafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Varee Cafe'&Restaurant-วารีคาเฟ่&ร้านอาหาร ขอนแก่น
1198	182	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Vareecafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Varee Cafe'&Restaurant-วารีคาเฟ่&ร้านอาหาร ขอนแก่น
1199	182	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Vareecafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Varee Cafe'&Restaurant-วารีคาเฟ่&ร้านอาหาร ขอนแก่น
1736	56	https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2024/10/04/e055fa7477cb464a952ff2523c9347d4_behind-the-bib-khon-kaen-grilled-pork-neck-chang_%287%29.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ MICHELIN Guide Thailand
1737	56	https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2024/10/04/78607382a66b457cb98f57e23c941a8d_behind-the-bib-khon-kaen-grilled-pork-neck-chang_%288%29.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ MICHELIN Guide Thailand
1546	59	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhoThaBo3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เฝอท่าบ่อ ขอนแก่น
1352	164	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NabuaCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นา บัว
1353	164	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NabuaCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นา บัว
1547	59	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhoThaBo4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เฝอท่าบ่อ ขอนแก่น
1742	73	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoTomSong24_1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวต้มซ้ง 24 น
1204	196	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SamrapLao1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สำรับลาว ภูผาม่าน  (Phuphaman esan restaurant)
1205	196	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SamrapLao2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Sopida Hanchana
1206	196	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SamrapLao3.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Sopida Hanchana
1207	196	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SamrapLao4.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Sopida Hanchana
1743	73	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoTomSong24_2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวต้มซ้ง 24 น
1744	73	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoTomSong24_3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวต้มซ้ง 24 น
618	141	https://github.com/cholthicha61/Picture/blob/main/Charm02.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ชาม Charm K Kitchen
619	141	https://github.com/cholthicha61/Picture/blob/main/Charm1.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ชาม Charm K Kitchen
620	141	https://github.com/cholthicha61/Picture/blob/main/Charm3.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ชาม Charm K Kitchen
621	141	https://github.com/cholthicha61/Picture/blob/main/Charm4.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ชาม Charm K Kitchen
1745	73	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoTomSong24_4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวต้มซ้ง 24 น
1211	193	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKhaoCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค หลงเขาคาเฟ่ ภูผาม่าน
1750	61	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KruaSupanniga4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ครัวสุพรรณิการ์ by คุณยายสมศรี ขอนแก่น
1751	61	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KruaSupanniga2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ครัวสุพรรณิการ์ by คุณยายสมศรี ขอนแก่น
1752	61	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KruaSupanniga3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ครัวสุพรรณิการ์ by คุณยายสมศรี ขอนแก่น
1212	193	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKhaoCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค หลงเขาคาเฟ่ ภูผาม่าน
1213	193	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKhaoCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค หลงเขาคาเฟ่ ภูผาม่าน
1354	164	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NabuaCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นา บัว
1355	164	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NabuaCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นา บัว
622	142	https://github.com/cholthicha61/Picture/blob/main/Aromatic03.jpg?raw=true	ขอบคุณภาพจาก : เพจ The Concept Aromatic Thai Cuisine
623	142	https://github.com/cholthicha61/Picture/blob/main/Aromatic02.jpg?raw=true	ขอบคุณภาพจาก : เพจ The Concept Aromatic Thai Cuisine
624	142	https://github.com/cholthicha61/Picture/blob/main/Aromatic01.jpg?raw=true	ขอบคุณภาพจาก : เพจ The Concept Aromatic Thai Cuisine
1753	61	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KruaSupanniga1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ครัวสุพรรณิการ์ by คุณยายสมศรี ขอนแก่น
1552	53	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrasitPochana2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสิทธิ์โภชนา ขอนแก่น
1553	53	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrasitPochana1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสิทธิ์โภชนา ขอนแก่น
1554	53	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrasitPochana3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสิทธิ์โภชนา ขอนแก่น
1360	197	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManLanView1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ภูผาม่าน ล้านวิว (อ. ภูผาม่าน)
1361	197	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManLanView2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ภูผาม่าน ล้านวิว (อ. ภูผาม่าน)
1555	53	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrasitPochana4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสิทธิ์โภชนา ขอนแก่น
625	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta%2007.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
626	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta05.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
627	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta03.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
628	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta06.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
629	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta02.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
630	143	https://github.com/cholthicha61/Picture/blob/main/ALL%20GOOD%20Homemade%20Pasta01.jpg?raw=true	ขอบคุณรูปภากจาก : เพจ ALL GOOD Homemade Pasta 
729	156	https://cms.dmpcdn.com/travel/2022/07/24/9ba80d40-0b29-11ed-9056-8ff37e209c3d_webp_original.jpg	ขอบคุณภาพจาก : RoBird / Shutterstock.com
730	156	https://cms.dmpcdn.com/travel/2022/07/24/9a46a880-0b29-11ed-8f0e-ef9921908600_webp_original.jpg	ขอบคุณภาพจาก : kwanchai / Shutterstock.com
731	156	https://cms.dmpcdn.com/travel/2022/07/24/9a48cb60-0b29-11ed-8f0e-ef9921908600_webp_original.jpg	ขอบคุณภาพจาก : kwanchai / Shutterstock.com
1218	187	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnSonViewCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ออนซอนวิว คาเฟ่ at ดูนสาด
1219	187	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnSonViewCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ออนซอนวิว คาเฟ่ at ดูนสาด
1220	187	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnSonViewCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ออนซอนวิว คาเฟ่ at ดูนสาด
1362	197	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManLanView3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ภูผาม่าน ล้านวิว (อ. ภูผาม่าน)
1363	197	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManLanView4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ภูผาม่าน ล้านวิว (อ. ภูผาม่าน)
1758	26	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kim1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คิมหมูกระทะ กังสดาล ขอนแก่น
1367	201	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
1368	201	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
1221	187	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnSonViewCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ออนซอนวิว คาเฟ่ at ดูนสาด
1759	26	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kim2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คิมหมูกระทะ กังสดาล ขอนแก่น
1226	163	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ImOzone1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อิ่มโอโซน
1227	163	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ImOzone2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อิ่มโอโซน
1228	163	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ImOzone3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อิ่มโอโซน
1229	163	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ImOzone4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อิ่มโอโซน
1234	179	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/UKhaoUNamFarmStay1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อู่ข้าวอู่น้ำ ฟาร์มสเตย์ เขื่อนอุบลรัตน์
1235	179	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/UKhaoUNamFarmStay2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อู่ข้าวอู่น้ำ ฟาร์มสเตย์ เขื่อนอุบลรัตน์
1236	179	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/UKhaoUNamFarmStay3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อู่ข้าวอู่น้ำ ฟาร์มสเตย์ เขื่อนอุบลรัตน์
1237	179	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/UKhaoUNamFarmStay4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อู่ข้าวอู่น้ำ ฟาร์มสเตย์ เขื่อนอุบลรัตน์
1242	98	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NamPhongNationalPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติน้ำพอง - Namphong National Park
813	168	https://old.khonkaenlink.info/home/upload/photo/news/RyXQ3Sdz.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink
814	168	https://old.khonkaenlink.info/home/upload/photo/news/KwTjcldz.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink
635	145	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%20%E0%B9%84%E0%B8%97%20%E0%B9%80%E0%B8%A5%E0%B8%A2%20%E0%B8%81%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%94%E0%B8%B2%E0%B8%A5%20%E0%B8%A1%E0%B8%82..jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ตำ ไท เลย กังสดาล มข. 
636	145	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%20%E0%B9%84%E0%B8%97%20%E0%B9%80%E0%B8%A5%E0%B8%A2%20%E0%B8%81%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%94%E0%B8%B2%E0%B8%A5%20%E0%B8%A1%E0%B8%82.%2003.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ตำ ไท เลย กังสดาล มข. 
637	145	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%20%E0%B9%84%E0%B8%97%20%E0%B9%80%E0%B8%A5%E0%B8%A2%20%E0%B8%81%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%94%E0%B8%B2%E0%B8%A5%20%E0%B8%A1%E0%B8%82.%2004.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ตำ ไท เลย กังสดาล มข. 
1566	30	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BoonDee1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บุญดีหมูกระทะ บ้านดอนบม
1567	30	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BoonDee2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บุญดีหมูกระทะ บ้านดอนบม
1760	26	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kim3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คิมหมูกระทะ กังสดาล ขอนแก่น
1243	98	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NamPhongNationalPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติน้ำพอง - Namphong National Park
1244	98	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NamPhongNationalPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติน้ำพอง - Namphong National Park
1245	98	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NamPhongNationalPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติน้ำพอง - Namphong National Park
1369	201	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
638	145	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%95%E0%B8%B3%20%E0%B9%84%E0%B8%97%20%E0%B9%80%E0%B8%A5%E0%B8%A2%20%E0%B8%81%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%94%E0%B8%B2%E0%B8%A5%20%E0%B8%A1%E0%B8%82.%2003.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ตำ ไท เลย กังสดาล มข. 
639	146	https://github.com/cholthicha61/Picture/blob/main/%E0%B9%81%E0%B8%AA%E0%B8%99%E0%B9%81%E0%B8%8B%E0%B9%88%E0%B8%9A.jpg?raw=true	ขอบคุณรุปภาพจาก : เพจ ขอนแก่น แสนแซ่บ 
640	146	https://github.com/cholthicha61/Picture/blob/main/%E0%B9%81%E0%B8%AA%E0%B8%99%E0%B9%81%E0%B8%8B%E0%B9%88%E0%B8%9A02.jpg?raw=true	ขอบคุณรุปภาพจาก : เพจ ขอนแก่น แสนแซ่บ 
641	146	https://github.com/cholthicha61/Picture/blob/main/%E0%B9%81%E0%B8%AA%E0%B8%99%E0%B9%81%E0%B8%8B%E0%B9%88%E0%B8%9A03.jpg?raw=true	ขอบคุณรุปภาพจาก : เพจ ขอนแก่น แสนแซ่บ 
815	168	https://old.khonkaenlink.info/home/upload/photo/news/0ZZlHt1h.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink
1761	26	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kim4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คิมหมูกระทะ กังสดาล ขอนแก่น
218	47	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OkaIzakayaKhonKaen1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Oka Izakaya KhonKaen
219	47	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OkaIzakayaKhonKaen2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Oka Izakaya KhonKaen
220	47	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OkaIzakayaKhonKaen3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Oka Izakaya KhonKaen
221	47	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OkaIzakayaKhonKaen4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Oka Izakaya KhonKaen
642	146	https://github.com/cholthicha61/Picture/blob/main/%E0%B9%81%E0%B8%AA%E0%B8%99%E0%B9%81%E0%B8%8B%E0%B9%88%E0%B8%9A04.jpg?raw=true	ขอบคุณรุปภาพจาก : เพจ ขอนแก่น แสนแซ่บ 
643	136	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Khanboon1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหารคานบุญ
644	136	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Khanboon2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหารคานบุญ
645	136	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Khanboon3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหารคานบุญ
646	136	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Khanboon4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหารคานบุญ
1250	54	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SoChengPochana1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Thatamsorn Rojrungsri
1766	57	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhunJaengGuayTiewPakMor1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง
1251	54	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SoChengPochana2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Thatamsorn Rojrungsri
1252	54	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SoChengPochana3.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Thatamsorn Rojrungsri
1253	54	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SoChengPochana4.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Thatamsorn Rojrungsri
1767	57	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhunJaengGuayTiewPakMor2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง
1572	50	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanHeng1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านเฮง ร้านอาหารเช้า และของฝากขอนแก่น
1573	50	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanHeng2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านเฮง ร้านอาหารเช้า และของฝากขอนแก่น
1574	50	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanHeng3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านเฮง ร้านอาหารเช้า และของฝากขอนแก่น
1575	50	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanHeng4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านเฮง ร้านอาหารเช้า และของฝากขอนแก่น
1768	57	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhunJaengGuayTiewPakMor3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง
1580	84	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanPhaSuk1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านผาสุข
1581	84	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanPhaSuk2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านผาสุข
1582	84	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanPhaSuk3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านผาสุข
1258	70	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SukjaiLand1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สุขใจ แลนด์
1259	70	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SukjaiLand2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สุขใจ แลนด์
1583	84	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanPhaSuk4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านผาสุข
1588	116	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaanKhonRakMooKrob1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านคนรักหมูกรอบ
1374	181	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatKhueanUbolratana1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วัดเขื่อนอุบลรัตน์ ถ้ำผาเจาะ จ.ขอนแก่น
1769	57	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhunJaengGuayTiewPakMor4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง
1375	181	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatKhueanUbolratana2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วัดเขื่อนอุบลรัตน์ ถ้ำผาเจาะ จ.ขอนแก่น
1376	181	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatKhueanUbolratana3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วัดเขื่อนอุบลรัตน์ ถ้ำผาเจาะ จ.ขอนแก่น
1377	181	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatKhueanUbolratana4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วัดเขื่อนอุบลรัตน์ ถ้ำผาเจาะ จ.ขอนแก่น
1589	116	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaanKhonRakMooKrob2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านคนรักหมูกรอบ
1260	70	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SukjaiLand3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สุขใจ แลนด์
1590	116	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaanKhonRakMooKrob3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านคนรักหมูกรอบ
1591	116	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BaanKhonRakMooKrob4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านคนรักหมูกรอบ
1776	114	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%88%E0%B9%89%E0%B8%A7%E0%B8%944.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1777	114	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%88%E0%B9%89%E0%B8%A7%E0%B8%943.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1778	114	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%88%E0%B9%89%E0%B8%A7%E0%B8%942.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1382	169	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OMGCAFEPW1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค OMG - OMEGA cafe โอเมก้า คาเฟ่
1383	169	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OMGCAFEPW2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค OMG - OMEGA cafe โอเมก้า คาเฟ่
1384	169	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OMGCAFEPW3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค OMG - OMEGA cafe โอเมก้า คาเฟ่
1385	169	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OMGCAFEPW4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค OMG - OMEGA cafe โอเมก้า คาเฟ่
1390	195	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Hugphaman1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮักผาม่าน
1391	195	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Hugphaman2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮักผาม่าน
1392	195	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Hugphaman3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮักผาม่าน
1393	195	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Hugphaman4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮักผาม่าน
1398	171	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoFeCoffeeTea1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DinoFe’ กาแฟไดโนเสาร์
1399	171	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoFeCoffeeTea2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DinoFe’ กาแฟไดโนเสาร์
1779	114	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/JaudCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1780	114	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%88%E0%B9%89%E0%B8%A7%E0%B8%94.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1781	114	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%88%E0%B9%89%E0%B8%A7%E0%B8%941.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค จ้วดคาเฟ่ ขอนแก่น
1596	71	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GuangTangNoodle1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บะหมี่กวงตัง พิมพสุต
1597	71	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GuangTangNoodle2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บะหมี่กวงตัง พิมพสุต
1786	27	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Janebbq1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เจนหมูกระทะ ออริจินอล ขอนแก่น
1598	71	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GuangTangNoodle3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บะหมี่กวงตัง พิมพสุต
1599	71	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GuangTangNoodle4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บะหมี่กวงตัง พิมพสุต
1400	171	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoFeCoffeeTea3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DinoFe’ กาแฟไดโนเสาร์
1401	171	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoFeCoffeeTea4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DinoFe’ กาแฟไดโนเสาร์
1787	27	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Janebbq2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เจนหมูกระทะ ออริจินอล ขอนแก่น
1788	27	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Janebbq3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เจนหมูกระทะ ออริจินอล ขอนแก่น
1789	27	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Janebbq4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เจนหมูกระทะ ออริจินอล ขอนแก่น
1261	70	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SukjaiLand4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สุขใจ แลนด์
1796	6	https://raw.githubusercontent.com/cholthicha61/Picture/main/Fellow%20Fellow%20Cafe.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
1797	6	https://github.com/cholthicha61/Picture/blob/main/Fellow%20Fellow%20Cafe02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
1798	6	https://github.com/cholthicha61/Picture/blob/main/Fellow%20Fellow%20Cafe03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
1799	6	https://github.com/cholthicha61/Picture/blob/main/Fellow%20Fellow%20Cafe04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
1800	6	https://github.com/cholthicha61/Picture/blob/main/Fellow%20Fellow%20Cafe06.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
1801	6	https://github.com/cholthicha61/Picture/blob/main/Fellow%20Fellow%20Cafe05.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Fellow Fellow Cafe
334	78	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SkywalkPhuAen1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
335	78	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SkywalkPhuAen2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
336	78	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SkywalkPhuAen3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
337	78	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SkywalkPhuAen4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
1604	112	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NewHengPochana1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค กินไปเที่ยวไปสไตล์ชมภู่
1605	112	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NewHengPochana2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค กินไปเที่ยวไปสไตล์ชมภู่
342	80	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Chomtawan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
1606	112	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NewHengPochana3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค กินไปเที่ยวไปสไตล์ชมภู่
1607	112	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NewHengPochana4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค กินไปเที่ยวไปสไตล์ชมภู่
1808	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1809	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1612	68	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TumkratoeiSagate1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตำกระเทย สาเกต Tumkratoei Sagate
1613	68	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TumkratoeiSagate2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตำกระเทย สาเกต Tumkratoei Sagate
1810	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1811	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1812	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie05.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1813	5	https://github.com/cholthicha61/Picture/blob/main/Lapin%20P%C3%A2tisserie02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Lapin Pâtisserie
1818	51	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MeekinFarm1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มีกินฟาร์ม MEKIN FARM
1819	51	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MeekinFarm2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มีกินฟาร์ม MEKIN FARM
343	80	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Chomtawan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
344	80	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Chomtawan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
345	80	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Chomtawan4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
346	81	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BlueLagoon1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ชีวิตต้องเจอนี่
347	81	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BlueLagoon2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ชีวิตต้องเจอนี่
348	81	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BlueLagoon3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ชีวิตต้องเจอนี่
349	81	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BlueLagoon4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ชีวิตต้องเจอนี่
1414	190	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Ganescafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Ganes cafe
1415	190	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Ganescafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Ganes cafe
1416	190	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Ganescafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Ganes cafe
1417	190	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Ganescafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Ganes cafe
1820	51	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MeekinFarm3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มีกินฟาร์ม MEKIN FARM
1821	51	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MeekinFarm4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มีกินฟาร์ม MEKIN FARM
1827	159	https://old.khonkaenlink.info/home/upload/photo/news/wfWAq0dQ.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink 
1614	68	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TumkratoeiSagate3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตำกระเทย สาเกต Tumkratoei Sagate
1615	68	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TumkratoeiSagate4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตำกระเทย สาเกต Tumkratoei Sagate
1828	159	https://old.khonkaenlink.info/home/upload/photo/news/HnxiWuQn.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink 
1829	159	https://old.khonkaenlink.info/home/upload/photo/news/rI0Ccfdy.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink 
1830	159	https://old.khonkaenlink.info/home/upload/photo/news/8rIz6Jqr.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink 
1831	159	https://old.khonkaenlink.info/home/upload/photo/news/cualBpB7.jpg	ขอบคุณภาพจาก : เว็บไซต์ khonkaenlink 
370	87	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatYai1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อีเว้นท์ไทย - Eventthai
371	87	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatYai2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อีเว้นท์ไทย - Eventthai
1422	176	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LittleBox1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Little Box Restaurant & Cafe
1620	109	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TonTan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตลาดต้นตาล
1621	109	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TonTan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตลาดต้นตาล
372	87	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatYai3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อีเว้นท์ไทย - Eventthai
373	87	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatYai4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อีเว้นท์ไทย - Eventthai
374	88	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKaengPhaThewada1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ล่องแก่งผาเทวดา
375	88	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKaengPhaThewada2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ล่องแก่งผาเทวดา
376	88	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKaengPhaThewada3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ล่องแก่งผาเทวดา
377	88	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LongKaengPhaThewada4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ล่องแก่งผาเทวดา
378	89	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanSuanRimThan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านสวนริมธาร at ภูผาม่าน
379	89	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanSuanRimThan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านสวนริมธาร at ภูผาม่าน
380	89	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanSuanRimThan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านสวนริมธาร at ภูผาม่าน
381	89	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BanSuanRimThan4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค บ้านสวนริมธาร at ภูผาม่าน
382	90	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatTao1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายท่องเที่ยว
383	90	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatTao2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายท่องเที่ยว
384	90	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatTao3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายท่องเที่ยว
385	90	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TatTao4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นายท่องเที่ยว
386	91	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoWaterPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dino Water Park
387	91	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoWaterPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dino Water Park
388	91	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoWaterPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dino Water Park
389	91	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DinoWaterPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dino Water Park
390	92	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ZooWaterPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
391	92	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ZooWaterPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
392	92	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ZooWaterPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
393	92	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ZooWaterPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
1832	204	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/189CAFE1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 1 8 9. CAFE'
1833	204	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/189CAFE4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 1 8 9. CAFE'
1834	204	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/189CAFE2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 1 8 9. CAFE'
1835	204	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/189CAFE3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 1 8 9. CAFE'
398	94	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengThungSang1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เทศบาลนครขอนแก่น ภาคกิจกรรม
399	94	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengThungSang2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เทศบาลนครขอนแก่น ภาคกิจกรรม
400	94	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengThungSang3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เทศบาลนครขอนแก่น ภาคกิจกรรม
401	94	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengThungSang4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เทศบาลนครขอนแก่น ภาคกิจกรรม
402	95	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SiThan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
403	95	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SiThan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
404	95	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SiThan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
1266	63	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SeeNaNuanCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค See-na-nuan cafe' I สีนานวล คาเฟ่
1267	63	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SeeNaNuanCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค See-na-nuan cafe' I สีนานวล คาเฟ่
1268	63	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SeeNaNuanCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค See-na-nuan cafe' I สีนานวล คาเฟ่
1269	63	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SeeNaNuanCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค See-na-nuan cafe' I สีนานวล คาเฟ่
1423	176	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LittleBox2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Little Box Restaurant & Cafe
1424	176	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LittleBox3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Little Box Restaurant & Cafe
1425	176	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LittleBox4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Little Box Restaurant & Cafe
1273	34	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Samruay1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สำรวยการกิน หมูกระทะชั้น 2
1622	109	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TonTan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตลาดต้นตาล
1623	109	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TonTan4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตลาดต้นตาล
1836	172	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/92Cafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 92Cafe'Wiangkao
1837	172	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/92Cafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 92Cafe'Wiangkao
417	99	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuKaoPhuPhanKhamNationalPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
418	99	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuKaoPhuPhanKhamNationalPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
419	99	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuKaoPhuPhanKhamNationalPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
420	99	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuKaoPhuPhanKhamNationalPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเก้า-ภูพานคำ Phu Kao Phu Phan Kham National Park
1838	172	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/92Cafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 92Cafe'Wiangkao
1274	34	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Samruay2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สำรวยการกิน หมูกระทะชั้น 2
1275	34	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Samruay3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สำรวยการกิน หมูกระทะชั้น 2
1280	85	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Zoo1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
1281	85	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Zoo2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
1282	85	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Zoo3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
1283	85	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Zoo4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนสัตว์ขอนแก่น khonkaen zoo
1288	76	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/AGoongPao1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหาร อ.กุ้งเผา ขอนแก่น
1289	76	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/AGoongPao2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหาร อ.กุ้งเผา ขอนแก่น
1290	76	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/AGoongPao3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหาร อ.กุ้งเผา ขอนแก่น
1291	76	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/AGoongPao4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนอาหาร อ.กุ้งเผา ขอนแก่น
1839	172	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/92Cafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 92Cafe'Wiangkao
1430	192	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MikiiHousemilkcafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mikii House milk cafe'
1431	192	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MikiiHousemilkcafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mikii House milk cafe'
1432	192	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MikiiHousemilkcafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mikii House milk cafe'
433	103	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaewChakkraphat1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสมสุข เล็ก สงวนเงิน
434	103	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaewChakkraphat2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสมสุข เล็ก สงวนเงิน
435	103	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaewChakkraphat3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประสมสุข เล็ก สงวนเงิน
1433	192	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MikiiHousemilkcafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mikii House milk cafe'
1628	20	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TheNuaBuffet1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เดอะนัวหมูกระทะบุฟเฟต์ สาขา ขอนแก่น
1629	20	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TheNuaBuffet2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เดอะนัวหมูกระทะบุฟเฟต์ สาขา ขอนแก่น
1630	20	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TheNuaBuffet3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เดอะนัวหมูกระทะบุฟเฟต์ สาขา ขอนแก่น
1631	20	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/TheNuaBuffet4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เดอะนัวหมูกระทะบุฟเฟต์ สาขา ขอนแก่น
754	100	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuwiangDinosaur1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พิพิธภัณฑ์ไดโนเสาร์ภูเวียง - Phuwiang Dinosaur Museum
755	100	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuwiangDinosaur2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พิพิธภัณฑ์ไดโนเสาร์ภูเวียง - Phuwiang Dinosaur Museum
447	107	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Central1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Central Khonkaen
448	107	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Central2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Central Khonkaen
449	107	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Central3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Central Khonkaen
450	107	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Central4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Central Khonkaen
451	108	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Fairy1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
452	108	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Fairy2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
453	108	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Fairy3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
454	108	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Fairy4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Khon Kaen City : ขอนแก่นซิตี้
756	100	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuwiangDinosaur3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พิพิธภัณฑ์ไดโนเสาร์ภูเวียง - Phuwiang Dinosaur Museum
757	100	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuwiangDinosaur4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พิพิธภัณฑ์ไดโนเสาร์ภูเวียง - Phuwiang Dinosaur Museum
766	158	https://cms.dmpcdn.com/travel/2021/11/14/c325b0e0-4520-11ec-99d2-afc4b19f1d2d_webp_original.jpg	ขอบคุณภาพจาก : siraphat / Shutterstock.com
767	158	https://cms.dmpcdn.com/travel/2021/11/14/c3024a60-4520-11ec-99d2-afc4b19f1d2d_webp_original.jpg	ขอบคุณภาพจาก : siraphat / Shutterstock.com
768	158	https://cms.dmpcdn.com/travel/2021/11/14/c52a5a80-4520-11ec-bd01-93edaaf1f962_webp_original.jpg	ขอบคุณภาพจาก : siraphat / Shutterstock.com
682	147	https://blog.drivehub.co/wp-content/uploads/2024/07/02-3-1024x576.jpg	ขอบคุณรูปภาพจาก Facebook ดูฟาร์มคาเฟ่
1636	36	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SaikoSeafoodGrill1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไซโกะ ทะเลเผา ขอนแก่น
1637	36	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SaikoSeafoodGrill2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไซโกะ ทะเลเผา ขอนแก่น
1638	36	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SaikoSeafoodGrill3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไซโกะ ทะเลเผา ขอนแก่น
1639	36	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SaikoSeafoodGrill4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไซโกะ ทะเลเผา ขอนแก่น
1438	189	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Passcoffeeroaster1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Pass Coffee Roaster
1439	189	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Passcoffeeroaster2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Pass Coffee Roaster
1440	189	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Passcoffeeroaster3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Pass Coffee Roaster
1441	189	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Passcoffeeroaster4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Pass Coffee Roaster
1644	65	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/JokKuayJabTomSenBatQueue1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โจ๊ก ก๋วยจั๊บ ต้มเส้น บัตรคิว
1645	65	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/JokKuayJabTomSenBatQueue2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โจ๊ก ก๋วยจั๊บ ต้มเส้น บัตรคิว
1646	65	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/JokKuayJabTomSenBatQueue3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โจ๊ก ก๋วยจั๊บ ต้มเส้น บัตรคิว
1647	65	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/JokKuayJabTomSenBatQueue4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โจ๊ก ก๋วยจั๊บ ต้มเส้น บัตรคิว
1446	200	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Wancoffeecafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค
1447	200	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Wancoffeecafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค
1448	200	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Wancoffeecafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค
1449	200	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Wancoffeecafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค
1652	83	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NongSamo1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ท่องเที่ยวทาม-หนองสมอ อ.ภูผาม่าน จ.ขอนแก่น
1653	83	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NongSamo2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ท่องเที่ยวทาม-หนองสมอ อ.ภูผาม่าน จ.ขอนแก่น
1654	83	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NongSamo3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ท่องเที่ยวทาม-หนองสมอ อ.ภูผาม่าน จ.ขอนแก่น
491	106	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PertTaiHoKan1.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ ศูนย์บริหารจัดการทรัพย์สิน มหาวิทยาลัยขอนแก่น
492	106	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PertTaiHoKan2.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ ศูนย์บริหารจัดการทรัพย์สิน มหาวิทยาลัยขอนแก่น
493	106	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PertTaiHoKan3.jpg	ขอบคุณรูปภาพจาก: เว็บไซต์ ศูนย์บริหารจัดการทรัพย์สิน มหาวิทยาลัยขอนแก่น
1655	83	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/NongSamo4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ท่องเที่ยวทาม-หนองสมอ อ.ภูผาม่าน จ.ขอนแก่น
1852	161	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%96%E0%B9%89%E0%B8%B3%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%84%E0%B8%B2%E0%B8%A7.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ Khon Kaen City : ขอนแก่นซิตี้  คุณ Paisal Sangiamsri
1853	161	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%96%E0%B9%89%E0%B8%B3%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%84%E0%B8%B2%E0%B8%A701.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ Khon Kaen City : ขอนแก่นซิตี้  คุณ Paisal Sangiamsri
1854	161	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%96%E0%B9%89%E0%B8%B3%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%84%E0%B8%B2%E0%B8%A702.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ Khon Kaen City : ขอนแก่นซิตี้  คุณ Paisal Sangiamsri
1855	161	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%96%E0%B9%89%E0%B8%B3%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%84%E0%B8%B2%E0%B8%A703.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ Khon Kaen City : ขอนแก่นซิตี้  คุณ Paisal Sangiamsri
695	148	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/DongLan2.jpg	ขอบคุณรูปภาพจาก : FB ไปเรื่อย ไปเปื่อย
696	148	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/DongLan3.jpg	ขอบคุณรูปภาพจาก : FB ไปเรื่อย ไปเปื่อย
697	148	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/DongLan4.jpg	ขอบคุณรูปภาพจาก : FB ไปเรื่อย ไปเปื่อย
698	149	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%95%E0%B8%81%E0%B8%95%E0%B8%B2%E0%B8%94%E0%B8%9F%E0%B9%89%E0%B8%B2.jpg?raw=true	ขอบคุณรูปภาพจาก : Tiwasun Oho
699	149	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%95%E0%B8%81%E0%B8%95%E0%B8%B2%E0%B8%94%E0%B8%9F%E0%B9%89%E0%B8%B21.jpg?raw=true	ขอบคุณรูปภาพจาก : Tiwasun Oho
700	149	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%95%E0%B8%81%E0%B8%95%E0%B8%B2%E0%B8%94%E0%B8%9F%E0%B9%89%E0%B8%B23.jpg?raw=true	ขอบคุณรูปภาพจาก : Tiwasun Oho
514	122	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoManKaiJoneSalad1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวมันไก่ โจรสลัด อู้ฟู่ ขอนแก่น
515	122	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoManKaiJoneSalad2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวมันไก่ โจรสลัด อู้ฟู่ ขอนแก่น
516	122	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoManKaiJoneSalad3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวมันไก่ โจรสลัด อู้ฟู่ ขอนแก่น
517	122	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoManKaiJoneSalad4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวมันไก่ โจรสลัด อู้ฟู่ ขอนแก่น
703	151	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%95%E0%B8%81%E0%B8%95%E0%B8%B2%E0%B8%94%E0%B8%97%E0%B8%B4%E0%B8%94%E0%B8%A1%E0%B8%B51.jpg?raw=true	ขอบคุณภาพจาก ไชยณพล โพชะดี
704	151	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%95%E0%B8%81%E0%B8%95%E0%B8%B2%E0%B8%94%E0%B8%97%E0%B8%B4%E0%B8%94%E0%B8%A1%E0%B8%B5.jpg?raw=true	ภาพจากแฟนเพจ: Nussorn Chanathipphitphiboon
705	152	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/ThungSetthi1.jpg	ขอบคุณรูปภาพจาก : FB หูกาง สตอรี่
706	152	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/ThungSetthi2.jpg	ขอบคุณรูปภาพจาก : FB หูกาง สตอรี่
707	152	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/ThungSetthi3.jpg	ขอบคุณรูปภาพจาก : FB หูกาง สตอรี่
1660	125	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnzonNoodlekk1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ก๋วยเตี๋ยวออนซอน ONZON สาขาหลัง มข
1454	134	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/tangtaedekgarden1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตั้งแต่เด็ก การ์เด้น - Tangtaedek Garden
1455	134	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/tangtaedekgarden2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตั้งแต่เด็ก การ์เด้น - Tangtaedek Garden
1456	134	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/tangtaedekgarden3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตั้งแต่เด็ก การ์เด้น - Tangtaedek Garden
1296	104	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatChaiSi1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Kamol Phapoom
1297	104	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatChaiSi2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Kamol Phapoom
1298	104	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatChaiSi3.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Kamol Phapoom
1299	104	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/WatChaiSi4.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Kamol Phapoom
769	160	https://f.ptcdn.info/416/083/000/s9thlh22lufqRE3J7UFRy-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
770	160	https://f.ptcdn.info/416/083/000/s9thlh22lufqRE3J7UFRy-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
771	160	https://f.ptcdn.info/416/083/000/s9thl733mkkdeM9hJsyk-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
772	160	https://f.ptcdn.info/416/083/000/s9thl813haoz9865UMe1g-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
773	160	https://f.ptcdn.info/416/083/000/s9thla13jssC6l6GwsaVW-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
774	160	https://f.ptcdn.info/416/083/000/s9thkgix5qtxZjm7B3lR-o.jpg	ขอบคุณรูปภาพจาก : Pantip หมายเลข 6872732 Travel my wife:เที่ยวตามใจเมีย
538	124	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoSoiMaeArom1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวซอยแม่อารมย์ สาขาชุมแพ
539	124	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoSoiMaeArom2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวซอยแม่อารมย์ สาขาชุมแพ
540	124	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoSoiMaeArom3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวซอยแม่อารมย์ สาขาชุมแพ
541	124	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KhaoSoiMaeArom4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ข้าวซอยแม่อารมย์ สาขาชุมแพ
1661	125	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnzonNoodlekk2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ก๋วยเตี๋ยวออนซอน ONZON สาขาหลัง มข
1662	125	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnzonNoodlekk3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ก๋วยเตี๋ยวออนซอน ONZON สาขาหลัง มข
1663	125	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OnzonNoodlekk4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ก๋วยเตี๋ยวออนซอน ONZON สาขาหลัง มข
1304	102	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhraPhutthabatPhuPhanKham1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นักรบตะวันออก
1305	102	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhraPhutthabatPhuPhanKham2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นักรบตะวันออก
1457	134	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/tangtaedekgarden4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ตั้งแต่เด็ก การ์เด้น - Tangtaedek Garden
546	77	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MiniMalSeafood1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารทะเล ซีฟู้ด ขอนแก่น MiniMal Seafood by Ranjana
547	77	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MiniMalSeafood2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารทะเล ซีฟู้ด ขอนแก่น MiniMal Seafood by Ranjana
548	77	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MiniMalSeafood3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารทะเล ซีฟู้ด ขอนแก่น MiniMal Seafood by Ranjana
549	77	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MiniMalSeafood4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารทะเล ซีฟู้ด ขอนแก่น MiniMal Seafood by Ranjana
550	128	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DNNamnueng1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DN แหนมเนือง ขอนแก่น
551	128	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DNNamnueng2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DN แหนมเนือง ขอนแก่น
552	128	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DNNamnueng3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DN แหนมเนือง ขอนแก่น
553	128	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DNNamnueng4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค DN แหนมเนือง ขอนแก่น
1306	102	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhraPhutthabatPhuPhanKham3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นักรบตะวันออก
717	150	https://img.wongnai.com/p/1920x0/2019/08/08/0e20c4cc644944169b706d7c69e7beea.jpg	ขอบคุณภาพจาก : Bae' Story
718	150	https://img.wongnai.com/p/1920x0/2018/06/11/1e393018a3cf436480caf948cda46233.jpg	ขอบคุณภาพจาก : Suwatchai
1307	102	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhraPhutthabatPhuPhanKham4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค นักรบตะวันออก
1668	139	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SomTamMakokZaap1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น
1669	139	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SomTamMakokZaap2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น
1670	139	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SomTamMakokZaap3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น
1462	117	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrachaSamosorn1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประชาสโมสร
1463	117	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrachaSamosorn2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประชาสโมสร
786	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A702.jpg?raw=true	ขอบคุณรูปภาพจาก : ประชาสัมพันธ์ กรมอุทยานแห่งชาติ สัตว์ป่า และพันธุ์พืช
787	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A703.jpg?raw=true	ขอบคุณรูปภาพจาก : ประชาสัมพันธ์ กรมอุทยานแห่งชาติ สัตว์ป่า และพันธุ์พืช
788	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A709.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ผมชอบ"เที่ยว"ครับแม่ 
1312	60	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SriruenPadThai1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ศรีเรือนผัดไทยไข่เป็ด พิษณุโลก
1313	60	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SriruenPadThai2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ศรีเรือนผัดไทยไข่เป็ด พิษณุโลก
1314	60	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SriruenPadThai3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ศรีเรือนผัดไทยไข่เป็ด พิษณุโลก
1671	139	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SomTamMakokZaap4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น
719	153	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/KhamKaen1.jpg	ขอบคุณภาพจาก : FB วัดพระธาตุขามแก่น
720	153	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/KhamKaen2.jpg	ขอบคุณภาพจาก : FB วัดพระธาตุขามแก่น
721	153	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/KhamKaen3.jpg	ขอบคุณภาพจาก : FB วัดพระธาตุขามแก่น
722	155	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A7%E0%B8%B1%E0%B8%94%E0%B8%9B%E0%B9%88%E0%B8%B2%E0%B9%81%E0%B8%AA%E0%B8%87%E0%B8%AD%E0%B8%A3%E0%B8%B8%E0%B8%93.jpg?raw=true	ขอบคุณภาพจาก : เพจ ขอนแก่น พาเที่ยว
1676	118	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/smilekhonkaen1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Smilewatersidekhonkaen อาหารอร่อย บรรยากาศดีๆ ที่ สมายล์ ขอนแก่น
585	86	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Exotic1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เที่ยวขอนแก่น Khonkaen Exotic Pets - สนามบินขอนแก่น
586	86	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Exotic2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เที่ยวขอนแก่น Khonkaen Exotic Pets - สนามบินขอนแก่น
587	86	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Exotic3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เที่ยวขอนแก่น Khonkaen Exotic Pets - สนามบินขอนแก่น
588	86	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Exotic4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เที่ยวขอนแก่น Khonkaen Exotic Pets - สนามบินขอนแก่น
1677	118	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/smilekhonkaen2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Smilewatersidekhonkaen อาหารอร่อย บรรยากาศดีๆ ที่ สมายล์ ขอนแก่น
1678	118	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/smilekhonkaen3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Smilewatersidekhonkaen อาหารอร่อย บรรยากาศดีๆ ที่ สมายล์ ขอนแก่น
1679	118	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/smilekhonkaen4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Smilewatersidekhonkaen อาหารอร่อย บรรยากาศดีๆ ที่ สมายล์ ขอนแก่น
723	155	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A7%E0%B8%B1%E0%B8%94%E0%B8%9B%E0%B9%88%E0%B8%B2%E0%B9%81%E0%B8%AA%E0%B8%87%E0%B8%AD%E0%B8%A3%E0%B8%B8%E0%B8%9301.jpg?raw=true	ขอบคุณภาพจาก : เพจ ขอนแก่น พาเที่ยว
724	155	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A7%E0%B8%B1%E0%B8%94%E0%B8%9B%E0%B9%88%E0%B8%B2%E0%B9%81%E0%B8%AA%E0%B8%87%E0%B8%AD%E0%B8%A3%E0%B8%B8%E0%B8%9302.jpg?raw=true	ขอบคุณภาพจาก : เพจ ขอนแก่น พาเที่ยว
789	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A705.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ผมชอบ"เที่ยว"ครับแม่ 
790	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A706.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ผมชอบ"เที่ยว"ครับแม่ 
791	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A707.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ผมชอบ"เที่ยว"ครับแม่ 
792	162	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%99%E0%B8%B1%E0%B8%9A%E0%B8%94%E0%B8%B2%E0%B8%A708.jpg?raw=true	ขอบคุณรูปภาพจาก : เพจ ผมชอบ"เที่ยว"ครับแม่ 
1315	60	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SriruenPadThai4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ศรีเรือนผัดไทยไข่เป็ด พิษณุโลก
1464	117	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrachaSamosorn3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประชาสโมสร
1465	117	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PrachaSamosorn4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ประชาสโมสร
1684	67	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kean1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค แก่น I KAEN
1685	67	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kean2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค แก่น I KAEN
1686	67	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kean3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค แก่น I KAEN
1687	67	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Kean4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค แก่น I KAEN
1691	72	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangRabeabKhaoSuanKwang1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างระเบียบ เขาสวนกวาง จ.ขอนแก่น
1692	72	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangRabeabKhaoSuanKwang2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างระเบียบ เขาสวนกวาง จ.ขอนแก่น
1693	72	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangRabeabKhaoSuanKwang3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ไก่ย่างระเบียบ เขาสวนกวาง จ.ขอนแก่น
1320	32	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/pbmookrata1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ลัคกี้หมูกระทะ สาขากังสดาล
1321	32	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/pbmookrata2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ลัคกี้หมูกระทะ สาขากังสดาล
1322	32	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/pbmookrata3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ลัคกี้หมูกระทะ สาขากังสดาล
1470	132	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/halongbaykk1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮาลองเบย์ อาหารเวียดนาม
1471	132	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/halongbaykk2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮาลองเบย์ อาหารเวียดนาม
1472	132	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/halongbaykk3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮาลองเบย์ อาหารเวียดนาม
1473	132	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/halongbaykk4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฮาลองเบย์ อาหารเวียดนาม
1478	131	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MoodsandGood1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค House of Moods & Good Everyday
1479	131	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MoodsandGood2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค House of Moods & Good Everyday
1480	131	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MoodsandGood3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค House of Moods & Good Everyday
1697	69	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWanna1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
1323	32	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/pbmookrata4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ลัคกี้หมูกระทะ สาขากังสดาล
1481	131	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MoodsandGood4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค House of Moods & Good Everyday
1326	58	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LengYentafo1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Muy Thitikarn
1485	66	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaoLaoXiangJi1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Winly Winly
1486	66	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaoLaoXiangJi2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Winly Winly
1487	66	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/GaoLaoXiangJi3.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Winly Winly
1327	58	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/LengYentafo2.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Muy Thitikarn
1330	105	https://cms.dmpcdn.com/travel/2021/08/08/4f588aa0-f810-11eb-aeef-3f184bb3ec47_webp_original.jpg	ขอบคุณรูปภาพจาก : kwanchai / Shutterstock.com
1331	105	https://cms.dmpcdn.com/travel/2021/08/08/4f581570-f810-11eb-a070-f339bc37f1a9_webp_original.jpg	ขอบคุณรูปภาพจาก : kwanchai / Shutterstock.com
1492	113	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KangHanNam1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านกังหันน้ำ
1493	113	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KangHanNam2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านกังหันน้ำ
1494	113	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KangHanNam3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านกังหันน้ำ
1495	113	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KangHanNam4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านกังหันน้ำ
1499	43	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Share1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านแชร์ - Share the good vibes
1500	43	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Share2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านแชร์ - Share the good vibes
1501	43	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Share3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านแชร์ - Share the good vibes
1506	23	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Mingmooyang1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มิ่งหมูย่างเกาหลี Mingmooyangkawlee
1507	23	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Mingmooyang2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มิ่งหมูย่างเกาหลี Mingmooyangkawlee
1508	23	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Mingmooyang3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มิ่งหมูย่างเกาหลี Mingmooyangkawlee
1509	23	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Mingmooyang4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค มิ่งหมูย่างเกาหลี Mingmooyangkawlee
1513	62	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ManaPhochanakan1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านมานะโภชนา ขอนแก่น Manapochana khonkan
1514	62	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ManaPhochanakan2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านมานะโภชนา ขอนแก่น Manapochana khonkan
1515	62	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/ManaPhochanakan3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านมานะโภชนา ขอนแก่น Manapochana khonkan
1520	35	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/FahSangMooKratha1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฟ้าสาง หมูกระทะ ขอนแก่น
1521	35	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/FahSangMooKratha2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฟ้าสาง หมูกระทะ ขอนแก่น
1522	35	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/FahSangMooKratha3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฟ้าสาง หมูกระทะ ขอนแก่น
968	198	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SuanRukkachartKhaoSuanKwang1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนรุกขชาติเขาสวนกวาง จังหวัดขอนแก่น
969	198	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SuanRukkachartKhaoSuanKwang2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนรุกขชาติเขาสวนกวาง จังหวัดขอนแก่น
970	198	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SuanRukkachartKhaoSuanKwang3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนรุกขชาติเขาสวนกวาง จังหวัดขอนแก่น
971	198	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SuanRukkachartKhaoSuanKwang4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค สวนรุกขชาติเขาสวนกวาง จังหวัดขอนแก่น
993	9	https://raw.githubusercontent.com/cholthicha61/Picture/main/The%20Garage%20Coffee%20TIME.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค The Garage Coffee TIME
994	9	https://github.com/cholthicha61/Picture/blob/main/The%20Garage%20Coffee%20TIME01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค The Garage Coffee TIME
995	9	https://github.com/cholthicha61/Picture/blob/main/The%20Garage%20Coffee%20TIME02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค The Garage Coffee TIME
996	9	https://github.com/cholthicha61/Picture/blob/main/The%20Garage%20Coffee%20TIME03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค The Garage Coffee TIME
997	16	https://github.com/cholthicha61/Picture/blob/main/Snim%20Coffee%20Khonkaen04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Snim Coffee Khonkaen
998	16	https://github.com/cholthicha61/Picture/blob/main/Snim%20Coffee%20Khonkaen03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Snim Coffee Khonkaen
999	16	https://github.com/cholthicha61/Picture/blob/main/Snim%20Coffee%20Khonkaen01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Snim Coffee Khonkaen
1000	16	https://github.com/cholthicha61/Picture/blob/main/Snim%20Coffee%20Khonkaen.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Snim Coffee Khonkaen
1001	16	https://github.com/cholthicha61/Picture/blob/main/Snim%20Coffee%20Khonkaen02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Snim Coffee Khonkaen
1002	14	https://github.com/cholthicha61/Picture/blob/main/Refill%20Coffee.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Refill Coffee
1003	14	https://github.com/cholthicha61/Picture/blob/main/Refill%20Coffee04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Refill Coffee
1004	14	https://github.com/cholthicha61/Picture/blob/main/Refill%20Coffee03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Refill Coffee
1005	14	https://github.com/cholthicha61/Picture/blob/main/Refill%20Coffee02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Refill Coffee
1006	14	https://github.com/cholthicha61/Picture/blob/main/Refill%20Coffee05.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Refill Coffee
1007	7	https://github.com/cholthicha61/Picture/blob/main/Punpang.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Punpang
1008	7	https://github.com/cholthicha61/Picture/blob/main/Punpang01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Punpang
1009	7	https://github.com/cholthicha61/Picture/blob/main/Punpang02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Punpang
1010	7	https://github.com/cholthicha61/Picture/blob/main/Punpang04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Punpang
1011	7	https://github.com/cholthicha61/Picture/blob/main/Punpang03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Punpang
1012	17	https://github.com/cholthicha61/Picture/blob/main/Nap%E2%80%99s%20Coffee%20x%20Khonkaen03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Nap’s Coffee x Khonkaen
1013	17	https://github.com/cholthicha61/Picture/blob/main/Nap%E2%80%99s%20Coffee%20x%20Khonkaen02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Nap’s Coffee x Khonkaen
1014	17	https://github.com/cholthicha61/Picture/blob/main/Nap%E2%80%99s%20Coffee%20x%20Khonkaen04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Nap’s Coffee x Khonkaen
1015	17	https://github.com/cholthicha61/Picture/blob/main/Nap%E2%80%99s%20Coffee%20x%20Khonkaen05.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Nap’s Coffee x Khonkaen
1016	17	https://github.com/cholthicha61/Picture/blob/main/Nap%E2%80%99s%20Coffee%20x%20Khonkaen01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Nap’s Coffee x Khonkaen
1021	13	https://github.com/cholthicha61/Picture/blob/main/Kyoto%20Shi%20Cafe.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kyoto Shi Cafe
1022	13	https://github.com/cholthicha61/Picture/blob/main/Kyoto%20Shi%20Cafe04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kyoto Shi Cafe
1023	13	https://github.com/cholthicha61/Picture/blob/main/Kyoto%20Shi%20Cafe02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kyoto Shi Cafe
1024	13	https://github.com/cholthicha61/Picture/blob/main/Kyoto%20Shi%20Cafe03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kyoto Shi Cafe
1025	11	https://github.com/cholthicha61/Picture/blob/main/Mali%20cakery.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mali cakery
1026	11	https://github.com/cholthicha61/Picture/blob/main/Mali%20cakery01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mali cakery
1027	11	https://github.com/cholthicha61/Picture/blob/main/Mali%20cakery02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mali cakery
1028	11	https://github.com/cholthicha61/Picture/blob/main/Mali%20cakery03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Mali cakery
1029	64	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/VaccaItalian4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Vacca Italian Restaurant
1030	64	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/VaccaItalian2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Vacca Italian Restaurant
1031	64	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/VaccaItalian3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Vacca Italian Restaurant
1032	64	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/VaccaItalian1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Vacca Italian Restaurant
1523	35	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/FahSangMooKratha4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ฟ้าสาง หมูกระทะ ขอนแก่น
1698	69	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWanna2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
1699	69	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KaiYangWanna3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค วรรณไก่ย่างเขาสวนกวาง
1039	18	https://github.com/cholthicha61/Picture/blob/main/Kaen%20Ground05.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1040	18	https://github.com/cholthicha61/Picture/blob/main/Kaen%20Ground01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1041	18	https://github.com/cholthicha61/Picture/blob/main/Kaen%20Ground04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1042	18	https://github.com/cholthicha61/Picture/blob/main/Kaen%20Ground03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1043	18	https://github.com/cholthicha61/Picture/blob/main/Kaen%20Ground02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1044	18	https://raw.githubusercontent.com/cholthicha61/Picture/main/Kaen%20Ground.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Kaen Ground
1045	8	https://github.com/cholthicha61/Picture/blob/main/Brew%20Planet.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Brew Planet
1046	8	https://github.com/cholthicha61/Picture/blob/main/Brew%20Planet01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Brew Planet
1047	8	https://github.com/cholthicha61/Picture/blob/main/Brew%20Planet02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Brew Planet
1048	8	https://github.com/cholthicha61/Picture/blob/main/Brew%20Planet03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Brew Planet
1049	8	https://github.com/cholthicha61/Picture/blob/main/Brew%20Planet04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Brew Planet
1050	12	https://github.com/cholthicha61/Picture/blob/main/Cafe%CC%81%20de%20Paris01.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Café de Paris
1051	12	https://github.com/cholthicha61/Picture/blob/main/Cafe%CC%81%20de%20Paris02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Café de Paris
1052	12	https://github.com/cholthicha61/Picture/blob/main/Cafe%CC%81%20de%20Paris.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Café de Paris
1053	12	https://github.com/cholthicha61/Picture/blob/main/Cafe%CC%81%20de%20Paris03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Café de Paris
1054	15	https://raw.githubusercontent.com/cholthicha61/Picture/main/11AM%20Cafe%20and%20Space.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 11AM Cafe and Space
1055	15	https://github.com/cholthicha61/Picture/blob/main/11AM%20Cafe%20and%20Spac04.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 11AM Cafe and Space
1056	15	https://github.com/cholthicha61/Picture/blob/main/11AM%20Cafe%20and%20Spac03.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 11AM Cafe and Space
1057	15	https://github.com/cholthicha61/Picture/blob/main/11AM%20Cafe%20and%20Spac02.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 11AM Cafe and Space
1058	15	https://github.com/cholthicha61/Picture/blob/main/11AM%20Cafe%20and%20Space.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค 11AM Cafe and Space
1059	44	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Seasons27_1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Seasons 27
1060	44	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Seasons27_2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Seasons 27
1061	44	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Seasons27_3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Seasons 27
1062	44	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/Seasons27_4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Seasons 27
1063	31	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SBarBQ1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค รีวิวขอนแก่น
1064	31	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SBarBQ2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค รีวิวขอนแก่น
1065	31	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SBarBQ3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค รีวิวขอนแก่น
1066	31	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/SBarBQ4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค รีวิวขอนแก่น
1067	21	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DragonGrillBBQ1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dragon Grill BBQ
1068	21	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DragonGrillBBQ2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dragon Grill BBQ
1069	21	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DragonGrillBBQ3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dragon Grill BBQ
1070	21	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/DragonGrillBBQ4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Dragon Grill BBQ
1071	29	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MrPiao1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
1072	29	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MrPiao2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
1073	29	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/MrPiao3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Food Fast Fin #ขอนแก่นแดกไรดี
1074	96	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManNationalPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูผาม่าน - Phuphaman National Park
1075	96	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManNationalPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูผาม่าน - Phuphaman National Park
1076	96	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManNationalPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูผาม่าน - Phuphaman National Park
1077	96	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuPhaManNationalPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูผาม่าน - Phuphaman National Park
1528	33	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PPang1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พี่แป้งหมูกระทะ & ชาบู บุฟเฟ่ต์ สาขาหลังมข.
1082	25	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OhMyGonByOporBuffet1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โอมายก้อน by โอปอ
1083	25	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OhMyGonByOporBuffet2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โอมายก้อน by โอปอ
1084	25	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OhMyGonByOporBuffet3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โอมายก้อน by โอปอ
1085	25	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/OhMyGonByOporBuffet4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค โอมายก้อน by โอปอ
1086	97	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuWiangNationalPark1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
1087	97	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuWiangNationalPark2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
1088	97	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuWiangNationalPark3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
1089	97	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PhuWiangNationalPark4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค อุทยานแห่งชาติภูเวียง - Phu Wiang National Park
1529	33	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PPang2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พี่แป้งหมูกระทะ & ชาบู บุฟเฟ่ต์ สาขาหลังมข.
1530	33	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PPang3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พี่แป้งหมูกระทะ & ชาบู บุฟเฟ่ต์ สาขาหลังมข.
1531	33	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PPang4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค พี่แป้งหมูกระทะ & ชาบู บุฟเฟ่ต์ สาขาหลังมข.
1704	52	https://github.com/cholthicha61/Picture/blob/main/%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B9%84%E0%B8%9E%E0%B8%A3.jpg?raw=true	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารประไพรสนามบิน ขอนแก่น
1705	52	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PraPrai2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารประไพรสนามบิน ขอนแก่น
1706	52	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PraPrai3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารประไพรสนามบิน ขอนแก่น
1707	52	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/PraPrai4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค ร้านอาหารประไพรสนามบิน ขอนแก่น
1712	93	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengKaenNakhon1.jpg	ขอบคุณรูปภาพจาก: เฟสบุ๊ค Korkiat Aksarachaiyapruk
1102	170	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiangnaCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียงนา - Kiangna Cafe
1103	170	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiangnaCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียงนา - Kiangna Cafe
1104	170	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiangnaCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียงนา - Kiangna Cafe
1105	170	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiangnaCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียงนา - Kiangna Cafe
1713	93	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengKaenNakhon2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Anywhere that i go
1714	93	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengKaenNakhon3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Anywhere that i go
1715	93	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/BuengKaenNakhon4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค Anywhere that i go
1110	165	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiamNa1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียมนา เตี๋ยวหางวัวตุ๋น
1111	165	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiamNa2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียมนา เตี๋ยวหางวัวตุ๋น
1112	165	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiamNa3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียมนา เตี๋ยวหางวัวตุ๋น
1113	165	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/KiamNa4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เคียมนา เตี๋ยวหางวัวตุ๋น
1126	191	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/CherryCafe1.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เชอรี่คาเฟ่
1127	191	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/CherryCafe2.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เชอรี่คาเฟ่
1128	191	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/CherryCafe3.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เชอรี่คาเฟ่
1129	191	https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image/CherryCafe4.jpg	ขอบคุณรูปภาพจาก: เพจเฟสบุ๊ค เชอรี่คาเฟ่
\.


--
-- TOC entry 3453 (class 0 OID 31653)
-- Dependencies: 222
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.places (id, name, description, admission_fee, address, contact_link, opening_hours, created_at, latitude, longitude) FROM stdin;
12	Café de Paris	คาเฟ่สไตล์ปารีสที่มีครัวซองต์อร่อยและพื้นที่นั่งสบาย	\N	888 21-23 ถนน เหล่านาดี ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=513348535846665	เปิดทำการทุกวัน เวลา 08:00–17:00 น.	2025-02-21 19:47:13.724093	16.412456317767017	102.81270567458556
5	Lapin Pâtisserie	คาเฟ่สไตล์ฝรั่งเศสที่ตกแต่งด้วยโทนสีขาวและวัสดุไม้ ให้ความรู้สึกอบอุ่น พร้อมขนมหวานและเครื่องดื่มพรีเมียม	\N	104/55, ขอนแก่น 40000	https://www.facebook.com/profile.php?id=101225685326663	เปิดทำการเวลา 09:00–17:30 น. (ปิดวันจันทร์)	2025-02-21 19:44:25.09155	16.44993683679121	102.83179677458608
176	Little Box Restaurant & Cafe	บรรยากาศดี ได้วิวทุ่งนาและภูเขา (มาช่วงต้นกุมภาพันธ์) มีบริการรถไฟจิ๋วและเรือถีบด้วย เหมาะแก่ครอบครับ มานั่งกินกาแฟและขนม ถือว่าอยู่ในมาตรฐาน ส่วนอาหารไม่ได้สั่งมาทาน แต่ดูแล้วในเมนู ค่อยข้างเยอะ น่าสนใจ เหมาะสำหรับสายชิวมานั่งเล่นพักผ่อนหย่อนกาย	\N	41 ม.14 ต.บ้านดง อ.อุบลรัตน์ จ.ขอนแก่น	https://www.facebook.com/littleboxcafekhonkaen	เปิดทำการทุกวัน เวลา 09:00 - 20:30 น.	2025-03-08 15:51:51.009988	16.783202285310768	102.62942695055901
6	Fellow Fellow Cafe	คาเฟ่มินิมอลที่โดดเด่นเรื่องโดนัทโฮมเมดและเครื่องดื่มสุดพิเศษ	\N	141 117 ซอย อดุลยาราม 1/5 ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=101332974979515	เปิดทำการเวลา 10:00–18:00 น. (ปิดวันพฤหัสบดี)	2025-02-21 19:47:13.724093	16.46255	102.8268
11	Mali cakery	คาเฟ่บ้านไม้ 2 ชั้น ที่มีขนมเค้กโฮมเมดและชาเบลนด์	\N	ศิลา 488 หมู่ 21 ต.ศิลา ซอยร่วมมิตร 2 ขอนแก่น 40000	https://www.facebook.com/profile.php?id=1812270022388198	เปิดทำการทุกวัน เวลา10:30–19:00 น.	2025-02-21 19:47:13.724093	16.46251	102.8365
9	The Garage Coffee TIME	คาเฟ่แนวชิค ๆ ที่ตั้งอยู่ในร้านล้างรถ	\N	ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=1446546785662192	เปิดทำการทุกวัน เวลา 09:00–19:00 น.	2025-02-21 19:47:13.724093	16.4346	102.8259
7	Punpang	คาเฟ่ขนมโฮมเมดที่อบสดใหม่ทุกวัน กับบรรยากาศน่ารัก	\N	577 ถนน บ้านกอก40 ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=338394116247824	เปิดทำการ เวลา11:00–20:00 น. (ปิดวันอังคาร)	2025-02-21 19:47:13.724093	16.4266	102.8005
8	Brew Planet	คาเฟ่สำหรับคนรักกาแฟ มีเมนูหลากหลายและมุมทำงาน	\N	30 เทพผาสุก ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=110795519075823	เปิดทำการทุกวัน เวลา 09:00–18:00 น.	2025-02-21 19:47:13.724093	16.443451894879658	102.82734626904868
68	ตำกระเทย สาเกต	ที่นี่เสิร์ฟอาหารอีสานรสชาติจัดจ้าน แนะนำให้ลอง “โคตรเหลา” ที่ใส่อาหารทะเลรวมมิตรมาแบบไม่หวงเครื่อง ปรุงรสด้วยน้ำปลาร้าทำเอง อ่อมไก่บ้านใส่วุ้นเส้นและปลาส้มทอดเป็นอีกสองเมนูที่ไม่ควรพลาด		ถ.กลางเมือง ต.ในเมือง อ.เมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=111266213805663	เปิดทำการทุกวัน เวลา 10:30 - 22:00 น.	2025-02-26 20:03:38.571906	16.45191672801584	102.78468929788393
13	Kyoto Shi Cafe	คาเฟ่สไตล์ญี่ปุ่นในขอนแก่น มีมุมถ่ายรูปที่ให้ฟีลญี่ปุ่นสุดๆ พร้อมเสิร์ฟโดนัทโฮมเมดและ Soft Cream แสนอร่อย		ถ.รอบบึงแก่นนคร ฝั่งวัดหนองแวง ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=120444900976633	เปิดทำการทุกวัน เวลา 09:00 AM - 07:00 PM	2025-02-21 19:47:13.724093	16.408864709296157	102.83561580691138
18	Kaen Ground	คาเฟ่โมเดิร์นอีสาน ตั้งอยู่ในโรงแรมแอดลิบ ขอนแก่น พร้อมเสิร์ฟเมนูเครื่องดื่มและครัวซองต์โฮมเมด		ชั้น G โรงแรมแอดลิบ ขอนแก่น 999 ถ.ศรีจันทร์ ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100589996205059	เปิดทำการทุกวัน เวลา 07:00 AM - 09:00 PM	2025-02-21 19:47:13.724093	16.430010263965602	102.83229427089427
15	11AM Cafe and Space	คาเฟ่มินิมอลสไตล์เกาหลี มีหลายโซนให้เลือกนั่ง พร้อมเครื่องดื่มและเบเกอรีโฮมเมดสุดละมุน		185/41 ม.16 ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=107901014294541	เปิดทำการทุกวัน เวลา 09:00 AM - 05:30 PM	2025-02-21 19:47:13.724093	16.45415628408679	102.8216150402137
16	Snim Coffee Khonkaen	คาเฟ่คอนเซ็ปต์เรโทรคลาสสิก เสิร์ฟกาแฟที่มีเอกลักษณ์และเครื่องดื่มหลากหลายกว่า 40 เมนู		ถ.หน้าเมือง ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น (ข้างบขส.เก่า)	https://www.facebook.com/profile.php?id=114530985033052	เปิดทำการทุกวัน เวลา 08:00 AM - 05:00 PM	2025-02-21 19:47:13.724093	16.439950466896867	102.83468435186242
14	Refill Coffee	คาเฟ่สไตล์อินดัสเทรียล ลอฟท์ คุมโทนเท่ๆ พร้อมเมนูกาแฟสร้างสรรค์ที่ใส่ใจทั้งรสชาติและดีไซน์		406 ม.17 ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=108620894718936	เปิดทำการทุกวัน เวลา 09:00 AM - 05:30 PM	2025-02-21 19:47:13.724093	16.42079183005767	102.82260239972919
17	Nap’s Coffee x Khonkaen	คาเฟ่ที่ให้ฟีลทะเลสุดชิลล์ เสิร์ฟเมนูกาแฟหลากหลาย รวมถึงเมล็ดกาแฟจากปางขอน		ตลาด 62 บล็อก 157/89 – 91 ม.16 ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=106595165117055	เปิดทำการทุกวัน เวลา 07:00 AM - 04:00 PM	2025-02-21 19:47:13.724093	16.456608296308506	102.82246585001685
35	ฟ้าสางหมูกระทะ	ร้านหมูกระทะเอาใจคนนอนดึก เนื้อหมูของร้านนี้ไม่แช่น้ำหมักหมู เหมาะสำหรับคนชอบรับประทานเนื้อแบบแห้ง ๆ และทำให้เวลาย่างกระทะจะไหม้ช้า ได้รสชาติของเนื้อหมูแบบเต็ม ๆ เมนูน่าสั่งคือชุดหมู+ซีฟู้ด เอาใจคนชอบอาหารทะเล น้ำจิ้มของร้านนี้มี 2 สูตร ได้แก่ น้ำจิ้มหมูกระทะแบบหวาน และน้ำจิ้มซีฟู้ดรสเปรี้ยวนิด ๆ 	ชุดเล็ก 149 บาท ชุดกลาง 299 บาท ชุดใหญ่ 399 บาท	396 ถ.รถไฟ ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100055149885556	เปิดทำการทุกวัน 20.00 – 04.30 น.	2025-02-26 18:30:51.29058	16.42094083510613	102.82426019788336
22	ทอมมี่ หมูเกาหลี	ร้านหมูกระทะเตาถ่านแบบดั้งเดิมแบบที่เคยโด่งดังในอดีต หมักหมูได้นุ่ม มีรสชาติเฉพาะตัว เลือกสั่งได้ทั้งเนื้อหมูและเนื้อวัว ผักสดกรอบ น้ำซุปกลมกล่อม บริการรวดเร็ว ทีเด็ดคือน้ำจิ้มที่อร่อยมากซึ่งมี 2 แบบ ได้แก่ น้ำจิ้มซอสหมูกระทะและน้ำจิ้มสูตรเด็ดของร้าน ที่มีลักษณะคล้ายกับน้ำจิ้มซีฟู้ด ให้รสชาติเปรี้ยวอมหวานและเผ็ดนิด ๆ จากรสกระเทียมดอง ทำให้น้ำจิ้มสไตล์ร้านทอมมี่เป็นเอกลักษณ์ไม่เหมือนใคร	110 บาท / ชุด	151 ม.3 ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100046608234546	เปิดทำการเวลา 15.30 – 23.30 น.	2025-02-26 18:30:51.29058	16.489037499325484	102.82552294390587
201	วรรณไก่ย่างเขาสวนกวาง	ต้นตำรับไก่ย่างเขาสวนกวางแท้เปิดขายมานานกว่า50ปีผลิตและจัดจำหน่ายไก่ย่างเขาสวนกวางแพ็คสูญญากาศเจ้าแรก ไก่ย่างอร่อย ย่างสุกกำลังดี ไม่แห้ง น้ำจิ้มหวาน เข้ากันดี ส้มตำรสชาติจัดจ้าน ปลาร้านัวกำลังดี ส่วนเมนูอื่นๆก็ใช้ได้ อาหารออกเร็ว รอไม่นาน บรรยากาศร้านดี โปร่งโล่ง สะดวกสบาย ไม่ร้อน มีโต๊ะสำหรับรองรับลูกค้าเยอะ เจ้าของร้านอัธยาศัยดี ราคาไม่แพง ไก่ย่างเขาสวนกวางต้องร้านนี้เลย	\N	172 วรรณไก่ย่าง ตำบลคำม่วง อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/wankaiyang	เปิดทำการทุกวัน 7:00–17:00 น.	2025-03-08 16:04:13.161802	16.853763908204858	102.85945775401869
175	เขื่อนอุบลรัตน์	เขื่อนอุบลรัตน์ เป็นเขื่อนอเนกประสงค์ขนาดใหญ่ในจังหวัดขอนแก่น โอบล้อมด้วยทิวทัศน์สวยงาม เหมาะสำหรับพักผ่อน ชมพระอาทิตย์ตก ล่องเรือ ตกปลา และทานอาหารริมเขื่อน ใกล้กันมี ศาลเจ้าพ่อหลักเมือง และ อุทยานแห่งชาติน้ำพอง ให้เที่ยวชม เป็นทั้งแหล่งท่องเที่ยวและพลังงานสำคัญของภาคอีสาน	\N	ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	\N	เปิดทำการทุกวัน เวลา 7:00–20:00 น.	2025-03-08 15:51:51.009988	16.7025	102.6336
26	คิมหมูกระทะ กังสดาล	ร้านหมูกระทะแบบเตาถ่านสไตล์ดั้งเดิม มีสูตรเด็ดหมักหมูด้วยงาขาวทำให้เนื้อนุ่ม รสชาติดี เมื่อย่างบนกระทะเตาถ่านยิ่งได้กลิ่นหอมน่ารับประทาน	144 บาท / ชุด	140/312 ซอยอดุลยาราม 7 ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100057161631881	เปิดทำการเวลา 16.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.461901209114504	102.8250057941924
36	ไซโกะ ทะเลเผา	พูดชื่อร้านแล้ว ก็รู้ได้เลยว่าอาหารซีฟู้ดต้องมีเน้น ๆ แน่นอน ร้านไซโกะโดดเด่นมากเรื่องอาหารทะเลที่หลากหลาย อาทิ กุ้ง หอย ปู ปลาหมึก หอยแครง และน้ำจิ้มซีฟู้ดที่บอกได้เลยว่าจัดจ้านในย่านบึงหนองโคตร	บุฟเฟต์ 299 บาท ไม่รวมเครื่องดื่ม	314 ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100064282264386	เปิดทำการทุกวัน เวลา 17.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.434571451320714	102.81085284205916
195	ฮักผาม่าน	คาเฟ่และร้านอาหารวิวภูเขาสุดอลังการในอำเภอภูผาม่าน ขอนแก่น บรรยากาศกว้างขวาง เหมาะสำหรับนั่งชิลล์ ทานอาหาร จัดปาร์ตี้ หรืออีเวนต์พิเศษ ท่ามกลางธรรมชาติสุดโรแมนติก	\N	ฮักผาม่าน ตำบลภูผาม่าน อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/hugphaman	เปิดทำการทุกวัน เวลา 10:00–22:00 น.	2025-03-08 15:58:19.919751	16.6643	101.9139
159	โสกผีดิบ	🌲 ป่าโสกผีดิบ หินล้านปี ธรรมชาติสร้างสรรค์\n🕯️ ตำนานหลอนเสียงร้องไห้ทุกวันพระ\n🧙‍♂️ พิธีบวงสรวงเจ้าป่า สืบทอดความเชื่อ\n📜 เรื่องเล่าขนหัวลุก โรคระบาดทิ้งร่างไร้พิธี\n🏞️ ที่ตั้งแหล่งท่องเที่ยว บ้านหนองบัวน้อย อ.พล\nโสกผีดิบเป็นแหล่งธรณีวิทยาที่ได้รับการตรวจสอบจากกรมทรัพยากรธรณี พบว่าประกอบไปด้วยหินตะกอนที่มีอายุยาวนานกว่า 65.5 ล้านปีในช่วงยุคครีเทเซียสถึงเทอร์เชียรีตอนต้น\n\nอ่านต่อได้ที่นี้ https://www.khonkaenlink.info/read/862443/	เข้าชมฟรี	บ้านหนองบัวน้อย หมู่ 3 ตำบลโสกนกเต็น อำเภอพล จังหวัดขอนแก่น	\N	เปิดให้เข้าชม: ทุกวัน\t(ยังไม่ทราบเวลาทำการแน่ชัด )	2025-03-07 17:10:16.927804	15.832821781139172	102.69127319418341
30	บุญดี หมูกระทะ	ร้านหมูกระทะคุณภาพราคามิตรภาพ เนื้อหมูหั่นหนา เครื่องในและอาหารทะเลสดคุณภาพดี ที่สำคัญหมักเนื้อวัวและเนื้อหมูได้นุ่มอร่อยกลมกล่อมมาก เสิร์ฟเป็นชุดพร้อมกับชุดผักสดสะอาด ให้ปริมาณเยอะคุ้มค่ากับราคาที่จ่ายไป จิ้มกับน้ำจิ้มงาเผ็ดรสเด็ดหอมหวนเอกลักษณ์ของร้านบุญดี แล้วจะติดใจจนต้องกลับมาเยือนอีกครั้ง	250 บาท / ชุด	หมู่ที่ 7 419 ถนนวิเวกธรรม อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100063756480769	เปิดทำการทุกวัน 17.00 – 22.00 น.	2025-02-26 18:30:51.29058	16.444846671991318	102.83029182699423
34	สำรวยการกิน	ร้านหมูกระทะเล็ก ๆ ย่านกังสดาล มีลักษณะเป็นเหมือนบ้านไม้ 2 ชั้น  บอกเลยว่ากินขาดเรื่องบรรยากาศ เพราะดูอบอุ่นเหมือนทานที่บ้านตัวเอง วัตถุดิบผ่านการคัดสรรมาเป็นอย่างดี เช่น หมูหมักที่สัมผัสได้ถึงความนุ่มนวลและหอมพริกไทย ผักสดสะอาดน่ารับประทาน ทีเด็ดอยู่ที่น้ำจิ้มครบรส ทั้งเปรี้ยวและหวานเป็นเอกลักษณ์เฉพาะ พบได้ที่สำรวยหมูกระทะเท่านั้น	ราคาเริ่มต้น 89 บาท / ชุด	ซ.อดุลยาราม 3 ในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100065703256289	เปิดทำการทุกวัน 17.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.463639734652567	102.8252487411198
33	พี่แป้งหมูกระทะ 	พี่แป้งหมูกระทะ บุฟเฟต์ปิ้งย่างและชาบู ที่มากับคอนเซปต์กำไรน้อยไม่ว่าลูกค้าต้องได้กินของดี เว่อร์มากสาว วัตถุดิบนี่คือคุณภาพดี แถมราคาเดียวอิ่มจุก ๆ รวมเนื้อ รวมน้ำ รวมขนมโอ้ยพี่แป้งเริ่ดนะ ไลน์อาหารก็มีทั้ง สามชั้นสไลซ์ บาง ๆ , สันคอสไลซ์, หมูนุ่ม, ปลา, หอย แถมมีริบอายสไลซ์ ลายสวย ๆ ด้วย	บุฟเฟต์ 199 บาท / บุฟเฟต์ซีฟู้ด 299 บาท	โนนม่วง-มหาวิทยาลัยขอนแก่น​ ตลาดเจ้พร​ อาม่ามอร์ ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/pangpoondong	เปิดทำการทุกวัน 15.30 - 24.00 น.	2025-02-26 18:30:51.29058	16.481517788076093	102.82011489694422
32	ลัคกี้หมูกระทะ สาขากังสดาล	ร้านหมูกระทะนี้มีวัตถุดิบสารพัดแต่ราคาไม่แพงมาก เหมาะกับคนที่ชอบกินหลาย ๆ อย่าง ทั้งหมูกระทะและของกินเล่นที่หลากหลายกว่าใคร ๆ ทั้งของหวาน ผลไม้ ซูชิหลากหลายหน้า	บุฟเฟต์ 189 บาท	ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/pbmookrata	เปิดทำการทุกวัน 16.00 – 23.30 น.	2025-02-26 18:30:51.29058	16.460646162095333	102.82449727951249
23	มิ่งหมูกะทะ มข.	านหมูกระทะที่ถูกใจนักกีฬาชาว มข. และเอาใจคนนอนดึก เนื่องจากเป็นร้านบุฟเฟต์ที่เปิดยันเช้า ร้านประจำของกลุ่มนักกีฬาที่เล่นกีฬาเสร็จค่ำ และมักจะมองหาร้านบุฟเฟต์ที่คุ้มค่า อร่อย และนั่งคุยกันชิลล์ ๆ ทั้งคืนได้ ที่นี่เลือกได้ตามใจว่าจะปิ้งเตาถ่านหรือเตาแก๊ส อาหารทีเด็ดคือเนื้อหมูสามชั้น หมูสันคอสไลซ์ที่มีทั้งแบบหมักและไม่หมัก เลือกความหอมและหนึบของเนื้อหมูได้เต็มปากเต็มคำ ของหวานชวนชิมของทางร้านคือขนมปังปิ้งเนยนม เป็นเมนูพิเศษไม่เหมือนร้านหมูกระทะไหน ๆ พบได้ที่มิ่งหมูกระทะเท่านั้น	บุฟเฟต์ 169 บาท	22 หมู่ 7 ถนน มิตรภาพ ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/Mingmooyang	เปิดทำการทุกวัน 16.30 – 05.00 น.	2025-02-26 18:30:51.29058	16.48155837580163	102.81751775061929
20	เดอะนัวหมูกระทะบุฟเฟต์	ร้านหมูกระทะที่ครบเครื่องลงตัวของใครหลายคน เป็นร้านบุฟเฟต์ราคาย่อมเยา มีวัตถุดิบที่ค่อนข้างดีมาก และยังมีเนื้อวัวที่นุ่มอร่อยคุ้มค่ากับราคา เพราะโดยทั่วไปแล้ว ในราคานี้แทบจะไม่มีร้านไหนที่มีเนื้อวัวรวมในราคาบุฟเฟต์เลย และวัตถุดิบอื่น ๆ ก็อร่อยไม่แพ้กัน ไม่ว่าจะเป็นหมูสามชั้น เนื้อหมูสไลซ์ อีกทั้งยังมีของกินเล่นที่อร่อยและหลากหลาย อาทิ ขนมจีบ แม้ว่าระยะทางจะค่อนข้างไกลจากโซนนักศึกษา แต่ก็ไม่ใช่ปัญหาสำหรับคนที่ต้องการทานของดีในราคาคุ้มเกินคาด	บุฟเฟต์ 189 บาท	หลัง ม.ขอนแก่น (ถนน รร.บ้านโนนม่วง) ตำบลศิลา เมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/TheNuaBuffet	เปิดทำการทุกวัน เวลา 15.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.427976160672724	102.83881186279116
24	นายตอง หมูกระทะ	ร้านหมูกระทะบุฟเฟต์ที่เปิดยันเช้าอีกหนึ่งร้าน เหมาะสำหรับกลุ่มเพื่อน ๆ มานั่งกินชิลล์ ๆ ที่ร้านแบบไม่จับเวลาและราคาย่อมเยา ทีเด็ดของนายตองคือหมูสามชั้นสด ไม่ติดมันมากจนเกินไป เมื่อปิ้งหรือย่าง หมูจะกรอบอร่อยทั้งยังมีเนื้อวัวสไลซ์และชีส รับประทานคู่กันแล้วบอกเลยว่าอร่อยเหมือนขึ้นสวรรค์ และต้องจิ้มกับน้ำจิ้มรสเลิศที่มีถึง 4 รสด้วยกัน ไม่ว่าจะเป็นน้ำจิ้มหวาน น้ำจิ้มเผ็ด น้ำจิ้มแจ่ว และน้ำจิ้มซีฟู้ด ถือว่าร้านนี้มีน้ำจิ้มหลากหลายที่สุดก็ว่าได้	บุฟเฟต์ 169 บาท	ซอยครูพรม ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100058705015623	เปิดทำการเวลา 16.30 – 04.00 น.	2025-02-26 18:30:51.29058	16.420845808073455	102.81771282544591
52	ประไพร	ร้านอาหารประไพ บรรยากาศร้านแบบสวนอาหาร มีอาหารอีสานหลากหลาย ปลาส้มทอดที่เป็นซิกเนเจอร์ของร้านนี้ ปลาทอดกรอบ มาพร้อมเครื่องเคียง ส้มตำหลากหลาย ไส้กรอกอีสาน อร่อยเด็ดห้ามพลาด		345/1-2 ถนนสนามบิน อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/prapraikhonkaen	เปิดทำการเวลา 11.00 - 21.00 น. (ปิดวันจันทร์)	2025-02-26 20:03:38.571906	16.461200022443297	102.78586443041068
101	พระมหาธาตุแก่นนคร	นี่คือแลนด์มาร์คกลางเมืองขอนแก่นซึ่งทุกคนต้องได้เห็นและต้องแวะกันเกือบทุกราย ด้านในวัดเป็นที่ตั้งขององค์พระมหาธาตุแก่นนครซึ่งมีความสูงถึง 80 เมตร โดดเด่นเป็นสง่าอยู่ในบริเวณริมบึงแก่นนครใจกลางเมืองเลยจ้า ในองค์เจดีย์แบ่งออกเป็น 9 ชั้น แต่ละชั้น จะมีสิ่งศักดิ์สิทธิ์มากมายให้เราได้แวะกราบไหว้ขอพรกันอย่างจุใจเชียวละ ส่วนขององค์พระบรมสารีริกธาตุนั้นจะอยู่ในชั้นบนสุดน้า ที่นี่ไม่มีบริการลิฟท์จ้ะ ค่อยๆ เดินชมเดินกราบไหว้กันไปทีละชั้น รับประกันว่าสายบุญต้องจุใจ	เข้าชมฟรี	อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100064655740957	เปิดทำการทุกวัน 08.00-18.00 น.	2025-02-26 20:03:59.617509	16.408365313989737	102.83474400895787
29	เฮียเปียว หมูเกาหลี	ร้านหมูกระทะนี้มีแฟรนไชส์ในหลายจังหวัด โดดเด่นเรื่องหมูหมักสูตรเด็ดของเฮียเปียวที่คัดสรรมาเป็นอย่างดี มีความนุ่มอร่อยทั้งหมูนุ่มและหมูสามชั้น เมื่อปิ้งย่างบนกระทะทองเหลืองจะได้กลิ่นหอม จิ้มกับน้ำจิ้มสีส้มสูตรเด็ดเฉพาะของเฮียเปียวที่เปรี้ยวนิด ๆ เพิ่มกระเทียม พริกสด มะนาวได้ ที่เด็ดกว่านั้นคือผักชีจีนซอยซึ่งเติมลงน้ำจิ้มได้ไม่อั้น เป็นเอกลักษณ์ที่ทำให้เฮียเปียวอยู่ในอุตสาหกรรมหมูกระทะได้นานกว่าใคร	ราคาต่อชุด ชุดเล็ก 109 บาท ชุดใหญ่ 139 บาท ราคาบุฟเฟ่ต์ 239 บาทไม่รวมเครื่องดื่ม	ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100037042793722	เปิดทำการทุกวัน เวลา 17.00 – 01.00 น.	2025-02-26 18:30:51.29058	16.438321333595514	102.80980454077357
43	ร้านแชร์ Share the good vibes	ร้านชิวน่านั่งสำหรับคนที่ชอบบรรยากาศดีๆ ร้านโล่งโปร่งต้องมาที่ “Share Bistro & Bar” หรือ “Share the good vibes” เป็นร้านอาหารฟีลดี เหมาะสำหรับการดินเนอร์แบบครอบครัวหรือคู่รักก็ได้ มีอาหารฟิวชั่นหลากเมนู ที่นั่งเป็นแบบ Open air ให้บรรยากาศสบาย ๆ ปัจจุบันร้านได้ย้ายทำเลใหม่มาอยู่ที่ริมบึงหนองโคตร บรรยากาศวิวริมบึง อากาศเย็นสบาย เหมือนคุณกำลังนั่งทานอาหารอยู่ริมชายหาด โดยโซนที่นั่งมีทั้ง out door และ indoor เลือกนั่งได้เลย		222 หมู่ 14 ถนนรอบบึงหนองโคตร ตำบลบ้านเป็ด อำเภอเมืองขินอก่น จังหวัดขอนแก่น	https://www.facebook.com/ShareKKC	เปิดทำการทุกวัน 17.00 – 24.00 น.	2025-02-26 20:03:29.975951	16.435662645409305	102.79182022487308
59	เฝอท่าบ่อ	เฝอท่าบ่อ ร้านเฝอเจ้านี้ดูแลกิจการโดยครอบครัวชาวเวียดนามมานานกว่า 3 ทศวรรษ ปรุงทุกเมนูจากสูตรดั้งเดิมของครอบครัว เคล็ดลับของความอร่อยอยู่ที่เส้นเฝอที่ทั้งเหนียวและนุ่มส่งมาจากท่าบ่อ จ.หนองคาย เติมความอร่อยด้วยลูกชิ้นเนื้อทำเอง และเนื้อวัวสไลด์ เข้ากันเป็นอย่างดีกับน้ำซุปเนื้อปรุงสุกนานกว่า 10 ชั่วโมง เมนูอื่นๆ อย่างไส้อั่วเลือดและเลือดแปลงก็อร่อยเด็ดไม่แพ้กัน		3/12 ถ.ศรีนวล ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=61559275404518	เปิดทำการทุกวัน 08.00 - 17.00 น.	2025-02-26 20:03:38.571906	16.42386178964843	102.83719093836741
50	บ้านเฮง	บ้านเฮง อาหารของร้านนี้จะเน้นไปที่เมนูอาหารเช้าง่ายๆ อย่างโจ๊ก ไข่กระทะ ขนมปังปิ้งต่างๆ กาแฟ พร้อมด้วยบรรยากาศง่ายๆ สบายๆ แต่เรียกได้ว่ารสชาติอร่อยลงตัว		54/2 ถนนกลางเมือง ตำบลในเมือง อำเภอเมือง จังหวัดขอนแก่น	https://www.facebook.com/baanheng	⏰: เปิดทุกวัน ร้านอาหาร 06.00–14.30 น. 	2025-02-26 20:03:38.571906	16.43433160406995	102.83609884575078
47	Oka Izakaya KhonKaen	ร้านอาหารญี่ปุ่น โอกะ อิซากายะ อาหารญี่ปุ่น ซาชิมิ ซูชิ และเมนูอื่นๆ กว่าร้อยรายการ เต็มอิ่มกับวัตถุดิบคุณภาพและสดใหม่ ในสไตล์ครอบครัว และยังรับทำข้าวกล่องเบนโตะอีกด้วย เมนูเทมปุระกุ้งคืออร่อยมาก กรอบนอกรุ่มในไม่อิ่มน้ำมัน อาหารอร่อย บรรยากาศดี ราคาไม่แพง คุ้มมาก ๆ ต้องมาลอง		26/62 หมู่4 ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/OkaIzakayaKhonKaen	เปิดทุกวัน 11.00 - 22.00 น.	2025-02-26 20:03:29.975951	16.42828521932447	102.85147534021328
51	มีกินฟาร์ม MEKIN FARM	สวนเกษตรมีกิน หรือ MEKIN FARM เป็นร้านอาหารสวนเกษตรออร์แกนิคแบบ 100% ไม่มีการใช้สารเคมีหรือยาฆ่าแมลงในการทำการเกษตร การทำนาทำสวนล้วนมาจากการใช้วิถีเกษตรอินทรีย์ทั้งหมด		114 ม.7 บ้านโคกกลาง ต.จระเข้ อ.หนองเรือ จ.ขอนแก่น	https://www.facebook.com/mekinfarmkhonkaen	เปิดทำการเวลา 09.30 - 17.30 น. (ปิดวันพุธ)	2025-02-26 20:03:38.571906	16.467180159720076	102.54195870342143
57	คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง	คุณแจง ก๋วยเตี๋ยวปากหม้อเข้าวัง ร้านก๋วยเตี๋ยวปากหม้อรสเด็ด กับเมนูที่ห้ามพลาดอย่าง ก๋วยเตี๋ยวปากหม้อน้ำข้น ตัวซุปรสชาติกลมกล่อมเข้มข้นพอดี ไม่เค็มจัด ไม่หวานจ๋อย ซดได้สบายใจ ปรุงรสเพิ่มเล็กน้อยได้ตามใจชอบ นอกจากนี้ยังมีสาคูไส้หมู ขนมปากหม้อที่ควรค่าแก่การสั่งมากินอีกด้วย แป้งบาง ไส้แน่น อร่อยโดนใจ		246 4 ถนน ถนนหลังเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100089214498371	เปิดทำการเวลา 09.00 - 16.00 น.	2025-02-26 20:03:38.571906	16.424948076445833	102.83670831506976
54	โสเจ๊งโภชนา (บ้านไผ่)	ร้านโสเจ๊งโภชนา ร้านอาหารไทย ฟิวชั่นอีสาน ที่อร่อยแบบลงตัว ตัวร้านมีร้านมุมให้เลือกนั่งมากมาย เป็นร้านสไตล์ครอบครัว เหมาะแก่การพาครอบครัวมากินข้าวในวันหยุด เป็นอีกร้านเก่าแก่อยู่คู่คนขอนแก่นมายาวนาน เป็นอีกหนึ่งตัวเลือกร้านอาหารขอนแก่นที่ไม่ควรพลาด		599/3-4 ม.2 ถ.แจ้งสนิท ต.ในเมือง อ.บ้านไผ่ จ.ขอนแก่น	\N	เปิดทำการทุกวัน 08.00 - 21.00 น.	2025-02-26 20:03:38.571906	16.057965497163952	102.73563149603238
58	เล้งเย็นตาโฟ	เล้งเย็นตาโฟ ร้านก๋วยเตี๋ยวเย็นตาโฟชื่อดังของชาวขอนแก่น น้ำซุปของที่ร้านจะมีความใส แต่เข้มข้น ลูกชิ้นทำเอง รสชาติแซ่บแบบยำมาให้แล้ว ส่วนใครไม่ชอบกินเผ็ดก็สั่งแบบน้ำใสมาได้ เป็นอีกร้านเย็นตาโฟที่อร่อยและไม่ควรพลาด		ถนน กลางเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	\N	เปิดทำการทุกวัน 07.00 - 14.30 น.	2025-02-26 20:03:38.571906	16.43509652235044	102.83611051322411
53	ประสิทธิ์โภชนา	ประสิทธิ์โภชนา ร้านอาหารอีสานเปิดมานานกว่า 40 ปีสโลแกนร้านคือ ใช้เนื้อส่วนที่ดีที่สุด เพื่อมาทำอาหารที่แซ่บที่สุด บอกเลยว่าเป็นร้านที่เหมาะสำหรับคนรักเนื้อ หมีหลายเมนูไม่ว่าจะเป็น ลาบ น้ำตก ยำ จิ้มจุ่ม สไตล์อีสาน และอีกมากมาย บอกเลยว่าเป็นอีกหนึ่งร้านอาหารอีสานรสแซ่บที่ไม่ควรพลาด		44/4 ถนนอำมาตย์ อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/Prasitpochana	เปิดทำการทุกวัน 09.30 - 14.00 น. (ปิดวันจันทร์)	2025-02-26 20:03:38.571906	16.422186001043197	102.81615903080444
56	ขอนแก่น คอหมูย่าง	ขอนแก่น คอหมูย่าง เป็นร้านที่มีสูตรเด็ดในการหมักหมูด้วยน้ำซอสสูตรพิเศษ เพื่อให้ได้คอหมูย่างที่มีกลิ่นหอม และรสชาติที่เป็นเอกลักษณ์ไม่เหมือนใคร นอกจากนี้ที่ร้านยังมีเมนูอื่นๆ ให้เลือกมากมาย เป็นอีกร้านที่ไม่ควรพลาด		ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	\N	เปิดทำการเวลา 09.00 - 20.00 น. / อาทิตย์ - จันทร์ 10.30 - 21.00 น.	2025-02-26 20:03:38.571906	16.43500269387424	102.83626808254321
62	มานะโภชนา	เชฟมานะ เจ้าของร้านสั่งสมประสบการณ์จากร้านอาหารสไตล์ไทย-จีนในเมืองหลวง ก่อนขยับมาเปิดร้านที่บ้านเกิดได้กว่าสิบปีแล้ว อาหารของที่นี่เป็นสไตล์ไทย-จีน โดยเน้นไปที่เมนูอาหารทะเล วัตถุดิบสดคัดพิเศษ แต่ราคาเป็นมิตร เชฟมานะแสดงฝีมือที่เคี่ยวกรำมายาวนานในทุก ๆ จาน		420 ม.21 ถ.ศรีจันทร์ ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/profile.php?id=61573149578666	เปิดทำการทุกวัน 12:00 - 13:30 น., 16:00 - 21:30 น.	2025-02-26 20:03:38.571906	16.43862013170823	102.78167080983025
64	Vacca Italian Restaurant	ร้านอาหารอิตาเลียน หน้าโรงแรมราชาวดี ใกล้สนามบิน มีบริการทั้งคาวทั้งหวาน มานั่งดื่มกาแฟ ทานเค้ก ระหว่างรอเครื่องบินได้ อาหารอร่อย รสจัด สไตล์อิตาเลียนจริงๆ พนักงานบริการดี บรรยากาศดี		99 หมู่ที่ 20 ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/vaccaitalianbyfabio	เปิดทำการทุกวัน เวลา 11:00 - 21:30 น.	2025-02-26 20:03:38.571906	16.4603478103617	102.78603591353591
65	โจ๊ก ก๋วยจั๊บ ต้มเส้น บัตรคิว	ร้านนี้ตั้งชื่อตามเมนูเด็ดของร้านที่ขายมามากว่า 30 ปี ไม่ว่าจะเป็น โจ๊ก ก๋วยจั๊บญวนเส้นสดในซุปกระดูกหมูเข้มข้น และต้มเส้นตีนไก่ ไม่ควรพลาดเลยสักจาน แนะนำให้ใส่หมูยอและไข่ลวกเพื่อความอร่อยยิ่งขึ้น และร้านจะแจกบัตรคิวให้สำหรับซื้อไปรับประทานที่บ้านช่วงที่ร้านคนแน่นมาก ๆ เท่านั้น		อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/Chok.KuaiChap.TomSen.BatKhio	เปิดทำการทุกวัน เวลา 17:30 - 02:00 น.	2025-02-26 20:03:38.571906	16.429331935293806	102.8337867233218
66	เกาเหลาเซี่ยงจี๊	ร้านเล็กๆ แห่งนี้เติบโตมาจากหาบเร่ในตลาด แต่ด้วยความอร่อยที่ลูกค้าติดใจ จึงเปิดขายมานานเกือบห้าสิบปีแล้ว ปัจจุบันดูแลโดยทายาทรุ่นสาม สืบสานตำรับที่รับมาจากรุ่นอากง เนื้อและเครื่องในหมูสะอาดและเตรียมมาอย่างดี อร่อยนุ่มไม่คาว น้ำซุปรสกลมกล่อม หอมกลิ่นขึ้นฉ่าย อย่าลืมสั่งเกี๊ยวกุ้งทอดมาเคี้ยวเพลินๆ ใช้กุ้งทั้งตัวเนื้อนุ่มเด้ง รสเค็มหวานอ่อนๆ อร่อยเด็ดทุกคำ		8 ถ.สันติยุติธรรม ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/Admin.eiw	เปิดทำการทุกวัน 06:00 - 11:30 น.	2025-02-26 20:03:38.571906	16.431506509714914	102.83631297266912
63	สีนานวล คาเฟ่	ร้านอาหารไทยและอาหารอีสานที่รสชาติดีเกินมาตรฐานทั่วไปในขอนแก่น เมนูห้ามพลาดคือปลาช่อนเผา เสิร์ฟพร้อมผักลวกสีสวย และน้ำจิ้มแจ่วทั้งสูตรธรรมดาและสูตรปลาร้า นอกจากนี้ทางร้านยังมีดนตรีสดไว้ขับกล่อมในช่วงมื้อเย็นอีกด้วย		164/160 ม.14 ต.ในเมือง อ.เมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100069610268734	เปิดทำการทุกวัน 10:00 - 23:00 น.	2025-02-26 20:03:38.571906	16.458598714917052	102.8234208846998
72	ไก่ย่างระเบียบ (สาขาเขาสวนกวาง)	ไก่ย่างที่โด่งดังที่สุดแห่งหนึ่งของประเทศ ที่นี่เลือกใช้ไก่สามสายพันธุ์ซึ่งเป็นไก่พื้นเมือง ย่างด้วยเตาถ่านที่ให้กลิ่นหอมเฉพาะตัว เนื้อไก่แน่นอร่อย นุ่มและฉ่ำ หนังบางกรอบ เครื่องในไก่ย่างสุดอร่อยมีเสิร์ฟเฉพาะสาขาแรก		99 ถ. มิตรภาพ ต.คำม่วง อ.เขาสวนกวาง จ.ขอนแก่น	https://www.facebook.com/kaiyangzap	เปิดทำการทุกวัน เวลา 08:00 - 18:00 น.	2025-02-26 20:03:38.571906	16.854217007761804	102.85887611169086
70	สุขใจแลนด์	เมื่อก้าวเข้ามาก็สุขใจสมชื่อ เพราะได้บรรยากาศสงบงามตามแบบอีสานท้องทุ่ง นั่งกินข้าวด้วยกันในเถียงนา รับลมธรรมชาติพร้อมสูดอากาศบริสุทธิ์ให้เต็มปอด อาหารมีให้เลือกทั้งแบบเซ็ตเมนูและตามสั่ง		98 ม.7 ถ.มะลิวัลย์ ต.หนองบัว อ.บ้านฝาง จ.ขอนแก่น	https://www.facebook.com/sookjailand	เปิดทำการทุกวัน 09:30 - 17:30 น.	2025-02-26 20:03:38.571906	16.46789377015289	102.61405109819165
71	บะหมี่กวงตัง	ร้านอายุกว่า 7 ทศวรรษแห่งนี้ผ่านมือเจ้าของร้านมาแล้วสามชั่วคน ยังเป็นที่นิยมของคนท้องถิ่นไม่เสื่อมคลาย ทำเครื่องเคราเองทุกอย่างตั้งแต่เส้นบะหมี่ไข่ หมูแดง หมูกรอบ และเกี๊ยวหมู จึงอร่อยเด็ดไม่เหมือนใคร		18/15 ถ.พิมพสุต ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/bamee.kwangtung	เปิดทำการทุกวัน เวลา 08:30 - 17:00 น.	2025-02-26 20:03:38.571906	16.436727997723764	102.83579769633846
69	ไก่ย่างวรรณา	ไก่ย่างเขาสวนกวางที่โดดเด่น คัดสรรไก่พันธุ์พื้นบ้านมาย่างเตาถ่านจนหนังกรอบ แต่เนื้อในยังคงความชุ่มฉ่ำ เสิร์ฟพร้อมเมนูอีสานยอดนิยมอื่นๆ ที่น่าลิ้มลอง ไก่ย่างของที่นี่ขายดีจนหมดก่อนเวลาปิดร้านเสมอ		271 ม.11 ถ.มิตรภาพ ต.คำม่วง อ.เขาสวนกวาง จ.ขอนแก่น	https://www.facebook.com/wankaiyang	เปิดทำการทุกวัน เวลา 07:00 - 17:00 น.	2025-02-26 20:03:38.571906	16.85377417621398	102.85950066936303
73	ข้าวต้มซ้ง 24 น.	ร้านข้าวต้มขวัญใจคนท้องถิ่นแห่งนี้เปิดบริการมาแล้วหลายสิบปี มีอาหารให้เลือกกว่า 200 รายการ ที่ต้มผัดแกงทอดกันเดี๋ยวนั้นเมื่อลูกค้าสั่ง จึงคลาคล่ำไปด้วยนักกินขาประจำ อย่าลืมสั่งแกงส้มผักกระเฉดปลาช่อนทอดและปลาหมึกทอดกระเทียม เป็นสองเมนูที่วัดทักษะคนทำได้ดี ซึ่งแน่นอนว่าที่นี่ผ่านฉลุย		ถ.นิกรสำราญ ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100094789720488	เปิดทำการเวลา 17:00 - 04:30 น.	2025-02-26 20:03:38.571906	16.420768922888314	102.83329688284643
67	แก่น	ร้านที่นำเสนอแก่นของอาหารไทยแบบร่วมสมัย ผสมผสานวัตถุดิบและรสชาติจากประสบการณ์ของเชฟไพศาล ห้ามพลาดมัสมั่นขาแกะ เนื้อแกะนุ่มชุ่มฉ่ำ หอมกลิ่นเครื่องเทศ น้ำแกงข้นพอดี ใส่อัลมอนด์แทนถั่วลิสง ทำให้ได้กลิ่นรสที่แปลกออกไป		140/64 อดุลยาราม ซ.7 ต.ในเมือง อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/kaendining	เปิดทำการทุกวัน เวลา 11:00 - 15:00 น. / 17:00 - 21:00 น.	2025-02-26 20:03:38.571906	16.464214630016563	102.82568915215859
80	ผาชมตะวัน	ผาชมตะวัน จุดชมวิวแห่งนี้นับเป็นความสวยงามอลังการของทะเลหมอกยามเช้า โดยเฉพาะในช่วงปลายฤดูฝนเช่นนี้ จะเต็มอิ่มไปด้วยทะเลหมอกเบื้องหน้า และหากวันที่ฟ้าเปิดให้แสงอาทิตย์ลอดออกมาทักทาย ก็ยิ่งกลายเป็นความสวยงาม เป็นจุดชมแสงแรกของวันที่น่าประทับใจไม่แพ้ที่ใด	ค่าเข้าชม: ผู้ใหญ่ 40 บาท เด็ก 20 บาท , ชาวต่างชาติ ผู้ใหญ่ 200 บาท เด็ก 100 บาท	อุทยานแห่งชาติภูเวียง ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/Phuwiangnp71/	เปิดให้เข้าชมทุกวัน : 08.30-16.30 น.	2025-02-26 20:03:59.617509	16.789325841512802	102.27698719264005
143	ALL GOOD Homemade Pasta 	🍽ร้านเลยจัดหนักให้เลยจ้า เมนูน้องใหม่ "พาสต้า เส้นสด" มีเส้นให้เลือกกว่า 8 อย่าง ทำมือทั้งหมด.. โดยเราสามารถเลือกเส้น เเละ ซอสกว่า 15 ซอสได้เองทุกจาน จะได้พาสต้าที่ไม่เหมือนใครแน่นอน🍝🍕		143 หมู่14 ซอยสวัสดี ในเมือง เมือง ขอนแก่น 40000	https://www.facebook.com/allgoodcafekk?locale=th_TH	เปิดทำการทุกวันเวลา 12.00-20.00 ทุกวัน	2025-03-01 10:41:07.415613	16.45111221448031	102.83064585586351
151	น้ำตกตาดทิดมี	สถานที่ท่องเที่ยวทางธรรมชาติ หนึ่งในพิกัดน่าเที่ยวที่งดงามที่สุดในช่วงฤดูฝน\nน้ำตกตาดทิดมี อยู่ในพื้นที่อุทยานแห่งชาติภูผาม่านเป็นที่กั้นเขตแดนของจังหวัดขอนแก่นและเพชรบูรณ์ เป็นน้ำตกที่มีความสูง 14 เมตร กว้าง น้ำไหลลดหลั่นกันไปตามระดับชั้นตามความยาวของลำห้วย บรรยากาศดี เพราะวิวล้อมรอบไปด้วยภูเขาสีเขียวๆ		บ้านดงสะคร่าน ต.วังสวาบ อ.ภูผาม่าน จ.ขอนแก่น	\N	เปิดทำการตั้งแต่เวลา 8.30 - 16.30 น. 	2025-03-06 19:10:19.885299	16.72943027685679	101.79103341354097
152	วัดทุ่งเศรษฐี	วัดทุ่งเศรษฐี วัดที่เชื่อว่าเปรียบเสมือนประตูเชื่อมของ 3 โลก ได้แก่ โลกบาดาล โลกมนุษย์ และสวรรค์ โดยที่นี่เป็นที่ประดิษฐานของมหาเจดีย์ศรีไตรโลกธาตุ หรือมหาเจดีย์รัตนะ 	ค่าเข้าชม : ฟรี	หมู่ 12 บ้านหนองไฮ ตำบลพระลับ เมืองขอนแก่น จ.ขอนแก่น	\N	เวลาเปิดทำการ : เปิดทุกวัน เวลา 07.00 - 19.00 น	2025-03-06 19:23:21.348004	16.411884026595942	102.88407080004325
150	น้ำตกบ๋าหลวง	ใครที่สนใจมาเที่ยว น้ำตกบ๋าหลวง นี้ แนะนำให้มาช่วงหน้าฝน เพราะจะมีน้ำค่อนข้างมาก ประมาณเดือนกรกฎาคม ไปจนถึง ธันวาคมเลยทีเดียว และที่บริเวณเหนือน้ำตกจะเป็นลานหินกว้าง สวยแปลกมากๆ		วนอุทยานน้ำตกบ๋าหลวง ตำบลห้วยยาง อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=121275774884021	เปิดให้เข้าชม : 08.00-16.00 น.	2025-03-06 19:04:43.861137	16.890149299076512	103.08690331539671
76	สวนอาหาร อ.กุ้งเผา	ร้านอาหารซีฟู้ดสด ๆ บรรยากาศโล่งสบาย มีเมนูเด่น เช่น กุ้งแม่น้ำเผา ปูผัดผงกะหรี่ และตำปูม้าสด		437 ม.21 ต.บ้านเป็ด อ.เมือง จ.ขอนแก่น	https://www.facebook.com/Or.KungPhao.KK	เปิดทำการทุกวัน 10.00 – 22.00 น.	2025-02-26 20:03:48.553143	16.43607876393334	102.76655538840444
78	Skywalk ภูแอ่นโนนสัง	Skywalk ภูแอ่นโนนสัง อยู่ในเขตอุทยานแห่งชาติภูเก้า-ภูพานคำ จุดชมวิวเหนือเขื่อนอุบลรัตน์ เดิมคือ จุดชมวิวช่องเขาขาด เเละได้สร้างเป็นสกายวอร์คยื่นออกไปชมวิวเขื่อน  เป็นจุดชมพระอาทิตย์ตกที่สวยมาก วิวด้านหน้าเป็นเขื่อนอุบลรัตน์วิวน้ำเเละท้องฟ้าสุดลูกหูลูกตา	ค่าเข้าอุทยานคนละ 20 บาท ค่ารถยนต์ 30 บาท ค่ารถสองแถวคนละ 60 บาท (ไป-กลับ) ได้รองเท้าใส่เดินบนสกายวอร์ค 1 คู่ (นำกลับบ้านได้เลย ไม่ต้องคืน)	ตำบลบ้านค้อ อำเภอโนนสัง จังหวัดหนองบัวลำภู	https://www.facebook.com/phukao.np	เปิดทุกวัน : เวลา 06.00 - 18.30 น.	2025-02-26 20:03:59.617509	16.80085982698527	102.61368501354238
81	Blue Lagoon ภูผาม่าน	Blue Lagoon แหล่งท่องเที่ยวสุด Unseen ของ ำเภอภูผาม่าน จังหวัดขอนแก่น ลักษณะเป็นสระน้ำสีฟ้ามรกตขนาดใหญ่รายล้อมไปด้วยภูเขาหินปูน มีความลึกถึง 70 เมตร ซึ่งเกิดจากการปล่อยน้ำหลังจากการเลิกทำเหมืองหินของโรงโม่หิน ทำให้มีน้ำขังทั่วบ่อ มีสีฟ้ามรกตใสสะอาด ตัดกับภูเขาหินปูนสีเทาที่มีลักษณะคล้ายหุบเหว สามารถแวะมาถ่ายรูปสวยๆกันได้เลย	เข้าชมฟรี	บ้านสองคอน ตำบลนาฝาย อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/BlueLagoonPPM/	เปิดให้เข้าชม : 06.00 – 19.00 น.	2025-02-26 20:03:59.617509	16.66501245718231	101.8319525558676
84	บ้านผาสุก	สำหรับใครที่มองหาที่พักบรรยากาศดี กลางทุ่งนาและภูเขา แนะนำเลย ที่นี่มีที่พักหลากหลายสไตล์ให้เลือกไม่ว่าจะเป็น เรือนไทย มินิมอล โมเดิร์นลอฟท์ หรือลานกลางเต้นท์ นอกจากนี้ยังมีร้านนั่งชิลล์ ร้านอาหาร คาเฟ่ ใกล้ ๆ อีกด้วยสะดวกสบายสุด ๆ พร้อมไปกับวิวสวย ๆ บรรยากาศดี ๆ	ราคาที่พักเริ่มต้น: 1,500 – 2,500 บาท / คืน	ต.ภูผาม่าน อ.ภูผาม่าน จ.ขอนแก่น	https://www.facebook.com/phasuk.phuphaman	เปิดตลอดเวลา	2025-02-26 20:03:59.617509	16.664520488174347	101.91561697491721
83	จุดชมวิวหนองสมอ	จุดชมวิวหนองสมอ จุดชมวิวริมน้ำมีชื่อว่าหนองสมอ ที่สามารถมองเห็นวิวของภูเขาของผาม่านได้แบบทอดยาว ตัดกับท้องฟ้าและมีเงาของภูเขาที่สะท้อนลงบนผิวน้ำ ตรงจุดชมวิวยังมีการทำระเบียงชมวิว ที่สามารถมานั่งมองวิวภูเขาได้อีกด้วย	เข้าชมฟรี	ตำบลโนนคอม อำเภอภูผาม่าน ขอนแก่น	\N	เปิดให้เข้าชมพระอาทิตย์ขึ้นได้ตั้งแต่ เวลา 05.30 น. เป็นต้นไป	2025-02-26 20:03:59.617509	16.641944275770435	101.9218752828506
89	บ้านสวนริมธาร	ไปนั่งชิลริมน้ำกับที่เที่ยวขอนแก่น ธรรมชาติ บ้านสวนริมธาร อำเภอภูผาม่าน เป็นสถานที่ที่เหมาะกับวันพักผ่อนสุดๆ นอกจากจะเป็นร้านอาหารที่มีอาหารแซ่บๆ แล้วยังมีที่พักและลานกางเต็นท์ด้วยนะครับ แถมที่นี่ยังน้ำใสสุดๆ สามารถลงไปเล่นน้ำกันได้เลย หรือจะพายเรือ นั่งห่วงยาง เดินเล่นในสวนผลไม้ก็ชิลไปอีกแบบ		103 บ้านฝายตาสวน ต.วังสวาบ อ.ภูผาม่าน จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100028871122533	เปิดให้เข้าชม : 08.00-17.00 น.	2025-02-26 20:03:59.617509	16.764506907730148	101.80249712908605
90	น้ำผุดตาดเต่า	น้ำผุดตาดเต่า​ สถานที่ท่องเที่ยวในอำเภอภูผาม่าน​  เป็นน้ำที่ผุดออกมาจากร่องเขา แล้วไหลลงมารวมกันจนเกิดเป็นแอ่งน้ำที่กว้าง​ เป็นที่เล่นน้ำของชาวขอนแก่น น้ำใส​ที่นี่ใสมาก  เป็นสีเขียวมรกต สะอาดน่าเล่น นอกจากนี้ที่นี่ยังมีร้านอาหารและที่พักบริการด้วย		บ้านวังผาดำ ต.วังสวาบ อ.ภูผาม่าน จ.ขอนแก่น	\N	เปิดให้เข้าชม : ทุกวัน	2025-02-26 20:03:59.617509	16.683937313867048	101.84900871724528
92	สวนน้ำสวนสัตว์ขอนแก่น	นอกเหนือจากสวนสัตว์แล้ว ภายในสวนสัตว์ขอนแก่นยังมี สวนน้ำ ซึ่งเป็นสถานที่ท่องเที่ยวพักผ่อนหย่อนใจ คลายร้อน มีสระน้ำ มีสไลด์เดอร์ให้เด็กและผู้ใหญ่ได้เล่นคลายร้อน หลังจากเดินเยี่ยมชมดูสัตว์เล็กสัตว์น้อยภายในสวนสัตว์ขอนแก่น ภายในมีการจัดการที่ดี มีทั้งห้องน้ำ มีทั้งที่จอดรถ สะดวกสบาย เหมาะสำหรับมาพักผ่อนคลายร้อนในช่วงนี้เป็นที่สุด	อัตราค่าเช่าชุด: เด็กเล็ก ชาย – หญิง ราคา 30 + ค่าหมวกว่ายน้ำ 10 บาท เด็กกลาง ชาย – หญิง ราคา 50 +ค่าหมวกว่ายน้ำ 10 บาท ผู้ใหญ่ ชาย – หญิง ราคา 80 + ค่าหมวกว่ายน้ำ 10 บาท	88 หมู่ที่ 8 สวนสัตว์ขอนแก่น อำเภอเขาสวนกวาง จังหวัดขอนแก่น	http://www.khonkaen.zoothailand.org/index.php	เปิดให้บริการทุกวัน ตั้งแต่เวลา 10.00 - 18.00 น.	2025-02-26 20:03:59.617509	16.83408199653184	102.90557357492037
88	ล่องแก่งผาเทวดา	ใครอยากลองสไตล์จากเที่ยวแบบสงบ ไปเที่ยวแบบตื่นเต้น ต้องไปล่องแก่งผาเทวดา อำเภอภูผาม่าน ที่เที่ยวธรรมชาติขอนแก่นยอดฮิตในตอนนี้ที่ไม่ควรพลาด จะไปล่องแก่งกับเพื่อนก็ดีหรือจะไปกับครอบครัวก็สนุกไม่แพ้กัน ระหว่างทางจะคดเคี้ยวซักหน่อย แต่วิวข้างทางที่ร่มรื่นกับสายน้ำที่เย็นฉ่ำ ไปพร้อมกับการผจญภัยสุดมันส์ ทำให้เราสนุกและเพลิดเพลินจนลืมเวลาแน่นอนครับ	ค่าเข้า: คนละ 250 บาท	บ้านเขาวง อ.ภูผาม่าน จ.ขอนแก่น	https://www.facebook.com/AdminDaw2.AdminTal3.AdminBoss	เปิดให้เข้าชม : 08.30-17.00 น.	2025-02-26 20:03:59.617509	16.65044366892462	101.77447583258895
93	บึงแก่นนคร	บึงแก่นนคร บึงขนาดใหญ่ใจกลางเมืองขอนแก่น เป็นทั้งสถานที่พักผ่อนหย่อนใจและออกกำลังกายประจำวันของชาวขอนแก่นที่บรรยากาศคึกคักและเต็มไปด้วยชีวิตชีวา แลนด์มาร์กล่าสุดของบึงแก่นนครที่ไม่ควรพลาด คือสะพานข้ามบึงความยาวราวๆ 800 เมตรที่พาดผ่านระหว่างฝั่งทิศตะวันออกของบึงมายังฝั่งทิศตะวันตก		367 ถนนกลางเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	\N	เปิดทำการเวลา 6.00 – 21.00 น.	2025-02-26 20:03:59.617509	16.4147	102.8381
98	อุทยานแห่งชาติน้ำพอง	อุทยานแห่งชาติน้ำพอง ที่เที่ยวสุดอันซีนที่จะทำให้ทุกคนได้สัมผัสอากาศพร้อมกับวิวสวย ๆ เหมือนกับไปภาคเหนือเลย ที่นี่ในตอนเย็นแสงแดดที่สาดส่องลงมาบอกเลยว่าสวยควรค่าแก่การถ่ายภาพไว้มาก ๆ	ผู้ใหญ่ 20 บาท เด็ก 10 บาท ค่าธรรมเนียมรถยนต์ 30 บาท จักรยานยนต์ 20. บาท	ตำบลบ้านผือ อำเภอหนองเรือ จังหวัดขอนแก่น	https://www.facebook.com/namphong.np	เปิดทำการทุกวัน 08.30-17.00 น.	2025-02-26 20:03:59.617509	16.625580270897665	102.56974169026073
94	บึงทุ่งสร้าง	บึงทุ่งสร้างเป็นทะเลสาปที่อยู่ในจังหวัดขอนแก่นมีขนาดใหญ่ บริเวณโดยรอบที่นี่เป็นสวนสาธารณะ ที่ให้คนในชุมชนมาพักผ่อนหย่อนใจ ทำกิจกรรมสันทนาการ ออกกำลังกาย ทั้งการวิ่ง ปั่นจักรยาน เดิน บริเวณโดยรอบสะอาดสบายตา มีปลูกต้นไม้รอบๆเลย	ฟรี	ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น	\N	เปิดให้บริการ ตั้งแต่เวลา 04.00 – 21.00 น.ทุกวัน	2025-02-26 20:03:59.617509	16.452021862039903	102.85540503636017
95	บึงสีฐาน	เป็นสถานที่ที่น่าไปเที่ยวมาก ๆ สำหรับผู้ที่ต้องการผ่อนคลายหรือออกกำลังกาย บึงแห่งนี้มีบรรยากาศร่มรื่น มีลมพัดเย็นสบาย เหมาะสำหรับการนั่งพักผ่อนหรือวิ่งออกกำลังกาย รอบบึงมีเลนจักรยานและลู่วิ่ง ซึ่งเป็นที่นิยมสำหรับนักวิ่งและผู้ที่ต้องการออกกำลังกาย	ฟรี	มหาวิทยาลัยขอนแก่น ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น	\N	เปิดทุกวันเวลา 06:00 น. - 21:00 น.	2025-02-26 20:03:59.617509	16.444441868756616	102.8155784824148
91	สวนน้ำไดโนวอเตอร์ปาร์ค	เป็นสวนน้ำที่เหมาะสำหรับครอบครัว มีเครื่องเล่นหลากหลาย ทั้งสไลเดอร์และสระว่ายน้ำที่เหมาะกับเด็กและผู้ใหญ่ การตกแต่งธีมไดโนเสาร์ทำให้บรรยากาศน่าสนใจ นอกจากนี้ยังมีบริการอาหารและสิ่งอำนวยความสะดวกเพียงพอ	ผู้ใหญ่: 400 บาท เด็กสูง 120-140 เซนติเมตร: 300 บาท เด็กต่ำกว่า 120 เซนติเมตร เข้าฟรี	456 หมู่ที่ 12 ถ. มิตรภาพ ตำบล เมืองเก่า อำเภอเมืองขอนแก่น ขอนแก่น	https://www.facebook.com/HIEND.DINO	เปิดให้บริการวันจันทร์ - วันศุกร์: 11:00 น. - 21:00 น. วันเสาร์ - วันอาทิตย์ และวันหยุดนักขัตฤกษ์: 09:00 น. - 21:00 น.	2025-02-26 20:03:59.617509	16.40223642072896	102.81086429633774
103	วัดแก้วจักรพรรดิสิริสุทธาวาส	เป็นสถานที่ศักดิ์สิทธิ์ที่มีเอกลักษณ์โดดเด่นด้วยสถาปัตยกรรมที่สวยงาม โดยเฉพาะรูปปั้นพญานาคสีขาวขนาดใหญ่และศาลาแก้วจักรพรรดิซึ่งใช้สำหรับปฏิบัติธรรม นอกจากนี้ภายในวัดยังมีพระพุทธรูปปางเปิดโลกที่ใหญ่ที่สุดในประเทศไทยและถ้ำวังแก้วหรือถ้ำพญานาคที่ประดับด้วยลูกแก้วจำนวนมาก	ฟรี	บ้านหนองโพนน้อย หมู่ที่ 7 ต.กุดขอนแก่น อ.ภูเวียง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100066878472792	เปิดทุกวัน เวลา 07.00 น. - 19.00 น.	2025-02-26 20:03:59.617509	16.587263067341965	102.4645656000466
188	ครัวสุนทะรี	ร้านอาหารบรรยากาศกันเอง เสิร์ฟอาหารอร่อย พร้อมดนตรีสดสร้างความสนุก มีเมนูหลากหลาย เหมาะสำหรับนั่งชิลล์กับเพื่อนฝูงหรือครอบครัว	\N	462 หมุ่ 19 ตำบลหนองโก อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/SoontareeKitchen	เปิดทำการทุกวัน เวลา 10:00–22:00 น.	2025-03-08 15:56:10.469097	16.689779644715237	103.08695859581972
100	พิพิธภัณฑ์ไดโนเสาร์ภูเวียง	พิพิธภัณฑ์ไดโนเสาร์ภูเวียง จุดเริ่มต้นของที่นี่คือมีการขุดพบซากฟอลซิลไดโนเสาร์เป็นครั้งแรกในภูเวียง ใครที่สนใจเรื่องราวเกี่ยวกับไดโนเสาร์ห้ามพลาด ที่นี่มีทั้งส่วนที่จัดแสดง ห้องบรรยาย และจุดขายของที่ระลึกน่ารักๆ ที่คนรักไดโนเสาร์ไม่ควรพลาด ขยับออกมาไม่ไกลจากพิพิธภัณฑ์ไดโนเสาร์ภูเวียง ก็จะเจอสวนไดโนเสาร์ภูเวียงที่มีบรรยากาศร่มรื่น เต็มไปด้วยต้นไม้คล้ายกับสวนสาธารณะ มีรูปปั้นของไดโนเสาร์พันธุ์ต่างๆ กระจายอยู่ทั่วทุกจุด เหมาะสำหรับเป็นจุดพักผ่อนของครอบครัว และเป็นที่ชื่นชอบของเด็กๆ	ค่าเข้าชม: ผู้ใหญ่ 20, เด็ก 10 บาท / ต่างชาติผู้ใหญ่ 60 บาท, เด็ก 30 บาท	ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/pdm.dmr	เวลาเปิดทำการ : 09.30 – 16.30 น. (ปิดวันจันทร์)	2025-02-26 20:03:59.617509	16.678049991648837	102.26739841909816
107	เซ็นทรัลขอนแก่น	ศูนย์การค้าไลฟ์สไตล์ขนาดใหญ่และทันสมัย โดดเด่นด้วยการออกแบบที่ผสมผสานศิลปวัฒนธรรมพื้นบ้านและคำนึงถึงการอนุรักษ์พลังงาน ศูนย์การค้าประกอบด้วยห้างสรรพสินค้าโรบินสัน โรงภาพยนตร์เอส เอฟ ซิตี้ ลานโบว์ลิ่งร้านค้าปลีกชั้นนำ แฟชั่น อาหารและเครื่องดื่ม รวมกันกว่า 250 ร้านค้า	-	99, 99/1 ถนนศรีจันทร์ ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/CentralKhonKaenFanpage	วันจันทร์-วันศุกร์ 10.30 น.-21.00 น. วันเสาร์-วันอาทิตย์-วันหยุดนักขัตฤกษ์ 10.00 น.-21.00 น.	2025-02-26 20:03:59.617509	16.4331	102.8257
109	ตลาดต้นตาล	ตลาดต้นตาล แแหล่งเที่ยวช้อปแนวใหม่สำหรับช่วงเวลาเย็น ๆสบาย ๆ หลังเลิกงาน เป็นตลาดชอปปิ้งทั้งแบบกลางแจ้งและอยู่ในอาคารสินค้าวางจำหน่ายมีทั้งสินค้าแฟชั่น สินค้าทำมือ อาหาร และเครื่องดื่ม มีที่นั่งพักหรือหาของอร่อย ๆ ทานก็มีให้เลือกชิมกันหลายอย่างในราคาที่แสนประหยัด บรรยากาศไม่ซ้ำใคร ด้วยเมนูเด็ด ๆ จากร้านค้าที่ถูกคัดสรรมาโดยเฉพาะ มีให้เลือกมากถึง 60 ร้านค้า		ถนนมิตรภาพ ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/TonTannMarket	เปิดทำการทุกวัน เวลา 16.00-23.00 น	2025-02-26 20:03:59.617509	16.4177	102.8197
97	อุทยานแห่งชาติภูเวียง	อุทยานแห่งชาติภูเวียง  มีความโดดเด่นด้วยรอยเท้าไดโนเสาร์และทัศนียภาพที่งดงาม เช่น น้ำตกตาดฟ้าและผาชมตะวัน เหมาะสำหรับการเดินป่าและตั้งแคมป์ นอกจากนี้ยังมีกิจกรรมการศึกษาเกี่ยวกับธรรมชาติ ชมทิวทัศน์ผืนป่าภูเวียงอีกด้วย 	ชาวไทย : ผู้ใหญ่ 40 บาท เด็ก 3-14 ปี 10 บาท ชาวต่างชาติ : ผู้ใหญ่ 200 บาท เด็ก 100 บาท รถจักยานยนต์ : คันละ 20 บาท รถยนต์ 4 ล้อ : คันละ 30 บาท	ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/Phuwiangnp71	เปิดทำการทุกวัน เวลา 08.30 - 16.30 น.	2025-02-26 20:03:59.617509	16.698008612736583	102.22321031168782
108	แฟรี่พลาซ่า	แฟรี่พลาซ่า ขอนแก่น เป็นห้างสรรพสินค้าใจกลางเมืองที่มีบรรยากาศท้องถิ่นและเหมาะสำหรับครอบครัวและนักท่องเที่ยว ภายในห้างมีร้านค้าและบริการหลากหลาย ตั้งแต่ร้านแฟชั่น เครื่องสำอาง และอุปกรณ์อิเล็กทรอนิกส์ ไปจนถึงร้านอาหารคาเฟ่ที่เสิร์ฟอาหารคลีนและสมุนไพร รวมถึงมีโรงภาพยนตร์ที่ให้บริการภาพยนตร์ใหม่ ๆ อย่างต่อเนื่อง​	-	69/9 ถนนกลางเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/fairyplaza	เปิดทุกวัน : 11.00 -20.00 น.	2025-02-26 20:03:59.617509	16.423835470222816	102.8336110640586
105	วัดกู่ประภาชัย	วัดกู่ประภาชัย หรือ กู่บ้านคำน้อย ตั้งอยู่ใน อำเภอน้ำพอง จังหวัดขอนแก่น เป็นกลุ่มโบราณสถานที่สร้างขึ้นตั้งแต่สมัยของ พระเจ้าชัยวรมันที่ 7 แห่งอาณาจักรเขมรโบราณ เมื่อพุทธศตวรรษที่ 18 มีสถาปัตยกรรมเป็นศิลปะแบบขอม ภายในมีพระพุทธรูปประดิษฐานอยู่ รวมถึงหินก้อนใหญ่ที่มีความเชื่อว่าเป็นหินศักดิ์สิทธิ์ ตั้งอยู่บนแท่นบูชาให้ผู้คนเข้ามากราบไหว้	เข้าชมฟรี	หมู่ 1 ตำบลบัวใหญ่ อำเภอน้ำพอง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100069911774903	เปิดทำการทุกวัน 06.00-18.00 น.	2025-02-26 20:03:59.617509	16.611912451499293	102.93028224608
112	นิวเฮงโภชนา	เรียกได้ว่าเป็นร้านอาหารระดับตำนานเก่าแก่ของขอนแก่นครับ โดดเด่นด้วยอาหารจีน และอาหารไทย รสชาติเข้มข้น ดั้งเดิมตามแบบฉบับร้านในตำนานครับ สามารถแวะมาฝากท้องแบบเร็วๆ ด้วยอาหารจานเดียว หรือว่าจะยกแก๊งค์มาทานข้าวกันเป็นกลุ่มก็ได้เลยครับ โดยห้ามพลาดลิ้มลอง “ยำปลาดุกฟู” เมนูขึ้นชื่อของร้านนี้ที่เขาบอกกันว่าเด็ดสุดๆ		ถนนประชาสโมสร ตำบลในเมือง อำเภอเมือง จังหวัดขอนแก่น	\N	เปิดทำการทุกวัน เวลา 10.00 – 20.00 น.​ (ปิดวันอาทิตย์)	2025-02-26 20:04:08.241284	16.43769403926405	102.84282739581502
113	กังหันน้ำ	ร้านอาหารซีฟู้ดเจ้าดังแห่งขอนแก่น ที่ขนอาหารทะเลสดๆ มาเสิร์ฟถึงขอนแก่นครับ มีโซนให้เลือกนั่งทั้งด้านในและด้านนอก ท่ามกลางบรรยากาศสุดชิลริมบึง และดนตรีสดสุดจอยๆ ครับ แน่นอนเรื่องของรสชาติบอกเลยว่าจัดจ้านถึงใจ และซีฟู้ดเนื้อหวาน ที่ไม่ว่าจะสั่งเมนูไหนก็อร่อย		641 ถนนศรีจันทร์ ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100063584293664	เปิดทำการทุกวัน 16.00 – 24.00 น.	2025-02-26 20:04:08.241284	16.43775215222954	102.79451386935501
114	จ้วดคาเฟ่	หากใครมองหาร้านอาหารบรรยากาศดีๆ นั่งชิลทานอาหาร จ้วดคาเฟ่ ก็เป็นอีกหนึ่งร้านที่เหมาะสุดๆ ครับ ท่ามกลางบรรยากาศสบายๆ กว้างขวาง นั่งชิลได้ทั้งช่วงกลางวัน และช่วงกลางคืน พร้อมเสิร์ฟความอร่อยทั้งเมนูของคาว ของหวาน เครื่องดื่มแบบครบ จบในร้านเดียว แถมยังเต็มไปด้วยมุมถ่ายรูปสวยๆ		123 หมู่ที่ 1 ถนนเลี่ยงเมืองขอนแก่น ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/Juadcafe	เปิดทำการเวลา 11.00 - 22.00 น.	2025-02-26 20:04:08.241284	16.50211140941501	102.87442304978325
116	บ้านคนรักหมูกรอบ	ทีมหมูกรอบมาทางนี้ ร้านบ้านคนรักหมูกรอบ ขอนแก่น “หมูกรอบ“ ที่ทางร้านใส่ใจตั้งแต่การคัดเลือกวัตถุดิบ กรรมวิธีการทอดการจัดเก็บ หมูกรอบทางร้านเน้นมันน้อยๆ กรอบรอบด้านกำลังพอดี เมนูแนะนำ กะเพราหมูกรอบ หมูกรอบคั่วพริกเกลือ ข้าวผัดหมูกรอบ ต้มยำมาม่าหม้อไฟ ตำถั่วหมูกรอบ ไข่ยางมะตูม ทางร้านรับจัดเบรค อาหารกลางวัน ลูกค้าสามารถติดต่อทางเพจเข้ามาสอบถามได้		177 ถนนมะลิวัลย์ ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น จังหวัดขอนแก่น 	https://www.facebook.com/aumm2501	เปิดทำการทุกวัน เวลา 8.00-17.00 น. หยุดทุกวันพฤหัสบดี	2025-02-26 20:04:08.241284	16.44353816480552	102.80584344978209
106	ตลาดเปิดท้ายมข.	เปิดท้าย มข.เดินเล่นเช็กอินเเหล่งละลายทรัพย์ของหนุ่มสาวชาวขอนแก่น มีเสื้อผ้าหลากหลายแบบหลากหลายสไตล์และไปช้อปเสื้อผ้าของมือสองแบบจุก ๆ ฟินร้านเด็ดเต็มอิ่ม ของกินก็จะมีหลากหลายครบรสชาติ เรียกได้ว่าเป็นที่กินขอนแก่นแบบจุกๆ		ศูนย์ประชุมอเนกประสงค์กาญจนาภิเษก มหาวิทยาลัยขอนแก่น ตำบลในเมือง อำเภอเมือง ขอนแก่น	https://www.facebook.com/profile.php?id=61556839171895	มีเฉพาะ วันศุกร์-อาทิตย์ เวลา17.00-22.00 น แต่ก็ไม่ได้มีทุกอาทิตย์ (สามารถติดตามข่าวสารได้ที่ FB: ตลาดเปิดท้ายหอกาญ มข. )	2025-02-26 20:03:59.617509	16.4471058521016	102.81924751353561
117	ประชาสโมสร	ร้านอาหารขอนแก่นในตำนาน เขาบอกว่า ถ้ามาเที่ยวขอนแก่นแล้วยังไม่เคยแวะร้านนี้ ถือว่ายังมาไม่ถึงถิ่นนะครับ “ร้านประชาสโมสร” ร้านอาหารที่เปิดมาค่อนข้างนาน ถ้าถามคนขอนแก่นไม่มีใครไม่รู้จักร้านนี้ โดดเด่นสไตล์วัยเก๋าด้วยการตกแต่งแบบย้อนยุค คลาสสิกเลยครับ ส่วนในเรื่องของรสชาติอาหารได้ลองต้องตราตรึงใจ อร่อยเด็ดสมมงฯ ร้านอาหารแห่งขอนแก่นจริงๆ เมนูแนะนำ ต้มแซ่บ ยำปลาดุกฟู		90/532 ถนนเฉลิมพระเกียติ อำเภอเมือง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100659778573203	เปิดทำการทุกวัน เวลา 11.00 – 01.00 น.	2025-02-28 17:48:09.737665	16.426902990815325	102.84237820133285
118	สมายล์ ขอนแก่น	ร้านอาหารขอนแก่นบรรยากาศดีสุดชิล ริมแม่น้ำ พร้อมเสิร์ฟหลากหลายความอร่อย ตั้งแต่อาหารไทย อาหารอีสาน ไปจนถึงอาหารไทยฟิวชัน รสชาติการันตีความอร่อย มีโซนให้นั่งทั้งด้านใน และด้านนอกครับ ซึ่งโซนด้านนอกบอกเลยว่าชิลสุด		280 ถนนเลียบบึงหนองโคตร ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/smilekhonkaen	เปิดทำการทุกวัน เวลา 11.00-23.00 น.	2025-02-28 17:48:09.737665	16.42793306472115	102.79861503073218
125	ก๋วยเตี๋ยวออนซอน	ก๋วยเตี๋ยวออนซอน ร้านก๋วยเตี๋ยวน้ำตกเนื้อพรีเมียมขอนแก่น ลูกชิ้นโฮมเมด ทั้งเนื้อ และหมู ใครเป็นสายเนื้อ และชอบก๋วยเตี๋ยวบอกเลยว่าห้ามพลาดร้านนี้! ก๋วยเตี๋ยวเนื้อของที่นี่จะใช้เนื้อแบบพรีเมียม คุณภาพดี แต่ราคาเข้าถึงง่าย รสชาติเข้มข้น พิถีพิถันในการปรุง นอกจากก๋วยเตี๋ยวแล้วก็ยังมีเมนูข้าวหน้าเนื้อ และพิเศษสุด ๆ ที่ร้านมีเมนู เนื้อพิคานย่า ที่มีความนุ่มละมุน ละลายในปาก		448/1 หมู่27 ต.ศิลา อ.เมืองขอนแก่น จ.ขอนแก่น	https://www.facebook.com/onzon.noodlekk	เปิดทำการทุกวัน เวลา 11.00 - 22.00 น. (รับออเดอร์สุดท้าย 21.00 น.)	2025-02-28 17:57:38.493173	16.48189330405059	102.81944075956928
99	อุทยานแห่งชาติภูเก้า-ภูพานคำ	อุทยานแห่งชาติภูเก้า-ภูพานคำ อยู่ในพื้นที่ครอบคลุมอำเภอโนนสัง จังหวัดหนองบัวลำภู และอำเภออุบลรัตน์ จังหวัดขอนแก่น โดยภูเก้านั้นจะเป็นภูเขาหินทราย มีดินลูกรัง และดินร่วนปนทราย เป็นเทือกเขาสองชั้น ส่วนภูพานคำ เป็นแนวทิวเขายาวต่อเนื่องกันเรียงตัวกัน ลักษณะคล้ายช้อน มีพื้นที่ของอ่างบนที่ราบต่ำลุ่มน้ำพอง ซึ่งจะกลายเป็นทะเลสาบหลังสร้างเขื่อนอุบลรัตน์ และเป็นที่ตั้งของที่ทำการอุทยานฯ	ค่าเข้าชม: คนไทย ผู้ใหญ่ 20 บาท เด็ก 10 บาท (อายุต่ำกว่า 3 ขวบ/พระ-นักบวช(พำนักในไทย)/ผู้สูงอายุ(ชาวไทย)/ผู้พิการ เข้าฟรี) ชาวต่างชาติ ผู้ใหญ่ 100 บาท เด็ก 50 บาท ค่ารถจักรยานยนต์ 20 บาท ค่ารถยนต์ 30 บาท	หมู่ที่ 6 ต.บ้านค้อ อ.โนนสัง จ.หนองบัวลำภู หรือ ตู้ ปณ.2 ปทจ.อุบลรัตน์ จ.ขอนแก่น	https://www.facebook.com/phukao.np	เปิดให้เข้าชม : 08.30-16.30 น.	2025-02-26 20:03:59.617509	16.81167979781588	102.61166328841173
122	ข้าวมันไก่ โจรสลัด	ข้าวมันไก่สูตรไหหลำและสูตรสิงคโปร์ เนื้อนุ่ม ไม่ตบแบน ตับนุ่มละมุนลิ้น ไก่ชิ้นใหญ่เต็มปากเต็มคำ น้ำจิ้มอร่อย รับรองไม่ผิดหวัง เน้นความสะอาด สุขลักษณะ เมนูที่ร้านมีทั้งสูตรไหหลำ สูตรสิงคโปร์ ไก่นุ่ม ไม่ตบแบน ตับเนียนละมุน ข้าวนุ่มไม่แข็ง ไก่ชิ้นใหญ่เต็มปากเต็มคำ น้ำจิ้มอร่อยแซ่บ ต้องลอง		567/18 เมือง ขอนแก่น 40000	https://www.facebook.com/profile.php?id=61572855407339	เปิด 07.00 - 13.00 น. (ปิดวันจันทร์)	2025-02-28 17:48:09.737665	16.41148336741107	102.8174193069905
124	ข้าวซอยแม่อารมย์	ทานข้าวซอย จิบกาแฟ ชมวิวต้นไม้ กับการประยุกต์ข้าวซอยให้ทานง่าย ในสไตล์ฟิวชั่น เหนือ ๆ มีกลิ่นไออีสานนิด ๆ แบบทำให้ครอบครัวทานที่บ้าน		129-3 ถนนชุมแพ ตำบลชุมแพ อำเภอชุมแพ จังหวัดขอนแก่น	https://www.facebook.com/arrommotherchumphae	เปิดเวลา 08.30 - 16.00 น.(หยุดทุกวันศุกร์)	2025-02-28 17:57:38.493173	16.53638535615846	102.08320916142301
77	MiniMal Seafood by Ranjana	สุดยอดร้านซีฟู๊ดลับแห่งประเทศขอนแก่น หลังจากตระเวนไปกินร้านซีฟู๊ดดังๆในของแก่นหมดแล้ว บอกเลยว่าสู้ร้านนี้ไม่ได้เลยแม้แต่นิดเดียว ความสด อร่อย ความเด้งฉ่ำของเนื้อน้ำจิ้มที่สุดยอด ยกให้เป็นอันดับหนึ่ง เป็นร้านที่ไม่สามารถหากินที่ไหนเหมือนได้ ราคาเรียกได้ว่าเหมาะสมกับขนาด กินเสร็จไม่รู้สึกว่าถูกโกง คุ้มค่าเงินทุกบาท แนะนำว่าคนจะมากินคือคนที่ต้องชิลและรอได้นิดนึ่ง ถ้าจะมากินซีฟู๊ดรีบๆอันนี้ไม่แนะนำ		305-307 ถ.หน้าเมือง-รื่นจิตร ต.ในเมือง อ.เมือง จ.ขอนก่น	https://www.facebook.com/MiniMalSeafood	เปิดทุกวัน 12.00 - 23.00 น.	2025-02-26 20:03:48.553143	16.42496813140544	102.83379660560121
44	Seasons27 @Ad Lib Hotel	ทานอาหารพร้อมชมวิวสูงของเมืองขอนแก่นต้องมาที่ “Seasons27 @Ad Lib Hotel” ร้านอาหารตั้งอยู่บนโรงแรม Ad Lib ขอนแก่น ชั้นที่ 27 จุดเด่นของร้านนี้นอกจากตั้งอยู่บนโรงแรมแล้ว หากคุณเลือกนั่งริมหน้าต่างก็จะได้ชมวิวเมืองขอนแก่น เพลิดเพลินกับอาหารอิตาเลี่ยนชั้นยอดอีกด้วย โดยที่นั่งเป็น indoor แอร์เย็นสบาย ร้านนี้ได้รับการโหวตเป็นร้านอาหารยอดนิยมจากเว็บไซต์อีกด้วย ด้วยการคัดวัตถุดิบชั้นดี ปรุงด้วยความพิถีพิถัน พร้อมการตกแต่งทำให้อาหารมีรสชาติยอดเยี่ยมสำหรับเมนูอิตาเลียน		โรงแรม Ad Lib ขอนแก่น, ชั้น 27 ถนนศรีจันทร์  อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/SeasonsTwentySeven	เปิดทำการทุกวัน เวลา 06.00 – 23.00 น.	2025-02-26 20:03:29.975951	16.430169526718483	102.83252059025708
131	House of Moods & Good Everyday	ร้านอาหารที่มี Indoor Kids Zone ในห้องแอร์เย็นๆที่เดียวในขอนแก่น รับรองว่าเด็กๆต้องชอบ ผู้ปกครองสามารถสามารถนั่งชิลทานอาหารและเครื่องดื่มเย็นๆได้อย่างสบายใจ ร้านเปิดตั้งแต่ช่วงสายของวัน มีดนตรีสดเล่นให้ฟังทุกวัน เมนูแนะนำแสนอร่อยของร้าน อย่าง Goodแหนมเนือง ที่ไม่ใส่ผงชูรส ใครที่แพ้สามารถทานได้เลย อาหารไทนและกับแกล้ม มีเมนูสำหรับเด็ก เป็นร้านอาหารครอบครัวที่แท้จริง ๆ พร้อมกับน้ำผลไม้และน้ำสำหรับผู้ใหญ่		80 ถนนหลังเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/MoodsAndGoodKKC	เปิดทำการทุกวัน 10.30 – 00.00 น.	2025-02-28 18:24:06.519368	16.433259461652607	102.83802834422396
128	DN แดงหน่องแหนมเนือง	อีกหนึ่งร้านไปเที่ยวขอนแก่น ต้องมากินให้ได้ครับ เรียกได้ว่าเป็นร้านขึ้นชื่อขอนแก่นเลย อย่าง DN แดงหน่องแหนมเนือง หรือร้านอัมพรแหนมเนืองเก่า สร้างตำนานความอร่อยมาแล้ว 40 ปี สำหรับใครที่ชอบกินอาหารเวียดนาม ขอแนะนำเลย ที่นี่มีให้เลือกหลากหลายเมนู รสชาติถูกปากอร่อยถูกใจแน่นอน เมนูที่ต้องสั่งเรียกได้ว่าสั่งกันทุกโต๊ะ แหนมเนือง, เมี่ยงสด, ปากหม้อ และหมูตะไคร้พันหมี่ รับรองว่าเด็ดทุกจาน		588/1-2 ถ.กลางเมือง ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/DNNamnueng	วันจันทร์ – วันพฤหัสบดี: 07.00 – 18.00 น. วันศุกร์ – วันอาทิตย์: 07.00 – 18.30 น.	2025-02-28 18:24:06.519368	16.40993291871244	102.83381993258445
86	Khonkaen Exotic Pets	Khonkaen Exotic Pets & The Fountain Show เป็นสวนสัตว์ที่รวบรวมสัตว์แปลกที่เลี้ยงแบบปล่อยภายในสวนสัตว์ น้องๆสามารถให้อาหารได้อย่างใกล้ชิด ภายในสวนสัตว์มีเจ้าตัวเรียกแขกอย่างคาปิบาร่า ที่แสนจะเป็นมิตรมากๆสามารถลูบคล้ำจับน้องได้เลยนอกจากนี้ทางสวนสัตว์ยังมีกรงนกขนาดใหญ่สูงมากๆสามารถขึ้นไปชมวิวได้อีกด้วย	ค่าบริการ ผู้ใหญ่ 150 บาท เด็ก 75 บาท(สูงไม่เกิน100cm)	ซอยนวลหง ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/kkepfs888/	เปิดให้บริการทุกวัน 10.00-18.00 น.	2025-02-26 20:03:59.617509	16.45921778169639	102.79311124051934
21	Dragon Grill BBQ	ร้านปิ้งย่างกระทะทองเหลืองนี้มีน้ำจิ้มบาร์บีคิวรสเด็ดสูตรเฉพาะสำหรับจิ้มเนื้อ ทางร้านใช้วัตถุดิบคุณภาพจากเบทาโกร สด สะอาด อร่อย วัตถุดิบที่น่าสนใจคือ เบคอน เนื้อหมูสามชั้น เนื้อโคขุนสไลซ์ เมื่อจิ้มกับน้ำจิ้มของทางร้าน รับประทานพร้อมกับข้าวผัดกระเทียม จะได้รสชาติละมุนลงตัว ยิ่งทานคู่กับกะหล่ำปลีซอยตัดเลี่ยน ทานได้เรื่อย ๆ ไม่มีเบื่อ แถมทางร้านยังมีไอศกรีมหลากรสชาติและเฉาก๊วยนมสดเป็นของหวานตบท้ายมื้อด้วย	ราคาบุฟเฟ่ต์เพียง 242.- บาท รีฟีล 33.- บาท หรือเครื่องดื่มอื่นๆทางร้านมีบริการ	498 หมู่ที่ 27 บ้านโนนม่วง ตำบลศิลา อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100063623076560	เปิดทำการทุกวัน เวลา 16.00 – 22.00 น.	2025-02-26 18:30:51.29058	16.489713911491428	102.81894777914252
134	ตั้งแต่เด็ก การ์เด้น	คาเฟ่สไตล์การ์เด้นใจกลางเมืองขอนแก่น คาเฟ่ที่เหมาะสำหรับครอบครัว ร้าน “ตั้งแต่เด็ก การ์เด้น” เป็นคาเฟ่สไตล์การ์เด้นใจกลางเมืองขอนแก่น ที่มีบริการอาหาร เครื่องดื่ม สนามเด็กเล่น และกิจกรรมต่างๆ สำหรับครอบครัว มีพื้นที่กว้างขวางและปลอดภัย มีบริการครบครัน ร้านมีเครื่องเล่นและของเล่นเด็กมากมาย ทั้งสะพานไม้ บันได สไลเดอร์ไม้ ที่ปีนป่ายสำหรับเด็กและผู้ใหญ่ พร้อมมุมถ่ายรูปที่น่าสนใจ นอกจากนี้ยังมีบริการอาหาร เครื่องดื่ม ทั้งกาแฟ ไม่มีกาแฟ เบเกอรี่ และเครื่องดื่มแอลกอฮอล์ให้เลือกหลากหลาย เพื่อให้ครอบครัวได้เล่นสนุกและอิ่มอร่อยครบจบในร้านเดียว		217/56 13 รอบเมือง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/tangtaedekgarden	เปิดทำการทุกวัน เวลา 09.00 – 23.00 น.	2025-02-28 18:24:06.519368	16.424696895753193	102.84005873073224
136	สวนอาหารคานบุญ	สวนอาหารที่มีซุ้มหลังคามุงจากให้นั่งแบบส่วนตัว มีทั้งรับลมเย็นข้างนอก หรือจะชอบเย็นฉ่ำแบบห้องแอร์ ก็สามารถเลือกได้ตามใจลูกค้า อาหารอร่อยถูกปาก บรรยากาศถูกใจ มุมถ่ายรูปสวย ๆ เพียบ		111 บ้านขามเปี้ย ตำบลกู่ทอง อำเภอเชียงยืน จังหวัดมหาสารคาม	https://www.facebook.com/KhanboonRestaurant	เปิดทุกวัน 10:30–20:30 น.	2025-02-28 18:34:48.456358	16.442958545603176	102.98222669025722
140	บ่าวบอยซอยถี่ ขอนแก่น	อาหารอีสานรสจัดจ้าน สารพัดเมนู ทำสดๆใหม่ๆจานต่อจาน คัดเลือกวัตถุดิบมาอย่างดี เติมวันละหลายรอบ สดๆ ดิ้นๆ รับประกันความฟินแบบอินถึงแก่นแท้ในแต่ละเมนู  แวะมาลองลิ้มชิมรสกัน		446 หมู่ 12 ถนนมิตรภาพ ตำบลเมืองเก่า จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=61563038080124	เปิดทุกวัน(ไม่มีวันหยุด) 11.00 - 23.00 น.	2025-02-28 18:34:48.456358	16.39355699632607	102.81228440004293
96	อุทยานแห่งชาติภูผาม่าน	อุทยานแห่งชาติภูผาม่าน อากาศร้อนๆ แบบนี้ หนีทะเล มาหาสถานที่ไปนอนแช่น้ำใสๆ ไหลเย็นๆ จากธรรมชาติ เอาให้ฉ่ำหนำใจไปเลย ที่มีน้ำไหลเย็นชุ่มฉ่ำตลอดทั้งปี ท่ามกลางบรรยากาศของธรรมชาติที่สงบร่มรื่นงดงาม และโดดเด่นด้วยเทือกเขาหินปูนที่มีหน้าผาตัดตรงลงมาคล้ายผ้าม่าน ภายในมีจุดท่องเที่ยวที่น่าสนใจหลายจุดทั้งถ้ำน้ำตก รวมถึงพื้นที่กางเต็นท์ที่บรรยากาศสวยงาม	ชาวไทย : ผู้ใหญ่ 20 บาท เด็ก 10 บาท ชาวต่างชาติ : ผู้ใหญ่ 100 บาท เด็ก 50 บาท ค่ายานพาหนะ รถจักรยานยนต์ 20 บาท รถยนต์ 30 บาท	201 หมู่ที่ 11 ตำบลนาหนองทุ่ม อำเภอชุมแพ จังหวัดขอนแก่น	https://www.facebook.com/phuphaman72	เปิดทำการทุกวัน เวลา 08.00 -16.30 น.	2025-02-26 20:03:59.617509	16.75670867614006	101.96876434608288
183	คีรี ธารา เขื่อนอุบลรัตน์	ร้านอาหารบรรยากาศสุดชิลล์ ริมน้ำใกล้เขื่อนอุบลรัตน์ รายล้อมด้วยธรรมชาติและวิวสุดผ่อนคลาย มีที่นั่งกระท่อมกลางน้ำสุดเก๋ เสิร์ฟอาหารทะเลสด ๆ อาหารอีสานรสจัดจ้าน และเมนูเครื่องดื่มหลากหลาย เหมาะสำหรับครอบครัว คู่รัก และเพื่อน ๆ ที่อยากมานั่งชิลล์ ฟินกับวิวและอาหารอร่อย ๆ	\N	41 หมู่ 14 ต.บ้านดง อ.อุบลรัตน์ จ.ขอนแก่น	https://www.facebook.com/KeereeTaraUbolratanaDam	เปิดทำการทุกวัน เวลา 09:00 - 21:00 น.	2025-03-08 15:51:51.009988	16.78311749565914	102.62877988285331
141	ชาม Charm Kitchen	🥄 คอนเซปต์ของทางร้าน คือ อาหารไทยดีกรีระดับอินเตอร์ ซึ่งแต่ละเมนูที่เสิร์ฟมาคุณภาพคับแน่นจานมากครับ ด้วยทั้งวัตถุดิบและหน้าตาอาหารที่เย้ายวนให้ลิ้มลอง~ ที่สำคัญไม่ใส่ผงชูรสทุกจาน แต่รสชาติออกมากลมกล่อมแถมเฮลตี้	ราคาเริ่มต้นที่ 50 บาท เท่านั้น !!!	22/4 หมู่ที่ 6 ถ.ศรีจันทร์ ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/CharmKitchen1/?locale=th_TH	เปิดทำการทุกวันเวลา 10.00 - 21.00 น.	2025-03-01 10:24:13.443972	16.42719692939715	102.87017498099394
142	The Concept Aromatic Thai Cuisine	ร้านอาหารไทยฟิวชั่นนานาชาติในราคาเป็นกันเอง ไปลองอาหารฟิวชั่นแบบจัดหนัก จัดเต็ม กันที่ร้านThe Concept ที่นี่เค้ามีเมนูทั้งอาหาร และเครื่องดื่มให้เลือกฟินมากกว่า 150 เมนู ! แถมราคาก็เป็นมิตรกับกระเป๋า ใกล้สนามบินขอนแก่น กินได้ ไม่ต้องกลัวตกเครื่อง 🍕😍		192 airport road tamboon baanped , Khonkhaen, Thailand, Khon Kaen	https://www.facebook.com/concept.khonkaen/?locale=th_TH	เปิดให้บริการทุกวัน ตั้งแต่เวลา 11.30-22.00 น.	2025-03-01 10:27:20.166685	16.450634419732555	102.78399296956931
27	เจนหมูกระทะ	ร้านหมูกระทะแบบตักชั่งกิโล ราคาวัยรุ่น มีของให้เลือกเยอะ บุฟเฟ่ต์ ผัก ซุป วุ้นเส้น น้ำจิ้ม เติมได้ไม่อั้น!! มีน้ำจิ้มให้เลือก 3 รสชาติ ทั้งน้ำจิ้มเจนต้นตำรับ ซีฟู๊ดนมสด และน้ำจิ้มงา	แบบตักชั่งกิโล กิโลกรัมละ 249 บาท	96 ถนนศรีนวล ตำบลในเมือง อำเภอเมือง จังหวัดขอนแก่น	https://www.facebook.com/Janebbqkkc	เปิดทำการเวลา 12.00 - 23.00 น.(เปิดทุกวัน)	2025-02-26 18:30:51.29058	16.390982842303817	102.8449085458703
145	ตำไทเลย	 ร้านส้มตำรสชาติเด็ด สั่งเผ็ดจี๊ดระดับ 50 เม็ด มีทั้งพริกสด พริกแห้ง เผ็ดจนน้ำมูก น้ำตาไหล ส่วนขนมจีนซาวน้ำของทางภาคอีสาน รสชาติเข้มข้น ผักเยอะ ไก่ทอดทอดได้แห้งมาก อร่อยมาก		FR6C+4M8 ถนน อดุลยาราม ตำบลในเมือง อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=100057318915182	เปิดทำการ 10.30-21.00 น. (ร้านเปิดทุกวัน) 	2025-03-01 11:02:29.760835	16.460450699403662	102.82183084237198
61	ครัวสุพรรณิการ์ บาย คุณยายสมศรี	อาหารของที่นี่ปรุงตามสูตรของคุณยาย เป็นการผสมผสานเมนูเด็ดของชายฝั่งทะเลตะวันออก (ตราดและจันทบุรี) กับอาหารอีสานยอดนิยม ใช้วัตถุดิบจากชายฝั่งทะเลตะวันออก อย่างน้ำปลาพรีเมียม กะปิ และปลาเค็ม เมนูเด็ดคือหมูชะมวง เนื้อหมูตุ๋นจนนุ่มชุ่มฉ่ำ รสเปรี้ยวนิด ๆ จากใบชะมวง เลือกนั่งได้สองโซนทั้งด้านในและด้านนอก รวมถึงโต๊ะบริเวณบ้านต้นไม้ที่แสนร่มรื่น		130/9 ถนนโพธิสาร ตำบลพระลับ อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/supannigahome	เปิดทำการเวลา 11:30 - 21:00 น.	2025-02-26 20:03:38.571906	16.41237135954874	102.85861421538759
147	ดูฟาร์ม คาเฟ่ (Dofarm Cafe)	ขอยกให้เป็นคาเฟ่ขอนแก่น สุดครบเครื่อง เพราะมีให้เลือกครบทุกความต้องการ ไม่ว่าจะเป็นอาหาร เครื่องดื่ม เค้ก กาแฟ พร้อมบรรยากาศห้อมล้อมไปด้วยธรรมชาติ อาหารอร่อยแถมมีโซนที่นั่งให้เลือกหลากหลาย ตามแต่ใจอยากจะใกล้ชิดธรรมชาติกันได้เลยครับ แต่บอกเลยว่าฟินแน่นอน	ราคาเฉลี่ยต่อหัว: 250 – 500 บาท	404 หมู่ 18 ตำบลพระลับ อำเภอเมือง จังหวัดขอนแก่น	https://www.facebook.com/dofarmcafe	เปิดให้บริการทุกวัน คาเฟ่ 10:00-18:30 น.	2025-03-02 18:27:22.441979	16.426562066464726	102.88968695956825
146	ขอนแก่น แสนแซ่บ 	ขอนแก่น แสนแซบ เมนูเด็ด น่าลอง 〰️ ตำสับปะรดหอยแครง เมนูนี้สายแซ่บต้องลอง รสชาติเข้มข้นทุกอณูไปเล้ย 〰 ตำมั่ว แซ่บ นัว หอมปลาร้า เครื่องแน่นสุดด 〰 ไก่ย่าง เนื้อเด้งฉ่ำ		941 หมู่12 ตำบล ศิลา 40000, Khon Kaen, Thailand, Khon Kaen	https://www.facebook.com/aofsinpisut/photos?locale=th_TH	เวลาเปิด-ปิด 11:30-20:00 น. (ติดตามวันหยุกผ่านเพจร้าน)	2025-03-01 11:05:18.794808	16.480980816740157	102.8160918553406
148	ป่าสนดงลาน	🍁 ป่าสนดงลาน ภูผาม่าน 🍁 โลเคชั่นสุดคลู ที่ใครผ่านจะต้องแวะ\n📸☘️🌲🌲🌲 ชวนเพื่อนๆไปถ่ายรูปชิคๆกัน ชมวิวป่าสน ยืนงงในดงลานแบบฟินๆ สุดแสนโรแมนติก ไม่ต้องไปไกลถึงที่อื่น อีสานบ้านเฮาก็มีเด้อ!! \n*ข้อควรระวัง ในบางช่วงที่แห้งแล้งมาก ๆ อาจจะทำให้กิ่งและลำต้นของต้นสนมีความเปาะบางเจ้าหน้าที่จึงจำเป็นต้องทำการปิดสวนสนดงลานชั่วคราว	เข้าชมฟรี	ตำบล นาหนองทุ่ม อำเภอชุมแพ ขอนแก่น 40290	\N	เปิดบริการ : เปิด - ปิด : 08.30น.-16.30 น. (เปิดทุกวัน)	2025-03-06 18:27:24.150536	16.812118708333664	101.98735740190345
149	น้ำตกตาดฟ้า	น้ำตกตาดฟ้า เป็นน้ำตกที่สวยที่สุดของอุทยานแห่งชาติภูเวียง น้ำตกลงมาจากหน้าผาหินชั้นเดียว สูงราว 15 เมตร ด้านล่างเป็นแอ่งหินทรายสีแดง รอบๆบริเวณมีความร่มรื่นด้วยร่มเงาไม้	ค่าเข้า: เด็ก 10 บาท / ผู้ใหญ่ 20 บาท	อุทยานแห่งชาติภูเวียง หมู่บ้านโนนสูง ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/Phuwiangnp71	เปิดให้เข้าชม : 08.30 – 16.30 น. (ปิดทำการชั่วคราว)	2025-03-06 18:59:52.085471	16.79088481245853	102.25942368841129
85	สวนสัตว์ขอนแก่น	สวนสัตว์ขอนแก่น เป็นสวนสัตว์ขนาดใหญ่ตั้งอยู่ใน อำเภอเขาสวนกวาง สามารถเป็นสถานที่พักผ่อนหย่อนใจ เดินเล่นผ่อนคลายชิลๆ มีสัตว์ต่างๆ จากทั่วโลกให้เพลิดเพลินตา เช่น ยีราฟ หมี เสือโคร่ง สิงโตขาว ม้าลาย แรด ฮิปโป กวาง แมวน้ำ นกฟลามิงโก้ นกยูง ลิง วอลลาบีเผือก ไฮยีน่า เมียร์แคท และอื่นๆ อีกเพียบ! พร้อมกิจกรรมมากมาย ไม่ว่าจะเป็นการให้อาหารกวางอย่างใกล้ชิด รวมถึงการแสดงสุดตื่นตาตื่นใจของเหล่าเจ้าอุ๋ง(แมวน้ำ) ที่พร้อมมาสร้างรอยยิ้มและเสียงหัวเราะให้กับทุกคน	ค่าเข้า : ผู้ใหญ่ 100 บาท เด็ก 20 บาท ผู้สูงอายุ 60 ปีขึ้นไปเข้าฟรี อัตราค่าเข้าสวนน้ำ ผู้ใหญ่ 30 บาท เด็ก 20 บาท	88 หมู่ที่ 8 สวนสัตว์ขอนแก่น อำเภอเขาสวนกวาง จังหวัดขอนแก่น	http://www.khonkaen.zoothailand.org/index.php	เปิดทำการทุกวัน 08.00 – 16.30 น.	2025-02-26 20:03:59.617509	16.845927390887024	102.89651155476265
162	ลานนับดาว	ชวนมาสัมผัสบรรยากาศที่โอบล้อม ด้วยธรรมชาติที่ "ลานนับดาว" อุทยานแห่งชาติน้ำพอง\nอุทยานแห่งชาติน้ำพองชวนนักท่องเที่ยวมาสัมผัสบรรยากาศที่ "ลานนับดาว" ชมพระอาทิตย์ตกดินและลานกางเต็นท์พักแรม ซึ่งลานนับดาวเป็นพื้นที่สำหรับกางเต็นท์ แคมป์ปิ้ง	เข้าชมฟรี	JHF9+VFW ขก.2063 ตำบล บ้านผือ อำเภอหนองเรือ ขอนแก่น 40240	https://www.facebook.com/namphong.np	ติดตามเวลาเปิดลสนนับดาวที่ที่เพจ อุทยานแห่งชาติน้ำพอง	2025-03-08 12:41:18.868913	16.624899869849877	102.56883847121118
163	อิ่มโอโซนคาเฟ่	ออกเมืองมาหาบรรยากาศติดทุ่งนาฟินๆ ขับรถ 20 นาทีถึง !! ที่ อิ่มโอโซนคาเฟ่ ช่วงนี้นาข้าวกำลังเขียวขจี บรรยากาศฟินเกินนต้าน !! ช่วงเย็นๆ บรรยากาศดี๊ดี มีเพลงฟังเพราะๆ พิเศษสุดทุกวันเสาร์-อาทิตย์บ่ายโมง มีดนตรีสด ทุกสัปดาห์		20/1 หมู่บ้านหนองบัว ตำบลหนองบัว อำเภอบ้านฝาง จังหวัดขอนแก่น	https://www.facebook.com/ImOzone.CafeandFarm	เปิดทำการทุกวัน เวลา 10:00–22:00 น.  (ครัวปิด 21.00น.)	2025-03-08 15:30:46.024655	16.465812949946695	102.61257244237208
156	ศาลหลักเมือง	ศาลหลักเมืองขอนแก่น เป็นที่ตั้งของหลักเมืองขอนแก่น ที่เป็นสิ่งศักดิ์สิทธิ์คู่บ้านคู่เมืองของจังหวัดขอนแก่นมาอย่างยาวนาน โดย เสาหลักเมือง นี้ เป็นเสมาหินทรายสมัยทวารวดี ที่มีร่องรอยการลงรักปิดทองเป็นลวดลายไทย มีการผูกผ้าพันรอบเสา ส่วนโคนเสาหลักเมืองนั้น จะก่อเป็นฐานปูนมีลายรูปดอกบัว ล้อมไปด้วยเครื่องสักการะต่างๆ 	เข้าชมฟรี	ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	\N	เปิดให้เข้าชมตลอดทั้งวัน	2025-03-07 16:45:42.487992	16.433216749162494	102.8302043139542
158	เทวาลัยศิวะมหาเทพ	ถือได้ว่าเป็นศาสนสถานศักดิ์สิทธิ์ของศาสนาพราหมณ์-ฮินดูเลยก็ว่าได้ เพราะภายในจะมีทั้ง องค์พระพิฆเนศ องค์อัมรินทราธิราชเจ้า ช้างเอราวัณ พระตรีมูรติ พระกฤษณะเจ้า พระแม่ศรีมหาอุมาเทวี พระพรหม พระแม่ธรณี เป็นต้น ซึ่งทั้งหมดนี้ก่อสร้างมาได้งดงามมากๆ  	ฟรี ไม่มีค่าเข้าชม	ถนนเลี่ยงเมืองขอนแก่น อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/pagetewalaishivakk/?locale=th_TH	เปิดทุกวันไม่มีวันหยุด เวลา 8.00-17.30 น.	2025-03-07 17:05:06.309498	16.46428788486532	102.88866671909373
160	วัดถ้ำผาเกิ้ง	วัดถ้ำผาเกิ้ง ตั้งอยู่บนเทือกเขาภูเวียง มีพระพุทธรูปองค์ที่สวยงามมากๆ ประดิษฐานอยู่ มีรูปปั้นพญานาค และ พระพุทธรูปต่างๆ  ที่เป็กเอกลักษณ์สวยงาม เป็นอีกหนึ่งวัดที่ใครผ่านมาเที่ยวที่ อ.ภูเวียง ก่อนขึ้นไป ชมแสงแรกของวันที่ภูชมตะวัน ก็แวะกราบขอพรเพื่อความร่มเย็นเป็นสุข เป็นวัดที่มุมถ่ายรูปสวย  วิวดี พื้นที่ร่มเย็นสบาย 	เข้าชมฟรี	วัดถ้ำผาเกิ้ง อุทยานแห่งชาติภูเวียง บ้านโคกหนองขาม ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/pakeong.org/?locale=th_TH	⏰เปิดให้เข้าชม : 06.30- 16.00 น.	2025-03-08 12:10:03.133233	16.700652709888878	102.24355552888484
161	ถ้ำค้างคาว	🦇 มาดูค้างคาวออกจากถ้ำ จะช่วงใกล้ๆค่ำ ต้องลองไปเช็คเวลาช่วงที่ไปเที่ยวอีกที แนะนำให้นั่งร้าน ekia cafe อยู่หน้าถ้ำเลย สบายสุด เห็นค้างคาวชัด เราก็อุดหนุนเคื่องดื่ม 	สามารถเข้าชมถ้ำค้างคาวได้ฟรีไม่เสียใช้จ่าย	ตั้งอยู่ที่อุทยานแห่งชาติภูผาม่าน อ. ภูผาม่าน จ.ขอนแก่น 	\N	ทุกวันค้างคาวจะออกจากถ้ำในเวลาประมาณ 18.00 น. ตอนบินออกจะใช้เวลาประมาณ 30 นาที	2025-03-08 12:30:35.083904	16.6673	101.8947
132	ฮาลองเบย์ อาหารเวียดนาม	ร้านอาหารเวียดนามโฮมเมด “ฮาลองเบย์ ขอนแก่น” ต้นตำรับจากเวียดนามแท้ ๆ เรียกได้ว่าเป็นเมนูสุขภาพเริ่มต้นที่การรับประทานอาหารที่ดี สำหรับคนที่ชอบทานผักต้องถูกใจกับอาหารเวียดนามเลยล่ะครับ บอกเลยว่าห้ามพลาดร้านนี้เด็ดขาด เมนูแนะนำของทางร้านจะมี แหนมเนือง ห่อหมกมะพร้าว เมี่ยงปลาทอด แหนมคลุก ซี่โครงทอด หมูแดดเดียว ขนมจีนน้ำยา ข้าวเกรียบปากหม้อญวน		256/6 ถ.รอบเมือง ต.ในเมือง อ.เมือง (หน้าโรงแรมมันตราวารี) จ.ขอนแก่น	https://www.facebook.com/halongbaykk	เปิดทำการทุกวัน 09.30 – 21.30 น.	2025-02-28 18:24:06.519368	16.423501188174246	102.84077593258478
87	น้ำตกตาดใหญ่	เป็นน้ำตกขนาดใหญ่ ตั้งอยู่ในเขตอุทยานแห่งชาติภูผาม่าน ขอนแก่น หน้าผาขั้นบันไดที่สวยงาม ลดหลั่นเป็นชั้นๆ ดูสวยอลังการสุดๆ ได้ชื่อว่าเป็นน้ำตกที่สูงที่สุดในอุทยานฯด้วยนะ ถ้ามาเที่ยวหน้าน้ำจะยิ่งเห็นความงดงามแบบเต็มๆตา น้ำตกนี้อยู่ไม่ไกลจากเพชรบูรณ์ด้วย เป็นเหมือนรอยต่อที่ทำให้สามารถท่องเที่ยวได้ทั้งสองฝั่ง เหมาะทั้งเที่ยวแบบชิล ๆ และแอดเวนเจอร์เลยทีเดียว	เข้าชมฟรี	ตำบลวังสวาบ อำเภอภูผาม่าน จังหวัดขอนแก่น	\N	สามารถเข้าชมได้ตามเวลาเปิดปิดของสถานที่	2025-02-26 20:03:59.617509	16.722050237117404	101.78244701724604
139	ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น	สายปลาร้านัว ๆ อาหารรสแซ่บจัดจ้านต้องไม่พลาดร้าน “ส้มตำมะกอกแซ่บ & ไก่หมุนละมุนลิ้น” ที่ไม่สามารถหาทานได้ที่ไหนแล้ว เพราะทางร้านใช้มะกอกจากต้นอายุกว่า 20 ปี หอมปลาร้า มะกอกหวาน ๆ ในส้มตำ เด็ดกว่านี้ไม่มีแล้ว มื้อกลางวันลูกค้าเยอะมาก ร้านอาหารอีสานแสนแซ่บต้องร้านนี้ ไก่ย่างละมุนลิ้น หอมอร่อยเครื่องสมุนไพร เนื้อไก่นุ่มชุ่มฉ่ำ ทานร้านแทบหมุนไก่ไม่ทันแล้ว สำหรับเมนูแนะนำคงไม่พ้นส้มตำ ทั้งตำลาว ตำปูปลาร้า ตำมั่ว ไก่หมุนที่หอมเครื่องสมุนไพร แกงเห็ด บอกอย่างนึงว่าตอนเที่ยงโต๊ะเต็มเร็วเพราะเป็นร้านเด็ดที่ชาวออฟฟิศมากินกัน		42 ถนนมะลิวัลย์ ตำบลบ้านเป็ด อำเภอเมืองขอนแก่น จังหวัดขอนแก่น (ตรงข้ามปั๊ม ปตท.)	https://www.facebook.com/profile.php?id=61550112339482	เปิดทำการทุกวัน เวลา 09.00 – 17.00 น. (หยุดวันจันทร์)	2025-02-28 18:34:48.456358	16.421547935886057	102.82239642084114
166	ณ ช่วงเวลา คาเฟ่	บรรยากาศดีมากๆค่ะ ฟีลเขาใหญ่ มีแพะน่ารักๆ เด็กชอบมาก อาหารรสชาติดี พนักงานทุกท่านบริการดี อัธยาศัยดี	\N	346/5 บ้านแก่นเท่า อำเภอบ้านฝาง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=61560065202768	เปิดทำการทุกวัน เวลา 11:00 - 23:00 น.	2025-03-08 15:30:46.024655	16.35518597294078	102.54822271301035
170	เคียงนา คาเฟ่	คาเฟ่กลางทุ่งนา บรรยากาศธรรมชาติสุดชิลล์ วิวสวย ลมเย็น เหมาะกับการมานั่งพักผ่อน จิบกาแฟ ทานขนมโฮมเมด หรืออาหารอีสานรสแซ่บ ไฮไลต์คือสะพานไม้ทอดยาวกลางนา ถ่ายรูปมุมไหนก็สวย สายธรรมชาติและคาเฟ่ฮอปปิ้งต้องมาเช็กอิน	\N	2038 หมู่2 ต.เมืองเก่าพัฒนา อ.เวียงเก่า จ.ขอนแก่น	https://www.facebook.com/KiangnaCafe159	เปิดทำการทุกวัน เวลา 09:30-16:00 น.	2025-03-08 15:46:31.930789	16.911654474564692	102.34382630559978
171	DinoFe’ กาแฟไดโนเสาร์	คาเฟ่ธีมไดโนเสาร์สุดเก๋ในขอนแก่น ตั้งอยู่ใกล้พิพิธภัณฑ์ไดโนเสาร์ภูเวียง บรรยากาศดี มีมุมตกแต่งแนว Jurassic ให้ถ่ายรูปเพียบ เมนูกาแฟและเครื่องดื่มหลากหลาย เหมาะสำหรับครอบครัว เด็ก ๆ และสายคาเฟ่ฮอปปิ้ง ใครมาเที่ยวภูเวียง ต้องแวะลอง	\N	2038 ตำบลเมืองเก่าพัฒนา อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/DinoFeCoffeeTea	เปิดทำการทุกวัน เวลา 08:00 - 17:30 น.	2025-03-08 15:46:31.930789	16.668795376125743	102.30098587862244
174	บางแสน 2	บางแสน 2 เป็นทะเลน้ำจืดของคนขอนแก่น ที่เป็นทั้งสถานที่ท่องเที่ยวและสถานที่พักผ่อนหย่อนใจ สำหรับมาทานอาหารพื้นเมืองและมาเล่นกิจกรรมทางน้ำได้	\N	ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	\N	เปิดทำการทุกวัน เวลา 09.00 น.-17.00 น.	2025-03-08 15:51:51.009988	16.729457121264034	102.6272194907075
177	ริมเขื่อนCoffee	ร้านบรรยากาศดี น่านั่ง อาหารอร่อย ราคาโอเค เครื่องดื่ม ชา กาแฟ ก็มีรสชาติดี มาแล้วไม่ผิดหวัง นั่งจิบเครื่องดื่มชมวิวสุดฟินกับวิวเขื่อนอุบลรัตน์	\N	ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	https://www.facebook.com/kookkai3537	เปิดทำการทุกวัน เวลา 09:00 - 19:00 น.	2025-03-08 15:51:51.009988	16.66112723873298	102.59469302703144
173	บ้านตาคาเฟ่	คาเฟ่บรรยากาศอบอุ่น สไตล์บ้านไม้กลางสวน ที่ให้ความรู้สึกเหมือนมานั่งพักผ่อนที่บ้านต่างจังหวัด มีมุมชิลล์ทั้งในร้านและโซนกลางแจ้ง ร่มรื่นด้วยต้นไม้เขียวขจี เมนูกาแฟและขนมโฮมเมดอร่อย แถมบริการเป็นกันเอง เหมาะสำหรับสายคาเฟ่ที่ชอบความเรียบง่ายและใกล้ชิดธรรมชาติ	\N	บ้านเลขที่ 41 หมู่ 7 บ้านหนองคู ตำบลในเมือง อำเภอเวียงเก่า จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=61559850684833	เปิดทำการทุกวัน 09:00 - 18:00 น.	2025-03-08 15:46:31.930789	14.136789160810586	100.53678433069187
185	Double T Coffee Truck	คาเฟ่สุดแนวสไตล์ Food Truck เสิร์ฟกาแฟสดและเครื่องดื่มสุดชิลล์ ริมน้ำ บรรยากาศสบาย ๆ เป็นกันเอง เหมาะสำหรับสายคาเฟ่ฮอปปิ้งที่ชอบความเรียบง่ายแต่มีกิมมิก เมนูกาแฟหอมกรุ่น ราคาน่ารัก ใครผ่านมาต้องแวะลอง	\N	ตำบลเปือยน้อย อำเภอเปือยน้อย จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100076126455329	เปิดทำการทุกวัน เวลา 10:00–15:00 น.	2025-03-08 15:54:21.867271	15.879549734294013	102.91401901485415
168	จุดชมวิวหินช้างสี	จุดชมวิวหินช้างสี จะมีระเบียงชมวิว 2 ชั้น ที่สามารถมองเห็นวิวทิวทัศย์ที่สวยงามของอ่างเก็บน้ำเขื่อนอุบลรัตน์แบบสุดสายตา และวิวเทือกเขาภูเวียง ภูเก้า ซึ่งถือว่าเป็นทั้งจุดชมวิวพระอาทิตย์ขึ้น และพระอาทิตย์ตกที่เขาว่าสวยงามที่สุด	ค่าเข้าอุทยานฯ : คนไทย ผู้ใหญ่ 20 บาท เด็ก 10 บาท / ชาวต่างชาติ ผู้ใหญ่ 100 บาท เด็ก 50 บาท	อุทยานเเห่งชาติน้ำพอง ตำบลโคกงาม อ.บ้านฝาง จ.ขอนแก่น	\N	เปิดให้เข้าชม : 08.00 - 16.30 น.	2025-03-08 15:34:41.331341	16.652792945897374	102.60792095401477
155	วัดป่าแสงอรุณ	วัดแห่งนี้เรียกกันสั้นๆ ว่า สิมอีสาน ซึ่งคำว่า สิม นั้น เป็นภาษาอีสาน หมายถึง พระอุโบสถ และตัวสิมอีสานของวัดป่าแสงอรุณนี้ ก็ตั้งอยู่กลางวัด รอบไปด้วยต้นไม้ร่มรื่นนั่นเองค่ะ จะเห็นได้ว่าเป็นสิมที่มีสถาปัตยกรรมแบบอีสานตอนบนอย่างสวยงดงามมาก 	เข้าชมฟรี	449 หมู่ 9 บ้านเลิงเปือย ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100209929219859	เปิดให้เข้าชม : 08.00 - 17.00 น	2025-03-06 19:40:20.514463	16.42560503985521	102.88631216512601
180	บ้านปายไม้	คาเฟ่และที่พักริมหาดโนนทัน บรรยากาศสุดชิลล์ ริมน้ำ ลมเย็น วิวสวย เหมาะสำหรับนั่งพักผ่อน จิบกาแฟ ทานอาหารอีสานรสเด็ด หรือจะตั้งแคมป์รับลมเย็น ๆ ยามเย็นชมพระอาทิตย์ตกสุดโรแมนติก ใครมาเที่ยวเขื่อนอุบลรัตน์ แนะนำให้แวะเช็กอิน	\N	69 หมู่ที่ 7 หาดโนนทัน(บ้านภูคำเบ้า) ถนนริม ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	https://www.facebook.com/baanpaimai	เปิดทำการทุกวัน เวลา 09:00 - 18:00 น.	2025-03-08 15:51:51.009988	16.73164505561414	102.62813540004929
144	ตำเมียป๋า	ตำเมียป๋า ร้านส้มตำยอดฮิตที่บอกเลยต้องตำ😋 ตอนนี้เขาย้ายร้านไปทำเลใหม่📍 กว้างใหญ่กว่าเดิม พร้อมรับลูกค้าสุดพลัง ถึงตัวร้านจะเปลี่ยนไปแต่รสชาติยังแซ่บไม่เปลี่ยนแปลง  ไก่ย่าง🍗และปลาเผา🐟เมนูแก้เผ็ดก็ยังมีเหมือนเดิม เนื้อฉ่ำ นุ่มละมุน หอนโข่งลวกจิ้มก็ฟินไม่ไหว🐚 น้ำจิ้มแซ่บอีหลี ร้านเปิดมาก็ 6 ปีละใครยังไม่เคยลองไปลองเด้อ แล้วจะติดใจ ไม่อยากมากลัวร้อนหรือขี้เกียจสามารถสั่งผ่านไลน์แมนได้จ้า💚		485 ม.12 ตำบล ศิลา อำเภอเมืองขอนแก่น ขอนแก่น 40000	https://www.facebook.com/profile.php?id=1959891880961274	เปิดทุกวัน 10:30-20:30 น. หยุดทุกวันที่ 10 20 30 (ติดตามได้ทางเพจร้าน) 	2025-03-01 10:55:27.259306	16.482016103952613	102.81317744237234
182	วารีคาเฟ่ ร้านอาหารขอนแก่น	คาเฟ่และร้านอาหารบรรยากาศสุดร่มรื่น ริมน้ำในขอนแก่น เหมาะสำหรับนั่งชิลล์ จิบกาแฟ ทานอาหารไทย-อีสานรสเด็ด พร้อมมุมถ่ายรูปสวย ๆ บรรยากาศสงบ เป็นกันเอง เหมาะทั้งสำหรับมื้อพิเศษกับครอบครัว หรือนั่งพักผ่อนกับเพื่อน ๆ	\N	188 ต.บ้านดง อ.อุบลรัตน์ จ.ขอนแก่น	https://www.facebook.com/vareecaferestaurant	เปิดทำการทุกวัน เวลา 08:00 - 20:00 น.	2025-03-08 15:51:51.009988	16.772317594706948	102.63900238047702
196	สำรับลาว ภูผาม่าน	ร้านอาหารอีสานฟิวชันสุดเก๋ในอำเภอภูผาม่าน ขอนแก่น เสิร์ฟเมนูพื้นบ้านสไตล์สำรับแบบดั้งเดิม ผสมผสานความสร้างสรรค์ วัตถุดิบสดใหม่ จัดจานสวยงาม บรรยากาศร้านอบอุ่น ให้ฟีลเหมือนไปกินข้าวบ้านญาติ ใครสายอาหารอีสานแท้ ๆ ห้ามพลาด	\N	หน้าที่ว่าการอำเภอภูผาม่าน อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100066319338848	เปิดทำการทุกวัน เวลา 11:00 - 22:00 น. (ปิดทุกวันอังคาร)	2025-03-08 15:58:19.919751	16.645095528193877	101.90323632465497
193	หลงเขาคาเฟ่	คาเฟ่และที่พักวิวภูเขาสุดชิลล์ในอำเภอภูผาม่าน ขอนแก่น มีทั้งโซนคาเฟ่ ลานกางเต็นท์ บ้านพัก และบริการหมูกระทะฟิน ๆ พร้อมดนตรีสดในวันเสาร์ เหมาะสำหรับสายธรรมชาติที่อยากพักผ่อนแบบสโลว์ไลฟ์ สูดอากาศบริสุทธิ์ และชมวิวสวย ๆ ใครผ่านมาแถวนี้ต้องแวะ	\N	บ้านนาน้ำซำ ตำบลภูผาม่าน อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/PhuphamanCafe	เปิดบริการทุกวัน ตั้งแต่เวลา 07.30 - 17.30 น. 	2025-03-08 15:58:19.919751	16.756757215121574	102.1550673493989
187	ออนซอนวิว คาเฟ่	คาเฟ่และร้านอาหารบรรยากาศดี เสิร์ฟอาหารอร่อยทั้ง สเต็ก พิซซ่า กาแฟสด และเมนูหลากหลาย ท่ามกลางบรรยากาศธรรมชาติสุดร่มรื่น เหมาะสำหรับนั่งชิลล์ หรือแวะพักระหว่างทาง	\N	ตำบลดูนสาด อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/kaesmith1010	เปิดทำการทุกวัน เวลา 8:30–20:30 น.	2025-03-08 15:56:10.469097	16.797586107746564	103.16822531910013
192	Mikii House milk cafe	คาเฟ่สไตล์อบอุ่นที่โดดเด่นเรื่องเมนูเครื่องดื่มนมสดและของหวานหลากหลาย บรรยากาศร้านน่ารัก เหมาะสำหรับการนั่งชิลล์หรือแวะพักเติมพลัง เจ้าของร้านเป็นกันเอง ใครที่ชอบเครื่องดื่มนมต้องห้ามพลาด	\N	357 ตำบลหนองโก อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100057458678872	เปิดทำการทุกวัน เวลา 9:00–19:00 น.	2025-03-08 15:56:10.469097	16.69978076351552	103.08416650560652
189	Pass Coffee Roaster	ร้านกาแฟที่บรรยากาศสบาย ๆ เหมาะกับการนั่งจิบกาแฟและพักผ่อน กาแฟหอมเข้มข้น รสชาติดี มีเมล็ดคั่วเองให้เลือกหลากหลาย เจ้าของร้านเป็นกันเอง บริการดี เหมาะสำหรับคอกาแฟที่ต้องการสัมผัสรสชาติแท้ ๆ ของกาแฟคุณภาพ	\N	ตำบลหนองโก อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/passcoffeeroaster	เปิดทำการทุกวัน เวลา 7:00–16:00 น.	2025-03-08 15:56:10.469097	16.70340650692267	103.0859110976727
190	Ganes cafe	คาเฟ่บรรยากาศอบอุ่น ที่นี่มีทั้งกาแฟ เครื่องดื่ม และเบเกอรี่โฮมเมดสดใหม่ โดยเฉพาะเค้กที่ตกแต่งสวยงามและรสชาติอร่อย เหมาะสำหรับคนที่ชอบขนมหวานหรือกำลังมองหาเค้กวันเกิด บริการเป็นกันเอง ใครผ่านมาต้องแวะลอง	\N	544 หมู่ 11 ต.หนองโก อ.กระนวน จ.ขอนแก่น	https://www.facebook.com/ganescafe	เปิดทำการทุกวัน เวลา 07:00-18:00 น.	2025-03-08 15:56:10.469097	16.70599574407373	103.08381716750743
157	กู่เปือยน้อย	เป็นเทวสถานในศาสนาฮินดู ที่สร้างราวพุทธศตวรรษที่ 16 - 17 ใช้เป็นศาสนสถานประกอบพิธีกรรม มีสภาพสมบูรณ์ที่สุดในแถบอีสานตอนบนเท่าที่เคยค้นพบเห็นมาเลยค่ะ โดยสถาปัตยกรรมนั้น จะเป็นกลุ่มอาคารโบราณ 4 หลัง ก่อด้วยศิลาแลง หินทราย และอิฐ มีกำแพงแก้วเป็นรูปสี่เหลี่ยมพื้นผ้าล้อมรอบอีกชั้น	เข้าชมฟรี	บ้านหัวขัว ตำบลเปือยน้อย อำเภอเปือยน้อย จังหวัดขอนแก่น	\N	เปิดให้เข้าชม : 07.00-19.00 น.	2025-03-07 17:01:11.200819	15.879955511530994	102.90855031352501
199	ไทบ้าน คาเฟ่	คาเฟ่สุดกรีนในเขาสวนกวาง บรรยากาศร่มรื่น รายล้อมไปด้วยต้นไม้ ร้านตั้งอยู่ห่างสวนสัตว์เพียง 2 กิโลเท่านั้น สามารถแวะนั่งชิลล์ พักผ่อนหย่อนใจ จิ้บกาแฟสักแก้วหรือจะพาครอบครัวแวะเติมพลังทานอาหารก่อนไปเที่ยวสวนสัตว์ขอนแก่นได้ ทางร้านมีทั้งกาแฟสด พิซซ่า สเต็ก เบอร์เกอร์ อาหารไทย อาหารจานเดียวไว้ให้บริการ	\N	ตำบล คำม่วง อำเภอเขาสวนกวาง ขอนแก่น 40280	https://www.facebook.com/profile.php?id=100063325082869	เปิดทำการทุกวัน 9:30 - 20:00 น. (หยุดทุกวันจันทร์)	2025-03-08 16:04:13.161802	16.85460548341991	102.88301997632571
197	ภูผาม่าน ล้านวิว	คาเฟ่และร้านอาหารสุดชิลล์ในอำเภอภูผาม่าน ขอนแก่น วิวสวยอลังการ ท่ามกลางภูเขาและธรรมชาติ บรรยากาศดี มีโซนนั่งทั้งในอาคารและกลางสวน เมนูอาหารอีสานรสเด็ด พร้อมกาแฟและเครื่องดื่มสดชื่น เหมาะสำหรับมานั่งพักผ่อน ถ่ายรูป และดื่มด่ำบรรยากาศ	\N	เลขที่ 212 ตำบลภูผาม่าน อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=61571405695584	เปิดทำการทุกวัน 8:00–23:30 น.	2025-03-08 15:58:19.919751	16.6643666054248	101.9145363828511
200	Wancoffee Cafe	Wancoffee Cafe บริการ กาแฟสด ร้อนเย็น เครื่องทุกชนิด ในร้านวรรณไก่ย่าเขาสวนกวาง มีกาแฟให้เลือกเยอะ ร้านตกแต่งดี คนรักมอเตอร์ไซค์น่าจะชอบ กาแฟก็รสชาติดี จะกินกาแฟไปพร้อมไก่ย่างเขาสวนกวางก็ได้	\N	Wancoffee cafe By wankaiyang173 หมู่ 11 ถนนมิตรภาพ ตำบลคำม่วง อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/wancoffeecafebywankaiyang	เปิดทำการทุกวัน เวลา 09:00 - 17:00 น. (ปิดทุกวันอังคาร)	2025-03-08 16:04:13.161802	16.853868544131302	102.85985887677343
202	ยายแพง ไก่ย่างเขาสวนกวาง	ร้านไก่ย่างชื่อดังแห่งเขาสวนกวาง การันตีความอร่อยจากรายการดัง ไก่ย่างหนังกรอบ เนื้อนุ่ม หอมกลิ่นสมุนไพรย่างเตาถ่าน เสิร์ฟพร้อมแจ่วรสเด็ด เมนูอื่น ๆ ก็อร่อยไม่แพ้กัน ใครมาเที่ยวขอนแก่น ต้องแวะชิมให้ได้	\N	ตำบลคำม่วง อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/KheaSwnKwangMeuxngKiYang	เปิดทำการทุกวัน เวลา 8:00–18:00 น.	2025-03-08 16:04:13.161802	16.85524710675429	102.8600799209539
198	สวนรุกขชาติ	แหล่งเรียนรู้ทางธรรมชาติ ป่าไม้ ธรณีวิทยา เจ้าหน้าที่น่ารัก เป็นกันเอง บรรยากาศดี สงบ เป็นส่วนตัว สำหรับไปพักผ่อน	สอบถามโดยตรงกับทางสวนรุกขชาติผ่านช่องทางการติดต่อ	ตำบลคำม่วง อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/DNP0026	ไม่พบการระบุเวลาเปิด-ปิดที่ชัดเจน สามารถสอบถามโดยตรงกับทางสวนรุกขชาติผ่านช่องทางการติดต่อ	2025-03-08 16:04:13.161802	16.478644812824193	102.82515324910513
153	วัดเจติยภูมิ (พระธาตุขามแก่น) 	พระธาตุขามแก่นเป็นสถานที่ทางศาสนา สำคัญและน่าสนใจในขอนแก่น มีสถาปัตยกรรมที่งดงามและธรรมชาติสงบเงียบ ตั้งอยู่ภายในวัดเจติยภูมิ สร้างขึ้นประมาณต้นพุทธศตวรรษที่ 25	ค่าเข้าชม : ฟรี	วัดเจติยภูมิ บ้านขาม หมู่ที่ 1 ตำบลบ้านขาม อำเภอน้ำพอง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=347435408674054	เวลาเปิดทำการ : 07.00-17.00 น.	2025-03-06 19:25:45.274068	16.563278020697343	102.95168322888225
181	วัดเขื่อนอุบลรัตน์ ถ้ำผาเจาะ	วัดศักดิ์สิทธิ์บนเขาที่เงียบสงบ ใกล้เขื่อนอุบลรัตน์ ไฮไลต์คือ ถ้ำผาเจาะ จุดชมวิวสุดอลังการที่มองเห็นอ่างเก็บน้ำจากมุมสูง อีกหนึ่งความพิเศษคือ สะพานหินธรรมชาติอายุ 140 ล้านปี โครงสร้างหินสุดแปลกตาที่เกิดขึ้นตามธรรมชาติ เหมาะสำหรับสายบุญและนักท่องเที่ยวที่ชอบวิวธรรมชาติและประวัติศาสตร์ล้านปี	ค่าเข้าชม : ฟรี 	ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100064531069636	เวลาเปิดทำการ : 07.30-17.00 น. 	2025-03-08 15:51:51.009988	16.744836170931876	102.63383130560744
204	1 8 9 CAFE	1 8 9. CAFE' เป็นคาเฟ่เล็ก ๆ สไตล์เรียบง่ายในอำเภอเขาสวนกวาง ที่มีบรรยากาศชิลล์ ๆ เหมาะกับการแวะพักระหว่างเดินทาง เมนูเครื่องดื่มสดชื่น ราคาย่อมเยา แถมเปิดตลอดเวลา ใครผ่านมาเส้นนี้แนะนำให้ลองแวะดื่มกาแฟหรือเครื่องดื่มเย็น ๆ สักแก้ว	\N	189 ตำบลโนนสมบูรณ์ อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100063580119226	เปิดทำการทุกวัน เวลา 8:00–21:00 น.	2025-03-08 16:04:13.161802	17.0093	102.7581
172	92 Cafe Wiang kao	คาเฟ่น่ารักในอำเภอเวียงเก่า บรรยากาศอบอุ่น ตกแต่งสไตล์มินิมอลผสมธรรมชาติ มีมุมถ่ายรูปสวย ๆ เพียบ เมนูกาแฟและเครื่องดื่มสดชื่น พร้อมขนมอร่อย ๆ เหมาะสำหรับมานั่งชิลล์ ทำงาน หรือแวะพักระหว่างเที่ยว ใครผ่านมาเวียงเก่า ต้องลองแวะ	\N	ตำบลในเมือง อำเภอเวียงเก่า ขอนแก่น 40150	https://www.facebook.com/profile.php?id=100063726454543#	เปิดทำการทุกวัน เวลา 09:00 - 19:00 น. (ปิดทุกวันเสาร์)	2025-03-08 15:46:31.930789	16.6776	102.2902
31	S Bar BQ เอสบาร์บีคิว	ร้านสะอาด บริการเร็วฉับไวด้วยพนักงานที่แข็งขันเสมอ เอกลักษณ์ของร้านหมูกระทะปิ้งย่างบนกระทะทองเหลืองคือน้ำจิ้มบาร์บีคิวรสเลิศ จิ้มกับเบคอนย่างกรอบ ๆ หอม ๆ พร้อมทั้งหมูสามชั้นและเนื้อโคขุนสไลซ์ ใครกินก็ติดใจทุกราย ตบท้ายด้วยของหวานเป็นไอศกรีมหลากหลายรส ได้มื้อใหญ่จบวันที่ทำให้กลับบ้านอย่างมีความสุข	บุฟเฟ่ต์ 249 บาท อิ่มไม่อั้นนน พบกันที่ เอสบาร์บีคิวขอนแก่นค่ะ	103 รื่นรมย์ ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/sbarbqkhonkaen	เปิดทำการทุกวัน เวลา 16.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.45752049133449	102.82209866142144
165	เคียมนา เตี๋ยวหางวัวตุ๋น	ร้านก๋วยเตี๋ยวเนื้อที่จริงใจ บรรยากาศดี บริการดี มีที่นั่งและที่จอดรถเยอะ เมนูซิกเนเจอร์ของร้านคือหางวัวตุ๋น อร่อยมากกกกก หางวัวตุ๋นได้นุ่มมาก น้ำซุปก็หอม เข้มข้นกลมกล่อม มีผักสดๆ ที่ตัดจากสวนหลังร้าน พริกเผา และเกี๊ยวทอดเติมได้ไม่อั้น ส่วนใครที่ไม่ทานเนื้อก็มีเมนูหมู ไก่ อาหารตามสั่ง ส้มตำ และอื่นๆ รวมทั้งมีขนมหวาน ไอศครีม และผักสดๆ ซื้อติดมือกลับบ้านได้อีกด้วย	\N	95 หมู่ 7 บ.หนองบัว ต.หนองบัว อ.บ้านฝาง จ.ขอนเเก่น	https://www.facebook.com/manmokoko	เปิดทำการทุกวัน เวลา 09:00 - 17:00 น.	2025-03-08 15:30:46.024655	16.46227777582071	102.60884873443808
186	ครัว คุณหน่อย	ร้านอาหารบรรยากาศร่มรื่น พร้อมบ่อปลาคราฟน้ำใสและห้องแอร์ฟรี เมนูอาหารหลากหลาย ทั้งอาหารไทย-อีสาน รสชาติอร่อย	\N	หมู่​ 6 ตำบลหนองโก อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/nongmaiKKN	เปิดทำการทุกวัน เวลา 10:00 - 21:30 น.	2025-03-08 15:56:10.469097	16.7057	103.0719
191	เชอรี่คาเฟ่	เซอร์รี่คาเฟ่ เป็นร้านคาเฟ่น่านั่ง มีทั้งอาหาร เครื่องดื่ม และขนมหวานให้เลือกหลากหลาย โดยเฉพาะเค้กวันเกิดแบบปอนด์ที่สวยและน่าทาน บรรยากาศเป็นกันเอง เหมาะกับการนั่งชิลล์ ดื่มกาแฟเพลิน ๆ หรือมานั่งทำงาน	\N	นิกรสำราญ ตำบลหนองโก อำเภอกระนวน จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100040874631224	เปิดทำการทุกวัน เวลา 8:00–21:00 น.	2025-03-08 15:56:10.469097	16.713109186526765	103.08303134052416
25	โอมายก้อน by โอปอ	หมูกระทะโอปอในตำนานกลับมาเปิดเเล้ว รอบนี้มาโฉมใหม่เเละใช้ชื่อว่า “โอมายก้อน by โอปอ” รสชาติน้ำจิ้มที่คุ้นเคย อร่อยคุ้มเหมือนเดิม เพิ่มเติมคือร้านสวย สะอาด เดินง่าย เมนูในบุฟเฟ่ต์เพียบ!!  ที่สำคุญมี “เนื้อเสือร้องไห้ออสเตรเลีย” ไม่อั้นด้วย ตัวร้านใหญ่โต ที่นั่งเยอะ!! โต๊ะกว้างวางของได้เยอะ ระดับโต๊ะดีด้วย ไม่ต้องยืนย่างเนื้อให้เมื่อย เเละโซนบาร์อาหารแยกเป็นสัดส่วน สำหรับหมู / เนื้อสไลด์ จะแยกแช่ที่ตู้ สามารถสั่งได้ที่พี่พนักงานได้เลย	บุฟเฟต์ 225 บาท / 279 บาท รวมเครื่องดื่มรีฟีล	ถนนกัลปพฤกษ์ ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/OhMyGonByOporBuffet	เปิดทำการทุกวัน เวลา 16.00 – 23.00 น.	2025-02-26 18:30:51.29058	16.458232633666427	102.82415540930714
178	บ้านนอก คอกควาย	คาเฟ่และร้านอาหารบรรยากาศชิลล์ ๆ ริมเขื่อนอุบลรัตน์ ตกแต่งสไตล์บ้านทุ่ง มีวิวอ่างเก็บน้ำสุดลูกหูลูกตา เหมาะกับการนั่งพักผ่อน จิบกาแฟ หรือลิ้มลองอาหารอีสานรสแซ่บ ไฮไลต์คือ วิวพระอาทิตย์ตก ที่สวยมาก ใครมาเที่ยวเขื่อนอุบลรัตน์ ไม่ควรพลาดแวะเช็กอิน!	\N	89 บ้านแก่งศิลา ตำบลเขื่อนอุบลรัตน์ อำเภออุบลรัตน์ จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100057363522822	เปิดทำการทุกวัน เวลา 09:00-22:00 น. (ครัวปิด 2ทุ่ม)	2025-03-08 15:51:51.009988	16.66082704682487	102.59375473814704
203	ร้านอาหารดอกไม้ฟาร์มไก่ย่างเขาสวนกวาง	ร้านไก่ย่างชื่อดังแห่งเขาสวนกวาง บรรยากาศร่มรื่น มีน้ำตกและสวนสวยให้ได้นั่งชิลล์ ไก่ย่างสูตรเด็ด หนังกรอบ เนื้อนุ่ม หอมกลิ่นเตาถ่าน เสิร์ฟคู่กับแจ่วรสแซ่บ นอกจากนี้ยังมีเมนูอาหารอีสานและอาหารไทยให้เลือกหลากหลาย	\N	89 หมู่ 10 ต.คำม่วง อำเภอเขาสวนกวาง จังหวัดขอนแก่น	https://www.facebook.com/Dokmaifarm2/	เปิดทำการทุกวัน เวลา 8:00–18:00 น.	2025-03-08 16:04:13.161802	16.427987673797595	102.86606439396219
179	อู่ข้าวอู่น้ำ ฟาร์มสเตย์	ที่พักฟาร์มสเตย์บรรยากาศธรรมชาติ โอบล้อมด้วยทุ่งนาและวิวเขื่อนอุบลรัตน์ เหมาะสำหรับคนที่อยากพักผ่อนแบบสโลว์ไลฟ์ สัมผัสวิถีเกษตรอินทรีย์ อาหารที่นี่สดใหม่จากฟาร์ม เสิร์ฟเมนูอีสานรสเด็ด บรรยากาศเงียบสงบ เหมาะกับการรีเฟรชร่างกายและจิตใจ ใครชอบฟีลบ้านทุ่ง แนะนำให้มาลอง	\N	ตำบลบ้านดง อำเภออุบลรัตน์ จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100071825404472#	เปิดทำการทุกวัน 10:00–21:00 น.	2025-03-08 15:51:51.009988	16.781111907159424	102.63390070983677
104	วัดไชยศรี	วัดไชยศรี หรือ วัดใต้ มีอุโบสถ (สิม) ซึ่งโดดเด่นในเชิงช่าง ทั้งด้านสถาปัตยกรรมสร้างโดยช่างชาวญวน และจิตรกรรมท้องถิ่นอีสาน (ฮูปแต้ม) วาดโดย นายทอง ทิพย์ชา และคณะ ซึ่งเป็นช่างแต้ม ชาวมหาสารคาม เป็นเรื่องราว สินไซ หรือ สังข์ศิลป์ชัย วรรณกรรมแห่งลุ่มแม่น้ำโขง ที่มีเนื้อหาค่อนข้างสมบูรณ์ วัดไชยศรี ถือตามธรรมเนียมดั้งเดิม คือห้ามสตรีขึ้นไปในสิม แต่ฮูปแต้มก็มีวาดบนผนังสิมทั้งด้านในและด้านนอก เพื่อให้ผู้หญิงสามารถชมฮูปแต้มที่ผนังด้านนอกได้	เข้าชมฟรี	บ้านสาวะถี ต.สาวะถี อ.เมือง จ.ขอนแก่น	\N	เปิดทำการทุกวัน 08.00-17.00 น.	2025-02-26 20:03:59.617509	16.50913624192819	102.69707241353677
102	วัดพระพุทธบาทภูพานคำ	วัดพระพุทธบาทภูพานคำ เป็นสถานที่ประดิษฐาน พระพุทธบาทจำลอง และ หลวงพ่อพระใหญ่ พระพุทธอุตรมหามงคลอุบลรัตน์ พระพุทธรูปสีขาวองค์ใหญ่ การที่จะขึ้นไปกราบไหว้ก็ หลวงพ่อขาว นั้นต้องผ่านบันไดวัดใจสักหน่อย ซึ่งถ้าใครใจไม่ถึงจริงก็แนะนำให้ขับรถขึ้นไปดีกว่าค่ะ เพราะต้องผ่านบันไดขึ้นไปถึง 1,049 ขั้น	เข้าชมฟรี	103 หมู่ 1 อำเภออุบลรัตน์ จังหวัดขอนแก่น	\N	เปิดทำการทุกวัน 07.00-17.00 น.	2025-02-26 20:03:59.617509	16.762776305183202	102.6255574344438
60	ศรีเรือนผัดไทย (สาขาถนนรื่นจิตร)	เชฟศรีเรือนทำผัดไทยรสเลิศมากว่า 30 ปี พื้นเพเป็นคนพิษณุโลก และเสิร์ฟผัดไทยรสชาติโดดเด่นไม่เหมือนใครจากไข่เป็ด ไม่ว่าจะสั่งเส้นผัดไทยหรือวุ้นเส้นก็อร่อยทั้งคู่ รสชาติเข้มข้นเข้าเส้นเหนียวนุ่ม ไปเที่ยวขอนแก่นต้องห้ามพลาด		48 ถ.รื่นจิตร ต.ในเมือง อ.เมือง จ.ขอนแก่น	https://www.facebook.com/profile.php?id=100054607922815	เปิดทำการทุกวัน 15.00 - 21.30 น.	2025-02-26 20:03:38.571906	16.425478612913412	102.83949453258474
194	ผาม่านฝัน	คาเฟ่และร้านอาหารบรรยากาศสุดชิลล์ ท่ามกลางวิวภูเขาอันสวยงามในอำเภอภูผาม่าน จังหวัดขอนแก่น ที่นี่ให้บริการทั้งอาหาร เครื่องดื่ม และขนม พร้อมที่พักสไตล์มินิมอลสำหรับสายสโลว์ไลฟ์ เมนูอาหารรสชาติอร่อย บรรยากาศเงียบสงบ เหมาะสำหรับนั่งชิลล์ ถ่ายรูป และพักผ่อนอย่างเต็มที่ ใครที่มองหาสถานที่กิน เที่ยว พักครบจบในที่เดียว ห้ามพลาด	\N	209 บ้านนาน้ำซำ ซอยโยธาธิการ อำเภอภูผาม่าน จังหวัดขอนแก่น	https://www.facebook.com/Phamanfun/	เปิดทำการทุกวัน เวลา 8:30–21:00 น.	2025-03-08 15:58:19.919751	16.671087863819228	101.91766112703161
28	โต้งเต้ยเนื้อย่างเกาหลี	ร้านหมูกระทะเตาถ่านนี้ให้กลิ่นอายเหมือนหมูกระทะในยุคแรก ๆ ที่เคยเฟื่องฟู เนื้อสัตว์หมักด้วยซอสสูตรเฉพาะของทางร้าน เรียงตัวในถ้วยอย่างสวยงาม และหั่นมาไม่หนามาก เมื่อนำไปย่างจนสุกจะได้เนื้อหมูกรอบนอกนุ่มใน น้ำซุปของทางร้านหวานกลมกล่อม ตัดกับน้ำจิ้มที่เปรี้ยวเผ็ดแซ่บ ไม่หวาน รับประทานด้วยกันแล้วกลมกล่อมเหมาะเจาะ สถานที่ลานโล่งของร้านยังสร้างบรรยากาศชิลล์ ๆ ให้นั่งทานได้ทั้งคืนอีกด้ว	ชุดเล็ก 180 บาท ชุดใหญ่ 230 บาท	ถ.กสิกรทุ่งสร้าง ตำบลในเมือง อำเภอเมืองขอนแก่น จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=100063542624899	เปิดทำการเวลา 10.00 – 22.30 น.	2025-02-26 18:30:51.29058	16.45002481201355	102.84306731724084
164	นา บัว คาเฟ่	ใช้เวลากับตัวเอง หลังจากเหนื่อยล้ากันมาทั้งสัปดาห์  ได้เวลาให้ตัวเองได้ผ่อนคลายกับธรรมชาติ และบรรยากาศที่มีความหมายกับคุณเอง เพื่อที่พรุ่งนี้จะเป็นวันที่ดีกว่า ร้านให้บรรยากาศบ้านสวน มีซุ้มนั่งทานอาหารแบบส่วนตัว มีศาลากลางน้ำ ให้นั่งชิลๆให้อาหารปลา สถานที่จอดรถกว้างขวาง และรับจัดเลี้ยงงานสังสรรค์ ต่างๆ	\N	มะลิวัลย์ 103 หมู่ 9 ตำบลบ้านฝาง อำเภอบ้านฝาง จังหวัดขอนแก่น	https://www.facebook.com/profile.php?id=61573433090887	เปิดทำการทุกวัน 10:00 - 21:00 น. (ครัวปิด 20:30)	2025-03-08 15:30:46.024655	16.448580258920565	102.65388698047082
169	โอเมก้า คาเฟ่	คาเฟ่สุดชิคในขอนแก่น ตกแต่งสไตล์มินิมอล บรรยากาศอบอุ่น มีเมนูกาแฟหอมกรุ่น เบเกอรี่โฮมเมด และเครื่องดื่มสุดครีเอทีฟ มุมถ่ายรูปสวยเพียบ เหมาะสำหรับสายคาเฟ่ฮอปปิ้ง หรือใครที่มองหาที่นั่งชิลล์ ๆ ทำงาน อ่านหนังสือ ห้ามพลาด		154 อำเภอภูเวียง ขอนแก่น 40150	https://www.facebook.com/OMGCAFEPW	เปิดทำการทุกวัน เวลา 8:30–17:00 น.	2025-03-08 15:46:31.930789	16.659967368855572	102.37349486513057
\.


--
-- TOC entry 3449 (class 0 OID 31629)
-- Dependencies: 218
-- Data for Name: table_counts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.table_counts (table_name, row_count, updated_at) FROM stdin;
users	22	2025-03-27 07:01:06.596129
web_answer	13	2025-03-27 07:01:06.647469
conversations	197	2025-03-27 07:01:06.692774
places	165	2025-03-27 07:01:06.743224
\.


--
-- TOC entry 3457 (class 0 OID 31675)
-- Dependencies: 226
-- Data for Name: tourist_destinations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tourist_destinations (id, name, place_id, created_at) FROM stdin;
35	เที่ยวขอนแก่น	96	2025-02-27 19:52:37.723335
37	อาหารระดับมิชลินไกด์	67	2025-02-28 16:57:36.101204
38	อาหารระดับมิชลินไกด์	53	2025-02-28 16:57:36.22061
39	อาหารระดับมิชลินไกด์	64	2025-02-28 16:57:36.33998
40	เที่ยวขอนแก่น	106	2025-02-28 17:25:08.952007
41	เที่ยวขอนแก่น	80	2025-02-28 17:25:09.071461
42	เที่ยวขอนแก่น	87	2025-02-28 17:25:09.191028
43	เที่ยวขอนแก่น	84	2025-02-28 17:25:09.311304
44	เที่ยวขอนแก่น	101	2025-02-28 17:25:09.430131
45	เที่ยวขอนแก่น	108	2025-02-28 17:25:09.550254
46	เที่ยวขอนแก่น	94	2025-02-28 17:25:09.670101
47	เที่ยวขอนแก่น	85	2025-02-28 17:25:09.789988
48	เที่ยวขอนแก่น	90	2025-02-28 17:25:09.910033
49	เที่ยวขอนแก่น	78	2025-02-28 17:25:10.030746
51	เที่ยวขอนแก่น	100	2025-02-28 17:25:10.320391
52	เที่ยวขอนแก่น	99	2025-02-28 17:25:10.440007
53	คาเฟ่ยอดฮิต	5	2025-02-28 17:51:25.992963
54	คาเฟ่ยอดฮิต	6	2025-02-28 17:51:26.111162
55	คาเฟ่ยอดฮิต	7	2025-02-28 17:51:26.23096
56	คาเฟ่ยอดฮิต	8	2025-02-28 17:51:26.351088
57	คาเฟ่ยอดฮิต	17	2025-02-28 17:51:26.470939
58	คาเฟ่ยอดฮิต	16	2025-02-28 17:51:26.590748
59	คาเฟ่ยอดฮิต	11	2025-02-28 17:51:26.710965
60	คาเฟ่ยอดฮิต	9	2025-02-28 17:51:26.841052
62	คาเฟ่ยอดฮิต	18	2025-02-28 17:51:27.081664
63	คาเฟ่ยอดฮิต	12	2025-02-28 17:51:27.20155
64	คาเฟ่ยอดฮิต	13	2025-02-28 17:51:27.320971
65	คาเฟ่ยอดฮิต	14	2025-02-28 17:51:27.452115
66	คาเฟ่ยอดฮิต	15	2025-02-28 17:51:27.572897
67	ประเภทอาหารไทย	60	2025-02-28 17:55:14.761541
68	ประเภทอาหารไทย	61	2025-02-28 17:55:14.892299
5	อาหารระดับมิชลินไกด์	50	2025-02-26 20:14:18.417398
6	อาหารระดับมิชลินไกด์	71	2025-02-26 20:14:18.525789
8	อาหารระดับมิชลินไกด์	51	2025-02-26 20:14:18.755754
9	อาหารระดับมิชลินไกด์	70	2025-02-26 20:14:18.865723
10	อาหารระดับมิชลินไกด์	52	2025-02-26 20:14:18.986387
12	อาหารระดับมิชลินไกด์	60	2025-02-26 20:14:19.207276
13	อาหารระดับมิชลินไกด์	59	2025-02-26 20:14:19.325862
14	อาหารระดับมิชลินไกด์	65	2025-02-26 20:14:19.435686
15	อาหารระดับมิชลินไกด์	73	2025-02-26 20:14:19.544868
16	อาหารระดับมิชลินไกด์	58	2025-02-26 20:17:21.876936
17	อาหารระดับมิชลินไกด์	72	2025-02-26 20:17:21.996188
18	อาหารระดับมิชลินไกด์	54	2025-02-26 20:17:22.106181
19	อาหารระดับมิชลินไกด์	56	2025-02-26 20:17:22.226426
21	อาหารระดับมิชลินไกด์	54	2025-02-26 20:17:22.466879
22	อาหารระดับมิชลินไกด์	63	2025-02-26 20:17:22.585228
23	อาหารระดับมิชลินไกด์	66	2025-02-26 20:17:22.695179
25	อาหารระดับมิชลินไกด์	69	2025-02-26 20:17:22.936261
26	อาหารระดับมิชลินไกด์	62	2025-02-26 20:17:23.056142
27	อาหารระดับมิชลินไกด์	61	2025-02-26 20:18:28.063174
28	อาหารระดับมิชลินไกด์	57	2025-02-26 20:18:28.173427
29	เที่ยวขอนแก่น	92	2025-02-27 19:52:36.714779
30	เที่ยวขอนแก่น	88	2025-02-27 19:52:36.987432
31	เที่ยวขอนแก่น	100	2025-02-27 19:52:37.211339
32	เที่ยวขอนแก่น	81	2025-02-27 19:52:37.332791
33	เที่ยวขอนแก่น	103	2025-02-27 19:52:37.46316
69	ประเภทอาหารไทย	63	2025-02-28 17:55:15.022286
70	ประเภทอาหารไทย	67	2025-02-28 17:55:15.141117
71	ประเภทอาหารไทย	57	2025-02-28 17:55:15.262517
74	ประเภทอาหารไทย	113	2025-02-28 17:55:15.641847
76	ประเภทอาหารไทย	112	2025-02-28 17:55:15.892056
77	ประเภทอาหารไทย	114	2025-02-28 17:55:16.011926
79	ประเภทอาหารไทย	116	2025-02-28 17:55:16.262016
81	ประเภทอาหารทั่วไป	65	2025-02-28 18:22:27.547122
82	ประเภทอาหารทั่วไป	59	2025-02-28 18:22:27.685665
83	ประเภทอาหารทั่วไป	60	2025-02-28 18:22:27.815136
84	ประเภทอาหารทั่วไป	71	2025-02-28 18:22:27.936408
86	ประเภทอาหารทั่วไป	125	2025-02-28 18:22:28.225876
87	ประเภทอาหารทั่วไป	66	2025-02-28 18:22:28.345811
88	ประเภทอาหารทั่วไป	124	2025-02-28 18:22:28.465193
90	ประเภทอาหารทั่วไป	76	2025-02-28 18:22:28.715409
91	ประเภทอาหารทั่วไป	77	2025-02-28 18:22:28.846574
92	ประเภทอาหารทั่วไป	56	2025-02-28 18:22:28.976396
93	ประเภทอาหารอินเตอร์	62	2025-02-28 18:33:48.810971
94	ประเภทอาหารอินเตอร์	50	2025-02-28 18:33:48.94223
95	ประเภทอาหารอินเตอร์	64	2025-02-28 18:33:49.070747
96	ประเภทอาหารอินเตอร์	128	2025-02-28 18:33:49.220604
97	ประเภทอาหารอินเตอร์	134	2025-02-28 18:33:49.430198
98	ประเภทอาหารอินเตอร์	44	2025-02-28 18:33:49.549542
99	ประเภทอาหารอินเตอร์	131	2025-02-28 18:33:49.680409
100	ประเภทอาหารอินเตอร์	132	2025-02-28 18:33:49.799526
101	ประเภทอาหารอินเตอร์	73	2025-02-28 18:33:49.920732
103	ประเภทอาหารอินเตอร์	47	2025-02-28 18:33:50.219484
104	ประเภทอาหารอินเตอร์	43	2025-02-28 18:34:26.749856
107	ประเภทอาหารอีสาน	53	2025-02-28 18:43:44.086459
110	ประเภทอาหารอีสาน	72	2025-02-28 18:43:44.514825
113	ประเภทอาหารอีสาน	70	2025-02-28 18:43:44.904642
114	ประเภทอาหารอีสาน	52	2025-02-28 18:43:45.035047
115	ประเภทอาหารอีสาน	51	2025-02-28 18:43:45.163398
116	ประเภทอาหารอีสาน	68	2025-02-28 18:43:45.294588
119	ประเภทอาหารอีสาน	54	2025-02-28 18:47:16.992587
120	ร้านอาหารบุฟเฟ่	27	2025-02-28 18:51:53.446768
121	ร้านอาหารบุฟเฟ่	36	2025-02-28 18:51:53.586513
122	ร้านอาหารบุฟเฟ่	20	2025-02-28 18:51:53.716603
123	ร้านอาหารบุฟเฟ่	24	2025-02-28 18:51:53.845996
124	ร้านอาหารบุฟเฟ่	30	2025-02-28 18:51:53.986064
125	ร้านอาหารบุฟเฟ่	32	2025-02-28 18:51:54.146094
126	ร้านอาหารบุฟเฟ่	26	2025-02-28 18:51:54.276757
127	ร้านอาหารบุฟเฟ่	29	2025-02-28 18:51:54.40667
128	ร้านอาหารบุฟเฟ่	28	2025-02-28 18:51:54.535288
130	ร้านอาหารบุฟเฟ่	22	2025-02-28 18:51:54.816729
131	ร้านอาหารบุฟเฟ่	33	2025-02-28 18:51:54.94666
132	ร้านอาหารบุฟเฟ่	35	2025-02-28 18:51:55.116501
133	ร้านอาหารบุฟเฟ่	21	2025-02-28 18:51:55.256536
134	ร้านอาหารบุฟเฟ่	23	2025-02-28 18:51:55.396287
135	ร้านอาหารบุฟเฟ่	34	2025-02-28 18:51:55.556592
136	ร้านอาหารบุฟเฟ่	25	2025-02-28 18:51:55.687194
137	ร้านอาหารบุฟเฟ่	31	2025-02-28 18:52:13.476504
138	ประเภทอาหารไทย	89	2025-02-28 18:53:25.641311
140	ประเภทอาหารไทย	134	2025-03-01 09:49:12.880535
141	ประเภทอาหารไทย	141	2025-03-01 10:28:42.300632
142	ประเภทอาหารไทย	142	2025-03-01 10:28:42.439933
143	ประเภทอาหารอินเตอร์	143	2025-03-01 10:42:10.08201
144	ประเภทอาหารอีสาน	146	2025-03-01 11:06:42.84577
145	ประเภทอาหารอีสาน	145	2025-03-01 11:06:42.995703
146	ประเภทอาหารอีสาน	144	2025-03-01 11:06:43.146104
147	ประเภทอาหารอีสาน	140	2025-03-01 11:09:02.579948
149	ประเภทอาหารอีสาน	134	2025-03-01 11:09:02.868392
150	ประเภทอาหารอีสาน	136	2025-03-01 11:15:00.905392
151	ร้านอาหารดังยอดฮิต	15	2025-03-01 14:25:42.031318
152	ร้านอาหารดังยอดฮิต	114	2025-03-01 14:25:42.188848
153	ร้านอาหารดังยอดฮิต	61	2025-03-01 14:25:42.329355
154	ร้านอาหารดังยอดฮิต	68	2025-03-01 14:25:42.470303
155	ร้านอาหารดังยอดฮิต	67	2025-03-01 14:25:42.609126
156	ร้านอาหารดังยอดฮิต	57	2025-03-01 14:25:42.738683
157	ร้านอาหารดังยอดฮิต	70	2025-03-01 14:25:42.889695
158	ร้านอาหารดังยอดฮิต	60	2025-03-01 14:25:43.029093
159	ร้านอาหารดังยอดฮิต	141	2025-03-01 14:25:43.170514
160	ร้านอาหารดังยอดฮิต	50	2025-03-01 14:25:43.330227
161	ร้านอาหารดังยอดฮิต	63	2025-03-01 14:25:43.500147
162	ร้านอาหารดังยอดฮิต	53	2025-03-01 14:25:43.6501
163	ร้านอาหารดังยอดฮิต	51	2025-03-01 14:25:43.790016
164	ร้านอาหารดังยอดฮิต	31	2025-03-01 14:25:43.95977
165	ร้านอาหารดังยอดฮิต	21	2025-03-01 14:25:44.119406
166	ร้านอาหารดังยอดฮิต	20	2025-03-01 14:25:44.249954
167	ร้านอาหารดังยอดฮิต	12	2025-03-01 14:25:44.399279
168	ร้านอาหารดังยอดฮิต	6	2025-03-01 14:25:44.539681
169	ร้านอาหารดังยอดฮิต	18	2025-03-01 14:25:44.690497
170	ร้านอาหารดังยอดฮิต	13	2025-03-01 14:25:44.829499
171	ร้านอาหารดังยอดฮิต	5	2025-03-01 14:25:44.970336
172	ร้านอาหารดังยอดฮิต	14	2025-03-01 14:25:45.140925
173	อาหารระดับมิชลินไกด์	68	2025-03-01 14:49:21.664656
175	แหล่งท่องเที่ยวทางธรรมชาติ	83	2025-03-06 18:49:30.472238
176	แหล่งท่องเที่ยวทางธรรมชาติ	148	2025-03-06 18:49:30.612849
177	แหล่งท่องเที่ยวทางธรรมชาติ	80	2025-03-06 18:49:30.794387
178	แหล่งท่องเที่ยวทางธรรมชาติ	88	2025-03-06 18:49:30.961507
179	แหล่งท่องเที่ยวทางธรรมชาติ	84	2025-03-06 18:52:35.512644
180	แหล่งท่องเที่ยวทางธรรมชาติ	98	2025-03-06 18:52:35.652804
181	แหล่งท่องเที่ยวทางธรรมชาติ	96	2025-03-06 18:52:35.791211
255	อำเภอน้ำพอง	162	2025-03-08 12:44:37.522831
256	อำเภอน้ำพอง	99	2025-03-08 12:44:37.652643
182	แหล่งท่องเที่ยวทางธรรมชาติ	97	2025-03-06 18:52:35.931343
183	แหล่งท่องเที่ยวทางธรรมชาติ	99	2025-03-06 18:52:36.073042
184	แหล่งท่องเที่ยวทางธรรมชาติ	81	2025-03-06 18:52:36.212727
185	แหล่งท่องเที่ยวทางธรรมชาติ	78	2025-03-06 18:52:36.352491
186	แหล่งท่องเที่ยวประเภทน้ำตก	149	2025-03-06 19:11:23.763037
187	แหล่งท่องเที่ยวประเภทน้ำตก	150	2025-03-06 19:11:23.912105
188	แหล่งท่องเที่ยวประเภทน้ำตก	87	2025-03-06 19:11:24.051981
189	แหล่งท่องเที่ยวประเภทน้ำตก	151	2025-03-06 19:11:24.172876
190	แหล่งท่องเที่ยวสำหรับช็อปปิ้ง	109	2025-03-06 19:18:34.76691
191	แหล่งท่องเที่ยวสำหรับช็อปปิ้ง	106	2025-03-06 19:18:34.906415
192	แหล่งท่องเที่ยวสำหรับช็อปปิ้ง	108	2025-03-06 19:18:35.06566
193	แหล่งท่องเที่ยวสำหรับช็อปปิ้ง	107	2025-03-06 19:19:05.956295
195	แหล่งท่องเที่ยวทางศาสนา	152	2025-03-06 19:41:04.251904
196	แหล่งท่องเที่ยวทางศาสนา	155	2025-03-06 19:41:04.381419
197	แหล่งท่องเที่ยวทางศาสนา	103	2025-03-06 19:41:04.501564
198	แหล่งท่องเที่ยวทางศาสนา	153	2025-03-06 19:41:04.621668
202	แหล่งท่องเที่ยวเพื่อนันทนาการ	91	2025-03-06 19:43:31.890624
203	แหล่งท่องเที่ยวเพื่อนันทนาการ	92	2025-03-06 19:43:32.02971
204	แหล่งท่องเที่ยวเพื่อนันทนาการ	85	2025-03-06 19:43:32.179167
205	แหล่งท่องเที่ยวเพื่อนันทนาการ	93	2025-03-06 19:43:32.319522
206	แหล่งท่องเที่ยวเพื่อนันทนาการ	94	2025-03-06 19:43:32.469109
207	แหล่งท่องเที่ยวเพื่อนันทนาการ	95	2025-03-06 19:43:32.61033
208	แหล่งท่องเที่ยวเพื่อนันทนาการ	88	2025-03-06 19:43:32.77046
209	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	100	2025-03-06 19:44:07.503688
210	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	98	2025-03-06 19:44:07.623516
211	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	99	2025-03-06 19:44:07.763498
212	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	96	2025-03-06 19:44:07.903572
213	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	97	2025-03-06 19:44:08.034416
214	แหล่งท่องเที่ยวทางศาสนา	105	2025-03-06 19:51:18.786714
215	แหล่งท่องเที่ยวทางศาสนา	104	2025-03-06 19:51:18.90525
216	แหล่งท่องเที่ยวทางศาสนา	102	2025-03-06 19:51:19.025223
217	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	159	2025-03-07 17:11:30.696684
218	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	158	2025-03-07 17:11:30.835966
219	แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์	156	2025-03-07 17:11:30.99602
220	อำเภออุบลรัตน์	78	2025-03-07 18:27:23.672815
221	อำเภออุบลรัตน์	102	2025-03-07 18:27:23.871514
222	อำเภออุบลรัตน์	99	2025-03-07 18:27:24.032566
223	อำเภอน้ำพอง	105	2025-03-07 18:38:27.870701
224	อำเภอน้ำพอง	153	2025-03-07 18:38:28.010455
225	อำเภอภูผาม่าน	83	2025-03-07 18:53:49.7685
226	อำเภอภูผาม่าน	81	2025-03-07 18:53:49.928232
227	อำเภอภูผาม่าน	90	2025-03-07 18:53:50.077025
228	อำเภอภูผาม่าน	87	2025-03-07 18:53:50.227241
229	อำเภอภูผาม่าน	88	2025-03-07 18:53:50.37704
230	อำเภอภูผาม่าน	89	2025-03-07 18:53:50.528527
231	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	61	2025-03-08 06:16:08.328343
232	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	114	2025-03-08 06:16:08.539079
233	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	84	2025-03-08 06:16:08.73747
234	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	83	2025-03-08 06:16:08.949634
235	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	85	2025-03-08 06:16:09.158031
236	อำเภอภูเวียง	100	2025-03-08 12:04:58.762691
237	อำเภอภูเวียง	97	2025-03-08 12:04:58.922281
238	อำเภอภูเวียง	80	2025-03-08 12:04:59.10142
239	อำเภอภูเวียง	149	2025-03-08 12:04:59.251973
240	อำเภอภูเวียง	103	2025-03-08 12:04:59.43313
241	อำเภอภูเวียง	160	2025-03-08 12:10:55.611637
242	อำเภอเวียงเก่า	103	2025-03-08 12:12:40.995338
243	อำเภอเวียงเก่า	149	2025-03-08 12:12:41.165286
244	อำเภอเวียงเก่า	80	2025-03-08 12:12:41.315328
245	อำเภอเวียงเก่า	100	2025-03-08 12:12:41.474894
246	อำเภอเวียงเก่า	97	2025-03-08 12:12:41.625238
247	อำเภอชุมแพ	124	2025-03-08 12:18:45.581134
248	อำเภอชุมแพ	148	2025-03-08 12:18:45.761103
249	อำเภอชุมแพ	96	2025-03-08 12:18:45.920729
250	อำเภอภูผาม่าน	161	2025-03-08 12:30:52.255846
251	อำเภอหนองเรือ	51	2025-03-08 12:32:24.828863
252	อำเภอหนองเรือ	98	2025-03-08 12:32:24.978827
253	อำเภอหนองเรือ	162	2025-03-08 12:43:37.018643
254	อำเภอน้ำพอง	98	2025-03-08 12:44:37.373958
257	อำเภอบ้านฝาง	70	2025-03-08 15:40:39.556282
258	อำเภอบ้านฝาง	163	2025-03-08 15:40:39.717355
259	อำเภอบ้านฝาง	168	2025-03-08 15:40:39.88552
260	อำเภอบ้านฝาง	165	2025-03-08 15:40:40.036762
261	อำเภอบ้านฝาง	166	2025-03-08 15:40:40.206238
262	อำเภอบ้านฝาง	164	2025-03-08 15:40:40.386456
263	อำเภอเวียงเก่า	172	2025-03-08 15:48:47.642049
264	อำเภอเวียงเก่า	170	2025-03-08 15:48:47.79166
265	อำเภอเวียงเก่า	173	2025-03-08 15:48:47.951499
266	อำเภอเวียงเก่า	171	2025-03-08 15:48:48.11292
267	อำเภออุบลรัตน์	178	2025-03-08 15:54:01.92747
268	อำเภออุบลรัตน์	175	2025-03-08 15:54:02.089049
269	อำเภออุบลรัตน์	183	2025-03-08 15:54:02.256085
270	อำเภออุบลรัตน์	181	2025-03-08 15:54:02.427279
271	อำเภออุบลรัตน์	174	2025-03-08 15:54:02.597244
272	อำเภออุบลรัตน์	176	2025-03-08 15:54:02.776419
273	อำเภออุบลรัตน์	177	2025-03-08 15:54:02.937256
274	อำเภออุบลรัตน์	179	2025-03-08 15:54:03.097588
275	อำเภออุบลรัตน์	180	2025-03-08 15:54:03.256273
278	อำเภอกระนวน	186	2025-03-08 15:57:57.887227
279	อำเภอกระนวน	188	2025-03-08 15:57:58.095986
280	อำเภอกระนวน	191	2025-03-08 15:57:58.247444
281	อำเภอกระนวน	187	2025-03-08 15:57:58.396864
282	อำเภอกระนวน	190	2025-03-08 15:57:58.557124
283	อำเภอกระนวน	192	2025-03-08 15:57:58.707183
284	อำเภอกระนวน	189	2025-03-08 15:57:58.857196
285	อำเภอกระนวน	150	2025-03-08 15:57:59.017066
286	อำเภอภูผาม่าน	197	2025-03-08 15:59:24.113851
287	อำเภอภูผาม่าน	196	2025-03-08 15:59:24.275222
288	อำเภอภูผาม่าน	193	2025-03-08 15:59:24.405456
289	อำเภอภูผาม่าน	195	2025-03-08 15:59:24.543539
290	อำเภอภูผาม่าน	96	2025-03-08 16:01:57.716583
291	อำเภอภูผาม่าน	84	2025-03-08 16:01:57.846434
292	อำเภอภูผาม่าน	148	2025-03-08 16:01:57.976755
293	อำเภอภูผาม่าน	151	2025-03-08 16:01:58.13654
294	อำเภอภูผาม่าน	194	2025-03-08 16:03:18.24408
295	อำเภอเขาสวนกวาง	85	2025-03-08 16:06:27.016504
296	อำเภอเขาสวนกวาง	92	2025-03-08 16:06:27.145015
297	อำเภอเขาสวนกวาง	198	2025-03-08 16:06:27.274986
298	อำเภอเขาสวนกวาง	199	2025-03-08 16:06:27.396742
299	อำเภอเขาสวนกวาง	202	2025-03-08 16:06:27.528175
300	อำเภอเขาสวนกวาง	203	2025-03-08 16:06:27.644949
301	อำเภอเขาสวนกวาง	201	2025-03-08 16:06:27.775026
302	อำเภอเขาสวนกวาง	200	2025-03-08 16:06:27.905364
303	อำเภอเขาสวนกวาง	69	2025-03-08 16:06:28.036197
304	อำเภอเมืองขอนแก่น	9	2025-03-08 16:24:25.004647
305	อำเภอเมืองขอนแก่น	7	2025-03-08 16:24:25.16507
306	อำเภอเมืองขอนแก่น	6	2025-03-08 16:24:25.325248
307	อำเภอเมืองขอนแก่น	12	2025-03-08 16:24:25.505092
308	อำเภอเมืองขอนแก่น	64	2025-03-08 16:24:25.685413
309	อำเภอเมืองขอนแก่น	44	2025-03-08 16:24:25.846699
310	อำเภอเมืองขอนแก่น	21	2025-03-08 16:24:26.025422
311	อำเภอเมืองขอนแก่น	31	2025-03-08 16:24:26.195468
312	อำเภอเมืองขอนแก่น	25	2025-03-08 16:24:26.354316
313	อำเภอเมืองขอนแก่น	91	2025-03-08 16:24:26.545598
314	อำเภอเมืองขอนแก่น	118	2025-03-08 16:24:26.703783
315	อำเภอเมืองขอนแก่น	15	2025-03-08 16:24:26.873459
316	อำเภอเมืองขอนแก่น	114	2025-03-08 16:24:27.07478
317	อำเภอเมืองขอนแก่น	93	2025-03-08 16:24:27.243301
318	อำเภอเมืองขอนแก่น	109	2025-03-08 16:24:27.405089
319	อำเภอเมืองขอนแก่น	106	2025-03-08 16:24:27.583446
320	อำเภอเมืองขอนแก่น	61	2025-03-08 16:24:27.773708
321	อำเภอเมืองขอนแก่น	57	2025-03-08 16:24:27.933837
322	อำเภอเมืองขอนแก่น	155	2025-03-08 16:24:28.133346
323	อำเภอเมืองขอนแก่น	53	2025-03-08 16:24:28.294743
324	อำเภอเมืองขอนแก่น	101	2025-03-08 16:24:28.484014
325	อำเภอเมืองขอนแก่น	134	2025-03-08 16:24:28.653889
326	อำเภอเมืองขอนแก่น	108	2025-03-08 16:24:28.853785
327	อำเภอเมืองขอนแก่น	20	2025-03-08 16:24:29.033517
328	อำเภอเมืองขอนแก่น	68	2025-03-08 16:24:29.203196
329	ร้านอาหารในเมืองขอนแก่น	64	2025-03-08 17:38:16.380709
330	ร้านอาหารในเมืองขอนแก่น	44	2025-03-08 17:38:16.549872
331	ร้านอาหารในเมืองขอนแก่น	58	2025-03-08 17:38:16.711689
332	ร้านอาหารในเมืองขอนแก่น	43	2025-03-08 17:38:16.880867
333	ร้านอาหารในเมืองขอนแก่น	53	2025-03-08 17:38:17.091366
334	ร้านอาหารในเมืองขอนแก่น	52	2025-03-08 17:38:17.261163
335	ร้านอาหารในเมืองขอนแก่น	50	2025-03-08 17:38:17.440032
336	ร้านอาหารในเมืองขอนแก่น	116	2025-03-08 17:38:17.60958
337	ร้านอาหารในเมืองขอนแก่น	112	2025-03-08 17:38:17.770315
338	ร้านอาหารในเมืองขอนแก่น	36	2025-03-08 17:38:17.95101
339	ร้านอาหารในเมืองขอนแก่น	61	2025-03-08 17:38:18.130939
340	ร้านอาหารในเมืองขอนแก่น	114	2025-03-08 17:38:18.310036
341	ร้านอาหารในเมืองขอนแก่น	54	2025-03-08 17:38:18.480816
342	ร้านอาหารในเมืองขอนแก่น	65	2025-03-08 17:38:18.660871
343	ร้านอาหารในเมืองขอนแก่น	57	2025-03-08 17:38:18.820615
344	ร้านอาหารในเมืองขอนแก่น	113	2025-03-08 17:38:19.000598
345	ร้านอาหารในเมืองขอนแก่น	125	2025-03-08 17:38:19.181121
346	ร้านอาหารในเมืองขอนแก่น	56	2025-03-08 17:38:19.350563
347	ร้านอาหารในเมืองขอนแก่น	146	2025-03-08 17:38:19.519918
348	ร้านอาหารในเมืองขอนแก่น	63	2025-03-08 17:38:19.730035
349	ร้านอาหารในเมืองขอนแก่น	118	2025-03-08 17:38:19.899922
350	ร้านอาหารในเมืองขอนแก่น	117	2025-03-08 17:38:20.06948
351	ร้านอาหารในเมืองขอนแก่น	134	2025-03-08 17:38:20.230575
352	ร้านอาหารในเมืองขอนแก่น	67	2025-03-08 17:38:20.389573
353	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	97	2025-03-12 18:51:18.503936
354	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	96	2025-03-12 18:51:18.68323
355	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	81	2025-03-12 18:51:18.892285
356	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	98	2025-03-12 18:51:19.073079
357	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	151	2025-03-12 18:51:19.253148
358	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	149	2025-03-12 18:51:19.453199
359	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	87	2025-03-12 18:51:19.622957
360	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	150	2025-03-12 18:51:19.792625
361	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	91	2025-03-12 18:51:19.972046
362	แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก	92	2025-03-12 18:51:20.142785
363	อำเภอชุมแพ	122	2025-03-20 17:35:58.700935
364	อำเภอชุมแพ	157	2025-03-20 17:35:58.879758
365	อำเภอชุมแพ	186	2025-03-20 17:35:59.049804
366	อำเภอชุมแพ	188	2025-03-20 17:35:59.22053
374	อำเภอเปือยน้อย	157	2025-03-20 17:47:30.189129
375	อำเภอเปือยน้อย	188	2025-03-20 17:47:30.369212
376	อำเภอเปือยน้อย	175	2025-03-20 17:47:30.54813
\.


--
-- TOC entry 3444 (class 0 OID 31544)
-- Dependencies: 213
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, line_id, display_name, picture_url, status_message, created_at) FROM stdin;
766	U15b053b316ae91ca75cda047c0880a62	เหนือฟ้า พองพรหม	https://sprofile.line-scdn.net/0h2xSrVKhFbVd-C39AOGMTKA5bbj1dejRFWmwqM00NMm9KOyoJU2UjNBgKMDcQOi0GVz4mNUsLYDVyGBoxYF2RY3k7MGZCPSsIUmsksQ	\N	2025-03-19 04:43:29.963612
324	Ub8a9217d5f0885468d6aafd9b19d55ae	aor	https://sprofile.line-scdn.net/0hyIiGQJnLJmZEPjemdppYGTRuJQxnT390YVA5VCE6LAN5C2UzYV9rUnhteQIuB2czO1E8UHdseFJILVEAWmjaUkMOe1d4CGA2bF5ohA	\N	2025-03-03 16:49:57.278619
779	U2f7f85958491b5f61fbc6a61c53295b6	JoJoe	https://profile.line-scdn.net/0m033c42b77251b86dd6b240fae49a45572d56f538e2df	\N	2025-03-19 04:44:18.616174
1	U8bb799fbd66fe92d932f721fa58073c8	Aichon 🌿	https://sprofile.line-scdn.net/0h3Ub7FXekbHpPTnzrt8USBT8ebxBsPzVoaiwgHi5NMRl0KiItYy4mTHpPZkJ2eHh-aypzSS5JMh9DXRscURiQTkh-MUtzeCoqZy4imA	Cholthicha	2025-02-14 16:20:39.553696
335	U0d65f543b3eacdb04e6183a7708607ce	FFFFFFFF	https://sprofile.line-scdn.net/0hZLpX6BMOBWNdIRRpZVx7HC1xBgl-UFxxcBdIV2h2XlpmREpiIhMeBjxxWVM1FUA0cE5OBm51DgRRMnIFQ3f5V1oRWFJhFUUydU5JgQ	ครับ	2025-03-03 18:54:06.749623
748	U4c20a808f50413941c43e28c46313be3	พี่หมีเกาพุง🐻	https://sprofile.line-scdn.net/0hn5QdQzwRMRp8HSGp7lRPZQxNMnBfbGgIUCsre09OZyITLSZIB356eE8fOC1ELXNLVSsrdUwfaCJwDkZ8YkvNLnstbCtAK3dFUH14_A	It's on you.(excited)(excited)	2025-03-19 04:42:54.688335
755	Ue7bec039d9d7f0cd8301cad771595304	สมคิด	https://sprofile.line-scdn.net/0hstZeyvmqLFt3HD3lEAJSZQdMLzFUbXVJXi0xNEQddmkdLWoFDH1qNEAfJWxJeGwFDyljbUVMcmNVKwh-GzJ_PAZ9AA8UShRlH3pjRgZCFRAwVw51JQUUdBtKdmoWe25WHDg9Szd4CR40Tx5XD34mTyxpDC8PWykRHEtADXIuQtgYHlsOWntlPEscdG3K	สิรภัทรเองฮ๊าฟ	2025-03-19 04:43:12.86144
757	U18c3db42d34e75e749b5aa2eaa986226	Jejennnn	https://sprofile.line-scdn.net/0hka3vT64GNE4eDyX8XspKcG5fNyQ9fm1cOmp-LiNdaXdwaCcRNW97KiJca3kjNiFMMjwvKyMObX08RHddahUNbWAPNRh-Zi16TjoMdVEGbRhkbyl2d206VTdvCSZRRwBRUzoSbmNVbihzWXtsdDIGbWpPOiVXUQNIVlhYGBs9Ws1xDUMbM2h9KSIPbHij	\N	2025-03-19 04:43:15.001896
780	Ua9418a1b029794b9fb085c5baf8dfbbc	I’m Pack	https://sprofile.line-scdn.net/0hCVV2H83gHHl7SwzzaK1iBgsbHxNYOkVrXitUTE1JQE9Ofg57BSpaGUkcQR0Wf1ktBS9TShkYEUF3WGsfZR3gTXx7QUhHfVomVytVnw	\N	2025-03-19 04:44:27.890984
767	U59bcba9187794d8660191ab540d4fec4	Px☘️	https://sprofile.line-scdn.net/0hKqY88a8VFF50QQH_uK1qIQQRFzRXME1MXiBSaxZBTGZIcVpdD3MLPUdASWtBJVEODS4MbUYSGmx4UmM4ahfoanNxSW9Id1IBWCFduA	\N	2025-03-19 04:43:33.183302
399	U87127e7fcb2e75e70f4674e568e9128e	Sometimes Somewhere	https://sprofile.line-scdn.net/0hcykgcn-mPFZGHi35RKhCKTZOPzxlb2VEYnkhMiNOZW8vLy4Cby92MnoXYWR8fSkJbCtxM3McZ2FKDUswWEjAYkEuYWd6KnwHbnFwtA	\N	2025-03-08 05:04:09.441562
326	U4e9fa087e74005588a5134d715601b7d	\N	\N	\N	2025-03-03 18:21:55.499258
327	U067bc64a38b85fe071ae5af07bbb6699	Paksa	https://sprofile.line-scdn.net/0h4tHUGojga1tlLHq7wB4VJBV8aDFGXTJJSU8sPQUlZT8KHX4EQUMkO1coYTtcTHkISUstPwIlNThpPxw9e3qXb2IcNmpZGCsKTUMnuQ	\N	2025-03-03 18:25:49.838016
708	U2e84cb84e8adfd6627a179dd40213316	🍫y~~	https://sprofile.line-scdn.net/0hyg-Vv56WJkgALzToysxYN3B_JSIjXn9aKUpoeWcsL35qTDUXKEk5J2Yseno8GjEdLEw6emB8eHkMPFEuHnnafAcfe3k8GWAYKE9oqg	!!! 095-195-9241 !!!	2025-03-18 14:22:35.211642
749	U7ff7b8882236e6d113da17efff64bccc	fifa	https://sprofile.line-scdn.net/0hh5SVlfeHNxp-LydDiN9JZQ5_NHBdXm4IBh0rKxl_bn9ET3YbVBx5fRwmaS5BGCAfV0sofkMsOShyPEB8YHnLLnkfaitCGXFFUk9-_A	\N	2025-03-19 04:42:55.174395
751	U8a7b02a81918a490265efcf4937f5fe9	Pongsathon Janyoi	https://sprofile.line-scdn.net/0haFCBEqcZPmluOxNFY9tAFh5rPQNNSmd7EA0iW19uZFBXWXk9RVoiCFo_YQlQWH49EgkjWw8zaA1iKEkPcG3CXWkLY1hSDXg2Qlt3jw	\N	2025-03-19 04:43:01.313412
744	U63df5cd96ca7bcbb72ba16f688c64a04	aor	https://sprofile.line-scdn.net/0hyIiGvwQ-JmZEPjemdppYGTRuJQxnT390YVA5VCE6LAN5C2UzYV9rUnhteQIuB2czO1E8UHdseFJILVEAWmjaUkMOe1d4CGA5aF5vgA	\N	2025-03-19 04:39:40.059384
763	U19db61d53fc9063d83246616ef07304b	♡	https://sprofile.line-scdn.net/0h_SdFU9a2AHxJPxHaLkd-QjlvAxZqTlluYF5JSig8XEpyBxR4Y1FITXU6XRxxDUYuN1kcHX8-WhhrCEB4HjJLfHpHDTkaUDIqZ144RiNsJyhzaC9sHAk2TQE6KBoLdE5cPT4yWAJoAC5xWBgvFSMITxVPVhwHVTFSA2hsKkwNbv8mPXcpZFhJG3U_WEr0	20:02	2025-03-19 04:43:23.279941
752	U4a16cb3b0fbcb081e7059b2c7317c383	J	https://sprofile.line-scdn.net/0hYOwufPcGBmBaDBfdDL94XipcBQp5fV9yJm4eVWwIWgViPkBidDhND2gEWVQzaEEyI28bUzwFXQJ4PUBFAhgTQRBYOxciaEZjIzk-fDUOPQljfEJmNjkOeh9fUCw9VTVDFiIqaDd3BDc8WSBhEWoMcTB0UUxuXRo0IVtqNl8-aOM1DnE1d2tPB2YMXlbn	\N	2025-03-19 04:43:02.738467
753	U6b440c35e1565e9e492220fb4c82b19b	skypurim	https://sprofile.line-scdn.net/0h2RuQorXDbX1YKH2hyqoTAih4bhd7WTRvdEsgSTl_MB1sEX1-cBonEmsuMxpsSCMrJE8lG25_YE5UOxobRn6RSV8YMExkHisidEgkmw	purim	2025-03-19 04:43:04.779228
588	U07beb378b7b27607e8ea12e2571face4	Aichon 🌿	https://sprofile.line-scdn.net/0h3Ub7-0ilbHpPTnzrt8USBT8ebxBsPzVoaiwgHi5NMRl0KiItYy4mTHpPZkJ2eHh-aypzSS5JMh9DXRscURiQTkh-MUtzeColYy4lnA	Cholthicha	2025-03-17 16:02:27.809789
782	U3b7dd74fb536677f1a2becfa363de412	모메	https://sprofile.line-scdn.net/0hiN76LxxRNmEaTyYtCD1IHmofNQs5Pm9zNHt6UyhHPwYgfiUxYy56VS8YbAUnd3VjNH54AnhGPFcWXEEHBBnKVR1_a1AmeXA-Ni9_hw	(i) (j)(u)(s)(t) (s)(a)(y)\n\neverything (m)(e)(a)(n)(s)\n\nnothing if (i) (c)(a)(n)(')(t)\n\nhave (y)(o)(u)	2025-03-19 04:44:42.050964
\.


--
-- TOC entry 3446 (class 0 OID 31588)
-- Dependencies: 215
-- Data for Name: web_answer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_answer (id, place_name, answer_text, intent_type, image_link, image_detail, contact_link, created_at) FROM stdin;
154	ตามแพะมาคาเฟ่  (Just Follow The Goat The Original)	สำหรับคาเฟ่ขอนแก่นร้านนี้ บอกเลยได้ว่าเป็นร้านดังของขอนแก่นเลยก็ว่าได้ นอกจากจะเป็นคาเฟ่สุดฮิตที่พร้อมเสิร์ฟขนม และกาแฟแสนอร่อยแล้ว ยังเป็นโรงคั่วกาแฟอีกด้วยนะครับ เพราะงั้นเรื่องรสชาติ และเมล็ดกาแฟโดนใจสาวกกาแฟแน่นอนครับ นอกจากนี้บรรยากาศตกแต่งภายในร้านยังสบายๆ มีให้เลือกนั่งทั้งด้านในและด้านนอก ใครมาเที่ยวขอนแก่น แนะนำให้มาลองครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/11-4-576x1024.jpg	ขอบคุณรูปภาพจาก Facebook Just Follow The Goat The Original	https://www.facebook.com/justfollowthegoat.theoriginal	2025-03-09 17:32:29.324705
155	พันธุ์ไม้คาเฟ่ ขอนแก่น (Punma Cafe)	พาเยือนคาเฟ่ขอนแก่นสายธรรมชาติกันที่ พันธุ์ไม้คาเฟ่ ขอนแก่น ที่มาพร้อมบรรยากาศรอบๆ แสนร่มรื่น โอบล้อมไปด้วยต้นไม้เล็กใหญ่ จัดเต็มด้วยเมนูกาแฟ เครื่องดื่ม และเค้ก อิ่มคาวหวาน จบเลยในที่เดียว แถมมีที่จอดรถสะดวก สบายสุดๆ เลยครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/08-4-576x1024.jpg	ขอบคุณรูปภาพจาก Facebook พันธุ์ไม้คาเฟ่	https://www.facebook.com/Punmai.Cafe	2025-03-09 17:33:16.092891
156	กาแฟฉิมพลี (Chimplee Coffee)	อีกร้านกาแฟขอนแก่น ที่ใครมาเที่ยวขอนแก่นไม่ควรพลาดครับ มาพร้อมการตกแต่งร้านแนวโลกอวกาศ และเครื่องดื่มสไตล์ร้านฉิมพลีที่ไม่เหมือนใคร ซึ่งพอตกเย็นร้านนี้ก็จะกลายเป็นร้านนั่งชิล เสิร์ฟเบียร์เย็นๆ และดนตรีสดฟังสบาย อยากสัมผัสสไตล์ไหน ก็เลือกเอาได้ตามใจเลยครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/07-4-576x1024.jpg	ขอบคุณรูปภาพจาก Facebook กาแฟฉิมพลี	https://www.facebook.com/CafeChimplee	2025-03-09 17:33:47.923466
157	Lecithin Special Coffee	ร้านกาแฟขอนแก่นโทนสีขาว-ดำ เน้นการตกแต่งเรียบง่าย แต่แฝงไปด้วยความดิบ และดุดันจากสีดำ ซึ่งเป็นสีหลักของทางร้านครับ ในส่วนของเครื่องดื่มนั้น ขึ้นชื่อว่าเป็นร้านกาแฟแบบ Specialty ดังนั้นจึงมีเมล็ดกาแฟและรูปแบบกาแฟให้เลือกหลากหลายเลยครับ  ไม่ว่าจะเป็น Nitro Brew Coffee, Coffee Latte ส่วนใครที่ไม่ใช่สายชิมกาแฟ คาเฟ่นี้ก็มีเมนูอื่นๆ ไม่เหมือนใครให้ได้ลิ้มลองเช่นกันครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/06-4-1024x576.jpg	ขอบคุณรูปภาพจาก Facebook Lecithin special coffee	https://www.facebook.com/LecithinSpecialCoffee	2025-03-09 17:42:23.03381
158	Honshu cafe	คาเฟ่ขอนแก่น สไตล์ญี่ปุ๊น ญี่ปุ่น ด้วยโทนสีขาว คลีนๆ เน้นความเรียบง่าย มีมุมถ่ายรูปเป็นไฮไลต์อยู่หลายมุมเลยล่ะครับ แน่นอนว่ามาคาเฟ่ขอนแก่นสไตล์ญี่ปุ่น เมนูไฮไลต์ก็ต้องแนวญี่ปุ่นสักหน่อย ขอแนะนำ ชาเขียวมัทฉะ ที่มีให้เลือกหลากหลายรูปแบบ รวมไปถึงเมนูขนมหวาน น่ารัก ถ่ายรูปสวย แถมอร่อยไม่ผิดหวังแน่นอนครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/05-4-1024x576.jpg	ขอบคุณรูปภาพจาก Facebook Honshū café	https://www.facebook.com/honshucafe	2025-03-09 17:43:09.859029
159	2k บุฟเฟ่ต์ หมูกระทะ & ซีฟู้ด	เวลา เปิด-ปิด : ทุกวัน 17.00-23.00 น.	เวลาเปิดทำการ	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-09 18:02:58.789154
160	มิ่งหมูกะทะ มข.	เวลาเปิด-ปิด : 16.30 – 05.00 น.	เวลาเปิดทำการ	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-09 18:11:39.673458
161	S Bar BQ เอสบาร์บีคิว	ราคา : 245 บาท	ค่าธรรมเนียมการเข้า	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-09 18:14:33.370689
163	จุดชมวิวหินช้างสี อุทยานแห่งชาติน้ำพอง	ค่าเข้าชม : ผู้ใหญ่ 20 บาท เด็ก 10 บาท , ชาวต่างชาติ ผู้ใหญ่ 100 บาท เด็ก 50 บาท	ค่าธรรมเนียมการเข้า	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-17 15:44:43.214178
164	ฟ้าทะลายโจร (Fahtalaijone Art Studio & Cafe)	คาเฟ่สุดชิคใจกลางเมืองขอนแก่นที่โดดเด่นไม่เหมือนใคร เพราะนอกจากจะเป็นคาเฟ่แล้วที่นี่ ยังเป็น อาร์ต สตูดิโอ อีกด้วยครับ ดังนั้นจึงจัดหนักเรื่องตกแต่งร้าน รวมไปถึงเมนูเด็ดๆ ไม่เหมือนใคร มีเฉพาะที่นี่เท่านั้น ใครอยากชมงานอาร์ตเจ๋งๆ พร้อมจิบเครื่องดื่ม ขนมอร่อยๆ ก็มาลองที่คาเฟ่ขอนแก่นแห่งนี้กันได้เลยครับ	รายละเอียด	https://blog.drivehub.co/wp-content/uploads/2023/08/20-4-1024x576.jpg	ขอบคุณรูปภาพจาก Facebook 𝗙𝗔𝗛-𝗧𝗔𝗟𝗔𝗜-𝗝𝗢𝗡𝗘	https://web.facebook.com/profile.php?id=10004865603598	2025-03-17 19:31:20.190563
165	น้ำตกบ๋าหลวง	ไม่พบข้อมูลที่ตรงกับคำถาม	ค่าธรรมเนียมการเข้า	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-18 14:07:12.715694
166	ผาชมตะวัน	ไม่พบข้อมูลที่ตรงกับคำถาม	ค่าธรรมเนียมการเข้า	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-18 14:57:21.591519
167	ฟ้าสางหมูกระทะ	ราคา : 149 บาท / ชุด	ค่าธรรมเนียมการเข้า	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-18 15:10:08.862683
168	หมู่บ้านงูจงอาง	เวลาทำการ: 08.00 น. – 17.00 น.	เวลาเปิดทำการ	ไม่มีรูปภาพ	ไม่มีรายละเอียดรูปภาพ	ไม่มีข้อมูลติดต่อ	2025-03-27 07:07:51.61443
\.


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 216
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conversations_id_seq', 762, true);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 219
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.event_id_seq', 37, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 223
-- Name: place_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.place_images_id_seq', 1863, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 221
-- Name: places_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.places_id_seq', 204, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 225
-- Name: tourist_destinations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tourist_destinations_id_seq', 376, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 815, true);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 214
-- Name: web_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.web_answer_id_seq', 168, true);


--
-- TOC entry 3287 (class 2606 OID 31606)
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 31651)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 31668)
-- Name: place_images place_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.place_images
    ADD CONSTRAINT place_images_pkey PRIMARY KEY (id);


--
-- TOC entry 3295 (class 2606 OID 31660)
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 31634)
-- Name: table_counts table_counts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.table_counts
    ADD CONSTRAINT table_counts_pkey PRIMARY KEY (table_name);


--
-- TOC entry 3299 (class 2606 OID 31681)
-- Name: tourist_destinations tourist_destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tourist_destinations
    ADD CONSTRAINT tourist_destinations_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 31608)
-- Name: conversations unique_user_place; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT unique_user_place UNIQUE (user_id, place_id, event_id);


--
-- TOC entry 3281 (class 2606 OID 31554)
-- Name: users users_line_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_line_id_key UNIQUE (line_id);


--
-- TOC entry 3283 (class 2606 OID 31552)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 31596)
-- Name: web_answer web_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_answer
    ADD CONSTRAINT web_answer_pkey PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 31609)
-- Name: conversations conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3301 (class 2606 OID 31619)
-- Name: conversations conversations_web_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_web_answer_id_fkey FOREIGN KEY (web_answer_id) REFERENCES public.web_answer(id);


--
-- TOC entry 3302 (class 2606 OID 31669)
-- Name: place_images place_images_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.place_images
    ADD CONSTRAINT place_images_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.places(id) ON DELETE CASCADE;


--
-- TOC entry 3303 (class 2606 OID 31682)
-- Name: tourist_destinations tourist_destinations_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tourist_destinations
    ADD CONSTRAINT tourist_destinations_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.places(id) ON DELETE CASCADE;


-- Completed on 2025-04-09 22:13:12

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

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3

-- Started on 2025-04-09 22:13:12

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


-- Completed on 2025-04-09 22:13:12

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-04-09 22:13:12

--
-- PostgreSQL database cluster dump complete
--

