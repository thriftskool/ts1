<?php

class pages_model extends CI_Model {

    var $int_glcode;
    var $fk_pages;
    var $var_pagename;
    var $var_alias;
    var $text_fulltext;
    var $var_metatitle;
    var $var_metakeyword;
    var $var_metadescription;
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
    var $orderby = 'int_displayorder'; // Attribute of Deafult Order By
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
    var $sortvar;

    public function __construct() {
        $this->load->database();
        $this->load->library('mylibrary');
        $mylibraryObj = new mylibrary;
    }

    function general() {
        $data['base'] = $this->config->item('base_url');
        $data['css'] = $this->config->item('css');
        $data['img'] = $this->config->item('images');
        return $data;
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

        if (!empty($term)) {
            $searchtxt = ($type == 'autosearch') ? $term : $searchtxt;
        }

        $this->searchbyVal = (!empty($searchbyVal)) ? $searchbyVal : $this->searchbyVal;
        $this->searchby = (!empty($searchby)) ? urldecode($searchby) : '';
        $this->searchtxt = (!empty($searchtxt)) ? urldecode($searchtxt) : '';
        $this->searchtxt = htmlspecialchars($this->searchtxt);
        $this->orderby = (!empty($orderby)) ? $orderby : $this->orderby;
        $this->ordertype = (!empty($ordertype)) ? $ordertype : $this->ordertype;
        $this->filterby = (!empty($filterby)) ? $filterby : $this->filterby;

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
           $this->numofrows = $this->CountRow_front($flag);
            $this->pagesize = (!empty($pagesize)) ? $pagesize : 6;
            $this->pagenumber = (!empty($pagenumber)) ? $pagenumber : $this->pagenumber;
            $this->noofpages = intval($this->numofrows / $this->pagesize);
            $this->noofpages = (($this->numofrows % $this->pagesize) > 0) ? ($this->noofpages + 1) : ($this->noofpages);
            $this->start = ($this->pagenumber - 1 ) * $this->pagesize;
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
        $this->addpagename = MODULE_PAGE_NAME . '/add?';
        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&hfilterby=' . $this->filterby . '&history=T';
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby;
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby;
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby;
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby;
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt;
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal;
        $this->addurlwithpara = $this->addpagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby .  '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby;
        if ($flag == 'Y') {

                  return $this;
              }
        }

    function generateParam($position = 'top') {


        return array('pageurl' => MODULE_PAGE_NAME,
            'heading' => 'Manage Pages',
            'listImage' => 'add-new-user-icon.png',
            'tablename' => DB_PREFIX . 'pages',
            'position' => $position,
            'actionImage' => 'add-new-button-blue.gif',
            'actionImageHover' => 'add-new-button-blue-hover.gif',
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
            'search' => array('searchArray' => array("var_pagename" => "Title"),
                'searchBy' => $this->searchby,
                'searchText' => $this->searchtxt,
                'searchUrl' => $this->urlwithpoutsearch
            ),
        );
    }

  
    function updatedisplayorder() {

       
        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_delete();
        $uids = $this->input->get_post('uid');
        $neworder = $this->input->get_post('neworder');
        $oldorder = $this->input->get_post('oldorder');
        $fkpages = $this->input->get_post('fkpages'); 
        if(empty($fkpages)){$fkpages = 0;}
      
        
        $this->mylibrary->update_display_order1($uids, $neworder, $oldorder, '', 'pages'," AND fk_pages='".$fkpages."'"); 

        $tablename = DB_PREFIX . 'pages';
      $this->mylibrary->set_display_order_sequence($tablename," AND fk_pages='".$fkpages."'");  
    }
    
    function update_display_order_parentwise($ids, $values, $oldvalues, $parenids) {
        $tablename = DB_PREFIX . "pages";
       
        for ($i = 0; $i < count($ids); $i++) {
           if ($values[$i] != $oldvalues[$i]) {
                $query = $this->db->query("SELECT count(1) as total FROM " . $tablename . " WHERE int_displayorder=" . $values[$i] . " and chr_delete = 'N' and fk_pages='" . $parenids[$i] . "'  and chr_previewstatus='N'");
                $rs = $query->row();
                
                if ($rs->total > 0) {
                    if ($values[$i] > $oldvalues[$i]) {
                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder - 1 WHERE int_displayorder > " . $oldvalues[$i] . " and  int_displayorder <= " . $values[$i] . " and fk_pages = '".$parenids[$i]."'  and chr_delete = 'N'";
                        $this->db->query($updateSql);
                    } else {
                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder + 1 WHERE int_displayorder >= " . $values[$i] . " and  int_displayorder < " . $oldvalues[$i] . " and fk_pages = '".$parenids[$i]."' and chr_delete = 'N'";
                        $this->db->query($updateSql);
                    }
                }
                $updateSql = "UPDATE $tablename SET int_displayorder=$values[$i] WHERE int_glcode=" . $ids[$i] . " and chr_delete = 'N' and fk_pages='".$parenids[$i]."'";
                $this->db->query($updateSql);
            }
        }
    }

    
    function selectAll() {
        $this->initialize();
        $this->Generateurl();
        $whereclauseids = '';

        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_pagename like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }

