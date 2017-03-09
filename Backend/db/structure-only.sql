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

