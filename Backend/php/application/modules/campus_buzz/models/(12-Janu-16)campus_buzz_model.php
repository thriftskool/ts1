<?php

class campus_buzz_model extends CI_Model {

    var $int_glcode;
    var $fk_pages;
    var $var_pagename;
    var $text_fulltext;
    var $int_displayorder;
    var $chr_access = 'P';
    var $chr_publish = 'Y';   // (normal Attribute)
    var $chr_delete = 'N';   // (normal Attribute)
    var $dt_createdate;   // (normal Attribute)
    var $dt_modifydate;   // (normal Attribute)
    var $chr_star;
    var $chr_read;   // (normal Attribute)
    var $oldint_displayorder; // Attribute of Old Displayorder
    var $pagename = ''; // Attribute of Page Name
    var $numofrows; // Attribute of Num Of Rows In Result
    var $numofpages; // Attribute of Num Of Pagues In Result
    var $orderby = 'var_title'; // Attribute of Deafult Order By
    var $ordertype = 'asc'; // Attribute of Deafult Order By
    var $searchby = '0'; // Attribute of Search By
    var $searchtxt; // Attribute of Search Text
    var $start = 1; // Attribute of Start For Paging
    var $pagesize = 30; // Attribute of Pagesize For Paging
    var $pagenumber = '1'; // Attribute of Page Number For Paging(
    var $lastinsertid; // Attribute of Last Inserid
    var $urlwithpara = ''; // Attribute of URL With parameters
    var $urlwithpoutsearch = ''; // Attribute of URL With parameters without searh
    var $urlwithoutsort = ''; // Attribute of URL With parameters without sort
    var $urlwithoutpaging = ''; // Attribute of URL With parameters without paging
    var $filterby = '0';
    var $urlwithoutfilter = '';
    var $display_limit_array = array('5', '10', '15', '30');
    var $dateField;
    var $noofpages;
    var $searchbyVal;
    var $AutoSearchUrl;
    var $sortvar = '';

    public function __construct() {
        $this->load->database();
        $this->load->helper(array('form', 'url'));
    }

    function HeaderPanel() {
        $content['headerpanel'] = $this->mylibrary->generateHeaderPanel($this->generateParam());
        return $content['headerpanel'];
    }

    function PagingTop() {
        $content['pagingtop'] = $this->mylibrary->generatePagingPannel($this->generateParam('top'));
        return $content['pagingtop'];
    }

    function PagingBottom() {
        $content['pagingbottom'] = $this->mylibrary->generatePagingPannel($this->generateParam('bottom'));
        return $content['pagingbottom'];
    }

