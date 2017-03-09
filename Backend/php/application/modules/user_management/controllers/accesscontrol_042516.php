<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class accesscontrol extends AdminPanel_Controller {

    function __construct() {
        parent::__construct();

        $this->load->model('accesscontrol_model', 'module_model');            // MODULE MODEL
        $this->main_tpl = 'adminpanel/accesscontrol/accesscontrol_tpl';                 // MODULE MAIN VIEW
        $this->add_tpl = 'adminpanel/accesscontrol/accesscontrol_add_tpl';              // MODULE ADD  VIEW
        $this->module_url = MODULE_URL . 'accesscontrol/';                   // MODULE URL
    }

    public function index() {
//        $this->set_message();
        $this->load_data();
        if ($this->input->get_post('ajax') == 'Y') {
            echo $this->parser->parse($this->main_tpl, $this->viewData);
            exit;
        }
        $this->viewData['accesscontrolTab'] = true;
        $this->viewData['adminContentPanel'] = $this->main_tpl;
        $this->load_view();
    }

    public function add() {
        $this->set_message();
        $eid = $this->input->get_post('eid');
        if (!empty($eid)) {
            
            $this->viewData['eid'] = $eid;
            $row = $this->module_model->select($eid);
            if (empty($row)) {
                redirect($this->module_url . 'add');
            }
            $this->viewData['row'] = $row;

            $action = $this->module_url . 'update?' . $_SERVER['QUERY_STRING'];
        } else {
            $action = $this->module_url . 'insert';
        }
        $this->viewData['action'] = $action;

        $University_Combo = $this->module_model->University_Combo($row['fk_university']);
        $this->viewData['University_Combo'] = $University_Combo;

        $this->viewData['accesscontrolAddTab'] = true;
        $this->viewData['adminContentPanel'] = $this->add_tpl;
        $this->load_view();
    }

    function phone_check() {

        $phoneno = $this->input->get_post('var_phoneno', true);

        $regex = '/^((\+)?[1-9]{1,2})?([-\s\.])?(\(\d\)[-\s\.]?)?((\(\d{1,4}\))|\d{1,4})(([-\s\.])?[0-9]{1,12}){1,2}(\s*(ext|x)\s*\.?:?\s*([0-9]+))?$/';
        if ($phoneno == '') {
            return true;
        } else if ($phoneno <= 0) {
            $this->form_validation->set_message('phone_check', 'Phone number is not valid.');
            return false;
        } else if (!preg_match($regex, $phoneno)) {
            $this->form_validation->set_message('phone_check', 'Phone number is not valid.');
            return false;
        } else {
            return true;
        }
    }

    public function insert() {

        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('fk_university', 'University Name', 'callback_handle_upload');
        $this->form_validation->set_rules('var_password', 'Password', 'required|min_length[5]');

        $this->form_validation->set_rules('var_cnfpassword', 'Confirm Password', 'required|matches[var_password]|min_length[5]');
        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');

        if ($this->form_validation->run($this) == FALSE) {
            $this->add();
        } else {

            $id = $this->module_model->insert();
            $this->redirect_to_page($id, 'add');
        }
    }

    function handle_upload($str) {
        if ($str == '') {
            $this->form_validation->set_message('handle_upload', 'Please select Group Name.');
            return FALSE;
        } else {
            return TRUE;
        }
    }

    function unique_email($str) {
        $ID = $this->input->get_post('ehintglcode');
        $query = $this->db->query("select * from " . DB_PREFIX . "users where var_emailid = '$str' and int_glcode!=$ID and chr_delete='N'");

        if ($query->num_rows() > '0') {
            $this->form_validation->set_message('unique_email', 'Please enter another User ID this email ID already exists.');
            return FALSE;
        } else {
            return TRUE;
        }
    }

    function password_match($str) {



        if ($str == $_REQUEST['var_password']) {

            return true;
        } else {

            $this->form_validation->set_message('password_match', CP_PASSWORD_VALIDATION_MATCH);
            return false;
        }
    }

    public function update() {

        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('fk_university', 'University Name', 'callback_handle_upload');
        $this->form_validation->set_rules('var_password', 'Password', 'min_length[5]');
        $this->form_validation->set_rules('var_cnfpassword', 'Confirm Password', 'callback_password_match');

        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');

        if ($this->form_validation->run($this) == FALSE) {
            $this->add();
        } else {

            $this->module_model->update();
            $this->redirect_to_page($this->input->get_post('ehintglcode'), 'edit');
        }
    }

    public function load_data() {

        $query = $this->module_model->selectAll();

        $this->viewData['counttotal'] = $query->num_rows();
        $this->viewData['selectAll'] = $query->result();

        $tmpsetsortvar = trim('setsortimg' . $this->module_model->orderby);
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

//        if (!empty($btnsaveandc_x)) {
//            redirect($this->module_model->addpagename . 'eid=' . $id);
//        } else {
//            redirect($this->module_model->urlwithpara);
//        }
         $btnsaveandc = $this->input->get_post('btnsaveandc');
        if ($btnsaveandc == '1') {
            redirect($this->module_model->addpagename . 'eid=' . $id);
        } else {
            redirect($this->module_model->urlwithpara);
        }
    }

    public function delete() {

        $this->module_model->delete_row();
        $this->load_data();

        echo $this->parser->parse($this->main_tpl, $this->viewData);
        exit;
    }

    /*     * **************************************************************************** */

    public function Check_Email() { // check if email address all ready exits or not.
        echo $this->module_model->Check_Email($this->input->get_post('user_email'), $this->input->get_post('eid'), $this->input->get_post('domainname'));
        exit;
    }
 public function Check_user_Name() { // check if email address all ready exits or not.
     
     echo $this->module_model->Check_user_Name($this->input->get_post('user_name'), $this->input->get_post('eid'));
        exit;
    }
    public function selectUniversityInfo() { // check if email address all ready exits or not.
        echo $this->module_model->selectUniversityInfo($this->input->get_post('uni_id'));
        exit;
    }

}

?>