        if ($this->searchcategoryname != '') {
            $whereclauseids .="and var_teamcategory='" . $this->searchcategoryname . "'";
        }
        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by int_displayorder asc';
                $searchbyVal = " like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_delete = 'N'";
                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_pagename";
                }
                if ($this->searchcategoryname != '') {
                    $whereclauseids .="and var_teamcategory='" . $this->searchcategoryname . "'";
                }
                if ($_REQUEST['fk_teamcategory']) {
                    $fkdivecategory = "and var_teamcategory in(" . $_REQUEST['fk_teamcategory'] . ")";
                } else {
                    $fkdivecategory = '';
                }
                 if ($this->session->userdata('userid') != 1) {
                     $whereclause .= " and int_glcode NOT IN(31,53,51)";
                }
             
                $autoSearchQry = "select *,{$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "pages where {$this->searchbyVal} $searchbyVal $whereclause $fkdivecategory $whereclauseids group by var_pagename $orderby";
                $this->mylibrary->GetAutoSearch($autoSearchQry);
            }
        }
        $pages = array();
        $sqlgetinds = "select int_glcode,fk_pages FROM " . DB_PREFIX . "pages where chr_delete='N' $whereclauseids ";
        $rsmatchedpagesids =  mysql_query($sqlgetinds);
        while ($row = mysql_fetch_array($rsmatchedpagesids)) {
                $pages[] = $row['int_glcode'];
                $pages[] = $row['fk_pages'];
                $i=0;
                if($row['fk_pages'] != '0') {
                    $sqlquery = "select int_glcode,fk_pages FROM " . DB_PREFIX . "pages where chr_delete='N'  and int_glcode='" . $row['fk_pages'] . "'";
                    $query=mysql_query($sqlquery);
                    $row = mysql_fetch_array($query);
                    $pages[] = $row['fk_pages'];
                
                }
            }
        $pages = array_unique($pages);
        if (count($pages) > 0) {
            $strinds = implode(',', $pages);
            $whereclause .= " and p.int_glcode in ($strinds)";
        } else {
            $whereclause .= " and p.int_glcode in (0)";
        }
        $whereCond = $whereclause;
        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;
        
        if ($this->searchcategoryname != '') {
            $whereclause .="and var_teamcategory='" . $this->searchcategoryname . "'";
        }

        if ($_REQUEST['fk_teamcategory']) {
            $fkdivecategory = "and var_teamcategory in(" . $_REQUEST['fk_teamcategory'] . ")";
        } else {
            $fkdivecategory = '';
        }
       if ($this->session->userdata('userid') != 1) {
                     $whereclause .= " and p.int_glcode NOT IN(31,53,51)";
                }


           $sqlSelectPages = "select (SELECT count(1) as idwiserecord1 FROM " . DB_PREFIX . "pages as p2 WHERE p2.fk_pages = p.int_glcode and p2.chr_delete='N')as idwiserecord
                                ,(SELECT count(1)as totalpages FROM " . DB_PREFIX . "pages as p1 WHERE p1.fk_pages = p.fk_pages)as totalpages,
                                count(distinct a.int_glcode) as TotalPage,
                                  p.int_glcode as id, 
                                  p.var_pagename as name, 
                                  p.fk_pages,p.*,
                                  m.var_modulename,
                                  m.chr_powerpanel_module 
                                  FROM " . DB_PREFIX . "pages p 
                                  left join " . DB_PREFIX . "modules m 
                                  ON p.var_pagetype = m.int_glcode 
                                  LEFT JOIN " . DB_PREFIX . "pages a on FIND_IN_SET(p.int_glcode,a.fk_pages) and a.chr_delete='N'
                                  where 1 and   
                                  p.chr_delete='N' $whereclause group by p.int_glcode $orderby";

        $rs = $this->db->query($sqlSelectPages);

        $children = array();
        $pitems = array();
        foreach ($rs->result_array() as $row) {
            $pitems[] = $row;
        }
        if ($pitems) {
            foreach ($pitems as $p) {
                $fk_dbprefix_pages = 'fk_pages';
                $pt = $p[$fk_dbprefix_pages];
                $list = @$children[$pt] ? $children[$pt] : array();
                array_push($list, $p);
                $children[$pt] = $list;
            }
        }


        $id = 0;

        $list = array();
        
        if ($id == 0) {
            
            $list = $this->treerecurse2($id, '', array(), $children, 10, 0);
        } else {
            foreach ($children as $key => $val) {
                $list = $this->treerecurse2($key, '&nbsp;&nbsp;&nbsp;', array(), $children, 10, 0);
            }
        }
        $list = array_slice($list, $this->start, $this->pagesize);
        return $list;
    }
    public function get_child($id) {

        $sqlCountPages = "select * FROM " . DB_PREFIX . "pages where chr_delete='N' and fk_pages=$id";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }
    function get_pagehitsdata() {
        $sql = "SELECT  int_pagehits ,var_pagename,int_mobhits  FROM " . DB_PREFIX . "pages where chr_delete='N' order  by int_pagehits desc limit 0,5";
        $data = $this->db->query($sql);
        return $data;
    }

    function GetTotalEntry() {
        $sql_total_entry = "SELECT * FROM " . DB_PREFIX . "pages where chr_delete='N'";
        $data_total_entry = $this->db->query($sql_total_entry);
        $rs_total_entry = $data_total_entry->num_rows();
        return $rs_total_entry;
    }
    
    function CountRows() {
        $whereclauseids = '';
        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                $whereclauseids .= (empty($this->searchby)) ? " and var_pagename like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
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
          if ($this->session->userdata('userid') != 1) {
                     $whereclause .= " and int_glcode NOT IN(31,53,51)";
                }
        $sqlCountPages = "select * FROM " . DB_PREFIX . "pages where chr_delete='N' $whereclause $whereclauseids";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }

    function select_Rows($id) {
        $returnArry = array();
        $query = "select * from " . DB_PREFIX . "pages where int_glcode=" . $id;
        $result = $this->db->query($query);
        if ($result->num_rows() > 0) {
            $returnArry = $result->row_array();
        }
        return $returnArry;
    }

    function insert() {
        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_delete();
        $DisplayOrderClause = " and fk_pages='".$this->input->post('fk_pages')."'";
        $query = $this->db->query('SELECT count(1) as total FROM ' . DB_PREFIX . 'pages WHERE chr_delete = "N" '.$DisplayOrderClause.' ');
        $rs = $query->row();
        $tot_recods = $rs->total;

        if ($tot_recods >= $this->input->post('int_displayorder')) {
            $this->mylibrary->updatedisplay_order('pages', $this->input->post('int_displayorder'),$DisplayOrderClause);
            $int_displayorder = $this->input->post('int_displayorder');
        } else {
            $int_displayorder = $tot_recods + 1;
        }
        if ($this->input->post('chr_file') == 'U') {            
            $filename = $_FILES['var_pdffile']['name'];
            $fileexntension = substr(strrchr($filename, '.'), 1);
            $var_title = str_replace('.' . $fileexntension, '', $filename);
            $filename = $var_title. $fileexntension;
            $filename = str_replace(' ', "_", $filename);
            $filename = str_replace('&', "_", $filename);
            $filename = str_replace(' ', "_", $filename);
            $filename = preg_replace('/[^a-zA-Z0-9_ \[\]\.\&-]/s', '', $filename);
            
            
            $tmp_name = $_FILES["var_pdffile"]["tmp_name"];
            $uploads_dir = 'upimages/pages';
            move_uploaded_file($tmp_name, $uploads_dir . "/" . $filename);
        } else if ($this->input->post('chr_file') == 'B') {
            $file = $this->input->post('selectedfile');
            $file = str_replace('www.dropbox.com', 'dl.dropboxusercontent.com', $file);
            $path_parts = pathinfo($file);
               
            $extension = explode('?', $path_parts['basename']);
            $des_file_photo = $this->common_model->Clean_String($extension[count($extension) - 2]);
//            $des_file_photo = trim(str_replace(range(0,9),'',str_replace('%','', $path_parts['basename']))) ;
            
            $fileexntension = substr(strrchr($des_file_photo, '.'), 1);
            $var_titles = str_replace('.' . $fileexntension, '', $des_file_photo);

            $filenamess = $var_titles ."_". time() . "." . $fileexntension;
            $newfiles = 'upimages/pages/'. $filenamess;

            $newimagethumb = $filenamess;
            
            if (copy($file, $newfiles)) {
                $files = glob("upload/*.pdf") + glob("upload/*.pdf");
                $files = array_combine($files, array_map("filemtime", $files));
                arsort($files);
                $filename = $newimagethumb;
                $latest_file = key($files);
            } else {
                echo "Upload failed.";
            }
        }

        else if ($this->input->post('chr_file') == 'E') {
            $file = $this->input->post('var_url_file');
            $path_parts = pathinfo($file);
            $des_file_photo = $path_parts['basename'];
            $des_file_photo = str_replace('&nbsp;', '-', $des_file_photo);
            $des_file_photo = str_replace(' ', '-', $des_file_photo);
            $des_file_photo = str_replace('%20', '-', $des_file_photo);
            
            $fileexntension = substr(strrchr($des_file_photo, '.'), 1);
            $var_titles = str_replace('.' . $fileexntension, '', $des_file_photo);
            $filenameexternal = $var_titles ."_". time() . "." . $fileexntension;

            $newfile = 'upimages/pages/' . $filenameexternal;
            $newimagethumb = $filenameexternal;
            
            if (copy($file, $newfile)) {
                $files = glob("upload/*.pdf") + glob("upload/*.pdf");
                $files = array_combine($files, array_map("filemtime", $files));
                arsort($files);
                
                 if($file !='')
            {
                
                $filename = $newimagethumb;
                $var_url = $this->input->post('var_url_file');
            }
            else
            {
                 $var_url = $this->input->post('var_url_file');
            }
            
            $latest_file = key($files); 
          
            
        }else{
            return true;
            //echo "Upload failed.";
        }
              
      }
      
        $fkpage = $this->input->post('fk_pages');
        $fkpage = (!empty($fkpage)) ? $fkpage : '0';
       
        $menudisplaydata = ($this->input->post('chr_menu_display') == 'Y') ? 'Y' : 'N';
     
        $footerdisplaydata = ($this->input->post('chr_footer_display') == 'Y') ? 'Y' : 'N';
        
        $contentdisplaydata = ($this->input->post('chr_displaycontent') == 'Y') ? 'Y' : 'N';
       
        $chr_image_display = ($this->input->post('chr_image_display') == 'Y') ? 'Y' : 'N';
        if($this->session->userdata('userid')!=1)
        {
                $fkmodule = 2;
        }
        else
        {   
            $menudisplaydata = ($this->input->post('chr_menu_display') == 'Y') ? 'Y' : 'N';
        } 
        if($this->input->post('fk_module',TRUE)==''){
            $pagetype=2;
        } else {
            $pagetype=$this->input->post('fk_module',TRUE);
        }
          $alias = $this->input->get_post('var_alias');
        if($alias==''){
          $title = $this->input->get_post('var_title');
          $alias_new = $this->mylibrary->auto_alias($title);
        }else{
            $alias_new = $this->input->get_post('var_alias');
        }
//        ----------------FOR IMAGE UPLOAD--------------------------
        if ($this->input->post('chr_image1') == 'X') {
            if ($_FILES['var_image1']['name'] != '') {
                $photo1 = basename($_FILES['var_image1']['name']);
                $photo1 = str_replace('&', "_", $photo1);
                $photo1 = str_replace(' ', "_", $photo1);
                  $photofile1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $photo1);

                $phototitle1 = explode('.', $photofile1);
                $_FILES['Filedata']['name'] = $photofile1;

                $maindir1 = 'upimages/pages/images/';

                $thumbdir1 = 'upimages/pages/thumb/';
                $var_main_file1 = $this->mylibrary->generate_image('var_image1', $maindir1);

                $file_photo1 = basename($var_main_file1);
                $uploadedfile1 = $maindir1 . $file_photo1;
                $this->PAGES_WIDTH = PAGES_WIDTH;
                $this->PAGES_HEIGHT = PAGES_HEIGHT;
                image_thumb($maindir1 . $var_main_file1, $this->PAGES_WIDTH, $this->PAGES_HEIGHT);

                image_thumb($maindir1 . $var_main_file1, PAGES_WIDTH, PAGES_HEIGHT);

                $var_thumb1 = $var_main_file1;
            }
        } else if ($this->input->post('chr_image1') == 'Y') {

            $file1 = $this->input->post('selectedfile1');
            $file1 = str_replace('www.dropbox.com', 'dl.dropboxusercontent.com', $file1);
            $path_parts1 = pathinfo($file1);


            $des_file_photo1 = $path_parts1['basename'];
            $des_file_photo1 = str_replace('&', "_", $des_file_photo1);
            $des_file_photo1 = str_replace(' ', "_", $des_file_photo1);
            $photofile1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $des_file_photo1);


            $newfile1 = 'upimages/pages/images/' . time() . $photofile1;
            $newimagethumb1 = time() . $photofile1;

            if (copy($file, $newfile)) {


                $files1 = glob("upload/*.jpg") + glob("upload/*.jpg");
                $files1 = array_combine($files1, array_map("filemtime", $files1));
                arsort($files);

                $this->PAGES_WIDTH = PAGES_WIDTH;
                $this->PAGES_HEIGHT = PAGES_HEIGHT;
                image_thumb($newfile1, PAGES_WIDTH, PAGES_HEIGHT);

                image_thumb($newfile1, PAGES_WIDTH, PAGES_HEIGHT);
                $var_thumb1 = $newimagethumb1;
                $latest_fil1e = key($files1);
            } else {
                echo "Upload failed.";
            }
        }else if ($this->input->post('chr_image1')=='Z'){
              
            $file1 = $this->input->post('var_url_image1');
            $path_parts1 = pathinfo($file1);
            $des_file_photo1 = $path_parts1['basename'];
            $des_file_photo1 = str_replace('&', "_", $des_file_photo1);
            $des_file_photo1 = str_replace(' ', "_", $des_file_photo1);

            $des_file_photo1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $des_file_photo1);
            $newfile1 = 'upimages/pages/images/'.time().$des_file_photo1;
            $newimagethumb1=time().$des_file_photo1;
           
          
        if (copy($file1, $newfile1) ) {
            
            
            $files1 = glob("upload/*.jpg") + glob("upload/*.jpg"); 
            $files1 = array_combine($files1, array_map("filemtime", $files1));
            arsort($files1);
                $this->PAGES_WIDTH = PAGES_WIDTH;
                $this->PAGES_HEIGHT = PAGES_HEIGHT;
             image_thumb($newfile1, PAGES_WIDTH, PAGES_HEIGHT);
            
            if($file1 !='')
            {
                $var_thumb1 = $newimagethumb1;
                $var_url_image1 = $this->input->post('var_url_image1');
            }
            else
            {
                $var_url_image1='';
            }
            //$var_thumb = $file;
            $latest_file1 = key($files1); 
          
            
        }else{
            return true;
            //echo "Upload failed.";
        }
              
      }

        if($this->input->post('fk_module', TRUE) != 2) {
            $filename_final = '';
            $var_url_final = '';
            $file_flag = 'U';
        } else {
            $filename_final = $filename;
            $var_url_final = $var_url;
            $file_flag = $this->input->post('chr_fileflag', true);
        }