    function initialize($flag = '') {

        $term = $this->input->get_post('term');
        $searchbyVal = $this->input->get_post('searchbyVal');
        $searchtxt = $this->input->get_post('searchtxt');
        $searchby = $this->input->get_post('searchby');
        $type = $this->input->get_post('type');
        $ordertype = $this->input->get_post('ordertype');
        $filterby = $this->input->get_post('filterby');
        $pagesize = $this->input->get_post('pagesize');
        $pagenumber = $this->input->get_post('pagenumber');
        $orderby = $this->input->get_post('orderby');
        $categoryid = $this->input->get_post('categoryid');

//        $fk_postcategory = $this->input->get_post('fk_postcategory');
        $fk_university = $this->input->get_post('fk_university');
        $chr_spamcount = $this->input->get_post('chr_spamcount');
        $create_date = $this->input->get_post('create_date');
        $chr_statuscmb = $this->input->get_post('chr_statuscmb');

        if (!empty($term)) {
            $searchtxt = ($type == 'autosearch') ? $term : $searchtxt;
        }
        $this->searchbyVal = (!empty($searchbyVal)) ? $searchbyVal : $this->searchbyVal;
        $this->searchby = (isset($searchby)) ? urldecode($searchby) : '';
        $this->searchtxt = (!empty($searchtxt)) ? urldecode($searchtxt) : '';
        $this->searchtxt = htmlspecialchars($this->searchtxt);
        $this->orderby = (!empty($orderby)) ? $orderby : $this->orderby;
        $this->ordertype = (!empty($ordertype)) ? $ordertype : $this->ordertype;
        $this->filterby = (!empty($filterby)) ? $filterby : $this->filterby;
        $this->categoryid = (!empty($categoryid)) ? $categoryid : $this->categoryid;

        $this->fk_university = (!empty($fk_university)) ? $fk_university : $this->fk_university;
        $this->chr_spamcount = (!empty($chr_spamcount)) ? $chr_spamcount : $this->chr_spamcount;
        $this->create_date = (!empty($create_date)) ? $create_date : $this->create_date;
        $this->chr_statuscmb = (!empty($chr_statuscmb)) ? $chr_statuscmb : $this->chr_statuscmb;

        if ($this->input->get_post('sorting') == 'Y') {
            if ($this->ordertype == "asc") {   // This is for sort image
                $this->ordertype = "desc";
                $this->sortvar = "<img alt=\"sorting\" src=\"" . ADMIN_MEDIA_URL . "images/arrow-down.png\" style=\"vertical-align:middle;\">";
            } else if ($this->ordertype == "desc") {   // This is for sort image
                $this->ordertype = "asc";
                $this->sortvar = "<img alt=\"sorting\" src=\"" . ADMIN_MEDIA_URL . "images/arrow-up.png\" style=\"vertical-align:middle;\">";
            }
        } else {
            if ($this->ordertype == "asc") {   // This is for sort image
                $this->sortvar = "<img alt=\"sorting\" src=\"" . ADMIN_MEDIA_URL . "images/arrow-up.png\" style=\"vertical-align:middle;\">";
            } else if ($this->ordertype == "desc") {   // This is for sort image
                $this->sortvar = "<img alt=\"sorting\" src=\"" . ADMIN_MEDIA_URL . "images/arrow-down.png\" style=\"vertical-align:middle;\">";
            }
        }

        if ($flag == 'Y') {
//            echo $this->numofrows;
            $this->pagesize = (!empty($pagesize)) ? $pagesize : 15;
            $this->pagenumber = (!empty($pagenumber)) ? $pagenumber : $this->pagenumber;
            $this->noofpages = intval($this->numofrows / $this->pagesize);
            $this->noofpages = (($this->numofrows % $this->pagesize) > 0) ? ($this->noofpages + 1) : ($this->noofpages);
            $this->start = ($this->pagenumber - 1 ) * $this->pagesize;
//            echo $this->start;
            return $this;
        } else {
            $this->numofrows = $this->CountRows();
            $this->pagesize = (!empty($pagesize)) ? $pagesize : $this->pagesize;
            $this->pagenumber = (!empty($pagenumber)) ? $pagenumber : $this->pagenumber;
            $this->noofpages = intval($this->numofrows / $this->pagesize);
            $this->noofpages = (($this->numofrows % $this->pagesize) > 0) ? ($this->noofpages + 1) : ($this->noofpages);
            $this->start = ($this->pagenumber - 1 ) * $this->pagesize;
        }
    }

    function Generateurl($flag = '') {

        if ($flag == 'Y') {
            
        } else {

            $this->pagename = MODULE_PAGE_NAME . '?';
        }

        if ($this->input->get_post('categoryid') == 'Y') {
            $Ftr_cat = "&categoryid=" . $this->input->get_post('categoryid');
        } else {
            $Ftr_cat = "";
        }
        $this->addpagename = MODULE_PAGE_NAME . '/add?';

        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&hfilterby=' . $this->filterby . '&history=T' . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->addurlwithpara = $this->addpagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&fk_university=' . $this->fk_university . '&chr_spamcount=' . $this->chr_spamcount . '&create_date=' . $this->create_date . '&chr_statuscmb=' . $this->chr_statuscmb;
        $this->fronturlwithpara = $this->pagename . '&' . 'pagesize=' . urlencode($this->pagesize) . '&numofrows=' . $this->numofrows . '&categoryid=' . urlencode($this->categoryid) . $Ftr_cat;
        if ($flag == 'Y') {
            return $this;
        }
    }

