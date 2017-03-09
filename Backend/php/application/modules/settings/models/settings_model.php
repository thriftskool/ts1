<?php

class settings_model extends CI_Model {

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
    var $dt_operationdate;   // (normal Attribute)
    var $chr_star;
    var $chr_read;   // (normal Attribute)
    var $oldint_displayorder; // Attribute of Old Displayorder
    var $pagename = ''; // Attribute of Page Name
    var $numofrows; // Attribute of Num Of Rows In Result
    var $numofpages; // Attribute of Num Of Pagues In Result
    var $orderby = 'dt_operationdate'; // Attribute of Deafult Order By
    var $ordertype = 'desc'; // Attribute of Deafult Order By
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
    var $modval = 0;
    var $chr_action = '';

    public function __construct() {
        $this->load->database();
        $this->load->library('mylibrary');
        $mylibraryObj = new mylibrary;
    }

    function PagingTop() {

        $content['pagingtop'] = $this->mylibrary->generatePagingPannel($this->generateParam('top'));
        return $content['pagingtop'];
    }

    function PagingBottom() {

        $content['pagingbottom'] = $this->mylibrary->generatePagingPannel($this->generateParam('bottom'));
        return $content['pagingbottom'];
    }

    function initialize() {

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
        $modval = $this->input->get_post('modval');

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
        $this->modval = (!empty($modval)) ? $modval : $this->modval;

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

        $this->numofrows = $this->CountRows();
        $this->pagesize = (!empty($pagesize)) ? $pagesize : $this->pagesize;
        $this->pagenumber = (!empty($pagenumber)) ? $pagenumber : $this->pagenumber;
        $this->noofpages = intval($this->numofrows / $this->pagesize);
        $this->noofpages = (($this->numofrows % $this->pagesize) > 0) ? ($this->noofpages + 1) : ($this->noofpages);
        $this->start = ($this->pagenumber - 1 ) * $this->pagesize;
    }

    function Generateurl() {

       $segment=$this->uri->segment(3);
        if (!empty($segment)) {
            if($segment=='delete') {
                $this->pagename = MODULE_PAGE_NAME . '/logmanager?';
            } else {
                $this->pagename = MODULE_PAGE_NAME . '/'.$this->uri->segment(3).'?';
            }
        } else {
            $this->pagename = MODULE_PAGE_NAME . '?';
        }

        
        $this->urlwithpara = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        $this->urlwithlogpara = MODULE_URL . 'logmanager?' . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        
        $this->hurlwithpara = $this->pagename . '&' . 'hpagesize=' . $this->pagesize . '&hnumofrows=' . $this->numofrows . '&horderby=' . $this->orderby . '&hordertype=' . $this->ordertype . '&hsearchby=' . $this->searchby . '&hsearchtxt=' . $this->searchtxt . '&hpagenumber=' . $this->pagenumber . '&modval=' . $this->modval . '&hfilterby=' . $this->filterby . '&history=T' . '&chr_action=' . $this->chr_action . $view;
        $this->urlwithpoutsearch = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . '&' . $view;
        $this->urlwithoutsort = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&ordertype=' . $this->ordertype . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        $this->urlwithoutpaging = $this->pagename . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        $this->urlwithoutfilter = $this->pagename . '&' . 'pagesize=' . $this->pagesize . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        $this->urlwithoutmoduleid = $this->pagename . '&pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&chr_action=' . $this->chr_action . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&modval=' . $this->modval . '&chr_action=' . $this->chr_action . $view;
        $this->AutoSearchUrl = $this->urlwithpara . "&type=autosearch&searchbyVal=" . $this->searchbyVal  . '&chr_action=' . $this->chr_action . $view;
        $this->AutoSearchUrl = $this->urlwithpara  . "&type=autosearch&searchbyVal=" . $this->searchbyVal;
        $this->urlwithoutmoduleid = ADMINPANEL_URL . 'settings/systemsettings?' . '&pagesize=' . $this->pagesize . '&numofrows=' . $this->numofrows . '&orderby=' . $this->orderby . '&ordertype=' . $this->ordertype . '&searchby=' . $this->searchby . '&searchtxt=' . $this->searchtxt . '&pagenumber=' . $this->pagenumber . '&filterby=' . $this->filterby . '&modval=' . $this->modval . $view;
    }

