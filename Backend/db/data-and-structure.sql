--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: campus_buzz; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE campus_buzz (
    int_glcode integer NOT NULL,
    var_title character varying(255),
    var_description text,
    fk_university integer,
    dt_expiredate date,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255),
    var_ipaddress character varying(255),
    fk_user_id integer,
    int_count integer DEFAULT 0 NOT NULL,
    chr_status character(1) DEFAULT 0 NOT NULL,
    chr_block character(1) DEFAULT 0 NOT NULL
);


ALTER TABLE public.campus_buzz OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_buzz_gallery; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE campus_buzz_gallery (
    int_glcode integer NOT NULL,
    var_title character varying(255),
    var_image character varying(100),
    fk_campus_buzz integer,
    fk_user_id integer,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL
);


ALTER TABLE public.campus_buzz_gallery OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_buzz_gallery_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE campus_buzz_gallery_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campus_buzz_gallery_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_buzz_gallery_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE campus_buzz_gallery_int_glcode_seq OWNED BY campus_buzz_gallery.int_glcode;


--
-- Name: campus_buzz_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE campus_buzz_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campus_buzz_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_buzz_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE campus_buzz_int_glcode_seq OWNED BY campus_buzz.int_glcode;


--
-- Name: campus_deal; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE campus_deal (
    int_glcode integer NOT NULL,
    var_title character varying(255),
    var_description text,
    fk_university integer,
    dt_expiredate date,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255) NOT NULL,
    var_ipaddress character varying(255) NOT NULL,
    fk_user_id integer,
    var_dealcode character varying(50),
    code_count integer DEFAULT 0 NOT NULL,
    chr_status character(1) DEFAULT 0 NOT NULL,
    chr_block character(1) DEFAULT 0 NOT NULL
);


ALTER TABLE public.campus_deal OWNER TO thriftskool_mobileappuser;

--
-- Name: COLUMN campus_deal.chr_status; Type: COMMENT; Schema: public; Owner: thriftskool_mobileappuser
--

COMMENT ON COLUMN campus_deal.chr_status IS '0=Active
1=Expire
2=Close';


--
-- Name: COLUMN campus_deal.chr_block; Type: COMMENT; Schema: public; Owner: thriftskool_mobileappuser
--

COMMENT ON COLUMN campus_deal.chr_block IS '0 = unblock
1 = Block';


--
-- Name: campus_deal_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE campus_deal_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campus_deal_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_deal_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE campus_deal_int_glcode_seq OWNED BY campus_deal.int_glcode;


--
-- Name: campus_gallery; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE campus_gallery (
    int_glcode integer NOT NULL,
    var_title character varying(255),
    var_image character varying(100),
    fk_campus_deal integer,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    fk_user_id integer
);


ALTER TABLE public.campus_gallery OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_gallery_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE campus_gallery_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campus_gallery_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: campus_gallery_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE campus_gallery_int_glcode_seq OWNED BY campus_gallery.int_glcode;


--
-- Name: category; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE category (
    int_glcode integer NOT NULL,
    var_title character varying(255) NOT NULL,
    var_alias character varying(255) DEFAULT NULL::character varying,
    int_displayorder integer NOT NULL,
    dt_createddate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    var_metatitle character varying(250) DEFAULT NULL::character varying,
    var_metakeyword character varying(500) DEFAULT NULL::character varying,
    var_metadescription text,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255) NOT NULL,
    var_ipaddress character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO thriftskool_mobileappuser;

--
-- Name: category_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE category_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: category_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE category_int_glcode_seq OWNED BY category.int_glcode;


--
-- Name: contactusleads; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE contactusleads (
    int_glcode integer NOT NULL,
    var_name character varying(255) NOT NULL,
    var_email character varying(255) NOT NULL,
    var_message text NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    fk_user_id integer
);


ALTER TABLE public.contactusleads OWNER TO thriftskool_mobileappuser;

--
-- Name: contactusleads_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE contactusleads_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contactusleads_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: contactusleads_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE contactusleads_int_glcode_seq OWNED BY contactusleads.int_glcode;


--
-- Name: favorite; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE favorite (
    int_glcode integer NOT NULL,
    fk_user_id integer,
    fk_post integer,
    dt_createdate timestamp without time zone NOT NULL,
    chr_favorite character(1) DEFAULT 0 NOT NULL,
    type character varying(2)
);


ALTER TABLE public.favorite OWNER TO thriftskool_mobileappuser;

--
-- Name: COLUMN favorite.type; Type: COMMENT; Schema: public; Owner: thriftskool_mobileappuser
--

COMMENT ON COLUMN favorite.type IS '1 = post

2 = Buzz 

3 =deal '';';


--
-- Name: favorite_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE favorite_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorite_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: favorite_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE favorite_int_glcode_seq OWNED BY favorite.int_glcode;


--
-- Name: general_settings; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE general_settings (
    int_glcode integer NOT NULL,
    var_sitename character varying(50) NOT NULL,
    var_sitepath character varying(100) NOT NULL,
    chr_seo_flag character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_maintenance character(1) NOT NULL,
    var_contactusmail character varying(100)
);


ALTER TABLE public.general_settings OWNER TO thriftskool_mobileappuser;

--
-- Name: general_settings_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE general_settings_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.general_settings_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: general_settings_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE general_settings_int_glcode_seq OWNED BY general_settings.int_glcode;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE groups (
    int_glcode integer NOT NULL,
    var_name character varying(200) NOT NULL,
    int_displayorder integer NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_read character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_star character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_adminpanel_group character(1) DEFAULT 'Y'::bpchar NOT NULL,
    dt_createdate date NOT NULL,
    dt_modifydate date NOT NULL
);


ALTER TABLE public.groups OWNER TO thriftskool_mobileappuser;

--
-- Name: job_management; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE job_management (
    int_glcode integer NOT NULL,
    var_jobname character varying(255) NOT NULL,
    var_description text NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255),
    var_ipaddress character varying(255),
    fk_user_id integer,
    dt_expiredate date,
    fk_university integer
);


ALTER TABLE public.job_management OWNER TO thriftskool_mobileappuser;

--
-- Name: job_management_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE job_management_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_management_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: job_management_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE job_management_int_glcode_seq OWNED BY job_management.int_glcode;


--
-- Name: logmanager; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE logmanager (
    int_glcode integer NOT NULL,
    fk_user_id integer,
    fk_modulename integer,
    var_tablename character varying(255),
    chr_read character(1) DEFAULT 'N'::bpchar,
    dt_createdate timestamp without time zone,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    var_referenceid integer,
    notification_type character varying(2),
    fk_post_id integer,
    from_where character(1),
    chr_send character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.logmanager OWNER TO thriftskool_mobileappuser;

--
-- Name: logmanager_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE logmanager_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logmanager_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: logmanager_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE logmanager_int_glcode_seq OWNED BY logmanager.int_glcode;


--
-- Name: manage_gcmcode; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE manage_gcmcode (
    int_glcode integer NOT NULL,
    fk_user integer,
    gcm_code text,
    dt_createdate timestamp without time zone NOT NULL
);


ALTER TABLE public.manage_gcmcode OWNER TO thriftskool_mobileappuser;

--
-- Name: manage_gcmcode_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE manage_gcmcode_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manage_gcmcode_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: manage_gcmcode_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE manage_gcmcode_int_glcode_seq OWNED BY manage_gcmcode.int_glcode;


--
-- Name: message_list; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE message_list (
    int_glcode integer NOT NULL,
    fk_thread integer,
    fk_user_id integer,
    fk_post integer,
    var_user_name character varying(255) NOT NULL,
    var_message text NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    chr_read character(1) DEFAULT 0 NOT NULL,
    own_delete character(1) DEFAULT 0,
    usr_delete character(1) DEFAULT 0
);


ALTER TABLE public.message_list OWNER TO thriftskool_mobileappuser;

--
-- Name: message_list_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE message_list_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_list_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: message_list_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE message_list_int_glcode_seq OWNED BY message_list.int_glcode;


--
-- Name: message_thread; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE message_thread (
    int_glcode integer NOT NULL,
    fk_user_id integer,
    fk_post integer,
    var_user_name character varying(255) NOT NULL,
    var_message text NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    chr_read character(1) DEFAULT 0,
    post_name character varying(100),
    post_owner_id integer,
    from_read character(1) DEFAULT 0,
    own_delete character varying(10) DEFAULT 0,
    usr_delete character varying(10) DEFAULT 0 NOT NULL
);


ALTER TABLE public.message_thread OWNER TO thriftskool_mobileappuser;

--
-- Name: message_thread_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE message_thread_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_thread_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: message_thread_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE message_thread_int_glcode_seq OWNED BY message_thread.int_glcode;


--
-- Name: module_useraction; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE module_useraction (
    int_glcode integer NOT NULL,
    fk_modules integer NOT NULL,
    fk_useraction integer NOT NULL,
    chr_custom character(1) DEFAULT ''::bpchar NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    dt_modifydate date NOT NULL
);


ALTER TABLE public.module_useraction OWNER TO thriftskool_mobileappuser;

--
-- Name: module_useraction_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE module_useraction_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_useraction_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: module_useraction_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE module_useraction_int_glcode_seq OWNED BY module_useraction.int_glcode;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE modules (
    int_glcode integer NOT NULL,
    var_modulename character varying(50) DEFAULT NULL::character varying,
    var_module_listing character varying(255),
    var_module_form_listing character varying(255) NOT NULL,
    var_header_text character varying(255) NOT NULL,
    var_header_class character varying(255) NOT NULL,
    fk_module integer NOT NULL,
    chr_edit_delete character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_cached character(1) DEFAULT 'N'::bpchar NOT NULL,
    dt_createdate date,
    dt_modifydate date,
    chr_adminpanel_module character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_show_trashmanager character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_link character varying(255),
    var_tablename character varying(100) DEFAULT NULL::character varying,
    chr_filterflag character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_pro_modulename character varying(255) NOT NULL,
    chr_menu character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_group_access character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_gallerymodule_flag character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_custom character(1) DEFAULT 'N'::bpchar NOT NULL,
    var_field character varying(100)
);


ALTER TABLE public.modules OWNER TO thriftskool_mobileappuser;

--
-- Name: modules_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE modules_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modules_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: modules_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE modules_int_glcode_seq OWNED BY modules.int_glcode;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE pages (
    int_glcode integer NOT NULL,
    var_pagetype integer NOT NULL,
    chr_custom character(1) DEFAULT 'N'::bpchar NOT NULL,
    var_pagename character varying(500) DEFAULT NULL::character varying,
    var_alias character varying(255) NOT NULL,
    text_fulltext text,
    var_pdffile character varying(255) DEFAULT NULL::character varying,
    var_url_file character varying(500) DEFAULT NULL::character varying,
    var_short_description character varying(450) DEFAULT NULL::character varying,
    var_image character varying(500) DEFAULT NULL::character varying,
    var_url_image character varying(500) DEFAULT NULL::character varying,
    var_image1 character varying(500) DEFAULT NULL::character varying,
    var_url_image1 character varying(500) DEFAULT NULL::character varying,
    var_metatitle character varying(250) DEFAULT NULL::character varying,
    var_metakeyword character varying(500) DEFAULT NULL::character varying,
    var_metadescription text,
    int_pagehits integer DEFAULT 0,
    int_mobhits integer DEFAULT 0 NOT NULL,
    int_displayorder integer DEFAULT 1 NOT NULL,
    chr_access character(1) DEFAULT 'P'::bpchar,
    chr_previewstatus character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar,
    chr_delete character(1) DEFAULT 'N'::bpchar,
    fk_preview integer DEFAULT 0 NOT NULL,
    dt_createdate date,
    dt_modifydate date,
    var_viewalias character varying(255),
    chr_displaycontent character(1) DEFAULT 'Y'::bpchar,
    chr_displaybanner character(1) DEFAULT 'N'::bpchar,
    var_bannerimage character varying(200) DEFAULT NULL::character varying,
    chr_validimage character(1) DEFAULT NULL::bpchar,
    chr_crop character(1) DEFAULT NULL::bpchar,
    var_ipaddress character varying(100) NOT NULL,
    var_adminuser character varying(100) NOT NULL,
    chr_fixmodule character varying(1) DEFAULT 'N'::character varying,
    chr_menu_display character varying(1) DEFAULT 'Y'::character varying NOT NULL,
    chr_image_display character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_footer_display character varying(1) DEFAULT 'N'::character varying NOT NULL,
    chr_mainparent character(1) DEFAULT 'N'::bpchar NOT NULL,
    fk_pages integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.pages OWNER TO thriftskool_mobileappuser;

--
-- Name: pages_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE pages_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: pages_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE pages_int_glcode_seq OWNED BY pages.int_glcode;


--
-- Name: post_category; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE post_category (
    int_glcode integer NOT NULL,
    var_categoryname character varying(255) NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255) NOT NULL,
    var_ipaddress character varying(255) NOT NULL,
    fk_user_id integer,
    dt_expiredate date,
    fk_university integer,
    var_image character varying(100),
    var_backimage character varying(150),
    int_displayorder integer
);


ALTER TABLE public.post_category OWNER TO thriftskool_mobileappuser;

--
-- Name: post_category_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE post_category_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_category_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: post_category_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE post_category_int_glcode_seq OWNED BY post_category.int_glcode;


--
-- Name: post_gallery; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE post_gallery (
    int_glcode integer NOT NULL,
    var_title character varying(255),
    var_image character varying(100),
    fk_post integer,
    fk_user_id integer,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL
);


ALTER TABLE public.post_gallery OWNER TO thriftskool_mobileappuser;

--
-- Name: post_gallery_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE post_gallery_int_glcode_seq
    START WITH 531
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_gallery_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: post_gallery_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE post_gallery_int_glcode_seq OWNED BY post_gallery.int_glcode;


--
-- Name: post_management; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE post_management (
    int_glcode integer NOT NULL,
    var_postname character varying(255) NOT NULL,
    fk_post_cate integer,
    var_description text,
    var_price character varying(255),
    dt_expiredate date,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_adminuser character varying(255),
    var_ipaddress character varying(255),
    fk_user_id integer,
    fk_university integer,
    chr_status character(1) DEFAULT 0 NOT NULL,
    chr_favorite character(1) DEFAULT 0 NOT NULL,
    int_count integer DEFAULT 0 NOT NULL,
    chr_block character(1) DEFAULT 0 NOT NULL
);


ALTER TABLE public.post_management OWNER TO thriftskool_mobileappuser;

--
-- Name: post_management_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE post_management_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_management_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: post_management_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE post_management_int_glcode_seq OWNED BY post_management.int_glcode;


--
-- Name: tbl_class; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE tbl_class (
    int_glcode integer NOT NULL,
    class_name character varying(100) NOT NULL
);


ALTER TABLE public.tbl_class OWNER TO thriftskool_mobileappuser;

--
-- Name: tbl_class_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE tbl_class_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_class_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: university_leads; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE university_leads (
    int_glcode integer NOT NULL,
    var_name character varying(255) NOT NULL,
    var_email character varying(255) NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    fk_user_id integer,
    var_username character varying(150)
);


ALTER TABLE public.university_leads OWNER TO thriftskool_mobileappuser;

--
-- Name: university_leads_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE university_leads_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.university_leads_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: university_leads_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE university_leads_int_glcode_seq OWNED BY university_leads.int_glcode;


--
-- Name: university_management; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE university_management (
    int_glcode integer NOT NULL,
    var_name character varying(100) NOT NULL,
    var_domain character varying(100),
    var_image character varying(100),
    dt_modifydate timestamp without time zone NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_ipaddress character varying(100) NOT NULL,
    var_adminuser character varying(100) NOT NULL,
    dt_createdate timestamp without time zone,
    fk_user_id integer
);


ALTER TABLE public.university_management OWNER TO thriftskool_mobileappuser;

--
-- Name: university_management_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE university_management_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.university_management_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: university_management_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE university_management_int_glcode_seq OWNED BY university_management.int_glcode;


--
-- Name: user_devices; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE user_devices (
    int_glcode integer NOT NULL,
    fk_user integer,
    device_id text,
    gcm_code text,
    dt_createdate timestamp without time zone NOT NULL
);


ALTER TABLE public.user_devices OWNER TO thriftskool_mobileappuser;

--
-- Name: user_devices_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE user_devices_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_devices_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: user_devices_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE user_devices_int_glcode_seq OWNED BY user_devices.int_glcode;


--
-- Name: useraccess; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE useraccess (
    int_glcode integer NOT NULL,
    fk_groups integer NOT NULL,
    fk_module_useraction integer NOT NULL,
    chr_assign character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    dt_modifydate date NOT NULL
);


ALTER TABLE public.useraccess OWNER TO thriftskool_mobileappuser;

--
-- Name: useraccess_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE useraccess_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.useraccess_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: useraccess_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE useraccess_int_glcode_seq OWNED BY useraccess.int_glcode;


--
-- Name: useraction; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE useraction (
    int_glcode integer NOT NULL,
    var_action character varying(200) NOT NULL,
    chr_delete character(1) DEFAULT 'N'::bpchar NOT NULL,
    dt_modifydate date NOT NULL
);


ALTER TABLE public.useraction OWNER TO thriftskool_mobileappuser;

--
-- Name: useraction_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE useraction_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.useraction_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: useraction_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE useraction_int_glcode_seq OWNED BY useraction.int_glcode;


--
-- Name: users; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE users (
    int_glcode integer NOT NULL,
    var_emailid character varying(100),
    var_password character varying(100) NOT NULL,
    var_conf_password character varying(100),
    var_fullname character varying(255) NOT NULL,
    chr_delete character varying(1) DEFAULT 'N'::character varying NOT NULL,
    dt_createdate date NOT NULL,
    dt_modifydate date NOT NULL,
    dt_deletedate date NOT NULL,
    chr_block character(1) DEFAULT 'N'::bpchar NOT NULL,
    var_adminuser character varying(100),
    var_ipaddress character varying(100),
    chr_usertype character(1) DEFAULT 'U'::bpchar NOT NULL,
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    var_emailid1 character varying(100)
);


ALTER TABLE public.users OWNER TO thriftskool_mobileappuser;

--
-- Name: users_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE users_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: users_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE users_int_glcode_seq OWNED BY users.int_glcode;


--
-- Name: users_manage; Type: TABLE; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

CREATE TABLE users_manage (
    int_glcode integer NOT NULL,
    fk_university integer NOT NULL,
    var_emailid character varying(100),
    var_password character varying(100) NOT NULL,
    var_conf_password character varying(100),
    chr_delete character varying(1) DEFAULT 'N'::character varying NOT NULL,
    dt_createdate timestamp without time zone NOT NULL,
    dt_modifydate timestamp without time zone NOT NULL,
    var_adminuser character varying(100),
    var_ipaddress character varying(100),
    chr_publish character(1) DEFAULT 'Y'::bpchar NOT NULL,
    chr_spam character(1) DEFAULT 'N'::bpchar NOT NULL,
    chr_buzz character(1) DEFAULT 'N'::bpchar NOT NULL,
    fk_user_id integer,
    chr_verify character(1) DEFAULT 'N'::bpchar NOT NULL,
    device_id text,
    var_username character varying(100),
    gcm_code character varying(1000),
    person_name character varying(255),
    profile_img character varying(255),
    class character(1)
);


ALTER TABLE public.users_manage OWNER TO thriftskool_mobileappuser;

--
-- Name: users_manage_int_glcode_seq; Type: SEQUENCE; Schema: public; Owner: thriftskool_mobileappuser
--

CREATE SEQUENCE users_manage_int_glcode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_manage_int_glcode_seq OWNER TO thriftskool_mobileappuser;

--
-- Name: users_manage_int_glcode_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER SEQUENCE users_manage_int_glcode_seq OWNED BY users_manage.int_glcode;


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY campus_buzz ALTER COLUMN int_glcode SET DEFAULT nextval('campus_buzz_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY campus_buzz_gallery ALTER COLUMN int_glcode SET DEFAULT nextval('campus_buzz_gallery_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY campus_deal ALTER COLUMN int_glcode SET DEFAULT nextval('campus_deal_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY campus_gallery ALTER COLUMN int_glcode SET DEFAULT nextval('campus_gallery_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY category ALTER COLUMN int_glcode SET DEFAULT nextval('category_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY contactusleads ALTER COLUMN int_glcode SET DEFAULT nextval('contactusleads_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY favorite ALTER COLUMN int_glcode SET DEFAULT nextval('favorite_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY general_settings ALTER COLUMN int_glcode SET DEFAULT nextval('general_settings_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY job_management ALTER COLUMN int_glcode SET DEFAULT nextval('job_management_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY logmanager ALTER COLUMN int_glcode SET DEFAULT nextval('logmanager_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY manage_gcmcode ALTER COLUMN int_glcode SET DEFAULT nextval('manage_gcmcode_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY message_list ALTER COLUMN int_glcode SET DEFAULT nextval('message_list_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY message_thread ALTER COLUMN int_glcode SET DEFAULT nextval('message_thread_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY module_useraction ALTER COLUMN int_glcode SET DEFAULT nextval('module_useraction_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY modules ALTER COLUMN int_glcode SET DEFAULT nextval('modules_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY pages ALTER COLUMN int_glcode SET DEFAULT nextval('pages_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY post_category ALTER COLUMN int_glcode SET DEFAULT nextval('post_category_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY post_gallery ALTER COLUMN int_glcode SET DEFAULT nextval('post_gallery_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY post_management ALTER COLUMN int_glcode SET DEFAULT nextval('post_management_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY university_leads ALTER COLUMN int_glcode SET DEFAULT nextval('university_leads_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY university_management ALTER COLUMN int_glcode SET DEFAULT nextval('university_management_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY user_devices ALTER COLUMN int_glcode SET DEFAULT nextval('user_devices_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY useraccess ALTER COLUMN int_glcode SET DEFAULT nextval('useraccess_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY useraction ALTER COLUMN int_glcode SET DEFAULT nextval('useraction_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY users ALTER COLUMN int_glcode SET DEFAULT nextval('users_int_glcode_seq'::regclass);


--
-- Name: int_glcode; Type: DEFAULT; Schema: public; Owner: thriftskool_mobileappuser
--

ALTER TABLE ONLY users_manage ALTER COLUMN int_glcode SET DEFAULT nextval('users_manage_int_glcode_seq'::regclass);


--
-- Data for Name: campus_buzz; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY campus_buzz (int_glcode, var_title, var_description, fk_university, dt_expiredate, dt_createdate, dt_modifydate, chr_delete, chr_publish, var_adminuser, var_ipaddress, fk_user_id, int_count, chr_status, chr_block) FROM stdin;
118	Party!	2408 Jerry jones \nBe there!\n	14	2015-12-05	2015-12-04 19:25:25	2015-12-04 19:25:25	N	Y	\N	\N	86	0	1	0
119	ThriftSkool	What a time to be alive! This is a brand new app, so no one has posted anything to sell yet. Be the first to post something and let's get the app going around campus ! 	30	2015-12-31	2015-12-05 14:27:22	2015-12-05 00:00:00	N	Y	\N	\N	68	0	1	0
133	buzz by naomi	create buzz	16	2016-01-13	2016-01-13 05:59:34	2016-01-13 05:59:34	N	Y	\N	\N	6	0	1	0
1	Lauren's Blankets	Hey! Please come help support Freshman Forum in downtown Athens tonight. We are trying to raise money to make quality blankets for the homeless and we need your help! Multiple members of the executive staff will be on the corners accepting donations and we'd love to have yours. So, come downtown tonight and support the cause. 	15	2016-02-02	2016-02-04 01:35:23	2016-02-03 20:46:52	N	Y	\N	\N	207	0	0	0
6	test by etilox	cvnsfgndgtngdfh	16	2016-03-04	2016-02-04 04:50:51	2016-02-04 10:26:40	N	Y	\N	\N	183	0	1	0
3	Ambassadors!	Shsh	15	2016-03-03	2016-02-04 01:57:10	2016-02-04 01:57:10	Y	Y	\N	\N	194	0	0	0
7	test by vaibhav	fsafds	26	2016-02-25	2016-02-04 05:27:37	2016-02-04 00:00:00	Y	Y	Administrator	122.169.68.155	0	0	0	0
2	Lauren's Blankets	Hey! Please come help support Freshman Forum in downtown Athens tonight. We are trying to raise money to make quality blankets for the homeless and we need your help! Multiple members of the executive staff will be on the corners accepting donations and we'd love to have yours. So, come downtown tonight and support the cause. 	15	2016-02-04	2016-02-04 01:37:01	2016-02-03 20:48:33	N	Y	\N	\N	207	0	1	0
131	thrid buzz	create buzz	16	2016-01-12	2016-01-06 05:06:04	2016-01-06 05:06:04	Y	Y	\N	\N	180	0	1	0
130	second buzz	create second buzz	16	2016-01-11	2016-01-06 05:05:02	2016-01-06 05:05:02	Y	Y	\N	\N	180	0	1	0
129	First buzz	create buzz	16	2016-01-11	2016-01-06 05:02:18	2016-01-06 05:02:18	Y	Y	\N	\N	180	0	1	0
8	Hzbsb	Bdhdbs	15	2016-03-04	2016-02-04 13:18:39	2016-02-04 13:18:39	Y	Y	\N	\N	194	0	0	0
10	GymDogs	GymDogs meet Feb 5th at 7!	15	2016-02-05	2016-02-05 04:19:48	2016-02-04 23:20:40	N	Y	\N	\N	30	0	1	0
9	Georgia Basketball Game	Basketball game against Auburn! Feb 6th at 5:30pm!	15	2016-02-06	2016-02-05 00:56:46	2016-02-05 00:56:46	N	Y	\N	\N	30	0	1	0
139	Winter Activities Fair 	10:00 am - 3:00 pm\nTate Student Center\nSponsored by: Center for Student Organizations\nContact: Emily Ancinec 706-583-5509\nThis event is for those looking to find new involvement opportunities with almost 220 student organizations. To include donuts and hot chocolate.\n\nOnly registered student organizations can participate in the fair. Sign-ups will begin one month prior to the event. 	15	2016-02-03	2016-01-30 15:51:17	2016-01-30 15:51:17	Y	Y	\N	\N	9	0	0	0
138	Spring Career Fair	12:00 pm - 5:00 pm\n\nClassic Center\n300 N. Thomas St.\n\nSponsored by: Career Center\nContact: 706-542-3375\nStudents can meet with recruiters seeking students to fill both internship and full-time opportunities. Over 220 employers will attend. Students should dress professionally and bring copies of their resume.\n\nShuttles will run from campus to the Classic Center between 11:30 a.m. and 5 p.m. Bus stops for students include: Memorial Hall, Bio-Chem, Physics, across from the Library, Classic Center	15	2016-02-03	2016-01-30 15:46:26	2016-01-30 15:46:26	Y	Y	\N	\N	9	0	0	0
136	Men’s Basketball vs. South Carolina 	Stegemen Coliseum\n7 PM. Be there.	15	2016-02-02	2016-01-30 15:37:10	2016-01-30 15:37:10	Y	Y	\N	\N	9	0	0	0
135	Phi Kappa Literary Society Debate!	\n7:00 pm\nPhi Kappa Hall\nUpper Chamber\n\nAs UGA's house of controversy, the Phi Kappa Literary Society is a 195-year old debate society, dedicated to improving the skills of members in debate, oration and creative writing.\n\n 	15	2016-01-14	2016-01-14 22:54:08	2016-01-14 22:54:08	Y	Y	\N	\N	9	0	1	0
134	Workshop: Teaching Portfolio Development	11:00 am - 1:00 pm\nInstructional Plaza\nCenter for Teaching and Learning\n\nSponsored by: Center for Teaching and Learning (CTL)\nContact: Erin Horan 706-542-6603\nThis workshop focuses on fulfilling the specific components of the Graduate School’s template of a teaching portfolio but also discusses the purpose and role of teaching portfolios to improve teaching and to enhance credentials both on the job market and as participants build their dossier for tenure and promotion.	15	2016-01-15	2016-01-14 22:48:12	2016-01-14 22:48:12	Y	Y	\N	\N	9	0	0	0
128	Swimming and Diving vs. Tennessee 	Sat, January 23 @ Ramsey \nStarts at 12 PM!	15	2016-01-23	2016-01-06 02:16:22	2016-01-06 02:16:22	Y	Y	\N	\N	9	0	1	0
127	Gymnastics vs. Stanford	Come cheer on the Gymdogs against Stanford on Monday, January the 18th \nStarts at 2PM!	15	2016-01-18	2016-01-06 02:13:39	2016-01-06 02:13:39	Y	Y	\N	\N	9	0	1	0
126	Men's Basketball vs. Texas A&M	Sat, January 16th at 2 PM! \n\nHome game! See you all there!	15	2016-01-16	2016-01-06 02:11:10	2016-01-06 02:11:10	Y	Y	\N	\N	9	0	1	0
125	Men's Tennis at MLK Invitational	Saturday, January 16th \nAtlanta, GA	15	2016-01-15	2016-01-06 02:09:40	2016-01-06 02:09:40	Y	Y	\N	\N	9	0	0	0
124	Men's Basketball vs. Tennessee	Wednesday, January 13, 2016 @ 7 PM!	15	2016-01-13	2016-01-06 02:07:30	2016-01-06 02:07:30	Y	Y	\N	\N	9	0	1	0
123	Women's Basketball vs. Kentucky	Sunday, January 10 @ 2 PM\nStegeman Coliseum	15	2016-01-10	2016-01-06 02:05:48	2016-01-06 02:05:48	Y	Y	\N	\N	9	0	1	0
122	Spotlight Tour: Highlights from the Permanent Collection	January 10, 2016\n3:00 PM\nGeorgia Museum of Art\n	15	2016-01-10	2016-01-06 02:02:31	2016-01-06 02:02:31	Y	Y	\N	\N	9	0	1	0
121	Exhibition: State Botanical Garden Art Competition Winners 	January 10, 2016 - February 14, 2016\nState Botanical Garden of UGA\n\nThis is the first formal exhibit of art competition winners from throughout the years.	15	2016-02-04	2016-01-06 01:57:49	2016-01-06 01:57:49	Y	Y	\N	\N	9	0	1	0
120	Tour at Two: Highlights from the Permanent Collection	Sponsored by: Georgia Museum of Art\nContact: Hillary Brown 706-542-4662\n\nEvent starts at 2 PM\n	15	2016-01-06	2016-01-06 01:32:50	2016-01-05 00:00:00	Y	Y	\N	\N	9	0	1	0
156	Jj	Jj	15	2016-03-11	2016-02-11 12:04:52	2016-02-11 12:04:52	Y	Y	\N	\N	194	0	0	0
155	Bb	Bb	15	2016-03-12	2016-02-11 12:00:22	2016-02-11 12:00:22	Y	Y	\N	\N	194	0	0	0
159	Jj	Mm	15	2016-03-12	2016-02-11 14:08:31	2016-02-11 14:08:31	Y	Y	\N	\N	194	0	3	0
17	test	fgjf,hg,dhg,g	16	2016-03-10	2016-02-10 14:34:33	2016-02-10 14:34:33	Y	Y	\N	\N	180	0	1	0
161	Chocolate Fountain	The O-House Dining Hall is having a chocolate fountain from 2:00 p.m. to 4:00 p.m. today! Pineapples, strawberries, pretzels, marshmallows, and more will be included! 	15	2016-02-12	2016-02-12 15:58:49	2016-02-12 15:58:49	N	Y	\N	\N	207	0	1	0
160	Basketball game vs Florida 	Come watch the dawgs whoop up on some gator tail 	15	2016-02-16	2016-02-11 18:21:08	2016-02-11 18:21:08	N	Y	\N	\N	66	0	1	0
163	Blood Drive Monday at Tate	Come to Tate at 12 on Monday to give back and give in the Blood Drive	15	2016-02-15	2016-02-14 01:18:42	2016-02-14 01:18:42	Y	Y	\N	\N	194	0	1	0
162	Baseball season opener 5pm	First game of the year friday at 5! Come support your Diamond Dawgs	15	2016-02-19	2016-02-14 01:16:02	2016-02-14 01:16:02	Y	Y	\N	\N	194	0	1	0
165	Red X #TheEndItMovement	There was human sex trafficing happening in Athens, Georgia in 2011 and it's still occurring in the world today.  Please be sure to mark a red x on your hand in order to raise awareness of human sex trafficing 	15	2016-02-25	2016-02-16 01:11:38	2016-02-16 01:11:38	N	Y	\N	\N	207	0	1	0
167	Gymdogs vs Oklahoma 	Saturday February 20th at 4pm!	15	2016-02-20	2016-02-16 13:33:11	2016-02-16 13:33:11	N	Y	\N	\N	30	0	1	0
166	Miracles Dance Marathon	This weekend, join Miracle and all who is involved and raise money for the kids! February 20-21! Register online at events.dancemarathon.com	15	2016-02-21	2016-02-16 13:29:35	2016-02-16 13:29:35	N	Y	\N	\N	30	0	1	0
164	student night at the museum	Thursday from 630-830 The Student Association of the Georgia Museum of Art will host a night of music, food, fun and themed activities to celebrate the latest exhibitions. Student Night is generously sponsored by the UGA Parents and Families Association.	15	2016-02-18	2016-02-14 01:20:46	2016-02-14 01:20:46	Y	Y	\N	\N	194	0	1	0
154	Four buzz	Gc	16	2016-03-11	2016-02-11 10:33:05	2016-02-11 10:33:05	Y	Y	\N	\N	180	0	1	0
151	Test by etilox	Test	16	2016-03-10	2016-02-11 07:14:45	2016-02-11 07:14:45	N	Y	\N	\N	182	0	1	0
152	Buzz create	Jjzn	16	2016-03-12	2016-02-11 10:30:09	2016-02-11 10:30:09	Y	Y	\N	\N	180	0	1	0
158	Healthy Cooking at The UGA health center!	$5 a person!\nRegister at www.uhs.uga.edu/nutrition/kitchen.html	15	2016-03-11	2016-02-11 13:33:53	2016-02-11 13:33:53	N	Y	\N	\N	30	0	1	0
157	Ted Talk at UGA	Ted Talk Friday, March 18th at 1-5pm \nRegister at TedxUGA.com/register 	15	2016-03-12	2016-02-11 13:24:43	2016-02-11 13:24:43	N	Y	\N	\N	30	0	1	0
153	Graft	Txt	16	2016-02-11	2016-02-11 10:31:32	2016-02-11 10:31:32	Y	Y	\N	\N	180	0	1	0
172	Nsjsj	Bjsksj	15	2016-02-24	2016-02-22 18:41:48	2016-02-22 18:41:48	Y	Y	\N	\N	194	0	0	0
176	Wallet	Djdgshshs	15	2016-03-25	2016-02-24 12:45:07	2016-02-24 12:45:07	Y	Y	\N	\N	194	0	0	0
171	UGA baseball- Bulldog invitational 	Vs South Alabama 2/26\nVs Cincinnati 2/27\nVs Western Kentucky 2/28\n	15	2016-02-28	2016-02-22 17:49:10	2016-02-22 13:45:22	N	Y	\N	\N	66	0	1	0
178	Bulldawg Brawl	Charity boxing event bulldawg brawl!	15	2016-02-27	2016-02-25 11:57:48	2016-02-25 11:57:48	Y	Y	\N	\N	194	0	1	0
175	buzz	test	16	2016-02-24	2016-02-24 06:41:16	2016-02-24 06:41:16	Y	Y	\N	\N	180	0	1	0
174	Testing buzz	Dghjjjvxd	16	2016-02-27	2016-02-24 06:14:07	2016-02-24 06:14:07	Y	Y	\N	\N	180	0	1	0
177	Ramsey Palooza	9:00 pm - 11:00 pm\nRamsey Student Center for Physical Activities\nSponsored by: Recreational Sports, Department of\nContact: Christina Reynolds 706-542-5060\nTo include free food, bubble soccer, throwback video games, fitness class previews and more.\n\n	15	2016-02-25	2016-02-24 14:17:03	2016-02-24 14:17:03	Y	Y	\N	\N	9	0	1	0
170	UGA Miracle Dance Marathon!	Starts on Saturday morning!\n10:00 am - 10:00 am\nTate Student Center\nGrand Hall\n\nTo benefit Children’s Healthcare of Atlanta. This is a 24-hour event that will start Feb. 20 at 10 a.m. and end Feb. 21 at 10 a.m.	15	2016-02-21	2016-02-19 15:35:22	2016-02-19 15:35:22	Y	Y	\N	\N	9	0	1	0
168	GOP Greek night!	Tuesday Feb 16\n\nCome out to Cabin Room for GOP Greek night! There will be a tab!	15	2016-02-16	2016-02-16 16:25:51	2016-02-16 16:25:51	Y	Y	\N	\N	9	0	1	0
16	Gym dogs vs LSU	Come out and see the Gym Dogs on Saturday at 4PM! \n\nFirst 1,000 get a Free Leah Brown Bobblehead!	15	2016-02-13	2016-02-09 01:44:20	2016-02-09 01:44:20	Y	Y	\N	\N	9	0	1	0
15	Equestrian vs Auburn	Come out on Saturday to cheer on the girls vs Auburn! \nFirst 150 fans receive a Free UGA Equestrian T-shirt!\n\nBishop Equestrian Complex	15	2016-02-13	2016-02-09 01:41:22	2016-02-09 01:41:22	Y	Y	\N	\N	9	0	1	0
14	Softball vs. Winthrop & Elon	Double hitter on Saturday at 12:30 & 3 PM!	15	2016-02-13	2016-02-09 01:36:33	2016-02-09 01:36:33	Y	Y	\N	\N	9	0	1	0
12	Concert: Atlanta Symphony Orchestra	2:00 pm\nPerforming Arts Center\nHugh Hodgson Concert Hall\n\n$25-$65\n\nSponsored by: Performing Arts Center\nContact: Performing Arts Center 706-542-4400\nWhen David Coucheron joined the Atlanta Symphony Orchestra as Concertmaster in 2010, he was just celebrating his 25th birthday and was the youngest concertmaster of any major American symphony orchestra. Coucheron takes the spotlight in this performance as soloist in the "Violin Concerto of Johannes Brahms."\n\nThe program also includes a new ASO-commissioned work by composer Michael Kurth, who is also a member of the ASO double bass section. The concert concludes with a concert favorite, the musical story of the 14th-century trickster whose practical jokes get out of hand and lead to a trip to the gallows, "Til Eulenspiegel’s Merry Pranks" by Richard Strauss.	15	2016-02-07	2016-02-07 16:01:10	2016-02-07 16:01:10	Y	Y	\N	\N	9	0	1	0
11	Women's basketball game vs. Ole Miss	Today at 2 PM! 	15	2016-02-07	2016-02-07 15:56:36	2016-02-07 15:56:36	Y	Y	\N	\N	9	0	1	0
183	International coffee hour	This event is for those who enjoy good food, coffee, conversations with people who like exploring and learning new cultures.	15	2016-03-18	2016-03-14 12:48:51	2016-03-14 12:48:51	Y	Y	\N	\N	194	0	1	0
184	Baseball vs Kentucky	First pitch 6pm friday! 	15	2016-03-18	2016-03-14 12:49:37	2016-03-14 12:49:37	Y	Y	\N	\N	194	0	1	0
179	Baseball game @ 5	Home game Tues at 5!	15	2016-03-01	2016-03-01 16:05:42	2016-03-01 16:05:42	Y	Y	\N	\N	194	0	1	0
181	UGA Symphony Orchestra 	Hodgson concert hall 8PM	15	2016-03-03	2016-03-01 16:09:08	2016-03-01 16:09:08	Y	Y	\N	\N	194	0	1	0
180	Summer Camp Job Fair	Explore emplyment options at summer camps across the Southeast.  Event is at Ramsey student center 5:30pm	15	2016-03-01	2016-03-01 16:07:41	2016-03-01 16:07:41	Y	Y	\N	\N	194	0	1	0
196	G-day game	4-7pm in Sanford stadium come watch the future! Free admission 	15	2016-04-17	2016-03-22 01:21:42	2016-03-22 01:21:42	Y	Y	\N	\N	194	0	0	0
190	testing buzz	for testing	16	2016-03-16	2016-03-15 12:49:57	2016-03-15 12:49:57	Y	Y	\N	\N	180	0	0	0
182	UGA softball game vs KSU	Come to the game weds @ 6!	15	2016-03-16	2016-03-14 12:46:46	2016-03-14 12:46:46	Y	Y	\N	\N	194	0	1	0
187	Summer job fair	Summer jobs will be available from a selection of employers in Atlanta, Athens and surrounding areas. UGA depts will also be hiring. Business casual attire recommended. 11am at Tate 	15	2016-03-23	2016-03-14 15:29:07	2016-03-14 15:29:07	Y	Y	\N	\N	194	0	1	0
186	Sigma Sigma Rho’s Heel The Soul Walk	Sigma Sigma Rho Sorority Inc. will host its fourth annual Heel the Soul Walk. This is a community service event that helps raise money for domestic violence centers such as Project Safe and Peace Place.	15	2016-03-19	2016-03-14 12:59:11	2016-03-14 12:59:11	Y	Y	\N	\N	194	0	1	0
185	Fun run towards sustainability	The Small Dreams Foundation focuses on honoring the life of Brittney Fox Watts by inspiring individuals and communities to improve global and environmental awareness. The fourth annual Fun Run Toward Sustainability is a celebration of sustainable actions toward a healthy community and supports both the UGA Office of Sustainability and the State Botanical Garden of Georgia.	15	2016-03-19	2016-03-14 12:56:56	2016-03-14 12:56:56	Y	Y	\N	\N	194	0	1	0
197	UGA tennis match 	Come watch the dawgs take on Tennessee	15	2016-03-25	2016-03-25 16:45:20	2016-03-25 16:45:20	N	Y	\N	\N	66	0	1	0
201	StartUp! Panel	Come listen to several Terry Alumni talk about their Start ups. Thursday, March 31st at 5:30 pm in Correll Hall 218	15	2016-03-31	2016-03-31 15:41:26	2016-03-31 15:41:26	N	Y	Administrator	50.241.13.170	0	0	1	0
199	Baseball vs Alabama 	7PM at Foley Field	15	2016-03-31	2016-03-28 14:11:18	2016-03-28 14:11:18	Y	Y	\N	\N	9	0	1	0
191	UGA night @ Six Flags!	Free t shirt to the first 400 students to buy a ticket. Purchase tix at tate student center cashier window. April 15 6pm-midnight	15	2016-04-15	2016-03-19 18:14:29	2016-03-19 18:14:29	Y	Y	\N	\N	194	0	1	0
206	Test buzz	Fghfgjh	15	2019-04-04	2016-04-04 08:58:26	2016-04-05 00:00:00	Y	Y	Administrator	50.20.4.10	181	0	0	0
203	 Women’s Tennis vs. Arkansas	Come out today to support the Dawgs!	15	2016-03-31	2016-03-31 15:59:03	2016-03-31 15:59:03	Y	Y	\N	\N	9	0	1	0
192	UGA football tryouts	Think you can make the squad?! Pick up a registration packet from Kim Mcdaniel in the football office or at kmcdaniel@uga.edu must be registered by april 4th! 	15	2016-04-12	2016-03-19 18:16:19	2016-03-19 18:16:19	Y	Y	\N	\N	194	0	1	0
189	UGA's Next Top Entrepreneur	The top teams will compete in front of a live audience and panel of judges for a winner takes all cash prize of $10,000. Hotel Indigo 6-9pm	15	2016-03-30	2016-03-14 17:16:37	2016-03-14 17:16:37	Y	Y	\N	\N	194	0	1	0
195	Sicario playing in Tate Theatre	Sicario playing in Tate Fri/Sat/Sun	15	2016-03-28	2016-03-19 18:20:43	2016-03-19 18:20:43	Y	Y	\N	\N	194	0	1	0
194	Late Night Paint & Pour	Come join the free fun! 9pm at Tate Grand Hall	15	2016-03-31	2016-03-19 18:19:07	2016-03-19 18:19:07	Y	Y	\N	\N	194	0	1	0
193	Fun Run and Field Day 	930-1pm at trail creek park! Check flyer for details	15	2016-04-09	2016-03-19 18:17:44	2016-03-19 18:17:44	Y	Y	\N	\N	194	0	1	0
188	Swing dance night in the garden	Dancing and music 8pm @ state botanical garden of Ga	15	2016-03-29	2016-03-14 17:10:39	2016-03-14 17:10:39	Y	Y	\N	\N	194	0	1	0
208	 Men’s Tennis vs. Florida 	Come out and watch our boys whoop up on the gators!	15	2016-04-08	2016-04-05 22:42:30	2016-04-05 22:42:30	Y	Y	\N	\N	9	0	1	0
205	Yet	Hhhh	15	2016-04-04	2016-04-02 13:20:22	2016-04-02 13:20:22	Y	Y	\N	\N	181	0	1	0
200	G-Day Game!! 	Kickoff at 4, FREE general admission! 	15	2016-04-16	2016-03-29 11:56:02	2016-03-29 11:56:02	Y	Y	\N	\N	194	0	1	0
202	Great Southland Stampede Rodeo March 31-April 2!	Through April 2. Doors open at 6 p.m.; show starts at 8 p.m. Hosted by UGA Block and Bridle. Rodeo contests are divided into two categories: rough stock events that are scored by a judge (bareback bronc riding, saddle bronc riding and bull riding) and those that are timed for speed (barrel racing, steer wrestling, calf roping and team roping). 	15	2016-04-02	2016-03-31 15:55:19	2016-03-31 15:55:19	Y	Y	\N	\N	9	0	1	0
198	Baseball game vs Kennesaw State	6 PM at Foley Field	15	2016-03-29	2016-03-28 14:10:01	2016-03-28 14:10:01	Y	Y	\N	\N	9	0	1	0
207	 UGA vs. Auburn Blood Battle Blood Drive	11:00 am - 5:00 pm\nMemorial Hall\n Co-sponsored by the UGA Red Cross Club, UGA Greek Life, UGA PrePA Club, UGA Miracle, UGA HEROs and UGA Relay For Life.\n\n\n	15	2016-04-05	2016-04-05 22:35:29	2016-04-05 22:35:29	Y	Y	\N	\N	9	0	1	0
222	International Agriculture Day	Tuesday April 19th 3:30- 5:30PM\nGeorgia Museum of Art	15	2016-04-19	2016-04-12 00:16:15	2016-04-12 00:16:15	Y	Y	\N	\N	9	0	1	0
230	Softball vs Ole Miss	6:00 pm\nJack Turner Stadium\nSponsored by: Athletic Association\nContact: 706-542-1621	15	2016-04-29	2016-04-28 11:12:54	2016-04-28 11:12:54	Y	Y	\N	\N	9	0	1	0
212	Georgia vs. Auburn blood drive!	Monday thru Wednesday\n11-5 PM\nMemorial Hall!	15	2016-04-13	2016-04-11 02:33:34	2016-04-11 02:33:34	Y	Y	\N	\N	9	0	1	0
210	Tags	Dig	15	2016-04-08	2016-04-08 10:35:03	2016-04-08 10:35:03	Y	Y	\N	\N	181	0	1	0
132	Buzz by john1	Buzz	16	2016-01-14	2016-01-07 04:43:21	2016-01-07 04:43:21	Y	Y	\N	\N	181	0	1	0
224	Testbuzz	Jhvkf	16	2018-04-16	2016-04-16 11:56:37	2016-04-16 11:56:37	N	Y	\N	\N	182	0	0	0
220	Relay for Life!	This Friday. Be there.\n7pm Friday night to 7am Saturday morning.\nintramural fields.	15	2016-04-15	2016-04-11 22:17:49	2016-04-14 08:08:49	Y	Y	\N	\N	9	0	1	0
213	Free The Girls!!!	Free The Girls is a bra drive that goes towards women who has been in sex trafficking. Donate a bra at American threads THIS WEEK!!!	15	2016-04-18	2016-04-11 14:05:41	2016-04-11 14:05:41	N	Y	\N	\N	30	0	1	0
238	Full moon hike	8pm at the botanical garden	15	2016-05-21	2016-05-17 17:03:23	2016-05-17 17:03:23	Y	Y	\N	\N	194	0	1	0
225	Full moon hike	8pm at the fountain at the botanical garden	15	2016-04-22	2016-04-20 14:26:02	2016-04-20 14:26:02	Y	Y	\N	\N	194	0	1	0
217	Baseball vs South Carolina 	First pitch 7PM 	15	2016-04-15	2016-04-11 16:40:40	2016-04-11 16:40:40	Y	Y	\N	\N	194	0	1	0
215	Advice from the Big Dawgs	Students can meet with prominent alumni and gain valuable networking tips and advice about life after UGA. \nTate student center Grand hall 6PM	15	2016-04-14	2016-04-11 16:35:50	2016-04-11 16:35:50	Y	Y	\N	\N	194	0	1	0
216	Morning Mindfulness	A guided mindfulness meditation practice in spaces throughout the museum.  Register by calling 706-542-0448 or email branew@uga.edu\n9:30am Georgia museum of art	15	2016-04-15	2016-04-11 16:39:45	2016-04-11 16:39:45	Y	Y	\N	\N	194	0	1	0
218	38th annual 5K Human Race	This race/run benefits local outreach ministries at the UGA catholic center\n\n8AM UGA Catholic Center	15	2016-04-16	2016-04-11 16:43:48	2016-04-11 16:43:48	Y	Y	\N	\N	194	0	1	0
214	"Olympic Trials" (Spring Total Reveal/Rave)	"Olympic Trials" (Spring Total Reveal/Rave)\nFriday, April 29 8:30-11pm\nHerty Field 	15	2016-04-29	2016-04-11 16:00:41	2016-04-11 16:00:41	Y	Y	\N	\N	194	0	1	0
223	Become a ThriftSkool Campus Ambassador!	Come join the ThriftSkool team! As we continue to grow at UGA join us and get involved with a hot startup that's growing rapidly! \n\nFor more details go to your profile and send us a message in 'contact admin'\n\nTalk soon! \n\n	15	2016-05-14	2016-04-14 14:17:30	2016-04-14 14:17:30	Y	Y	\N	\N	194	0	1	0
221	Back to the 90's 5K	Stegeman coliseum 8am\nRegistration $10 	15	2016-04-23	2016-04-12 00:14:36	2016-04-12 00:14:36	Y	Y	\N	\N	194	0	1	0
211	International Street Festival! 	Come downtown to College Ave until 5 PM to see this awesome International Festival. 	15	2016-04-09	2016-04-09 17:19:31	2016-04-09 17:19:31	Y	Y	\N	\N	9	0	1	0
228	Phi Slam datenight! 	grab a date or a bunch of friends and sign up for the last phi slam datenight of the year! Monday, May 2nd	15	2016-05-02	2016-04-27 13:29:38	2016-04-27 13:29:38	N	Y	\N	\N	30	0	1	0
235	Thursday Twilight Tour	Ga museum of art 7pm	15	2016-05-12	2016-05-07 16:03:43	2016-05-07 16:03:43	Y	Y	\N	\N	194	0	1	0
226	Baseball vs Georgia tech 	First pitch 7pm!	15	2016-04-26	2016-04-20 14:27:26	2016-04-20 14:27:26	Y	Y	\N	\N	194	0	1	0
227	Alabama Shakes at the Classic Center	Get your tickets now before it's too late!	15	2016-04-27	2016-04-26 14:18:32	2016-04-26 14:18:32	Y	Y	\N	\N	9	0	1	0
233	Baseball vs Ole Miss	Game strts at 1! 	15	2016-05-08	2016-05-07 16:00:41	2016-05-07 16:00:41	Y	Y	\N	\N	194	0	1	0
219	Fetty Wap! 	Fetty wap live at the coliseum @ 8!	15	2016-04-26	2016-04-11 16:46:00	2016-04-11 16:46:00	Y	Y	\N	\N	194	0	1	0
229	Bulldog Brass Society	Brass Society\n8:00 pm - 9:30 pm\nHugh Hodgson School of Music\nEdge Recital Hall\n\nSponsored by: Hugh Hodgson School of Music\nContact: Clarke Schwabe 706-542-4752\nBrass Society, the UGA Hugh Hodgson School of Music’s premier brass quintet, will perform one of the School of Music’s last concerts of the spring. Founded in 1996 by famed trumpeter and School of Music professor Fred Mills, the Bulldog Brass Society performs repertoire ranging from Bach to 20th century works as well as more popular music including home grown arrangements by their members.	15	2016-04-28	2016-04-28 02:22:03	2016-04-28 02:22:03	Y	Y	\N	\N	9	0	1	0
237	Baseball vs Tennessee	first pitch at 2	15	2016-05-21	2016-05-17 17:01:57	2016-05-17 17:01:57	Y	Y	\N	\N	194	0	1	0
236	Become a ThriftSkool Campus Ambassador!	Message us in the "contact admin" portal in your profile and join the team at UGA today!	15	2016-08-30	2016-05-17 17:00:37	2016-07-31 18:36:23	N	Y	\N	\N	194	0	1	0
231	Baseball vs. Vandy	7:30 PM! Be there	15	2016-04-29	2016-04-28 11:15:29	2016-04-28 11:15:29	Y	Y	\N	\N	9	0	1	0
232	Ecoppella V Concert 	7:00 pm - 9:00 pm\n\nLive Wire Athens\n227 W. Dougherty St.\n\n$8; $5 for students\n\nContact: Molly Alexander 912-856-6904\nThe UGA Ecotones will hold its fifth annual benefit concert for the Upper Oconee Watershed Network. The Ecotones are a co-ed, eco-friendly a cappella group that performs a repertoire of pop songs, classic hits, indie tunes, rock n’ roll and soulful ballads.	15	2016-04-30	2016-04-28 11:22:10	2016-04-28 11:22:10	Y	Y	\N	\N	9	0	1	0
234	2016 senior sendoff! 	5 - 7 Herty Field\nVice President for Student Affairs Victor Wilson and Meredith Gurley Johnson, executive director of the UGA Alumni Association, will address the Class of 2016 and unveil the Senior Signature plaque.\n\nProfessional headshots will be offered during the event. This is an opportunity for students to update their LinkedIn profile photo as they begin applying for jobs.\n\nComplimentary appetizers and beverages will be available.\n\nRegistration required. Register at https://alumni.uga.edu/event/class-2016-senior-send-off/ \n\n	15	2016-05-11	2016-05-07 16:01:52	2016-05-07 16:01:52	Y	Y	\N	\N	194	0	1	0
242	Football (home) vs Vanderbilt	Go Dawgs!	15	2016-10-15	2016-07-31 22:36:18	2016-07-31 22:36:18	Y	Y	\N	\N	194	0	1	0
247	SEC football championship	Dawgs vs _____ 	15	2016-12-03	2016-07-31 22:42:42	2016-07-31 22:42:42	Y	Y	\N	\N	194	0	3	0
245	Football (home) vs UL Lafayette	Go dawgs	15	2016-11-19	2016-07-31 22:40:19	2016-07-31 22:40:19	Y	Y	\N	\N	194	0	1	0
249	Class of 2020 Freshman Welcome	All incoming freshman and transfers are invited to attend Freshman Welcome, UGA's official welcome celebration in Sanford Stadium. Free food and beverages! 6pm	15	2016-08-10	2016-07-31 22:59:47	2016-07-31 22:59:47	Y	Y	\N	\N	194	0	1	0
248	UGA Fans Day	Times are TBD at Sanford Stadium. More info will be on georgiadogs.com	15	2016-08-06	2016-07-31 22:55:32	2016-07-31 22:55:32	Y	Y	\N	\N	194	0	1	0
251	Fall classes begin	Back to schooooool	15	2016-08-11	2016-07-31 23:02:27	2016-07-31 23:02:27	Y	Y	\N	\N	194	0	1	0
209	International Coffee Hour	11:30 am - 1:00 pm\nMemorial Hall\nBallroom\n\nSponsored by: International Student Life, Office of\nContact: cheeia@uga.edu 706-542-5867\nThis event is for those who enjoy good food, coffee, conversations with people who like exploring and learning new cultures.\n\nInternational Coffee Hour at UGA is a weekly program that brings together students, faculty, staff and community members over coffee and international cuisine. This program offers a unique experience to engage in conversation with people of different cultures and backgrounds. Each week is hosted by a different student organization or department on campus.  \n\nCoordinated by the Department of International Student Life, UGA’s International Coffee Hour is held every Friday afternoon during the fall and spring semesters (excluding scheduled university breaks) and is one of the longest running programs of its kind across the U.S. 	15	2016-04-08	2016-04-05 22:44:33	2016-04-05 22:44:33	Y	Y	\N	\N	9	0	1	0
204	 Concert: UGA Symphony Orchestra	8:00 pm - 10:00 pm\nHugh Hodgson Concert Hall\n\nThe UGA Symphony Orchestra will close out the UGA Hugh Hodgson School of Music’s March schedule in fine fashion.\n\nThe students of the orchestra, led by Mark Cedel, will perform the overture from Mozart’s “The Marriage of Figaro,” Manuel de Falla’s “El Amor Brujo” and Symphony No. 3 from Mendelssohn. 	15	2016-04-01	2016-03-31 16:07:30	2016-03-31 16:07:30	Y	Y	\N	\N	9	0	1	0
173	Brawl for a Cause	WHEN\nSaturday, February 27, 2016 at 7:00 PM - Sunday, February 28, 2016 at 2:00 AM (EST)\nWHERE\nHedges on Broad - 346 East Broad Street Athens, GA 30601 \n\nBulldawg Brawl is back for its 6th Brawl for a Cause in Athens, and you aren't going to want to miss the action...\nPromo Video: https://www.youtube.com/watch?v=oTpOFxWs9iM\n12 passion-fueled charity-boxing bouts between everyday folks literally fighting for what they believe in most. We will be bussing in University of Florida student to Brawl Between the Hedges on Broad against University of Georgia Students in our very first rivalry fight event!\nProfessional boxer and announcer, Preston Haliburton and GA Follower's face and funny man, Ronndell Smith will be calling the shots. Belles of the Brawl (our classy ring-girls) will be showing off outfits from Cheeky Peach while escorted by our friends at E.S.P. Athens. Plus, we'll have DJ Grokas spinning tracks and playing walkout songs all night long. \nTickets:\nVIP:\n- Exclusive access to the second level, best view and ability to be directly above the action in the ring\n- Free first drinks courtesy of Buffalo Trace Bourbon\n- Handouts and goodies from our awesome sponsors\n- Exclusive access to the VIP section of the After-Party at Silver Dollar, including a bar tab\nTable: \n- Ringside Access with the closest view of the action\n- Free first drinks courtesy of Sponsors\n- Table service for all beverage needs\n- Exclusive access to upstairs at both Brawl and after-party at Silver Dollar, including bar tab\n\nMatch-ups, Causes and Donations: www.brawlforacause.fundly.com \n\n\n	15	2016-02-27	2016-02-23 19:55:32	2016-02-23 19:55:32	Y	Y	\N	\N	9	0	1	0
169	International Coffee Hour	11:30 am - 1:00 pm\nMemorial Hall\nBallroom\n\nSponsored by: International Student Life, Office of\nContact: cheeia@uga.edu 706-542-5867\nThis event is for those who enjoy good food, coffee, conversations with people and exploring and learning new cultures.\n\nInternational Coffee Hour at UGA is a weekly program that brings together students, faculty, staff and community members over coffee and international cuisine. This program offers a unique experience to engage in conversation with people of different cultures and backgrounds. Each week is hosted by a different student organization or department on campus.  \n\nCoordinated by the Department of International Student Life, UGA’s International Coffee Hour is held every Friday afternoon during the fall and spring semesters (excluding scheduled university breaks) and is one of the longest running programs of its kind across the U.S. 	15	2016-02-19	2016-02-19 15:29:47	2016-02-19 15:29:47	Y	Y	\N	\N	9	0	1	0
13	Softball vs. Elon	Come out Friday at 5:30 to cheer on our girls vs. Elon! 	15	2016-02-12	2016-02-09 01:35:02	2016-02-09 01:35:02	Y	Y	\N	\N	9	0	1	0
243	Ga-Fl football game! 	Dont miss the worlds biggest cocktail party down in Jax!	15	2016-10-29	2016-07-31 22:38:16	2016-07-31 22:38:16	Y	Y	\N	\N	194	0	1	0
255	The UGA Welcome Experience 	Tons of fun stuff going on this month!\n\nLearn more at glory.uga.edu	15	2016-08-27	2016-08-07 16:11:15	2016-08-07 16:11:15	Y	Y	\N	\N	9	0	1	0
256	Poster sale! August 8-16	Posters from $5-$9 \n\nTate student center\nAugust 8-16 \n9am-6pm	15	2016-08-16	2016-08-07 16:12:43	2016-08-07 16:12:43	Y	Y	\N	\N	194	0	1	0
254	Club Sports Fair	Learn about 43 different club sports and join one if your up for it! 	15	2016-08-22	2016-07-31 23:10:50	2016-07-31 23:10:50	Y	Y	\N	\N	194	0	1	0
252	Womens soccer vs Ga Southern	Home game 6pm 	15	2016-08-13	2016-07-31 23:04:26	2016-07-31 23:04:26	Y	Y	\N	\N	194	0	1	0
250	Group Fitness Free Week	August 11-17 all fitness classes are free at Ramsey	15	2016-08-17	2016-07-31 23:01:07	2016-07-31 23:01:07	Y	Y	\N	\N	194	0	1	0
244	Football (home) vs Auburn	dawgs on top!	15	2016-11-12	2016-07-31 22:39:25	2016-07-31 22:39:25	Y	Y	\N	\N	194	0	1	0
246	Clean, old-fashioned hate!	Dawgs on top over GT!	15	2016-11-26	2016-07-31 22:41:53	2016-07-31 22:41:53	N	Y	\N	\N	194	0	1	0
241	Football (home) vs Tennessee	Go dawgs!	15	2016-10-01	2016-07-31 22:35:23	2016-07-31 22:35:23	Y	Y	\N	\N	194	0	1	0
239	Football vs UNC	This game is at the Ga Dome to start the season! 5:30 start time	15	2016-09-03	2016-07-31 22:32:43	2016-07-31 22:32:43	Y	Y	\N	\N	194	0	1	0
240	Football (home) vs Nicholls State 	Go dawgs! 	15	2016-09-10	2016-07-31 22:33:41	2016-07-31 22:33:41	Y	Y	\N	\N	194	0	1	0
253	Part-time job and internship fair	11am @ Tate to meet local employers on and off campus for part time jobs and internships	15	2016-08-17	2016-07-31 23:07:06	2016-07-31 23:07:06	Y	Y	\N	\N	194	0	1	0
140	FHCE Internship/Career Fair 	1:00 pm - 4:00 pm\nTate Student Center\nReception Hall\n\nSponsored by: College of Family and Consumer Sciences, Financial Planning, Housing and Consumer Economics, Department of\nContact: Sheri Worthy \nThis event is for those who are for employment in financial planning, housing or consumer economics. To include employers across the state who have career and internship opportunities.\n\n	15	2016-02-04	2016-01-30 15:56:58	2016-01-30 15:56:58	Y	Y	\N	\N	9	0	1	0
137	Performance: “Fires In the Mirror”	8:00 pm - 8:00 pm\nSeney-Stovall Chapel\n$12; $7 for students\n\nContact: University Theatre 706-542-4400\nAlso Feb. 3-7 at 8 p.m. and Feb. 7 at 2:30 p.m.\n\nUniversity Theatre presents "Fires in the Mirror" by Anna Deavere Smith, directed by David Saltz. "Fires in the Mirror" tells the true story of a conflict between the African American and Hassidic Jewish communities who live side-by-side in the Crown Heights neighborhood of Brooklyn. In August 1991, a car in a motorcade carrying the Hassidic rabbi struck and killed a young black boy from a Guyanan family, and a few hours later a visiting Jewish scholar from Australia, unaware the accident had occurred, was stabbed to death in revenge. These two deaths sparked a three-day riot and inflamed latent tensions between the two communities. The play takes the audience in to the heart of this conflict through a series of monologues told from different character's points of view.	15	2016-02-07	2016-01-30 15:42:42	2016-01-30 15:42:42	Y	Y	\N	\N	9	0	1	0
\.


--
-- Data for Name: campus_buzz_gallery; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY campus_buzz_gallery (int_glcode, var_title, var_image, fk_campus_buzz, fk_user_id, dt_createdate, dt_modifydate, chr_delete, chr_publish) FROM stdin;
236	\N	118-1.jpeg	118	86	2015-12-04 19:25:25	2015-12-04 19:25:25	N	Y
237	\N	119-1.jpeg	119	68	2015-12-05 14:27:22	2015-12-05 14:32:17	N	Y
238	\N	120-1.jpeg	120	9	2016-01-06 01:32:50	2016-01-06 01:38:13	N	Y
239	\N	121-1.jpeg	121	9	2016-01-06 01:57:49	2016-01-06 01:57:49	N	Y
240	\N	122-1.jpeg	122	9	2016-01-06 02:02:31	2016-01-06 02:02:31	N	Y
241	\N	123-1.jpeg	123	9	2016-01-06 02:05:48	2016-01-06 02:05:48	N	Y
242	\N	124-1.jpeg	124	9	2016-01-06 02:07:30	2016-01-06 02:07:30	N	Y
243	\N	125-1.jpeg	125	9	2016-01-06 02:09:40	2016-01-06 02:09:40	N	Y
244	\N	126-1.jpeg	126	9	2016-01-06 02:11:10	2016-01-06 02:11:10	N	Y
245	\N	127-1.jpeg	127	9	2016-01-06 02:13:39	2016-01-06 02:13:39	N	Y
246	\N	128-1.jpeg	128	9	2016-01-06 02:16:22	2016-01-06 02:16:22	N	Y
247	\N	128-2.jpeg	128	9	2016-01-06 02:16:22	2016-01-06 02:16:22	N	Y
248	\N	128-3.jpeg	128	9	2016-01-06 02:16:22	2016-01-06 02:16:22	N	Y
249	\N	129-1.jpeg	129	180	2016-01-06 05:02:18	2016-01-06 05:02:18	N	Y
250	\N	130-1.jpeg	130	180	2016-01-06 05:05:02	2016-01-06 05:05:02	N	Y
251	\N	131-1.jpeg	131	180	2016-01-06 05:06:04	2016-01-06 05:06:04	N	Y
252	\N	132-1.jpeg	132	181	2016-01-07 04:43:21	2016-01-07 04:43:21	N	Y
253	\N	133-1.jpeg	133	6	2016-01-13 05:59:34	2016-01-13 05:59:34	N	Y
254	\N	134-1.jpeg	134	9	2016-01-14 22:48:12	2016-01-14 22:48:12	N	Y
255	\N	135-1.jpeg	135	9	2016-01-14 22:54:08	2016-01-14 22:54:08	N	Y
256	\N	136-1.jpeg	136	9	2016-01-30 15:37:11	2016-01-30 15:37:11	N	Y
257	\N	136-2.jpeg	136	9	2016-01-30 15:37:11	2016-01-30 15:37:11	N	Y
258	\N	136-3.jpeg	136	9	2016-01-30 15:37:11	2016-01-30 15:37:11	N	Y
259	\N	136-4.jpeg	136	9	2016-01-30 15:37:11	2016-01-30 15:37:11	N	Y
260	\N	137-1.jpeg	137	9	2016-01-30 15:42:42	2016-01-30 15:42:42	N	Y
261	\N	137-2.jpeg	137	9	2016-01-30 15:42:42	2016-01-30 15:42:42	N	Y
262	\N	137-3.jpeg	137	9	2016-01-30 15:42:42	2016-01-30 15:42:42	N	Y
263	\N	137-4.jpeg	137	9	2016-01-30 15:42:42	2016-01-30 15:42:42	N	Y
264	\N	138-1.jpeg	138	9	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y
265	\N	138-2.jpeg	138	9	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y
266	\N	138-3.jpeg	138	9	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y
267	\N	138-4.jpeg	138	9	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y
268	\N	139-1.jpeg	139	9	2016-01-30 15:51:17	2016-01-30 15:51:17	N	Y
269	\N	139-2.jpeg	139	9	2016-01-30 15:51:17	2016-01-30 15:51:17	N	Y
270	\N	139-3.jpeg	139	9	2016-01-30 15:51:17	2016-01-30 15:51:17	N	Y
271	\N	139-4.jpeg	139	9	2016-01-30 15:51:17	2016-01-30 15:51:17	N	Y
272	\N	140-1.jpeg	140	9	2016-01-30 15:56:58	2016-01-30 15:56:58	N	Y
273	\N	140-2.jpeg	140	9	2016-01-30 15:56:58	2016-01-30 15:56:58	N	Y
274	\N	140-3.jpeg	140	9	2016-01-30 15:56:58	2016-01-30 15:56:58	N	Y
275	\N	140-4.jpeg	140	9	2016-01-30 15:56:58	2016-01-30 15:56:58	N	Y
5	\N	1-1.jpeg	1	207	2016-02-04 01:48:05	2016-02-03 20:46:52	N	Y
6	\N	1-2.jpeg	1	207	2016-02-04 01:48:05	2016-02-03 20:46:52	N	Y
7	\N	1-3.jpeg	1	207	2016-02-04 01:48:05	2016-02-03 20:46:52	N	Y
8	\N	1-4.jpeg	1	207	2016-02-04 01:48:05	2016-02-03 20:46:52	N	Y
1	\N	2-1.jpeg	2	207	2016-02-04 01:37:01	2016-02-04 01:48:43	N	Y
2	\N	2-2.jpeg	2	207	2016-02-04 01:37:01	2016-02-04 01:48:43	N	Y
3	\N	2-3.jpeg	2	207	2016-02-04 01:37:01	2016-02-04 01:48:43	N	Y
4	\N	2-4.jpeg	2	207	2016-02-04 01:37:01	2016-02-04 01:48:43	N	Y
9	\N	3-1.jpeg	3	194	2016-02-04 01:57:10	2016-02-04 01:57:10	N	Y
12	\N	6-1.jpeg	6	183	2016-02-04 04:50:51	2016-02-04 04:57:09	N	Y
13	\N	6-2.jpeg	6	183	2016-02-04 04:57:09	2016-02-04 10:26:40	N	Y
14	\N	6-3.jpeg	6	183	2016-02-04 04:57:09	2016-02-04 10:26:40	N	Y
15	safsaf	7-1.png	0	0	2016-02-04 05:27:49	2016-02-04 05:27:49	Y	Y
16	\N	8-1.jpeg	8	194	2016-02-04 13:18:39	2016-02-04 13:18:39	N	Y
17	\N	9-1.jpeg	9	30	2016-02-05 00:56:46	2016-02-05 00:56:46	N	Y
18	\N	10-1.jpeg	10	30	2016-02-05 04:19:48	2016-02-05 04:20:48	N	Y
19	\N	11-1.jpeg	11	9	2016-02-07 15:56:36	2016-02-07 15:56:36	N	Y
20	\N	11-2.jpeg	11	9	2016-02-07 15:56:36	2016-02-07 15:56:36	N	Y
21	\N	11-3.jpeg	11	9	2016-02-07 15:56:36	2016-02-07 15:56:36	N	Y
22	\N	12-1.jpeg	12	9	2016-02-07 16:01:10	2016-02-07 16:01:10	N	Y
23	\N	12-2.jpeg	12	9	2016-02-07 16:01:10	2016-02-07 16:01:10	N	Y
24	\N	12-3.jpeg	12	9	2016-02-07 16:01:10	2016-02-07 16:01:10	N	Y
25	\N	12-4.jpeg	12	9	2016-02-07 16:01:10	2016-02-07 16:01:10	N	Y
26	\N	13-1.jpeg	13	9	2016-02-09 01:35:02	2016-02-09 01:35:02	N	Y
27	\N	13-2.jpeg	13	9	2016-02-09 01:35:02	2016-02-09 01:35:02	N	Y
28	\N	13-3.jpeg	13	9	2016-02-09 01:35:02	2016-02-09 01:35:02	N	Y
29	\N	13-4.jpeg	13	9	2016-02-09 01:35:02	2016-02-09 01:35:02	N	Y
30	\N	14-1.jpeg	14	9	2016-02-09 01:36:33	2016-02-09 01:36:33	N	Y
31	\N	14-2.jpeg	14	9	2016-02-09 01:36:33	2016-02-09 01:36:33	N	Y
32	\N	14-3.jpeg	14	9	2016-02-09 01:36:33	2016-02-09 01:36:33	N	Y
33	\N	14-4.jpeg	14	9	2016-02-09 01:36:33	2016-02-09 01:36:33	N	Y
34	\N	15-1.jpeg	15	9	2016-02-09 01:41:23	2016-02-09 01:41:23	N	Y
35	\N	15-2.jpeg	15	9	2016-02-09 01:41:23	2016-02-09 01:41:23	N	Y
36	\N	15-3.jpeg	15	9	2016-02-09 01:41:23	2016-02-09 01:41:23	N	Y
37	\N	15-4.jpeg	15	9	2016-02-09 01:41:23	2016-02-09 01:41:23	N	Y
38	\N	16-1.jpeg	16	9	2016-02-09 01:44:20	2016-02-09 01:44:20	N	Y
39	\N	16-2.jpeg	16	9	2016-02-09 01:44:20	2016-02-09 01:44:20	N	Y
40	\N	16-3.jpeg	16	9	2016-02-09 01:44:20	2016-02-09 01:44:20	N	Y
41	\N	16-4.jpeg	16	9	2016-02-09 01:44:20	2016-02-09 01:44:20	N	Y
42	\N	17-1.jpeg	17	180	2016-02-10 14:34:33	2016-02-10 14:34:33	N	Y
296	\N	151-1.jpeg	151	182	2016-02-11 07:14:45	2016-02-11 07:14:45	N	Y
297	\N	152-1.jpeg	152	180	2016-02-11 10:30:09	2016-02-11 10:30:09	N	Y
298	\N	153-1.jpeg	153	180	2016-02-11 10:31:32	2016-02-11 10:31:32	N	Y
299	\N	154-1.jpeg	154	180	2016-02-11 10:33:05	2016-02-11 10:33:05	N	Y
300	\N	154-2.jpeg	154	180	2016-02-11 10:33:05	2016-02-11 10:33:05	N	Y
301	\N	154-3.jpeg	154	180	2016-02-11 10:33:05	2016-02-11 10:33:05	N	Y
302	\N	154-4.jpeg	154	180	2016-02-11 10:33:05	2016-02-11 10:33:05	N	Y
303	\N	155-1.jpeg	155	194	2016-02-11 12:00:22	2016-02-11 12:00:22	N	Y
304	\N	156-1.jpeg	156	194	2016-02-11 12:04:52	2016-02-11 12:04:52	N	Y
305	\N	157-1.jpeg	157	30	2016-02-11 13:24:43	2016-02-11 13:24:43	N	Y
306	\N	158-1.jpeg	158	30	2016-02-11 13:33:53	2016-02-11 13:33:53	N	Y
307	\N	159-1.jpeg	159	194	2016-02-11 14:08:31	2016-02-11 14:08:31	N	Y
308	\N	160-1.jpeg	160	66	2016-02-11 18:21:08	2016-02-11 18:21:08	N	Y
309	\N	161-1.jpeg	161	207	2016-02-12 15:58:49	2016-02-12 15:58:49	N	Y
310	\N	161-2.jpeg	161	207	2016-02-12 15:58:49	2016-02-12 15:58:49	N	Y
311	\N	162-1.jpeg	162	194	2016-02-14 01:16:02	2016-02-14 01:16:02	N	Y
312	\N	163-1.jpeg	163	194	2016-02-14 01:18:42	2016-02-14 01:18:42	N	Y
313	\N	164-1.jpeg	164	194	2016-02-14 01:20:46	2016-02-14 01:20:46	N	Y
314	\N	165-1.jpeg	165	207	2016-02-16 01:11:38	2016-02-16 01:11:38	N	Y
315	\N	166-1.jpeg	166	30	2016-02-16 13:29:35	2016-02-16 13:29:35	N	Y
316	\N	167-1.jpeg	167	30	2016-02-16 13:33:11	2016-02-16 13:33:11	N	Y
317	\N	168-1.jpeg	168	9	2016-02-16 16:25:51	2016-02-16 16:25:51	N	Y
318	\N	168-2.jpeg	168	9	2016-02-16 16:25:51	2016-02-16 16:25:51	N	Y
319	\N	169-1.jpeg	169	9	2016-02-19 15:29:47	2016-02-19 15:29:47	N	Y
320	\N	170-1.jpeg	170	9	2016-02-19 15:35:22	2016-02-19 15:35:22	N	Y
321	\N	170-2.jpeg	170	9	2016-02-19 15:35:22	2016-02-19 15:35:22	N	Y
322	\N	170-3.jpeg	170	9	2016-02-19 15:35:22	2016-02-19 15:35:22	N	Y
324	\N	172-1.jpeg	172	194	2016-02-22 18:41:48	2016-02-22 18:41:48	N	Y
396	\N	233-1.jpeg	233	194	2016-05-07 16:00:41	2016-05-07 16:00:41	N	Y
323	\N	171-1.jpeg	171	66	2016-02-22 17:49:10	2016-02-22 18:45:12	N	Y
325	\N	173-1.jpeg	173	9	2016-02-23 19:55:32	2016-02-23 19:55:32	N	Y
326	\N	173-2.jpeg	173	9	2016-02-23 19:55:32	2016-02-23 19:55:32	N	Y
327	\N	173-3.jpeg	173	9	2016-02-23 19:55:32	2016-02-23 19:55:32	N	Y
328	\N	173-4.jpeg	173	9	2016-02-23 19:55:32	2016-02-23 19:55:32	N	Y
329	\N	174-1.jpeg	174	180	2016-02-24 06:14:07	2016-02-24 06:14:07	N	Y
330	\N	175-1.jpeg	175	180	2016-02-24 06:41:16	2016-02-24 06:41:16	N	Y
331	\N	176-1.jpeg	176	194	2016-02-24 12:45:07	2016-02-24 12:45:07	N	Y
332	\N	177-1.jpeg	177	9	2016-02-24 14:17:03	2016-02-24 14:17:03	N	Y
333	\N	177-2.jpeg	177	9	2016-02-24 14:17:03	2016-02-24 14:17:03	N	Y
334	\N	178-1.jpeg	178	194	2016-02-25 11:57:48	2016-02-25 11:57:48	N	Y
335	\N	179-1.jpeg	179	194	2016-03-01 16:05:42	2016-03-01 16:05:42	N	Y
336	\N	180-1.jpeg	180	194	2016-03-01 16:07:41	2016-03-01 16:07:41	N	Y
337	\N	181-1.jpeg	181	194	2016-03-01 16:09:08	2016-03-01 16:09:08	N	Y
338	\N	182-1.jpeg	182	194	2016-03-14 12:46:46	2016-03-14 12:46:46	N	Y
339	\N	183-1.jpeg	183	194	2016-03-14 12:48:51	2016-03-14 12:48:51	N	Y
340	\N	184-1.jpeg	184	194	2016-03-14 12:49:37	2016-03-14 12:49:37	N	Y
341	\N	185-1.jpeg	185	194	2016-03-14 12:56:56	2016-03-14 12:56:56	N	Y
342	\N	186-1.jpeg	186	194	2016-03-14 12:59:11	2016-03-14 12:59:11	N	Y
343	\N	187-1.jpeg	187	194	2016-03-14 15:29:07	2016-03-14 15:29:07	N	Y
344	\N	188-1.jpeg	188	194	2016-03-14 17:10:39	2016-03-14 17:10:39	N	Y
345	\N	189-1.jpeg	189	194	2016-03-14 17:16:37	2016-03-14 17:16:37	N	Y
346	\N	190-1.jpeg	190	180	2016-03-15 12:49:57	2016-03-15 12:49:57	N	Y
347	\N	191-1.jpeg	191	194	2016-03-19 18:14:29	2016-03-19 18:14:29	N	Y
348	\N	192-1.jpeg	192	194	2016-03-19 18:16:19	2016-03-19 18:16:19	N	Y
349	\N	193-1.jpeg	193	194	2016-03-19 18:17:44	2016-03-19 18:17:44	N	Y
350	\N	194-1.jpeg	194	194	2016-03-19 18:19:07	2016-03-19 18:19:07	N	Y
351	\N	195-1.jpeg	195	194	2016-03-19 18:20:43	2016-03-19 18:20:43	N	Y
352	\N	196-1.jpeg	196	194	2016-03-22 01:21:42	2016-03-22 01:21:42	N	Y
353	\N	197-1.jpeg	197	66	2016-03-25 16:45:20	2016-03-25 16:45:20	N	Y
354	\N	198-1.jpeg	198	9	2016-03-28 14:10:01	2016-03-28 14:10:01	N	Y
355	\N	199-1.jpeg	199	9	2016-03-28 14:11:18	2016-03-28 14:11:18	N	Y
356	\N	200-1.jpeg	200	194	2016-03-29 11:56:02	2016-03-29 11:56:02	N	Y
357	\N	202-1.jpeg	202	9	2016-03-31 15:55:19	2016-03-31 15:55:19	N	Y
358	\N	203-1.jpeg	203	9	2016-03-31 15:59:03	2016-03-31 15:59:03	N	Y
359	\N	204-1.jpeg	204	9	2016-03-31 16:07:30	2016-03-31 16:07:30	N	Y
360	\N	204-2.jpeg	204	9	2016-03-31 16:07:30	2016-03-31 16:07:30	N	Y
361	\N	204-3.jpeg	204	9	2016-03-31 16:07:30	2016-03-31 16:07:30	N	Y
362	\N	205-1.jpeg	205	181	2016-04-02 13:20:22	2016-04-02 13:20:22	N	Y
363	\N	206-1.jpeg	206	181	2016-04-04 08:58:26	2016-04-04 08:58:26	N	Y
364	\N	207-1.jpeg	207	9	2016-04-05 22:35:29	2016-04-05 22:35:29	N	Y
365	\N	207-2.jpeg	207	9	2016-04-05 22:35:29	2016-04-05 22:35:29	N	Y
366	\N	208-1.jpeg	208	9	2016-04-05 22:42:30	2016-04-05 22:42:30	N	Y
367	\N	208-2.jpeg	208	9	2016-04-05 22:42:30	2016-04-05 22:42:30	N	Y
368	\N	209-1.jpeg	209	9	2016-04-05 22:44:33	2016-04-05 22:44:33	N	Y
369	\N	210-1.jpeg	210	181	2016-04-08 10:35:03	2016-04-08 10:35:03	N	Y
370	\N	211-1.jpeg	211	9	2016-04-09 17:19:31	2016-04-09 17:19:31	N	Y
371	\N	212-1.jpeg	212	9	2016-04-11 02:33:34	2016-04-11 02:33:34	N	Y
372	\N	212-2.jpeg	212	9	2016-04-11 02:33:34	2016-04-11 02:33:34	N	Y
373	\N	213-1.jpeg	213	30	2016-04-11 14:05:41	2016-04-11 14:05:41	N	Y
374	\N	214-1.jpeg	214	194	2016-04-11 16:00:41	2016-04-11 16:00:41	N	Y
375	\N	215-1.jpeg	215	194	2016-04-11 16:35:50	2016-04-11 16:35:50	N	Y
376	\N	216-1.jpeg	216	194	2016-04-11 16:39:45	2016-04-11 16:39:45	N	Y
377	\N	217-1.jpeg	217	194	2016-04-11 16:40:40	2016-04-11 16:40:40	N	Y
378	\N	218-1.jpeg	218	194	2016-04-11 16:43:48	2016-04-11 16:43:48	N	Y
379	\N	219-1.jpeg	219	194	2016-04-11 16:46:00	2016-04-11 16:46:00	N	Y
397	\N	234-1.jpeg	234	194	2016-05-07 16:01:52	2016-05-07 16:01:52	N	Y
381	\N	221-1.jpeg	221	194	2016-04-12 00:14:36	2016-04-12 00:14:36	N	Y
382	\N	222-1.jpeg	222	9	2016-04-12 00:16:15	2016-04-12 00:16:15	N	Y
380	\N	220-1.jpeg	220	9	2016-04-11 22:17:49	2016-04-14 12:07:01	N	Y
383	\N	223-1.jpeg	223	194	2016-04-14 14:17:30	2016-04-14 14:17:30	N	Y
384	\N	224-1.jpeg	224	182	2016-04-16 11:56:37	2016-04-16 11:56:37	N	Y
385	\N	225-1.jpeg	225	194	2016-04-20 14:26:02	2016-04-20 14:26:02	N	Y
386	\N	226-1.jpeg	226	194	2016-04-20 14:27:26	2016-04-20 14:27:26	N	Y
387	\N	227-1.jpeg	227	9	2016-04-26 14:18:32	2016-04-26 14:18:32	N	Y
388	\N	228-1.jpeg	228	30	2016-04-27 13:29:38	2016-04-27 13:29:38	N	Y
389	\N	229-1.jpeg	229	9	2016-04-28 02:22:03	2016-04-28 02:22:03	N	Y
390	\N	229-2.jpeg	229	9	2016-04-28 02:22:03	2016-04-28 02:22:03	N	Y
391	\N	230-1.jpeg	230	9	2016-04-28 11:12:54	2016-04-28 11:12:54	N	Y
392	\N	231-1.jpeg	231	9	2016-04-28 11:15:29	2016-04-28 11:15:29	N	Y
393	\N	231-2.jpeg	231	9	2016-04-28 11:15:29	2016-04-28 11:15:29	N	Y
394	\N	232-1.jpeg	232	9	2016-04-28 11:22:10	2016-04-28 11:22:10	N	Y
395	\N	232-2.jpeg	232	9	2016-04-28 11:22:11	2016-04-28 11:22:11	N	Y
398	\N	235-1.jpeg	235	194	2016-05-07 16:03:43	2016-05-07 16:03:43	N	Y
400	\N	237-1.jpeg	237	194	2016-05-17 17:01:57	2016-05-17 17:01:57	N	Y
401	\N	238-1.jpeg	238	194	2016-05-17 17:03:23	2016-05-17 17:03:23	N	Y
399	\N	236-1.jpeg	236	194	2016-05-17 17:00:37	2016-07-31 22:31:10	N	Y
402	\N	239-1.jpeg	239	194	2016-07-31 22:32:43	2016-07-31 22:32:43	N	Y
403	\N	240-1.jpeg	240	194	2016-07-31 22:33:41	2016-07-31 22:33:41	N	Y
404	\N	241-1.jpeg	241	194	2016-07-31 22:35:23	2016-07-31 22:35:23	N	Y
405	\N	242-1.jpeg	242	194	2016-07-31 22:36:18	2016-07-31 22:36:18	N	Y
406	\N	243-1.jpeg	243	194	2016-07-31 22:38:16	2016-07-31 22:38:16	N	Y
407	\N	244-1.jpeg	244	194	2016-07-31 22:39:25	2016-07-31 22:39:25	N	Y
408	\N	245-1.jpeg	245	194	2016-07-31 22:40:19	2016-07-31 22:40:19	N	Y
409	\N	246-1.jpeg	246	194	2016-07-31 22:41:53	2016-07-31 22:41:53	N	Y
410	\N	247-1.jpeg	247	194	2016-07-31 22:42:42	2016-07-31 22:42:42	N	Y
414	\N	251-1.jpeg	251	194	2016-07-31 23:02:27	2016-07-31 23:02:27	N	Y
416	\N	253-1.jpeg	253	194	2016-07-31 23:07:06	2016-07-31 23:07:06	N	Y
417	\N	254-1.jpeg	254	194	2016-07-31 23:10:50	2016-07-31 23:10:50	N	Y
411	\N	248-1.jpeg	248	194	2016-07-31 22:55:32	2016-07-31 22:55:32	N	Y
412	\N	249-1.jpeg	249	194	2016-07-31 22:59:47	2016-07-31 22:59:47	N	Y
413	\N	250-1.jpeg	250	194	2016-07-31 23:01:07	2016-07-31 23:01:07	N	Y
415	\N	252-1.jpeg	252	194	2016-07-31 23:04:26	2016-07-31 23:04:26	N	Y
418	\N	255-1.jpeg	255	9	2016-08-07 16:11:15	2016-08-07 16:11:15	N	Y
419	\N	256-1.jpeg	256	194	2016-08-07 16:12:43	2016-08-07 16:12:43	N	Y
\.


--
-- Name: campus_buzz_gallery_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('campus_buzz_gallery_int_glcode_seq', 419, true);


--
-- Name: campus_buzz_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('campus_buzz_int_glcode_seq', 256, true);


--
-- Data for Name: campus_deal; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY campus_deal (int_glcode, var_title, var_description, fk_university, dt_expiredate, dt_createdate, dt_modifydate, chr_delete, chr_publish, var_adminuser, var_ipaddress, fk_user_id, var_dealcode, code_count, chr_status, chr_block) FROM stdin;
\.


--
-- Name: campus_deal_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('campus_deal_int_glcode_seq', 1, false);


--
-- Data for Name: campus_gallery; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY campus_gallery (int_glcode, var_title, var_image, fk_campus_deal, dt_createdate, dt_modifydate, chr_delete, chr_publish, fk_user_id) FROM stdin;
\.


--
-- Name: campus_gallery_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('campus_gallery_int_glcode_seq', 1, false);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY category (int_glcode, var_title, var_alias, int_displayorder, dt_createddate, dt_modifydate, var_metatitle, var_metakeyword, var_metadescription, chr_delete, chr_publish, var_adminuser, var_ipaddress) FROM stdin;
\.


--
-- Name: category_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('category_int_glcode_seq', 1, false);


--
-- Data for Name: contactusleads; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY contactusleads (int_glcode, var_name, var_email, var_message, dt_createdate, chr_delete, chr_publish, fk_user_id) FROM stdin;
1	syray	syray@valdosta.edu	You're hawt	2016-02-02 03:27:20	Y	Y	61
3	DPSchwartz11	dps11@uga.edu	Are you getting this? Testing 123	2016-02-24 14:19:23	Y	Y	9
4	rach217	rach217@uga.edu	How does one get free chic fil a 	2016-03-01 04:48:28	Y	Y	395
5	c52	chrisb52@uga.edu	Hey guys. You asked for some constructive criticism so here are some things I saw in no particular order:\n\n1. I don't see any way to rate a seller. If I was going to buy something from a random person off the app, it would be nice to see if they had done it before. That could also help address concerns over safety when meeting to buy or sell. If a person can see that the seller has done this before and done it well, they could have a better idea of the safety and legitimacy of the transaction.\n\n2. The app actually froze on me. Probably an isolated incident, but this is not ideal.\n\n3. When looking at pictures, I would like to know how many there are. I would not have known you could have multiple pictures for a single item if I had not looked at the Post feature and seen this.\n\n4. I know that a person has to have a university email address to login, but can they view other colleges once logged in? I tried looking at Auburn to see your presence there, but found nothing there. Does that mean there is nothing posted or I cannot view it? When changing universities, I was forced to input my email. I used my UGA email address and things seemed to work fine, but I cannot tell since there was nothing posted. Viewing other universities could be helpful if someone is trying to transfer and find books, housing etc.\n\n5. The search function could use some improvement. For example, I searched "shirt" and came up empty. There were shirts available in the men's clothing section, but none of the titles had the word "shirt" in them. Had I searched "polo" or "tee" I could have easily found a shirt. Could you use a visual search component so that it could find shirts when that was not the key word or perhaps a have a subcategory box you check when posting? Using subcategory "shirt" I could have found all these, but was forced to go in and look through the men's clothing section to find a shirt.\n\n6. What does the campus notification do? All it said was there was no notification. Would this notify me of an event or an item on my watchlist expiring?\n\n7. Some items say "Expired Today". Does this mean they are still available since they still appear in the market? If so should it say "Expires Today"? \n\n8. What motivation do people have to use this feedback feature?\n\n9. The lack of stuff on here is probably the biggest issue with the app. Even if you just worked with Flagpole or UGA to put more events on here, that would look better.\n\n10. Is there an alert system? If I wanted a place to live for example, could I set up an alert on housing to let me know if some became available? Or if I wanted a particular textbook could the app tell me when one was posted? Is this what the  notification does?\n\n11. This contact us feature is annoying in some ways. Does not capitalize letters after periods or let me scroll through easily.\n\nThose are just some things I noticed after playing with the app a little while. If I think of more, I can let you know.\n\nYou told me not to worry about praising you and to focus on constructive criticism. But, I think for the most part the app is fantastic. Pretty easy to use and a nice slick layout. It actually reminds me of the Spotify genre page a lot. This is a great idea and the app looks good. Most of the stuff I pointed out were just little things. Keep up the good work y'all!	2016-04-23 00:00:00	N	Y	506
6	c52	chrisb52@uga.edu	How are you going to deal with most people wanting to sell books at the end of the semester and most people wanting to buy at the beginning? \n\nSeems like you may have disjointed timing there.	2016-04-23 00:00:00	N	Y	506
7	jojojacob	jds99691@uga.edu	I am really enjoying ThriftSkool and would like to become a student ambassador. If you would like for me to send in an application or do an in person interview, that is fine by me. Just send me a date and I will make it. Thanks so much, Jacob Sumpter	2016-05-02 05:56:03	N	Y	520
8	Lindsay_O	lmo52451@uga.edu	Loved the event and free pizza! I love your passion for the app and openness to new ideas! Great job and the app is super easy to use!	2016-08-20 00:00:00	N	Y	801
9	DPSchwartz11	dps11@uga.edu	I don't even want to pay Pratik. 	2016-11-15 11:55:01	N	Y	9
\.


--
-- Name: contactusleads_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('contactusleads_int_glcode_seq', 9, true);


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY favorite (int_glcode, fk_user_id, fk_post, dt_createdate, chr_favorite, type) FROM stdin;
134	605	568	2016-10-04 14:32:11	0	1
104	576	419	2016-08-12 21:34:45	0	1
71	61	235	2015-12-04 19:45:30	0	1
70	30	184	2015-12-16 03:18:17	0	1
73	9	255	2015-12-16 23:52:07	0	1
72	119	237	2015-12-18 17:33:23	0	1
75	9	265	2016-01-08 04:44:21	1	1
74	6	258	2016-01-13 00:37:02	1	1
76	6	278	2016-01-13 06:01:17	1	1
77	6	281	2016-01-13 06:01:34	1	1
78	194	286	2016-01-16 19:57:48	0	1
1	99	293	2016-02-04 17:52:01	0	1
81	359	318	2016-02-17 16:53:50	0	1
82	194	319	2016-02-27 16:52:36	0	1
83	194	330	2016-03-16 07:16:17	0	1
84	437	334	2016-03-24 01:27:06	0	1
85	421	339	2016-03-29 15:48:55	0	1
136	1093	574	2016-10-05 21:29:04	0	1
101	687	414	2016-08-13 16:15:51	0	1
86	421	345	2016-04-21 02:42:14	0	1
100	687	441	2016-08-13 16:16:28	0	1
89	421	363	2016-04-29 11:58:32	0	1
90	421	362	2016-04-29 11:58:52	0	1
105	687	451	2016-08-13 16:16:52	0	1
103	421	426	2016-08-13 21:23:11	0	1
92	207	382	2016-05-02 19:37:16	0	1
93	207	385	2016-05-02 19:37:17	0	1
87	421	361	2016-05-02 23:24:54	0	1
94	421	381	2016-05-02 23:25:00	0	1
107	636	460	2016-08-14 14:38:34	0	1
106	599	418	2016-08-14 16:45:34	0	1
91	421	383	2016-05-03 22:06:16	0	1
97	421	400	2016-05-06 16:31:04	0	1
95	421	375	2016-05-08 20:58:32	0	1
96	421	374	2016-05-08 20:58:36	0	1
98	321	373	2016-05-08 22:48:55	1	1
99	194	407	2016-07-08 23:06:17	0	1
137	611	606	2016-10-09 20:47:09	0	1
109	723	442	2016-08-16 20:19:48	0	1
135	1086	577	2016-10-13 03:08:01	0	1
102	725	421	2016-08-18 01:19:24	0	1
112	725	452	2016-08-18 01:21:18	0	1
111	725	447	2016-08-18 01:21:19	0	1
113	777	437	2016-08-19 21:22:23	0	1
110	777	416	2016-08-19 21:24:10	0	1
114	194	470	2016-08-22 22:30:54	0	1
138	643	604	2016-10-17 17:37:29	0	1
108	845	456	2016-08-28 23:34:32	1	1
117	844	444	2016-08-29 03:22:09	0	1
118	611	502	2016-08-30 00:45:46	0	1
115	598	428	2016-08-30 00:49:15	0	1
120	844	501	2016-08-31 01:44:48	0	1
122	868	510	2016-09-02 15:18:58	0	1
139	1018	621	2016-11-10 02:41:39	0	1
124	910	533	2016-09-06 20:57:57	0	1
140	1018	631	2016-11-21 15:28:30	0	1
116	598	439	2016-09-10 06:42:45	0	1
123	962	500	2016-09-13 21:12:33	0	1
125	965	499	2016-09-14 17:14:35	0	1
121	605	472	2016-09-14 17:16:10	0	1
126	514	495	2016-09-17 19:08:49	0	1
119	605	483	2016-09-18 23:42:16	0	1
127	1018	570	2016-09-21 00:24:12	0	1
129	1018	564	2016-09-21 17:07:28	0	1
128	1018	567	2016-09-21 17:07:58	0	1
130	1038	566	2016-09-22 17:52:03	0	1
131	1018	585	2016-09-27 22:11:19	0	1
133	1062	598	2016-09-28 19:43:25	0	1
132	1018	572	2016-10-01 00:11:17	0	1
\.


--
-- Name: favorite_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('favorite_int_glcode_seq', 140, true);


--
-- Data for Name: general_settings; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY general_settings (int_glcode, var_sitename, var_sitepath, chr_seo_flag, chr_maintenance, var_contactusmail) FROM stdin;
1	Thriftskool	https://thriftskool.com/mobileapps/thriftskool/	Y	N	0
\.


--
-- Name: general_settings_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('general_settings_int_glcode_seq', 1, false);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY groups (int_glcode, var_name, int_displayorder, chr_publish, chr_read, chr_star, chr_delete, chr_adminpanel_group, dt_createdate, dt_modifydate) FROM stdin;
\.


--
-- Data for Name: job_management; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY job_management (int_glcode, var_jobname, var_description, dt_createdate, dt_modifydate, chr_delete, chr_publish, var_adminuser, var_ipaddress, fk_user_id, dt_expiredate, fk_university) FROM stdin;
1	test	test	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y	\N	\N	0	2016-01-30	5
2	test	test	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y	\N	\N	0	2016-01-30	5
3	test	test	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y	\N	\N	0	2016-01-30	5
4	test	test	2016-01-30 15:46:26	2016-01-30 15:46:26	N	Y	\N	\N	0	2016-01-30	5
\.


--
-- Name: job_management_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('job_management_int_glcode_seq', 4, true);


--
-- Data for Name: logmanager; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY logmanager (int_glcode, fk_user_id, fk_modulename, var_tablename, chr_read, dt_createdate, chr_delete, var_referenceid, notification_type, fk_post_id, from_where, chr_send) FROM stdin;
2043	86	149	campus_buzz	N	2015-12-04 19:25:26	N	118		\N	1	N
2046	68	149	campus_buzz	N	2015-12-05 14:27:22	N	119		\N	1	N
2048	86	149	campus_buzz	N	2015-12-06 07:00:05	N	118	1	\N	\N	N
2049	117	144	post_management	N	2015-12-08 05:55:55	N	237		\N	1	N
2050	61	144	post_management	N	2015-12-11 21:54:34	N	238		\N	1	N
2052	163	144	post_management	N	2015-12-14 00:16:21	N	240		\N	1	N
2054	92	144	post_management	N	2015-12-15 03:53:42	N	242		\N	1	N
2056	33	144	post_management	N	2015-12-15 07:00:03	N	185	1	\N	\N	N
2059	172	144	post_management	N	2015-12-15 17:07:26	N	246		\N	1	N
2062	175	144	post_management	N	2015-12-16 05:27:44	N	255		\N	1	N
2065	6	144	post_management	N	2015-12-18 06:58:05	N	257		\N	1	N
2068	2	144	post_management	N	2015-12-18 07:08:03	N	258		\N	1	N
2329	61	145	message_list	Y	2015-12-22 13:01:36	N	1794	0	\N	1	N
2592	181	144	post_management	N	2016-01-07 04:42:13	N	276		\N	1	N
2332	12	145	message_list	Y	2015-12-22 13:05:08	N	1797	0	\N	1	N
2335	61	145	message_list	Y	2015-12-22 13:06:52	N	1800	0	\N	1	N
2338	12	145	message_list	Y	2015-12-22 13:09:23	N	1803	0	\N	1	N
2454	181	144	post_management	Y	2015-12-26 07:00:04	N	260	1	\N	\N	N
2598	61	144	post_management	N	2016-01-10 07:00:04	N	238	1	\N	\N	N
2458	61	145	message_list	Y	2015-12-28 00:53:24	N	1913	0	\N	1	N
2600	61	144	post_management	Y	2016-01-11 07:00:05	N	239	1	\N	\N	N
2311	180	144	post_management	N	2015-12-22 11:33:47	N	264		\N	1	N
2118	175	144	post_management	N	2015-12-19 07:00:04	N	255	1	\N	\N	N
2604	180	144	post_management	N	2016-01-12 05:40:45	N	278		\N	1	N
2356	9	144	post_management	N	2015-12-22 23:51:10	N	265		\N	1	N
2317	12	145	message_list	Y	2015-12-22 11:44:50	N	1782	0	\N	1	N
2724	194	145	message_list	Y	2016-01-21 12:40:17	N	2113	0	\N	1	N
2326	12	145	message_list	Y	2015-12-22 12:55:03	N	1791	0	\N	1	N
2323	61	145	message_list	Y	2015-12-22 12:21:44	N	1788	0	\N	1	N
2727	212	145	message_list	Y	2016-01-21 12:42:50	N	2116	0	\N	1	N
2730	212	145	message_list	Y	2016-01-21 12:48:49	N	2119	0	\N	1	N
2479	12	145	message_list	Y	2015-12-28 12:39:24	N	1932	0	\N	1	N
2189	12	144	post_management	N	2015-12-21 22:53:08	N	259		\N	1	N
2692	185	144	post_management	N	2016-01-18 20:23:27	N	288		\N	1	N
2455	12	145	message_list	Y	2015-12-28 00:51:59	N	1910	0	\N	1	N
2738	212	145	message_list	Y	2016-01-22 12:24:54	N	2127	0	\N	1	N
2399	12	144	post_management	N	2015-12-24 05:47:16	N	273		\N	1	N
2641	9	144	post_management	N	2016-01-12 13:33:48	N	279		\N	1	N
2482	12	145	message_list	Y	2015-12-28 12:47:19	N	1935	0	\N	1	N
1850	\N	144	post_management	N	2015-11-07 06:19:25	N	171		\N	1	N
2643	6	144	post_management	N	2016-01-13 05:57:49	N	281		\N	1	N
2648	172	144	post_management	N	2016-01-14 07:00:07	N	244	1	\N	\N	N
2649	172	144	post_management	N	2016-01-14 07:00:07	N	246	1	\N	\N	N
2650	6	144	post_management	N	2016-01-14 07:00:07	N	281	1	\N	\N	N
2651	172	144	post_management	N	2016-01-14 07:00:07	N	245	1	\N	\N	N
2652	172	144	post_management	N	2016-01-14 07:00:07	N	247	1	\N	\N	N
2653	6	149	campus_buzz	N	2016-01-14 07:00:08	N	133	1	\N	\N	N
2654	9	149	campus_buzz	Y	2016-01-14 07:00:08	N	124	1	\N	\N	N
2518	6	144	post_management	N	2015-12-31 05:38:15	N	274		\N	1	N
1852	\N	144	post_management	N	2015-11-07 06:30:58	N	172		\N	1	N
2660	9	149	campus_buzz	N	2016-01-14 22:48:12	N	134		\N	1	N
1854	\N	144	post_management	N	2015-11-07 06:33:14	N	173		\N	1	N
2601	9	149	campus_buzz	Y	2016-01-11 07:00:05	N	122	1	\N	\N	N
1858	\N	144	post_management	N	2015-11-07 06:50:03	N	174		\N	1	N
1859	\N	144	post_management	N	2015-11-07 06:54:07	N	175		\N	1	N
2702	6	144	post_management	N	2016-01-20 07:00:07	N	287	1	\N	\N	N
1861	\N	144	post_management	N	2015-11-07 08:25:48	N	176		\N	1	N
2581	9	149	campus_buzz	N	2016-01-06 01:57:49	N	121		\N	1	N
2584	9	149	campus_buzz	N	2016-01-06 02:07:30	N	124		\N	1	N
2587	9	149	campus_buzz	N	2016-01-06 02:13:39	N	127		\N	1	N
2591	180	149	campus_buzz	N	2016-01-06 05:06:05	N	131		\N	1	N
2666	194	145	message_list	Y	2016-01-15 00:54:00	N	2073	0	\N	1	N
2741	212	145	message_list	Y	2016-01-22 12:26:52	N	2130	0	\N	1	N
2671	30	144	post_management	N	2016-01-15 07:00:05	N	248	1	\N	\N	N
2672	30	144	post_management	N	2016-01-15 07:00:05	N	250	1	\N	\N	N
2677	194	144	post_management	N	2016-01-15 22:48:45	N	284		\N	1	N
2744	194	145	message_list	Y	2016-01-22 12:30:08	N	2133	0	\N	1	N
2685	6	144	post_management	N	2016-01-18 07:00:06	N	257	1	\N	\N	N
2686	2	144	post_management	N	2016-01-18 07:00:06	N	258	1	\N	\N	N
2695	9	149	campus_buzz	Y	2016-01-19 07:00:07	N	127	1	\N	\N	N
2684	9	149	campus_buzz	Y	2016-01-17 07:00:06	N	126	1	\N	\N	N
2674	9	149	campus_buzz	Y	2016-01-15 07:00:05	N	135	1	\N	\N	N
2602	9	149	campus_buzz	Y	2016-01-11 07:00:05	N	123	1	\N	\N	N
2669	30	145	message_list	Y	2016-01-15 01:59:24	N	2076	0	\N	1	N
1862	\N	149	campus_buzz	N	2015-11-07 08:28:47	N	106		\N	1	N
1863	\N	144	post_management	N	2015-11-07 09:35:08	N	177		\N	1	N
2044	87	144	post_management	N	2015-12-04 19:28:55	N	235		\N	1	N
2673	181	149	campus_buzz	Y	2016-01-15 07:00:05	N	132	1	\N	\N	N
2599	181	144	post_management	Y	2016-01-11 07:00:04	N	276	1	\N	\N	N
2047	71	144	post_management	N	2015-12-05 19:58:17	N	236		\N	1	N
2051	61	144	post_management	N	2015-12-11 21:56:07	N	239		\N	1	N
2053	170	144	post_management	N	2015-12-14 02:19:11	N	241		\N	1	N
2055	171	144	post_management	N	2015-12-15 03:59:56	N	243		\N	1	N
2057	172	144	post_management	N	2015-12-15 17:03:38	N	244		\N	1	N
2060	172	144	post_management	N	2015-12-15 17:08:35	N	247		\N	1	N
1871	\N	144	post_management	N	2015-11-07 10:36:45	N	179		\N	1	N
2063	175	144	post_management	N	2015-12-16 14:59:21	N	256		\N	1	N
2330	61	145	message_list	Y	2015-12-22 13:02:14	N	1795	0	\N	1	N
2333	61	145	message_list	Y	2015-12-22 13:06:04	N	1798	0	\N	1	N
2593	181	149	campus_buzz	N	2016-01-07 04:43:21	N	132		\N	1	N
2336	61	145	message_list	Y	2015-12-22 13:07:39	N	1801	0	\N	1	N
1881	\N	149	campus_buzz	N	2015-11-07 12:31:19	N	107		\N	1	N
2603	9	144	post_management	N	2016-01-11 23:24:58	N	277		\N	1	N
1884	\N	144	post_management	N	2015-11-07 12:53:33	N	180		\N	1	N
2742	194	145	message_list	Y	2016-01-22 12:27:43	N	2131	0	\N	1	N
1887	\N	144	post_management	N	2015-11-07 13:06:25	N	181		\N	1	N
2722	212	145	message_list	Y	2016-01-21 12:33:33	N	2111	0	\N	1	N
2309	180	144	post_management	N	2015-12-22 11:19:44	N	262		\N	1	N
2745	212	145	message_list	Y	2016-01-22 12:33:05	N	2134	0	\N	1	N
2312	12	145	message_list	Y	2015-12-22 11:38:43	N	1777	0	\N	1	N
2725	212	145	message_list	Y	2016-01-21 12:42:00	N	2114	0	\N	1	N
2728	212	145	message_list	Y	2016-01-21 12:47:50	N	2117	0	\N	1	N
2318	12	145	message_list	Y	2015-12-22 11:47:32	N	1783	0	\N	1	N
2327	61	145	message_list	Y	2015-12-22 12:56:19	N	1792	0	\N	1	N
2459	12	145	message_list	Y	2015-12-28 00:53:45	N	1914	0	\N	1	N
2456	12	145	message_list	Y	2015-12-28 00:52:37	N	1911	0	\N	1	N
2480	61	145	message_list	Y	2015-12-28 12:41:30	N	1933	0	\N	1	N
2483	61	145	message_list	Y	2015-12-28 12:47:31	N	1936	0	\N	1	N
2387	66	144	post_management	N	2015-12-24 01:40:18	N	269		\N	1	N
2642	9	144	post_management	N	2016-01-12 13:35:51	N	280		\N	1	N
1918	30	144	post_management	N	2015-11-13 18:46:31	N	184		\N	1	N
2397	180	144	post_management	N	2015-12-24 05:41:22	N	271		\N	1	N
1920	33	144	post_management	N	2015-11-14 22:58:36	N	185		\N	1	N
2644	6	149	campus_buzz	N	2016-01-13 05:59:34	N	133		\N	1	N
2661	9	149	campus_buzz	N	2016-01-14 22:54:08	N	135		\N	1	N
2596	9	149	campus_buzz	Y	2016-01-07 07:00:03	N	120	1	\N	\N	N
2687	6	144	post_management	N	2016-01-18 12:17:44	N	287		\N	1	N
2751	212	144	post_management	N	2016-01-22 12:43:00	N	291		\N	1	N
2400	180	144	post_management	Y	2015-12-24 07:00:04	N	262	1	\N	\N	N
2693	185	144	post_management	N	2016-01-18 20:25:27	N	289		\N	1	N
2401	180	144	post_management	Y	2015-12-24 07:00:04	N	264	1	\N	\N	N
2402	180	144	post_management	Y	2015-12-24 07:00:04	N	261	1	\N	\N	N
2403	180	144	post_management	Y	2015-12-24 07:00:04	N	263	1	\N	\N	N
2667	30	145	message_list	Y	2016-01-15 01:57:49	N	2074	0	\N	1	N
2675	194	144	post_management	N	2016-01-15 22:43:12	N	282		\N	1	N
2678	194	144	post_management	N	2016-01-15 22:52:04	N	285		\N	1	N
2579	71	144	post_management	N	2016-01-05 07:00:03	N	236	1	\N	\N	N
2582	9	149	campus_buzz	N	2016-01-06 02:02:31	N	122		\N	1	N
2585	9	149	campus_buzz	N	2016-01-06 02:09:40	N	125		\N	1	N
2588	9	149	campus_buzz	N	2016-01-06 02:16:22	N	128		\N	1	N
2589	180	149	campus_buzz	N	2016-01-06 05:02:18	N	129		\N	1	N
2739	212	145	message_list	Y	2016-01-22 12:25:30	N	2128	0	\N	1	N
2752	9	145	message_list	Y	2016-01-22 12:45:56	N	2140	0	\N	1	N
2754	9	145	message_list	Y	2016-01-22 12:50:15	N	2142	0	\N	1	N
2331	12	145	message_list	Y	2015-12-22 13:04:01	N	1796	0	\N	1	N
2058	172	144	post_management	N	2015-12-15 17:05:14	N	245		\N	1	N
2061	30	144	post_management	N	2015-12-16 03:18:05	N	248		\N	1	N
2723	194	145	message_list	Y	2016-01-21 12:37:11	N	2112	0	\N	1	N
2337	12	145	message_list	Y	2015-12-22 13:08:40	N	1802	0	\N	1	N
2466	180	144	post_management	N	2015-12-28 07:00:04	N	272	1	\N	\N	N
2762	66	144	post_management	N	2016-01-23 07:00:09	N	267	1	\N	\N	N
2726	194	145	message_list	Y	2016-01-21 12:42:40	N	2115	0	\N	1	N
2289	181	144	post_management	N	2015-12-22 11:00:27	N	260		\N	1	N
2729	194	145	message_list	Y	2016-01-21 12:48:38	N	2118	0	\N	1	N
2670	194	145	message_list	Y	2016-01-15 02:00:22	N	2077	0	\N	1	N
2557	181	144	post_management	Y	2015-12-31 08:40:17	N	275	2	\N	1	N
2301	180	144	post_management	N	2015-12-22 11:07:45	N	261		\N	1	N
2310	180	144	post_management	N	2015-12-22 11:29:14	N	263		\N	1	N
2313	61	145	message_list	Y	2015-12-22 11:40:06	N	1778	0	\N	1	N
2316	61	145	message_list	Y	2015-12-22 11:41:18	N	1781	0	\N	1	N
2319	61	145	message_list	Y	2015-12-22 11:48:15	N	1784	0	\N	1	N
2457	12	145	message_list	Y	2015-12-28 00:53:05	N	1912	0	\N	1	N
2328	12	145	message_list	Y	2015-12-22 13:00:19	N	1793	0	\N	1	N
2740	194	145	message_list	Y	2016-01-22 12:26:09	N	2129	0	\N	1	N
2481	12	145	message_list	Y	2015-12-28 12:46:16	N	1934	0	\N	1	N
2743	212	145	message_list	Y	2016-01-22 12:28:46	N	2132	0	\N	1	N
2645	163	144	post_management	N	2016-01-13 07:00:04	N	240	1	\N	\N	N
2646	170	144	post_management	N	2016-01-13 07:00:04	N	241	1	\N	\N	N
2647	180	149	campus_buzz	N	2016-01-13 07:00:04	N	131	1	\N	\N	N
2569	117	144	post_management	N	2016-01-01 07:00:04	N	237	1	\N	\N	N
2398	180	144	post_management	N	2015-12-24 05:42:27	N	272		\N	1	N
2570	6	144	post_management	N	2016-01-01 07:00:04	N	274	1	\N	\N	N
2571	68	149	campus_buzz	N	2016-01-01 07:00:04	N	119	1	\N	\N	N
1967	9	144	post_management	Y	2015-11-18 02:37:48	N	208		\N	1	N
1966	9	144	post_management	Y	2015-11-18 02:35:29	N	207		\N	1	N
2465	180	144	post_management	Y	2015-12-28 07:00:04	N	271	1	\N	\N	N
2688	30	145	message_list	Y	2016-01-18 14:42:24	N	2082	0	\N	1	N
2580	9	149	campus_buzz	N	2016-01-06 01:32:50	N	120		\N	1	N
2583	9	149	campus_buzz	N	2016-01-06 02:05:48	N	123		\N	1	N
2586	9	149	campus_buzz	N	2016-01-06 02:11:10	N	126		\N	1	N
2590	180	149	campus_buzz	N	2016-01-06 05:05:02	N	130		\N	1	N
2676	194	144	post_management	N	2016-01-15 22:45:37	N	283		\N	1	N
2679	194	144	post_management	N	2016-01-15 22:54:07	N	286		\N	1	N
2753	212	145	message_list	Y	2016-01-22 12:48:14	N	2141	0	\N	1	N
2694	185	144	post_management	N	2016-01-18 20:27:40	N	290		\N	1	N
2769	180	144	post_management	N	2016-01-24 07:00:07	N	278	1	\N	\N	N
2772	182	144	post_management	N	2016-01-25 04:47:07	N	292		\N	1	N
2770	9	149	campus_buzz	Y	2016-01-24 07:00:07	N	128	1	\N	\N	N
2820	182	145	message_list	Y	2016-01-25 05:48:53	N	2204	0	\N	1	N
2822	182	145	message_list	N	2016-01-25 05:49:31	N	2206	0	\N	1	N
2824	183	145	message_list	Y	2016-01-25 05:50:35	N	2208	0	\N	1	N
2825	183	145	message_list	Y	2016-01-25 05:52:37	N	2209	0	\N	1	N
2823	183	145	message_list	Y	2016-01-25 05:50:17	N	2207	0	\N	1	N
2821	183	145	message_list	Y	2016-01-25 05:49:11	N	2205	0	\N	1	N
2819	183	145	message_list	Y	2016-01-25 05:48:36	N	2203	0	\N	1	N
2826	183	145	message_list	N	2016-01-25 05:54:09	N	2210	0	\N	1	N
2827	183	145	message_list	N	2016-01-25 05:54:45	N	2211	0	\N	1	N
2828	183	145	message_list	N	2016-01-25 06:22:43	N	2212	0	\N	1	N
2829	183	145	message_list	N	2016-01-25 06:22:59	N	2213	0	\N	1	N
2830	183	145	message_list	N	2016-01-25 06:23:13	N	2214	0	\N	1	N
2841	9	149	campus_buzz	N	2016-01-30 15:37:11	N	136		\N	1	N
2842	9	149	campus_buzz	N	2016-01-30 15:42:42	N	137		\N	1	N
2843	9	149	campus_buzz	N	2016-01-30 15:46:26	N	138		\N	1	N
2844	9	149	campus_buzz	N	2016-01-30 15:51:17	N	139		\N	1	N
2845	9	149	campus_buzz	N	2016-01-30 15:56:58	N	140		\N	1	N
2846	221	144	post_management	N	2016-02-01 02:41:36	N	293		\N	1	N
4	180	144	post_management	N	2016-02-01 13:37:13	N	2		\N	1	N
5	182	145	message_list	N	2016-02-01 13:39:18	N	3	0	\N	1	N
6	180	145	message_list	N	2016-02-01 13:40:47	N	4	0	\N	1	N
7	183	145	message_list	N	2016-02-01 14:01:14	N	5	0	\N	1	N
8	183	145	message_list	N	2016-02-02 09:09:27	N	6	0	\N	1	N
9	180	145	message_list	N	2016-02-02 09:10:14	N	7	0	\N	1	N
10	180	145	message_list	N	2016-02-02 09:10:30	N	8	0	\N	1	N
12	180	145	message_list	N	2016-02-02 09:11:29	N	10	0	\N	1	N
11	183	145	message_list	Y	2016-02-02 09:11:13	N	9	0	\N	1	N
19	9	145	message_list	Y	2016-02-02 15:28:33	N	17	0	\N	1	N
22	194	145	message_list	Y	2016-02-02 15:29:49	N	20	0	\N	1	N
13	194	145	message_list	Y	2016-02-02 12:44:57	N	11	0	\N	1	N
16	9	145	message_list	Y	2016-02-02 15:24:47	N	14	0	\N	1	N
15	9	145	message_list	Y	2016-02-02 15:24:29	N	13	0	\N	1	N
18	9	145	message_list	Y	2016-02-02 15:28:23	N	16	0	\N	1	N
14	9	145	message_list	Y	2016-02-02 15:24:11	N	12	0	\N	1	N
23	9	145	message_list	Y	2016-02-02 15:30:17	N	21	0	\N	1	N
17	194	145	message_list	Y	2016-02-02 15:25:25	N	15	0	\N	1	N
20	194	145	message_list	Y	2016-02-02 15:29:10	N	18	0	\N	1	N
21	9	145	message_list	Y	2016-02-02 15:29:38	N	19	0	\N	1	N
25	9	145	message_list	Y	2016-02-02 15:52:42	N	23	0	\N	1	N
27	9	145	message_list	Y	2016-02-02 15:54:57	N	25	0	\N	1	N
24	194	145	message_list	Y	2016-02-02 15:36:06	N	22	0	\N	1	N
28	194	145	message_list	N	2016-02-02 15:57:42	N	26	0	\N	1	N
26	194	145	message_list	Y	2016-02-02 15:54:34	N	24	0	\N	1	N
35	9	145	message_list	Y	2016-02-02 20:01:07	N	33	0	\N	1	N
29	9	145	message_list	Y	2016-02-02 19:54:48	N	27	0	\N	1	N
30	194	145	message_list	Y	2016-02-02 19:56:48	N	28	0	\N	1	N
31	9	145	message_list	Y	2016-02-02 19:57:14	N	29	0	\N	1	N
32	194	145	message_list	Y	2016-02-02 19:58:58	N	30	0	\N	1	N
33	9	145	message_list	Y	2016-02-02 19:59:18	N	31	0	\N	1	N
34	194	145	message_list	Y	2016-02-02 20:00:57	N	32	0	\N	1	N
36	9	145	message_list	Y	2016-02-02 21:56:17	N	34	0	\N	1	N
43	183	145	message_list	N	2016-02-03 04:57:48	N	41	0	\N	1	N
2840	181	144	post_management	Y	2016-01-30 07:00:07	N	275	1	\N	\N	N
37	194	145	message_list	Y	2016-02-02 22:21:27	N	35	0	\N	1	N
38	9	145	message_list	Y	2016-02-02 22:21:53	N	36	0	\N	1	N
40	9	145	message_list	Y	2016-02-03 03:19:20	N	38	0	\N	1	N
39	9	145	message_list	Y	2016-02-03 03:19:08	N	37	0	\N	1	N
42	9	145	message_list	Y	2016-02-03 03:22:04	N	40	0	\N	1	N
41	194	145	message_list	Y	2016-02-03 03:21:50	N	39	0	\N	1	N
44	180	145	message_list	Y	2016-02-03 04:58:31	N	42	0	\N	1	N
105	182	144	post_management	N	2016-02-11 06:59:57	N	301		\N	1	N
45	9	145	message_list	Y	2016-02-03 17:46:00	N	43	0	\N	1	N
46	194	145	message_list	Y	2016-02-03 17:54:24	N	44	0	\N	1	N
49	194	145	message_list	Y	2016-02-03 19:00:38	N	47	0	\N	1	N
50	9	145	message_list	Y	2016-02-03 19:15:40	N	48	0	\N	1	N
48	9	145	message_list	Y	2016-02-03 18:46:38	N	46	0	\N	1	N
47	9	145	message_list	Y	2016-02-03 18:46:11	N	45	0	\N	1	N
2839	182	144	post_management	Y	2016-01-29 07:00:07	N	292	1	\N	\N	N
51	9	145	message_list	Y	2016-02-03 19:24:45	N	49	0	\N	1	N
52	194	145	message_list	Y	2016-02-03 19:25:47	N	50	0	\N	1	N
53	207	145	message_list	Y	2016-02-04 01:32:14	N	51	0	\N	1	N
55	207	149	campus_buzz	N	2016-02-04 01:37:01	N	2		\N	1	N
54	194	145	message_list	Y	2016-02-04 01:36:07	N	52	0	\N	1	N
56	207	145	message_list	Y	2016-02-04 01:39:01	N	53	0	\N	1	N
77	9	149	campus_buzz	Y	2016-02-08 00:00:01	N	137	1	\N	\N	N
57	194	145	message_list	Y	2016-02-04 01:48:30	N	54	0	\N	1	N
107	182	145	message_list	N	2016-02-11 07:01:56	N	2232	0	\N	1	N
58	207	145	message_list	Y	2016-02-04 01:49:00	N	55	0	\N	1	N
60	194	149	campus_buzz	N	2016-02-04 01:57:10	N	3		\N	1	N
62	183	149	campus_buzz	N	2016-02-04 04:46:34	N	4		\N	1	N
63	183	149	campus_buzz	N	2016-02-04 04:48:54	N	5		\N	1	N
64	183	149	campus_buzz	N	2016-02-04 04:50:51	N	6		\N	1	N
65	183	144	post_management	N	2016-02-04 04:55:36	N	3		\N	1	N
66	\N	149	campus_buzz	N	2016-02-04 05:27:37	N	7		\N	1	N
67	194	149	campus_buzz	N	2016-02-04 13:18:39	N	8		\N	1	N
71	30	149	campus_buzz	N	2016-02-05 00:56:46	N	9		\N	1	N
72	30	149	campus_buzz	N	2016-02-05 04:19:48	N	10		\N	1	N
73	30	149	campus_buzz	N	2016-02-06 00:00:02	N	10	1	\N	\N	N
59	194	145	message_list	Y	2016-02-04 01:50:35	N	56	0	\N	1	N
70	207	149	campus_buzz	Y	2016-02-05 00:00:01	N	2	1	\N	\N	N
75	9	149	campus_buzz	N	2016-02-07 15:56:36	N	11		\N	1	N
76	9	149	campus_buzz	N	2016-02-07 16:01:10	N	12		\N	1	N
106	183	145	message_list	Y	2016-02-11 07:00:41	N	2231	0	\N	1	N
80	207	145	message_list	Y	2016-02-08 14:58:44	N	58	0	\N	1	N
61	207	145	message_list	Y	2016-02-04 04:16:31	N	57	0	\N	1	N
82	207	145	message_list	Y	2016-02-08 15:22:39	N	60	0	\N	1	N
84	9	149	campus_buzz	N	2016-02-09 01:35:02	N	13		\N	1	N
85	9	149	campus_buzz	N	2016-02-09 01:36:33	N	14		\N	1	N
86	9	149	campus_buzz	N	2016-02-09 01:41:23	N	15		\N	1	N
87	9	149	campus_buzz	N	2016-02-09 01:44:20	N	16		\N	1	N
88	30	144	post_management	N	2016-02-10 14:08:19	N	4		\N	1	N
89	180	144	post_management	N	2016-02-10 14:33:57	N	5		\N	1	N
90	180	149	campus_buzz	N	2016-02-10 14:34:33	N	17		\N	1	N
91	180	145	message_list	N	2016-02-10 14:34:47	N	62	0	\N	1	N
92	9	144	post_management	N	2016-02-11 00:38:38	N	6		\N	1	N
93	9	144	post_management	N	2016-02-11 00:41:40	N	7		\N	1	N
94	9	144	post_management	N	2016-02-11 00:45:09	N	8		\N	1	N
95	9	144	post_management	N	2016-02-11 00:49:22	N	9		\N	1	N
96	9	144	post_management	N	2016-02-11 00:52:48	N	10		\N	1	N
97	9	144	post_management	N	2016-02-11 00:56:26	N	11		\N	1	N
98	9	144	post_management	N	2016-02-11 00:58:18	N	12		\N	1	N
99	9	144	post_management	N	2016-02-11 01:03:10	N	13		\N	1	N
100	9	144	post_management	N	2016-02-11 01:05:35	N	14		\N	1	N
101	9	144	post_management	N	2016-02-11 01:08:46	N	15		\N	1	N
102	9	144	post_management	N	2016-02-11 01:11:23	N	16		\N	1	N
103	9	144	post_management	N	2016-02-11 01:15:04	N	17		\N	1	N
104	194	144	post_management	N	2016-02-11 01:34:52	N	18		\N	1	N
108	183	145	message_list	Y	2016-02-11 07:02:24	N	2233	0	\N	1	N
109	182	149	campus_buzz	N	2016-02-11 07:14:45	N	151		\N	1	N
110	180	144	post_management	N	2016-02-11 08:46:21	N	302		\N	1	N
111	180	144	post_management	N	2016-02-11 08:48:19	N	303		\N	1	N
112	180	144	post_management	N	2016-02-11 10:30:04	N	304		\N	1	N
113	180	149	campus_buzz	N	2016-02-11 10:30:09	N	152		\N	1	N
114	180	149	campus_buzz	N	2016-02-11 10:31:32	N	153		\N	1	N
115	180	149	campus_buzz	N	2016-02-11 10:33:05	N	154		\N	1	N
116	194	144	post_management	N	2016-02-11 11:56:56	N	305		\N	1	N
117	194	149	campus_buzz	N	2016-02-11 12:00:22	N	155		\N	1	N
118	194	149	campus_buzz	N	2016-02-11 12:04:52	N	156		\N	1	N
119	30	149	campus_buzz	N	2016-02-11 13:24:43	N	157		\N	1	N
120	30	149	campus_buzz	N	2016-02-11 13:33:53	N	158		\N	1	N
121	194	149	campus_buzz	N	2016-02-11 14:08:31	N	159		\N	1	N
122	194	144	post_management	N	2016-02-11 14:09:23	N	306		\N	1	N
123	194	144	post_management	N	2016-02-11 14:36:02	N	307		\N	1	N
124	194	144	post_management	N	2016-02-11 14:37:30	N	308		\N	1	N
125	194	144	post_management	N	2016-02-11 14:41:58	N	309		\N	1	N
126	194	144	post_management	N	2016-02-11 14:57:30	N	310		\N	1	N
127	194	144	post_management	N	2016-02-11 14:59:37	N	311		\N	1	N
78	9	149	campus_buzz	Y	2016-02-08 00:00:01	N	11	1	\N	\N	N
79	9	149	campus_buzz	Y	2016-02-08 00:00:01	N	12	1	\N	\N	N
68	9	149	campus_buzz	Y	2016-02-05 00:00:01	N	140	1	\N	\N	N
69	9	149	campus_buzz	Y	2016-02-05 00:00:01	N	121	1	\N	\N	N
83	194	145	message_list	Y	2016-02-08 15:23:19	N	61	0	\N	1	N
81	194	145	message_list	Y	2016-02-08 15:00:11	N	59	0	\N	1	N
74	30	149	campus_buzz	Y	2016-02-07 00:00:01	N	9	1	\N	\N	N
128	66	149	campus_buzz	N	2016-02-11 18:21:08	N	160		\N	1	N
135	180	149	campus_buzz	N	2016-02-12 00:00:01	N	153	1	\N	\N	N
132	9	145	message_list	Y	2016-02-11 22:00:39	N	2237	0	\N	1	N
131	9	145	message_list	Y	2016-02-11 21:58:45	N	2236	0	\N	1	N
129	9	145	message_list	Y	2016-02-11 21:49:06	N	2234	0	\N	1	N
137	194	144	post_management	N	2016-02-12 01:01:24	N	312		\N	1	N
133	9	144	post_management	Y	2016-02-12 00:00:01	N	280	1	\N	\N	N
134	9	144	post_management	Y	2016-02-12 00:00:01	N	279	1	\N	\N	N
136	194	145	message_list	Y	2016-02-12 00:01:44	N	2238	0	\N	1	N
186	9	145	message_list	Y	2016-02-16 16:50:10	N	2266	0	\N	1	N
130	194	145	message_list	Y	2016-02-11 21:58:20	N	2235	0	\N	1	N
138	9	145	message_list	Y	2016-02-12 02:57:16	N	2239	0	\N	1	N
159	207	145	message_list	Y	2016-02-12 16:06:39	N	2259	0	\N	1	N
160	207	145	message_list	Y	2016-02-12 16:07:08	N	2260	0	\N	1	N
140	9	145	message_list	Y	2016-02-12 02:59:22	N	2241	0	\N	1	N
139	194	145	message_list	Y	2016-02-12 02:58:26	N	2240	0	\N	1	N
158	194	145	message_list	Y	2016-02-12 16:05:59	N	2258	0	\N	1	N
155	194	145	message_list	Y	2016-02-12 16:00:43	N	2255	0	\N	1	N
162	207	145	message_list	Y	2016-02-12 16:07:23	N	2262	0	\N	1	N
142	194	145	message_list	Y	2016-02-12 03:00:26	N	2243	0	\N	1	N
163	180	144	post_management	N	2016-02-13 00:00:01	N	304	1	\N	\N	N
144	9	145	message_list	Y	2016-02-12 03:01:06	N	2245	0	\N	1	N
141	9	145	message_list	Y	2016-02-12 02:59:35	N	2242	0	\N	1	N
143	9	145	message_list	Y	2016-02-12 03:00:53	N	2244	0	\N	1	N
145	194	145	message_list	Y	2016-02-12 03:01:48	N	2246	0	\N	1	N
146	9	145	message_list	Y	2016-02-12 03:02:43	N	2247	0	\N	1	N
166	207	149	campus_buzz	N	2016-02-13 00:00:01	N	161	1	\N	\N	N
147	194	145	message_list	Y	2016-02-12 03:07:12	N	2248	0	\N	1	N
167	330	144	post_management	N	2016-02-13 20:44:18	N	313		\N	1	N
148	9	145	message_list	Y	2016-02-12 03:23:42	N	2249	0	\N	1	N
149	194	145	message_list	Y	2016-02-12 03:24:07	N	2250	0	\N	1	N
151	207	145	message_list	Y	2016-02-12 15:45:12	N	2252	0	\N	1	N
150	194	145	message_list	Y	2016-02-12 15:37:42	N	2251	0	\N	1	N
152	194	145	message_list	Y	2016-02-12 15:49:20	N	2253	0	\N	1	N
154	207	149	campus_buzz	N	2016-02-12 15:58:49	N	161		\N	1	N
153	207	145	message_list	Y	2016-02-12 15:55:13	N	2254	0	\N	1	N
171	194	149	campus_buzz	N	2016-02-14 01:16:02	N	162		\N	1	N
157	207	145	message_list	Y	2016-02-12 16:03:47	N	2257	0	\N	1	N
172	194	149	campus_buzz	N	2016-02-14 01:18:42	N	163		\N	1	N
156	207	145	message_list	Y	2016-02-12 16:03:41	N	2256	0	\N	1	N
173	194	149	campus_buzz	N	2016-02-14 01:20:46	N	164		\N	1	N
175	194	144	post_management	Y	2016-02-15 00:00:01	N	284	1	\N	\N	N
176	194	144	post_management	Y	2016-02-15 00:00:01	N	285	1	\N	\N	N
161	194	145	message_list	N	2016-02-12 16:07:09	N	2261	0	\N	1	N
179	207	149	campus_buzz	N	2016-02-16 01:11:38	N	165		\N	1	N
180	349	145	message_list	N	2016-02-16 05:18:54	N	2263	0	\N	1	N
181	30	149	campus_buzz	N	2016-02-16 13:29:35	N	166		\N	1	N
182	30	149	campus_buzz	N	2016-02-16 13:33:11	N	167		\N	1	N
183	9	149	campus_buzz	N	2016-02-16 16:25:51	N	168		\N	1	N
174	194	144	post_management	Y	2016-02-15 00:00:01	N	282	1	\N	\N	N
184	9	145	message_list	Y	2016-02-16 16:26:46	N	2264	0	\N	1	N
177	194	144	post_management	Y	2016-02-15 00:00:01	N	283	1	\N	\N	N
164	194	144	post_management	Y	2016-02-13 00:00:01	N	286	1	\N	\N	N
185	194	145	message_list	Y	2016-02-16 16:49:36	N	2265	0	\N	1	N
187	9	145	message_list	Y	2016-02-16 16:50:20	N	2267	0	\N	1	N
165	9	149	campus_buzz	Y	2016-02-13 00:00:01	N	13	1	\N	\N	N
170	9	149	campus_buzz	Y	2016-02-14 00:00:01	N	16	1	\N	\N	N
169	9	149	campus_buzz	Y	2016-02-14 00:00:01	N	15	1	\N	\N	N
168	9	149	campus_buzz	Y	2016-02-14 00:00:01	N	14	1	\N	\N	N
178	194	149	campus_buzz	Y	2016-02-16 00:00:01	N	163	1	\N	\N	N
192	194	145	message_list	Y	2016-02-16 17:17:06	N	2272	0	\N	1	N
189	9	145	message_list	Y	2016-02-16 16:50:57	N	2269	0	\N	1	N
188	194	145	message_list	Y	2016-02-16 16:50:54	N	2268	0	\N	1	N
194	30	144	post_management	N	2016-02-16 18:18:29	N	314		\N	1	N
190	9	145	message_list	Y	2016-02-16 16:56:49	N	2270	0	\N	1	N
195	30	144	post_management	N	2016-02-16 18:19:52	N	315		\N	1	N
191	194	145	message_list	Y	2016-02-16 16:57:50	N	2271	0	\N	1	N
193	9	145	message_list	Y	2016-02-16 17:17:07	N	2273	0	\N	1	N
196	30	144	post_management	N	2016-02-16 18:21:48	N	316		\N	1	N
197	30	144	post_management	N	2016-02-16 18:23:41	N	317		\N	1	N
198	66	149	campus_buzz	N	2016-02-17 00:00:01	N	160	1	\N	\N	N
200	359	144	post_management	N	2016-02-17 16:28:28	N	318		\N	1	N
201	373	144	post_management	N	2016-02-17 23:41:00	N	319		\N	1	N
202	185	144	post_management	N	2016-02-18 00:00:01	N	289	1	\N	\N	N
203	185	144	post_management	N	2016-02-18 00:00:01	N	288	1	\N	\N	N
204	185	144	post_management	N	2016-02-18 00:00:01	N	290	1	\N	\N	N
205	330	145	message_list	N	2016-02-18 16:22:57	N	2274	0	\N	1	N
199	9	149	campus_buzz	Y	2016-02-17 00:00:01	N	168	1	\N	\N	N
207	194	145	message_list	Y	2016-02-18 23:24:19	N	2276	0	\N	1	N
208	194	149	campus_buzz	N	2016-02-19 00:00:01	N	164	1	\N	\N	N
209	9	149	campus_buzz	N	2016-02-19 15:29:47	N	169		\N	1	N
210	9	149	campus_buzz	N	2016-02-19 15:35:22	N	170		\N	1	N
211	194	149	campus_buzz	N	2016-02-20 00:00:01	N	162	1	\N	\N	N
213	221	144	post_management	N	2016-02-21 00:00:01	N	293	1	\N	\N	N
212	9	149	campus_buzz	Y	2016-02-20 00:00:01	N	169	1	\N	\N	N
214	30	149	campus_buzz	N	2016-02-21 00:00:01	N	167	1	\N	\N	N
215	30	149	campus_buzz	N	2016-02-22 00:00:01	N	166	1	\N	\N	N
217	66	149	campus_buzz	N	2016-02-22 17:49:10	N	171		\N	1	N
218	194	149	campus_buzz	N	2016-02-22 18:41:48	N	172		\N	1	N
219	380	144	post_management	N	2016-02-22 21:39:06	N	320		\N	1	N
220	382	144	post_management	N	2016-02-23 18:59:53	N	321		\N	1	N
221	9	149	campus_buzz	N	2016-02-23 19:55:32	N	173		\N	1	N
222	180	149	campus_buzz	N	2016-02-24 06:14:07	N	174		\N	1	N
223	180	149	campus_buzz	N	2016-02-24 06:41:16	N	175		\N	1	N
224	194	149	campus_buzz	N	2016-02-24 12:45:07	N	176		\N	1	N
225	9	149	campus_buzz	N	2016-02-24 14:17:03	N	177		\N	1	N
206	9	145	message_list	Y	2016-02-18 22:48:18	N	2275	0	\N	1	N
249	9	145	message_list	Y	2016-02-24 17:04:10	N	2300	0	\N	1	N
226	9	145	message_list	Y	2016-02-24 14:18:34	N	2277	0	\N	1	N
271	194	149	campus_buzz	N	2016-03-01 16:05:42	N	179		\N	1	N
243	9	145	message_list	Y	2016-02-24 15:24:54	N	2294	0	\N	1	N
227	194	145	message_list	Y	2016-02-24 14:25:26	N	2278	0	\N	1	N
216	9	149	campus_buzz	Y	2016-02-22 00:00:01	N	170	1	\N	\N	N
229	9	145	message_list	Y	2016-02-24 14:27:46	N	2280	0	\N	1	N
248	9	145	message_list	Y	2016-02-24 17:04:00	N	2299	0	\N	1	N
228	9	145	message_list	Y	2016-02-24 14:27:27	N	2279	0	\N	1	N
246	9	145	message_list	Y	2016-02-24 17:02:00	N	2297	0	\N	1	N
230	194	145	message_list	Y	2016-02-24 14:33:59	N	2281	0	\N	1	N
231	9	145	message_list	Y	2016-02-24 14:38:17	N	2282	0	\N	1	N
272	194	149	campus_buzz	N	2016-03-01 16:07:41	N	180		\N	1	N
232	194	145	message_list	Y	2016-02-24 14:38:38	N	2283	0	\N	1	N
234	194	145	message_list	Y	2016-02-24 14:41:07	N	2285	0	\N	1	N
250	194	145	message_list	Y	2016-02-24 17:04:41	N	2301	0	\N	1	N
235	194	145	message_list	Y	2016-02-24 15:12:38	N	2286	0	\N	1	N
252	9	145	message_list	Y	2016-02-24 17:07:12	N	2303	0	\N	1	N
273	194	149	campus_buzz	N	2016-03-01 16:09:08	N	181		\N	1	N
238	194	145	message_list	Y	2016-02-24 15:21:12	N	2289	0	\N	1	N
241	9	145	message_list	Y	2016-02-24 15:21:54	N	2292	0	\N	1	N
240	9	145	message_list	Y	2016-02-24 15:21:49	N	2291	0	\N	1	N
237	9	145	message_list	Y	2016-02-24 15:15:36	N	2288	0	\N	1	N
239	9	145	message_list	Y	2016-02-24 15:21:36	N	2290	0	\N	1	N
233	9	145	message_list	Y	2016-02-24 14:40:35	N	2284	0	\N	1	N
251	9	145	message_list	Y	2016-02-24 17:07:00	N	2302	0	\N	1	N
236	9	145	message_list	Y	2016-02-24 15:15:26	N	2287	0	\N	1	N
242	194	145	message_list	Y	2016-02-24 15:24:15	N	2293	0	\N	1	N
253	194	145	message_list	Y	2016-02-24 17:20:42	N	2304	0	\N	1	N
245	9	145	message_list	Y	2016-02-24 17:01:38	N	2296	0	\N	1	N
244	194	145	message_list	Y	2016-02-24 16:59:51	N	2295	0	\N	1	N
275	9	145	message_list	Y	2016-03-01 19:12:10	N	2315	0	\N	1	N
254	9	145	message_list	Y	2016-02-24 17:22:16	N	2305	0	\N	1	N
247	194	145	message_list	Y	2016-02-24 17:02:26	N	2298	0	\N	1	N
265	194	145	message_list	Y	2016-02-26 17:22:40	N	2312	0	\N	1	N
255	194	145	message_list	Y	2016-02-24 17:26:54	N	2306	0	\N	1	N
256	9	145	message_list	Y	2016-02-24 17:27:21	N	2307	0	\N	1	N
257	180	149	campus_buzz	N	2016-02-25 00:00:01	N	175	1	\N	\N	N
258	194	149	campus_buzz	N	2016-02-25 11:57:48	N	178		\N	1	N
259	207	149	campus_buzz	N	2016-02-26 00:00:01	N	165	1	\N	\N	N
261	30	145	message_list	N	2016-02-26 16:32:23	N	2308	0	\N	1	N
260	9	149	campus_buzz	Y	2016-02-26 00:00:01	N	177	1	\N	\N	N
263	194	145	message_list	Y	2016-02-26 17:11:32	N	2310	0	\N	1	N
264	9	145	message_list	Y	2016-02-26 17:12:01	N	2311	0	\N	1	N
262	9	145	message_list	Y	2016-02-26 16:37:32	N	2309	0	\N	1	N
268	180	149	campus_buzz	N	2016-02-28 00:00:01	N	174	1	\N	\N	N
270	66	149	campus_buzz	N	2016-02-29 00:00:01	N	171	1	\N	\N	N
267	9	149	campus_buzz	Y	2016-02-28 00:00:01	N	173	1	\N	\N	N
274	9	145	message_list	Y	2016-03-01 19:11:50	N	2314	0	\N	1	N
277	194	145	message_list	Y	2016-03-01 19:16:22	N	2317	0	\N	1	N
269	194	149	campus_buzz	Y	2016-02-28 00:00:01	N	178	1	\N	\N	N
276	194	145	message_list	Y	2016-03-01 19:16:14	N	2316	0	\N	1	N
266	194	145	message_list	Y	2016-02-26 17:22:48	N	2313	0	\N	1	N
278	9	145	message_list	Y	2016-03-01 19:16:57	N	2318	0	\N	1	N
281	9	145	message_list	Y	2016-03-01 19:19:51	N	2321	0	\N	1	N
289	194	149	campus_buzz	N	2016-03-04 00:00:01	N	181	1	\N	\N	N
279	9	145	message_list	Y	2016-03-01 19:17:08	N	2319	0	\N	1	N
280	194	145	message_list	Y	2016-03-01 19:17:20	N	2320	0	\N	1	N
283	194	145	message_list	Y	2016-03-01 19:27:29	N	2323	0	\N	1	N
282	9	145	message_list	Y	2016-03-01 19:27:02	N	2322	0	\N	1	N
284	9	145	message_list	Y	2016-03-01 19:30:18	N	2324	0	\N	1	N
285	180	144	post_management	N	2016-03-02 00:00:01	N	2	1	\N	\N	N
286	194	149	campus_buzz	N	2016-03-02 00:00:01	N	179	1	\N	\N	N
287	194	149	campus_buzz	N	2016-03-02 00:00:01	N	180	1	\N	\N	N
288	359	144	post_management	N	2016-03-03 00:00:01	N	318	1	\N	\N	N
290	183	144	post_management	N	2016-03-05 00:00:02	N	3	1	\N	\N	N
291	183	149	campus_buzz	N	2016-03-05 00:00:02	N	6	1	\N	\N	N
292	180	144	post_management	N	2016-03-11 00:00:01	N	5	1	\N	\N	N
293	182	144	post_management	N	2016-03-11 00:00:01	N	301	1	\N	\N	N
295	180	149	campus_buzz	N	2016-03-11 00:00:01	N	17	1	\N	\N	N
296	182	149	campus_buzz	N	2016-03-11 00:00:01	N	151	1	\N	\N	N
298	9	144	post_management	Y	2016-03-12 00:00:01	N	7	1	\N	\N	N
294	30	144	post_management	Y	2016-03-11 00:00:01	N	4	1	\N	\N	N
303	180	144	post_management	N	2016-03-12 00:00:01	N	302	1	\N	\N	N
304	180	144	post_management	N	2016-03-12 00:00:01	N	303	1	\N	\N	N
309	194	144	post_management	N	2016-03-12 00:00:01	N	308	1	\N	\N	N
310	194	144	post_management	N	2016-03-12 00:00:01	N	309	1	\N	\N	N
311	194	144	post_management	N	2016-03-12 00:00:01	N	311	1	\N	\N	N
312	180	149	campus_buzz	N	2016-03-12 00:00:01	N	154	1	\N	\N	N
313	30	149	campus_buzz	N	2016-03-12 00:00:01	N	158	1	\N	\N	N
316	194	144	post_management	N	2016-03-13 00:00:01	N	312	1	\N	\N	N
317	180	149	campus_buzz	N	2016-03-13 00:00:01	N	152	1	\N	\N	N
318	30	149	campus_buzz	N	2016-03-13 00:00:01	N	157	1	\N	\N	N
319	397	144	post_management	N	2016-03-13 06:13:27	N	322		\N	1	N
320	330	144	post_management	N	2016-03-14 00:00:01	N	313	1	\N	\N	N
321	194	149	campus_buzz	N	2016-03-14 12:46:46	N	182		\N	1	N
322	194	149	campus_buzz	N	2016-03-14 12:48:51	N	183		\N	1	N
323	194	149	campus_buzz	N	2016-03-14 12:49:37	N	184		\N	1	N
324	194	149	campus_buzz	N	2016-03-14 12:56:56	N	185		\N	1	N
325	194	149	campus_buzz	N	2016-03-14 12:59:11	N	186		\N	1	N
326	194	144	post_management	N	2016-03-14 13:46:33	N	323		\N	1	N
327	194	144	post_management	N	2016-03-14 13:47:59	N	324		\N	1	N
328	194	144	post_management	N	2016-03-14 13:49:18	N	325		\N	1	N
329	194	144	post_management	N	2016-03-14 13:50:23	N	326		\N	1	N
330	194	144	post_management	N	2016-03-14 13:51:46	N	327		\N	1	N
331	194	149	campus_buzz	N	2016-03-14 15:29:07	N	187		\N	1	N
332	194	149	campus_buzz	N	2016-03-14 17:10:39	N	188		\N	1	N
333	194	149	campus_buzz	N	2016-03-14 17:16:37	N	189		\N	1	N
334	337	145	message_list	N	2016-03-14 21:01:26	N	2325	0	\N	1	N
335	182	144	post_management	N	2016-03-15 12:14:47	N	328		\N	1	N
336	180	145	message_list	N	2016-03-15 12:17:01	N	2326	0	\N	1	N
337	180	145	message_list	N	2016-03-15 12:46:09	N	2327	0	\N	1	N
338	180	145	message_list	N	2016-03-15 12:47:40	N	2328	0	\N	1	N
339	180	149	campus_buzz	N	2016-03-15 12:49:57	N	190		\N	1	N
340	180	145	message_list	N	2016-03-15 12:51:53	N	2329	0	\N	1	N
341	180	145	message_list	N	2016-03-15 12:53:10	N	2330	0	\N	1	N
342	180	145	message_list	N	2016-03-15 12:54:46	N	2331	0	\N	1	N
343	180	145	message_list	N	2016-03-15 13:00:11	N	2332	0	\N	1	N
344	407	144	post_management	N	2016-03-15 23:04:00	N	329		\N	1	N
345	407	144	post_management	N	2016-03-15 23:06:44	N	330		\N	1	N
347	382	144	post_management	N	2016-03-16 00:00:01	N	321	1	\N	\N	N
348	181	144	post_management	N	2016-03-16 05:07:48	N	331		\N	1	N
349	194	145	message_list	N	2016-03-16 05:08:18	N	2333	0	\N	1	N
350	194	145	message_list	N	2016-03-16 05:09:12	N	2334	0	\N	1	N
352	194	144	post_management	N	2016-03-16 05:11:56	N	332		\N	1	N
353	181	145	message_list	N	2016-03-16 05:12:28	N	2336	0	\N	1	N
354	181	145	message_list	N	2016-03-16 05:12:42	N	2337	0	\N	1	N
355	181	145	message_list	N	2016-03-16 05:17:14	N	2338	0	\N	1	N
356	194	145	message_list	N	2016-03-16 05:21:09	N	2339	0	\N	1	N
357	194	145	message_list	N	2016-03-16 05:23:35	N	2340	0	\N	1	N
359	181	145	message_list	N	2016-03-16 05:26:32	N	2342	0	\N	1	N
360	181	145	message_list	N	2016-03-16 05:32:06	N	2343	0	\N	1	N
361	181	145	message_list	N	2016-03-16 05:32:46	N	2344	0	\N	1	N
362	181	145	message_list	N	2016-03-16 05:36:43	N	2345	0	\N	1	N
363	181	145	message_list	N	2016-03-16 05:40:02	N	2346	0	\N	1	N
364	181	145	message_list	N	2016-03-16 05:48:12	N	2347	0	\N	1	N
365	181	145	message_list	N	2016-03-16 05:51:41	N	2348	0	\N	1	N
366	181	145	message_list	N	2016-03-16 05:52:48	N	2349	0	\N	1	N
367	181	145	message_list	N	2016-03-16 05:52:54	N	2350	0	\N	1	N
368	181	145	message_list	N	2016-03-16 05:52:59	N	2351	0	\N	1	N
369	181	145	message_list	N	2016-03-16 05:53:12	N	2352	0	\N	1	N
370	181	145	message_list	N	2016-03-16 05:55:11	N	2353	0	\N	1	N
371	181	145	message_list	N	2016-03-16 05:55:55	N	2354	0	\N	1	N
372	181	145	message_list	N	2016-03-16 06:08:51	N	2355	0	\N	1	N
373	181	145	message_list	N	2016-03-16 06:19:46	N	2356	0	\N	1	N
374	181	145	message_list	N	2016-03-16 06:20:10	N	2357	0	\N	1	N
375	181	145	message_list	N	2016-03-16 06:20:17	N	2358	0	\N	1	N
376	181	145	message_list	N	2016-03-16 06:20:27	N	2359	0	\N	1	N
377	181	145	message_list	N	2016-03-16 06:20:36	N	2360	0	\N	1	N
378	181	145	message_list	N	2016-03-16 06:20:59	N	2361	0	\N	1	N
379	181	145	message_list	N	2016-03-16 06:23:31	N	2362	0	\N	1	N
380	194	145	message_list	N	2016-03-16 06:27:32	N	2363	0	\N	1	N
381	194	144	post_management	N	2016-03-16 06:29:42	N	333		\N	1	N
382	181	145	message_list	N	2016-03-16 06:30:56	N	2364	0	\N	1	N
383	181	145	message_list	N	2016-03-16 06:32:36	N	2365	0	\N	1	N
384	181	145	message_list	N	2016-03-16 06:33:43	N	2366	0	\N	1	N
385	181	145	message_list	N	2016-03-16 06:35:59	N	2367	0	\N	1	N
386	181	145	message_list	N	2016-03-16 06:38:49	N	2368	0	\N	1	N
358	181	145	message_list	Y	2016-03-16 05:24:37	N	2341	0	\N	1	N
351	181	145	message_list	Y	2016-03-16 05:09:41	N	2335	0	\N	1	N
346	194	144	post_management	Y	2016-03-16 00:00:01	N	18	1	\N	\N	N
315	9	144	post_management	Y	2016-03-13 00:00:01	N	16	1	\N	\N	N
299	9	144	post_management	Y	2016-03-12 00:00:01	N	8	1	\N	\N	N
301	9	144	post_management	Y	2016-03-12 00:00:01	N	11	1	\N	\N	N
302	9	144	post_management	Y	2016-03-12 00:00:01	N	12	1	\N	\N	N
300	9	144	post_management	Y	2016-03-12 00:00:01	N	9	1	\N	\N	N
306	9	144	post_management	Y	2016-03-12 00:00:01	N	14	1	\N	\N	N
305	9	144	post_management	Y	2016-03-12 00:00:01	N	13	1	\N	\N	N
307	9	144	post_management	Y	2016-03-12 00:00:01	N	10	1	\N	\N	N
308	9	144	post_management	Y	2016-03-12 00:00:01	N	15	1	\N	\N	N
387	181	145	message_list	Y	2016-03-16 06:39:13	N	2369	0	\N	1	N
388	194	145	message_list	N	2016-03-16 06:40:38	N	2370	0	\N	1	N
389	181	145	message_list	N	2016-03-16 06:44:25	N	2371	0	\N	1	N
392	194	145	message_list	N	2016-03-16 06:48:32	N	2374	0	\N	1	N
393	194	145	message_list	N	2016-03-16 06:49:49	N	2375	0	\N	1	N
390	181	145	message_list	N	2016-03-16 06:44:40	N	2372	0	\N	1	N
391	181	145	message_list	N	2016-03-16 06:44:55	N	2373	0	\N	1	N
394	180	145	message_list	N	2016-03-16 06:50:33	N	2376	0	\N	1	N
398	30	144	post_management	N	2016-03-17 00:00:01	N	314	1	\N	\N	N
399	30	144	post_management	N	2016-03-17 00:00:01	N	315	1	\N	\N	N
400	30	144	post_management	N	2016-03-17 00:00:01	N	316	1	\N	\N	N
401	30	144	post_management	N	2016-03-17 00:00:01	N	317	1	\N	\N	N
404	373	144	post_management	N	2016-03-19 00:00:01	N	319	1	\N	\N	N
407	194	149	campus_buzz	N	2016-03-19 18:14:29	N	191		\N	1	N
408	194	149	campus_buzz	N	2016-03-19 18:16:19	N	192		\N	1	N
409	194	149	campus_buzz	N	2016-03-19 18:17:44	N	193		\N	1	N
410	194	149	campus_buzz	N	2016-03-19 18:19:07	N	194		\N	1	N
411	194	149	campus_buzz	N	2016-03-19 18:20:43	N	195		\N	1	N
414	194	149	campus_buzz	N	2016-03-22 01:21:42	N	196		\N	1	N
415	380	144	post_management	N	2016-03-23 00:00:01	N	320	1	\N	\N	N
314	9	144	post_management	Y	2016-03-13 00:00:01	N	17	1	\N	\N	N
412	194	149	campus_buzz	Y	2016-03-20 00:00:01	N	185	1	\N	\N	N
416	9	145	message_list	Y	2016-03-23 20:38:37	N	2377	0	\N	1	N
406	194	149	campus_buzz	Y	2016-03-19 00:00:01	N	184	1	\N	\N	N
405	194	149	campus_buzz	Y	2016-03-19 00:00:01	N	183	1	\N	\N	N
403	194	149	campus_buzz	Y	2016-03-17 00:00:01	N	182	1	\N	\N	N
397	194	144	post_management	Y	2016-03-17 00:00:01	N	283	1	\N	\N	N
396	194	144	post_management	Y	2016-03-17 00:00:01	N	285	1	\N	\N	N
413	194	149	campus_buzz	Y	2016-03-20 00:00:01	N	186	1	\N	\N	N
402	194	144	post_management	Y	2016-03-17 00:00:01	N	333	1	\N	\N	N
395	194	144	post_management	Y	2016-03-17 00:00:01	N	284	1	\N	\N	N
418	194	149	campus_buzz	N	2016-03-24 00:00:01	N	187	1	\N	\N	N
419	437	144	post_management	N	2016-03-24 01:24:24	N	334		\N	1	N
420	437	144	post_management	N	2016-03-24 01:26:20	N	335		\N	1	N
417	194	145	message_list	Y	2016-03-23 20:43:56	N	2378	0	\N	1	N
422	9	144	post_management	N	2016-03-25 00:38:06	N	336		\N	1	N
423	9	144	post_management	N	2016-03-25 00:42:12	N	337		\N	1	N
424	9	144	post_management	N	2016-03-25 00:44:22	N	338		\N	1	N
425	9	144	post_management	N	2016-03-25 00:47:32	N	339		\N	1	N
426	194	144	post_management	N	2016-03-25 02:07:18	N	340		\N	1	N
427	194	144	post_management	N	2016-03-25 02:10:30	N	341		\N	1	N
428	194	144	post_management	N	2016-03-25 02:12:21	N	342		\N	1	N
429	194	144	post_management	N	2016-03-25 02:13:55	N	343		\N	1	N
430	194	144	post_management	N	2016-03-25 02:15:18	N	344		\N	1	N
431	194	144	post_management	N	2016-03-25 02:18:46	N	345		\N	1	N
432	66	149	campus_buzz	N	2016-03-25 16:45:20	N	197		\N	1	N
433	66	149	campus_buzz	N	2016-03-26 00:00:01	N	197	1	\N	\N	N
434	9	149	campus_buzz	N	2016-03-28 14:10:01	N	198		\N	1	N
435	9	149	campus_buzz	N	2016-03-28 14:11:18	N	199		\N	1	N
421	9	145	message_list	Y	2016-03-24 14:12:25	N	2379	0	\N	1	N
438	194	149	campus_buzz	N	2016-03-29 11:56:02	N	200		\N	1	N
439	444	145	message_list	N	2016-03-29 13:43:37	N	2381	0	\N	1	N
437	194	149	campus_buzz	Y	2016-03-29 00:00:01	N	195	1	\N	\N	N
441	9	145	message_list	Y	2016-03-29 21:45:50	N	2383	0	\N	1	N
440	9	145	message_list	Y	2016-03-29 21:45:26	N	2382	0	\N	1	N
447	\N	149	campus_buzz	N	2016-03-31 15:41:26	N	201		\N	1	N
448	9	149	campus_buzz	N	2016-03-31 15:55:19	N	202		\N	1	N
449	9	149	campus_buzz	N	2016-03-31 15:59:03	N	203		\N	1	N
450	9	149	campus_buzz	N	2016-03-31 16:07:30	N	204		\N	1	N
445	9	149	campus_buzz	Y	2016-03-30 00:00:01	N	198	1	\N	\N	N
297	9	144	post_management	Y	2016-03-12 00:00:01	N	6	1	\N	\N	N
443	194	145	message_list	Y	2016-03-29 22:12:23	N	2385	0	\N	1	N
442	194	145	message_list	Y	2016-03-29 22:12:10	N	2384	0	\N	1	N
436	194	145	message_list	Y	2016-03-28 22:05:48	N	2380	0	\N	1	N
452	194	145	message_list	Y	2016-03-31 18:57:41	N	2387	0	\N	1	N
453	0	149	campus_buzz	N	2016-04-01 00:00:01	N	201	1	\N	\N	N
458	181	144	post_management	N	2016-04-02 13:18:25	N	346		\N	1	N
459	181	149	campus_buzz	N	2016-04-02 13:20:22	N	205		\N	1	N
461	181	144	post_management	N	2016-04-04 08:57:10	N	347		\N	1	N
462	181	149	campus_buzz	N	2016-04-04 08:58:26	N	206		\N	1	N
463	181	149	campus_buzz	N	2016-04-05 00:00:01	N	205	1	\N	\N	N
464	30	144	post_management	N	2016-04-05 19:58:54	N	348		\N	1	N
465	9	149	campus_buzz	N	2016-04-05 22:35:29	N	207		\N	1	N
466	9	149	campus_buzz	N	2016-04-05 22:42:30	N	208		\N	1	N
467	9	149	campus_buzz	N	2016-04-05 22:44:33	N	209		\N	1	N
455	194	149	campus_buzz	Y	2016-04-01 00:00:01	N	194	1	\N	\N	N
444	194	149	campus_buzz	Y	2016-03-30 00:00:01	N	188	1	\N	\N	N
451	9	145	message_list	Y	2016-03-31 18:53:46	N	2386	0	\N	1	N
446	194	149	campus_buzz	Y	2016-03-31 00:00:01	N	189	1	\N	\N	N
457	9	149	campus_buzz	Y	2016-04-02 00:00:01	N	204	1	\N	\N	N
454	9	149	campus_buzz	Y	2016-04-01 00:00:01	N	203	1	\N	\N	N
456	9	149	campus_buzz	Y	2016-04-01 00:00:01	N	199	1	\N	\N	N
460	9	149	campus_buzz	Y	2016-04-03 00:00:01	N	202	1	\N	\N	N
469	458	144	post_management	N	2016-04-06 13:54:43	N	349		\N	1	N
470	458	144	post_management	N	2016-04-06 13:55:41	N	350		\N	1	N
471	458	144	post_management	N	2016-04-06 13:56:27	N	351		\N	1	N
472	458	144	post_management	N	2016-04-06 13:57:55	N	352		\N	1	N
473	458	144	post_management	N	2016-04-06 13:58:50	N	353		\N	1	N
474	458	144	post_management	N	2016-04-06 14:01:48	N	354		\N	1	N
475	458	144	post_management	N	2016-04-06 14:02:29	N	355		\N	1	N
476	458	144	post_management	N	2016-04-06 14:05:37	N	356		\N	1	N
468	9	149	campus_buzz	Y	2016-04-06 00:00:01	N	207	1	\N	\N	N
477	458	144	post_management	N	2016-04-06 14:06:31	N	357		\N	1	N
478	181	144	post_management	N	2016-04-08 10:34:32	N	358		\N	1	N
479	181	149	campus_buzz	N	2016-04-08 10:35:03	N	210		\N	1	N
480	181	144	post_management	N	2016-04-09 00:00:01	N	358	1	\N	\N	N
483	181	149	campus_buzz	N	2016-04-09 00:00:01	N	210	1	\N	\N	N
484	9	149	campus_buzz	N	2016-04-09 17:19:31	N	211		\N	1	N
481	9	149	campus_buzz	Y	2016-04-09 00:00:01	N	208	1	\N	\N	N
482	9	149	campus_buzz	Y	2016-04-09 00:00:01	N	209	1	\N	\N	N
488	9	149	campus_buzz	N	2016-04-11 02:33:34	N	212		\N	1	N
485	194	149	campus_buzz	Y	2016-04-10 00:00:02	N	193	1	\N	\N	N
489	30	149	campus_buzz	N	2016-04-11 14:05:41	N	213		\N	1	N
490	194	149	campus_buzz	N	2016-04-11 16:00:41	N	214		\N	1	N
491	194	149	campus_buzz	N	2016-04-11 16:35:50	N	215		\N	1	N
492	194	149	campus_buzz	N	2016-04-11 16:39:45	N	216		\N	1	N
493	194	149	campus_buzz	N	2016-04-11 16:40:40	N	217		\N	1	N
494	194	149	campus_buzz	N	2016-04-11 16:43:48	N	218		\N	1	N
495	194	149	campus_buzz	N	2016-04-11 16:46:00	N	219		\N	1	N
496	9	149	campus_buzz	N	2016-04-11 22:17:49	N	220		\N	1	N
497	194	149	campus_buzz	N	2016-04-12 00:14:36	N	221		\N	1	N
498	9	149	campus_buzz	N	2016-04-12 00:16:15	N	222		\N	1	N
499	397	144	post_management	N	2016-04-13 00:00:02	N	322	1	\N	\N	N
501	488	144	post_management	N	2016-04-13 03:58:37	N	359		\N	1	N
504	182	144	post_management	N	2016-04-14 00:00:01	N	328	1	\N	\N	N
507	407	144	post_management	N	2016-04-14 00:00:01	N	329	1	\N	\N	N
502	194	144	post_management	Y	2016-04-14 00:00:01	N	326	1	\N	\N	N
505	194	144	post_management	Y	2016-04-14 00:00:01	N	324	1	\N	\N	N
526	485	144	post_management	N	2016-04-14 19:00:15	N	364		\N	1	N
506	194	144	post_management	Y	2016-04-14 00:00:01	N	325	1	\N	\N	N
503	194	144	post_management	Y	2016-04-14 00:00:01	N	327	1	\N	\N	N
527	407	144	post_management	N	2016-04-15 00:00:01	N	330	1	\N	\N	N
487	194	145	message_list	Y	2016-04-10 03:31:47	N	2388	0	\N	1	N
512	9	145	message_list	Y	2016-04-14 12:07:32	N	2392	0	\N	1	N
500	194	149	campus_buzz	Y	2016-04-13 00:00:02	N	192	1	\N	\N	N
510	9	145	message_list	Y	2016-04-14 12:05:27	N	2390	0	\N	1	N
509	9	145	message_list	Y	2016-04-14 12:04:53	N	2389	0	\N	1	N
514	9	145	message_list	Y	2016-04-14 12:07:44	N	2394	0	\N	1	N
530	194	145	message_list	N	2016-04-15 00:36:00	N	2402	0	\N	1	N
511	194	145	message_list	Y	2016-04-14 12:07:10	N	2391	0	\N	1	N
513	194	145	message_list	Y	2016-04-14 12:07:38	N	2393	0	\N	1	N
486	9	149	campus_buzz	Y	2016-04-10 00:00:02	N	211	1	\N	\N	N
508	9	149	campus_buzz	Y	2016-04-14 00:00:01	N	212	1	\N	\N	N
516	9	145	message_list	Y	2016-04-14 12:07:59	N	2396	0	\N	1	N
515	9	145	message_list	Y	2016-04-14 12:07:50	N	2395	0	\N	1	N
529	47	145	message_list	Y	2016-04-15 00:09:41	N	2401	0	\N	1	N
517	194	145	message_list	Y	2016-04-14 12:12:00	N	2397	0	\N	1	N
518	9	145	message_list	Y	2016-04-14 12:17:58	N	2398	0	\N	1	N
538	9	149	campus_buzz	Y	2016-04-16 00:00:01	N	220	1	\N	\N	N
519	194	145	message_list	Y	2016-04-14 12:20:57	N	2399	0	\N	1	N
520	9	145	message_list	Y	2016-04-14 12:25:36	N	2400	0	\N	1	N
521	194	144	post_management	N	2016-04-14 14:08:19	N	360		\N	1	N
522	194	144	post_management	N	2016-04-14 14:09:24	N	361		\N	1	N
523	194	144	post_management	N	2016-04-14 14:10:57	N	362		\N	1	N
524	194	144	post_management	N	2016-04-14 14:12:10	N	363		\N	1	N
525	194	149	campus_buzz	N	2016-04-14 14:17:30	N	223		\N	1	N
531	9	145	message_list	Y	2016-04-15 19:14:43	N	2403	0	\N	1	N
532	194	145	message_list	Y	2016-04-15 19:19:06	N	2404	0	\N	1	N
533	9	145	message_list	Y	2016-04-15 19:20:40	N	2405	0	\N	1	N
528	194	149	campus_buzz	Y	2016-04-15 00:00:01	N	215	1	\N	\N	N
534	194	145	message_list	N	2016-04-15 21:55:25	N	2406	0	\N	1	N
539	181	144	post_management	N	2016-04-16 11:50:39	N	365		\N	1	N
540	182	149	campus_buzz	N	2016-04-16 11:56:37	N	224		\N	1	N
541	182	144	post_management	N	2016-04-16 11:57:23	N	366		\N	1	N
537	194	149	campus_buzz	Y	2016-04-16 00:00:01	N	217	1	\N	\N	N
536	194	149	campus_buzz	Y	2016-04-16 00:00:01	N	216	1	\N	\N	N
535	194	149	campus_buzz	Y	2016-04-16 00:00:01	N	191	1	\N	\N	N
542	182	144	post_management	N	2016-04-17 00:00:01	N	366	1	\N	\N	N
543	194	149	campus_buzz	N	2016-04-17 00:00:01	N	200	1	\N	\N	N
544	194	149	campus_buzz	N	2016-04-17 00:00:01	N	218	1	\N	\N	N
545	30	149	campus_buzz	N	2016-04-19 00:00:01	N	213	1	\N	\N	N
547	481	144	post_management	N	2016-04-20 00:54:28	N	367		\N	1	N
548	481	144	post_management	N	2016-04-20 00:56:30	N	368		\N	1	N
549	481	144	post_management	N	2016-04-20 00:58:03	N	369		\N	1	N
550	194	149	campus_buzz	N	2016-04-20 14:26:02	N	225		\N	1	N
551	194	149	campus_buzz	N	2016-04-20 14:27:26	N	226		\N	1	N
552	194	149	campus_buzz	N	2016-04-23 00:00:01	N	225	1	\N	\N	N
546	9	149	campus_buzz	Y	2016-04-20 00:00:01	N	222	1	\N	\N	N
556	9	144	post_management	Y	2016-04-24 00:00:01	N	339	1	\N	\N	N
555	9	144	post_management	Y	2016-04-24 00:00:01	N	338	1	\N	\N	N
554	9	144	post_management	Y	2016-04-24 00:00:01	N	337	1	\N	\N	N
553	9	144	post_management	Y	2016-04-24 00:00:01	N	336	1	\N	\N	N
557	194	144	post_management	Y	2016-04-24 00:00:01	N	340	1	\N	\N	N
558	194	144	post_management	Y	2016-04-24 00:00:01	N	341	1	\N	\N	N
559	194	144	post_management	Y	2016-04-24 00:00:01	N	342	1	\N	\N	N
560	194	144	post_management	Y	2016-04-24 00:00:01	N	343	1	\N	\N	N
561	194	144	post_management	Y	2016-04-24 00:00:01	N	344	1	\N	\N	N
564	9	149	campus_buzz	N	2016-04-26 14:18:32	N	227		\N	1	N
567	30	144	post_management	N	2016-04-27 13:13:18	N	370		\N	1	N
568	30	144	post_management	N	2016-04-27 13:15:45	N	371		\N	1	N
569	30	149	campus_buzz	N	2016-04-27 13:29:38	N	228		\N	1	N
570	194	144	post_management	N	2016-04-27 19:40:40	N	372		\N	1	N
571	194	144	post_management	N	2016-04-27 21:56:11	N	373		\N	1	N
572	194	144	post_management	N	2016-04-27 21:58:45	N	374		\N	1	N
573	194	144	post_management	N	2016-04-27 22:01:02	N	375		\N	1	N
574	194	144	post_management	N	2016-04-27 22:03:54	N	376		\N	1	N
575	194	144	post_management	N	2016-04-27 22:05:28	N	377		\N	1	N
576	194	144	post_management	N	2016-04-27 22:12:41	N	378		\N	1	N
577	194	144	post_management	N	2016-04-27 22:14:49	N	379		\N	1	N
578	194	144	post_management	N	2016-04-27 22:16:24	N	380		\N	1	N
579	194	144	post_management	N	2016-04-27 22:18:28	N	381		\N	1	N
580	194	144	post_management	N	2016-04-27 22:21:29	N	382		\N	1	N
582	9	144	post_management	N	2016-04-28 02:00:35	N	383		\N	1	N
583	9	144	post_management	N	2016-04-28 02:02:38	N	384		\N	1	N
584	9	144	post_management	N	2016-04-28 02:03:51	N	385		\N	1	N
585	9	144	post_management	N	2016-04-28 02:06:25	N	386		\N	1	N
586	9	144	post_management	N	2016-04-28 02:08:22	N	387		\N	1	N
587	9	144	post_management	N	2016-04-28 02:12:13	N	388		\N	1	N
588	9	144	post_management	N	2016-04-28 02:16:19	N	389		\N	1	N
589	9	149	campus_buzz	N	2016-04-28 02:22:03	N	229		\N	1	N
590	9	149	campus_buzz	N	2016-04-28 11:12:54	N	230		\N	1	N
591	9	149	campus_buzz	N	2016-04-28 11:15:29	N	231		\N	1	N
592	9	149	campus_buzz	N	2016-04-28 11:22:11	N	232		\N	1	N
593	194	145	message_list	Y	2016-04-28 15:28:26	N	2407	0	\N	1	N
581	9	149	campus_buzz	Y	2016-04-28 00:00:01	N	227	1	\N	\N	N
594	458	144	post_management	N	2016-04-29 00:00:01	N	351	1	\N	\N	N
596	421	144	post_management	N	2016-04-29 17:08:18	N	390		\N	1	N
595	9	149	campus_buzz	Y	2016-04-29 00:00:01	N	229	1	\N	\N	N
597	458	144	post_management	N	2016-04-30 00:00:02	N	350	1	\N	\N	N
598	458	144	post_management	N	2016-04-30 00:00:02	N	349	1	\N	\N	N
602	512	145	message_list	Y	2016-04-30 16:04:26	N	2408	0	\N	1	N
601	9	149	campus_buzz	Y	2016-04-30 00:00:02	N	231	1	\N	\N	N
600	9	149	campus_buzz	Y	2016-04-30 00:00:02	N	230	1	\N	\N	N
604	458	144	post_management	N	2016-05-01 00:00:01	N	352	1	\N	\N	N
605	458	144	post_management	N	2016-05-01 00:00:01	N	353	1	\N	\N	N
606	458	144	post_management	N	2016-05-01 00:00:01	N	354	1	\N	\N	N
607	458	144	post_management	N	2016-05-01 00:00:01	N	355	1	\N	\N	N
608	458	144	post_management	N	2016-05-01 00:00:01	N	356	1	\N	\N	N
609	458	144	post_management	N	2016-05-01 00:00:01	N	357	1	\N	\N	N
611	512	144	post_management	N	2016-05-01 16:00:29	N	391		\N	1	N
613	194	145	message_list	Y	2016-05-01 23:59:29	N	2411	0	\N	1	N
614	119	144	post_management	N	2016-05-02 14:22:54	N	392		\N	1	N
615	119	144	post_management	N	2016-05-02 14:24:12	N	393		\N	1	N
616	119	144	post_management	N	2016-05-02 14:25:11	N	394		\N	1	N
617	119	144	post_management	N	2016-05-02 14:26:52	N	395		\N	1	N
618	119	144	post_management	N	2016-05-02 14:28:11	N	396		\N	1	N
610	9	149	campus_buzz	Y	2016-05-01 00:00:01	N	232	1	\N	\N	N
620	207	144	post_management	N	2016-05-02 19:25:28	N	397		\N	1	N
621	207	144	post_management	N	2016-05-02 19:31:56	N	398		\N	1	N
622	207	144	post_management	N	2016-05-02 19:35:58	N	399		\N	1	N
623	30	149	campus_buzz	N	2016-05-03 00:00:01	N	228	1	\N	\N	N
624	421	144	post_management	N	2016-05-03 22:05:43	N	400		\N	1	N
627	194	145	message_list	Y	2016-05-05 14:35:54	N	2415	0	\N	1	N
631	194	145	message_list	Y	2016-05-05 14:39:00	N	2419	0	\N	1	N
599	194	149	campus_buzz	Y	2016-04-30 00:00:02	N	214	1	\N	\N	N
565	194	149	campus_buzz	Y	2016-04-27 00:00:01	N	219	1	\N	\N	N
628	194	145	message_list	Y	2016-05-05 14:36:06	N	2416	0	\N	1	N
562	194	144	post_management	Y	2016-04-24 00:00:01	N	345	1	\N	\N	N
630	460	145	message_list	Y	2016-05-05 14:37:30	N	2418	0	\N	1	N
619	460	145	message_list	Y	2016-05-02 18:19:20	N	2412	0	\N	1	N
612	460	145	message_list	Y	2016-05-01 23:53:13	N	2410	0	\N	1	N
626	460	145	message_list	Y	2016-05-05 03:16:30	N	2414	0	\N	1	N
629	460	145	message_list	Y	2016-05-05 14:37:09	N	2417	0	\N	1	N
625	460	145	message_list	Y	2016-05-05 03:15:58	N	2413	0	\N	1	N
563	194	149	campus_buzz	Y	2016-04-24 00:00:01	N	221	1	\N	\N	N
566	194	149	campus_buzz	Y	2016-04-27 00:00:01	N	226	1	\N	\N	N
603	9	145	message_list	Y	2016-04-30 16:05:44	N	2409	0	\N	1	N
632	460	145	message_list	Y	2016-05-05 15:10:05	N	2420	0	\N	1	N
633	460	145	message_list	N	2016-05-05 23:53:31	N	2421	0	\N	1	N
634	30	144	post_management	N	2016-05-06 00:00:01	N	348	1	\N	\N	N
635	194	149	campus_buzz	N	2016-05-07 16:00:41	N	233		\N	1	N
636	194	149	campus_buzz	N	2016-05-07 16:01:52	N	234		\N	1	N
637	194	149	campus_buzz	N	2016-05-07 16:03:43	N	235		\N	1	N
638	460	145	message_list	N	2016-05-07 16:27:57	N	2422	0	\N	1	N
640	460	145	message_list	Y	2016-05-08 17:19:55	N	2424	0	\N	1	N
642	527	144	post_management	N	2016-05-08 17:51:54	N	401		\N	1	N
641	194	145	message_list	Y	2016-05-08 17:50:24	N	2425	0	\N	1	N
643	460	145	message_list	Y	2016-05-08 17:51:54	N	2426	0	\N	1	N
639	460	145	message_list	Y	2016-05-08 17:08:52	N	2423	0	\N	1	N
645	460	145	message_list	Y	2016-05-08 17:54:54	N	2428	0	\N	1	N
644	194	145	message_list	Y	2016-05-08 17:52:58	N	2427	0	\N	1	N
646	194	145	message_list	Y	2016-05-08 17:56:26	N	2429	0	\N	1	N
647	460	145	message_list	Y	2016-05-08 17:57:55	N	2430	0	\N	1	N
648	460	145	message_list	Y	2016-05-08 17:58:13	N	2431	0	\N	1	N
649	194	145	message_list	Y	2016-05-08 17:59:11	N	2432	0	\N	1	N
650	460	145	message_list	Y	2016-05-08 17:59:56	N	2433	0	\N	1	N
651	194	145	message_list	Y	2016-05-08 18:00:16	N	2434	0	\N	1	N
653	194	145	message_list	Y	2016-05-08 18:02:02	N	2436	0	\N	1	N
700	194	144	post_management	Y	2016-05-28 00:00:01	N	372	1	\N	\N	N
652	460	145	message_list	Y	2016-05-08 18:00:53	N	2435	0	\N	1	N
655	194	144	post_management	N	2016-05-08 21:47:54	N	402		\N	1	N
701	194	144	post_management	Y	2016-05-28 00:00:01	N	373	1	\N	\N	N
654	321	145	message_list	Y	2016-05-08 21:47:26	N	2437	0	\N	1	N
656	194	145	message_list	Y	2016-05-08 21:48:26	N	2438	0	\N	1	N
698	194	144	post_management	Y	2016-05-28 00:00:01	N	377	1	\N	\N	N
657	321	145	message_list	Y	2016-05-08 21:50:08	N	2439	0	\N	1	N
658	194	145	message_list	Y	2016-05-08 21:51:54	N	2440	0	\N	1	N
704	194	144	post_management	Y	2016-05-28 00:00:01	N	379	1	\N	\N	N
659	321	145	message_list	Y	2016-05-08 21:54:36	N	2441	0	\N	1	N
705	194	144	post_management	Y	2016-05-28 00:00:01	N	380	1	\N	\N	N
660	194	145	message_list	Y	2016-05-08 21:56:27	N	2442	0	\N	1	N
661	321	145	message_list	Y	2016-05-08 21:59:33	N	2443	0	\N	1	N
664	528	144	post_management	N	2016-05-10 14:00:35	N	403		\N	1	N
703	194	144	post_management	Y	2016-05-28 00:00:01	N	378	1	\N	\N	N
665	321	145	message_list	Y	2016-05-11 18:49:56	N	2444	0	\N	1	N
666	194	145	message_list	Y	2016-05-11 18:50:51	N	2445	0	\N	1	N
667	321	145	message_list	Y	2016-05-11 19:35:15	N	2446	0	\N	1	N
668	512	144	post_management	N	2016-05-12 00:00:01	N	391	1	\N	\N	N
670	488	144	post_management	N	2016-05-13 00:00:01	N	359	1	\N	\N	N
671	119	144	post_management	N	2016-05-13 00:00:01	N	392	1	\N	\N	N
672	119	144	post_management	N	2016-05-13 00:00:01	N	393	1	\N	\N	N
673	119	144	post_management	N	2016-05-13 00:00:01	N	396	1	\N	\N	N
675	409	144	post_management	N	2016-05-13 18:17:09	N	404		\N	1	N
680	207	144	post_management	N	2016-05-15 00:00:01	N	397	1	\N	\N	N
663	194	149	campus_buzz	Y	2016-05-09 00:00:01	N	233	1	\N	\N	N
674	194	149	campus_buzz	Y	2016-05-13 00:00:01	N	235	1	\N	\N	N
669	194	149	campus_buzz	Y	2016-05-12 00:00:01	N	234	1	\N	\N	N
681	194	149	campus_buzz	Y	2016-05-15 00:00:01	N	223	1	\N	\N	N
679	194	144	post_management	Y	2016-05-15 00:00:01	N	363	1	\N	\N	N
678	194	144	post_management	Y	2016-05-15 00:00:01	N	362	1	\N	\N	N
677	194	144	post_management	Y	2016-05-15 00:00:01	N	361	1	\N	\N	N
676	194	144	post_management	Y	2016-05-15 00:00:01	N	360	1	\N	\N	N
682	194	149	campus_buzz	N	2016-05-17 17:00:37	N	236		\N	1	N
683	194	149	campus_buzz	N	2016-05-17 17:01:57	N	237		\N	1	N
684	194	149	campus_buzz	N	2016-05-17 17:03:23	N	238		\N	1	N
685	527	144	post_management	N	2016-05-21 00:00:01	N	401	1	\N	\N	N
688	534	145	message_list	N	2016-05-24 00:46:12	N	2447	0	\N	1	N
689	460	145	message_list	Y	2016-05-24 02:06:15	N	2448	0	\N	1	N
690	460	145	message_list	Y	2016-05-24 02:06:56	N	2449	0	\N	1	N
691	30	144	post_management	N	2016-05-27 00:00:01	N	370	1	\N	\N	N
702	194	144	post_management	Y	2016-05-28 00:00:01	N	374	1	\N	\N	N
694	194	145	message_list	N	2016-05-27 19:14:10	N	2451	0	\N	1	N
693	479	145	message_list	Y	2016-05-27 19:10:59	N	2450	0	\N	1	N
695	467	145	message_list	Y	2016-05-27 19:33:17	N	2452	0	\N	1	N
687	194	149	campus_buzz	Y	2016-05-22 00:00:01	N	238	1	\N	\N	N
692	194	144	post_management	Y	2016-05-27 00:00:01	N	375	1	\N	\N	N
686	194	149	campus_buzz	Y	2016-05-22 00:00:01	N	237	1	\N	\N	N
696	321	145	message_list	Y	2016-05-27 21:17:12	N	2453	0	\N	1	N
699	30	144	post_management	N	2016-05-28 00:00:01	N	371	1	\N	\N	N
706	194	144	post_management	Y	2016-05-28 00:00:01	N	381	1	\N	\N	N
697	194	144	post_management	Y	2016-05-28 00:00:01	N	376	1	\N	\N	N
662	421	144	post_management	Y	2016-05-09 00:00:01	N	390	1	\N	\N	N
715	207	144	post_management	N	2016-05-30 00:00:01	N	399	1	\N	\N	N
716	207	144	post_management	N	2016-06-01 00:00:01	N	398	1	\N	\N	N
735	194	144	post_management	Y	2016-07-10 00:00:01	N	405	1	\N	\N	N
720	194	145	message_list	Y	2016-06-09 03:25:36	N	2455	0	\N	1	N
721	460	145	message_list	Y	2016-06-09 03:27:10	N	2456	0	\N	1	N
718	194	144	post_management	Y	2016-06-08 00:00:01	N	402	1	\N	\N	N
722	194	144	post_management	N	2016-06-09 03:39:08	N	405		\N	1	N
723	194	144	post_management	N	2016-06-09 03:42:16	N	406		\N	1	N
724	194	144	post_management	N	2016-06-09 03:43:52	N	407		\N	1	N
719	460	145	message_list	Y	2016-06-09 03:01:13	N	2454	0	\N	1	N
725	194	144	post_management	N	2016-06-09 03:45:13	N	408		\N	1	N
726	194	144	post_management	N	2016-06-09 03:46:59	N	409		\N	1	N
707	194	144	post_management	Y	2016-05-28 00:00:01	N	382	1	\N	\N	N
727	194	144	post_management	N	2016-06-09 03:49:37	N	410		\N	1	N
728	194	144	post_management	N	2016-06-09 03:51:05	N	411		\N	1	N
729	528	144	post_management	N	2016-06-10 00:00:01	N	403	1	\N	\N	N
730	409	144	post_management	N	2016-06-13 00:00:01	N	404	1	\N	\N	N
731	524	144	post_management	N	2016-06-26 14:28:32	N	412		\N	1	N
740	524	144	post_management	N	2016-07-27 00:00:01	N	412	1	\N	\N	N
741	194	144	post_management	N	2016-07-31 20:13:47	N	413		\N	1	N
742	194	144	post_management	N	2016-07-31 20:17:52	N	414		\N	1	N
743	194	144	post_management	N	2016-07-31 20:23:51	N	415		\N	1	N
744	194	144	post_management	N	2016-07-31 20:26:57	N	416		\N	1	N
745	194	144	post_management	N	2016-07-31 20:32:23	N	417		\N	1	N
746	194	144	post_management	N	2016-07-31 20:38:51	N	418		\N	1	N
747	194	144	post_management	N	2016-07-31 20:42:47	N	419		\N	1	N
748	194	144	post_management	N	2016-07-31 21:23:37	N	420		\N	1	N
749	194	144	post_management	N	2016-07-31 21:24:43	N	421		\N	1	N
750	194	144	post_management	N	2016-07-31 21:28:19	N	422		\N	1	N
751	194	144	post_management	N	2016-07-31 21:32:28	N	423		\N	1	N
752	194	144	post_management	N	2016-07-31 21:35:38	N	424		\N	1	N
753	194	144	post_management	N	2016-07-31 21:37:36	N	425		\N	1	N
754	194	144	post_management	N	2016-07-31 21:40:15	N	426		\N	1	N
755	194	144	post_management	N	2016-07-31 21:44:43	N	427		\N	1	N
756	194	149	campus_buzz	N	2016-07-31 22:32:43	N	239		\N	1	N
757	194	149	campus_buzz	N	2016-07-31 22:33:41	N	240		\N	1	N
758	194	149	campus_buzz	N	2016-07-31 22:35:23	N	241		\N	1	N
759	194	149	campus_buzz	N	2016-07-31 22:36:18	N	242		\N	1	N
760	194	149	campus_buzz	N	2016-07-31 22:38:16	N	243		\N	1	N
761	194	149	campus_buzz	N	2016-07-31 22:39:25	N	244		\N	1	N
762	194	149	campus_buzz	N	2016-07-31 22:40:19	N	245		\N	1	N
763	194	149	campus_buzz	N	2016-07-31 22:41:53	N	246		\N	1	N
764	194	149	campus_buzz	N	2016-07-31 22:42:42	N	247		\N	1	N
765	194	149	campus_buzz	N	2016-07-31 22:55:32	N	248		\N	1	N
766	194	149	campus_buzz	N	2016-07-31 22:59:47	N	249		\N	1	N
767	194	149	campus_buzz	N	2016-07-31 23:01:07	N	250		\N	1	N
768	194	149	campus_buzz	N	2016-07-31 23:02:27	N	251		\N	1	N
769	194	149	campus_buzz	N	2016-07-31 23:04:26	N	252		\N	1	N
770	194	149	campus_buzz	N	2016-07-31 23:07:06	N	253		\N	1	N
771	194	149	campus_buzz	N	2016-07-31 23:10:50	N	254		\N	1	N
732	460	145	message_list	Y	2016-06-26 19:31:53	N	2457	0	\N	1	N
734	194	144	post_management	Y	2016-07-09 00:00:01	N	410	1	\N	\N	N
738	194	144	post_management	Y	2016-07-10 00:00:01	N	408	1	\N	\N	N
733	194	144	post_management	Y	2016-07-09 00:00:01	N	409	1	\N	\N	N
772	9	145	message_list	Y	2016-08-01 02:05:33	N	2458	0	\N	1	N
739	194	144	post_management	Y	2016-07-10 00:00:01	N	411	1	\N	\N	N
737	194	144	post_management	Y	2016-07-10 00:00:01	N	407	1	\N	\N	N
736	194	144	post_management	Y	2016-07-10 00:00:01	N	406	1	\N	\N	N
773	9	145	message_list	Y	2016-08-01 02:06:12	N	2459	0	\N	1	N
774	9	145	message_list	Y	2016-08-01 02:06:43	N	2460	0	\N	1	N
711	9	144	post_management	Y	2016-05-29 00:00:01	N	386	1	\N	\N	N
712	9	144	post_management	Y	2016-05-29 00:00:01	N	387	1	\N	\N	N
713	9	144	post_management	Y	2016-05-29 00:00:01	N	388	1	\N	\N	N
710	9	144	post_management	Y	2016-05-29 00:00:01	N	385	1	\N	\N	N
714	9	144	post_management	Y	2016-05-29 00:00:01	N	389	1	\N	\N	N
709	9	144	post_management	Y	2016-05-28 00:00:01	N	384	1	\N	\N	N
708	9	144	post_management	Y	2016-05-28 00:00:01	N	383	1	\N	\N	N
775	194	145	message_list	Y	2016-08-01 02:07:49	N	2461	0	\N	1	N
776	194	145	message_list	Y	2016-08-01 02:08:35	N	2462	0	\N	1	N
777	194	145	message_list	Y	2016-08-01 02:08:50	N	2463	0	\N	1	N
778	194	145	message_list	Y	2016-08-01 02:09:12	N	2464	0	\N	1	N
779	9	145	message_list	Y	2016-08-01 02:09:55	N	2465	0	\N	1	N
780	194	145	message_list	Y	2016-08-01 02:11:49	N	2466	0	\N	1	N
782	9	145	message_list	Y	2016-08-01 02:16:55	N	2468	0	\N	1	N
783	194	145	message_list	Y	2016-08-01 03:22:31	N	2469	0	\N	1	N
781	9	145	message_list	Y	2016-08-01 02:12:41	N	2467	0	\N	1	N
784	9	145	message_list	Y	2016-08-01 03:22:56	N	2470	0	\N	1	N
785	9	145	message_list	Y	2016-08-01 03:41:01	N	2471	0	\N	1	N
786	194	145	message_list	Y	2016-08-01 03:54:05	N	2472	0	\N	1	N
787	9	145	message_list	Y	2016-08-01 11:28:25	N	2473	0	\N	1	N
788	194	145	message_list	Y	2016-08-01 11:29:32	N	2474	0	\N	1	N
789	194	145	message_list	Y	2016-08-01 11:32:18	N	2475	0	\N	1	N
790	9	145	message_list	Y	2016-08-01 11:44:24	N	2476	0	\N	1	N
791	194	145	message_list	Y	2016-08-01 11:45:00	N	2477	0	\N	1	N
792	9	145	message_list	Y	2016-08-01 11:46:54	N	2478	0	\N	1	N
793	194	145	message_list	Y	2016-08-01 11:49:05	N	2479	0	\N	1	N
794	194	145	message_list	Y	2016-08-01 11:58:48	N	2480	0	\N	1	N
795	194	145	message_list	Y	2016-08-01 12:01:41	N	2481	0	\N	1	N
796	9	145	message_list	Y	2016-08-02 00:02:03	N	2482	0	\N	1	N
797	460	145	message_list	Y	2016-08-04 02:25:37	N	2483	0	\N	1	N
798	460	145	message_list	Y	2016-08-04 02:26:14	N	2484	0	\N	1	N
799	194	145	message_list	Y	2016-08-04 02:26:36	N	2485	0	\N	1	N
850	194	144	post_management	N	2016-08-12 00:14:54	N	436		\N	1	N
801	194	145	message_list	Y	2016-08-04 02:27:46	N	2487	0	\N	1	N
802	194	145	message_list	Y	2016-08-04 02:28:35	N	2488	0	\N	1	N
805	9	144	post_management	N	2016-08-04 23:24:30	N	428		\N	1	N
806	9	144	post_management	N	2016-08-04 23:27:01	N	429		\N	1	N
807	9	144	post_management	N	2016-08-04 23:28:23	N	430		\N	1	N
808	9	144	post_management	N	2016-08-04 23:30:22	N	431		\N	1	N
809	9	144	post_management	N	2016-08-04 23:31:54	N	432		\N	1	N
810	9	144	post_management	N	2016-08-05 11:49:18	N	433		\N	1	N
811	9	144	post_management	N	2016-08-05 21:38:30	N	434		\N	1	N
813	194	145	message_list	Y	2016-08-06 15:15:48	N	2492	0	\N	1	N
800	460	145	message_list	Y	2016-08-04 02:27:27	N	2486	0	\N	1	N
803	460	145	message_list	Y	2016-08-04 02:28:45	N	2489	0	\N	1	N
812	460	145	message_list	Y	2016-08-06 13:43:56	N	2491	0	\N	1	N
814	460	145	message_list	Y	2016-08-06 15:16:19	N	2493	0	\N	1	N
816	194	145	message_list	Y	2016-08-07 00:37:02	N	2494	0	\N	1	N
804	194	145	message_list	Y	2016-08-04 02:31:51	N	2490	0	\N	1	N
817	9	149	campus_buzz	N	2016-08-07 16:11:15	N	255		\N	1	N
818	194	149	campus_buzz	N	2016-08-07 16:12:43	N	256		\N	1	N
819	460	145	message_list	Y	2016-08-07 16:14:17	N	2495	0	\N	1	N
815	194	149	campus_buzz	Y	2016-08-07 00:00:01	N	248	1	\N	\N	N
834	460	145	message_list	Y	2016-08-08 14:37:32	N	2510	0	\N	1	N
820	194	145	message_list	Y	2016-08-07 16:27:17	N	2496	0	\N	1	N
821	460	145	message_list	Y	2016-08-07 16:31:46	N	2497	0	\N	1	N
832	460	145	message_list	Y	2016-08-08 13:33:47	N	2508	0	\N	1	N
823	9	145	message_list	Y	2016-08-07 16:45:32	N	2499	0	\N	1	N
824	9	145	message_list	Y	2016-08-07 16:45:54	N	2500	0	\N	1	N
825	194	145	message_list	Y	2016-08-07 16:46:05	N	2501	0	\N	1	N
826	9	145	message_list	Y	2016-08-07 16:47:35	N	2502	0	\N	1	N
822	194	145	message_list	Y	2016-08-07 16:43:10	N	2498	0	\N	1	N
827	460	145	message_list	Y	2016-08-07 17:07:39	N	2503	0	\N	1	N
851	194	144	post_management	N	2016-08-12 00:18:18	N	437		\N	1	N
829	460	145	message_list	Y	2016-08-07 17:15:31	N	2505	0	\N	1	N
830	194	145	message_list	Y	2016-08-07 17:47:56	N	2506	0	\N	1	N
828	194	145	message_list	Y	2016-08-07 17:14:42	N	2504	0	\N	1	N
831	460	145	message_list	Y	2016-08-07 17:48:42	N	2507	0	\N	1	N
837	460	145	message_list	Y	2016-08-09 21:27:02	N	2513	0	\N	1	N
838	194	145	message_list	Y	2016-08-09 21:39:27	N	2514	0	\N	1	N
835	194	145	message_list	Y	2016-08-08 14:38:26	N	2511	0	\N	1	N
833	194	145	message_list	Y	2016-08-08 14:36:02	N	2509	0	\N	1	N
836	194	145	message_list	Y	2016-08-09 21:12:18	N	2512	0	\N	1	N
852	194	144	post_management	N	2016-08-12 00:20:34	N	438		\N	1	N
839	460	145	message_list	Y	2016-08-09 21:43:15	N	2515	0	\N	1	N
853	194	144	post_management	N	2016-08-12 00:22:39	N	439		\N	1	N
841	460	145	message_list	Y	2016-08-09 21:54:48	N	2517	0	\N	1	N
842	194	145	message_list	Y	2016-08-09 22:02:20	N	2518	0	\N	1	N
854	194	144	post_management	N	2016-08-12 00:27:22	N	440		\N	1	N
840	194	145	message_list	Y	2016-08-09 21:54:10	N	2516	0	\N	1	N
855	194	144	post_management	N	2016-08-12 00:29:43	N	441		\N	1	N
843	460	145	message_list	Y	2016-08-09 22:03:15	N	2519	0	\N	1	N
856	194	144	post_management	N	2016-08-12 00:31:34	N	442		\N	1	N
844	194	145	message_list	Y	2016-08-09 22:06:35	N	2520	0	\N	1	N
857	581	144	post_management	N	2016-08-12 00:47:32	N	443		\N	1	N
845	460	145	message_list	Y	2016-08-09 22:09:44	N	2521	0	\N	1	N
846	194	145	message_list	Y	2016-08-09 22:27:59	N	2522	0	\N	1	N
847	338	144	post_management	N	2016-08-09 23:48:46	N	435		\N	1	N
848	194	149	campus_buzz	N	2016-08-11 00:00:01	N	249	1	\N	\N	N
849	194	149	campus_buzz	N	2016-08-12 00:00:01	N	251	1	\N	\N	N
858	581	144	post_management	N	2016-08-12 00:52:17	N	444		\N	1	N
859	581	144	post_management	N	2016-08-12 00:53:47	N	445		\N	1	N
861	598	144	post_management	N	2016-08-12 01:31:10	N	446		\N	1	N
860	589	145	message_list	Y	2016-08-12 01:08:15	N	2523	0	\N	1	N
862	194	145	message_list	N	2016-08-12 01:57:20	N	2524	0	\N	1	N
864	194	145	message_list	N	2016-08-12 03:20:46	N	2526	0	\N	1	N
865	194	145	message_list	N	2016-08-12 03:21:16	N	2527	0	\N	1	N
863	602	145	message_list	Y	2016-08-12 03:13:00	N	2525	0	\N	1	N
867	194	145	message_list	N	2016-08-12 03:45:33	N	2529	0	\N	1	N
866	602	145	message_list	Y	2016-08-12 03:44:14	N	2528	0	\N	1	N
868	602	145	message_list	Y	2016-08-12 03:51:36	N	2530	0	\N	1	N
874	194	145	message_list	Y	2016-08-12 12:59:55	N	2536	0	\N	1	N
875	194	145	message_list	N	2016-08-12 13:01:18	N	2537	0	\N	1	N
871	623	145	message_list	Y	2016-08-12 04:12:04	N	2533	0	\N	1	N
870	592	145	message_list	Y	2016-08-12 04:08:28	N	2532	0	\N	1	N
872	633	145	message_list	Y	2016-08-12 11:12:04	N	2534	0	\N	1	N
873	641	145	message_list	Y	2016-08-12 12:56:15	N	2535	0	\N	1	N
876	194	145	message_list	Y	2016-08-12 13:02:06	N	2538	0	\N	1	N
877	194	145	message_list	Y	2016-08-12 13:02:13	N	2539	0	\N	1	N
878	194	145	message_list	Y	2016-08-12 13:02:53	N	2540	0	\N	1	N
879	194	145	message_list	N	2016-08-12 13:03:39	N	2541	0	\N	1	N
880	194	145	message_list	N	2016-08-12 13:03:54	N	2542	0	\N	1	N
882	194	145	message_list	N	2016-08-12 13:32:58	N	2544	0	\N	1	N
881	602	145	message_list	Y	2016-08-12 13:31:07	N	2543	0	\N	1	N
869	622	145	message_list	Y	2016-08-12 04:07:49	N	2531	0	\N	1	N
883	592	145	message_list	Y	2016-08-12 13:41:06	N	2545	0	\N	1	N
884	589	145	message_list	Y	2016-08-12 13:43:20	N	2546	0	\N	1	N
918	641	145	message_list	Y	2016-08-12 18:23:39	N	2577	0	\N	1	N
885	621	145	message_list	Y	2016-08-12 13:52:38	N	2547	0	\N	1	N
886	194	145	message_list	Y	2016-08-12 13:55:23	N	2548	0	\N	1	N
887	621	145	message_list	Y	2016-08-12 13:56:27	N	2549	0	\N	1	N
942	664	145	message_list	N	2016-08-13 02:10:29	N	2599	0	\N	1	N
890	194	145	message_list	N	2016-08-12 14:14:32	N	2552	0	\N	1	N
889	623	145	message_list	Y	2016-08-12 14:13:04	N	2551	0	\N	1	N
888	602	145	message_list	Y	2016-08-12 14:01:40	N	2550	0	\N	1	N
891	660	144	post_management	N	2016-08-12 15:17:00	N	447		\N	1	N
920	194	145	message_list	N	2016-08-12 18:38:11	N	2579	0	\N	1	N
892	583	145	message_list	Y	2016-08-12 15:23:50	N	2553	0	\N	1	N
919	636	145	message_list	Y	2016-08-12 18:28:43	N	2578	0	\N	1	N
893	194	145	message_list	Y	2016-08-12 15:32:28	N	2554	0	\N	1	N
895	583	145	message_list	Y	2016-08-12 15:40:08	N	2556	0	\N	1	N
894	583	145	message_list	Y	2016-08-12 15:34:27	N	2555	0	\N	1	N
921	636	145	message_list	Y	2016-08-12 18:40:13	N	2580	0	\N	1	N
896	194	145	message_list	Y	2016-08-12 15:48:40	N	2557	0	\N	1	N
897	583	145	message_list	Y	2016-08-12 15:51:01	N	2558	0	\N	1	N
922	636	145	message_list	Y	2016-08-12 18:41:16	N	2581	0	\N	1	N
898	194	145	message_list	Y	2016-08-12 16:00:38	N	2559	0	\N	1	N
901	641	145	message_list	Y	2016-08-12 16:26:10	N	2562	0	\N	1	N
899	663	145	message_list	Y	2016-08-12 16:12:37	N	2560	0	\N	1	N
902	641	145	message_list	Y	2016-08-12 16:28:11	N	2563	0	\N	1	N
923	194	145	message_list	N	2016-08-12 18:57:25	N	2582	0	\N	1	N
900	583	145	message_list	Y	2016-08-12 16:21:49	N	2561	0	\N	1	N
907	194	145	message_list	Y	2016-08-12 16:33:22	N	2568	0	\N	1	N
909	194	145	message_list	N	2016-08-12 16:34:32	N	2570	0	\N	1	N
908	663	145	message_list	Y	2016-08-12 16:34:07	N	2569	0	\N	1	N
910	664	144	post_management	N	2016-08-12 16:45:03	N	448		\N	1	N
911	664	144	post_management	N	2016-08-12 16:46:31	N	449		\N	1	N
906	194	145	message_list	Y	2016-08-12 16:32:52	N	2567	0	\N	1	N
905	194	145	message_list	Y	2016-08-12 16:30:48	N	2566	0	\N	1	N
904	194	145	message_list	Y	2016-08-12 16:30:36	N	2565	0	\N	1	N
913	622	145	message_list	Y	2016-08-12 17:44:40	N	2572	0	\N	1	N
914	194	145	message_list	Y	2016-08-12 17:45:21	N	2573	0	\N	1	N
915	641	145	message_list	Y	2016-08-12 18:18:07	N	2574	0	\N	1	N
916	641	145	message_list	Y	2016-08-12 18:18:21	N	2575	0	\N	1	N
912	622	145	message_list	Y	2016-08-12 17:42:36	N	2571	0	\N	1	N
917	194	145	message_list	N	2016-08-12 18:19:38	N	2576	0	\N	1	N
943	664	145	message_list	N	2016-08-13 02:14:00	N	2600	0	\N	1	N
925	194	145	message_list	N	2016-08-12 19:02:31	N	2584	0	\N	1	N
924	636	145	message_list	Y	2016-08-12 18:59:19	N	2583	0	\N	1	N
903	194	145	message_list	Y	2016-08-12 16:28:36	N	2564	0	\N	1	N
927	194	145	message_list	N	2016-08-12 19:13:17	N	2586	0	\N	1	N
926	636	145	message_list	Y	2016-08-12 19:07:06	N	2585	0	\N	1	N
928	636	145	message_list	Y	2016-08-12 19:14:30	N	2587	0	\N	1	N
931	194	145	message_list	N	2016-08-12 20:52:52	N	2590	0	\N	1	N
932	194	145	message_list	N	2016-08-12 20:53:30	N	2591	0	\N	1	N
933	678	145	message_list	Y	2016-08-12 22:24:24	N	2592	0	\N	1	N
930	674	145	message_list	Y	2016-08-12 20:51:25	N	2589	0	\N	1	N
929	674	145	message_list	Y	2016-08-12 20:50:52	N	2588	0	\N	1	N
934	678	145	message_list	Y	2016-08-12 22:27:15	N	2593	0	\N	1	N
935	194	145	message_list	N	2016-08-12 22:28:52	N	2594	0	\N	1	N
936	654	145	message_list	Y	2016-08-12 22:40:52	N	2595	0	\N	1	N
937	555	144	post_management	N	2016-08-12 23:34:28	N	450		\N	1	N
938	612	144	post_management	N	2016-08-13 01:35:57	N	451		\N	1	N
941	674	145	message_list	N	2016-08-13 02:03:22	N	2598	0	\N	1	N
955	570	144	post_management	N	2016-08-13 17:07:30	N	459		\N	1	N
944	460	145	message_list	Y	2016-08-13 14:39:42	N	2601	0	\N	1	N
946	612	144	post_management	N	2016-08-13 15:12:20	N	452		\N	1	N
945	194	145	message_list	Y	2016-08-13 14:55:06	N	2602	0	\N	1	N
947	9	144	post_management	N	2016-08-13 15:43:04	N	453		\N	1	N
948	9	144	post_management	N	2016-08-13 15:45:20	N	454		\N	1	N
949	9	144	post_management	N	2016-08-13 16:00:28	N	455		\N	1	N
950	9	144	post_management	N	2016-08-13 16:03:56	N	456		\N	1	N
951	9	144	post_management	N	2016-08-13 16:09:10	N	457		\N	1	N
953	688	144	post_management	N	2016-08-13 16:29:52	N	458		\N	1	N
956	570	144	post_management	N	2016-08-13 17:11:29	N	460		\N	1	N
957	570	144	post_management	N	2016-08-13 17:13:36	N	461		\N	1	N
958	612	144	post_management	N	2016-08-13 20:34:27	N	462		\N	1	N
960	690	145	message_list	N	2016-08-13 21:36:32	N	2606	0	\N	1	N
962	555	145	message_list	N	2016-08-14 01:37:14	N	2607	0	\N	1	N
963	555	145	message_list	N	2016-08-14 01:37:32	N	2608	0	\N	1	N
964	690	145	message_list	N	2016-08-14 02:02:04	N	2609	0	\N	1	N
954	673	145	message_list	Y	2016-08-13 16:33:22	N	2604	0	\N	1	N
952	636	145	message_list	Y	2016-08-13 16:23:49	N	2603	0	\N	1	N
940	674	145	message_list	Y	2016-08-13 02:01:32	N	2597	0	\N	1	N
939	674	145	message_list	Y	2016-08-13 02:01:09	N	2596	0	\N	1	N
959	194	145	message_list	Y	2016-08-13 20:49:43	N	2605	0	\N	1	N
965	690	145	message_list	N	2016-08-14 02:02:23	N	2610	0	\N	1	N
966	555	145	message_list	N	2016-08-14 02:04:05	N	2611	0	\N	1	N
967	690	145	message_list	N	2016-08-14 02:04:23	N	2612	0	\N	1	N
968	194	145	message_list	N	2016-08-14 15:19:08	N	2613	0	\N	1	N
969	194	145	message_list	N	2016-08-14 15:19:39	N	2614	0	\N	1	N
970	194	145	message_list	N	2016-08-14 15:20:20	N	2615	0	\N	1	N
971	696	145	message_list	N	2016-08-14 15:34:55	N	2616	0	\N	1	N
973	696	145	message_list	N	2016-08-14 15:35:53	N	2618	0	\N	1	N
972	570	145	message_list	Y	2016-08-14 15:35:28	N	2617	0	\N	1	N
975	696	145	message_list	N	2016-08-14 15:36:20	N	2620	0	\N	1	N
1025	673	145	message_list	Y	2016-08-15 13:36:36	N	2668	0	\N	1	N
977	696	145	message_list	N	2016-08-14 15:37:02	N	2622	0	\N	1	N
976	570	145	message_list	Y	2016-08-14 15:36:36	N	2621	0	\N	1	N
979	696	145	message_list	N	2016-08-14 15:38:23	N	2624	0	\N	1	N
980	696	145	message_list	N	2016-08-14 15:38:28	N	2625	0	\N	1	N
1014	583	145	message_list	Y	2016-08-14 18:04:57	N	2659	0	\N	1	N
981	696	145	message_list	N	2016-08-14 15:38:59	N	2626	0	\N	1	N
978	570	145	message_list	Y	2016-08-14 15:37:52	N	2623	0	\N	1	N
982	570	145	message_list	N	2016-08-14 15:39:47	N	2627	0	\N	1	N
983	696	145	message_list	N	2016-08-14 15:43:12	N	2628	0	\N	1	N
984	570	145	message_list	N	2016-08-14 15:46:02	N	2629	0	\N	1	N
985	696	145	message_list	N	2016-08-14 15:48:34	N	2630	0	\N	1	N
986	570	145	message_list	N	2016-08-14 15:49:32	N	2631	0	\N	1	N
987	696	145	message_list	N	2016-08-14 15:50:17	N	2632	0	\N	1	N
990	570	145	message_list	N	2016-08-14 15:56:38	N	2635	0	\N	1	N
974	194	145	message_list	Y	2016-08-14 15:36:06	N	2619	0	\N	1	N
996	194	145	message_list	N	2016-08-14 16:21:04	N	2641	0	\N	1	N
993	589	145	message_list	Y	2016-08-14 16:17:36	N	2638	0	\N	1	N
961	194	149	campus_buzz	Y	2016-08-14 00:00:01	N	252	1	\N	\N	N
994	643	145	message_list	Y	2016-08-14 16:18:31	N	2639	0	\N	1	N
992	602	145	message_list	Y	2016-08-14 16:15:40	N	2637	0	\N	1	N
991	602	145	message_list	Y	2016-08-14 16:15:04	N	2636	0	\N	1	N
1028	708	145	message_list	Y	2016-08-15 15:08:43	N	2671	0	\N	1	N
989	194	145	message_list	Y	2016-08-14 15:52:31	N	2634	0	\N	1	N
998	602	145	message_list	Y	2016-08-14 16:33:55	N	2643	0	\N	1	N
997	583	145	message_list	Y	2016-08-14 16:32:17	N	2642	0	\N	1	N
999	194	145	message_list	N	2016-08-14 17:01:19	N	2644	0	\N	1	N
1000	194	145	message_list	Y	2016-08-14 17:02:15	N	2645	0	\N	1	N
1001	9	145	message_list	N	2016-08-14 17:17:18	N	2646	0	\N	1	N
1015	194	145	message_list	Y	2016-08-14 18:22:22	N	2660	0	\N	1	N
1003	9	145	message_list	N	2016-08-14 17:18:46	N	2648	0	\N	1	N
1016	583	145	message_list	Y	2016-08-14 18:22:37	N	2661	0	\N	1	N
1004	9	145	message_list	N	2016-08-14 17:19:30	N	2649	0	\N	1	N
1002	589	145	message_list	Y	2016-08-14 17:18:01	N	2647	0	\N	1	N
995	589	145	message_list	Y	2016-08-14 16:19:31	N	2640	0	\N	1	N
988	194	145	message_list	Y	2016-08-14 15:52:16	N	2633	0	\N	1	N
1006	589	145	message_list	Y	2016-08-14 17:19:51	N	2651	0	\N	1	N
1007	194	145	message_list	N	2016-08-14 17:20:57	N	2652	0	\N	1	N
1009	9	145	message_list	N	2016-08-14 17:23:26	N	2654	0	\N	1	N
1008	602	145	message_list	Y	2016-08-14 17:22:01	N	2653	0	\N	1	N
1010	589	145	message_list	Y	2016-08-14 17:24:01	N	2655	0	\N	1	N
1005	583	145	message_list	Y	2016-08-14 17:19:49	N	2650	0	\N	1	N
1029	653	145	message_list	Y	2016-08-15 15:10:05	N	2672	0	\N	1	N
1012	194	145	message_list	N	2016-08-14 17:44:45	N	2657	0	\N	1	N
1013	194	145	message_list	N	2016-08-14 17:44:51	N	2658	0	\N	1	N
1026	708	145	message_list	Y	2016-08-15 15:07:19	N	2669	0	\N	1	N
1011	194	145	message_list	Y	2016-08-14 17:24:30	N	2656	0	\N	1	N
1017	194	145	message_list	Y	2016-08-14 18:23:45	N	2662	0	\N	1	N
1018	583	145	message_list	Y	2016-08-14 18:47:55	N	2663	0	\N	1	N
1030	677	144	post_management	N	2016-08-15 19:41:50	N	465		\N	1	N
1019	194	145	message_list	Y	2016-08-14 23:22:35	N	2664	0	\N	1	N
1020	583	145	message_list	Y	2016-08-14 23:37:32	N	2665	0	\N	1	N
1021	569	144	post_management	N	2016-08-15 11:37:49	N	463		\N	1	N
1023	636	145	message_list	Y	2016-08-15 11:43:45	N	2667	0	\N	1	N
1024	653	144	post_management	N	2016-08-15 13:15:35	N	464		\N	1	N
1027	653	145	message_list	N	2016-08-15 15:07:48	N	2670	0	\N	1	N
1031	194	145	message_list	N	2016-08-15 21:22:45	N	2673	0	\N	1	N
1032	555	145	message_list	N	2016-08-16 01:57:30	N	2674	0	\N	1	N
1033	570	145	message_list	N	2016-08-16 15:32:47	N	2675	0	\N	1	N
1034	569	144	post_management	N	2016-08-16 16:21:58	N	466		\N	1	N
1035	720	144	post_management	N	2016-08-16 20:13:50	N	467		\N	1	N
1036	720	144	post_management	N	2016-08-16 20:15:31	N	468		\N	1	N
1037	720	144	post_management	N	2016-08-16 20:17:09	N	469		\N	1	N
1040	194	145	message_list	N	2016-08-16 20:38:11	N	2678	0	\N	1	N
1022	636	145	message_list	Y	2016-08-15 11:43:01	N	2666	0	\N	1	N
1038	723	145	message_list	Y	2016-08-16 20:20:16	N	2676	0	\N	1	N
1039	727	145	message_list	Y	2016-08-16 20:37:52	N	2677	0	\N	1	N
1041	194	145	message_list	N	2016-08-16 20:38:53	N	2679	0	\N	1	N
1042	729	144	post_management	N	2016-08-16 21:01:03	N	470		\N	1	N
1044	194	145	message_list	N	2016-08-16 21:27:05	N	2681	0	\N	1	N
1043	732	145	message_list	Y	2016-08-16 21:26:18	N	2680	0	\N	1	N
1046	194	145	message_list	N	2016-08-16 22:11:07	N	2683	0	\N	1	N
1045	738	145	message_list	Y	2016-08-16 22:04:52	N	2682	0	\N	1	N
1047	598	144	post_management	N	2016-08-17 00:00:01	N	446	1	\N	\N	N
1048	194	149	campus_buzz	Y	2016-08-17 00:00:01	N	256	1	\N	\N	N
1049	623	145	message_list	Y	2016-08-17 03:20:23	N	2684	0	\N	1	N
1050	647	145	message_list	N	2016-08-17 18:43:17	N	2685	0	\N	1	N
1053	660	145	message_list	Y	2016-08-17 20:59:45	N	2688	0	\N	1	N
1054	754	145	message_list	Y	2016-08-17 21:01:48	N	2689	0	\N	1	N
1052	660	145	message_list	Y	2016-08-17 20:59:35	N	2687	0	\N	1	N
1056	754	145	message_list	Y	2016-08-17 21:03:40	N	2691	0	\N	1	N
1055	660	145	message_list	Y	2016-08-17 21:02:44	N	2690	0	\N	1	N
1060	754	145	message_list	Y	2016-08-17 21:17:09	N	2695	0	\N	1	N
1051	754	145	message_list	Y	2016-08-17 20:55:14	N	2686	0	\N	1	N
1068	643	145	message_list	Y	2016-08-18 01:27:36	N	2697	0	\N	1	N
1057	660	145	message_list	Y	2016-08-17 21:04:06	N	2692	0	\N	1	N
1092	754	145	message_list	Y	2016-08-19 20:23:08	N	2718	0	\N	1	N
1058	754	145	message_list	Y	2016-08-17 21:06:48	N	2693	0	\N	1	N
1094	754	145	message_list	Y	2016-08-19 20:32:43	N	2720	0	\N	1	N
1059	660	145	message_list	Y	2016-08-17 21:16:17	N	2694	0	\N	1	N
1061	755	144	post_management	N	2016-08-17 21:32:40	N	471		\N	1	N
1062	755	144	post_management	N	2016-08-17 21:34:11	N	472		\N	1	N
1063	755	144	post_management	N	2016-08-17 21:35:33	N	473		\N	1	N
1064	755	144	post_management	N	2016-08-17 21:38:18	N	474		\N	1	N
1067	643	145	message_list	Y	2016-08-18 01:23:21	N	2696	0	\N	1	N
1069	660	145	message_list	N	2016-08-18 01:31:06	N	2698	0	\N	1	N
1070	421	145	message_list	Y	2016-08-18 14:24:05	N	2699	0	\N	1	N
1071	636	145	message_list	Y	2016-08-18 18:56:05	N	2700	0	\N	1	N
1072	623	145	message_list	Y	2016-08-18 21:14:15	N	2701	0	\N	1	N
1073	194	145	message_list	N	2016-08-18 21:15:53	N	2702	0	\N	1	N
1075	194	145	message_list	N	2016-08-18 21:17:23	N	2704	0	\N	1	N
1076	194	145	message_list	N	2016-08-18 21:18:01	N	2705	0	\N	1	N
1078	194	145	message_list	N	2016-08-18 21:19:55	N	2707	0	\N	1	N
1093	660	145	message_list	Y	2016-08-19 20:32:26	N	2719	0	\N	1	N
1079	194	145	message_list	N	2016-08-18 21:20:07	N	2708	0	\N	1	N
1077	623	145	message_list	Y	2016-08-18 21:18:59	N	2706	0	\N	1	N
1065	194	149	campus_buzz	Y	2016-08-18 00:00:01	N	250	1	\N	\N	N
1066	194	149	campus_buzz	Y	2016-08-18 00:00:01	N	253	1	\N	\N	N
1112	754	145	message_list	Y	2016-08-19 21:15:40	N	2738	0	\N	1	N
1080	421	145	message_list	Y	2016-08-18 21:24:30	N	2709	0	\N	1	N
1082	421	145	message_list	Y	2016-08-18 21:34:02	N	2711	0	\N	1	N
717	421	144	post_management	Y	2016-06-02 00:00:01	N	400	1	\N	\N	N
1074	194	145	message_list	Y	2016-08-18 21:17:06	N	2703	0	\N	1	N
1081	194	145	message_list	Y	2016-08-18 21:31:56	N	2710	0	\N	1	N
1083	194	145	message_list	Y	2016-08-18 21:34:14	N	2712	0	\N	1	N
1085	194	145	message_list	N	2016-08-19 00:12:29	N	2714	0	\N	1	N
1086	732	145	message_list	Y	2016-08-19 00:13:41	N	2715	0	\N	1	N
1084	732	145	message_list	Y	2016-08-19 00:11:21	N	2713	0	\N	1	N
1087	770	145	message_list	Y	2016-08-19 02:18:27	N	2716	0	\N	1	N
1088	623	145	message_list	Y	2016-08-19 13:43:00	N	2717	0	\N	1	N
1089	772	144	post_management	N	2016-08-19 15:11:02	N	475		\N	1	N
1090	772	144	post_management	N	2016-08-19 15:12:56	N	476		\N	1	N
1091	421	144	post_management	N	2016-08-19 16:49:10	N	477		\N	1	N
1095	754	145	message_list	Y	2016-08-19 20:33:11	N	2721	0	\N	1	N
1103	754	145	message_list	Y	2016-08-19 20:48:04	N	2729	0	\N	1	N
1096	660	145	message_list	Y	2016-08-19 20:33:34	N	2722	0	\N	1	N
1114	569	144	post_management	N	2016-08-20 00:00:01	N	466	1	\N	\N	N
1105	660	145	message_list	Y	2016-08-19 20:49:10	N	2731	0	\N	1	N
1102	660	145	message_list	Y	2016-08-19 20:47:45	N	2728	0	\N	1	N
1101	754	145	message_list	Y	2016-08-19 20:47:06	N	2727	0	\N	1	N
1098	660	145	message_list	Y	2016-08-19 20:46:22	N	2724	0	\N	1	N
1104	754	145	message_list	Y	2016-08-19 20:48:20	N	2730	0	\N	1	N
1100	754	145	message_list	Y	2016-08-19 20:46:47	N	2726	0	\N	1	N
1097	754	145	message_list	Y	2016-08-19 20:34:17	N	2723	0	\N	1	N
1099	754	145	message_list	Y	2016-08-19 20:46:37	N	2725	0	\N	1	N
1106	660	145	message_list	Y	2016-08-19 20:50:56	N	2732	0	\N	1	N
1115	732	144	post_management	N	2016-08-20 01:13:40	N	478		\N	1	N
1116	780	145	message_list	N	2016-08-20 15:24:10	N	2740	0	\N	1	N
1107	754	145	message_list	Y	2016-08-19 20:51:08	N	2733	0	\N	1	N
1111	754	145	message_list	Y	2016-08-19 20:55:02	N	2737	0	\N	1	N
1109	754	145	message_list	Y	2016-08-19 20:51:47	N	2735	0	\N	1	N
1108	754	145	message_list	Y	2016-08-19 20:51:23	N	2734	0	\N	1	N
1117	772	144	post_management	N	2016-08-20 15:24:51	N	479		\N	1	N
1110	660	145	message_list	Y	2016-08-19 20:53:34	N	2736	0	\N	1	N
1113	754	145	message_list	Y	2016-08-19 21:16:53	N	2739	0	\N	1	N
1118	570	145	message_list	Y	2016-08-20 15:36:52	N	2741	0	\N	1	N
1119	780	145	message_list	N	2016-08-20 15:46:06	N	2742	0	\N	1	N
1120	570	145	message_list	Y	2016-08-20 15:46:58	N	2743	0	\N	1	N
1121	780	145	message_list	N	2016-08-20 15:48:35	N	2744	0	\N	1	N
1122	780	145	message_list	N	2016-08-20 15:48:49	N	2745	0	\N	1	N
1124	780	145	message_list	N	2016-08-20 15:50:44	N	2747	0	\N	1	N
1123	570	145	message_list	Y	2016-08-20 15:49:13	N	2746	0	\N	1	N
1127	194	145	message_list	N	2016-08-20 15:57:58	N	2750	0	\N	1	N
1126	194	145	message_list	Y	2016-08-20 15:57:17	N	2749	0	\N	1	N
1129	194	145	message_list	Y	2016-08-20 16:07:59	N	2752	0	\N	1	N
1130	780	145	message_list	N	2016-08-20 16:14:11	N	2753	0	\N	1	N
1125	570	145	message_list	Y	2016-08-20 15:56:31	N	2748	0	\N	1	N
1131	514	144	post_management	N	2016-08-20 16:17:22	N	480		\N	1	N
1128	421	145	message_list	Y	2016-08-20 15:59:49	N	2751	0	\N	1	N
1132	460	145	message_list	N	2016-08-20 17:04:46	N	2754	0	\N	1	N
1133	460	145	message_list	N	2016-08-20 17:05:18	N	2755	0	\N	1	N
1134	740	145	message_list	N	2016-08-20 17:15:42	N	2756	0	\N	1	N
1135	660	145	message_list	Y	2016-08-20 17:16:28	N	2757	0	\N	1	N
1136	740	145	message_list	N	2016-08-20 17:18:01	N	2758	0	\N	1	N
1137	740	145	message_list	Y	2016-08-20 17:20:58	N	2759	0	\N	1	N
1138	772	145	message_list	Y	2016-08-20 17:26:48	N	2760	0	\N	1	N
1139	460	145	message_list	N	2016-08-20 17:29:06	N	2761	0	\N	1	N
1140	772	144	post_management	N	2016-08-20 17:31:09	N	481		\N	1	N
1207	845	145	message_list	Y	2016-08-29 01:04:29	N	2804	0	\N	1	N
1141	421	145	message_list	Y	2016-08-20 21:38:09	N	2762	0	\N	1	N
1142	194	145	message_list	Y	2016-08-20 21:41:13	N	2763	0	\N	1	N
1143	194	145	message_list	N	2016-08-20 21:42:38	N	2764	0	\N	1	N
1144	194	145	message_list	N	2016-08-20 21:43:05	N	2765	0	\N	1	N
1145	194	145	message_list	N	2016-08-20 22:05:20	N	2766	0	\N	1	N
1146	636	145	message_list	Y	2016-08-20 22:46:49	N	2767	0	\N	1	N
1147	801	144	post_management	N	2016-08-20 23:48:47	N	482		\N	1	N
1149	772	145	message_list	Y	2016-08-21 00:21:08	N	2769	0	\N	1	N
1150	421	145	message_list	Y	2016-08-21 00:21:24	N	2770	0	\N	1	N
1151	780	145	message_list	N	2016-08-21 14:06:52	N	2771	0	\N	1	N
1152	570	145	message_list	Y	2016-08-21 14:07:19	N	2772	0	\N	1	N
1153	664	145	message_list	N	2016-08-21 15:55:12	N	2773	0	\N	1	N
1154	772	144	post_management	N	2016-08-22 12:38:22	N	483		\N	1	N
1155	811	144	post_management	N	2016-08-22 22:20:53	N	484		\N	1	N
1157	194	144	post_management	N	2016-08-23 03:07:33	N	485		\N	1	N
1158	553	145	message_list	Y	2016-08-23 03:36:06	N	2774	0	\N	1	N
1156	194	149	campus_buzz	Y	2016-08-23 00:00:01	N	254	1	\N	\N	N
1159	194	145	message_list	N	2016-08-23 03:38:12	N	2775	0	\N	1	N
1160	194	145	message_list	N	2016-08-23 03:38:33	N	2776	0	\N	1	N
1162	553	145	message_list	Y	2016-08-23 03:43:48	N	2778	0	\N	1	N
1161	553	145	message_list	Y	2016-08-23 03:43:38	N	2777	0	\N	1	N
1163	609	144	post_management	N	2016-08-24 02:01:22	N	486		\N	1	N
1165	194	145	message_list	N	2016-08-24 18:11:29	N	2780	0	\N	1	N
1190	194	145	message_list	Y	2016-08-28 16:19:03	N	2794	0	\N	1	N
1168	194	145	message_list	N	2016-08-24 18:14:02	N	2783	0	\N	1	N
1166	631	145	message_list	Y	2016-08-24 18:13:29	N	2781	0	\N	1	N
1167	631	145	message_list	Y	2016-08-24 18:13:55	N	2782	0	\N	1	N
1164	631	145	message_list	Y	2016-08-24 18:10:16	N	2779	0	\N	1	N
1169	631	145	message_list	Y	2016-08-24 18:14:38	N	2784	0	\N	1	N
1185	9	149	campus_buzz	Y	2016-08-28 00:00:01	N	255	1	\N	\N	N
1171	194	145	message_list	N	2016-08-24 19:16:36	N	2786	0	\N	1	N
1170	631	145	message_list	Y	2016-08-24 18:15:34	N	2785	0	\N	1	N
1172	569	145	message_list	N	2016-08-24 22:19:42	N	2787	0	\N	1	N
1173	460	144	post_management	N	2016-08-24 22:50:23	N	487		\N	1	N
1174	460	144	post_management	N	2016-08-24 22:51:49	N	488		\N	1	N
1175	569	144	post_management	N	2016-08-26 00:00:01	N	463	1	\N	\N	N
1176	772	144	post_management	N	2016-08-26 00:00:01	N	475	1	\N	\N	N
1177	772	144	post_management	N	2016-08-26 01:33:09	N	489		\N	1	N
1178	643	144	post_management	N	2016-08-26 22:00:49	N	490		\N	1	N
1179	739	144	post_management	N	2016-08-27 17:23:26	N	491		\N	1	N
1180	739	144	post_management	N	2016-08-27 17:24:44	N	492		\N	1	N
1181	653	145	message_list	N	2016-08-27 18:08:02	N	2788	0	\N	1	N
1182	739	144	post_management	N	2016-08-27 18:08:43	N	493		\N	1	N
1183	598	145	message_list	Y	2016-08-27 22:18:37	N	2789	0	\N	1	N
1184	421	144	post_management	N	2016-08-27 22:39:47	N	494		\N	1	N
1186	641	145	message_list	Y	2016-08-28 14:38:05	N	2790	0	\N	1	N
1187	194	145	message_list	N	2016-08-28 15:44:45	N	2791	0	\N	1	N
1188	194	145	message_list	N	2016-08-28 15:44:57	N	2792	0	\N	1	N
1198	194	145	message_list	N	2016-08-28 18:09:51	N	2796	0	\N	1	N
1189	641	145	message_list	Y	2016-08-28 15:58:29	N	2793	0	\N	1	N
1191	842	144	post_management	N	2016-08-28 17:06:11	N	495		\N	1	N
1192	842	144	post_management	N	2016-08-28 17:11:37	N	496		\N	1	N
1193	842	144	post_management	N	2016-08-28 17:14:55	N	497		\N	1	N
1194	842	144	post_management	N	2016-08-28 17:18:22	N	498		\N	1	N
1195	842	144	post_management	N	2016-08-28 17:25:25	N	499		\N	1	N
1196	842	144	post_management	N	2016-08-28 17:37:14	N	500		\N	1	N
1197	641	145	message_list	Y	2016-08-28 18:06:54	N	2795	0	\N	1	N
1199	844	144	post_management	N	2016-08-28 18:12:18	N	501		\N	1	N
1200	641	145	message_list	Y	2016-08-28 18:53:33	N	2797	0	\N	1	N
1201	194	145	message_list	N	2016-08-28 23:14:48	N	2798	0	\N	1	N
1202	194	145	message_list	N	2016-08-28 23:15:48	N	2799	0	\N	1	N
1204	641	145	message_list	Y	2016-08-29 00:32:48	N	2801	0	\N	1	N
1205	9	145	message_list	N	2016-08-29 01:01:04	N	2802	0	\N	1	N
1206	9	145	message_list	N	2016-08-29 01:01:25	N	2803	0	\N	1	N
1212	9	145	message_list	N	2016-08-29 15:28:26	N	2809	0	\N	1	N
1208	9	145	message_list	N	2016-08-29 01:05:17	N	2805	0	\N	1	N
1203	845	145	message_list	Y	2016-08-28 23:40:56	N	2800	0	\N	1	N
1209	9	145	message_list	N	2016-08-29 01:40:16	N	2806	0	\N	1	N
1210	845	145	message_list	Y	2016-08-29 05:15:51	N	2807	0	\N	1	N
1211	194	145	message_list	N	2016-08-29 12:34:11	N	2808	0	\N	1	N
1213	9	144	post_management	N	2016-08-29 21:27:49	N	502		\N	1	N
1214	194	145	message_list	N	2016-08-29 21:43:19	N	2810	0	\N	1	N
1216	598	145	message_list	Y	2016-08-30 00:48:57	N	2812	0	\N	1	N
1215	598	145	message_list	Y	2016-08-30 00:48:43	N	2811	0	\N	1	N
1217	641	145	message_list	Y	2016-08-30 02:02:25	N	2813	0	\N	1	N
1219	772	145	message_list	Y	2016-08-30 03:10:06	N	2815	0	\N	1	N
1222	9	145	message_list	N	2016-08-30 12:50:59	N	2818	0	\N	1	N
1221	9	145	message_list	N	2016-08-30 12:50:07	N	2817	0	\N	1	N
1220	636	145	message_list	Y	2016-08-30 12:46:25	N	2816	0	\N	1	N
1148	421	145	message_list	Y	2016-08-21 00:19:21	N	2768	0	\N	1	N
1223	673	145	message_list	N	2016-08-30 14:45:04	N	2819	0	\N	1	N
1224	772	145	message_list	N	2016-08-30 14:50:38	N	2820	0	\N	1	N
1225	778	144	post_management	N	2016-08-30 20:59:49	N	503		\N	1	N
1239	664	145	message_list	N	2016-08-31 16:50:27	N	2821	0	\N	1	N
1240	194	145	message_list	N	2016-08-31 21:07:12	N	2822	0	\N	1	N
1241	636	145	message_list	Y	2016-08-31 21:09:30	N	2823	0	\N	1	N
1242	194	145	message_list	N	2016-08-31 21:57:12	N	2824	0	\N	1	N
1279	421	144	post_management	N	2016-09-07 17:04:38	N	550		\N	1	N
1245	194	145	message_list	N	2016-08-31 22:00:20	N	2827	0	\N	1	N
1243	636	145	message_list	Y	2016-08-31 21:58:51	N	2825	0	\N	1	N
1248	194	145	message_list	N	2016-08-31 22:01:43	N	2830	0	\N	1	N
1251	194	145	message_list	N	2016-08-31 22:02:44	N	2833	0	\N	1	N
1226	194	144	post_management	Y	2016-08-31 00:00:01	N	419	1	\N	\N	N
1227	194	144	post_management	Y	2016-08-31 00:00:01	N	415	1	\N	\N	N
1229	194	144	post_management	Y	2016-08-31 00:00:01	N	420	1	\N	\N	N
1228	194	144	post_management	Y	2016-08-31 00:00:01	N	417	1	\N	\N	N
1231	194	144	post_management	Y	2016-08-31 00:00:01	N	422	1	\N	\N	N
1230	194	144	post_management	Y	2016-08-31 00:00:01	N	421	1	\N	\N	N
1233	194	144	post_management	Y	2016-08-31 00:00:01	N	424	1	\N	\N	N
1232	194	144	post_management	Y	2016-08-31 00:00:01	N	423	1	\N	\N	N
1235	194	144	post_management	Y	2016-08-31 00:00:01	N	426	1	\N	\N	N
1234	194	144	post_management	Y	2016-08-31 00:00:01	N	425	1	\N	\N	N
1238	194	149	campus_buzz	Y	2016-08-31 00:00:01	N	236	1	\N	\N	N
1236	194	144	post_management	Y	2016-08-31 00:00:01	N	427	1	\N	\N	N
1250	636	145	message_list	Y	2016-08-31 22:02:21	N	2832	0	\N	1	N
1249	636	145	message_list	Y	2016-08-31 22:02:06	N	2831	0	\N	1	N
1247	636	145	message_list	Y	2016-08-31 22:01:12	N	2829	0	\N	1	N
1246	636	145	message_list	Y	2016-08-31 22:00:46	N	2828	0	\N	1	N
1244	636	145	message_list	Y	2016-08-31 21:58:58	N	2826	0	\N	1	N
1252	194	145	message_list	N	2016-08-31 22:14:49	N	2834	0	\N	1	N
1253	636	145	message_list	Y	2016-08-31 22:27:02	N	2835	0	\N	1	N
1255	194	145	message_list	N	2016-08-31 22:49:49	N	2837	0	\N	1	N
1256	740	145	message_list	N	2016-09-01 15:58:39	N	2838	0	\N	1	N
1257	772	144	post_management	N	2016-09-02 00:00:01	N	479	1	\N	\N	N
1258	766	145	message_list	Y	2016-09-02 01:23:23	N	2839	0	\N	1	N
1261	766	145	message_list	N	2016-09-03 18:55:20	N	2842	0	\N	1	N
1260	755	145	message_list	Y	2016-09-02 01:27:37	N	2841	0	\N	1	N
1262	729	145	message_list	N	2016-09-03 23:16:33	N	2843	0	\N	1	N
1259	755	145	message_list	Y	2016-09-02 01:27:25	N	2840	0	\N	1	N
1271	766	145	message_list	N	2016-09-06 23:26:45	N	2844	0	\N	1	N
1272	\N	144	post_management	N	2016-09-07 01:35:26	N	535		\N	1	N
1273	\N	144	post_management	N	2016-09-07 01:38:29	N	536		\N	1	N
1274	636	145	message_list	N	2016-09-07 13:22:20	N	2845	0	\N	1	N
1275	194	144	post_management	N	2016-09-07 14:59:28	N	547		\N	1	N
1276	194	144	post_management	N	2016-09-07 15:01:22	N	548		\N	1	N
1277	194	144	post_management	N	2016-09-07 15:07:30	N	549		\N	1	N
1278	766	145	message_list	N	2016-09-07 16:57:57	N	2846	0	\N	1	N
1280	338	144	post_management	N	2016-09-08 00:00:01	N	435	1	\N	\N	N
1281	194	144	post_management	N	2016-09-09 02:21:25	N	551		\N	1	N
1282	194	144	post_management	N	2016-09-09 02:23:10	N	552		\N	1	N
1283	194	144	post_management	N	2016-09-09 02:24:09	N	553		\N	1	N
1284	194	144	post_management	N	2016-09-09 02:26:15	N	554		\N	1	N
1285	194	144	post_management	N	2016-09-09 02:27:23	N	555		\N	1	N
1286	194	144	post_management	N	2016-09-09 02:29:04	N	556		\N	1	N
1287	194	144	post_management	N	2016-09-09 02:30:37	N	557		\N	1	N
1288	925	144	post_management	N	2016-09-09 21:03:39	N	558		\N	1	N
1294	581	144	post_management	N	2016-09-11 00:00:01	N	444	1	\N	\N	N
1295	581	144	post_management	N	2016-09-11 00:00:01	N	445	1	\N	\N	N
1296	421	144	post_management	N	2016-09-11 00:00:01	N	524	1	\N	\N	N
1297	421	144	post_management	N	2016-09-11 00:00:01	N	550	1	\N	\N	N
1299	664	144	post_management	N	2016-09-12 00:00:01	N	448	1	\N	\N	N
1300	664	144	post_management	N	2016-09-12 00:00:01	N	449	1	\N	\N	N
1301	555	144	post_management	N	2016-09-12 00:00:01	N	450	1	\N	\N	N
1302	612	144	post_management	N	2016-09-12 00:00:01	N	451	1	\N	\N	N
1303	868	144	post_management	N	2016-09-12 00:00:01	N	514	1	\N	\N	N
1304	796	144	post_management	N	2016-09-12 15:04:00	N	559		\N	1	N
1305	612	144	post_management	N	2016-09-13 00:00:02	N	452	1	\N	\N	N
1291	194	144	post_management	Y	2016-09-11 00:00:01	N	436	1	\N	\N	N
1292	194	144	post_management	Y	2016-09-11 00:00:01	N	437	1	\N	\N	N
1293	194	144	post_management	Y	2016-09-11 00:00:01	N	439	1	\N	\N	N
1298	194	149	campus_buzz	Y	2016-09-11 00:00:01	N	240	1	\N	\N	N
1289	194	144	post_management	Y	2016-09-10 00:00:01	N	438	1	\N	\N	N
1290	194	144	post_management	Y	2016-09-10 00:00:01	N	440	1	\N	\N	N
1268	194	149	campus_buzz	Y	2016-09-04 00:00:01	N	239	1	\N	\N	N
1254	636	145	message_list	Y	2016-08-31 22:39:07	N	2836	0	\N	1	N
1306	9	144	post_management	Y	2016-09-13 00:00:02	N	453	1	\N	\N	N
1307	9	144	post_management	Y	2016-09-13 00:00:02	N	454	1	\N	\N	N
1308	9	144	post_management	Y	2016-09-13 00:00:02	N	455	1	\N	\N	N
1309	9	144	post_management	Y	2016-09-13 00:00:02	N	457	1	\N	\N	N
1269	9	144	post_management	Y	2016-09-05 00:00:01	N	433	1	\N	\N	N
1270	9	144	post_management	Y	2016-09-05 00:00:01	N	434	1	\N	\N	N
1263	9	144	post_management	Y	2016-09-04 00:00:01	N	428	1	\N	\N	N
1264	9	144	post_management	Y	2016-09-04 00:00:01	N	429	1	\N	\N	N
1265	9	144	post_management	Y	2016-09-04 00:00:01	N	430	1	\N	\N	N
1266	9	144	post_management	Y	2016-09-04 00:00:01	N	431	1	\N	\N	N
1310	688	144	post_management	N	2016-09-13 00:00:02	N	458	1	\N	\N	N
1311	612	144	post_management	N	2016-09-13 00:00:02	N	462	1	\N	\N	N
1312	729	144	post_management	N	2016-09-13 00:00:02	N	470	1	\N	\N	N
1313	868	144	post_management	N	2016-09-13 00:00:02	N	508	1	\N	\N	N
1314	946	144	post_management	N	2016-09-13 00:40:23	N	560		\N	1	N
1315	862	144	post_management	N	2016-09-13 17:53:13	N	561		\N	1	N
1316	862	144	post_management	N	2016-09-13 21:09:22	N	562		\N	1	N
1317	964	144	post_management	N	2016-09-14 03:55:16	N	563		\N	1	N
1318	973	145	message_list	N	2016-09-14 18:37:22	N	2847	0	\N	1	N
1320	973	145	message_list	N	2016-09-14 18:54:15	N	2849	0	\N	1	N
1321	653	144	post_management	N	2016-09-15 00:00:01	N	464	1	\N	\N	N
1322	677	144	post_management	N	2016-09-15 00:00:01	N	465	1	\N	\N	N
1323	778	144	post_management	N	2016-09-15 00:00:01	N	503	1	\N	\N	N
1324	9	144	post_management	N	2016-09-15 00:19:02	N	564		\N	1	N
1325	9	144	post_management	N	2016-09-15 00:21:42	N	565		\N	1	N
1326	707	145	message_list	N	2016-09-15 13:08:27	N	2850	0	\N	1	N
1327	720	144	post_management	N	2016-09-16 00:00:01	N	467	1	\N	\N	N
1328	720	144	post_management	N	2016-09-16 00:00:01	N	468	1	\N	\N	N
1329	720	144	post_management	N	2016-09-16 00:00:01	N	469	1	\N	\N	N
1237	772	144	post_management	Y	2016-08-31 00:00:01	N	476	1	\N	\N	N
1319	974	145	message_list	Y	2016-09-14 18:45:24	N	2848	0	\N	1	N
1218	858	145	message_list	Y	2016-08-30 03:08:41	N	2814	0	\N	1	N
1330	988	144	post_management	N	2016-09-16 21:22:41	N	566		\N	1	N
1331	755	144	post_management	N	2016-09-17 00:00:01	N	471	1	\N	\N	N
1332	755	144	post_management	N	2016-09-17 00:00:01	N	472	1	\N	\N	N
1333	755	144	post_management	N	2016-09-17 00:00:01	N	473	1	\N	\N	N
1334	755	144	post_management	N	2016-09-17 00:00:01	N	474	1	\N	\N	N
1335	796	144	post_management	N	2016-09-17 00:00:01	N	559	1	\N	\N	N
1336	778	144	post_management	N	2016-09-17 18:50:41	N	567		\N	1	N
1337	194	144	post_management	N	2016-09-18 17:34:47	N	568		\N	1	N
1338	194	144	post_management	N	2016-09-18 17:40:00	N	569		\N	1	N
1339	194	144	post_management	N	2016-09-18 17:45:28	N	570		\N	1	N
1340	990	144	post_management	N	2016-09-18 18:37:59	N	571		\N	1	N
1341	732	144	post_management	N	2016-09-19 00:00:01	N	478	1	\N	\N	N
1342	1000	144	post_management	N	2016-09-19 15:47:16	N	572		\N	1	N
1343	978	144	post_management	N	2016-09-19 17:00:56	N	573		\N	1	N
1344	978	144	post_management	N	2016-09-19 17:02:46	N	574		\N	1	N
1345	978	144	post_management	N	2016-09-19 17:06:48	N	575		\N	1	N
1346	772	144	post_management	N	2016-09-20 00:00:01	N	481	1	\N	\N	N
1347	801	144	post_management	N	2016-09-20 00:00:01	N	482	1	\N	\N	N
1348	347	144	post_management	N	2016-09-20 22:59:23	N	576		\N	1	N
1349	1009	145	message_list	N	2016-09-20 23:00:26	N	2851	0	\N	1	N
1350	925	144	post_management	N	2016-09-20 23:02:42	N	577		\N	1	N
1351	1016	145	message_list	N	2016-09-20 23:55:05	N	2852	0	\N	1	N
1352	988	145	message_list	N	2016-09-20 23:56:23	N	2853	0	\N	1	N
1353	1016	145	message_list	N	2016-09-21 00:27:30	N	2854	0	\N	1	N
1354	988	145	message_list	N	2016-09-21 00:29:16	N	2855	0	\N	1	N
1375	1016	145	message_list	N	2016-09-22 16:24:11	N	2871	0	\N	1	N
1357	988	145	message_list	N	2016-09-21 00:31:34	N	2858	0	\N	1	N
1376	979	144	post_management	N	2016-09-22 19:36:38	N	583		\N	1	N
1358	988	145	message_list	N	2016-09-21 00:32:06	N	2859	0	\N	1	N
1377	979	144	post_management	N	2016-09-22 19:38:58	N	584		\N	1	N
1378	979	144	post_management	N	2016-09-22 19:40:59	N	585		\N	1	N
1360	988	145	message_list	N	2016-09-21 00:46:37	N	2861	0	\N	1	N
1355	1016	145	message_list	Y	2016-09-21 00:31:10	N	2856	0	\N	1	N
1359	1016	145	message_list	Y	2016-09-21 00:32:41	N	2860	0	\N	1	N
1356	1016	145	message_list	Y	2016-09-21 00:31:23	N	2857	0	\N	1	N
1379	979	144	post_management	N	2016-09-22 19:43:41	N	586		\N	1	N
1380	979	144	post_management	N	2016-09-22 19:46:07	N	587		\N	1	N
1381	979	144	post_management	N	2016-09-22 19:47:35	N	588		\N	1	N
1364	988	145	message_list	N	2016-09-21 01:22:05	N	2865	0	\N	1	N
1363	1016	145	message_list	Y	2016-09-21 01:21:32	N	2864	0	\N	1	N
1361	1016	145	message_list	Y	2016-09-21 01:20:48	N	2862	0	\N	1	N
1365	1020	145	message_list	N	2016-09-21 02:29:34	N	2866	0	\N	1	N
1366	1020	145	message_list	N	2016-09-21 02:31:37	N	2867	0	\N	1	N
1368	1016	145	message_list	N	2016-09-21 21:40:35	N	2869	0	\N	1	N
1362	988	145	message_list	Y	2016-09-21 01:21:12	N	2863	0	\N	1	N
1369	194	144	post_management	N	2016-09-21 23:47:56	N	581		\N	1	N
1370	772	144	post_management	N	2016-09-22 00:00:01	N	483	1	\N	\N	N
1371	811	144	post_management	N	2016-09-22 00:00:01	N	484	1	\N	\N	N
1372	609	144	post_management	N	2016-09-22 00:00:01	N	486	1	\N	\N	N
1373	998	144	post_management	N	2016-09-22 15:07:23	N	582		\N	1	N
1374	1028	145	message_list	N	2016-09-22 15:50:07	N	2870	0	\N	1	N
1382	958	144	post_management	N	2016-09-23 14:43:25	N	589		\N	1	N
1383	738	145	message_list	N	2016-09-23 14:48:17	N	2872	0	\N	1	N
1384	979	145	message_list	N	2016-09-23 15:00:14	N	2873	0	\N	1	N
1385	935	144	post_management	N	2016-09-23 15:04:38	N	590		\N	1	N
1386	935	144	post_management	N	2016-09-23 15:10:12	N	591		\N	1	N
1387	1044	144	post_management	N	2016-09-23 15:31:20	N	592		\N	1	N
1388	1044	145	message_list	Y	2016-09-23 15:36:08	N	2874	0	\N	1	N
1389	958	145	message_list	N	2016-09-23 15:44:00	N	2875	0	\N	1	N
1390	1044	145	message_list	Y	2016-09-23 15:44:13	N	2876	0	\N	1	N
1391	460	144	post_management	N	2016-09-24 00:00:01	N	487	1	\N	\N	N
1392	460	144	post_management	N	2016-09-24 00:00:01	N	488	1	\N	\N	N
1393	844	144	post_management	N	2016-09-24 00:00:01	N	501	1	\N	\N	N
1394	1021	144	post_management	N	2016-09-24 12:45:52	N	593		\N	1	N
1395	1049	144	post_management	N	2016-09-25 18:16:41	N	594		\N	1	N
1396	1049	144	post_management	N	2016-09-25 18:17:46	N	595		\N	1	N
1397	643	144	post_management	N	2016-09-26 00:00:01	N	490	1	\N	\N	N
1398	842	144	post_management	N	2016-09-27 00:00:01	N	497	1	\N	\N	N
1399	421	144	post_management	N	2016-09-27 00:00:01	N	494	1	\N	\N	N
1400	842	144	post_management	N	2016-09-27 00:00:01	N	496	1	\N	\N	N
1401	842	144	post_management	N	2016-09-27 00:00:01	N	495	1	\N	\N	N
1402	842	144	post_management	N	2016-09-27 00:00:01	N	500	1	\N	\N	N
1403	842	144	post_management	N	2016-09-27 00:00:01	N	499	1	\N	\N	N
1404	842	144	post_management	N	2016-09-27 00:00:01	N	498	1	\N	\N	N
1405	432	144	post_management	N	2016-09-27 15:13:39	N	596		\N	1	N
1406	850	145	message_list	N	2016-09-27 15:19:44	N	2877	0	\N	1	N
1407	979	145	message_list	N	2016-09-27 15:42:13	N	2878	0	\N	1	N
1408	194	144	post_management	N	2016-09-28 14:09:03	N	597		\N	1	N
1409	729	145	message_list	N	2016-09-28 17:35:25	N	2879	0	\N	1	N
1410	1062	144	post_management	N	2016-09-28 19:41:39	N	598		\N	1	N
1411	1064	145	message_list	N	2016-09-29 03:17:24	N	2880	0	\N	1	N
1412	979	145	message_list	N	2016-09-29 16:39:56	N	2881	0	\N	1	N
1413	329	144	post_management	N	2016-09-29 20:04:15	N	599		\N	1	N
1414	772	144	post_management	N	2016-09-30 00:00:01	N	578	1	\N	\N	N
1415	992	144	post_management	N	2016-09-30 03:49:26	N	600		\N	1	N
1416	1065	144	post_management	N	2016-09-30 15:16:42	N	601		\N	1	N
1417	1066	145	message_list	Y	2016-09-30 15:17:29	N	2882	0	\N	1	N
1418	988	144	post_management	N	2016-10-01 00:00:01	N	566	1	\N	\N	N
1419	778	144	post_management	N	2016-10-01 00:00:01	N	567	1	\N	\N	N
1459	862	144	post_management	N	2016-10-12 00:00:01	N	562	1	\N	\N	N
1421	194	145	message_list	N	2016-10-01 05:34:22	N	2884	0	\N	1	N
1420	1073	145	message_list	Y	2016-10-01 05:20:49	N	2883	0	\N	1	N
1422	194	145	message_list	N	2016-10-01 06:04:55	N	2885	0	\N	1	N
1367	1023	145	message_list	Y	2016-09-21 03:50:54	N	2868	0	\N	1	N
1423	194	145	message_list	N	2016-10-01 06:06:07	N	2886	0	\N	1	N
1427	194	145	message_list	N	2016-10-02 01:53:44	N	2889	0	\N	1	N
1460	1104	144	post_management	N	2016-10-12 00:04:29	N	609		\N	1	N
1430	1073	145	message_list	N	2016-10-03 02:27:57	N	2892	0	\N	1	N
1429	1073	145	message_list	Y	2016-10-03 02:26:57	N	2891	0	\N	1	N
1428	1073	145	message_list	Y	2016-10-03 00:55:50	N	2890	0	\N	1	N
1425	1073	145	message_list	Y	2016-10-02 01:49:02	N	2887	0	\N	1	N
1426	1073	145	message_list	Y	2016-10-02 01:49:25	N	2888	0	\N	1	N
1424	194	149	campus_buzz	Y	2016-10-02 00:00:01	N	241	1	\N	\N	N
1431	460	144	post_management	N	2016-10-03 12:57:43	N	602		\N	1	N
1435	1073	145	message_list	Y	2016-10-04 03:09:06	N	2895	0	\N	1	N
1433	194	145	message_list	Y	2016-10-03 23:46:29	N	2894	0	\N	1	N
1436	1092	145	message_list	N	2016-10-05 21:28:41	N	2896	0	\N	1	N
1437	194	144	post_management	N	2016-10-05 23:21:14	N	603		\N	1	N
1438	194	144	post_management	N	2016-10-05 23:23:43	N	604		\N	1	N
1439	194	144	post_management	N	2016-10-05 23:26:14	N	605		\N	1	N
1440	194	144	post_management	N	2016-10-05 23:27:48	N	606		\N	1	N
1441	910	144	post_management	N	2016-10-06 00:00:01	N	531	1	\N	\N	N
1442	910	144	post_management	N	2016-10-06 00:00:01	N	533	1	\N	\N	N
1443	910	144	post_management	N	2016-10-06 00:00:01	N	532	1	\N	\N	N
1444	754	145	message_list	Y	2016-10-07 18:15:22	N	2897	0	\N	1	N
1432	1073	145	message_list	Y	2016-10-03 23:43:25	N	2893	0	\N	1	N
1445	194	145	message_list	Y	2016-10-07 18:19:23	N	2898	0	\N	1	N
1446	754	145	message_list	Y	2016-10-07 18:19:44	N	2899	0	\N	1	N
1447	414	144	post_management	N	2016-10-08 13:06:14	N	607		\N	1	N
1448	414	144	post_management	N	2016-10-08 13:08:42	N	608		\N	1	N
1457	925	144	post_management	N	2016-10-10 00:00:01	N	558	1	\N	\N	N
1458	1044	144	post_management	N	2016-10-11 00:00:01	N	592	1	\N	\N	N
1463	194	145	message_list	N	2016-10-12 11:15:25	N	2903	0	\N	1	N
1464	194	144	post_management	N	2016-10-12 13:18:07	N	610		\N	1	N
1465	414	144	post_management	N	2016-10-12 13:19:30	N	611		\N	1	N
1451	194	144	post_management	Y	2016-10-10 00:00:01	N	552	1	\N	\N	N
1467	194	145	message_list	N	2016-10-12 13:37:37	N	2905	0	\N	1	N
1466	1078	145	message_list	Y	2016-10-12 13:36:59	N	2904	0	\N	1	N
1454	194	144	post_management	Y	2016-10-10 00:00:01	N	555	1	\N	\N	N
1462	194	145	message_list	Y	2016-10-12 11:14:47	N	2902	0	\N	1	N
1450	194	144	post_management	Y	2016-10-10 00:00:01	N	551	1	\N	\N	N
1452	194	144	post_management	Y	2016-10-10 00:00:01	N	553	1	\N	\N	N
1453	194	144	post_management	Y	2016-10-10 00:00:01	N	554	1	\N	\N	N
1455	194	144	post_management	Y	2016-10-10 00:00:01	N	556	1	\N	\N	N
1456	194	144	post_management	Y	2016-10-10 00:00:01	N	557	1	\N	\N	N
1468	1078	145	message_list	Y	2016-10-12 13:38:12	N	2906	0	\N	1	N
1461	520	145	message_list	Y	2016-10-12 05:18:38	N	2901	0	\N	1	N
1449	1078	145	message_list	Y	2016-10-08 15:15:34	N	2900	0	\N	1	N
1469	1105	144	post_management	N	2016-10-12 14:17:22	N	612		\N	1	N
1470	946	144	post_management	N	2016-10-13 00:00:01	N	560	1	\N	\N	N
1471	862	144	post_management	N	2016-10-13 00:00:01	N	561	1	\N	\N	N
1475	869	144	post_management	Y	2016-10-16 00:00:01	N	521	1	\N	\N	N
1474	869	144	post_management	Y	2016-10-16 00:00:01	N	520	1	\N	\N	N
1478	869	144	post_management	N	2016-10-16 21:11:16	N	613		\N	1	N
1479	869	144	post_management	N	2016-10-16 21:12:29	N	614		\N	1	N
1480	1021	144	post_management	N	2016-10-18 00:00:01	N	593	1	\N	\N	N
1481	194	144	post_management	Y	2016-10-19 00:00:01	N	568	1	\N	\N	N
1477	194	149	campus_buzz	Y	2016-10-16 00:00:01	N	242	1	\N	\N	N
1472	1073	145	message_list	Y	2016-10-13 17:40:03	N	2907	0	\N	1	N
1476	9	144	post_management	Y	2016-10-16 00:00:01	N	564	1	\N	\N	N
1473	9	144	post_management	Y	2016-10-15 00:00:01	N	565	1	\N	\N	N
1484	990	144	post_management	N	2016-10-19 00:00:01	N	571	1	\N	\N	N
1485	978	144	post_management	N	2016-10-19 00:00:01	N	573	1	\N	\N	N
1486	978	144	post_management	N	2016-10-19 00:00:01	N	574	1	\N	\N	N
1487	978	144	post_management	N	2016-10-19 00:00:01	N	575	1	\N	\N	N
1488	347	144	post_management	N	2016-10-21 00:00:01	N	576	1	\N	\N	N
1489	925	144	post_management	N	2016-10-21 00:00:01	N	577	1	\N	\N	N
1490	421	144	post_management	N	2016-10-21 14:03:50	N	615		\N	1	N
1434	421	144	post_management	Y	2016-10-04 00:00:01	N	522	1	\N	\N	N
1491	979	144	post_management	N	2016-10-22 00:00:01	N	583	1	\N	\N	N
1492	979	144	post_management	N	2016-10-22 00:00:01	N	584	1	\N	\N	N
1493	979	144	post_management	N	2016-10-22 00:00:01	N	585	1	\N	\N	N
1494	979	144	post_management	N	2016-10-22 00:00:01	N	586	1	\N	\N	N
1495	979	144	post_management	N	2016-10-22 00:00:01	N	587	1	\N	\N	N
1496	979	144	post_management	N	2016-10-22 00:00:01	N	588	1	\N	\N	N
1497	958	144	post_management	N	2016-10-22 00:00:01	N	589	1	\N	\N	N
1499	194	145	message_list	N	2016-10-22 23:23:53	N	2909	0	\N	1	N
1500	998	144	post_management	N	2016-10-23 00:00:01	N	582	1	\N	\N	N
1501	935	144	post_management	N	2016-10-24 00:00:01	N	590	1	\N	\N	N
1502	935	144	post_management	N	2016-10-24 00:00:01	N	591	1	\N	\N	N
1503	1111	144	post_management	N	2016-10-24 17:00:11	N	616		\N	1	N
1504	1115	144	post_management	N	2016-10-25 17:46:59	N	617		\N	1	N
1505	1049	144	post_management	N	2016-10-26 00:00:01	N	594	1	\N	\N	N
1506	1049	144	post_management	N	2016-10-26 00:00:01	N	595	1	\N	\N	N
1507	1062	144	post_management	N	2016-10-26 00:00:01	N	598	1	\N	\N	N
1508	621	144	post_management	N	2016-10-26 14:37:16	N	618		\N	1	N
1509	432	144	post_management	N	2016-10-28 00:00:01	N	596	1	\N	\N	N
1510	329	144	post_management	N	2016-10-29 00:00:01	N	599	1	\N	\N	N
1512	1096	144	post_management	N	2016-10-30 02:20:10	N	619		\N	1	N
1513	1096	144	post_management	N	2016-10-30 02:23:13	N	620		\N	1	N
1518	414	144	post_management	N	2016-11-08 00:00:01	N	607	1	\N	\N	N
1519	414	144	post_management	N	2016-11-08 00:00:01	N	608	1	\N	\N	N
1520	9	144	post_management	N	2016-11-08 17:03:58	N	621		\N	1	N
1514	194	144	post_management	Y	2016-11-05 00:00:01	N	606	1	\N	\N	N
1515	194	144	post_management	Y	2016-11-05 00:00:01	N	603	1	\N	\N	N
1516	194	144	post_management	Y	2016-11-05 00:00:01	N	604	1	\N	\N	N
1517	194	144	post_management	Y	2016-11-05 00:00:01	N	605	1	\N	\N	N
1511	194	149	campus_buzz	Y	2016-10-30 00:00:01	N	243	1	\N	\N	N
1482	194	144	post_management	Y	2016-10-19 00:00:01	N	569	1	\N	\N	N
1483	194	144	post_management	Y	2016-10-19 00:00:01	N	570	1	\N	\N	N
1498	1073	145	message_list	Y	2016-10-22 23:07:57	N	2908	0	\N	1	N
1521	194	144	post_management	N	2016-11-10 16:22:25	N	622		\N	1	N
1522	1104	144	post_management	N	2016-11-11 00:00:01	N	609	1	\N	\N	N
1523	460	145	message_list	Y	2016-11-11 01:54:29	N	2910	0	\N	1	N
1525	194	145	message_list	N	2016-11-11 02:54:33	N	2912	0	\N	1	N
1526	194	145	message_list	N	2016-11-11 03:10:35	N	2913	0	\N	1	N
1539	9	145	message_list	Y	2016-11-11 14:27:44	N	2926	0	\N	1	N
1528	194	145	message_list	N	2016-11-11 12:29:16	N	2915	0	\N	1	N
1527	9	145	message_list	Y	2016-11-11 03:16:00	N	2914	0	\N	1	N
1529	9	145	message_list	N	2016-11-11 13:33:45	N	2916	0	\N	1	N
1530	194	145	message_list	N	2016-11-11 13:45:48	N	2917	0	\N	1	N
1524	194	145	message_list	Y	2016-11-11 02:25:59	N	2911	0	\N	1	N
1534	194	145	message_list	N	2016-11-11 14:25:28	N	2921	0	\N	1	N
1533	9	145	message_list	Y	2016-11-11 14:12:23	N	2920	0	\N	1	N
1532	9	145	message_list	Y	2016-11-11 14:12:05	N	2919	0	\N	1	N
1531	9	145	message_list	Y	2016-11-11 14:11:47	N	2918	0	\N	1	N
1538	9	145	message_list	Y	2016-11-11 14:27:21	N	2925	0	\N	1	N
1536	194	145	message_list	N	2016-11-11 14:26:45	N	2923	0	\N	1	N
1535	9	145	message_list	Y	2016-11-11 14:26:23	N	2922	0	\N	1	N
1537	194	145	message_list	Y	2016-11-11 14:26:56	N	2924	0	\N	1	N
1540	194	145	message_list	N	2016-11-11 14:27:56	N	2927	0	\N	1	N
1543	194	145	message_list	N	2016-11-11 15:01:22	N	2930	0	\N	1	N
1541	9	145	message_list	Y	2016-11-11 14:33:02	N	2928	0	\N	1	N
1542	9	145	message_list	Y	2016-11-11 14:37:00	N	2929	0	\N	1	N
1544	9	145	message_list	N	2016-11-11 15:05:24	N	2931	0	\N	1	N
1267	9	144	post_management	Y	2016-09-04 00:00:01	N	432	1	\N	\N	N
1546	414	144	post_management	N	2016-11-12 00:00:01	N	611	1	\N	\N	N
1547	1105	144	post_management	N	2016-11-12 00:00:01	N	612	1	\N	\N	N
1545	194	144	post_management	Y	2016-11-12 00:00:01	N	610	1	\N	\N	N
1548	194	145	message_list	Y	2016-11-12 03:28:16	N	2932	0	\N	1	N
1554	9	145	message_list	Y	2016-11-12 03:46:54	N	2938	0	\N	1	N
1551	9	145	message_list	Y	2016-11-12 03:46:36	N	2935	0	\N	1	N
1552	194	145	message_list	Y	2016-11-12 03:46:42	N	2936	0	\N	1	N
1550	9	145	message_list	Y	2016-11-12 03:45:24	N	2934	0	\N	1	N
1549	194	145	message_list	Y	2016-11-12 03:32:49	N	2933	0	\N	1	N
1553	194	145	message_list	Y	2016-11-12 03:46:51	N	2937	0	\N	1	N
1555	9	144	post_management	N	2016-11-12 03:57:00	N	623		\N	1	N
1556	194	144	post_management	N	2016-11-12 04:00:44	N	624		\N	1	N
1557	9	145	message_list	Y	2016-11-12 04:01:40	N	2939	0	\N	1	N
1560	194	145	message_list	Y	2016-11-12 04:02:58	N	2942	0	\N	1	N
1558	194	145	message_list	Y	2016-11-12 04:02:09	N	2940	0	\N	1	N
1559	9	145	message_list	Y	2016-11-12 04:02:25	N	2941	0	\N	1	N
1562	801	145	message_list	Y	2016-11-14 16:58:11	N	2943	0	\N	1	N
1563	861	144	post_management	N	2016-11-14 21:13:54	N	625		\N	1	N
1561	194	149	campus_buzz	Y	2016-11-13 00:00:01	N	244	1	\N	\N	N
1564	9	145	message_list	Y	2016-11-15 11:46:44	N	2944	0	\N	1	N
1565	194	145	message_list	Y	2016-11-15 12:09:39	N	2945	0	\N	1	N
1566	9	145	message_list	Y	2016-11-15 12:38:57	N	2946	0	\N	1	N
1567	194	145	message_list	Y	2016-11-15 12:40:55	N	2947	0	\N	1	N
1568	194	144	post_management	N	2016-11-16 03:25:37	N	626		\N	1	N
1569	194	145	message_list	Y	2016-11-16 17:52:07	N	2948	0	\N	1	N
1570	9	145	message_list	Y	2016-11-16 17:54:21	N	2949	0	\N	1	N
1571	194	145	message_list	Y	2016-11-16 17:56:34	N	2950	0	\N	1	N
1572	9	145	message_list	Y	2016-11-16 17:57:50	N	2951	0	\N	1	N
1573	194	145	message_list	Y	2016-11-16 18:06:45	N	2952	0	\N	1	N
1574	9	145	message_list	Y	2016-11-16 18:07:09	N	2953	0	\N	1	N
1575	194	145	message_list	Y	2016-11-16 18:10:43	N	2954	0	\N	1	N
1576	9	145	message_list	Y	2016-11-16 18:13:09	N	2955	0	\N	1	N
1577	9	144	post_management	N	2016-11-17 11:30:54	N	627		\N	1	N
1578	9	144	post_management	N	2016-11-17 11:38:31	N	628		\N	1	N
1579	9	144	post_management	N	2016-11-17 11:48:18	N	629		\N	1	N
1580	9	144	post_management	N	2016-11-17 11:49:29	N	630		\N	1	N
1581	9	144	post_management	N	2016-11-17 11:52:03	N	631		\N	1	N
1582	9	144	post_management	N	2016-11-17 12:06:35	N	632		\N	1	N
1583	9	144	post_management	N	2016-11-17 12:09:27	N	633		\N	1	N
1584	194	144	post_management	N	2016-11-17 15:28:01	N	634		\N	1	N
1588	861	144	post_management	N	2016-11-20 00:00:01	N	625	1	\N	\N	N
1590	421	144	post_management	N	2016-11-21 00:00:01	N	615	1	\N	\N	N
1591	9	144	post_management	N	2016-11-21 00:00:01	N	621	1	\N	\N	N
1587	871	145	message_list	Y	2016-11-19 21:15:42	N	2958	0	\N	1	N
1589	194	149	campus_buzz	Y	2016-11-20 00:00:01	N	245	1	\N	\N	N
1586	871	145	message_list	Y	2016-11-19 08:21:28	N	2957	0	\N	1	N
1585	622	145	message_list	Y	2016-11-17 18:45:41	N	2956	0	\N	1	N
1594	194	144	post_management	N	2016-11-21 01:13:43	N	635		\N	1	N
1595	194	144	post_management	N	2016-11-21 01:14:34	N	636		\N	1	N
1593	194	145	message_list	Y	2016-11-21 01:12:34	N	2960	0	\N	1	N
1596	194	144	post_management	N	2016-11-21 01:18:50	N	637		\N	1	N
1597	194	144	post_management	N	2016-11-21 01:22:13	N	638		\N	1	N
1598	194	144	post_management	N	2016-11-21 01:24:32	N	639		\N	1	N
1599	194	144	post_management	N	2016-11-21 01:29:18	N	640		\N	1	N
1600	194	145	message_list	N	2016-11-21 01:30:14	N	2961	0	\N	1	N
1601	194	145	message_list	N	2016-11-21 01:30:43	N	2962	0	\N	1	N
1602	194	144	post_management	N	2016-11-21 19:21:54	N	641		\N	1	N
1603	194	144	post_management	N	2016-11-21 19:23:36	N	642		\N	1	N
1604	194	144	post_management	N	2016-11-21 19:37:30	N	643		\N	1	N
1605	9	144	post_management	N	2016-11-23 03:46:21	N	644		\N	1	N
1606	9	144	post_management	N	2016-11-23 03:50:00	N	645		\N	1	N
1607	9	144	post_management	N	2016-11-23 03:53:28	N	646		\N	1	N
1608	9	144	post_management	N	2016-11-23 04:03:30	N	647		\N	1	N
1609	194	144	post_management	N	2016-11-23 04:30:04	N	648		\N	1	N
1610	194	144	post_management	N	2016-11-23 04:57:57	N	649		\N	1	N
1611	194	144	post_management	N	2016-11-23 04:59:57	N	650		\N	1	N
1612	9	144	post_management	N	2016-11-23 12:58:47	N	651		\N	1	N
1592	194	145	message_list	Y	2016-11-21 01:12:03	N	2959	0	\N	1	N
1615	194	144	post_management	N	2016-11-27 23:00:55	N	652		\N	1	N
1616	1096	144	post_management	N	2016-11-29 00:00:02	N	619	1	\N	\N	N
1617	1096	144	post_management	N	2016-11-29 00:00:02	N	620	1	\N	\N	N
1613	621	144	post_management	Y	2016-11-26 00:00:02	N	618	1	\N	\N	N
1614	194	149	campus_buzz	Y	2016-11-27 00:00:01	N	246	1	\N	\N	N
\.


--
-- Name: logmanager_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('logmanager_int_glcode_seq', 1617, true);


--
-- Data for Name: manage_gcmcode; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY manage_gcmcode (int_glcode, fk_user, gcm_code, dt_createdate) FROM stdin;
1	192	APA91bF_ahBr5GZ0JEwqBhEjnH8EAhb-_zxPIPlACQj9YJx0J1eh_pGmaV-9P0s73BvmSSsljx7ZtICI9jIh6kIIP1tFEqt9YL9JlTcYBVuYYFlhGbd8HlXNCiJWUs4X5-tSPadENvJQ	2016-01-06 03:52:33
2	193	APA91bE20dkfq5XYaKil29Tyh-0uxqiaug8ym8H9V23zvpQg_roXJE6H0nMNbpeihe-59GfH-R2VcKqwVzKhokgnp_u-r0uLodNH8KonJ0H37lCHLui6myaHxcA7O9X6kbetk4qYSFgq	2016-01-06 06:00:09
3	195	APA91bEhR6EQCjfsjD1rJa94Zizg_fmg5zckiHIJ3vdLt12z32b7r0pSnUEmxOQy8UweS4D61k0Xw2VGOw-fbrlZacoatArnUf8cAXMCWahlzzYe2tnsA1f3TluItX_1MHxYPwSI4sBX	2016-01-07 21:29:55
8	9	APA91bFh0jUIjvXSQfu1YxlwUR3p_1mIFGXMURFST_SUGYZ_mOjqP49LYjyBRkvG06RexTlv4sFWyRARkSc2AU43sytqwivgNU6RR3Rt1KWUW4EV9SMXyC0D0PeXyg_wXQEcS27GM1Tp	2016-01-18 04:40:41
9	212	APA91bGKk5BWerVGaWLDqsaZg-YgTBqnfBuo8ZaQhE0uGJQ9J-EvB06rnXgNXA_88XqF73LLFjafM4fjDqxJUDd_SnsHzv1AIbw77Knn9Fzob3nwVJQKMsKjoCix0xTs8DqcSnG7zS0Q	2016-01-21 04:38:13
12	222	APA91bFusszW8koTLtjyP0PcPO5puV5H3nMC_EbjnVfY4K1Vf1sQWDbkld3rrmfSGTfjS3dSs88g7s7Q0GwcyG2_o1UFW2-1PtsfINWp5wkmLjigCSG5Sigabq__baUNraXcbN6e6Lmc	2016-01-31 01:46:50
11	181	APA91bFZ4JF4aYaJJvv5u8sM3kncbwoNaTG9ChTrC_ripDw6sv_z8OZQNNNgsQDBEXqNhZd-ALNAgOg9_GvBTt_pIukUWt6dogWv8z0UjYv4eK-qUCgkblSUFZrObydhNeewZZm5JCBQ	2016-01-28 10:11:26
5	180	APA91bH3McFjrmBwp1KwIrA0cn7cHZFQ8ScSb3_IPzlxuCMHLaZWAKub1860rWjiYU6g1twUm7kzy1lYL67YBhWvtlccMjIEaGNue1hQActsbZZV2eUXPjxjzGncS4bax-mkWsUShJ89	2016-02-10 14:33:26
26	552	APA91bHokM2tfVP0WhEJlwtm0YjpP7udnw1eE75hsIxQXiwtiKv8x4egbH65aDmNjD31no5o54UBV9Dytg4xE6hUHLcE6UeyK3o0DBNqdefx_E7jHOcCXdRAWSo3s4ET2eaM6HoGhXsR	2016-08-11 20:19:14
27	553	APA91bExU3lyC_3HAvQGkYSqZKY0odt6nsv6_PjNef2LYWCBTtHLVVKMCAg8tdFNXjmOV4jZzfCOnMjPi0B6F47pFaJarOl5hazdIM0BAYcjwanWReW2G_YfAkyBha46ZLBoIlT58Gwu	2016-08-11 23:52:53
10	181	APA91bHiXwNg5zEvHFwLMq-YU359F3VgjPfdI-GXa5Vrdi2slEb7ZL5TwgjVebaig6j-Oe43Axha0x4rV5Lz6Or6nqKtByPwIPo8x8YPDeiX7eL0ePANyRfc0FcVUTenMbFePPWE25Mh	2016-01-25 05:21:55
6	180	APA91bEfZmWMLUIXL6gCsFrvT98mfVG5Q8stXVnonZavY2QnenG3GOldClITOt7X8JStw-hMyylmrOJlTNPSNjd8QO1e4r4YJxD4jl0Or8q9syTmIHdA0hiz6He84JdUzB0L4U2TxCGF	2016-02-11 10:28:44
13	372	APA91bENmzElUWxL6u2IHhivqfNDnrvn_bxQVT4heuNkt3R5CMEgC71cWDZ5tLX6o5g5NiSw1T8oPggc7TLkpka8tit-D0MTv2IC_V4D7I9kXrjktlPix7Qb9VV_b7Wjtf9a117_a1jo	2016-02-17 19:57:28
15	180	APA91bFDT_D0pS5Zj7LjiSyhP8qNjJQyA4qzHdJS8LW5R1mHfzIYUJqC5RkAZjzE3Hvr487CDNA-gDlT_NGcXWrCWPkUlCWbx9zMT5C4st2RY-mstV5iwcW5eMf4UFNgxcxTPhQymLGE	2016-02-25 05:19:43
16	194	APA91bEYZBfpVGjjn7_Slc_A4nfyp4R5FsvAAVGhHCkYekDCIrkGh0Vg5NNbyqhFPjJCMiyAzbiOiJ52JAf0nN-VF5uSlZK6JOihBumGLABMQhkJmDCUzL70yIWJ_982kezz4Plfol2G	2016-02-26 16:59:18
28	555	APA91bEzu7CXqa06UYTcrXZZuGdXDK6CPWRJwbopVWcK4kJEO6ntYd8RKA27HgmZhCoQmBktsGveUkI6wlN1IPtolNa6vVLg7sXswxFvyyr1bNxQcqmJ9PfJ1p0dcHKmlQ_tcAoBik1S	2016-08-12 00:01:37
17	194	APA91bG3uCErTlhOrpZwA-rUGkF3r0NLsyPMaTOqR6RFM5Evb8dhkWQlGKEyNGnlJ9qZlebwMnze2H9wShBW1WZfPBUmdCIvV_jrm0GWbbszh-Q5mC6l2LC604yxIAOfuv0jqn9OGFCq	2016-03-14 14:16:19
29	567	APA91bEYe1buh813yN0eRLR4QoFmJR8zJ9OuC5k9vzS65pn5W0F1KPYVQyVa6cc45e5yOQhAWBz5RYwJoPHGkF-A4_hGaIDhfELAPt9XXdG2JNSV_O-2LH6q-07jnLOXQBFQzwC-fpD1	2016-08-12 00:29:56
30	570	APA91bECgcGvullcd-fPrqt74fuWiPIcJqXWbHxJcm6G99l2fYubztE5Sw0q1JUB--uprr50TYu_rksLttBjb357067JWHUIArJkN4XeqEZLUUcB3U277IGhAKLOIr_PXdlm6auXMiXg	2016-08-12 00:32:25
7	180	APA91bHpTmE3BFC4HMnrZmDmQhStyjNk0s_42uAx5e-KmnF9lTvr8WOdLwWD-sB36jGevozBJVelnBHSOwQ7f2bWz6ptFbfIXUwTAPbDWA58sXaQGeHOARAPBsGJYusuKM_gtxdRY8NA	2016-02-11 13:23:31
18	180	APA91bGVotlvfyQZcS3Om0374K83xKs2gx2zI1hkkh75HQssDCReAiMtXW_Hl42UEaVkSqoqJMv0z0HNtG5jvwaY-Wpkd3ki-oEukaLWiCyO7IC3Hgl8f1EGMqlrDSGTVSKLOHH8Pxrj	2016-03-15 12:23:38
31	580	APA91bGhb3m7tpWXONEQYggO7vPGsgjIIpWaz0US66viHZsyKdtal0cUG_XGfzt0VmUOqI1fz1w_ptSN6GpSWbtV2x9rGffo-VsURAZFHlIHiH4PgeDhfJzYBeL85hjfcJqhIVAOS4Lw	2016-08-12 00:45:14
32	589	APA91bGlG3niZ5YQ3aBqIaQziBKkzgITKye2b4oLF_F-z4mlLSxAGsROxBmyYMcqtQvs1qrhvFlTaHUeF-yLTYxukUHZmAnI6sMob1jM6BRmpjfIft_RwuS8hfHzoDWW0NNDOBw73C3Q	2016-08-12 01:06:02
33	590	APA91bHzf3h8dA0BTSb7aAnNCQIM4f-JYlOvxhq_rGHgAGRvBfXbRGUcUXmnVWM8gNqN57UnJBN4Kns2ZOAjtRszrdUtYXFBV8JbgqtKR-111oHdX7XTUPXh-5gQYoGJ6TFu0v4eJmjN	2016-08-12 01:06:17
34	594	APA91bE913nSpXbj7V70riDNFiqGoHW-QL3FzDgsHQ-I2Yl3-rXJmRGB0I8hqwHXBaRLRTfxLQQb6rktnk6HGIYMKMvBNYQEsa-ScNkhxNjrploToxcMaP31GoEnJBolKxR1-d1xEL8e	2016-08-12 01:22:59
35	599	APA91bGXwFc1mAI7JnByb3ZRJWHKnUHVpwNoh9HNzyZDpZV6kvyOZVK8fwUvzd66zwgQ8lz8ZZI6NnnjL01XxkccI77V2VAozMP_dBdgZOpOwgVUM4EBm7sqdt8Iyqgg8kqD00bmqYNh	2016-08-12 01:30:48
36	601	APA91bEF5HTkzs-jahUL4Q_UKZHTzXp0i7mKGi6RgEA9Y0vF6AtlmLSLxQjY1jH4tPx_qUFgACswhYwrbPq20L1BlPV30xY7HG3QvQZbbDNGijn_y9d_aSFnD5niny5AsNMK5mjft05U	2016-08-12 01:33:19
37	605	APA91bEVh_ZfAHbcDiRCISJXqevuF3mCmVuJnm_YKw8t9pfEi0jH94eIg2mF1wDBTYZBR8SUYW5GfUQ1KiWwDyc1NLgsmHaRzlb6FUBzoYXhEwtu1UqSkWwrJpNU87ungiaKUFftVkhg	2016-08-12 01:55:51
38	612	APA91bGeYwp8m801McvTD0X-a9KD7G6KoqFsbb2QYtxWPMM4_iLUmlgMSssbxWZAsb04w0YicLNUvbKdi4gak3ArOMEF7DirA_cNj6rgw9p8InTzheLKvlk6DbMcabHtGT6YBl--YKcJ	2016-08-12 02:26:30
19	180	APA91bEEfrwtln-ws9578UNARQYFiWJxo8z13pUuoOMs2l6u46HtOLM0ujs7PuWB5zkwrN0Kn8DA57Ld7yLJXe_2HphT0K8Fop3-7iuffbKNCc2dXZx90quKIgEGahBbJwF73x7kSBOU	2016-04-11 04:50:24
20	480	APA91bHO6NvtwliPxqHrWSHy0ogvyAQqboy7zPrcNr0THQHz2erkZlizNRn30grCGcEpl7TpkRqn8yu1KSO4owQt2BfbniJiPso-gCtJSHCdyAfTPHKNEyuWS1ligSAJIzo9NiJ7bj0x	2016-04-12 02:52:34
22	501	APA91bHDEr6CTPUAl6GVQKiiC3321mTytmLcoObDdrOCGKQCE2nho4BKXimURXKyghHTwT96KGnlpH6HPerXS7VpYYqLGjxLK2azL33gp8Ekvz4w5rg8l9VXLjjxOC-1OkP_UOkK_g1j	2016-04-18 23:53:55
23	504	APA91bGw9vCe4uNDUfIKr63RjNr1MeXrVFEIGiebeLqp8UB6rl5Hj5QKUEgdx7RvLQX8Q5x-UXRXkhW53_qnCaL5E4IKy3C0jPMJUDwdO6XTObWwrK_hkhcMTNa1Som7_Jp80nIub8Ew	2016-04-19 16:57:54
24	506	APA91bFD5s1yVmNqeQXsLHXFT7tGlf-aUjtLfkLFtiCL8jSvQXo9Yn1HmZTnLtGcg9S5nqeQaHG12TSWJiDSAiOkXl_OtGMC92TNI11pzvYUYROljFmmFdwhUK3szeAStiUfgRjv_dLG	2016-04-23 17:33:59
21	530	APA91bFZK9MaB5mHDcpGPmTUGrh8bDGinz6lyyfrzoMkH8g-XZJyIBT7_XJ3B0V_DgXJYVGNw5cIjTdA3aAdp5sjsk_iNVFU2ERhcHOX1Ygz4xvAmHYBe4qca8iWLQ7QtiVrdZQPN8B-	2016-04-18 10:42:01
39	615	APA91bFlXKe9H4LCPcXOK2285qPrTiJ_BUn2hA0jjpUtRDTgfReDzKZcZAdkIsSnrD_hB-zbEQ-jUzsK2BqChscVJRYsyjpxLg-aU0-0Xazfd4DCHfdhGpehhiwtmO70RcnUxVDF8jCr	2016-08-12 03:12:53
40	620	APA91bG24tZaAgAPnm7Ud5MBFhEFHlTpltW2JRKhsJgccfq3dSari699mVdEhlQMGO03L7Z5Zei4_BHwd2gVY5Hh8fPKdG8C-AcIJ-SUF_xkoM8-9vooxrJe7cudEnZGccs8xBbF8XeA	2016-08-12 03:52:54
41	624	APA91bHyWm2c0mqb4_JtohcygEVJDS5885ixMyOWYlY4rfWqxD__nnQCb5BJViyUitjhaFxSjYjjP4nvdfzqm3CtnIZNQMphDw54LczoCU36RDtWyW4dIqIysPasa-jW64rhvX1Sd1om	2016-08-12 04:19:24
42	631	APA91bHYgJ66hJNqrYY-pSm6FaEvOKCJI-DTjnIyidgc1LKjpnUIL0M-SNn114nzmz_VMIfmkHj2yNWvOm2oqvmUhZPAJyaOZCktw3GUtB_-LcCLl38iSyiWp_Jmuh6QFZutwxRwB7eK	2016-08-12 06:33:38
43	632	APA91bGACHivjOP_gnY-Gln5L7K6nXrgf1uPaxrkC3p7ti0oy-vPg7jn8c-qESYvrJbUkhuAezraCd7tn7Xw3xQPvPOuMQ1ZHpbiAe3DMHGZErVZDMTT5K2bFsLF6kJbjhBkIxXaibTS	2016-08-12 07:17:42
44	636	APA91bH-xG-57qIPIXpFOirGSfsXnUv-9Xs5OaQEUZRUp_63GabHQbtwi4FX6YXpYsXN3KnVbvWNnp0vgHPeWnGGG6HTrBdesYG4qbPHDjnzaqoNASDIz6_JKT9ycRmBUtTLyeD7liU5	2016-08-12 11:30:10
45	637	APA91bHpavz8tmKmDwECfHl_NULtDn-SU_Iuy4xmoIvEhpZGJcWhqxkrnGsnJKvzB5IFhSJst3g6_AVeXEF7zXuV0nnsPzkTQLVNppK3eGZUuAows3UFJf9rpnNU6zRS1ifHkNfuoYdk	2016-08-12 11:32:37
46	638	APA91bEHXBI5qLGfCOxSkZOwbOeWPQ_MSGSjBLx5MpWledbX8rrxqQWgzTkLWos9qJlvPOCLSJKl0K0-c4MtDXfrYqQfLNKqXdwUybNILA359x4-WcNFROGbU1t-xAxKf-73hmqAGfNk	2016-08-12 12:38:20
47	647	APA91bEYVHCD9MJc4vGWDllSRE8MGdhKvp5a0hY1-MGquWREWSOxfIJNr1zBk8tL7ZpMklpcfeMh3jprb6CAV8kYwlsH8uSxLRE_OhNrdp-ca6Awg-4XogE2bx7RFmLVjHR0_up4pxcK	2016-08-12 13:25:07
48	650	APA91bEsyeElZF-sdjQQOkj_LbSEr2dcKDR3bh9ZdE9FN2Uzis5809HLX9kiZYQDiy0aGsH9Ys0_EilRptvRffLLnxRkVjxd_JXvlgb_BdHSYGpu_Xs8pKRY6C6wJbTQHR2OEUj_x-pk	2016-08-12 13:46:08
49	654	APA91bGBeL-601AJavpSZo_rtrscKuBP0a7ARJIFyMLZwRKFupzp719RK2R6bY-Y6BnFL25rnDdoIzSLAYwc60d0HElwLiqud6koSjLx7wHfOca-Mfxx06_i_BT7vrl-zqIJZpKysxPK	2016-08-12 14:09:22
50	616	APA91bHqoRMgESXXufFMEQ4NjXil4v_Y8hfqZsLiGwst-TkqZBGkUmWMPE7iQXGH2fHjYHd4GRPApfvh7heMsIZvdtaJojZ82Y2vxjorkMoq1LJ2v-JQ6CZ_FJ1kn3ss5kCOQ-KS_BWa	2016-08-12 14:19:06
52	675	APA91bGNBD8rIc2SIc0mpIvSM3LhHJV-UsEFWMWIsv_sKry4BpSJjR4NlOOqrRTaJEAvF1KjWHhqQBix1p9n8MiLxLfqaTsn2aDJgnNAuh3GPORQuUjuhm3WDhWgnJnESYmANnw8l4bd	2016-08-12 21:43:33
53	687	APA91bFtvDwapUOVgDWn1jNjruhz37EzVs_V8DJBCGz2wxttYH5TTGnU0FEwWNSqhsdYEuOqvApqxE8RvMR9q8Fe754en1Md6SCM5s6IRPqgt05tZ8r9HTGVbFQe5AkPEbBN7k5vqRwz	2016-08-13 16:15:27
54	688	APA91bGkQJq_2anE0hk_Ydit9KaamVacac6HLmHceySzvgpHduPxjCjIGJ_NJtzmAi4_q9gnfVjoV3Pv1cUU9CyPUxDdUhKP3cvfYwJSsImv2zXz7V8baAoYHjj_R0CpP1g7_Wu78q8R	2016-08-13 16:22:49
55	690	APA91bGVTkUTxay5bBf8PLvPEMgA5lmt36AW1givQv3c2c_-XGCxDd5ovE9KwBxE94fWRIYEaYNsE08IJCaUCnQbPXI9DCqiOTAfg0m_O_dR7V8_V-fmreR3BRWc7syY5ubrcdzGtUxD	2016-08-13 21:35:54
56	693	APA91bHYKY1cXlqkebrhoB043A6jaB281eaZBvynDQcffZl2wnq56UNHhVfE5ZZSHeJq_TrEag0g9kFIlerHxab7_mzCXEkADEanPT2QFmdyZ9hl1GwgySEgSCBYOok-chXxLzq2nqot	2016-08-14 03:57:33
57	700	APA91bHwNib3lQEXrTN5sMy0MjUPUdiuUE8ce6QCSUWUu0afym1TAU7l1HhAACUzUdTyVqmkz6coOSxhHKSAOLB2NbblxpxzZP0BQFz4AetfmAvBnp-GGYGRXFs-anXe6HG4m6RWDlmW	2016-08-14 20:50:34
58	725	APA91bFgw0pAe657qGITD0X0t44P44FNVwdvHTPW8f23jyQVPTW8h7r4V3bfxJq3LEXa-adLLAizLO3QtKrtM4HU-eCsDCOZ124p688LvjVTQo4WZdmU4M2zou6WvTFtbsJo7Wzm-5mH	2016-08-16 20:30:48
59	733	APA91bHplKlAxEwfkmagJWxoR4ytZiSRIw_T_VC5P9x25Sb66hY1A4M73GwChZ7KEMQoMm54d5RFlY4R25iwtcR6KZkwL-J1dZUhbqfTZ7qx9J7v9YbAwVgC8mFVJVjCDCKOVxkBH-p3	2016-08-16 22:20:42
60	742	APA91bGLBewqC0rIkH1CPgSoeBwZ_9W55enQcHNX4HjFSVpRnmLYp2XylT9b3YL_bF5Fqh7rtmh6Kbj0v1JIYpzECJ4nftGIcjVd2-HgGx7IzLWj4RZ1AuTcz5n2gUHluWi_9rJ6v4o2	2016-08-16 23:37:34
61	743	APA91bEY1kL7xLDzAmPml3PCgXyRjP0vwkTaEtkdeoTyPkg6XMjuVCz9F71oNpV9tehRPSod3eWT-cCWJfDrLpfakg29anSLg6l3cTQ4LwD5veFNLuttrH5rE1ftRAJ5dYEjzJjP5v06	2016-08-17 00:14:41
62	757	APA91bF9lvBaSXifYi3nWcGrDcJ9m-bdX_5cZkmnus7WakqzneKivKADRsmALW8DsfBQjpOnzD7Xu9pvsRVSOnV-D3rqxU0v0-sfyZ3wJJ9fZAhtZThPtA60L9-pYQ7VOeTj7sFkN_d4	2016-08-18 01:27:18
63	758	APA91bGb6M-m3HD3HMCLBIMXFvuituLOY9B-obdPtvDpRkDHDjROX5KOQ5x2BXH3NLJ01MxRQi014ohIuVV4H87xCMnamcbm8oSf1SfzXwLBYjShMN9lxVa9-AYLTNUf8C2BPmEZECY1	2016-08-18 05:26:55
64	763	APA91bH24TsqXfQ_8fJBouG614ydlcdExQ03FVOfmGEIIz37DKwLv56VXOhixG_CdIHBj7DAkSrG67iek6apEiNkNSzWqgO-7xWaiGm5y9RruIOMXhdbTS1BXLbl4OjnRW-d8O_cW0Q7	2016-08-18 21:52:50
65	764	APA91bGQ3eKvciXKlaCZwLqcf6Gc_IIhH30SneeSRxwMyFlZrMQzDsdG47_0asOO3e7W4BbabxDvbGwoa7tHRSugB1noSM1cH25dlD3iLjiixRtrTdYi2tBMpmm5B0U40RU4USwNzMCD	2016-08-18 22:07:20
66	776	APA91bGf0iWbzc2H1Q9pdInvwAPnvNxYsDkkLQLm9SshaLAMwafFspfqw49ip2WLF2WhFEkGoPY53CqM5agc2VammV6q3VJlqf29ncZEv0a4ND_2gAcVXY12HgxCQuRFXcJlQbB8z8_T	2016-08-19 19:28:51
67	779	APA91bG_My9_qTFQimsrNFN8nWFt6ylmc7Vmr6FgAB9GXSHZt9J1fpvGM82y4VSU0ffPtNPiuk0sVrMy26tXLzhWtZO0K31_VEwWCp_4ks7jwdDNpSg6BL3bS8rTwoUbyrePh2jIz5Kg	2016-08-20 03:11:40
68	733	APA91bEPH_ceANOczMnIsTRFFYeAZSCYxYmhTEl-Z1TpxUcs42G1Hl69csFSNHBt_K9TpQ6qYHFZE3qdNRiqvYLobuom5PXFEkmglh3w9DFmtsrM7D7ZstS5d-2nlkMoAtOJSPCY_B4F	2016-08-20 21:01:42
69	796	APA91bH6QJfPbTyD_mB-VntJxSnKvLY9erZAh9AXWpZXcZO5T1jYuDI_4g-Keg1MvIK4HpJvkXp-zWbDXO8a3HQkZUN_e59bOiYkoYtydfnf1yKiJjRTVYUGPYXc7CGjy4DMv-2jSDHp	2016-08-20 22:05:24
70	801	APA91bHpUvsNyp_1scBmuNpdY9cKJrzTdXaiNRPKrSASCsWXr4PbVweVOg5dJMCFJRLKcV_m7iyJvHVFpmkD-3WsZlBAB4_LpW5KzpO7NaR-L5wX4KvKPmk-WerRUDoMr_zrtLlkujmT	2016-08-20 22:17:31
71	819	APA91bF6Ln3whqNi3QkiC7KuAxb5CTmlCYLc7eVNgK9BhexjaLiZjlnMXrEcIVq6GkgTeeX_vM7BvOY-GDB6DuFAcNLo1EpLrN4pimS67FY-YUfo00ccPY1NfjnRNC0vQ48miIUFwu0q	2016-08-23 23:45:37
72	821	APA91bE_hThVOgRpNS7prQ-LqR33PzPnnawFt5JVq4uRrjwFDSXD7xWU3d0z5SzY9JnvGvTUP9BZU_u1FDTrNSkdJzUYknlFrO398pM9fvvs5m-rWkgn_qWuGNjgmDrJhoyrAUFo_zeJ	2016-08-24 14:44:55
73	825	APA91bHHkYGo1baBjjpyMQb7w-lyEEJosbjFcL5siQAhWkUxMu5dor_PDdGPccVk9b6lM_iDMD3Gkp0oFoCCNY-AZjT_Pqrlbt-Iekihwm6M7JZPm4eqYB4OTlFkCTzv6OCt9QaeYw4f	2016-08-26 19:51:23
74	826	APA91bF4AGRZtQ9XGuzKBaFihZIqPpuq-boFW6Ozfi0rCBy43POTe69lMzeY7yt9Auc-9LNG5RgyVnXZqhdRiCOB-0SorPa3tH0_QrRUi6MQkwiT-5UnQxf9yd8JeHixmt00edYIAZkc	2016-08-26 20:00:59
75	835	APA91bGmLHbxz90FnpSkHYvCmNMvO98PcddmreHhR1uY0-6BY1HVtMUc-slyOBBcKA5tYsS_2G_4p8UnBalO5NAA1Qu72bskyPg66En04tHzT2F7hKJu_rNFkDdgGuvZqXw3eysMxAId	2016-08-27 00:58:49
76	339	APA91bHLF5XXzGyVQ3MEuOxFRXRoBLUUNb13faQK9lNFtKRnPpJPH6Cm8vjZ8tLmWtBy4nWXS1C-YdIhG_-Opw4Xo_nYnSO2SEuXn3EvNTyLmDYo8yJiWJnAh0o5041i-iV__plVJ_to	2016-08-27 02:51:05
77	839	APA91bGBkiNBVMk1rVsUZxq1qRrMXk8bW-38WdII7ji749m5u_yJicmKPn5QiLEL9SEIs6LI-OB6DwvjruG9t5JOE1lLLxyicQ7XgVi0VR78DSwLH1SNQLpvPvSQdN2QIxEGx7g1NEqF	2016-08-27 16:51:19
78	843	APA91bFXDM2x5-XTWHc2rZllpKqjSVd3IpQmT-pA5RO-VCxt9DxpWBTbNYXKOFkGYCLAXCxZKS9QmAAXS-cPdGhtOzV1gkZQBbMMI5-1BQCmPo6Kfj33Vlv-N6mJwatA7tAWtp-07RSI	2016-08-28 17:20:54
79	848	APA91bEStnWlVmI_lO11kwRswIRvHWzEELAT2GOU9o6qdrAWy7JsI3JaGsbs9ANW0SXgd5m4xt2VHADr1TnamwS7qekX2HdywdA3a1m1R_PZXAlzNhbQklXT9_DMx6pvGKuZzG4NORDR	2016-08-29 15:33:55
80	846	APA91bEOXWLwf524x5pFBMRaoHq8vr3PG41K8XhlrUvFvfCH6xJmgvHbQfXAZPlZzJ5oGCMPy4GG8WGR62Cef3PKXJzRdEsJFgdZ_e8YYiChW8Nghu5aX0ghMPc0MA2Lk721Y6dK1bxI	2016-08-30 04:08:49
81	861	APA91bHqRhdxdQtBOfelr4IHcavn_kEcv5sP1Cb6DtzpWAf60kVwSCxElGSRPYCJE2WR1utRBEb_gfnk926FRjFIvU13gt6OKQTOvW7fC2i6jxahOp36Snmg8lWNLVkAAUgIgN-e95Pb	2016-08-30 16:01:15
82	863	APA91bGBs8M2cMmgmAraArePE4zwuQDseR7q_zk_EyDOwNobB_txCTQ2a0RsWuRStlA9uG6mvxkKv6gPOXNygMJE1t7bj-RBaJvGzh3S4qXJL-ynAC95BcCLLkKR9pk6DHXx7TyQr8wG	2016-08-30 23:24:57
83	864	APA91bH4Ygmr_cVYIW33SAIsix_e2l2SpYNNhtvssfH6WQVDrSg09ESjwfqSYyaXZ7lvrflEMjkrf0lIu2II70VphGDP7E-oN55-BYdWnp-otBUqsQo-Wiob9eR_KyLjttwF2TsyF236	2016-08-30 23:26:47
84	879	APA91bGYGm_MS7tr6fL_ek3D3B8KQTyVAwIkJKkohN-dFF3Uoy94yCiUCg4SRTvjuKlwwisoOUbjBctpQYZoFwmeNTjWGaP7G9s_VSzM3yW-ATGVR-Riq1UVIJedlqsoWg-WKClLhNif	2016-09-03 17:39:17
85	880	APA91bEDRgG-bNZp8kRtFtnTMwZQhRoU54xnj6cRcMAtJCZkgTx23XQybOSlkNOkm7uus_5_SsdvDzCkFAjQDJCGyK_ZzicYlzm-OtMBidCJxiZb23douq7aDy0qUc19OkOCTRYRZ6jD	2016-09-03 17:47:44
86	889	APA91bHI0pQcDoffxdvhO3f6Y5es8x5NQhopmenCHAn8tDyjNspvg9HdqHhuqTfdP8G8WLyUFtF87MvnhVins0BvdBE5FkEWD9SDT6ysueF9IU5_KcZ5Zi_yDytlTdzHdyzv9K1Suz4F	2016-09-04 08:08:26
87	892	APA91bFruLFoOieBhvbYmDtFkfyIpdNuvZdc-Q479Dli-3WEVzxgYrIe07oY5rbg0aztHo55OezB7-iLjaZmUuPHSAd3ekhcPh7JRIsE2iMdPUg6hDDKGH7maSxqWuHYY4WIHdEYis5M	2016-09-04 15:01:29
88	895	APA91bEi6noNpnXOUsCVB4JG3Wj1qEc5p3nssBzdWYxatk0RBwrPqXUulMMiUBInxIst4mCMpdI3spYGns8HQqaeSPRfXZVMohfV1FDa3CrI38dESdVF9hajztqf72vXVznjDzz6SlDD	2016-09-04 19:50:53
89	900	APA91bGd_5JQX9hrh45Zuu7OyjAiB8tr6ptx65UFCPH-nCIhjJSiRAnEu8dxmIXJRPssuNhEf7tHpbh9a2MLqnYSAsoRhndo4ABOs6CwvKfD385R8hlpE_UdcVz24WXqo2dLeTznU0mC	2016-09-05 19:28:54
90	902	APA91bFThflXGTQXWGe68booCsRioLbDqucLEIwWUfVzDtDwFmxmroE1Opvl5FjHzU9Pg1uIZC0BYJP4x3KFUfjt6d1eMMQDEs6oXfFrGt_ikFmNxPENqzVW_D7PCLB6cQrZEg5R_rFD	2016-09-05 20:45:04
91	903	APA91bEAHYeKJz0PnvFPOUBd-mq5aR2C-NjkHMvIpTT7E88ra3f8NblEG5fDaCwPhSFW6Cmf0BlBOcegDbERc_LDiApj5y8q1M31P2b4Nwk09rV7ysbqzK4iFbkD-tA9gJSHPWLE5RpF	2016-09-05 21:42:17
92	908	APA91bGJe6NH-5LivdF2f7IxVibdJ2PCP0gyVuAAEcXPVQZpw72alF94HuDwX2oHWjpLP1sQk2zhRVFp3uj8gwsFqWhvrduPL2ppeBTXalHnDfEUatoa_leWUAWAkAlS9cSQxEzKJbd3	2016-09-06 13:19:51
93	910	APA91bGq3HgiFbvpzBNjXHdThWQmyMo5FCzmJiKKGcNk-4YdmWwNCHmTyf_EyBuZLxVxbCwxztQImPpFn-OKpYMqb6SukrEKx-R0-cpMZt_g6abvNzENQbjr1uSpKZnAPCDUVK224bnG	2016-09-06 20:28:30
116	194	APA91bEETYT8EJKv6dQdhN822ynqJLs2yTwQS4To6n6Ykn5QV0TIRU78tmxrnkSumSoHbo0x_tCKQZQqOw7LaMiilmXyP098GcAQnxssDZMXGC3JAxw-PGM6Fg6mVWjeMfzsS0dNFMEc	2016-09-27 16:52:09
94	194	APA91bGGjcfPBTViHBA_yvImPkNXuqDEtFTbkWOvkbeGONt44qZT4fGw76txwTeoPU3JdWsfa3IAoVo7wA4Xa9U9pclMnWUXzlg4erOooP0dB-p75eTViqNgroL3_pY_j_XUhNWbbnmt	2016-09-07 01:39:49
95	921	APA91bEtJyG74A3sg1ie4zmXiU4zakuK7mUt0GVtlNFtGJ6Yxex6HA650Za-3Dyk0WBRHiquD2b46klSmspbyQUdSJpRK2LEaCH1EHs3FBcgDs2jJl8jW6vxQi-vPlvQWV--KkWBeRmN	2016-09-09 18:38:16
96	924	APA91bGdsy2s9DVfsiPlicr6wvi4RaSDU17YXoryEqzWL-2-j4rLI29Mg8dnPLRvOQ4rU4og66DefQw4xNeI-RQrzE-2To8qIOjyXthrbyhMdQP6QaQZFf-gwLmR2Fsqi4KmcKROrqCY	2016-09-09 19:47:03
97	928	APA91bEpHVrMn_CiEiGlml1oCgwxnrzSiAttbM-LLyBBors9HKXE0YLl_7pmysszMWOwhGq31cMUy8_Zy8O2940c-mtmHmZAmA2whDQbcP-VvE9nY28wDmGlmjJKh3YMdYKfGhG6e69W	2016-09-10 12:37:01
98	796	APA91bGR27N-KawTROzc1QA0nM1lZj8f5KuqABtzf51l_086ccTSUbhrxKhUxmE2KNN9nyatv1nWgfoy3LooR2EtRm5buQxTmhXBj0khXQAh9dTWJoTS5nzy5vea_PfFhhBgPVlN_ttO	2016-09-12 14:57:40
99	941	APA91bHnUVfWb0-d3CQNKWH5cGSB0NOvhQKFGNDjNuw9EVdO7oxo9ieflXbFXGqI3MRggjSvxuRMyvLLqH8w_dL41WOu3a8FuinlNurfek0cV6C0Spex-Of8Hjed2ZYxkU1LgMvv_nrR	2016-09-12 19:09:21
100	951	APA91bHRSlhAHkZkSc-snhZIAN26PPEaPRWC2j9TbFsjCr4rKQMuVeXQL0R0YwikC7Uke_4jfTr-rm9_A48KBcaxNy77scdDD7h6DhQr05k-sw8X5onPRzJhE6ddIElusyN9p0hhfSQv	2016-09-12 20:26:26
101	956	APA91bFotTFfOWQoM9YiFQCOCxwaD59MDUIAt0VMOYIOHLgLB5-skj6N5SK8Ci89sEYY6Mz6YzGcbK2XW80mM5t0ewNhdOKGLJaAK_pCubByRyMnGTLU0J0-c1Nw8_4CITOte5QgCY7n	2016-09-13 05:25:43
102	962	APA91bEpUjl2eZLIBFV7lKBrf_tKB_BUm4sZtMSSn76-mXXmYiMgM4Cg7aNf0J08v4gj5wemGc9I8SthO-QGoallx0xfyjOB25WLFViFBvLmxdA7UeIZ4GSJwLZ_YxAGHUEZY7_kdDzd	2016-09-13 21:11:51
103	967	APA91bF3TuDkZYgBGUqVMTQtcpT_b9j-si-L48PHoLx7jc7b7Ol5poBm5rDQO-Hdlq5tdRu5wNDf3dYbNV2AjcG4glMcDngGAwY0X6pZKAuQRFLE4FAvE3HZ2aM_eG-guFgml5q6Fyoc	2016-09-14 17:17:16
104	972	APA91bFDNg6KZnmZja7ZK8yKTVPlqhAfT9AYNF76nL-sSEXqDqaWXytZ_52Z_DdX-EQ44zuiOnn6PwFE4uhFfrrZnEs4xI8Y8-VZHbicSnjizciCHzgMXGpqvZLtz8gtDZ5QeH9TAfpb	2016-09-14 18:30:57
105	979	APA91bHjP3mDsxL9WF_HnaeZ1g8-hDQ8j2hsao4DJglwZwDkZwNKYbEydGxxOfOk9GX1UfoBm1zLtMY6Cgb5FZLe5P0c0ComvgrwWNAhRKa1rGQYONyCvY0qGAaQ3TcVQKwitNaYutvO	2016-09-14 20:49:14
106	989	APA91bGibRKG968X_t5hJtA_PpfUMDb9GpE82QMW83mmFwgThU1j6H9-6PMgQSvcWWE3jDizlObEktnOrqnFBm5Pphnapopd1unq0JwKBVquLMm3hewMOC4dsouSKCFgKeZt9qtq4THM	2016-09-17 03:16:33
107	991	APA91bHM33aXhojxfTCNrHWhzVJpBlQ-x5L-3K50yt9XrQM1n_Ve40OvN3_PzcwfyMiebHtO6g_OMdH5020DXbLE_7M8iHSv-pRwxqVCVKnnlCf2YfxKjkUzkOu0t4bI8GjFTaxwxEK7	2016-09-18 21:00:55
108	194	APA91bGSNMbfvuvtF_oqK2-mRaflVLvYPb7Ng_RyFnsMQMBRzkq--LaoR6CPaEf1Wb90pkK3IpyhLw8lW-0lvArSsMERjbGg9UrbngIpu2bXWUne5D2y7islm2iWp9RanEzNLbxwAuAF	2016-09-19 15:32:31
109	1020	APA91bF_CGI9ESQL_U8VJCM6wL8k4Epg-NpVQ74dPf12yqFSdkWqBc-OERIl8Hycc1gkcyuh_sYOIRyX7br1w-e_9FFQX7KGksW8ylqjGkCL-uxcBzZ1GJjOI77626EhTC-Ztbz1B615	2016-09-21 02:28:20
110	1032	APA91bHKniiOIxaZfP0CkkJfW8nIz_ig90Sf-h170jmHSaNNqpwcgcXl7wuKtE7l7W6Y4x7MRu_5DgEFK2PxxNIdXgqfmOmkdCgBfL2mw_Azk4I7WkLxqOcYLQUtECUw9CceYwaWklI3	2016-09-21 19:25:49
111	1033	APA91bHjfMGjZYAAcdUJP1rFcPtaEFFWr-Xt-8KSELtYoi--BZC8Ny-vDSwAGWRBM8O_VqFT3D6NjFp6Un8l79ZF_sqt6jCeGrZPuXOcnzdct2iqpxJH2-0Cv3thzsj9O3ZD8Y3_i5-Q	2016-09-21 19:51:19
112	1039	APA91bGBZh8N_edVq6NcgjJIj7FAKAf_SNodkqo1UPPewh6Bc5bcS_SfDmKpJHHARfHo44NdB5k0Q89Yj1VVG_a7pEk1pLbb9sV_Ct7-4Cz-WznO6mPy-5oBDm2wgu6yKmUKn0qsT0qz	2016-09-22 18:23:27
113	1044	APA91bFD_doEqhaH1x3b70ASBpJaboGGvPsUNMfGvUaQJ1jHmneEVOzVL1waZ0nmnlMtic8CKWlkaGJjE5tLkCdOfaXD0CaGwJqzAa6PIXgLdtN4TugGiXYAtGQRX_m4b1pw7Rf-pQzE	2016-09-23 15:28:43
51	669	APA91bGRYjDyoQEQWUbuL7XJpTYyhxtItIGoc02B1wQ8olFEj8X0WD4jr3IaJqw46x0mJhB-3gWtFcsY_W7qkFRTzGbJFQhqlGNIkf8e8yEUpAlipPuCwa-S7iiOfZ2nYCvvHNlbB2mg	2016-08-12 19:36:25
114	1036	APA91bHxKlZNa326CT2mXUQmB-Go0DCrgpuzT28eTEFpIF9ljreGjpREzmyDPTeXoraOdbLGcpdn5QecIjqiwUO4RimS5n5uEPZfNh_gF5q5_dU9eZ-CEaQ_t6kBTACv17fYtxql5P3h	2016-09-23 21:04:16
115	1050	APA91bG9h0yZ2EfrISDb-PnL96C1RSJHXnQxoE7BKfpZwR0YRz1ks5L1kpdxJYK_ln13hBxecbBcwS3SYxsRTxmbpGtOL9bM-ZpAkQuhrX8aaLwO9xrNKNgF49Ie3Oq807jjldcK89bK	2016-09-26 15:01:25
14	194	APA91bElY67Vvo2QA-YUngWyZoe5OVbhCxHj_7RYGlVwCtmSdhgXjy1RZSaMRgQR5pXczGkCNWeM7G97UNXlEX9qPPr0NbC08PB8mAgi75iY4BrEdRdbZK0NuXjkFp7yE8EZ1gnC7mjJ	2016-02-24 12:59:13
117	194	APA91bFPjwuo-zUJiPCAL8B7_WpZIrbisbhoSskx-EiShu_oWV4W400evHl41l0QLT_O89Y6sPleTEZoDLaCHY2MJPDF6439P0PgDnu3_Mnvbnfd3P8UtuDKKDa_Yo3O6TqrMQ4k7c8T	2016-09-28 12:10:23
118	194	APA91bE-JVCu1exMVhaZfnahoPMRGcKRsWXXn66WK5G9B43AVevmkYbLxJu0o2IC8H3QBI_CYr4rD0-MfQiluS2bWG0YBS1_paEPPz-hNzvRGWb7YnI24x9CxSDii2b_zGLOptxM7Tom	2016-09-28 12:18:07
121	1066	APA91bF-G5gnlr2pG5sLGPELrxxIVPfoCJZjjqF90mkmyH-WSs6idy6WvPS51_BKLEgojAzRugfe-C7tJ9QoNIcONSUBnBO4aY1gBmdvPjXj1fILi2kVxaqPMW6lUEP9y1tdJybFAeYk	2016-09-30 15:16:29
122	1082	APA91bHeHs_YzxPp0wwsWmXfSjwVO20RbEFortgmiOTEymtrxMqnzolZnpUPFLOlwsOJb6PqfPxQba42wLXGUz3pU1BhC-nxnNJAMCb-XgIre8O4JSw-38cDAJWtxyMvX1lEwwjYjjmY	2016-10-05 20:00:49
120	1062	APA91bH4mS9zCt4N7dkKdxinWF8j_25683iNkVFN-33Q_xaEMayWgWepXyFR91pd5pajzQwhHbYJfl2-kRPk0HOlOsRkYbSpvjDwRnxgjRUh9AmFWZK3WSEIw3IUryQSHk70tCbdEESI	2016-09-28 19:14:46
123	1086	APA91bECfrHxVFQxB2qP91rHC0skN39a0KX1ON8m8boAU3WML8v5l0kfPr68dEtNPYqkn7Z8vnS-7ZsWBX7b5fuDEKx2rKUu5El30VAhE3unE21aXz9lDqUX7G7VIOP8jV2tFzwRyReR	2016-10-05 20:08:33
124	1085	APA91bF0NEGb5tzY9-SfDVWjGQQD6m7GLgWwMm7AMhMWJ5rIjLu-u-BEJCOmmF38M9ujQfH7yh8Rw5ALzdb6ncxSgD0KmTW7i0n6OeCNrcA9gfzXfVJpmcv3-oEiC0_md6nc_WicrrP8	2016-10-05 20:09:32
119	194	APA91bEMVkn8sbTOwnEnAVII0M9QZRCfwGW7AhZWaleZbGGsIn_6NFmInSbnWKEkY-EvviVIrAtuxYvXPabMfvCjKhP9govUHk1fTBmd662qsp9N3AmEs-R_Kg_lE36-k6Gegf5MDZbz	2016-09-28 12:22:52
125	1087	APA91bGXaZS85-zQAlG6V6amL3FcC18dz31wiQ1pFGg9vubZoNOFQECwJP6zWfQEpedGfm5Xyar8s08NhW1ML19Cdb5Gkwx4q3p4PTQVTbbi-u8W_sZwOOvr5unYbo7MsUjcNcju59BV	2016-10-05 20:11:58
126	1089	APA91bHhAZb20JBwFdtIXSccZ-zvnp0xNA-H6p6pFcaKjhesrETawyMJae-u1Y3kd3eaPqlvsN5vHbuRScEqv7mX5kYEX6Zh8qLoOM8Ibn2m2Ggkw4SV9ulDgg_bNDCdSlop3wVF-mm_	2016-10-05 20:21:09
127	1091	APA91bFR8GB6dF92SkpypQOBlMzODK5KrTZh7zJw-m6H7AqPvDY8qobWWZIeC9PZTW5qybPCPyH6nf3Rq3iQjOqxICFwjR0sirGAqAD2Ub10NBH5C4Fcoj74wsu1H7wLtRS64S2IRPkc	2016-10-05 20:46:37
128	1099	APA91bHdMXnx7lG35nSXKekCm2ywCmSXwYA_R6orz8-drya55gRrtl9gh6g0XTtfBtbg4WIvj_vDUQbavc2RkcqGT2WEKj2HhSIPe14V_eY9InwBEPr3D1GXDzylIZ-O1gmULBdFi4qP	2016-10-06 03:43:12
129	1104	APA91bGD142DON_kl6pdJCWdMYyiV3pZSEPM-iH_rGvq1NAULf0tORvYG4X7F9OOH1vz2SbdPQBMGA4FXDacoX43X4zU5MRcm3w1O8igZzlqREthf89FMt4GWLyU4Rn7UyFOEOLdY3TT	2016-10-11 08:11:17
130	1106	APA91bG1j84eGdLd5TAhIKqahtHUXTSHfnltgCbaqH26AZq2KIh1SrF6Fqx0YdEnRjIgYrFMZ6hxYjP5o9sGjlISYhm1W9gCswhK27XHKRL9vXe0MMgvHe3wF-KeKUMl_WN9MIFUAObi	2016-10-15 18:31:21
131	1106	APA91bFDx9CYmqIBEuzohtOdFpjN_SOUk2ESMGoo9D714rKHcHRGFm091rGpUKzFVFUhKbV8Yrb_WsN2kqFbTY_EFgYQUCGQo84KfOwKDwjQXmjqzxKl341_DjQOsZj1YSkx5hM_t0TL	2016-10-23 21:46:06
132	194	APA91bGX6Dddyh8Eb5M4v3dkLcgrPBCAM4f2AOm-ll4F6s_A4EQoQ5k5RaOey2pNmkgva2v4uPEWy63O1om1PlqCwmngDqxx_OJDbgLDwwb1lMNOHHh19-AKhvEU_GMeuka4YZNx2U5V	2016-10-24 16:48:25
133	194	APA91bEntumb69zKCGkKm4rW-G-KK5MpAQeLrXRPlK3yLUtGOPq6b4FavQn5JUoSwpj4yZ9pK7wxRg-HuA13FzaaEkUOmCW1SQETKH1NcfkggtDJRMJ0sn6zWKgjkAO1H69R_J-u35ga	2016-10-24 16:54:12
134	1111	APA91bFogybbxDmEGO56MChUYg10eBzzFgMRVGDNAbPLKr9BcGCJZpL62CFNaXryoW-YLZemSo_Hs0x1zLqtotyuZw8tRHSxpN5oO9t2RnOhom3Tfq3IPLOlLxRZBOvIvOXvhBkQe2bj	2016-10-24 16:58:11
136	1112	APA91bEwzPcHuz1aYbzWGK1HXjT70FAjJWDsizU-ksU4EtNcnTY2BZO3GTHWBq43mYssBXzV5P9EG3RFpoO8R3K5kZ9wJFA2bFXbAWpgfs2HyvQen8V-LudalTi6ySlLSAl_qmLvv8iY	2016-10-24 17:10:53
135	194	APA91bF-eo-5W8ZoBY7hNlo94RJ85MzRc69UbjL8lvA37StLrt9ChEp01thRjrlcQ8yFOhBWY-gSr9CZQw-GtNnL4-WW-KrNvx6CS6xsV6RWEXuBXaRySpvZB1MB9g8-RGCa_NI1rllV	2016-10-24 17:05:06
137	1122	APA91bFYFgo2k_VjYq2sELxfnfsdVrB8akUQ9YQhMLzlDre8l9Nkm0qnW0gxXBHy4z-iJ9C8jbNlrbeH_tKpvvX3FeDUQCiySRdsvMB2QqoiorQniuWchp77NQizpAjsL8U_1EYkGwWa	2016-11-06 17:05:06
138	194	APA91bEjCTcnJZAjOfOhRcQjNv618B6GjggI9jc17r-7rmOIQ62nysN1etH8IPvFJzzrEEbYTqbYrsDKJTHlhQfHOOkZb2ghGXh5CnMYvYLFllWFQvOhgEUgkjl-lPeL_CTFUQOXf2Jn	2016-11-19 09:15:33
139	9	APA91bHb97DUJ098v06cZWp3xhbHo5vdVEd_BR_LjnaFwlezv0ZYU5A7Kee8IJZVmHGqnhHDNBaQl1OrCigGoYaxI9-yMhefdGQgej7kDS7F9JMZL0PM9V1tdDl0S-xjXClh2vBlukTA	2016-11-19 10:59:18
140	194	APA91bGJ8CvO3hjf-Uf1zlPzWZfAayb2LQvnc2aoN2Nf3KdASNe_SbK6f6iSGVmUHCkMoSDTL85jEH9pc9XkV3kgmaQflGxjuShJvS_7lkH5V-WlQVHCvKThjnBI6m1Vf8xvJa7MY7Ml	2016-11-21 19:19:28
25	514	APA91bEyt5MhNlT4_zjwj30NCu5wEUIulPSW97gqk5d-APAJ251rkINzU9gmO7irMZCwv4D31KhZjjk9aFI2YgINfJc8pKtnRk_lWmZqP4Ijf1lPuw9VIEWLxDCDMjIppUbsl0Y1TMT1	2016-04-30 15:36:37
141	194	APA91bGp8W83iSWwvoUnqvIM63nSrrAYs2rE0a7OSqBj2qkBm5_MbJ_YF95gFqBEnWG_yghc169ppQhk09qjvbRKPtZk-roqTo2eK-YfaKI0d0w-2t9HrQ6Mes1MYQjtKPQ35irEPMIO	2016-11-25 16:53:52
142	733	APA91bFPq0FK4DqoxCwb8bYoHSpEAD2bcFxo_i4787ZX3OI2FAK85t7zwoBPjm5rAqqStoutZrNJmngwBAwkCeornXbIV5d1JDd49tcqdJnbqiK9sY3ewn2A8u-ciV7FMEths8ra7uFa	2016-11-26 01:19:35
143	1130	APA91bE6vY9JWxgdUdO8IoNGVhWC-ITCJ4va43q5Dipx6osHXlNuHfmqM0aQDAF0JY30stkUalh9YmORTKsbawUPd3Vv7eZzqLWdibC9EIHjXRZHG5Yg-eUDPE2o0e_M_7lzRbtaif3n	2016-11-29 02:31:47
144	1141	APA91bG_pBiB9Vxy2pSM-wmmxkEiVAwDE8kgO1HpIDWg4r1xG_XuLC4nlDD4vNaV6R-bYRNsBRRbK-wBID8-6ePsF5kt6YxVcXb7itNc8uq1sWUTCwaHPmBHTUUTxypN-cIFvrDy5x91	2016-11-29 17:42:59
\.


--
-- Name: manage_gcmcode_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('manage_gcmcode_int_glcode_seq', 144, true);


--
-- Data for Name: message_list; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY message_list (int_glcode, fk_thread, fk_user_id, fk_post, var_user_name, var_message, dt_createdate, chr_read, own_delete, usr_delete) FROM stdin;
2140	500	9	291	DPSchwartz11	We really have to get these issues solved, Pratik :/	2016-01-22 12:45:55	1	0	0
2142	500	9	291	DPSchwartz11	it's so slow 	2016-01-22 12:50:14	1	0	0
2730	584	754	447	zain7197	no but I can get it	2016-08-19 20:54:14	1	0	0
2598	571	674	448	bpolito	Yo i like that i can do 25	2016-08-13 02:09:02	1	0	0
1798	460	61	239	syray	test	2015-12-22 13:06:04	1	0	0
1788	460	61	239	syray	test test	2015-12-22 12:21:43	1	0	0
1777	460	12	239	whittingslow	Hi from pratik iphone 6s	2015-12-22 11:38:41	1	0	0
1781	460	61	239	syray	test 2	2015-12-22 11:41:18	1	0	0
1782	460	12	239	whittingslow	iphone 6 2	2015-12-22 11:44:48	1	0	0
1784	460	61	239	syray	test 3	2015-12-22 11:48:15	1	0	0
1792	460	61	239	syray	got it. 	2015-12-22 12:56:19	1	0	0
1794	460	61	239	syray	testing	2015-12-22 13:01:36	1	0	0
1796	460	12	239	whittingslow	iphone 6 6	2015-12-22 13:03:59	1	0	0
1800	460	61	239	syray	message	2015-12-22 13:06:52	1	0	0
1802	460	12	239	whittingslow	iphone 6 8	2015-12-22 13:08:38	1	0	0
1910	460	12	239	whittingslow	test	2015-12-28 00:51:59	1	0	0
2578	564	636	414	m_houli30522	Do you still have the chair?	2016-08-12 18:34:22	1	0	0
26	5	194	293	thriftskool	Nice watch!	2016-02-02 15:57:38	1	0	0
1912	473	12	238	whittingslow	Test	2015-12-28 00:53:05	1	0	0
1914	473	12	238	whittingslow	test	2015-12-28 00:53:44	1	0	0
1933	473	61	238	syray	test1.1	2015-12-28 12:41:28	1	0	0
1935	473	12	238	whittingslow	test3	2015-12-28 12:47:17	1	0	0
41	3	183	2	john3	hey watsapp	2016-02-03 04:57:45	1	0	0
2629	574	570	461	IBinked	okay, that would be great	2016-08-14 15:51:46	1	0	0
2545	555	592	441	olivertru	ok nvm then but thanks for replying! 	2016-08-12 13:46:45	1	0	0
2111	498	212	285	john4	Hi Thomas	2016-01-21 12:33:29	1	0	0
2262	6	207	286	JosheyWashie	Yay! Thank you so much!	2016-02-12 16:07:25	1	0	0
62	3	180	2	john	gfhfdhdfhc	2016-02-10 14:34:38	1	0	0
2204	502	182	292	john2	ipad1	2016-01-25 05:48:52	1	0	0
2208	502	183	292	john3	iphone3	2016-01-25 05:50:32	1	0	0
2212	502	183	292	john3	iphone7	2016-01-25 06:22:41	1	0	0
2254	6	207	286	JosheyWashie	Oh, wow! I'm so excited for you. ❤️ Aha, I have some bad news though.	2016-02-12 15:55:15	1	0	0
2325	524	337	319	allison_hope14	What size?	2016-03-14 21:02:20	0	0	0
2074	494	30	248	shell27	yes 	2016-01-15 01:57:49	1	0	0
2618	574	696	461	npmenon	Nathalie 	2016-08-14 15:41:37	1	0	0
2076	494	30	248	shell27	oh oops ^^	2016-01-15 01:59:23	1	0	0
1778	460	61	239	syray	test	2015-12-22 11:40:06	1	0	0
1783	460	12	239	whittingslow	iphone 6 3	2015-12-22 11:47:30	1	0	0
1791	460	12	239	whittingslow	iphone 6 4	2015-12-22 12:55:01	1	0	0
1793	460	12	239	whittingslow	iphone 6 5	2015-12-22 13:00:17	1	0	0
1795	460	61	239	syray	iphone test	2015-12-22 13:02:14	1	0	0
1797	460	12	239	whittingslow	iphone 6 7	2015-12-22 13:05:05	1	0	0
1801	460	61	239	syray	messge2	2015-12-22 13:07:38	1	0	0
1803	460	12	239	whittingslow	iphone 6 9	2015-12-22 13:09:21	1	0	0
1911	460	12	239	whittingslow	test2	2015-12-28 00:52:36	1	0	0
1913	473	61	238	syray	jingle	2015-12-28 00:53:23	1	0	0
1932	473	12	238	whittingslow	test1	2015-12-28 12:39:24	1	0	0
1934	473	12	238	whittingslow	test2	2015-12-28 12:46:14	1	0	0
1936	473	61	238	syray	test test	2015-12-28 12:47:30	1	0	0
2113	498	194	285	thriftskool	test2	2016-01-21 12:40:15	1	0	0
2114	498	212	285	john4	test 1 from pratik	2016-01-21 12:41:57	1	0	0
2116	498	212	285	john4	ok	2016-01-21 12:42:48	1	0	0
2118	498	194	285	thriftskool	i recieved it	2016-01-21 12:48:38	1	0	0
2128	498	212	285	john4	test 2	2016-01-22 12:25:27	1	0	0
2130	498	212	285	john4	test 3	2016-01-22 12:26:49	1	0	0
2670	577	653	464	mddiaz11	just one	2016-08-15 15:13:34	1	0	0
2132	498	212	285	john4	test 4	2016-01-22 12:28:44	1	0	0
2134	498	212	285	john4	test 5	2016-01-22 12:33:00	1	0	0
2907	623	1073	568	rbj30218	still have the painting? 	2016-10-13 17:47:46	1	0	0
2715	581	732	416	jmk61297	ok thanks	2016-08-19 00:19:34	1	0	0
2263	522	349	313	ddp03394	yea so what is this	2016-02-16 05:19:18	1	0	0
2308	523	30	319	shell27	If I am 5"4 would this be too long?? 	2016-02-26 16:32:49	1	0	0
2082	494	30	248	shell27	no I didn't 	2016-01-18 14:42:23	1	0	0
2073	494	194	248	thriftskool	Hey this is Pete, let me know if you get this!	2016-01-15 00:54:00	1	0	0
51	6	207	286	JosheyWashie	Hey, there! I saw your post about the gray polo, and the title says that it's a medium, but your description says that it's a large. Aha, I would love to buy it, but I can only for a medium. Is there any way that you have a size medium?	2016-02-04 01:32:09	1	0	0
56	6	194	286	thriftskool	How about i message you sunday morning and we can meet in the middle! 	2016-02-04 01:50:30	1	0	0
2899	626	754	605	zain7197	cool thanks!	2016-10-07 18:27:15	1	0	0
2233	521	183	301	john3	yes	2016-02-11 07:02:14	1	0	0
2577	563	641	441	ericasnicole	ok thank you (:	2016-08-12 18:29:19	1	0	0
2077	494	194	248	thriftskool	did you get a notification to your phone? and a red icon	2016-01-15 02:00:20	1	0	0
57	6	207	286	JosheyWashie	that sounds like a plan!	2016-02-04 04:16:26	1	0	0
2258	6	194	286	thriftskool	ahh bummer! when are u coming back??	2016-02-12 16:06:01	1	0	0
61	6	194	286	thriftskool	absolutely! 	2016-02-08 15:23:11	1	0	0
2251	6	194	286	thriftskool	i'll be in athens all weekend with the shirt for you!	2016-02-12 15:37:44	1	0	0
2596	567	674	419	bpolito	down . hmu 2252290571	2016-08-13 02:06:49	1	0	0
2701	556	623	416	mjc16555	can I still get that guitar? 	2016-08-18 21:20:07	1	0	0
2566	563	194	441	thriftskool	small!	2016-08-12 16:36:28	1	0	0
2756	591	740	447	Ondea	I have $45	2016-08-20 17:21:38	1	0	0
2569	561	663	441	samcrawford34	:/ alright.	2016-08-12 16:39:46	1	0	0
2845	606	636	503	m_houli30522	are they sold yet?	2016-09-07 13:28:51	0	0	0
2681	581	194	416	thriftskool	i do!	2016-08-16 21:32:54	1	0	0
2634	560	194	413	thriftskool	can we meet*	2016-08-14 15:58:16	1	0	0
2685	583	647	452	haihanma	Do you have cable with it?	2016-08-17 18:49:06	1	0	0
2141	500	212	291	john4	test 1	2016-01-22 12:48:10	1	0	0
2205	502	183	292	john3	iPhone 1	2016-01-25 05:49:08	1	0	0
2846	604	766	472	brianasimone	When can I buy this 	2016-09-07 17:04:29	0	0	0
2209	502	183	292	john3	iphone4	2016-01-25 05:52:34	1	0	0
2213	502	183	292	john3	ipjone8	2016-01-25 06:22:57	1	0	0
2206	502	182	292	john2	ipad2	2016-01-25 05:49:29	1	0	0
2210	502	183	292	john3	iphone5	2016-01-25 05:54:07	1	0	0
2214	502	183	292	john3	iphone9	2016-01-25 06:23:10	1	0	0
3	2	182	2	john2	Hey	2016-02-01 13:39:13	1	0	0
2740	588	780	461	Kendall Clay	Hi! I am interested in these cork boards. Have you given them away yet?	2016-08-20 15:30:06	1	0	0
2203	502	183	292	john3	Iphone1	2016-01-25 05:48:33	1	0	0
2207	502	183	292	john3	iphone2	2016-01-25 05:50:14	1	0	0
2211	502	183	292	john3	iphone6	2016-01-25 05:54:42	1	0	0
2887	623	1073	568	rbj30218	hey! I still do. sorry. I was at the game... still	2016-10-02 01:56:22	1	0	0
2735	584	754	447	zain7197	even if u have $35 I have enough but if not yeah we can do that	2016-08-19 20:57:41	1	0	0
2613	553	194	441	thriftskool	can you meet at 130 to buy the fitbit?	2016-08-14 15:24:53	1	0	0
2538	555	194	441	thriftskool	yes it comes with the charging cable. interested? i already have several offers if you would like to make an offer	2016-08-12 13:07:46	1	0	0
2608	573	555	450	ahaertel	I can give you the book tomorrow if you'd like it	2016-08-14 01:43:15	1	0	0
2532	555	592	441	olivertru	Does everything come included? 	2016-08-12 04:14:07	1	0	0
2450	543	479	374	ams44393	I see this expires today but I could get it today and pay you. Not quite sure how this works.	2016-05-27 19:14:09	1	0	0
2406	534	194	361	thriftskool	do you want it?	2016-04-15 21:57:18	1	0	0
2445	541	194	377	thriftskool	still waiting! i want to give him a chance since we initially agreed	2016-05-11 18:53:33	1	0	0
2944	633	9	624	DPSchwartz11	Did you get this?	2016-11-15 11:55:27	1	0	0
2579	564	194	414	thriftskool	at this point someone agreed to buy but if it falls through ill let you know!	2016-08-12 18:43:51	1	0	0
2576	563	194	441	thriftskool	as of now someone has argeed to buy already but if it falls through ill let you know asap!	2016-08-12 18:25:19	1	0	0
2531	554	622	414	AnnaCorbould	Hi,\n\nI really love this chair but don't have transport.\n\nDo you still have it and how much would it be to drop off at family housing on Rogers Rd?\n\nKindest,\n\nAnna	2016-08-12 04:13:28	1	0	0
2133	498	194	285	thriftskool	testing 	2016-01-22 12:30:07	1	0	0
2945	633	194	624	thriftskool	yes, did you?	2016-11-15 12:18:23	1	0	0
2567	562	194	415	thriftskool	right now someone has agreed to buy but if they dont ill let u know!	2016-08-12 16:38:32	1	0	0
4	2	180	2	john	hello 2	2016-02-01 13:40:43	1	0	0
5	3	183	2	john3	hello	2016-02-01 14:01:04	1	0	0
6	3	183	2	john3	heyyy	2016-02-02 09:09:22	1	0	0
7	3	180	2	john	hello	2016-02-02 09:10:05	1	0	0
8	3	180	2	john	hey	2016-02-02 09:10:20	1	0	0
2129	498	194	285	thriftskool	test	2016-01-22 12:26:07	1	0	0
2112	498	194	285	thriftskool	test	2016-01-21 12:37:10	1	0	0
2115	498	194	285	thriftskool	now it worked.	2016-01-21 12:42:40	1	0	0
2117	498	212	285	john4	test 2 from pratik	2016-01-21 12:47:48	1	0	0
2119	498	212	285	john4	ok	2016-01-21 12:48:47	1	0	0
2127	498	212	285	john4	test 1	2016-01-22 12:24:52	1	0	0
2558	560	583	413	jwj11238	yeah I can do Sunday! what time and where are you thinking? 	2016-08-12 15:56:41	1	0	0
2523	552	589	414	shubh	hi i need this chair. when can i get this	2016-08-12 01:13:52	1	0	0
2131	498	194	285	thriftskool	testttt	2016-01-22 12:27:43	1	0	0
2533	556	623	416	mjc16555	Hey, I'll take that off your hands for $20!!! 	2016-08-12 04:17:43	1	0	0
52	6	194	286	thriftskool	yes its actually a medium! 	2016-02-04 01:36:01	1	0	0
2274	522	330	313	Drew	hahaha nice uga id stranger	2016-02-18 16:23:07	0	0	0
9	3	183	2	john3	yeyeye	2016-02-02 09:11:05	1	0	0
10	3	180	2	john	shaggy	2016-02-02 09:11:23	1	0	0
42	3	180	2	john	hey fine nd u 	2016-02-03 04:58:25	1	0	0
2326	525	180	328	john	testing	2016-03-15 12:19:17	0	0	0
2328	525	180	328	john	hello....	2016-03-15 12:48:35	0	0	0
2231	521	183	301	john3	hello\n	2016-02-11 07:00:31	1	0	0
2329	525	180	328	john	r u there?	2016-03-15 12:53:45	0	0	0
2597	566	674	414	bpolito	hmu 2252290571	2016-08-13 02:07:12	1	0	0
2888	623	1073	568	rbj30218	shaking my head, but yeah I still want it! 	2016-10-02 01:56:45	1	0	0
53	6	207	286	JosheyWashie	Yay! Is there a way that I can meet up with you to complete the transaction?	2016-02-04 01:38:56	1	0	0
55	6	207	286	JosheyWashie	Sure! Where would you like to meet,	2016-02-04 01:48:55	1	0	0
58	6	207	286	JosheyWashie	hey, do you still have those shirts?	2016-02-08 14:58:36	1	0	0
2592	568	678	414	bksingleton	I'm interested in the chair. Can you deliver if it doesn't fit in a Chevy Cavalier?	2016-08-12 22:30:05	1	0	0
2440	541	194	377	thriftskool	yes, ive actually had someone agree to pay $40 for it today	2016-05-08 21:54:29	1	0	0
2955	632	9	621	DPSchwartz11	Good! Mine is good enough! Let's get this thing in the App Store!	2016-11-16 18:21:55	1	0	0
60	6	207	286	JosheyWashie	It's okay! Puh-leaze message me when they come back.	2016-02-08 15:22:32	1	0	0
2529	553	194	441	thriftskool	ok! well i could always meet you on campus and see if it fits, just let me know :)	2016-08-12 03:51:12	1	0	0
2757	591	660	447	jmk68398	sorry I actually sold them yesterday and need to take the post down	2016-08-20 17:22:24	1	0	0
2255	6	194	286	thriftskool	your gone all weekend? ha	2016-02-12 16:00:45	1	0	0
2773	571	664	448	jonaha	Hey man! I have one shirt left. do you still want it?	2016-08-21 16:01:10	1	0	0
2539	555	194	441	thriftskool	offer	2016-08-12 13:07:52	1	0	0
2542	553	194	441	thriftskool	just a heads up ive recieved a few offers for it as well	2016-08-12 13:09:33	1	0	0
2259	6	207	286	JosheyWashie	Probably Sunday or Monday!	2016-02-12 16:06:40	1	0	0
2552	556	194	416	thriftskool	yeah no problem! ill message u wednesday	2016-08-12 14:20:12	1	0	0
2327	525	180	328	john	hey tester	2016-03-15 12:47:03	0	0	0
2330	525	180	328	john	r u there?	2016-03-15 12:53:45	0	0	0
2232	521	182	301	john2	hi	2016-02-11 07:01:43	1	0	0
2534	557	633	441	mnoxsel	Hi! I'd love to buy the Fitbit flex. Text me at (513) 518-0864 to work something out.	2016-08-12 11:17:44	1	0	0
2570	557	194	441	thriftskool	hi there! someone has already agreed to purchase but if they fall through ill let you know!	2016-08-12 16:40:12	1	0	0
2381	531	444	322	Mbatson	I'll give you $5 for just the Bluetooth remote. 	2016-03-29 13:44:58	1	0	0
2451	543	194	374	thriftskool	haha its set up for us to talk through here and we can exchange the $ in person. i actually am out of town now, are you in athens?	2016-05-27 19:17:20	1	0	0
54	6	194	286	thriftskool	can we meet this sunday?	2016-02-04 01:48:26	1	0	0
59	6	194	286	thriftskool	i do! I apologize for not getting to you, they are currently not in athens but they are set aside back home so as soon as i get them they are yours! sorry for the delay 	2016-02-08 15:00:04	1	0	0
2252	6	207	286	JosheyWashie	Will you be here today?	2016-02-12 15:45:14	1	0	0
2256	6	207	286	JosheyWashie	I am. 😔	2016-02-12 16:03:43	1	0	0
2260	6	207	286	JosheyWashie	Will you still be in Athens?	2016-02-12 16:07:10	1	0	0
2741	588	570	461	IBinked	nope not yet!	2016-08-20 15:42:47	1	0	0
2623	574	570	461	IBinked	okay I see. is sometime later today or possibly tomorrow okay? I'm about to go downtown for lunch	2016-08-14 15:43:35	1	0	0
2626	574	696	461	npmenon	if you want I can come nearer to you 	2016-08-14 15:44:43	1	0	0
2897	626	754	605	zain7197	Hey! I'm interested but it's a bit pricey for me. I have 40 bucks on me, does that work?	2016-10-07 18:22:52	1	0	0
2551	556	623	416	mjc16555	I actually won't be until Wednesday. would that be possible? 	2016-08-12 14:18:44	1	0	0
2599	571	664	448	jonaha	Sure! I can get it to you in a week! I'll let you know when I make another batch	2016-08-13 02:16:09	1	0	0
2614	556	194	416	thriftskool	can you meet at 130 today to get the guitar?!	2016-08-14 15:25:24	1	0	0
2600	571	664	448	jonaha	Is that cool with you?	2016-08-13 02:19:40	1	0	0
2630	574	696	461	npmenon	I'll let you know when I'll be there 	2016-08-14 15:54:18	1	0	0
2898	626	194	605	thriftskool	im probably going to stay at the $60 just because of how low the price already is, but thank u for the offer! 	2016-10-07 18:26:54	1	0	0
2593	569	678	416	bksingleton	I'd love to see this guitar, when and where can I check it out?	2016-08-12 22:32:55	1	0	0
2774	594	553	421	crazydwarf99	hey. id like to buy your thing.	2016-08-23 03:42:07	1	0	0
2956	635	622	634	AnnaCorbould	The futon looks great, we just moved here from England and it'd be really useful.\n\nAny chance you could deliver, we are on Rogers Rd and don't have s car yet :/\n\nKindest,\n\nAnna	2016-11-17 18:54:25	1	0	0
2690	584	660	447	jmk68398	definitely! I'm not home right now but should be by 6. when is a good time for you?	2016-08-17 21:08:34	1	0	0
2530	553	602	441	LAS20	Okay, could you meet me at the Journalism building between 11-12 tomorrow? 	2016-08-12 03:57:15	1	0	0
2932	632	194	621	thriftskool	Get this?	2016-11-12 03:36:54	1	0	0
2609	573	690	450	daniel565964	ill be at school monday is that ok	2016-08-14 02:07:48	1	0	0
2604	572	673	416	prh92592	Hey I am interested! Still available?	2016-08-13 16:39:04	1	0	0
2553	560	583	413	jwj11238	Hey I'm interested in your mini fridge. Does the thing 100% work? 	2016-08-12 15:29:24	1	0	0
2540	554	194	414	thriftskool	its ok i can bring it to you, do you mind if i bring it sunday? i have to go home for today and tomorrow	2016-08-12 13:08:33	1	0	0
2946	633	9	624	DPSchwartz11	yes sir	2016-11-15 12:47:40	1	0	0
2571	554	622	414	AnnaCorbould	yeah, that's ok, we should be about Sunday.	2016-08-12 17:48:16	1	0	0
2759	592	740	436	Ondea	I have $50	2016-08-20 17:26:54	1	0	0
2559	560	194	413	thriftskool	id say around lunch time and ill message u to meet up!	2016-08-12 16:06:19	1	0	0
2561	560	583	413	jwj11238	hell yeah! just send message me on this thing	2016-08-12 16:27:29	1	0	0
2524	552	194	414	thriftskool	i can have it to you by sunday afternoon if thats ok	2016-08-12 02:02:59	1	0	0
2441	541	321	377	JordanMcGriff	Is it still up for negotiation? if so, I will give you $45	2016-05-08 21:57:11	1	0	0
2446	541	321	377	JordanMcGriff	yeah I completely understand! there's no rush, I was just curious. have a good day!	2016-05-11 19:37:55	1	0	0
2908	623	1073	568	rbj30218	still have it? 	2016-10-22 23:15:57	1	0	0
2889	623	194	568	thriftskool	yaaa that was unbelievable :( ok cool! can we meet Monday?	2016-10-02 02:01:05	1	0	0
2580	564	636	414	m_houli30522	ok. thanks	2016-08-12 18:45:52	1	0	0
2546	552	589	414	shubh	sounds great. call me at 7065409129	2016-08-12 13:48:58	1	0	0
2819	602	673	483	prh92592	Hey I am interested in making some money during college. What does this job entail and what is the pay? Thanks, Patrick	2016-08-30 14:51:20	1	0	0
2847	607	973	532	ncm86561	Do you have a picture of it?	2016-09-14 18:44:08	1	0	0
2870	616	1028	566	bcd94145	When was the console purchased originally? 	2016-09-22 15:57:09	1	0	0
2872	617	738	585	gibdawg9	Yo I'm interested in this. Jw why it says #phidelt though? It doesn't say that in hat right?	2016-09-23 14:55:20	1	0	0
2881	621	979	587	coryc11	I'm selling a bunch of hats are you interested in buying the cowboy hat	2016-09-29 16:47:11	1	0	0
2736	584	660	447	jmk68398	just got $35 from my friend	2016-08-19 20:59:29	1	0	0
2253	6	194	286	thriftskool	no not today unfortunately i have an early valentines date haha	2016-02-12 15:49:22	1	0	0
2257	6	207	286	JosheyWashie	:(	2016-02-12 16:03:49	1	0	0
2261	6	194	286	thriftskool	okkk ill message u sunday!	2016-02-12 16:07:11	1	0	0
2686	584	754	447	zain7197	Hey! Are the beats still up for sale?	2016-08-17 21:01:04	1	0	0
2620	574	696	461	npmenon	what's yours and when can I pick it up ? 	2016-08-14 15:42:04	1	0	0
2624	574	696	461	npmenon	I'm free today after like 6 or tomorrow ! where do you love ? 	2016-08-14 15:44:07	1	0	0
2447	542	534	371	kat22598	What size is the second one? Or is it already sold?	2016-05-24 00:49:15	0	0	0
2452	544	467	382	cea97789	If you don't have any other offers I will take it off you for $5	2016-05-27 19:36:27	1	0	0
2631	574	570	461	IBinked	is it alright if we wait till later today? I'm about to be picked up to head out	2016-08-14 15:55:15	1	0	0
2900	627	1078	604	WadeCox3	Interested in buying the jersey	2016-10-08 15:23:06	1	0	0
2442	541	194	377	thriftskool	ok, im going to let the other buyer know so i will message him and let you know 	2016-05-08 21:59:01	1	0	0
2331	525	180	328	john	r u there?	2016-03-15 12:53:45	0	0	0
2695	584	754	447	zain7197	will do thanks!	2016-08-17 21:22:59	1	0	0
2691	584	754	447	zain7197	you're in one of the UGA dorms right?	2016-08-17 21:09:30	1	0	0
2376	525	180	328	john	msg by android	2016-03-16 06:52:44	0	0	0
2401	534	47	361	peterpin	I like this\n	2016-04-15 00:11:32	1	0	0
2562	562	641	415	ericasnicole	Is your chair still available?	2016-08-12 16:31:50	1	0	0
2588	566	674	414	bpolito	Yo i want to check out ur chair	2016-08-12 20:56:32	1	0	0
2625	574	696	461	npmenon	*live 	2016-08-14 15:44:12	1	0	0
2627	574	570	461	IBinked	I'm in O house	2016-08-14 15:45:30	1	0	0
2643	553	602	441	LAS20	yes, that works great! I'll be in a tan 1999 Toyota 4Runner and I'll park toward the back of the parking lot. 	2016-08-14 16:39:39	1	0	0
2560	561	663	441	samcrawford34	Still have available?\n	2016-08-12 16:18:17	1	0	0
2594	569	194	416	thriftskool	unfortunately someone has already agreed to buy it but if it falls through ill let u know asap!	2016-08-12 22:34:32	1	0	0
2525	553	602	441	LAS20	I'm interested in the Fitbit you're selling. What size is it? Also, does it come with the charging cable? 	2016-08-12 03:18:38	1	0	0
2541	553	194	441	thriftskool	hi ive actually had to go home for today and tomorrow but i can sunday if that works. 	2016-08-12 13:09:19	1	0	0
2568	561	194	441	thriftskool	right now someone has agreed to buy but if they dont ill let you know!	2016-08-12 16:39:02	1	0	0
2590	566	194	414	thriftskool	sorry someone agreed to buy but if it falls through ill let u know	2016-08-12 20:58:33	1	0	0
2574	563	641	441	ericasnicole	awesome! are you still selling	2016-08-12 18:23:48	1	0	0
2708	556	194	416	thriftskool	saturday*	2016-08-18 21:26:00	1	0	0
2572	554	622	414	AnnaCorbould	message my husband (Stu) on Sunday to arrange drop off his number is 706 765 8011. We are S108, 310 Rogers Rd, 30605.	2016-08-12 17:50:20	1	0	0
2775	594	194	421	thriftskool	ok great!	2016-08-23 03:44:13	1	0	0
2820	602	772	483	mattyp	Download the app and check it out! we are offering a $5 Starbucks gift card for all active users. it's basically uber and Twitter combined to create Bonnect!	2016-08-30 14:56:53	1	0	0
2890	623	1073	568	rbj30218	yeah that's good! 	2016-10-03 01:03:12	1	0	0
2637	553	602	441	LAS20	I can meet off campus (which would be way easier today) if you can. would you be able to meet at Kroger on Alps maybe? 	2016-08-14 16:21:24	1	0	0
2942	633	194	624	thriftskool	no. its supposed to be my dog. it was working earlier and not its not	2016-11-12 04:11:36	1	0	0
2677	580	727	442	lrh93032	Hi I'm a graduate of UGA but don't live in the area anymore. Would you be willing to ship these?\nThanks!\n-Leann	2016-08-16 20:43:41	1	0	0
2761	589	460	480	Scott_Brodmann26	very interested!	2016-08-20 17:35:02	1	0	0
2653	553	602	441	LAS20	there's no parking in the Kroger lot, so I'm in the Schlotzskys parking lot. 	2016-08-14 17:27:45	1	0	0
2702	556	194	416	thriftskool	yes! im sorry i had to come home for a funeral, can we meet saturday?	2016-08-18 21:21:46	1	0	0
2947	633	194	624	thriftskool	thank you sweet baby jesus	2016-11-15 12:49:39	1	0	0
2610	573	690	450	daniel565964	also what professor did you have	2016-08-14 02:08:06	1	0	0
2909	623	194	568	thriftskool	yes i do, i have had to leave athens for a few weeks for an emergency but will be back soon hopefully. want me to notify when im back?	2016-10-22 23:31:53	1	0	0
2679	578	194	465	thriftskool	what is this?	2016-08-16 20:44:42	1	0	0
2787	596	569	478	cp	You still selling this book? \n	2016-08-24 22:25:46	1	0	0
2957	636	871	634	Ruthy2016	Is that the lowest you will go?	2016-11-19 08:30:18	1	0	0
2661	560	583	413	jwj11238	okay I'll meet you outside	2016-08-14 18:28:22	1	0	0
2547	559	621	421	Jwdixon01	Hey I'm interested in buying your pull up bar. Looks like a good deal. Would you like to meet on campus at sometime today so I could buy it? \n-Joseph Dixon 336-880-4086	2016-08-12 13:58:18	1	0	0
2848	608	974	483	jts87689	Hi,\nI am looking to get more information on this job posting. I have never heard of this particular service and am intrigued in it. I am looking for a part time job, under 40 hours a week.	2016-09-14 18:52:10	1	0	0
2838	603	740	452	Ondea	I have $40?	2016-09-01 16:04:57	0	0	0
2674	573	555	450	ahaertel	are you still interested in buying the genetics book	2016-08-16 02:03:16	1	0	0
2933	632	194	621	thriftskool	where did all of our text thread go? i can only see my last two messages	2016-11-12 03:41:27	1	0	0
2671	577	708	464	rachelmoore	would you take $35 for it?	2016-08-15 15:14:29	1	0	0
2605	572	194	416	thriftskool	im sorry but its already been agreed to, if it falls through i will let you know!	2016-08-13 20:55:25	1	0	0
2880	621	1064	587	robdog508	Who are u	2016-09-29 03:24:38	1	0	0
2873	617	979	585	coryc11	No it's just for a thrift skool promotion thing.  If you have cash you can pick it up	2016-09-23 15:07:17	1	0	0
2682	582	738	438	gibdawg9	What size is it?	2016-08-16 22:10:40	1	0	0
2554	560	194	413	thriftskool	sure does! i just dont have a need for it anymore	2016-08-12 15:38:08	1	0	0
2656	560	194	413	thriftskool	ok cool. whats your address?	2016-08-14 17:30:13	1	0	0
2644	553	194	441	thriftskool	ok great! im in a silver truck with a chair in the my truck bed	2016-08-14 17:07:03	1	0	0
2737	584	754	447	zain7197	dude awesome thanks so much 	2016-08-19 21:00:56	1	0	0
2526	553	194	441	thriftskool	ah im sorry i forgot to post that! it is a size small and DOES come with the charger	2016-08-12 03:26:25	1	0	0
2543	553	602	441	LAS20	yeah, I'll definitely buy it (I can get a new band if it doesn't fit). And yeah,Sunday or Monday is fine. 	2016-08-12 13:36:46	1	0	0
2548	559	194	421	thriftskool	hey! id love to meet but i had an emergency at home at wont b back til sunday. can we meet then?	2016-08-12 14:01:03	1	0	0
2723	584	754	447	zain7197	cool I'll be there in like 20	2016-08-19 20:40:11	1	0	0
2776	594	194	421	thriftskool	however i had to come home for a family emergency, i will message you when i am back	2016-08-23 03:44:34	1	0	0
2589	567	674	419	bpolito	Yo i want to check out ur lamp	2016-08-12 20:57:05	1	0	0
2437	541	321	377	JordanMcGriff	Would you consider taking $25 for it?	2016-05-08 21:50:01	1	0	0
2720	584	754	447	zain7197	yes	2016-08-19 20:38:37	1	0	0
2402	534	194	361	thriftskool	it works perfectly and has no scratches or anything. I bought it for $100 but need some $ so asking $30	2016-04-15 00:37:51	1	0	0
2595	570	654	414	eddysanders1993	Hi, \n\nI'm interested in your chair. Can I pick it up tomorrow afternoon? Text me \n\nEddy Sanders\n2294129111	2016-08-12 22:46:32	1	0	0
2332	525	180	328	john	r u there?	2016-03-15 12:53:45	0	0	0
2573	554	194	414	thriftskool	ok will do, thanks!	2016-08-12 17:51:01	1	0	0
2563	563	641	441	ericasnicole	Hi! What size is your Fitbit 	2016-08-12 16:33:51	1	0	0
2808	598	194	499	thriftskool	just sent you an email about your gift card!!	2016-08-29 12:40:26	1	0	0
2941	633	9	624	DPSchwartz11	is it a weird 6?	2016-11-12 04:11:03	1	0	0
2788	577	653	464	mddiaz11	Are you still interested?	2016-08-27 18:14:12	1	0	0
2438	541	194	377	thriftskool	no. sorry, its already extremely priced really low	2016-05-08 21:51:01	1	0	0
2641	553	194	441	thriftskool	ok great. does 130 at kroger work for you?	2016-08-14 16:26:48	1	0	0
2672	577	653	464	mddiaz11	I'm pretty set on $40. it's literally out of the box and never used, so I think it's fair since this same set with only one ball retails for $53	2016-08-15 15:15:51	1	0	0
2606	573	690	450	daniel565964	is the book still available?	2016-08-13 21:42:15	1	0	0
2910	629	460	622	Scott_Brodmann26	Hi, can you tell me more about this mac? What's it's condition and storage and all?	2016-11-11 02:03:05	1	0	0
2611	573	555	450	ahaertel	yeah Monday sounds good. I had Armstrong and Hall, but all of the genetics department uses the same book	2016-08-14 02:09:48	1	0	0
2721	584	754	447	zain7197	can u text me the adress?	2016-08-19 20:39:05	1	0	0
2443	541	321	377	JordanMcGriff	Okay sounds good!	2016-05-08 22:02:08	1	0	0
2901	628	520	603	jojojacob	Is this price negotiable?	2016-10-12 05:26:18	1	0	0
2453	541	321	377	JordanMcGriff	hey! I hope your summer is going well so far. I just wanted to ask you if you had any updates on the tv? I think I may be coming down to Athens tomorrow, and it would be awesome if I could buy it from you while I'm down there. 	2016-05-27 21:20:22	1	0	0
2683	582	194	438	thriftskool	oops sorry its XL	2016-08-16 22:16:55	1	0	0
2821	571	664	448	jonaha	hey man do you still want this shirt? if not inhale someone else who would like to buy it.	2016-08-31 16:56:45	1	0	0
2675	574	570	461	IBinked	hey sorry I keep getting caught up with school! would you be able to meet me sometime between 2 and 5?	2016-08-16 15:38:34	1	0	0
2839	604	766	472	brianasimone	I'm interested in purchasing. 	2016-09-02 01:29:43	1	0	0
2616	574	696	461	npmenon	Hey ! I would like to get this please ! Meet up on campus ( preferably near reed )  ! \nThanks 	2016-08-14 15:40:39	1	0	0
2665	560	583	413	jwj11238	yeah man no problem! 	2016-08-14 23:43:17	1	0	0
2617	574	570	461	IBinked	okay! what's your name?	2016-08-14 15:41:11	1	0	0
2621	574	570	461	IBinked	Alrighty I'm Ingrid, do you live in Reed?	2016-08-14 15:42:19	1	0	0
2891	623	1073	568	rbj30218	just let me know where you would like to meet! also is the price firm? would you take 10$? 	2016-10-03 02:34:19	1	0	0
2849	609	973	495	ncm86561	I want them! Idk how this process actually works though	2016-09-14 19:01:00	1	0	0
2948	632	194	621	thriftskool	get this?	2016-11-16 18:00:53	1	0	0
2638	552	589	414	shubh	hey i am waiting to hear back from you	2016-08-14 16:23:19	1	0	0
2657	556	194	416	thriftskool	opps i forgot about wednesday!	2016-08-14 17:50:28	1	0	0
2716	587	770	416	wanders	What's the number on the inside (round opening behind strings)?	2016-08-19 02:24:20	1	0	0
2713	581	732	416	jmk61297	I'll buy it if you're still selling	2016-08-19 00:17:13	1	0	0
2668	572	673	416	prh92592	great thanks	2016-08-15 13:42:21	1	0	0
2958	636	871	634	Ruthy2016	hello?	2016-11-19 21:24:30	1	0	0
2707	556	194	416	thriftskool	absolutely. ThriftSkool is actually having an event from 5-7 at the MLC giving users free pizza. can we meet there?	2016-08-18 21:25:48	1	0	0
2934	632	9	621	DPSchwartz11	no clue!	2016-11-12 03:54:02	1	0	0
2718	584	754	447	zain7197	can I come get it in like 20 mins?	2016-08-19 20:29:02	1	0	0
2874	618	1044	589	RSS	I'll give you 8	2016-09-23 15:43:10	1	0	0
2555	560	583	413	jwj11238	I'm down to buy it then! How does this app work? do I just hand you cash whenever I come to get it?	2016-08-12 15:40:07	1	0	0
2557	560	194	413	thriftskool	ya we message back and forth in here but the money exchange is hand to hand to keep it simple! is sunday ok? i had to come home for the weekend	2016-08-12 15:54:21	1	0	0
2938	632	9	621	DPSchwartz11	yes	2016-11-12 03:55:32	1	0	0
2882	622	1066	594	mattclaffee	#beta	2016-09-30 15:24:45	1	0	0
2642	560	583	413	jwj11238	can we make it around 230? I'm actually in milledgeville right now but I'm heading back soon 	2016-08-14 16:38:00	1	0	0
2719	584	660	447	jmk68398	yeah that's perfect I just got home. you've got cash right?	2016-08-19 20:38:20	1	0	0
2632	574	696	461	npmenon	yeah yeah ! I'm in atl now so if I do come it's probably after 8 or tomorrow 	2016-08-14 15:56:01	1	0	0
2556	560	583	413	jwj11238	okay awesome! how does this work? do I just hand you cash when I go to pick it up?	2016-08-12 15:45:48	1	0	0
2694	584	660	447	jmk68398	sounds good just let me know	2016-08-17 21:22:07	1	0	0
2564	560	194	413	thriftskool	perfect!	2016-08-12 16:34:16	1	0	0
2633	560	194	413	thriftskool	hi! and we made around two today for the fridge? I can bring it to you 	2016-08-14 15:58:01	1	0	0
2902	627	194	604	thriftskool	awesome! its brand new with the fags still on it	2016-10-12 11:22:28	1	0	0
2747	588	780	461	Kendall Clay	ok! what time?	2016-08-20 15:56:40	1	0	0
2673	578	194	465	thriftskool	What is this	2016-08-15 21:28:31	1	0	0
2645	560	194	413	thriftskool	OK, I have to leave Athens at three so if we can meet before then that would be great	2016-08-14 17:07:59	1	0	0
2662	560	194	413	thriftskool	ok im in the driveway	2016-08-14 18:29:29	1	0	0
2549	559	621	421	Jwdixon01	Yeah just let me know when you are available 	2016-08-12 14:02:07	1	0	0
2439	541	321	377	JordanMcGriff	no worries. is $40 the lowest you're willing to go?	2016-05-08 21:52:43	1	0	0
2676	579	723	442	Yanchun	hello I want this\n\n	2016-08-16 20:26:04	1	0	0
2744	588	780	461	Kendall Clay	yeah! Would tomorrow work?	2016-08-20 15:54:31	1	0	0
2635	574	570	461	IBinked	awesome gotcha!	2016-08-14 16:02:22	1	0	0
2911	629	194	622	thriftskool	already sold, thank u for the interest tho!	2016-11-11 02:34:35	1	0	0
2444	541	321	377	JordanMcGriff	did you ever hear anything back from the other buyer?	2016-05-11 18:52:36	1	0	0
2777	594	553	421	crazydwarf99	okay. all goos.	2016-08-23 03:49:39	1	0	0
2680	581	732	416	jmk61297	Still have the guitar?	2016-08-16 21:32:06	1	0	0
2607	573	555	450	ahaertel	yes it is	2016-08-14 01:42:57	1	0	0
2652	553	194	441	thriftskool	here!	2016-08-14 17:26:41	1	0	0
2528	553	602	441	LAS20	No worries. I am really interested, but I'll have to check with the sizing chart. I may be a large. 	2016-08-12 03:49:53	1	0	0
2527	553	194	441	thriftskool	it works great I just recieved another as a gift. would you like to buy?	2016-08-12 03:26:55	1	0	0
2612	573	690	450	daniel565964	ok	2016-08-14 02:10:07	1	0	0
2728	584	660	447	jmk68398	I do not. do you have venmo?	2016-08-19 20:53:40	1	0	0
2544	553	194	441	thriftskool	ok thanks! i will message you sunday morning	2016-08-12 13:38:38	1	0	0
2727	584	754	447	zain7197	I have $105 sorry I thought I had change	2016-08-19 20:53:00	1	0	0
2550	553	602	441	LAS20	sounds good! Thanks!	2016-08-12 14:07:20	1	0	0
2537	556	194	416	thriftskool	ok sweet! i wont be back in athens until sunday. can we meet sunday?	2016-08-12 13:06:57	1	0	0
2724	584	660	447	jmk68398	might need to park across the street or just pull up right in front and I'll run out real quick	2016-08-19 20:52:17	1	0	0
2591	567	194	419	thriftskool	ok cool. im outta town today and tomorrow. sunday?	2016-08-12 20:59:11	1	0	0
2959	635	194	634	thriftskool	im sorry but it already sold! :( sorry i forgot to take the post down	2016-11-21 01:20:56	1	0	0
2636	553	602	441	LAS20	where at?	2016-08-14 16:20:48	1	0	0
2687	584	660	447	jmk68398	yes they are	2016-08-17 21:05:25	1	0	0
2669	577	708	464	rachelmoore	Hey, how many balls does the spikeball set come with?	2016-08-15 15:13:05	1	0	0
2704	582	194	438	thriftskool	interested?	2016-08-18 21:23:16	1	0	0
2575	562	641	415	ericasnicole	okay awesome! 	2016-08-12 18:24:01	1	0	0
2935	632	9	621	DPSchwartz11	get this?	2016-11-12 03:55:14	1	0	0
2892	624	1073	577	rbj30218	Will you take 20$? 	2016-10-03 02:35:19	1	0	0
2949	632	9	621	DPSchwartz11	yes sir 	2016-11-16 18:03:07	1	0	0
2850	610	707	486	thellmeister	Would you take $100 for them? 	2016-09-15 13:15:14	0	0	0
2840	604	755	472	mmm62173	Alright... I'm sure you know there's no access code with it right?	2016-09-02 01:33:46	1	0	0
2714	581	194	416	thriftskool	im sorry but it sold!	2016-08-19 00:18:22	1	0	0
2658	556	194	416	thriftskool	oops*	2016-08-14 17:50:35	1	0	0
2622	574	696	461	npmenon	no Payne hall ! but reed is more central 	2016-08-14 15:42:46	1	0	0
2883	623	1073	568	rbj30218	Hey! I would like to buy your painting! 	2016-10-01 05:28:07	1	0	0
2684	556	623	416	mjc16555	haha it's okay! can we still meet tomorrow? 	2016-08-17 03:26:09	1	0	0
2726	584	754	447	zain7197	do you have a $50 on you?	2016-08-19 20:52:41	1	0	0
2650	560	583	413	jwj11238	Okay, my GPS says I'll be back in an hour and five. if you want you can just meet me at my place on your way out of town and I'll get it from you then	2016-08-14 17:25:33	1	0	0
2659	560	583	413	jwj11238	416 first street Athens Georgia	2016-08-14 18:10:41	1	0	0
2664	560	194	413	thriftskool	thank you so much for the feedback! im constantly trying to improve the app so this really helps, thanks again!	2016-08-14 23:28:19	1	0	0
2628	574	696	461	npmenon	I can come there if you want too 	2016-08-14 15:48:55	1	0	0
2867	614	1020	561	mtmalcom	I'm interested in purchasing your product.  please email me at mtm07826@uga.edu	2016-09-21 02:38:33	0	0	0
2866	613	1020	566	mtmalcom	I'm interested in purchasing this item. please email me at mtm07826@uga.edu	2016-09-21 02:36:30	1	0	0
2688	584	660	447	jmk68398	I'm guessing you're interested?	2016-08-17 21:05:36	1	0	0
2722	584	660	447	jmk68398	112 foundry street Athens ga 30609	2016-08-19 20:39:28	1	0	0
2875	618	958	589	gavin.cagle51	who are you 👀	2016-09-23 15:51:02	1	0	0
2706	556	623	416	mjc16555	oh I'm so sorry. that should work. would it be possible to meet somewhere on campus? 	2016-08-18 21:24:51	1	0	0
2717	556	623	416	mjc16555	yeah that's fine! 	2016-08-19 13:48:54	1	0	0
2663	560	583	413	jwj11238	I meant to tell you this earlier but when you look at other schools for their stuff because you're visiting there or whatever, the app told me if I were to switch schools it would delete whatever things I had going on at the previous school and also for this message, I'm not a big fan of the text scrolling off the page when it starts getting long and also you should make it where the first letter is capitalized at the beginning of each sentence because I know I phone users aren't used to having to capitalize it so we tend to forget to capitalize it. other than that I wrote you a good review and the app is great! 	2016-08-14 18:53:39	1	0	0
2660	560	194	413	thriftskool	my phones about to die so i came to ur place. hope thats ok, here now	2016-08-14 18:28:06	1	0	0
2742	588	780	461	Kendall Clay	Can I have them? and where should I meet you to get them?	2016-08-20 15:52:02	1	0	0
2743	588	570	461	IBinked	sure! I'm about to go off campus so it won't be immediately but would o house be okay?	2016-08-20 15:52:53	1	0	0
2738	584	754	447	zain7197	1 min away can u come out?	2016-08-19 21:21:34	1	0	0
2876	618	1044	589	RSS	I'll never tell	2016-09-23 15:51:16	1	0	0
2868	615	1023	570	walkeronyou	Hey, I'm interested in your bass! My father had one as a kid and I would love to give him another. Is it in decent condition? Let me know. Thanks!	2016-09-21 03:57:52	1	0	0
2799	598	194	499	thriftskool	Congrats!! Thank you for posting in ThriftSkool im happy to tell you you've won a $100 amazon gift card!	2016-08-28 23:22:01	1	0	0
2841	604	755	472	mmm62173	is that cool	2016-09-02 01:33:58	1	0	0
2814	600	858	483	jrs1987	Hi,\n\nWhat are the requirements to drive for you all? Thanks!\n\nJarrod 	2016-08-30 03:14:55	1	0	0
2851	611	1009	561	Easondayone 	Would you take 30?	2016-09-20 23:07:23	0	0	0
2778	594	553	421	crazydwarf99	good	2016-08-23 03:49:49	1	0	0
2903	628	194	603	thriftskool	what do you have in mind?	2016-10-12 11:23:05	1	0	0
2936	632	194	621	thriftskool	did your messages go away too?	2016-11-12 03:55:19	1	0	0
2950	632	194	621	thriftskool	woooooooo!	2016-11-16 18:05:20	1	0	0
2960	636	194	634	thriftskool	im sorry for the late reply! i actually sold it right after i posted it. ut forgot to take it down. im sorry!	2016-11-21 01:21:28	1	0	0
2884	623	194	568	thriftskool	u won't be disappointed! where u at?	2016-10-01 05:41:40	1	0	0
2893	623	1073	568	rbj30218	?	2016-10-03 23:50:48	1	0	0
2745	588	780	461	Kendall Clay	or Monday?	2016-08-20 15:54:44	1	0	0
2753	588	780	461	Kendall Clay	okay!	2016-08-20 16:20:07	1	0	0
2693	584	754	447	zain7197	oh ok. yeah I'm in brumby but my car is out of power steering fluid. I'm gonna put it in on Friday then I can just drive over there and pick it up Friday. is that cool?	2016-08-17 21:12:38	1	0	0
2739	584	754	447	zain7197	actually wait	2016-08-19 21:22:47	1	0	0
2765	556	194	416	thriftskool	im here at the thriftskool event if you can swing by here!	2016-08-20 21:49:01	1	0	0
2877	619	850	585	ford	I want this 	2016-09-27 15:26:55	1	0	0
2885	615	194	570	thriftskool	dude im sorry for delayed response! its in perfect condition and wirks oerfectly! lets make a deal haha	2016-10-01 06:12:14	1	0	0
2937	632	194	621	thriftskool	yes	2016-11-12 03:55:29	1	0	0
2951	632	9	621	DPSchwartz11	can you find any issues?	2016-11-16 18:06:36	1	0	0
2952	632	194	621	thriftskool	nope. but we have until 1030 to find anything	2016-11-16 18:15:31	1	0	0
2842	604	766	472	brianasimone	yes that's fine. I just need the physical textbook	2016-09-03 19:01:44	1	0	0
2904	627	1078	604	WadeCox3	okay great I think I'll buy it from you then 	2016-10-12 13:44:39	1	0	0
2961	627	194	604	thriftskool	hello, im sorry i havent been back to athens in weeks due to emergencies. do you still want the jersey?	2016-11-21 01:39:07	1	0	0
2815	600	772	483	mattyp	Just download the app and sign up!!	2016-08-30 03:16:20	1	0	0
2894	623	194	568	thriftskool	hi im sorry i had to come to atlanta for a family emergency, can i message u when i return? im sorry	2016-10-03 23:53:52	1	0	0
2746	588	570	461	IBinked	tomorrow should be good!	2016-08-20 15:55:08	1	0	0
2771	588	780	461	Kendall Clay	Actually I've rethought my plan and I'm just going to get a bulletin board instead. sorry if that's an inconvenience!	2016-08-21 14:12:49	1	0	0
2754	589	460	480	Scott_Brodmann26	Do you have better pictures of these? I can't see the detail at all in the pictures. Thanks	2016-08-20 17:10:42	1	0	0
2878	619	979	585	coryc11	I'll give it to you for 9 if you come pick it up	2016-09-27 15:49:23	0	0	0
2939	633	9	624	DPSchwartz11	Great!	2016-11-12 04:10:18	1	0	0
2940	633	194	624	thriftskool	can you see my profike photo?	2016-11-12 04:10:47	1	0	0
2843	605	729	486	naziz17	100?	2016-09-03 23:22:57	0	0	0
2953	632	9	621	DPSchwartz11	ok cool	2016-11-16 18:15:55	1	0	0
2689	584	754	447	zain7197	yeah! can I come pick them up for $65	2016-08-17 21:07:38	1	0	0
2692	584	660	447	jmk68398	no I'm in the sigma chi house downtown	2016-08-17 21:09:56	1	0	0
2905	627	194	604	thriftskool	great! I've actually had to come home for a family event, can i get it to u sunday?	2016-10-12 13:45:17	1	0	0
2886	623	194	568	thriftskool	would u still like to buy?	2016-10-01 06:13:25	1	0	0
2895	623	1073	568	rbj30218	no problem! no rush, praying for you family! 	2016-10-04 03:16:29	1	0	0
2962	623	194	568	thriftskool	hi im sorry i havent been to athens in weeks bc of the emergency i mentioned, are u still interested?	2016-11-21 01:39:37	1	0	0
2748	588	570	461	IBinked	noon?	2016-08-20 16:02:26	1	0	0
2772	588	570	461	IBinked	it's fine!	2016-08-21 14:13:15	1	0	0
2896	625	1092	574	nishka	Hey! Can I try it on first? 	2016-10-05 21:36:08	1	0	0
2954	632	194	621	thriftskool	mine is working perfectly 	2016-11-16 18:19:29	1	0	0
2758	591	740	447	Ondea	it's okay, thanks anyway 	2016-08-20 17:23:56	1	0	0
2844	604	766	472	brianasimone	can I still buy the book?	2016-09-06 23:33:16	1	0	0
2906	627	1078	604	WadeCox3	yes that will work! thank you	2016-10-12 13:45:52	1	0	0
2943	634	801	624	Lindsay_O	how tall is it?	2016-11-14 17:06:51	1	0	0
2766	556	194	416	thriftskool	do you think you can make it up here?	2016-08-20 22:11:16	1	0	0
2879	620	729	567	naziz17	80?	2016-09-28 17:42:38	0	0	0
2729	584	754	447	zain7197	or I guess do u have $40	2016-08-19 20:53:58	1	0	0
2725	584	754	447	zain7197	ok cool	2016-08-19 20:52:31	1	0	0
2731	584	660	447	jmk68398	I don't have any cash on me	2016-08-19 20:55:04	1	0	0
2732	584	660	447	jmk68398	it's a pretty easy payment app that doesn't charge you anything If you use a debit card	2016-08-19 20:56:50	1	0	0
2733	584	754	447	zain7197	ok	2016-08-19 20:57:02	1	0	0
2734	584	754	447	zain7197	I'm gonna try that 	2016-08-19 20:57:18	1	0	0
\.


--
-- Name: message_list_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('message_list_int_glcode_seq', 2962, true);


--
-- Data for Name: message_thread; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY message_thread (int_glcode, fk_user_id, fk_post, var_user_name, var_message, dt_createdate, chr_read, post_name, post_owner_id, from_read, own_delete, usr_delete) FROM stdin;
571	674	448	bpolito	Yo i like that i can do 25	2016-08-31 16:56:45	1	Georgia Red Lightweight Tee	664	0	664	674
6	207	286	JosheyWashie	Hey, there! I saw your post about the gray polo, and the title says that it's a medium, but your description says that it's a large. Aha, I would love to buy it, but I can only for a medium. Is there any way that you have a size medium?	2016-02-12 16:07:25	1	Mens Polo Ralph Lauren polo - Medium	194	1	194	207
563	641	441	ericasnicole	Hi! What size is your Fitbit 	2016-08-12 18:29:19	1	Fitbit flex - works Perfect!!	194	1	194	641
498	212	285	john4	Hi Thomas	2016-01-22 12:33:00	1	Men's Polo Ralph Lauren white polo - Large	194	1	194	212
620	729	567	naziz17	80?	2016-09-28 17:42:38	0	Beats Solo2 Wireless	778	0	778	729
460	12	239	whittingslow	Hi from pratik iphone 6s	2015-12-28 00:52:36	1	ACSM's Certification Review	61	1	61	12
583	647	452	haihanma	Do you have cable with it?	2016-08-17 18:49:06	1	insignia 36 inch lcd	612	0	612	647
502	183	292	john3	Iphone1	2016-01-25 06:23:10	0	Pen drive foe sale	182	1	182	183
525	180	328	john	testing	2016-03-16 06:52:44	0	Test by etilox	182	0	182	180
473	12	238	whittingslow	Test	2015-12-28 12:47:30	1	Guidelines for Cardiac Rehab	61	1	61	12
2	182	2	john2	Hey	2016-02-01 13:40:43	1	final test	180	0	180	182
572	673	416	prh92592	Hey I am interested! Still available?	2016-08-15 13:42:21	1	Ibanez acoustic guitar for sale	194	1	194	673
3	183	2	john3	hello	2016-02-10 14:34:38	1	final test	180	1	180	183
524	337	319	allison_hope14	What size?	2016-03-14 21:02:20	0	Floor length Floral Maxi from Revolve	373	0	373	337
500	9	291	DPSchwartz11	We really have to get these issues solved, Pratik :/	2016-01-22 12:50:14	1	Elect chip for sale	212	1	212	
522	349	313	ddp03394	yea so what is this	2016-02-18 16:23:07	1	Accounting 2101 Study Resources	330	0	330	349
555	592	441	olivertru	Does everything come included? 	2016-08-12 13:46:45	1	Fitbit flex - works Perfect!!	194	0	194	592
559	621	421	Jwdixon01	Hey I'm interested in buying your pull up bar. Looks like a good deal. Would you like to meet on campus at sometime today so I could buy it? \n-Joseph Dixon 336-880-4086	2016-08-12 14:02:07	1	Pull-up/chin-up bar for sale	194	0	194	621
560	583	413	jwj11238	Hey I'm interested in your mini fridge. Does the thing 100% work? 	2016-08-14 23:43:17	1	Mini fridge! Works great perfect for dorms	194	0	194	583
582	738	438	gibdawg9	What size is it?	2016-08-18 21:23:16	1	NWT nike braves shirt	194	0	194	738
541	321	377	JordanMcGriff	Would you consider taking $25 for it?	2016-05-27 21:20:22	1	Magnavox 32" flatscreen 1080p tv	194	1	194	321
521	183	301	john3	hello\n	2016-02-11 07:02:14	1	Test 11 feb	182	1	182	183
566	674	414	bpolito	Yo i want to check out ur chair	2016-08-13 02:07:12	1	Black office chair	194	0	194	674
556	623	416	mjc16555	Hey, I'll take that off your hands for $20!!! 	2016-08-20 22:11:16	1	Ibanez acoustic guitar for sale	194	0	194	623
523	30	319	shell27	If I am 5"4 would this be too long?? 	2016-02-26 16:32:49	1	Floor length Floral Maxi from Revolve	373	1	373	30
494	194	248	thriftskool	Hey this is Pete, let me know if you get this!	2016-01-18 14:42:23	1	Green blouse 	30	1	30	194
574	696	461	npmenon	Hey ! I would like to get this please ! Meet up on campus ( preferably near reed )  ! \nThanks 	2016-08-16 15:38:34	1	hexagon cork boards	570	1	570	696
543	479	374	ams44393	I see this expires today but I could get it today and pay you. Not quite sure how this works.	2016-05-27 19:17:20	1	majestic Chipper Jones replica jersey	194	0	194	479
5	194	293	thriftskool	Nice watch!	2016-02-02 15:57:38	0	Michael Kors watch	221	1	221	194
633	9	624	DPSchwartz11	Great!	2016-11-15 12:49:39	1	Bookshelf	194	1	194	9
542	534	371	kat22598	What size is the second one? Or is it already sold?	2016-05-24 00:49:15	0	Dresses! (4 different, sold individually)	30	0	30	534
573	690	450	daniel565964	is the book still available?	2016-08-16 02:03:16	1	Genetics: A conceptual approach, 5th Edition	555	0	555	690
622	1066	594	mattclaffee	#beta	2016-09-30 15:24:45	1	Need a futon	1049	0	1049	1066
531	444	322	Mbatson	I'll give you $5 for just the Bluetooth remote. 	2016-03-29 13:44:58	0	PS3 Slim	397	1	397	444
544	467	382	cea97789	If you don't have any other offers I will take it off you for $5	2016-05-27 19:36:27	1	Golfer Lamp - you know its awesome!	194	1	194	467
567	674	419	bpolito	Yo i want to check out ur lamp	2016-08-13 02:06:49	1	Tall bedside or living room lamp	194	0	194	674
569	678	416	bksingleton	I'd love to see this guitar, when and where can I check it out?	2016-08-12 22:34:32	1	Ibanez acoustic guitar for sale	194	0	194	678
561	663	441	samcrawford34	Still have available?\n	2016-08-12 16:39:46	1	Fitbit flex - works Perfect!!	194	1	194	663
553	602	441	LAS20	I'm interested in the Fitbit you're selling. What size is it? Also, does it come with the charging cable? 	2016-08-14 17:27:45	1	Fitbit flex - works Perfect!!	194	1	194	602
562	641	415	ericasnicole	Is your chair still available?	2016-08-12 18:24:01	1	Super comfy big chair for sale	194	1	194	641
554	622	414	AnnaCorbould	Hi,\n\nI really love this chair but don't have transport.\n\nDo you still have it and how much would it be to drop off at family housing on Rogers Rd?\n\nKindest,\n\nAnna	2016-08-12 17:51:01	1	Black office chair	194	0	194	622
552	589	414	shubh	hi i need this chair. when can i get this	2016-08-14 16:23:19	1	Black office chair	194	0	194	589
568	678	414	bksingleton	I'm interested in the chair. Can you deliver if it doesn't fit in a Chevy Cavalier?	2016-08-12 22:30:05	1	Black office chair	194	0	194	678
564	636	414	m_houli30522	Do you still have the chair?	2016-08-12 18:45:52	1	Black office chair	194	1	194	636
557	633	441	mnoxsel	Hi! I'd love to buy the Fitbit flex. Text me at (513) 518-0864 to work something out.	2016-08-12 16:40:12	1	Fitbit flex - works Perfect!!	194	1	194	633
534	47	361	peterpin	I like this\n	2016-04-15 21:57:18	1	Fitbit Flex size small	194	0	194	47
579	723	442	Yanchun	hello I want this\n\n	2016-08-16 20:26:04	1	Womens Ray Ban gold Aviators	194	1	194	723
570	654	414	eddysanders1993	Hi, \n\nI'm interested in your chair. Can I pick it up tomorrow afternoon? Text me \n\nEddy Sanders\n2294129111	2016-08-12 22:46:32	1	Black office chair	194	1	194	654
578	194	465	thriftskool	What is this	2016-08-16 20:44:42	0	New alienware13 	677	1	677	194
592	740	436	Ondea	I have $50	2016-08-20 17:26:54	1	Beats headphones	194	0	194	740
588	780	461	Kendall Clay	Hi! I am interested in these cork boards. Have you given them away yet?	2016-08-21 14:13:15	1	hexagon cork boards	570	0	570	780
587	770	416	wanders	What's the number on the inside (round opening behind strings)?	2016-08-19 02:24:20	1	Ibanez acoustic guitar for sale	194	1	194	770
581	732	416	jmk61297	Still have the guitar?	2016-08-19 00:19:34	1	Ibanez acoustic guitar for sale	194	1	194	732
606	636	503	m_houli30522	are they sold yet?	2016-09-07 13:28:51	0	Beats by Dre Solo2 Wireless	778	0	778	636
584	754	447	zain7197	Hey! Are the beats still up for sale?	2016-08-19 21:22:47	1	Beats solo 2 headphones	660	0	660	754
615	1023	570	walkeronyou	Hey, I'm interested in your bass! My father had one as a kid and I would love to give him another. Is it in decent condition? Let me know. Thanks!	2016-10-01 06:12:14	1	Funny singing bass wall mount	194	0	194	1023
621	1064	587	robdog508	Who are u	2016-09-29 16:47:11	1	New Cowboy hat	979	1	979	1064
604	766	472	brianasimone	I'm interested in purchasing. 	2016-09-07 17:04:29	0	Spanish 1110	755	1		
602	673	483	prh92592	Hey I am interested in making some money during college. What does this job entail and what is the pay? Thanks, Patrick	2016-08-30 14:56:53	1	Bonnect Drivers!	772	1	772	673
598	194	499	thriftskool	Congrats!! Thank you for posting in ThriftSkool im happy to tell you you've won a $100 amazon gift card!	2016-08-29 12:40:26	0	Charcoal grey overall romper	842	1	842	194
610	707	486	thellmeister	Would you take $100 for them? 	2016-09-15 13:15:14	0	Beats solo 2 wireless	609	0	609	707
608	974	483	jts87689	Hi,\nI am looking to get more information on this job posting. I have never heard of this particular service and am intrigued in it. I am looking for a part time job, under 40 hours a week.	2016-09-14 18:52:10	1	Bonnect Drivers!	772	0	772	974
635	622	634	AnnaCorbould	The futon looks great, we just moved here from England and it'd be really useful.\n\nAny chance you could deliver, we are on Rogers Rd and don't have s car yet :/\n\nKindest,\n\nAnna	2016-11-21 01:20:56	1	Black futon for sale! EXCELLENT condition	194	0	194	622
600	858	483	jrs1987	Hi,\n\nWhat are the requirements to drive for you all? Thanks!\n\nJarrod 	2016-08-30 03:16:20	1	Bonnect Drivers!	772	0	772	858
632	194	621	thriftskool	Get this?	2016-11-16 18:21:55	1	Invest with the Fed	9	1	9	194
591	740	447	Ondea	I have $45	2016-08-20 17:23:56	1	Beats solo 2 headphones	660	0	660	740
607	973	532	ncm86561	Do you have a picture of it?	2016-09-14 18:44:08	0	Free People Affogato Hacci Top	910	1	910	973
611	1009	561	Easondayone 	Would you take 30?	2016-09-20 23:07:23	0	BISSELL PowerTrak Upright Vacuum	862	0	862	1009
609	973	495	ncm86561	I want them! Idk how this process actually works though	2016-09-14 19:01:00	0	Burgundy short rain boots	842	1	842	973
594	553	421	crazydwarf99	hey. id like to buy your thing.	2016-08-23 03:49:49	1	Pull-up/chin-up bar for sale	194	0	194	553
605	729	486	naziz17	100?	2016-09-03 23:22:57	0	Beats solo 2 wireless	609	0	609	729
589	460	480	Scott_Brodmann26	Do you have better pictures of these? I can't see the detail at all in the pictures. Thanks	2016-08-20 17:35:02	1	UGA Golf Polos	514	1	514	460
617	738	585	gibdawg9	Yo I'm interested in this. Jw why it says #phidelt though? It doesn't say that in hat right?	2016-09-23 15:07:17	1	Vintage Master's rope hat	979	0	979	738
614	1020	561	mtmalcom	I'm interested in purchasing your product.  please email me at mtm07826@uga.edu	2016-09-21 02:38:33	0	BISSELL PowerTrak Upright Vacuum	862	0	862	1020
580	727	442	lrh93032	Hi I'm a graduate of UGA but don't live in the area anymore. Would you be willing to ship these?\nThanks!\n-Leann	2016-08-16 20:43:41	1	Womens Ray Ban gold Aviators	194	1	194	727
603	740	452	Ondea	I have $40?	2016-09-01 16:04:57	0	insignia 36 inch lcd	612	0	612	740
613	1020	566	mtmalcom	I'm interested in purchasing this item. please email me at mtm07826@uga.edu	2016-09-21 02:36:30	1	Xbox One 500GB	988	0	988	1020
577	708	464	rachelmoore	Hey, how many balls does the spikeball set come with?	2016-08-27 18:14:12	1	Brand New Spikeball Set	653	1	653	708
625	1092	574	nishka	Hey! Can I try it on first? 	2016-10-05 21:36:08	0	Black Armani Exchange jacket	978	1	978	1092
596	569	478	cp	You still selling this book? \n	2016-08-24 22:25:46	1	BUSN 4000 textbook	732	1	732	569
619	850	585	ford	I want this 	2016-09-27 15:49:23	1	Vintage Master's rope hat	979	0	979	850
634	801	624	Lindsay_O	how tall is it?	2016-11-14 17:06:51	1	Bookshelf	194	0	194	801
618	1044	589	RSS	I'll give you 8	2016-09-23 15:51:16	1	Phillips Portable Speaker	958	0	958	1044
623	1073	568	rbj30218	Hey! I would like to buy your painting! 	2016-11-21 01:39:37	1	Awesome framed painting	194	0	194	1073
616	1028	566	bcd94145	When was the console purchased originally? 	2016-09-22 15:57:09	0	Xbox One 500GB	988	1	988	1028
626	754	605	zain7197	Hey! I'm interested but it's a bit pricey for me. I have 40 bucks on me, does that work?	2016-10-07 18:27:15	1	Beats Solo Headphones	194	0	194	754
624	1073	577	rbj30218	Will you take 20$? 	2016-10-03 02:35:19	0	Bar Stools	925	1	925	1073
627	1078	604	WadeCox3	Interested in buying the jersey	2016-11-21 01:39:07	1	BRAND NEW chipper jones jersey	194	0	194	1078
628	520	603	jojojacob	Is this price negotiable?	2016-10-12 11:23:05	1	Ticket from final game at Tuner Field	194	0	194	520
629	460	622	Scott_Brodmann26	Hi, can you tell me more about this mac? What's it's condition and storage and all?	2016-11-11 02:34:35	1	Mac	194	0	194	460
636	871	634	Ruthy2016	Is that the lowest you will go?	2016-11-21 01:21:28	1	Black futon for sale! EXCELLENT condition	194	0	194	871
\.


--
-- Name: message_thread_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('message_thread_int_glcode_seq', 636, true);


--
-- Data for Name: module_useraction; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY module_useraction (int_glcode, fk_modules, fk_useraction, chr_custom, chr_delete, dt_modifydate) FROM stdin;
\.


--
-- Name: module_useraction_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('module_useraction_int_glcode_seq', 1, false);


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY modules (int_glcode, var_modulename, var_module_listing, var_module_form_listing, var_header_text, var_header_class, fk_module, chr_edit_delete, chr_publish, chr_delete, chr_cached, dt_createdate, dt_modifydate, chr_adminpanel_module, chr_show_trashmanager, var_link, var_tablename, chr_filterflag, chr_pro_modulename, chr_menu, chr_group_access, chr_gallerymodule_flag, chr_custom, var_field) FROM stdin;
18	login					0	N	Y	N	N	2011-03-17	2011-03-25	Y	Y		\N	N	Login	Y	Y	N	N	
98	user_management/accesscontrol	Manage Users	Add user	User Management	icon-file	0	Y	Y	N	N	2013-08-22	2013-08-22	Y	Y		\N	Y	Staff	Y	Y	N	N	
1	dashboard			Dashboard	icon-home	0	Y	Y	N	N	2011-08-05	2013-04-03	Y	Y		\N	N	Dashboard	Y	Y	N	N	
142	job_management	Manage Jobs	Add Job	Job Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	N	Y		job_management	Y	job_management	Y	Y	Y	N	var_title
116	users					0	Y	Y	N	N	2013-12-08	2013-12-08	N	N		\N	N	Users	Y	Y	N	N	
131	newsletterleads	Manage Newsletter Leads				90	Y	Y	N	N	2014-10-18	2014-10-18	Y	Y		\N	Y	Newsletterleads	Y	Y	N	N	var_email
149	campus_buzz	Manage Campus Buzz	Add Buzz	Campus Buzz Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	campus_buzz	Y	campus_buzz	Y	Y	Y	N	var_title
4	contactus	Manage Contact Information				0	Y	Y	N	N	2012-02-09	2013-04-04	Y	Y		\N	Y	Contact Information	Y	Y	N	N	
11	trashmanager	Manage Trash Manager				8	Y	Y	N	N	2011-03-17	2013-04-04	N	Y		\N	N	Trash Manager	Y	Y	N	N	
10	settings/logmanager	Manage Log Manager				8	Y	Y	N	N	2011-04-15	2013-04-04	N	Y	index?module=settings	\N	N	Log Manager	Y	Y	N	N	
150	campus_buzz_gallery	Manage Buzz Gallery	Add New Image		icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	campus_buzz_gallery	Y	campus_buzz_gallery	N	Y	Y	N	var_title
141	university_management	Manage University	Add University	University Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y		university_management	Y	university_management	Y	Y	Y	N	var_title
133	banner	Manage Home Banners	Add Home Banner	Banners	icon-file	0	Y	Y	N	N	2014-05-08	2014-05-08	N	Y	module=banner	banner	Y	Home Banners	Y	Y	Y	N	var_title
17	module	Manage Modules	Add Module	Module	icon-home	0	Y	Y	N	N	2013-04-02	2013-04-04	Y	Y		modules	N	Module	N	Y	N	N	
90	contactusleads	Manage Contact Us Leads		Leads	icon-user-md	0	Y	Y	N	N	2013-07-31	2013-07-31	N	Y		contactdetails	Y	Contact Us Leads	Y	Y	Y	N	var_name
3	commonfile	Manage Common Files	Add Common File	Common File	icon-file	0	Y	Y	N	N	2012-12-06	2013-04-04	N	Y		commonfile	Y	Common Files	Y	Y	Y	N	var_title
143	post_category	Manage Post Category	Add Post Category	Post Category Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	post_category	Y	post_category	Y	Y	Y	N	var_title
144	post_management	Manage Post	Add Post	Post Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	post_management	Y	post_management	Y	Y	Y	N	var_title
145	webservice					0	Y	Y	N	N	2014-04-18	2014-04-18	Y	Y		\N	Y	Web Services	Y	Y	N	N	
2	pages	Manage Pages	Add Page	Pages	icon-file	0	Y	Y	N	N	2011-03-23	2013-03-28	N	Y	module=pages	pages	Y	Pages	Y	Y	Y	N	var_pagename
7	settings	Change Profile		Settings		8	Y	Y	N	N	2013-03-28	2013-04-04	N	Y		users	N	Change Profile	Y	Y	N	N	
8	settings/systemsettings	Manage System Settings		Settings	icon-cogs	0	Y	Y	N	N	2013-03-28	2013-03-29	N	Y		\N	N	Settings	Y	Y	N	N	
146	post_gallery	Manage Post Gallery	Add Post Image		icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	post_gallery	Y	post_gallery	N	Y	Y	N	var_title
99	user_management/groupaccess	Manage Group Access	Add Group Access	User Management		98	Y	Y	N	N	2013-08-22	2013-08-22	N	Y		\N	Y	Group Access	Y	Y	N	N	
100	user_management/modcontrol	Assign Module Action		User Management		98	Y	Y	N	N	2013-08-22	2013-08-22	N	Y	index.php?module=modcontrol	\N	N	Assign Module Action	Y	Y	N	N	
147	campus_deal	Manage Campus Deals	Add Deal	Campus Deal Management	icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	campus_deal	Y	campus_deal	Y	Y	Y	N	var_title
148	campus_gallery	Manage Deals Gallery	Add New Image		icon-file	0	Y	Y	N	N	2014-10-17	2014-10-18	Y	Y	' '	campus_gallery	Y	campus_gallery	N	Y	Y	N	var_title
151	university_leads	Manage University Request		Contact Request	icon-file	0	Y	Y	N	N	2015-10-17	2015-10-17	Y	Y		university_leads	Y	university_leads	Y	Y	N	N	var_name
152	contactusleads	Manage Contact Us		Contact Request	icon-user-md	151	Y	Y	N	N	2015-07-31	2015-07-31	Y	Y	''	contactusleads	Y	Contact Us Leads	Y	Y	N	N	var_name
\.


--
-- Name: modules_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('modules_int_glcode_seq', 1, false);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY pages (int_glcode, var_pagetype, chr_custom, var_pagename, var_alias, text_fulltext, var_pdffile, var_url_file, var_short_description, var_image, var_url_image, var_image1, var_url_image1, var_metatitle, var_metakeyword, var_metadescription, int_pagehits, int_mobhits, int_displayorder, chr_access, chr_previewstatus, chr_publish, chr_delete, fk_preview, dt_createdate, dt_modifydate, var_viewalias, chr_displaycontent, chr_displaybanner, var_bannerimage, chr_validimage, chr_crop, var_ipaddress, var_adminuser, chr_fixmodule, chr_menu_display, chr_image_display, chr_footer_display, chr_mainparent, fk_pages) FROM stdin;
\.


--
-- Name: pages_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('pages_int_glcode_seq', 1, false);


--
-- Data for Name: post_category; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY post_category (int_glcode, var_categoryname, dt_createdate, dt_modifydate, chr_delete, chr_publish, var_adminuser, var_ipaddress, fk_user_id, dt_expiredate, fk_university, var_image, var_backimage, int_displayorder) FROM stdin;
1	Textbooks	2015-09-03 11:06:01	2015-10-13 12:08:54	N	Y	Administrator	182.70.55.20	\N	\N	\N	Textbooks1441278360.png	textbook1444738134561cf456728c6.jpg	1
7	Tickets	2015-09-03 11:14:34	2015-10-13 12:12:13	N	Y	Administrator	182.70.55.20	\N	\N	\N	Tickets1441279719.png	Tickets1444738333561cf51d164e4.jpg	8
2	Campus Jobs	2015-09-03 11:16:12	2015-10-13 12:12:37	N	Y	Administrator	182.70.55.20	\N	\N	\N	jobs1441278972.png	Campus-jobs1444738357561cf535729a6.jpg	2
8	Housing	2015-09-03 11:10:09	2015-10-13 12:10:08	N	Y	Administrator	182.70.55.20	\N	\N	\N	Housing1441279614.png	Housing1444738208561cf4a03c370.jpg	4
3	Furniture	2015-09-03 11:06:59	2015-10-13 12:09:33	N	Y	Administrator	182.70.55.20	\N	\N	\N	Furniture1441279582.png	Furniture1444738173561cf47da362b.jpg	3
18	Mens Clothing	2015-09-03 11:10:57	2016-02-11 04:47:29	N	Y	Administrator	24.98.121.196	\N	\N	\N	Clothing1441279640.png	Clothing1444738239561cf4bfdba13.jpg	5
22	Womens Clothing	2016-02-11 05:01:49	2016-02-11 05:01:49	N	Y	Administrator	24.98.121.196	\N	\N	\N	Clothing1441279640145516690956bc15bd5a638.png	womens-clothing145516690956bc15bd5ba41.jpg	6
5	Electronics	2015-09-03 11:11:42	2015-10-13 12:11:08	N	Y	Administrator	182.70.55.20	\N	\N	\N	Electronics1441279665.png	Electronics1444738268561cf4dc66ca8.jpg	7
6	Free Stuff	2015-09-03 11:12:45	2015-10-13 12:11:28	N	Y	Administrator	182.70.55.20	\N	\N	\N	Free-stuff1441279693.png	Free-stuff1444738288561cf4f06d56a.jpg	9
14	Appliances	2015-09-03 11:22:17	2015-10-13 12:14:52	N	Y	Administrator	182.70.55.20	\N	\N	\N	Appliances1441279887.png	Appliances1444738492561cf5bc17180.jpg	10
11	Sporting Goods	2015-09-03 11:19:33	2015-10-13 12:13:37	N	Y	Administrator	182.70.55.20	\N	\N	\N	Sporting-goods1441279813.png	Sporting-goods1444738417561cf571497b9.jpg	11
23	Outdoors	2016-02-11 05:08:35	2016-02-11 05:08:35	N	Y	Administrator	24.98.121.196	\N	\N	\N	sun-2-xxl145516731556bc1753799bd.png	dH8aOb5145516731556bc17537c8a4.jpg	12
12	Jewelry	2015-09-03 11:20:32	2015-10-13 12:13:49	N	Y	Administrator	182.70.55.20	\N	\N	\N	Jewelry1441279839.png	Jewelry1444738429561cf57de6afc.jpg	13
9	Transportation	2015-09-03 11:16:54	2015-10-13 12:12:56	N	Y	Administrator	182.70.55.20	\N	\N	\N	Transportation1441279757.png	Transportation1444738376561cf548ad1ed.jpg	14
13	Tools	2015-09-03 11:21:15	2015-10-13 12:14:12	N	Y	Administrator	182.70.55.20	\N	\N	\N	Tools1441279862.png	Tools1444738452561cf5945a10b.jpg	15
17	Miscellaneous	2015-09-03 11:25:15	2015-10-13 12:15:45	N	Y	Administrator	182.70.55.20	\N	\N	\N	Miscellaneous1441279980.png	Miscellaneous1444738545561cf5f1bf5ec.jpg	16
16	Wanted (looking for)	2015-09-03 11:24:05	2015-10-13 12:15:29	N	Y	Administrator	182.70.55.20	\N	\N	\N	Wanted-(looking-for)1441279938.png	Wanted1444738529561cf5e160cb7.jpg	17
15	Swap	2015-09-03 11:23:07	2015-10-13 12:15:04	N	Y	Administrator	182.70.55.20	\N	\N	\N	Swap1441279914.png	Swap1444738504561cf5c82e309.jpg	18
\.


--
-- Name: post_category_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('post_category_int_glcode_seq', 23, true);


--
-- Data for Name: post_gallery; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY post_gallery (int_glcode, var_title, var_image, fk_post, fk_user_id, dt_createdate, dt_modifydate, chr_delete, chr_publish) FROM stdin;
452	\N	184-1.jpeg	184	30	2015-12-01 13:43:46	2015-12-01 00:00:00	N	Y
454	\N	185-2.jpeg	185	33	2015-12-01 13:43:46	2015-12-01 00:00:00	N	Y
456	\N	185-4.jpeg	185	33	2015-12-01 13:43:46	2015-12-01 00:00:00	N	Y
457	\N	235-1.jpeg	235	87	2015-12-04 00:00:00	2015-12-04 19:28:55	N	Y
458	\N	236-1.jpeg	236	71	2015-12-05 00:00:00	2015-12-05 19:58:17	N	Y
459	\N	236-2.jpeg	236	71	2015-12-05 00:00:00	2015-12-05 19:58:17	N	Y
460	\N	237-1.jpeg	237	117	2015-12-08 00:00:00	2015-12-08 05:55:54	N	Y
461	\N	237-2.jpeg	237	117	2015-12-08 00:00:00	2015-12-08 05:55:54	N	Y
462	\N	237-3.jpeg	237	117	2015-12-08 00:00:00	2015-12-08 05:55:55	N	Y
463	\N	238-1.jpeg	238	61	2015-12-11 00:00:00	2015-12-11 21:57:42	N	Y
464	\N	238-2.jpeg	238	61	2015-12-11 00:00:00	2015-12-11 21:57:42	N	Y
465	\N	238-3.jpeg	238	61	2015-12-11 00:00:00	2015-12-11 21:57:42	N	Y
466	\N	238-4.jpeg	238	61	2015-12-11 00:00:00	2015-12-11 21:57:43	N	Y
469	\N	240-1.jpeg	240	163	2015-12-13 00:00:00	2015-12-14 00:16:21	N	Y
474	\N	242-1.jpeg	242	92	2015-12-15 00:00:00	2015-12-15 03:53:42	N	Y
476	\N	244-1.jpeg	244	172	2015-12-15 17:03:36	2015-12-15 17:03:38	N	Y
477	\N	244-2.jpeg	244	172	2015-12-15 17:03:36	2015-12-15 17:03:38	N	Y
480	\N	246-1.jpeg	246	172	2015-12-15 17:07:25	2015-12-15 17:07:26	N	Y
481	\N	246-2.jpeg	246	172	2015-12-15 17:07:25	2015-12-15 17:07:26	N	Y
484	\N	248-1.jpeg	248	30	2015-12-16 00:00:00	2015-12-16 03:18:05	N	Y
485	\N	255-1.jpeg	255	175	2015-12-16 05:27:42	2015-12-16 05:32:39	N	Y
488	\N	257-1.jpeg	257	6	2015-12-18 06:58:02	2015-12-18 06:58:05	N	Y
490	\N	259-1.jpeg	259	12	2015-12-21 00:00:00	2015-12-21 22:53:08	N	Y
491	\N	260-1.jpeg	260	181	2015-12-22 00:00:00	2015-12-22 11:00:27	N	Y
493	\N	262-1.jpeg	262	180	2015-12-22 00:00:00	2015-12-22 11:19:44	N	Y
495	\N	264-1.jpeg	264	180	2015-12-22 11:33:41	2015-12-22 11:33:47	N	Y
497	\N	269-1.jpeg	269	66	2015-12-23 00:00:00	2015-12-24 01:40:18	N	Y
498	\N	271-1.jpeg	271	180	2015-12-24 00:00:00	2015-12-24 05:41:22	N	Y
500	\N	273-1.jpeg	273	12	2015-12-24 00:00:00	2015-12-24 05:47:16	N	Y
501	\N	274-1.jpeg	274	6	2015-12-31 05:38:08	2015-12-31 05:38:15	N	Y
502	\N	274-2.jpeg	274	6	2015-12-31 05:38:08	2015-12-31 05:38:15	N	Y
504	\N	276-1.jpeg	276	181	2016-01-07 04:42:02	2016-01-07 04:42:13	N	Y
505	\N	277-1.jpeg	277	9	2016-01-11 23:24:49	2016-01-11 23:24:58	N	Y
506	\N	277-2.jpeg	277	9	2016-01-11 23:24:49	2016-01-11 23:24:58	N	Y
507	\N	277-3.jpeg	277	9	2016-01-11 23:24:49	2016-01-11 23:24:58	N	Y
508	\N	278-1.jpeg	278	180	2016-01-12 05:40:39	2016-01-12 05:40:45	N	Y
511	\N	280-1.jpeg	280	9	2016-01-12 13:35:47	2016-01-12 13:35:51	N	Y
512	\N	280-2.jpeg	280	9	2016-01-12 13:35:47	2016-01-12 13:35:51	N	Y
513	\N	280-3.jpeg	280	9	2016-01-12 13:35:47	2016-01-12 13:35:51	N	Y
514	\N	281-1.jpeg	281	6	2016-01-13 05:57:44	2016-01-13 05:57:48	N	Y
515	\N	282-1.jpeg	282	194	2016-01-15 22:43:09	2016-01-15 22:43:12	N	Y
516	\N	282-2.jpeg	282	194	2016-01-15 22:43:09	2016-01-15 22:43:12	N	Y
519	\N	284-1.jpeg	284	194	2016-01-15 22:48:43	2016-01-15 22:48:45	N	Y
520	\N	284-2.jpeg	284	194	2016-01-15 22:48:43	2016-01-15 22:48:45	N	Y
524	\N	287-1.jpeg	287	6	2016-01-18 12:17:41	2016-01-18 12:17:44	N	Y
526	\N	289-1.jpeg	289	185	2016-01-18 20:24:26	2016-01-18 20:25:27	N	Y
528	\N	291-1.jpeg	291	212	2016-01-22 12:42:47	2016-01-22 12:43:00	N	Y
529	\N	292-1.jpeg	292	182	2016-01-25 04:47:01	2016-01-25 04:47:07	N	Y
530	\N	293-1.jpeg	293	221	2016-02-01 02:41:26	2016-02-01 02:41:35	N	Y
453	\N	185-1.jpeg	185	33	2015-12-01 13:43:46	2015-12-01 00:00:00	N	Y
455		185-3.jpeg	185	33	2015-12-01 13:43:46	2015-12-01 00:00:00	N	Y
467	\N	239-1.jpeg	239	61	2015-12-11 00:00:00	2015-12-11 21:56:07	N	Y
468	\N	239-2.jpeg	239	61	2015-12-11 00:00:00	2015-12-11 21:56:07	N	Y
470	\N	241-1.jpeg	241	170	2015-12-14 00:00:00	2015-12-14 02:19:11	N	Y
471	\N	241-2.jpeg	241	170	2015-12-14 00:00:00	2015-12-14 02:19:11	N	Y
472	\N	241-3.jpeg	241	170	2015-12-14 00:00:00	2015-12-14 02:19:11	N	Y
473	\N	241-4.jpeg	241	170	2015-12-14 00:00:00	2015-12-14 02:19:11	N	Y
475	\N	243-1.jpeg	243	171	2015-12-15 00:00:00	2015-12-15 03:59:56	N	Y
478	\N	245-1.jpeg	245	172	2015-12-15 17:05:13	2015-12-15 17:05:14	N	Y
479	\N	245-2.jpeg	245	172	2015-12-15 17:05:13	2015-12-15 17:05:14	N	Y
482	\N	247-1.jpeg	247	172	2015-12-15 17:08:33	2015-12-15 17:08:35	N	Y
483	\N	247-2.jpeg	247	172	2015-12-15 17:08:33	2015-12-15 17:08:35	N	Y
486	\N	256-1.jpeg	256	175	2015-12-16 14:59:17	2015-12-16 14:59:21	N	Y
487	\N	256-2.jpeg	256	175	2015-12-16 14:59:17	2015-12-16 14:59:21	N	Y
489	\N	258-1.jpeg	258	2	2015-12-18 00:00:00	2015-12-18 07:08:03	N	Y
492	\N	261-1.jpeg	261	180	2015-12-22 00:00:00	2015-12-22 11:07:45	N	Y
494	\N	263-1.jpeg	263	180	2015-12-22 11:28:58	2015-12-22 11:29:14	N	Y
496	\N	265-1.jpeg	265	9	2015-12-22 00:00:00	2015-12-22 23:51:10	N	Y
499	\N	272-1.jpeg	272	180	2015-12-24 00:00:00	2015-12-24 05:42:27	N	Y
503	\N	275-1.jpeg	275	181	2015-12-31 00:00:00	2015-12-31 08:40:17	N	Y
509	\N	279-1.jpeg	279	9	2016-01-12 13:33:43	2016-01-12 13:33:48	N	Y
510	\N	279-2.jpeg	279	9	2016-01-12 13:33:43	2016-01-12 13:33:48	N	Y
517	\N	283-1.jpeg	283	194	2016-01-15 22:45:34	2016-01-15 22:45:37	N	Y
518	\N	283-2.jpeg	283	194	2016-01-15 22:45:34	2016-01-15 22:45:37	N	Y
521	\N	285-1.jpeg	285	194	2016-01-15 22:52:02	2016-01-15 22:52:04	N	Y
522	\N	285-2.jpeg	285	194	2016-01-15 22:52:02	2016-01-15 22:52:04	N	Y
525	\N	288-1.jpeg	288	185	2016-01-18 20:23:22	2016-01-18 20:23:27	N	Y
527	\N	290-1.jpeg	290	185	2016-01-18 20:25:36	2016-01-18 20:27:40	N	Y
2	\N	2-1.jpeg	2	180	2016-02-01 13:37:03	2016-02-01 13:37:13	N	Y
8	\N	6-1.jpeg	6	9	2016-02-11 00:38:21	2016-02-11 00:38:38	N	Y
523	\N	286-1.jpeg	286	194	2016-01-15 22:54:03	2016-02-04 01:34:19	N	Y
3	\N	3-1.jpeg	3	183	2016-02-04 04:55:30	2016-02-04 04:56:03	N	Y
4	\N	3-2.jpeg	3	183	2016-02-04 04:56:03	2016-02-04 10:25:49	N	Y
5	test	3-3.jpg	3	0	2016-02-04 05:26:11	2016-02-04 05:26:11	N	Y
7	\N	5-1.jpeg	5	180	2016-02-10 14:33:46	2016-02-10 14:33:57	N	Y
9	\N	6-2.jpeg	6	9	2016-02-11 00:38:21	2016-02-11 00:38:38	N	Y
10	\N	6-3.jpeg	6	9	2016-02-11 00:38:21	2016-02-11 00:38:38	N	Y
11	\N	6-4.jpeg	6	9	2016-02-11 00:38:21	2016-02-11 00:38:38	N	Y
12	\N	7-1.jpeg	7	9	2016-02-11 00:41:22	2016-02-11 00:41:40	N	Y
13	\N	7-2.jpeg	7	9	2016-02-11 00:41:22	2016-02-11 00:41:40	N	Y
14	\N	7-3.jpeg	7	9	2016-02-11 00:41:22	2016-02-11 00:41:40	N	Y
15	\N	8-1.jpeg	8	9	2016-02-11 00:44:57	2016-02-11 00:45:09	N	Y
16	\N	8-2.jpeg	8	9	2016-02-11 00:44:57	2016-02-11 00:45:09	N	Y
17	\N	8-3.jpeg	8	9	2016-02-11 00:44:57	2016-02-11 00:45:09	N	Y
18	\N	8-4.jpeg	8	9	2016-02-11 00:44:57	2016-02-11 00:45:09	N	Y
19	\N	9-1.jpeg	9	9	2016-02-11 00:49:10	2016-02-11 00:49:22	N	Y
20	\N	9-2.jpeg	9	9	2016-02-11 00:49:10	2016-02-11 00:49:22	N	Y
21	\N	9-3.jpeg	9	9	2016-02-11 00:49:10	2016-02-11 00:49:22	N	Y
22	\N	9-4.jpeg	9	9	2016-02-11 00:49:10	2016-02-11 00:49:22	N	Y
23	\N	10-1.jpeg	10	9	2016-02-11 00:52:21	2016-02-11 00:52:48	N	Y
24	\N	10-2.jpeg	10	9	2016-02-11 00:52:21	2016-02-11 00:52:48	N	Y
25	\N	10-3.jpeg	10	9	2016-02-11 00:52:21	2016-02-11 00:52:48	N	Y
26	\N	10-4.jpeg	10	9	2016-02-11 00:52:21	2016-02-11 00:52:48	N	Y
37	\N	14-1.jpeg	14	9	2016-02-11 01:05:20	2016-02-11 01:05:35	N	Y
38	\N	14-2.jpeg	14	9	2016-02-11 01:05:20	2016-02-11 01:05:35	N	Y
39	\N	14-3.jpeg	14	9	2016-02-11 01:05:20	2016-02-11 01:05:35	N	Y
40	\N	15-1.jpeg	15	9	2016-02-11 01:08:34	2016-02-11 01:08:46	N	Y
41	\N	15-2.jpeg	15	9	2016-02-11 01:08:34	2016-02-11 01:08:46	N	Y
42	\N	15-3.jpeg	15	9	2016-02-11 01:08:34	2016-02-11 01:08:46	N	Y
27	\N	11-1.jpeg	11	9	2016-02-11 00:56:11	2016-02-11 00:56:26	N	Y
28	\N	11-2.jpeg	11	9	2016-02-11 00:56:11	2016-02-11 00:56:26	N	Y
29	\N	11-3.jpeg	11	9	2016-02-11 00:56:11	2016-02-11 00:56:26	N	Y
30	\N	11-4.jpeg	11	9	2016-02-11 00:56:11	2016-02-11 00:56:26	N	Y
46	\N	17-1.jpeg	17	9	2016-02-11 01:14:49	2016-02-11 01:15:04	N	Y
47	\N	17-2.jpeg	17	9	2016-02-11 01:14:49	2016-02-11 01:15:04	N	Y
31	\N	12-1.jpeg	12	9	2016-02-11 00:58:04	2016-02-11 00:58:18	N	Y
32	\N	12-2.jpeg	12	9	2016-02-11 00:58:04	2016-02-11 00:58:18	N	Y
33	\N	12-3.jpeg	12	9	2016-02-11 00:58:04	2016-02-11 00:58:18	N	Y
34	\N	13-1.jpeg	13	9	2016-02-11 01:02:57	2016-02-11 01:03:10	N	Y
35	\N	13-2.jpeg	13	9	2016-02-11 01:02:57	2016-02-11 01:03:10	N	Y
36	\N	13-3.jpeg	13	9	2016-02-11 01:02:57	2016-02-11 01:03:10	N	Y
43	\N	16-1.jpeg	16	9	2016-02-11 01:11:06	2016-02-11 01:11:23	N	Y
44	\N	16-2.jpeg	16	9	2016-02-11 01:11:06	2016-02-11 01:11:23	N	Y
45	\N	16-3.jpeg	16	9	2016-02-11 01:11:06	2016-02-11 01:11:23	N	Y
49	\N	301-1.jpeg	301	182	2016-02-11 06:59:41	2016-02-11 06:59:57	N	Y
50	\N	301-2.jpeg	301	182	2016-02-11 06:59:41	2016-02-11 06:59:57	N	Y
51	\N	302-1.jpeg	302	180	2016-02-11 08:45:31	2016-02-11 08:46:21	N	Y
52	\N	303-1.jpeg	303	180	2016-02-11 08:47:51	2016-02-11 08:48:19	N	Y
53	\N	304-1.jpeg	304	180	2016-02-11 10:29:38	2016-02-11 10:33:40	N	Y
54	\N	304-2.jpeg	304	180	2016-02-11 10:29:38	2016-02-11 10:33:40	N	Y
55	\N	304-3.jpeg	304	180	2016-02-11 10:33:40	2016-02-11 10:33:18	N	Y
56	\N	304-4.jpeg	304	180	2016-02-11 10:33:40	2016-02-11 10:33:18	N	Y
57	\N	305-1.jpeg	305	194	2016-02-11 11:56:45	2016-02-11 11:56:56	N	Y
58	\N	306-1.jpeg	306	194	2016-02-11 14:09:12	2016-02-11 14:09:23	N	Y
59	\N	307-1.jpeg	307	194	2016-02-11 14:35:51	2016-02-11 14:36:02	N	Y
60	\N	308-1.jpeg	308	194	2016-02-11 14:37:20	2016-02-11 14:37:30	N	Y
61	\N	309-1.jpeg	309	194	2016-02-11 14:41:48	2016-02-11 14:41:58	N	Y
62	\N	310-1.jpeg	310	194	2016-02-11 14:57:20	2016-02-11 14:58:37	N	Y
63	\N	310-2.jpeg	310	194	2016-02-11 14:58:37	2016-02-11 09:58:18	N	Y
64	\N	311-1.jpeg	311	194	2016-02-11 14:59:26	2016-02-11 14:59:37	N	Y
65	\N	312-1.jpeg	312	194	2016-02-12 01:01:24	2016-02-12 01:01:24	N	Y
66	\N	313-1.jpeg	313	330	2016-02-13 20:44:20	2016-02-13 20:44:18	N	Y
48	\N	18-1.jpeg	18	194	2016-02-11 01:34:40	2016-02-16 16:58:20	N	Y
67	\N	314-1.jpeg	314	30	2016-02-16 18:18:36	2016-02-16 18:18:29	N	Y
68	\N	314-2.jpeg	314	30	2016-02-16 18:18:36	2016-02-16 18:18:29	N	Y
69	\N	315-1.jpeg	315	30	2016-02-16 18:19:59	2016-02-16 18:19:52	N	Y
70	\N	315-2.jpeg	315	30	2016-02-16 18:19:59	2016-02-16 18:19:52	N	Y
71	\N	316-1.jpeg	316	30	2016-02-16 18:21:54	2016-02-16 18:21:48	N	Y
72	\N	316-2.jpeg	316	30	2016-02-16 18:21:54	2016-02-16 18:21:48	N	Y
73	\N	317-1.jpeg	317	30	2016-02-16 18:23:41	2016-02-16 18:23:41	N	Y
74	\N	317-2.jpeg	317	30	2016-02-16 18:23:41	2016-02-16 18:23:41	N	Y
75	\N	317-3.jpeg	317	30	2016-02-16 18:23:41	2016-02-16 18:23:41	N	Y
6	\N	4-1.jpeg	4	30	2016-02-10 14:08:02	2016-02-17 14:35:44	N	Y
76	\N	318-1.jpeg	318	359	2016-02-17 16:28:27	2016-02-17 16:28:28	N	Y
77	\N	319-1.jpeg	319	373	2016-02-17 23:41:06	2016-02-17 23:41:00	N	Y
78	\N	320-1.jpeg	320	380	2016-02-22 21:38:56	2016-02-22 21:39:06	N	Y
79	\N	321-1.jpeg	321	382	2016-02-23 19:00:13	2016-02-23 18:59:53	N	Y
80	\N	322-1.jpeg	322	397	2016-03-13 06:14:04	2016-03-13 06:13:27	N	Y
81	\N	322-2.jpeg	322	397	2016-03-13 06:14:04	2016-03-13 06:13:27	N	Y
82	\N	322-3.jpeg	322	397	2016-03-13 06:14:04	2016-03-13 06:13:27	N	Y
83	\N	322-4.jpeg	322	397	2016-03-13 06:14:04	2016-03-13 06:13:27	N	Y
84	\N	323-1.jpeg	323	194	2016-03-14 13:47:27	2016-03-14 13:46:33	N	Y
85	\N	324-1.jpeg	324	194	2016-03-14 13:48:53	2016-03-14 13:47:59	N	Y
86	\N	325-1.jpeg	325	194	2016-03-14 13:50:12	2016-03-14 13:49:18	N	Y
87	\N	326-1.jpeg	326	194	2016-03-14 13:51:16	2016-03-14 13:50:23	N	Y
88	\N	327-1.jpeg	327	194	2016-03-14 13:52:39	2016-03-14 13:51:46	N	Y
89	\N	328-1.jpeg	328	182	2016-03-15 12:15:09	2016-03-15 12:14:47	N	Y
91	\N	330-1.jpeg	330	407	2016-03-15 23:07:38	2016-03-15 23:06:44	N	Y
90	\N	329-1.jpeg	329	407	2016-03-15 23:04:51	2016-03-15 23:07:19	N	Y
92	\N	331-1.jpeg	331	181	2016-03-16 05:10:04	2016-03-16 05:07:48	N	Y
93	\N	332-1.jpeg	332	194	2016-03-16 05:12:34	2016-03-16 05:11:56	N	Y
94	\N	333-1.jpeg	333	194	2016-03-16 06:30:07	2016-03-16 06:29:42	N	Y
99	\N	334-5.jpeg	334	437	2016-03-24 01:24:58	2016-03-24 01:24:24	N	Y
100	\N	335-1.jpeg	335	437	2016-03-24 01:27:27	2016-03-24 01:26:20	N	Y
101	\N	335-2.jpeg	335	437	2016-03-24 01:27:27	2016-03-24 01:26:20	N	Y
102	\N	335-3.jpeg	335	437	2016-03-24 01:27:27	2016-03-24 01:26:20	N	Y
95	\N	334-1.jpeg	334	437	2016-03-24 01:24:58	2016-03-24 01:28:12	N	Y
96	\N	334-2.jpeg	334	437	2016-03-24 01:24:58	2016-03-24 01:28:12	N	Y
97	\N	334-3.jpeg	334	437	2016-03-24 01:24:58	2016-03-24 01:28:12	N	Y
98	\N	334-4.jpeg	334	437	2016-03-24 01:24:58	2016-03-24 01:28:12	N	Y
103	\N	336-1.jpeg	336	9	2016-03-25 00:39:10	2016-03-25 00:38:06	N	Y
104	\N	336-2.jpeg	336	9	2016-03-25 00:39:10	2016-03-25 00:38:06	N	Y
105	\N	337-1.jpeg	337	9	2016-03-25 00:43:19	2016-03-25 00:42:12	N	Y
106	\N	337-2.jpeg	337	9	2016-03-25 00:43:19	2016-03-25 00:42:12	N	Y
107	\N	337-3.jpeg	337	9	2016-03-25 00:43:19	2016-03-25 00:42:12	N	Y
108	\N	338-1.jpeg	338	9	2016-03-25 00:45:27	2016-03-25 00:44:22	N	Y
109	\N	338-2.jpeg	338	9	2016-03-25 00:45:27	2016-03-25 00:44:22	N	Y
110	\N	338-3.jpeg	338	9	2016-03-25 00:45:27	2016-03-25 00:44:22	N	Y
111	\N	339-1.jpeg	339	9	2016-03-25 00:48:39	2016-03-25 00:47:32	N	Y
112	\N	339-2.jpeg	339	9	2016-03-25 00:48:39	2016-03-25 00:47:32	N	Y
113	\N	340-1.jpeg	340	194	2016-03-25 02:08:29	2016-03-25 02:07:18	N	Y
114	\N	341-1.jpeg	341	194	2016-03-25 02:11:25	2016-03-25 02:10:30	N	Y
115	\N	341-2.jpeg	341	194	2016-03-25 02:11:25	2016-03-25 02:10:30	N	Y
116	\N	342-1.jpeg	342	194	2016-03-25 02:13:14	2016-03-25 02:12:21	N	Y
117	\N	342-2.jpeg	342	194	2016-03-25 02:13:14	2016-03-25 02:12:21	N	Y
118	\N	343-1.jpeg	343	194	2016-03-25 02:15:05	2016-03-25 02:13:55	N	Y
119	\N	344-1.jpeg	344	194	2016-03-25 02:16:25	2016-03-25 02:15:18	N	Y
120	\N	345-1.jpeg	345	194	2016-03-25 02:19:37	2016-03-25 02:18:46	N	Y
121	\N	345-2.jpeg	345	194	2016-03-25 02:19:37	2016-03-25 02:18:46	N	Y
122	\N	346-1.jpeg	346	181	2016-04-02 13:19:31	2016-04-02 13:18:25	N	Y
123	\N	347-1.jpeg	347	181	2016-04-04 08:58:12	2016-04-04 08:57:10	N	Y
124	\N	348-1.jpeg	348	30	2016-04-05 20:00:26	2016-04-05 19:58:54	N	Y
129	\N	351-2.jpeg	351	458	2016-04-06 13:56:56	2016-04-06 13:59:13	N	Y
130	\N	352-1.jpeg	352	458	2016-04-06 13:59:28	2016-04-06 13:57:55	N	Y
131	\N	353-1.jpeg	353	458	2016-04-06 14:00:23	2016-04-06 13:58:50	N	Y
128	\N	351-1.jpeg	351	458	2016-04-06 13:58:01	2016-04-06 13:59:13	N	Y
126	\N	350-1.jpeg	350	458	2016-04-06 13:57:14	2016-04-06 13:59:41	N	Y
127	\N	350-2.jpeg	350	458	2016-04-06 13:57:14	2016-04-06 13:59:41	N	Y
125	\N	349-1.jpeg	349	458	2016-04-06 13:56:18	2016-04-06 13:59:56	N	Y
132	\N	354-1.jpeg	354	458	2016-04-06 14:03:21	2016-04-06 14:01:48	N	Y
133	\N	355-1.jpeg	355	458	2016-04-06 14:04:01	2016-04-06 14:02:29	N	Y
134	\N	356-1.jpeg	356	458	2016-04-06 14:07:08	2016-04-06 14:05:37	N	Y
135	\N	356-2.jpeg	356	458	2016-04-06 14:07:08	2016-04-06 14:05:37	N	Y
136	\N	357-1.jpeg	357	458	2016-04-06 14:08:03	2016-04-06 14:06:31	N	Y
137	\N	357-2.jpeg	357	458	2016-04-06 14:08:03	2016-04-06 14:06:31	N	Y
138	\N	358-1.jpeg	358	181	2016-04-08 10:35:36	2016-04-08 10:34:32	N	Y
139	\N	359-1.jpeg	359	488	2016-04-13 03:59:07	2016-04-13 04:01:13	N	Y
140	\N	359-2.jpeg	359	488	2016-04-13 03:59:07	2016-04-13 04:01:13	N	Y
141	\N	359-3.jpeg	359	488	2016-04-13 03:59:07	2016-04-13 04:01:13	N	Y
142	\N	360-1.jpeg	360	194	2016-04-14 14:10:07	2016-04-14 14:08:19	N	Y
143	\N	361-1.jpeg	361	194	2016-04-14 14:11:13	2016-04-14 14:09:24	N	Y
144	\N	362-1.jpeg	362	194	2016-04-14 14:12:45	2016-04-14 14:10:57	N	Y
145	\N	363-1.jpeg	363	194	2016-04-14 14:13:59	2016-04-14 14:12:10	N	Y
146	\N	364-1.jpeg	364	485	2016-04-14 19:01:38	2016-04-14 19:00:15	N	Y
147	\N	364-2.jpeg	364	485	2016-04-14 19:01:38	2016-04-14 19:00:15	N	Y
148	\N	364-3.jpeg	364	485	2016-04-14 19:01:38	2016-04-14 19:00:15	N	Y
149	\N	364-4.jpeg	364	485	2016-04-14 19:01:38	2016-04-14 19:00:15	N	Y
150	\N	365-1.jpeg	365	181	2016-04-16 11:52:15	2016-04-16 11:50:39	N	Y
151	\N	366-1.jpeg	366	182	2016-04-16 11:58:56	2016-04-16 11:57:23	N	Y
152	\N	367-1.jpeg	367	481	2016-04-20 00:56:20	2016-04-20 00:54:28	N	Y
153	\N	367-2.jpeg	367	481	2016-04-20 00:56:20	2016-04-20 00:54:28	N	Y
154	\N	367-3.jpeg	367	481	2016-04-20 00:56:20	2016-04-20 00:54:28	N	Y
155	\N	368-1.jpeg	368	481	2016-04-20 00:58:27	2016-04-20 00:56:30	N	Y
156	\N	369-1.jpeg	369	481	2016-04-20 00:59:56	2016-04-20 00:58:03	N	Y
157	\N	370-1.jpeg	370	30	2016-04-27 13:15:23	2016-04-27 13:14:20	N	Y
158	\N	370-2.jpeg	370	30	2016-04-27 13:15:23	2016-04-27 13:14:20	N	Y
159	\N	370-3.jpeg	370	30	2016-04-27 13:15:23	2016-04-27 13:14:20	N	Y
160	\N	370-4.jpeg	370	30	2016-04-27 13:15:23	2016-04-27 13:14:20	N	Y
161	\N	371-1.jpeg	371	30	2016-04-27 13:17:48	2016-04-27 13:15:45	N	Y
162	\N	371-2.jpeg	371	30	2016-04-27 13:17:48	2016-04-27 13:15:45	N	Y
163	\N	371-3.jpeg	371	30	2016-04-27 13:17:48	2016-04-27 13:15:45	N	Y
164	\N	371-4.jpeg	371	30	2016-04-27 13:17:48	2016-04-27 13:15:45	N	Y
165	\N	372-1.jpeg	372	194	2016-04-27 19:42:54	2016-04-27 19:40:40	N	Y
166	\N	373-1.jpeg	373	194	2016-04-27 21:58:22	2016-04-27 21:56:11	N	Y
167	\N	373-2.jpeg	373	194	2016-04-27 21:58:22	2016-04-27 21:56:11	N	Y
168	\N	373-3.jpeg	373	194	2016-04-27 21:58:22	2016-04-27 21:56:11	N	Y
169	\N	374-1.jpeg	374	194	2016-04-27 22:00:57	2016-04-27 21:58:45	N	Y
170	\N	374-2.jpeg	374	194	2016-04-27 22:00:57	2016-04-27 21:58:45	N	Y
171	\N	375-1.jpeg	375	194	2016-04-27 22:03:13	2016-04-27 22:01:23	N	Y
172	\N	375-2.jpeg	375	194	2016-04-27 22:01:23	2016-04-27 18:03:23	N	Y
173	\N	376-1.jpeg	376	194	2016-04-27 22:06:07	2016-04-27 22:03:54	N	Y
174	\N	377-1.jpeg	377	194	2016-04-27 22:07:36	2016-04-27 22:05:28	N	Y
175	\N	377-2.jpeg	377	194	2016-04-27 22:07:36	2016-04-27 22:05:28	N	Y
176	\N	378-1.jpeg	378	194	2016-04-27 22:14:53	2016-04-27 22:12:41	N	Y
177	\N	379-1.jpeg	379	194	2016-04-27 22:16:55	2016-04-27 22:14:49	N	Y
178	\N	380-1.jpeg	380	194	2016-04-27 22:18:37	2016-04-27 22:16:24	N	Y
179	\N	381-1.jpeg	381	194	2016-04-27 22:20:41	2016-04-27 22:18:28	N	Y
180	\N	382-1.jpeg	382	194	2016-04-27 22:23:40	2016-04-27 22:21:29	N	Y
181	\N	383-1.jpeg	383	9	2016-04-28 02:02:43	2016-04-28 02:00:35	N	Y
182	\N	383-2.jpeg	383	9	2016-04-28 02:02:43	2016-04-28 02:00:35	N	Y
183	\N	384-1.jpeg	384	9	2016-04-28 02:04:50	2016-04-28 02:02:38	N	Y
184	\N	384-2.jpeg	384	9	2016-04-28 02:04:50	2016-04-28 02:02:38	N	Y
185	\N	384-3.jpeg	384	9	2016-04-28 02:04:50	2016-04-28 02:02:38	N	Y
186	\N	384-4.jpeg	384	9	2016-04-28 02:04:50	2016-04-28 02:02:38	N	Y
187	\N	385-1.jpeg	385	9	2016-04-28 02:06:00	2016-04-28 02:03:51	N	Y
188	\N	385-2.jpeg	385	9	2016-04-28 02:06:00	2016-04-28 02:03:51	N	Y
189	\N	386-1.jpeg	386	9	2016-04-28 02:08:32	2016-04-28 02:06:25	N	Y
190	\N	386-2.jpeg	386	9	2016-04-28 02:08:32	2016-04-28 02:06:25	N	Y
191	\N	386-3.jpeg	386	9	2016-04-28 02:08:32	2016-04-28 02:06:25	N	Y
192	\N	387-1.jpeg	387	9	2016-04-28 02:10:33	2016-04-28 02:08:22	N	Y
193	\N	387-2.jpeg	387	9	2016-04-28 02:10:33	2016-04-28 02:08:22	N	Y
194	\N	388-1.jpeg	388	9	2016-04-28 02:14:20	2016-04-28 02:12:13	N	Y
195	\N	388-2.jpeg	388	9	2016-04-28 02:14:20	2016-04-28 02:12:13	N	Y
196	\N	388-3.jpeg	388	9	2016-04-28 02:14:20	2016-04-28 02:12:13	N	Y
197	\N	388-4.jpeg	388	9	2016-04-28 02:14:20	2016-04-28 02:12:13	N	Y
198	\N	389-1.jpeg	389	9	2016-04-28 02:18:28	2016-04-28 02:16:19	N	Y
199	\N	389-2.jpeg	389	9	2016-04-28 02:18:28	2016-04-28 02:16:19	N	Y
200	\N	389-3.jpeg	389	9	2016-04-28 02:18:28	2016-04-28 02:16:19	N	Y
201	\N	390-1.jpeg	390	421	2016-04-29 17:10:30	2016-04-29 17:08:54	N	Y
206	\N	392-1.jpeg	392	119	2016-05-02 14:25:06	2016-05-02 14:22:54	N	Y
207	\N	392-2.jpeg	392	119	2016-05-02 14:25:06	2016-05-02 14:22:54	N	Y
208	\N	393-1.jpeg	393	119	2016-05-02 14:26:33	2016-05-02 14:24:12	N	Y
209	\N	394-1.jpeg	394	119	2016-05-02 14:27:29	2016-05-02 14:25:11	N	Y
210	\N	395-1.jpeg	395	119	2016-05-02 14:29:13	2016-05-02 14:26:52	N	Y
211	\N	396-1.jpeg	396	119	2016-05-02 14:30:27	2016-05-02 14:28:11	N	Y
212	\N	397-1.jpeg	397	207	2016-05-02 19:27:40	2016-05-02 19:27:35	N	Y
213	\N	397-2.jpeg	397	207	2016-05-02 19:27:40	2016-05-02 19:27:35	N	Y
214	\N	397-3.jpeg	397	207	2016-05-02 19:27:40	2016-05-02 19:27:35	N	Y
215	\N	397-4.jpeg	397	207	2016-05-02 19:27:40	2016-05-02 19:27:35	N	Y
216	\N	398-1.jpeg	398	207	2016-05-02 19:33:49	2016-05-02 19:32:40	N	Y
217	\N	398-2.jpeg	398	207	2016-05-02 19:33:49	2016-05-02 19:32:40	N	Y
218	\N	398-3.jpeg	398	207	2016-05-02 19:33:49	2016-05-02 19:32:41	N	Y
219	\N	399-1.jpeg	399	207	2016-05-02 19:38:14	2016-05-02 19:36:54	N	Y
220	\N	399-2.jpeg	399	207	2016-05-02 19:38:14	2016-05-02 19:36:54	N	Y
221	\N	399-3.jpeg	399	207	2016-05-02 19:38:14	2016-05-02 19:36:54	N	Y
222	\N	400-1.jpeg	400	421	2016-05-03 22:08:00	2016-05-04 03:27:23	N	Y
202	\N	391-1.jpeg	391	512	2016-05-01 16:02:42	2016-05-08 15:48:38	N	Y
203	\N	391-2.jpeg	391	512	2016-05-01 16:02:42	2016-05-08 15:48:38	N	Y
204	\N	391-3.jpeg	391	512	2016-05-01 16:02:42	2016-05-08 15:48:38	N	Y
205	\N	391-4.jpeg	391	512	2016-05-01 16:02:42	2016-05-08 15:48:38	N	Y
223	\N	401-1.jpeg	401	527	2016-05-08 17:54:23	2016-05-08 17:51:54	N	Y
224	\N	402-1.jpeg	402	194	2016-05-08 21:50:26	2016-05-08 21:47:54	N	Y
225	\N	403-1.jpeg	403	528	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y
226	\N	403-2.jpeg	403	528	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y
227	\N	403-3.jpeg	403	528	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y
228	\N	403-4.jpeg	403	528	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y
229	\N	403-5.jpeg	403	528	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y
230	\N	404-1.jpeg	404	409	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y
231	\N	404-2.jpeg	404	409	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y
232	\N	404-3.jpeg	404	409	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y
233	\N	404-4.jpeg	404	409	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y
234	\N	404-5.jpeg	404	409	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y
235	\N	405-1.jpeg	405	194	2016-06-09 03:42:38	2016-06-09 03:39:08	N	Y
236	\N	405-2.jpeg	405	194	2016-06-09 03:42:38	2016-06-09 03:39:08	N	Y
237	\N	405-3.jpeg	405	194	2016-06-09 03:42:38	2016-06-09 03:39:08	N	Y
238	\N	406-1.jpeg	406	194	2016-06-09 03:45:47	2016-06-09 03:42:16	N	Y
239	\N	406-2.jpeg	406	194	2016-06-09 03:45:47	2016-06-09 03:42:16	N	Y
240	\N	407-1.jpeg	407	194	2016-06-09 03:47:24	2016-06-09 03:43:52	N	Y
241	\N	408-1.jpeg	408	194	2016-06-09 03:48:45	2016-06-09 03:45:13	N	Y
242	\N	409-1.jpeg	409	194	2016-06-09 03:50:30	2016-06-09 03:47:16	N	Y
243	\N	409-2.jpeg	409	194	2016-06-09 03:50:30	2016-06-09 03:47:16	N	Y
244	\N	409-3.jpeg	409	194	2016-06-09 03:50:30	2016-06-09 03:47:16	N	Y
245	\N	410-1.jpeg	410	194	2016-06-09 03:53:07	2016-06-09 03:49:37	N	Y
246	\N	410-2.jpeg	410	194	2016-06-09 03:53:07	2016-06-09 03:49:37	N	Y
247	\N	411-1.jpeg	411	194	2016-06-09 03:54:37	2016-06-09 03:51:05	N	Y
248	\N	412-1.jpeg	412	524	2016-06-26 14:31:18	2016-06-26 14:28:32	N	Y
249	\N	413-1.jpeg	413	194	2016-07-31 20:18:47	2016-07-31 20:13:47	N	Y
250	\N	413-2.jpeg	413	194	2016-07-31 20:18:47	2016-07-31 20:13:47	N	Y
251	\N	414-1.jpeg	414	194	2016-07-31 20:22:59	2016-07-31 20:17:52	N	Y
252	\N	414-2.jpeg	414	194	2016-07-31 20:22:59	2016-07-31 20:17:52	N	Y
253	\N	414-3.jpeg	414	194	2016-07-31 20:22:59	2016-07-31 20:17:52	N	Y
254	\N	415-1.jpeg	415	194	2016-07-31 20:28:58	2016-07-31 20:23:51	N	Y
255	\N	415-2.jpeg	415	194	2016-07-31 20:28:58	2016-07-31 20:23:51	N	Y
256	\N	415-3.jpeg	415	194	2016-07-31 20:28:58	2016-07-31 20:23:51	N	Y
257	\N	416-1.jpeg	416	194	2016-07-31 20:32:04	2016-07-31 20:26:57	N	Y
258	\N	416-2.jpeg	416	194	2016-07-31 20:32:04	2016-07-31 20:26:57	N	Y
259	\N	416-3.jpeg	416	194	2016-07-31 20:32:04	2016-07-31 20:26:57	N	Y
260	\N	417-1.jpeg	417	194	2016-07-31 20:37:29	2016-07-31 20:32:23	N	Y
261	\N	417-2.jpeg	417	194	2016-07-31 20:37:29	2016-07-31 20:32:23	N	Y
262	\N	417-3.jpeg	417	194	2016-07-31 20:37:29	2016-07-31 20:32:23	N	Y
263	\N	418-1.jpeg	418	194	2016-07-31 20:43:53	2016-07-31 20:38:51	N	Y
264	\N	418-2.jpeg	418	194	2016-07-31 20:43:53	2016-07-31 20:38:51	N	Y
265	\N	418-3.jpeg	418	194	2016-07-31 20:43:53	2016-07-31 20:38:51	N	Y
266	\N	418-4.jpeg	418	194	2016-07-31 20:43:53	2016-07-31 20:38:51	N	Y
267	\N	419-1.jpeg	419	194	2016-07-31 20:47:56	2016-07-31 20:42:47	N	Y
268	\N	419-2.jpeg	419	194	2016-07-31 20:47:56	2016-07-31 20:42:47	N	Y
269	\N	419-3.jpeg	419	194	2016-07-31 20:47:56	2016-07-31 20:42:47	N	Y
270	\N	420-1.jpeg	420	194	2016-07-31 21:28:51	2016-07-31 21:23:37	N	Y
271	\N	420-2.jpeg	420	194	2016-07-31 21:28:51	2016-07-31 21:23:37	N	Y
272	\N	420-3.jpeg	420	194	2016-07-31 21:28:51	2016-07-31 21:23:37	N	Y
273	\N	421-1.jpeg	421	194	2016-07-31 21:29:58	2016-07-31 21:24:43	N	Y
274	\N	422-1.jpeg	422	194	2016-07-31 21:33:32	2016-07-31 21:28:19	N	Y
275	\N	422-2.jpeg	422	194	2016-07-31 21:33:32	2016-07-31 21:28:19	N	Y
276	\N	422-3.jpeg	422	194	2016-07-31 21:33:32	2016-07-31 21:28:19	N	Y
277	\N	422-4.jpeg	422	194	2016-07-31 21:33:32	2016-07-31 21:28:19	N	Y
278	\N	423-1.jpeg	423	194	2016-07-31 21:37:39	2016-07-31 21:32:28	N	Y
279	\N	423-2.jpeg	423	194	2016-07-31 21:37:39	2016-07-31 21:32:28	N	Y
280	\N	423-3.jpeg	423	194	2016-07-31 21:37:39	2016-07-31 21:32:28	N	Y
281	\N	423-4.jpeg	423	194	2016-07-31 21:37:39	2016-07-31 21:32:28	N	Y
282	\N	424-1.jpeg	424	194	2016-07-31 21:40:52	2016-07-31 21:35:38	N	Y
283	\N	424-2.jpeg	424	194	2016-07-31 21:40:52	2016-07-31 21:35:38	N	Y
284	\N	425-1.jpeg	425	194	2016-07-31 21:42:48	2016-07-31 21:37:36	N	Y
285	\N	425-2.jpeg	425	194	2016-07-31 21:42:48	2016-07-31 21:37:36	N	Y
286	\N	426-1.jpeg	426	194	2016-07-31 21:44:09	2016-07-31 21:40:15	N	Y
287	\N	426-2.jpeg	426	194	2016-07-31 21:44:09	2016-07-31 21:40:15	N	Y
288	\N	427-1.jpeg	427	194	2016-07-31 21:49:47	2016-07-31 21:44:43	N	Y
289	\N	427-2.jpeg	427	194	2016-07-31 21:49:47	2016-07-31 21:44:43	N	Y
290	\N	427-3.jpeg	427	194	2016-07-31 21:49:47	2016-07-31 21:44:43	N	Y
291	\N	428-1.jpeg	428	9	2016-08-04 23:29:47	2016-08-04 23:24:30	N	Y
292	\N	428-2.jpeg	428	9	2016-08-04 23:29:47	2016-08-04 23:24:30	N	Y
293	\N	428-3.jpeg	428	9	2016-08-04 23:29:47	2016-08-04 23:24:30	N	Y
294	\N	429-1.jpeg	429	9	2016-08-04 23:32:23	2016-08-04 23:27:01	N	Y
295	\N	429-2.jpeg	429	9	2016-08-04 23:32:23	2016-08-04 23:27:01	N	Y
296	\N	429-3.jpeg	429	9	2016-08-04 23:32:23	2016-08-04 23:27:01	N	Y
297	\N	430-1.jpeg	430	9	2016-08-04 23:33:46	2016-08-04 23:28:23	N	Y
298	\N	431-1.jpeg	431	9	2016-08-04 23:35:41	2016-08-04 23:30:22	N	Y
299	\N	431-2.jpeg	431	9	2016-08-04 23:35:41	2016-08-04 23:30:22	N	Y
300	\N	432-1.jpeg	432	9	2016-08-04 23:37:15	2016-08-04 23:31:54	N	Y
301	\N	433-1.jpeg	433	9	2016-08-05 11:54:37	2016-08-05 11:49:18	N	Y
302	\N	433-2.jpeg	433	9	2016-08-05 11:54:37	2016-08-05 11:49:18	N	Y
303	\N	433-3.jpeg	433	9	2016-08-05 11:54:37	2016-08-05 11:49:18	N	Y
304	\N	434-1.jpeg	434	9	2016-08-05 21:43:50	2016-08-05 21:38:30	N	Y
305	\N	434-2.jpeg	434	9	2016-08-05 21:43:50	2016-08-05 21:38:30	N	Y
306	\N	434-3.jpeg	434	9	2016-08-05 21:43:50	2016-08-05 21:38:30	N	Y
307	\N	435-1.jpeg	435	338	2016-08-09 23:54:21	2016-08-09 23:48:46	N	Y
308	\N	435-2.jpeg	435	338	2016-08-09 23:54:21	2016-08-09 23:48:46	N	Y
309	\N	436-1.jpeg	436	194	2016-08-12 00:20:26	2016-08-12 00:14:54	N	Y
310	\N	436-2.jpeg	436	194	2016-08-12 00:20:26	2016-08-12 00:14:54	N	Y
311	\N	436-3.jpeg	436	194	2016-08-12 00:20:26	2016-08-12 00:14:54	N	Y
312	\N	437-1.jpeg	437	194	2016-08-12 00:23:26	2016-08-12 00:18:18	N	Y
313	\N	437-2.jpeg	437	194	2016-08-12 00:23:26	2016-08-12 00:18:18	N	Y
314	\N	437-3.jpeg	437	194	2016-08-12 00:23:26	2016-08-12 00:18:18	N	Y
318	\N	439-1.jpeg	439	194	2016-08-12 00:28:15	2016-08-12 00:22:39	N	Y
319	\N	439-2.jpeg	439	194	2016-08-12 00:28:15	2016-08-12 00:22:39	N	Y
320	\N	439-3.jpeg	439	194	2016-08-12 00:28:15	2016-08-12 00:22:39	N	Y
324	\N	443-1.jpeg	443	581	2016-08-12 00:52:57	2016-08-12 00:47:32	N	Y
325	\N	443-2.jpeg	443	581	2016-08-12 00:52:57	2016-08-12 00:47:32	N	Y
326	\N	444-1.jpeg	444	581	2016-08-12 00:57:37	2016-08-12 00:52:17	N	Y
327	\N	445-1.jpeg	445	581	2016-08-12 00:59:14	2016-08-12 00:53:47	N	Y
328	\N	446-1.jpeg	446	598	2016-08-12 01:35:27	2016-08-12 01:31:10	N	Y
329	\N	447-1.jpeg	447	660	2016-08-12 15:22:37	2016-08-12 15:17:00	N	Y
315	\N	438-1.jpeg	438	194	2016-08-12 00:26:10	2016-08-16 22:11:18	N	Y
317	\N	438-3.jpeg	438	194	2016-08-12 00:26:10	2016-08-16 22:11:18	N	Y
321	\N	440-1.jpeg	440	194	2016-08-12 00:32:58	2016-08-23 03:20:06	N	Y
323	\N	442-1.jpeg	442	194	2016-08-12 00:37:11	2016-08-23 23:34:08	N	Y
322	\N	441-1.jpeg	441	194	2016-08-12 00:35:16	2016-08-12 16:32:02	N	Y
330	\N	448-1.jpeg	448	664	2016-08-12 16:49:20	2016-08-12 16:45:03	N	Y
331	\N	449-1.jpeg	449	664	2016-08-12 16:51:44	2016-08-12 16:46:31	N	Y
332	\N	450-1.jpeg	450	555	2016-08-12 23:40:07	2016-08-12 23:34:28	N	Y
333	\N	451-1.jpeg	451	612	2016-08-13 01:41:36	2016-08-13 01:35:57	N	Y
334	\N	452-1.jpeg	452	612	2016-08-13 15:17:40	2016-08-13 15:12:20	N	Y
335	\N	452-2.jpeg	452	612	2016-08-13 15:17:40	2016-08-13 15:12:20	N	Y
336	\N	453-1.jpeg	453	9	2016-08-13 15:48:40	2016-08-13 15:43:04	N	Y
337	\N	453-2.jpeg	453	9	2016-08-13 15:48:40	2016-08-13 15:43:04	N	Y
338	\N	453-3.jpeg	453	9	2016-08-13 15:48:40	2016-08-13 15:43:04	N	Y
339	\N	454-1.jpeg	454	9	2016-08-13 15:50:55	2016-08-13 15:45:20	N	Y
340	\N	454-2.jpeg	454	9	2016-08-13 15:50:55	2016-08-13 15:45:20	N	Y
341	\N	454-3.jpeg	454	9	2016-08-13 15:50:55	2016-08-13 15:45:20	N	Y
342	\N	455-1.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
343	\N	455-2.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
344	\N	455-3.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
345	\N	455-4.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
346	\N	455-5.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
347	\N	455-6.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
348	\N	455-7.jpeg	455	9	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y
349	\N	456-1.jpeg	456	9	2016-08-13 16:09:36	2016-08-13 16:03:56	N	Y
350	\N	456-2.jpeg	456	9	2016-08-13 16:09:36	2016-08-13 16:03:56	N	Y
351	\N	456-3.jpeg	456	9	2016-08-13 16:09:36	2016-08-13 16:03:56	N	Y
352	\N	457-1.jpeg	457	9	2016-08-13 16:14:44	2016-08-13 16:09:10	N	Y
353	\N	457-2.jpeg	457	9	2016-08-13 16:14:44	2016-08-13 16:09:10	N	Y
354	\N	457-3.jpeg	457	9	2016-08-13 16:14:44	2016-08-13 16:09:10	N	Y
355	\N	458-1.jpeg	458	688	2016-08-13 16:35:33	2016-08-13 16:29:52	N	Y
356	\N	458-2.jpeg	458	688	2016-08-13 16:35:33	2016-08-13 16:29:52	N	Y
357	\N	459-1.jpeg	459	570	2016-08-13 17:13:10	2016-08-13 17:07:30	N	Y
358	\N	459-2.jpeg	459	570	2016-08-13 17:13:10	2016-08-13 17:07:30	N	Y
359	\N	459-3.jpeg	459	570	2016-08-13 17:13:10	2016-08-13 17:07:30	N	Y
360	\N	460-1.jpeg	460	570	2016-08-13 17:17:10	2016-08-13 17:11:29	N	Y
361	\N	460-2.jpeg	460	570	2016-08-13 17:17:10	2016-08-13 17:11:29	N	Y
362	\N	460-3.jpeg	460	570	2016-08-13 17:17:10	2016-08-13 17:11:29	N	Y
363	\N	461-1.jpeg	461	570	2016-08-13 17:19:16	2016-08-13 17:14:07	N	Y
364	\N	461-2.jpeg	461	570	2016-08-13 17:19:16	2016-08-13 17:14:07	N	Y
365	\N	462-1.jpeg	462	612	2016-08-13 20:40:03	2016-08-13 20:34:27	N	Y
366	\N	462-2.jpeg	462	612	2016-08-13 20:40:03	2016-08-13 20:34:27	N	Y
367	\N	463-1.jpeg	463	569	2016-08-15 11:43:28	2016-08-15 11:37:49	N	Y
368	\N	463-2.jpeg	463	569	2016-08-15 11:43:28	2016-08-15 11:37:49	N	Y
369	\N	464-1.jpeg	464	653	2016-08-15 13:21:14	2016-08-15 13:15:35	N	Y
370	\N	464-2.jpeg	464	653	2016-08-15 13:21:14	2016-08-15 13:15:35	N	Y
371	\N	465-1.jpeg	465	677	2016-08-15 19:46:28	2016-08-15 19:41:50	N	Y
372	\N	465-2.jpeg	465	677	2016-08-15 19:46:28	2016-08-15 19:41:50	N	Y
373	\N	465-3.jpeg	465	677	2016-08-15 19:46:28	2016-08-15 19:41:50	N	Y
374	\N	465-4.jpeg	465	677	2016-08-15 19:46:28	2016-08-15 19:41:50	N	Y
375	\N	466-1.jpeg	466	569	2016-08-16 16:27:45	2016-08-16 16:22:34	N	Y
376	\N	467-1.jpeg	467	720	2016-08-16 20:19:26	2016-08-16 20:13:50	N	Y
377	\N	468-1.jpeg	468	720	2016-08-16 20:21:17	2016-08-16 20:15:31	N	Y
378	\N	469-1.jpeg	469	720	2016-08-16 20:22:55	2016-08-16 20:17:09	N	Y
316	\N	438-2.jpeg	438	194	2016-08-12 00:26:10	2016-08-16 22:11:18	N	Y
405	\N	484-1.jpeg	484	811	2016-08-22 22:26:50	2016-08-22 22:20:53	N	Y
379	\N	470-1.jpeg	470	729	2016-08-16 21:06:20	2016-08-17 17:14:50	N	Y
380	\N	470-2.jpeg	470	729	2016-08-17 17:14:50	2016-08-17 13:20:26	N	Y
381	\N	471-1.jpeg	471	755	2016-08-17 21:38:27	2016-08-17 21:32:40	N	Y
382	\N	471-2.jpeg	471	755	2016-08-17 21:38:27	2016-08-17 21:32:40	N	Y
383	\N	472-1.jpeg	472	755	2016-08-17 21:39:57	2016-08-17 21:34:11	N	Y
384	\N	472-2.jpeg	472	755	2016-08-17 21:39:57	2016-08-17 21:34:11	N	Y
385	\N	473-1.jpeg	473	755	2016-08-17 21:41:21	2016-08-17 21:35:33	N	Y
386	\N	473-2.jpeg	473	755	2016-08-17 21:41:21	2016-08-17 21:35:33	N	Y
387	\N	474-1.jpeg	474	755	2016-08-17 21:44:05	2016-08-17 21:38:18	N	Y
388	\N	474-2.jpeg	474	755	2016-08-17 21:44:05	2016-08-17 21:38:18	N	Y
389	\N	475-1.jpeg	475	772	2016-08-19 15:10:32	2016-08-19 15:11:02	N	Y
391	\N	477-1.jpeg	477	421	2016-08-19 16:54:51	2016-08-19 16:49:10	N	Y
392	\N	478-1.jpeg	478	732	2016-08-20 01:19:32	2016-08-20 01:13:40	N	Y
393	\N	478-2.jpeg	478	732	2016-08-20 01:19:32	2016-08-20 01:13:40	N	Y
395	\N	480-1.jpeg	480	514	2016-08-20 16:23:17	2016-08-24 14:17:27	N	Y
396	\N	480-2.jpeg	480	514	2016-08-20 16:23:17	2016-08-24 14:17:27	N	Y
406	\N	485-1.jpeg	485	194	2016-08-23 03:13:32	2016-08-23 03:08:37	N	Y
390	\N	476-1.jpeg	476	772	2016-08-19 15:18:49	2016-08-20 17:30:04	N	Y
397	\N	476-2.jpeg	476	772	2016-08-20 17:30:04	2016-08-20 13:35:18	N	Y
398	\N	476-3.jpeg	476	772	2016-08-20 17:30:04	2016-08-20 13:35:18	N	Y
399	\N	481-1.jpeg	481	772	2016-08-20 17:37:03	2016-08-20 17:31:09	N	Y
407	\N	485-2.jpeg	485	194	2016-08-23 03:08:37	2016-08-22 23:14:22	N	Y
408	\N	486-1.jpeg	486	609	2016-08-24 02:07:14	2016-08-24 02:02:51	N	Y
409	\N	480-3.jpeg	480	514	2016-08-24 14:17:27	2016-08-24 14:23:30	N	Y
410	\N	487-1.jpeg	487	460	2016-08-24 22:56:19	2016-08-24 22:50:23	N	Y
415	\N	490-1.jpeg	490	643	2016-08-26 22:06:54	2016-08-26 22:00:49	N	Y
416	\N	491-1.jpeg	491	739	2016-08-27 17:29:33	2016-08-27 17:23:26	N	Y
402	\N	482-3.jpeg	482	801	2016-08-21 21:24:25	2016-08-28 19:33:04	N	Y
421	\N	495-1.jpeg	495	842	2016-08-28 17:12:20	2016-09-11 23:09:27	N	Y
401	\N	482-2.jpeg	482	801	2016-08-20 23:52:40	2016-08-28 19:33:04	N	Y
394	\N	479-1.jpeg	479	772	2016-08-20 15:30:00	2016-08-22 12:34:40	N	Y
403	\N	483-1.jpeg	483	772	2016-08-22 12:44:20	2016-08-22 12:38:22	N	Y
404	\N	483-2.jpeg	483	772	2016-08-22 12:44:20	2016-08-22 12:38:22	N	Y
411	\N	488-1.jpeg	488	460	2016-08-24 22:57:52	2016-08-24 22:51:49	N	Y
412	\N	489-1.jpeg	489	772	2016-08-26 01:39:10	2016-08-26 01:33:09	N	Y
413	\N	489-2.jpeg	489	772	2016-08-26 01:39:10	2016-08-26 01:33:09	N	Y
414	\N	489-3.jpeg	489	772	2016-08-26 01:39:10	2016-08-26 01:33:09	N	Y
417	\N	492-1.jpeg	492	739	2016-08-27 17:30:51	2016-08-27 17:24:44	N	Y
418	\N	493-1.jpeg	493	739	2016-08-27 18:14:51	2016-08-27 18:08:43	N	Y
419	\N	494-1.jpeg	494	421	2016-08-27 22:45:42	2016-08-27 22:39:46	N	Y
420	\N	494-2.jpeg	494	421	2016-08-27 22:45:42	2016-08-27 22:39:46	N	Y
422	\N	495-2.jpeg	495	842	2016-08-28 17:12:20	2016-09-11 23:09:27	N	Y
423	\N	495-3.jpeg	495	842	2016-08-28 17:12:20	2016-09-11 23:09:27	N	Y
447	\N	503-1.jpeg	503	778	2016-08-30 21:05:55	2016-09-07 11:21:04	N	Y
448	\N	503-2.jpeg	503	778	2016-08-30 21:05:55	2016-09-07 11:21:04	N	Y
449	\N	503-3.jpeg	503	778	2016-08-30 21:05:55	2016-09-07 11:21:04	N	Y
450	\N	503-4.jpeg	503	778	2016-08-30 21:05:55	2016-09-07 11:21:04	N	Y
400	\N	482-1.jpeg	482	801	2016-08-20 23:54:41	2016-08-28 19:33:04	N	Y
441	\N	501-1.jpeg	501	844	2016-08-28 18:18:17	2016-08-28 21:15:12	N	Y
442	\N	501-2.jpeg	501	844	2016-08-28 18:18:17	2016-08-28 21:15:12	N	Y
443	\N	501-3.jpeg	501	844	2016-08-28 18:18:17	2016-08-28 21:15:12	N	Y
444	\N	501-4.jpeg	501	844	2016-08-28 18:18:17	2016-08-28 21:15:12	N	Y
445	\N	502-1.jpeg	502	9	2016-08-29 21:32:34	2016-08-29 21:27:49	N	Y
446	\N	502-2.jpeg	502	9	2016-08-29 21:32:34	2016-08-29 21:27:49	N	Y
451	\N	503-5.jpeg	503	778	2016-08-30 21:05:55	2016-08-30 20:59:49	N	Y
531	\N	547-1.jpeg	547	194	2016-09-07 14:58:00	2016-09-07 14:59:28	N	Y
532	\N	548-1.jpeg	548	194	2016-09-07 15:07:29	2016-09-07 15:01:22	N	Y
533	\N	548-2.jpeg	548	194	2016-09-07 15:07:29	2016-09-07 15:01:22	N	Y
534	\N	548-3.jpeg	548	194	2016-09-07 15:07:29	2016-09-07 15:01:22	N	Y
535	\N	548-4.jpeg	548	194	2016-09-07 15:07:29	2016-09-07 15:01:22	N	Y
536	\N	549-1.jpeg	549	194	2016-09-07 15:13:59	2016-09-07 15:07:30	N	Y
537	\N	550-1.jpeg	550	421	2016-09-07 17:11:02	2016-09-07 17:04:38	N	Y
538	\N	522-1.jpeg	522	421	2016-09-07 17:05:15	2016-09-07 13:11:34	N	Y
539	\N	551-1.jpeg	551	194	2016-09-09 02:27:58	2016-09-09 02:21:25	N	Y
540	\N	551-2.jpeg	551	194	2016-09-09 02:27:58	2016-09-09 02:21:25	N	Y
541	\N	552-1.jpeg	552	194	2016-09-09 02:29:41	2016-09-09 02:23:10	N	Y
542	\N	552-2.jpeg	552	194	2016-09-09 02:29:41	2016-09-09 02:23:10	N	Y
543	\N	553-1.jpeg	553	194	2016-09-09 02:30:42	2016-09-09 02:24:09	N	Y
544	\N	553-2.jpeg	553	194	2016-09-09 02:30:42	2016-09-09 02:24:09	N	Y
545	\N	554-1.jpeg	554	194	2016-09-09 02:32:47	2016-09-09 02:26:15	N	Y
546	\N	554-2.jpeg	554	194	2016-09-09 02:32:47	2016-09-09 02:26:15	N	Y
547	\N	554-3.jpeg	554	194	2016-09-09 02:32:47	2016-09-09 02:26:15	N	Y
548	\N	554-4.jpeg	554	194	2016-09-09 02:32:47	2016-09-09 02:26:15	N	Y
549	\N	555-1.jpeg	555	194	2016-09-09 02:33:56	2016-09-09 02:27:23	N	Y
550	\N	555-2.jpeg	555	194	2016-09-09 02:33:56	2016-09-09 02:27:23	N	Y
551	\N	556-1.jpeg	556	194	2016-09-09 02:35:37	2016-09-09 02:29:04	N	Y
552	\N	556-2.jpeg	556	194	2016-09-09 02:35:37	2016-09-09 02:29:04	N	Y
553	\N	556-3.jpeg	556	194	2016-09-09 02:35:37	2016-09-09 02:29:04	N	Y
554	\N	557-1.jpeg	557	194	2016-09-09 02:37:10	2016-09-09 02:30:37	N	Y
555	\N	557-2.jpeg	557	194	2016-09-09 02:37:10	2016-09-09 02:30:37	N	Y
556	\N	557-3.jpeg	557	194	2016-09-09 02:37:10	2016-09-09 02:30:37	N	Y
557	\N	558-1.jpeg	558	925	2016-09-09 21:10:09	2016-09-09 21:03:39	N	Y
437	\N	500-1.jpeg	500	842	2016-08-28 17:43:23	2016-09-11 23:07:27	N	Y
438	\N	500-2.jpeg	500	842	2016-08-28 17:43:23	2016-09-11 23:07:27	N	Y
439	\N	500-3.jpeg	500	842	2016-08-28 17:43:23	2016-09-11 23:07:27	N	Y
440	\N	500-4.jpeg	500	842	2016-08-28 17:43:23	2016-09-11 23:07:27	N	Y
433	\N	499-1.jpeg	499	842	2016-08-28 17:31:30	2016-09-11 23:07:57	N	Y
434	\N	499-2.jpeg	499	842	2016-08-28 17:31:30	2016-09-11 23:07:57	N	Y
435	\N	499-3.jpeg	499	842	2016-08-28 17:31:30	2016-09-11 23:07:57	N	Y
436	\N	499-4.jpeg	499	842	2016-08-28 17:31:30	2016-09-11 23:07:57	N	Y
431	\N	498-1.jpeg	498	842	2016-08-28 17:24:31	2016-09-11 23:08:27	N	Y
432	\N	498-2.jpeg	498	842	2016-08-28 17:24:31	2016-09-11 23:08:27	N	Y
429	\N	497-1.jpeg	497	842	2016-08-28 17:21:02	2016-09-11 23:08:45	N	Y
430	\N	497-2.jpeg	497	842	2016-08-28 17:21:02	2016-09-11 23:08:45	N	Y
425	\N	496-1.jpeg	496	842	2016-08-28 17:17:43	2016-09-11 23:09:05	N	Y
426	\N	496-2.jpeg	496	842	2016-08-28 17:17:43	2016-09-11 23:09:05	N	Y
427	\N	496-3.jpeg	496	842	2016-08-28 17:17:43	2016-09-11 23:09:05	N	Y
428	\N	496-4.jpeg	496	842	2016-08-28 17:17:43	2016-09-11 23:09:05	N	Y
424	\N	495-4.jpeg	495	842	2016-08-28 17:12:20	2016-09-11 23:09:27	N	Y
558	\N	559-1.jpeg	559	796	2016-09-12 15:10:40	2016-09-12 15:04:00	N	Y
559	\N	559-2.jpeg	559	796	2016-09-12 15:10:40	2016-09-12 15:04:00	N	Y
560	\N	559-3.jpeg	559	796	2016-09-12 15:10:40	2016-09-12 15:04:00	N	Y
561	\N	560-1.jpeg	560	946	2016-09-13 00:47:04	2016-09-13 00:40:23	N	Y
562	\N	561-1.jpeg	561	862	2016-09-13 17:59:52	2016-09-13 17:58:12	N	Y
563	\N	561-2.jpeg	561	862	2016-09-13 17:59:52	2016-09-13 17:58:12	N	Y
564	\N	561-3.jpeg	561	862	2016-09-13 17:59:52	2016-09-13 17:58:12	N	Y
565	\N	561-4.jpeg	561	862	2016-09-13 17:59:52	2016-09-13 17:58:12	N	Y
579	\N	568-1.jpeg	568	194	2016-09-18 17:41:34	2016-09-18 17:34:47	N	Y
566	\N	562-1.jpeg	562	862	2016-09-13 21:15:25	2016-09-13 21:14:01	N	Y
567	\N	562-2.jpeg	562	862	2016-09-13 21:10:45	2016-09-13 21:14:01	N	Y
568	\N	563-1.jpeg	563	964	2016-09-14 04:01:48	2016-09-14 03:55:16	N	Y
569	\N	564-1.jpeg	564	9	2016-09-15 00:25:33	2016-09-15 00:19:02	N	Y
570	\N	565-1.jpeg	565	9	2016-09-15 00:28:16	2016-09-15 00:21:42	N	Y
571	\N	521-1.jpeg	521	869	2016-09-15 12:01:59	2016-09-15 12:03:22	N	Y
572	\N	520-1.jpeg	520	869	2016-09-15 12:02:29	2016-09-15 12:03:47	N	Y
573	\N	566-1.jpeg	566	988	2016-09-16 21:29:09	2016-09-16 21:22:41	N	Y
574	\N	566-2.jpeg	566	988	2016-09-16 21:29:09	2016-09-16 21:22:41	N	Y
575	\N	566-3.jpeg	566	988	2016-09-16 21:29:09	2016-09-16 21:22:41	N	Y
576	\N	567-1.jpeg	567	778	2016-09-17 18:57:29	2016-09-17 18:50:41	N	Y
577	\N	567-2.jpeg	567	778	2016-09-17 18:57:29	2016-09-17 18:50:41	N	Y
578	\N	567-3.jpeg	567	778	2016-09-17 18:57:29	2016-09-17 18:50:41	N	Y
580	\N	568-2.jpeg	568	194	2016-09-18 17:41:34	2016-09-18 17:34:47	N	Y
581	\N	569-1.jpeg	569	194	2016-09-18 17:46:46	2016-09-18 17:40:00	N	Y
582	\N	569-2.jpeg	569	194	2016-09-18 17:46:46	2016-09-18 17:40:00	N	Y
583	\N	569-3.jpeg	569	194	2016-09-18 17:46:46	2016-09-18 17:40:00	N	Y
584	\N	570-1.jpeg	570	194	2016-09-18 17:52:15	2016-09-18 17:45:28	N	Y
585	\N	571-1.jpeg	571	990	2016-09-18 18:44:49	2016-09-18 18:37:59	N	Y
586	\N	571-2.jpeg	571	990	2016-09-18 18:44:49	2016-09-18 18:37:59	N	Y
587	\N	572-1.jpeg	572	1000	2016-09-19 15:54:09	2016-09-19 15:52:38	N	Y
588	\N	572-2.jpeg	572	1000	2016-09-19 15:54:09	2016-09-19 15:52:38	N	Y
589	\N	573-1.jpeg	573	978	2016-09-19 17:07:43	2016-09-19 17:00:56	N	Y
590	\N	573-2.jpeg	573	978	2016-09-19 17:07:43	2016-09-19 17:00:56	N	Y
591	\N	573-3.jpeg	573	978	2016-09-19 17:07:43	2016-09-19 17:00:56	N	Y
592	\N	573-4.jpeg	573	978	2016-09-19 17:07:43	2016-09-19 17:00:56	N	Y
593	\N	574-1.jpeg	574	978	2016-09-19 17:09:39	2016-09-19 17:02:46	N	Y
594	\N	574-2.jpeg	574	978	2016-09-19 17:09:39	2016-09-19 17:02:46	N	Y
595	\N	575-1.jpeg	575	978	2016-09-19 17:13:39	2016-09-19 17:06:48	N	Y
596	\N	575-2.jpeg	575	978	2016-09-19 17:13:39	2016-09-19 17:06:48	N	Y
597	\N	575-3.jpeg	575	978	2016-09-19 17:13:39	2016-09-19 17:06:48	N	Y
598	\N	575-4.jpeg	575	978	2016-09-19 17:13:39	2016-09-19 17:06:48	N	Y
599	\N	576-1.jpeg	576	347	2016-09-20 23:07:22	2016-09-20 22:59:23	N	Y
600	\N	577-1.jpeg	577	925	2016-09-20 23:09:35	2016-09-20 23:02:42	N	Y
601	\N	581-1.jpeg	581	194	2016-09-21 23:54:56	2016-09-21 23:47:56	N	Y
602	\N	582-1.jpeg	582	998	2016-09-22 15:14:15	2016-09-22 15:07:23	N	Y
603	\N	582-2.jpeg	582	998	2016-09-22 15:14:15	2016-09-22 15:07:23	N	Y
604	\N	582-3.jpeg	582	998	2016-09-22 15:14:15	2016-09-22 15:07:23	N	Y
605	\N	582-4.jpeg	582	998	2016-09-22 15:14:15	2016-09-22 15:07:23	N	Y
606	\N	583-1.jpeg	583	979	2016-09-22 19:43:39	2016-09-22 19:36:38	N	Y
607	\N	584-1.jpeg	584	979	2016-09-22 19:45:59	2016-09-22 19:38:58	N	Y
608	\N	585-1.jpeg	585	979	2016-09-22 19:47:59	2016-09-22 19:40:59	N	Y
609	\N	586-1.jpeg	586	979	2016-09-22 19:50:42	2016-09-22 19:43:41	N	Y
610	\N	587-1.jpeg	587	979	2016-09-22 19:53:08	2016-09-22 19:46:07	N	Y
611	\N	587-2.jpeg	587	979	2016-09-22 19:53:08	2016-09-22 19:46:07	N	Y
612	\N	588-1.jpeg	588	979	2016-09-22 19:54:36	2016-09-22 19:47:35	N	Y
674	\N	622-1.jpeg	622	194	2016-11-10 16:30:57	2016-11-10 16:22:25	N	Y
675	\N	622-2.jpeg	622	194	2016-11-10 16:30:57	2016-11-10 16:22:25	N	Y
613	\N	589-1.jpeg	589	958	2016-09-23 14:50:13	2016-09-23 14:55:22	N	Y
614	\N	589-2.jpeg	589	958	2016-09-23 14:50:13	2016-09-23 14:55:22	N	Y
615	\N	590-1.jpeg	590	935	2016-09-23 15:11:40	2016-09-23 15:04:38	N	Y
616	\N	591-1.jpeg	591	935	2016-09-23 15:17:11	2016-09-23 15:10:12	N	Y
617	\N	592-1.jpeg	592	1044	2016-09-23 15:38:22	2016-09-23 15:31:20	N	Y
618	\N	593-1.jpeg	593	1021	2016-09-24 12:52:44	2016-09-24 12:45:52	N	Y
619	\N	594-1.jpeg	594	1049	2016-09-25 18:21:24	2016-09-25 18:16:41	N	Y
620	\N	595-1.jpeg	595	1049	2016-09-25 18:24:49	2016-09-25 18:17:46	N	Y
621	\N	596-1.jpeg	596	432	2016-09-27 15:20:44	2016-09-27 15:13:39	N	Y
622	\N	597-1.jpeg	597	194	2016-09-28 12:48:08	2016-09-28 14:09:03	N	Y
628	\N	600-1.jpeg	600	992	2016-09-30 03:56:30	2016-09-30 03:49:26	N	Y
629	\N	600-2.jpeg	600	992	2016-09-30 03:56:30	2016-09-30 03:49:26	N	Y
630	\N	600-3.jpeg	600	992	2016-09-30 03:56:30	2016-09-30 03:49:26	N	Y
631	\N	600-4.jpeg	600	992	2016-09-30 03:56:30	2016-09-30 03:49:26	N	Y
627	\N	599-1.jpeg	599	329	2016-09-29 20:11:27	2016-09-30 08:46:22	N	Y
632	\N	601-1.jpeg	601	1065	2016-09-30 15:23:57	2016-09-30 15:16:42	N	Y
625	\N	598-3.jpeg	598	1062	2016-09-28 19:48:51	2016-10-14 20:38:50	N	Y
626	\N	598-4.jpeg	598	1062	2016-09-28 19:48:51	2016-10-14 20:38:50	N	Y
623	\N	598-1.jpeg	598	1062	2016-09-28 19:48:51	2016-10-14 20:38:50	N	Y
624	\N	598-2.jpeg	598	1062	2016-09-28 19:48:51	2016-10-14 20:38:50	N	Y
661	\N	615-1.jpeg	615	421	2016-10-21 14:11:45	2016-10-21 14:03:50	N	Y
662	\N	615-2.jpeg	615	421	2016-10-21 14:11:45	2016-10-21 14:03:50	N	Y
663	\N	616-1.jpeg	616	1111	2016-10-24 17:08:11	2016-10-24 17:00:11	N	Y
664	\N	617-1.jpeg	617	1115	2016-10-25 17:54:56	2016-10-25 17:46:59	N	Y
665	\N	618-1.jpeg	618	621	2016-10-26 14:45:17	2016-10-26 14:37:16	N	Y
666	\N	618-2.jpeg	618	621	2016-10-26 14:45:17	2016-10-26 14:37:16	N	Y
633	\N	602-1.jpeg	602	460	2016-10-03 13:05:03	2016-10-03 12:57:43	N	Y
667	\N	618-3.jpeg	618	621	2016-10-26 14:45:17	2016-10-26 14:37:16	N	Y
668	\N	618-4.jpeg	618	621	2016-10-26 14:45:17	2016-10-26 14:37:16	N	Y
676	\N	623-1.jpeg	623	9	2016-11-12 04:04:41	2016-11-12 03:57:00	N	Y
672	\N	621-1.jpeg	621	9	2016-11-08 17:12:17	2016-11-12 04:00:10	N	Y
634	\N	603-1.jpeg	603	194	2016-10-05 23:28:40	2016-10-05 23:21:14	N	Y
635	\N	604-1.jpeg	604	194	2016-10-05 23:31:08	2016-10-05 23:23:43	N	Y
636	\N	604-2.jpeg	604	194	2016-10-05 23:31:08	2016-10-05 23:23:43	N	Y
637	\N	604-3.jpeg	604	194	2016-10-05 23:31:08	2016-10-05 23:23:43	N	Y
638	\N	605-1.jpeg	605	194	2016-10-05 23:33:37	2016-10-05 23:26:14	N	Y
639	\N	605-2.jpeg	605	194	2016-10-05 23:33:37	2016-10-05 23:26:14	N	Y
640	\N	606-1.jpeg	606	194	2016-10-05 23:35:14	2016-10-05 23:27:48	N	Y
641	\N	606-2.jpeg	606	194	2016-10-05 23:35:14	2016-10-05 23:27:48	N	Y
642	\N	607-1.jpeg	607	414	2016-10-08 13:13:44	2016-10-08 13:06:14	N	Y
643	\N	607-2.jpeg	607	414	2016-10-08 13:13:44	2016-10-08 13:06:14	N	Y
644	\N	607-3.jpeg	607	414	2016-10-08 13:13:44	2016-10-08 13:06:14	N	Y
645	\N	608-1.jpeg	608	414	2016-10-08 13:16:12	2016-10-08 13:08:42	N	Y
646	\N	608-2.jpeg	608	414	2016-10-08 13:16:12	2016-10-08 13:08:42	N	Y
647	\N	608-3.jpeg	608	414	2016-10-08 13:16:12	2016-10-08 13:08:42	N	Y
648	\N	609-1.jpeg	609	1104	2016-10-12 00:12:06	2016-10-12 00:04:29	N	Y
649	\N	609-2.jpeg	609	1104	2016-10-12 00:12:06	2016-10-12 00:04:29	N	Y
650	\N	609-3.jpeg	609	1104	2016-10-12 00:12:06	2016-10-12 00:04:29	N	Y
651	\N	609-4.jpeg	609	1104	2016-10-12 00:12:06	2016-10-12 00:04:29	N	Y
652	\N	610-1.jpeg	610	194	2016-10-12 13:25:41	2016-10-12 13:18:06	N	Y
653	\N	610-2.jpeg	610	194	2016-10-12 13:25:41	2016-10-12 13:18:07	N	Y
654	\N	611-1.jpeg	611	414	2016-10-12 13:27:09	2016-10-12 13:19:30	N	Y
655	\N	611-2.jpeg	611	414	2016-10-12 13:27:09	2016-10-12 13:19:30	N	Y
656	\N	612-1.jpeg	612	1105	2016-10-12 14:24:58	2016-10-12 14:17:22	N	Y
657	\N	612-2.jpeg	612	1105	2016-10-12 14:24:58	2016-10-12 14:17:22	N	Y
658	\N	612-3.jpeg	612	1105	2016-10-12 14:24:58	2016-10-12 14:17:22	N	Y
673	\N	621-2.jpeg	621	9	2016-11-08 17:12:17	2016-11-12 04:00:10	N	Y
677	\N	624-1.jpeg	624	194	2016-11-12 04:09:19	2016-11-12 04:00:44	N	Y
669	\N	619-1.jpeg	619	1096	2016-10-30 02:27:53	2016-10-30 02:20:10	N	Y
670	\N	620-1.jpeg	620	1096	2016-10-30 02:30:04	2016-10-30 02:23:13	N	Y
671	\N	620-2.jpeg	620	1096	2016-10-30 02:30:04	2016-10-30 02:23:13	N	Y
660	\N	614-1.jpeg	614	869	2016-10-16 21:20:11	2016-11-01 17:42:53	N	Y
659	\N	613-1.jpeg	613	869	2016-10-16 21:18:54	2016-11-01 17:43:31	N	Y
678	\N	624-2.jpeg	624	194	2016-11-12 04:09:19	2016-11-12 04:00:44	N	Y
679	\N	625-1.jpeg	625	861	2016-11-14 21:22:37	2016-11-14 21:13:54	N	Y
680	\N	626-1.jpeg	626	194	2016-11-16 03:34:18	2016-11-16 03:25:37	N	Y
681	\N	626-2.jpeg	626	194	2016-11-16 03:34:18	2016-11-16 03:25:37	N	Y
682	\N	627-1.jpeg	627	9	2016-11-17 11:39:27	2016-11-17 11:30:54	N	Y
683	\N	627-2.jpeg	627	9	2016-11-17 11:39:27	2016-11-17 11:30:54	N	Y
684	\N	627-3.jpeg	627	9	2016-11-17 11:39:27	2016-11-17 11:30:54	N	Y
685	\N	628-1.jpeg	628	9	2016-11-17 11:47:06	2016-11-17 11:38:31	N	Y
686	\N	628-2.jpeg	628	9	2016-11-17 11:47:06	2016-11-17 11:38:31	N	Y
687	\N	628-3.jpeg	628	9	2016-11-17 11:47:06	2016-11-17 11:38:31	N	Y
688	\N	629-1.jpeg	629	9	2016-11-17 11:57:02	2016-11-17 11:48:18	N	Y
689	\N	629-2.jpeg	629	9	2016-11-17 11:57:02	2016-11-17 11:48:18	N	Y
690	\N	630-1.jpeg	630	9	2016-11-17 11:58:13	2016-11-17 11:49:29	N	Y
691	\N	631-1.jpeg	631	9	2016-11-17 12:00:46	2016-11-17 11:52:03	N	Y
692	\N	632-1.jpeg	632	9	2016-11-17 12:15:19	2016-11-17 12:06:35	N	Y
693	\N	633-1.jpeg	633	9	2016-11-17 12:18:04	2016-11-17 12:09:27	N	Y
694	\N	633-2.jpeg	633	9	2016-11-17 12:18:04	2016-11-17 12:09:27	N	Y
695	\N	633-3.jpeg	633	9	2016-11-17 12:18:04	2016-11-17 12:09:27	N	Y
696	\N	633-4.jpeg	633	9	2016-11-17 12:18:04	2016-11-17 12:09:27	N	Y
697	\N	634-1.jpeg	634	194	2016-11-17 15:36:45	2016-11-17 15:28:01	N	Y
698	\N	635-1.jpeg	635	194	2016-11-21 01:22:30	2016-11-21 01:13:43	N	Y
699	\N	636-1.jpeg	636	194	2016-11-21 01:23:24	2016-11-21 01:14:34	N	Y
700	\N	636-2.jpeg	636	194	2016-11-21 01:23:24	2016-11-21 01:14:34	N	Y
701	\N	637-1.jpeg	637	194	2016-11-21 01:27:40	2016-11-21 01:18:50	N	Y
702	\N	638-1.jpeg	638	194	2016-11-21 01:31:01	2016-11-21 01:22:13	N	Y
703	\N	638-2.jpeg	638	194	2016-11-21 01:31:01	2016-11-21 01:22:13	N	Y
704	\N	638-3.jpeg	638	194	2016-11-21 01:31:01	2016-11-21 01:22:13	N	Y
705	\N	639-1.jpeg	639	194	2016-11-21 01:33:07	2016-11-21 01:24:31	N	Y
706	\N	639-2.jpeg	639	194	2016-11-21 01:33:07	2016-11-21 01:24:31	N	Y
707	\N	639-3.jpeg	639	194	2016-11-21 01:33:07	2016-11-21 01:24:32	N	Y
708	\N	640-1.jpeg	640	194	2016-11-21 01:38:06	2016-11-21 01:29:18	N	Y
709	\N	640-2.jpeg	640	194	2016-11-21 01:38:06	2016-11-21 01:29:18	N	Y
710	\N	640-3.jpeg	640	194	2016-11-21 01:38:06	2016-11-21 01:29:18	N	Y
711	\N	641-1.jpeg	641	194	2016-11-21 19:30:48	2016-11-21 19:21:54	N	Y
712	\N	641-2.jpeg	641	194	2016-11-21 19:30:48	2016-11-21 19:21:54	N	Y
713	\N	642-1.jpeg	642	194	2016-11-21 19:32:30	2016-11-21 19:23:36	N	Y
714	\N	642-2.jpeg	642	194	2016-11-21 19:32:30	2016-11-21 19:23:36	N	Y
715	\N	643-1.jpeg	643	194	2016-11-21 19:46:24	2016-11-21 19:37:30	N	Y
716	\N	644-1.jpeg	644	9	2016-11-23 03:55:09	2016-11-23 03:46:21	N	Y
717	\N	644-2.jpeg	644	9	2016-11-23 03:55:09	2016-11-23 03:46:21	N	Y
718	\N	644-3.jpeg	644	9	2016-11-23 03:55:09	2016-11-23 03:46:21	N	Y
719	\N	644-4.jpeg	644	9	2016-11-23 03:55:09	2016-11-23 03:46:21	N	Y
720	\N	645-1.jpeg	645	9	2016-11-23 03:58:48	2016-11-23 03:50:00	N	Y
721	\N	645-2.jpeg	645	9	2016-11-23 03:58:48	2016-11-23 03:50:00	N	Y
722	\N	645-3.jpeg	645	9	2016-11-23 03:58:48	2016-11-23 03:50:00	N	Y
723	\N	646-1.jpeg	646	9	2016-11-23 04:02:07	2016-11-23 03:53:28	N	Y
724	\N	646-2.jpeg	646	9	2016-11-23 04:02:07	2016-11-23 03:53:28	N	Y
725	\N	646-3.jpeg	646	9	2016-11-23 04:02:07	2016-11-23 03:53:28	N	Y
726	\N	647-1.jpeg	647	9	2016-11-23 04:12:18	2016-11-23 04:03:30	N	Y
727	\N	647-2.jpeg	647	9	2016-11-23 04:12:18	2016-11-23 04:03:30	N	Y
728	\N	647-3.jpeg	647	9	2016-11-23 04:12:18	2016-11-23 04:03:30	N	Y
729	\N	647-4.jpeg	647	9	2016-11-23 04:12:18	2016-11-23 04:03:30	N	Y
730	\N	648-1.jpeg	648	194	2016-11-23 04:38:07	2016-11-23 04:30:04	N	Y
731	\N	648-2.jpeg	648	194	2016-11-23 04:38:07	2016-11-23 04:30:04	N	Y
732	\N	648-3.jpeg	648	194	2016-11-23 04:38:07	2016-11-23 04:30:04	N	Y
733	\N	649-1.jpeg	649	194	2016-11-23 05:06:49	2016-11-23 04:57:56	N	Y
734	\N	649-2.jpeg	649	194	2016-11-23 05:06:49	2016-11-23 04:57:57	N	Y
735	\N	649-3.jpeg	649	194	2016-11-23 05:06:49	2016-11-23 04:57:57	N	Y
736	\N	650-1.jpeg	650	194	2016-11-23 05:08:32	2016-11-23 04:59:57	N	Y
737	\N	650-2.jpeg	650	194	2016-11-23 05:08:32	2016-11-23 04:59:57	N	Y
738	\N	651-1.jpeg	651	9	2016-11-23 13:07:31	2016-11-23 12:58:47	N	Y
739	\N	651-2.jpeg	651	9	2016-11-23 13:07:31	2016-11-23 12:58:47	N	Y
740	\N	651-3.jpeg	651	9	2016-11-23 13:07:31	2016-11-23 12:58:47	N	Y
741	\N	652-1.jpeg	652	194	2016-11-27 23:10:00	2016-11-27 23:00:55	N	Y
\.


--
-- Name: post_gallery_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('post_gallery_int_glcode_seq', 741, true);


--
-- Data for Name: post_management; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY post_management (int_glcode, var_postname, fk_post_cate, var_description, var_price, dt_expiredate, dt_createdate, dt_modifydate, chr_delete, chr_publish, var_adminuser, var_ipaddress, fk_user_id, fk_university, chr_status, chr_favorite, int_count, chr_block) FROM stdin;
266	6 month lease Fall 16 	16	I am looking for a 3-4 person apartment/house. I will only be in Athens for the fall semester so it needs to be a 6 month lease. 	1	2016-01-22	2015-12-23 00:00:00	2015-12-24 01:36:12	Y	Y	\N	\N	66	15	0	0	0	0
268	6 month lease Fall 16 	16	I am looking for a 3-4 person apartment/house. I will only be in Athens for the fall semester so it needs to be a 6 month lease. 	1	2016-01-22	2015-12-23 00:00:00	2015-12-24 01:36:21	Y	Y	\N	\N	66	15	0	0	0	0
231	Sock 	4	Are you tired of looking for the other pair to your single socks? This slightly used sock could be an answer to all your problems! 	1.00	2016-01-03	2015-12-04 00:00:00	2015-12-04 19:28:36	Y	Y	\N	\N	87	14	3	0	0	0
233	Sock 	4	Are you tired of looking for the other pair to your single socks? This slightly used sock could be an answer to all your problems! 	1.00	2016-01-03	2015-12-04 00:00:00	2015-12-04 19:28:42	Y	Y	\N	\N	87	14	3	0	0	0
235	Sock 	4	Are you tired of looking for the other pair to your single socks? This slightly used sock could be an answer to all your problems! 	5.00	2016-01-03	2015-12-04 00:00:00	2015-12-04 19:28:55	Y	Y	\N	\N	87	14	3	0	0	0
185	Sublease Jan-July 	3	$495+ utilities (price negotiable) 525 S. Poplar Street right behind the flatts. Walking distance to downtown and campus, private balcony, and ready to be taken over at anytime. Contact 770-876-7209 for more info/tour	495.00	2015-12-14	2015-11-14 00:00:00	2015-11-14 22:58:29	N	Y	\N	\N	33	15	1	0	0	0
184	Green blouse	4	Never worn!	10	2015-12-15	2015-11-13 00:00:00	2015-12-01 13:43:46	Y	Y	\N	\N	30	15	3	0	0	0
254	Looking for a desk!	16	Need a white or off white desk!\n	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:21:02	Y	Y	\N	\N	30	15	0	0	0	0
252	Looking for a desk!	16	I need a white or off white desk!  	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:20:41	Y	Y	\N	\N	30	15	0	0	0	0
255	Response clicker	17	works fine, batteries included. Would like to sell it before I leave for break	30.00	2015-12-18	2015-12-16 05:27:42	2015-12-16 05:32:39	N	Y	\N	\N	175	15	1	0	0	0
270	Book	16	Book	2	2015-12-23	2015-12-23 00:00:00	2015-12-24 01:40:48	Y	Y	\N	\N	66	15	0	0	0	0
273	Dog	16	Dog	90.00	2015-12-30	2015-12-24 00:00:00	2015-12-24 05:47:15	Y	Y	\N	\N	12	14	0	0	0	0
259	Test	12	Test	40.00	2016-01-17	2015-12-21 00:00:00	2015-12-21 22:53:08	Y	Y	\N	\N	12	14	0	0	0	0
242	Need a roommate	16	Room in remerton. $270. Not including utilities. Pet friendly. 	270	2016-01-13	2015-12-15 00:00:00	2015-12-15 03:53:42	Y	Y	\N	\N	92	14	3	0	0	0
237	2 12" subs for sale with amp	5	2 kenwood 12s and a 1000 watt kenwood amp with a ported custom box. Paid $350+ for everything 	200	2015-12-31	2015-12-08 00:00:00	2015-12-08 05:55:54	N	Y	\N	\N	117	14	1	0	0	0
274	My testing post	1	Heyyy	10.23	2015-12-31	2015-12-31 05:38:08	2015-12-31 05:38:15	N	Y	\N	\N	6	16	1	0	0	0
236	Math 3008 text 	1	Numeracy applications textbook 	25	2016-01-04	2015-12-05 00:00:00	2015-12-05 19:58:17	N	Y	\N	\N	71	38	1	0	0	0
238	Guidelines for Cardiac Rehab	1	Practically new AACVPR Guidelines for Cardiac Rehab and Secondary Prevention book. (Barely used for one semester)	20.00	2016-01-09	2015-12-11 00:00:00	2015-12-11 21:57:42	N	Y	\N	\N	61	14	1	0	0	0
277	Xbox 360 + wifi	5	Xbox 360 with one controller, a 60 gig hard drive and a wireless adaptor! Great condition!!	75.00	2016-02-10	2016-01-11 23:24:49	2016-01-11 23:24:58	N	Y	\N	\N	9	15	0	0	0	0
240	Lease Takeover	3	Looking for someone to take over my lease. It's $750 a month. Three bedroom two bath. Pet friendly and it's directly behind north campus. 	750.00	2016-01-12	2015-12-13 00:00:00	2015-12-14 00:16:21	N	Y	\N	\N	163	14	1	0	0	0
244	Achieving Fluency: Special Education and Mathematics	1	text used in Math 3008. excellent condition with some highlighting	20.00	2016-01-13	2015-12-15 17:03:36	2015-12-15 17:03:38	N	Y	\N	\N	172	38	1	0	0	0
246	Publication Manual of the American Psychological Association	1	Excellent condition, can be used for many classes.	35.00	2016-01-13	2015-12-15 17:07:25	2015-12-15 17:07:26	N	Y	\N	\N	172	38	1	0	0	0
281	post by naomi	1	post creAte	456	2016-01-13	2016-01-13 05:57:44	2016-01-13 05:57:48	N	Y	\N	\N	6	16	1	0	0	0
248	Green blouse 	4	Never worn!!	5	2016-01-14	2015-12-16 00:00:00	2015-12-16 03:18:05	N	Y	\N	\N	30	15	1	0	0	0
250	Looking for a desk!	16	I need a white or off white desk! Will pay up to the price in the description 	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:20:00	N	Y	\N	\N	30	15	1	0	0	0
257	hello this is etilox	1	hdllo	50	2016-01-17	2015-12-18 06:58:02	2015-12-18 06:58:05	N	Y	\N	\N	6	16	1	0	0	0
287	Post testing	1	Adfff	12	2016-01-19	2016-01-18 12:17:41	2016-01-18 12:17:44	N	Y	\N	\N	6	16	1	0	0	0
291	Elect chip for sale	5	Test pls ignore	100	2016-01-24	2016-01-22 12:42:47	2016-01-22 12:43:00	Y	Y	\N	\N	212	15	3	0	0	0
292	Pen drive foe sale	5	Test	100	2016-01-28	2016-01-25 04:47:01	2016-01-25 04:47:07	N	Y	\N	\N	182	16	1	0	0	0
232	Sock 	4	Are you tired of looking for the other pair to your single socks? This slightly used sock could be an answer to all your problems! 	1.00	2016-01-03	2015-12-04 00:00:00	2015-12-04 19:28:40	Y	Y	\N	\N	87	14	3	0	0	0
234	Sock 	4	Are you tired of looking for the other pair to your single socks? This slightly used sock could be an answer to all your problems! 	1.00	2016-01-03	2015-12-04 00:00:00	2015-12-04 19:28:46	Y	Y	\N	\N	87	14	3	0	0	0
256	rug	2	5x7	15	2016-01-15	2015-12-16 14:59:17	2015-12-16 14:59:21	N	Y	\N	\N	175	15	0	0	0	0
251	Looking for a desk!	16	I need a white or off white desk! Will pay up to the price in the description  	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:20:28	Y	Y	\N	\N	30	15	0	0	0	0
253	Looking for a desk!	16	I need a white or off white desk!  	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:20:44	Y	Y	\N	\N	30	15	0	0	0	0
280	Vineyard Vines polo	4	UGA logo, Vineyard Vines polo.\nPerfect game day shirt! \nSize: LARGE	25	2016-02-11	2016-01-12 13:35:47	2016-01-12 13:35:51	N	Y	\N	\N	9	15	1	0	0	0
289	MGMT 3000 	1	Price negotiable. 	20	2016-02-17	2016-01-18 20:24:26	2016-01-18 20:25:27	N	Y	\N	\N	185	15	1	0	0	0
284	Mens Polo Ralph Lauren black polo - Large	18	Mens Large Polo Ralph Lauren polo for sale! In great condition! Not stains, rips, or tears\nColor - Black	15.00	2016-03-16	2016-01-15 22:48:43	2016-02-16 16:52:41	Y	Y	\N	\N	194	15	1	0	0	0
276	Post by john1	1	Create post	2500	2016-01-10	2016-01-07 04:42:02	2016-01-07 04:42:13	Y	Y	\N	\N	181	16	1	0	0	0
293	Michael Kors watch	12	Basically new. Pristine condition.	150	2016-02-20	2016-02-01 02:41:26	2016-02-01 02:41:35	N	Y	\N	\N	221	15	1	0	0	0
271	Test	16	Test	500	2015-12-27	2015-12-24 00:00:00	2015-12-24 05:41:22	Y	Y	\N	\N	180	16	1	0	0	0
264	test post 4 john	1	test	9	2015-12-23	2015-12-22 11:33:41	2015-12-22 11:33:47	Y	Y	\N	\N	180	16	1	0	0	0
262	test post2 john	1	test	5	2015-12-23	2015-12-22 00:00:00	2015-12-22 11:19:44	Y	Y	\N	\N	180	16	1	0	0	0
282	Mens Polo Ralph Lauren Polo - Large	18	Mens Large Polo Ralph Lauren polo for sale! In great condition! Not stains, rips, or tears	15.00	2016-02-14	2016-01-15 22:43:09	2016-02-12 15:40:48	Y	Y	\N	\N	194	15	1	0	0	0
278	Test by John	1	Hello	58	2016-01-23	2016-01-12 05:40:39	2016-01-12 05:40:45	Y	Y	\N	\N	180	16	1	0	0	0
260	Test post	1	Test post	500	2015-12-25	2015-12-22 00:00:00	2015-12-22 11:00:26	Y	Y	\N	\N	181	16	1	0	0	0
540	test	17	Poorly trained, very cute	20	2016-09-06	2016-09-07 01:58:23	2016-09-07 01:51:53	Y	Y	\N	\N	194	15	3	0	0	0
542	Pen drive test	5	Test desc	123	2016-10-06	2016-09-07 06:25:14	2016-09-07 06:19:27	Y	Y	\N	\N	194	15	0	0	0	0
249	Looking for a desk!	16	I need a white or off white desk! Will pay up to the price in the description 	150	2016-01-14	2015-12-15 00:00:00	2015-12-16 03:19:56	Y	Y	\N	\N	30	15	0	0	0	0
269	Book	1	The	2	2015-12-23	2015-12-23 00:00:00	2015-12-24 01:40:18	Y	Y	\N	\N	66	15	0	0	0	0
243	RMIN 5100 Tests	1	Old tests for RMIN 5100	30	2016-01-13	2015-12-15 00:00:00	2015-12-15 03:59:56	Y	Y	\N	\N	171	15	3	0	0	0
245	Speech to Print	1	excellent condition, some highlighting, used in Read 3200	20.00	2016-01-13	2015-12-15 17:05:13	2015-12-15 17:05:14	N	Y	\N	\N	172	38	1	0	0	0
272	Test	8	Test	500	2015-12-27	2015-12-24 00:00:00	2015-12-24 05:42:27	Y	Y	\N	\N	180	16	3	0	0	0
239	ACSM's Certification Review	1	Certification review for ACSM Certified EP, CPT, HFS	10.00	2016-01-10	2015-12-11 00:00:00	2015-12-11 21:56:07	N	Y	\N	\N	61	14	1	0	0	0
247	Phonics the Use	1	excellent condition	20.00	2016-01-13	2015-12-15 17:08:33	2015-12-15 17:08:35	N	Y	\N	\N	172	38	1	0	0	0
265	Campus Ambassador!	8	Who wants to make some $$$ by becoming an official campus ambassador! Put it on your resume! \nMessage us back or email us at thriftskool@gmail.com to get started and get paid!	500.00	2016-01-21	2015-12-22 00:00:00	2015-12-22 23:51:10	Y	Y	\N	\N	9	15	0	0	0	0
241	Apartment Sublease starting now-July 	3	I need someone to take over my lease starting as soon as possible until July!\nI currently live in Polo Club. \nRent is $389 a month + utilities which should be no more than $50 a month. Internet and trash is included in the rent! Also the apartment is furnished \n\nAmenities include:\nDesigner Swimming Pool\nSun deck\n24-Hour Fitness Center and Clubhouse\nStand-up tanning bed\nComputer Lab\nBilliards\nSand Volleyball Court\nPoolside Fire Pit\nOutdoor Grills\nPet Friendly\n1.8 mi from Campus\nBike to Class\nConvenient Bus Routes\nIndividual Leases\nOn-Site Parking Available\nRoommate Matching Available\nOn-Site Management\nCommunity Events\nFully Furnished\nFlat Screen TV in Living Room\nWiFi Internet\nDirect Billing (Water & Power)\n24-Hr Emergency Maintenance\nWaste Management\nPest Control\n\nI currently live with two female roommates, both are UGA students. They're very busy so they typically aren't a bother of any sort, and they're super nice.\nWe're in a three bedroom townhouse layout, but my bedroom that I would be leasing out is on the main floor and has its own bathroom and walk in closet. \n\nPlease contact me if you're interested, I'd really love to hear from you!	389	2016-01-12	2015-12-14 00:00:00	2015-12-14 02:19:11	N	Y	\N	\N	170	15	1	0	0	0
258	Peter1	1	Shaggy	55	2016-01-17	2015-12-18 00:00:00	2015-12-18 07:08:03	N	Y	\N	\N	2	16	1	0	0	0
267	6 month lease Fall 16 	16	I am looking for a 3-4 person apartment/house. I will only be in Athens for the fall semester so it needs to be a 6 month lease. 	1	2016-01-22	2015-12-23 00:00:00	2015-12-24 01:36:15	N	Y	\N	\N	66	15	1	0	0	0
18	Wounded Warrior Under Armour workout tee	18	BRAND NEW! tags are still on this Under Armour Wounded Warrior dri-fit tee.  size large	15.00	2016-03-15	2016-02-11 01:34:40	2016-02-16 16:58:20	Y	Y	\N	\N	194	15	1	0	0	0
263	test post 3 john	1	test	6	2015-12-23	2015-12-22 11:28:58	2015-12-22 11:29:14	Y	Y	\N	\N	180	16	1	0	0	0
285	Men's Polo Ralph Lauren white polo - Large	18	Mens Large Polo Ralph Lauren polo for sale! In great condition! Slightly worn!	10.00	2016-03-16	2016-01-15 22:52:02	2016-02-16 16:54:01	Y	Y	\N	\N	194	15	1	0	0	0
305	Bb	18	Hh\n	50.00	2016-03-11	2016-02-11 11:56:45	2016-02-11 11:56:56	Y	Y	\N	\N	194	15	3	0	0	0
306	Hh	1	Hh	50.00	2016-03-11	2016-02-11 14:09:12	2016-02-11 14:09:23	Y	Y	\N	\N	194	15	3	0	0	0
279	Beer mug tie	4	A beer mug tie	5	2016-02-11	2016-01-12 13:33:43	2016-01-12 13:33:47	N	Y	\N	\N	9	15	1	0	0	0
286	Mens Polo Ralph Lauren polo - Medium	18	Mens Medium Polo Ralph Lauren polo for sale! In great condition! Not stains, rips, or tears\nColor - Gray	15.00	2016-03-16	2016-01-15 22:54:03	2016-02-16 16:53:48	Y	Y	\N	\N	194	15	1	0	0	0
14	Lightly worn Polo button down	18	16 1/2.  34/35\nGreat shirt	15	2016-03-11	2016-02-11 01:05:20	2016-02-12 15:43:17	N	Y	\N	\N	9	15	1	0	0	0
10	Size 12 L.L. Bean Duck boots	18	Used. Been great shoes but I don't use them anymore. Kinda don't really want to let them go so $75 	75	2016-03-11	2016-02-11 00:52:21	2016-02-12 15:45:29	N	Y	\N	\N	9	15	1	0	0	0
304	Test post	1	Asss	12	2016-02-12	2016-02-11 10:29:38	2016-02-11 10:33:40	Y	Y	\N	\N	180	16	1	0	0	0
261	test Post john	1	test post	5	2015-12-23	2015-12-22 00:00:00	2015-12-22 11:07:45	Y	Y	\N	\N	180	16	1	0	0	0
15	Vineyard Vines button down	18	Large. Lightly worn	15	2016-03-11	2016-02-11 01:08:34	2016-02-12 15:45:41	N	Y	\N	\N	9	15	1	0	0	0
17	25 lb and 40 lb weights	11	It's almost spring break season.	35	2016-03-12	2016-02-11 01:14:49	2016-02-11 01:15:04	N	Y	\N	\N	9	15	1	0	0	0
6	Poker set	17	Full poker set. In great condition. 	50.00	2016-03-11	2016-02-11 00:38:21	2016-02-11 00:38:38	N	Y	\N	\N	9	15	1	0	0	0
5	test by etiloxfhsdgnxgfngchmc	1	chZcfngchjhdgj	50	2016-03-10	2016-02-10 14:33:46	2016-02-10 14:33:57	Y	Y	\N	\N	180	16	1	0	0	0
288	Intro to Tax Loose-Leaf Textbook 	1	Willing to negotiate price. 	30	2016-02-17	2016-01-18 20:23:22	2016-01-18 20:23:27	N	Y	\N	\N	185	15	1	0	0	0
290	Nike Running Hat	11	Description\nWorn twice. 	20	2016-02-17	2016-01-18 20:25:36	2016-02-12 15:45:20	N	Y	\N	\N	185	15	1	0	0	0
3	test	1	hsddndfhhdfjgf	50	2016-03-04	2016-02-04 04:55:30	2016-02-04 04:56:03	N	Y	\N	\N	183	16	1	0	0	0
301	Test 11 feb	1	Test by etilox	500	2016-03-10	2016-02-11 06:59:41	2016-02-11 06:59:57	N	Y	\N	\N	182	16	1	0	0	0
4	UGA campus transit 	2	Apply to work for UGA transit at www.transit.uga.edu\n\nHighest paying job on campus!	0.00	2016-03-10	2016-02-10 14:08:02	2016-02-17 14:35:44	N	Y	\N	\N	30	15	1	0	0	0
7	X box 360	5	Used X box. Good condition, just haven't used in years. Comes with everything you see there.	100	2016-03-11	2016-02-11 00:41:22	2016-02-11 00:41:40	N	Y	\N	\N	9	15	1	0	0	0
8	Yeti cooler	14	45 Yeti. Special Ducks Unlimited addition. Great condition! 	250.00	2016-03-11	2016-02-11 00:44:57	2016-02-11 00:45:09	N	Y	\N	\N	9	15	1	0	0	0
9	Wireless beats 	5	Literally just bought these like two months ago. Great condition. 	250	2016-03-11	2016-02-11 00:49:10	2016-02-11 00:49:22	N	Y	\N	\N	9	15	1	0	0	0
11	Two racquets and three balls	11	Used equipment. Don't play anymore. 	40	2016-03-11	2016-02-11 00:56:11	2016-02-11 00:56:26	N	Y	\N	\N	9	15	1	0	0	0
12	TI-84 Plus Silver Edition 	5	No need for this any longer	45	2016-03-11	2016-02-11 00:58:04	2016-02-11 00:58:18	N	Y	\N	\N	9	15	1	0	0	0
2	final test	1	hell 	55	2016-03-01	2016-02-01 13:37:03	2016-02-01 13:37:13	Y	Y	\N	\N	180	16	1	0	0	0
302	my first pOst	1	fhdsfh	2255	2016-03-11	2016-02-11 08:45:31	2016-02-11 08:46:21	Y	Y	\N	\N	180	16	1	0	0	0
13	Large Polo button down	18	Lightly worn 	10	2016-03-11	2016-02-11 01:02:57	2016-02-12 15:43:00	N	Y	\N	\N	9	15	1	0	0	0
16	Classic fit Polo button down	18	16 34/35\n\nLightly worn	10	2016-03-12	2016-02-11 01:11:06	2016-02-12 15:41:42	N	Y	\N	\N	9	15	1	0	0	0
275	test johnnn11	1	ethdfg	45	2016-01-29	2015-12-31 00:00:00	2015-12-31 08:40:17	Y	Y	\N	\N	181	16	1	0	0	0
303	second	1	vghgf	57654	2016-03-11	2016-02-11 08:47:51	2016-02-11 08:48:19	Y	Y	\N	\N	180	16	1	0	0	0
541	Golden retriever	17	poorly trained, very cute	20	2016-09-07	2016-09-07 02:03:06	2016-09-07 01:56:36	Y	Y	\N	\N	194	15	3	0	0	0
547	Test book	1	Test	123	2016-10-07	2016-09-07 14:58:00	2016-09-07 14:59:28	Y	Y	\N	\N	194	15	0	0	0	0
307	Mens Smith Sunglasses	18	Mens Smith Outlier Sunglasses. Matte black with black frames in great condition! No scratches on the lenses!	25.00	2016-03-12	2016-02-11 14:35:51	2016-02-11 14:36:02	Y	Y	\N	\N	194	15	3	0	0	0
310	Womens Gold Ray Ban Aviator Sunglasses	22	In great condition! Message me for details!	50.00	2016-03-10	2016-02-11 14:57:20	2016-02-11 14:58:37	Y	Y	\N	\N	194	15	3	0	0	0
308	Fitbit Flex size small	5	Fitbit flex works perfectly! Color - slate	40.00	2016-03-11	2016-02-11 14:37:20	2016-02-11 14:37:30	Y	Y	\N	\N	194	15	1	0	0	0
320	Women's Patagonia M	22	Medium \nGray and purple	35.00	2016-03-22	2016-02-22 21:38:56	2016-02-22 21:39:06	N	Y	\N	\N	380	15	1	0	0	0
334	Shirts 	22	Each shirt is a size small, all worn less that 3 times. $5 each!\n	5	2016-04-21	2016-03-24 01:24:58	2016-03-24 01:28:12	Y	Y	\N	\N	437	15	0	0	0	0
312	Nike bookbag for sale	17	In great condition, message me for details 	20.00	2016-03-12	2016-02-12 01:01:24	2016-02-12 01:01:24	Y	Y	\N	\N	194	15	1	0	0	0
313	Accounting 2101 Study Resources	1	Lectures (4 slides per page) with notes already filled in, practice problems, audio recordings of lectures, Connect Homework, and LS for all 12 chapters of Accounting 1.	15.00	2016-03-13	2016-02-13 20:44:20	2016-02-13 20:44:18	N	Y	\N	\N	330	15	1	0	0	0
309	Mens Smith Outlier Sunglasses	18	Mens Smith Outlier Sunglasses. Matte black with black frames in great condition! No scratches on the lenses!	30.00	2016-03-11	2016-02-11 14:41:48	2016-02-11 14:41:58	Y	Y	\N	\N	194	15	1	0	0	0
323	Mens Smith Outlier Sunglasses	18	Mens Smith Outlier Sunglasses. Matte black with black frames in great condition! No scratches on the lenses!	30.00	2016-04-13	2016-03-14 13:47:27	2016-03-14 13:46:33	Y	Y	\N	\N	194	15	0	0	0	0
311	Womens Gold Ray Ban Aviator Sunglasses 	22	In great condition! Message me for details!	50.00	2016-03-11	2016-02-11 14:59:26	2016-02-11 14:59:37	Y	Y	\N	\N	194	15	1	0	0	0
326	Fitbit Flex size small	5	Fitbit flex works perfectly! Color - slate	40.00	2016-04-13	2016-03-14 13:51:16	2016-03-14 13:50:23	Y	Y	\N	\N	194	15	1	0	0	0
321	Maroon long sleeve dress	22	This is a boutique dress that's never been worn! It's just too long on me because I'm REALLY short 	15	2016-03-15	2016-02-23 19:00:13	2016-02-23 18:59:53	N	Y	\N	\N	382	15	1	0	0	0
332	Test 2	1	Hdj\n	48	2016-03-16	2016-03-16 05:12:34	2016-03-16 05:11:56	Y	Y	\N	\N	194	15	0	0	0	0
331	test by etilox	1	hey testeing	45.12	2016-03-19	2016-03-16 05:10:04	2016-03-16 05:07:48	Y	Y	\N	\N	181	15	0	0	0	0
318	Dresses!!!	16	I need dresses for formals! One long and one short. XS. 	100	2016-03-02	2016-02-17 16:28:27	2016-02-17 16:28:28	Y	Y	\N	\N	359	15	3	0	0	0
314	Purple blouse 	22	Worn but in great condition! 	5	2016-03-16	2016-02-16 18:18:36	2016-02-16 18:18:29	N	Y	\N	\N	30	15	1	0	0	0
315	Multi-color blouse	22	Size medium! Never worn 	10	2016-03-16	2016-02-16 18:19:59	2016-02-16 18:19:52	N	Y	\N	\N	30	15	1	0	0	0
316	Maroon blouse	22	Worn a few times, in great condition! Size medium 	10	2016-03-16	2016-02-16 18:21:54	2016-02-16 18:21:48	N	Y	\N	\N	30	15	1	0	0	0
317	White blouse	22	Size large, worn a few times but in perfect condition! 	10	2016-03-16	2016-02-16 18:23:41	2016-02-16 18:23:41	N	Y	\N	\N	30	15	1	0	0	0
335	Size small shirts 	22	Only worn a couple times. $7 each 	7	2016-04-22	2016-03-24 01:27:27	2016-03-24 01:26:20	Y	Y	\N	\N	437	15	0	0	0	0
319	Floor length Floral Maxi from Revolve	22	Cotton maxi from revolve, super cute originally $180	30	2016-03-18	2016-02-17 23:41:06	2016-02-17 23:41:00	N	Y	\N	\N	373	15	1	0	0	0
322	PS3 Slim	5	This PS3 Slim is used but you would never be able to tell. 120gb console with 2 controllers, Bluetooth remote, original cables, additional charging dock for two controllers, and an additional 10ft charging cable!\nContinue checking my selling list for PS3 games that will be uploaded soon!\n	200	2016-04-12	2016-03-13 06:14:04	2016-03-13 06:13:27	N	Y	\N	\N	397	15	1	0	0	0
333	Testing	2	Test\n	12	2016-03-16	2016-03-16 06:30:07	2016-03-16 06:29:42	Y	Y	\N	\N	194	15	1	0	0	0
283	Mens Polo Ralph Lauren half-zip pullover Large	18	Never been worn! Mens Large Polo Ralph Lauren half-zip pullover for sale! In great condition! Not stains, rips, or tears\nColor- light purple-ish	20.00	2016-03-16	2016-01-15 22:45:34	2016-02-16 16:53:32	Y	Y	\N	\N	194	15	1	0	0	0
327	Nike bookbag for sale	17	In great condition, message me for details 	20.00	2016-04-13	2016-03-14 13:52:39	2016-03-14 13:51:46	Y	Y	\N	\N	194	15	1	0	0	0
325	Womens Gold Rayban Aviator Sunglasses	22	In great condition! Message me for details!	40.00	2016-04-13	2016-03-14 13:50:12	2016-03-14 13:49:18	Y	Y	\N	\N	194	15	1	0	0	0
328	Test by etilox	1	Test	500	2016-04-13	2016-03-15 12:15:09	2016-03-15 12:14:47	N	Y	\N	\N	182	16	1	0	0	0
344	Mens Polo Ralph Lauren polo Large	18	Mens Polo Ralph Lauren polo - black with red logo - no stains or rips - message me for details!	20.00	2016-04-23	2016-03-25 02:16:25	2016-03-25 02:15:18	Y	Y	\N	\N	194	15	1	0	0	0
330	Shimmer and Shine Jumpsuit	22	Size large but fits like a medium/large. Never worn. Originally $42	30	2016-04-14	2016-03-15 23:07:38	2016-03-15 23:06:44	N	Y	\N	\N	407	15	1	0	0	0
329	Olive Montana Tunic	22	Size large but fits like a medium/large. Never worn, tags still attacked. Very soft!! Originally $77	30	2016-04-13	2016-03-15 23:04:51	2016-03-15 23:07:19	N	Y	\N	\N	407	15	1	0	0	0
336	Weights 	11	25lb & 45lb dumb bells	25	2016-04-23	2016-03-25 00:39:10	2016-03-25 00:38:06	N	Y	\N	\N	9	15	1	0	0	0
337	YETI cooler 	23	45 YETI cooler. Great condition! 	250	2016-04-23	2016-03-25 00:43:19	2016-03-25 00:42:12	N	Y	\N	\N	9	15	1	0	0	0
338	Two Racquets and three balls	11	Great condition, hardly ever used!	35	2016-04-23	2016-03-25 00:45:27	2016-03-25 00:44:22	N	Y	\N	\N	9	15	1	0	0	0
339	Xbox 360 with accessories 	5	Xbox 360\n60GB hard drive \nWifi connector \nController 	125	2016-04-23	2016-03-25 00:48:39	2016-03-25 00:47:32	N	Y	\N	\N	9	15	1	0	0	0
340	Mens Under Armour wounded warrior tee	18	Mens LARGE under armour wounded warrior athletic tee. NEW WITH TAGS!	15.00	2016-04-23	2016-03-25 02:08:29	2016-03-25 02:07:18	N	Y	\N	\N	194	15	1	0	0	0
341	Mens Polo Ralph Lauren half zip pullover LARGE	18	Brand new polo pullover - large - purple(ish) message me for details!	20.00	2016-04-23	2016-03-25 02:11:25	2016-03-25 02:10:30	N	Y	\N	\N	194	15	1	0	0	0
342	Mens Polo Ralph Lauren polo Large	18	Mens Polo Ralph Lauren polo - white with green stripes - no stains or rips - message me for details!	20.00	2016-04-23	2016-03-25 02:13:14	2016-03-25 02:12:21	N	Y	\N	\N	194	15	1	0	0	0
343	Mens Polo Ralph Lauren white polo Large	18	Mens Polo Ralph Lauren polo - white with navy logo - no stains or rips - message me for details!	20.00	2016-04-23	2016-03-25 02:15:05	2016-03-25 02:13:55	N	Y	\N	\N	194	15	1	0	0	0
324	Mens Smith Outlier Sunglasses	18	Mens Smith Outlier Sunglasses. Matte black with black frames in great condition! No scratches on the lenses!	30.00	2016-04-13	2016-03-14 13:48:53	2016-03-14 13:47:59	Y	Y	\N	\N	194	15	1	0	0	0
347	Test	1	Jhghjghbj	556	2016-05-04	2016-04-04 08:58:12	2016-04-04 08:57:10	Y	Y	\N	\N	181	15	0	0	0	0
346	Test	3	Jzjzh	575	2016-05-01	2016-04-02 13:19:31	2016-04-02 13:18:25	Y	Y	\N	\N	181	15	0	0	0	0
350	Swimsuit 	22	Never worn, top size medium bottoms size small 	40	2016-04-29	2016-04-06 13:57:14	2016-04-06 13:59:41	N	Y	\N	\N	458	15	1	0	0	0
349	Lily Pulitzer dress 	22	Worn twice, great condition size 6  	50	2016-04-29	2016-04-06 13:56:18	2016-04-06 13:59:56	N	Y	\N	\N	458	15	1	0	0	0
352	Joe's jeans 	22	Size 29, too big for me now 	40	2016-04-30	2016-04-06 13:59:28	2016-04-06 13:57:55	N	Y	\N	\N	458	15	1	0	0	0
360	Nike bookbag for sale	17	In great shape just don't need it! Message me	15.00	2016-05-14	2016-04-14 14:10:07	2016-04-14 14:08:19	N	Y	\N	\N	194	15	1	0	0	0
365	Tesrt	1	Fxhcgfjc	4454	2016-05-16	2016-04-16 11:52:15	2016-04-16 11:50:39	Y	Y	\N	\N	181	15	0	0	0	0
358	Ffdu	1	Gofk jxjz	123	2016-04-08	2016-04-08 10:35:36	2016-04-08 10:34:32	Y	Y	\N	\N	181	15	1	0	0	0
366	Fgdfgj	1	Ghckfhig	5644568	2016-04-16	2016-04-16 11:58:56	2016-04-16 11:57:23	N	Y	\N	\N	182	16	1	0	0	0
364	Ping Putter 	11	Ping Karsten TR Anser 5. Great condition. Basically new never been used on the course before. 	85	2016-05-01	2016-04-14 19:01:38	2016-04-14 19:00:15	Y	Y	\N	\N	485	15	3	0	0	0
380	Family Feud Tix!	7	I can get tickets pretty much when needed, just let me know when! 	10.00	2016-05-27	2016-04-27 22:18:37	2016-04-27 22:16:24	Y	Y	\N	\N	194	15	1	0	0	0
381	Beats by Dre Solo Headphones	5	Beats by Dre Solo Headphones work perfectly. These are amazing i just need the cash	60.00	2016-05-27	2016-04-27 22:20:41	2016-04-27 22:18:28	Y	Y	\N	\N	194	15	1	0	0	0
376	Large standing corner mirror	3	5ft wood grain standing mirror! Looks great in the corner of a room!	25.00	2016-05-27	2016-04-27 22:06:07	2016-04-27 22:03:54	N	Y	\N	\N	194	15	1	0	0	0
369	Pillow	3	Brand new	10	2016-05-09	2016-04-20 00:59:56	2016-04-20 00:58:03	Y	Y	\N	\N	481	15	0	0	0	0
368	Pillow	3	Looks brand new! Only had it for a few months and it just sat on top of my bed as decoration 	5	2016-05-09	2016-04-20 00:58:27	2016-04-20 00:56:30	Y	Y	\N	\N	481	15	0	0	0	0
367	Pillows 	3	I have two of the solid yellow one! $10 each for all these  	10	2016-05-09	2016-04-20 00:56:20	2016-04-20 00:54:28	Y	Y	\N	\N	481	15	0	0	0	0
351	vs swimsuit 	22	Worn once, both size medium \n	35	2016-04-28	2016-04-06 13:58:01	2016-04-06 13:59:13	N	Y	\N	\N	458	15	1	0	0	0
353	Top 	22	Women's top size medium 	15	2016-04-30	2016-04-06 14:00:23	2016-04-06 13:58:50	N	Y	\N	\N	458	15	1	0	0	0
354	Top	22	Off the shoulder top with slitted sleeves, size medium. 	15	2016-04-30	2016-04-06 14:03:21	2016-04-06 14:01:48	N	Y	\N	\N	458	15	1	0	0	0
355	Top	22	One shoulder top size medium 	15	2016-04-30	2016-04-06 14:04:01	2016-04-06 14:02:29	N	Y	\N	\N	458	15	1	0	0	0
356	Buckle jeans 	22	Worn once, size 28/34, originally $100 	50	2016-04-30	2016-04-06 14:07:08	2016-04-06 14:05:37	N	Y	\N	\N	458	15	1	0	0	0
357	Buckle jeans 	22	Slim boot cut size 28/34 originally $100 	50	2016-04-30	2016-04-06 14:08:03	2016-04-06 14:06:31	N	Y	\N	\N	458	15	1	0	0	0
348	UGA campus transit	2	Apply to work for UGA transit at www.transit.uga.edu\n\nHighest paying job on campus!	0.00	2016-05-05	2016-04-05 20:00:26	2016-04-05 19:58:54	N	Y	\N	\N	30	15	1	0	0	0
377	Magnavox 32" flatscreen 1080p tv	5	Magnavox 32" flatscreen 1080p tv with remote. Works amazing!	40.00	2016-05-27	2016-04-27 22:07:36	2016-04-27 22:05:28	Y	Y	\N	\N	194	15	1	0	0	0
363	Mens Smith Outlier Shades 	18	Matte Black Smith Outlier Sunglasses in good condition. Regularly $90	20.00	2016-05-14	2016-04-14 14:13:59	2016-04-14 14:12:10	Y	Y	\N	\N	194	15	1	0	0	0
361	Fitbit Flex size small	5	Works perfectly! Color- slate	30.00	2016-05-14	2016-04-14 14:11:13	2016-04-14 14:09:24	Y	Y	\N	\N	194	15	1	0	0	0
370	Dresses!! (4 different, individually being sold)	22	Great condition, gently worn \n$10 EACH	10	2016-05-26	2016-04-27 13:15:23	2016-04-27 13:14:20	N	Y	\N	\N	30	15	1	0	0	0
374	majestic Chipper Jones replica jersey	18	BRAND New with tags Chipper Jones Majestic jersey. Size Large. Hit me up for details!	25.00	2016-05-27	2016-04-27 22:00:57	2016-04-27 21:58:45	Y	Y	\N	\N	194	15	1	0	0	0
371	Dresses! (4 different, sold individually)	22	Gently worn, great condition! \n$10 EACH	10	2016-05-27	2016-04-27 13:17:48	2016-04-27 13:15:45	N	Y	\N	\N	30	15	1	0	0	0
372	Dakine backpack	11	Awesome backpack in perfect condition, has straps to attach any boards/poles for hiking as well	25.00	2016-05-27	2016-04-27 19:42:54	2016-04-27 19:40:40	N	Y	\N	\N	194	15	1	0	0	0
373	Mens left handed Titleist D1 Driver	11	Mens LH Titleist D1 driver with Fujikura shaft. Awesome driver with tons of shots left in it. Message me for more info\n	30.00	2016-05-27	2016-04-27 21:58:22	2016-04-27 21:56:10	N	Y	\N	\N	194	15	1	0	0	0
419	Tall bedside or living room lamp	3	About 3ft high, perfect for living rooms or bedside. Just dont need it but works great!	10.00	2016-08-30	2016-07-31 20:47:56	2016-07-31 20:42:47	N	Y	\N	\N	194	15	1	0	0	0
378	Large collection of Best Seller books! $5 each	1	The Lean Startup\nthe 6 Figure Second Income\nThe Richest Man In Babylon\nJuiced\nJohn Smoltz: Starting & Closing\nKevin Oleary - Men,Women, & Money\nRich Dad Poor Dad\nThink & Grow Rich\nAutomatic Millionaire\nDave Ramsey: Complete guide to Money\nTrump: How to get Rich	5.00	2016-05-27	2016-04-27 22:14:53	2016-04-27 22:12:41	N	Y	\N	\N	194	15	1	0	0	0
362	Womens Rayban Gold Aviator Sunglasses	22	In PERFECT condition! Message me for details 	30.00	2016-05-14	2016-04-14 14:12:45	2016-04-14 14:10:57	Y	Y	\N	\N	194	15	1	0	0	0
538	Golden Retiever	6	Poorly trained, very cute	0	2016-09-06	2016-09-07 01:57:40	2016-09-07 01:51:10	Y	Y	\N	\N	194	15	3	0	0	0
382	Golfer Lamp - you know its awesome!	3	This made it all the way through college with me, but its time to pass it down. Hit me up! 	10.00	2016-05-27	2016-04-27 22:23:40	2016-04-27 22:21:29	N	Y	\N	\N	194	15	1	0	0	0
383	Timex Weekender watch	12	Timex weekender watch. Has a light, water proof, and interchangeable bands. Great condition!	30	2016-05-27	2016-04-28 02:02:43	2016-04-28 02:00:35	N	Y	\N	\N	9	15	1	0	0	0
384	Xbox 360 + extras	5	Xbox\nController\nWifi \n60gig drive	100	2016-05-27	2016-04-28 02:04:50	2016-04-28 02:02:38	N	Y	\N	\N	9	15	1	0	0	0
385	Nice chair	3	Great condition!	100	2016-05-28	2016-04-28 02:06:00	2016-04-28 02:03:51	N	Y	\N	\N	9	15	1	0	0	0
386	Weights	11	Get strong for the ladies	20	2016-05-28	2016-04-28 02:08:32	2016-04-28 02:06:25	N	Y	\N	\N	9	15	1	0	0	0
387	3 wood	11	Got a new one so selling this	15	2016-05-28	2016-04-28 02:10:33	2016-04-28 02:08:22	N	Y	\N	\N	9	15	1	0	0	0
388	YETI	23	Great condition	250	2016-05-28	2016-04-28 02:14:20	2016-04-28 02:12:13	N	Y	\N	\N	9	15	1	0	0	0
389	Chinese (Mandarin) Rosetta Stone	17	I just don't have the time right now to do this. 	350	2016-05-28	2016-04-28 02:18:28	2016-04-28 02:16:18	N	Y	\N	\N	9	15	1	0	0	0
379	Under Armour Wounded Warriors tee	18	NWT! Size large, hit me up for details	10.00	2016-05-27	2016-04-27 22:16:55	2016-04-27 22:14:49	Y	Y	\N	\N	194	15	1	0	0	0
375	Mens Gshock watch	18	Awesome black gshock with lime green dials. Hit me up!	25.00	2016-05-26	2016-04-27 22:03:13	2016-04-27 22:01:23	Y	Y	\N	\N	194	15	1	0	0	0
545	Photo Post test	2	Photo Post Desc	123	2016-10-07	2016-09-07 07:36:15	2016-09-07 07:30:38	Y	Y	\N	\N	194	15	0	0	0	0
544	Test post	2	Test	123	2016-10-07	2016-09-07 07:21:18	2016-09-07 07:15:05	Y	Y	\N	\N	194	15	0	0	0	0
397	Nike Running Shoes	18	These Nike shoes have only been worn once, so you can say that they're practically brand new! You can tell that they haven't been worn because the soles of the shoes are shiny, black, clean, and still in tact. They still have the fresh, new shoe smell and are a size 12.  If you wear a size 11, possibly even 10, then you'd be able to wear them. Please get this off of my hands (I'm willing to negotiate). 	60.00	2016-05-14	2016-05-02 19:27:40	2016-05-02 19:27:35	N	Y	\N	\N	207	15	1	0	0	0
395	Lounge Chair 	3	Five foot long lounge chair with cushion. Suede fabric 	30	2016-05-12	2016-05-02 14:29:13	2016-05-02 14:26:52	Y	Y	\N	\N	119	14	0	0	0	0
394	Coffee table	3	Long coffee table. Roughly four feet long 	10	2016-05-12	2016-05-02 14:27:29	2016-05-02 14:25:11	Y	Y	\N	\N	119	14	0	0	0	0
403	Pillows and curtains 	3	$50 for all of it ! I will sell things separately too. Worth over a $150 value.	50	2016-06-09	2016-05-10 14:03:09	2016-05-10 14:00:35	N	Y	\N	\N	528	15	1	0	0	0
404	1BR 1 Bath @ the Standard - downtown	8	1BR 1B unit available for Fall 2016 at the Standard!!!! Last unit available - will be gone soon. Contact me or call the Standard's leasing office directly. 	1299	2016-06-12	2016-05-13 18:19:49	2016-05-13 18:17:09	N	Y	\N	\N	409	15	1	0	0	0
409	Mens Large Polo Ralph Lauren polo	18	Mens Large Black Polo - polo ralph lauren in perfect condition only worn a few times! 	20.00	2016-07-08	2016-06-09 03:50:30	2016-06-09 03:47:16	N	Y	\N	\N	194	15	1	0	0	0
401	TvCabinet with underneath storage 	3	Bought for 350 selling for 175	175	2016-05-20	2016-05-08 17:54:23	2016-05-08 17:51:54	N	Y	\N	\N	527	15	1	0	0	0
418	Atlanta Falcons cornhole boards! 	11	Atlanta Falcons cornhole boards for sale. In perfect condition, work great. Come with 8 falcons bags as well! Hmu! 	50.00	2016-08-30	2016-07-31 20:43:53	2016-07-31 20:38:51	Y	Y	\N	\N	194	15	0	0	0	0
391	Futon in great condition	3	Futon is in great condition. Comes with bedsheet cover as well as egg crate mattress topper. Has drawers underneath 	30	2016-05-11	2016-05-01 16:02:42	2016-05-08 15:48:38	N	Y	\N	\N	512	15	1	0	0	0
359	Brand New Tory Burch Flats 	22	Brand new Tory Burch flats, only been worn once. No signs of wear, mint condition! Just didn't like the way they looked on me. Size 8! \n	190	2016-05-12	2016-04-13 03:59:07	2016-04-13 04:01:13	N	Y	\N	\N	488	15	1	0	0	0
392	Metal Rack $20/ Outdoor Table and 5 chairs $20	3	Metal shelf/rack. Each level does break down individually for easy moving. Does not come with anything on it as shown \n\nOutdoor table and chairs: 5 foldable chairs included. Roughly 4 feet in diameter \n	20.00	2016-05-12	2016-05-02 14:25:06	2016-05-02 14:22:54	N	Y	\N	\N	119	14	1	0	0	0
393	Black chair	3	Living room chair. Will come with small unmatching gray storage ottoman. Does not recline	20.00	2016-05-12	2016-05-02 14:26:33	2016-05-02 14:24:12	N	Y	\N	\N	119	14	1	0	0	0
396	Bedside table	3	Two shelf bedside table. About three feet high. 	10	2016-05-12	2016-05-02 14:30:27	2016-05-02 14:28:10	N	Y	\N	\N	119	14	1	0	0	0
399	HP Office Jet 4630 Printer	5	It's a great printer that came with my laptop! Aha, the only problem is that I already had one. 	90.00	2016-05-29	2016-05-02 19:38:14	2016-05-02 19:36:54	N	Y	\N	\N	207	15	1	0	0	0
398	Futon	3	I got this futon from Ikea and, as you can see, fits perfectly underneath the beds. Definitely a great buy compared to the other futons that are available.	100.00	2016-05-31	2016-05-02 19:33:49	2016-05-02 19:32:40	N	Y	\N	\N	207	15	1	0	0	0
390	Textbooks For Sale! $5-$15	1	Selling the following textbooks for $5-$15:\nFirst Year Composition Guide, GA Politics in a State of Change, The Logic of American Politics, They Say I Say, Literature Portfolio, Amadeus, The Elements of Eloquence, and Several Shorts sentences about writing	5	2016-05-08	2016-04-29 17:10:30	2016-04-29 17:08:54	Y	Y	\N	\N	421	15	3	0	0	0
408	Large 5ft standing mirror	3	5ft wood grain standing mirror! Looks great in the corner of a room, paid $60 for it	30.00	2016-07-09	2016-06-09 03:48:45	2016-06-09 03:45:13	N	Y	\N	\N	194	15	1	0	0	0
410	Womens Rayban Aviators Gold &Brown	22	In PERFECT condition! Message me for details	50.00	2016-07-08	2016-06-09 03:53:07	2016-06-09 03:49:37	N	Y	\N	\N	194	15	1	0	0	0
405	Mens LH Titleist D1 Driver	11	Mens LH Titleist D1 driver with Fujikura shaft. Awesome driver with tons of shots left in it. Message me for more info	20.00	2016-07-09	2016-06-09 03:42:38	2016-06-09 03:39:08	N	Y	\N	\N	194	15	1	0	0	0
406	Under Armour Wounder Warrior Athletic Tee	18	NWT! Awesome Dri fit UA tee. Hit me up for details!	10.00	2016-07-09	2016-06-09 03:45:47	2016-06-09 03:42:16	N	Y	\N	\N	194	15	1	0	0	0
407	Large collection of best seller books! $5 each	1	The Lean Startup\nthe 6 Figure Second Income\nThe Richest Man In Babylon\nJuiced\nJohn Smoltz: Starting & Closing\nKevin Oleary - Men,Women, & Money\nRich Dad Poor Dad\nThink & Grow Rich\nAutomatic Millionaire\nDave Ramsey: Complete guide to Money\nTrump: How to get Rich	5.00	2016-07-09	2016-06-09 03:47:24	2016-06-09 03:43:52	N	Y	\N	\N	194	15	1	0	0	0
414	Black office chair	3	Black office chair used at my desk, has all the bells and whistles and comfy! 	10.00	2016-08-30	2016-07-31 20:22:59	2016-07-31 20:17:52	Y	Y	\N	\N	194	15	3	0	0	0
412	Blink 182 tickets	7	A pair of Blink-182 tickets for August 2 at 7:00 pm. Section just behind the pit.	200.00	2016-07-26	2016-06-26 14:31:18	2016-06-26 14:28:32	N	Y	\N	\N	524	15	1	0	0	0
411	Fitbit Flex size small - Slate - Works PERFECT	5	This fitbit works perfect i just got another as a gift so this is a cheap and perfect gadget to have!	30.00	2016-07-09	2016-06-09 03:54:37	2016-06-09 03:51:05	Y	Y	\N	\N	194	15	1	0	0	0
413	Mini fridge! Works great perfect for dorms	14	White mini fridge works great! Its roughly 18-20 inches high with pretty big room inside. Fits two dozen drinks. Hmu!  	25.00	2016-08-30	2016-07-31 20:18:47	2016-07-31 20:13:47	Y	Y	\N	\N	194	15	3	0	0	0
400	Apple TV	5	Great condition, has only been taken out of the box once! Price negotiable!	55	2016-06-01	2016-05-03 22:08:00	2016-05-04 03:27:23	Y	Y	\N	\N	421	15	3	0	0	0
416	Ibanez acoustic guitar for sale	17	Ibanez acoustic guitar for sale. I dont know much about guitars but other than one string broken there are no other damages to it. 	20.00	2016-08-30	2016-07-31 20:32:04	2016-07-31 20:26:57	Y	Y	\N	\N	194	15	0	0	0	0
415	Super comfy big chair for sale	3	Really big suede(ish) chair for sale! Really really comfy we just cant fit it in our apt living room. No stains, tears, anything this thing is awesome. Hmu! 	40.00	2016-08-30	2016-07-31 20:28:58	2016-07-31 20:23:51	N	Y	\N	\N	194	15	1	0	0	0
402	Funny college worthy Painting	3	roughly 4ft wide, 3ft high in perfect shape. Perfect for a college house! 	25.00	2016-06-07	2016-05-08 21:50:26	2016-05-08 21:47:54	Y	Y	\N	\N	194	15	1	0	0	0
417	Life's a Beach painting	3	Funny painting to put in your place! This has hung in my apt through college and now its time to pass it on. Its an actual painting in great shape! 	20.00	2016-08-30	2016-07-31 20:37:29	2016-07-31 20:32:23	Y	Y	\N	\N	194	15	1	0	0	0
420	Foam roller	11	Nice 30inch foam roller for those of you that work out and like to roll out the soreness or roll out achey muscles/joints!	10.00	2016-08-30	2016-07-31 21:28:51	2016-07-31 21:23:37	N	Y	\N	\N	194	15	1	0	0	0
421	Pull-up/chin-up bar for sale	11	Pull-up/chin-up bar for sale. Just latch it on to any door and your good to go!	10.00	2016-08-30	2016-07-31 21:29:58	2016-07-31 21:24:43	N	Y	\N	\N	194	15	1	0	0	0
345	Majestic Atlanta Braves Chipper Jones Jersey	18	New with tags! Size 44 (Large) Majestic Chipper Jones Braves jersey! Message me for details!	30.00	2016-04-23	2016-03-25 02:19:37	2016-03-25 02:18:46	Y	Y	\N	\N	194	15	1	0	0	0
443	Sofa/ Love Seat	3	Matching brown fabric sofa and love seat in great condition. 	500	2016-09-10	2016-08-12 00:52:57	2016-08-12 00:47:32	Y	Y	\N	\N	581	15	3	0	0	0
456	JanSport backpack	6	This is an old backpack but it's in good shape. Nothing broken!	0.	2016-09-12	2016-08-13 16:09:36	2016-08-13 16:03:56	Y	Y	\N	\N	9	15	3	0	0	0
441	Fitbit flex - works Perfect!!	5	This fitbit works perfect i just got another as a gift so this is a cheap and perfect gadget to have! Size small\n\nColor - Slate	25.00	2016-09-09	2016-08-12 00:35:16	2016-08-12 16:32:02	Y	Y	\N	\N	194	15	3	0	0	0
440	Mens Smith Outlier sunglasses	18	Mens Smith Outlier Sunglasses. Matte black with black frames in great condition! No scratches on the lenses!\nG\nG\nG\nG\nG\nH	25.00	2016-09-09	2016-08-12 00:32:58	2016-08-23 03:20:06	N	Y	\N	\N	194	15	1	0	0	0
447	Beats solo 2 headphones	5	Brand new still in the wrapper. Are not wireless. Silver/gray color	65	2016-09-01	2016-08-12 15:22:37	2016-08-12 15:17:00	Y	Y	\N	\N	660	15	3	0	0	0
459	closet shelf organizer	3	Laura Ashley six section closet organizer, brand new, out of packaging. Never used, great for sweaters and pants storage. Originally purchased for $24	15	2016-08-31	2016-08-13 17:13:10	2016-08-13 17:07:30	Y	Y	\N	\N	570	15	0	0	0	0
428	Sun glasses	18	Great condition just don't want them anymore.	30.00	2016-09-03	2016-08-04 23:29:47	2016-08-04 23:24:30	N	Y	\N	\N	9	15	1	0	0	0
422	womens nike golf shoes BRAND NEW! 	22	NWT womens nike golf shoes size 7.5 these shoes still have the tags on them, orginially priced at $70	35.00	2016-08-30	2016-07-31 21:33:32	2016-07-31 21:28:19	N	Y	\N	\N	194	15	1	0	0	0
423	Womens Columbia ADPi button down shirt	22	Womens columbia PFG baby blue button down shirt with ADPi logo on it. Size small. No stains, tears, etc in great condition! 	10.00	2016-08-30	2016-07-31 21:37:39	2016-07-31 21:32:28	N	Y	\N	\N	194	15	1	0	0	0
438	NWT nike braves shirt	18	Brand new with tags nike braves shirt. Awesome shirt just doesnt fit me. XL	15.00	2016-09-09	2016-08-12 00:26:10	2016-08-16 22:11:18	N	Y	\N	\N	194	15	1	0	0	0
426	Strapless maxi dress for sale	22	Size medium strapless maxi dress for sale. Only worn a few times in perfect condition 	10.00	2016-08-30	2016-07-31 21:44:09	2016-07-31 21:40:15	Y	Y	\N	\N	194	15	1	0	0	0
424	Womens purple komono 	22	This purple komono cardigan is lightweight, in great condition, and easy to match to make a cute outfit! 	10.00	2016-08-30	2016-07-31 21:40:52	2016-07-31 21:35:38	Y	Y	\N	\N	194	15	1	0	0	0
425	Maxi dress for sale! 	22	Size small only worn a few times. No stains, tears, etc and in super cute and comfy!	10.00	2016-08-30	2016-07-31 21:42:48	2016-07-31 21:37:36	Y	Y	\N	\N	194	15	1	0	0	0
442	Womens Ray Ban gold Aviators	22	They are in perfect condition, no scratches or anything! Message me for details	40.00	2016-09-08	2016-08-12 00:37:11	2016-08-23 23:34:08	Y	Y	\N	\N	194	15	0	0	0	0
429	Two Racquetball sticks	11	Don't play anymore so I'm selling em. I'll throw in the balls too.	50.00	2016-09-03	2016-08-04 23:32:23	2016-08-04 23:27:01	N	Y	\N	\N	9	15	1	0	0	0
430	Logitech wireless keyboard	5	This is in great shape.	70.00	2016-09-03	2016-08-04 23:33:46	2016-08-04 23:28:23	N	Y	\N	\N	9	15	1	0	0	0
431	TI 84+ Silver Edition	5	I don't have a need for this anymore. 	50.00	2016-09-03	2016-08-04 23:35:41	2016-08-04 23:30:22	N	Y	\N	\N	9	15	1	0	0	0
432	GMAT 2017 prep book	1	Perfect condition. Barely even opened.	60	2016-09-03	2016-08-04 23:37:15	2016-08-04 23:31:54	N	Y	\N	\N	9	15	1	0	0	0
433	Costa Del Mar glasses	23	Blue lens, Costa glasses in good condition!	125	2016-09-04	2016-08-05 11:54:37	2016-08-05 11:49:18	N	Y	\N	\N	9	15	1	0	0	0
434	No brand, ray ban wanna bes	18	These are from Walmart	15.00	2016-09-04	2016-08-05 21:43:50	2016-08-05 21:38:30	N	Y	\N	\N	9	15	1	0	0	0
539	Golden Retiever	17	Poorly trained, very cute	20	2016-09-06	2016-09-07 01:58:00	2016-09-07 01:51:29	Y	Y	\N	\N	194	15	3	0	0	0
543	Pen drive test	5	Test desc	123	2016-10-06	2016-09-07 06:25:14	2016-09-07 06:20:14	Y	Y	\N	\N	194	15	0	0	0	0
546	Test book	1	Test	123	2016-10-07	2016-09-07 14:58:00	2016-09-07 14:51:39	Y	Y	\N	\N	194	15	0	0	0	0
427	Womens teal blouse 	22	Size small, very unique and cute teal blouse . Only worn once!	10.00	2016-08-30	2016-07-31 21:49:47	2016-07-31 21:44:43	Y	Y	\N	\N	194	15	1	0	0	0
436	Beats headphones	5	Beats solo headphones work amazing! 	75.00	2016-09-10	2016-08-12 00:20:26	2016-08-12 00:14:54	Y	Y	\N	\N	194	15	1	0	0	0
439	Black&red polo ralph lauren polo	18	Black and red polo ralph lauren polo\nSize large\nBarely worn in perfect condition	15.00	2016-09-10	2016-08-12 00:28:15	2016-08-12 00:22:39	N	Y	\N	\N	194	15	1	0	0	0
444	GRE book	1	Graduate Record Examination Strategies, Practice and Review\n	10	2016-09-10	2016-08-12 00:57:37	2016-08-12 00:52:17	N	Y	\N	\N	581	15	1	0	0	0
445	PCAT	1	PCAT Strategies, Practice and Review 2014/2015	30	2016-09-10	2016-08-12 00:59:14	2016-08-12 00:53:47	N	Y	\N	\N	581	15	1	0	0	0
448	Georgia Red Lightweight Tee	18	Size Large lightweight graphic tee that I designed. I only have a few left! 	28	2016-09-11	2016-08-12 16:49:20	2016-08-12 16:45:03	N	Y	\N	\N	664	15	1	0	0	0
449	Georgia Swirl Lightweight Tee 	22	Size Large lightweight graphic tee that I designed. I only have a few left! 	28	2016-09-11	2016-08-12 16:51:44	2016-08-12 16:46:31	N	Y	\N	\N	664	15	1	0	0	0
450	Genetics: A conceptual approach, 5th Edition	1	Great condition! The lowest price for this book is $105 at the bookstores in Athens, so this is a great deal.	80.00	2016-09-11	2016-08-12 23:40:07	2016-08-12 23:34:28	N	Y	\N	\N	555	15	1	0	0	0
451	A brave little toaster!	14	Great for toasting, baking or broiling everything you can imagine as long as it fits inside.	10.00	2016-09-11	2016-08-13 01:41:36	2016-08-13 01:35:57	N	Y	\N	\N	612	15	1	0	0	0
452	insignia 36 inch lcd	5	Perfectly fine TV. Only thing missing is a remote but doesn't matter. I can show you an app that works the same way.	70.00	2016-09-12	2016-08-13 15:17:40	2016-08-13 15:12:20	N	Y	\N	\N	612	15	1	0	0	0
453	Costa Del Mar	18	Fathom\nGlass lens \nGreat condition\n	100.00	2016-09-12	2016-08-13 15:48:40	2016-08-13 15:43:04	N	Y	\N	\N	9	15	1	0	0	0
454	Beats wireless headphones	5	Perfect condition and hardly used	270.00	2016-09-12	2016-08-13 15:50:55	2016-08-13 15:45:20	N	Y	\N	\N	9	15	1	0	0	0
455	Swiss gear backpack	17	This is a great backpack	20	2016-09-12	2016-08-13 16:06:03	2016-08-13 16:00:28	N	Y	\N	\N	9	15	1	0	0	0
457	Nike backpack	6	This Nike backpack is missing one strap. No worries though, it's cool to only have your backpack hang from one shoulder! ;)	0.00	2016-09-12	2016-08-13 16:14:44	2016-08-13 16:09:10	N	Y	\N	\N	9	15	1	0	0	0
458	Black Diamond Climbing Harness	11	This is a black diamond size medium harness that's been used only once. The condition of the harness is new.	30.00	2016-09-12	2016-08-13 16:35:33	2016-08-13 16:29:52	N	Y	\N	\N	688	15	1	0	0	0
437	BRAND NEW chipper jones jersey	18	Majestic size 44 (large) chipper jones jersey. Still has the tags on it	50.00	2016-09-10	2016-08-12 00:23:26	2016-08-12 00:18:18	Y	Y	\N	\N	194	15	1	0	0	0
461	hexagon cork boards	6	Two hexagon shaped cork boards purchased as part of a set of 4. I only used two so I don't need these two :)	0	2016-09-01	2016-08-13 17:19:16	2016-08-13 17:14:07	Y	Y	\N	\N	570	15	0	0	0	0
446	CHEM 1211/1212 	1	This is a hardcover textbook. Don't have picture available at the moment but if you're interested let me know. Not the hybrid edition. Bought it for $250. Looks similar to the one in the picture. 	100	2016-08-16	2016-08-12 01:35:27	2016-08-12 01:31:10	N	Y	\N	\N	598	15	1	0	0	0
460	PBTeen hanging shoe rack	3	Brand new Pottery Barn Teen hanging shoe organizer in navy minidot. Never used, still in packaging. Original price $39. Color as first two pictures show.	15	2016-09-09	2016-08-13 17:17:10	2016-08-13 17:11:29	Y	Y	\N	\N	570	15	0	0	0	0
464	Brand New Spikeball Set	11	Brand new spikeball set. Got it as a gift but I already have 2 sets. Has not been used at all. Retails for over more than $50.	40	2016-09-14	2016-08-15 13:21:14	2016-08-15 13:15:35	N	Y	\N	\N	653	15	1	0	0	0
466	Mgmt 3000 book	1	For sale.	50	2016-08-19	2016-08-16 16:27:45	2016-08-16 16:22:34	N	Y	\N	\N	569	15	1	0	0	0
480	UGA Golf Polos	18	Nike & Cutter and Buck, 30 each or 50 for both\n\nBoth are medium	30	2016-09-17	2016-08-20 16:23:17	2016-08-24 14:17:27	Y	Y	\N	\N	514	15	3	0	0	0
493	Samsung s7 case	5	New not opened\n	20	2016-09-26	2016-08-27 18:14:51	2016-08-27 18:08:43	Y	Y	\N	\N	739	15	0	0	0	0
492	Otterbox Samsung s7 edge	5	New otterbox	25	2016-09-26	2016-08-27 17:30:51	2016-08-27 17:24:44	Y	Y	\N	\N	739	15	0	0	0	0
463	Dell Insipiron Mini Laptop	5	Mac users- get your Excel work done with this laptop. Its not a big investment and it could get you through your intro MIS class. The laptop is like-new; only used for a few months. OBO. Reasonable offers only.	160	2016-08-25	2016-08-15 11:43:28	2016-08-15 11:37:49	N	Y	\N	\N	569	15	1	0	0	0
475	Southern Cotton Apparel Comfort Color Tee	18	Comfort Color Tee by Southern Cotton Apparel. Brand new shirts in different colors and sizes.	25	2016-08-25	2016-08-19 15:10:32	2016-08-19 15:11:02	N	Y	\N	\N	772	15	1	0	0	0
485	This is a very very very long post	1	G	500.00	2016-09-20	2016-08-23 03:13:32	2016-08-23 03:08:37	Y	Y	\N	\N	194	15	3	0	0	0
487	University Calculus Early Transcendentals	1	The hardback edition of the textbook that all calculus courses at UGA use! Some bent corners, but overall in good shape with nothing that will impede the use of the book. 	25.00	2016-09-23	2016-08-24 22:56:19	2016-08-24 22:50:23	N	Y	\N	\N	460	15	1	0	0	0
491	Canvas picture	3	Painted picture of flowers. Dorm decor.	12	2016-09-26	2016-08-27 17:29:33	2016-08-27 17:23:26	Y	Y	\N	\N	739	15	0	0	0	0
479	Football Tickets	16	Need a ticket for UNC vs. UGA game.	40	2016-09-01	2016-08-20 15:30:00	2016-08-22 12:34:40	N	Y	\N	\N	772	15	1	0	0	0
495	Burgundy short rain boots	22	Vintage Size 8, sturdy, dark burgundy/wine booties. In good shape, never worn by me, purchased used. Might want to consider adding insoles. 	8.00	2016-09-26	2016-08-28 17:12:20	2016-09-11 23:09:27	N	Y	\N	\N	842	15	1	0	0	0
494	Women's Julio Jones Falcons Jersey	22	Women's Medium Julio Jones Atlanta Falcons Jersey! Message me if interested!	60	2016-09-26	2016-08-27 22:45:42	2016-08-27 22:39:46	Y	Y	\N	\N	421	15	1	0	0	0
462	dual band router	5	2.4 and 5 ghz router	20.00	2016-09-12	2016-08-13 20:40:03	2016-08-13 20:34:27	N	Y	\N	\N	612	15	1	0	0	0
470	Great deals 	1	Personal finance for Chatterjee $5\nGlobal future for Carmichael $5\nCommercial property for Atkinson $80\n	90	2016-09-12	2016-08-16 21:06:20	2016-08-17 17:14:50	N	Y	\N	\N	729	15	1	0	0	0
465	New alienware13 	5	I bought It in China about 20 days ago. GTX965m. Any famous games can play. The price can be discussed. email 854553477@qq.com…If you want more information pls email me	9999	2016-09-14	2016-08-15 19:46:28	2016-08-15 19:41:50	N	Y	\N	\N	677	15	1	0	0	0
477	Political Science Textbooks	1	GA Politics in a State of Change (2nd Edition) and The Logic of American Politics (6th Edition)	30	2016-09-18	2016-08-19 16:54:51	2016-08-19 16:49:10	Y	Y	\N	\N	421	15	0	0	0	0
467	Environmental Health: A Global Perspective	1	Very lightly used I dropped the class so I'm trying to sell it	90	2016-09-15	2016-08-16 20:19:26	2016-08-16 20:13:50	N	Y	\N	\N	720	15	1	0	0	0
468	Organic Chemistry 7th Edition	1	Same as the one sold in bookstores, but softcover economy version 	30	2016-09-15	2016-08-16 20:21:17	2016-08-16 20:15:31	N	Y	\N	\N	720	15	1	0	0	0
469	Chem 1211/1212 chemistry and chemical reactivity	1	Gen chem book. I don't know if they still use this one, but if they do, you can have it.	50	2016-09-15	2016-08-16 20:22:55	2016-08-16 20:17:09	N	Y	\N	\N	720	15	1	0	0	0
471	Macroeconomics 2105 	1	Barely used macro book for sale	50	2016-09-16	2016-08-17 21:38:27	2016-08-17 21:32:40	N	Y	\N	\N	755	15	1	0	0	0
472	Spanish 1110	1	Barely used Spanish book	30	2016-09-16	2016-08-17 21:39:57	2016-08-17 21:34:11	N	Y	\N	\N	755	15	1	0	0	0
473	First Year Comp Guide- English 1101/2	1	Opened up once. Nearly new book	10	2016-09-16	2016-08-17 21:41:21	2016-08-17 21:35:33	N	Y	\N	\N	755	15	1	0	0	0
474	Spanish 2001/2002	1	Very good condition textbook	60	2016-09-16	2016-08-17 21:44:05	2016-08-17 21:38:18	N	Y	\N	\N	755	15	1	0	0	0
478	BUSN 4000 textbook	1	Great condition textbook. Lmk if you have questions.	25	2016-09-18	2016-08-20 01:19:32	2016-08-20 01:13:40	N	Y	\N	\N	732	15	1	0	0	0
481	Southern Cotton Button Ups	18	Men's button up long sleeve shirts.	79	2016-09-19	2016-08-20 17:37:03	2016-08-20 17:31:09	N	Y	\N	\N	772	15	1	0	0	0
483	Bonnect Drivers!	2	Bonnect is the newest social media ride sharing company made by UGA students! Be a part of the team today! Great way to have an additional income. Set your own hours!	100	2016-09-21	2016-08-22 12:44:20	2016-08-22 12:38:22	N	Y	\N	\N	772	15	1	0	0	0
484	Beats solo 2 wireless	5	Selling brand new beats solo 2 wireless headphones. Still in wrapping. Retail price is $300	200	2016-09-21	2016-08-22 22:26:50	2016-08-22 22:20:53	N	Y	\N	\N	811	15	1	0	0	0
486	Beats solo 2 wireless	5	It's a brand new one. The color is rose gold. Adorable! The retail price is $300. \n\n	170	2016-09-21	2016-08-24 02:07:14	2016-08-24 02:02:51	N	Y	\N	\N	609	15	1	0	0	0
488	Physics 2 for Scientists and Engineers	1	A brand new without wrapping textbook used in all 1212 and 1252 courses at UGA. Perfect condition	25.00	2016-09-23	2016-08-24 22:57:52	2016-08-24 22:51:49	N	Y	\N	\N	460	15	1	0	0	0
490	Guitars	17	Looking for guitars 	.	2016-09-25	2016-08-26 22:06:54	2016-08-26 22:00:49	N	Y	\N	\N	643	15	1	0	0	0
497	Small sundress	22	Ridiculously comfy and I almost can't bare to sell it the back is so pretty. Size small!	7.00	2016-09-26	2016-08-28 17:21:02	2016-09-11 23:08:45	N	Y	\N	\N	842	15	1	0	0	0
496	Black suede wedges	22	Says size 8 but definitely runs small. I would recommend if you are size 7 or 7.5! They are suede and hella tall and I've never worn them because of their smallness :)	15.00	2016-09-26	2016-08-28 17:17:43	2016-09-11 23:09:05	N	Y	\N	\N	842	15	1	0	0	0
511	Apple wireless mouse	5	Never been used wireless apple mouse	40	2016-09-14	2016-09-02 15:21:35	2016-09-02 15:15:48	Y	Y	\N	\N	868	15	0	0	0	0
513	Apple wireless mouse	5	Never been used wireless apple mouse	40.00	2016-09-14	2016-09-02 15:21:35	2016-09-02 15:16:37	Y	Y	\N	\N	868	15	0	0	0	0
512	Apple wireless mouse	5	Never been used wireless apple mouse	40.00	2016-09-14	2016-09-02 15:21:35	2016-09-02 15:15:58	Y	Y	\N	\N	868	15	0	0	0	0
501	Organic chemistry (8th edition) by Bruice	1	Brand new organic chemistry (8th edition, 2016, hardcover) by Paula Yurkanis Bruice plus study guide and solutions manual. This is the newest edition (2016) textbook for Ochem. I have it only for one week. Bookstore sells $290. I offer $250 with a free UGA binder for study guide.	250.00	2016-09-23	2016-08-28 18:18:17	2016-08-28 21:15:12	N	Y	\N	\N	844	15	1	0	1	0
510	Apple wireless mouse	5	Never been used wireless apple mouse	40	2016-09-14	2016-09-02 15:21:35	2016-09-02 15:15:33	Y	Y	\N	\N	868	15	0	0	0	0
502	Free dog!	6	Who wants a free dog? Beautiful, 1 year old, white lab. Long story short, he was about to be taken to the pound today so I offered to take him until I could find him a good home. 	0.00	2016-08-31	2016-08-29 21:32:34	2016-08-29 21:27:49	Y	Y	\N	\N	9	15	3	0	0	0
504	Yeti Rambler	17	Brand new Yeti Rambler (30 oz) \nStill has all the tags and sticker inside	28.00	2016-09-15	2016-08-30 21:20:31	2016-08-30 21:14:17	Y	Y	\N	\N	856	15	0	0	0	0
505	Yeti Rambler	17	Brand new Yeti Rambler (30 oz) \nStill has all the tags and sticker inside	28.00	2016-09-15	2016-08-30 21:20:31	2016-08-30 21:14:20	Y	Y	\N	\N	856	15	0	0	0	0
506	Yeti Rambler	23	Brand new Yeti Rambler (30 oz) \nStill has all the tags and sticker inside	28.00	2016-09-15	2016-08-30 21:20:31	2016-08-30 21:14:32	Y	Y	\N	\N	856	15	0	0	0	0
507	Yeti Rambler	23	Brand new Yeti Rambler (30 oz) \nStill has all the tags and sticker inside	28	2016-09-15	2016-08-30 21:20:31	2016-08-30 21:14:38	Y	Y	\N	\N	856	15	0	0	0	0
476	Southern Cotton Comfort Color Tee	22	New Comfort Color pocket tees by Southern Cotton Apparel, in multiple colors and sizes!	25	2016-08-30	2016-08-19 15:18:49	2016-08-20 17:30:04	N	Y	\N	\N	772	15	1	0	0	0
500	Two silver picture frames 	3	Never been used. They still have sticky stuff on them from their old tags but this can be easily removed with rubbing alcohol! They hold 4x6 pictures. 	5.00	2016-09-26	2016-08-28 17:43:23	2016-09-11 23:07:27	N	Y	\N	\N	842	15	1	0	0	0
509	Apple wireless mouse	17	Never been used wireless apple mouse	40	2016-09-14	2016-09-02 15:21:35	2016-09-02 15:15:23	Y	Y	\N	\N	868	15	0	0	0	0
515	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-09-30	2016-09-03 15:26:55	2016-09-03 15:20:42	Y	Y	\N	\N	869	15	3	0	0	0
516	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-09-30	2016-09-03 15:26:55	2016-09-03 15:20:50	Y	Y	\N	\N	869	15	3	0	0	0
503	Beats by Dre Solo2 Wireless	5	Brand new with wrapping. Active Collection Siren Red 	170	2016-09-14	2016-08-30 21:05:55	2016-09-07 11:21:04	N	Y	\N	\N	778	15	1	0	0	0
525	Looking for student ID 	16	Looking for a student ID for the game this weekend against Nicholls State. Looking for a brown haired, brown eyed female id, willing to pay!	.	2016-09-10	2016-09-06 16:10:45	2016-09-06 16:04:20	Y	Y	\N	\N	421	15	0	0	0	0
514	Raybans sunglasses 	18	Only taken out of case to take picture. Received as a gift. 	60.00	2016-09-11	2016-09-02 15:24:54	2016-09-02 15:28:47	Y	Y	\N	\N	868	15	3	0	0	0
519	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-09-30	2016-09-03 15:27:58	2016-09-03 15:22:15	Y	Y	\N	\N	869	15	3	0	0	0
518	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-10-03	2016-09-03 15:27:47	2016-09-03 15:21:28	Y	Y	\N	\N	869	15	3	0	0	0
517	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-10-01	2016-09-03 15:27:31	2016-09-03 15:21:11	Y	Y	\N	\N	869	15	3	0	0	0
523	iPhone Charger	5	iPhone Charger for iPhone 5, 6, or 6 Plus! $15 or best offer!	15	2016-10-06	2016-09-06 03:20:49	2016-09-06 03:15:05	Y	Y	\N	\N	421	15	0	0	0	0
530	Car	11	Car for sale	5	2016-10-06	2016-09-06 16:44:12	2016-09-06 16:37:45	Y	Y	\N	\N	194	15	0	0	0	0
528	Car	1	Djdjcn	50	2016-10-06	2016-09-06 16:18:06	2016-09-06 16:11:37	Y	Y	\N	\N	194	15	0	0	0	0
529	Car	1	Djdjcn	50	2016-10-06	2016-09-06 16:18:06	2016-09-06 16:11:40	Y	Y	\N	\N	194	15	0	0	0	0
527	Car	1	S	5	2016-10-06	2016-09-06 16:17:26	2016-09-06 16:10:56	Y	Y	\N	\N	194	15	0	0	0	0
526	Car	1	S	5	2016-09-06	2016-09-06 16:17:17	2016-09-06 16:10:49	Y	Y	\N	\N	194	15	0	0	0	0
499	Charcoal grey overall romper	22	Size small, I would recommend for someone taller as I'm 5'4 and it doesn't fit my torso as well as it could. It has pockets (!!!) and it's a romper so it has shorts. The straps button in the front where regular overalls would. It's low cut on the sides (gotta show off those cute bralettes and crop tops ;)	8.00	2016-09-26	2016-08-28 17:31:30	2016-09-11 23:07:57	N	Y	\N	\N	842	15	1	0	0	0
532	Free People Affogato Hacci Top	22	medium but runs big.  still has tags. retail for $68.00	10.00	2016-10-05	2016-09-06 20:56:35	2016-09-06 21:22:47	N	Y	\N	\N	910	15	1	0	0	0
534	T	2	F	50	2016-10-07	2016-09-07 01:33:01	2016-09-07 01:26:32	Y	Y	\N	\N	194	15	0	0	0	0
535	hole	14	gole	500	2016-09-14	2016-09-07 01:35:26	2016-09-07 01:35:26	Y	Y	\N	\N	0	15	0	0	0	0
536	test	2	test	500	2016-09-14	2016-09-07 01:38:29	2016-09-07 01:38:29	Y	Y	\N	\N	0	15	0	0	0	0
537	Golden Retiever	6	Poorly trained, very cute	0	2016-09-06	2016-09-07 01:57:31	2016-09-07 01:51:01	Y	Y	\N	\N	194	15	3	0	0	0
520	Chem 1211 Textbook	1	New, perfect condition with unused MindTap code	125	2016-10-15	2016-09-03 15:27:58	2016-09-15 12:03:47	Y	Y	\N	\N	869	15	3	0	0	0
521	Chem 1211L Textbook	1	New, perfect condition. Unused.	25	2016-10-15	2016-09-03 15:27:58	2016-09-15 12:03:22	Y	Y	\N	\N	869	15	3	0	0	0
531	Free People Affogato Hacci Top	22	medium but runs big. color is called Moon Shadow but looks greyish.  tags still on.  retail is $68.00	10.00	2016-10-05	2016-09-06 20:52:56	2016-09-06 20:46:29	N	Y	\N	\N	910	15	1	0	0	0
498	Size 0-2 cutoff jean shorts 	22	Stretchy material (good for people who like to eat big burritos but also look cute). I wear a 0-2 in pants usually and they fit me great! When I wore them I folded the legs up once because I tend to like a shorter short. 	3.00	2016-09-26	2016-08-28 17:24:31	2016-09-11 23:08:27	N	Y	\N	\N	842	15	1	0	0	0
522	iPhone Charger	5	iPhone Charger for iPhone 5, 6, or 6 Plus! $15 or best offer!	15	2016-10-03	2016-09-06 03:20:49	2016-09-07 17:05:15	N	Y	\N	\N	421	15	1	0	0	0
482	New Wall Mirror	3	Brand new wall mirror, 19.5 inches x 23.5 inches. sorry pic is so blurry!	15	2016-09-19	2016-08-20 23:54:41	2016-08-28 19:33:04	N	Y	\N	\N	801	15	1	0	0	0
508	Apple wireless mouse	17	Never been used wireless apple mouse	50.00	2016-09-12	2016-09-02 15:21:35	2016-09-02 15:20:09	Y	Y	\N	\N	868	15	3	0	0	0
533	Lucky Brand Sienna Slim Ripped Boyfriend Jeans	22	size 8/29.  still has tags.	15.00	2016-10-05	2016-09-06 21:03:56	2016-09-06 21:23:25	N	Y	\N	\N	910	15	1	0	0	0
548	Test book 2	1	Test	123	2016-10-07	2016-09-07 15:07:29	2016-09-07 15:01:22	Y	Y	\N	\N	194	15	0	0	0	0
549	Shoes	22	Vhhh	50	2016-10-07	2016-09-07 15:13:59	2016-09-07 15:07:30	Y	Y	\N	\N	194	15	0	0	0	0
435	Durango Rebel Boots	18	Basically new boots, worn maybe 3 times and only a couple small scuffs. Size 9EE, I am usually a 10 but these fit great. $130 new. very comfortable!	50.00	2016-09-07	2016-08-09 23:54:21	2016-08-09 23:48:46	N	Y	\N	\N	338	15	1	0	0	0
572	Introducing Psychology 	1	Used loose-leaf PSYCH 1101 textbook, has highlighted vocab words but in very good condition. 	35.00	2016-10-18	2016-09-19 15:54:09	2016-09-19 15:52:38	Y	Y	\N	\N	1000	15	3	0	0	0
560	Sony Sound Bar	14	LIKE NEW. \nEverything works perfectly and in good condition!\nEverything Included!	120.00	2016-10-12	2016-09-13 00:47:04	2016-09-13 00:40:23	N	Y	\N	\N	946	18	1	0	0	0
563	Music Midtown Ticket	7	I'm selling a 2 day pass bracelet that has not been tightened at all. It hasn't been registered yet. I'd like to get what I paid for it. The only ones left online are $135.	125	2016-09-17	2016-09-14 04:01:48	2016-09-14 03:55:16	Y	Y	\N	\N	964	15	3	0	0	0
524	Looking for student ID 	16	Looking for a student ID for the game this weekend against Nicholls State. Looking for a brown haired, brown eyed female id, willing to pay!	.	2016-09-10	2016-09-06 16:10:45	2016-09-06 16:04:17	Y	Y	\N	\N	421	15	1	0	0	0
550	Falcons Tickets For Sale	7	Selling 2 tickets for the Atlanta Falcons vs. Tampa Bay Buccaneers for this Sunday the 11th. Seats are on the Falcons Side, about the 15 yard line, and close to the field. Section 119, Row 7, message me if interested!	130	2016-09-10	2016-09-07 17:11:02	2016-09-07 17:04:38	Y	Y	\N	\N	421	15	1	0	0	0
559	GT  Avalanche	17	Solid mountain bike. Good for trails and commuting.	300	2016-09-16	2016-09-12 15:10:40	2016-09-12 15:04:00	N	Y	\N	\N	796	15	1	0	0	0
565	Brand new GMAT 2017 Study book	1	I think I opened this book twice. It is literally brand new. Retail is like $46	20.00	2016-10-14	2016-09-15 00:28:16	2016-09-15 00:21:42	N	Y	\N	\N	9	15	1	0	0	0
579	UGA Tickets	16	Need 2 cheap TN tix.	100	2016-09-29	2016-09-21 12:50:04	2016-09-21 12:43:09	Y	Y	\N	\N	772	15	3	0	0	0
580	UGA Tickets	16	Need 2 cheap TN tix.	100	2016-09-29	2016-09-21 12:50:04	2016-09-21 12:43:12	Y	Y	\N	\N	772	15	3	0	0	0
489	General Manager	2	Southern Cotton Apparel is looking for an energetic, money hungry, self-motivated, business savvy student to run day to day operations of the company using the strategies given. Flexible hours and a great way to have additional income.	70	2016-09-24	2016-08-26 01:39:10	2016-08-26 01:33:09	Y	Y	\N	\N	772	15	3	0	0	0
566	Xbox One 500GB	5	Like New	185	2016-09-30	2016-09-16 21:29:09	2016-09-16 21:22:41	N	Y	\N	\N	988	15	1	0	0	0
551	Strapless Maxi dress size M	22	Size medium strapless maxi dress for sale. Only worn a few times in perfect condition	10.00	2016-10-09	2016-09-09 02:27:58	2016-09-09 02:21:25	N	Y	\N	\N	194	15	1	0	0	0
552	Womens teal blouse 	22	Size small, very unique and cute teal blouse . Only worn once!	10.00	2016-10-09	2016-09-09 02:29:41	2016-09-09 02:23:10	N	Y	\N	\N	194	15	1	0	0	0
553	Maxi dress for sale!	22	Size small only worn a few times. No stains, tears, etc and in super cute and comfy!	10.00	2016-10-09	2016-09-09 02:30:42	2016-09-09 02:24:09	N	Y	\N	\N	194	15	1	0	0	0
554	Womens purple komono	22	This purple komono cardigan is lightweight, in great condition, and easy to match to make a cute outfit! 	10.00	2016-10-09	2016-09-09 02:32:47	2016-09-09 02:26:15	N	Y	\N	\N	194	15	1	0	0	0
555	Womens columbia ADPi shirt	22	Womens columbia PFG baby blue button down shirt with ADPi logo on it. Size small. No stains, tears, etc in great condition! 	10.00	2016-10-09	2016-09-09 02:33:56	2016-09-09 02:27:23	N	Y	\N	\N	194	15	1	0	0	0
556	Womens Fringe top	22	Size medium cute fringe hombre top with teal top and cream/white bottom of shirt. Only worn once!	10.00	2016-10-09	2016-09-09 02:35:37	2016-09-09 02:29:04	N	Y	\N	\N	194	15	1	0	0	0
557	Super cute mint romper!	22	Size small in perfect condition! 	15.00	2016-10-09	2016-09-09 02:37:10	2016-09-09 02:30:37	N	Y	\N	\N	194	15	1	0	0	0
558	Comfy Hoodie for game days! 	22	Medium	5	2016-10-09	2016-09-09 21:10:09	2016-09-09 21:03:39	N	Y	\N	\N	925	15	1	0	0	0
562	Trash Can (never used)	3	Saves you $40.00 for a quality can! \nNormal sized trash can. Perfect for a kitchen! (Will post my own pics soon. Shown is the exact model in perfect condition).\n-Trashcans are surprisingly pricy!! Just like EVERYTHING you realize you need when moving in. This is high quality & definitely worth the investment for a good can. 	50.00	2016-10-11	2016-09-13 21:15:25	2016-09-13 21:14:01	N	Y	\N	\N	862	15	1	0	0	0
564	Free GMAT study book	1	This is in perfect condition it is just a few years old. I bought the 2017 and quickly realized I wasted my money. It's the exact same.....	0.00	2016-10-15	2016-09-15 00:25:33	2016-09-15 00:19:02	N	Y	\N	\N	9	15	1	0	0	0
568	Awesome framed painting	3	Lifes a beach! In perfect condition	20.00	2016-10-18	2016-09-18 17:41:34	2016-09-18 17:34:46	N	Y	\N	\N	194	15	1	0	0	0
569	7" dual screen mobile dvd system	5	Perfect for road trips! The box has been opened but theyve never been used. It comes with two screens, one of which includes the dvd slot. 	20.00	2016-10-18	2016-09-18 17:46:46	2016-09-18 17:40:00	Y	Y	\N	\N	194	15	1	0	0	0
571	3 inch foam mattress pad	3	It's a xl twin size pad. Used it my freshman year and don't need it anymore. Definitely makes the dorm beds more comfortable. Doesn't get too hot either.	30	2016-10-18	2016-09-18 18:44:49	2016-09-18 18:37:59	N	Y	\N	\N	990	15	1	0	0	0
573	North face down jacket 700 weight	22	Light blue size small women's North Face down jacket. In good condition overall but several marks visible on front and one sleeve. Very warm and cosy if winter ever arrives!	30.00	2016-10-18	2016-09-19 17:07:43	2016-09-19 17:00:56	N	Y	\N	\N	978	15	1	0	0	0
574	Black Armani Exchange jacket	22	Black size small women's zip up jacket. Very good condition. 	10.00	2016-10-18	2016-09-19 17:09:39	2016-09-19 17:02:45	N	Y	\N	\N	978	15	1	0	0	0
575	Unworn - Clarkes un.signal size 9.5US/41EU shoes	22	Brand new unworn Clarkes women's shoes. Bought online, got the wrong size. Very comfortable soft sole, ideal for waitressing or other jobs where you have to be on your feet. 	30.00	2016-10-18	2016-09-19 17:13:39	2016-09-19 17:06:48	N	Y	\N	\N	978	15	1	0	0	0
576	iPhone 6S - 64GB	16	Looking for a 64GB iPhone 6s in either silver or space gray.	350	2016-10-20	2016-09-20 23:07:22	2016-09-20 22:59:23	N	Y	\N	\N	347	15	1	0	0	0
577	Bar Stools	3	All three bar stools for $40! 	40	2016-10-20	2016-09-20 23:09:35	2016-09-20 23:02:42	N	Y	\N	\N	925	15	1	0	0	0
570	Funny singing bass wall mount	17	Big mouth billy bass! Billy has been with me all through college but its time to pass him on! Works perfectly. Sings multiple songs	10.00	2016-10-18	2016-09-18 17:52:15	2016-09-18 17:45:28	Y	Y	\N	\N	194	15	1	0	0	0
581	Dogs	8	D	000	2016-09-21	2016-09-21 23:54:56	2016-09-21 23:47:56	Y	Y	\N	\N	194	15	0	0	0	0
582	HP Pavilion p6740f	5	\nHP Pavilion p6740f - Magnesium Gray Edition - Phenom II X4 955 3.2 GHz - 8 GB - 1.5 TB\n\n\n\nBrand: HP\nModel: Pavilion p6740f\nMPN: BV525AA#ABA\nProcessor Type: AMD Phenom II X4\nProcessor Speed: 3.2 GHz\nMemory: 8 GB\nHard Drive Capacity: 1.5 TB\nType: PC Desktop\nOperating System: Microsoft Windows 7 Home Premium 64-bit	300.00	2016-10-22	2016-09-22 15:14:15	2016-09-22 15:07:23	N	Y	\N	\N	998	15	1	0	0	0
597	test	3	rest \ndhdhf	10	2016-09-28	2016-09-28 12:48:08	2016-09-28 14:09:03	Y	Y	\N	\N	194	15	3	0	0	0
578	UGA Tickets	16	Need 2 cheap TN tix.	100	2016-09-29	2016-09-21 12:50:04	2016-09-21 12:43:06	N	Y	\N	\N	772	15	1	0	0	0
601	#beta	6	#beta\n	5	2016-09-30	2016-09-30 15:23:57	2016-09-30 15:16:42	Y	Y	\N	\N	1065	15	0	0	0	0
567	Beats Solo2 Wireless	5	Brand new in wrapping Beats Solo2 Wireless. They're the Active Collection in Siren Red. Came with a computer I bought but didn't need them. If this ad is up they're still available	170	2016-09-30	2016-09-17 18:57:29	2016-09-17 18:50:41	N	Y	\N	\N	778	15	1	0	0	0
592	Sweepstakes	7	#DeltaSig	8	2016-10-10	2016-09-23 15:38:22	2016-09-23 15:31:20	N	Y	\N	\N	1044	18	1	0	0	0
602	Niykee Heaton Sold Out Georgia Theatre Ticket 10/6	7	Get a cheap ticket to this one of a lifetime sold out show	15.00	2016-10-06	2016-10-03 13:05:03	2016-10-03 12:57:43	Y	Y	\N	\N	460	15	0	0	0	0
561	BISSELL PowerTrak Upright Vacuum	14	5 settings: High carpet - bare floor. \nVery light and easy to store. \nBrand new- never used. \nGets the job done quick with its high power wattage! \nMarket sale price= $125.00 	80.00	2016-10-12	2016-09-13 17:59:52	2016-09-13 17:58:12	N	Y	\N	\N	862	15	1	0	0	0
600	Nintendo 3DS XL	5	There's a few small scratches on this but otherwise it's like brand new. I hardly ever played it. I'll also include all the games I have (including Animal Crossing New Leaf and Super Smash Bros).	220	2016-10-30	2016-09-30 03:56:30	2016-09-30 03:49:26	Y	Y	\N	\N	992	15	0	0	0	0
593	Brand new Jabra Move Wireless headphones	5	Got this pair of wireless headphones a few weeks ago with the purchase of a new phone. They are brand new/never been opened.	90	2016-10-17	2016-09-24 12:52:44	2016-09-24 12:45:52	N	Y	\N	\N	1021	15	1	0	0	0
583	Georgia hat	18	New never worn before. #phidelt	10.00	2016-10-21	2016-09-22 19:43:39	2016-09-22 19:36:38	N	Y	\N	\N	979	15	1	0	0	0
584	Guinness hat	18	New Guinness hat with bottle opener. #phidelt	10.00	2016-10-21	2016-09-22 19:45:59	2016-09-22 19:38:58	N	Y	\N	\N	979	15	1	0	0	0
585	Vintage Master's rope hat	18	Used green Master's hat. #phidelt	10.00	2016-10-21	2016-09-22 19:47:59	2016-09-22 19:40:59	N	Y	\N	\N	979	15	1	0	0	0
586	UGA hat	18	Classic Red Georgia hat. #phidelt	10.00	2016-10-21	2016-09-22 19:50:42	2016-09-22 19:43:41	N	Y	\N	\N	979	15	1	0	0	0
587	New Cowboy hat	18	Straw cowboy hat. #phidelt	5.00	2016-10-21	2016-09-22 19:53:08	2016-09-22 19:46:07	N	Y	\N	\N	979	15	1	0	0	0
588	Nike Athletic hat	18	Used Nike Nylon athletic hat. #phidelt	8.00	2016-10-21	2016-09-22 19:54:36	2016-09-22 19:47:35	N	Y	\N	\N	979	15	1	0	0	0
589	Phillips Portable Speaker	5	Refurbished Portable Speakers for sale! Amazing Quality, Bluetooth/Aux Capabilities #DeltaSig	12.00	2016-10-21	2016-09-23 14:50:13	2016-09-23 14:55:22	N	Y	\N	\N	958	18	1	0	0	0
590	Vape mod black fuchai 200w variable box mod	17	Mod Fuchai-200w with temperature control, steam engine  stentorian tank with capacity of 6ml and battery charger (mod includes batteries)\n\nLess than a month of use \n#Deltasig	85.00	2016-10-23	2016-09-23 15:11:40	2016-09-23 15:04:38	N	Y	\N	\N	935	18	1	0	0	0
591	Electric guitar gig bag 	17	New. Used to transport a guitar when it was purchased\n\n#Deltasig	8.00	2016-10-23	2016-09-23 15:17:11	2016-09-23 15:10:12	N	Y	\N	\N	935	18	1	0	0	0
594	Need a futon	3	Need a futon	70	2016-10-25	2016-09-25 18:21:24	2016-09-25 18:16:41	N	Y	\N	\N	1049	15	1	0	0	0
595	Need futon	3	Need futon	80	2016-10-25	2016-09-25 18:24:49	2016-09-25 18:17:46	N	Y	\N	\N	1049	15	1	0	0	0
598	Fitbit Alta (black, small), accessory band (blue, small), extra charger	5	Brand new, never opened fitbit alta with an accessory band and an extra charger (about $170 value altogether) *reduced price	90	2016-10-25	2016-09-28 19:48:51	2016-10-14 20:38:50	N	Y	\N	\N	1062	15	1	0	0	0
596	Pool Table with Cues and pool balls included	11	Used Brunswick pool table #beta	500	2016-10-27	2016-09-27 15:20:44	2016-09-27 15:13:39	N	Y	\N	\N	432	15	1	0	0	0
599	Mens LG Polo Ralph Lauren Button Down	18	Mint condition, worn once. \n\n#ATO\n	20.00	2016-10-28	2016-09-29 20:11:27	2016-09-30 08:46:22	N	Y	\N	\N	329	15	1	0	0	0
613	Chem 1211 Textbook	1	New, unused with MindTap code	125.00	2016-12-01	2016-10-16 21:18:54	2016-11-01 17:43:31	N	Y	\N	\N	869	15	0	0	0	0
606	Large standing wall mirror	3	5ft wood grain standing mirror! Looks great in the corner of a room!	25.00	2016-11-04	2016-10-05 23:35:14	2016-10-05 23:27:48	N	Y	\N	\N	194	15	1	0	0	0
618	Beats by Dr. Dre Studio Headphones	5	I've had these headphones for 5 years. They are just a little beat up but still sound great. Does not come with the wire needed to plug into the headphones. 	70	2016-11-25	2016-10-26 14:45:17	2016-10-26 14:37:16	N	Y	\N	\N	621	15	1	0	0	0
605	Beats Solo Headphones	5	Work perfectly! Hardly used	60.00	2016-11-04	2016-10-05 23:33:37	2016-10-05 23:26:14	N	Y	\N	\N	194	15	1	0	0	0
607	Cute Teal blouse 	22	Only worn once. Size medium. Perfect condition!	10.00	2016-11-07	2016-10-08 13:13:44	2016-10-08 13:06:14	N	Y	\N	\N	414	18	1	0	0	0
608	BRAND NEW chipper jones jersey!	18	Majestic size large chipper jones jersey. In perfect condition, never worn with tags on it 	30.00	2016-11-07	2016-10-08 13:16:12	2016-10-08 13:08:42	N	Y	\N	\N	414	18	1	0	0	0
609	Sublease Spring/Summer 2017	8	Going to DC in the spring so I need to sublet my bedroom in this 3 BR/ 3.5 BA condo. The bedroom is on the second floor with its own bathroom. Furniture not included other than standard appliances. Unit has both a theater room and a fireplace. Located off of Riverbend Parkway.	483	2016-11-10	2016-10-12 00:12:06	2016-10-12 00:04:29	N	Y	\N	\N	1104	15	1	0	0	0
604	BRAND NEW chipper jones jersey	18	Majestic size 44 (large) chipper jones jersey. Still has the tags on it	30.00	2016-11-04	2016-10-05 23:31:08	2016-10-05 23:23:43	Y	Y	\N	\N	194	15	1	0	0	0
611	Fitbit charge hr	5	Like new, works perfectly!	75.00	2016-11-11	2016-10-12 13:27:09	2016-10-12 13:19:30	N	Y	\N	\N	414	18	1	0	0	0
612	Plastic dog crate	17	Height: 26 in. Width: 19 in. Length: 35 in. \nSuitable for dog up to 90 lbs\nIn excellent condition 	25.00	2016-11-11	2016-10-12 14:24:58	2016-10-12 14:17:22	N	Y	\N	\N	1105	15	1	0	0	0
615	Shirts for sale	18	A friend and I are selling these tshirts! They come in light grey and white and are available in sizes Small through Extra Large	15	2016-11-20	2016-10-21 14:11:45	2016-10-21 14:03:50	N	Y	\N	\N	421	15	1	0	0	0
610	Fitbit charge hr	5	Like new, works perfect! 	75.00	2016-11-11	2016-10-12 13:25:41	2016-10-12 13:18:06	Y	Y	\N	\N	194	15	1	0	0	0
619	Dell Monitor	5	19" Dell monitor	50	2016-11-28	2016-10-30 02:27:53	2016-10-30 02:20:10	N	Y	\N	\N	1096	15	1	0	0	0
614	Chem 1211 L book	1	New, unused	25.00	2016-12-01	2016-10-16 21:20:11	2016-11-01 17:42:53	N	Y	\N	\N	869	15	0	0	0	0
622	Mac	5	Mac book air	600	2016-12-10	2016-11-10 16:30:57	2016-11-10 16:22:25	Y	Y	\N	\N	194	15	0	0	0	0
623	Sunglasses  	18	These puppies have been all over the world. Great glasses!	100	2016-11-13	2016-11-12 04:04:41	2016-11-12 03:57:00	Y	Y	\N	\N	9	15	3	0	0	0
650	Michael Jordan Tune Squad jersey XXL	18	In great shape hmu!	20.00	2016-12-23	2016-11-23 05:08:32	2016-11-23 04:59:57	N	Y	\N	\N	194	15	0	0	0	0
626	Tv	5	Tv for sale\nA\nA\nA\nA\nA	50.00	2016-12-16	2016-11-16 03:34:18	2016-11-16 03:25:37	Y	Y	\N	\N	194	15	0	0	0	0
627	Racquetball set	11	Two racquets and a sleeve of balls.	30	2016-12-17	2016-11-17 11:39:27	2016-11-17 11:30:53	N	Y	\N	\N	9	15	0	0	0	0
628	Beats wireless headphones	5	These headphones are in perfect condition!	250	2016-12-17	2016-11-17 11:47:06	2016-11-17 11:38:31	N	Y	\N	\N	9	15	0	0	0	0
629	GMAT study book	1	Perfect condition!	20	2016-12-17	2016-11-17 11:57:02	2016-11-17 11:48:18	N	Y	\N	\N	9	15	0	0	0	0
630	GMAT 2014 	1	This is in great shape, it's just a few years old.	5	2016-12-17	2016-11-17 11:58:13	2016-11-17 11:49:29	N	Y	\N	\N	9	15	0	0	0	0
631	Not ready to leave Athens?	1	This book can help!\n\nPerfect condition.	10	2016-12-17	2016-11-17 12:00:46	2016-11-17 11:52:03	N	Y	\N	\N	9	15	0	0	0	0
632	25 lbs weights	11	Not inflatables. These are actually 25lbs 	10	2016-12-17	2016-11-17 12:15:19	2016-11-17 12:06:35	N	Y	\N	\N	9	15	0	0	0	0
633	YETI cooler 45	11	This is in good shape, but not new. It's been used a couple times.	300	2016-12-17	2016-11-17 12:18:04	2016-11-17 12:09:27	N	Y	\N	\N	9	15	0	0	0	0
625	400 lb Max scale	14	weigh scale for people	12	2016-11-19	2016-11-14 21:22:37	2016-11-14 21:13:54	N	Y	\N	\N	861	15	1	0	0	0
621	Invest with the Fed	1	This is a great read on investing and Fed policy!	20	2016-11-20	2016-11-08 17:12:17	2016-11-12 04:00:10	N	Y	\N	\N	9	15	1	0	0	0
634	Black futon for sale! EXCELLENT condition	3	Black futon for sale! Works great, very comfortable with no stains, tears, or damages. In very good condition i just dont have room in my new place. Message me for more details!	50.00	2016-12-17	2016-11-17 15:36:45	2016-11-17 15:28:01	Y	Y	\N	\N	194	15	3	0	0	0
635	Nike backpack for sale	17	In great shape!	10.00	2016-12-21	2016-11-21 01:22:30	2016-11-21 01:13:43	N	Y	\N	\N	194	15	0	0	0	0
636	Jansport backpack for sale	17	Cant beat a $5 price tag!	5.00	2016-12-21	2016-11-21 01:23:24	2016-11-21 01:14:34	N	Y	\N	\N	194	15	0	0	0	0
637	Funny singing bass wall mount	3	Big mouth billy bass! Billy has been with me all through college but its time to pass him on! Works perfectly. Sings multiple songs	10.00	2016-12-21	2016-11-21 01:27:40	2016-11-21 01:18:50	N	Y	\N	\N	194	15	0	0	0	0
638	Ticket from final game at Turner Field	17	This is a collectors item! It came with Dirt from Turner Field as well. If you're a Braves fan this is a great addition to your Braves memorabilia	25.00	2016-12-21	2016-11-21 01:31:01	2016-11-21 01:22:13	N	Y	\N	\N	194	15	0	0	0	0
603	Ticket from final game at Tuner Field	7	This is a collectors item! It came with Dirt from Turner Field as well. If you're a Braves fan this is a great addition to your Braves memorabilia	25.00	2016-11-04	2016-10-05 23:28:40	2016-10-05 23:21:14	Y	Y	\N	\N	194	15	1	0	0	0
639	7" dual screen mobile dvd system	5	Perfect for road trips! The box has been opened but theyve never been used. It comes with two screens, one of which includes the dvd slot. 	20.00	2016-12-21	2016-11-21 01:33:07	2016-11-21 01:24:31	N	Y	\N	\N	194	15	0	0	0	0
640	BRAND NEW Chipper Jones Jersey	18	Majestic size 44 (large) chipper jones jersey. Still has the tags on it	25.00	2016-12-21	2016-11-21 01:38:06	2016-11-21 01:29:18	N	Y	\N	\N	194	15	0	0	0	0
624	Bookshelf	3	Leaning bookshelf for self. Set of 2!	50.00	2016-12-12	2016-11-12 04:09:19	2016-11-12 04:00:44	Y	Y	\N	\N	194	15	0	0	0	0
641	beats	5	beats	50.00	2016-11-30	2016-11-21 19:30:48	2016-11-21 19:21:54	Y	Y	\N	\N	194	15	3	0	0	0
642	fan	8	fan	5.00	2016-11-30	2016-11-21 19:32:30	2016-11-21 19:23:36	Y	Y	\N	\N	194	15	3	0	0	0
643	h	3	g	5.0	2016-11-22	2016-11-21 19:46:24	2016-11-21 19:37:30	Y	Y	\N	\N	194	15	3	0	0	0
644	PFG frat dawg shorts	18	Columbia Sportswear Company. Frat dawgs only. 	15	2016-12-23	2016-11-23 03:55:09	2016-11-23 03:46:21	N	Y	\N	\N	9	15	0	0	0	0
645	Logitech wireless keyboard 	5	Great shape, hardly ever been used.	45	2016-12-23	2016-11-23 03:58:48	2016-11-23 03:50:00	N	Y	\N	\N	9	15	0	0	0	0
646	Perfect college wall art	3	This is perfect for your wall	10	2016-12-23	2016-11-23 04:02:07	2016-11-23 03:53:28	N	Y	\N	\N	9	15	0	0	0	0
647	Costas - Fathom	18	Not sure the next time I'll make it to the ocean so selling these bad boys. \nGlass lenses, good shape!	125	2016-12-23	2016-11-23 04:12:18	2016-11-23 04:03:30	N	Y	\N	\N	9	15	0	0	0	0
648	Make Par Not War trucker hat	18	Brand new golf trucker hat. Hmu!	20.00	2016-12-23	2016-11-23 04:38:07	2016-11-23 04:30:04	N	Y	\N	\N	194	15	0	0	0	0
649	Chicago Blackhawks Jersey XL	18	In great condition! Size XL Patrick Kane jersey	20.00	2016-12-23	2016-11-23 05:06:49	2016-11-23 04:57:56	N	Y	\N	\N	194	15	0	0	0	0
651	TI 84 Plus Silver 	5	Do people still use these? \nThis one has been lightly used.	50	2016-12-23	2016-11-23 13:07:31	2016-11-23 12:58:47	N	Y	\N	\N	9	15	0	0	0	0
652	Complete bocce ball set	11	Complete bocce ball set with 8 balls (4 colors), the smaller ball, along with the bag to hold the set in. Hmu!	20.00	2016-12-27	2016-11-27 23:10:00	2016-11-27 23:00:55	N	Y	\N	\N	194	15	0	0	0	0
620	Womens Fila Fleece Jacket	22	Brand new! Size XL	20	2016-11-28	2016-10-30 02:30:04	2016-10-30 02:23:13	N	Y	\N	\N	1096	15	1	0	0	0
\.


--
-- Name: post_management_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('post_management_int_glcode_seq', 652, true);


--
-- Data for Name: tbl_class; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY tbl_class (int_glcode, class_name) FROM stdin;
1	Freshman
2	Sophmore
3	Junior
4	Senior
5	Grad Student
6	Alumni
7	Faculty
0	Select
\.


--
-- Name: tbl_class_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('tbl_class_int_glcode_seq', 1, false);


--
-- Data for Name: university_leads; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY university_leads (int_glcode, var_name, var_email, dt_createdate, chr_delete, chr_publish, fk_user_id, var_username) FROM stdin;
2	Uga	Pete.whittingslow@salesloft.com	2015-11-30 11:13:47	Y	Y	\N	\N
6	Carson Newman University	Sbarnett@cn.edu	2015-12-04 05:19:19	Y	Y	\N	\N
3	Oglethorpe University	kbetterson@oglethorpe.edu	2015-12-03 09:05:13	Y	Y	\N	\N
4	University of North Carolina at Chapel Hill	memurray@live.unc.edu	2015-12-03 09:08:50	Y	Y	\N	\N
5	College of Charleston	Christasandlin@outlook.com	2015-12-04 03:51:31	Y	Y	\N	\N
7	Lawson state	rcottrell6169@students.lawsonstate.edu	2015-12-11 11:40:51	N	Y	\N	\N
8	Abraham Baldwin Agricultural College	Bcasey1@stallions.abac.edu	2015-12-18 12:40:38	N	Y	\N	\N
9	Georgia Perimeter College 	scottazi@student.gpc.edu	2016-01-28 06:00:57	N	Y	\N	\N
1	University of Louisville 	tsowsl01@louisville.edu	2016-03-17 01:17:10	N	Y	\N	\N
10	Abilene Christian University	srm13a@acu.edu	2016-06-19 04:28:57	N	Y	\N	\N
11	Nau	Fozcan@na.edu	2016-06-26 05:38:34	N	Y	\N	\N
12	University of North Georgia	Emlupi9076@ung.edu	2016-08-07 05:37:37	N	Y	\N	\N
13	Ivy tech	Choffman55@ivytech.edu	2016-08-11 02:53:36	N	Y	\N	\N
14	University of Miami	muratkasli@miami.edu	2016-08-12 10:35:52	N	Y	\N	\N
15	samastipur	rajmukeshkumar207@gmail.com	2016-08-13 17:10:15	N	Y	\N	\N
16	samastipur	rajmukeshkumar207@gmail.com	2016-08-13 17:14:03	N	Y	\N	\N
17	University of North Georgia	keber6390@ung.edu	2016-08-22 10:23:14	N	Y	\N	\N
18	University of Ga 	aem91807@uga.edu	2016-09-14 01:20:51	N	Y	\N	\N
19	University of Notre Dame	Jbrolly@nd.edu	2016-09-28 09:49:21	N	Y	\N	\N
20	University of Notre dame	jbrolly@nd.edu	2016-10-03 08:17:02	N	Y	\N	\N
21	dhaka	jahir229@gmail.com	2016-11-06 06:45:13	N	Y	\N	\N
22	University of Gmail	ramviswa23@gmail.com	2016-11-18 11:58:22	N	Y	\N	\N
\.


--
-- Name: university_leads_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('university_leads_int_glcode_seq', 22, true);


--
-- Data for Name: university_management; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY university_management (int_glcode, var_name, var_domain, var_image, dt_modifydate, chr_delete, chr_publish, var_ipaddress, var_adminuser, dt_createdate, fk_user_id) FROM stdin;
24	Columbus State University	columbusstate.edu	csu144251036755faf61f2a29b.jpg	2015-09-17 17:19:43	N	Y	76.240.21.99	Administrator	2015-09-17 17:19:27	\N
17	Georgia Institute of Technology	gatech.edu	Georgia_Tech_Outline_Interlocking_logo_svg144250831955faee1fcbe41.png	2015-12-04 00:04:07	N	Y	198.143.57.1	Administrator	2015-09-17 16:45:20	\N
38	Georgia Gwinnett College	ggc.edu	861544614491905005660e464e2c02.jpg	2015-12-04 00:55:01	N	Y	198.143.57.1	Administrator	2015-12-04 00:55:01	\N
1	Princeton University	princeton.edu	Princeton-University1441286103.png	2015-09-08 00:00:00	Y	Y	50.151.166.11	Administrator	2015-09-03 11:43:08	\N
14	Valdosta State University	valdosta.edu	Valdosta-State144246217255fa39dc2b1ff.jpg	2015-09-17 03:56:12	N	Y	76.240.21.99	Administrator	2015-09-17 03:56:12	\N
15	University of Georgia	uga.edu	University_of_Georgia144246224955fa3a2963aac.jpg	2015-09-17 03:57:29	N	Y	76.240.21.99	Administrator	2015-09-17 03:57:29	\N
4	Columbia University	columbia.edu	Columbia-University1441286222.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:17:02	\N
11	Dartmouth College	dartmouth.edu	Dartmouth-College144128638455e848f031dce.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:19:44	\N
8	Duke University	duke.edu	Duke-University1441286297.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:18:17	\N
2	Harvard University	harvard.edu	Harvard-University1441286175.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:16:15	\N
12	Johns Hopkins University	jhu.edu	Johns-Hopkins-University144128671755e84a3d5876f.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:25:17	\N
18	Kennesaw State University	students.kennesaw.edu	Kennesaw_State_Wordmark144250906555faf109b6128.jpg	2015-09-17 16:57:45	N	Y	76.240.21.99	Administrator	2015-09-17 16:57:45	\N
10	California Institute of Technology	caltech.edu	California-Institute-of-Technology144128635555e848d32c67a.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:19:15	\N
7	Massachusetts Institute of Technology	mit.edu	Massachusetts-Institute-of-Technology1441286278.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:17:58	\N
13	Northwestern University	northwestern.edu	Northwestern-University144128674655e84a5a69afc.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:25:46	\N
5	Stanford University	stanford.edu	Stanford-University1441286242.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:17:22	\N
6	University of Chicago	uchicago.edu	University-of-Chicago1441286260.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:17:40	\N
3	Yale University	yale.edu	Yale-University1441286195.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:16:35	\N
19	Georgia Southern University	georgiasouthern.edu	ga-southern144250933955faf21be6d4b.jpg	2015-09-17 17:02:20	N	Y	76.240.21.99	Administrator	2015-09-17 17:02:20	\N
20	Mercer University	mercer.edu	MercerBears144250942155faf26d055f8.png	2015-09-17 17:03:41	N	Y	76.240.21.99	Administrator	2015-09-17 17:03:41	\N
21	Georgia State University	student.gsu.edu	Georgia_State_Panthers_Logo_svg144250958155faf30d97d22.png	2015-09-17 17:06:21	N	Y	76.240.21.99	Administrator	2015-09-17 17:06:21	\N
9	University of Pennsylvania	upenn.edu	University-of-Pennsylvania1441286319.png	2015-09-17 00:00:00	Y	Y	76.240.21.99	Administrator	2015-09-03 13:18:39	\N
22	Emory University	emory.edu	emory144251003955faf4d765028.gif	2015-09-17 17:13:59	N	Y	76.240.21.99	Administrator	2015-09-17 17:13:59	\N
23	Georgia College & State University	bobcats.gcsu.edu	gcsu144251018655faf56a603fa.jpg	2015-09-17 17:17:09	N	Y	76.240.21.99	Administrator	2015-09-17 17:16:26	\N
25	gdsgsdfg	fdsa.d	Koala1446901264563df61081324.jpg	2015-11-07 00:00:00	Y	Y	182.70.29.243	Administrator	2015-11-07 13:00:30	\N
26	Auburn University	tigermail.auburn.edu	Auburn_Tigers31448972726565d91b6d1385.jpg	2015-12-01 12:25:27	N	Y	198.143.47.1	Administrator	2015-12-01 12:25:27	\N
27	University of Alabama	crimson.ua.edu	69f10c093307c76e451daac907672ede1448972811565d920bd13b2.jpg	2015-12-01 12:26:52	N	Y	198.143.47.1	Administrator	2015-12-01 12:26:52	\N
28	Florida State University	my.fsu.edu	FSU_Seminoles.svg1448973084565d931c15742.png	2015-12-01 12:31:25	N	Y	198.143.47.1	Administrator	2015-12-01 12:31:25	\N
29	University of West Georgia	westga.edu	19361_CREASEY-REV_M21_img_501448973375565d943f9f213.jpg	2015-12-01 12:36:16	N	Y	198.143.47.1	Administrator	2015-12-01 12:36:16	\N
30	University of Alabama at Birminghan	uab.edu	1280px-UAB_Blazers_Logo.svg1449009296565e20905eb56.png	2015-12-01 22:34:58	N	Y	198.143.47.1	Administrator	2015-12-01 22:34:58	\N
31	University of Florida	ufl.edu	Mascot-Monday-Florida-Gators-University-of-Florida-Logo-610x4571449009695565e221f8f028.jpg	2015-12-01 22:41:36	N	Y	198.143.47.1	Administrator	2015-12-01 22:41:36	\N
32	University of Tennessee	vols.utk.edu	us_tnvols21449009749565e2255d35a2.gif	2015-12-01 22:42:29	N	Y	198.143.47.1	Administrator	2015-12-01 22:42:29	\N
33	Troy University	troy.edu	03-11-15+troy+trojans+logo1449009906565e22f259c52.jpg	2015-12-01 22:45:06	N	Y	198.143.47.1	Administrator	2015-12-01 22:45:06	\N
35	University of Central Florida	knights.ucf.edu	University_of_Central_Florida_UCF_vertical_text_logo.svg1449010719565e261f1a589.png	2015-12-01 22:58:40	N	Y	198.143.47.1	Administrator	2015-12-01 22:58:40	\N
37	Oklahoma University	ou.edu	Oklahoma_Sooners14491877485660d9a4f3b91.jpg	2015-12-04 13:09:50	N	Y	198.143.47.1	Administrator	2015-12-04 00:09:10	\N
36	Oklahoma University	ou.edu	Oklahoma_Sooners14491877355660d997c2982.jpg	2015-12-04 00:00:00	Y	Y	198.143.47.1	Administrator	2015-12-04 00:08:56	\N
41	University of North Carolina	live.unc.edu	unc-chapel-hill-logo14492467055661bff1d3aaa.jpg	2015-12-04 16:31:46	N	Y	198.143.47.1	Administrator	2015-12-04 16:31:46	\N
44	University of South Carolina	email.sc.edu	SouthCarolina_Logo114492523165661d5dc2da58.jpg	2015-12-04 18:05:16	N	Y	198.143.47.1	Administrator	2015-12-04 18:05:16	\N
46	Louisiana State University	lsu.edu	lsu-logo14492526375661d71dc5038.jpg	2015-12-04 18:10:39	N	Y	198.143.47.1	Administrator	2015-12-04 18:10:39	\N
45	East Tennessee State University	goldmail.etsu.edu	iphone-elogo14492524155661d63f5e244.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 18:06:55	\N
34	Jacksonville State University	stu.jsu.edu	28c5e22fd39d7b6d724fbb5fd262f5801449010206565e241eecf6d.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-01 22:50:07	\N
39	Appalachian State University	appstate.edu	appalachian_state_university_logo-214491944545660f3d66a0e0.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 02:00:55	\N
48	University of South Carolina Upstate	email.uscupstate.edu	uscupstatelogo14492619255661fb653b89a.png	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 20:45:25	\N
43	University of Tulsa	utulsa.edu	gmINoqIa14492520535661d4d54c2e4.jpeg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 18:00:53	\N
42	Oklahoma State University	okstate.edu	2000px-Oklahoma_State_University_Logo.svg14492519895661d49565cc7.png	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 17:59:51	\N
52	University of Arkansas	uark.edu	Arkansas-Razorback-Logo11449275464566230480f43c.png	2015-12-05 00:31:04	N	Y	198.143.57.1	Administrator	2015-12-05 00:31:04	\N
40	University of North Carolina	live.unc.edu	unc-chapel-hill-logo14492467025661bfeea48d7.jpg	2015-12-08 00:00:00	Y	Y	198.143.47.33	Administrator	2015-12-04 16:31:42	\N
55	Texas A&M University	tamu.edu	logowhitemaroon1449599687566722c73e794.jpg	2015-12-08 18:34:47	N	Y	198.143.47.1	Administrator	2015-12-08 18:34:47	\N
47	University of Mississippi	go.olemiss.edu	ole-miss-colreb114492539625661dc4aaf7c9.jpg	2015-12-09 18:18:32	N	Y	198.143.47.1	Administrator	2015-12-04 18:32:43	\N
58	Duke University	duke.edu	download1450379699567309b347daa.png	2015-12-17 19:14:59	N	Y	198.143.47.1	Administrator	2015-12-17 19:14:59	\N
16	ThriftSkool University	gmail.com	1144249908355faca0b9ce94.PNG	2015-09-17 17:25:33	N	N	76.240.21.99	Administrator	2015-09-17 14:11:23	\N
54	Carson Newman University	cn.edu	300x3001449329911566304f79796a.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-05 15:38:31	\N
57	Savannah College of Art and Design	student.scad.edu	2e93a2b1177d9afd03c64ec2edb39e511449683122566868b2b13bf.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-09 17:45:22	\N
49	University of South Carolina Aiken	email.usca.edu	USCAPrimaryRedLogoA14492620135661fbbde90c9.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 20:46:54	\N
56	University of Kansas	ku.edu	University_of_Kansas_Jayhawk_logo.svg1449600531566726137a711.png	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-08 18:48:51	\N
53	Oglethorpe University	oglethorpe.edu	33c611ec4e269c1f5e45e81573849c4b144932974556630451a4e9f.gif	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-05 15:35:45	\N
50	St Edwards University	stedwards.edu	xtra_set7144926592756620b07b5ea8.jpg	2016-03-24 00:00:00	Y	Y	50.20.4.10	Administrator	2015-12-04 21:52:07	\N
51	University of Texas	utexas.edu	Texas_Longhorns144927537556622fefb3ecc.jpg	2015-12-05 00:29:36	N	N	198.143.57.1	Administrator	2015-12-05 00:29:36	\N
\.


--
-- Name: university_management_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('university_management_int_glcode_seq', 1, false);


--
-- Data for Name: user_devices; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY user_devices (int_glcode, fk_user, device_id, gcm_code, dt_createdate) FROM stdin;
70	207	7a802de6441a51059624183cf33f8769a0882d620ae4175c67bf58afeecdf80d	\N	2016-01-19 16:25:33
2	28	fd4dc2e219e7870034f9c2153b24e25fc9d977fc258b8f2b30cfcc69d4da03bc	\N	2015-11-06 06:04:45
3	32	1478169d94002919dd7211beba8759d9270b44bb286fbbb1676da0187cf78da1	\N	2015-11-06 15:04:49
4	35	dc081ae230db7451b9eb6176e6449843aeff140547b8b8f544333475a2d47cd2	\N	2015-11-06 15:25:10
5	38	833a94522e6871af02cef8f93411a6abbfe871dc29360edcf11ec924cb34a527	\N	2015-11-06 18:59:17
7	40	38492759251e11c0cba9c93d9bb626be568ebbf766a4e3314c79a44a89913a3b	\N	2015-11-06 20:35:45
8	41	73c68d3b72c596dd725a0eb9f930a412ba647d6b58c203598624f062cd42c6f0	\N	2015-11-06 23:13:12
10	42	66925d6159999461eb321b7bf3f0d79cc671b9678ede38162d9517814eb52f6c	\N	2015-11-06 23:22:56
11	43	0c7f1bfe4357e6e0dec947fd5559d01eb1629c496e63fa3d90d34204c968b091	\N	2015-11-06 23:37:57
12	44	ce4417ba451951902085b0f44c34d7d750a75b840e9e9ec4a804ecd515865aba	\N	2015-11-07 00:18:05
14	45	0b900cc4a2e41a24222d408f075cd58f22f20993fb489fc51985bc3443e230e2	\N	2015-11-07 04:29:15
15	47	08dd8165dcb70221d62a934c0e411419064886912cd41fef863e2691e33e4b72	\N	2015-11-07 21:01:15
16	49	fe1d0e99876d5a6420929258d824aab8bef98ccfce8655e9dcb7e7fd8d512c5c	\N	2015-11-08 20:37:10
17	50	9667daa7e6a2fed4b40df5ed88a52beb3f761bab975a4d1a4961f5b050a7f495	\N	2015-11-08 20:38:57
18	51	c369d878dce3ed47f4e76a34eeb3909436caf4589713318c6e301b75d7f6b575	\N	2015-11-08 20:40:36
19	53	7a6ad0ab1e3f253efa1380d62d2f921bde4fec4a554bc963382494ed5e6a8108	\N	2015-11-08 22:46:42
20	56	381c0fdc553d91b3558a9b54355408091ebf6f11421821f2daab7357a17f1d85	\N	2015-11-09 21:31:27
21	57	23287da9ba58390e6f35fb083c41ac5b76ae1f7bf07d3b2354c323bd60cf7085	\N	2015-11-09 22:11:03
22	58	fdb5c3250e4cdd93c684a26f0853696580ac8a6570259d1ce62564d144e5e472	\N	2015-11-10 00:28:20
23	60	0dba684e8344b763c21be28696ee1fe73e112b7bb6376a4955e81ab182d93703	\N	2015-11-10 19:35:01
24	66	4858ee413afc5cdd55022317ffa9ef6d31ab023e715a475eefeca8155adc527d	\N	2015-12-02 15:32:22
25	69	4ed3e2da5b568a5f7394551b17dba9af8eddbaa47401661bfd5046efe5241337	\N	2015-12-03 00:31:33
26	71	d76c04f987dfbb8e1e082699278883918881ce84f19b23000ba196f7a69a9a37	\N	2015-12-04 04:00:07
27	77	0c3d728cd8a9e2dc93eeba9b7c160651c446afdacb998dfc6125c17dc1e879b1	\N	2015-12-04 16:52:49
28	79	6e3a11c2611ca7852af453bd45f3456596816cd8868db1d4c2716cab5c46be36	\N	2015-12-04 17:05:24
29	82	ca448ff479c945aa503b40f32b3ad8a778fd5447d96840ca8f4a85f900f7c5e6	\N	2015-12-04 18:11:15
30	84	b0293ecccf5a7a78746c7c10606dd0bc43dac69ea1f55cf287654a4537c91194	\N	2015-12-04 19:14:18
31	86	7661bd1346b1ccfe720b2e468a64d9c91053d6044f58243909d30a0d1947c63c	\N	2015-12-04 19:16:45
32	88	cb4891ad21a53d7215cba35b9b273802d831a28bc214d5db6f2938c834e1f5f0	\N	2015-12-04 19:19:04
33	99	84de6f957331fa227adadaa9727fa37010b9ea148686cbda83bf57e9623901a5	\N	2015-12-05 12:47:59
34	101	4b15122ab5d3f8b6c6e0e0a1387eaea93f9bcaa5881e6d0ead80d45b0b5127e4	\N	2015-12-05 15:29:04
35	102	559fc43a149436befa6cb7a3d8d77a7b24fb64bfcbf267e14ce096e9b944984d	\N	2015-12-05 17:52:54
36	103	7f61a1ffc7d89576e92c86c8ff6fa946cafe39b48cca2a0d3503af1d59973a84	\N	2015-12-05 20:42:11
37	106	a710f167433e185c79ea6529b95634c57914d72b9fd2e80d93947f0c378de2ea	\N	2015-12-06 01:58:08
38	107	0bb46f98ec1978a69b561cbba9861ba143fe1036c5aa4936fb85455e0e8eb78f	\N	2015-12-06 02:43:26
39	108	b441db283ac99d2abd197f38ce108fd0171b1d85c72d88c448dc080d01b99591	\N	2015-12-06 02:58:42
40	109	ca0c13b4450225b5f472f113ba6f837b3658ce83137775d2d84ca3a0a2f76ced	\N	2015-12-06 04:15:34
41	115	f87987c73313e9abc6aa714da42aaa2e69c118239bee11f230022a68c3a4f758	\N	2015-12-07 02:25:43
42	117	8c64eceaf4afdc66fd3dc50e67954e8505e07ab1a513555ea64f865540f55493	\N	2015-12-07 21:28:44
43	118	63001a15c4790eab27b52ef1ded3268090eef05157e8a8be1288d59eb493eb4b	\N	2015-12-07 22:50:40
44	121	6cabff14cd1b1707697b58ccfc91627b3e90a7f19795054fd2f24cb7df3b9f9c	\N	2015-12-08 02:55:10
45	125	072c257b0c0fabf580f57e704150734b2b8bc88658e3dcecf8cdc4354c066a5a	\N	2015-12-08 17:59:16
46	127	8c8c9ac34f2d8e50f17ea06695301c78d5337980a01725e99a9b4be6edf1d1d9	\N	2015-12-08 19:39:11
47	131	b7f687a2c18015465ffe79efc5f288acfd82916fe6a047bc68016ec118877364	\N	2015-12-09 12:28:23
48	133	57a547c0c7a67f7b90f1ddbbc916718c236b108763aeac3a02c59857c38e4f5f	\N	2015-12-09 12:57:52
49	134	0414b5721cf061bc61ab1c886bda27e4c75502296c40bde07bbeeb152081811a	\N	2015-12-09 13:01:13
50	135	0767dbe515e037796b0076ae53a24debf6ba1ab629ad6525419dcf0225be1174	\N	2015-12-09 15:08:48
51	137	404df605deb236de3aae6691361c6a390e0199031b51fea24f71cbc5226cc178	\N	2015-12-09 15:34:29
52	142	15d0f25098c43ab7ee9a42093a3c1eb8e7b23df2196aef11f6ef99db25ae7c04	\N	2015-12-09 15:50:17
53	146	018abedaa89e7e3ec275e22f942cec9898da91f3e8c8e5031330e9da99cd5e1b	\N	2015-12-09 21:24:24
54	148	e75a21f709774467e4f34b81160e3a6cd655e5312b4ff3e4ddeccc65a509f3e0	\N	2015-12-09 23:42:08
55	149	0edfb372e10955beb929726adfe234bf4942c5a2b9b1190608bf04f6fe1864b7	\N	2015-12-10 00:01:54
57	150	069fbc6142f433f4010ac2cc1df94405390eb9beac222bf3ece3403de48a59dc	\N	2015-12-10 00:29:13
58	154	b320d71abd04a13d8146f0f99586caacf12d73a7ca17224cdf2f4dc6e9fb1c98	\N	2015-12-10 02:41:21
60	163	86d420b833fb73d4127a74f1ad5429e611d73eaf925096ff157f1a15b2231227	\N	2015-12-10 22:04:20
61	165	cfff21d807c51ca10dd7db7f91c84550dbcbe945be236100a22f7046d65fd76b	\N	2015-12-11 02:24:49
62	170	ec0fb9a355ab746fb95463e5e1596b56e802afa61f4101e1a849bf3a086f97fe	\N	2015-12-14 02:13:59
63	171	5192153b2d335ee21cd48e5a40a774749a84959c39d345df7dd3d34c2ee21baf	\N	2015-12-15 03:57:49
64	173	47c7619646061d0ebb7d67aa8a72f8988a5e29f815e3a71a0398a1e9e09e1b26	\N	2015-12-15 18:35:11
72	211	3d2676ad33390c31f4cad1eba0046aac9e1c5625f38b2b3c035583d92b25339e	\N	2016-01-21 03:06:57
73	9	55	\N	2016-01-21 04:36:34
56	194	b815d378249785f0b0c61f1746108e3a89d2aa5dc52c527886730265f63641c3	\N	2016-01-18 04:49:33
75	194	ba77e0f72f26e299cfdc904e5fd0592da762dd99a6ff29ec4da6df2f35ce5d15	\N	2016-01-21 05:08:45
81	183	0ab9b1b5bb6f2645df1a0cd8e05613015c3e7ede506dcb36e14b82b86154fd1b	\N	2016-01-25 05:03:12
79	215	5451f99a9e3d5b30170151bdd5b70b920c80527dd0244f9720a19744ffce3866	\N	2016-01-24 18:32:45
83	219	a75d3dd672513a90b36b88d10fcf995856cde38cc49522fc608b60a3555837de	\N	2016-01-28 16:21:08
65	181	5e99d6df273c944264be4338f8ec00a75a10e8a4466b24932ac330405044090d	\N	2015-12-22 10:52:07
77	9	b46fa22e6aa06e18f69ca4aa6f9644f31b9f16bb113e11dcbc85cb261e024547	\N	2016-01-21 10:52:36
66	190	7e5d24b08bed97cf39f16dff5ef769a99f461d18043e7f5a459f539ecef6453c	\N	2016-01-05 01:59:59
67	191	38b79106840e1a92e23ed50d0569dd17f17d75e357bc5505199bc7c8d24493cc	\N	2016-01-05 02:01:18
69	198	5b3485069945f7d1c1cecc05ce1418f31bccfd04bc7a2c228fd63e412eb8899d	\N	2016-01-09 21:41:09
76	194	079f3859ce172b1f399ba8bec3c88be80f218ead8075c4f086b6dd5a1e8696fd	\N	2016-01-21 08:58:29
80	216	04943bd84c54fb892c4a180245f3d7dc4928b3cde417ef54164fcb61515f2dc2	\N	2016-01-24 23:11:50
82	183	0705a49765a9786b747a3cb3626bd99b690dfadff133b5f056fce5ecadc2f176	\N	2016-01-25 05:12:42
84	220	8a219c3c65c1fb8b509a090ba37876be9d10a2c2c3a0976f97f2d4233e68d151	\N	2016-01-28 23:01:31
85	223	6beb1cb82bb8dd714fb75a6be9d011848389a22f8ff98a02a71a1b1bf01df603	\N	2016-01-31 01:54:58
105	354	5616b29cae98db1c9bdbc3f3344d8ce145467af7854c35afd2af66b14848baf0	\N	2016-02-16 20:03:11
117	379	3079e51c5d9a8f7972a2920724097a506f5d9292ab85caacf0b1094630e7d3f2	\N	2016-02-22 13:38:49
106	356	b3c6914f4ad965b26d555d4318f4ef18b5cd786611b7065dd25ab2679bbafd0e	\N	2016-02-16 20:11:36
1	180	92b41196bd51fcff0025013307e5e6fd32db61f63c90b10a1f06345bdb196de2	\N	2016-02-01 13:38:24
107	359	e82aea546ceffd8d5187f1a1164e01ffcfca0f8fb9afbbb9c61bc61986a3b331	\N	2016-02-16 20:33:59
88	320	ccda1096e85b9862b643e1463623e9680759c9e5a0c9a0070027ced41b4d5dc1	\N	2016-02-13 03:56:12
89	321	d3f0fb72403999f40e1e630273462fa3ad475feb50230f8c6c234ee174890058	\N	2016-02-13 04:47:41
90	322	f52709414e6c60a13207098044eb89bba98e7acc2cac61d3d40c021e1208469c	\N	2016-02-13 16:51:43
132	407	1beb0ffa101545c8cc3130c44a3e7603222f61d8f40342978ce6b079226005e3	\N	2016-03-15 23:00:47
91	326	a0ade88a9196ba5b1299acb54375040c8ea4a1c558edeb9936406ce35be868fc	\N	2016-02-13 18:54:27
92	328	532b902e7da7985f7e7d8625143e2eb253ebc2a200b7427bb564454e55617550	\N	2016-02-13 18:57:21
119	381	d962db6933099b0f9a4a3242d57468d6942268646cf6e91063531d52a4926c48	\N	2016-02-22 21:27:01
118	380	d8229877a0b03f351758cdca3863d3200b28ae5a3300fcd51f9d0fe77df1ffbe	\N	2016-02-22 20:37:20
71	9	bb40aec8540df68429fa1ce0ffd7b56ecb94c02fc93b8dd482ec71e3e821c547	\N	2016-01-20 02:30:59
93	331	238a433a9f6f8ddafca1b87713210f7d8558efa68c35fe606eeb802cb00e6d09	\N	2016-02-13 23:34:15
121	180	6ce7a20263c413f5ad8240ee71cae965d357eba1e9ca5e1a8367a3553d59833b	\N	2016-02-24 07:10:23
94	333	659aa22bf5fb607271c3e6f692c7874e0091b93334b5c444845b393112071fc7	\N	2016-02-14 12:22:19
95	334	99faf1943fc0e5a04c3bdf4ec228a9175932677d2b8cee04b5570f9cb4a20622	\N	2016-02-14 20:12:43
6	26	e458fe93d4658fee19f49f4eae52b6d6fd3a4787e011908455f4b2580fd28776	\N	2016-02-09 13:05:05
97	336	7397430379c1da060b9715ff5b1e3629aba5bb6f49f0f8f989c4a6c7e5d39717	\N	2016-02-14 21:21:11
108	367	bc0f0edc7e1ec166e966e4849db0ab0c894f09c65c6c8e712ddabe681fa347a7	\N	2016-02-17 00:52:01
96	335	30fb915020aab4a536bd9a1759624ba7b9c70bea7992dbba2c49a1a4334d8042	\N	2016-02-14 21:20:33
98	337	e020796ec9b7d39138e32179357257494f6bf3e27e2f585a03e71055a56e1bdb	\N	2016-02-14 21:24:31
109	368	f87fdb24a22f542395ae6451b085a0ea24777e8b2199f8e73aa0a4ac1878e1d8	\N	2016-02-17 02:35:56
9	305	09bd7bd32e458724d2f7e475f7b2dfaacffaec8fc6a12be407c855bae5e3d3ea	\N	2016-02-10 18:32:13
100	340	e5e4ee9b13f9971ad133a2a40136ee5384564b9401c38fa4e0af02777203bf95	\N	2016-02-16 00:41:25
125	389	94796faca2c81d183a623c0f4ba729d9ec08f2f0b53d35f98e197895bf1f8fb9	\N	2016-02-29 22:53:33
110	370	b65e36ea3d0d6876005cf4a40277c5d417a4f32fe235fbfd0898b81b06890046	\N	2016-02-17 04:12:23
122	180	0667ea96b2acef3b4aaa37b35c069c5ff494a8253705b2271b8239887302ed58	\N	2016-02-24 13:03:09
99	341	186dd132ff747f5057da0bc59aa6f04c2d0140513bb5bb43e0dcb15b0599682c	\N	2016-02-16 00:41:25
86	9	9cec7775fc33ef535a2e4e1325e85546fa16b2f6508f4facd1b028ca61a24be3	\N	2016-02-11 16:35:00
128	400	d6756532d2d743541852c7867254cfb98146f7963f07f808d5aa7a2daf84e270	\N	2016-03-03 13:02:58
13	180	14448f8f041d2840005e988dc17c014e9c382563559f3b667f1d7c08077e23da	\N	2016-02-11 10:16:07
111	371	2075dd6e7f5198a20ad295c811d0cd24a4354c34c9131c2c6370bffa27a7a83f	\N	2016-02-18 17:02:28
101	347	e88870a72d2dc970fff843a89fcb9832668c72d531c06d4c2ab5cd146bca38e2	\N	2016-02-16 01:15:39
102	342	a00c1097d942e307464fcdcd4f1177c1f7b36b81c42e0c6147bebdb446b0136f	\N	2016-02-16 03:25:52
123	386	0405a5a9e769458f7147b1b65681ecc46454039633c85fb7dbae6c23ce633699	\N	2016-02-24 17:04:50
135	414	98570dd6d069f03ff34b9c6fc15817c09673019a87fc919a0baec96f892f95ba	\N	2016-03-18 15:54:27
103	350	95b0c9e85fc26a6131fa1d7b1281c9b0056f52d7faf9c861c575a7ad51971a28	\N	2016-02-16 06:34:25
129	401	47c4ac5978d51d2d4730c22c8472c7bf6bad19f58fa8cd188095e7323446f1ad	\N	2016-03-04 02:23:14
114	376	3b769dfe0cbec62a8f12b35ac20aa52d6b05219f49c6c00f67131402627153c1	\N	2016-02-20 19:50:03
104	352	b56cc018db7dffde6d95c2c8d07138872e7da0ed70007aa6d85fca86fcb69dd3	\N	2016-02-16 18:16:01
112	374	d121f197f2c0ae81e2c6d6a4556ca698422dc29b3bc3fa0c5b701b766ada6c6a	\N	2016-02-19 06:11:57
59	162	0c7c434f8b93e0f5434930d985527fed730cd27e4749a09a7684e5b98d5f6a20	\N	2015-12-10 21:57:34
115	377	fd65c4dd50b6c248d54fd0db2f49e589f21af8aea3017da011bc73733165d9de	\N	2016-02-20 19:53:57
87	181	9e89975664cfcb21957c5999eeb9dd3975af5f12ea9786796f87ca96a376f1f4	\N	2016-02-12 03:13:57
116	378	633dbc2a2ca6d30e5cb4a64950f05b41ae3d1196cc006298d55afed301dde5a2	\N	2016-02-21 21:38:38
134	409	7287f311e174dbdd4f7e8762b2455863e9b94cc016b21432919aab6d727a57bc	\N	2016-03-17 17:31:38
120	354	0aab641f1e9e45bbe6ca4c2212d2227559afd8d56ea0a31b2eb17cb58bc4d612	\N	2016-02-24 00:12:01
130	402	8bfaa73dc0ab8c0403d3c0fdb8294daf50d139c28210a8aa4e43518c1c80bb90	\N	2016-03-05 07:20:52
113	180	55269e61f578f2a6643669b52366f15c247a07113da174d0348e3a02a0e21c4f	\N	2016-02-19 07:00:09
124	387	6333c0b98824025656cf8e26e8eac3db3d74b296992dfe2066924b22495f45da	\N	2016-02-28 00:10:35
126	394	ff87e295ed2c332fbc03f0da0e0dc655a761c2cd479ba94e795279db138d2d0f	\N	2016-02-29 23:59:47
131	406	72c49f03f4a965b0d2e1d051509273c40778bb17c1960af601860c798a603491	\N	2016-03-12 03:54:32
127	9	508a20557ce5045e7b814174e0f7b9b12c5431a05d74d605f8786e909fed8215	\N	2016-03-02 12:46:07
133	194	1140c1940b09caa5c17f833d057b998f394d563b2af1a94a79667c4e715794c1	\N	2016-03-16 04:59:55
74	181	aa623b54616622c812c63956edb8d632d1674731548e48f3bee30967bd0b3662	\N	2016-01-21 04:59:58
68	194	6d916856433888a07198983c89ffa053ded8db0c9215718145e21ca9ab90f598	\N	2015-12-08 07:24:56
136	415	194047d6b6dbcec5298fee1f12ef9b35718e3908f81db7b2741694e8889fc922	\N	2016-03-18 16:27:55
137	419	d3065de156c0058959d52f9980091571b46907e798311ae64cbf4800dd51dd58	\N	2016-03-21 19:56:26
138	420	437ec60fcee363d9fe85fb85f5d1e9b7e21a9367626cc7e74fed7a5a189235ce	\N	2016-03-21 20:11:42
139	423	0638ade928e0a088ffdb787a55489ee6cc74df92d3d4be1546d28a20f1ae246d	\N	2016-03-21 21:08:13
163	464	15cdfcb4f6ccc4d0213c34e77aa66246e3af7aa81235cf3aa18343672050d045	\N	2016-04-11 05:46:05
164	9	7d502bb1a48bdc0f4fa50c03477384ed8a2d2e193feed662e1fe0044a4970bf7	\N	2016-04-11 14:22:18
195	527	fa611ee51fdef4716e2513a70bdc925ebf8b2bb88e60effdb0c58d0fd463b0a0	\N	2016-05-08 17:46:19
140	428	e5425c830cfd43628d1d91fc5d0e0131b8ccea4d3dd411891f1ddd4190459f46	\N	2016-03-22 01:26:05
141	429	140540fb76ea62037d67bb2b13695e41e561999766067019de92df4bf4d1e39e	\N	2016-03-22 05:24:55
196	181	acefd7e2ae9731654d55f4e73f04a4508f8515e0dab91311d9fc82ed114a0b4d	\N	2016-05-10 06:02:49
165	467	ee5d553cc7fe20ec844ffac20acffbf53d095a1671d5edf7407ddd0853c1243b	\N	2016-04-11 22:03:43
142	431	74733c64ad0d4f613dca22cc8dc0828f2d5249cc9cd833c35bce0f5331cd7b4c	\N	2016-03-22 16:27:47
166	468	0aa20df24ce1307da158bb1978fe730f9120a39d86234444391d3f5ef4c9db35	\N	2016-04-11 22:03:50
183	502	283e4afc0347e7ef0d99981b72f5be819282dd2d0ee99242a1beb5e4d798add5	\N	2016-04-19 04:07:54
167	472	77c63f7ff077317dbb0c0c3c49deb58c24e1a6b31137bb2169aa7d30d1287b57	\N	2016-04-11 22:08:03
168	473	e28094162576d0ec12d09239d0a6e65c0c50f05c829ee52973ab4509a462b871	\N	2016-04-11 22:20:30
143	437	05723af944699c1b904b0b5b8670eecbfcd9d016595283fde9d108e415fe4a81	\N	2016-03-23 21:01:47
144	438	1b47e79c9b454cb80071438dfc5b379da5c71bd32396cb35f9f145ecce36dc6f	\N	2016-03-24 00:19:19
169	474	e0147379030aac15baed0f694b7d433ca109fa3b7d07e6ecdf608d7b6b90298a	\N	2016-04-11 22:20:46
170	476	fd1e35922b24b0b6bb18951a58ffb95a690c89265bb66ce052b1c13df3b5c83d	\N	2016-04-11 22:23:19
145	9	886204eb831b022174e59003327c850c48fa3d8ff1b48bfdd85c2b0c71526770	\N	2016-03-28 14:07:50
146	442	ef05a64b594c9fa14067c8ef621a2a90529790c3b10ee5409c8fc99ec8af47af	\N	2016-03-28 22:19:34
184	503	d76257a5d754148ddff1aa36297bae38183693ba683df963e8d806e1bd945439	\N	2016-04-19 04:45:46
147	444	70dbe1824061b99f85dd9841865b23440ba017fe296abc9395cab2c2f8426083	\N	2016-03-29 13:33:34
148	445	177ffd0e1e12c620fe266187d3325594b70e03c67b49736a2cdd269ddb5b5dec	\N	2016-03-30 15:23:40
149	446	4296c91e8e2296d86a64f0da863db5ca0c5be9eff841ad3e9abd72867c331464	\N	2016-03-30 16:18:07
185	496	10633703dde42a9bbba6a147fb3b35e465e25c816a835d1f9b7c52b754895a67	\N	2016-04-21 08:47:12
150	181	cfe8447cfa707a6c62db900c0cd4f85336e60f2baf48d3614fc9742ad1f8780b	\N	2016-03-31 07:03:18
151	181	c6faa8132c9aa418a26ebbce771a3ab332f83ac03e2f819ff7e152d35b3f05f7	\N	2016-03-31 09:39:46
197	409	01c20745b7ae2e3001408cf9d621c0d9c4a2618e81e75ed34d12f67b06ea7ecd	\N	2016-05-13 18:14:41
152	448	9f8d61a02cc3f17d1e76946eb3489769f96409b4830539b44c817f35c3a2daba	\N	2016-03-31 18:10:18
198	531	09ddf57a31621e4fafbc7a95bf875ab9b66614036f5b5ee0f92f336430e27206	\N	2016-05-15 17:27:34
171	466	447083c862416e92937880c16233a3b7ab75df7455eefa0ccb1e41d9a3f0a2bd	\N	2016-04-12 04:07:26
202	543	057bcb1184a16398dcd24378f839b7f39968bdd66f1333233dd8550cc1f65f35	\N	2016-07-03 06:28:54
153	450	60e776b39aff9352801aa82e3c42e450f16bce2074693add073dcdda5865a9e3	\N	2016-03-31 22:38:07
172	482	fee27d62fe9d24d12e70d6d61e8fae406886ea4505af182a58a8c51a55c42383	\N	2016-04-12 17:51:43
173	483	a7c88260154740581f264b3cc7cc0750fac2e454653c627b6fc2511234b1bf00	\N	2016-04-12 18:53:15
174	484	ac19d91918ef8b2c2dc114a0056ede910514c05284134b16dd6b7be1be08aec3	\N	2016-04-12 19:47:07
175	487	e9a464d8b4a2a8a85f93ed14f9a6ecd97e52f6445ea8ff04b7930fe1e750794f	\N	2016-04-12 20:21:52
176	488	790ddeceb282c273bcaad08c32aa2081130c4d0366ee893953d0fd837c804c84	\N	2016-04-12 20:38:42
154	181	701125f41e31afc559ba1d376b1998f5b459674d20f3d20193571d46eb91fed7	\N	2016-04-02 11:44:49
155	181	bca2a902e4e2d2b3afcdeff8f4752b9024bd69417f08beaa21a5c58a7173e315	\N	2016-04-02 13:17:25
177	489	9ed6db31ca04e240ff06410e799b8f402510672770c7a7202fb5c62e0347a5c8	\N	2016-04-12 21:18:48
178	462	7667cc73790a8449b09ed461a66430984d14b48254fe3490d7363a98b262598c	\N	2016-04-13 04:45:20
179	490	66f33be2bee4d31a6f427750128ea96f1102b7f4d5e65972b6d952771387a08a	\N	2016-04-13 14:20:47
190	207	652a823d201e9e2c3eef44e9ddd3265e0d17b78101b8b1e799cfa1b3d1a3d396	\N	2016-05-02 18:49:23
156	9	5aeb4f1b64ab0c0cea9703c23cda2e4a110619a9a7014375a92c2e0b4ae0e9b7	\N	2016-04-05 23:53:51
199	532	a65a08af25928762c7d959809b033ca343bd7b7c424534aa61a4eb589ad76351	\N	2016-05-16 15:13:52
180	491	f47e89d93fa4fef0d072ca909aaef514ea6b4205a690a6592e8c781a4b06bca8	\N	2016-04-13 15:25:51
157	456	b881c76015f7f12f3470ca9d784ec39df2add76886eeb5e7e12fcd82fcd68707	\N	2016-04-06 00:24:09
158	457	735d851260fa63bc0872802ac0a01c03e30a3ccfc104b8aebb557c93bdc29b1f	\N	2016-04-06 00:37:49
159	458	0690dcdd546232a702b01a7ab3262fb8ab793e0f597768e7740ccfda1b7bcc9b	\N	2016-04-06 13:53:15
182	9	efd81c9c2d464815d4168495121e6926519c5a0320c6c9e97cb076f0e57c4155	\N	2016-04-15 19:10:37
187	512	9114b4fff4adc016ac2efd4bbfe4b8cce56e9dbd1a2da8a5676b7c1edd0e5a47	\N	2016-04-30 15:59:24
160	181	d12960844138aa5066c8c2992eedc6c743a786919e7b39c2cc79e36893f77606	\N	2016-04-08 10:33:26
161	459	37586ef6eb2bd12ad0aece0eef89c9b5313d8f4e41c7d1cc47997bb08be0b591	\N	2016-04-08 14:46:58
181	470	6c41cefeb3199b64d9592c03e8fe977d2d17d9df1892ca447648454f9f4f5d80	\N	2016-04-13 22:04:50
162	460	097c23bc4c8007d36a8aa3e560eafdb5e906a700811392ad4b8b11e696e20e54	\N	2016-04-09 01:57:08
191	522	46c7eb156b18b6643b66f933d5251c9625d5f7271dcc398c644da478176615a3	\N	2016-05-02 21:57:28
192	523	1f77229d793bbffc40ad3e769e33f59814df3471d66b3419524b0a7133b2e732	\N	2016-05-02 23:59:35
193	524	57a99f9602c4df5f0d39b490dfb4289a2506f4ad3b34c59ab4b8283afdbaaf45	\N	2016-05-04 11:43:40
188	516	20b8948b5df23207928fc06510a588b02f2ec541c498a9963ac4cd7752829e3e	\N	2016-04-30 18:41:49
189	517	60b302ceab3e00c319fef67ffba38b523bfcd5b79fe59ccdb3fc62c1454e25ff	\N	2016-04-30 18:44:25
194	525	9d10cac127978ceaf8bd8822e5b3d9c70924f41b4c958af9a0542e46feed3733	\N	2016-05-05 17:46:40
201	9	27df0d7b348909f13aa6896cdd0f3f45942419dda98303de2c47842422de8122	\N	2016-05-21 02:49:39
186	182	ebb60f58675b3b7405c516a776898904fd31f829f96434f066bbbc0a9cafa119	\N	2016-04-28 11:04:17
200	530	50de6f62652e1cd5434f381c15c83942df3dedcbba952476b190a80e68f5d01c	\N	2016-05-17 12:00:29
203	547	10398ef5d4583eea077864fcfcff4fe614fa359b5a0fadbb74c2871b66cd5bfa	\N	2016-07-10 21:31:36
204	548	86e2b2bf082dde66aad185671eaa61228f0d6afa0cb454f93f636af2fd263945	\N	2016-07-11 02:35:16
205	9	1ede94a70934dce9e6d12bec6bbf77384e9b46c5600b6d01cd9001dd2f8f6363	\N	2016-07-30 19:28:41
206	9	a29c2dbe71ff16814f7392beea55cde37923862f54fbc268500610a1bfce7c48	\N	2016-08-01 02:05:15
78	1144	015ca64ec97df6b005d0c0ee6ce3275424a09a832d02e0481b48083e777504da	\N	2016-01-23 22:11:15
207	554	61b961342b5df3042404b2065652b38c80d98593d043d326d3eb90a0413eb999	\N	2016-08-11 23:55:23
208	556	19d7c677f1fab5f3088acb108f8ae9b143518df77295eebc94e0bfd263d23d6b	\N	2016-08-12 00:02:11
209	559	b7c7e2e22eb2f113bf58e8d4b20c3719c4ba179bea0838063e29c89404944e14	\N	2016-08-12 00:06:01
210	560	95dde09a928309c2497c3e63af0dd8d3bfefae2f028dc10e923c7c2b83efaf1d	\N	2016-08-12 00:07:40
211	561	3465d414d0989cd62a18e3b01ae9cfd46a2b62c366a0a9391a62c3566b35d699	\N	2016-08-12 00:10:47
212	563	452b31c02e0e16d1a6e408622ac0a01fdc34427a498f398d30c32a8920b03be1	\N	2016-08-12 00:12:25
213	565	d5131db84c02db88b9513e8f9acc78b21739d1482d46fee1bf1ea989a9c0e4ee	\N	2016-08-12 00:16:53
214	566	a05b5af1c7ed2cbe9d26d665f4f2eed5371e8a6dae28ea031b7a5a9d08c58570	\N	2016-08-12 00:24:36
215	568	d76ceda68320640815a16dd459b516335241c0029183caa6229b22b81672d12f	\N	2016-08-12 00:25:07
216	572	f125f28f26bef399d8393d8f5e8c4b9d0c52ee368f9af96c0c52913a1c60642b	\N	2016-08-12 00:30:02
217	573	cfbfb7df4af6cfcc7eaf94b7a023f702570dc9b3a9c72e6ba1ef3da3d42eddcc	\N	2016-08-12 00:30:56
218	575	e15ef856516deac30fcbd796a72eafafa5af71e959bb52fa64049add48a15d91	\N	2016-08-12 00:35:51
219	576	cc9eb81b42fee6976f6092bf3c035b1958fa32b25b21b74516d897b4477c2e57	\N	2016-08-12 00:36:53
220	577	0b6c49b5c293156873936c7a1f1e612109c2fd3806bab449097b5966fd54d11a	\N	2016-08-12 00:39:44
221	579	e4b85add9d6ab6e3263acb403db73a6448925a282ba96a75b610af69aeb86d66	\N	2016-08-12 00:43:59
223	582	56eb85975c9f2de3559995cd458e87358c398d7ff637b6524d81570100569c48	\N	2016-08-12 00:45:59
224	585	6904b24273f8521d99f1302caa679b4c7692dba80f4730467f5a2eba931ba6db	\N	2016-08-12 00:51:10
225	586	8b291454476c9b13ea519e120fbafde2527a97d3ab6023e9adc059d36af5e9dc	\N	2016-08-12 01:11:20
227	592	b930fff368b913379d1ecd2c114ecbd1670fce9860766b4e6d3ca472a0ea96c0	\N	2016-08-12 01:13:26
226	591	b7257f1b5c9859f50b6e3eed506ff57e5fe3b431e706376438cb46403cc14db2	\N	2016-08-12 01:11:35
228	593	5738c1a1ad4d5a6866eefba0db0dfb4fe107d9b445975bc104a56ce6622ed865	\N	2016-08-12 01:14:14
229	597	dbddd1f6232817906bba9b3e5aa5c83a81ff5c7c2b8605e259be5f44ea7dd48e	\N	2016-08-12 01:25:58
230	604	31313323b9d57bf1b99b4b09e6b68d59262533adafe972685e99746dc52d11b7	\N	2016-08-12 01:43:34
264	683	3cf276e6478344141d3801cbcd8c545902465770abb4d9d69f78f5928452e556	\N	2016-08-13 05:26:09
231	607	1c2b7b73851140877fc8e33c660612324cfde31c6ec003fe12e41b92558f400d	\N	2016-08-12 02:07:34
232	608	dd9c0217ebfb945163bbda6b0834734b1e85b4cf3a0ea7c995e2de325e789544	\N	2016-08-12 02:10:32
233	609	5e42bb78043e3764137f19837e1adada3ceeb7e458f4dba3fd7d69b3003adf20	\N	2016-08-12 02:14:00
234	610	52977c349371a9ea6c5e9f7436d63b83a833e600771a66e3469d4d9a4f75aeb1	\N	2016-08-12 02:19:18
235	613	2c5aac3cd334650111e99101694fc6a104fd28de832a46355802b7fe81360b5b	\N	2016-08-12 02:34:06
236	618	cbdd832b68c65f9354f6b1ba5f6ea5f77beb81f14add5afe9a83d02b395ee49f	\N	2016-08-12 03:23:12
237	619	8895d11ff7945ff77f2b51f3d6d8dac9c5e66adb905811827444b376bd87a8c3	\N	2016-08-12 03:51:43
239	622	f60fd3bb986f422ad3d356f2394aed22c519215b8ccab938c5276b1d4e1dc2d1	\N	2016-08-12 04:04:50
222	583	5db28ff32bec39aa8a27d1d1b0d92e4a588c6408ff8b83cec8b474644f2ad503	\N	2016-08-12 00:45:49
240	626	e4e45500df223b95f4c5664a3431d4309d36e42888c2f7b88e19816142c942b4	\N	2016-08-12 04:32:21
241	627	c8a26e27626489495fb7a478afa2da903fd172c8fb28dabde6a0cbb5d4ea262e	\N	2016-08-12 04:45:38
242	629	6257ac138336adc90b7a3857ae5335237357ead2d370a12d0090805a57a54752	\N	2016-08-12 05:48:28
243	633	9fa915af8c8e8a0cb90597cd19b6125f4d6e504cefbf521a32884b5af47754ea	\N	2016-08-12 11:07:29
244	634	d1941cb2a61a64a70b0c0a03dc0173e103d217425b2a30451b4ee31f436c9ee0	\N	2016-08-12 11:27:36
245	635	6945668e3c3fc97e45408958dbe241ca35ce46fc5badd17ebff2076c9d54527c	\N	2016-08-12 11:28:55
246	640	ca572c914c8832b0809b2ed4440f4227eb39ba94cec0e8c7309a45d85544c6f3	\N	2016-08-12 12:48:08
255	660	4b3400ce1a16946b2d24b56a1cf93ae9c97e02da4239735560162957082d2581	\N	2016-08-12 15:13:39
247	641	ec8582692df44db892f0e4969b44af65427eedcaf195acf8cb2a6e4734dacc02	\N	2016-08-12 12:53:51
248	642	d602ad44afe1c479df3e9c3790b12c3863af0cf98d2046935c2e04574b94226e	\N	2016-08-12 12:59:56
249	644	3b2900d3d75eb0fec841a8fb9096543d4f5f3b642a80db42669550f88ca3cf68	\N	2016-08-12 13:21:58
250	645	98d658430bad91cdd341f5f4a54c222324bd575934f2a460e3ca11d4d9c453ef	\N	2016-08-12 13:23:10
251	652	39f66235319b47474af43f2647bb4b80a13061ebce974851dff72c61b2032a02	\N	2016-08-12 13:47:09
252	653	69bccd91128d3000ce95391f63e529a51c35220f5a7cf5c1ccbc0b4fe162e72a	\N	2016-08-12 13:55:03
253	656	2f036d4bde15c83a95eb361743a80cb82fc22f9e71e52d5419006fee967528d5	\N	2016-08-12 14:19:12
254	657	3d98537f7436b93a6c5549cd7167b1d2e24d74c2417f53f0c7f07f98401e5b16	\N	2016-08-12 14:33:18
256	663	dcb137cbc731de4acf81aa7e3eec177af71d1ebba21d6d11a3959e2e706f769b	\N	2016-08-12 16:09:44
257	664	724146e809b0cead2d791eb055549423bcb3577da1e7736f9a147fd35b30691f	\N	2016-08-12 16:41:30
258	667	c37026f968892971a7426e9e0146a65d1ac7b6e48162b9e8cba249a400a4a4ad	\N	2016-08-12 19:09:45
259	672	6813e97632b36ecf24259cfc2e506b0b82024061113c435e6c46a96482119712	\N	2016-08-12 19:58:55
260	679	95b682aae25efc080371bbe949caacf2f7e9df4ad8651140a5197f40d0209b21	\N	2016-08-12 23:27:50
261	680	c80320a39c06dcdae82a0f6038f8ee69a3e098a5d6f1dc050d969d1d3290bf80	\N	2016-08-13 01:51:31
262	681	4ad736bcd673320ef2ba71f4908787739a084b92a502c04b75e5f8bf885a38bc	\N	2016-08-13 04:00:30
263	682	6b4a64192425fe1f580b8eeeaabcc2ae69f82cb3c4ad879fd48811aa777e6d6c	\N	2016-08-13 04:01:30
265	685	faf45fb6cfbb5f5bf0dbe04122eed7db09efbfef2f3e72ea4a5f49af43ea6714	\N	2016-08-13 14:34:49
266	689	1f5cb4cf64b1831d9c86c67ac27116a0d101460042b27742006b54b2b2fad754	\N	2016-08-13 18:28:24
267	421	14404dce66488b9ab8eb8fdaef196647770d1759fb70cd3fafe11f4c1b8f477d	\N	2016-08-13 21:20:53
268	691	80d316cfb2552f523c4f29722429d47510598a5717150ad80993265ac237f744	\N	2016-08-14 00:10:16
269	696	f16e42bdc73a3ba32a0c80a6f84aa62e30bda165799ce897700bc86a3c2c8f5b	\N	2016-08-14 15:30:37
270	699	8fc633193c32c7e22a3831f6d63140b4ea5f31c3a94bdeb2a85a0bf089c3ead9	\N	2016-08-14 19:27:53
271	701	fd432b47440727cabaffd114f62d27d49af78b863c57afa762f8b5ac0477bcd6	\N	2016-08-14 21:33:27
272	703	a6c298ca20f7fa07e9de50a45f797d869e5703e3b67df3a32b2ba97a7ce49cbb	\N	2016-08-15 00:52:23
273	705	94ebbb6385ba00dbd7015d565640bac777c082ac1e17ca90e9d39284bd976695	\N	2016-08-15 03:06:56
274	708	bde397e4e1f0369eef298c6cccc1e7eeb9bfb1076a4f1e1437c7c432aa528113	\N	2016-08-15 15:00:14
275	709	46dade4ba75f825b394868d1f6bb36bc5647fc1fc8d5600308e95cd90e87b8ad	\N	2016-08-16 01:39:05
276	710	be03c1e196573b9c03f9a7426e747362de57f61054f509c634e5b3bc937e7a3b	\N	2016-08-16 17:09:35
277	711	e50dfb8818fcd4df4b406df54dc2669bc6f593fb38809a2c04214b9d59e215cd	\N	2016-08-16 18:03:58
278	603	c317cbeee3cb99854b81e3b1687b219f491fa9cf50ed7d9332d32fd76fbe8843	\N	2016-08-16 19:27:22
279	713	f1ee1af058aaa45a4189029edfb5599ea9439fc9cc936ec73826cdd366969f66	\N	2016-08-16 19:35:08
280	473	6e005fa9a320338303d053e3fe23479627c83ea6e1ef6eebad01f05f8646d0f4	\N	2016-08-16 19:36:38
281	715	1ae7912871c0d29f7f9121bbfd560ef929823e21259f55daf8ae656206923529	\N	2016-08-16 19:38:09
282	714	0c6d0973e799e709e0d7621243c2d19d215e1d036123fee01e1fbd7487df8397	\N	2016-08-16 19:42:04
283	717	53f21a44d43757d9d47add7d03e690e7f7ff1ad4e73c5b36bfe4f46632687fce	\N	2016-08-16 19:45:27
284	718	74ced58094e41063a6a76e71e1a662f7fca2437d8f508ffbde0a69e8d5f6e45f	\N	2016-08-16 19:53:34
285	723	e29e3c8832bf4ff82ccdd1a64da3f1679ec1ddb744fa8eb8031dfcf653fe5177	\N	2016-08-16 20:17:04
286	724	9d2655acb86eba12f2a7a0448d5b6163d215c4ea3a9336abe3cfa7404cf79179	\N	2016-08-16 20:19:13
287	728	d1e0333eaaa3c7dc0b8efcdad0ba6ccc8b404db1dcd2e76ea93db384095f5336	\N	2016-08-16 20:53:58
288	730	919af74a3a8e307e753968c7095020e93297439e9187d43ff0f88fb79b2fdce1	\N	2016-08-16 21:13:57
289	734	a898bc6e400f8464a31bc887926732dcd3d9151281891e698c09c0a00b737360	\N	2016-08-16 21:31:18
290	736	13ce6d623ff7693c0dcb745f51d0c86e8141883b7e85f4c2f9a990ca22be27eb	\N	2016-08-16 21:47:31
291	737	e5867e9351ece3abd623aec396f381f7abbe52ba54b2bdd55f0614202852f0fa	\N	2016-08-16 21:57:19
292	740	4a336d887aebbd44b8700ca7e37c5a42c3fce5b3725f0b92cc00c1ecd689967f	\N	2016-08-16 22:20:38
293	741	b949e41e8f846bc0b4a133c81167ed06df01651f7bb329c44e5efc50d02cbd8f	\N	2016-08-16 23:09:45
295	749	1daf94bfe16e28dde4fbf1169bd439afc89c6154fd2d37f6a946f6f7e972a5fe	\N	2016-08-17 06:15:27
296	750	685d0d818cf9cdae7ec98a15cb9e07645370e0ae8df53154ecf27efbea85541a	\N	2016-08-17 09:48:51
297	653	7e7ec11f53ae444542909a3389f748fb98aac88a4bb7596b11fa5f3d423ff46b	\N	2016-08-17 11:15:57
298	754	27ca8b3eefa2cbaf9372bf8ca7a24f97322803a345b33eb875785e5e7fb5b486	\N	2016-08-17 20:51:48
299	755	43006e0f9b9745a2a2b3ec63ea52422917bcb16468e037b1fa3a8d630a6b412c	\N	2016-08-17 21:27:45
300	756	5757b0fa23e0ac955cba6e698dd0cb7de3a103fa7ac2d749efbe71936b16981f	\N	2016-08-18 00:22:21
301	760	045d0eaccd08779f901f6b78de71ced8305a953ba9f434631422b47c92f02749	\N	2016-08-18 17:11:52
303	761	1146dfce0816fc7edef9a36d359dbf1be767d8494fb0220606acd01a43aaadfe	\N	2016-08-18 21:21:28
304	765	f6bd647f0ba7cd6ef213adf916064d99b272cae8df8c6641bc1174a265863232	\N	2016-08-18 22:17:08
305	767	b2b1e61f21fb778bc26a67070c7aa4c1dec0e848fd84b80c99a109ea93d65553	\N	2016-08-18 23:05:14
306	769	d0da2659bfe559035165729cb8920d3f3be2ad32974d4e2eb4db7f044679da12	\N	2016-08-18 23:52:26
294	746	f13a1708fcfefda640e967239a0ba3bc5068e19975a9ae1e9cdc4ce3d3c989a2	\N	2016-08-17 00:19:02
307	770	43c6d04601207e3f0a71987b9e5ff99bd2c3eb2e0d37872ff27483c0049ae8b0	\N	2016-08-19 02:13:28
308	772	ad7c2e57f3ce0d96971813bdced6a22621eb2bfe08ea6b8ddc3191b4453f90ad	\N	2016-08-19 14:04:10
309	775	12337e69284b97cb2155bcba1f123d2d189108f9a3a9b486ccb4b30733a1292c	\N	2016-08-19 15:43:41
310	780	3dd563056cea9a1fbbf09343b023c3f9d5ab8ed560efc712a7cb1b015a6b4451	\N	2016-08-20 15:22:43
311	783	bb4003ba9446366a4257e055ba9d512be19b1e2509006318c1f790486c80ec20	\N	2016-08-20 18:27:27
312	788	ccd5a181ffb67e2f7737945b35a9e82bab5b94d223fbbf4506a72fd3f47a3a6f	\N	2016-08-20 21:02:31
313	786	fa5b2b96bf8379a3c911f82e52744e71f9273cda3f81c5439f402f14c2fae430	\N	2016-08-20 21:13:24
314	791	f136d8619c9827388c721f07dec283768bf0112004fd8a849282c6a925937695	\N	2016-08-20 21:15:05
315	792	375eb81be57be31899748d55d8f564b15936f5d66454c74ad3763f1f7b6a7868	\N	2016-08-20 21:16:49
316	794	72189b350521b213d41d4762728060f936526b46bc3cd962e39623c1c4d7cef2	\N	2016-08-20 21:25:00
317	795	c74aa85db4c2ed8f8e69f1d4a15314a235b9b7957862d1424e0cde176e775bee	\N	2016-08-20 22:06:12
318	799	69c5349c674d3f136d6775e5ce019fd240692a4f94a79bdb95a9b4fc70bac799	\N	2016-08-20 22:17:04
319	802	84bc3abf17d0d679470f4048696942ea2f3d3db51de6396feea00d285e6358e6	\N	2016-08-20 22:20:55
320	808	18517111b43ec05f19e19919105ada4f6422f76185f6785b830adcd0df4735f5	\N	2016-08-21 21:49:24
321	810	96f3deca03f96295838d200eb698ffb3453ece2cc29d5485f1a6a020e4563427	\N	2016-08-22 17:56:28
322	813	940537fd01962482a55f6b1d25de8ac75b27ac0082d10b1d1ca7d9d9b0ae0c73	\N	2016-08-22 23:42:22
323	814	dacebc3d5631910e4d940204731b8a4f9b332b2ceb155f0a69471030c9d172ab	\N	2016-08-22 23:49:33
324	820	ab4ac9c730c21f434484a3271530df618e65a80dad0d57095e8afe10f83584df	\N	2016-08-24 05:03:20
325	661	f1e298de764f1723cab7baa03e7601152a4f032941eb0327f8a67c39d1acc0f4	\N	2016-08-24 19:19:07
327	827	c0088f2a3169090b15de6106d9f6e63bcf48739f971bb90c2dfddff9b26d2cfc	\N	2016-08-26 20:15:20
328	829	1785195bbb168836963e6595a52f6e38f49ba85192ce7e98e494d157d747083d	\N	2016-08-26 21:29:18
329	831	9f4bafa1ccebeb0d4b908c28b1241e03f4644d16ee03065b09f9954fce800a72	\N	2016-08-26 21:52:02
330	833	664e93faf8f311f88f3dd4ffce49d8e170ecb871ca82b4c8d3ec0bcbf3b126c3	\N	2016-08-27 00:53:46
331	836	8a1ac87aa2708b63f4ffc4340db00b0696c85dd8f32dda063bd43f1a8fe4226e	\N	2016-08-27 02:11:31
332	845	d8b2e72e17a05ae704143d2a12461dd5f3b36208a32fe9d9af8248823fc52118	\N	2016-08-28 23:32:11
333	851	1651588825503446078b066343b69234c0f0caba1d9cb129ad9e17ee241b633c	\N	2016-08-29 23:00:23
334	852	bcd14bf5ddfac3dca9a08a445f797cb713731ce5651030ca4e2131d3be733271	\N	2016-08-29 23:01:22
335	856	1a8cc763009b24e7c4b021c75a32c0e0de5c3c678a272a9e49b45b4ca4c0192f	\N	2016-08-30 02:28:18
336	824	56ae3b74686064af52e4a71ebd96985d3f9a5191497441364617f44400d973a3	\N	2016-08-30 02:38:18
337	858	ed0b553d24c2f27a7f017d36c9fd1eb5c514356cfdb6581b4645d7b8cabc2b26	\N	2016-08-30 02:59:29
338	860	30532bb5892c0ce1ebe624c5225f99da741dabbeb02dda3436122260e12caf6a	\N	2016-08-30 11:45:24
339	867	78200d58f1a0b2de1546ad86acdf755c3dbe075eb542fb9dafc5670782c6e8f9	\N	2016-08-31 13:00:05
340	868	b4dcab3ad9da98ff01bf441c01805c5cb737bae15c7427cb629beb2299aed285	\N	2016-09-02 15:13:24
341	870	230541af025c855fdb51bd8cc3e814992797e328827f769ceb49673d0b58e3c8	\N	2016-09-03 16:14:30
342	882	c7b2cba94e3e3a24e59cfc5d2b2fa65a1629daf807f9ec59f5f2aac880dff7f7	\N	2016-09-03 17:53:21
343	881	9cfe0a315abbc0fc2025758277e8bb1772a538dd98b0dd936e1055c27d5d6880	\N	2016-09-03 18:21:44
326	823	2f1944fa699c4c828ca0a7ea7284e642223dbad2ec43f95c02ba7844ece6358d	\N	2016-08-25 13:38:39
302	9	4d6a86814dc574b4bc36021d06d00cc22d8fe833a3dba75ebce929149f5960cf	\N	2016-08-18 19:33:16
344	878	e70ff5da2b9d2802cc06b763f1fb314ff598688e8d9c800015389bab2a76da89	\N	2016-09-03 18:52:08
345	883	88f235f1d6d47afcfb2fbfbe5b91c29814515fa9f1a30b29653bd019a79fb3ce	\N	2016-09-03 21:54:45
346	884	77c22cad8c739b01017f1327db102fa8c19a0e1e06054fcec55c367a04c32eaf	\N	2016-09-03 23:21:17
347	885	d9408e1f7a5c8c9c42b435b511c9afab607ef5f0fd0f72301fa302cba0151cb1	\N	2016-09-04 00:22:43
348	887	cfcbab150c2fb79b2af8810dcb9c929b3675124e1f311d8f5639439b019d6e3c	\N	2016-09-04 03:57:14
349	888	7dfe5851291f44d84a9fc47b12cb74c967171a904de3ba5bb62a2c1ccfba904e	\N	2016-09-04 04:14:56
350	893	44449fee304afad0b4fa916d735c8558231a80b0aa107990dcf1b916288403d0	\N	2016-09-04 19:58:30
351	897	8889765c7887d50a435044e92f70b61c20bb28a028a5ec840561dafe21bab86f	\N	2016-09-05 04:25:48
352	898	08e98f9ba56c62405d9a7fa4da85cf9a8b720c11920a6d7d5c4c7ce3d7c99e71	\N	2016-09-05 07:08:38
353	899	062af47f98d67fc260f1e87a9d55ea519ab9ec1d7c17af3dfb48f3b7b5206bc3	\N	2016-09-05 14:45:43
354	901	56e05f789c56a23dfd1f60fc6917b2e9ac3ca52580ffab0bff401ab51df6e3f4	\N	2016-09-05 19:34:24
356	907	c6e78393512438dcb0759c49bd81f7dc094a7aae76b59de563134d8949dc6940	\N	2016-09-06 06:53:59
357	912	8363612ec3daa2f3eaaf4eb8441aec62f09d5dfd5a8533c94709b9c43056df63	\N	2016-09-06 21:44:41
358	666	7b1b8fc8bfcd64eda0c0684eab2405adb49dcbc7fd85b9ce5906a71957d81dac	\N	2016-09-07 03:33:43
393	954	ae79683442d5aa7006ca2d5c99095d04171928db5825a419ed2ea5fac40e92c8	\N	2016-09-16 21:24:58
372	945	c025a4d268331aa26ae110c3bf85a764f1978f6744884848ff9dc47639245537	\N	2016-09-12 17:53:56
360	913	b5f3fd0de642ff0129c6b086234e58d960de6fa9cb950fd2d893ce2476eb7dad	\N	2016-09-07 17:13:01
355	906	7a83f9303e57ed1921a7d82dfe6b112ad822ff249b47aef5e64fe17cf72a733d	\N	2016-09-06 05:28:10
362	917	77c39651fcac5374ecf62072384d11e758fd2a43c2591ab16e67258d5152be21	\N	2016-09-09 18:21:24
363	918	78b403be8c4f7f5cb21e64cc2b0fdb800c047eeec6ef3a85eba63b03689533ef	\N	2016-09-09 18:22:00
365	925	e47aab89be4f830a7b0a7a968a48409fc5c680ca5b47e1368877a4e59aa3086e	\N	2016-09-09 21:01:13
364	923	221866ad0d856c0ecc5097ff43dcc10fe08ef62ad0b879fddb47a269834eb3e9	\N	2016-09-09 19:28:33
366	927	44bf68769839c22562c1dbf225c175ef5bc1fbc98675106c84766300fa1599a9	\N	2016-09-09 23:01:03
361	915	95a74a3693ab4533b36e0a67479875e7011632fb994224de876284577ca4f058	\N	2016-09-09 02:23:08
367	929	ac4a47bd35ae5b2432100bd92f305db09bba4851fd98b0df6b334ac7bdfc138c	\N	2016-09-10 21:16:59
368	931	ee2d31656058a4892016c8697bc7d1e2e9b1169c99c44581d3d54981ce8baf5a	\N	2016-09-11 16:36:36
369	935	b62cdbbe77dca7cad050bab617d553d9ef51f23879bbeb73c816b54e01ced8e6	\N	2016-09-11 23:02:03
370	939	5773fbb7bad849908c610106f9fe4ae9062a2acb1caffd7ae2579d07b3d7124f	\N	2016-09-12 14:27:02
371	944	3b5ceb96d93bcee522f443124c7dd6153856fc0ff5611c0bcffacf19bc2ffda7	\N	2016-09-12 17:43:10
373	946	22b2fd2ae49764890851135c6aab4e7add23dd0be4c211f1e2c152aa9348d1af	\N	2016-09-12 18:09:21
404	1010	eb12b4827c911ba1d3394b1085d8e9aa95481fa2a3b65a323d5a57b9b27ec18a	\N	2016-09-20 22:55:27
375	952	72bd31b1de43cbee362e8cee60e91180f5a9c35e011b8e95709ca97848255667	\N	2016-09-12 22:13:20
376	954	f71bb4a6fffe7671ae9791f6f50824c056c1645ccc225a308df7f750ffa0052b	\N	2016-09-13 00:12:29
377	957	e2e51a7cdc9dc2e1c256198d55f37edd14b647e7f06f63443056fdf1eecae550	\N	2016-09-13 11:34:10
378	960	d14bba65bdb2928ecf4e04b905061dab342f11b09b13af52f48f2cee57aced92	\N	2016-09-13 15:01:11
379	964	67053439197c8c026a8de7eb3ea7a7f62a7e97b042cd54ccb123fd7c339d3450	\N	2016-09-14 03:49:07
380	965	fdbfdbcc20e9dcedfbe33f5db4c7dd13d3cb5b323d75a84347ee17bb3eca749d	\N	2016-09-14 17:13:25
381	968	fda088df82d8fde83efd15ecce664565e69b3e5e11652111ba0f55691c58e901	\N	2016-09-14 17:16:57
382	969	12cb5790a2064079fa06ba9b65c44a754bd1743784d6752773ed3e10cf97f2f0	\N	2016-09-14 17:44:44
383	973	af00850ff62384ac115455dc151ee05dfe428f97c3fed70b7e39f642f80a2a01	\N	2016-09-14 18:34:43
384	974	9179be75a492460ae89ec807848102cc07766a4b573218cb29bfb70780f2d0df	\N	2016-09-14 18:43:46
385	976	3b87ad35ed438a92493d320a176fbba3645da423a5ce79b07a6a2020847849fb	\N	2016-09-14 20:04:47
386	977	f47dc6d1565012b78977fa37979f62bce56629710374829c9330b2226cd97284	\N	2016-09-14 20:36:03
387	980	9ca20b0fd353e9de3cb0aa878a6041a769829d09e1ea0e725c3858f9af075649	\N	2016-09-14 21:36:48
388	983	3e9af6684c327f0e8547c236804902424a2f2b043288e5b4cc495199e989bb5b	\N	2016-09-15 00:29:24
389	985	de65d0f0e89c6e41772f92bf06bd0b3f96fb964cdd9ccc5378460f78da559489	\N	2016-09-15 17:33:16
390	986	85acb08946008e2b437c1f72e3535a85e7ec8acc24189f81122f4ce1718a9361	\N	2016-09-16 03:25:33
391	987	bfd680406aa45365e270c535ddde3b274d80a32135fc816aefe1d41dce480a68	\N	2016-09-16 15:48:51
392	988	ed83f502fc36cc2fa49c8a45bb7be218b2677dc193548e7daf2b0ca356268f10	\N	2016-09-16 21:20:53
394	990	dc5b92bcd4ef65d6e6aabd99f0c88a3a86916098688e2da12eea6d06afb77475	\N	2016-09-18 18:34:05
395	995	7f6fb45f2ded1c9254b0b68427816486d803ba4a3e79696d539e77f6971bdeee	\N	2016-09-18 22:59:48
396	998	b8690100a56058384bef7298d1cbbf2b684be12232934a44917123ac1c9c3fb2	\N	2016-09-19 01:07:37
400	1003	e751c8335517c741dc4573c3272757e8b358911193c4f46e65067b761ac67886	\N	2016-09-19 22:01:07
374	943	612eb9bf5ba0bf565bd89750b27c5f35110e0e80acd4df167f67b497566faa27	\N	2016-09-12 20:26:39
397	1000	b7f1c6a9ab7597d751787f3a8bb65c665a7a546fc34e3d32e5574ec3e8d66520	\N	2016-09-19 15:45:02
398	1001	58684d31192b497e7012065ac05f7cb37a66eac59ef2947a84ba88d6b90cb806	\N	2016-09-19 21:57:32
399	1002	ee451ff3724106f4910f4cd7e7e327899f3a11cf01db99178478ecd9ba810bfd	\N	2016-09-19 21:59:12
401	1006	1aa1e217463030d86601d980135cc743dd34b50e0be37179e7e680df8b2bac07	\N	2016-09-19 22:31:38
402	1007	df18aa1cd4126a2c0088161a5cb084e4a367745c2d8d3118c8ad890f0ac7321b	\N	2016-09-20 19:44:26
403	347	97b75586d509277ba05fd690bf1dce9d0cee21eb661a6d80bfcc3f20ac414e60	\N	2016-09-20 22:55:20
405	1009	04fb298bbf389410809beab1cfc5abb120558d9665c7cf0d7bb6125b283c634e	\N	2016-09-20 22:59:34
406	1014	9dfefca79f4dad784d6a769f350123a677094e6387b5e6253347df748be5122d	\N	2016-09-20 23:42:03
407	1018	531d0f40cfd3ff2ab046e43156314ebb7fb0ffe523b5a97d0ed58c77c6c53a91	\N	2016-09-21 00:23:12
408	1022	60ccb9204d49aa6ea1d16da8f7ed29dcf5ed4d1c8103a679031108702dc0d14e	\N	2016-09-21 03:26:37
409	1023	32b19fb43c2a5afd12bd582be3c06b48e0c97ce9a9e9694b05a99d416971d1b5	\N	2016-09-21 03:47:43
410	1030	94ae358bf16ef2eb61a71b0d29e6b6808c8ec566c66217891dd4f077170d1533	\N	2016-09-21 19:04:10
411	1037	227da696c495ca506235761a0fc3f5d8852ee15a30eda99c422ae31be9ab267c	\N	2016-09-22 17:37:14
412	958	bae0cb64df18f8f3e7ad85cc6cc4fd2de994a93f631e4107ced9ab584811d440	\N	2016-09-23 14:41:03
413	1041	c3b32d043a4e686ddc4576e808c385aca8b5301375442f9fdae14cefd1fa85d3	\N	2016-09-23 14:48:09
414	935	7d7133f1ec9dbd598ca9e564a5973fd49505dba9690a4065ffbdaca0782b1e9b	\N	2016-09-23 14:58:23
415	1042	5c56af5bb9634641ee9f7767d5cc61344ecc6063fcc6a93c7b7a1dc2d633cedc	\N	2016-09-23 15:10:10
416	1045	1ba928d84ce4f0fa495320a03c043a540c136c40ccf5ae18b16ff892476a4b10	\N	2016-09-23 15:42:46
417	1047	eafc45d209545d84400d40863ed76f02441b1c6eb9601d3711d0b2d6e1e1a942	\N	2016-09-23 22:17:49
418	1049	160c8335657f39d516b5deec1a08f9e649f4ea4002b36ced0fa899f574bf137f	\N	2016-09-25 18:11:56
419	1051	fe35be84f469d761dcc224393c381dd54325c1ef9b3e4364ce3dc25e6127d0f7	\N	2016-09-26 16:30:17
420	1052	97e05b777fe37619f228ca56ced7a80aa69b14038d966164e3159aa8f6b9c224	\N	2016-09-26 17:32:08
421	1054	d9dec578e893e08bbc821780b42d1c5073ef7918afb09717968d399b49b1e3ac	\N	2016-09-26 23:30:15
473	194	bead74f9e239aedec20a262f15767dc08675e5e1c9c793a49ba9b6a0c4a699dd	\N	2016-11-09 12:20:57
447	194	4fc0e4e3a75c4a9676eaf830231687be0a7b9dda80a84797c65fda3836ae5625	\N	2016-10-25 12:07:23
423	1056	7d522885b90ca2c237ab91d863d4b40e4e7fce93a75d8df7bcb76a2d019c1f6a	\N	2016-09-27 00:38:21
424	1057	ba622c8bbfa463206e54309940239b52b7ca5e3f41cb9a8f3ff91e8d5ceba82e	\N	2016-09-27 02:22:11
359	194	17cbc1678a1a85e3db5dc30269337511af639be366783593588aaa488cf25ba4	\N	2016-09-07 05:53:20
426	1059	3b0447a11279ca9b5eefb72ba0e269c0183b1646c69847cb6ec4427da6f277ec	\N	2016-09-28 01:33:09
422	1055	399195b484b801f5e39173ace5ffba6a2c4b95c92f5440a30fd57c6bda4a21ac	\N	2016-09-26 23:41:07
427	1064	35f3e9152efba4cd00b6e231736cfcc29a930f1c062ceaa797af9eefbcd95acd	\N	2016-09-29 02:11:05
428	1063	d3f35c2565aab1ca3947736dfee59d871c8cfb1d970c37f7c769fa9ef720d1b2	\N	2016-09-29 11:57:23
425	1053	4a0d18115b3ddf09af3dfbc55f368ad08770020529919d94315fc53c54de61dc	\N	2016-09-27 17:45:26
429	936	0d71478e34b419b291bd91f3a92bf966e87ef526f782e8936feb60f15bc34027	\N	2016-09-29 21:59:56
430	1068	9571969bdf052813250550d2c652f9b0f096c6fc9b0a0d3566c7aa836ad91975	\N	2016-09-30 23:10:58
431	1069	1c715bdd83f7bb481e0b93ef3f5c0d4becf12a1bbc31f6febf5a3542009e0051	\N	2016-09-30 23:19:00
432	1076	5687b6cbcb678e69767b77d094ea281ba2311dac6715aacb65f8872be7b75a01	\N	2016-10-03 05:13:13
433	1077	3941fcd3d49eaa58faad4053de8afd0beb88ef96771b157e0c0407afa1c85c7c	\N	2016-10-03 16:31:48
434	1078	62f755d1338ad73c70ea2ad5e136f4db53b3a6526bf24c627cf1515ffced4f60	\N	2016-10-04 00:01:06
435	1080	ed1252dd245a371961d64d7479512980760544e77e01b1bceb64f57c0b146eaf	\N	2016-10-04 18:37:11
436	1081	326b57f81e800941ead68aa3e3588c43c40e43fb05f19099e274aae3641ab3f3	\N	2016-10-05 14:29:15
437	1092	6a30ddec462911ad4b99d4c2a93d8e0a84e9ea1bc5765e0b6ab7237923562998	\N	2016-10-05 21:08:06
438	1093	a2d929ca65116ea55e1b46dfa859c9697415dfd6264051f6083235cb3a51b7fa	\N	2016-10-05 21:28:03
439	1096	cd63a68abaec383f4b13b96af9111cac8924e7ee2fbb11874083d5f057a15d4c	\N	2016-10-06 00:25:38
440	1098	78c6e68b17dd2b1fafa1884c8e17f08db6295f4d02024457bccb80a1b96d3f2d	\N	2016-10-06 02:55:32
441	1101	a8d199af0a01d32dd47129936fa06c4ba4eca8ee64ec9b5d90fb2c3c613c5bdf	\N	2016-10-06 18:45:53
442	1105	faece55caaed37846e175e361acebb02557228d2c5ec091aee52c205bcecd374	\N	2016-10-12 14:05:28
443	1108	db56ed4bece80f5abfc386a4ba55ac4778c8bb5c4d6e7635531a4f70a02c961e	\N	2016-10-17 19:18:34
444	1109	ced4ef29f6ab554f2c6bb3340c8fc95f5e2b6ac541d0e66c4c0a1ebcc08b212e	\N	2016-10-22 16:48:31
445	1112	a2258cf8759aff749718749efc24a517f73990f9b060349920362ffdf7123695	\N	2016-10-24 17:37:30
446	194	432981007d5542696dac240e7df6941e5d4005be63791d1fd59adf6f69710666	\N	2016-10-24 17:38:49
448	1112	afe00e3463d36a8fbf52b96857e963823804904d8c212a4b0e4f49c28a43464d	\N	2016-10-25 16:41:37
449	194	688f883cc8c57c9d34db50c800cae768f0c718002984db2516fc8f8798d9b248	\N	2016-10-25 16:59:22
459	194	6a89ae36f4304bdc421f65493c6dbcd1e7fe38eba5781ebc8195dac018f7c44d	\N	2016-10-27 06:04:43
450	194	a9cafacb4b7ee3667d556b279edb36e1c9773bf0cf63dbdef6bcba0802eaad23	\N	2016-10-25 17:01:37
451	1112	946b2610d6137e9eef2fc3a00ddcef606b99311eab31d799c70fb35f03180449	\N	2016-10-25 17:04:56
452	1112	d5318bd0ecf54fb3cb0ea5e289086b7da26a7cc35c0d767ded8948f5d2773480	\N	2016-10-25 17:08:16
453	1112	0d9953d3882fbbdd78d8895ba8d02653534cbd1d882a9fe965199a5dbd43298a	\N	2016-10-25 17:11:59
454	194	da310c114527390c65ba0b50555de65f1a6970305cbfb34c237bf4256e49c1b3	\N	2016-10-25 17:14:46
455	194	312562811c4b05f0dbaf50610dd8a8c63e7f1f2541a5d400fbab54b4c3da8664	\N	2016-10-25 17:15:54
456	194	9572dee159418e9e17453abae644bb7ecdb6c10b375c22d8f84ee36ce6975b5c	\N	2016-10-25 17:18:14
457	194	be613d544ebd546e0fd4f9f1fddcc651a54ec5ba50ea11dcbfef3f65c1572558	\N	2016-10-25 17:20:39
460	1117	b442204d370fb57ecd29de47e7bb0ebe5816fff856f21cdc0fe27005e218fb3b	\N	2016-10-30 14:28:06
458	1112	1b10285008a9dd4fa773ff5f14706d529343ff12c40b53ed0ec597d0954be893	\N	2016-10-25 17:43:23
472	194	53028c39030c4911c6342a3ce72c3f7dd48d47d20b1ec10dbfb00cf5c871470e	\N	2016-11-09 12:18:20
461	9	9d9c7d0d93eaa19efb70ed0fe09a5d896cf837694268ef4818376ac88bcd1202	\N	2016-11-01 14:57:52
462	194	d90bd017400e15532deb05edb4a36fa27138f5e9c2f86c31028ba5713a65700c	\N	2016-11-02 11:11:35
463	194	91697603a263fb58a310fd8d961d29849c119f3c6a5b8b46175127b71c4a1e4f	\N	2016-11-02 13:02:48
464	1118	95739cb62a4f1e23aa4e9b6c3700d65f21c78bb2765c2ff1e0e5b510133d716c	\N	2016-11-03 00:18:00
465	1120	db44e6c2640de43de606c04dca87dc85cd70b281fae0d4029495e97619392465	\N	2016-11-05 00:16:22
466	31	c023e8583df79c7e54d4c7e071596adb89ad996157b96f3f5bc93ad39157cd42	\N	2016-11-07 14:06:20
467	9	fbdfb6a354789ee539e5545cb6a5a7ecdcf774f30ffadc6414072f3db773db62	\N	2016-11-08 16:59:33
468	194	681c76fd3cb62998eacdf3b52bf7cb5ac4d995c7b429a6acf299dfe538222a6d	\N	2016-11-08 17:07:00
469	194	103708767c529d072025fe4ae8e5665f9e71e15aa967eb1d5ef7e9488f82965d	\N	2016-11-08 17:12:03
470	194	e6110fc7dac1c348d59ab72036f9d7942d2f50aeadde0a1b56530ce524db6e3c	\N	2016-11-08 21:32:12
474	194	40fc1bc10d2e1885ddd544bea18516044578d7e2aa7ea64f20a6af24e2b886b7	\N	2016-11-09 15:31:33
475	9	c747d163bafa399df2fb0bd331f56607f67f154c5f2e46c205e0fa9d833c3205	\N	2016-11-10 15:07:02
477	194	c33626c921a0b72759db49ce34b4339c9edfe9f19a3f55308c593591034f3d7d	\N	2016-11-10 16:14:01
471	631	8e1a14833c3c3b350c0a534338d80921964f1120aa8af0594de92773a15b650a	\N	2016-11-09 07:16:29
479	194	5c78daf5ab62d86971b85769daff68e5bb71d5d9a177afab11affd0fd96fe67f	\N	2016-11-11 02:24:52
476	194	d17492d7f40c44962952e28937a7a509340e821f3aae7422053bee8cd5efcbe8	\N	2016-11-10 15:27:34
480	194	e07f94ea6b200909aee453e00427bc128cad2ab7b2ca5c2303bf2de6ad20c898	\N	2016-11-11 13:44:11
481	194	58301b19816588acb73754e977d7917a11fe95d2b956e713f2137de20c82b4c2	\N	2016-11-11 13:44:54
478	9	28e9e0ca9c59c72c5192b7aa2fdf3b957e9b72d4c99dba87cb19dc95b31969f4	\N	2016-11-10 16:25:04
482	194	8933ed5a2be63a7d8aa8d5f808c05442af3eea095595cdec8e75f568b4d3b4ab	\N	2016-11-15 15:38:00
483	194	4910628aaf01dcfef8f67510a102ad7f5364e28aaa2691c272cd4b309525ee45	\N	2016-11-16 03:23:12
484	194	051a9741144e25330006a3508adf958dc9777a3f540608b9f116df49b9ee3916	\N	2016-11-16 03:30:42
485	194	26382f83e4399e227d59a78e5ffec0365966f0278fe111b7b04be357ee4582da	\N	2016-11-16 03:32:48
486	9	28463b38e88b26edb47a8e4c8e9e8a408b6b32ded8b3c29952e36a14256618e0	\N	2016-11-16 03:35:30
488	194	b11abbdefb92c7eb2aa4ec5024edd8fb42a37e76d3da8d38b056db35533bf63b	\N	2016-11-16 03:41:23
487	9	1a5c0a13ac5dec3e836f478f0d1d35dd13f5ee40a6cf48a6520521234d6ee913	\N	2016-11-16 03:40:48
489	194	2bfa01a7fcc4a85dce93163370e51a5e94f22a752ed19b6991deba448e789b2c	\N	2016-11-16 12:14:23
490	194	55c0a82726a5a626aa9fcfff5928f350ba3f9231f23c7aae5b5a462e3fb3fc1d	\N	2016-11-16 16:02:48
491	194	d9a67db68a8d4b9adda2bc8bd93968315368ac6b9fb381bf063d77ad95c9413d	\N	2016-11-16 16:07:46
492	194	32f19d20fcd36f87fa0cb2e54b5cd951fb069a40d89a62ad632afe5df9513f1f	\N	2016-11-16 16:15:36
494	9	8b57a5f7987134ce411a3529f43d6efc96aeede89ce02ae05547861304456a0a	\N	2016-11-16 17:53:06
496	9	37acb8b624b6f47cfa74f2bd011b7b9bc4fb363acffa51ba616da047273fe298	\N	2016-11-17 03:35:15
493	9	27cf05f6a9b7aaaf72971300ecac2582e3fbe2d0fb455568e0afeeeca7b3fda1	\N	2016-11-16 17:47:54
495	194	37ddb7cfde05b29c1fbe324e0d3c5d4d71f6c7ac83ec50a51cfa7ca8532b7a27	\N	2016-11-16 17:53:52
497	871	eaec1461e673f5b189e596dd108e38e45730208d553e4961a6e023cbfc5a6e59	\N	2016-11-19 21:15:07
499	9	532f0770b1e10d1f06f35784443135d68cfb541cbf285e518e00b6eefc79d26c	\N	2016-11-21 01:42:40
500	1018	b2867ab9bacbd0d4d6e6878dc40b14aa0bb15c78c25a389b6ebd788b3ac04b6d	\N	2016-11-21 15:28:09
498	194	a8f5b8ffdfe219611bb81a7eefe6a5590ebe6ccf66c4ef5ade6758be3cfc14f7	\N	2016-11-21 01:11:09
501	622	6bc1843148bb147155cc898baceee681f9593010380ed05a5af4269c710bf023	\N	2016-11-24 19:36:42
502	460	7df7ac80221fd79aea9782cf0b98c872fbfaef31aabe7cb9bb9ce98477c3bf85	\N	2016-11-27 19:58:43
503	1131	a9f57d1f23b3a72daebe4303500fbe5ea4789b2d40815811b651f00c4f7beb1d	\N	2016-11-29 02:33:29
504	1132	f920f7f3a361560d02ea4d2f04f736147414acebe7721d4c56c45e259288eab2	\N	2016-11-29 02:45:23
505	1133	caeb8ebeb322e3f9c79388ed008c0a7d328778cf1e03ca61ef7f4fee1f38d353	\N	2016-11-29 02:45:43
506	1134	256262c42bedbbab57e24e0933d159c9488e8171ac2dc1016d98f9fdabef7ea8	\N	2016-11-29 02:47:52
507	1135	8483e56b1fa4e636e9fed83cb452b6344d262169fc6597afcbe62301f9389e81	\N	2016-11-29 03:06:08
508	38	745929d2f02aa7cedcc2ecbfae2177e3212c37e0301869cf4805ca9b3557ec64	\N	2016-11-29 03:21:54
509	1136	2f6810dea78bdfc65270b399a24477d04995f2f7d4962cd040772374067ed942	\N	2016-11-29 04:16:18
510	1137	b59d92c55b8bfa743efa3f34c271b894eaa129daeed812a65bfadb0f59136c9b	\N	2016-11-29 05:19:09
511	1138	ed2da897d0d46d9fb1c6421db444c23e2dddecd878a62659c4c7a29674a49fa8	\N	2016-11-29 13:25:45
512	1139	75778a786c0c5140f98bc0f9d867144d6b1eb3921c1335e81d860e2f6e7b4143	\N	2016-11-29 14:57:37
513	883	f12ab95b295ea281e0ad391b30f5e414dc6f0320dd54626227d8017187561a2f	\N	2016-11-29 19:10:13
514	1143	458dbe2513483da71ff8abeacc2def88e6fba3654ed9dffadb08345533121026	\N	2016-11-29 20:33:19
515	740	510a3888ec7546e477a3b0b8b4df8effa75837c4dc95975377c54bf08b744148	\N	2016-11-29 20:50:25
238	621	3c8ab77c3cb7f9ffeee5a18a29137816e5303a5f328d816f31b909e81d73a61e	\N	2016-08-12 04:01:10
516	1145	f19d67659c3f95cf9c6faa83501e3dcc281c328497f8eef1533e757023df1c7f	\N	2016-11-30 02:05:28
517	643	72bd64dd7e08000314c843cba943eb13b4f87962080c7da79549f4626744a74b	\N	2016-11-30 05:32:32
\.


--
-- Name: user_devices_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('user_devices_int_glcode_seq', 517, true);


--
-- Data for Name: useraccess; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY useraccess (int_glcode, fk_groups, fk_module_useraction, chr_assign, chr_delete, dt_modifydate) FROM stdin;
\.


--
-- Name: useraccess_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('useraccess_int_glcode_seq', 1, false);


--
-- Data for Name: useraction; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY useraction (int_glcode, var_action, chr_delete, dt_modifydate) FROM stdin;
\.


--
-- Name: useraction_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('useraction_int_glcode_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY users (int_glcode, var_emailid, var_password, var_conf_password, var_fullname, chr_delete, dt_createdate, dt_modifydate, dt_deletedate, chr_block, var_adminuser, var_ipaddress, chr_usertype, chr_publish, var_emailid1) FROM stdin;
1	admin@thriftskool.com	102094086082092032038042033054116119120113		Administrator	N	2013-04-03	2013-04-03	2013-04-03	N			N	Y	test@testing.com
\.


--
-- Name: users_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('users_int_glcode_seq', 1, false);


--
-- Data for Name: users_manage; Type: TABLE DATA; Schema: public; Owner: thriftskool_mobileappuser
--

COPY users_manage (int_glcode, fk_university, var_emailid, var_password, var_conf_password, chr_delete, dt_createdate, dt_modifydate, var_adminuser, var_ipaddress, chr_publish, chr_spam, chr_buzz, fk_user_id, chr_verify, device_id, var_username, gcm_code, person_name, profile_img, class) FROM stdin;
109	30	jwolf10@uab.edu	112066064064091082071000024	\N	N	2015-12-06 04:15:34	2015-12-06 04:15:34	\N	\N	Y	N	N	\N	Y	ca0c13b4450225b5f472f113ba6f837b3658ce83137775d2d84ca3a0a2f76ced	jwolf10	\N	jwolf10	default1324657089.png	0
100	18	bblough@students.kennesaw.edu	043094065086068093014014	\N	N	2015-12-05 14:32:51	2015-12-05 14:32:51	\N	\N	Y	N	N	\N	Y		bblough89	\N	bblough89	default1324657089.png	0
107	30	zachday@uab.edu	116090091087087085054045049032005119114	\N	N	2015-12-06 02:43:26	2015-12-06 02:43:26	\N	\N	Y	N	N	\N	Y	0bb46f98ec1978a69b561cbba9861ba143fe1036c5aa4936fb85455e0e8eb78f	Blazethemagicdragon	\N	Blazethemagicdragon	default1324657089.png	0
105	38	acannon@ggc.edu	011010004007015004009088113096	\N	N	2015-12-06 01:57:56	2015-12-06 01:57:56	\N	\N	Y	N	N	\N	Y	5	awolfcannon	\N	awolfcannon	default1324657089.png	0
1122	15	ah11910@uga.edu	064086067002005008009001120122117	\N	N	2016-11-06 17:04:09	2016-11-06 17:04:09	\N	\N	Y	N	N	\N	Y	5	darreldh	\N	\N	\N	\N
60	15	Maiaw@uga.edu	037040112007010006	\N	N	2015-11-10 19:35:01	2015-11-10 19:35:01	\N	\N	Y	N	N	\N	Y	0dba684e8344b763c21be28696ee1fe73e112b7bb6376a4955e81ab182d93703	Maia	\N	Maia	default1324657089.png	0
70	19	tf01188@georgiasouthern.edu	046068081091006007001000	\N	N	2015-12-03 22:41:50	2015-12-03 22:41:50	\N	\N	Y	N	N	\N	N	123456	tarafloyd	\N	tarafloyd	default1324657089.png	0
66	15	David.schwartz25@uga.edu	115071092080088068012011003117	\N	N	2015-12-02 15:32:22	2015-12-02 15:32:22	\N	\N	Y	N	N	\N	Y	4858ee413afc5cdd55022317ffa9ef6d31ab023e715a475eefeca8155adc527d	DCS4234	\N	DCS4234	default1324657089.png	0
65	14	careaves@valdosta.edu	121084094004006007015009011	\N	N	2015-12-02 01:39:04	2015-12-02 01:39:04	\N	\N	Y	N	N	\N	N		careaves	\N	careaves	default1324657089.png	0
1123	24	abhaykirti456@columbusstate.edu	083081092084079068087087081044	\N	N	2016-11-10 06:10:10	2016-11-10 06:10:10	\N	\N	Y	N	N	\N	N	5	abhaykirti456@gmail.com	\N	abhaykirti456@gmail.com	default1324657089.png	0
9	15	dps11@uga.edu	112082071080084086084085002115	\N	N	2015-09-28 15:03:14	2015-09-29 11:41:30	Administrator	50.150.17.28	Y	N	N	\N	Y	015ca64ec97df6b005d0c0ee6ce3275424a09a832d02e0481b48083e777504da	DPSchwartz11		Douglas P.	DPSchwartz11_1.jpeg	5
1124	15	km15563@uga.edu	127092091071091086086121001113	\N	N	2016-11-12 19:36:00	2016-11-12 19:36:00	\N	\N	Y	N	N	\N	Y	123456	Kmoo	\N	Kmoo	default1324657089.png	0
78	14	bjsammon@valdosta.edu	083088081094087092005009009	\N	N	2015-12-04 16:54:34	2015-12-04 16:54:34	\N	\N	Y	N	N	\N	Y		bjsammon	\N	bjsammon	default1324657089.png	0
87	14	kandre@valdosta.edu	007000004007006001000	\N	N	2015-12-04 19:18:29	2015-12-04 19:18:29	\N	\N	Y	N	N	\N	Y		littlebatboy34	\N	littlebatboy34	default1324657089.png	0
71	38	creaves2@ggc.edu	121084094004006007015009011	\N	N	2015-12-04 04:00:07	2015-12-04 04:00:07	\N	\N	Y	N	N	\N	Y	d76c04f987dfbb8e1e082699278883918881ce84f19b23000ba196f7a69a9a37	calebreaves	\N	calebreaves	default1324657089.png	0
73	15	kennyc@uga.edu	087083095087090088068010008	\N	N	2015-12-04 14:58:39	2015-12-04 14:58:39	\N	\N	Y	N	N	\N	Y	5	kennyc	\N	kennyc	default1324657089.png	0
74	14	dsekerak@valdosta.edu	053089093094085070007015	\N	N	2015-12-04 16:21:36	2015-12-04 16:21:36	\N	\N	Y	N	N	\N	N	123456	dsekerak	\N	dsekerak	default1324657089.png	0
75	15	apeden@uga.edu	080086064093083085093074068115	\N	N	2015-12-04 16:30:15	2015-12-04 16:30:15	\N	\N	Y	N	N	\N	N	123456	apeden	\N	apeden	default1324657089.png	0
15	15	jct33187@uga.edu	093087069093065007006015014	\N	N	2016-02-06 18:43:54	2016-02-06 18:43:54	\N	\N	Y	N	N	\N	N	123456	katiebergs 	\N	katiebergs 	default1324657089.png	0
82	15	abrown1@uga.edu	087095093079087085093077088112	\N	N	2015-12-04 18:11:15	2015-12-04 18:11:15	\N	\N	Y	N	N	\N	Y	ca448ff479c945aa503b40f32b3ad8a778fd5447d96840ca8f4a85f900f7c5e6	annelisebrown	\N	annelisebrown	default1324657089.png	0
83	14	amawhite@valdosta.edu	116000006011088076088089	\N	N	2015-12-04 18:37:34	2015-12-04 18:37:34	\N	\N	Y	N	N	\N	N	123456	amawhite	\N	amawhite	default1324657089.png	0
421	15	rlj64345@uga.edu	043084092088093091069005	\N	N	2016-03-21 20:20:00	2016-03-21 20:20:00	\N	\N	Y	N	N	\N	Y	123456	Rena	\N	Rena	default1324657089.png	0
86	14	Bmblair@valdosta.edu	113088084095069090092081052115114	\N	N	2015-12-04 19:16:45	2015-12-04 19:16:45	\N	\N	Y	N	N	\N	Y	7661bd1346b1ccfe720b2e468a64d9c91053d6044f58243909d30a0d1947c63c	BeauBlair	\N	BeauBlair	default1324657089.png	0
89	14	jamferguson@valdosta.edu	083083064081087087091084015	\N	N	2015-12-04 19:21:04	2015-12-04 19:21:04	\N	\N	Y	N	N	\N	Y	123456	JFerguson6	\N	JFerguson6	default1324657089.png	0
88	14	clibryant@valdosta.edu	127085071091086074090069050115119	\N	N	2015-12-04 19:19:04	2015-12-04 19:19:04	\N	\N	Y	N	N	\N	Y	cb4891ad21a53d7215cba35b9b273802d831a28bc214d5db6f2938c834e1f5f0	cbryant_19	\N	cbryant_19	default1324657089.png	0
80	30	sieck519@uab.edu	065090081086093082084085085047	\N	N	2015-12-04 17:44:36	2015-12-04 17:44:36	\N	\N	Y	N	N	\N	Y		Laura	\N	Laura	default1324657089.png	0
92	14	bdduren@valdosta.edu	005068064086090000007007	\N	N	2015-12-04 20:16:28	2015-12-04 20:16:28	\N	\N	Y	N	N	\N	Y		bdduren	\N	bdduren	default1324657089.png	0
85	14	dhersey@valdosta.edu	080082071080084086084085002117	\N	N	2015-12-04 19:16:22	2015-12-04 19:16:22	\N	\N	Y	N	N	\N	Y		Dustin hersey	\N	Dustin hersey	default1324657089.png	0
1125	31	test@ufl.edu	046044063056	\N	N	2016-11-16 08:13:44	2016-11-16 08:13:44	\N	\N	Y	N	N	\N	N	5	test	\N	test	default1324657089.png	0
299	39	bhargav11@appstate.edu	040	\N	N	2016-02-10 14:40:44	2016-02-10 14:40:44	\N	\N	Y	N	N	\N	N	5	bhags	\N	bhags	default1324657089.png	0
1126	31	Vishwa@ufl.edu	064082089067095068079088002114	\N	N	2016-11-18 06:18:24	2016-11-18 06:18:24	\N	\N	Y	N	N	\N	N	123456	Vishwa	\N	Vishwa	default1324657089.png	0
91	15	wesleybt@uga.edu	069086071089083078010009001112	\N	N	2015-12-04 20:07:12	2015-12-04 20:07:12	\N	\N	Y	N	N	\N	Y	5	wesleybt	\N	wesleybt	default1324657089.png	0
1127	15	ilrisk3@uga.edu	045068068065000069095082	\N	N	2016-11-19 02:09:31	2016-11-19 02:09:31	\N	\N	Y	N	N	\N	Y	123456	iainrisk	\N	iainrisk	default1324657089.png	0
90	15	tylerj@uga.edu	021091002001001003005007	\N	N	2015-12-04 19:59:07	2015-12-04 19:59:07	\N	\N	Y	N	N	\N	Y		tylerj	\N	tylerj	default1324657089.png	0
94	50	kmayo2@stedwards.edu	003094069090081005006005	\N	N	2015-12-04 22:51:17	2015-12-04 22:51:17	\N	\N	Y	N	N	\N	N	5	kmayo2	\N	kmayo2	default1324657089.png	0
1128	26	wasim9761338799@tigermail.auburn.edu	011004002004005004000014009120	\N	N	2016-11-21 13:15:49	2016-11-21 13:15:49	\N	\N	Y	N	N	\N	N	5	Wasim.khan	\N	Wasim.khan	default1324657089.png	0
93	18	jpettit2@students.kennesaw.edu	090086070092066086095092006113	\N	N	2015-12-04 21:20:32	2015-12-04 21:20:32	\N	\N	Y	N	N	\N	Y		jpettit2	\N	jpettit2	default1324657089.png	0
1129	15	na94916@uga.edu	045034040093083093	\N	N	2016-11-29 02:10:02	2016-11-29 02:10:02	\N	\N	Y	N	N	\N	Y	123456	Nalina	\N	Nalina	default1324657089.png	0
95	19	cb04377@georgiasouthern.edu	032093083081085088087006	\N	N	2015-12-05 00:39:13	2015-12-05 00:39:13	\N	\N	Y	N	N	\N	Y		cbacon	\N	cbacon	default1324657089.png	0
1130	15	zw92492@uga.edu	066076069009010009112123113114112115112	\N	N	2016-11-29 02:30:58	2016-11-29 02:30:58	\N	\N	Y	N	N	\N	Y	5	Zhourui	\N	Zhourui	default1324657089.png	0
104	18	nwood15@students.kennesaw.edu	089085077093068087087004112114113	\N	N	2015-12-06 01:24:42	2015-12-06 01:24:42	\N	\N	Y	N	N	\N	N	123456	nadia wood	\N	nadia wood	default1324657089.png	0
1131	15	drsandes@uga.edu	118065085082089089015014007096	\N	N	2016-11-29 02:33:02	2016-11-29 02:33:02	\N	\N	Y	N	N	\N	Y	123456	drsandes	\N	drsandes	default1324657089.png	0
117	14	cdwisdom@valdosta.edu	002089087087080084068006	\N	N	2015-12-07 21:28:44	2015-12-07 21:28:44	\N	\N	Y	N	N	\N	Y	8c64eceaf4afdc66fd3dc50e67954e8505e07ab1a513555ea64f865540f55493	cdwisdom	\N	cdwisdom	default1324657089.png	0
1116	55	most.live2014@hotmail.com@tamu.edu	066070074088080069006010010	\N	N	2016-10-30 14:26:07	2016-10-30 14:26:07	\N	\N	Y	N	N	\N	N	123456	buy.T-shirts.online.USA	\N	buy.T-shirts.online.USA	default1324657089.png	0
1132	15	xf85483@uga.edu	082084088080064080009115115114118125	\N	N	2016-11-29 02:43:29	2016-11-29 02:43:29	\N	\N	Y	N	N	\N	Y	123456	Fancy	\N	Fancy	default1324657089.png	0
118	15	dmal09@uga.edu	065095081080070088086080068112	\N	N	2015-12-07 22:50:40	2015-12-07 22:50:40	\N	\N	Y	N	N	\N	N	63001a15c4790eab27b52ef1ded3268090eef05157e8a8be1288d59eb493eb4b	dlabeach	\N	dlabeach	default1324657089.png	0
1133	15	jmr32652@uga.edu	113066067088080004003012011	\N	N	2016-11-29 02:44:55	2016-11-29 02:44:55	\N	\N	Y	N	N	\N	Y	123456	jmr32652	\N	jmr32652	default1324657089.png	0
145	47	jcgresha@olemiss.edu	046032073070086070007	\N	N	2015-12-09 17:58:25	2015-12-09 17:58:25	\N	\N	Y	N	N	\N	N		jcgresha	\N	jcgresha	default1324657089.png	0
1134	15	caitpage@uga.edu	095082070092083069087065002118	\N	N	2016-11-29 02:47:15	2016-11-29 02:47:15	\N	\N	Y	N	N	\N	Y	123456	caitpage	\N	caitpage	default1324657089.png	0
1135	15	les16789@uga.edu	069082071084084094009000009121	\N	N	2016-11-29 03:05:38	2016-11-29 03:05:38	\N	\N	Y	N	N	\N	Y	123456	lsims98	\N	lsims98	default1324657089.png	0
135	18	vbasnett@students.kennesaw.edu	068090070082095089081088001112	\N	N	2015-12-09 15:08:48	2015-12-09 15:08:48	\N	\N	Y	N	N	\N	Y	0767dbe515e037796b0076ae53a24debf6ba1ab629ad6525419dcf0225be1174	vbasnett	\N	vbasnett	default1324657089.png	0
1136	15	kyuha.choi@uga.edu	042089010011004006006004	\N	N	2016-11-29 04:15:54	2016-11-29 04:15:54	\N	\N	Y	N	N	\N	Y	123456	icingstar	\N	icingstar	default1324657089.png	0
61	14	syray@valdosta.edu	098095065085076006007011013	\N	N	2015-12-01 02:34:20	2015-12-01 02:34:20	\N	\N	Y	N	N	\N	Y		syray	\N	syray	default1324657089.png	0
210	14	mrross@valdosta.edu	101091085064090088005008000	\N	N	2016-01-21 02:20:36	2016-01-21 02:20:36	\N	\N	Y	N	N	\N	Y	123456	marlaross	\N	marlaross	default1324657089.png	0
1137	15	mmp81878@uga.edu	006073000069078079095094085036	\N	N	2016-11-29 05:18:30	2016-11-29 05:18:30	\N	\N	Y	N	N	\N	Y	123456	plummerwoo	\N	Melanie	plummerwoo_1.jpeg	3
48	15	rjc@uga.edu	087085088084066074094001115115119	\N	N	2015-11-08 20:35:50	2015-11-08 20:35:50	\N	\N	Y	N	N	\N	Y		joeyc	\N	joeyc	default1324657089.png	0
68	30	aperez25@uab.edu	117121000003007006007	\N	N	2015-12-02 21:12:41	2015-12-02 21:12:41	\N	\N	Y	N	N	\N	Y		aperezreynoso 	\N	aperezreynoso 	default1324657089.png	0
1138	15	snr58185@uga.edu	095082064065094082079009000113	\N	N	2016-11-29 13:25:10	2016-11-29 13:25:10	\N	\N	Y	N	N	\N	Y	123456	sarahroon	\N	sarahroon	default1324657089.png	0
1141	15	gee31641@uga.edu	088095082093088087006010010	\N	N	2016-11-29 17:41:14	2016-11-29 17:41:14	\N	\N	Y	N	N	\N	Y	5	gee31641	\N	gee31641	default1324657089.png	0
56	15	callene@uga.edu	038067083087006005007000	\N	N	2015-11-09 21:31:27	2015-11-09 21:31:27	\N	\N	Y	N	N	\N	Y	381c0fdc553d91b3558a9b54355408091ebf6f11421821f2daab7357a17f1d85	callenellen	\N	callenellen	default1324657089.png	0
1139	15	jvv32078@uga.edu	123095091067083078087076002116	\N	N	2016-11-29 14:57:09	2016-11-29 14:57:09	\N	\N	Y	N	N	\N	Y	123456	JenniferV	\N	JenniferV	default1324657089.png	0
57	15	tcrom@uga.edu	057038080000003005002	\N	N	2015-11-09 22:11:03	2015-11-09 22:11:03	\N	\N	Y	N	N	\N	Y	23287da9ba58390e6f35fb083c41ac5b76ae1f7bf07d3b2354c323bd60cf7085	tcromwell	\N	tcromwell	default1324657089.png	0
1140	15	suhaniv@uga.edu	089084088080087077066036039114118118	\N	N	2016-11-29 16:05:48	2016-11-29 16:05:48	\N	\N	Y	N	N	\N	Y	123456	suhaniv	\N	suhaniv	default1324657089.png	0
183	16	john3@gmail.com	107123127120	\N	N	2015-12-22 10:56:26	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y		john3	APA91bHI-eaeTIjzwEJxVVIIPwXarlEccdWLABRIHM1B0MUWdUUPjGg6NJwD6yCcMoinyWpSMJN4SCLxBCUzm7m5qReDu_0YaiRzAWgNw-KrXW_6ISQkChMf2V45Zz8barPWeKvIg1QF	john3	default1324657089.png	0
81	30	jfrye002@uab.edu	043094087074082071079082	\N	N	2015-12-04 17:54:07	2015-12-04 17:54:07	\N	\N	Y	N	N	\N	Y	123456	Joey	\N	Joey	default1324657089.png	0
72	18	jcraft5@students.kennesaw.edu	112082071080084086084085002115	\N	N	2015-12-04 14:18:06	2016-09-20 23:59:26	Administrator	50.150.17.28	Y	N	N	\N	N	123456	jcraft5	\N	jcraft5	default1324657089.png	0
121	41	memurray@live.unc.edu@live.unc.edu	004092071065070084079006	\N	N	2015-12-08 02:55:10	2015-12-08 02:55:10	Administrator	198.143.57.65	Y	N	N	\N	Y	6cabff14cd1b1707697b58ccfc91627b3e90a7f19795054fd2f24cb7df3b9f9c	emurray	\N	emurray	default1324657089.png	0
122	15	reidwr3@uga.edu	044084093068089084088004	\N	N	2015-12-08 07:24:56	2015-12-08 07:24:56	\N	\N	Y	N	N	\N	N	123456	reidwr3	\N	reidwr3	default1324657089.png	0
119	14	mjgouge@valdosta.edu	126094082089066095092001120123119	\N	N	2015-12-08 01:06:30	2015-12-08 01:06:30	\N	\N	Y	N	N	\N	Y		mjgouge	\N	mjgouge	default1324657089.png	0
140	18	amiramon@students.kennesaw.edu	045057050069091093	\N	N	2015-12-09 15:46:43	2015-12-09 15:46:43	\N	\N	Y	N	N	\N	Y		amiramon	\N	amiramon	default1324657089.png	0
1142	15	djb61918@uga.edu	118070071065095089008014009096	\N	N	2016-11-29 18:55:19	2016-11-29 18:55:19	\N	\N	Y	N	N	\N	N	123456	epicdbo	\N	epicdbo	default1324657089.png	0
883	15	khb58606@uga.edu	097087082090064066025009008	\N	N	2016-09-03 21:54:07	2016-09-03 21:54:07	\N	\N	Y	N	N	\N	Y	123456	KarinaB17	\N	KarinaB17	default1324657089.png	0
1143	15	vew74673@uga.edu	050088074091093089090068	\N	N	2016-11-29 20:29:52	2016-11-29 20:29:52	\N	\N	Y	N	N	\N	Y	123456	victoriawagner	\N	victoriawagner	default1324657089.png	0
1144	15	hdp58646@uga.edu	017068086086070002003022	\N	N	2016-11-29 21:02:19	2016-11-29 21:02:19	\N	\N	Y	N	N	\N	Y	123456	hpuder75	\N	hpuder75	default1324657089.png	0
131	29	mnesmit2@westga.edu	126084091082075000004116116116118100	\N	N	2015-12-09 12:28:23	2015-12-09 12:28:23	\N	\N	Y	N	N	\N	N	b7f687a2c18015465ffe79efc5f288acfd82916fe6a047bc68016ec118877364	Marysa	\N	Marysa	default1324657089.png	0
146	47	jcgresha@go.olemiss.edu	046032073070086070007	\N	N	2015-12-09 21:24:24	2015-12-09 21:24:24	\N	\N	Y	N	N	\N	Y	018abedaa89e7e3ec275e22f942cec9898da91f3e8c8e5031330e9da99cd5e1b	jcgresha2	\N	jcgresha2	default1324657089.png	0
123	50	mdavism@stedwards.edu	035080065086086084090091	\N	N	2015-12-08 15:47:26	2015-12-08 15:47:26	\N	\N	Y	N	N	\N	Y		mdavis	\N	mdavis	default1324657089.png	0
124	50	zweston@stedwards.edu	059041050069000010	\N	N	2015-12-08 16:49:20	2015-12-08 16:49:20	\N	\N	Y	N	N	\N	Y		Zane29	\N	Zane29	default1324657089.png	0
126	14	clglisson@valdosta.edu	115083064081087087091084014	\N	N	2015-12-08 19:10:24	2015-12-08 19:10:24	Administrator	198.143.47.1	Y	N	N	\N	Y	\N	cglisson7	\N	cglisson7	default1324657089.png	0
142	18	nschwar1@students.kennesaw.edu	038067087086090004004004	\N	N	2015-12-09 15:50:17	2015-12-09 15:50:17	\N	\N	Y	N	N	\N	Y	15d0f25098c43ab7ee9a42093a3c1eb8e7b23df2196aef11f6ef99db25ae7c04	nmschwarz 	\N	nmschwarz 	default1324657089.png	0
127	15	taty485@uga.edu	094070066088079085074088068059	\N	N	2015-12-08 19:39:11	2015-12-08 19:39:11	\N	\N	Y	N	N	\N	Y	8c8c9ac34f2d8e50f17ea06695301c78d5337980a01725e99a9b4be6edf1d1d9	Taty485	\N	Taty485	default1324657089.png	0
128	18	jpeter79@students.kennesaw.edu	093084091006094086072056047034042107	\N	N	2015-12-08 21:14:58	2015-12-08 21:14:58	\N	\N	Y	N	N	\N	Y	5	jpeter79	\N	jpeter79	default1324657089.png	0
129	18	afranzen @students.kennesaw.edu	006080070092070070007002	\N	N	2015-12-08 22:10:53	2015-12-08 22:10:53	\N	\N	Y	N	N	\N	N	123456	a.franzen19	\N	a.franzen19	default1324657089.png	0
120	41	memurray@live.unc.edu	080085071089091081087081096115115	\N	Y	2015-12-08 02:50:20	2015-12-09 00:00:00	Administrator	198.143.47.33	Y	N	N	\N	N	123456	memurray 	\N	memurray 	default1324657089.png	0
132	47	blgallow@olemiss.edu	062036083087095071004	\N	N	2015-12-09 12:30:28	2015-12-09 12:30:28	\N	\N	Y	N	N	\N	N	123456	brockgalloway	\N	brockgalloway	default1324657089.png	0
137	15	lju34561@uga.edu	121126114002011000	\N	N	2015-12-09 15:34:29	2015-12-09 15:34:29	\N	\N	Y	N	N	\N	Y	404df605deb236de3aae6691361c6a390e0199031b51fea24f71cbc5226cc178	lucieurk	\N	lucieurk	default1324657089.png	0
133	18	ddemery1@students.kennesaw.edu	092083074006003007014001010	\N	N	2015-12-09 12:57:52	2015-12-09 12:57:52	\N	\N	Y	N	N	\N	Y	57a547c0c7a67f7b90f1ddbbc916718c236b108763aeac3a02c59857c38e4f5f	dani	\N	dani	default1324657089.png	0
136	18	agriff69@students.kennesaw.edu	086092070092069064081084067112	\N	N	2015-12-09 15:32:15	2015-12-09 15:32:15	\N	\N	Y	N	N	\N	Y		agriff69	\N	agriff69	default1324657089.png	0
16	15	caydenc@uga.edu	035067083087006005007000	\N	N	2016-02-06 20:16:33	2016-02-06 20:16:33	\N	\N	Y	N	N	\N	N	123456	ccook	\N	ccook	default1324657089.png	0
1145	15	djm40214@uga.edu	067085065068094087077002113115118	\N	N	2016-11-30 02:04:57	2016-11-30 02:04:57	\N	\N	Y	N	N	\N	Y	123456	Deyoncé	\N	Deyoncé	Deyoncé_1.jpeg	0
134	18	ahuggin8@students.kennesaw.edu	066071093071093095089093011	\N	N	2015-12-09 13:01:13	2015-12-09 13:01:13	\N	\N	Y	N	N	\N	Y	0414b5721cf061bc61ab1c886bda27e4c75502296c40bde07bbeeb152081811a	Alexis	\N	Alexis	default1324657089.png	0
141	18	dwood27@students.kennesaw.edu	037088093065000004006005	\N	N	2015-12-09 15:48:01	2015-12-09 15:48:01	\N	\N	Y	N	N	\N	N		dwood27	\N	dwood27	default1324657089.png	0
139	21	afernandez18@student.gsu.edu	117091082094126093074119112112116125	\N	N	2015-12-09 15:37:59	2015-12-09 15:37:59	\N	\N	Y	N	N	\N	Y	123456	afernandez18 	\N	afernandez18 	default1324657089.png	0
152	22	jwcombs @emory.edu	066086085071090078009010009118	\N	N	2015-12-10 02:30:31	2015-12-10 02:30:31	\N	\N	Y	N	N	\N	N	123456	jwcombs15	\N	jwcombs15	default1324657089.png	0
138	18	cmccoma2@students.kennesaw.edu	089086090091083068089078001115	\N	N	2015-12-09 15:36:31	2015-12-09 15:36:31	\N	\N	Y	N	N	\N	Y		Caitlyn.mccomas	\N	Caitlyn.mccomas	default1324657089.png	0
144	57	mjenni20@student.scad.edu	042057037086091086	\N	N	2015-12-09 17:49:31	2015-12-09 17:49:31	\N	\N	Y	N	N	\N	Y	123456	Morgana 	\N	Morgana 	default1324657089.png	0
151	15	kathrine@uga.edu	048070087065064076007005	\N	N	2015-12-10 02:01:21	2015-12-10 02:01:21	\N	\N	Y	N	N	\N	Y		katmcil	\N	katmcil	default1324657089.png	0
150	30	dplaxco1@uab.edu	100081081081006079086066053042114	\N	N	2015-12-10 00:29:13	2015-12-10 00:29:13	\N	\N	Y	N	N	\N	Y	069fbc6142f433f4010ac2cc1df94405390eb9beac222bf3ece3403de48a59dc	dplaxco1	\N	dplaxco1	default1324657089.png	0
538	23	Rahees@bobcats.gcsu.edu	121124124113001	\N	N	2016-06-13 10:25:20	2016-06-13 10:25:20	\N	\N	Y	N	N	\N	N	5	khan	\N	khan	default1324657089.png	0
148	23	Joseph.owens@bobcats.gcsu.edu	051068084070071006007002	\N	N	2015-12-09 23:42:08	2015-12-09 23:42:08	\N	\N	Y	N	N	\N	Y	e75a21f709774467e4f34b81160e3a6cd655e5312b4ff3e4ddeccc65a509f3e0	jco315	\N	jco315	default1324657089.png	0
147	14	aperezreynoso@valdosta.edu	117121000003007006007	\N	N	2015-12-09 22:05:57	2015-12-09 22:05:57	\N	\N	Y	N	N	\N	Y		apr25	\N	apr25	default1324657089.png	0
149	23	Caitlyn.dillman@bobcats.gcsu.edu	053080081092071006002002	\N	N	2015-12-10 00:01:54	2015-12-10 00:01:54	\N	\N	Y	N	N	\N	Y	0edfb372e10955beb929726adfe234bf4942c5a2b9b1190608bf04f6fe1864b7	cdillman	\N	cdillman	default1324657089.png	0
170	15	kjw88418@uga.edu	051094081088091091007003	\N	N	2015-12-14 02:13:59	2015-12-14 02:13:59	\N	\N	Y	N	N	\N	Y	ec0fb9a355ab746fb95463e5e1596b56e802afa61f4101e1a849bf3a086f97fe	katiej1495	\N	katiej1495	default1324657089.png	0
154	14	Mireed@valdosta.edu	012088003007002001093082	\N	N	2015-12-10 02:41:21	2015-12-10 02:41:21	\N	\N	Y	N	N	\N	N	b320d71abd04a13d8146f0f99586caacf12d73a7ca17224cdf2f4dc6e9fb1c98	Mireed	\N	Mireed	default1324657089.png	0
155	47	blgallow@go.olemiss.edu	062036083087095071004	\N	N	2015-12-10 04:14:59	2015-12-10 04:14:59	\N	\N	Y	N	N	\N	N	123456	brockg	\N	brockg	default1324657089.png	0
153	19	jc02834@georgiasouthern.edu	066086085071090078009010009118	\N	N	2015-12-10 02:31:28	2015-12-10 02:31:28	\N	\N	Y	N	N	\N	Y		jwcombs12	\N	jwcombs12	default1324657089.png	0
156	14	mitking@valdosta.edu	115094082078080068068001013	\N	N	2015-12-10 14:30:36	2015-12-10 14:30:36	\N	\N	Y	N	N	\N	Y		kingers15	\N	kingers15	default1324657089.png	0
125	18	ccantr31@students.kennesaw.edu	043035046083087065	\N	N	2015-12-08 17:59:16	2015-12-08 17:59:16	\N	\N	Y	N	N	\N	Y	072c257b0c0fabf580f57e704150734b2b8bc88658e3dcecf8cdc4354c066a5a	ccantr31	\N	ccantr31	default1324657089.png	0
157	21	kwise10@student.gsu.edu	067068081071066078072088084112	\N	N	2015-12-10 16:14:27	2015-12-10 16:14:27	\N	\N	Y	N	N	\N	Y		Kristy	\N	Kristy	default1324657089.png	0
158	15	colef21@uga.edu	000002086084069082090088092045	\N	N	2015-12-10 17:31:34	2015-12-10 17:31:34	\N	\N	Y	N	N	\N	N		colef21	\N	colef21	default1324657089.png	0
130	18	afranzen@students.kennesaw.edu	006080070092070070007002	\N	N	2015-12-08 22:41:31	2015-12-08 22:41:31	\N	\N	Y	N	N	\N	Y		a.franzen1019	\N	a.franzen1019	default1324657089.png	0
159	53	kbetterson@oglethorpe.edu	096092092069095083088082046032114	\N	N	2015-12-10 20:32:34	2015-12-10 20:32:34	\N	\N	Y	N	N	\N	Y		KaylaB	\N	KaylaB	default1324657089.png	0
161	54	Sbarnett @cn.edu	117087069093089069020011009	\N	N	2015-12-10 21:57:34	2015-12-10 21:57:34	\N	\N	Y	N	N	\N	N	0c7c434f8b93e0f5434930d985527fed730cd27e4749a09a7684e5b98d5f6a20	Sbarnett	\N	Sbarnett	default1324657089.png	0
160	15	jcoffin@uga.edu	047035046093091092	\N	N	2015-12-10 21:13:16	2015-12-10 21:13:16	\N	\N	Y	N	N	\N	Y		jcoffin	\N	jcoffin	default1324657089.png	0
163	14	jaracena@valdosta.edu	123095082005004006005001010	\N	N	2015-12-10 22:04:20	2015-12-10 22:04:20	\N	\N	Y	N	N	\N	Y	86d420b833fb73d4127a74f1ad5429e611d73eaf925096ff157f1a15b2231227	Jaracena	\N	Jaracena	default1324657089.png	0
165	30	ejogodo@uab.edu	062032072080082088089	\N	N	2015-12-11 02:24:49	2015-12-11 02:24:49	\N	\N	Y	N	N	\N	Y	cfff21d807c51ca10dd7db7f91c84550dbcbe945be236100a22f7046d65fd76b	EjOgodo	\N	EjOgodo	default1324657089.png	0
166	30	rcottrell@uab.edu	051080081090090082006000	\N	N	2015-12-11 17:40:03	2015-12-11 17:40:03	\N	\N	Y	N	N	\N	N	123456	bluejireh	\N	bluejireh	default1324657089.png	0
164	19	mm08630@georgiasouthern.edu	010084092073093080003022	\N	N	2015-12-11 01:45:13	2015-12-11 01:45:13	\N	\N	Y	N	N	\N	Y		kenziebride	\N	kenziebride	default1324657089.png	0
162	54	Sbarnett@cn.edu	117087069093089069020011009	\N	N	2015-12-10 21:59:31	2015-12-10 21:59:31	\N	\N	Y	N	N	\N	Y	123456	Sbarnett 	\N	Sbarnett 	default1324657089.png	0
168	27	tkim10@crimson.ua.edu	056044090064092088089	\N	N	2015-12-11 22:03:56	2015-12-11 22:03:56	\N	\N	Y	N	N	\N	Y	5	tmkroll	\N	tmkroll	default1324657089.png	0
169	14	larockett@valdosta.edu	065091086093082076077008114123112	\N	N	2015-12-12 01:59:40	2015-12-12 01:59:40	\N	\N	Y	N	N	\N	N	123456	larockett	\N	larockett	default1324657089.png	0
179	14	ciglenn@valdosta.edu	099091069070078091086066047112113	\N	N	2015-12-21 21:04:46	2015-12-21 21:04:46	\N	\N	Y	N	N	\N	Y	5	igis44	\N	igis44	default1324657089.png	0
27	15	crw57890@uga.edu	087066087091092075085049115118119118	\N	N	2016-02-09 14:28:06	2016-02-09 14:28:06	\N	\N	Y	N	N	\N	N	123456	crw57890	\N	crw57890	default1324657089.png	0
174	15	jspitts@uga.edu	118008006006013002116014	\N	N	2015-12-16 04:30:16	2015-12-16 04:30:16	\N	\N	Y	N	N	\N	Y		jspitts	\N	jspitts	default1324657089.png	0
167	30	kime@uab.edu	039067091087085076015001	\N	N	2015-12-11 19:56:07	2015-12-11 19:56:07	\N	\N	Y	N	N	\N	Y		ekim12	\N	ekim12	default1324657089.png	0
186	15	antoniobell@uga.edu	022088065087091088004004	\N	N	2015-12-25 18:57:52	2015-12-25 18:57:52	\N	\N	Y	N	N	\N	N	123456	abell816	\N	abell816	default1324657089.png	0
171	15	murtso@uga.edu	089086090091083083065008002114	\N	N	2015-12-15 03:57:49	2015-12-15 03:57:49	\N	\N	Y	N	N	\N	Y	5192153b2d335ee21cd48e5a40a774749a84959c39d345df7dd3d34c2ee21baf	murtso	\N	murtso	default1324657089.png	0
172	38	anorris2@ggc.edu	044080075001006005006015	\N	N	2015-12-15 16:51:40	2015-12-15 16:51:40	\N	\N	Y	N	N	\N	Y	5	ashleymae93	\N	ashleymae93	default1324657089.png	0
173	15	ocn49337@uga.edu	083071095088081089080027008	\N	N	2015-12-15 18:35:11	2015-12-15 18:35:11	\N	\N	Y	N	N	\N	Y	47c7619646061d0ebb7d67aa8a72f8988a5e29f815e3a71a0398a1e9e09e1b26	carsonnevels	\N	carsonnevels	default1324657089.png	0
177	15	rachael@uga.edu	087081070095080086092066114115112	\N	N	2015-12-17 12:35:40	2015-12-17 12:35:40	\N	\N	Y	N	N	\N	N	123456	rachaelmidler	\N	rachaelmidler	default1324657089.png	0
178	18	bfarmer6@students.kennesaw.edu	121064084074064032049048051042052035122104	\N	N	2015-12-19 01:31:58	2015-12-19 01:31:58	\N	\N	Y	N	N	\N	Y		bfarmer6	\N	bfarmer6	default1324657089.png	0
175	15	ska53792@uga.edu	045032052090093006	\N	N	2015-12-16 05:19:30	2015-12-16 05:19:30	\N	\N	Y	N	N	\N	Y		ska53792	\N	ska53792	default1324657089.png	0
185	15	gfuller@uga.edu	080082071080084086084085002112	\N	N	2015-12-24 00:28:39	2015-12-24 00:28:39	\N	\N	Y	N	N	\N	Y		gfuller	\N	gfuller	default1324657089.png	0
187	15	jwh3@uga.edu	086087082065077090068077008	\N	N	2015-12-29 02:59:48	2015-12-29 02:59:48	\N	\N	Y	N	N	\N	N	123456	jwhawkins3	\N	jwhawkins3	default1324657089.png	0
17	15	zcs55397@uga.edu	113070080081090082075011001114	\N	N	2016-02-07 00:05:44	2016-02-07 00:05:44	\N	\N	Y	N	N	\N	N	123456	zsanchez	\N	zsanchez	default1324657089.png	0
199	15	djh68924@uga.edu	005089065065085093005014	\N	N	2016-01-12 02:24:08	2016-01-12 02:24:08	\N	\N	Y	N	N	\N	Y	9d224dcfdc3480a542dced5b21959da90353407737675b0a485974cddc2631ca	djherr	\N	djherr	default1324657089.png	0
13	14	jps@valdosta.edu	043045032045066	\N	N	2015-10-02 20:58:35	2015-10-02 20:58:35	\N	\N	Y	N	N	\N	N	5	jps200	\N	jps200	default1324657089.png	0
96	14	atewksbury@troy.edu@valdosta.edu	000011011001086094082078064	\N	N	2015-12-05 00:59:17	2015-12-05 00:59:17	\N	\N	Y	N	N	\N	Y		atewksbury	\N	atewksbury	default1324657089.png	0
36	15	mwright5@uga.edu	045080081065091070069082	\N	N	2015-11-06 18:47:53	2015-11-06 18:47:53	\N	\N	Y	N	N	\N	Y		mwright5	\N	mwright5	default1324657089.png	0
31	15	dcs66897@uga.edu	116081090068080081088004115113119	\N	N	2015-11-06 14:29:04	2015-11-06 14:29:04	\N	\N	Y	N	N	\N	Y		dcs4234	\N	dcs4234	default1324657089.png	0
32	15	grace.langella@uga.edu	063057047095075087	\N	N	2015-11-06 15:04:49	2015-11-06 15:04:49	\N	\N	Y	N	N	\N	Y	1478169d94002919dd7211beba8759d9270b44bb286fbbb1676da0187cf78da1	glangella	\N	glangella	default1324657089.png	0
103	38	hmckenzie@ggc.edu	001000002002004006116093091	\N	N	2015-12-05 20:42:11	2015-12-05 20:42:11	\N	\N	Y	N	N	\N	Y	7f61a1ffc7d89576e92c86c8ff6fa946cafe39b48cca2a0d3503af1d59973a84	hmckenzie	\N	hmckenzie	default1324657089.png	0
99	15	seeling1@uga.edu	038116125065115124119015	\N	N	2015-12-05 12:47:59	2015-12-05 12:47:59	\N	\N	Y	N	N	\N	Y	84de6f957331fa227adadaa9727fa37010b9ea148686cbda83bf57e9623901a5	seedlings	\N	seedlings	default1324657089.png	0
1117	55	most.live2014@tamu.edu	066070074088080069006010010	\N	N	2016-10-30 14:27:33	2016-10-30 14:27:33	\N	\N	Y	N	N	\N	N	123456	buy.T-shirts	\N	buy.T-shirts	default1324657089.png	0
182	16	john2@gmail.com	107123127120	\N	N	2015-12-22 10:54:19	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y		john2	\N	john2	default1324657089.png	0
1	15	cth57756@uga.edu	080070087094091086075077085051	\N	N	2016-02-01 19:39:08	2016-02-01 19:39:08	\N	\N	Y	N	N	\N	Y	123456	Charlie	\N	Charlie	default1324657089.png	0
225	15	jstang3@uga.edu	038036066065090081004	\N	N	2016-01-31 22:17:57	2016-01-31 22:17:57	\N	\N	Y	N	N	\N	Y	123456	jstang	\N	jstang	default1324657089.png	0
28	15	khs61074@uga.edu	087094090087094067085087091	\N	N	2015-11-06 06:04:45	2015-11-06 06:04:45	\N	\N	Y	N	N	\N	Y	fd4dc2e219e7870034f9c2153b24e25fc9d977fc258b8f2b30cfcc69d4da03bc	karlynsuggs	\N	karlynsuggs	default1324657089.png	0
29	15	jat57002@uga.edu	091083094093080003006001015	\N	N	2015-11-06 13:53:19	2015-11-06 13:53:19	\N	\N	Y	N	N	\N	Y		jatuggle	\N	jatuggle	default1324657089.png	0
34	15	calendar@uga.edu	027040095065071091091	\N	N	2015-11-06 15:18:43	2015-11-06 15:18:43	\N	\N	Y	N	N	\N	N		callenstapleton	\N	callenstapleton	default1324657089.png	0
116	15	sls713@uga.edu	063045066006004002005	\N	N	2015-12-07 13:58:39	2015-12-07 13:58:39	\N	\N	Y	N	N	\N	Y		bulldawgsls	\N	bulldawgsls	default1324657089.png	0
37	15	cbailey3@uga.edu	047088089086002007003004	\N	N	2015-11-06 18:50:39	2015-11-06 18:50:39	\N	\N	Y	N	N	\N	Y		cbailey3	\N	cbailey3	default1324657089.png	0
35	15	sjaipaul@uga.edu	060046094089090013000	\N	N	2015-11-06 15:25:10	2015-11-06 15:25:10	\N	\N	Y	N	N	\N	Y	dc081ae230db7451b9eb6176e6449843aeff140547b8b8f544333475a2d47cd2	stephjaipaul	\N	stephjaipaul	default1324657089.png	0
38	15	rmw90584@uga.edu	087083094093089079006011014	\N	N	2015-11-06 18:59:17	2015-11-06 18:59:17	\N	\N	Y	N	N	\N	Y	833a94522e6871af02cef8f93411a6abbfe871dc29360edcf11ec924cb34a527	rmw90584	\N	rmw90584	default1324657089.png	0
300	39	bhargav1111@appstate.edu	040	\N	N	2016-02-10 14:41:07	2016-02-10 14:41:07	\N	\N	Y	N	N	\N	N	5	bhagsss	\N	bhagsss	default1324657089.png	0
658	15	kegold@uga.edu	069090092065082094067009010	\N	N	2016-08-12 14:47:29	2016-08-12 14:47:29	\N	\N	Y	N	N	\N	Y	123456	kegold	\N	kegold	default1324657089.png	0
40	15	jmacer@uga.edu	018088082076070089089009009	\N	N	2015-11-06 20:35:45	2015-11-06 20:35:45	\N	\N	Y	N	N	\N	Y	38492759251e11c0cba9c93d9bb626be568ebbf766a4e3314c79a44a89913a3b	jmacer	\N	jmacer	default1324657089.png	0
101	27	fgthomas@crimson.ua.edu	037068084085091090069006	\N	N	2015-12-05 15:29:04	2015-12-05 15:29:04	\N	\N	Y	N	N	\N	Y	4b15122ab5d3f8b6c6e0e0a1387eaea93f9bcaa5881e6d0ead80d45b0b5127e4	fgthomas	\N	fgthomas	default1324657089.png	0
42	15	bwb45193@uga.edu	086087087079086086082085036049116	\N	N	2015-11-06 23:22:56	2015-11-06 23:22:56	\N	\N	Y	N	N	\N	Y	66925d6159999461eb321b7bf3f0d79cc671b9678ede38162d9517814eb52f6c	BBurkett7	\N	BBurkett7	default1324657089.png	0
43	15	men28195@uga.edu	064081086076078089051046038054116116102	\N	N	2015-11-06 23:37:57	2015-11-06 23:37:57	\N	\N	Y	N	N	\N	Y	0c7f1bfe4357e6e0dec947fd5559d01eb1629c496e63fa3d90d34204c968b091	maryelizabeth	\N	maryelizabeth	default1324657089.png	0
44	15	minth@uga.edu	120008002007012004007090	\N	N	2015-11-07 00:18:05	2015-11-07 00:18:05	\N	\N	Y	N	N	\N	Y	ce4417ba451951902085b0f44c34d7d750a75b840e9e9ec4a804ecd515865aba	mkvinth	\N	mkvinth	default1324657089.png	0
45	15	cpb35658@uga.edu	127091067083067076013000113114098	\N	N	2015-11-07 04:29:15	2015-11-07 04:29:15	\N	\N	Y	N	N	\N	Y	0b900cc4a2e41a24222d408f075cd58f22f20993fb489fc51985bc3443e230e2	carolinepbarry	\N	carolinepbarry	default1324657089.png	0
102	45	Moorekk@goldmail.etsu.edu	113008001006003007125090	\N	N	2015-12-05 17:52:54	2015-12-05 17:52:54	\N	\N	Y	N	N	\N	Y	559fc43a149436befa6cb7a3d8d77a7b24fb64bfcbf267e14ce096e9b944984d	kelsiem28	\N	kelsiem28	default1324657089.png	0
200	15	lumsden@uga.edu	052086083002006006002002	\N	N	2016-01-12 03:35:41	2016-01-12 03:35:41	\N	\N	Y	N	N	\N	N	123456	rachellumsden	\N	rachellumsden	default1324657089.png	0
190	41	acpeat@live.unc.edu	094082087071089068075092002121	\N	N	2016-01-05 01:59:59	2016-01-05 01:59:59	\N	\N	Y	N	N	\N	Y	7e5d24b08bed97cf39f16dff5ef769a99f461d18043e7f5a459f539ecef6453c	acpeat	\N	acpeat	default1324657089.png	0
203	15	Fransuave.moore@uga.edu	001004005004003013074091046045047	\N	N	2016-01-16 18:06:53	2016-01-16 18:06:53	\N	\N	Y	N	N	\N	Y	123456	Fransuave	\N	Fransuave	default1324657089.png	0
191	55	jtuck17@tamu.edu	080065093065066086086064001118	\N	N	2016-01-05 02:01:18	2016-01-05 02:01:18	\N	\N	Y	N	N	\N	Y	38b79106840e1a92e23ed50d0569dd17f17d75e357bc5505199bc7c8d24493cc	jtuck17	\N	jtuck17	default1324657089.png	0
1119	31	sumthing@ufl.edu	050094095071092092088080	\N	N	2016-11-04 08:10:55	2016-11-04 08:10:55	\N	\N	Y	N	N	\N	N	5	sumthing	\N	sumthing	default1324657089.png	0
30	15	shell27@uga.edu	088095067081071095086084024	\N	N	2015-11-06 14:26:46	2015-11-06 14:26:46	\N	\N	Y	N	N	\N	Y		shell27		shell27	default1324657089.png	0
207	15	jtw66563@uga.edu	065094069081095068050041044043041119118	\N	N	2016-01-18 17:30:37	2016-01-19 00:44:05	Administrator	198.143.47.1	Y	N	N	\N	Y	123456	JosheyWashie	\N	JosheyWashie	default1324657089.png	0
192	18	hparshal@students.kennesaw.edu	037045072090094068007	\N	N	2016-01-06 03:52:33	2016-01-06 03:52:33	\N	\N	Y	N	N	\N	Y	5	hailie_	APA91bF_ahBr5GZ0JEwqBhEjnH8EAhb-_zxPIPlACQj9YJx0J1eh_pGmaV-9P0s73BvmSSsljx7ZtICI9jIh6kIIP1tFEqt9YL9JlTcYBVuYYFlhGbd8HlXNCiJWUs4X5-tSPadENvJQ	hailie_	default1324657089.png	0
189	55	rcdolezal@tamu.edu	039088065091091091004006	\N	N	2016-01-04 01:42:56	2016-01-04 01:42:56	\N	\N	Y	N	N	\N	Y		Ryan.Dolezal.	\N	Ryan.Dolezal.	default1324657089.png	0
193	14	cngibbs@valdosta.edu	103093089069076087085056118119118113	\N	N	2016-01-06 06:00:09	2016-01-06 06:00:09	\N	\N	Y	N	N	\N	Y	5	cngibbs	APA91bE20dkfq5XYaKil29Tyh-0uxqiaug8ym8H9V23zvpQg_roXJE6H0nMNbpeihe-59GfH-R2VcKqwVzKhokgnp_u-r0uLodNH8KonJ0H37lCHLui6myaHxcA7O9X6kbetk4qYSFgq	cngibbs	default1324657089.png	0
195	15	gat12183@uga.edu	070091091088087068083080084115	\N	N	2016-01-07 21:29:55	2016-01-07 21:29:55	\N	\N	Y	N	N	\N	Y	5	gat12183	APA91bEhR6EQCjfsjD1rJa94Zizg_fmg5zckiHIJ3vdLt12z32b7r0pSnUEmxOQy8UweS4D61k0Xw2VGOw-fbrlZacoatArnUf8cAXMCWahlzzYe2tnsA1f3TluItX_1MHxYPwSI4sBX	gat12183	default1324657089.png	0
4	15	hrf81293@uga.edu	121006011011092080068081	\N	N	2016-02-02 19:29:32	2016-02-02 19:29:32	\N	\N	Y	N	N	\N	Y	123456	ellie_fields	\N	ellie_fields	default1324657089.png	0
5	15	sko26121@uga.edu	092087068089080065006010010	\N	N	2016-02-03 15:06:55	2016-02-03 15:06:55	\N	\N	Y	N	N	\N	N	123456	sarakoshields	\N	sarakoshields	default1324657089.png	0
7	15	adm22084@uga.edu	124081120093070069094091082	\N	N	2016-02-05 01:37:44	2016-02-05 01:37:44	\N	\N	Y	N	N	\N	N	123456	adm22084	\N	adm22084	default1324657089.png	0
10	15	hellmanj @uga.edu	034043037067066064	\N	N	2016-02-05 18:57:16	2016-02-05 18:57:16	\N	\N	Y	N	N	\N	N	123456	julia4	\N	julia4	default1324657089.png	0
11	15	emily.smith@uga.edu	050092091071092092088084	\N	N	2016-02-06 17:58:02	2016-02-06 17:58:02	\N	\N	Y	N	N	\N	N	123456	emily	\N	emily	default1324657089.png	0
14	15	ees64448@uga.edu	050092091071092092088084	\N	N	2016-02-06 17:59:51	2016-02-06 17:59:51	\N	\N	Y	N	N	\N	N	123456	emilysmith	\N	emilysmith	default1324657089.png	0
19	15	sar31531@uga.edu	125115002006064085071	\N	N	2016-02-07 02:15:39	2016-02-07 02:15:39	\N	\N	Y	N	N	\N	N	123456	stephanierehberg	\N	stephanierehberg	default1324657089.png	0
20	15	ano33950@uga.edu	043036094064084093084	\N	N	2016-02-09 04:51:10	2016-02-09 04:51:10	\N	\N	Y	N	N	\N	N	123456	ano33950	\N	ano33950	default1324657089.png	0
21	15	Amanda.valentini25@uga.edu	045045059038066	\N	N	2016-02-09 04:55:32	2016-02-09 04:55:32	\N	\N	Y	N	N	\N	N	123456	amanda_valentini	\N	amanda_valentini	default1324657089.png	0
180	16	john@gmail.com	107123127120	\N	N	2015-12-22 03:48:08.933017	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y	5e99d6df273c944264be4338f8ec00a75a10e8a4466b24932ac330405044090d	john		john	default1324657089.png	0
212	15	john4@gmail.com	107123127120	\N	N	2015-01-21 10:54:19	2015-01-21 10:54:19	Administrator	\N	Y	N	N	\N	Y	\N	john4	\N	john4	default1324657089.png	0
214	15	bic28728@uga.edu	125091095088076082088095013	\N	N	2016-01-24 18:32:15	2016-01-24 18:32:15	\N	\N	Y	N	N	\N	Y	123456	carrollb	\N	carrollb	default1324657089.png	0
181	15	john1@gmail.com	116104122	\N	N	2015-12-22 10:52:07	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y		john1		john1	default1324657089.png	0
215	15	wna21116@uga.edu	114001007013015014011015007116	\N	N	2016-01-24 18:32:27	2016-01-24 18:32:27	\N	\N	Y	N	N	\N	Y	123456	wanderson717	\N	wanderson717	default1324657089.png	0
216	15	ldm59390@uga.edu	021067091067088080066006	\N	N	2016-01-24 23:11:31	2016-01-24 23:11:31	\N	\N	Y	N	N	\N	Y	123456	luis_mata3	\N	luis_mata3	default1324657089.png	0
217	15	egossett @uga.edu	038094065064081065066005	\N	N	2016-01-25 04:02:17	2016-01-25 04:02:17	\N	\N	Y	N	N	\N	N	123456	egossett 	\N	egossett 	default1324657089.png	0
211	14	rfredner@valdosta.edu	117120002002002004004	\N	N	2016-01-21 03:05:36	2016-01-21 03:05:36	\N	\N	Y	N	N	\N	Y	123456	regsred	\N	regsred	default1324657089.png	0
213	15	nrw86695@uga.edu	092083075068090065082074074	\N	N	2016-01-21 21:21:52	2016-01-21 21:21:52	\N	\N	Y	N	N	\N	Y	123456	nweinberg	\N	nweinberg	default1324657089.png	0
218	31	brycedavis@ufl.edu	112003086086081066009008	\N	N	2016-01-28 06:18:24	2016-01-28 06:18:24	\N	\N	Y	N	N	\N	N	123456	captaincrush	\N	captaincrush	default1324657089.png	0
219	15	ankerich@uga.edu	095081089070084085089085092116	\N	N	2016-01-28 16:20:07	2016-01-28 16:20:07	\N	\N	Y	N	N	\N	Y	123456	kyleankerich	\N	kyleankerich	default1324657089.png	0
220	53	ascott1 @oglethorpe.edu	063052082081086071070	\N	N	2016-01-28 22:58:33	2016-01-28 22:58:33	\N	\N	Y	N	N	\N	N	123456	ascott	\N	ascott	default1324657089.png	0
221	15	ns88401@uga.edu	097088081080066082074000006107	\N	N	2016-01-29 17:46:07	2016-01-29 17:46:07	\N	\N	Y	N	N	\N	Y	123456	nataliespeciale	\N	nataliespeciale	default1324657089.png	0
222	15	saeid.Safaei25@uga.edu	069090090000013001115113123118119114118	\N	N	2016-01-31 01:42:44	2016-01-31 01:42:44	\N	\N	Y	N	N	\N	Y	5	saeidalgorithm	\N	saeidalgorithm	default1324657089.png	0
223	15	mclark1@uga.edu	094067080088087077082032046047124116	\N	N	2016-01-31 01:54:11	2016-01-31 01:54:11	\N	\N	Y	N	N	\N	Y	123456	mclark1	\N	mclark1	default1324657089.png	0
224	15	mitch11@uga.edu	117000000006001087089085	\N	N	2016-01-31 09:50:20	2016-01-31 09:50:20	\N	\N	Y	N	N	\N	Y	123456	mitchgargosh	\N	mitchgargosh	default1324657089.png	0
1118	15	dsa12555@uga.edu	096064080064082082086082050112003	\N	N	2016-11-03 00:17:28	2016-11-03 00:17:28	\N	\N	Y	N	N	\N	Y	123456	drewaguilar	\N	drewaguilar	default1324657089.png	0
22	15	aav65099@uga.edu	045045059038066	\N	N	2016-02-09 05:00:52	2016-02-09 05:00:52	\N	\N	Y	N	N	\N	N	123456	amandav	\N	amandav	default1324657089.png	0
23	15	aav65090@uga.edu	045045059038066	\N	N	2016-02-09 05:01:07	2016-02-09 05:01:07	\N	\N	Y	N	N	\N	N	123456	amandavalentini	\N	amandavalentini	default1324657089.png	0
24	15	hnh69600@uga.edu	039067071085070064015000	\N	N	2016-02-09 06:21:59	2016-02-09 06:21:59	\N	\N	Y	N	N	\N	N	123456	hannahhannah	\N	hannahhannah	default1324657089.png	0
25	23	william.cochran@bobcats.gcsu.edu	046046083093081091004	\N	N	2016-02-09 06:38:15	2016-02-09 06:38:15	\N	\N	Y	N	N	\N	N	123456	bc20	\N	bc20	default1324657089.png	0
26	15	jcs35260@uga.edu	120092090091079091089065009096	\N	N	2016-02-09 13:03:37	2016-02-09 13:03:37	\N	\N	Y	N	N	\N	N	123456	jcs35260	\N	jcs35260	default1324657089.png	0
3	16	testby@gmail.com	116104122	\N	N	2016-02-02 10:18:42	2016-02-02 10:18:42	\N	\N	Y	N	N	\N	Y	12344	testetilox	\N	testetilox	default1324657089.png	0
301	39	bhargav1234@appstate.edu	040	\N	N	2016-02-10 14:41:35	2016-02-10 14:41:35	\N	\N	Y	N	N	\N	N	5	bhags1234	\N	bhags1234	default1324657089.png	0
302	39	dhhffghff@appstate.edu	040	\N	N	2016-02-10 14:42:07	2016-02-10 14:42:07	\N	\N	Y	N	N	\N	N	5	bhags12888	\N	bhags12888	default1324657089.png	0
303	26	martin@tigermail.auburn.edu	040	\N	N	2016-02-10 14:48:42	2016-02-10 14:48:42	\N	\N	Y	N	N	\N	N	5	martin	\N	martin	default1324657089.png	0
348	15	jrd05492@uga.edu	103086068086085091092036048114113100	\N	N	2016-02-16 01:13:41	2016-02-16 01:13:41	\N	\N	Y	N	N	\N	Y	123456	jrd05492	\N	jrd05492	default1324657089.png	0
305	15	sh19954@uga.edu	085086091071081094089000009098	\N	N	2016-02-10 18:31:46	2016-02-10 18:31:46	\N	\N	Y	N	N	\N	N	123456	spencethefence	\N	spencethefence	default1324657089.png	0
306	15	tjk@uga.edu	086087092070082095086009009	\N	N	2016-02-10 21:24:29	2016-02-10 21:24:29	\N	\N	Y	N	N	\N	N	5	TJK	\N	TJK	default1324657089.png	0
298	34	john@stu.jsu.edu	056040063041	\N	Y	2016-02-10 14:35:50	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	john123	\N	john123	default1324657089.png	0
296	17	dwhitt@gatech.edu	056040063041	\N	Y	2016-02-10 14:29:16	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	dwhitt	\N	dwhitt	default1324657089.png	0
294	58	joe@duke.edu	056040063041	\N	Y	2016-02-10 14:28:42	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	joe	\N	joe	default1324657089.png	0
295	58	mike@duke.edu	056040063041	\N	Y	2016-02-10 14:28:54	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	mike	\N	mike	default1324657089.png	0
304	15	mikey@uga.edu	056040063041	\N	Y	2016-02-10 14:56:06	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	mikey	\N	mikey	default1324657089.png	0
297	37	mmaa@ou.edu	056040063041	\N	Y	2016-02-10 14:30:52	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	123456	mmaa	\N	mmaa	default1324657089.png	0
62	39	test@appstate.edu	107123127120	\N	Y	2016-02-10 14:05:15	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	5	test	\N	test	default1324657089.png	0
63	39	test1@appstate.edu	107123127120	\N	Y	2016-02-10 14:06:26	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	5	test1	\N	test1	default1324657089.png	0
293	39	test12@appstate.edu	107123127120	\N	Y	2016-02-10 14:25:38	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	5	test22	\N	test22	default1324657089.png	0
291	39	test123@appstate.edu	107123127120	\N	Y	2016-02-10 14:24:58	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	5	test223	\N	test223	default1324657089.png	0
292	39	test124@appstate.edu	107123127120	\N	Y	2016-02-10 14:25:20	2016-02-11 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	5	test224	\N	test224	default1324657089.png	0
307	15	asm67579@uga.edu	064092071080079090093088084050	\N	N	2016-02-11 01:44:59	2016-02-11 01:44:59	\N	\N	Y	N	N	\N	N	123456	ameads	\N	ameads	default1324657089.png	0
308	49	coco@email.usca.edu	056040063041	\N	Y	2016-02-11 04:33:00	2016-02-11 00:00:00	Administrator	24.98.121.196	Y	N	N	\N	N	123456	coco	\N	coco	default1324657089.png	0
310	16	bhargav9542@gmail.com	040	\N	N	2016-02-11 06:41:40	2016-02-11 06:41:40	\N	\N	Y	N	N	\N	N	5	bbbb	\N	bbbb	default1324657089.png	0
311	16	abc@gmail.com	116104122	\N	N	2016-02-11 06:50:34	2016-02-11 06:50:34	\N	\N	Y	N	N	\N	N	123456	abc	\N	abc	default1324657089.png	0
314	16	testbyetilox@gmail.com	040	\N	N	2016-02-11 06:53:05	2016-02-11 06:53:05	\N	\N	Y	N	N	\N	N	123456	add	\N	add	default1324657089.png	0
312	44	petew@email.sc.edu	056040063041	\N	Y	2016-02-11 06:52:25	2016-02-11 00:00:00	Administrator	24.98.121.196	Y	N	N	\N	N	123456	petew	\N	petew	default1324657089.png	0
313	41	petew@live.unc.edu	056040063041	\N	Y	2016-02-11 06:52:57	2016-02-11 00:00:00	Administrator	24.98.121.196	Y	N	N	\N	N	123456	petewh	\N	petewh	default1324657089.png	0
339	15	dat00202@uga.edu	069083091093071007014001015	\N	N	2016-02-15 16:08:37	2016-02-15 16:08:37	\N	\N	Y	N	N	\N	Y	5	dtahir	\N	dtahir	default1324657089.png	0
316	15	art37307@uga.edu	068087076068041039049042039035043036044124106	\N	N	2016-02-11 16:40:12	2016-02-11 16:40:12	\N	\N	Y	N	N	\N	N	123456	alaya_tyler	\N	alaya_tyler	default1324657089.png	0
317	15	cbizze43011@uga.edu	092070083082083067076008002114	\N	N	2016-02-11 17:06:47	2016-02-11 17:06:47	\N	\N	Y	N	N	\N	N	123456	cassbizz	\N	cassbizz	default1324657089.png	0
318	15	hmg81955@uga.edu	009086011000005006015008	\N	N	2016-02-11 18:46:11	2016-02-11 18:46:11	\N	\N	Y	N	N	\N	Y	123456	hmg81955	\N	hmg81955	default1324657089.png	0
319	29	dgreene7@westga.edu	101091071085091069006010010	\N	N	2016-02-12 06:26:33	2016-02-12 06:26:33	\N	\N	Y	N	N	\N	N	123456	dgreene7	\N	dgreene7	default1324657089.png	0
320	15	mdovel@uga.edu	047032046068086010	\N	N	2016-02-13 03:55:43	2016-02-13 03:55:43	\N	\N	Y	N	N	\N	Y	123456	mdovel	\N	mdovel	default1324657089.png	0
321	15	jordanmcgriff@uga.edu	080070092091082092088071038112112	\N	N	2016-02-13 04:47:03	2016-02-13 04:47:03	\N	\N	Y	N	N	\N	Y	123456	JordanMcGriff	\N	JordanMcGriff	default1324657089.png	0
322	15	ebha@uga.edu	041053089064090082065	\N	N	2016-02-13 16:51:12	2016-02-13 16:51:12	\N	\N	Y	N	N	\N	Y	123456	bookworm	\N	bookworm	default1324657089.png	0
323	26	qwr@tigermail.auburn.edu	061059036067070074	\N	N	2016-02-13 17:20:51	2016-02-13 17:20:51	\N	\N	Y	N	N	\N	N	5	qery	\N	qery	default1324657089.png	0
324	15	acs72825@uga.edu	098093080087080068002015024	\N	N	2016-02-13 18:29:15	2016-02-13 18:29:15	\N	\N	Y	N	N	\N	Y	123456	Ashleystepanek	\N	Ashleystepanek	default1324657089.png	0
326	15	rha17891@uga.edu	006006002111092067053045045125112114102	\N	N	2016-02-13 18:52:08	2016-02-13 18:52:08	\N	\N	Y	N	N	\N	Y	123456	razahabidi	\N	razahabidi	default1324657089.png	0
327	15	jg06295@uga.edu	043080091095081091007001	\N	N	2016-02-13 18:56:08	2016-02-13 18:56:08	\N	\N	Y	N	N	\N	Y	123456	jg06295	\N	jg06295	default1324657089.png	0
328	15	jm19124@uga.edu	093081042045055037049046053033047062056039034033035	\N	N	2016-02-13 18:56:34	2016-02-13 18:56:34	\N	\N	Y	N	N	\N	Y	123456	Jmadd7	\N	Jmadd7	default1324657089.png	0
329	15	ktw06900@uga.edu	035094092086005005000015	\N	N	2016-02-13 19:02:38	2016-02-13 19:02:38	\N	\N	Y	N	N	\N	Y	123456	kyle.weber	\N	kyle.weber	default1324657089.png	0
325	45	pete@goldmail.etsu.edu	056040063041	\N	Y	2016-02-13 18:32:47	2016-02-13 00:00:00	Administrator	75.137.9.100	Y	N	N	\N	N	123456	bucwild	\N	bucwild	default1324657089.png	0
331	15	ajr80231@uga.edu	000095086065081070007006	\N	N	2016-02-13 23:33:42	2016-02-13 23:33:42	\N	\N	Y	N	N	\N	Y	123456	tony1096	\N	tony1096	default1324657089.png	0
333	15	jlinn@uga.edu	045088006001013000003002	\N	N	2016-02-14 12:21:44	2016-02-14 12:21:44	\N	\N	Y	N	N	\N	Y	123456	jonathanjlinn	\N	jonathanjlinn	default1324657089.png	0
332	15	apugh@uga.edu	059040086085095081070	\N	N	2016-02-14 07:20:05	2016-02-14 07:20:05	\N	\N	Y	N	N	\N	Y	123456	Ansley 	\N	Ansley 	default1324657089.png	0
334	15	jlc60983@uga.edu	121120114000005003	\N	N	2016-02-14 20:12:02	2016-02-14 20:12:02	\N	\N	Y	N	N	\N	Y	123456	josel7	\N	josel7	default1324657089.png	0
336	15	trj79589@uga.edu	051091093091090070089089	\N	N	2016-02-14 21:20:04	2016-02-14 21:20:04	\N	\N	Y	N	N	\N	Y	123456	Rjohnson1	\N	Rjohnson1	default1324657089.png	0
335	15	ebleau17@uga.edu	088094092066080092088075081	\N	N	2016-02-14 21:19:53	2016-02-14 21:19:53	\N	\N	Y	N	N	\N	Y	123456	ebleau	\N	ebleau	default1324657089.png	0
337	15	ahs52267@uga.edu	021116090091081074095047112123125115	\N	N	2016-02-14 21:23:37	2016-02-14 21:23:37	\N	\N	Y	N	N	\N	Y	123456	allison_hope14	\N	allison_hope14	default1324657089.png	0
338	15	jtw09802@uga.edu	098082088084082094086026002119	\N	N	2016-02-14 22:25:25	2016-02-14 22:25:25	\N	\N	Y	N	N	\N	Y	5	JamesTWilson	\N	JamesTWilson	default1324657089.png	0
402	15	mnp49552@uga.edu	091088086075095036018034040040035053123022	\N	N	2016-03-05 07:20:26	2016-03-05 07:20:26	\N	\N	Y	N	N	\N	Y	123456	momo101196	\N	momo101196	default1324657089.png	0
340	15	nlh34628@uga.edu	034089091080095080088068	\N	N	2016-02-16 00:40:43	2016-02-16 00:40:43	\N	\N	Y	N	N	\N	Y	123456	nora14	\N	nora14	default1324657089.png	0
343	15	edw65148@uga.edu	114064068085077074087040048047117100	\N	N	2016-02-16 00:41:24	2016-02-16 00:41:24	\N	\N	Y	N	N	\N	N	123456	lilwillis	\N	lilwillis	default1324657089.png	0
1120	15	ccw33173@uga.edu	090092070070083068009000009121	\N	N	2016-11-05 00:15:50	2016-11-05 00:15:50	\N	\N	Y	N	N	\N	N	123456	ccw1998	\N	ccw1998	default1324657089.png	0
345	15	shp96331@uga.edu	112080080080004015014015024	\N	N	2016-02-16 00:42:31	2016-02-16 00:42:31	\N	\N	Y	N	N	\N	Y	123456	shp96331	\N	shp96331	default1324657089.png	0
344	15	bkm10437@uga.edu	095082083082095082012010001114	\N	N	2016-02-16 00:41:54	2016-02-16 00:41:54	\N	\N	Y	N	N	\N	Y	123456	mcbonnie96	\N	mcbonnie96	default1324657089.png	0
341	15	sterling.mcrae25@uga.edu	086087092070082095086007006	\N	N	2016-02-16 00:41:07	2016-02-16 00:41:07	\N	\N	Y	N	N	\N	Y	123456	Sterlo2015	\N	Sterlo2015	default1324657089.png	0
346	15	ams15697@uga.edu	116086070071087069081008005096	\N	N	2016-02-16 00:43:52	2016-02-16 00:43:52	\N	\N	Y	N	N	\N	Y	123456	amatthew	\N	amatthew	default1324657089.png	0
342	15	spc23104@uga.edu	065082089084005006012013005001	\N	N	2016-02-16 00:41:19	2016-02-16 00:41:19	\N	\N	Y	N	N	\N	Y	123456	samablue38	\N	samablue38	default1324657089.png	0
330	15	dag55377@uga.edu	049080065064087071085067	\N	N	2016-02-13 20:36:05	2016-02-13 20:36:05	\N	\N	Y	N	N	\N	Y	5	David	\N	David	default1324657089.png	0
347	15	jss29576@uga.edu	050091093084070080088000	\N	N	2016-02-16 01:13:37	2016-02-16 01:13:37	\N	\N	Y	N	N	\N	Y	123456	jssjogren	\N	jssjogren	default1324657089.png	0
349	15	ddp03394@uga.edu	118082088087094086076019002121	\N	N	2016-02-16 05:13:59	2016-02-16 05:13:59	\N	\N	Y	N	N	\N	Y	5	ddp03394	\N	ddp03394	default1324657089.png	0
350	15	tls00173@uga.edu	119071092084088005008008004096	\N	N	2016-02-16 06:33:33	2016-02-16 06:33:33	\N	\N	Y	N	N	\N	Y	123456	Teanna	\N	Teanna	default1324657089.png	0
351	15	ecmobley@uga.edu	046052083065004002000	\N	N	2016-02-16 18:14:35	2016-02-16 18:14:35	\N	\N	Y	N	N	\N	Y	123456	ecmobley	\N	ecmobley	default1324657089.png	0
352	15	jsl72197@uga.edu	089090092088008013000121115122125114	\N	N	2016-02-16 18:15:18	2016-02-16 18:15:18	\N	\N	Y	N	N	\N	Y	123456	Skylar Lindsey	\N	Skylar Lindsey	default1324657089.png	0
353	15	tao69495@uga.edu	123095091067083071081092007096	\N	N	2016-02-16 19:13:13	2016-02-16 19:13:13	\N	\N	Y	N	N	\N	N	123456	tao69485	\N	tao69485	default1324657089.png	0
354	15	pwm56459@uga.edu	105091071068088085086094051045038	\N	N	2016-02-16 20:02:29	2016-02-16 20:02:29	\N	\N	Y	N	N	\N	Y	123456	pmoney353	\N	pmoney353	default1324657089.png	0
355	15	cjwebb95@uga.edu	040070092095077082007003	\N	N	2016-02-16 20:08:15	2016-02-16 20:08:15	\N	\N	Y	N	N	\N	Y	123456	carolinewebb	\N	carolinewebb	default1324657089.png	0
356	15	bac73062@uga.edu	037036117083085064	\N	N	2016-02-16 20:11:03	2016-02-16 20:11:03	\N	\N	Y	N	N	\N	Y	123456	brenna.coyle	\N	brenna.coyle	default1324657089.png	0
358	15	lce795@uga.edu	087093083082074085085032038038054116	\N	N	2016-02-16 20:26:05	2016-02-16 20:26:05	\N	\N	Y	N	N	\N	Y	123456	lce795	\N	lce795	default1324657089.png	0
360	15	caroday@uga.edu	054080075085085071083069	\N	N	2016-02-16 20:31:36	2016-02-16 20:31:36	\N	\N	Y	N	N	\N	N	123456	caroday	\N	caroday	default1324657089.png	0
359	15	kag22076@uga.edu	114083087006001093094015	\N	N	2016-02-16 20:30:16	2016-02-16 20:30:16	\N	\N	Y	N	N	\N	Y	123456	Kyra Gilomen	\N	Kyra Gilomen	default1324657089.png	0
357	15	rga00160@uga.edu	070082087005008009001116115123114117	\N	N	2016-02-16 20:20:21	2016-02-16 20:20:21	\N	\N	Y	N	N	\N	Y	123456	rosemaryankerich	\N	rosemaryankerich	default1324657089.png	0
361	15	huttonh@uga.edu	090070064065089089015011009117	\N	N	2016-02-16 22:40:22	2016-02-16 22:40:22	\N	\N	Y	N	N	\N	Y	123456	huttonh	\N	huttonh	default1324657089.png	0
362	15	ofloyd@uga.edu	034089087086070005006005	\N	N	2016-02-16 22:50:39	2016-02-16 22:50:39	\N	\N	Y	N	N	\N	Y	123456	ofloyd	\N	ofloyd	default1324657089.png	0
363	15	nma61488@uga.edu	086093092086080068006010010	\N	N	2016-02-16 23:27:27	2016-02-16 23:27:27	\N	\N	Y	N	N	\N	Y	5	StefanA	\N	StefanA	default1324657089.png	0
364	15	jordan9@uga.edu	119093087093095091089093081096	\N	N	2016-02-16 23:34:59	2016-02-16 23:34:59	\N	\N	Y	N	N	\N	Y	123456	levinejordan21	\N	levinejordan21	default1324657089.png	0
365	15	jdg84004@uga.edu	038094086082067082069004	\N	N	2016-02-17 00:00:24	2016-02-17 00:00:24	\N	\N	Y	N	N	\N	Y	123456	jdgrider3	\N	jdgrider3	default1324657089.png	0
366	15	jh21013@uga.edu	083064090090084007006008014	\N	N	2016-02-17 00:15:14	2016-02-17 00:15:14	\N	\N	Y	N	N	\N	Y	123456	sabrinahan	\N	sabrinahan	default1324657089.png	0
367	15	ral70281@uga.edu	051084085082090004005006	\N	N	2016-02-17 00:51:08	2016-02-17 00:51:08	\N	\N	Y	N	N	\N	Y	123456	ralochmandy	\N	ralochmandy	default1324657089.png	0
368	15	cmoore12@uga.edu	082094082071070004007009010	\N	N	2016-02-17 02:34:12	2016-02-17 02:34:12	\N	\N	Y	N	N	\N	Y	123456	caroline	\N	caroline	default1324657089.png	0
369	15	brookehw@uga.edu	080065091005093082120076087032	\N	N	2016-02-17 03:15:29	2016-02-17 03:15:29	\N	\N	Y	N	N	\N	Y	123456	brookehw	\N	brookehw	default1324657089.png	0
370	15	jrw10286@uga.edu	116007087064093098005003	\N	N	2016-02-17 04:11:34	2016-02-17 04:11:34	\N	\N	Y	N	N	\N	Y	123456	Jack.wise96	\N	Jack.wise96	default1324657089.png	0
372	15	tmi01921@uga.edu	126076068052048038040036049062045059121127126123	\N	N	2016-02-17 19:56:10	2016-02-17 19:56:10	\N	\N	Y	N	N	\N	Y	5	Tyler.Insolia	\N	Tyler.Insolia	default1324657089.png	0
373	15	msmith18@uga.edu	110065087118074080067053035114124111	\N	N	2016-02-17 23:35:14	2016-02-17 23:35:14	\N	\N	Y	N	N	\N	Y	123456	msmith18	\N	msmith18	default1324657089.png	0
371	15	agh52116@uga.edu	083064092089079089010014009118	\N	N	2016-02-17 19:23:29	2016-02-17 19:23:29	\N	\N	Y	N	N	\N	Y	123456	ashlynh15	\N	ashlynh15	default1324657089.png	0
374	55	miguratyson7@tamu.edu	126085071095089093090095051050116	\N	N	2016-02-19 06:11:32	2016-02-19 06:11:32	\N	\N	Y	N	N	\N	Y	123456	miguratyson 	\N	miguratyson 	default1324657089.png	0
375	15	jdt59500@uga.edu	040092066082087065004006	\N	N	2016-02-19 17:13:29	2016-02-19 17:13:29	\N	\N	Y	N	N	\N	Y	123456	jennytomasello	\N	jennytomasello	default1324657089.png	0
377	15	wcr22485@uga.edu	050094081080081071001000	\N	N	2016-02-20 19:51:16	2016-02-20 19:51:16	\N	\N	Y	N	N	\N	Y	123456	willritt77	\N	willritt77	default1324657089.png	0
378	15	ejd38475@uga.edu	094084087090069090087074002121	\N	N	2016-02-21 21:38:08	2016-02-21 21:38:08	\N	\N	Y	N	N	\N	Y	123456	Eric.devries	\N	Eric.devries	default1324657089.png	0
376	15	sko27121@uga.edu	097083064071066089069092008	\N	N	2016-02-20 19:49:01	2016-02-23 18:46:34	Administrator	50.20.4.10	Y	N	N	\N	Y	123456	katieoshields	\N	katieoshields	default1324657089.png	0
379	15	smd73458@uga.edu	011068094074005004007006	\N	N	2016-02-22 13:33:03	2016-02-22 13:33:03	\N	\N	Y	N	N	\N	Y	123456	samdenty	\N	samdenty	default1324657089.png	0
381	15	ald23441@uga.edu	081087069084080094038035033038060119114	\N	N	2016-02-22 21:25:25	2016-02-22 21:25:25	\N	\N	Y	N	N	\N	Y	123456	abbydarling	\N	abbydarling	default1324657089.png	0
380	15	ah21984@uga.edu	037067093068071070087071	\N	N	2016-02-22 20:37:06	2016-02-22 20:37:06	\N	\N	Y	N	N	\N	Y	123456	anabellehowell	\N	anabellehowell	default1324657089.png	0
457	15	ceo10094@uga.edu	124083069081071095084083008	\N	N	2016-04-06 00:37:15	2016-04-06 00:37:15	\N	\N	Y	N	N	\N	Y	123456	CaitElizabeth5	\N	CaitElizabeth5	default1324657089.png	0
391	15	nrs37179@uga.edu	093093086118071089080087036114118	\N	N	2016-02-29 22:53:14	2016-02-29 22:53:14	\N	\N	Y	N	N	\N	Y	123456	nicolettesariotis	\N	nicolettesariotis	default1324657089.png	0
106	38	mgallagh@ggc.edu	097091085088067068009008002118	\N	N	2015-12-06 01:58:08	2015-12-06 01:58:08	\N	\N	Y	N	N	\N	Y	a710f167433e185c79ea6529b95634c57914d72b9fd2e80d93947f0c378de2ea	mgallagh	\N	mgallagh	default1324657089.png	0
382	15	cgr81546@uga.edu	082083065091089095089093013	\N	N	2016-02-23 18:55:55	2016-02-23 18:55:55	\N	\N	Y	N	N	\N	Y	123456	caroline_ridley	\N	caroline_ridley	default1324657089.png	0
383	15	rwg55000@uga.edu	041080070071070092085092	\N	N	2016-02-23 18:57:20	2016-02-23 18:57:20	\N	\N	Y	N	N	\N	Y	123456	Bobby_grunow	\N	Bobby_grunow	default1324657089.png	0
384	15	agq38502@uga.edu	089085086093094093121001120123118	\N	N	2016-02-23 18:58:19	2016-02-23 18:58:19	\N	\N	Y	N	N	\N	Y	123456	alyssaquinones	\N	alyssaquinones	default1324657089.png	0
385	14	pmlovett@valdosta.edu	051094081088081065000001	\N	N	2016-02-24 05:11:57	2016-02-24 05:11:57	\N	\N	Y	N	N	\N	N	123456	plove 	\N	plove 	default1324657089.png	0
386	15	21sum14@uga.edu	053088081088088080007006	\N	N	2016-02-24 16:59:33	2016-02-24 16:59:33	\N	\N	Y	N	N	\N	Y	123456	rpmontayre7	\N	rpmontayre7	default1324657089.png	0
387	15	egkuga@uga.edu	002000002005005002014093092	\N	N	2016-02-28 00:10:11	2016-02-28 00:10:11	\N	\N	Y	N	N	\N	Y	123456	egkuga	\N	egkuga	default1324657089.png	0
388	15	hturner@uga.edu	041086070001007013006005	\N	N	2016-02-29 22:52:10	2016-02-29 22:52:10	\N	\N	Y	N	N	\N	Y	123456	HarleighGT	\N	HarleighGT	default1324657089.png	0
389	15	slw87764@uga.edu	096065069083069090086071045118113	\N	N	2016-02-29 22:52:47	2016-02-29 22:52:47	\N	\N	Y	N	N	\N	Y	123456	sydneylwells	\N	sydneylwells	default1324657089.png	0
393	15	csc34215@uga.edu	065093092068089087006010010	\N	N	2016-02-29 22:53:55	2016-02-29 22:53:55	\N	\N	Y	N	N	\N	Y	123456	channingcooper	\N	channingcooper	default1324657089.png	0
392	15	sgriffi@uga.edu	053084092093093070023022	\N	N	2016-02-29 22:53:20	2016-02-29 22:53:20	\N	\N	Y	N	N	\N	Y	123456	sgriffi	\N	sgriffi	default1324657089.png	0
390	15	emw44411@uga.edu	064093068094094077067042045047117116	\N	N	2016-02-29 22:53:10	2016-02-29 22:53:10	\N	\N	Y	N	N	\N	Y	123456	elise11	\N	elise11	default1324657089.png	0
394	15	mlg74777@uga.edu	085092088081091086086026001120	\N	N	2016-02-29 23:59:14	2016-02-29 23:59:14	\N	\N	Y	N	N	\N	Y	123456	mlg74777	\N	mlg74777	default1324657089.png	0
395	15	rach217@uga.edu	038067091094070005007014	\N	N	2016-03-01 04:43:34	2016-03-01 04:43:34	\N	\N	Y	N	N	\N	Y	123456	rach217	\N	rach217	default1324657089.png	0
396	15	rwalkera@uga.edu	062054080002007006001	\N	N	2016-03-02 22:45:54	2016-03-02 22:45:54	\N	\N	Y	N	N	\N	Y	123456	rwalkera	\N	rwalkera	default1324657089.png	0
397	15	jpd72149@uga.edu	018065091065093065006004	\N	N	2016-03-02 23:21:42	2016-03-02 23:21:42	\N	\N	Y	N	N	\N	Y	123456	Joseph Dixon	\N	Joseph Dixon	default1324657089.png	0
398	23	savschank@gmail.com@bobcats.gcsu.edu	092082087093089068001014001117	\N	N	2016-03-03 00:16:58	2016-03-03 00:16:58	\N	\N	Y	N	N	\N	N	123456	savschank	\N	savschank	default1324657089.png	0
399	23	mwheeler0314@bobcats.gcsu.edu	092082087093089068001014001117	\N	N	2016-03-03 00:19:03	2016-03-03 00:19:03	\N	\N	Y	N	N	\N	N	123456	savana.schank	\N	savana.schank	default1324657089.png	0
400	15	mac45578@uga.edu	003001007000014014014084112002	\N	N	2016-03-03 13:02:06	2016-03-03 13:02:06	\N	\N	Y	N	N	\N	Y	123456	doctorchester	\N	doctorchester	default1324657089.png	0
401	15	wrenmcdaniel@uga.edu	035068070095081071007014	\N	N	2016-03-04 02:22:35	2016-03-04 02:22:35	\N	\N	Y	N	N	\N	Y	123456	wrenmcdaniel	\N	wrenmcdaniel	default1324657089.png	0
403	15	chrystla.hodge25@uga.edu	112084065080075086094053045051103116	\N	N	2016-03-07 21:14:36	2016-03-07 21:14:36	\N	\N	Y	N	N	\N	Y	123456	cnh12241	\N	cnh12241	default1324657089.png	0
404	24	markg0203@columbusstate.edu	038070087093006006007006	\N	N	2016-03-09 20:38:01	2016-03-09 20:38:01	\N	\N	Y	N	N	\N	N	123456	mackyg0204	\N	mackyg0204	default1324657089.png	0
405	58	markg2321@duke.edu	038070087093006006007006	\N	N	2016-03-10 13:44:01	2016-03-10 13:44:01	\N	\N	Y	N	N	\N	N	123456	markg2311	\N	markg2311	default1324657089.png	0
406	15	lda17172@uga.edu	115091084068084070094027000	\N	N	2016-03-12 03:53:41	2016-03-12 03:53:41	\N	\N	Y	N	N	\N	Y	123456	lda17172	\N	lda17172	default1324657089.png	0
407	15	ews64093@uga.edu	080090094066088082036054043051044040041	\N	N	2016-03-15 22:59:56	2016-03-15 22:59:56	\N	\N	Y	N	N	\N	Y	123456	betsy_sutton	\N	betsy_sutton	default1324657089.png	0
408	15	jbm26514@uga.edu	075087081070084070088087073	\N	N	2016-03-17 16:56:10	2016-03-17 16:56:10	\N	\N	Y	N	N	\N	Y	123456	jaymckibben	\N	jaymckibben	default1324657089.png	0
409	15	adf42548@uga.edu	080094095093070089089008013	\N	N	2016-03-17 17:31:02	2016-03-17 17:31:02	\N	\N	Y	N	N	\N	Y	123456	allisonfrazier	\N	allisonfrazier	default1324657089.png	0
410	15	elb76206@uga.edu	069090070090081068015009008	\N	N	2016-03-17 17:37:10	2016-03-17 17:37:10	\N	\N	Y	N	N	\N	Y	123456	ebendock	\N	ebendock	default1324657089.png	0
411	15	sdcarl @uga.edu	012012001090081085092036038036033111	\N	N	2016-03-17 17:40:33	2016-03-17 17:40:33	\N	\N	Y	N	N	\N	N	123456	sdcarlquist	\N	sdcarlquist	default1324657089.png	0
412	15	mac79422@uga.edu	066090090094090088078092001113	\N	N	2016-03-17 18:08:32	2016-03-17 18:08:32	\N	\N	Y	N	N	\N	Y	123456	maggs103	\N	maggs103	default1324657089.png	0
430	15	Alayna.orr25@uga.edu	082088084079089089075095034041048	\N	N	2016-03-22 13:18:38	2016-03-22 13:18:38	\N	\N	Y	N	N	\N	Y	123456	alayna 	\N	alayna 	default1324657089.png	0
413	15	Abirdie@uga.edu	047084069094085091007004	\N	N	2016-03-17 20:48:24	2016-03-17 20:48:24	\N	\N	Y	N	N	\N	Y	123456	arden	\N	arden	default1324657089.png	0
414	18	kzadig@students.kennesaw.edu	112082071080084086084085002115	\N	N	2016-03-18 15:53:48	2016-10-12 11:40:28	Administrator	50.20.4.10	Y	N	N	\N	Y	123456	kzchillmode	\N	kzchillmode	default1324657089.png	0
415	15	cz48201@uga.edu	046062046070087093	\N	N	2016-03-18 16:27:03	2016-03-18 16:27:03	\N	\N	Y	N	N	\N	Y	123456	Gottabuy	\N	Gottabuy	default1324657089.png	0
416	35	Ben.lehrer95@knights.ucf.edu	116008075086088092091068	\N	N	2016-03-19 14:54:56	2016-03-19 14:54:56	\N	\N	Y	N	N	\N	N	123456	Benslehrer 	\N	Benslehrer 	default1324657089.png	0
417	15	cgv31947@uga.edu	043094071065090080079003	\N	N	2016-03-21 18:11:27	2016-03-21 18:11:27	\N	\N	Y	N	N	\N	Y	123456	gvaughan 	\N	gvaughan 	default1324657089.png	0
418	15	lem89566@uga.edu	050093083069081091069119	\N	N	2016-03-21 18:14:21	2016-03-21 18:14:21	\N	\N	Y	N	N	\N	Y	123456	lindsaymagill	\N	lindsaymagill	default1324657089.png	0
419	15	bcr64753@uga.edu	091083080095088087089010001	\N	N	2016-03-21 19:56:00	2016-03-21 19:56:00	\N	\N	Y	N	N	\N	Y	123456	baachristt	\N	baachristt	default1324657089.png	0
420	15	jgp75160@uga.edu	116085092088082075009006121114098	\N	N	2016-03-21 20:11:01	2016-03-21 20:11:01	\N	\N	Y	N	N	\N	Y	123456	jgp75160	\N	jgp75160	default1324657089.png	0
422	15	jab34629@uga.edu	051088085091064095087085	\N	N	2016-03-21 20:25:47	2016-03-21 20:25:47	\N	\N	Y	N	N	\N	Y	123456	bohnjusby 	\N	bohnjusby 	default1324657089.png	0
423	15	jessilee@uga.edu	043086080002007013004001	\N	N	2016-03-21 21:07:19	2016-03-21 21:07:19	\N	\N	Y	N	N	\N	Y	123456	jessibrooker	\N	jessibrooker	default1324657089.png	0
424	15	llh66496@uga.edu	039084064065081065069006	\N	N	2016-03-21 22:09:17	2016-03-21 22:09:17	\N	\N	Y	N	N	\N	Y	123456	llh66496	\N	llh66496	default1324657089.png	0
114	50	bdavis8@stedwards.edu	042045054095002000	\N	N	2015-12-07 01:40:10	2015-12-07 01:40:10	\N	\N	Y	N	N	\N	Y		bdavis8	\N	bdavis8	default1324657089.png	0
513	15	jbc22604@uga.edu	046045051095087074	\N	N	2016-04-30 07:41:06	2016-04-30 07:41:06	\N	\N	Y	N	N	\N	Y	123456	Pawges	\N	Pawges	default1324657089.png	0
425	15	sfl75751@uga.edu	003007004009000009118049042038041035062	\N	N	2016-03-21 22:41:09	2016-03-21 22:41:09	\N	\N	Y	N	N	\N	Y	123456	slyndgaard	\N	slyndgaard	default1324657089.png	0
426	15	ctc77204@uga.edu	019094075082088070105006	\N	N	2016-03-21 23:36:02	2016-03-21 23:36:02	\N	\N	Y	N	N	\N	Y	123456	ctc77204	\N	ctc77204	default1324657089.png	0
428	15	aas2017@uga.edu	065095085064081095076092066096	\N	N	2016-03-22 01:25:12	2016-03-22 01:25:12	\N	\N	Y	N	N	\N	Y	123456	aslaughter	\N	aslaughter	default1324657089.png	0
429	15	pfp65613@uga.edu	094091088087089092084085112114114	\N	N	2016-03-22 05:23:57	2016-03-22 05:23:57	\N	\N	Y	N	N	\N	Y	123456	patriziapain	\N	patriziapain	default1324657089.png	0
432	15	cdb79643@uga.edu	035045085086070080080	\N	N	2016-03-22 16:36:31	2016-03-22 16:36:31	\N	\N	Y	N	N	\N	Y	123456	baumsquad	\N	baumsquad	default1324657089.png	0
431	15	snp42922@uga.edu	047041093093086004003	\N	N	2016-03-22 16:27:23	2016-03-22 16:27:23	\N	\N	Y	N	N	\N	Y	123456	sarapiche	\N	sarapiche	default1324657089.png	0
433	15	mcpitt@uga.edu	067070092088084093077095047115118	\N	N	2016-03-22 18:30:50	2016-03-22 18:30:50	\N	\N	Y	N	N	\N	Y	123456	mcpitt	\N	mcpitt	default1324657089.png	0
434	15	mms34891@uga.edu	044066083065081091006007	\N	N	2016-03-23 02:49:45	2016-03-23 02:49:45	\N	\N	Y	N	N	\N	N	123456	mms2015	\N	mms2015	default1324657089.png	0
435	15	prb35527@uga.edu	060062036066070092	\N	N	2016-03-23 04:25:50	2016-03-23 04:25:50	\N	\N	Y	N	N	\N	Y	123456	prestonrb	\N	prestonrb	default1324657089.png	0
436	15	kbw63041@uga.edu	090080068095087065006010010	\N	N	2016-03-23 15:23:57	2016-03-23 15:23:57	\N	\N	Y	N	N	\N	Y	123456	kbw63041	\N	kbw63041	default1324657089.png	0
437	15	msutz@uga.edu	042062052092089082	\N	N	2016-03-23 21:01:16	2016-03-23 21:01:16	\N	\N	Y	N	N	\N	Y	123456	mollysutz	\N	mollysutz	default1324657089.png	0
438	15	mosher13@uga.edu	042052082089074091064	\N	N	2016-03-24 00:17:41	2016-03-24 00:17:41	\N	\N	Y	N	N	\N	Y	123456	mosher13	\N	mosher13	default1324657089.png	0
439	15	John.barnett25@uga.edu	088092092091004007010010002115	\N	N	2016-03-24 02:23:08	2016-03-24 02:23:08	\N	\N	Y	N	N	\N	Y	123456	john20232	\N	john20232	default1324657089.png	0
440	14	sedouglas@valdosta.edu	021114122096005012015001	\N	N	2016-03-27 12:35:16	2016-03-27 12:35:16	\N	\N	Y	N	N	\N	Y	123456	sedouglas69	\N	sedouglas69	default1324657089.png	0
441	15	rawlins@uga.edu	060035049084075086	\N	N	2016-03-28 21:20:50	2016-03-28 21:20:50	\N	\N	Y	N	N	\N	Y	123456	rawlins	\N	rawlins	default1324657089.png	0
442	15	faluce5@uga.edu	039080094000005002003008	\N	N	2016-03-28 22:19:16	2016-03-28 22:19:16	\N	\N	Y	N	N	\N	N	123456	faluce5	\N	faluce5	default1324657089.png	0
443	15	sloanand@uga.edu	066094092085091007006001013	\N	N	2016-03-28 23:36:46	2016-03-28 23:36:46	\N	\N	Y	N	N	\N	Y	123456	sloanmarie	\N	sloanmarie	default1324657089.png	0
444	15	mark.batson25@uga.edu	012083007002007012007022	\N	N	2016-03-29 13:32:55	2016-03-29 13:32:55	\N	\N	Y	N	N	\N	Y	123456	Mbatson	\N	Mbatson	default1324657089.png	0
445	15	kwc55585@uga.edu	089082064093090082093087009117	\N	N	2016-03-30 15:23:08	2016-03-30 15:23:08	\N	\N	Y	N	N	\N	Y	123456	kwchance	\N	kwchance	default1324657089.png	0
446	15	jahall13@uga.edu	035068086087077012015018	\N	N	2016-03-30 16:17:39	2016-03-30 16:17:39	\N	\N	Y	N	N	\N	Y	123456	jahall13	\N	jahall13	default1324657089.png	0
447	14	tarsmith@valdosta.edu	012080064095081076004004	\N	N	2016-03-31 02:29:40	2016-03-31 02:29:40	\N	\N	Y	N	N	\N	N	123456	taras 	\N	taras 	default1324657089.png	0
448	15	Carraway@uga.edu	118086087069074088071032059114124100	\N	N	2016-03-31 18:09:04	2016-03-31 18:09:04	\N	\N	Y	N	N	\N	Y	123456	benjaminelwin	\N	benjaminelwin	default1324657089.png	0
449	15	aeh1995@uga.edu	098083094089076007005011024	\N	N	2016-03-31 20:08:58	2016-03-31 20:08:58	\N	\N	Y	N	N	\N	Y	123456	Aeh1995	\N	Aeh1995	default1324657089.png	0
450	15	jlangley@uga.edu	096089084069095009011003096054048	\N	N	2016-03-31 22:36:52	2016-03-31 22:36:52	\N	\N	Y	N	N	\N	Y	123456	jlangley95	\N	jlangley95	default1324657089.png	0
451	15	trb4@uga.edu	045113000003001013000	\N	N	2016-04-01 00:32:09	2016-04-01 00:32:09	\N	\N	Y	N	N	\N	Y	123456	trb1304	\N	trb1304	default1324657089.png	0
452	15	hlg85843@uga.edu	038084093065083092087008	\N	N	2016-04-03 22:38:22	2016-04-03 22:38:22	\N	\N	Y	N	N	\N	N	123456	hlg85844	\N	hlg85844	default1324657089.png	0
427	15	hlg85844@uga.edu	071092071095081076074091046045047	\N	N	2016-03-22 01:17:52	2016-03-22 01:17:52	\N	\N	Y	N	N	\N	Y	123456	hlg2016	\N	hlg2016	default1324657089.png	0
453	15	jts15169@uga.edu	112003001091085081083069	\N	N	2016-04-04 03:25:30	2016-04-04 03:25:30	\N	\N	Y	N	N	\N	Y	123456	jtsellers	\N	jtsellers	default1324657089.png	0
455	18	nbridge3@students.kennesaw.edu@students.kennesaw.edu	093085065094086086080085045119114	\N	N	2016-04-06 00:23:37	2016-04-06 00:23:37	\N	\N	Y	N	N	\N	N	123456	nbridges51	\N	nbridges51	default1324657089.png	0
456	18	nbridge3@students.kennesaw.edu	093085065094086086080085045119114	\N	N	2016-04-06 00:25:51	2016-04-06 00:25:51	\N	\N	Y	N	N	\N	Y	123456	nbridges51!	\N	nbridges51!	default1324657089.png	0
454	15	jmw56289@uga.edu	095080085089070094086067002117	\N	N	2016-04-05 15:49:44	2016-04-05 15:49:44	\N	\N	Y	N	N	\N	Y	123456	jordanwilson14	\N	jordanwilson14	default1324657089.png	0
458	15	jbrew11@uga.edu	070074088080068093089080001112	\N	N	2016-04-06 13:52:47	2016-04-06 13:52:47	\N	\N	Y	N	N	\N	Y	123456	jabrewton	\N	jabrewton	default1324657089.png	0
459	15	amh27887@uga.edu	115070071065095089013012008117	\N	N	2016-04-08 14:46:26	2016-04-08 14:46:26	\N	\N	Y	N	N	\N	Y	123456	austinhibbard	\N	austinhibbard	default1324657089.png	0
460	15	stb48822@uga.edu	080082088089089088086074007096	\N	N	2016-04-09 01:55:51	2016-04-09 01:55:51	\N	\N	Y	N	N	\N	Y	123456	Scott_Brodmann26	\N	Scott_Brodmann26	default1324657089.png	0
461	15	ase11645@uga.edu	032084086094091091082068	\N	N	2016-04-09 16:50:29	2016-04-09 16:50:29	\N	\N	Y	N	N	\N	Y	123456	Alex 	\N	Alex 	default1324657089.png	0
463	15	ahester@uga.edu	080092087070080065095001012	\N	N	2016-04-10 21:15:24	2016-04-10 21:15:24	\N	\N	Y	N	N	\N	Y	123456	ahester	\N	ahester	default1324657089.png	0
464	15	marieluz@uga.edu	113085089042113055044055047033060058033036035033	\N	N	2016-04-11 05:45:26	2016-04-11 05:45:26	\N	\N	Y	N	N	\N	Y	123456	mal34120	\N	mal34120	default1324657089.png	0
462	15	walter14@uga.edu	070083095001007015001011010	\N	N	2016-04-09 18:50:35	2016-04-09 18:50:35	\N	\N	Y	N	N	\N	Y	123456	walterlopez14	\N	walterlopez14	default1324657089.png	0
465	15	jdp3@uga.edu	123083088081118112116025024	\N	N	2016-04-11 22:01:31	2016-04-11 22:01:31	\N	\N	Y	N	N	\N	N	123456	jake95	\N	jake95	default1324657089.png	0
467	15	cea97789@uga.edu	044088086093093082094067	\N	N	2016-04-11 22:03:02	2016-04-11 22:03:02	\N	\N	Y	N	N	\N	Y	123456	cea97789	\N	cea97789	default1324657089.png	0
468	15	prm33268@uga.edu	035068094095082071089080	\N	N	2016-04-11 22:03:10	2016-04-11 22:03:10	\N	\N	Y	N	N	\N	Y	123456	patmaguire	\N	patmaguire	default1324657089.png	0
469	15	jwd72805@uga.edu	042084080092005012015000	\N	N	2016-04-11 22:03:11	2016-04-11 22:03:11	\N	\N	Y	N	N	\N	Y	123456	johndouglas	\N	johndouglas	default1324657089.png	0
59	15	hes19163@uga.edu	060041032095071071	\N	N	2015-11-10 05:14:52	2015-11-10 05:14:52	\N	\N	Y	N	N	\N	Y		hayden	\N	hayden	default1324657089.png	0
470	15	hrb65660@uga.edu	035093071086006001003001	\N	N	2016-04-11 22:03:58	2016-04-11 22:03:58	\N	\N	Y	N	N	\N	Y	123456	hrb65660	\N	hrb65660	default1324657089.png	0
569	15	cap05314@uga.edu	022036083064082005007	\N	N	2016-08-12 00:27:28	2016-08-12 00:27:28	\N	\N	Y	N	N	\N	Y	123456	cp	\N	cp	default1324657089.png	0
471	15	mcg33032@uga.edu	117087093090076084007065024	\N	N	2016-04-11 22:05:26	2016-04-11 22:05:26	\N	\N	Y	N	N	\N	Y	123456	mcg33032	\N	mcg33032	default1324657089.png	0
472	15	aseif26@uga.edu	000066001006002005015022	\N	N	2016-04-11 22:07:05	2016-04-11 22:07:05	\N	\N	Y	N	N	\N	Y	123456	Alex_Seiferth26	\N	Alex_Seiferth26	default1324657089.png	0
474	15	an1221@uga.edu	099093094085091069015011008	\N	N	2016-04-11 22:20:31	2016-04-11 22:20:31	\N	\N	Y	N	N	\N	N	123456	an1221	\N	an1221	default1324657089.png	0
473	15	chenry33@uga.edu	113091081071089092093092003114	\N	N	2016-04-11 22:19:59	2016-04-11 22:19:59	\N	\N	Y	N	N	\N	Y	123456	Chenry33	\N	Chenry33	default1324657089.png	0
475	15	clb80697@uga.edu	113070090085005010013007034045098	\N	N	2016-04-11 22:22:15	2016-04-11 22:22:15	\N	\N	Y	N	N	\N	Y	123456	corriebrock 	\N	corriebrock 	default1324657089.png	0
476	15	jmj32138@uga.edu	088089005005001005009001001115	\N	N	2016-04-11 22:22:26	2016-04-11 22:22:26	\N	\N	Y	N	N	\N	Y	123456	jennaj1096	\N	jennaj1096	default1324657089.png	0
477	15	aeh77407@uga.edu	037088080081088080007007	\N	N	2016-04-11 23:56:48	2016-04-11 23:56:48	\N	\N	Y	N	N	\N	Y	123456	ansleye17	\N	ansleye17	default1324657089.png	0
478	15	cjs82218@uga.edu	065091093088087089089077095051	\N	N	2016-04-12 00:33:25	2016-04-12 00:33:25	\N	\N	Y	N	N	\N	Y	123456	cshiman	\N	cshiman	default1324657089.png	0
479	15	ams44393@uga.edu	009099086119117026118119114113058033057127120013	\N	N	2016-04-12 00:38:47	2016-04-12 00:38:47	\N	\N	Y	N	N	\N	Y	123456	ams44393	\N	ams44393	default1324657089.png	0
480	15	jwad18@uga.edu	043080064088085070007015	\N	N	2016-04-12 02:51:50	2016-04-12 02:51:50	\N	\N	Y	N	N	\N	Y	5	jwad18	\N	jwad18	default1324657089.png	0
466	15	jps81919@uga.edu	066090090090085084080080095112	\N	N	2016-04-11 22:02:41	2016-04-11 22:02:41	\N	\N	Y	N	N	\N	Y	123456	joestark18	\N	joestark18	default1324657089.png	0
481	15	tln21529@uga.edu	102070087094083069009009001107	\N	N	2016-04-12 17:11:25	2016-04-12 17:11:25	\N	\N	Y	N	N	\N	Y	123456	TaylorNettles	\N	TaylorNettles	default1324657089.png	0
482	15	cmc61385@uga.edu	054080064086085082090082	\N	N	2016-04-12 17:50:18	2016-04-12 17:50:18	\N	\N	Y	N	N	\N	Y	123456	carlockc	\N	carlockc	default1324657089.png	0
483	15	anr26646@uga.edu	082070005006007013008000117116098	\N	N	2016-04-12 18:49:36	2016-04-12 18:49:36	\N	\N	Y	N	N	\N	Y	123456	anr26646	\N	anr26646	default1324657089.png	0
484	15	wyattfr@uga.edu	119089085090064090046044038055124114120	\N	N	2016-04-12 19:46:23	2016-04-12 19:46:23	\N	\N	Y	N	N	\N	Y	123456	wyattfr	\N	wyattfr	default1324657089.png	0
486	15	pcc62863@uga.edu	098080087004005006011008003101	\N	N	2016-04-12 20:18:57	2016-04-12 20:18:57	\N	\N	Y	N	N	\N	N	123456	pc1415	\N	pc1415	default1324657089.png	0
487	15	dlb86627@uga.edu	032075090094081081095086	\N	N	2016-04-12 20:20:30	2016-04-12 20:20:30	\N	\N	Y	N	N	\N	Y	123456	Dazberry 	\N	Dazberry 	default1324657089.png	0
488	15	Emily.reynolds25@uga.edu	051080091087081071007007	\N	N	2016-04-12 20:38:08	2016-04-12 20:38:08	\N	\N	Y	N	N	\N	Y	123456	emilyreynolds10	\N	emilyreynolds10	default1324657089.png	0
489	15	tmm57824@uga.edu	127080088077081092000114115117116114	\N	N	2016-04-12 21:18:12	2016-04-12 21:18:12	\N	\N	Y	N	N	\N	Y	123456	taylormaggiore	\N	taylormaggiore	default1324657089.png	0
490	15	rjs54822@uga.edu	114089094086094002035054043033055035102	\N	N	2016-04-13 14:19:49	2016-04-13 14:19:49	\N	\N	Y	N	N	\N	Y	123456	rjs54822	\N	rjs54822	default1324657089.png	0
491	15	vh75584@uga.edu	116095065065083003084080086036	\N	N	2016-04-13 15:25:03	2016-04-13 15:25:03	\N	\N	Y	N	N	\N	Y	123456	vanessa_h96	\N	vanessa_h96	default1324657089.png	0
485	15	acn1097@uga.edu	066094094076092068032043047117117127112	\N	N	2016-04-12 19:59:21	2016-04-12 19:59:21	\N	\N	Y	N	N	\N	Y	123456	acn1097	\N	acn1097	default1324657089.png	0
492	15	mjfort @uga.edu	032066091065085088004000	\N	N	2016-04-17 20:11:53	2016-04-17 20:11:53	\N	\N	Y	N	N	\N	N	123456	mjfort	\N	mjfort	default1324657089.png	0
493	15	mjfort@uga.edu	032066091065085088004000	\N	N	2016-04-17 20:15:05	2016-04-17 20:15:05	\N	\N	Y	N	N	\N	Y	123456	mjfort 	\N	mjfort 	default1324657089.png	0
494	15	cge11570@uga.edu	114064089087089076088001115113103	\N	N	2016-04-18 17:49:11	2016-04-18 17:49:11	\N	\N	Y	N	N	\N	Y	123456	chriseriksen4	\N	chriseriksen4	default1324657089.png	0
495	15	sn16390@uga.edu	074065088091078001012000115112115	\N	N	2016-04-18 23:03:39	2016-04-18 23:03:39	\N	\N	Y	N	N	\N	N	5	alexnam	\N	alexnam	default1324657089.png	0
497	15	hb35921@uga.edu	095082077084070082080085089034	\N	N	2016-04-18 23:03:43	2016-04-18 23:03:43	\N	\N	Y	N	N	\N	N	123456	harisbejdic	\N	harisbejdic	default1324657089.png	0
496	15	andhogan@uga.edu	053000085084007071015015	\N	N	2016-04-18 23:03:40	2016-04-18 23:03:40	\N	\N	Y	N	N	\N	Y	123456	andhogan	\N	andhogan	default1324657089.png	0
500	15	rdk44733@uga.edu	118086089090090086065011001126	\N	N	2016-04-18 23:06:21	2016-04-18 23:06:21	\N	\N	Y	N	N	\N	N	123456	rdk44733	\N	rdk44733	default1324657089.png	0
498	15	wtsegars@uga.edu	070091095088006003004011012	\N	N	2016-04-18 23:05:28	2016-04-18 23:05:28	\N	\N	Y	N	N	\N	Y	123456	wtsegars	\N	wtsegars	default1324657089.png	0
499	15	connorh@uga.edu	095086071090091082075086093036	\N	N	2016-04-18 23:05:52	2016-04-18 23:05:52	\N	\N	Y	N	N	\N	Y	123456	connorh	\N	connorh	default1324657089.png	0
502	15	mec30081@uga.edu	032069094000004006005015	\N	N	2016-04-19 04:06:57	2016-04-19 04:06:57	\N	\N	Y	N	N	\N	Y	123456	MaxCurtis	\N	MaxCurtis	default1324657089.png	0
503	15	fac90183@uga.edu	082064086081094090086086093	\N	N	2016-04-19 04:44:10	2016-04-19 04:44:10	\N	\N	Y	N	N	\N	Y	123456	Fernando	\N	Fernando	default1324657089.png	0
504	15	tsh52340@uga.edu	085086091071081094089091095056	\N	N	2016-04-19 16:47:30	2016-04-19 16:47:30	\N	\N	Y	N	N	\N	Y	5	SloanHuff	\N	SloanHuff	default1324657089.png	0
505	14	pkpetrey@valdosta.edu	060039049006007004	\N	N	2016-04-21 17:27:01	2016-04-21 17:27:01	\N	\N	Y	N	N	\N	Y	123456	Paige	\N	Paige	default1324657089.png	0
506	15	chrisb52@uga.edu	071092071095081076074091046045047	\N	N	2016-04-23 17:32:24	2016-04-23 17:32:24	\N	\N	Y	N	N	\N	Y	5	c52	\N	c52	default1324657089.png	0
507	15	mary.coffin25@uga.edu	046057053069087065	\N	N	2016-04-24 05:25:34	2016-04-24 05:25:34	\N	\N	Y	N	N	\N	Y	123456	marywcoffin	\N	marywcoffin	default1324657089.png	0
508	15	kclarkga@uga.edu	055089083088093084001022	\N	N	2016-04-24 20:32:58	2016-04-24 20:32:58	\N	\N	Y	N	N	\N	Y	123456	kclarkga	\N	kclarkga	default1324657089.png	0
509	24	Sam@columbusstate.edu	095093067083069072086095045115113	\N	N	2016-04-27 12:14:02	2016-04-27 12:14:02	\N	\N	Y	N	N	\N	N	123456	samshshd	\N	samshshd	default1324657089.png	0
510	14	Karan@valdosta.edu	034045056116005	\N	N	2016-04-28 04:26:47	2016-04-28 04:26:47	\N	\N	Y	N	N	\N	N	5	Karan	\N	Karan	default1324657089.png	0
511	15	brs12227@uga.edu	118080087066076080086052046114117100	\N	N	2016-04-30 02:20:35	2016-04-30 02:20:35	\N	\N	Y	N	N	\N	Y	123456	brs12227	\N	brs12227	default1324657089.png	0
67	18	tking57@students.kennesaw.edu	121126112006003000	\N	N	2015-12-02 19:05:16	2015-12-02 19:05:16	\N	\N	Y	N	N	\N	N	123456	tking57	\N	tking57	default1324657089.png	0
512	15	mwb31553@uga.edu	044088081091085080090085	\N	N	2016-04-30 02:30:29	2016-04-30 02:30:29	\N	\N	Y	N	N	\N	Y	123456	Michael36297	\N	Michael36297	default1324657089.png	0
626	15	Barrett.teague26@uga.edu	035089070004000004006015	\N	N	2016-08-12 04:36:20	2016-08-12 04:36:20	\N	\N	Y	N	N	\N	Y	123456	barrett22	\N	barrett22	default1324657089.png	0
627	15	zcp21546@uga.edu	075066090064065076004008014	\N	N	2016-08-12 04:44:44	2016-08-12 04:44:44	\N	\N	Y	N	N	\N	Y	123456	pittsy60	\N	pittsy60	default1324657089.png	0
515	15	arm81899@uga.edu	083095088007124082075076067096	\N	N	2016-04-30 18:40:13	2016-04-30 18:40:13	\N	\N	Y	N	N	\N	Y	123456	kasereale	\N	kasereale	default1324657089.png	0
542	55	vasimmirza99@tamu.edu	055080065090089004004004	\N	N	2016-07-03 04:18:14	2016-07-03 04:18:14	\N	\N	Y	N	N	\N	N	5	vasimmirza99	\N	vasimmirza99	default1324657089.png	0
551	18	anurag15meena@students.kennesaw.edu	080092070000006007003011008	\N	N	2016-07-29 10:58:38	2016-07-29 10:58:38	\N	\N	Y	N	N	\N	Y	5	anurag	\N	anurag	default1324657089.png	0
550	26	dheerajkumar786@tigermail.auburn.edu	112003001007001003001015	\N	N	2016-07-26 11:45:50	2016-07-26 11:45:50	\N	\N	Y	N	N	\N	Y	5	Dheeraj	\N	Dheeraj	default1324657089.png	0
516	15	hec76003@uga.edu	009082011006002003003022	\N	N	2016-04-30 18:41:08	2016-04-30 18:41:08	\N	\N	Y	N	N	\N	Y	123456	hec76003	\N	hec76003	default1324657089.png	0
517	15	clt70715@uga.edu	113091091124088078080002113115113	\N	N	2016-04-30 18:43:52	2016-04-30 18:43:52	\N	\N	Y	N	N	\N	Y	123456	clthig	\N	clthig	default1324657089.png	0
518	15	wbb77471@uga.edu	054088094095093084091000	\N	N	2016-04-30 18:51:25	2016-04-30 18:51:25	\N	\N	Y	N	N	\N	Y	123456	wbdawgs7	\N	wbdawgs7	default1324657089.png	0
519	15	jwl35235@uga.edu	045091005011013004004006	\N	N	2016-04-30 18:58:35	2016-04-30 18:58:35	\N	\N	Y	N	N	\N	Y	123456	jarrettlowery5	\N	jarrettlowery5	default1324657089.png	0
520	15	jds99691@uga.edu	091093089091095087084087091	\N	N	2016-05-01 00:56:51	2016-05-01 00:56:51	\N	\N	Y	N	N	\N	Y	123456	jojojacob	\N	jojojacob	default1324657089.png	0
521	15	rda61961@uga.edu	093094083084094085093085092032	\N	N	2016-05-01 18:49:13	2016-05-01 18:49:13	\N	\N	Y	N	N	\N	Y	123456	rdantwine	\N	rdantwine	default1324657089.png	0
522	15	mwc14@uga.edu	095080087089087094086121001117	\N	N	2016-05-02 21:56:45	2016-05-02 21:56:45	\N	\N	Y	N	N	\N	Y	123456	mcclain_cummins	\N	mcclain_cummins	default1324657089.png	0
523	15	parkerg@uga.edu	069071084089084088005013024	\N	N	2016-05-02 23:59:07	2016-05-02 23:59:07	\N	\N	Y	N	N	\N	Y	123456	parkerg06	\N	parkerg06	default1324657089.png	0
524	15	jdh37603@uga.edu	061059036067070074	\N	N	2016-05-04 11:42:43	2016-05-04 11:42:43	\N	\N	Y	N	N	\N	Y	123456	joshdhampton	\N	joshdhampton	default1324657089.png	0
525	15	flm33731@uga.edu	001004005004003013008008118036046	\N	N	2016-05-05 17:44:56	2016-05-05 17:44:56	\N	\N	Y	N	N	\N	Y	123456	Fransuave 	\N	Fransuave 	default1324657089.png	0
526	15	mcb16267@uga.edu	034083094082065089007005	\N	N	2016-05-07 00:22:54	2016-05-07 00:22:54	\N	\N	Y	N	N	\N	Y	123456	cblaul	\N	cblaul	default1324657089.png	0
527	15	tateh@uga.edu	033035050084065002	\N	N	2016-05-08 17:45:45	2016-05-08 17:45:45	\N	\N	Y	N	N	\N	Y	123456	tateh	\N	tateh	default1324657089.png	0
528	15	taysims@uga.edu	053080075095091071015004	\N	N	2016-05-10 13:56:35	2016-05-10 13:56:35	\N	\N	Y	N	N	\N	Y	123456	taysims22	\N	taysims22	default1324657089.png	0
529	15	abbschef@uga.edu	126120114004000007	\N	N	2016-05-10 18:17:42	2016-05-10 18:17:42	\N	\N	Y	N	N	\N	Y	123456	abbyscheffer	\N	abbyscheffer	default1324657089.png	0
530	16	pRatik.padaliya@gmail.com	112086094093091007005011026	\N	N	2016-05-13 11:00:41	2016-05-13 11:00:41	Administrator	110.227.196.93	Y	N	N	\N	Y	\N	pPratik.padaliya	\N	pPratik.padaliya	default1324657089.png	0
531	15	daniwalk@uga.edu	056071093093090080005004	\N	N	2016-05-15 17:17:49	2016-05-15 17:17:49	\N	\N	Y	N	N	\N	Y	123456	daniwalk	\N	daniwalk	default1324657089.png	0
532	15	kac62703@uga.edu	042082002005012012001006	\N	N	2016-05-16 15:12:47	2016-05-16 15:12:47	\N	\N	Y	N	N	\N	Y	123456	kac1126	\N	kac1126	default1324657089.png	0
533	14	kcruz@valdosta.edu	051084086064091077007000	\N	N	2016-05-18 21:56:06	2016-05-18 21:56:06	\N	\N	Y	N	N	\N	N	5	kcruz17	\N	kcruz17	default1324657089.png	0
534	15	kea36979@uga.edu	121083094068065089089009008	\N	N	2016-05-24 00:38:20	2016-05-24 00:38:20	\N	\N	Y	N	N	\N	Y	123456	kat22598	\N	kat22598	default1324657089.png	0
535	15	wrb29964@uga.edu	017089091116085088002015	\N	N	2016-05-28 02:47:14	2016-05-28 02:47:14	\N	\N	Y	N	N	\N	Y	123456	WilliamBallou3	\N	WilliamBallou3	default1324657089.png	0
536	15	kmcdevit@uga.edu	039041055088092094	\N	N	2016-06-04 20:37:43	2016-06-04 20:37:43	\N	\N	Y	N	N	\N	N	123456	kmac25	\N	kmac25	default1324657089.png	0
537	28	kjm14f@my.fsu.edu	095080089092090091089087009115	\N	N	2016-06-08 19:42:22	2016-06-08 19:42:22	\N	\N	Y	N	N	\N	Y	123456	kjmac2992	\N	kjmac2992	default1324657089.png	0
539	14	jayancey @valdosta.edu	107082090086083078009012003113	\N	N	2016-06-21 12:23:59	2016-06-21 12:23:59	\N	\N	Y	N	N	\N	N	123456	jayancey 	\N	jayancey 	default1324657089.png	0
540	38	hhsdhsh@ggc.edu	046094093092091090089088	\N	N	2016-06-26 21:34:03	2016-06-26 21:34:03	\N	\N	Y	N	N	\N	N	123456	shhshs	\N	shhshs	default1324657089.png	0
541	17	stevetest@gatech.edu	047032069065002006006	\N	N	2016-06-29 04:15:53	2016-06-29 04:15:53	\N	\N	Y	N	N	\N	N	123456	stevetest	\N	stevetest	default1324657089.png	0
555	15	ahaertel@uga.edu	080094086076007006006009024	\N	N	2016-08-12 00:00:17	2016-08-12 00:00:17	\N	\N	Y	N	N	\N	Y	5	ahaertel	\N	ahaertel	default1324657089.png	0
543	21	plee27@student.gsu.edu	068084067091084092085119117115115119	\N	N	2016-07-03 06:22:51	2016-07-03 06:22:51	\N	\N	Y	N	N	\N	Y	123456	legitpauls	\N	legitpauls	default1324657089.png	0
544	26	anshuojha255@tigermail.auburn.edu	005001004012014001014015008119	\N	N	2016-07-04 14:03:36	2016-07-04 14:03:36	\N	\N	Y	N	N	\N	N	5	Anshu ojha	\N	Anshu ojha	default1324657089.png	0
545	58	anshuojha255@duke.edu	005001004012014001014015008119	\N	N	2016-07-04 16:24:04	2016-07-04 16:24:04	\N	\N	Y	N	N	\N	N	5	anshu ojha	\N	anshu ojha	default1324657089.png	0
546	15	htm99966@uga.edu	041069095002005012015002	\N	N	2016-07-10 17:23:28	2016-07-10 17:23:28	\N	\N	Y	N	N	\N	Y	123456	hannahmahoney1195	\N	hannahmahoney1195	default1324657089.png	0
547	17	msweeley3@gatech.edu	021084074082071004004004	\N	N	2016-07-10 21:29:57	2016-07-10 21:29:57	\N	\N	Y	N	N	\N	Y	123456	michaelsweeley	\N	michaelsweeley	default1324657089.png	0
548	15	jru70172@uga.edu	033036093091064071084	\N	N	2016-07-11 02:32:31	2016-07-11 02:32:31	\N	\N	Y	N	N	\N	Y	123456	rossuhlar 	\N	rossuhlar 	default1324657089.png	0
549	15	srn75807@uga.edu	099085070069064087075084050035046	\N	N	2016-07-25 13:34:36	2016-07-25 13:34:36	\N	\N	Y	N	N	\N	Y	123456	snevers	\N	snevers	default1324657089.png	0
552	15	rh35437@uga.edu	118071087083084092073035039034054100	\N	N	2016-08-11 20:16:07	2016-08-11 20:16:07	\N	\N	Y	N	N	\N	Y	5	renatahoskova	\N	renatahoskova	default1324657089.png	0
553	15	mld20030@uga.edu	112092092070071093075002119115113	\N	N	2016-08-11 23:52:22	2016-08-11 23:52:22	\N	\N	Y	N	N	\N	Y	5	crazydwarf99	\N	crazydwarf99	default1324657089.png	0
554	15	cnw93133@uga.edu	127113004002007012005	\N	N	2016-08-11 23:55:07	2016-08-11 23:55:07	\N	\N	Y	N	N	\N	Y	123456	Claire	\N	Claire	default1324657089.png	0
76	21	johns28y@student.gsu.edu	003001007089090084087086092043	\N	N	2015-12-04 16:41:36	2015-12-04 16:41:36	\N	\N	Y	N	N	\N	N	123456	johns28y	\N	johns28y	default1324657089.png	0
12	14	tpwhittingslow@valdosta.edu	112082071080084086084085002115	\N	N	2015-10-02 20:57:29	2015-12-09 19:45:05	Administrator	198.143.47.1	Y	N	N	\N	Y		whittingslow	\N	whittingslow	default1324657089.png	0
556	15	adp93597@uga.edu	065082071070079005008008006096	\N	N	2016-08-12 00:01:26	2016-08-12 00:01:26	\N	\N	Y	N	N	\N	Y	123456	adp1997	\N	adp1997	default1324657089.png	0
557	15	csg49424@uga.edu	114070080077083001074078073036	\N	N	2016-08-12 00:03:13	2016-08-12 00:03:13	\N	\N	Y	N	N	\N	Y	123456	csg49424	\N	csg49424	default1324657089.png	0
628	15	Jon.okoye@uga.edu	066065093091085082075074008113	\N	N	2016-08-12 05:20:02	2016-08-12 05:20:02	\N	\N	Y	N	N	\N	N	123456	jctrackstar	\N	jctrackstar	default1324657089.png	0
558	15	daf46467@uga.edu	044107084097101013100122	\N	N	2016-08-12 00:04:51	2016-08-12 00:04:51	\N	\N	Y	N	N	\N	Y	123456	DForsee	\N	DForsee	default1324657089.png	0
559	15	ahmed.okasha25@uga.edu	098083065085004007007001009	\N	N	2016-08-12 00:05:18	2016-08-12 00:05:18	\N	\N	Y	N	N	\N	Y	123456	Aokasha 	\N	Aokasha 	default1324657089.png	0
560	15	brianna.kattos97@uga.edu	044080074068081089090006	\N	N	2016-08-12 00:07:24	2016-08-12 00:07:24	\N	\N	Y	N	N	\N	Y	123456	akattos	\N	akattos	default1324657089.png	0
561	15	rpm51630@uga.edu	066094087089083088092008002096	\N	N	2016-08-12 00:10:27	2016-08-12 00:10:27	\N	\N	Y	N	N	\N	Y	123456	rpm51630	\N	rpm51630	default1324657089.png	0
562	15	jf92119@uga.edu	125126120003003004	\N	N	2016-08-12 00:12:02	2016-08-12 00:12:02	\N	\N	Y	N	N	\N	Y	123456	causmart 	\N	causmart 	default1324657089.png	0
563	15	Zachary.chandler26@uga.edu	022067091084088080079004	\N	N	2016-08-12 00:12:03	2016-08-12 00:12:03	\N	\N	Y	N	N	\N	Y	123456	Zach	\N	Zach	default1324657089.png	0
564	15	jl98206@uga.edu	075076089056043044117117119117063038043034034036	\N	N	2016-08-12 00:14:02	2016-08-12 00:14:02	\N	\N	Y	N	N	\N	Y	123456	kiki	\N	kiki	default1324657089.png	0
565	15	Doniell.glass@uga.edu	000097090090082095089095024	\N	N	2016-08-12 00:16:14	2016-08-12 00:16:14	\N	\N	Y	N	N	\N	Y	123456	doniellg 	\N	doniellg 	default1324657089.png	0
566	15	xsweng@uga.edu	068076070007014001010000114114113	\N	N	2016-08-12 00:23:08	2016-08-12 00:23:08	\N	\N	Y	N	N	\N	Y	123456	xisha	\N	xisha	default1324657089.png	0
568	15	ehs40161@uga.edu	118087092070082095086009024	\N	N	2016-08-12 00:24:06	2016-08-12 00:24:06	\N	\N	Y	N	N	\N	Y	123456	ehs40161	\N	ehs40161	default1324657089.png	0
567	15	johann.ebongom25@uga.edu	064090087093088086086080071032	\N	N	2016-08-12 00:23:09	2016-08-12 00:23:09	\N	\N	Y	N	N	\N	Y	5	Johann	\N	Johann	default1324657089.png	0
514	15	dlw79056@uga.edu	060032082089086070070	\N	N	2016-04-30 15:36:14	2016-04-30 15:36:14	\N	\N	Y	N	N	\N	Y	5	Dwitthoft	\N	Dwitthoft	default1324657089.png	0
572	15	Vibhor.rampal25@uga.edu	119114090070076004014001010	\N	N	2016-08-12 00:29:07	2016-08-12 00:29:07	\N	\N	Y	N	N	\N	Y	123456	vibram89	\N	vibram89	default1324657089.png	0
573	15	aman4294@uga.edu	095083094085071089084083024	\N	N	2016-08-12 00:30:14	2016-08-12 00:30:14	\N	\N	Y	N	N	\N	Y	123456	aman4294	\N	aman4294	default1324657089.png	0
571	15	kak77537@uga.edu	123077079064036035045049049036040049121125111	\N	N	2016-08-12 00:28:32	2016-08-12 00:28:32	\N	\N	Y	N	N	\N	Y	123456	kak77537	\N	kak77537	default1324657089.png	0
570	15	ingrid.brindle25@uga.edu	094090086071087068084080085112	\N	N	2016-08-12 00:28:07	2016-08-12 00:28:07	\N	\N	Y	N	N	\N	Y	5	IBinked	\N	IBinked	default1324657089.png	0
575	21	res@student.gsu.edu	103070080069091089094095050122098	\N	N	2016-08-12 00:35:35	2016-08-12 00:35:35	\N	\N	Y	N	N	\N	N	123456	res29399	\N	res29399	default1324657089.png	0
576	15	poguejk@uga.edu	120082077076070088095076085118	\N	N	2016-08-12 00:36:26	2016-08-12 00:36:26	\N	\N	Y	N	N	\N	Y	123456	poguejk	\N	poguejk	default1324657089.png	0
577	15	dnm05644@uga.edu	027001005049035047037033047041046043043039032099	\N	N	2016-08-12 00:38:34	2016-08-12 00:38:34	\N	\N	Y	N	N	\N	Y	123456	dnm05644	\N	dnm05644	default1324657089.png	0
578	15	npa35404@uga.edu	084086076000002119114048038038115127121122	\N	N	2016-08-12 00:40:52	2016-08-12 00:40:52	\N	\N	Y	N	N	\N	Y	123456	npa35404	\N	npa35404	default1324657089.png	0
581	15	gr91569@uga.edu	086064002001012005015009009	\N	N	2016-08-12 00:44:17	2016-08-12 00:44:17	\N	\N	Y	N	N	\N	Y	123456	cactus59	\N	cactus59	default1324657089.png	0
582	15	Joshua.harris26@uga.edu	036071083093005004004014	\N	N	2016-08-12 00:45:30	2016-08-12 00:45:30	\N	\N	Y	N	N	\N	Y	123456	hypershot5	\N	hypershot5	default1324657089.png	0
580	15	cp81134@uga.edu	053042049045035050052035038037039060044061060039062032055	\N	N	2016-08-12 00:44:12	2016-08-12 00:44:12	\N	\N	Y	N	N	\N	Y	5	caroline_ep	\N	caroline_ep	default1324657089.png	0
584	15	christopher.pounds@uga.edu	047049002003006002007	\N	N	2016-08-12 00:46:31	2016-08-12 00:46:31	\N	\N	Y	N	N	\N	Y	123456	Cpounds	\N	Cpounds	default1324657089.png	0
585	15	hkb36586@uga.edu	090088090064082075087095046041042	\N	N	2016-08-12 00:50:41	2016-08-12 00:50:41	\N	\N	Y	N	N	\N	Y	123456	hannahborgs	\N	hannahborgs	default1324657089.png	0
587	15	sck34683@uga.edu	014092065082093004004004	\N	N	2016-08-12 01:00:42	2016-08-12 01:00:42	\N	\N	Y	N	N	\N	Y	123456	shivani	\N	shivani	default1324657089.png	0
596	15	rg87490@uga.edu	083071078014011009006115117036054061	\N	N	2016-08-12 01:23:57	2016-08-12 01:23:57	\N	\N	Y	N	N	\N	Y	123456	Ruixin Guo	\N	Ruixin Guo	default1324657089.png	0
588	15	kmw76469@uga.edu	035094069064081071005004	\N	N	2016-08-12 01:01:03	2016-08-12 01:01:03	\N	\N	Y	N	N	\N	Y	123456	KaylaWhit 	\N	KaylaWhit 	default1324657089.png	0
589	15	subhojyoti.dasgupta25@uga.edu	103091088117086076121000120115113	\N	N	2016-08-12 01:04:13	2016-08-12 01:04:13	\N	\N	Y	N	N	\N	Y	5	shubh	\N	shubh	default1324657089.png	0
590	15	johnathan.raney25@uga.edu	006010007004092085074115114019	\N	N	2016-08-12 01:05:46	2016-08-12 01:05:46	\N	\N	Y	N	N	\N	Y	5	jbraney97	\N	jbraney97	default1324657089.png	0
586	15	mcb82190@uga.edu	053089064090082065015015	\N	N	2016-08-12 00:59:43	2016-08-12 00:59:43	\N	\N	Y	N	N	\N	Y	123456	mbenoit	\N	mbenoit	default1324657089.png	0
592	15	ott70708@uga.edu	099082078066069079009011112001	\N	N	2016-08-12 01:13:00	2016-08-12 01:13:00	\N	\N	Y	N	N	\N	Y	123456	olivertru	\N	olivertru	default1324657089.png	0
591	15	phc21368@uga.edu	102083065070092089069014012	\N	N	2016-08-12 01:11:10	2016-08-12 01:11:10	\N	\N	Y	N	N	\N	Y	123456	hunter.collett	\N	hunter.collett	default1324657089.png	0
593	15	wh35956@uga.edu	127077088094038116119114119113126112120125114	\N	N	2016-08-12 01:13:26	2016-08-12 01:13:26	\N	\N	Y	N	N	\N	Y	123456	Armilla	\N	Armilla	default1324657089.png	0
594	15	cody.matteson25@uga.edu	113092080076004005117088068053	\N	N	2016-08-12 01:21:20	2016-08-12 01:21:20	\N	\N	Y	N	N	\N	Y	5	cody.matteson	\N	cody.matteson	default1324657089.png	0
595	15	Molly.roehl25@uga.edu	088094092066080079088077008	\N	N	2016-08-12 01:23:30	2016-08-12 01:23:30	\N	\N	Y	N	N	\N	Y	123456	mollzupa	\N	mollzupa	default1324657089.png	0
1064	15	rjw31396@uga.edu	062035035004002011	\N	N	2016-09-29 02:10:01	2016-09-29 02:10:01	\N	\N	Y	N	N	\N	Y	123456	robdog508	\N	robdog508	default1324657089.png	0
597	15	ef74877@uga.edu	003002003005000002015001000	\N	N	2016-08-12 01:24:55	2016-08-12 01:24:55	\N	\N	Y	N	N	\N	Y	123456	bethfree123	\N	bethfree123	default1324657089.png	0
39	15	swood4@uga.edu	044094092086064013004003	\N	N	2015-11-06 20:34:12	2015-11-06 20:34:12	\N	\N	Y	N	N	\N	Y		swood4	\N	swood4	default1324657089.png	0
598	15	at81605@uga.edu	126065093087090085088084117118098	\N	N	2016-08-12 01:27:50	2016-08-12 01:27:50	\N	\N	Y	N	N	\N	Y	123456	at81605	\N	at81605	default1324657089.png	0
599	15	mab15730@uga.edu	092083071064076095084093010	\N	N	2016-08-12 01:30:05	2016-08-12 01:30:05	\N	\N	Y	N	N	\N	Y	5	bullrusher1	\N	bullrusher1	default1324657089.png	0
601	15	lma57845@uga.edu	085086091071081094089010003096	\N	N	2016-08-12 01:32:35	2016-08-12 01:32:35	\N	\N	Y	N	N	\N	Y	5	Lacy McKay	\N	Lacy McKay	default1324657089.png	0
602	15	las85374@uga.edu	125083074090080004007010009	\N	N	2016-08-12 01:34:03	2016-08-12 01:34:03	\N	\N	Y	N	N	\N	Y	123456	LAS20	\N	LAS20	default1324657089.png	0
681	15	rj66383@uga.edu	001001013001004001012000003117	\N	N	2016-08-13 03:59:57	2016-08-13 03:59:57	\N	\N	Y	N	N	\N	Y	123456	d3294264934	\N	d3294264934	default1324657089.png	0
603	15	emi76851@uga.edu	027094093081085065005004	\N	N	2016-08-12 01:35:32	2016-08-12 01:35:32	\N	\N	Y	N	N	\N	Y	123456	Edwardi	\N	Edwardi	default1324657089.png	0
608	15	ach19829@uga.edu	050082093070064005014001	\N	N	2016-08-12 02:09:52	2016-08-12 02:09:52	\N	\N	Y	N	N	\N	Y	123456	allyhoskins	\N	allyhoskins	default1324657089.png	0
604	15	yz21918@uga.edu	065064079008003120116116114114113116125113	\N	N	2016-08-12 01:42:30	2016-08-12 01:42:30	\N	\N	Y	N	N	\N	Y	123456	yz21918	\N	yz21918	default1324657089.png	0
605	15	orm15717@uga.edu	124091095088080068006010013	\N	N	2016-08-12 01:54:57	2016-08-12 01:54:57	\N	\N	Y	N	N	\N	Y	5	Owen4217	\N	Owen4217	default1324657089.png	0
606	15	hliu1992@uga.edu	125093087067093064095052115113119100	\N	N	2016-08-12 02:06:51	2016-08-12 02:06:51	\N	\N	Y	N	N	\N	N	123456	hliu	\N	hliu	default1324657089.png	0
607	15	hliu92@uga.edu	125093087067093064095052115113119100	\N	N	2016-08-12 02:09:25	2016-08-12 02:09:25	\N	\N	Y	N	N	\N	Y	123456	hliu92	\N	hliu92	default1324657089.png	0
609	15	yc12993@uga.edu	121126113003003003	\N	N	2016-08-12 02:13:21	2016-08-12 02:13:21	\N	\N	Y	N	N	\N	Y	123456	christina	\N	christina	default1324657089.png	0
610	15	Hannah.rhodes25@uga.edu	019089093087081070004005	\N	N	2016-08-12 02:18:36	2016-08-12 02:18:36	\N	\N	Y	N	N	\N	Y	123456	hjrhodes96	\N	hjrhodes96	default1324657089.png	0
611	15	tmk35899@uga.edu	049068066067077070007005	\N	N	2016-08-12 02:21:43	2016-08-12 02:21:43	\N	\N	Y	N	N	\N	Y	123456	tk10076	\N	tk10076	default1324657089.png	0
612	15	nac48337@uga.edu	001007015035000117124126112105009105120126124122123	\N	N	2016-08-12 02:24:17	2016-08-12 02:24:17	\N	\N	Y	N	N	\N	Y	5	nac48337	\N	nac48337	default1324657089.png	0
613	15	rjt57529@uga.edu	009006001013003007006009008	\N	N	2016-08-12 02:33:15	2016-08-12 02:33:15	\N	\N	Y	N	N	\N	Y	123456	jakethornton10	\N	jakethornton10	default1324657089.png	0
614	15	yk31605@uga.edu	070067082094007005008014017096	\N	N	2016-08-12 03:02:02	2016-08-12 03:02:02	\N	\N	Y	N	N	\N	Y	123456	dyddnr56	\N	dyddnr56	default1324657089.png	0
615	15	kdh23390@uga.edu	062060033046	\N	N	2016-08-12 03:10:09	2016-08-12 03:10:09	\N	\N	Y	N	N	\N	Y	5	farmboy	\N	farmboy	default1324657089.png	0
616	15	dsb33321@uga.edu	065087093086092068083010012	\N	N	2016-08-12 03:11:29	2016-08-12 03:11:29	\N	\N	Y	N	N	\N	Y	5	devangibohra	\N	devangibohra	default1324657089.png	0
618	15	ctg38831@uga.edu	032036086093080004012	\N	N	2016-08-12 03:23:02	2016-08-12 03:23:02	\N	\N	Y	N	N	\N	Y	123456	Caleb	\N	Caleb	default1324657089.png	0
619	15	asr52401@uga.edu	072083093095080083068009010	\N	N	2016-08-12 03:50:28	2016-08-12 03:50:28	\N	\N	Y	N	N	\N	Y	123456	arich13	\N	arich13	default1324657089.png	0
620	15	rbd72369@uga.edu	067093065071065083069010013	\N	N	2016-08-12 03:52:04	2016-08-12 03:52:04	\N	\N	Y	N	N	\N	Y	5	rorschach	\N	rorschach	default1324657089.png	0
621	15	jwd91800@uga.edu	123085071090082065008002114118098	\N	N	2016-08-12 03:57:29	2016-08-12 03:57:29	\N	\N	Y	N	N	\N	Y	123456	Jwdixon01	\N	Jwdixon01	default1324657089.png	0
622	15	ahc48771@uga.edu	065066085085065078064084087	\N	N	2016-08-12 04:04:04	2016-08-12 04:04:04	\N	\N	Y	N	N	\N	Y	123456	AnnaCorbould	\N	AnnaCorbould	default1324657089.png	0
623	15	mjc16555@uga.edu	112121126119022003004009013	\N	N	2016-08-12 04:08:25	2016-08-12 04:08:25	\N	\N	Y	N	N	\N	Y	123456	mjc16555	\N	mjc16555	default1324657089.png	0
624	15	wj53702@uga.edu	000011000013004015012001065054	\N	N	2016-08-12 04:18:49	2016-08-12 04:18:49	\N	\N	Y	N	N	\N	Y	5	rozie9456	\N	rozie9456	default1324657089.png	0
625	15	bht38741@uga.edu	035089070004000004006015	\N	N	2016-08-12 04:32:04	2016-08-12 04:32:04	\N	\N	Y	N	N	\N	N	123456	barrett_teague	\N	barrett_teague	default1324657089.png	0
600	15	mdw28523@uga.edu	100065086070091087090093008	\N	N	2016-08-12 01:32:23	2016-08-12 01:32:23	\N	\N	Y	N	N	\N	Y	123456	matt_wigg	\N	matt_wigg	default1324657089.png	0
583	15	jwj11238@uga.edu	038036087084000000007	\N	N	2016-08-12 00:45:33	2016-08-12 00:45:33	\N	\N	Y	N	N	\N	Y	123456	jwj11238	\N	jwj11238	default1324657089.png	0
617	15	lc94@uga.edu	059041094083065081064	\N	N	2016-08-12 03:22:36	2016-08-12 03:22:36	\N	\N	Y	N	N	\N	Y	123456	lc94	\N	lc94	default1324657089.png	0
629	15	obinns@uga.edu	053089091080095080007004	\N	N	2016-08-12 05:47:40	2016-08-12 05:47:40	\N	\N	Y	N	N	\N	Y	123456	obinns	\N	obinns	default1324657089.png	0
630	15	lauraham@uga.edu	041080095090088065089089	\N	N	2016-08-12 06:27:27	2016-08-12 06:27:27	\N	\N	Y	N	N	\N	Y	123456	lham	\N	lham	default1324657089.png	0
631	15	nazik8@uga.edu	120004003004001006120084	\N	N	2016-08-12 06:33:03	2016-08-12 06:33:03	\N	\N	Y	N	N	\N	Y	5	naz	\N	naz	default1324657089.png	0
632	15	jdm94773@uga.edu	120126127117004	\N	N	2016-08-12 07:08:38	2016-08-12 07:08:38	\N	\N	Y	N	N	\N	Y	5	jill	\N	jill	default1324657089.png	0
633	15	Matthew.Noxsel@uga.edu	115001002003000000004007	\N	N	2016-08-12 11:06:51	2016-08-12 11:06:51	\N	\N	Y	N	N	\N	Y	123456	mnoxsel	\N	mnoxsel	default1324657089.png	0
634	15	jeu99526@uga.edu	116000006011004006007005	\N	N	2016-08-12 11:26:50	2016-08-12 11:26:50	\N	\N	Y	N	N	\N	Y	123456	jackusry	\N	jackusry	default1324657089.png	0
635	15	dlb78946@uga.edu	112082071080084086084085001096	\N	N	2016-08-12 11:28:22	2016-08-12 11:28:22	\N	\N	Y	N	N	\N	Y	123456	BosLee	\N	BosLee	default1324657089.png	0
636	15	mth30522@uga.edu	121125089066084080088032044096117114	\N	N	2016-08-12 11:29:23	2016-08-12 11:29:23	\N	\N	Y	N	N	\N	Y	5	m_houli30522	\N	m_houli30522	default1324657089.png	0
637	15	fk76366@uga.edu	125113002007005005013	\N	N	2016-08-12 11:31:57	2016-08-12 11:31:57	\N	\N	Y	N	N	\N	Y	5	fko127	\N	fko127	default1324657089.png	0
638	15	jackie.bonds25@uga.edu	094095085071003067074086081053	\N	N	2016-08-12 12:37:23	2016-08-12 12:37:23	\N	\N	Y	N	N	\N	Y	5	bonds624	\N	bonds624	default1324657089.png	0
640	15	zm53920@uga.edu	089084076094065088094038115115116125	\N	N	2016-08-12 12:47:36	2016-08-12 12:47:36	\N	\N	Y	N	N	\N	Y	123456	Pisuduo	\N	Pisuduo	default1324657089.png	0
639	15	cap25254@uga.edu	114089087066064087081051038114124100	\N	N	2016-08-12 12:37:27	2016-08-12 12:37:27	\N	\N	Y	N	N	\N	Y	123456	C$Pittman18	\N	C$Pittman18	default1324657089.png	0
641	15	ens25514@uga.edu	084070071084092092036047044042119117114	\N	N	2016-08-12 12:53:22	2016-08-12 12:53:22	\N	\N	Y	N	N	\N	Y	123456	ericasnicole	\N	ericasnicole	default1324657089.png	0
642	15	tlm58704@uga.edu	065091085081089064090088082056	\N	N	2016-08-12 12:59:22	2016-08-12 12:59:22	\N	\N	Y	N	N	\N	Y	123456	taylorlmullen	\N	taylorlmullen	default1324657089.png	0
97	15	mmahr@uga.edu	121122113004003010	\N	N	2015-12-05 01:42:15	2015-12-05 01:42:15	\N	\N	Y	N	N	\N	Y		melissamahr	\N	melissamahr	default1324657089.png	0
574	15	mw83521@uga.edu	088090064082009000008120115113116112	\N	N	2016-08-12 00:30:26	2016-08-12 00:30:26	\N	\N	Y	N	N	\N	Y	123456	meihahaha	\N	meihahaha	default1324657089.png	0
643	15	cfo45433@uga.edu	016103093091004015005009011	\N	N	2016-08-12 13:13:29	2016-08-12 13:13:29	\N	\N	Y	N	N	\N	Y	123456	cfo45433	\N	cfo45433	default1324657089.png	0
644	15	ilp90392@uga.edu	093071080093089090082009011	\N	N	2016-08-12 13:21:36	2016-08-12 13:21:36	\N	\N	Y	N	N	\N	Y	123456	isabellucille	\N	isabellucille	default1324657089.png	0
645	15	ads18353@uga.edu	083065090095067089081086066112	\N	N	2016-08-12 13:22:32	2016-08-12 13:22:32	\N	\N	Y	N	N	\N	Y	123456	saintjr2087	\N	saintjr2087	default1324657089.png	0
647	15	haihan.ma@uga.edu	012112122114125125119121	\N	N	2016-08-12 13:24:18	2016-08-12 13:24:18	\N	\N	Y	N	N	\N	Y	5	haihanma	\N	haihanma	default1324657089.png	0
648	15	aaz93462@uga.edu	123086093044055045045038039051033038036056126108	\N	N	2016-08-12 13:36:03	2016-08-12 13:36:03	\N	\N	Y	N	N	\N	Y	123456	aaz93462	\N	aaz93462	default1324657089.png	0
651	15	yq72941@uga.edu	048088083093026004004004	\N	N	2016-08-12 13:45:39	2016-08-12 13:45:39	\N	\N	Y	N	N	\N	N	123456	qq854553477	\N	qq854553477	default1324657089.png	0
649	15	nam25127@uga.edu	094082080076094088074074085112	\N	N	2016-08-12 13:45:33	2016-08-12 13:45:33	\N	\N	Y	N	N	\N	Y	123456	NoraMcGonigle	\N	NoraMcGonigle	default1324657089.png	0
652	15	ipocrnic@uga.edu	049094081082005006014117	\N	N	2016-08-12 13:46:32	2016-08-12 13:46:32	\N	\N	Y	N	N	\N	Y	123456	ivan	\N	ivan	default1324657089.png	0
653	15	mdd03629@uga.edu	094006005006005008013005120123039	\N	N	2016-08-12 13:54:24	2016-08-12 13:54:24	\N	\N	Y	N	N	\N	Y	123456	mddiaz11	\N	mddiaz11	default1324657089.png	0
654	15	edward.sanders25@uga.edu	100067094066087095112115114119124117102	\N	N	2016-08-12 14:02:51	2016-08-12 14:02:51	\N	\N	Y	N	N	\N	Y	5	eddysanders1993	\N	eddysanders1993	default1324657089.png	0
655	15	xw90953@uga.edu	037080092082004002007004	\N	N	2016-08-12 14:17:41	2016-08-12 14:17:41	\N	\N	Y	N	N	\N	Y	123456	Xue Wang	\N	Xue Wang	default1324657089.png	0
656	15	tkh80537@uga.edu	097087078084086066111042042040041119117	\N	N	2016-08-12 14:18:15	2016-08-12 14:18:15	\N	\N	Y	N	N	\N	Y	123456	thill466	\N	thill466	default1324657089.png	0
657	15	Laura.crecelius@uga.edu	120013114002010004004	\N	N	2016-08-12 14:30:10	2016-08-12 14:30:10	\N	\N	Y	N	N	\N	Y	123456	lauracrecelius	\N	lauracrecelius	default1324657089.png	0
646	15	rfc48514@uga.edu	003002004005004005008010008112	\N	N	2016-08-12 13:22:53	2016-08-12 13:22:53	\N	\N	Y	N	N	\N	Y	123456	pats10270	\N	pats10270	default1324657089.png	0
659	15	pds19455@uga.edu	017066004000003003005001	\N	N	2016-08-12 15:01:09	2016-08-12 15:01:09	\N	\N	Y	N	N	\N	Y	123456	psong1	\N	psong1	default1324657089.png	0
660	15	jmk68398@uga.edu	096092066091093080067053099122125114	\N	N	2016-08-12 15:13:06	2016-08-12 15:13:06	\N	\N	Y	N	N	\N	Y	123456	jmk68398	\N	jmk68398	default1324657089.png	0
661	15	cml66887@uga.edu	066093080087080068006009008	\N	N	2016-08-12 15:28:01	2016-08-12 15:28:01	\N	\N	Y	N	N	\N	N	123456	connorlawhead	\N	connorlawhead	default1324657089.png	0
662	15	jlb96977@uga.edu	043083094086093082094006	\N	N	2016-08-12 16:02:15	2016-08-12 16:02:15	\N	\N	Y	N	N	\N	Y	123456	jessbrannigan	\N	jessbrannigan	default1324657089.png	0
663	15	src11014@uga.edu	085086091071081094089018002116	\N	N	2016-08-12 16:08:26	2016-08-12 16:08:26	\N	\N	Y	N	N	\N	Y	123456	samcrawford34	\N	samcrawford34	default1324657089.png	0
664	15	jonaha@uga.edu	013080114001004004002008	\N	N	2016-08-12 16:40:57	2016-08-12 16:40:57	\N	\N	Y	N	N	\N	Y	123456	jonaha	\N	jonaha	default1324657089.png	0
665	15	kpb89003@uga.edu@uga.edu	121082064093083069081087085114	\N	N	2016-08-12 17:25:35	2016-08-12 17:25:35	\N	\N	Y	N	N	\N	N	123456	katpatbat	\N	katpatbat	default1324657089.png	0
666	15	klf70325@uga.edu	085086091071081094089012005096	\N	N	2016-08-12 18:48:52	2016-08-12 18:48:52	\N	\N	Y	N	N	\N	Y	123456	klf70325	\N	klf70325	default1324657089.png	0
667	15	tk40349@uga.edu	096093087094084088094037115113119097	\N	N	2016-08-12 19:08:57	2016-08-12 19:08:57	\N	\N	Y	N	N	\N	Y	123456	t.klaihathai	\N	t.klaihathai	default1324657089.png	0
668	15	Tonishia.wimbish25@uga.edu	080086088089087005012010006113	\N	N	2016-08-12 19:35:43	2016-08-12 19:35:43	\N	\N	Y	N	N	\N	Y	5	Tonishia	\N	Tonishia	default1324657089.png	0
671	15	bho46886@uga.edu@uga.edu	121085088083068115092094116112098	\N	N	2016-08-12 19:56:36	2016-08-12 19:56:36	\N	\N	Y	N	N	\N	N	123456	brandonoday	\N	brandonoday	default1324657089.png	0
672	15	bho46886@uga.edu	121085088083068115092094116112098	\N	N	2016-08-12 19:57:46	2016-08-12 19:57:46	\N	\N	Y	N	N	\N	Y	123456	brandonhoday	\N	brandonhoday	default1324657089.png	0
670	15	shannenc@uga.edu	041094095086070022007005	\N	N	2016-08-12 19:56:20	2016-08-12 19:56:20	\N	\N	Y	N	N	\N	Y	123456	Animals4Lif3	\N	Animals4Lif3	default1324657089.png	0
674	15	bpolito@uga.edu	124084080086080088005114123043037100	\N	N	2016-08-12 20:48:54	2016-08-12 20:48:54	\N	\N	Y	N	N	\N	Y	123456	bpolito	\N	bpolito	default1324657089.png	0
675	15	agbennett@uga.edu	071092080068088091082085053123122	\N	N	2016-08-12 21:25:57	2016-08-12 21:25:57	\N	\N	Y	N	N	\N	Y	5	agbennett	\N	agbennett	default1324657089.png	0
676	15	yd63827@uga.edu	008005002004005003083065084	\N	N	2016-08-12 21:53:29	2016-08-12 21:53:29	\N	\N	Y	N	N	\N	Y	123456	McGrady	\N	McGrady	default1324657089.png	0
677	15	yq72491@uga.edu	048088083093026004004004	\N	N	2016-08-12 21:55:02	2016-08-12 21:55:02	\N	\N	Y	N	N	\N	Y	123456	854553477	\N	854553477	default1324657089.png	0
678	15	bksingleton@uga.edu	050088092084088080014001	\N	N	2016-08-12 22:21:24	2016-08-12 22:21:24	\N	\N	Y	N	N	\N	Y	123456	bksingleton	\N	bksingleton	default1324657089.png	0
679	15	kks25977@uga.edu	127065086093078014014004115099098	\N	N	2016-08-12 23:26:55	2016-08-12 23:26:55	\N	\N	Y	N	N	\N	Y	123456	komalsadruddin	\N	komalsadruddin	default1324657089.png	0
680	15	Julie.farmer25@uga.edu@uga.edu	101064082093091095089095008	\N	N	2016-08-13 01:50:42	2016-08-13 01:50:42	\N	\N	Y	N	N	\N	N	123456	juliefarmer	\N	juliefarmer	default1324657089.png	0
682	15	nac90070@uga.edu	086095082093089024084087084	\N	N	2016-08-13 04:00:58	2016-08-13 04:00:58	\N	\N	Y	N	N	\N	Y	123456	natcol	\N	natcol	default1324657089.png	0
673	15	prh92592@uga.edu	047094086092083000005006	\N	N	2016-08-12 20:38:33	2016-08-12 20:38:33	\N	\N	Y	N	N	\N	Y	123456	prh92592	\N	prh92592	default1324657089.png	0
650	15	jvh79606@uga.edu	091082085073088040049046037060118126121122	\N	N	2016-08-12 13:45:38	2016-08-12 13:45:38	\N	\N	Y	N	N	\N	Y	5	JayCeVyncent	\N	JayCeVyncent	default1324657089.png	0
669	15	tonishia_wimbish25@uga.edu@uga.edu	080086088089087005012010006113	\N	N	2016-08-12 19:43:04	2016-08-12 19:43:04	\N	\N	Y	N	N	\N	Y	5	Tonishia25	\N	Tonishia25	default1324657089.png	0
683	15	Samantha.harris27@uga.edu	066086090091079091089087085112	\N	N	2016-08-13 05:25:47	2016-08-13 05:25:47	\N	\N	Y	N	N	\N	Y	123456	sjha224	\N	sjha224	default1324657089.png	0
684	15	ABF09578@uga.edu	117071080092080069068010010	\N	N	2016-08-13 14:10:36	2016-08-13 14:10:36	\N	\N	Y	N	N	\N	Y	123456	Fintothecannon	\N	Fintothecannon	default1324657089.png	0
685	15	mgt72998@uga.edu	081085089090094075085089039039112	\N	N	2016-08-13 14:34:04	2016-08-13 14:34:04	\N	\N	Y	N	N	\N	Y	123456	GraysonT3	\N	GraysonT3	default1324657089.png	0
686	15	jtchen @uga.edu	085087071081086066094078092	\N	N	2016-08-13 15:25:26	2016-08-13 15:25:26	\N	\N	Y	N	N	\N	N	123456	jtchen	\N	jtchen	default1324657089.png	0
687	15	loven@uga.edu	050094081080081071007015	\N	N	2016-08-13 16:14:39	2016-08-13 16:14:39	\N	\N	Y	N	N	\N	Y	5	Alex Loven	\N	Alex Loven	default1324657089.png	0
688	15	tms85694@uga.edu	053110070091070092080067	\N	N	2016-08-13 16:22:19	2016-08-13 16:22:19	\N	\N	Y	N	N	\N	Y	5	t_spoerer	\N	t_spoerer	default1324657089.png	0
689	15	ks57380@uga.edu	089065089027099112121012002096	\N	N	2016-08-13 18:23:07	2016-08-13 18:23:07	\N	\N	Y	N	N	\N	Y	123456	811358676	\N	811358676	default1324657089.png	0
690	15	dmarty35@uga.edu	085083093001003003014014013	\N	N	2016-08-13 21:34:56	2016-08-13 21:34:56	\N	\N	Y	N	N	\N	Y	5	daniel565964	\N	daniel565964	default1324657089.png	0
691	15	rsg39543@uga.edu	004003015015014013003113112112114100	\N	N	2016-08-14 00:09:54	2016-08-14 00:09:54	\N	\N	Y	N	N	\N	Y	123456	rsg39543	\N	rsg39543	default1324657089.png	0
692	15	ajd43177@uga.edu	065071094068094095089009011	\N	N	2016-08-14 00:58:43	2016-08-14 00:58:43	\N	\N	Y	N	N	\N	Y	123456	ajd43177	\N	ajd43177	default1324657089.png	0
794	15	agd22045@uga.edu	040080095080065087087089	\N	N	2016-08-20 21:24:45	2016-08-20 21:24:45	\N	\N	Y	N	N	\N	Y	123456	adambriel	\N	adambriel	default1324657089.png	0
693	15	sdr25927@uga.edu	097087070002002005014013002096	\N	N	2016-08-14 03:56:43	2016-08-14 03:56:43	\N	\N	Y	N	N	\N	Y	5	gemini_nia	\N	gemini_nia	default1324657089.png	0
694	15	jenn.nguyen52@uga.edu	096090093094081125095042043042113119	\N	N	2016-08-14 06:22:32	2016-08-14 06:22:32	\N	\N	Y	N	N	\N	Y	123456	jennly52	\N	jennly52	default1324657089.png	0
695	15	pma78461@uga.edu	118084079081051039045035036054117120112126111	\N	N	2016-08-14 15:09:17	2016-08-14 15:09:17	\N	\N	Y	N	N	\N	Y	123456	pma	\N	pma	default1324657089.png	0
696	15	np11466@uga.edu	117070094064089087084040054043037116	\N	N	2016-08-14 15:29:54	2016-08-14 15:29:54	\N	\N	Y	N	N	\N	Y	123456	npmenon	\N	npmenon	default1324657089.png	0
697	15	aorlando@uga.edu	114092070089087089092086009116	\N	N	2016-08-14 17:39:03	2016-08-14 17:39:03	\N	\N	Y	N	N	\N	Y	123456	aorlando	\N	aorlando	default1324657089.png	0
698	15	hicksuga@uga.edu	045094094095093069089071	\N	N	2016-08-14 19:17:07	2016-08-14 19:17:07	\N	\N	Y	N	N	\N	Y	123456	hicksuga	\N	hicksuga	default1324657089.png	0
699	15	marshallhahn@uga.edu	121084068068080088092045115122125115	\N	N	2016-08-14 19:27:18	2016-08-14 19:27:18	\N	\N	Y	N	N	\N	Y	123456	marshallhahn	\N	marshallhahn	default1324657089.png	0
700	15	mtllop@uga.edu	071092071095081076074091046045047	\N	N	2016-08-14 20:49:39	2016-08-14 20:49:39	\N	\N	Y	N	N	\N	Y	5	Michael Llop	\N	Michael Llop	default1324657089.png	0
701	15	eeg43698@uga.edu	081088091086095075085036044038125125	\N	N	2016-08-14 21:32:50	2016-08-14 21:32:50	\N	\N	Y	N	N	\N	Y	123456	eegreene98	\N	eegreene98	default1324657089.png	0
703	15	nmi37345@uga.edu	015088003011004003005022	\N	N	2016-08-15 00:52:05	2016-08-15 00:52:05	\N	\N	Y	N	N	\N	Y	123456	nmi37345	\N	nmi37345	default1324657089.png	0
702	15	iam13100@uga.edu	050094081080081071004002	\N	N	2016-08-15 00:50:24	2016-08-15 00:50:24	\N	\N	Y	N	N	\N	Y	123456	iz_mess	\N	iz_mess	default1324657089.png	0
704	15	duygu.umutlu@uga.edu	127116009010011006003	\N	N	2016-08-15 00:53:47	2016-08-15 00:53:47	\N	\N	Y	N	N	\N	Y	123456	tazmania	\N	tazmania	default1324657089.png	0
705	15	nnb09764@uga.edu	001064086091070116086093024	\N	N	2016-08-15 03:06:13	2016-08-15 03:06:13	\N	\N	Y	N	N	\N	Y	123456	natalienicolebrown 	\N	natalienicolebrown 	default1324657089.png	0
706	15	kpb89003@uga.edu	121082064093083069081087085114	\N	N	2016-08-15 06:16:31	2016-08-15 06:16:31	\N	\N	Y	N	N	\N	Y	123456	kpb89003	\N	kpb89003	default1324657089.png	0
708	15	ram51460@uga.edu	032112001000013002100069	\N	N	2016-08-15 14:59:38	2016-08-15 14:59:38	\N	\N	Y	N	N	\N	Y	123456	rachelmoore	\N	rachelmoore	default1324657089.png	0
709	15	frd65018@uga.edu@uga.edu	015080066082006005007006	\N	N	2016-08-16 01:38:28	2016-08-16 01:38:28	\N	\N	Y	N	N	\N	N	123456	Frankie262	\N	Frankie262	default1324657089.png	0
710	15	jbz37531@uga.edu	123080082093089083078015024	\N	N	2016-08-16 17:09:18	2016-08-16 17:09:18	\N	\N	Y	N	N	\N	Y	123456	Jaclyn 	\N	Jaclyn 	default1324657089.png	0
711	15	mm78771@uga.edu	121092088080077082093046045045103116	\N	N	2016-08-16 18:02:43	2016-08-16 18:02:43	\N	\N	Y	N	N	\N	Y	123456	mmoon11	\N	mmoon11	default1324657089.png	0
712	15	ksledge@uga.edu	102083088081070067069094008	\N	N	2016-08-16 19:32:56	2016-08-16 19:32:56	\N	\N	Y	N	N	\N	Y	123456	kjsledge	\N	kjsledge	default1324657089.png	0
714	15	jr80624@uga.edu	006067003005013007006005	\N	N	2016-08-16 19:33:51	2016-08-16 19:33:51	\N	\N	Y	N	N	\N	Y	123456	jr80624	\N	jr80624	default1324657089.png	0
713	15	msm27527@uga.edu	125124114009010002	\N	N	2016-08-16 19:33:33	2016-08-16 19:33:33	\N	\N	Y	N	N	\N	Y	123456	megherss	\N	megherss	default1324657089.png	0
715	15	gif19633@uga.edu	085090082012014080081095009121	\N	N	2016-08-16 19:36:31	2016-08-16 19:36:31	\N	\N	Y	N	N	\N	Y	123456	Gfish22	\N	Gfish22	default1324657089.png	0
717	15	nj86645@uga.edu	082084081051045057042036044038058044039034116108	\N	N	2016-08-16 19:44:59	2016-08-16 19:44:59	\N	\N	Y	N	N	\N	Y	123456	nj86645	\N	nj86645	default1324657089.png	0
716	15	fgs15882@uga.edu	116085080090078086121001120123117	\N	N	2016-08-16 19:44:26	2016-08-16 19:44:26	\N	\N	Y	N	N	\N	Y	123456	fgsummers	\N	fgsummers	default1324657089.png	0
721	15	mgb75828@uga.edu	085093095068093095089001001	\N	N	2016-08-16 20:11:05	2016-08-16 20:11:05	\N	\N	Y	N	N	\N	Y	123456	ginoski	\N	ginoski	default1324657089.png	0
718	15	rak96509@uga.edu	064115095002014014010013000121	\N	N	2016-08-16 19:52:31	2016-08-16 19:52:31	\N	\N	Y	N	N	\N	Y	123456	rak96509	\N	rak96509	default1324657089.png	0
719	15	vmt20712@uga.edu	097091095088090065006010010	\N	N	2016-08-16 19:59:39	2016-08-16 19:59:39	\N	\N	Y	N	N	\N	Y	123456	vmt20712	\N	vmt20712	default1324657089.png	0
720	15	pedrame3@uga.edu	097087064089084007014001001	\N	N	2016-08-16 20:10:58	2016-08-16 20:10:58	\N	\N	Y	N	N	\N	Y	123456	pedrame3	\N	pedrame3	default1324657089.png	0
722	15	gfs01449@uga.edu	003003007004081069085086093112	\N	N	2016-08-16 20:12:21	2016-08-16 20:12:21	\N	\N	Y	N	N	\N	Y	123456	Griffinsorohan	\N	Griffinsorohan	default1324657089.png	0
723	15	yl54267@uga.edu	007004012008005112123118112118116038042042	\N	N	2016-08-16 20:16:26	2016-08-16 20:16:26	\N	\N	Y	N	N	\N	Y	123456	Yanchun	\N	Yanchun	default1324657089.png	0
724	15	nrl88434@uga.edu	034089091080095080088006	\N	N	2016-08-16 20:18:26	2016-08-16 20:18:26	\N	\N	Y	N	N	\N	Y	123456	neillavietes	\N	neillavietes	default1324657089.png	0
725	15	jclementes@uga.edu	092003006001005007004008014	\N	N	2016-08-16 20:21:47	2016-08-16 20:21:47	\N	\N	Y	N	N	\N	Y	5	jclementes	\N	jclementes	default1324657089.png	0
726	15	grm77256@uga.edu	112070088089082088095074017112	\N	N	2016-08-16 20:30:45	2016-08-16 20:30:45	\N	\N	Y	N	N	\N	Y	123456	gmayne	\N	gmayne	default1324657089.png	0
727	15	lrh93032@uga.edu	093087091091089091082075008	\N	N	2016-08-16 20:35:51	2016-08-16 20:35:51	\N	\N	Y	N	N	\N	Y	123456	lrh93032	\N	lrh93032	default1324657089.png	0
728	15	gk14951@uga.edu	065088084081090092120124112112112	\N	N	2016-08-16 20:53:13	2016-08-16 20:53:13	\N	\N	Y	N	N	\N	Y	123456	Jacob Kim	\N	Jacob Kim	default1324657089.png	0
735	15	mwf38801@uga.edu	087070071085076065090010013	\N	N	2016-08-16 21:41:20	2016-08-16 21:41:20	\N	\N	Y	N	N	\N	Y	123456	mariaflowers24	\N	mariaflowers24	default1324657089.png	0
736	15	rec33699@uga.edu	041094081088081076007004	\N	N	2016-08-16 21:47:13	2016-08-16 21:47:13	\N	\N	Y	N	N	\N	Y	123456	rchosewood 	\N	rchosewood 	default1324657089.png	0
33	15	cadam93@uga.edu	083087082071065091088001010	\N	N	2015-11-06 15:09:17	2015-11-06 15:09:17	\N	\N	Y	N	N	\N	Y		acorwin93	\N	acorwin93	default1324657089.png	0
737	15	brb27058@uga.edu	068093089090094089084001115113098	\N	N	2016-08-16 21:57:05	2016-08-16 21:57:05	\N	\N	Y	N	N	\N	N	123456	rossbishoff	\N	rossbishoff	default1324657089.png	0
850	15	fer40898@uga.edu	033035051086083093	\N	N	2016-08-29 22:05:00	2016-08-29 22:05:00	\N	\N	Y	N	N	\N	Y	123456	ford	\N	ford	default1324657089.png	0
864	15	rcu79786@uga.edu	121123118002002005	\N	N	2016-08-30 23:26:07	2016-08-30 23:26:07	\N	\N	Y	N	N	\N	Y	5	royurum	\N	royurum	default1324657089.png	0
707	15	twh42437@uga.edu@uga.edu	059036067086070090006	\N	N	2016-08-15 11:27:11	2016-08-15 11:27:11	\N	\N	Y	N	N	\N	Y	123456	thellmeister	\N	thellmeister	default1324657089.png	0
738	15	rdg11020@uga.edu	082090086085069069095081077	\N	N	2016-08-16 22:00:59	2016-08-16 22:00:59	\N	\N	Y	N	N	\N	Y	123456	gibdawg9	\N	gibdawg9	default1324657089.png	0
739	15	Freda.chen@uga.edu	094077081089080079080094047043038	\N	N	2016-08-16 22:05:13	2016-08-16 22:05:13	\N	\N	Y	N	N	\N	Y	123456	winniehi	\N	winniehi	default1324657089.png	0
733	15	krh71550@uga.edu	081088080069068093093005121123123	\N	N	2016-08-16 21:26:25	2016-08-16 21:26:25	\N	\N	Y	N	N	\N	Y	5	keeleyh98	\N	keeleyh98	default1324657089.png	0
740	15	Ondea.stokes25@uga.edu	040092093093114124100114	\N	N	2016-08-16 22:18:51	2016-08-16 22:18:51	\N	\N	Y	N	N	\N	Y	123456	Ondea	\N	Ondea	default1324657089.png	0
741	15	jmh15569@uga.edu	000098102100101111115119126	\N	N	2016-08-16 23:08:49	2016-08-16 23:08:49	\N	\N	Y	N	N	\N	Y	123456	KFlage	\N	KFlage	default1324657089.png	0
742	15	aab95939@uga.edu	075081081055039048040036040035033039045011117117	\N	N	2016-08-16 23:36:57	2016-08-16 23:36:57	\N	\N	Y	N	N	\N	Y	5	anna_adele	\N	anna_adele	default1324657089.png	0
743	15	carol27@uga.edu	070086085088089026009001000118	\N	N	2016-08-17 00:11:54	2016-08-17 00:11:54	\N	\N	Y	N	N	\N	Y	5	Carol_ernani	\N	Carol_ernani	default1324657089.png	0
744	15	danielasuarezromero@gmail.com@uga.edu	126120113004011011	\N	N	2016-08-17 00:18:20	2016-08-17 00:18:20	\N	\N	Y	N	N	\N	N	123456	danisuarezr	\N	danisuarezr	default1324657089.png	0
745	15	daniela_msr@hotmail.com@uga.edu	126120113004011011	\N	N	2016-08-17 00:20:21	2016-08-17 00:20:21	\N	\N	Y	N	N	\N	N	123456	danisuarezr 	\N	danisuarezr 	default1324657089.png	0
747	15	ame64675@uga.edu	093094082093088081053054043044118119102	\N	N	2016-08-17 01:58:02	2016-08-17 01:58:02	\N	\N	Y	N	N	\N	Y	123456	alliestes	\N	alliestes	default1324657089.png	0
748	15	amc50849@uga.edu	047032067094002006006	\N	N	2016-08-17 03:25:59	2016-08-17 03:25:59	\N	\N	Y	N	N	\N	Y	123456	alaynacarrandi	\N	alaynacarrandi	default1324657089.png	0
749	15	nesalva@uga.edu	114097088089001015015027008	\N	N	2016-08-17 06:12:06	2016-08-17 06:12:06	\N	\N	Y	N	N	\N	Y	123456	nsalvador	\N	nsalvador	default1324657089.png	0
750	15	jones22@uga.edu	063041049088011000	\N	N	2016-08-17 09:48:22	2016-08-17 09:48:22	\N	\N	Y	N	N	\N	Y	123456	jones22	\N	jones22	default1324657089.png	0
751	26	sonali@tigermail.auburn.edu	107123127120	\N	N	2016-08-17 12:49:26	2016-08-17 12:49:26	\N	\N	Y	N	N	\N	N	5	sonali	\N	sonali	default1324657089.png	0
752	15	btj80724@uga.edu	003091006003005003002022	\N	N	2016-08-17 13:06:37	2016-08-17 13:06:37	\N	\N	Y	N	N	\N	Y	123456	Brandon.janeway	\N	Brandon.janeway	default1324657089.png	0
753	58	sonali@duke.edu	107123127120	\N	N	2016-08-17 13:18:53	2016-08-17 13:18:53	\N	\N	Y	N	N	\N	N	5	s	\N	s	default1324657089.png	0
754	15	zac91038@uga.edu	045039075003010013002	\N	N	2016-08-17 20:51:23	2016-08-17 20:51:23	\N	\N	Y	N	N	\N	Y	123456	zain7197	\N	zain7197	default1324657089.png	0
755	15	mmm62173@uga.edu	106092084032044039038041039036035120115114122108	\N	N	2016-08-17 21:27:06	2016-08-17 21:27:06	\N	\N	Y	N	N	\N	Y	123456	mmm62173	\N	mmm62173	default1324657089.png	0
756	15	sth88934@uga.edu	050090087086064080068022	\N	N	2016-08-18 00:22:00	2016-08-18 00:22:00	\N	\N	Y	N	N	\N	Y	123456	sth88934	\N	sth88934	default1324657089.png	0
757	15	ld20920@uga.edu	127085070083084087087084032123118	\N	N	2016-08-18 01:26:41	2016-08-18 01:26:41	\N	\N	Y	N	N	\N	Y	5	lusiute	\N	lusiute	default1324657089.png	0
758	15	btc86283@uga.edu	019094081088004007006014	\N	N	2016-08-18 05:26:04	2016-08-18 05:26:04	\N	\N	Y	N	N	\N	Y	5	BTC74	\N	BTC74	default1324657089.png	0
759	15	cac36110@uga.edu	065092088084088080093008000112	\N	N	2016-08-18 14:31:26	2016-08-18 14:31:26	\N	\N	Y	N	N	\N	Y	123456	CameronC	\N	CameronC	default1324657089.png	0
760	15	briones @uga.edu	032035055084000002	\N	N	2016-08-18 17:10:32	2016-08-18 17:10:32	\N	\N	Y	N	N	\N	N	123456	lonestarmyke21	\N	lonestarmyke21	default1324657089.png	0
761	15	def61203@uga.edu	047032095086090002001	\N	N	2016-08-18 21:20:46	2016-08-18 21:20:46	\N	\N	Y	N	N	\N	Y	123456	daniellefay	\N	daniellefay	default1324657089.png	0
762	15	zh45385@uga.edu	091078065090088078092073046055117	\N	N	2016-08-18 21:33:46	2016-08-18 21:33:46	\N	\N	Y	N	N	\N	Y	123456	Kevon	\N	Kevon	default1324657089.png	0
763	15	tsb47496@uga.edu	083071081086089083068009010	\N	N	2016-08-18 21:52:03	2016-08-18 21:52:03	\N	\N	Y	N	N	\N	Y	5	tylannas98	\N	tylannas98	default1324657089.png	0
767	15	nlm89491@uga.edu	081091081071068078074086067114	\N	N	2016-08-18 23:04:36	2016-08-18 23:04:36	\N	\N	Y	N	N	\N	Y	123456	nadinemanjin	\N	nadinemanjin	default1324657089.png	0
764	15	sdm49932@uga.edu	122083065089080088119010008	\N	N	2016-08-18 22:06:28	2016-08-18 22:06:28	\N	\N	Y	N	N	\N	Y	5	sdm49932	\N	sdm49932	default1324657089.png	0
765	15	kec12353@uga.edu	089095071095085095050049118118115127112	\N	N	2016-08-18 22:16:17	2016-08-18 22:16:17	\N	\N	Y	N	N	\N	Y	123456	Keryn	\N	Keryn	default1324657089.png	0
766	15	bsc04704@uga.edu	018069091093095080068006	\N	N	2016-08-18 22:20:03	2016-08-18 22:20:03	\N	\N	Y	N	N	\N	Y	123456	brianasimone	\N	brianasimone	default1324657089.png	0
768	15	byh33328@uga.edu	003002122116068066076086017096	\N	N	2016-08-18 23:17:07	2016-08-18 23:17:07	\N	\N	Y	N	N	\N	Y	5	stickfight11	\N	stickfight11	default1324657089.png	0
769	15	evb14109@uga.edu	113093071066095092088073115113098	\N	N	2016-08-18 23:51:48	2016-08-18 23:51:48	\N	\N	Y	N	N	\N	Y	123456	Leesie	\N	Leesie	default1324657089.png	0
746	15	jag04138@uga.edu	126125112000003007	\N	N	2016-08-17 00:23:00	2016-08-17 00:23:00	\N	\N	Y	N	N	\N	Y	123456	javigonz	\N	javigonz	default1324657089.png	0
770	15	wlanders95@uga.edu	076070091089064067053035055045042040118	\N	N	2016-08-19 02:12:28	2016-08-19 02:12:28	\N	\N	Y	N	N	\N	Y	123456	wanders	\N	wanders	default1324657089.png	0
771	15	dfr91322@uga.edu	127083069093084089032042113125116119102	\N	N	2016-08-19 02:53:17	2016-08-19 02:53:17	\N	\N	Y	N	N	\N	Y	123456	davisray8	\N	davisray8	default1324657089.png	0
772	15	matthew.powell25@uga.edu	119087068041035055039036053047046037037060125125	\N	N	2016-08-19 14:02:26	2016-08-19 14:02:26	\N	\N	Y	N	N	\N	Y	123456	mattyp	\N	mattyp	default1324657089.png	0
773	15	psg87729@uga.edu	087083095087090088068008011	\N	N	2016-08-19 14:17:55	2016-08-19 14:17:55	\N	\N	Y	N	N	\N	Y	123456	peyton58	\N	peyton58	default1324657089.png	0
774	15	mef30576@uga.edu	113082095080084088075074001096	\N	N	2016-08-19 15:07:25	2016-08-19 15:07:25	\N	\N	Y	N	N	\N	Y	123456	mfollak	\N	mfollak	default1324657089.png	0
775	15	tdw20511@uga.edu	002094080082088065007002	\N	N	2016-08-19 15:21:39	2016-08-19 15:21:39	\N	\N	Y	N	N	\N	Y	123456	itsover9000	\N	itsover9000	default1324657089.png	0
84	14	jbgraham@valdosta.edu	115094082078080068006009024	\N	N	2015-12-04 19:14:18	2015-12-04 19:14:18	\N	\N	Y	N	N	\N	Y	b0293ecccf5a7a78746c7c10606dd0bc43dac69ea1f55cf287654a4537c91194	jbgraham	\N	jbgraham	default1324657089.png	0
46	15	carhearn @uga.edu	066071094089080068006010010	\N	N	2015-11-07 14:40:58	2015-11-07 14:40:58	\N	\N	Y	N	N	\N	N		carohearn	\N	carohearn	default1324657089.png	0
776	15	mvr89703@uga.edu	066086085086094082075011000112	\N	N	2016-08-19 19:28:01	2016-08-19 19:28:01	\N	\N	Y	N	N	\N	Y	5	mikmikmary	\N	mikmikmary	default1324657089.png	0
907	15	ani59408@uga.edu	112092090071090091006014102	\N	N	2016-09-06 06:53:28	2016-09-06 06:53:28	\N	\N	Y	N	N	\N	Y	123456	Ani59408	\N	Ani59408	default1324657089.png	0
908	15	adiguna.bahari@uga.edu	001004004007068076088068036048034	\N	N	2016-09-06 13:19:13	2016-09-06 13:19:13	\N	\N	Y	N	N	\N	Y	5	abahari	\N	abahari	default1324657089.png	0
777	15	joycebui@uga.edu	067068081071066078012008006114	\N	N	2016-08-19 21:19:21	2016-08-19 21:19:21	\N	\N	Y	N	N	\N	Y	123456	joycebui	\N	joycebui	default1324657089.png	0
778	15	mpr83380@uga.edu	092064119119007006006012024	\N	N	2016-08-19 23:30:57	2016-08-19 23:30:57	\N	\N	Y	N	N	\N	Y	123456	mikeyruse	\N	mikeyruse	default1324657089.png	0
779	15	pam.allyn25@uga.edu	080127065080091088087087002107	\N	N	2016-08-20 03:10:50	2016-08-20 03:10:50	\N	\N	Y	N	N	\N	Y	5	pallyn	\N	pallyn	default1324657089.png	0
780	15	kendall.clay@uga.edu	010114094082077012014029	\N	N	2016-08-20 15:21:32	2016-08-20 15:21:32	\N	\N	Y	N	N	\N	Y	123456	Kendall Clay	\N	Kendall Clay	default1324657089.png	0
781	15	ked23858@uga.edu	037080092080081071004001	\N	N	2016-08-20 15:24:06	2016-08-20 15:24:06	\N	\N	Y	N	N	\N	Y	123456	kdippers	\N	kdippers	default1324657089.png	0
782	15	vla56103@uga.edu	080066067088080005001001001	\N	N	2016-08-20 16:31:24	2016-08-20 16:31:24	\N	\N	Y	N	N	\N	Y	123456	vlallen	\N	vlallen	default1324657089.png	0
783	15	klc64141@uga.edu	015041002095102115001	\N	N	2016-08-20 18:24:31	2016-08-20 18:24:31	\N	\N	Y	N	N	\N	Y	123456	katheryn	\N	katheryn	default1324657089.png	0
784	15	crc39691@uga.edu	001000001004002000012009120033000	\N	N	2016-08-20 19:29:09	2016-08-20 19:29:09	\N	\N	Y	N	N	\N	N	123456	ChazC	\N	ChazC	default1324657089.png	0
785	15	crc39601@uga.edu	001000001004002000012009120033000	\N	N	2016-08-20 19:42:28	2016-08-20 19:42:28	\N	\N	Y	N	N	\N	Y	123456	Chaz	\N	Chaz	default1324657089.png	0
786	15	naomilj@uga.edu	039037045080094082	\N	N	2016-08-20 20:57:44	2016-08-20 20:57:44	\N	\N	Y	N	N	\N	Y	123456	noahleejones	\N	noahleejones	default1324657089.png	0
787	15	ftp30563@uga.edu	082071095082086093067051055047033100	\N	N	2016-08-20 21:01:33	2016-08-20 21:01:33	\N	\N	Y	N	N	\N	Y	123456	fionaputhenpura 	\N	fionaputhenpura 	default1324657089.png	0
789	15	rp49191@uga.edu	065094069081095068050041044043041116119	\N	N	2016-08-20 21:02:41	2016-08-20 21:02:41	\N	\N	Y	N	N	\N	N	123456	rpannu	\N	rpannu	default1324657089.png	0
788	15	hzs78457@uga.edu	000036069095086093091	\N	N	2016-08-20 21:01:54	2016-08-20 21:01:54	\N	\N	Y	N	N	\N	Y	123456	hzs78457	\N	hzs78457	default1324657089.png	0
790	15	jlg22225@uga.edu	083084090091077090083040118119112100	\N	N	2016-08-20 21:14:38	2016-08-20 21:14:38	\N	\N	Y	N	N	\N	N	123456	jengallucci	\N	jengallucci	default1324657089.png	0
791	15	mme94102@uga.edu	088084092070082089067008008	\N	N	2016-08-20 21:14:40	2016-08-20 21:14:40	\N	\N	Y	N	N	\N	Y	123456	mikeedwards32	\N	mikeedwards32	default1324657089.png	0
792	15	ykm13167@uga.edu	089087065081076089066095086	\N	N	2016-08-20 21:14:47	2016-08-20 21:14:47	\N	\N	Y	N	N	\N	Y	123456	yandelobro	\N	yandelobro	default1324657089.png	0
793	15	lmg25389@uga.edu	019084080086088070007006	\N	N	2016-08-20 21:21:56	2016-08-20 21:21:56	\N	\N	Y	N	N	\N	N	123456	leegar88	\N	leegar88	default1324657089.png	0
796	15	cao19749@uga.edu	124116120120003	\N	N	2016-08-20 22:04:45	2016-08-20 22:04:45	\N	\N	Y	N	N	\N	Y	5	CashOwens	\N	CashOwens	default1324657089.png	0
795	38	awalker33@ggc.edu	116088083074092071022035047047032052116	\N	N	2016-08-20 22:04:37	2016-08-20 22:04:37	\N	\N	Y	N	N	\N	Y	123456	awalker33	\N	awalker33	default1324657089.png	0
798	15	lmo5245q@uga.edu	102068093091070082089082067115	\N	N	2016-08-20 22:09:03	2016-08-20 22:09:03	\N	\N	Y	N	N	\N	N	5	LindsayO	\N	LindsayO	default1324657089.png	0
797	15	agt02445@uga.edu	080094085123069067077093001115	\N	N	2016-08-20 22:07:18	2016-08-20 22:07:18	\N	\N	Y	N	N	\N	Y	123456	agt02445	\N	agt02445	default1324657089.png	0
800	15	aj42592@uga.edu	000089064069092089077085036048048	\N	N	2016-08-20 22:15:20	2016-08-20 22:15:20	\N	\N	Y	N	N	\N	Y	123456	alexjerreat	\N	alexjerreat	default1324657089.png	0
799	15	mlk89225@uga.edu	121120115003011003	\N	N	2016-08-20 22:14:52	2016-08-20 22:14:52	\N	\N	Y	N	N	\N	Y	123456	max.k	\N	max.k	default1324657089.png	0
801	15	lmo52451@uga.edu	102068093091070082089082067115	\N	N	2016-08-20 22:16:12	2016-08-20 22:16:12	\N	\N	Y	N	N	\N	Y	5	Lindsay_O	\N	Lindsay_O	default1324657089.png	0
804	15	map06629@uga.edu	039067091086090081014003	\N	N	2016-08-20 22:22:20	2016-08-20 22:22:20	\N	\N	Y	N	N	\N	Y	123456	Michael 	\N	Michael 	default1324657089.png	0
805	15	egf16080@uga.edu	053067071095085091093086	\N	N	2016-08-20 22:23:09	2016-08-20 22:23:09	\N	\N	Y	N	N	\N	N	123456	Emily Fleming	\N	Emily Fleming	default1324657089.png	0
803	15	mhf57977@uga.edu	003003013007003006001084088039	\N	N	2016-08-20 22:22:10	2016-08-20 22:22:10	\N	\N	Y	N	N	\N	Y	123456	mhf57977	\N	mhf57977	default1324657089.png	0
802	15	srp57592@uga.edu	087087067080069067079080083042	\N	N	2016-08-20 22:20:40	2016-08-20 22:20:40	\N	\N	Y	N	N	\N	Y	123456	sierrapelkey	\N	sierrapelkey	default1324657089.png	0
806	24	parma@columbusstate.edu	125126114005007005	\N	N	2016-08-21 11:13:36	2016-08-21 11:13:36	\N	\N	Y	N	N	\N	N	5	parma	\N	parma	default1324657089.png	0
807	15	ccf40773@uga.edu	095095067076092066035055036119112115116	\N	N	2016-08-21 16:36:37	2016-08-21 16:36:37	\N	\N	Y	N	N	\N	Y	123456	christencflowers	\N	christencflowers	default1324657089.png	0
808	15	amanda.barbosa25@uga.edu	126082065071087005008009007096	\N	N	2016-08-21 21:47:16	2016-08-21 21:47:16	\N	\N	Y	N	N	\N	Y	123456	mandy4blue	\N	mandy4blue	default1324657089.png	0
809	15	kbs46876@uga.edu	039035066003010013000	\N	N	2016-08-22 14:03:10	2016-08-22 14:03:10	\N	\N	Y	N	N	\N	Y	123456	kyndallscott	\N	kyndallscott	default1324657089.png	0
810	15	vsonon@uga.edu	125087074085039036042042054039053039039045106	\N	N	2016-08-22 17:55:53	2016-08-22 17:55:53	\N	\N	Y	N	N	\N	Y	123456	vsonon	\N	vsonon	default1324657089.png	0
811	15	byoon@uga.edu	048016069001081006068003	\N	N	2016-08-22 22:19:12	2016-08-22 22:19:12	\N	\N	Y	N	N	\N	Y	123456	byoon	\N	byoon	default1324657089.png	0
812	15	cl84176@uga.edu	121002004001006005001005	\N	N	2016-08-22 23:30:00	2016-08-22 23:30:00	\N	\N	Y	N	N	\N	Y	123456	Chang072	\N	Chang072	default1324657089.png	0
813	15	yk12065@uga.edu	070092089020002000009000004112	\N	N	2016-08-22 23:41:53	2016-08-22 23:41:53	\N	\N	Y	N	N	\N	Y	123456	yk12065	\N	yk12065	default1324657089.png	0
814	15	ach81243@uga.edu	084064125093080014001028029	\N	N	2016-08-22 23:48:55	2016-08-22 23:48:55	\N	\N	Y	N	N	\N	Y	123456	aarhead	\N	aarhead	default1324657089.png	0
51	15	wdr96608@uga.edu	070083065070092089069075014	\N	N	2015-11-08 20:40:36	2015-11-08 20:40:36	\N	\N	Y	N	N	\N	Y	c369d878dce3ed47f4e76a34eeb3909436caf4589713318c6e301b75d7f6b575	Billy.Rose	\N	Billy.Rose	default1324657089.png	0
54	15	mbrehmer@uga.edu	054080064086085082090082	\N	N	2015-11-08 23:17:14	2015-11-08 23:17:14	\N	\N	Y	N	N	\N	Y		mbrehmer	\N	mbrehmer	default1324657089.png	0
815	15	jdh51174@uga.edu	092092093046044039033033049007058045121125120117	\N	N	2016-08-23 00:43:31	2016-08-23 00:43:31	\N	\N	Y	N	N	\N	Y	123456	honorejustin 	\N	honorejustin 	default1324657089.png	0
816	15	raheem.davis25@uga.edu	097091088087069081086002113115117	\N	N	2016-08-23 01:38:29	2016-08-23 01:38:29	\N	\N	Y	N	N	\N	Y	5	rheminarg	\N	rheminarg	default1324657089.png	0
817	22	vipin@emory.edu	063037060040095	\N	N	2016-08-23 15:53:36	2016-08-23 15:53:36	\N	\N	Y	N	N	\N	N	5	Vipin	\N	Vipin	default1324657089.png	0
818	15	zjk90400@uga.edu	006003000012005015001011002112	\N	N	2016-08-23 17:28:49	2016-08-23 17:28:49	\N	\N	Y	N	N	\N	Y	5	Dallon Knox	\N	Dallon Knox	default1324657089.png	0
960	18	badams46@students.kennesaw.edu	091078085086093051055047033054113127113104	\N	N	2016-09-13 15:00:18	2016-09-13 15:00:18	\N	\N	Y	N	N	\N	Y	123456	badams46	\N	badams46	default1324657089.png	0
961	15	jwm50311@uga.edu	055001094064066005090068	\N	N	2016-09-13 19:17:21	2016-09-13 19:17:21	\N	\N	Y	N	N	\N	Y	123456	willm3755	\N	willm3755	default1324657089.png	0
819	15	nk47141@uga.edu	086090092070087087080080092	\N	N	2016-08-23 23:45:01	2016-08-23 23:45:01	\N	\N	Y	N	N	\N	Y	5	nima.kt	\N	nima.kt	default1324657089.png	0
820	15	nms85911@uga.edu	086092088069094094086073095046	\N	N	2016-08-24 05:01:02	2016-08-24 05:01:02	\N	\N	Y	N	N	\N	Y	123456	nicolemsmith2	\N	nicolemsmith2	default1324657089.png	0
821	15	dtd81968@uga.edu	119008006010000081066083	\N	N	2016-08-24 14:44:11	2016-08-24 14:44:11	\N	\N	Y	N	N	\N	Y	5	d.drumm19	\N	d.drumm19	default1324657089.png	0
834	15	darup89@uga.edu@uga.edu	120094092066080091082011013	\N	N	2016-08-26 23:15:49	2016-08-26 23:15:49	\N	\N	Y	N	N	\N	N	123456	darup89	\N	darup89	default1324657089.png	0
833	15	mokhtari@uga.edu	068065092068080088004010008	\N	N	2016-08-26 23:14:15	2016-08-26 23:14:15	\N	\N	Y	N	N	\N	Y	123456	mokhtari	\N	mokhtari	default1324657089.png	0
822	15	annatimm@uga.edu	042088065064076007005022	\N	N	2016-08-24 23:44:14	2016-08-24 23:44:14	\N	\N	Y	N	N	\N	Y	123456	annatimm 	\N	annatimm 	default1324657089.png	0
823	15	pbb0005@uga.edu	080087084091076007005028029	\N	N	2016-08-25 13:37:17	2016-08-25 13:37:17	\N	\N	Y	N	N	\N	Y	123456	pbbritt1	\N	pbbritt1	default1324657089.png	0
825	15	jal20486@uga.edu	112064069081070066066075008	\N	N	2016-08-26 19:42:57	2016-08-26 19:42:57	\N	\N	Y	N	N	\N	Y	5	4everJayWalking	\N	4everJayWalking	default1324657089.png	0
826	15	jz89496@uga.edu	107088074013006007006010009	\N	N	2016-08-26 20:00:14	2016-08-26 20:00:14	\N	\N	Y	N	N	\N	Y	5	jz8946	\N	jz8946	default1324657089.png	0
828	15	tt73372@uga.edu	032070087064092006095000	\N	N	2016-08-26 20:15:21	2016-08-26 20:15:21	\N	\N	Y	N	N	\N	Y	123456	terrencet	\N	terrencet	default1324657089.png	0
827	15	cah67363@uga.edu	080088084069068087095002113112115	\N	N	2016-08-26 20:15:01	2016-08-26 20:15:01	\N	\N	Y	N	N	\N	Y	123456	cah67363	\N	cah67363	default1324657089.png	0
829	15	amberly.ford25@uga.edu	022084065118007004006006	\N	N	2016-08-26 21:25:36	2016-08-26 21:25:36	\N	\N	Y	N	N	\N	Y	123456	anf12002	\N	anf12002	default1324657089.png	0
830	15	mkb01802@uga.edu	017084083065088106014015	\N	N	2016-08-26 21:43:28	2016-08-26 21:43:28	\N	\N	Y	N	N	\N	Y	123456	mkb01802	\N	mkb01802	default1324657089.png	0
831	15	tc58097@uga.edu	002089083070004012005007	\N	N	2016-08-26 21:50:37	2016-08-26 21:50:37	\N	\N	Y	N	N	\N	Y	123456	Michaelctl	\N	Michaelctl	default1324657089.png	0
832	15	klf13229@uga.edu	123094107087068088083092009118	\N	N	2016-08-26 22:41:47	2016-08-26 22:41:47	\N	\N	Y	N	N	\N	Y	123456	klf13229	\N	klf13229	default1324657089.png	0
835	15	py37465@uga.edu	068084069068120008001116117117119116	\N	N	2016-08-27 00:57:54	2016-08-27 00:57:54	\N	\N	Y	N	N	\N	Y	5	pawan yadav	\N	pawan yadav	default1324657089.png	0
836	15	yc19039@uga.edu	117127113004000001	\N	N	2016-08-27 02:11:02	2016-08-27 02:11:02	\N	\N	Y	N	N	\N	Y	123456	karakara	\N	karakara	default1324657089.png	0
837	26	mohdmofeej@tigermail.auburn.edu	123116113001010001	\N	N	2016-08-27 11:12:31	2016-08-27 11:12:31	\N	\N	Y	N	N	\N	N	5	mohd mofeej	\N	mohd mofeej	default1324657089.png	0
838	15	ahn25600@uga.edu	034045040090075002	\N	N	2016-08-27 14:50:49	2016-08-27 14:50:49	\N	\N	Y	N	N	\N	Y	123456	anish_naik	\N	anish_naik	default1324657089.png	0
839	15	fva00141@uga.edu	042032083091082090006	\N	N	2016-08-27 16:49:14	2016-08-27 16:49:14	\N	\N	Y	N	N	\N	Y	5	fabian1	\N	fabian1	default1324657089.png	0
840	15	ebz44072@uga.edu	114005000001002086087067	\N	N	2016-08-27 21:32:02	2016-08-27 21:32:02	\N	\N	Y	N	N	\N	N	123456	emmazipp	\N	emmazipp	default1324657089.png	0
841	15	ctbilz@uga.edu	046040093072002006006	\N	N	2016-08-28 15:54:34	2016-08-28 15:54:34	\N	\N	Y	N	N	\N	Y	123456	ctbilz	\N	ctbilz	default1324657089.png	0
842	15	mlr38095@uga.edu	065093067087090068089000000	\N	N	2016-08-28 16:46:17	2016-08-28 16:46:17	\N	\N	Y	N	N	\N	Y	123456	mlr38095	\N	mlr38095	default1324657089.png	0
843	15	zvs93655@uga.edu	081086084088071038043049040119118118112104	\N	N	2016-08-28 17:20:13	2016-08-28 17:20:13	\N	\N	Y	N	N	\N	Y	5	zvs93655	\N	zvs93655	default1324657089.png	0
844	15	zhaowj@uga.edu	111126118119078090112112112112112112007	\N	N	2016-08-28 17:40:15	2016-08-28 17:40:15	\N	\N	Y	N	N	\N	Y	123456	UGA	\N	UGA	default1324657089.png	0
845	15	nicholas.harbin26@uga.edu	019094080086070065014015	\N	N	2016-08-28 23:31:24	2016-08-28 23:31:24	\N	\N	Y	N	N	\N	Y	123456	nick15679	\N	nick15679	default1324657089.png	0
847	15	jew41693@uga.edu	012094065064077002007005	\N	N	2016-08-29 13:44:33	2016-08-29 13:44:33	\N	\N	Y	N	N	\N	Y	123456	jwellem	\N	jwellem	default1324657089.png	0
848	15	nsf60870@uga.edu	100085067083092081085092036048114	\N	N	2016-08-29 15:30:24	2016-08-29 15:30:24	\N	\N	Y	N	N	\N	Y	5	nsf60870	\N	nsf60870	default1324657089.png	0
849	15	jch53910@uga.edu	127093091093091066006010024	\N	N	2016-08-29 17:22:01	2016-08-29 17:22:01	\N	\N	Y	N	N	\N	Y	123456	jcheath21	\N	jcheath21	default1324657089.png	0
846	15	wds34319@uga.edu	119093089090071081085092121115116	\N	N	2016-08-29 01:50:57	2016-08-29 01:50:57	\N	\N	Y	N	N	\N	Y	5	lost will	\N	lost will	default1324657089.png	0
824	21	jmesa1@student.gsu.edu	090095087116115126009000009113	\N	N	2016-08-25 23:58:43	2016-08-25 23:58:43	\N	\N	Y	N	N	\N	Y	123456	jmesaor	\N	jmesaor	default1324657089.png	0
851	15	packle89@uga.edu	125126113009011000	\N	N	2016-08-29 22:59:29	2016-08-29 22:59:29	\N	\N	Y	N	N	\N	Y	123456	packle89	\N	packle89	default1324657089.png	0
852	15	tbr50114@uga.edu	040093091088081069095082	\N	N	2016-08-29 23:00:22	2016-08-29 23:00:22	\N	\N	Y	N	N	\N	Y	123456	tommyr	\N	tommyr	default1324657089.png	0
854	15	acs63866@uga.edu	080082093089083078009011000112	\N	N	2016-08-29 23:38:11	2016-08-29 23:38:11	\N	\N	Y	N	N	\N	Y	123456	acs63866	\N	acs63866	default1324657089.png	0
855	15	rmh58498@uga.edu	070076087089080088092045115113119113	\N	N	2016-08-30 00:29:28	2016-08-30 00:29:28	\N	\N	Y	N	N	\N	Y	5	RyanHallway	\N	RyanHallway	default1324657089.png	0
49	15	egossett@uga.edu	086093064071080066067010024	\N	N	2015-11-08 20:37:10	2015-11-08 20:37:10	\N	\N	Y	N	N	\N	Y	fe1d0e99876d5a6420929258d824aab8bef98ccfce8655e9dcb7e7fd8d512c5c	Erik Gossett	\N	Erik Gossett	default1324657089.png	0
856	15	nps09914@uga.edu	072093074091086094086085073	\N	N	2016-08-30 02:28:01	2016-08-30 02:28:01	\N	\N	Y	N	N	\N	Y	123456	Champsin	\N	Champsin	default1324657089.png	0
857	15	ltn68637@uga.edu	102065081086095082010009001119	\N	N	2016-08-30 02:50:42	2016-08-30 02:50:42	\N	\N	Y	N	N	\N	Y	123456	lnew1	\N	lnew1	default1324657089.png	0
858	15	jrs1987@uga.edu	087068086078092067112123122113018005102	\N	N	2016-08-30 02:56:31	2016-08-30 02:56:31	\N	\N	Y	N	N	\N	Y	123456	jrs1987	\N	jrs1987	default1324657089.png	0
860	15	Radcliff@uga.edu	034080068094085091007004	\N	N	2016-08-30 11:44:51	2016-08-30 11:44:51	\N	\N	Y	N	N	\N	Y	123456	radcliff	\N	radcliff	default1324657089.png	0
853	15	wj35593@uga.edu	066090065081094007005011013	\N	N	2016-08-29 23:02:27	2016-08-29 23:02:27	\N	\N	Y	N	N	\N	Y	123456	willjanousek	\N	willjanousek	default1324657089.png	0
861	15	vjt44010@uga.edu	065091073078084004007008008	\N	N	2016-08-30 15:55:07	2016-08-30 15:55:07	\N	\N	Y	N	N	\N	Y	5	vinnyt	\N	vinnyt	default1324657089.png	0
862	15	kjb60648@uga.edu	093093069081076014003010008	\N	N	2016-08-30 19:26:13	2016-08-30 19:26:13	\N	\N	Y	N	N	\N	Y	123456	katboll123	\N	katboll123	default1324657089.png	0
1012	15	wnk74688@uga.edu	097067065091093078010000003113	\N	N	2016-09-20 23:23:17	2016-09-20 23:23:17	\N	\N	Y	N	N	\N	Y	123456	wnkelley13	\N	wnkelley13	default1324657089.png	0
863	15	davidg.aguirre98@uga.edu	011084065064093080113006	\N	N	2016-08-30 23:24:32	2016-08-30 23:24:32	\N	\N	Y	N	N	\N	Y	5	DGAguirre	\N	DGAguirre	default1324657089.png	0
865	15	melg93@uga.edu	043040066087095088080	\N	N	2016-08-31 02:53:40	2016-08-31 02:53:40	\N	\N	Y	N	N	\N	Y	123456	melg93	\N	melg93	default1324657089.png	0
867	15	lks42114@uga.edu	117005000006000005007086	\N	N	2016-08-31 12:58:52	2016-08-31 12:58:52	\N	\N	Y	N	N	\N	Y	123456	lks42114	\N	lks42114	default1324657089.png	0
866	15	msb39838@uga.edu	085086091071081094089010003096	\N	N	2016-08-31 04:02:55	2016-08-31 04:02:55	\N	\N	Y	N	N	\N	Y	123456	msb39838	\N	msb39838	default1324657089.png	0
859	15	fgm71755@uga.edu	073087093093084007005011013	\N	N	2016-08-30 09:18:47	2016-08-30 09:18:47	\N	\N	Y	N	N	\N	Y	123456	felixmuniz 	\N	felixmuniz 	default1324657089.png	0
868	15	cbp15396@uga.edu	113092090118089089010009001112	\N	N	2016-09-02 15:13:06	2016-09-02 15:13:06	\N	\N	Y	N	N	\N	Y	123456	Cperry7	\N	Cperry7	default1324657089.png	0
869	15	eam72949@uga.edu	103092080082086079094099113115098	\N	N	2016-09-02 17:06:29	2016-09-02 17:06:29	\N	\N	Y	N	N	\N	Y	123456	emar1516	\N	emar1516	default1324657089.png	0
870	15	jtl33883@uga.edu	095089069092088094045055040033116116116	\N	N	2016-09-03 16:13:40	2016-09-03 16:13:40	\N	\N	Y	N	N	\N	Y	123456	Jordanlaskey	\N	Jordanlaskey	default1324657089.png	0
871	15	rmf03358@uga.edu	025006112000003006005	\N	N	2016-09-03 16:18:43	2016-09-03 16:18:43	\N	\N	Y	N	N	\N	Y	123456	Ruthy2016	\N	Ruthy2016	default1324657089.png	0
872	15	brh29076@uga.edu	086094094072073085051040044042032053118	\N	N	2016-09-03 16:25:33	2016-09-03 16:25:33	\N	\N	Y	N	N	\N	Y	123456	ben2b15	\N	ben2b15	default1324657089.png	0
873	15	nikepatel@uga.edu	060034044001003029	\N	N	2016-09-03 16:41:06	2016-09-03 16:41:06	\N	\N	Y	N	N	\N	N	123456	nikepatel55	\N	nikepatel55	default1324657089.png	0
874	15	nnp20095@uga.edu	124067091066083069010009001114	\N	N	2016-09-03 16:41:42	2016-09-03 16:41:42	\N	\N	Y	N	N	\N	Y	123456	nnp20095	\N	nnp20095	default1324657089.png	0
875	15	mek41107@uga.edu	091095091067083078087076004096	\N	N	2016-09-03 16:56:26	2016-09-03 16:56:26	\N	\N	Y	N	N	\N	Y	123456	mek41107	\N	mek41107	default1324657089.png	0
876	15	slu11193@uga.edu	096065070094094084086070036048123	\N	N	2016-09-03 17:03:28	2016-09-03 17:03:28	\N	\N	Y	N	N	\N	Y	123456	sydneyuphold	\N	sydneyuphold	default1324657089.png	0
877	15	epm41205@uga.edu	043040066087095088080	\N	N	2016-09-03 17:10:51	2016-09-03 17:10:51	\N	\N	Y	N	N	\N	Y	123456	emmapersy	\N	emmapersy	default1324657089.png	0
879	15	add24311@uga.edu	047035046090091086	\N	N	2016-09-03 17:38:05	2016-09-03 17:38:05	\N	\N	Y	N	N	\N	Y	5	atltaken85	\N	atltaken85	default1324657089.png	0
880	15	huipu.gao@uga.edu	123112002006003005013	\N	N	2016-09-03 17:47:06	2016-09-03 17:47:06	\N	\N	Y	N	N	\N	Y	5	pursgao	\N	pursgao	default1324657089.png	0
882	15	ler25345@uga.edu	032041051003007001	\N	N	2016-09-03 17:52:55	2016-09-03 17:52:55	\N	\N	Y	N	N	\N	Y	123456	ler25345	\N	ler25345	default1324657089.png	0
881	15	lp40675@uga.edu	045080064090090092085088	\N	N	2016-09-03 17:49:55	2016-09-03 17:49:55	\N	\N	Y	N	N	\N	Y	123456	laripenha23	\N	laripenha23	default1324657089.png	0
878	15	cbf58815@uga.edu	035067093092095013001002	\N	N	2016-09-03 17:19:38	2016-09-03 17:19:38	\N	\N	Y	N	N	\N	Y	123456	cbfranchini	\N	cbfranchini	default1324657089.png	0
889	15	ajh14191@uga.edu	113119122076092045006044035054112118120123	\N	N	2016-09-04 08:07:27	2016-09-04 08:07:27	\N	\N	Y	N	N	\N	Y	5	ajh14191	\N	ajh14191	default1324657089.png	0
884	15	ojo28280@uga.edu	067091066083069075083081056003114	\N	N	2016-09-03 23:12:29	2016-09-03 23:12:29	\N	\N	Y	N	N	\N	Y	123456	Noj	\N	Noj	default1324657089.png	0
885	15	jlw27253@uga.edu	091069002006007003014015024	\N	N	2016-09-04 00:21:59	2016-09-04 00:21:59	\N	\N	Y	N	N	\N	Y	123456	jlw27253	\N	jlw27253	default1324657089.png	0
887	15	zcz74700@uga.edu	003085086091071081094089010	\N	N	2016-09-04 03:56:39	2016-09-04 03:56:39	\N	\N	Y	N	N	\N	Y	123456	zackziegler8	\N	zackziegler8	default1324657089.png	0
888	15	tjp62575@uga.edu	091087071081071004004001008	\N	N	2016-09-04 04:14:11	2016-09-04 04:14:11	\N	\N	Y	N	N	\N	Y	123456	tpalatine	\N	tpalatine	default1324657089.png	0
890	15	reaganreese@uga.edu	038088092084081071007006	\N	N	2016-09-04 13:49:20	2016-09-04 13:49:20	\N	\N	Y	N	N	\N	Y	123456	rzreese 	\N	rzreese 	default1324657089.png	0
891	15	dst52271@uga.edu	003002003005013015000014000	\N	N	2016-09-04 14:23:55	2016-09-04 14:23:55	\N	\N	Y	N	N	\N	Y	123456	danilat39	\N	danilat39	default1324657089.png	0
892	15	meh02277@uga.edu	127080083071093075000112036038054043	\N	N	2016-09-04 15:00:41	2016-09-04 15:00:41	\N	\N	Y	N	N	\N	Y	5	hise01	\N	hise01	default1324657089.png	0
893	15	rwc72456@uga.edu	118089088072092066112123122115119119102	\N	N	2016-09-04 19:42:55	2016-09-04 19:42:55	\N	\N	Y	N	N	\N	Y	123456	GTCoop	\N	GTCoop	default1324657089.png	0
895	15	pg84794@uga.edu	099123120119115120119127012003007	\N	N	2016-09-04 19:49:25	2016-09-04 19:49:25	\N	\N	Y	N	N	\N	Y	5	pg84794	\N	pg84794	default1324657089.png	0
894	15	jqm23432@uga.edu	126113005005085077080	\N	N	2016-09-04 19:46:20	2016-09-04 19:46:20	\N	\N	Y	N	N	\N	Y	123456	jeremiahqm	\N	jeremiahqm	default1324657089.png	0
896	15	cgf17720@uga.edu	125080064090084082074011001096	\N	N	2016-09-05 02:09:12	2016-09-05 02:09:12	\N	\N	Y	N	N	\N	Y	123456	cgf17720	\N	cgf17720	default1324657089.png	0
897	15	mx58886@uga.edu	075089086007014001013000118112113	\N	N	2016-09-05 04:23:25	2016-09-05 04:23:25	\N	\N	Y	N	N	\N	Y	123456	Erin	\N	Erin	default1324657089.png	0
898	15	tns84564@uga.edu	081091071086094082093075001117	\N	N	2016-09-05 07:04:55	2016-09-05 07:04:55	\N	\N	Y	N	N	\N	Y	123456	taycole14	\N	taycole14	default1324657089.png	0
50	15	cjb60607@uga.edu	121083094089080068005009024	\N	N	2015-11-08 20:38:57	2015-11-08 20:38:57	\N	\N	Y	N	N	\N	Y	9667daa7e6a2fed4b40df5ed88a52beb3f761bab975a4d1a4961f5b050a7f495	ChrisBlack	\N	ChrisBlack	default1324657089.png	0
899	15	nbea@uga.edu	015088089092004007006001	\N	N	2016-09-05 14:44:58	2016-09-05 14:44:58	\N	\N	Y	N	N	\N	Y	123456	nbea	\N	nbea	default1324657089.png	0
900	15	pj89675@uga.edu	095090070090093067089080076	\N	N	2016-09-05 19:27:36	2016-09-05 19:27:36	\N	\N	Y	N	N	\N	Y	5	Pragati Jain	\N	Pragati Jain	default1324657089.png	0
901	15	jd40653@uga.edu	120082087094095082064086007107	\N	N	2016-09-05 19:33:22	2016-09-05 19:33:22	\N	\N	Y	N	N	\N	Y	123456	jackiedaniello	\N	jackiedaniello	default1324657089.png	0
902	15	rld33819@uga.edu	014066095092090080007005	\N	N	2016-09-05 20:44:32	2016-09-05 20:44:32	\N	\N	Y	N	N	\N	Y	5	rdurkee47	\N	rdurkee47	default1324657089.png	0
903	15	hy20763@uga.edu	042058120116	\N	N	2016-09-05 21:41:49	2016-09-05 21:41:49	\N	\N	Y	N	N	\N	Y	5	hyin278	\N	hyin278	default1324657089.png	0
904	15	rhw64090@uga.edu	035053069093000005006	\N	N	2016-09-05 22:01:55	2016-09-05 22:01:55	\N	\N	Y	N	N	\N	Y	123456	rwebb5000	\N	rwebb5000	default1324657089.png	0
886	15	dri42333@uga.edu	051094065080091080007006	\N	N	2016-09-04 02:06:26	2016-09-04 02:06:26	\N	\N	Y	N	N	\N	Y	123456	danielle.impara	\N	danielle.impara	default1324657089.png	0
905	15	brt49845@uga.edu	070070069089064082036048049061054046052	\N	N	2016-09-06 04:08:09	2016-09-06 04:08:09	\N	\N	Y	N	N	\N	Y	123456	baytay	\N	baytay	default1324657089.png	0
69	14	calemonds@valdosta.edu	019080091087081071007007	\N	N	2015-12-03 00:31:33	2015-12-03 00:31:33	\N	\N	Y	N	N	\N	Y	4ed3e2da5b568a5f7394551b17dba9af8eddbaa47401661bfd5046efe5241337	calemonds	\N	calemonds	default1324657089.png	0
110	30	jeremyss@uab.edu	081091071083083010093085032054043	\N	N	2015-12-06 15:38:29	2015-12-06 15:38:29	\N	\N	Y	N	N	\N	Y	5	eatabogon	\N	eatabogon	default1324657089.png	0
98	14	kmkirkland@valdosta.edu	065092082065084086084085001112	\N	N	2015-12-05 03:46:56	2015-12-05 03:46:56	\N	\N	Y	N	N	\N	N		kmkirkland	\N	kmkirkland	default1324657089.png	0
111	18	aking121@students.kennesaw.edu	112003000010006005006002	\N	N	2015-12-06 17:28:16	2015-12-06 17:28:16	\N	\N	Y	N	N	\N	Y		alexking1229	\N	alexking1229	default1324657089.png	0
41	15	gagirl93@uga.edu	066082071070065088074093009114	\N	N	2015-11-06 23:13:12	2015-11-06 23:13:12	\N	\N	Y	N	N	\N	Y	73c68d3b72c596dd725a0eb9f930a412ba647d6b58c203598624f062cd42c6f0	schwartzkath	\N	schwartzkath	default1324657089.png	0
1068	15	ccg02287@uga.edu	096067092091084080080083042115098	\N	N	2016-09-30 23:10:15	2016-09-30 23:10:15	\N	\N	Y	N	N	\N	Y	123456	ccg02287@uga.edu	\N	ccg02287@uga.edu	default1324657089.png	0
909	15	kb85831@uga.edu	035093071085082004004004	\N	N	2016-09-06 19:35:45	2016-09-06 19:35:45	\N	\N	Y	N	N	\N	Y	123456	kharabang 	\N	kharabang 	default1324657089.png	0
910	15	drg36360@uga.edu	038067083074005004015003	\N	N	2016-09-06 20:27:45	2016-09-06 20:27:45	\N	\N	Y	N	N	\N	Y	5	dgray	\N	dgray	default1324657089.png	0
911	15	xz26057@uga.edu	059073090003012007006025	\N	N	2016-09-06 21:33:59	2016-09-06 21:33:59	\N	\N	Y	N	N	\N	Y	123456	Xiaohan Zhang 	\N	Xiaohan Zhang 	default1324657089.png	0
912	15	jah59647@uga.edu	003002002006091083068080081	\N	N	2016-09-06 21:44:10	2016-09-06 21:44:10	\N	\N	Y	N	N	\N	Y	123456	jah12d	\N	jah12d	default1324657089.png	0
913	15	johncartlidge25@uga.edu	113065089090083087094067112119098	\N	N	2016-09-07 17:12:41	2016-09-07 17:12:41	\N	\N	Y	N	N	\N	N	123456	jtc51758	\N	jtc51758	default1324657089.png	0
914	15	kkc58581@uga.edu	000006006002003001013008000120	\N	N	2016-09-08 20:36:40	2016-09-08 20:36:40	\N	\N	Y	N	N	\N	N	123456	katiekoernertcarr	\N	katiekoernertcarr	default1324657089.png	0
916	15	jlm97407@uga.edu	038045092002005006000	\N	N	2016-09-09 18:12:40	2016-09-09 18:12:40	\N	\N	Y	N	N	\N	Y	123456	jodylmilford	\N	jodylmilford	default1324657089.png	0
917	15	kenzie13@uga.edu	063045047085075064	\N	N	2016-09-09 18:20:49	2016-09-09 18:20:49	\N	\N	Y	N	N	\N	Y	123456	kenzie13	\N	kenzie13	default1324657089.png	0
918	15	jnm78392@uga.edu	043094075065091077002002	\N	N	2016-09-09 18:21:27	2016-09-09 18:21:27	\N	\N	Y	N	N	\N	Y	123456	jnm45	\N	jnm45	default1324657089.png	0
919	15	ugajen17@uga.edu	081088090088083081092001115113098	\N	N	2016-09-09 18:22:50	2016-09-09 18:22:50	\N	\N	Y	N	N	\N	Y	123456	ugajen17	\N	ugajen17	default1324657089.png	0
920	15	mkb44878@uga.edu	032095086074012006015003	\N	N	2016-09-09 18:28:31	2016-09-09 18:28:31	\N	\N	Y	N	N	\N	Y	123456	mkblovesthedawgs	\N	mkblovesthedawgs	default1324657089.png	0
921	15	kwhite28@uga.edu	049068064067088080007005	\N	N	2016-09-09 18:36:59	2016-09-09 18:36:59	\N	\N	Y	N	N	\N	Y	5	KaylasWhite95	\N	KaylasWhite95	default1324657089.png	0
922	15	lbg57986@uga.edu	113091093065066082074074003096	\N	N	2016-09-09 18:50:47	2016-09-09 18:50:47	\N	\N	Y	N	N	\N	Y	123456	lgriffith19	\N	lgriffith19	default1324657089.png	0
924	15	srf21853@uga.edu	065083070088080091090089008	\N	N	2016-09-09 19:42:48	2016-09-09 19:42:48	\N	\N	Y	N	N	\N	Y	5	sfutch2	\N	sfutch2	default1324657089.png	0
915	15	Kathleen.carr@uga.edu	000006006002003001013008000120	\N	N	2016-09-09 02:28:26	2016-09-09 02:28:26	\N	\N	Y	N	N	\N	Y	123456	Kathleenkoernertcarr	\N	Kathleenkoernertcarr	default1324657089.png	0
923	15	jlw03680@uga.edu	127115101125116121000010113125127119118	\N	N	2016-09-09 19:28:09	2016-09-09 19:28:09	\N	\N	Y	N	N	\N	Y	123456	jlw03680	\N	jlw03680	default1324657089.png	0
955	18	sneely2@students.kennesaw.edu	045082090064006005007002	\N	N	2016-09-13 04:23:44	2016-09-13 04:23:44	\N	\N	Y	N	N	\N	Y	123456	Sneel 	\N	Sneel 	default1324657089.png	0
926	15	apl40571@uga.edu	096087093091088087073089036115119	\N	N	2016-09-09 22:55:19	2016-09-09 22:55:19	\N	\N	Y	N	N	\N	Y	123456	apl40571	\N	apl40571	default1324657089.png	0
927	15	elewis13@uga.edu	127090085088095029009000009116	\N	N	2016-09-09 22:59:18	2016-09-09 22:59:18	\N	\N	Y	N	N	\N	Y	123456	elewis13	\N	elewis13	default1324657089.png	0
928	15	wjg33159@uga.edu	115019070081087005069074064	\N	N	2016-09-10 12:35:45	2016-09-10 12:35:45	\N	\N	Y	N	N	\N	Y	5	joshgilbert7	\N	joshgilbert7	default1324657089.png	0
929	15	smr43995@uga.edu	064092071080088069087074085050	\N	N	2016-09-10 21:16:31	2016-09-10 21:16:31	\N	\N	Y	N	N	\N	Y	123456	smrosen	\N	smrosen	default1324657089.png	0
931	15	kag52470@uga.edu	066093080087080068023010011	\N	N	2016-09-11 16:35:57	2016-09-11 16:35:57	\N	\N	Y	N	N	\N	Y	123456	based_kaykay	\N	based_kaykay	default1324657089.png	0
932	15	aml12@uga.edu	112071064064092088006010024	\N	N	2016-09-11 17:57:59	2016-09-11 17:57:59	\N	\N	Y	N	N	\N	Y	123456	aleonard12	\N	aleonard12	default1324657089.png	0
934	18	awynn5@students.kennesaw.edu	032046069070086070076	\N	N	2016-09-11 23:01:10	2016-09-11 23:01:10	\N	\N	Y	N	N	\N	N	123456	Awynn	\N	Awynn	default1324657089.png	0
936	18	tdeighan@students.kennesaw.edu	116086075082085053032034040041025112121120	\N	N	2016-09-11 23:59:02	2016-09-11 23:59:02	\N	\N	Y	N	N	\N	N	123456	tdeighan	\N	tdeighan	default1324657089.png	0
949	18	afinch5@students.kennesaw.edu	089086090091083068089078001120	\N	N	2016-09-12 18:50:06	2016-09-12 18:50:06	\N	\N	Y	N	N	\N	Y	123456	afinch5	\N	afinch5	default1324657089.png	0
937	15	ceg46984@uga.edu	082087084005007007007001014	\N	N	2016-09-12 00:16:26	2016-09-12 00:16:26	\N	\N	Y	N	N	\N	Y	123456	carolinegregor	\N	carolinegregor	default1324657089.png	0
197	15	new21447@uga.edu	069090087094091086086012001096	\N	N	2016-01-08 00:15:11	2016-01-08 00:15:11	\N	\N	Y	N	N	\N	Y		new21447	\N	new21447	default1324657089.png	0
206	18	aenser1@students.kennesaw.edu	121120115008002007	\N	N	2016-01-18 13:46:06	2016-01-18 13:46:06	\N	\N	Y	N	N	\N	Y	123456	alexaenser	\N	alexaenser	default1324657089.png	0
188	14	chascott@valdosta.edu	006069087080092001004004	\N	N	2016-01-01 19:03:52	2016-01-01 19:03:52	\N	\N	Y	N	N	\N	N	123456	cscott423	\N	cscott423	default1324657089.png	0
201	15	Rennie@uga.edu	046062046095081092	\N	N	2016-01-14 01:40:23	2016-01-14 01:40:23	\N	\N	Y	N	N	\N	N	123456	renniec	\N	renniec	default1324657089.png	0
198	15	jparr@uga.edu	043094065091065084070006	\N	N	2016-01-09 21:41:09	2016-01-09 21:41:09	\N	\N	Y	N	N	\N	N	5b3485069945f7d1c1cecc05ce1418f31bccfd04bc7a2c228fd63e412eb8899d	jparrish55	\N	jparrish55	default1324657089.png	0
196	15	emmakm@uga.edu	094090090081069082065091095046	\N	N	2016-01-07 23:14:14	2016-01-07 23:14:14	\N	\N	Y	N	N	\N	Y		emmak8	\N	emmak8	default1324657089.png	0
202	18	plowery5@students.kennesaw.edu	089065093070069078076088073112	\N	N	2016-01-15 19:30:19	2016-01-15 19:30:19	\N	\N	Y	N	N	\N	Y	123456	plowery44	\N	plowery44	default1324657089.png	0
938	15	mlp35191@uga.edu	115087082065087095082086000	\N	N	2016-09-12 05:11:16	2016-09-12 05:11:16	\N	\N	Y	N	N	\N	N	123456	mattpott090	\N	mattpott090	default1324657089.png	0
939	15	tgc92146@uga.edu	084085071068082076077001114119116	\N	N	2016-09-12 14:26:30	2016-09-12 14:26:30	\N	\N	Y	N	N	\N	Y	123456	tylergcundiff 	\N	tylergcundiff 	default1324657089.png	0
940	18	vpatel49@students.kennesaw.edu	037040042000000000	\N	N	2016-09-12 15:55:45	2016-09-12 15:55:45	\N	\N	Y	N	N	\N	N	123456	vpatel49	\N	vpatel49	default1324657089.png	0
942	18	mkane9@students.kennesaw.edu	121120114005001007	\N	N	2016-09-12 16:17:10	2016-09-12 16:17:10	\N	\N	Y	N	N	\N	N	123456	Sphinx.jar	\N	Sphinx.jar	default1324657089.png	0
943	18	gryback@students.kennesaw.edu	068071095089091092067050115122125114	\N	N	2016-09-12 16:50:35	2016-09-12 16:50:35	\N	\N	Y	N	N	\N	N	123456	gmariexo	\N	gmariexo	default1324657089.png	0
930	15	rotcdog1@uga.edu	103065093076087095014014008096	\N	N	2016-09-11 16:22:51	2016-09-11 16:22:51	\N	\N	Y	N	N	\N	Y	5	rotcdog1	\N	rotcdog1	default1324657089.png	0
944	18	rneusner@students.kennesaw.edu	034094081092090064066006	\N	N	2016-09-12 17:42:35	2016-09-12 17:42:35	\N	\N	Y	N	N	\N	Y	123456	rneusner	\N	rneusner	default1324657089.png	0
946	18	evo@students.kennesaw.edu	113070064092006007090080085053	\N	N	2016-09-12 18:08:42	2016-09-12 18:08:42	\N	\N	Y	N	N	\N	Y	123456	CIREVO	\N	CIREVO	default1324657089.png	0
947	18	cmagri@students.kennesaw.edu	119071087077065013115041039038054100	\N	N	2016-09-12 18:11:23	2016-09-12 18:11:23	\N	\N	Y	N	N	\N	N	123456	stephaniemagri	\N	stephaniemagri	default1324657089.png	0
948	18	vdiaz2@students.kennesaw.edu	066070070069090082008013000117	\N	N	2016-09-12 18:17:01	2016-09-12 18:17:01	\N	\N	Y	N	N	\N	Y	123456	vd4	\N	vd4	default1324657089.png	0
941	18	bskurpsk@students.kennesaw.edu	098089070070069069092081008	\N	N	2016-09-12 16:08:18	2016-09-12 16:08:18	\N	\N	Y	N	N	\N	Y	5	skurpskiii	\N	skurpskiii	default1324657089.png	0
950	18	tscrudat@students.kennesaw.edu	069070064004013007003001013	\N	N	2016-09-12 19:42:48	2016-09-12 19:42:48	\N	\N	Y	N	N	\N	Y	123456	scroods	\N	scroods	default1324657089.png	0
951	18	bdufek@students.kennesaw.edu	100040045055035049036053059040062041056040111124100100	\N	N	2016-09-12 20:20:51	2016-09-12 20:20:51	\N	\N	Y	N	N	\N	Y	5	bdufek	\N	bdufek	default1324657089.png	0
952	15	mmb52568@uga.edu	089088084122117123093044032114118118	\N	N	2016-09-12 22:12:54	2016-09-12 22:12:54	\N	\N	Y	N	N	\N	Y	123456	somerando123	\N	somerando123	default1324657089.png	0
953	15	jwn46823@uga.edu@uga.edu	050089083087091066006004	\N	N	2016-09-12 22:14:41	2016-09-12 22:14:41	\N	\N	Y	N	N	\N	N	123456	Jacobn	\N	Jacobn	default1324657089.png	0
954	18	dramir11@students.kennesaw.edu	047032095086090081070	\N	N	2016-09-13 00:10:58	2016-09-13 00:10:58	\N	\N	Y	N	N	\N	N	123456	PaolaRamirez	\N	PaolaRamirez	default1324657089.png	0
956	18	csmit696@students.kennesaw.edu	002005004007006005014013009114	\N	N	2016-09-13 05:20:39	2016-09-13 05:20:39	\N	\N	Y	N	N	\N	Y	5	Lollipop492	\N	Lollipop492	default1324657089.png	0
957	15	amw27634@uga.edu	093089089065093081081051052038061100	\N	N	2016-09-13 11:33:28	2016-09-13 11:33:28	\N	\N	Y	N	N	\N	Y	123456	amw27634	\N	amw27634	default1324657089.png	0
958	18	gcagle2@students.kennesaw.edu	112089079089053059044049055049038049022127122	\N	N	2016-09-13 14:10:19	2016-09-13 14:10:19	\N	\N	Y	N	N	\N	Y	123456	gavin.cagle51	\N	gavin.cagle51	default1324657089.png	0
959	18	langel4@students.kennesaw.edu	103090080067090088092045115118118112	\N	N	2016-09-13 14:13:39	2016-09-13 14:13:39	\N	\N	Y	N	N	\N	N	123456	Lanieangel 	\N	Lanieangel 	default1324657089.png	0
906	15	gdd17468@uga.edu	006092093093081076007002	\N	N	2016-09-06 05:27:51	2016-09-06 05:27:51	\N	\N	Y	N	N	\N	Y	123456	GriffinDennison	\N	GriffinDennison	default1324657089.png	0
925	15	ear22625@uga.edu	086089092090078089087094036123117	\N	N	2016-09-09 21:00:40	2016-09-09 21:00:40	\N	\N	Y	N	N	\N	Y	123456	emily.rissmann	\N	emily.rissmann	default1324657089.png	0
933	18	zkaplan@students.kennesaw.edu	059080081091085071079006	\N	N	2016-09-11 23:00:01	2016-09-11 23:00:01	\N	\N	Y	N	N	\N	Y	123456	zachkaplan	\N	zachkaplan	default1324657089.png	0
935	18	jmarroq2@students.kennesaw.edu	115095091086087084087090001121	\N	N	2016-09-11 23:01:46	2016-09-11 23:01:46	\N	\N	Y	N	N	\N	Y	123456	andresmd94	\N	andresmd94	default1324657089.png	0
962	15	jwa17363@uga.edu	081065089090083089078087050115113	\N	N	2016-09-13 20:33:17	2016-09-13 20:33:17	\N	\N	Y	N	N	\N	Y	5	johnAdd	\N	johnAdd	default1324657089.png	0
963	15	kmn71813@uga.edu	010002001067087084085007	\N	N	2016-09-14 03:38:20	2016-09-14 03:38:20	\N	\N	Y	N	N	\N	Y	123456	knettleship	\N	knettleship	default1324657089.png	0
964	15	cjb25075@uga.edu	087091071090080069068000001	\N	N	2016-09-14 03:48:39	2016-09-14 03:48:39	\N	\N	Y	N	N	\N	Y	123456	calebjordan	\N	calebjordan	default1324657089.png	0
965	15	mdt01789@uga.edu	003068065071081071004007	\N	N	2016-09-14 17:12:50	2016-09-14 17:12:50	\N	\N	Y	N	N	\N	Y	123456	michael Toplisek	\N	michael Toplisek	default1324657089.png	0
966	15	aem91807@uga.edu	080080081077007005002015024	\N	N	2016-09-14 17:14:45	2016-09-14 17:14:45	\N	\N	Y	N	N	\N	Y	123456	aem91807	\N	aem91807	default1324657089.png	0
968	15	kyle.ganeriwal@uga.edu	117095093074067036042044047044035052105120	\N	N	2016-09-14 17:16:25	2016-09-14 17:16:25	\N	\N	Y	N	N	\N	Y	123456	kyle.ganeriwal	\N	kyle.ganeriwal	default1324657089.png	0
967	15	esg46096@uga.edu	036092091095077002007000	\N	N	2016-09-14 17:15:37	2016-09-14 17:15:37	\N	\N	Y	N	N	\N	Y	5	esgarner	\N	esgarner	default1324657089.png	0
969	15	nsc84572@uga.edu	095091080095001001006010010	\N	N	2016-09-14 17:44:00	2016-09-14 17:44:00	\N	\N	Y	N	N	\N	Y	123456	nickcarter47	\N	nickcarter47	default1324657089.png	0
970	15	joanna.jernigan25@uga.edu	096069064095069076008002114113098	\N	N	2016-09-14 17:54:59	2016-09-14 17:54:59	\N	\N	Y	N	N	\N	Y	123456	joannajernigan	\N	joannajernigan	default1324657089.png	0
971	15	zpt27478@uga.edu	104082087084082082084080083112	\N	N	2016-09-14 18:17:40	2016-09-14 18:17:40	\N	\N	Y	N	N	\N	N	5	zinack24	\N	zinack24	default1324657089.png	0
972	15	cjb68480@uga.edu	040085085082080084091089	\N	N	2016-09-14 18:24:24	2016-09-14 18:24:24	\N	\N	Y	N	N	\N	Y	5	cjb68480	\N	cjb68480	default1324657089.png	0
973	15	ncm86561@uga.edu	098092003067086006089093024	\N	N	2016-09-14 18:34:14	2016-09-14 18:34:14	\N	\N	Y	N	N	\N	Y	123456	ncm86561	\N	ncm86561	default1324657089.png	0
974	15	jts87689@uga.edu	114096085067087089086088088112	\N	N	2016-09-14 18:43:09	2016-09-14 18:43:09	\N	\N	Y	N	N	\N	Y	123456	jts87689	\N	jts87689	default1324657089.png	0
975	15	mab03779@uga.edu	063060032067089074	\N	N	2016-09-14 19:21:38	2016-09-14 19:21:38	\N	\N	Y	N	N	\N	Y	123456	matt911511	\N	matt911511	default1324657089.png	0
976	15	km55991@uga.edu	122080070086086093069051043110125116	\N	N	2016-09-14 19:57:11	2016-09-14 19:57:11	\N	\N	Y	N	N	\N	Y	123456	kmead91	\N	kmead91	default1324657089.png	0
977	15	rlw31941@uga.edu	086079088092042054044054032043034037043047057	\N	N	2016-09-14 20:35:31	2016-09-14 20:35:31	\N	\N	Y	N	N	\N	Y	123456	bekah_williamson	\N	bekah_williamson	default1324657089.png	0
978	15	gvs70472@uga.edu	085092088081085069093074068116	\N	N	2016-09-14 20:43:03	2016-09-14 20:43:03	\N	\N	Y	N	N	\N	Y	123456	gstewart88	\N	gstewart88	default1324657089.png	0
979	15	cpc11845@uga.edu	116070085066090088064051045119117125	\N	N	2016-09-14 20:47:57	2016-09-14 20:47:57	\N	\N	Y	N	N	\N	Y	5	coryc11	\N	coryc11	default1324657089.png	0
980	15	vpn81444@uga.edu	121091085091094095087088009121	\N	N	2016-09-14 21:36:24	2016-09-14 21:36:24	\N	\N	Y	N	N	\N	Y	123456	Victor	\N	Victor	default1324657089.png	0
982	15	kab53150@uga.edu	120085065095082095080066045002114	\N	N	2016-09-14 23:27:01	2016-09-14 23:27:01	\N	\N	Y	N	N	\N	Y	123456	kab53150	\N	kab53150	default1324657089.png	0
983	15	neh62476@uga.edu	098071093071093095089093008	\N	N	2016-09-15 00:28:45	2016-09-15 00:28:45	\N	\N	Y	N	N	\N	Y	123456	nataliehirsch	\N	nataliehirsch	default1324657089.png	0
984	15	atb83369@uga.edu	123093094095089095121001120123123	\N	N	2016-09-15 01:01:38	2016-09-15 01:01:38	\N	\N	Y	N	N	\N	Y	123456	atb83369	\N	atb83369	default1324657089.png	0
981	15	nnt53823@uga.edu	007004003015009068032044043049042040032	\N	N	2016-09-14 23:08:08	2016-09-14 23:08:08	\N	\N	Y	N	N	\N	Y	5	Gwen	\N	Gwen	default1324657089.png	0
985	15	jfh11642@uga.edu	043088095084091089080014	\N	N	2016-09-15 17:31:40	2016-09-15 17:31:40	\N	\N	Y	N	N	\N	Y	123456	jimbo9	\N	jimbo9	default1324657089.png	0
986	15	ikm22964@uga.edu	053089087002007000001014	\N	N	2016-09-16 03:24:40	2016-09-16 03:24:40	\N	\N	Y	N	N	\N	Y	123456	ikm1	\N	ikm1	default1324657089.png	0
987	15	pcs62793@uga.edu	059041088065088081076	\N	N	2016-09-16 15:48:12	2016-09-16 15:48:12	\N	\N	Y	N	N	\N	Y	123456	ChaseS	\N	ChaseS	default1324657089.png	0
988	15	sdh80880@uga.edu	053067093070086089083000	\N	N	2016-09-16 21:20:16	2016-09-16 21:20:16	\N	\N	Y	N	N	\N	Y	123456	sdh80880	\N	sdh80880	default1324657089.png	0
989	15	btk47759@uga.edu	043084070071085088087089	\N	N	2016-09-17 03:16:01	2016-09-17 03:16:01	\N	\N	Y	N	N	\N	Y	5	btk	\N	btk	default1324657089.png	0
945	18	cwelch24@students.kennesaw.edu	122089069087091093075000116112112	\N	N	2016-09-12 17:53:17	2016-09-12 17:53:17	\N	\N	Y	N	N	\N	Y	123456	Cameron.Welch	\N	Cameron.Welch	default1324657089.png	0
990	15	mcgernatt@uga.edu	067080075089039054058041044045034121127107011	\N	N	2016-09-18 18:32:56	2016-09-18 18:32:56	\N	\N	Y	N	N	\N	Y	123456	mcgernatt	\N	mcgernatt	default1324657089.png	0
991	15	anthony.le@uga.edu	113093082084086086094112112114114	\N	N	2016-09-18 21:00:13	2016-09-18 21:00:13	\N	\N	Y	N	N	\N	Y	5	anthony.le	\N	anthony.le	default1324657089.png	0
992	15	kap55443@uga.edu	064086080092065094072092067121	\N	N	2016-09-18 22:23:40	2016-09-18 22:23:40	\N	\N	Y	N	N	\N	Y	123456	joshhutchersonscat	\N	joshhutchersonscat	default1324657089.png	0
993	18	cvanhor1@students.kennesaw.edu	099007071069089081090091036054058	\N	N	2016-09-18 22:58:47	2016-09-18 22:58:47	\N	\N	Y	N	N	\N	N	123456	chasevanhorn	\N	chasevanhorn	default1324657089.png	0
994	18	djone241@students.kennesaw.edu	033035047084075073	\N	N	2016-09-18 22:59:01	2016-09-18 22:59:01	\N	\N	Y	N	N	\N	N	123456	princejones06	\N	princejones06	default1324657089.png	0
995	18	dbright2@students.kennesaw.edu	087093095084083095089045035114118118	\N	N	2016-09-18 22:59:26	2016-09-18 22:59:26	\N	\N	Y	N	N	\N	N	123456	dillyb	\N	dillyb	default1324657089.png	0
996	18	ndickso1@students.kennesaw.edu@students.kennesaw.edu	088087080095080085096114123117115113119	\N	N	2016-09-18 23:00:11	2016-09-18 23:00:11	\N	\N	Y	N	N	\N	N	123456	ndickso1	\N	ndickso1	default1324657089.png	0
997	18	ndickso1@students.kennesaw.edu	088087080095080085096114123117115113119	\N	N	2016-09-18 23:00:49	2016-09-18 23:00:49	\N	\N	Y	N	N	\N	N	123456	noahld	\N	noahld	default1324657089.png	0
998	15	bkb25916@uga.edu	035003064007085001082006	\N	N	2016-09-19 00:56:41	2016-09-19 00:56:41	\N	\N	Y	N	N	\N	Y	123456	burks2441	\N	burks2441	default1324657089.png	0
999	26	test123456@tigermail.auburn.edu	040	\N	Y	2016-09-19 15:28:52	2016-09-19 00:00:00	Administrator	182.70.1.234	Y	N	N	\N	N	5	test	\N	test	default1324657089.png	0
1000	15	sgn59736@uga.edu	034080064069081071007007	\N	N	2016-09-19 15:44:34	2016-09-19 15:44:34	\N	\N	Y	N	N	\N	Y	123456	sgn59736	\N	sgn59736	default1324657089.png	0
1001	15	ajm83591@uga.edu	120125117006011004	\N	N	2016-09-19 21:56:55	2016-09-19 21:56:55	\N	\N	Y	N	N	\N	Y	123456	ajmarshall14	\N	ajmarshall14	default1324657089.png	0
1002	15	bpmike@uga.edu	113068088095084080088085045049098	\N	N	2016-09-19 21:58:20	2016-09-19 21:58:20	\N	\N	Y	N	N	\N	Y	123456	bpmike	\N	bpmike	default1324657089.png	0
1004	15	gainslie@uga.edu	006088080090071070007005	\N	N	2016-09-19 22:01:08	2016-09-19 22:01:08	\N	\N	Y	N	N	\N	N	123456	gainslie	\N	gainslie	default1324657089.png	0
1003	15	kmt61367@uga.edu	098087082083064090091001015	\N	N	2016-09-19 22:00:21	2016-09-19 22:00:21	\N	\N	Y	N	N	\N	Y	123456	Kthwaits	\N	Kthwaits	default1324657089.png	0
1005	15	sgp09779@uga.edu	064092084088082009011003117119098	\N	N	2016-09-19 22:31:00	2016-09-19 22:31:00	\N	\N	Y	N	N	\N	Y	123456	sgpkeeper	\N	sgpkeeper	default1324657089.png	0
1006	15	zeb66481@uga.edu	003002004005004007009008002120	\N	N	2016-09-19 22:31:19	2016-09-19 22:31:19	\N	\N	Y	N	N	\N	Y	123456	zeb66481	\N	zeb66481	default1324657089.png	0
1007	15	darryl@uga.edu	000007002004120095091084024	\N	N	2016-09-20 19:43:04	2016-09-20 19:43:04	\N	\N	Y	N	N	\N	Y	123456	darryldavidson	\N	darryldavidson	default1324657089.png	0
1008	15	jdanielpelletier@gmail.com@uga.edu	018090075095085071007005	\N	N	2016-09-20 22:53:28	2016-09-20 22:53:28	\N	\N	Y	N	N	\N	N	123456	danielpelletier	\N	danielpelletier	default1324657089.png	0
1010	15	lsk71634@uga.edu	084070080079095087076094037122116	\N	N	2016-09-20 22:54:47	2016-09-20 22:54:47	\N	\N	Y	N	N	\N	Y	123456	jaguar077	\N	jaguar077	default1324657089.png	0
1009	15	danielpelletier@uga.edu	018090075095085071007005	\N	N	2016-09-20 22:54:05	2016-09-20 22:54:05	\N	\N	Y	N	N	\N	Y	123456	Easondayone 	\N	Easondayone 	default1324657089.png	0
1011	15	art04658@uga.edu	112003001007001003001015	\N	N	2016-09-20 23:08:23	2016-09-20 23:08:23	\N	\N	Y	N	N	\N	Y	123456	Emilysummer16	\N	Emilysummer16	default1324657089.png	0
1013	15	jnb90721@uga.edu	121081081084094075081095049113123	\N	N	2016-09-20 23:39:33	2016-09-20 23:39:33	\N	\N	Y	N	N	\N	Y	123456	jedbishop	\N	jedbishop	default1324657089.png	0
1014	15	ajg30177@uga.edu	053088070082090004004015	\N	N	2016-09-20 23:41:36	2016-09-20 23:41:36	\N	\N	Y	N	N	\N	Y	123456	agottlieb128	\N	agottlieb128	default1324657089.png	0
1015	15	rab02260@uga.edu	035069070091005005007003	\N	N	2016-09-20 23:48:04	2016-09-20 23:48:04	\N	\N	Y	N	N	\N	Y	123456	rabazemore	\N	rabazemore	default1324657089.png	0
1016	15	wgd24250@uga.edu	100117114080084065080075008	\N	N	2016-09-20 23:53:07	2016-09-20 23:53:07	\N	\N	Y	N	N	\N	Y	123456	willdreggors	\N	willdreggors	default1324657089.png	0
1017	18	whittingslow22@gmail.com@students.kennesaw.edu	112082071080084086084085002115	\N	Y	2016-09-20 23:57:22	2016-09-21 00:00:00	Administrator	50.150.17.28	Y	N	N	\N	N	\N	ksuthriftskool	\N	ksuthriftskool	default1324657089.png	0
1018	15	hnt54828@uga.edu	101088094077082032046047023042042100121113	\N	N	2016-09-21 00:22:34	2016-09-21 00:22:34	\N	\N	Y	N	N	\N	Y	123456	Sol-1678	\N	Sol-1678	default1324657089.png	0
1019	15	reidkoski@uga.edu	082086087087077087086074032112114	\N	N	2016-09-21 01:00:43	2016-09-21 01:00:43	\N	\N	Y	N	N	\N	Y	123456	rkoski	\N	rkoski	default1324657089.png	0
1020	15	mtm07826@uga.edu	117083087080076024006010010	\N	N	2016-09-21 02:27:18	2016-09-21 02:27:18	\N	\N	Y	N	N	\N	Y	5	mtmalcom	\N	mtmalcom	default1324657089.png	0
1021	15	renck@uga.edu	038094086092083070007005	\N	N	2016-09-21 03:13:22	2016-09-21 03:13:22	\N	\N	Y	N	N	\N	Y	123456	renck	\N	renck	default1324657089.png	0
1022	15	hm16410@uga.edu	049080067094006005068088	\N	N	2016-09-21 03:24:59	2016-09-21 03:24:59	\N	\N	Y	N	N	\N	Y	123456	HarshRhymesWith	\N	HarshRhymesWith	default1324657089.png	0
1023	15	wwj75252@uga.edu	115083064081087087091084008	\N	N	2016-09-21 03:47:11	2016-09-21 03:47:11	\N	\N	Y	N	N	\N	Y	123456	walkeronyou	\N	walkeronyou	default1324657089.png	0
1024	15	qi1995@uga.edu	064091011006004005007011011	\N	N	2016-09-21 06:43:33	2016-09-21 06:43:33	\N	\N	Y	N	N	\N	Y	123456	tingting Qi	\N	tingting Qi	default1324657089.png	0
1025	15	jh54608@uga.edu	066094090089095095090010011	\N	N	2016-09-21 13:08:21	2016-09-21 13:08:21	\N	\N	Y	N	N	\N	Y	123456	jose0201	\N	jose0201	default1324657089.png	0
1026	15	est28415@uga.edu	007080094095006005007001	\N	N	2016-09-21 14:01:39	2016-09-21 14:01:39	\N	\N	Y	N	N	\N	Y	123456	esthomas	\N	esthomas	default1324657089.png	0
1027	15	colt45@uga.edu	034005081006087002085001	\N	N	2016-09-21 18:03:29	2016-09-21 18:03:29	\N	\N	Y	N	N	\N	Y	123456	colt45	\N	colt45	default1324657089.png	0
1028	15	bcd94145@uga.edu	067082078069090090009011003101	\N	N	2016-09-21 18:16:36	2016-09-21 18:16:36	\N	\N	Y	N	N	\N	Y	123456	bcd94145	\N	bcd94145	default1324657089.png	0
1029	15	uga21857@uga.edu	003113070094085091006006	\N	N	2016-09-21 19:02:53	2016-09-21 19:02:53	\N	\N	Y	N	N	\N	N	123456	andersonryan	\N	andersonryan	default1324657089.png	0
1030	15	rpa21857@uga.edu	003113070094085091006006	\N	N	2016-09-21 19:03:40	2016-09-21 19:03:40	\N	\N	Y	N	N	\N	Y	123456	ryananderson	\N	ryananderson	default1324657089.png	0
1031	15	rah68344@uga.edu	116067068076080094111010034040032104118	\N	N	2016-09-21 19:16:33	2016-09-21 19:16:33	\N	\N	Y	N	N	\N	N	123456	AustinHale	\N	AustinHale	default1324657089.png	0
1032	15	db49591@uga.edu	121085070070082074010006112112098	\N	N	2016-09-21 19:25:07	2016-09-21 19:25:07	\N	\N	Y	N	N	\N	Y	5	db49591	\N	db49591	default1324657089.png	0
1033	15	ssl10857@uga.edu	093091092090087083086074010	\N	N	2016-09-21 19:49:47	2016-09-21 19:49:47	\N	\N	Y	N	N	\N	Y	5	sleachga	\N	sleachga	default1324657089.png	0
1034	15	kicks13@uga.edu	121090088082065091081038056114119097	\N	N	2016-09-21 20:40:20	2016-09-21 20:40:20	\N	\N	Y	N	N	\N	Y	123456	kicks13	\N	kicks13	default1324657089.png	0
1035	15	jtc56940@uga.edu	066087066065090079086080008	\N	N	2016-09-22 02:24:11	2016-09-22 02:24:11	\N	\N	Y	N	N	\N	Y	123456	tatecook1	\N	tatecook1	default1324657089.png	0
1037	15	aea28705@uga.edu	080095085086093093089090091112	\N	N	2016-09-22 17:36:11	2016-09-22 17:36:11	\N	\N	Y	N	N	\N	Y	123456	aea28705	\N	aea28705	default1324657089.png	0
1038	15	rps29366@uga.edu	112092086087079119008013009118	\N	N	2016-09-22 17:50:08	2016-09-22 17:50:08	\N	\N	Y	N	N	\N	Y	123456	bobby31	\N	bobby31	default1324657089.png	0
1039	15	jad60140@uga.edu	112092084068091081092003120115113	\N	N	2016-09-22 18:23:01	2016-09-22 18:23:01	\N	\N	Y	N	N	\N	Y	5	joshdavis	\N	joshdavis	default1324657089.png	0
1040	15	rdb88391@uga.edu	021084095067081071007005	\N	N	2016-09-23 01:45:30	2016-09-23 01:45:30	\N	\N	Y	N	N	\N	N	123456	rbarnie 	\N	rbarnie 	default1324657089.png	0
1041	18	dfrizzel@students.kennesaw.edu	049094094092003004000007	\N	N	2016-09-23 14:46:33	2016-09-23 14:46:33	\N	\N	Y	N	N	\N	Y	123456	dmfrizzell	\N	dmfrizzell	default1324657089.png	0
1042	18	aali25@students.kennesaw.edu	085065090068093085085034054109119112	\N	N	2016-09-23 15:08:57	2016-09-23 15:08:57	\N	\N	Y	N	N	\N	Y	123456	aali25	\N	aali25	default1324657089.png	0
1044	18	rspann9@students.kennesaw.edu	066082064071095088076008002114	\N	N	2016-09-23 15:25:22	2016-09-23 15:25:22	\N	\N	Y	N	N	\N	Y	5	RSS	\N	RSS	default1324657089.png	0
1046	18	nmcray@students.kennesaw.edu	125124115002011006	\N	N	2016-09-23 15:40:53	2016-09-23 15:40:53	\N	\N	Y	N	N	\N	N	123456	nevinmcray	\N	nevinmcray	default1324657089.png	0
1045	18	sharr@students.kennesaw.edu	117085089085088086074007120116113	\N	N	2016-09-23 15:40:29	2016-09-23 15:40:29	\N	\N	Y	N	N	\N	Y	123456	sharr2697	\N	sharr2697	default1324657089.png	0
1036	18	mkeogh@students.kennesaw.edu	045094068086089080007000	\N	N	2016-09-22 16:33:23	2016-09-22 16:33:23	\N	\N	Y	N	N	\N	Y	5	mvkeogh	\N	mvkeogh	default1324657089.png	0
1047	18	kponder6@students.kennesaw.edu	006080070092070070006015	\N	N	2016-09-23 22:15:10	2016-09-23 22:15:10	\N	\N	Y	N	N	\N	N	123456	ponderkpax	\N	ponderkpax	default1324657089.png	0
1048	18	cvelazq1@students.kennesaw.edu	084094093081091083006010010	\N	N	2016-09-23 22:18:03	2016-09-23 22:18:03	\N	\N	Y	N	N	\N	N	123456	cadmiel100	\N	cadmiel100	default1324657089.png	0
1049	15	tm78442@uga.edu	006067083093090076015015	\N	N	2016-09-25 18:11:21	2016-09-25 18:11:21	\N	\N	Y	N	N	\N	Y	123456	tylermeans	\N	tylermeans	default1324657089.png	0
1050	15	jl00274@uga.edu	087088066092083095087067112112112	\N	N	2016-09-26 15:00:50	2016-09-26 15:00:50	\N	\N	Y	N	N	\N	Y	5	dlwjdgns	\N	dlwjdgns	default1324657089.png	0
1051	18	jmart268@students.kennesaw.edu	044094092088081076004007	\N	N	2016-09-26 16:29:51	2016-09-26 16:29:51	\N	\N	Y	N	N	\N	N	123456	mstxga	\N	mstxga	default1324657089.png	0
1052	15	jmd26500@uga.edu	053069087064071090082006	\N	N	2016-09-26 17:27:25	2016-09-26 17:27:25	\N	\N	Y	N	N	\N	Y	123456	Jack Dossett	\N	Jack Dossett	default1324657089.png	0
1054	15	mjj29981@uga.edu	050084083065085076015015	\N	N	2016-09-26 23:29:46	2016-09-26 23:29:46	\N	\N	Y	N	N	\N	Y	123456	mjj29981	\N	mjj29981	default1324657089.png	0
1056	15	ecc85746@uga.edu	002117070071092066094094024	\N	N	2016-09-27 00:37:34	2016-09-27 00:37:34	\N	\N	Y	N	N	\N	Y	123456	evancantu	\N	evancantu	default1324657089.png	0
1057	15	hce32238@uga.edu	124086083006009011005112123122114100	\N	N	2016-09-27 02:20:35	2016-09-27 02:20:35	\N	\N	Y	N	N	\N	Y	123456	hce32238	\N	hce32238	default1324657089.png	0
1058	15	jrn86444@uga.edu	092003080066002084086094057123113	\N	N	2016-09-27 17:38:16	2016-09-27 17:38:16	\N	\N	Y	N	N	\N	Y	123456	jakeryannelson 	\N	jakeryannelson 	default1324657089.png	0
1059	18	jmallis1@students.kennesaw.edu	117005005006002089089091	\N	N	2016-09-28 01:31:36	2016-09-28 01:31:36	\N	\N	Y	N	N	\N	Y	123456	Zaybub	\N	Zaybub	default1324657089.png	0
1055	15	kylemo9@uga.edu	049073064071066088079084	\N	N	2016-09-26 23:40:22	2016-09-26 23:40:22	\N	\N	Y	N	N	\N	Y	123456	kylemo9	\N	kylemo9	default1324657089.png	0
1060	15	lep82907@uga.edu	117083068083007006006001023	\N	N	2016-09-28 17:41:51	2016-09-28 17:41:51	\N	\N	Y	N	N	\N	Y	123456	lpowell	\N	lpowell	default1324657089.png	0
1061	15	tjb95213@uga.edu	087090082082074092084119122113119100	\N	N	2016-09-28 18:53:15	2016-09-28 18:53:15	\N	\N	Y	N	N	\N	Y	123456	tjb95213	\N	tjb95213	default1324657089.png	0
1062	15	mk26565@uga.edu	039044066002010005005	\N	N	2016-09-28 19:12:30	2016-09-28 19:12:30	\N	\N	Y	N	N	\N	Y	5	kms98	\N	kms98	default1324657089.png	0
1063	15	cp16146@uga.edu	102087082064093083069001029	\N	N	2016-09-28 23:39:36	2016-09-28 23:39:36	\N	\N	Y	N	N	\N	Y	123456	Catherinepizza	\N	Catherinepizza	default1324657089.png	0
1053	15	jrw74527@uga.edu	082083086071084068006010010	\N	N	2016-09-26 22:57:41	2016-09-26 22:57:41	\N	\N	Y	N	N	\N	Y	123456	jrw3	\N	jrw3	default1324657089.png	0
1065	15	btobrien@uga.edu	069083067081066089069085010	\N	N	2016-09-30 15:13:42	2016-09-30 15:13:42	\N	\N	Y	N	N	\N	Y	123456	btobrien	\N	btobrien	default1324657089.png	0
1066	15	mcc22488@uga.edu	080091064081086074085081057115119	\N	N	2016-09-30 15:15:37	2016-09-30 15:15:37	\N	\N	Y	N	N	\N	Y	5	mattclaffee	\N	mattclaffee	default1324657089.png	0
1067	15	deg52951@uga.edu	066092068090070094104118009112	\N	N	2016-09-30 23:01:18	2016-09-30 23:01:18	\N	\N	Y	N	N	\N	N	123456	galindocastellon 	\N	galindocastellon 	default1324657089.png	0
1069	15	deg52961@uga.edu	049094066092068092070088	\N	N	2016-09-30 23:18:28	2016-09-30 23:18:28	\N	\N	Y	N	N	\N	Y	123456	galindocastellon	\N	galindocastellon	default1324657089.png	0
1071	15	swagyolo@uga.edu	066092095080091088086008002114	\N	N	2016-10-01 00:38:13	2016-10-01 00:38:13	\N	\N	Y	N	N	\N	N	123456	swagyolo	\N	swagyolo	default1324657089.png	0
1070	15	lml45719@uga.edu	045092094115117102099004	\N	N	2016-10-01 00:37:56	2016-10-01 00:37:56	\N	\N	Y	N	N	\N	Y	123456	Luke	\N	Luke	default1324657089.png	0
1072	15	msw18463@uga.edu	050065093065064070004006	\N	N	2016-10-01 02:42:57	2016-10-01 02:42:57	\N	\N	Y	N	N	\N	Y	123456	masonwolfe98	\N	masonwolfe98	default1324657089.png	0
1073	15	rbj30218@uga.edu	115094082095080006003008013	\N	N	2016-10-01 05:19:19	2016-10-01 05:19:19	\N	\N	Y	N	N	\N	Y	123456	rbj30218	\N	rbj30218	default1324657089.png	0
1074	58	emailjxjdjdjxjjx@duke.edu	040	\N	N	2016-10-01 05:25:44	2016-10-01 05:25:44	\N	\N	Y	N	N	\N	N	5	hdhdhdh	\N	hdhdhdh	default1324657089.png	0
1075	15	ocp05928@uga.edu	050065064090064080007007	\N	N	2016-10-01 21:25:40	2016-10-01 21:25:40	\N	\N	Y	N	N	\N	Y	123456	OsoSexy	\N	OsoSexy	default1324657089.png	0
1076	15	sd53168@uga.edu	118089088083080085037045038119118117126	\N	N	2016-10-02 18:23:46	2016-10-02 18:23:46	\N	\N	Y	N	N	\N	Y	123456	lasyd3	\N	lasyd3	default1324657089.png	0
1077	15	yhk18349@uga.edu	003002003005001015014008014	\N	N	2016-10-03 16:31:24	2016-10-03 16:31:24	\N	\N	Y	N	N	\N	Y	123456	daniel0226	\N	daniel0226	default1324657089.png	0
1078	15	wsc74538@uga.edu	000118084069082090088092045113098	\N	N	2016-10-04 00:00:29	2016-10-04 00:00:29	\N	\N	Y	N	N	\N	Y	123456	WadeCox3	\N	WadeCox3	default1324657089.png	0
1079	18	amccar13@students.kennesaw.edu	050065083093095076004005	\N	N	2016-10-04 17:25:40	2016-10-04 17:25:40	\N	\N	Y	N	N	\N	N	123456	alexmccarthy	\N	alexmccarthy	default1324657089.png	0
1080	15	ajg04875@uga.edu	113085087079090089075001120123123	\N	N	2016-10-04 18:36:50	2016-10-04 18:36:50	\N	\N	Y	N	N	\N	Y	123456	Alexeiag	\N	Alexeiag	default1324657089.png	0
1081	15	kmj12479@uga.edu	114083088074094089032016044039046053109	\N	N	2016-10-05 14:28:15	2016-10-05 14:28:15	\N	\N	Y	N	N	\N	Y	123456	kmj12479	\N	kmj12479	default1324657089.png	0
1082	15	oap41722@uga.edu	118065083088071095087078	\N	N	2016-10-05 20:00:16	2016-10-05 20:00:16	\N	\N	Y	N	N	\N	Y	5	jaypaks	\N	jaypaks	default1324657089.png	0
1095	15	cato46@uga.edu	082093091081080082022009014	\N	N	2016-10-05 21:55:14	2016-10-05 21:55:14	\N	\N	Y	N	N	\N	Y	123456	cato46	\N	cato46	default1324657089.png	0
1083	15	kasey.yangchen@uga.edu	088069037043055045043034034056044036047041035045042	\N	N	2016-10-05 20:05:23	2016-10-05 20:05:23	\N	\N	Y	N	N	\N	Y	123456	Kasey	\N	Kasey	default1324657089.png	0
1084	15	ll13693@uga.edu	110126121118092046046042117124127112126120	\N	N	2016-10-05 20:05:58	2016-10-05 20:05:58	\N	\N	Y	N	N	\N	Y	123456	LiweiLuo 	\N	LiweiLuo 	default1324657089.png	0
184	15	nocerini@uga.edu	124071064087089083003013015	\N	N	2015-12-23 03:15:51	2016-01-11 23:29:57	Administrator	198.143.47.33	Y	N	N	\N	Y	f82e9df224fa3165d6040998bd84a5b1152a8139eb42ad020ad83dbee151732a	brett	\N	brett	default1324657089.png	0
204	15	npc32893@uga.edu	095083071081086090086074064	\N	N	2016-01-16 20:17:37	2016-01-16 20:17:37	\N	\N	Y	N	N	\N	Y	123456	nateclary	\N	nateclary	default1324657089.png	0
205	15	fsa98834@uga.edu	081065081080093064089077083041	\N	N	2016-01-16 20:53:37	2016-01-16 20:53:37	\N	\N	Y	N	N	\N	Y	123456	fabele1	\N	fabele1	default1324657089.png	0
2	16	peter1@gmail.com	107123127120	\N	Y	2015-09-14 12:52:11	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y		peter1		peter1	default1324657089.png	0
208	15	lew79954@uga.edu	034094081092005007005003	\N	N	2016-01-18 19:27:28	2016-01-18 19:27:28	\N	\N	Y	N	N	\N	Y	123456	laurenwynn11	\N	laurenwynn11	default1324657089.png	0
6	16	naomi@gmail.com	116104122	\N	Y	2015-09-26 13:05:17	2016-01-19 00:00:00	Administrator	198.143.47.1	Y	N	N	\N	Y		Naomi		Naomi	default1324657089.png	0
209	15	nwb67780@uga.edu	022094093081088080005007	\N	N	2016-01-20 18:08:42	2016-01-20 18:08:42	\N	\N	Y	N	N	\N	Y	123456	barnes.noah	\N	barnes.noah	default1324657089.png	0
112	14	mdshultz@valdosta.edu	044085065091065089066077	\N	N	2015-12-06 23:51:17	2015-12-06 23:51:17	\N	\N	Y	N	N	\N	N	123456	maxxshultz	\N	maxxshultz	default1324657089.png	0
1115	24	testpratik2@columbusstate.edu	040	\N	N	2016-10-25 17:45:05	2016-10-25 17:45:05	\N	\N	Y	N	N	\N	Y	123456	testpratik123	\N	testpratik123	default1324657089.png	0
79	14	hhathcock@valdosta.edu	038041054084094095	\N	N	2015-12-04 17:05:24	2015-12-04 17:05:24	\N	\N	Y	N	N	\N	Y	6e3a11c2611ca7852af453bd45f3456596816cd8868db1d4c2716cab5c46be36	haileejewell	\N	haileejewell	default1324657089.png	0
53	15	sasporn @uga.edu	036041045093093010	\N	N	2015-11-08 22:46:42	2015-11-08 22:46:42	\N	\N	Y	N	N	\N	N	7a6ad0ab1e3f253efa1380d62d2f921bde4fec4a554bc963382494ed5e6a8108	sasporn	\N	sasporn	default1324657089.png	0
58	15	jrm22@uga.edu	011067095011004001003022	\N	N	2015-11-10 00:28:20	2015-11-10 00:28:20	\N	\N	Y	N	N	\N	Y	fdb5c3250e4cdd93c684a26f0853696580ac8a6570259d1ce62564d144e5e472	mac.mclemore	\N	mac.mclemore	default1324657089.png	0
64	14	gastratton@valdosta.edu	003088085084093080006015	\N	N	2015-12-02 01:02:18	2015-12-02 01:02:18	\N	\N	Y	N	N	\N	N	123456	gastratton	\N	gastratton	default1324657089.png	0
55	15	skf68937@uga.edu	080086064084066082075077085051	\N	N	2015-11-09 03:46:33	2015-11-09 03:46:33	\N	\N	Y	N	N	\N	Y		skfuqua	\N	skfuqua	default1324657089.png	0
77	30	melody25@uab.edu	045057035083091086	\N	N	2015-12-04 16:52:49	2015-12-04 16:52:49	\N	\N	Y	N	N	\N	Y	0c3d728cd8a9e2dc93eeba9b7c160651c446afdacb998dfc6125c17dc1e879b1	Melody25	\N	Melody25	default1324657089.png	0
143	15	iporter@uga.edu	082080086086090070006010010	\N	N	2015-12-09 17:19:19	2015-12-09 17:19:19	\N	\N	Y	N	N	\N	Y		Inman	\N	Inman	default1324657089.png	0
176	15	croftcc@uga.edu	066066074070090014014011013	\N	N	2015-12-17 03:30:33	2015-12-17 03:30:33	\N	\N	Y	N	N	\N	N	123456	croftcc	\N	croftcc	default1324657089.png	0
8	15	hellmanj@uga.edu	034043037067066064	\N	N	2016-02-05 18:55:40	2016-02-05 18:55:40	\N	\N	Y	N	N	\N	N	123456	juliah	\N	juliah	default1324657089.png	0
501	15	mj59182@uga.edu	044088089082092095014007	\N	N	2016-04-18 23:52:35	2016-04-18 23:52:35	\N	\N	Y	N	N	\N	Y	5	mj2345	\N	mj2345	default1324657089.png	0
579	15	sk67100@uga.edu	045125115002006006	\N	N	2016-08-12 00:43:30	2016-08-12 00:43:30	\N	\N	Y	N	N	\N	Y	123456	sheri	\N	sheri	default1324657089.png	0
729	15	naziz17@uga.edu	085086091071081094089006008114	\N	N	2016-08-16 20:55:23	2016-08-16 20:55:23	\N	\N	Y	N	N	\N	Y	123456	naziz17	\N	naziz17	default1324657089.png	0
730	15	kp34997@uga.edu	066065091083095091093008002114	\N	N	2016-08-16 21:12:24	2016-08-16 21:12:24	\N	\N	Y	N	N	\N	Y	123456	karuna	\N	karuna	default1324657089.png	0
731	15	gma99637@uga.edu	039068072073077081089080	\N	N	2016-08-16 21:16:14	2016-08-16 21:16:14	\N	\N	Y	N	N	\N	Y	123456	gma99637	\N	gma99637	default1324657089.png	0
732	15	jmk61297@uga.edu	083003011006106113115000015	\N	N	2016-08-16 21:22:20	2016-08-16 21:22:20	\N	\N	Y	N	N	\N	Y	123456	jmk61297	\N	jmk61297	default1324657089.png	0
734	15	bld37922@uga.edu	035067083069081070004006	\N	N	2016-08-16 21:30:29	2016-08-16 21:30:29	\N	\N	Y	N	N	\N	Y	123456	bday21	\N	bday21	default1324657089.png	0
108	30	rhigs@uab.edu	045080085070070089079000	\N	N	2015-12-06 02:58:42	2015-12-06 02:58:42	\N	\N	Y	N	N	\N	Y	b441db283ac99d2abd197f38ce108fd0171b1d85c72d88c448dc080d01b99591	rhigs	\N	rhigs	default1324657089.png	0
194	15	thriftskool@gmail.com	112082071080084086084085002115	\N	N	2015-12-08 07:24:56	2015-12-08 07:24:56	\N	\N	Y	N	N	\N	Y	6d916856433888a07198983c89ffa053ded8db0c9215718145e21ca9ab90f598	thriftskool	\N	thriftskool	thriftskool_1.jpeg	3
1086	15	vb45524@uga.edu	100090090084079119009013001115	\N	N	2016-10-05 20:07:49	2016-10-05 20:07:49	\N	\N	Y	N	N	\N	Y	5	vb45524	\N	vb45524	default1324657089.png	0
1085	15	mew98594@uga.edu	035068065090090080069068	\N	N	2016-10-05 20:07:11	2016-10-05 20:07:11	\N	\N	Y	N	N	\N	Y	5	elliott	\N	elliott	default1324657089.png	0
1087	15	mk47682@uga.edu	002006088095084080088085045108109	\N	N	2016-10-05 20:10:41	2016-10-05 20:10:41	\N	\N	Y	N	N	\N	Y	5	Michael	\N	Michael	default1324657089.png	0
1089	15	sjl21196@uga.edu	118068005005012065002003	\N	N	2016-10-05 20:19:51	2016-10-05 20:19:51	\N	\N	Y	N	N	\N	Y	5	slawsure	\N	slawsure	default1324657089.png	0
1088	15	meh79491@uga.edu	016068087008091036050055040044048046038046	\N	N	2016-10-05 20:11:24	2016-10-05 20:11:24	\N	\N	Y	N	N	\N	Y	5	meh79491	\N	meh79491	default1324657089.png	0
1090	15	cv79057@uga.edu	118090086078092100013033034045042119118	\N	N	2016-10-05 20:26:21	2016-10-05 20:26:21	\N	\N	Y	N	N	\N	Y	123456	Caio 	\N	Caio 	default1324657089.png	0
1091	15	mmr56043@uga.edu	083090080088074087085052054049037041	\N	N	2016-10-05 20:45:30	2016-10-05 20:45:30	\N	\N	Y	N	N	\N	Y	5	manoragho	\N	manoragho	default1324657089.png	0
113	50	nlerick@stedwards.edu	035080065081088089007007	\N	N	2015-12-07 01:35:39	2015-12-07 01:35:39	\N	\N	Y	N	N	\N	Y		Nick_Lerick10	\N	Nick_Lerick10	default1324657089.png	0
115	17	ZTRichmond5@gatech.edu	107070065004012004006001009	\N	N	2015-12-07 02:25:43	2015-12-07 02:25:43	\N	\N	Y	N	N	\N	Y	f87987c73313e9abc6aa714da42aaa2e69c118239bee11f230022a68c3a4f758	ZTRichmond5	\N	ZTRichmond5	default1324657089.png	0
47	15	peterpin@uga.edu	080065081091088086091077001096	\N	N	2015-11-07 21:01:15	2015-11-07 21:01:15	\N	\N	Y	N	N	\N	Y	08dd8165dcb70221d62a934c0e411419064886912cd41fef863e2691e33e4b72	peterpin	\N	peterpin	default1324657089.png	0
52	15	tcooksey@uga.edu	085086091071081094089012005096	\N	N	2015-11-08 20:51:39	2015-11-08 20:51:39	\N	\N	Y	N	N	\N	Y		tcooksey	\N	tcooksey	default1324657089.png	0
18	22	Tia@emory.edu	116104122	\N	N	2015-10-07 14:06:19	2015-10-07 14:06:19	\N	\N	Y	N	N	\N	N	123456	Tia	\N	Tia	default1324657089.png	0
1113	15	kstrawd@uga.edu	005116088080093085088036035049048100	\N	N	2016-10-24 18:34:08	2016-10-24 18:34:08	\N	\N	Y	N	N	\N	Y	123456	kstrawd	\N	kstrawd	default1324657089.png	0
1092	15	nm08997@uga.edu	080064090085070095089095081	\N	N	2016-10-05 21:07:11	2016-10-05 21:07:11	\N	\N	Y	N	N	\N	Y	123456	nishka	\N	nishka	default1324657089.png	0
1093	15	hmr19205@uga.edu	039067093084005006007004	\N	N	2016-10-05 21:27:31	2016-10-05 21:27:31	\N	\N	Y	N	N	\N	Y	123456	hmr19205	\N	hmr19205	default1324657089.png	0
1094	15	cato46 @uga.edu	114093091081080082022009014	\N	N	2016-10-05 21:50:26	2016-10-05 21:50:26	\N	\N	Y	N	N	\N	N	123456	LucienC33	\N	LucienC33	default1324657089.png	0
1096	15	agb13695@uga.edu	126085081095068087087000120115112	\N	N	2016-10-06 00:24:58	2016-10-06 00:24:58	\N	\N	Y	N	N	\N	Y	123456	agb13695	\N	agb13695	default1324657089.png	0
1097	15	yd17fa@uga.edu	115090082094075085095055039109117125	\N	N	2016-10-06 02:47:17	2016-10-06 02:47:17	\N	\N	Y	N	N	\N	Y	123456	rigi	\N	rigi	default1324657089.png	0
1098	15	mad56735@uga.edu	006002023085085078066036038054035036	\N	N	2016-10-06 02:53:23	2016-10-06 02:53:23	\N	\N	Y	N	N	\N	Y	123456	mad56735	\N	mad56735	default1324657089.png	0
1099	15	gk50759@uga.edu	095086088089089067093087094113	\N	N	2016-10-06 03:42:37	2016-10-06 03:42:37	\N	\N	Y	N	N	\N	Y	5	natkjh	\N	natkjh	default1324657089.png	0
1100	15	jbarber3@uga.edu	034080095087081091007001	\N	N	2016-10-06 06:10:45	2016-10-06 06:10:45	\N	\N	Y	N	N	\N	Y	123456	jdbarber3	\N	jdbarber3	default1324657089.png	0
1043	18	aengli12@students.kennesaw.edu	112082071080084086084085002115	\N	N	2016-09-23 15:20:05	2016-10-06 15:18:18	Administrator	50.20.4.10	Y	N	N	\N	N	123456	englishallen	\N	englishallen	default1324657089.png	0
1101	15	teb08932@uga.edu	002013007014004015015004116054023	\N	N	2016-10-06 18:44:58	2016-10-06 18:44:58	\N	\N	Y	N	N	\N	Y	123456	taylorb167	\N	taylorb167	default1324657089.png	0
1102	15	alp34496@uga.edu	112095081081071007014001015	\N	N	2016-10-09 13:54:43	2016-10-09 13:54:43	\N	\N	Y	N	N	\N	Y	123456	a.payne	\N	a.payne	default1324657089.png	0
1103	18	rpicker1@students.kennesaw.edu	102069000004012013003096119117116117	\N	N	2016-10-10 19:31:18	2016-10-10 19:31:18	\N	\N	Y	N	N	\N	N	123456	rpicker1	\N	rpicker1	default1324657089.png	0
1104	15	bhill02@uga.edu	122112002003006000013	\N	N	2016-10-11 08:10:10	2016-10-11 08:10:10	\N	\N	Y	N	N	\N	Y	5	bhill02	\N	bhill02	default1324657089.png	0
1105	15	rb30652@uga.edu	101067071082084069090073082112	\N	N	2016-10-12 14:04:46	2016-10-12 14:04:46	\N	\N	Y	N	N	\N	Y	123456	rbonilla	\N	rbonilla	default1324657089.png	0
1106	15	dstaffor@uga.edu	123085071090082085020002113114122	\N	N	2016-10-15 18:30:50	2016-10-15 18:30:50	\N	\N	Y	N	N	\N	Y	5	dstaffor	\N	dstaffor	default1324657089.png	0
1107	15	sre69065@uga.edu	049093083074006066095089	\N	N	2016-10-16 04:46:48	2016-10-16 04:46:48	\N	\N	Y	N	N	\N	Y	123456	syerickson	\N	syerickson	default1324657089.png	0
1108	15	ahp89034@uga.edu	035080065000086084007006	\N	N	2016-10-17 19:17:07	2016-10-17 19:17:07	\N	\N	Y	N	N	\N	Y	123456	ahp7621	\N	ahp7621	default1324657089.png	0
1109	15	kgd79416@uga.edu	054089083071067093087067	\N	N	2016-10-22 16:47:36	2016-10-22 16:47:36	\N	\N	Y	N	N	\N	Y	123456	kdabro	\N	kdabro	default1324657089.png	0
1114	38	manmohansingh231303@ggc.edu	003002005004007006009008001112	\N	N	2016-10-25 14:11:10	2016-10-25 14:11:10	\N	\N	Y	N	N	\N	N	5	mohit	\N	mohit	default1324657089.png	0
1112	26	testpratik@tigermail.auburn.edu	040	\N	N	2016-10-24 17:04:44	2016-10-24 17:04:44	\N	\N	Y	N	N	\N	Y	5	pratik123	\N	pratik123	default1324657089.png	0
\.


--
-- Name: users_manage_int_glcode_seq; Type: SEQUENCE SET; Schema: public; Owner: thriftskool_mobileappuser
--

SELECT pg_catalog.setval('users_manage_int_glcode_seq', 1145, true);


--
-- Name: campus_buzz_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY campus_buzz_gallery
    ADD CONSTRAINT campus_buzz_gallery_pkey PRIMARY KEY (int_glcode);


--
-- Name: campus_buzz_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY campus_buzz
    ADD CONSTRAINT campus_buzz_pkey PRIMARY KEY (int_glcode);


--
-- Name: campus_deal_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY campus_deal
    ADD CONSTRAINT campus_deal_pkey PRIMARY KEY (int_glcode);


--
-- Name: campus_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY campus_gallery
    ADD CONSTRAINT campus_gallery_pkey PRIMARY KEY (int_glcode);


--
-- Name: cc_category_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT cc_category_pkey PRIMARY KEY (int_glcode);


--
-- Name: cc_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT cc_groups_pkey PRIMARY KEY (int_glcode);


--
-- Name: contactusleads_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY contactusleads
    ADD CONSTRAINT contactusleads_pkey PRIMARY KEY (int_glcode);


--
-- Name: favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (int_glcode);


--
-- Name: general_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY general_settings
    ADD CONSTRAINT general_settings_pkey PRIMARY KEY (int_glcode);


--
-- Name: job_management_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY job_management
    ADD CONSTRAINT job_management_pkey PRIMARY KEY (int_glcode);


--
-- Name: logmanager_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY logmanager
    ADD CONSTRAINT logmanager_pkey PRIMARY KEY (int_glcode);


--
-- Name: manage_gcmcode_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY manage_gcmcode
    ADD CONSTRAINT manage_gcmcode_pkey PRIMARY KEY (int_glcode);


--
-- Name: message_list_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY message_list
    ADD CONSTRAINT message_list_pkey PRIMARY KEY (int_glcode);


--
-- Name: message_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY message_thread
    ADD CONSTRAINT message_thread_pkey PRIMARY KEY (int_glcode);


--
-- Name: module_useraction_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY module_useraction
    ADD CONSTRAINT module_useraction_pkey PRIMARY KEY (int_glcode);


--
-- Name: modules_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (int_glcode);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (int_glcode);


--
-- Name: post_category_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY post_category
    ADD CONSTRAINT post_category_pkey PRIMARY KEY (int_glcode);


--
-- Name: post_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY post_gallery
    ADD CONSTRAINT post_gallery_pkey PRIMARY KEY (int_glcode);


--
-- Name: post_management_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY post_management
    ADD CONSTRAINT post_management_pkey PRIMARY KEY (int_glcode);


--
-- Name: university_leads_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY university_leads
    ADD CONSTRAINT university_leads_pkey PRIMARY KEY (int_glcode);


--
-- Name: university_management_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY university_management
    ADD CONSTRAINT university_management_pkey PRIMARY KEY (int_glcode);


--
-- Name: user_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY user_devices
    ADD CONSTRAINT user_devices_pkey PRIMARY KEY (int_glcode);


--
-- Name: useraccess_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY useraccess
    ADD CONSTRAINT useraccess_pkey PRIMARY KEY (int_glcode);


--
-- Name: useraction_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY useraction
    ADD CONSTRAINT useraction_pkey PRIMARY KEY (int_glcode);


--
-- Name: users_manage_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY users_manage
    ADD CONSTRAINT users_manage_pkey PRIMARY KEY (int_glcode);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: thriftskool_mobileappuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (int_glcode);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

