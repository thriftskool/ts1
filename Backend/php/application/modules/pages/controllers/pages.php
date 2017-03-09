<?php

class pages extends Front_Controller {

    function __construct() {
        parent::__construct();
        
        $this->load->model('pages_model', 'module_model');
        $this->module_url = FRONT_MODULE_URL;
        $this->leftpanel = 'front/leftpanel_tpl';
         $this->pages_tpl = 'front/pages_tpl';
    }
    
    public function index() {
       
        $this->load_data();
        
           $CurrentPageData = $this->common_model->getpagedata_content(RECORD_ID, "pages");
           $CurrentPageTitle = $this->common_model->getpagedata_Title(RECORD_ID, "pages");
//        print_r($CurrentPageData);exit;
        $this->viewData['Title'] = $CurrentPageTitle['var_pagename'];
        $this->viewData['ContentPanel'] = 'front/pages_tpl';
     
        $this->load_view();
    }
    
    

    public function load_data() {
//        $this->viewData['LeftPanelPagesData'] = $this->common_model->getInnerLeftPanelCMSData();
    }
    
    
    
    public function orderupdate() {
        $this->pages_model->updatedisplayorder();
        $this->load_data();

        echo $this->parser->parse($this->main_tpl, $this->viewData);
        exit;
    }
     
    function sendMailtoNewsletterEmail($emailid) {
       
        $ajax = $this->input->get_post('ajax', true);

        if ($ajax == 'Y') {
          
                echo $this->module_model->insert_newsletterdata();
                exit;
        }
        
        
    }
    
     function check_email_address() {          
        $emailid = $this->input->get_post('emailid', true);
        
//        echo $emailid; exit;
        echo $this->module_model->check_email_exit($emailid);
        exit;
    }
}

?>