    function generateParam($position = 'top') {

        if ($position == 'top') {
            $modcmb = $this->Bindmodule();
            $actioncmb = $this->getoperationcmb();
        }
        
        
         $segment=$this->uri->segment(3);
         
        if (!empty($segment)) {
           
            if($segment=='delete') {
                $pagename = MODULE_PAGE_NAME . '/logmanager?';
            } else {
                $pagename= MODULE_PAGE_NAME . '/'.$this->uri->segment(3).'?';
            }
        } else {
            $pagename = MODULE_PAGE_NAME ;
        } 
        
        
        return array('pageurl' => MODULE_PAGE_NAME,
            'heading' => 'Log Manager',
            'listImage' => 'add-new-user-icon.png',
            'tablename' => DB_PREFIX . 'logmanager',
            'position' => $position,
            'actionImage' => 'add-new-button-blue.gif',
            'actionImageHover' => 'add-new-button-blue-hover.gif',
            'actionUrl' => MODULE_PAGE_NAME,
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
            'search' => array('searchArray' => array("var_modulename" =>"Module Name","var_name" => "Title","var_ipaddress" => "Ip Address"),
//        'search' => array('searchArray' => array("var_name" => "Title"),

                'searchBy' => $this->searchby,
                'searchText' => $this->searchtxt,
                'searchUrl' => $this->urlwithpoutsearch
            ),
            'modcmb' => $modcmb,
        );
    }

    function HeaderPanel() {
        $content['headerpanel'] = $this->mylibrary->generateHeaderPanel($this->generateParam(), 'no');
        return $content['headerpanel'];
    }



