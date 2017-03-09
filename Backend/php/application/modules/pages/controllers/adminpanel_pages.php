<?php

class Adminpanel_pages extends AdminPanel_Controller {

    public function __construct() {
        parent::__construct();

        if($_REQUEST['ajax']!='Y' && ($this->uri->segment(3)!='checksessionstatus' && $this->uri->segment(3)!='openpopup' && $_REQUEST['sub']!='validlogin') )
        {
            $this->check_isvalidated();
        }
        $this->load->model('pages_model', 'module_model');           // MODULE MODEL
        $this->main_tpl = 'adminpanel/page_tpl';                     // MODULE MAIN VIEW
        $this->add_tpl = 'adminpanel/pages_add_tpl';                 // MODULE ADD  VIEW
        $this->module_url = MODULE_URL;                              // MODULE URL

        $this->data = $this->module_model->general();
        $this->load->library('parser');
        $this->load->helper(array('form', 'url'));
        $this->viewData['pagesTab'] = true;
        $this->popup_url = 'adminpanel/popup_tpl';
    }

    private function check_isvalidated() {
        if (!$this->session->userdata('validated')) {
            redirect('login');
        }
    }

    function index() {

        $this->set_message();
        $this->load_data();
         $this->viewData['moduleurl'] = $this->module_url; 

        if ($this->input->get_post('ajax') == 'Y') {
            echo $this->parser->parse($this->main_tpl, $this->viewData);
            exit;
        }

        $this->viewData['pagesTab'] = true;
        $this->viewData['adminContentPanel'] = $this->main_tpl;
        $this->load_view();
    }
    
    function checksessionstatus()
    {
        if($this->session->userdata('userid')!='')
        {
            echo "1";
        }
        else
        {
            echo "0";
        }
        exit;
    }

    function add() {
        $this->set_message();
        $eid = $this->input->get_post('eid');
        if (!empty($eid)) {
            $this->viewData['eid'] = $eid;
            $row = $this->module_model->select_Rows($eid);
            $CountChild = $this->module_model->get_child($eid);
            if (empty($row)) {
               $redirect = redirect($this->module_url . '/add');
            }
            $this->viewData['row'] = $row;
            $this->viewData['CountChild'] = $CountChild;
            $action = $this->module_url . 'update?' . $_SERVER['QUERY_STRING'];
            $data_module_comb = $this->module_model->getEnablemodules('fk_module', $row['var_pagetype']);
        } else {
            $action = $this->module_url . 'insert';
            $data_module_comb = $this->module_model->getEnablemodules('fk_module', '');
        }
        $this->viewData['action'] = $action;
        $data_page_comb = $this->module_model->Bindpageshierarchy('fk_pages', (!empty($row['fk_pages']) ? $row['fk_pages'] : ''), 'add-new-user-textarea2', '1');
        $this->viewData['pagetree'] = $data_page_comb;
        $this->viewData['module_combo'] = $data_module_comb;
        $this->viewData['pagesAddTab'] = true;
        $this->viewData['adminContentPanel'] = $this->add_tpl;
        $this->load_view();
    }
    
   
    public function insert() {
        $eid = $this->input->get_post('eid');
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('var_title', 'Title', 'trim|required');
         if($eid != '16'){
        $this->form_validation->set_rules('var_alias', 'Alias', 'trim|required');
        }
        $this->form_validation->set_rules('int_displayorder', 'display order', 'trim|required|greater_than[0]');
        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');

        if ($this->form_validation->run($this) == FALSE) {
            $this->add();
        } 
        else{
        $filename = time() . $_FILES['userfile']['name'];
        $filename = str_replace(' ', "_", $filename);
        $tmp_name = $_FILES["userfile"]["tmp_name"];
        $uploads_dir = 'upimages/pages';
        move_uploaded_file($tmp_name, $uploads_dir . "/" . $filename);

        $id = $this->module_model->insert();
        $this->redirect_to_page($id, 'add');
       }
    }