    function generateParam($position = 'top') {
        if ($position == 'top') {
//            $post_category = $this->search_post_category_combo();
            $combo = $this->search_university_combo();
            $spam_count = $this->Get_Count_combo();
            $select_date = $this->select_datepicker();
            $status_combo = $this->Get_Status_combo();
//            $publish_combo = $this->Get_Publish_combo();
        }
        return array('pageurl' => MODULE_PAGE_NAME,
            'heading' => 'Manage Campus Buzz',
//            'listImage' => 'add-new-user-icon.png',
            'tablename' => DB_PREFIX . 'campus_buzz',
            'position' => $position,
            'actionImage' => 'Add New Buzz',
//            'actionImageHover' => 'add-new-button-blue-hover.gif',
            'actionUrl' => MODULE_PAGE_NAME . '/add',
            'dispPaging' => 'Yes',
            'AutoSearchUrl' => $this->AutoSearchUrl,
            'display' => array('displayurl' => $this->urlwithoutpaging,
                'pagesize' => $this->pagesize,
                'limitarray' => $this->display_limit_array,
            ),
            'paging' => array('pagenumber' => $this->pagenumber,
                'noofpages' => $this->noofpages,
                'numofrows' => $this->numofrows,
                'pagingurl' => $this->urlwithpara
            ),
            'search' => array('searchArray' => array("var_title" => "Title"),
                'searchBy' => $this->searchby,
                'searchText' => $this->searchtxt,
                'searchUrl' => $this->urlwithpoutsearch
            ),
//            'sccombo' => $combo
            'post_university_combo' => $combo,
//            'post_category' => $post_category,
            'spam_count' => $spam_count,
            'select_date' => $select_date,
            'status_combo' => $status_combo
        );
    }

    function selectAll() {

        $this->initialize();
        $this->Generateurl();
        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_title ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }


        if ($this->fk_university != '' && $this->fk_university != '0') {
            $whereclauseids .=" and um.fk_university = '" . $this->fk_university . "'";
        }

        if ($this->create_date != '') {
            $originalDate1 = $this->create_date;
            $newDate = date("Y-m-d", strtotime($originalDate1));
            $whereclauseids .= "and date(um.dt_createdate)='" . $newDate . "'";
        }

        if ($_REQUEST['chr_statuscmb'] != '') {

            $whereclauseids .=" and um.chr_status = '" . $_REQUEST['chr_statuscmb'] . "'";
        }

        if ($this->chr_spamcount == '5') {
            $whereclauseids .=" and um.int_count >= '" . $this->chr_spamcount . "'";
        } elseif ($this->chr_spamcount != '' && $this->chr_spamcount != '0') {
            $whereclauseids .=" and um.int_count = '" . $this->chr_spamcount . "'";
        }

        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by var_title desc';
                $searchbyVal = " ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_delete = 'N'";
//                echo $searchbyVal; die;
                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_title";
                }
                $autoSearchQry = $this->db->query("select {$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "campus_buzz where {$this->searchbyVal} $searchbyVal  GROUP BY var_title $orderby");
                $this->mylibrary->GetAutoSearch($autoSearchQry);
            }
        }



        $limitby = 'OFFSET ' . $this->start . ' LIMIT ' . $this->pagesize;
        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;