    function edit_systemsettings() {
            
      if ($this->input->get_post('p') == "gen") {

 
 if ($this->input->get_post('chr_linkedin', TRUE) == "Y")
                 	$chr_linkedin = "Y";
            else
                 	$chr_linkedin = "N";

if ($this->input->get_post('chr_pinterest', TRUE) == "Y")
                 	$chr_pinterest = "Y";
            else
                 	$chr_pinterest = "N";
            
  if ($this->input->get_post('chr_facebook', TRUE) == "Y")
                $chr_facebook = "Y";
            else
                $chr_facebook = "N";
              if ($this->input->get_post('chr_twitter', TRUE) == "Y")
                $chr_twitter = "Y";
            else
                $chr_twitter = "N";
            
            if ($this->input->get_post('chr_rss') == "Y")
                $chr_rss = "Y";
            else
                $chr_rss = "N";

            if ($this->input->get_post('chr_googleplus') == "Y")
                $chr_googleplus = "Y";
            else
                $chr_googleplus = "N";


            if ($this->input->get_post('chr_district') == "Y")
                $chr_district = "Y";
            else
                $chr_district = "N";

            if ($this->input->get_post('chr_ypages') == "Y")
                $chr_ypages = "Y";
            else
                $chr_ypages = "N";



            if ($this->input->get_post('chr_member') == "Y")
                $chr_member = "Y";
            else
                $chr_member = "N";

            if ($this->input->get_post('chr_tripadvisor') == "on")
                $chr_trip = "Y";
            else
                $chr_trip = "N";

            if ($this->input->get_post('chr_alias_flag') == "on")
                $chr_alias_flag = "Y";
            else
                $chr_alias_flag = "N";

            if ($this->input->get_post('chr_seo_flag') == "on")
                $chr_seo_flag = "Y";
            else
                $chr_seo_flag = "N";

            if ($this->input->get_post('chr_commision_flag') == "on")
                $chr_alias_flag = "Y";
            else
                $chr_alias_flag = "N";
            
            if ($this->input->get_post('chr_dropbox_beta') == "on")
                $chr_alias_flag = "Y";
            else
                $chr_alias_flag = "N";


            $data = array(
                'var_sitename' => $this->input->get_post('var_sitename', TRUE),
                'var_sitepath' => $this->input->get_post('var_sitepath', TRUE),
//                'var_pagesize' => $this->input->get_post('var_pagesize', TRUE),
                //'var_clubrunner_link' => $this->input->get_post('var_clubrunner_link', TRUE),
                'var_facebook_link' => $this->input->get_post('var_facebook_link', TRUE),
                'var_twitter_link' => $this->input->get_post('var_twitter_link', TRUE),
//                'var_youtube_link' => $this->input->get_post('var_youtube_link', TRUE),
                'var_linkedin' => $this->input->get_post('var_linkedin', TRUE),
                 'var_pinterest_link' => $this->input->get_post('var_pinterest_link', TRUE),
//                'var_tripadvisor' => $this->input->get_post('var_tripadvisor_link', TRUE),
              
                'chr_facebook' => $chr_facebook,
                'chr_twitter' => $chr_twitter,
                'chr_linkedin' => $chr_linkedin,
                 'chr_pinterest' => $chr_pinterest,
//                'chr_youtube' => $chr_youtube,
               // 'chr_tripadvisor' => $chr_trip,
                'var_dateformat' => $this->input->get_post('var_dateformat'),
                'var_frontdateformat' => $this->input->get_post('var_frontdateformat'),
                'chr_seo_flag' => $this->input->get_post('chr_seo_flag'),
                'chr_dropbox_beta'=> $this->input->get_post('chr_dropbox_beta'),
                'var_dropbox_beta_sk' => $this->input->get_post('var_dropbox_beta_sk', TRUE),
                'var_dropbox_live_sk' => $this->input->get_post('var_dropbox_live_sk', TRUE),
                'chr_commision_flag' => $this->input->get_post('chr_commision_flag'),
                'var_byprice' => $this->input->get_post('var_byprice', TRUE),
                'var_byperc' => $this->input->get_post('var_byperc', TRUE),
                'var_marginusci' => $this->input->get_post('var_marginusci', TRUE),
                'chr_alias_flag' => $this->input->get_post('chr_alias_flag'),
                'var_timeformat' => $this->input->get_post('var_timeformat'), 
               
            );

            $this->db->update(DB_PREFIX . 'general_settings', $data);
          
        }

        if ($this->input->get_post('p') == "ser") {

            $cryptpwd = $this->mylibrary->cryptPass($this->input->get_post('var_smtppassword', TRUE));

            $data = array(
                'var_smtpserver' => $this->input->get_post('var_smtpserver', TRUE),
                'var_smtpusername' => $this->input->get_post('var_smtpusername', TRUE),
                'var_smtppassword' => $cryptpwd,
                'chr_smtpauthentication' => $this->input->get_post('chr_smtpauthentication', TRUE),
                'var_smtpport' => $this->input->get_post('var_smtpport', TRUE),
                'var_emailfrom' => $this->input->get_post('var_emailfrom', TRUE),
                'var_mailer' => $this->input->get_post('var_mailer', TRUE),
                'var_adminmailid' => $this->input->get_post('var_adminmailid', TRUE),
                'var_email_signature' => $this->input->get_post('var_email_signature')
            );

            $this->db->update(DB_PREFIX . 'general_settings', $data);
        }

        if ($this->input->get_post('p') == "cur") {

            $data = array(
                'var_currency' => $this->input->get_post('var_currency', TRUE),
                'var_currencysymbol' => $this->input->get_post('var_currencysymbol', TRUE)
            );

            $this->db->update(DB_PREFIX . 'general_settings', $data);
        }

        if ($this->input->get_post('p') == "seo") {

            $this->db->cache_set_common_path("application/cache/db/common/settings/");
            $this->db->cache_delete();

            if ($this->input->get_post('chr_urlrewriting') == "Y")
                $chr_urlrewriting = "Y";
            else
                $chr_urlrewriting = "N";

            $data = array(
                'var_googleanalyticcode' => $this->input->get_post('var_googleanalyticcode'),
                'var_metatitle' => $this->input->get_post('var_metatitle', TRUE),
                'var_metakeywords' => $this->input->get_post('var_metakeywords', TRUE),
                'var_metadescription' => $this->input->get_post('var_metadescription', TRUE),
                'var_commanmetatags' => $this->input->get_post('var_commanmetatags'),
                'chr_urlrewriting' => $chr_urlrewriting
            );

            $this->db->update(DB_PREFIX . 'general_settings', $data);
        }

        if ($this->input->get_post('p') == "uman") {

            if (($this->input->get_post('chr_maintenance') !== FALSE)) {
                $chr_maintenance = $this->input->get_post('chr_maintenance');
                $var_main_description = $this->input->get_post('main_description');
            } else {
                $chr_maintenance = 'N';
                $var_main_description = $this->input->get_post('main_description');
            }

            $data = array(
                'chr_maintenance' => $chr_maintenance,
                'var_main_description' => $var_main_description
            );

            $this->db->update(DB_PREFIX . 'general_settings', $data);
        }
        redirect(base_url() . 'adminpanel/settings/systemsettings?p=' . $this->input->get_post('p') . '&action=edit&msg=edit');
    }

