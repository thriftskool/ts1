<?php

class common_model extends CI_Model {

    public function __construct() {

        $this->getAllModuleName();
        $this->getAllPagesAlias();
    }

    public function getAllModuleName() {

        $this->db->cache_set_common_path("application/cache/db/common/module/");
        $this->db->cache_on();
        $ModuleArray = array();
        $query = $this->db->get('modules');
        $this->db->cache_off();
        foreach ($query->result() as $row) {
            $ModuleArray[$row->var_modulename] = $row;
            $ModuleArray[$row->int_glcode] = $row;
        }
        $this->ModuleArray = $ModuleArray;
    }

    public function getAllPagesAlias() {
        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_on();
        $PagesAliasArray = array();
        $this->db->select('var_pagetype,int_glcode, var_alias');
        $this->db->from('pages');
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get();
        $this->db->cache_off();
        foreach ($query->result() as $row) {
            $PagesAliasArray['var_pagetype'][$row->var_pagetype] = $row;
            $PagesAliasArray['int_glcode'][$row->int_glcode] = $row;
        }
        $this->PagesAliasArray = $PagesAliasArray;
    }

    public function getModuleName($modulename) {
        $row = $this->ModuleArray[$modulename];
       
        if (empty($row)) {
            $query = $this->db->get_where('modules', array('var_modulename' => $modulename));
            return $query->row();
        } else {
            return $row;
        }
    }

    function set_page_hits1($table_name, $record_id) {
        if ($table_name != '' && $record_id != '') {
            $update_page_hits_sql = "UPDATE " . DB_PREFIX . $table_name . " SET int_pagehits=int_pagehits+1 WHERE int_glcode='" . $record_id . "'";
            $this->db->query($update_page_hits_sql);
        } else
            return false;
    }

    function set_page_hits($table_name, $record_id) {
        if ($table_name != '' && $record_id != '') {
            if ($_SESSION['is_mobile_browser'] == 'no') {
                $update_page_hits_sql = "UPDATE " . DB_PREFIX . $table_name . " SET int_pagehits=int_pagehits+1 WHERE int_glcode='" . $record_id . "'";
            } else {
                $update_page_hits_sql = "UPDATE " . DB_PREFIX . $table_name . " SET int_mobhits=int_mobhits+1 WHERE int_glcode='" . $record_id . "'";
            }
            $this->db->query($update_page_hits_sql);
        } else
            return false;
    }

    function set_metadata() {
        $table_name = SEO_TABLE;
        $seo_query = "SELECT var_metatitle,var_metakeyword,var_metadescription FROM " . DB_PREFIX . $table_name . "  WHERE int_glcode='" . RECORD_ID . "'";
        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_on();
        $seo_result = $this->db->query($seo_query);
        if ($seo_result->num_rows > 0) {
            $pages_data = $seo_result->row_array();
            $title = $pages_data['var_metatitle'];
            $keyword = $pages_data['var_metakeyword'];
            $description = $pages_data['var_metadescription'];
        }
        $this->db->cache_off();
        if ($title == '' || $keyword == '' || $description == '') {
            $seo_query = "SELECT var_metatitle,var_metakeywords,var_metadescription FROM " . DB_PREFIX . "general_settings";
            $this->db->cache_set_common_path("application/cache/db/common/settings/");
            $this->db->cache_on();
            $seo_result = $this->db->query($seo_query);
            $pages_data = $seo_result->row_array();
            $this->db->cache_off();
            if ($title == '')
                $title = $pages_data['var_metatitle'];
            if ($keyword == '')
                $keyword = $pages_data['var_metakeywords'];
            if ($description == '')
                $description = $pages_data['var_metadescription'];
        }

        $metadata['title'] = $title;
        $metadata['keywords'] = $keyword;
        $metadata['description'] = $description;
        return $metadata;
    }

    function glMetaArray() {
        $seo_query = "SELECT var_googleanalyticcode, var_commanmetatags FROM " . DB_PREFIX . "general_settings";
        $this->db->cache_set_common_path("application/cache/db/common/settings/");
        $this->db->cache_on();
        $seo_result = $this->db->query($seo_query);
        $seo_data = $seo_result->row_array();
        $this->db->cache_off();
        return $seo_data;
    }