    public function update() {
       $eid = $this->input->get_post('eid');
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('var_title', 'Title', 'trim|required');
           if($eid != '16'){
        $this->form_validation->set_rules('var_alias', 'Alias', 'trim|required');
        }    $this->form_validation->set_rules('int_displayorder', 'display order', 'trim|required|greater_than[0]');
        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');
        if ($this->form_validation->run($this) == FALSE) {
            $this->add();
        } 
        else{        
        $filename = time() . $_FILES['userfile']['name'];
        $filename = str_replace(' ', "_", $filename);
        $tmp_name = $_FILES["userfile"]["tmp_name"];
        $uploads_dir = 'upimages/pages';
        move_uploaded_file($tmp_name, $uploads_dir . "/" . $filename);

        $this->module_model->update();
        $this->redirect_to_page($this->input->get_post('ehintglcode'), 'edit');
        }
    }

    public function load_data() {
        $this->viewData['showall'] = $this->module_model->selectAll();
        $tmpsetsortvar = trim('setsortimg' . $this->module_model->orderby);
        $tmpsetsortvar = str_replace(".", "_", $tmpsetsortvar);
        $this->viewData[$tmpsetsortvar] = $this->module_model->sortvar;
        $this->viewData['HeaderPanel'] = $this->module_model->HeaderPanel();
        $this->viewData['PagingTop'] = $this->module_model->PagingTop();
        $this->viewData['PagingBottom'] = $this->module_model->PagingBottom();
    }

    public function set_message() {

        $msg = $this->session->flashdata('msg');

        if (!empty($msg)) {
            if ($msg == 'add') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully saved.");
            } else if ($msg == 'edit') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully edited and saved.");
            }else if ($msg == 'notsaved') {
               $this->viewData['messagebox'] = $this->mylibrary->message("Sorry! External link file path is not found insert try again.");  
            }  else if ($msg == 'notedited') {
               $this->viewData['messagebox'] = $this->mylibrary->message("Sorry! External link file path is not found update try again.");  
            } 
        }
    }

    public function redirect_to_page($id, $msg_type) {
        $this->module_model->initialize();
        $this->module_model->Generateurl();
        $this->session->set_flashdata('msg', $msg_type);
        $btnsaveandc_x = $this->input->get_post('btnsaveandc_x');
        if (!empty($btnsaveandc_x)) {
            redirect($this->module_model->addpagename . 'eid=' . $id);
        } else {
            redirect($this->module_model->urlwithpara);
        }
    }

    public function orderupdate() {
        $this->module_model->updatedisplayorder();
        $this->load_data();
        echo $this->parser->parse($this->main_tpl, $this->viewData);
        exit;
    }

    public function UpdatePublish() {
       $this->module_model->updatedisplay();
    }

    public function delete() {
        $this->module_model->delete_row();
        $this->load_data();
        echo $this->parser->parse($this->main_tpl, $this->viewData);
        exit;
    }

    function cmsplugin() {
        $query = $this->module_model->selectAll_commonfiles();
        $this->viewData['counttotal'] = $query->num_rows();
        $this->viewData['selectAll'] = $query->result();
        echo $this->parser->parse('adminpanel/cmsplugin_tpl', $this->viewData);
        exit;
    }

    function updateread() {
        echo $this->module_model->updateread();
    }

    function openpopup() {
        if ($this->input->get_post('sub') == 'validlogin') {
            $this->input->get_post('var_password');
            $Total = $this->module_model->checkvalid($this->input->get_post('userId'),$this->input->get_post('var_password'));
            if ($Total > 0) {
                echo "1";exit;
            } else {
                $this->session->sess_destroy();
                echo "0";exit;
            }
        } else {
            echo $this->parser->parse($this->popup_url);
            exit;
        }
    }
    
    public function issameAlias() {
        $this->mylibrary->issameAlias();
    }
    
    function getalias(){
        $this->mylibrary->getalias();
    }
    
    public function download_pdf() {

        $file = $this->input->get_post('file');
        $this->load->helper('download');
        $data = file_get_contents(base_url() . 'upimages/pages/' . $file);
        force_download($file, $data);
        exit;
    }
}
?>