    function selectall_systemsettings() {

        $sql = "select * from " . DB_PREFIX . "general_settings";
        $result = $this->db->query($sql);
        $row = $result->row_array();
        return $row;
    }

    function GetGridTabs($arrtab, $activeident, $display = true, $filterbyuser = '') {

        if (!$display)
            return "";
        $str = "<div class='grid-tab-box'>";

        $activeleftcurv = ADMIN_MEDIA_URL . "images/tab-active-left-curv.jpg";
        $activerightcurv = ADMIN_MEDIA_URL . "images/tab-active-right-curv.jpg";
        $activeclass = "grid-tab-current";

        $leftcurv = ADMIN_MEDIA_URL . "images/tab-left-curv.jpg";
        $rightcurv = ADMIN_MEDIA_URL . "images/tab-right-curv.jpg";
        $class = "grid-tab";

        foreach ($arrtab as $arr) {

           $abarray = array('Mail','Currency','SEO', '.Htaccess', 'Maintenance');

            // $abarray = array('SEO', '.Htaccess', 'Maintenance');
            if ($this->session->userdata('chr_user') == 'A' && in_array($arr[0], $abarray)) {
                $flag = 'false';
            } else {
                $flag = 'true';
            }

            if ($flag == 'true') {
                $sendGridFunction = "SendGridBindRequest('$arr[1]','gridbody','tab','','','$arr[2]')";
                if ($arr[2] == $activeident) {
                    $str .= "<div style='float:left'><img src='" . $activeleftcurv . "' width='7' height='26' alt='teb left curv' /></div>
            <div class='" . $activeclass . "'><a id='" . $arr[2] . "' href=\"javascript:;\" onclick=\"$sendGridFunction\">" . $arr[0] . "</a></div>
            <div style='float:left;  margin-right:2px;'><img src='" . $activerightcurv . "' width='7' height='26' alt='teb left curv' /></div>";
                } else {
                    $str .= "<div style='float:left'><img src='" . $leftcurv . "' width='7' height='26' alt='teb left curv' /></div>
            <div class='" . $class . "'><a id='" . $arr[2] . "' href=\"javascript:;\" onclick=\"$sendGridFunction\">" . $arr[0] . "</a></div>
            <div style='float:left;  margin-right:2px;'><img src='" . $rightcurv . "' width='7' height='26' alt='teb left curv' /></div>";
                }
            }
        }


        $str .= "</div>";
        if ($filterbyuser != '') {
            $str .="<div class=\"by-user\">$filterbyuser</div>";
        }

        return $str;
    }

