<?php

class campus_buzz_gallery_model extends CI_Model {

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

//        echo $this->input->get_post('post_id'); die;
//        print_r($_REQUEST);
//        die;
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
        $cid = $this->input->get_post('cid');

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
//        $this->cid = (!empty($cid)) ? $cid : $this->cid;

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
//     print_r($_REQUEST); 
//        die;
        if ($flag == 'Y') {
            
        } else {

            $this->pagename = MODULE_PAGE_NAME . '?';
        }

        if ($this->input->get_post('categoryid') == 'Y') {
            $Ftr_cat = "&categoryid=" . $this->input->get_post('categoryid');
        } else {
            $Ftr_cat = "";
        }
        $this->addpagename = MODULE_PAGE_NAME . '/add?cid=' . $this->input->get_post('cid');

        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&hfilterby=' . $this->filterby . '&history=T' . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->addurlwithpara = $this->addpagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&categoryid=' . $this->categoryid . '&cid=' . $this->input->get_post('cid');
        $this->fronturlwithpara = $this->pagename . '&' . 'pagesize=' . urlencode($this->pagesize) . '&numofrows=' . $this->numofrows . '&categoryid=' . urlencode($this->categoryid) . $Ftr_cat . '&cid=' . $this->input->get_post('cid');
        if ($flag == 'Y') {
            return $this;
        }
    }

    function generateParam($position = 'top') {
        if ($position == 'top') {
//            $combo = $this->search_categorycombo();
        }

        return array('pageurl' => MODULE_PAGE_NAME . '?cid=' . $this->input->get_post('cid'),
            'heading' => 'Manage Buzz Gallery',
//            'listImage' => 'add-new-user-icon.png',
            'tablename' => 'campus_buzz_gallery',
            'position' => $position,
            'actionImage' => 'Add New Image',
//            'actionImageHover' => 'add-new-button-blue-hover.gif',
            'actionUrl' => MODULE_PAGE_NAME . '/add?cid=' . $this->input->get_post('cid'),
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
            'sccombo' => $combo
        );
    }

    function selectAll() {

        $this->initialize();
        $this->Generateurl();
        $whereclauseids = '';

        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_title like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }

        $cids = $this->input->get_post('cid');
        if ($cids != '') {
            $whereclauseids .=" and fk_campus_buzz = '" . $cids . "'";
        }
        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by var_title desc';
                $searchbyVal = " like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_delete = 'N'";