//        -----------------------------------------------------------------
        $data = array(
            'var_pagetype' => $pagetype,
            'fk_pages' => $this->input->post('fk_pages'),
            'var_pagename' => $this->input->post('var_title',TRUE),
            'var_image' => $var_thumb,
            'var_url_image' => $var_url_image,
            'chr_imageflag' => $this->input->post('chr_imageflag', true),
            'var_image1' => $var_thumb1,
            'var_url_image1' => $var_url_image1,
          
            'var_pdffile' => $filename_final,
            'var_url_file' => $var_url_final,
            'chr_fileflag' => $file_flag,
             'var_short_description' => $this->input->post('var_short_description', true),
            'chr_imageflag1' => $this->input->post('chr_imageflag1', true),
            'var_alias' => $this->input->post('var_alias',TRUE),
            'var_short_description' => $this->input->post('var_short_description'),
            'text_fulltext' => $this->input->post('var_description'),
             'chr_menu_display' => $menudisplaydata,
            'chr_image_display' => $chr_image_display,
            'chr_footer_display' => $footerdisplaydata,
            'chr_displaycontent' => $contentdisplaydata,
            'var_metatitle' => str_replace('"', '', $this->input->post('var_metatitle',TRUE)),
            'var_metakeyword' => str_replace('"', '', $this->input->post('var_metakeyword',TRUE)),
            'var_metadescription' => str_replace('"', '', $this->input->post('var_metadescription',TRUE)),
            'int_displayorder' => $int_displayorder,
            'chr_publish' => $this->input->post('chr_publish'),
            'dt_createdate' => date('Y-m-d-h-i-s'),
            'dt_modifydate' => date('Y-m-d-h-i-s'),
            'int_displayorder' => $this->input->post('int_displayorder',TRUE),
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );

        $query = $this->db->insert(DB_PREFIX . 'pages', $data);
        $id = $this->db->insert_id();
        $this->mylibrary->set_display_order_sequence(DB_PREFIX . 'pages',$DisplayOrderClause);
        $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'pages', 'var_pagename', $id, 'I', 'int_glcode');
        return $id;
    }

    function update() {
         $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_delete();
        $DisplayOrderClause = " and fk_pages='".$this->input->post('fk_pages')."'";
        if ($this->input->post('int_displayorder') != $this->input->post('old_displayorder')) {
            $this->mylibrary->update_display_order($this->input->post('ehintglcode'), $this->input->post('int_displayorder'), $this->input->post('old_displayorder'), '', 'pages',$DisplayOrderClause);
        }

        $menudisplaydata = ($this->input->post('chr_menu_display') == 'Y') ? 'Y' : 'N';
        
        $footerdisplaydata = ($this->input->post('chr_footer_display') == 'Y') ? 'Y' : 'N';
       
        $contentdisplaydata = ($this->input->post('chr_displaycontent') == 'Y') ? 'Y' : 'N';
        
         if ($this->input->post('chr_file') == 'U') {
            
            $filename = $_FILES['var_pdffile']['name'];
            $fileexntension = substr(strrchr($filename, '.'), 1);
            $var_title = str_replace('.' . $fileexntension, '', $filename);
            if($filename == ''){
               $filename = '';
           } else {
               $filename = $var_title ."_". time() . "." . $fileexntension;
           }
           
            $filename = str_replace(' ', "_", $filename);
            $filename = str_replace('&', "_", $filename);
            $filename = str_replace(' ', "_", $filename);
            $filename = preg_replace('/[^a-zA-Z0-9_ \[\]\.\&-]/s', '', $filename);
           /* $filename = preg_replace('/[\/:*?"&!@#$()+%^\'<>| ]/', "_", $filename); */
            $tmp_name = $_FILES["var_pdffile"]["tmp_name"];
            $uploads_dir = 'upimages/pages';
            move_uploaded_file($tmp_name, $uploads_dir . "/" . $filename);
        } else if ($this->input->post('chr_file') == 'B') {

            $file = $this->input->post('selectedfile');
            $file = str_replace('www.dropbox.com', 'dl.dropboxusercontent.com', $file);
            $path_parts = pathinfo($file);
            $extension = explode('?', $path_parts['basename']);
            $des_file_photo = $this->common_model->Clean_String($extension[count($extension) - 2]);
//            $des_file_photo = trim(str_replace(range(0,9),'',str_replace('%','', $path_parts['basename']))) ;
           
            $fileexntension = substr(strrchr($des_file_photo, '.'), 1);
            $var_titles = str_replace('.' . $fileexntension, '', $des_file_photo);
            
            $filenamess = $var_titles ."_". time() . "." . $fileexntension;
            $newfiles = 'upimages/pages/'. $filenamess;

            $newimagethumb = $filenamess;
            if (copy($file, $newfiles)) {
                $files = glob("upload/*.pdf") + glob("upload/*.pdf");
                $files = array_combine($files, array_map("filemtime", $files));
                arsort($files);
                $filename = $newimagethumb;
                $latest_file = key($files);
            } else {
               
            }
        }

     else if ($this->input->post('chr_file') == 'E') {
            $file = $this->input->post('var_url_file');
            $path_parts = pathinfo($file);
            $des_file_photo = $path_parts['basename'];
            $des_file_photo = str_replace('&nbsp;', '-', $des_file_photo);
            $des_file_photo = str_replace(' ', '-', $des_file_photo);
            $des_file_photo = str_replace('%20', '-', $des_file_photo);
            
            $fileexntension = substr(strrchr($des_file_photo, '.'), 1);
            $var_titles = str_replace('.' . $fileexntension, '', $des_file_photo);
            $filenameexternal = $var_titles ."_". time() . "." . $fileexntension;

            $newfile = 'upimages/pages/' . $filenameexternal;
            $newimagethumb = $filenameexternal;
            
            if (copy($file, $newfile)) {
                $files = glob("upload/*.pdf") + glob("upload/*.pdf");
                $files = array_combine($files, array_map("filemtime", $files));
                arsort($files);

                 if($file !='')
            {
                
                $filename = $newimagethumb;
                $var_url = $this->input->post('var_url_file');
            }
            else
            {
                 $var_url = $this->input->post('var_url_file');
            }
            
            $latest_file = key($files); 
          
            
        }else{
            return true;
            //echo "Upload failed.";
        }
              
      }
      
        
        if ($filename == '') {
            $filename = $this->input->get_post('hiduserfile');
        }
//       --------------------for image upload---------------------------
        
        if ($this->input->post('chr_image1') == 'X') {
            if ($_FILES['var_image1']['name'] != '') {
                $photo1 = basename($_FILES['var_image1']['name']);
                $photo1 = str_replace('&', "_", $photo1);
                $photo1 = str_replace(' ', "_", $photo1);
                $photofile1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $photo1);

                $phototitle1 = explode('.', $photofile1);
                $_FILES['Filedata']['name'] = $photofile1;

                $maindir1 = 'upimages/pages/images/';
                $thumbdir1 = 'upimages/pages/thumb/';
                $var_main_file1 = $this->mylibrary->generate_image('var_image1', $maindir1);

                $file_photo1 = basename($var_main_file1);
                $uploadedfile1 = $maindi1r . $file_photo1;

                $this->PAGES_WIDTH = PAGES_WIDTH;
                $this->PAGES_HEIGHT = PAGES_HEIGHT;


                image_thumb($maindir1 . $var_main_file1, $this->PAGES_WIDTH, $this->PAGES_HEIGHT);
                image_thumb($maindir1 . $var_main_file1, PAGES_WIDTH, PAGES_HEIGHT);
                $var_thumb1 = $var_main_file1;
            }
        } else if ($this->input->post('chr_image1') == 'Y') {

            $file1 = $this->input->post('selectedfile1');
            $file1 = str_replace('www.dropbox.com', 'dl.dropboxusercontent.com', $file1);
            $path_parts1 = pathinfo($file1);


            $des_file_photo1 = $path_parts1['basename'];
            $des_file_photo1 = str_replace('&', "_", $des_file_photo1);
            $des_file_photo1 = str_replace(' ', "_", $des_file_photo1);

            $photofile1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $des_file_photo1);

            $newfile1 = 'upimages/pages/images/' . time() . $photofile1;
            $newimagethumb1 = time() . $photofile1;

            if (copy($file1, $newfile1)) {


                $files1 = glob("upload/*.jpg") + glob("upload/*.jpg");
                $files1 = array_combine($files1, array_map("filemtime", $files1));
                arsort($files1);

                $this->PAGES_WIDTH = PAGES_WIDTH;
                $this->PAGES_HEIGHT = PAGES_HEIGHT;

                image_thumb($newfile1, $this->PAGES_WIDTH, $this->PAGES_HEIGHT);
                image_thumb($newfile1, PAGES_WIDTH, PAGES_HEIGHT);
                $var_thumb1 = $newimagethumb1;
                $latest_file1 = key($files1);
            } else {
                echo "Upload failed.";
            }
        } else if ($this->input->post('chr_image')=='Z'){
            $file1 = $this->input->post('var_url_image1');
            $path_parts1 = pathinfo($file1);
            $des_file_photo1= $path_parts['basename'];
            $des_file_photo1 = str_replace('&', "_", $des_file_photo1);
            $des_file_photo1 = str_replace(' ', "_", $des_file_photo1);
            $des_file_photo1 = preg_replace('/[^a-zA-Z0-9_ \[\]\.\(\)&-]/s', '', $des_file_photo1);
            
            $newfile1 = 'upimages/pages/images/'.time().$des_file_photo1;
            $newimagethumb1=time().$des_file_photo1;
            
           
        if ( copy($file1, $newfile1) ) {
            
            $files1 = glob("upload/*.jpg") + glob("upload/*.jpg");
            $files1 = array_combine($files1, array_map("filemtime", $files1));
            arsort($files1);
            $this->PAGES_WIDTH = $this->input->post('hidthumb_width');
            $this->PAGES_HEIGHT = $this->input->post('hidthumb_height');
            image_thumb($newfile1,  $this->PAGES_WIDTH, $this->PAGES_HEIGHT);
            
            if($file1 !='')
            {
                
                $var_thumb1 = $newimagethumb1;
                $var_url_image1 = $this->input->post('var_url_image1');
            }
            else
            {
                $var_url_image1='';
            }
            
            $latest_file1 = key($files1); 
          
            
        }else{
            return true;

        }
              
      }
        if ($var_thumb1 == '') {
            $var_thumb1 = $this->input->get_post('hidvar_image1');
        }
        $chr_image_display = ($this->input->post('chr_image_display') == 'Y') ? 'Y' : 'N';
        