    function selectall_logmanager() {

        $this->initialize();
        $this->Generateurl();

        $whereclause = " where chr_publish = 'Y'";
        $whereclauseids = "";

//        if (ADMIN_ID != '1' && ADMIN_ID != '2') {
            $whereclauseids .= " and fk_userglcode = '" . ADMIN_ID . "'";
//        }

        $modval = $this->input->get_post('modval');
        $chr_action = $this->input->get_post('chr_action');


        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
//                $whereclauseids .= (empty($this->searchby)) ? " and var_name like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
                 $whereclauseids .= (empty($this->searchby)) ? " and (var_modulename like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%' or var_name like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%' or var_ipaddress like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%')" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            
   
                }

            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclauseids .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        }

        if (!empty($modval)) {

            $filtermodule = explode('-', $modval);

            if ($filtermodule[1] == 'm') {

                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='N'";
            } else {
                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='Y'";
            }
        }

        if (!empty($chr_action)) {
            $whereclause .=" and  var_operation ='" . $chr_action . "'";
        }
         $modval1 = $this->input->get_post('modval');
//         print_r($modval1);
         $filtermodule = explode('-', $modval1);
        
        $type = $this->input->get_post('type');
        if (!empty($type)) {
            if ($type == 'autosearch') {
                $orderby = (isset($this->orderby)) ? 'order by ' . $this->orderby . ' ' . $this->ordertype : 'order by dt_operationdate desc';
                $searchbyVal = " like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'  and chr_publish = 'Y'";

                if ($this->searchbyVal == '0' || $this->searchbyVal == '') {
                    $this->searchbyVal = "var_name";
                }
                
               if ($filtermodule[0] != '' && $filtermodule[0] != '0') {
            $whereclauseids1 =" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename)";
        }
        
                $autoSearchQry = "select *,{$this->searchbyVal} as AutoVal  FROM " . DB_PREFIX . "logmanager where {$this->searchbyVal}  $searchbyVal $whereclauseids1  group by {$this->searchbyVal} ";
                $this->mylibrary->GetAutoSearch($autoSearchQry);
            }
        }
        
        
        
        
        $limitby = 'limit ' . $this->start . ', ' . $this->pagesize;
        $orderby = 'order by ' . $this->orderby . ' ' . $this->ordertype;
        if ($filtermodule[0] != '' && $filtermodule[0] != '0') {
            $whereclauseids1 =" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename)";
        }
        
        $query = $this->db->query("select *,DATE_FORMAT(dt_operationdate, '" . DEFAULT_DATEFORMAT . "') as Date,DATE_FORMAT(dt_operationdate,'".DEFAULT_TIMEFORMAT."') as Time from " . DB_PREFIX . "logmanager $whereclause $whereclauseids1 $whereclauseids $orderby $limitby");
