<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Adminpanel_dashboard extends Adminpanel_Controller {

    function __construct() {
        parent::__construct();
        
        
        header('Cache-Control: no-store, no-cache, must-revalidate');
        header('Cache-Control: post-check=0, pre-check=0',false);
        header('Pragma: no-cache'); 
        $this->load->model('dashboard_model', 'module_model');
    }

    public function index() {
        
//          $this->page_hits();
//          $this->load_contactleads();
//          $this->load_newsletterleads();
    if($this->permissionArry['reminders']['View'] == 'Y'){
        }
        $this->viewData['dashboardTab'] = TRUE;
        $this->viewData['adminContentPanel'] = 'adminpanel/dashboard_tpl';
        $this->load_view();

    }
  public function load_contactleads() {

        $this->load->model('contactusleads/contactusleads_model');
        $this->contactusleads_model->start = 0;
        $this->contactusleads_model->pagesize = 5;
        $this->contactusleads_model->getdatapage = "dashboard";
        $query = $this->contactusleads_model->selectAll();
        $return['recentlycontactArray'] = $query->result();
        $return['recentlycontactrecord'] = $query->num_rows();
        $this->viewData['contactusleads'] = $return;
        
    }
  public function load_newsletterleads() {

        $this->load->model('newsletterleads/newsletterleads_model');
        $this->newsletterleads_model->start = 0;
        $this->newsletterleads_model->pagesize = 5;
        $this->newsletterleads_model->getdatapage = "dashboard";
        $query = $this->newsletterleads_model->selectAll();
        $return['recentlyNewsletterArray'] = $query->result();
        $return['recentlyNewsletterrecord'] = $query->num_rows();
        $this->viewData['newsletterleads'] = $return;
        
    }
      public function statuschange() {
        $this->module_model->statuschanges($_REQUEST['id'], $_REQUEST['recordid']);
    }
  
     public function page_hits() {

        $this->load->model('pages/pages_model');
        $this->pages_model->start = 0;
        $this->pages_model->pagesize = 5;
        $this->pages_model->getdatapage = "dashboard";
         $list = $this->pages_model->get_pagehitsdata();
        $return['recentlyArray1'] = $list->result();
        $return['recentlyrecord1'] = $list->num_rows();
        $this->viewData['pages'] = $return;
    }
    
      public function autoalias() {
          echo "sadcvsabkvbsakv";exit;
        $param['alias'] = $_REQUEST['alias'];
        echo $this->mylibrary->autoAlias2($param['alias']);
        exit;
    }
  
    public function do_logout() {

        $this->session->sess_destroy();
        redirect(base_url() . 'adminpanel/login');
    }
    
   function loadoutput() {

        $data['dashboardTab'] = true;
        if ($this->input->get_post['ajax'] == "Y") {
            echo $this->parser->parse('adminpanel/dashboard_tpl', $data);
            exit;
        } else {
            $this->load->view('adminpanel/templates/header_tpl', $data);
            $this->load->view('adminpanel/templates/leftpanel_tpl');
            $this->load->view('adminpanel/dashboard/dashboard_tpl', $data);
            $this->load->view('adminpanel/templates/footer_tpl');
        }
    }
   

}

?>