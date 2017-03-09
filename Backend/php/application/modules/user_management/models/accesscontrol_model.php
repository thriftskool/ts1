<?php

class Accesscontrol_model extends CI_Model {

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
    var $orderby = 'var_username'; // Attribute of Deafult Order By
    var $ordertype = 'asc'; // Attribute of Deafult Order By
    var $searchby = '0'; // Attribute of Search By
    var $searchtxt; // Attribute of Search Text
    var $start = 1; // Attribute of Start For Paging
    var $pagesize = DEFAULT_PAGESIZE; // Attribute of Pagesize For Paging
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
        $fk_university = $this->input->get_post('fk_university');
        $chr_publishcmb = $this->input->get_post('chr_publishcmb');

        $create_date = $this->input->get_post('create_date');

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
        $this->chr_publishcmb = (!empty($chr_publishcmb)) ? $chr_publishcmb : $this->chr_publishcmb;
        $this->create_date = (!empty($create_date)) ? $create_date : $this->create_date;

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

        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&hfilterby=' . $this->filterby . '&history=T' . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&create_date=' . $this->create_date;
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->addurlwithpara = $this->addpagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&fk_university=' . $this->fk_university . '&chr_publishcmb=' . $this->chr_publishcmb . '&create_date=' . $this->create_date;
        $this->fronturlwithpara = $this->pagename . '&' . 'pagesize=' . urlencode($this->pagesize) . '&numofrows=' . $this->numofrows . '&fk_university=' . urlencode($this->fk_university) . $Ftr_cat . '&create_date=' . $this->create_date;
        if ($flag == 'Y') {
            return $this;
        }
    }

    function generateParam($position = 'top') {
        if ($position == 'top') {
            $combo = $this->search_university_combo();
            $publish_combo = $this->Get_Publish_combo();
            $select_date = $this->select_datepicker();
        }
        return array('pageurl' => MODULE_PAGE_NAME,
            'heading' => 'Manage Users',
//            'listImage' => 'add-new-user-icon.png',
            'tablename' => DB_PREFIX . 'users_manage',
            'position' => $position,
            'actionImage' => 'Add User',
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
            'search' => array('searchArray' => array("var_username" => "Title"),
                'searchBy' => $this->searchby,
                'searchText' => $this->searchtxt,
                'searchUrl' => $this->urlwithpoutsearch
            ),
            'sccombo' => $combo,
            'pubcombo' => $publish_combo,
            'select_date' => $select_date
        );        
    }
    
    function select($id) {

        $query = $this->db->get_where('users_manage', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    function select_datepicker() {

        $sel = "<input placeholder=\"Registration Date\"  class='more-textarea fl' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_create_date');\"   style=\"width: 15% !important\" name=\"create_date\"  id=\"create_date\" value='" . $this->create_date . "'>";
        return $sel;
    }

    function University_Combo($selectID = '') {
        $sql_property = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $data = $this->db->query($sql_property);
        $display = "";
        $otherString = ' onchange="displayUserInfo(this.value);" id="fk_university" class="form-control"';
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
    function University_Combo1($selectID = '') {
        $sql_property = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $data = $this->db->query($sql_property);
        $display = "";
//        $otherString = ' onchange="displayUserInfo(this.value);" id="fk_university" class="form-control"';
        $selected_ids = Array();
        array_push($selected_ids, $selectID);
        $options = Array();
        $options['0'] = 'All';
        foreach ($data->result() as $row) {
            $options[$row->int_glcode] = ucwords($row->var_name);
        }
        $display = form_multiselect('universitylist[]',$options,'class="universitylist"');
        return $display.="";
    }

    function search_university_combo() {

        $query = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $res = $this->db->query($query);
        $sel = "<select id='fk_university' class='more-textarea fl' name='fk_university' style='float:left;' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_university');\">";
        $sel .= "<option value=''>--Select University--</option>";
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

    function Get_Publish_combo() {

//         $query = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
//        $res = $this->db->query($query);
        $sel = "<select id='chr_publishcmb' class='more-textarea fl' name='chr_publishcmb' style='float:left;' onchange=\"SendGridBindRequest('" . $this->urlwithpara . "&pagenumber=1','gridbody','search_publishcmb');\">";
        $sel .= "<option value=''>-- Select Publish --</option>";
        if ($this->chr_publishcmb == 'Y') {
            $selected = "selected";
        } else {
            $selected = '';
        }
        if ($this->chr_publishcmb == 'N') {
            $selected1 = "selected";
        } else {
            $selected1 = '';
        }
        $sel.='<option value="Y" ' . $selected . '>Publish</option>';
        $sel.='<option value="N" ' . $selected1 . '>Un - Publish</option>';
//        foreach ($res->result() as $row) {
//            if ($row->int_glcode == $this->fk_university) {
//                $selected = "selected";
//            } else {
//                $selected = '';
//            }
//            $sel.='<option value="' . $row->int_glcode . '" ' . $selected . '>' . $row->var_name . '</option>';
//        }
        $sel .="</select>";
        return $sel;
    }

    function selectAll() {

        $this->initialize();
        $this->Generateurl();
        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and um.var_username ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }
        if ($this->create_date != '') {
            $originalDate1 = $this->create_date;
            $newDate = date("Y-m-d", strtotime($originalDate1));
            $whereclauseids .= "and date(um.dt_createdate)='" . $newDate . "'";
        }
        if ($this->fk_university != '' && $this->fk_university != '0') {

            $whereclauseids .=" and um.fk_university = '" . $this->fk_university . "'";
        }
        if ($this->chr_publishcmb != '' && $this->chr_publishcmb != '0') {

            $whereclauseids .=" and um.chr_publish = '" . $this->chr_publishcmb . "'";
        }

        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by var_username desc';
                $searchbyVal = " ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_delete = 'N'";
                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_username";
                }
//               $autoSearchQry = "select {$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "Accesscontrol where {$this->searchbyVal} $searchbyVal  GROUP BY var_name $orderby";
                $autoSearchQry = $this->db->query("select {$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "users_manage where {$this->searchbyVal} $searchbyVal  GROUP BY var_username $orderby");
//                echo $this->db->last_query(); die;
                $this->mylibrary->GetAutoSearch($autoSearchQry);
//                     echo $this->db->last_query(); die;
            }
        }

        $limitby = 'OFFSET ' . $this->start . ' LIMIT ' . $this->pagesize;

        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;

        $query1 = "SELECT um.*,uni.var_name as university_name from users_manage as um
                LEFT JOIN university_management as uni on um.fk_university = uni.int_glcode where um.chr_delete='N' $whereclauseids $orderby  $limitby";

        $query = $this->db->query($query1);
//          $query = $this->db->query("select * ,(SELECT count(1)as totalpages FROM " . DB_PREFIX . "users_manage)as totalpages from " . DB_PREFIX . "users_manage where chr_delete = 'N' $whereclauseids  $orderby $limitby");
        return $query;
    }

    function CountRows() {

        $whereclauseids = '';

        if ($this->fk_university != '' && $this->fk_university != '0') {

            $whereclauseids .=" and fk_university = '" . $this->fk_university . "'";
        }
        if ($this->chr_publishcmb != '' && $this->chr_publishcmb != '0') {

            $whereclauseids .=" and chr_publish = '" . $this->chr_publishcmb . "'";
        }
        if ($this->create_date != '') {
            $originalDate1 = $this->create_date;
            $newDate = date("Y-m-d", strtotime($originalDate1));
            $whereclauseids .= "and date(dt_createdate)='" . $newDate . "'";
        }
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_username ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby ILIKE '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }
        $sqlCountPages = "select * FROM " . DB_PREFIX . "users_manage  where chr_delete='N' $whereclauseids";
        $query = $this->db->query($sqlCountPages);
//        ECHO $this->db->last_query(); 
        $rs = $query->num_rows();
        return $rs;
    }

    function select_Rows($id) {

        $query = $this->db->get_where('users_manage', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    public function insert() {

//        print_r($_REQUEST); 
//        die;
        $email = $this->input->post('var_emailid');
        $domain = $this->input->post('var_hidemail');

        $var_emailid = $email . '@' . $domain;

        $data = array(
            'fk_university' => $this->input->post('fk_university', TRUE),
            'var_emailid' => $var_emailid,
            'var_password' => $this->mylibrary->cryptPass($this->input->post('var_password', TRUE)),
            'var_username' => htmlspecialchars($this->input->post('var_username', TRUE)),
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => 'Y',
            'chr_delete' => 'N',
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );
//        echo '<pre>';print_r($data);exit;
        $this->db->insert('users_manage', $data);
        $id = $this->db->insert_id();
        // $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'Accesscontrol', 'var_title', $id, 'I', 'int_glcode');
        return $id;
    }

    function update() {

        $email = $this->input->post('var_emailid');
        $domain = $this->input->post('var_hidemail');

        $domainss = strstr($domain, '@');

        if (!empty($domainss)) {
            $var_emailid = $email . $domain;
        } else {
            $var_emailid = $email . '@' . $domain;
        }
//      $test =  str_replace("@","@",$domain);  
//      echo $var_emailid; die;


        $data = array(
            'fk_university' => $this->input->post('fk_university', TRUE),
            'var_emailid' => $var_emailid,
            'var_username' => htmlspecialchars($this->input->post('var_username', TRUE)),
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => $this->input->post('chr_publish'),
            'chr_delete' => 'N',
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );
//        echo '<pre>';print_r($data);exit;

        $password = $this->input->post('var_password');

        if (!empty($password)) {
            $data['var_password'] = $this->mylibrary->cryptPass($password);
        }

        $this->db->where('int_glcode', $this->input->get_post('ehintglcode'));
        $this->db->update('users_manage', $data);

//        $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'Accesscontrol', 'var_title', $this->input->get_post('ehintglcode'), 'U', 'int_glcode');
//        $where = " and fk_category='" . $this->input->post('fk_category') . "'";
//        $this->mylibrary->set_display_order_sequence(DB_PREFIX . 'Accesscontrol', $where);
    }

    function updatedisplay() {

        $tablename = $this->input->get_post('tablename');
        $fieldname = $this->input->get_post('fieldname');
        $value = $this->input->get_post('value');
        $idname = $this->input->get_post('id');

        $updateSql = "UPDATE {$tablename} SET {$fieldname}='{$value}' WHERE  int_glcode in ({$idname}) ";
        $res = $this->db->query($updateSql);
//        echo $this->db->last_query(); die;
//        $res = mysql_query($updateSql) or die(mysql_error());
        echo ($res) ? "1" : "0";
        exit;
    }

    function delete_row() {
        $tablename = DB_PREFIX . 'users_manage';
        $deleteids = $this->input->get_post('dids');
        $deletearray = explode(',', $deleteids);
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {
            $data = array('chr_delete' => 'Y', 'dt_modifydate' => date('Y-m-d'), 'var_ipaddress' => $_SERVER['REMOTE_ADDR'], 'var_adminuser' => ADMIN_NAME);
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);
//            $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'Accesscontrol', 'var_title', $deletearray[$i], 'D', 'int_glcode');
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

    function initialize_front() {
        $this->setrefinesearchdata();
        $this->link = $this->common_model->getUrl('pages', 2, 42);
        $this->pagesize = ($this->input->get_post('size')) ? $this->input->get_post('size') : $this->front_page_size;
        $this->numrowsfront = $this->CountRow_front();
        $this->pagesizefront = (!empty($pagesize)) ? $pagesize : $this->front_page_size;
        $this->noofpages = intval($this->numrowsfront / $this->front_page_size);
        $this->noofpages = (($this->numrowsfront % $this->front_page_size) > 0) ? ($this->noofpages + 1) : ($this->noofpages);
        $this->pagenumber = $this->input->post('page') ? $this->input->post('page') : 1;
        $this->start = ($this->pagenumber - 1) * $this->front_page_size;
        return $this;
    }

    function setrefinesearchdata() {
        $curr_url = $_SERVER['REQUEST_URI'];
        $search_array = explode('/', $curr_url);
        foreach ($search_array as $data) {
            $para = explode('-', $data);
            $resultarr[$para[0]] = $para[1];
            $_POST[$para[0]] = $para[1];
        }
    }

    function Check_Email($user_email, $eid, $domainname) {

        $user_email = $user_email . $domainname;
        $eid = $this->input->get_post('eid');
        if (!empty($eid)) {
            $this->db->where_not_in('int_glcode', $eid);
        }
        $this->db->where('var_emailid', $user_email);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');

        if ($query->num_rows() > 0) {
            return true;
        } else {
            return false;
        }
    }

    function Check_user_Name($user_name, $eid) {


        $eid = $this->input->get_post('eid');
        if (!empty($eid)) {
            $this->db->where_not_in('int_glcode', $eid);
        }
        $this->db->where('var_username', $user_name);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');

        if ($query->num_rows() > 0) {
            return true;
        } else {
            return false;
        }
    }

    function selectUniversityInfo($id) {
        $sel = "SELECT var_domain FROM " . DB_PREFIX . "university_management WHERE chr_delete='N' and int_glcode='" . $id . "'";
        $row = $this->db->query($sel);
        $res = $row->row_array();
        return $res['var_domain'];
    }

}

?>