//                echo $searchbyVal; die;
                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_title";
                }
                $autoSearchQry = $this->db->query("select {$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "campus_buzz_gallery where {$this->searchbyVal} $searchbyVal  GROUP BY var_title $orderby");
                $this->mylibrary->GetAutoSearch($autoSearchQry);
            }
        }
        $limitby = 'OFFSET ' . $this->start . ' LIMIT ' . $this->pagesize;
        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;
        $query = $this->db->query("select * ,(SELECT count(1)as totalpages FROM " . DB_PREFIX . "campus_buzz_gallery)as totalpages from " . DB_PREFIX . "campus_buzz_gallery where chr_delete = 'N' $whereclauseids  $orderby $limitby");
        return $query;
    }

    function CountRows() {
        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_title like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
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
        $cids = $this->input->get_post('cid');
        if ($cids != '') {
            $whereclauseids .=" and fk_campus_buzz = '" . $cids . "'";
        }
        $sqlCountPages = "select * FROM " . DB_PREFIX . "campus_buzz_gallery  where chr_delete='N' $whereclauseids";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }

    function select_Rows($id) {
        $query = $this->db->get_where('campus_buzz_gallery', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    public function insert() {

        $idss = $this->input->post('cid', true);

        if ($_FILES['var_image']['name'] != '') {
            $photo = basename($_FILES['var_image']['name']);
            $photo = str_replace('&', "_", $photo);
            $photo = str_replace(' ', "_", $photo);
            $photofile = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $photo);
            $phototitle = explode('.', $photofile);
            $_FILES['Filedata']['name'] = $photofile;
            $maindir = 'upimages/campus_buzz_gallery/images/';
            $thumbdir = 'upimages/campus_buzz_gallery/thumb/';
            $var_main_file = $this->mylibrary->generate_image('var_image', $maindir, $idss);
            $file_photo = basename($var_main_file);
            $uploadedfile = $maindir . $file_photo;

            $this->UNIVERSITY_WIDTH = UNIVERSITY_WIDTH;
            $this->UNIVERSITY_HEIGHT = UNIVERSITY_HEIGHT;
            image_thumb($maindir . $var_main_file, $this->UNIVERSITY_WIDTH, $this->UNIVERSITY_HEIGHT);

            $var_thumb = $var_main_file;
        }
//        print_r($_FILES['var_image']['name']); die;
//           $temp = explode(".", $_FILES["var_image"]["name"]);
//           $temp[0] = rand(1, 4); //Set to random number
//           $fileName = $temp[0].".".$temp[1];
        $data = array(
            'var_title' => $this->input->post('var_title', true),
            'fk_campus_buzz' => $this->input->post('cid', true),
            'fk_user_id' => '0',
            'var_image' => $var_thumb,
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => $this->input->post('chr_publish'),
            'chr_delete' => 'N'
        );
//        echo '<pre>';print_r($data);exit;
        $this->db->insert('campus_buzz_gallery', $data);
        $id = $this->db->insert_id();
//        ECHO $id; DIE;
        // $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'campus_buzz_gallery', 'var_title', $id, 'I', 'int_glcode');
        return $id;
    }

    function update() {

        $idss = $this->input->post('cid', true);
        if ($_FILES['var_image']['name'] != '') {
            $photo = basename($_FILES['var_image']['name']);
            $photo = str_replace('&', "_", $photo);
            $photo = str_replace(' ', "_", $photo);
            $photofile = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $photo);

            $phototitle = explode('.', $photofile);
            $_FILES['Filedata']['name'] = $photofile;

            $maindir = 'upimages/campus_buzz_gallery/images/';

            $thumbdir = 'upimages/campus_buzz_gallery/thumb/';
            $var_main_file = $this->mylibrary->generate_image('var_image', $maindir, $idss);
            $file_photo = basename($var_main_file);
            $uploadedfile = $maindir . $file_photo;

            $this->UNIVERSITY_WIDTH = UNIVERSITY_WIDTH;
            $this->UNIVERSITY_HEIGHT = UNIVERSITY_HEIGHT;
            image_thumb($maindir . $var_main_file, $this->UNIVERSITY_WIDTH, $this->UNIVERSITY_HEIGHT);

            $var_thumb = $var_main_file;
        }

        if ($var_thumb == '') {
            $var_thumb = $this->input->get_post('hidvar_image');
        }
        $data = array(
            'var_title' => $this->input->post('var_title', true),
            'fk_campus_buzz' => $this->input->post('cid', true),
            'var_image' => $var_thumb,
            'dt_modifydate' => date('Y-m-d H:i:s', time()),
            'chr_publish' => $this->input->post('chr_publish'),
            'chr_delete' => 'N'
        );
        $this->db->where('int_glcode', $this->input->get_post('ehintglcode'));
        $this->db->update('campus_buzz_gallery', $data);
    }

    function University_Combo($selectID = '') {

        $sql_property = "select * from " . DB_PREFIX . "university_management WHERE chr_delete='N' order by var_name asc ";
        $data = $this->db->query($sql_property);

        $display = "";
        $otherString = 'id="fk_university" class="form-control"';
        $selected_ids = Array();
        array_push($selected_ids, $selectID);
        $options = Array();
        $options[''] = '-- Select Group --';
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
        $this->mylibrary->update_display_order1($uids, $neworder, $oldorder, '', 'campus_buzz_gallery', $where);
        $tablename = DB_PREFIX . 'campus_buzz_gallery';
        $this->mylibrary->set_display_order_sequence($tablename, $where);
    }

    function delete_row() {


        $tablename = DB_PREFIX . 'campus_buzz_gallery';
        $deleteids = $this->input->get_post('dids');
        $cids = $this->input->get_post('cid');
        $deletearray = explode(',', $deleteids);
//        print_r($deletearray);die;
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {
            $data = array('chr_delete' => 'Y', 'fk_campus_buzz' => $cids);
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);
//            $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'campus_buzz_gallery', 'var_title', $deletearray[$i], 'D', 'int_glcode');
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
    
      function count_photo($pids) {
        $sql = "select * from campus_buzz_gallery where chr_delete = 'N' and fk_campus_buzz= $pids";
        $records = $this->db->query($sql);
        $rscnt = $records->num_rows();
        return $rscnt;
    }


}

?>
