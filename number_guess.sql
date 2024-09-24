--
-- PostgreSQL database dump
--

-- Dumped from database version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: guessing_game; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guessing_game (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer NOT NULL,
    game_id integer NOT NULL
);


ALTER TABLE public.guessing_game OWNER TO freecodecamp;

--
-- Name: guessing_game_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guessing_game_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guessing_game_game_id_seq OWNER TO freecodecamp;

--
-- Name: guessing_game_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guessing_game_game_id_seq OWNED BY public.guessing_game.game_id;


--
-- Name: guessing_game_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guessing_game_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guessing_game_user_id_seq OWNER TO freecodecamp;

--
-- Name: guessing_game_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guessing_game_user_id_seq OWNED BY public.guessing_game.user_id;


--
-- Name: guessing_game user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_game ALTER COLUMN user_id SET DEFAULT nextval('public.guessing_game_user_id_seq'::regclass);


--
-- Name: guessing_game game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_game ALTER COLUMN game_id SET DEFAULT nextval('public.guessing_game_game_id_seq'::regclass);


--
-- Data for Name: guessing_game; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guessing_game VALUES (1, 's', 0, 3, 1);
INSERT INTO public.guessing_game VALUES (2, 'user_1727157806236', 0, 441, 2);
INSERT INTO public.guessing_game VALUES (3, 'user_1727157806236', 1, 219, 3);
INSERT INTO public.guessing_game VALUES (4, 'user_1727157806235', 0, 808, 4);
INSERT INTO public.guessing_game VALUES (5, 'user_1727157806235', 1, 157, 5);
INSERT INTO public.guessing_game VALUES (6, 'user_1727157806236', 2, 99, 6);
INSERT INTO public.guessing_game VALUES (7, 'user_1727157806236', 3, 495, 7);
INSERT INTO public.guessing_game VALUES (8, 'user_1727157806236', 4, 921, 8);
INSERT INTO public.guessing_game VALUES (9, 'user_1727158333391', 0, 95, 9);
INSERT INTO public.guessing_game VALUES (10, 'user_1727158333391', 1, 696, 10);
INSERT INTO public.guessing_game VALUES (11, 'user_1727158333390', 0, 300, 11);
INSERT INTO public.guessing_game VALUES (12, 'user_1727158333390', 1, 730, 12);
INSERT INTO public.guessing_game VALUES (13, 'user_1727158333391', 2, 448, 13);
INSERT INTO public.guessing_game VALUES (14, 'user_1727158333391', 3, 736, 14);
INSERT INTO public.guessing_game VALUES (15, 'user_1727158333391', 4, 548, 15);
INSERT INTO public.guessing_game VALUES (16, 'user_1727158764856', 0, 975, 16);
INSERT INTO public.guessing_game VALUES (17, 'user_1727158764856', 1, 543, 17);
INSERT INTO public.guessing_game VALUES (18, 'user_1727158764855', 0, 430, 18);
INSERT INTO public.guessing_game VALUES (19, 'user_1727158764855', 1, 894, 19);
INSERT INTO public.guessing_game VALUES (20, 'user_1727158764856', 2, 204, 20);
INSERT INTO public.guessing_game VALUES (21, 'user_1727158764856', 3, 314, 21);
INSERT INTO public.guessing_game VALUES (22, 'user_1727158764856', 4, 867, 22);


--
-- Name: guessing_game_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guessing_game_game_id_seq', 22, true);


--
-- Name: guessing_game_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guessing_game_user_id_seq', 22, true);


--
-- Name: guessing_game guessing_game_game_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_game
    ADD CONSTRAINT guessing_game_game_id_key UNIQUE (game_id);


--
-- Name: guessing_game guessing_game_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_game
    ADD CONSTRAINT guessing_game_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