//        $query = $this->db->query("select * ,(SELECT count(1)as totalpages FROM " . DB_PREFIX . "campus_buzz)as totalpages from " . DB_PREFIX . "campus_buzz where chr_delete = 'N' $whereclauseids  $orderby $limitby");

        $query1 = "SELECT um.*, unim.var_name as university_name from campus_buzz as um
                    	LEFT JOIN university_management as unim on um.fk_university = unim.int_glcode 
				where um.chr_delete='N' $whereclauseids $orderby  $limitby";
        $query = $this->db->query($query1);
        return $query;
    }

    function Get_Status_combo() {
        $sel = "<select id='chr_statuscmb' class='more-textarea fl' name='chr_statuscmb' style='float:left;' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_chr_status');\">";
        $sel .= "<option value=''>Select Status</option>";
        if ($_REQUEST['chr_statuscmb'] == '0') {
            $selected0 = "selected";
        } else {
            $selected0 = '';
        }
        if ($_REQUEST['chr_statuscmb'] == '1') {
            $selected1 = "selected";
        } else {
            $selected1 = '';
        }
        if ($_REQUEST['chr_statuscmb'] == '2') {
            $selected2 = "selected";
        } else {
            $selected2 = '';
        }

        $sel.='<option value="0" ' . $selected0 . '>Active</option>';
        $sel.='<option value="1" ' . $selected1 . '>Expire</option>';
        $sel.='<option value="2" ' . $selected2 . '>Cancel</option>';
        $sel .="</select>";
        return $sel;
    }

    function CountRows() {

        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_title ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        } else {
            $whereclauseids = '';
        }

        if ($this->fk_university != '' && $this->fk_university != '0') {
            $whereclauseids .=" and fk_university = '" . $this->fk_university . "'";
        }
        if ($this->create_date != '') {
            $originalDate1 = $this->create_date;
            $newDate = date("Y-m-d", strtotime($originalDate1));
            $whereclauseids .= "and date(dt_createdate)='" . $newDate . "'";
        }
        if ($this->chr_spamcount == '5') {
            $whereclauseids .=" and int_count >= '" . $this->chr_spamcount . "'";
        } elseif ($this->chr_spamcount != '' && $this->chr_spamcount != '0') {
            $whereclauseids .=" and int_count = '" . $this->chr_spamcount . "'";
        }

        if ($_REQUEST['chr_statuscmb'] != '') {

            $whereclauseids .=" and chr_status = '" . $_REQUEST['chr_statuscmb'] . "'";
        }

        $sqlCountPages = "select * FROM " . DB_PREFIX . "campus_buzz  where chr_delete='N' $whereclauseids";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }

    function search_university_combo() {

        $query = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $res = $this->db->query($query);
        $sel = "<select style=\"width: 15% !important\" id='fk_university' class='more-textarea fl' name='fk_university' style='float:left;' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_university');\">";
        $sel .= "<option value=''>-- Select University --</option>";
        foreach ($res->result() as $row) {
            if ($row->int_glcode == $this->fk_university) {
                $selected = "selected";
            } else {
                $selected = '';
            }
            $sel.='<option value="' . $row->int_glcode . '" ' . $selected . '>' . $row->var_name . '</option>';
        }
        $sel .="</select>";
        return $sel;
    }

    function select_datepicker() {

        $sel = "<input placeholder=\"Creation Date\"  class='more-textarea fl' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_create_date');\"   style=\"width: 15% !important\" name=\"create_date\"  id=\"create_date\" value='" . $this->create_date . "'>";
        return $sel;
    }

    function Get_Count_combo() {
        $sel = "<select id='chr_spamcount' class='more-textarea fl' name='chr_spamcount' style='float:left;' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_spamcount');\">";
        $sel .= "<option value=''>-- Select Spam Counter --</option>";
        if ($this->chr_spamcount == '1') {
            $selected1 = "selected";
        } else {
            $selected1 = '';
        }
        if ($this->chr_spamcount == '2') {
            $selected2 = "selected";
        } else {
            $selected2 = '';
        }
        if ($this->chr_spamcount == '3') {
            $selected3 = "selected";
        } else {
            $selected3 = '';
        }
        if ($this->chr_spamcount == '4') {
            $selected4 = "selected";
        } else {
            $selected4 = '';
        }
        if ($this->chr_spamcount == '5') {
            $selected5 = "selected";
        } else {
            $selected5 = '';
        }
        $sel.='<option value="1" ' . $selected1 . '>1</option>';
        $sel.='<option value="2" ' . $selected2 . '>2</option>';
        $sel.='<option value="3" ' . $selected3 . '>3</option>';
        $sel.='<option value="4" ' . $selected4 . '>4</option>';
        $sel.='<option value="5" ' . $selected5 . '>5 and more</option>';

        $sel .="</select>";
        return $sel;
    }

    function select_Rows($id) {

        $query = $this->db->get_where('campus_buzz', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    public function insert() {
        $data = array(
            'var_title' => $this->input->post('var_title', true),
            'var_description' => $this->input->post('var_description', true),
            'fk_university' => $this->input->post('fk_university'),
            'fk_user_id' => '0',
            'dt_expiredate' => $this->input->post('dt_expiredate'),
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => $this->input->post('chr_publish'),
            'chr_delete' => 'N',
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );
        $this->db->insert('campus_buzz', $data);
        $id = $this->db->insert_id();

        $this->mylibrary->insertinlogmanager(MODULE_ID, 'campus_buzz', $user_id, $id, "");

        return $id;
    }

    function update() {

        $data = array(
            'var_title' => $this->input->post('var_title', true),
            'var_description' => $this->input->post('var_description'),
            'fk_university' => $this->input->post('fk_university'),
            'dt_expiredate' => $this->input->post('dt_expiredate'),
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => $this->input->post('chr_publish'),
            'chr_delete' => 'N',
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );
//        echo '<pre>';print_r($data);exit;

        $this->db->where('int_glcode', $this->input->get_post('ehintglcode'));
        $this->db->update('campus_buzz', $data);

        $sql_property = "select fk_user_id from campus_buzz WHERE int_glcode='" . $this->input->get_post('ehintglcode') . "'";
        $data = $this->db->query($sql_property);
        $row = $data->row_array();
//echo $row['fk_user_id']; die;
        $sql = "select int_glcode from logmanager where var_referenceid='" . $this->input->get_post('ehintglcode') . "' and var_tablename='campus_buzz'";
        $query = $this->db->query($sql);
        $count = $query->num_rows;
        if ($count == 0) {
            $this->mylibrary->insertinlogmanager(MODULE_ID, 'campus_buzz', $row['fk_user_id'], $this->input->get_post('ehintglcode'), "");
        }
    }

    function University_Combo($selectID = '') {

        $sql_property = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $data = $this->db->query($sql_property);

        $display = "";
        $otherString = 'id="fk_university" class="form-control"';
        $selected_ids = Array();
        array_push($selected_ids, $selectID);
        $options = Array();
        $options[''] = '-- Select University --';
        foreach ($data->result() as $row) {
            $options[$row->int_glcode] = ucwords($row->var_name);
        }
        $moduleSelectBox = array('name' => 'fk_university',
            'options' => $options,
            'selected_ids' => $selected_ids,
            'otherString' => $otherString,
            'tdoption' => Array('TDDisplay' => 'Y', 'width' => '30%'),
            'onchange' => 'displayDomainInfo(this.value)'
        );
        $display = form_input_ready($moduleSelectBox, 'select');
        return $display.="";
    }

    function updatedisplay() {

        $tablename = $this->input->get_post('tablename');
        $fieldname = $this->input->get_post('fieldname');
        $value = $this->input->get_post('value');
        $idname = $this->input->get_post('id');

        $updateSql = "UPDATE {$tablename} SET {$fieldname}='{$value}' WHERE  int_glcode in ({$idname}) ";
        $res = $this->db->query($updateSql);
        echo ($res) ? "1" : "0";
        exit;
    }

    function delete_row() {
        $tablename = DB_PREFIX . 'campus_buzz';
        $deleteids = $this->input->get_post('dids');
        $deletearray = explode(',', $deleteids);
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {
            $data = array('chr_delete' => 'Y', 'dt_modifydate' => date('Y-m-d'), 'var_ipaddress' => $_SERVER['REMOTE_ADDR'], 'var_adminuser' => ADMIN_NAME);
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);
//            $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'campus_buzz', 'var_title', $deletearray[$i], 'D', 'int_glcode');
        }
    }

    function getcategorycombo($cate_value, $editid, $fk_cat_id) {
//        echo $fk_cat_id;
        $sql = "select * from " . DB_PREFIX . "category where chr_delete = 'N' and chr_publish='Y' order by int_displayorder asc";
        $records = $this->db->query($sql);
        $record = $records->result();
        $selected_ids = Array();
        array_push($selected_ids, $fk_cat_id);
        $otherString = ' id="fk_category" class="more-textarea fl" style="width:355px;"  get_width_height(this.value)  "';
        $options = Array();
        $options[''] = '- Select Product Category -';
        foreach ($record as $row) {
            $options[$row->int_glcode] = ucwords($row->var_title);
        }
        $moduleSelectBox = array('name' => 'fk_category',
            'style' => 'width:350px;class:more-textarea;',
            'options' => $options,
            'otherString' => $otherString,
            'selected_ids' => $selected_ids,
            'tdoption' => Array('TDDisplay' => 'Y'),
        );
        $display_output = form_input_ready($moduleSelectBox, 'select');
        return $display_output;
    }

    function getappendurl($view = '', $ajax_view = '') {
        $url = '';
        $alias = $this->common_model->PagesAliasArray['int_glcode']['42'];
        $url.=$alias->var_alias;
        if ($ajax_view == 'Y') {
            return $url;
        } else {
            return $url;
        }
    }

    function Count_Gallery($cids) {
        $sql = "select * from campus_buzz_gallery where chr_delete = 'N' and fk_campus_buzz= $cids";
        $records = $this->db->query($sql);
        $rscnt = $records->num_rows();
        return $rscnt;
    }

    function select_View_Buzz_data($id) {

//        $query = $this->db->get_where('post_management', array('int_glcode' => $id));
        $query1 = "SELECT pm.*,um.var_name as university_name,usm.var_username as user_name  from campus_buzz as pm
    LEFT JOIN university_management as um on pm.fk_university = um.int_glcode 
    LEFT JOIN users_manage as usm on pm.fk_user_id = usm.int_glcode 
    where pm.chr_delete='N' and pm.int_glcode=$id";
        $query = $this->db->query($query1);

//echo $this->db->last_query(); die;

        $row = $query->row_array();
        return $row;
    }

    function get_buzz_images($ids) {
        $query1 = "SELECT *  from campus_buzz_gallery where chr_delete='N' and fk_campus_buzz=$ids";
        $query = $this->db->query($query1);
        $row = $query->result_array();
        return $row;
    }

    function updatedisplayview() {

        $tablename = $this->input->get_post('tablename');
        $fieldname = $this->input->get_post('fieldname');
        $value = $this->input->get_post('value');
//        echo $value; die;
        $idname = $this->input->get_post('id');

        $updateSql = "UPDATE {$tablename} SET {$fieldname}='{$value}' WHERE  int_glcode in ({$idname}) ";
        $res = $this->db->query($updateSql);
//        echo $this->db->last_query(); die;

        $update_status = "UPDATE logmanager SET notification_type= '4' WHERE var_referenceid=$idname and var_tablename='campus_buzz' and from_where='1'";
        $this->db->query($update_status);

        $this->Send_Gcm_Message($idname);

        echo ($res) ? "1" : "0";
        exit;
    }

    function Send_Gcm_Message($idname) {
        //APA91bGUTg-mDut7CeA1Vgq4gNEXwxOWyRPchz8-WUnWjiLI1xH3IYcj5pizY6X5wN8AN-Wiz79PZHbWwnoDZzGe323zjrUDRjzn7EcUYL69wCMbSxjHlsZvfCxRG4wY1dJ-NUEeRrYl
        $Get_User_Id = "SELECT fk_user_id, int_glcode FROM campus_buzz WHERE int_glcode=$idname";
        $query_user = pg_query($Get_User_Id);
        $User_Id_Code = pg_fetch_array($query_user);

        $usr_id = $User_Id_Code['fk_user_id'];
        if ($usr_id != '' && $usr_id != '0') {

             $logcnt = $this->count_notification($usr_id);
            
            $Get_User_Reg_Id = "SELECT gcm_code,device_id, int_glcode as user_id FROM users_manage WHERE int_glcode=$usr_id";
            $query = pg_query($Get_User_Reg_Id);
            $Gcm_Code = pg_fetch_array($query);

            $query_Buzzdetail = "SELECT 
                        log.int_glcode as notification_id,
                        log.var_referenceid as reference_id,
                        log.notification_type,
                        log.fk_user_id as user_id,
                        log.var_tablename as tablename,
                        bm.int_glcode as buzz_id,
                        bm.fk_user_id as user_id,
                        bm.var_title as buzz_name
                        FROM logmanager as log
                        LEFT JOIN campus_buzz as bm on log.var_referenceid = bm.int_glcode
                        where log.var_referenceid=$idname and log.var_tablename = 'campus_buzz'
                        and bm.chr_delete='N' and log.notification_type != ''";

            $Result_Buzz = pg_query($query_Buzzdetail);
            $Data_Array1 = pg_fetch_array($Result_Buzz);

//                    $Gcm_Code['gcm_code']

            $gcmRegIds = array($Gcm_Code['gcm_code']);
            $Device_ios_RegIds = $Gcm_Code['device_id'];

            $message = array(
                "notification_id" => $Data_Array1['notification_id'],
                "notification_type" => $Data_Array1['notification_type'],
                "name" => $Data_Array1['buzz_name'],
                "id" => $Data_Array1['buzz_id'],
                "thread_id" => "0",
                "user_id" => $Data_Array1['user_id'],
                "message" => "Your buzz '" . $Data_Array1['buzz_name'] . "' has been blocked.",
                "badge" => $logcnt
            );


            if (!empty($gcmRegIds)) {
                $this->sendMessageThroughGCM($gcmRegIds, $message);
            }

            if (!empty($Device_ios_RegIds)) {
                $this->sendMessageThroughGCM_ios($Device_ios_RegIds, $message);
            }
        }
    }

    function sendMessageThroughGCM($registatoin_ids, $message) {

        //Google cloud messaging GCM-API url
        $url = 'https://android.googleapis.com/gcm/send';
        $fields = array(
            'data' => $message,
            'registration_ids' => $registatoin_ids
        );
//        echo json_encode($fields);
//        die;
//        print "<pre/>";
//        print_r($fields);
//        die;
        // Update your Google Cloud Messaging API Key

        $headers = array(
            'Authorization: key=' . GOOGLE_API_KEY,
            'Content-Type: application/json'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }
        curl_close($ch);

//        location.reload(); 
        return $result;
    }

    function sendMessageThroughGCM_ios($registatoin_ids, $message) {

        $deviceToken = $registatoin_ids;
        $body['aps'] = array(
            'alert' => $message['message'],
            'notification_id' => $message['notification_id'],
            "notification_type" => $message['notification_type'],
            "name" => $message['name'],
            "id" => $message['id'],
            "thread_id" => $message['thread_id'],
            "user_id" => $message['user_id'],
            "badge" => $message['badge']
        );
        $ctx = stream_context_create();
        
//***************************** Development Start ***********************************
//        stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
//        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
//        $fp = stream_socket_client(
//                'ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
//***************************** Development End ***********************************
        
//***************************** Production Start ***********************************
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'pushcert.pem');
        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
        $fp = stream_socket_client(
                'ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
        
//******************* Production End *************************
        
        $payload = json_encode($body);
        $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
        $result = fwrite($fp, $msg, strlen($msg));
        fclose($fp);
    }

    function Signle_delete($recordid) {
        $query1 = "update campus_buzz set chr_delete='Y' where int_glcode='" . $recordid . "'";
        $res = $this->db->query($query1);
        echo ($res) ? "1" : "0";
        exit;
    }
    
      function count_notification($user_id) {
        $query_postdetail = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.dt_createdate as create_date,
                            pm.int_glcode as id,
                            pm.fk_user_id as user_id,
                            pm.var_postname as name,
                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,
                            (SELECT pg.int_glcode FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id
                            FROM logmanager as log
                            LEFT JOIN post_management as pm on log.var_referenceid = pm.int_glcode
                            LEFT JOIN post_category as pc on pm.fk_post_cate = pc.int_glcode
                            LEFT JOIN university_management as uni on pm.fk_university = uni.int_glcode
                            where log.fk_user_id=$user_id and log.var_tablename = 'post_management'
                            and pm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
        $Result_post = $query_postdetail->result_array();
        $cnt_post = count($Result_post);

        $query_Buzzdetail = $this->db->query("SELECT 
                        log.int_glcode as notification_id,
                        log.var_referenceid as reference_id,
                        log.notification_type,
                        log.dt_createdate as create_date,
                        bm.int_glcode as id,
                        bm.fk_user_id as user_id,
                        bm.var_title as name,
                        (SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image,
                        (SELECT cbg.int_glcode FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image_id
                        FROM logmanager as log
                        LEFT JOIN campus_buzz as bm on log.var_referenceid = bm.int_glcode
                        LEFT JOIN university_management as uni on bm.fk_university = uni.int_glcode
                        where log.fk_user_id=$user_id and log.var_tablename = 'campus_buzz'
                        and bm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
        $Result_Buzz = $query_Buzzdetail->result_array();
        $cnt_buzz = count($Result_Buzz);

        $query_message = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.dt_createdate as create_date,
                            msg.fk_post as post_id,
                            msg.int_glcode as message_id,
                            mt.post_name as post_name,
                            msg.fk_user_id as user_id,
                            msg.fk_thread as thread_id,
                            msg.var_user_name as user_name,
                            mt.fk_post as mt_post_id,
                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
                            FROM logmanager as log
                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
                            LEFT JOIN message_thread as mt on msg.fk_thread = mt.int_glcode                            
                            where  msg.fk_post = mt.fk_post and msg.fk_user_id != $user_id and log.var_tablename = 'message_list'
                            and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
//                echo $this->db->last_query();  die;
        $Result_message = $query_message->result_array();
        $cnt_message = count($Result_message);

        if (!empty($Result_post) || !empty($Result_Buzz) || !empty($Result_message)) {
            $sum = $cnt_post + $cnt_buzz + $cnt_message;
//            echo $sum; die;
            return $sum;
        }
    }

}

?>