    function getseodata() {
        $table_array = array("pages");
        $alias1 = $this->uri->segment(1);
        if (!empty($table_array)) {
            foreach ($table_array as $table_name) {
                $queryalias = "select * from " . DB_PREFIX . $table_name . " WHERE chr_delete='N' AND chr_publish='Y' and  var_alias='" . $alias1 . "'";
                $resultalias = $this->db->query($queryalias);
                $countalias = $resultalias->num_rows();
                if ($countalias > 0) {
                    break;
                }
            }
        }
        return $countalias;
    }

    function get_filte_category($id) {
        $sql = "select p.var_title as product,p.int_glcode,c.var_title as category from " . DB_PREFIX . "products as p left join " . DB_PREFIX . "category_product as c on p.fk_category=c.int_glcode where p.chr_delete='N' and p.chr_publish='Y' and c.chr_delete='N' and c.chr_publish='Y' and p.int_glcode=$id ";
        $detail = $this->db->query($sql);
        $result = $detail->row_array();
        return $result;
    }

    function total_qty() {
        $userid = $this->session->userdata('user_id');
        $sql_check = "SELECT sum(int_qty) as totalqty FROM " . DB_PREFIX . "cart_detail WHERE fk_login='" . $userid . "'";
        $result = $this->db->query($sql_check);
        $total = $result->row_array();
        return $total['totalqty'];
    }

