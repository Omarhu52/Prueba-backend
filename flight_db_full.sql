--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: flights; Type: TABLE; Schema: public; Owner: flight_user
--

CREATE TABLE public.flights (
    id integer NOT NULL,
    airline character varying(255) NOT NULL,
    origin_city character varying(255) NOT NULL,
    destination_city character varying(255) NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    price numeric(10,2) NOT NULL,
    seat_category character varying(50) NOT NULL,
    available_seats integer NOT NULL,
    status character varying(50) DEFAULT 'on time'::character varying NOT NULL
);


ALTER TABLE public.flights OWNER TO flight_user;

--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: flight_user
--

CREATE SEQUENCE public.flights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flights_id_seq OWNER TO flight_user;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: flight_user
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchases (
    id integer NOT NULL,
    reservation_id integer NOT NULL,
    user_id integer NOT NULL,
    payment_method character varying(255) NOT NULL,
    payment_status character varying(50) DEFAULT 'pending'::character varying,
    purchase_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount double precision NOT NULL
);


ALTER TABLE public.purchases OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchases_id_seq OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    flight_id integer NOT NULL,
    user_id integer NOT NULL,
    reservation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    seats_reserved integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(50) DEFAULT 'confirmed'::character varying
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservations_id_seq OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    credit_card character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: flight_user
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: flight_user
--

COPY public.flights (id, airline, origin_city, destination_city, departure_time, arrival_time, price, seat_category, available_seats, status) FROM stdin;
2	Airline B	City A	City C	2024-12-20 12:00:00	2024-12-20 14:30:00	150.00	Business	29	on time
1	Airline A	City A	City B	2024-12-20 08:00:00	2024-12-20 10:00:00	100.00	Economy	35	on time
\.


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchases (id, reservation_id, user_id, payment_method, payment_status, purchase_date, total_amount) FROM stdin;
1	1	1	credit_card	paid	2024-12-14 12:29:24.413519	200
2	2	1	credit_card	paid	2024-12-14 12:39:23.872458	200
3	7	5	credit_card	pending	2024-12-16 04:06:54.279961	100
4	6	5	credit_card	pending	2024-12-16 04:07:45.836816	100
5	6	5	credit_card	pending	2024-12-16 04:07:56.974175	100
6	6	5	credit_card	pending	2024-12-16 04:11:09.179925	100
7	7	5	credit_card	pending	2024-12-16 04:22:14.589755	100
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, flight_id, user_id, reservation_date, seats_reserved, total_price, status) FROM stdin;
1	1	1	\N	2	200.00	confirmed
2	1	1	\N	2	200.00	confirmed
3	1	1	2024-12-14 11:58:35.419502	2	200.00	confirmed
5	1	2	2024-12-14 12:38:12.684604	2	200.00	confirmed
8	1	5	2024-12-16 03:02:18.499238	1	100.00	confirmed
9	1	5	2024-12-16 03:04:30.523917	1	100.00	confirmed
10	1	5	2024-12-16 03:08:43.539949	1	100.00	confirmed
11	1	5	2024-12-16 03:14:01.238765	1	100.00	confirmed
6	1	5	2024-12-16 02:58:43.665165	1	100.00	purchased
12	2	5	2024-12-16 04:21:29.606486	1	150.00	confirmed
7	1	5	2024-12-16 03:02:09.413204	1	100.00	purchased
13	1	5	2024-12-16 04:39:45.988901	1	100.00	confirmed
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, credit_card) FROM stdin;
1	user@example.com	$2b$12$Hbd5yQThykTp9mq1P9yTouBVMjXpFIaWG1Gsq/BbY0FUK71wLy2dO	\N
2	omar@gmail.com	$2b$12$nP2T52e1m3/ib42wa28PZuZP7RayXv8Afu0V3XctovxuiTtl.BVGO	\N
3	ss@example.com	$2b$12$7IieGxQTcSVq1dbNrn.opOUFbafEnMAHsLPcxpmyc6683Oe/LIkdG	123
4	ssssa@example.com	$2b$12$1YvFwQF98Yi2OMuHABTkXuEJozGAp09U7zh68epFHL2YP5uJE0hxy	123
5	sssxxsa@example.com	$2b$12$ewXXq5vNe5j3PSuSHJTgluYGtnbPNeuoeUpf/sa4ZU2m1yCCFlV/S	123
\.


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: flight_user
--

SELECT pg_catalog.setval('public.flights_id_seq', 2, true);


--
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchases_id_seq', 7, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: flight_user
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservations(id) ON DELETE CASCADE;


--
-- Name: purchases purchases_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: reservations reservations_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(id);


--
-- Name: reservations reservations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO flight_user;


--
-- Name: TABLE purchases; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.purchases TO flight_user;


--
-- Name: SEQUENCE purchases_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.purchases_id_seq TO flight_user;


--
-- Name: TABLE reservations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reservations TO flight_user;


--
-- Name: SEQUENCE reservations_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.reservations_id_seq TO flight_user;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO flight_user;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO flight_user;


--
-- PostgreSQL database dump complete
--