//        echo $this->db->last_query($query);
        return $query;
    }

    function select_changeprofile($id) {

        $query = $this->db->get_where('users', array('int_glcode' => $id));
        $row = $query->row_array();
        return $row;
    }

    function insert_changeprofile() {
        $var_phoneno = $this->input->post('var_phoneno', TRUE);
        $var_fax = $this->input->post('var_fax', TRUE);
        $var_state = $this->input->post('var_state', TRUE);
        $var_address1 = $this->input->post('var_address1', TRUE);

        if (!empty($var_phoneno)) {
            $var_phoneno = $var_phoneno;
        } else {
            $var_phoneno = "";
        }


        if (!empty($var_fax)) {
            $var_fax = $var_fax;
        } else {
            $var_fax = "";
        }

        if (!empty($var_state)) {
            $var_state = $var_state;
        } else {
            $var_state = "";
        }

        if (!empty($var_address1)) {
            $var_address1 = $var_address1;
        } else {
            $var_address1 = "";
        }


        if ($this->input->post('pwdpassword') != '') {
            $data = array(
                 'var_fullname' => $this->input->post('var_fullname', TRUE),
//                'var_fname' => $this->input->post('txtfname', TRUE),
//                'var_lname' => $this->input->post('txtlname', TRUE),
                'var_emailid' => $this->input->post('txtemail', TRUE),
                'var_emailid1' => $this->input->post('txtemail1', TRUE),
                'var_password' => $this->mylibrary->cryptPass($this->input->post('pwdpassword', TRUE)),
            );
        } else {

            $data = array(
                 'var_fullname' => $this->input->post('var_fullname', TRUE),
//                'var_fname' => $this->input->post('txtfname', TRUE),
//                'var_lname' => $this->input->post('txtlname', TRUE),
                'var_emailid' => $this->input->post('txtemail', TRUE),
                'var_emailid1' => $this->input->post('txtemail1', TRUE),
            );
        }

        $data_owner = array(
            'var_phoneno' => $var_phoneno,
            'var_fax' => $var_fax,
            'fk_country' => $this->input->post('fk_country', TRUE),
            'var_address1' => $var_address1,
            'var_state' => $var_state,
        );

        $data1 = array(
             'var_contactusmail' => $this->input->post('var_contactusmail',TRUE),
//            'var_newsletteremail' => $this->input->post('var_newsletteremail',TRUE),
//            'var_careermail' => $this->input->post('var_careermail',TRUE)
        );
        $this->db->where('int_glcode', $this->session->userdata('userid'));

        $id = $this->db->update('users', $data);
        if (chr_usertype == 'O') {
            $this->db->update('users', $data_owner);
        }
        if (ADMIN_ID == '1' || ADMIN_ID == '2') {
            $this->db->update('general_settings', $data1);
        }
    }



    function getchangeprofiledata($id) {

        $query = "select u.*,g.*
            ,u.var_emailid as var_emailid
            ,u.var_fullname as var_fullname
            FROM " . DB_PREFIX . "users AS u, " . DB_PREFIX . "general_settings AS g 
            Where u.int_glcode = " . $id . " AND g.int_glcode = 1";

        $result = $this->db->query($query);
        $rs = $result->row_array();
        $this->load->database();
        return $rs;
    }

    function CountRows() {

        $whereclause = '';
        $whereclauseids = '';
        $whereclauseids_mod = '';

        $modval = $this->input->get_post('modval');
        $chr_action = $this->input->get_post('chr_action');

        if (!empty($modval)) {

            $filtermodule = explode('-', $modval);

            if ($filtermodule[1] == 'm') {
                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='N'";
            } else {
                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='Y'";
            }
        }


        if (!empty($chr_action)) {
            $whereclause .=" var_operation ='" . $chr_action . "'";
        }

        if (trim($this->searchtxt) != '' || $this->filterby != '0') {
            if ($this->searchtxt != '') {
                   $whereclauseids .= (empty($this->searchby)) ? " and (var_modulename like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%' or var_name like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%' or var_ipaddress like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%')" : " and $this->searchby like '%" . addslashes(htmlspecialchars_decode($this->searchtxt)) . "%'";
            
             }
            if ($this->filterby != '0') {
                $filterarray = explode('-', $this->filterby);
                if (!empty($filterarray[0]) && !empty($filterarray[1])) {
                    $whereclause .="  and  $filterarray[0] = '$filterarray[1]'";
                }
            }
        } else {
            $whereclauseids = '';
        }
        
        $modval1 = $this->input->get_post('modval');
         $filtermodule = explode('-', $modval1);
         if ($filtermodule[0] != '' && $filtermodule[0] != '0') {
            $whereclauseids1 =" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename)";
        }
//        $sqlCountPages = "select * FROM " . DB_PREFIX . "logmanager where chr_publish = 'Y' $whereclause $whereclauseids1  $whereclauseids";
//        $query = $this->db->query($sqlCountPages);
//        $rs = $query->num_rows();
//        return $rs;
    }

         function getalldata($tablename = "logmanager", $modval = "", $pagesize = "30") {

        $selectids = $this->input->get_post('chkids');
        $selectarray = explode(',', $selectids);
        
        $whereclause = "chr_publish = 'Y'";

        if ($this->input->get_post('searchbytxt', TRUE) == 'var_name') {
                $searchdata = $this->input->get_post('searchtxt', TRUE);
               $whereclause .= " AND var_name LIKE '%" .   addslashes($searchdata) . "%'";
            } 
            
             if ($this->input->get_post('searchbytxt', TRUE) == 'var_modulename') {
                $searchdata = $this->input->get_post('searchtxt', TRUE);
               $whereclause .= " AND var_modulename LIKE '%" .   addslashes($searchdata) . "%'";
            } 
            
             if ($this->input->get_post('searchbytxt', TRUE) == 'var_ipaddress') {
                $searchdata = $this->input->get_post('searchtxt', TRUE);
               $whereclause .= " AND var_ipaddress LIKE '%" .   addslashes($searchdata) . "%'";
            } 
            
        if (trim($this->searchtxt) != '') {
            $whereclause .= ($this->searchby == '0') ? " and($this->searchbyVal like '%" . $this->addSlashes($this->searchtxt) . "%') " : " and $this->searchby like '%" . $this->addSlashes($this->searchtxt) . "%'";
        }

        if (!empty($modval)) {
            $this->modval = $modval;
        }

        if ($this->modval != '0' && $this->modval != '') {
            $filtermodule = explode('-', $this->modval);

            if ($filtermodule[1] == 'm') {

                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='N'";
            } else {
                $whereclause .=" and FIND_IN_SET('" . $filtermodule[0] . "',fk_modulename) and chr_custom='Y'";
            }
        }
        if (!empty($this->pagesize)) {
            $pageSize = $this->pagesize;
        }
       
        if ($selectids == '') {
                 $sql = "SELECT var_modulename as 'Module Name',var_name as Title,var_fname as 'User Name',DATE_FORMAT(dt_operationdate, '" . DEFAULT_DATEFORMAT . "') as Date,DATE_FORMAT(dt_operationdate,'".DEFAULT_TIMEFORMAT."') as Time,var_ipaddress as 'Ip Address',CASE When var_operation='I' THEN 'Insert' WHEN var_operation='U' THEN 'Update' WHEN var_operation='D' THEN 'Delete' END as Operations from " . DB_PREFIX . "logmanager where  $whereclause order by int_glcode desc LIMIT 0,$pageSize";   
        }
        else
        {
                  $sql="SELECT var_modulename as 'Module Name',var_name as Title,var_fname as 'User Name',DATE_FORMAT(dt_operationdate, '" . DEFAULT_DATEFORMAT . "') as Date,DATE_FORMAT(dt_operationdate,'".DEFAULT_TIMEFORMAT."') as Time,var_ipaddress as 'Ip Address',CASE When var_operation='I' THEN 'Insert' WHEN var_operation='U' THEN 'Update' WHEN var_operation='D' THEN 'Delete' END as Operations FROM " . DB_PREFIX . "logmanager WHERE  $whereclause and `int_glcode` IN (" . $selectids . ") and $whereclause  order by int_glcode"; 
        }
   
        return $sql;
    }

    function delete_row() {
        $tablename = DB_PREFIX . 'logmanager';
        $deleteids = $this->input->get_post('dids');
        $deletearray = explode(',', $deleteids);
        $totaldeletedrecords = count($deletearray);
        $is_assigned = 0;
        $delcount = 0;

        for ($i = 0; $i < $totaldeletedrecords; $i++) {
            $data = array('chr_publish' => 'N');
            $this->db->where('int_glcode', $deletearray[$i]);
            $this->db->update($tablename, $data);
             
        }
    }
    
    function delete_All() {
        $tablename = DB_PREFIX . 'logmanager';

        $sql = $this->db->truncate($tablename);  
    }

    function Bindmodule() {

        $modval = $this->input->get_post('modval');
        

        if (!empty($modval)) {
            $selected_array = $modval;
        } else {
            $selected_array = 0;
        }
         if ($this->session->userdata('userid') != 1) {
                   $whereclause .= " and int_glcode NOT IN(9,98,99,139)";
                }
                $whereclause .= " and int_glcode NOT IN(140)";
        $show_in_trashmanager = " and chr_adminpanel_module='Y'";

        $module = "select * from " . DB_PREFIX . "modules where chr_delete='N' and chr_publish='Y' and chr_filterflag='Y' $show_in_trashmanager $whereclause order by chr_pro_modulename asc";
        $rs1 = $this->db->query($module);

        $custmodule = "select * from " . DB_PREFIX . "pages where chr_custom='Y' and chr_delete='N' and chr_publish='Y' ";
        $rs2 = $this->db->query($custmodule);

        $display = "<div class=\"new-search-show-all\">";
        $display .="<select name=\"module\" id=\"module\" class=\"more-textarea\" style=\"width:130px;\" onchange=\"SendGridBindRequest('$this->urlwithpara&filtering=Y&pagenumber=1','gridbody','MVF')\">";
        $display .="<option value=\"0\">-- Filter By Module --</option>";

        foreach ($rs1->result() as $row) {
            
             if($this->session->userdata('userid') == '1'  || ($row->chr_pro_modulename!='Group Access')) {
                 
             
            $p = ($row->int_glcode . '-m' == $selected_array) ? 'selected' : '';
            
            $display.="<option value=" . $row->int_glcode . '-m' . " " . $p . ">" . $row->chr_pro_modulename . "</option>";
        }
        }
        $display.="</select></div>";
        return $display;
    }

    function getoperationcmb() {

        $chr_action = $this->input->get_post('chr_action');

        $display = "<div class=\"new-search-show-all\">";
        $display .="<select name=\"chr_action\" id=\"chr_action\" class=\"more-textarea\" style=\"width:140px\" onchange=\"SendGridBindRequest('" . $this->urlwithpara . "','gridbody','APP1')\">";
        $display .="<option value=\"0\">--ALL OPERATIONS--</option>";


        if (!empty($chr_action)) {
            $display.="<option value='I' " . (($chr_action == 'I') ? "selected" : "" ) . ">INSERT</option>";
            $display.="<option value='U' " . (($chr_action == 'U') ? "selected" : "" ) . ">UPDATE</option>";
            $display.="<option value='D' " . (($chr_action == 'D') ? "selected" : "" ) . ">DELETE</option>";
        } else {
            $display.="<option value='I'>INSERT</option>";
            $display.="<option value='U'>UPDATE</option>";
            $display.="<option value='D'>DELETE</option>";
        }


        return $display.="</select></div>";
    }
    
    function DeleteHits() {
        $tablename = DB_PREFIX . 'pages';               
        $deleteids = $this->input->get_post('hitsid');
        if ($deleteids == 'A') {
            $Data = array("int_pagehits" => 0,
                "int_mobhits" => 0);
        } else if ($deleteids == 'W') {

            $Data = array("int_pagehits" => 0);
        } else if ($deleteids == 'M') {
            $Data = array("int_mobhits" => 0);
        } else {
            
        }
        $this->db->update($tablename, $Data);
      //  echo $this->db->last_query();exit;
    }
    
    
}

?>