    function getbreadcrumdata($id, $pageId) {
//        echo "sdfghdghfgj";exit;
        $id = $this->input->get_post('id');

        if ($id != '') {
            $pageId = '3';
        }
        $fkstring = '';
        $result = $this->getfkarray($pageId, $fkstring);

        $fkarray = explode(',', $result);

        $revfkarray = array_reverse($fkarray);

        $revfkarray = implode(',', $revfkarray);
        $uriseg = $this->uri->rsegments;


        if ($uriseg[2] == 'details' && $uriseg[1] == 'photoalbum') {

            $servicesql = "select var_title as title from " . DB_PREFIX . "photoalbum WHERE int_glcode='" . RECORD_ID . "'";
            $servicedetail = $this->db->query($servicesql);
            $servicerow = $servicedetail->row_array();

            $moduleurl1 = $this->common_model->getUrl('pages', '2', '18', '');
        } else if ($uriseg[2] == 'details' && $uriseg[1] == 'videoalbum') {

            $servicesql = "select var_title as title from " . DB_PREFIX . "videoalbum WHERE int_glcode='" . RECORD_ID . "'";
            $photodetail = $this->db->query($servicesql);
            $photorow = $photodetail->row_array();
            $moduleurl1 = $this->common_model->getUrl('pages', '2', '18', '');
        } else {
            $sql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,
                      case p.var_pagetype WHEN 0 THEN CONCAT('" . SITE_PATH . "',p.var_alias)
                      ELSE CONCAT('" . SITE_PATH . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where  p.int_glcode IN($revfkarray) order by p.fk_pages asc";
            $rs = $this->db->query($sql);
            $countdata = $rs->num_rows();
            $resultdata = $rs->result_array($rs);
        }

        if ($countdata > 0) {
            $data = '';
            $data .='<a  href="' . SITE_PATH . '" title="Home">Home</a>';
            $i = 1;

            foreach ($resultdata as $key => $row) {

                if ($row['int_glcode'] == '16') {
                    $rlink = $moduleurl1;
                } else {
                    $rlink = $row['link'];
                }
                $m = (RECORD_ID != $row['int_glcode'] ) ? '<a href="' . $rlink . '" title="' . htmlspecialchars($row['var_pagename']) . '">' : '<span class="active">';
                $a = (RECORD_ID != $row['int_glcode'] ) ? '</a>' : '</span>';


                $pagetitle = ucfirst($row['var_pagename']);

                $data .=' >&nbsp;' . $m . $pagetitle . $a;

                $i++;
            }
        }
        $innerpagetitle = '';
        if (MODULE == 'photoalbum' && $uriseg[2] == 'details') {

            $moduleurl = $this->getUrl('pages', '120', '18');

            $char = substr($servicerow['title'], 0, 66);
            $photo = '<span class="active">' . $char . '</span>';
            if (strlen($servicerow['title']) > 66) {
                $char.='...';
            }
            $sql = "select var_pagename from " . DB_PREFIX . "pages where var_pagetype=" . MODULE_ID;

            $query = $this->db->query($sql);
            $result = $query->row_array();

            $moduleurl1 = $this->common_model->getUrl('pages', '2', '18', '');
            $sql1 = "select var_pagename from " . DB_PREFIX . "pages where  int_glcode=18";

            $query1 = $this->db->query($sql1);
            $result1 = $query1->row_array();
            // $innerpagetitle = '<a href="' . SITE_PATH . '" title="Home">Home</a>&nbsp;><a href=' . $moduleurl . ' title=' . $result['var_pagename'] . '> ' . $result['var_pagename'] . '</a>&nbsp;>&nbsp;' . $photo;
            $innerpagetitle = '<a href="' . SITE_PATH . '" title="Home">Home</a>&nbsp;>&nbsp;<a href=' . $moduleurl1 . ' title="Gallery">Gallery</a>&nbsp;>&nbsp;<a href=' . $moduleurl . ' title="' . htmlspecialchars($result1['var_pagename']) . '">' . $result1['var_pagename'] . ' </a>>&nbsp;' . $photo;
        }



        if (MODULE == 'videoalbum' && $uriseg[2] == 'details') {

            $moduleurl = $this->getUrl('pages', '119', '19');
            $char = substr($photorow['title'], 0, 66);
            $video = '<span class="active">' . $char . '</span>';
            if (strlen($photorow['title']) > 66) {
                $char.='...';
            }

            $sql = "select var_pagename from " . DB_PREFIX . "pages where  var_pagetype=" . MODULE_ID;

            $query = $this->db->query($sql);
            $result = $query->row_array();
            $sql1 = "select var_pagename from " . DB_PREFIX . "pages where  int_glcode=16";

            $query1 = $this->db->query($sql1);
            $result1 = $query1->row_array();
            $moduleurl1 = $this->common_model->getUrl('pages', '2', '18', '');

            $innerpagetitle = '<a href="' . SITE_PATH . '" title="Home">Home</a>&nbsp;>&nbsp;<a href=' . $moduleurl1 . ' title="' . $result1['var_pagename'] . '">' . $result1['var_pagename'] . '</a>&nbsp;>&nbsp;<a href=' . $moduleurl . ' title="' . htmlspecialchars($result['var_pagename']) . '">' . $result['var_pagename'] . ' </a>>&nbsp;' . $video;
        }
        if ($innerpagetitle != '') {
            $data .=$innerpagetitle;
        }

//        }
        return $data;
    }

    function getpagedata($id = '', $tablename = 'pages') {
        if ($id != '' && $tablename != '') {
            if ($this->uri->segment(2) == 'insert_contactdata') {
                $id = 3;
            } else {
                $id = $id;
            }

            $alias_sql = "SELECT * FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "'";
            $alias_result = $this->db->query($alias_sql);
            return $alias_result->row_array();
        } else {
            return false;
        }
    }

    function getpagedata_content($id = '', $tablename = 'pages') {
        if ($id != '' && $tablename != '') {
            if ($this->uri->segment(2) == 'insert_contactdata') {
                $id = 3;
            } else {
                $id = $id;
            }

            $alias_sql = "SELECT * FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "' and chr_displaycontent='Y'";
//            $alias_sql = "SELECT * FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "'";
            $alias_result = $this->db->query($alias_sql);
            return $alias_result->row_array();
        } else {
            return false;
        }
    }

    function getpagedata_Title($id = '', $tablename = 'pages') {
        if ($id != '' && $tablename != '') {
            if ($this->uri->segment(2) == 'insert_contactdata') {
                $id = 3;
            } else {
                $id = $id;
            }

            $alias_sql = "SELECT * FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "'";
//            $alias_sql = "SELECT * FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "'";
            $alias_result = $this->db->query($alias_sql);
            return $alias_result->row_array();
        } else {
            return false;
        }
    }

    function GetSEOFooterMenuData($pageId) {
        $fkstring = '';
        $this->menuString = "";
        $uriseg = $this->uri->rsegments;
        $selectstring = $this->getfkarray($pageId, $fkstring);
        $selectarray = explode(",", $selectstring);
        $sql = "SELECT *,case var_pagetype WHEN 0 THEN CONCAT('" . SITE_PATH . "',var_alias) ELSE CONCAT('" . SITE_PATH . "',var_alias) end as link FROM " . DB_PREFIX . "pages WHERE int_glcode!=1 and chr_publish='Y' and chr_delete='N' and chr_footer_display='Y' order by int_displayorder asc limit 0,5";
        $result = $this->db->query($sql);
        $seofooterMenu = $result->result_array();
        $i = 1;
        foreach ($seofooterMenu as $footer) {
            
//            print "<pre/>";
//            print_r($footer);
//            die;
            
            
            if (in_array($footer['int_glcode'], $selectarray)) {
                $selected = "selected";
            }
            else if($footer['var_pagetype'] == MODULE_ID && MODULE_ID == 144){
                $selected = "selected";
            }
            else {
                $selected = "";
            }

            if ($i == count($seofooterMenu)) {
                $class = "last";
            } else {
                $class = "";
            }
//            print "<pre/>";
//            print_r($uriseg); exit;
            
            
            
                $this->menuString .= '<li class="' . $class . '"><a href="' . $footer['link'] . '" class="' . $selected . '" title="' . htmlspecialchars($footer['var_pagename']) . '">' . htmlspecialchars($footer['var_pagename']) . '</a></li>';
            

            $i++;
        }
        return $this->menuString;
    }

    function GetFooterMenuData($pageId) {
       

        $fkstring = '';
        $this->menuString = "";
        $uriseg = $this->uri->rsegments;
        $selectstring = $this->getfkarray($pageId, $fkstring);
        $selectarray = explode(",", $selectstring);
//        $notshow = "and p.int_glcode NOT IN(13,12)";
        if (SITE_SEO == "Y") {
            $sql = "select p.int_glcode,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,case p.var_pagetype WHEN 0 THEN CONCAT('" . SITE_PATH . "',p.var_alias) ELSE CONCAT('" . SITE_PATH . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.int_glcode!='1' and p.chr_publish='Y' and p.chr_delete='N' and p.fk_pages=0 and p.chr_footer_display='Y' $notshow order by p.int_displayorder asc limit 0,5";
        } else {
            $sql = "select p.int_glcode,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,case p.var_pagetype WHEN 0 THEN CONCAT('" . SITE_PATH . "',p.var_alias) ELSE CONCAT('" . SITE_PATH . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.int_glcode!='1' and p.chr_publish='Y' and p.chr_delete='N' and p.fk_pages=0 and p.chr_footer_display='Y' $notshow order by p.int_displayorder asc limit 0,5";
        }
        $query = $this->db->query($sql);
        $count = $query->num_rows;
        $footer .='<nav><ul>';
        if ($count > 0) {
            if (RECORD_ID == 1 && $this->uri->segment(1) == '') {
                $home_slct_footer = " selected";
            } else {
                $home_slct_footer = "";
            }
            $footer .='<li><a  class="' . $home_slct_footer . '" title="Home" href="' . SITE_PATH . '">Home</a></li>';
            foreach ($query->result_array() as $data) {
                if (in_array($data['int_glcode'], $selectarray)) {
                    $selected = "selected";
                } else {
                    $selected = "";
                }

                if (MODULE_ID == 120 && $uriseg[2] == 'details' && $data["int_glcode"] == 16) {
                    $selected = "selected";
                } else if (MODULE_ID == 119 && $uriseg[2] == 'details' && $data["int_glcode"] == 16) {
                    $selected = "selected";
                }

                if ($data['int_glcode'] == 16) {
                    $media_url = $this->common_model->getUrl('pages', '2', '18', '');
                    $Dlink = $media_url;
                } else {
                    $Dlink = $data['link'];
                }

                $footer .='<li><a  class="' . $selected . '" title="' . htmlspecialchars($data['var_pagename']) . '" href="' . $Dlink . '">' . $data['var_pagename'] . '</a></li>';
            }
        }
        $footer .='</ul></nav>';
        return $footer;
    }

    function getUrl($tableName = 'pages', $moduleID = 2, $recordID = 0, $alias = '', $action = '') {

        $URL = "#";
        if (SITE_SEO == "N") {
            $res = $this->ModuleArray[$modulename];
            if (empty($res)) {
                $this->db->select('var_modulename');
                $this->db->where('int_glcode', $moduleID);
                $query = $this->db->get('modules');
                $res = $query->row();
                $URL = base_url() . $res->var_modulename;
            } else {
                $URL = base_url() . $res->var_modulename;
            }

            if (!empty($action)) {
                $URL = $URL . '/' . $action;
            }
            if (!empty($recordID)) {
                $URL = $URL . '/' . $recordID;
            }
        } else {
            if (!empty($alias)) {
                $URL = base_url() . $alias;
            } else {
                if ($moduleID != 2 && empty($recordID)) {
                    $res = $this->PagesAliasArray['var_pagetype'][$moduleID];
                    if (empty($res)) {
                        $this->db->select('int_glcode,var_alias');
                        $this->db->where('var_pagetype', $moduleID);
                        $query = $this->db->get('pages');

                        if ($query->num_rows() > 0) {
                            $res = $query->row();
                            $URL = base_url() . $res->var_alias;
                        }
                    } else {
                        $URL = base_url() . $res->var_alias;
                    }
                } else {

                    $res = $this->PagesAliasArray['int_glcode'][$recordID];
                    if (empty($res)) {
                        $this->db->select('var_alias');
                        $this->db->where('int_glcode', $recordID);
                        $query = $this->db->get($tableName);
                        $res = $query->row();
                        $URL = base_url() . $res->var_alias;
                    } else {
                        $URL = base_url() . $res->var_alias;
                    }
                }
            }
        }
        return $URL;
    }

    function getMasters($tablename) {
        $returnArry = array();
        $this->db->select('*');
        $this->db->from($tablename);
        $this->db->where('chr_delete', 'N');
        $this->db->where('chr_publish', 'Y');
        $this->db->order_by('int_displayorder');
        $query = $this->db->get();
        foreach ($query->result_array() as $row) {
            $returnArry[$row['int_glcode']] = $row;
        }
        return $returnArry;
    }

    function GetHeaderMenuData($pageId) {
//         echo $_SESSION['is_mobile_browser']."&&&";exit
        $uriseg = $this->uri->rsegments;
        $fkstring = '';
        $this->menuString = "";

        $selectstring = $this->getfkarray($pageId, $fkstring);
        $selectarray = explode(",", $selectstring);

        $length = '7';

        $sql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,case p.var_pagetype WHEN 0 THEN CONCAT('" . SITE_PATH . "',p.var_alias) ELSE CONCAT('" . SITE_PATH . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.int_glcode!='1' and p.chr_publish='Y' and p.chr_delete='N' and p.chr_menu_display='Y'  " . $where . " order by p.int_displayorder asc";

        $query = $this->db->query($sql);
        $count = $query->num_rows;

        $i = 0;

        if ($count > 0) {

            foreach ($query->result_array() as $result) {

                $pitems[] = $result;
            }
            if ($pitems) {
                foreach ($pitems as $p) {
                    $pt = $p['fk_pages'];
                    $list = @$children[$pt] ? $children[$pt] : array();
                    array_push($list, $p);
                    $children[$pt] = $list;
                }
            }


            $this->menuString .= "<nav class=\"collapse collapsing navbar-collapse\"><ul class=\"nav navbar-nav navbar-center\">";

            if (RECORD_ID == 1 && $this->uri->segment(1) == '') {
                $home_selected = "selected";
            } else {
                $home_selected = "";
            }

            $this->menuString .= '<li class="' . $home_selected . '"><a title="Home" href=' . SITE_PATH . '><b></b></a></li>';

            foreach ($children[0] as $record) {
                if ($i < $length && $record['fk_pages'] == 0) {

                    $uriseg = $this->uri->rsegments;

                    if($uriseg['2'] != 'details'){
                    if (in_array($record['int_glcode'], $selectarray)) {
                        $sclass = "selected";
                    } else {
                        $sclass = "";
                    }
                    }
//                     if(MODULE_ID == 120 && $uriseg[2] == 'details' && $record["int_glcode"] == 16){
//                    $sclass = "selected";
//               } else if(MODULE_ID == 119 && $uriseg[2] == 'details' && $record["int_glcode"] == 16){
//                    $sclass = "selected";
//               }
                    if ($record['int_glcode'] == 16) {
                        $media_url = $this->common_model->getUrl('pages', '2', '18', '');
                        $link = $media_url;
                    } else {
                        $link = $record['link'];
                    }



                    if (array_key_exists($record['int_glcode'], $children)) {
                        $this->menuString .= "<li class=\"parent $sclass\"><a  href=\"$link\" title='" . htmlspecialchars($record['var_pagename']) . "' ><b>" . $record['var_pagename'] . "</b></a>";
                        $this->menuString .= "<ul class=\"sub\">";
                        $this->menuString .= $this->getChildMenu($record['int_glcode'], $children, $selectarray);
                        $this->menuString .="</ul>";
                        $this->menuString.="</li>";
                    } else {

                        $this->menuString .= "<li class='$sclass'><a   href=\"$link\" " . " title='" . htmlspecialchars($record['var_pagename']) . "'><b>" . $record['var_pagename'] . "</b></a></li>";
                    }
                    $i++;
                }
            }

            $this->menuString.="</ul></nav>";
        }
        return $this->menuString;
    }

    function getChildMenu($id, $children, $selectarray, $type = '') {
        if ($children[$id]) {
            $count = count($children[$id]);
            $d = 1;
            $uriseg = $this->uri->rsegments;
            foreach ($children[$id] as $subrecord) {
                if (in_array($subrecord['int_glcode'], $selectarray)) {
                    $subSelclass = "selected";
                } else {
                    $subSelclass = "";
                }
                if ($uriseg[2] == 'details') {
                    if ($subrecord["var_pagetype"] == MODULE_ID) {
                        $subSelclass = "selected";
                    } else {
                        $subSelclass = '';
                    }
                }

                $link = $subrecord['link'];
                if (array_key_exists($subrecord['int_glcode'], $children)) {
                    $this->menuString .= "<li class=\"parent $subSelclass\"><a class=\"$subSelclass\" href='" . $link . "' title=\"" . htmlspecialchars($subrecord['var_pagename']) . "\" ><i class=\"fa fa-long-arrow-right\"></i>" . $subrecord['var_pagename'] . "</a>";
                } else {
                    $this->menuString .= "<li class=\"$subSelclass\"><a  href='" . $link . "' title=\"" . htmlspecialchars($subrecord['var_pagename']) . "\"><i class=\"fa fa-long-arrow-right\"></i>" . $subrecord['var_pagename'] . "</a>";
                }
                if (array_key_exists($subrecord['int_glcode'], $children)) {
                    $this->menuString .= "<ul class=\"sub\">";
                    $this->menuString .= $this->getChildMenu($subrecord['int_glcode'], $children, $selectarray, 'no');
                    $this->menuString .= "</ul>";
                }
                $this->menuString .= "</li>";
            }
        }
    }

    function getfkarray($pageid, $fkstring = '') {

        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_on();
        $sql = "select int_glcode,fk_pages from " . DB_PREFIX . "pages where int_glcode='" . $pageid . "'";
        $query = $this->db->query($sql);
        $count = $query->num_rows;
        $this->db->cache_off();
        $result = $query->row_array();

        if ($count > 0) {
            if ($result['fk_pages'] != '0') {
                $fkstring.=$result['int_glcode'] . ',';
                return $this->getfkarray($result['fk_pages'], $fkstring);
            } else {
                $fkstring.=$result['int_glcode'];
                return $fkstring;
            }
        } else {
            return $fkstring;
        }
    }

    function get_contactusdata() {
        $sql = "select * from " . DB_PREFIX . "contactuspage where chr_delete='N' and chr_publish='Y' and int_glcode=1";
        $query = $this->db->query($sql);
        $result = $query->row_array();

        $email1 = $this->generate_contactus_mail_image($result['var_email']);

        $email2 = $this->generate_contactus_mail_image1($result['var_email']);
        $email3 = $this->generate_contactus_mail_image1($result['var_email2']);
        $managing_email = $this->generate_contactus_mail_image1($result['var_directoremail']);
        define('CONTACT_NAME', $result['var_name']);
        define('CONTACT_ADD', $result['var_address']);
        define('CONTACT_PHONE', $result['var_phone']);
        define('CONTACT_FAX', $result['var_fax']);
        define('CONTACT_EMAIL_IMAGE', $email1);
        define('CONTACT_EMAIL2_IMAGE_FOOTER', $email2);
        define('CONTACT_EMAIL2_IMAGE_FOOTER1', $email3);
        define('MANAGING_EMAIL_IMAGE_SMALL', $managing_email);
        define('CONTACT_EMAIL', $result['var_email']);
        define('CONTACT_EMAIL1', $result['var_email2']);
        define('MANAGING_EMAIL', $result['var_directoremail']);
    }

    function get_contactusdata2() {
        $sql = "select * from " . DB_PREFIX . "contactuspage where chr_delete='N' and chr_publish='Y' and int_glcode=1";
        $query = $this->db->query($sql);
        $result = $query->row_array();

        $email1 = $this->generate_contactus_mail_image2($result['var_email']);

        define('CONTACT_NAME', $result['var_name']);
        define('CONTACT_ADD', $result['var_address']);
        define('CONTACT_PHONE', $result['var_phone']);
        define('CONTACT_FAX', $result['var_fax']);
        define('CONTACT_EMAIL_IMAGE_SMALL', $email1);
        define('CONTACT_EMAIL2_IMAGE_FOOTER', $email2);
        define('CONTACT_EMAIL_SMALL', $result['var_email']);
    }

    function getcontactdata() {
        $sql = "select * from " . DB_PREFIX . "contactuspage where chr_delete = 'N' and chr_publish='Y'";
        $rs = $this->db->query($sql);
        $countdata1 = $rs->num_rows();
        $res = $rs->row_array();
        return $res;
    }

    function generate_contactus_mail_image($email) {

        $mailid_text = $email;
        $configArray['color'] = "#858585";
        $configArray['font-size'] = "12";
        $contactimage = $this->mylibrary->text2image($mailid_text, $configArray, $filepath = 'upimages/contactus');

        return $contactimage;
    }

    function generate_contactus_mail_image2($email) {
        $mailid_text = $email;
        $configArray['color'] = "#474646";
        $configArray['font-size'] = "11";
        $contactimage = $this->mylibrary->text2image($mailid_text, $configArray, $filepath = 'upimages/contactus');

        return $contactimage;
    }

    function generate_contactus_mail_image1($email2) {
        $mailid_text = $email2;
        $configArray['color'] = "#474646";
        $configArray['font-size'] = "11";
        $contactimage = $this->mylibrary->text2image($mailid_text, $configArray, $filepath = 'upimages/contactus');
        return $contactimage;
    }

    function generate_random_number() {

        $chars = "0123456789";
        $res = "";
        for ($i = 0; $i < 15; $i++) {
            $res .= $chars[mt_rand(0, strlen($chars) - 1)];
        }

        return $res;
    }

    function getHomepagedata($id = '', $tablename = 'pages') {
        if ($id != '' && $tablename != '') {
            $alias_sql = "SELECT var_pagename,text_fulltext, var_short_description,int_glcode,var_alias FROM " . DB_PREFIX . $tablename . " WHERE int_glcode in  (" . $id . ") order by int_displayorder";
            $alias_result = $this->db->query($alias_sql);
            return $alias_result->result_array();
        } else {
            return false;
        }
    }

    function get_thankyou_meta($id) {
        $sql_check = "SELECT var_metatitle,var_metakeyword,var_metadescription FROM " . DB_PREFIX . "pages WHERE int_glcode=8";
        $result = $this->db->query($sql_check);
        $result1 = $result->row_array();
        return $result1;
    }

    function set_next_prev_url($cur_url = '', $pagenumber = '', $noofpages = '') {
        if ($cur_url != '' && $pagenumber != '' && $noofpages > 1 && $pagenumber <= $noofpages) {
            $prev_url = '';
            $next_url = '';
            $prev_page = $pagenumber - 1;
            $next_page = $pagenumber + 1;
            $prev_href = SITE_PATH . $cur_url . '/page-' . $prev_page;
            $next_href = SITE_PATH . $cur_url . '/page-' . $next_page;

            if ($pagenumber == '1') {
                $next_url = '<link rel="next" href="' . $next_href . '">';
            } else if ($pagenumber == $noofpages) {
                $prev_url = '<link rel="prev" href="' . $prev_href . '">';
            } else {
                if ($prev_page == 1) {
                    $prev_url = '<link rel="prev" href="' . SITE_PATH . $cur_url . '">';
                } else {
                    $prev_url = '<link rel="prev" href="' . $prev_href . '">';
                }
                $next_url = '<link rel="next" href="' . $next_href . '">';
            }
            $return_url = $prev_url . $next_url;
            $this->next_prev_url = $return_url;
        }
    }

    function GetHomeBannerData() {
        $sql = "select * from " . DB_PREFIX . "banner where chr_delete='N' and chr_publish='Y' order by int_displayorder asc";
        $query = $this->db->query($sql);
        $returnArry = $query->result_array();
        return $returnArry;
    }

//    
    function GetInnerBannerData($rec_id) {
        $sql_InnerBanner = "select * from " . DB_PREFIX . "banner where chr_delete='N' and chr_publish='Y' and chr_bannertype_flag='IB' and fk_addpages =$rec_id order by int_displayorder asc";
        $query_InnerBanner = $this->db->query($sql_InnerBanner);
        $returnArry_InnerBanner = $query_InnerBanner->result_array();
        return $returnArry_InnerBanner;
    }

//     function getpagedata_content($id = '', $tablename = 'pages') {
//        if ($id != '' && $tablename != '') {
//            if ($this->uri->segment(2) == 'insert_contactdata') {
//                $id = 3;
//            } else {
//                $id = $id;
//            }
//
//            $alias_sql = "SELECT text_fulltext FROM " . DB_PREFIX . $tablename . " WHERE int_glcode = '" . $id . "' and chr_displaycontent='Y'";
//            $alias_result = $this->db->query($alias_sql);
//            return $alias_result->row_array();
//        } else {
//            return false;
//        }
//    }

    function getdetailpagedata($id = '') {
//        echo $id;die;
        $uriseg = $this->uri->rsegments;
//         print_r($uriseg);
//         echo RECORD_ID;
        if ($id != '') {

            if ($uriseg['1'] == 'photoalbum' || $uriseg['2'] == 'details ') {
                $alias_sql = "SELECT *  FROM " . DB_PREFIX . "photoalbum  WHERE int_glcode = '" . RECORD_ID . "'";
            } else if ($uriseg['1'] == 'videoalbum' || $uriseg['2'] == 'details ') {
                $alias_sql = "SELECT *  FROM " . DB_PREFIX . "videoalbum  WHERE int_glcode = '" . RECORD_ID . "'";
            } else if ($uriseg['1'] == 'menus' || $uriseg['2'] == 'details ') {
                $alias_sql = "SELECT *  FROM " . DB_PREFIX . "menus  WHERE int_glcode = '" . RECORD_ID . "'";
            } else {
                $alias_sql = "SELECT *  FROM " . DB_PREFIX . "pages  WHERE var_pagetype = '" . $id . "'";
            }
            $alias_result = $this->db->query($alias_sql);
            $row = $alias_result->row_array();
            return $row;
//            echo '<pre/>'; print_r($row);die;
//             $aliasnamesql = "SELECT ";
        } else {
            return false;
        }
    }

    function getmaintaincedata() {
        $sql = "select var_main_description from " . DB_PREFIX . "general_settings   limit 0,1";
        $alias_result = $this->db->query($sql);
        $row = $alias_result->row_array();
        return $row;
    }

    function get_page_title() {

        $uriseg = $this->uri->rsegments;

        $id = RECORD_ID;

//          if(RECORD_ID==8 && MODULE_ID ==88)
//          {
//                $id=$id+1;
//          }

        $sql = "SELECT var_pagename FROM " . DB_PREFIX . "pages where int_glcode=" . $id;
        $result = $this->db->query($sql);
        $res = $result->row_array();
//        print_r($res['var_pagename']);
        return $res['var_pagename'];
    }

    function get_project_title($id) {

        $sql = "SELECT var_title FROM " . DB_PREFIX . "videoalbum where int_glcode=" . $id;
        $result = $this->db->query($sql);
        $res = $result->row_array();
        return $res['var_title'];
    }

    function get_menu_title($id) {

        $sql = "SELECT var_category FROM " . DB_PREFIX . "menucategory where int_glcode=" . $id;
        $result = $this->db->query($sql);
        $res = $result->row_array();
        return $res['var_category'];
    }

    function get_team_title($id) {

        $sql = "SELECT var_title FROM " . DB_PREFIX . "team where int_glcode=" . $id;
        $result = $this->db->query($sql);
        $res = $result->row_array();
        return $res['var_title'];
    }

    function get_photogallery_title($id) {

        $sql = "SELECT var_title FROM " . DB_PREFIX . "photoalbum where int_glcode=" . $id;
        $result = $this->db->query($sql);
        $res = $result->row_array();
        return $res['var_title'];
    }

    function Clean_String($String) {
        $String = str_replace(' ', '', $String);
        return preg_replace('/[^A-Za-z0-9.\-]/', '', $String);
    }

    function mapdata() {
        $qry = "select * from  " . DB_PREFIX . "contactuspage where chr_delete='N' and chr_publish='Y'";
        $query = $this->db->query($qry);
        $data = $query->result_array();
        return $data;
    }

    function GetAdminPanelBannerData() {
        $query_PPbanner = "select * from " . DB_PREFIX . "adminpanelbanner where chr_delete ='N' and chr_publish = 'Y' order by int_displayorder";
        $sql_PPbanner = $this->db->query($query_PPbanner);
        $PPbanner = $sql_PPbanner->result_array();
        return $PPbanner;
    }

//       
}

?>