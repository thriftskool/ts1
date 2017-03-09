<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
/* Author: Jorge Torres
 * Description: Home controller class
 * This is only viewable to those members that are logged in
 */

class Adminpanel_post_category extends AdminPanel_Controller {

    function __construct() {
        parent::__construct();

        $this->load->model('post_category_model', 'module_model');                       // MODULE MODEL
        $this->main_tpl = 'adminpanel/post_category_tpl';                 // MODULE MAIN VIEW
        $this->add_tpl = 'adminpanel/post_category_add_tpl';              // MODULE ADD  VIEW
        $this->module_url = base_url() . 'adminpanel/post_category/';          // MODULE URL    
    }

    public function index() {

        $this->set_message();
        $this->load_data();
        $this->viewData['moduleurl'] = $this->module_url;

        if ($this->input->get_post('ajax') == 'Y') {
            echo $this->parser->parse($this->main_tpl, $this->viewData);
            exit;
        }

        $this->viewData['commonPDF'] = true;
        $this->viewData['adminContentPanel'] = $this->main_tpl;
        $this->load_view();
    }

    public function add() {

        $this->set_message();

        $eid = $this->input->get_post('eid');

        if (!empty($eid)) {

            $this->viewData['eid'] = $eid;

            $row = $this->module_model->select_Rows($eid);
            if (empty($row)) {
                redirect($this->module_url . 'add');
            }
            $this->viewData['row'] = $row;

            $action = $this->module_url . 'update?' . $_SERVER['QUERY_STRING'];
        } else {
            $action = $this->module_url . 'insert';
        }
        $this->viewData['action'] = $action;
        
//        $University_Combo = $this->module_model->University_Combo($row['fk_university']);
//        $this->viewData['University_Combo'] = $University_Combo;

        $this->viewData['commonPDFAdd'] = true;
        $this->viewData['adminContentPanel'] = $this->add_tpl;
        $this->load_view();
    }

    public function insert() {
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('var_categoryname', 'Title', 'trim|required');
        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');
        if ($this->form_validation->run($this) == FALSE) {
            $this->add();
        } else {
            $id = $this->module_model->insert();
//            echo $id; die;
            if ($id == 'true') {
                $this->session->set_flashdata('msg', 'notsaved');
                redirect($this->module_url . 'add?msg=msg');
            }
            $this->redirect_to_page($id, 'add');
        }
    }

    public function update() {

        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('var_categoryname', 'Title', 'trim|required');
        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');
          if ($this->form_validation->run($this) == FALSE)
        { 
            $this->add();
        }        
        else{        
        $this->module_model->update();
        
        $this->redirect_to_page($this->input->get_post('ehintglcode'), 'edit');
        }
        
//        if ($this->form_validation->run($this) == FALSE) {
//            $this->add();
//        } else {
//            $id = $this->module_model->update();
//
//            if ($id == '1') {
//                $this->session->set_flashdata('msg', 'notedited');
//
//                $eid = $this->input->get_post('eid');
//                redirect(base_url() . 'adminpanel/post_category/add?' . 'eid=' . $eid);
//            } else {
//                $this->redirect_to_page($this->input->get_post('ehintglcode'), 'edit');
//            }
//        }
    }

    public function load_data() {

        $query = $this->module_model->selectAll();

        $this->viewData['counttotal'] = $query->num_rows();
        $this->viewData['selectAll'] = $query->result();

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
            }
        }
    }


    public function redirect_to_page($id, $msg_type) {

        $this->module_model->initialize();
        $this->module_model->Generateurl();

        $this->session->set_flashdata('msg', $msg_type);
       
        $btnsaveandc_x = $this->input->get_post('btnsaveandc_x');
//   print "<pre/>";
//        print_r($_REQUEST);
//        die;
        $btnsaveandc = $this->input->get_post('btnsaveandc');
     if($btnsaveandc == '1'){
         redirect($this->module_model->addpagename . 'eid=' . $id);   
     }else{
          redirect($this->module_model->urlwithpara);
     }
        
        
//        if (!empty($btnsaveandc_x)) {
//            redirect($this->module_model->addpagename . 'eid=' . $id);
//        } else {
//            redirect($this->module_model->urlwithpara);
//        }
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

    function ChangeFeatured() {
        $this->module_model->Featuredstatuschanges($this->input->get_post('featureid', TRUE), $this->input->get_post('recordid', TRUE));
    }

}

?>