//        ---------image upload end-------------------------

//        ----------------------- code for cms or not --------------
        if($this->input->post('fk_module', TRUE) != 2) {
            $filename_final = '';
            $var_url_final = '';
            $file_flag = 'U';
        } else {
            $filename_final = $filename;
            $var_url_final = $var_url;
            $file_flag = $this->input->post('chr_fileflag', true);
        }
//        -----------------------------------------------------------------
        $data = array(
            'var_pagetype' => $this->input->post('fk_module', TRUE),
            'fk_pages' => $this->input->post('fk_pages', TRUE),
            'var_pagename' => $this->input->post('var_title', TRUE),
            'var_image' => $var_thumb,
            'var_url_image' => $var_url_image,
            'chr_imageflag' => $this->input->post('chr_imageflag', true),
            'var_image1' => $var_thumb1,
            'var_url_image1' => $var_url_image1,
            'chr_imageflag1' => $this->input->post('chr_imageflag1', true),
            'var_pdffile' => $filename_final,
            'var_url_file' => $var_url_final,
            'chr_fileflag' => $file_flag,
            'var_alias' => $this->input->post('var_alias', TRUE),
            'var_short_description' => $this->input->post('var_short_description'),
            'text_fulltext' => $this->input->post('var_description'),
            'chr_menu_display' => $menudisplaydata,
            'chr_image_display' => $chr_image_display,
            'chr_footer_display' => $footerdisplaydata,
            'chr_displaycontent' => $contentdisplaydata,
            'var_metatitle' => str_replace('"', '', $this->input->post('var_metatitle', TRUE)),
            'var_metakeyword' => str_replace('"', '', $this->input->post('var_metakeyword', TRUE)),
            'var_metadescription' => str_replace('"', '', $this->input->post('var_metadescription', TRUE)),
            'int_displayorder' => $this->input->post('int_displayorder', TRUE),
            'chr_publish' => $this->input->post('chr_publish'),
            'dt_modifydate' => date('Y-m-d h-i-s'),
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME
        );

        $this->db->where('int_glcode', $this->input->get_post('ehintglcode'));
        $this->db->update(DB_PREFIX . 'pages', $data);

        $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'pages', 'var_pagename', $this->input->get_post('ehintglcode'), 'U', 'int_glcode');
        $this->mylibrary->set_display_order_sequence(DB_PREFIX . 'pages',$DisplayOrderClause);
    }

     function updatedisplay() {
         $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_delete();
        $tablename = $this->input->get_post('tablename');
        $fieldname = $this->input->get_post('fieldname');
        $value = $this->input->get_post('value');
        $idname = $this->input->get_post('id');

        $updateSql = "UPDATE {$tablename} SET {$fieldname}='{$value}' WHERE  int_glcode in ({$idname}) ";
        $res = mysql_query($updateSql) or die(mysql_error());
        echo ($res) ? "1" : "0";
        exit;
    }
   

    function delete_row() {
        
        $this->db->cache_set_common_path("application/cache/db/common/pages/");
        $this->db->cache_delete();
        
        $tablename = DB_PREFIX . 'pages';

        $deleteids = $this->input->get_post('dids');
        $deletearray = explode(',', $deleteids);
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {

            $data = array('chr_delete' => 'Y', 'dt_modifydate' => date('Y-m-d h-i-s'), 'var_ipaddress' => $_SERVER['REMOTE_ADDR'], 'var_adminuser' => ADMIN_NAME);
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);

            $this->mylibrary->insertinlogmanager(MODULE_ID, DB_PREFIX . 'pages', 'var_pagename', $deletearray[$i], 'D', 'int_glcode');
        }
    }
    function Bindpageshierarchy($name, $selected_id, $class = 'listbox') {
        $style = "style='display: none'";
        $dipnopar = "selected";
        $requesteid = $this->input->get_post('eid');
        $tempfk = "";
        $requesteid = !empty($requesteid) ? $requesteid : "";
        
        if($requesteid =='' || $requesteid !=''){
            $abc=" and int_glcode!=1 and fk_pages!=1";
        }
        else{
            $abc='';
        }
          if ($this->session->userdata('userid') != 1) {
                     $whereclause .= " and int_glcode NOT IN(31,49,50,53)";
                }
        $sql = "SELECT int_glcode AS id, var_pagename AS name, fk_pages FROM " . DB_PREFIX . "pages WHERE chr_publish = 'Y' $abc AND chr_delete = 'N' and int_glcode NOT IN(51,53) $whereclause ORDER BY int_displayorder";
        $rs = mysql_query($sql);

        $children = array();
        $pitems = array();

        while ($row = mysql_fetch_array($rs)) {
            $pitems[] = $row;
        }
        
        if ($pitems) {
            foreach ($pitems as $p) {
                $pt = $p['fk_pages'];
                $list = @$children[$pt] ? $children[$pt] : array();
                array_push($list, $p);
                $children[$pt] = $list;
            }
        }
        $list = $this->treerecurse(0, '&nbsp;&nbsp;&nbsp;', array(), $children, 10, 0, 0);
        $display_output = '<select class="fl" name="' . $name . '" id="' . $name . '"  size="10" style="width:355px">';
        if ($this->session->userdata('chr_user') == 'N') {
            $display_output .="<option value=\"0\" " . (($selected_id == 0) ? $dipnopar : '') . ">Parent Page (Top Level Page)</option>";
            }
        $temp1 = "";
        $temp = "";
        
        foreach ($list as $item) {
            if ($item['id'] == $_REQUEST['eid'] || $item['fk_pages'] == $_REQUEST['eid'] || $item['id'] == 2) {
                $disabled = " disabled='disabled' ";
                $temp1 = $item['id'];
            } else if ($item['fk_pages'] == $temp || $item['fk_pages'] == $temp1 || $tempfk == $item['fk_pages']) {
                $disabled = " disabled='disabled' ";
                $temp = $item['id'];
                $tempfk = $item['fk_pages'];
            } else {
                $disabled = "";
            }
            $display_output.="<option value=" . $item['id'] . " " . (($item['id'] == $selected_id) ? 'selected' : '') . " " . $disabled . " >" . $item['treename'] . "</option>";
        }
        
        return $display_output;
    }

    function treerecurse($id, $indent, $list = Array(), $children = Array(), $maxlevel = '10', $level = 0, $type = 1) {

        $c = "";
        if ($children[$id] && $level <= $maxlevel) {

            foreach ($children[$id] as $c) {

                $id = $c['id'];
                if ($type) {
                    $pre = '<sup>|_</sup>&nbsp;';
                    $spacer = '.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                } else {
                    $pre = '|_ ';
                    $spacer = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                }
                if ($c['fk_pages'] == 0) {
                     $txt = $c['name'];
                } else {
                     $txt = $pre . $c['name'];
                }
                $pt = $c['fk_pages'];

                $list[$id] = $c;
                $list[$id]['treename'] = "$indent$txt";
                $list[$id]['children'] = count($children[$id]);

                $list = $this->treerecurse($id, $indent . $spacer, $list, $children, $maxlevel, $level + 1, $type);
            }
        }

        return $list;
    }

    function getEnablemodules($name, $selected = '') {

        $sql = "select int_glcode , var_modulename,chr_pro_modulename from " . DB_PREFIX . "modules where chr_publish='Y' and chr_delete='N' and chr_powerpanel_module='Y' and chr_filterflag='Y' and int_glcode NOT IN (98,99,100)";
        $records = mysql_query($sql);
       
        $id = $name;
        
        $otherString = ' id="' . $id . '" class="more-textarea fl" style="width:355px;" onchange="Show_upload_file(this.value)";';
        $selected_ids=Array();
        array_push($selected_ids, $selected);        
        
        $options=Array();
        while ($row = mysql_fetch_array($records)) {        
            $options[$row['int_glcode']]=ucwords($row['chr_pro_modulename']);

        }
        

        $moduleSelectBox = array('name'         => $name,
                                 'options'      => $options,
                                 'selected_ids' => $selected_ids,
//                                 'disabled_ids' => $disabled_ids,
                                 'otherString'  => $otherString,
                                 'tdoption'     => Array('TDDisplay'=>'Y')
                                   );
        $display_output=form_input_ready($moduleSelectBox,'select');
        return $display_output;
    }

    function selectAll_commonfiles() {

        $query = "select * from " . DB_PREFIX . "pdf_mst where chr_delete = 'N' and chr_publish='Y'";
        $result = $this->db->query($query);
        return $result;
    }

    function getChildDisable($id) {
        $sql = "select count(1) as total from " . DB_PREFIX . "pages where chr_delete='N' and fk_pages=" . $id;
        $data = $this->db->query($sql);
        $rs = $data->row();
        return $rs->total;
    }
    function updateread(){
        
        $tablename=$_REQUEST['tablename'];
        $fieldname=$_REQUEST['fieldname'];
        $value=$_REQUEST['value'];
        $id=$_REQUEST['id']; 
        
        
        $id_ARRAY = explode(",", $id);
        foreach ($id_ARRAY as $id_value){
         
        $query="update ".$tablename." set ".$fieldname."='".$value."' where int_glcode='".$id_value."'";
        $result = $this->db->query($query);
        }
        return 1;
    }
    
    function checkvalid($userId,$pass){
      
        $Password = urldecode($this->mylibrary->cryptPass($pass));
       //$uid = $this->session->userdata('userid');
        $sql = "SELECT * from ".DB_PREFIX."users where int_glcode='".$userId."' and var_password = '".$Password."'";
        $query = $this->db->query($sql);
        
        $noOfRows=$query->num_rows;
        if ($noOfRows == 1) {
            $row = $query->row();
            $data = array(
                'userid' => $row->int_glcode,
                'username' => $row->var_emailid,
                'chr_user' => $row->chr_usertype,
                'fname' => $row->var_fname,
                'lname' => $row->var_lname,
                'group_id' => $row->fk_groups,
                'validated' => true
            );
            
            if ($this->input->get_post("chkrememberme") != "") {
                $oneyear = 365 * 24 * 3600; // one year's time.
                $usercookie_info = array('user' => $username, 'time' => time(), 'pwd' => $password, 'takemeto' => $takemeto, 'chkrememberme' => '1');
                $this->mylibrary->requestSetCookie('tml_CookieLogin', $usercookie_info, $oneyear);
            } else {
                $this->mylibrary->requestRemoveCookie('tml_CookieLogin');
            }
            $this->session->set_userdata($data);
            $AllmoduleAccess = $this->mylibrary->getAllmoduleAccess();
            
            $this->session->set_userdata('permissionArry',$AllmoduleAccess);
            $menuModuleArry = $this->mylibrary->getMenuModules();
            $this->session->set_userdata('menuModuleArry',$menuModuleArry);                        
        }
        
        return $noOfRows;
    }
    
   function get_displayorder($eid,$displayorder = '')
    { 
        $displayorder = array();    
            if(!empty($eid)) 
            {
                $str1 = "SELECT int_displayorder,fk_pages,int_glcode FROM ".DB_PREFIX."pages WHERE int_glcode='".$eid."'";
                $query1 = $this->db->query($str1); 
                $data1 = $query1->row_array($query1);
                $displayorder[] = $data1['int_displayorder'];    
                if($data1['fk_pages'] != 0)
                {
                    $displayorder[] = $this->get_displayorder($data1['fk_pages'],$displayorder);
                }
            }
        $displayorder_str = implode(".",array_reverse($displayorder));
        return $displayorder_str;
    }
     
     function treerecurse2($id, $indent, $list = Array(), $children = Array(), $maxlevel = '10', $level = 0, $type = 1, $Order='') {
        $c = "";

        if ($children[$id] && $level <= $maxlevel) {

            foreach ($children[$id] as $c) {

                $id = $c['id'];

                if ($type) {

                    $pre = '<sup>|_</sup>&nbsp;';

                    $spacer = '.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                    $parent_order = $Order;
                    
                } else {

                    $pre = '|_ ';

                    $spacer = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                }
                if ($c['fk_pages'] == 0) {

                    $txt = $c['name'];
                    $Orderparent = $c['int_displayorder'];
                } else {

                    $txt = $pre . $c['name'];
                    $Orderparent = ".".$c['int_displayorder'];
                }
                $pt = $c['fk_pages'];

                $list[$id] = $c;
                $list[$id]['treename'] = "$indent$txt";
                $list[$id]['children'] = count($children[$id]);
                $list[$id]['DisplayOrder'] = $Order.$Orderparent;
                $list = $this->treerecurse2($id, $indent . $spacer, $list, $children, $maxlevel, $level + 1, $type,$parent_order.$Orderparent);
            }
        }
       
        return $list;
    }

    
      public function getParentRecord()
    {
        
        $sqlCountPages = "select * FROM " . DB_PREFIX . "pages where chr_delete='N' and chr_publish='Y' and fk_pages=0";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }
    
  
    function getappendurl($view = '', $ajax_view = '') {

        $url = '';
        $alias = $this->common_model->PagesAliasArray['int_glcode']['23'];
        $url.=$alias->var_alias;
        if ($ajax_view == 'Y') { 
           return $url; 
        } else {
            return $url; 
        }
    }
     function getHomeDisable() {
        $sql = "SELECT count(1) as total FROM " . DB_PREFIX . "pages WHERE chr_delete='N' and chr_image_display='Y'";
        $data = $this->db->query($sql);
        $rs = $data->row();
        return $rs->total;
    }
    
    function downloadmenu(){
        $sql = "SELECT * FROM " . DB_PREFIX . "pages WHERE chr_delete='N' and chr_publish='Y' and int_glcode=".RECORD_ID." and var_pagetype='2'";
        $data = $this->db->query($sql);
        $rs = $data->result_array();
        return $rs;
    }

    function check_email_exit($emailID) {
        $this->db->where('var_email', $emailID);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('newsletterleads');
        if ($query->num_rows() > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    function insert_newsletterdata() {
        $data = array(
            'var_email' => $this->input->get_post('var_email'),
            'dt_createdate' => date('Y-m-d-h-i-s'),
            'dt_modifydate' => date('Y-m-d-h-i-s'),
            'chr_publish' => 'Y',
            'chr_delete' => 'N',
            'var_ipaddress' => $_SERVER['REMOTE_ADDR'],
            'var_adminuser' => ADMIN_NAME,
        );
        $this->db->insert(DB_PREFIX . 'newsletterleads', $data);
        $id = $this->db->insert_id();
        return $this->sendMailtoNewsletter($id);
//        return true;
    }

    function sendMailtoNewsletter($id) {
        
        $userQuery = $this->db->get_where('newsletterleads', array('int_glcode' => $id));
        $userRow = $userQuery->row_array();
        
        $name = $userRow['var_email'];

        $subject = 'Newsletter Subscription Notification';
        $adminEmail = ADMIN_NEWSLETTER_ID;
        $Regards = str_replace("@SITE_URL", SITE_PATH, EMAIL_SIGNATURE);
        $Messagecontent = '';
        $logo = FRONT_MEDIA_URL;
        $content = "New user <b>" . $name . "</b> has subscribed for our Newsletter.";
        $detailtitle = "<span style=\"color:#ED1C22; font-size:14px; padding:10px 0 5px 0; display:block; font-family:Arial, Helvetica, sans-serif; font-weight:bold;\">Enquiry Details</span>";
        $html_message = file_get_contents(FRONT_MEDIA_URL . "email-template/index1.html");
        
        $logo = '<td valign="middle" style="padding:10px 0px"><a href="' . SITE_PATH . '"><img src="'.FRONT_MEDIA_URL . 'email-template/images/logo.jpg" alt=" "  style="border:0;" title=" "/></a></td>';
        
//        $body_content = '<tr>
//                            <td width="15" height="24" align="left" valign="middle"><img src="'.FRONT_MEDIA_URL . 'email-template/images/email_bullat.png" style="vertical-align: top;" width="10" height="12" vspace="7" alt="" /></td>
//                            <td height="24" align="left" valign="middle" style="font-family:Arial, Helvetica, sans-serif; color:#818486 ; font-size:13px;"><strong style="color:#181818;">Email Id: </strong><a title="' . $name . '" href="#" style="color:#000; text-decoration:none;">' . $name . ' </a></td>
//                        </tr>';
                
        if (CHR_FACEBOOK == 'Y') {
            $facebook = '<td align="center"><a href="' . FACEBOOK_LINK . '" style="border:none; border-radius:50%; background:#5e626d; height:25px; width:25px; display:block; margin:0 5px"  title="Facebook" target="_blank"><img src="'.FRONT_MEDIA_URL . 'email-template/images/fb.png" style="border:none;margin-top:5px;" alt="Facebook" /></a></td>';
        }
        if (CHR_TWITTER == 'Y') {
            $twitter = '<td align="center"><a href="' . TWITTER_LINK . '" style="border:none; border-radius:50%; background:#5e626d; height:25px; width:25px; display:block; margin:0 5px" title="Twitter" target="_blank"><img src="'.FRONT_MEDIA_URL . 'email-template/images/tw.png" style="border:none; margin-top:7px;" alt="Twitter" /></a></td>';
        }
        
        if (CHR_PINTEREST == 'Y') {
            $pinterest = '<td align="center"><a href="' . PINTEREST_LINK . '" style="border:none; border-radius:50%; background:#5e626d; height:25px; width:25px; display:block; margin:0 5px"  title="Pinterest" target="_blank"><img src="'.FRONT_MEDIA_URL . 'email-template/images/pt.png" style="border:none;margin-top:6px;" alt="Pinterest" /></a></td>';
        }
        if (CHR_LINKEDIN == 'Y') {
            $linkedin = '<td align="center"><a href="' . LINKEDIN_LINK . '" style="border:none; border-radius:50%; background:#5e626d; height:25px; width:25px; display:block; margin:0 5px"  title="LinkedIn" target="_blank"><img src="'.FRONT_MEDIA_URL . 'email-template/images/in.png" style="border:none;margin-top:5px;" alt="LinkedIn" /></a></td>';
        }
        
        if((CHR_FACEBOOK == 'Y') || (CHR_TWITTER == 'Y') || (CHR_PINTEREST == 'Y') || (CHR_LINKEDIN == 'Y')) {
            $follow = "FOLLOW US";
        } else {
            $follow = '';    
        }
        $signature= '<td>
                         <span style="font-family:Arial, Helvetica, sans-serif; font-size:14px; color:#ED1C22; font-weight:bold;">@REGARD</span> <br />
                         <a href="' . SITE_PATH . '" style="color:#ED1C22; text-decoration:none;font-family:Arial, Helvetica, sans-serif; font-size:12px;" title="' . SITE_NAME . '">' . SITE_NAME . '</a>
                     </td>';
        $copyright="Copyright &copy; " . date(Y) . " . All Rights Reserved.";

        $html_message = str_replace("@LOGO", $logo, $html_message);
        $html_message = str_replace("@DEAR", 'Dear', $html_message);
        $html_message = str_replace("@ADMIN", 'Administrator' . ',', $html_message);
        $html_message = str_replace("@CONTENT", $content, $html_message);
//        $html_message = str_replace("@DETAILSTITLE", $detailtitle, $html_message);
//        $html_message = str_replace("@BODYCONTENT", $body_content, $html_message);
        
        $html_message = str_replace("@SIGNATURE", $signature, $html_message);
        $html_message = str_replace("@REGARD", 'Best Regards, ', $html_message);
        $html_message = str_replace("@SITE_URL", SITE_NAME, $html_message);
        
        $html_message = str_replace("@FOLLOW", $follow, $html_message);
        $html_message = str_replace("@FACEBOOK", $facebook, $html_message);
        $html_message = str_replace("@TWITTER", $twitter, $html_message);
        $html_message = str_replace("@LINKEDIN", $linkedin, $html_message);
        $html_message = str_replace("@PINTEREST", $pinterest, $html_message);
        
        $html_message = str_replace("@COPYRIGHT", $copyright, $html_message);

//        echo $html_message;
        $this->email->reply_to($userRow['var_email'], $userRow['var_email']);
        $this->email->to($adminEmail);
        $this->email->subject($subject);
        $this->email->message($html_message);

        if ($this->mylibrary->send_mail()) {
            $message = mysql_real_escape_string($html_message);
            $fk_emailtype = '3';

            $insertSql = "insert into " . DB_PREFIX . "emails (fk_emailtype,var_from,txt_to,txt_subject,txt_body,dt_createdate,dt_modifydate) Values ($fk_emailtype,'" . MAIL_FROM . "', '" . $adminEmail . "' ,'" . $subject . "','" . $message . "',now(),now()) ";
            $exec = $this->db->query($insertSql);


            return "1";
//             redirect($this->common_model->getUrl('pages','2','44'));
        } else {
            return "0";
        }
    }
}

?>
