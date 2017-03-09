<?php

class job_management_model extends CI_Model {

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
    var $orderby = 'var_jobname'; // Attribute of Deafult Order By
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

        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&hfilterby=' . $this->filterby . '&history=T' . '&categoryid=' . $this->categoryid;
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid;
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid;
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid;
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid;
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&categoryid=' . $this->categoryid;
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal . '&categoryid=' . $this->categoryid;
        $this->addurlwithpara = $this->addpagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid;
        $this->fronturlwithpara = $this->pagename . '&' . 'pagesize=' . urlencode($this->pagesize) . '&numofrows=' . $this->numofrows . '&categoryid=' . urlencode($this->categoryid) . $Ftr_cat;
        if ($flag == 'Y') {
            return $this;
        }
    }

    function generateParam($position = 'top') {
        if ($position == 'top') {
//            $combo = $this->search_categorycombo();
        }
        return array('pageurl' => MODULE_PAGE_NAME,
            'heading' => 'Manage Jobs',
//            'listImage' => 'add-new-user-icon.png',
            'tablename' => DB_PREFIX . 'job_management',
            'position' => $position,
            'actionImage' => 'Add Job',
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
            'search' => array('searchArray' => array("var_jobname" => "Title"),
                'searchBy' => $this->searchby,
                'searchText' => $this->searchtxt,
                'searchUrl' => $this->urlwithpoutsearch
            ),
            'sccombo' => $combo
        );
    }

    function selectAll() {

        $this->initialize();
        $this->Generateurl();
        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_jobname like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }
//        if ($this->categoryid != '' && $this->categoryid != '0') {
//
//            $whereclauseids .=" and p.fk_category = '" . $this->categoryid . "'";
//        }

        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by var_jobname desc';
                $searchbyVal = " like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_delete = 'N'";
//                echo $searchbyVal; die;
                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_jobname";
                }
               $autoSearchQry = $this->db->query("select {$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "job_management where {$this->searchbyVal} $searchbyVal  GROUP BY var_jobname $orderby");
               $this->mylibrary->GetAutoSearch($autoSearchQry);
            }
        }
        $limitby = 'OFFSET ' . $this->start . ' LIMIT ' . $this->pagesize;
        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;
        $query = $this->db->query("select * ,(SELECT count(1)as totalpages FROM " . DB_PREFIX . "job_management)as totalpages from " . DB_PREFIX . "job_management where chr_delete = 'N' $whereclauseids  $orderby $limitby");
        return $query;
  
    }

    function CountRows() {

        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_jobname like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
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
       
        $sqlCountPages = "select * FROM " . DB_PREFIX . "job_management  where chr_delete='N' $whereclauseids";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }

    function select_Rows($id) {

        $query = $this->db->get_where('job_management', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    public function insert() {
        
//        print "<pre/>";
//        print_r($_REQUEST);
//        die;


        $data = array(
        'var_jobname' => $this->input->post('var_jobname', true),
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
//        echo '<pre>';print_r($data);exit;
        $this->db->insert('job_management', $data);
        $id =  $this->db->insert_id();
    // $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'job_management', 'var_title', $id, 'I', 'int_glcode');
        return $id;
    }

    function update() {
        
        $data = array(
            'var_jobname' => $this->input->post('var_jobname', true),
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
        $this->db->update('job_management', $data);
        
//        $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'job_management', 'var_title', $this->input->get_post('ehintglcode'), 'U', 'int_glcode');
//        $where = " and fk_category='" . $this->input->post('fk_category') . "'";
//        $this->mylibrary->set_display_order_sequence(DB_PREFIX . 'job_management', $where);


    }

     function University_Combo($selectID = '') {

        $sql_property = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $data = $this->db->query($sql_property);
        
        $display = "";
        $otherString = 'id="fk_university" class="form-control"';
        $selected_ids=Array();
        array_push($selected_ids, $selectID); 
        $options=Array();
        $options['']='-- Select University --';
        foreach ($data->result() as $row) {
            $options[$row->int_glcode]=ucwords($row->var_name);            
        }
        $moduleSelectBox = array('name'         => 'fk_university',
                                 'options'      => $options,
                                 'selected_ids' => $selected_ids,
                                 'otherString'  => $otherString,
                                 'tdoption'     => Array('TDDisplay'=>'Y','width'=>'30%'),
                                  'onchange' =>   'displayDomainInfo(this.value)'
                                   );
        $display=form_input_ready($moduleSelectBox,'select');
        return $display.="";
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

    function updatedisplayorder() {
//        $this->db->cache_set_common_path("application/cache/db/common/special/");
        $this->db->cache_delete();
        $uids = $this->input->get_post('uid');
        $neworder = $this->input->get_post('neworder');
        $oldorder = $this->input->get_post('oldorder');

        $fk_type1 = $this->input->get_post('fk_category');

        if ($fk_type1 != '') {

            $where = " and fk_category='" . $this->input->post('fk_category') . "'";
        } else {

            $where = '';
        }
        $this->mylibrary->update_display_order1($uids, $neworder, $oldorder, '', 'job_management', $where);
        $tablename = DB_PREFIX . 'job_management';
        $this->mylibrary->set_display_order_sequence($tablename, $where);
    }

    function delete_row() {
        $tablename = DB_PREFIX . 'job_management';
        $deleteids = $this->input->get_post('dids');
        $deletearray = explode(',', $deleteids);
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {
            $data = array('chr_delete' => 'Y', 'dt_modifydate' => date('Y-m-d'), 'var_ipaddress' => $_SERVER['REMOTE_ADDR'], 'var_adminuser' => ADMIN_NAME);
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);
//            $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'job_management', 'var_title', $deletearray[$i], 'D', 'int_glcode');
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

}

?>
