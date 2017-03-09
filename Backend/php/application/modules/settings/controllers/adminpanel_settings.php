<?php

class AdminPanel_settings extends AdminPanel_Controller {

    public function __construct() {
        parent::__construct();
        
        $this->load->model('settings_model', 'module_model');                                      // MODULE MODELa

        $this->changeprofile_tpl = 'adminpanel/changeprofile_tpl';               // MODULE CHANGE PROFILE VIEW
//        $this->systemsetting_url = 'AdminPanel/systemsettings_tpl';             // MODULE SYESTEM SETTING VIEW
//        $this->logmanager_url = 'AdminPanel/logmanager_tpl';                 // MODULE LOG MANAGER VIEW
    }

    public function index() {

        $this->set_message();

        $this->viewData['changeprofileTab'] = true;

        $getdata = $this->module_model->getchangeprofiledata($this->session->userdata('userid'));

        $this->viewData['var_fullname'] = $getdata['var_fullname'];
//        $this->viewData['var_fname'] = $getdata['var_fname'];
//        $this->viewData['var_lname'] = $getdata['var_lname'];
        $this->viewData['var_emailid'] = $getdata['var_emailid'];
        $this->viewData['var_emailid1'] = $getdata['var_emailid1'];
        $this->viewData['var_phoneno'] = $getdata['var_phoneno'];
        $this->viewData['var_fax'] = $getdata['var_fax'];
        $this->viewData['fk_country'] = $getdata['fk_country'];
        $this->viewData['var_address1'] = $getdata['var_address1'];
        $this->viewData['var_state'] = $getdata['var_state'];

        $this->viewData['var_orderleadsemail'] = $getdata['var_orderleadsemail'];
         $this->viewData['var_suppliername'] = $getdata['var_suppliername'];
          $this->viewData['var_contactusmail'] = $getdata['var_contactusmail'];
            $this->viewData['var_newsletteremail'] = $getdata['var_newsletteremail'];
            $this->viewData['var_careermail'] = $getdata['var_careermail'];
        $this->viewData['adminContentPanel'] = $this->changeprofile_tpl;
        $this->load_view();
    }

    function password_match($str) {

        if ($str == $_REQUEST['pwdpassword']) {
            return true;
        } else {
            $this->form_validation->set_message('password_match', 'Both Password not match.');
            return false;
        }
    }

    function Password_Contain($str) {

        if ($str != '') {
            
        } else {
            return TRUE;
        }
    }

    public function insert_changeprofile() {

        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('var_fullname', 'Full Name', 'trim|required');
//        $this->form_validation->set_rules('txtfname', 'First Name', 'trim|required');
        $this->form_validation->set_rules('txtemail', 'Login ID', 'trim|required|valid_email');
        $this->form_validation->set_rules('txtemail1', 'Personal Email ID', 'trim|required|valid_email');
        $this->form_validation->set_rules('pwdpassword', 'New Password', 'callback_Password_Contain');
        $this->form_validation->set_rules('pwdconfirmpassword', 'Confirm Password', 'callback_password_match');
//        if ($this->session->userdata('chr_user') == 'N' || $this->session->userdata('chr_user') == 'A') {
//        $this->form_validation->set_rules('var_contactusmail', 'Contact Us Email ID', 'trim|required|valid_emails');
//        $this->form_validation->set_rules('var_newsletteremail', 'Newsletter Email ID', 'trim|required|valid_emails');
//        }
        if ($this->form_validation->run($this) == FALSE) {
            $this->index();
        } else {
            $this->module_model->insert_changeprofile();
            $this->redirect_to_page($this->input->get_post('ehintglcode'), 'edit');
        }
    }


    /*     * ********************************** SYESTEM SETTING ***************************************** */

    function handle_url($str) {
        if (filter_var($str, FILTER_VALIDATE_URL)) {
            return TRUE;
        } else {
            $this->form_validation->set_message('handle_url', SET_VALID_URL_MSG);
            return FALSE;
        }
    }

    function perc_checking($str) {


        if ($str > 100 || $str < 0) {
            $this->form_validation->set_message('perc_checking', SET_VALID_PERG_MSG);
            return FALSE;
        } else {
            return TRUE;
        }
    }

//    function savesystemsettings() {
//
//
//        $this->load->helper(array('form', 'url'));
//        $this->load->library('form_validation');
//
//        if ($this->input->get_post('p') == 'gen') {
//            $this->form_validation->set_rules('var_sitename', 'site name', 'trim|required');
//            $this->form_validation->set_rules('var_sitepath', 'site path', 'trim|required');
////            $this->form_validation->set_rules('var_pagesize', 'page size', 'trim|required|integer|greater_than[9]|less_than[51]');
//            $this->form_validation->set_rules('var_facebook_link', 'facebook link', 'callback_handle_url');
//
//        } else if ($this->input->get_post('p') == 'ser') {
//            $this->form_validation->set_rules('var_mailer', 'mailer', 'trim|required');
//            $this->form_validation->set_rules('var_smtpserver', 'SMTP Server Name', 'trim|required');
//            $this->form_validation->set_rules('var_smtpusername', 'SMTP User Name', 'trim|required|valid_email');
//            $this->form_validation->set_rules('var_smtppassword', 'SMTP Password', 'trim|required|min_length[5]');
//            $this->form_validation->set_rules('var_smtpport', 'smtp port', 'trim|required|integer');
//            $this->form_validation->set_rules('var_adminmailid', 'sender email id', 'trim|valid_email');
//        } else if ($this->input->get_post('p') == 'cur' || $this->input->get_post('p') == 'seo' || $this->input->get_post('p') == 'uman') {
//            $this->set_message();
//            $this->module_model->edit_systemsettings();
//            $this->redirect_to_page($this->input->get_post('p'), 'edit');
//        }
//        $this->form_validation->set_error_delimiters('<div class="dverrorcustom"><div class="Alertconfirmation-div">', '</div></div>');
//        
//         if ($this->form_validation->run($this) == FALSE) {
//
//            $this->systemsettings();
////            redirect(base_url() . 'AdminPanel/settings/systemsettings?p=' . $this->input->get_post('p') . '&action=edit&msg=edit');
//        } else {
//            $this->set_message();
//            $this->module_model->edit_systemsettings();
//            $this->redirect_to_page($this->input->get_post('p'), 'edit');
//        }
//    }
//
//    public function systemsettings() {
//        
//        $this->set_message();
//        if ($this->session->userdata('chr_user') != 'N') {
//            redirect(ADMINPANEL_HOME_URL);
//        }
//
//        $this->module_model->Generateurl();
//
//        $this->viewData['settingsTab'] = true;
//
//        $this->viewData['row'] = $this->module_model->selectall_systemsettings();
//
////        echo "<pre/>";
////        print_r($this->module_model->selectall_systemsettings());exit;
//
//        $gridtabarray = array(array("General", $this->module_model->urlwithoutmoduleid . "&p=gen", "gen"),
//            array("Mail", $this->module_model->urlwithoutmoduleid . "&p=ser", "ser"),
//            array("Currency", $this->module_model->urlwithoutmoduleid . "&p=cur", "cur"),
//            array("SEO", $this->module_model->urlwithoutmoduleid . "&p=seo", "seo"),
//            array("Maintenance", $this->module_model->urlwithoutmoduleid . "&p=uman", "uman"),
//        );
//
//        $request_p = $this->input->get_post('p');
//
//        if ($this->input->get_post('ajax') == 'Y') {
//            $p = $request_p;
//            $data['gridtabs'] = $this->module_model->GetGridTabs($gridtabarray, $p, true);
//            $data['row'] = $this->module_model->selectall_systemsettings();
//            echo $this->parser->parse($this->systemsetting_url, $data);
//            exit;
//        } else {
//            if (!empty($request_p)) {
//                $p = $request_p;
//            } else {
//                $p = 'gen';
//            }
//
//            $this->viewData['gridtabs'] = $this->module_model->GetGridTabs($gridtabarray, $p, true);
//            $this->viewData['adminContentPanel'] = $this->systemsetting_url;
//            $this->load_view();
//        }
//    }
//
//    /*     * ********************************** LOG MANAGER ***************************************** */
//
//    function logmanager() {
//
//        $this->load_data();
//
//        if ($this->input->get_post('ajax') == 'Y') {
//            echo $this->parser->parse($this->logmanager_url, $this->viewData);
//            exit;
//        }
//
//        $this->viewData['logmanagerTab'] = true;
//        $this->viewData['adminContentPanel'] = $this->logmanager_url;
//        $this->load_view();
//    }

    public function load_data() {

//        $query = $this->module_model->selectall_logmanager();

//        $this->viewData['counttotal'] = $query->num_rows();
//        $this->viewData['selectAll'] = $query->result();

        $tmpsetsortvar = trim('setsortimg' . $this->module_model->orderby);
        $tmpsetsortvar = str_replace(".", "_", $tmpsetsortvar);
        $this->viewData[$tmpsetsortvar] = $this->module_model->sortvar;

        $this->viewData['HeaderPanel'] = $this->module_model->HeaderPanel();
        $this->viewData['PagingTop'] = $this->module_model->PagingTop();
        $this->viewData['PagingBottom'] = $this->module_model->PagingBottom();
    }

//      public function export() {
//        
//       $tablename = "logmanager";
//       $module= substr($_REQUEST['modval'] ,0,3) ;     
//       $sql="SELECT var_modulename FROM ".DB_PREFIX . "modules WHERE int_glcode='".$module."'";  
//       $abc=mysql_query($sql); 
//       $rec=mysql_fetch_array($abc); 
//         $modulename=$rec['var_modulename']; 
//           
//        $sql1="select var_sitename from cc_general_settings"; 
//        
//        $abc1=mysql_query($sql1);  
//        $sitename=mysql_fetch_array($abc1);
//        $projectname= $sitename[0];
//        $projectname1 = str_replace(' ', '-', $projectname);
//     
//        $this->mylibrary->xlsSQL = $this->module_model->getalldata($tablename, $_REQUEST['modval'], $_REQUEST['pagesize']);
//        
//       if($module=='')
//       {
//              $this->mylibrary->filename = "$projectname1". "-" . "Logmanager" . "-".date("d-m-y-h:m_a") . ".xls"; 
//                 $this->mylibrary->fileheader = "<center>Logmanager\n</center>";
//       }
//      else
//      {
//         
//          if($this->input->get_post('searchtxt')==''){
//              $Module_name=" ($modulename)";
//          }
//          else{
//              $Module_name="";
//          }
//          
//          if($this->input->get_post('searchtxt')==''){
//              $Module_name=" ($modulename)";
//          }
//          else{
////              $Module_name="-";
//          }
//         $this->mylibrary->filename = "$projectname1". "-" . "Logmanager" . "-".date("d-m-y-h:m_a") . ".xls"; 
//              $this->mylibrary->fileheader = "<center>Logmanager".$Module_name."\n</center>";
//      }
//         $this->mylibrary->dataArray = $allrecordsset;
//        $this->mylibrary->generateXLSfile();
//    }
    
//     public function export() {
//        
//        $tablename = "logmanager";
//        $this->mylibrary->xlsSQL = $this->module_model->getalldata($tablename, $_REQUEST['modval'], $_REQUEST['pagesize'],$_REQUEST['chkids']);
//        $this->mylibrary->filename = "Logmanager_" . date("Y-m-d_h_i_a") . ".xls";
//        $this->mylibrary->fileheader = "<center>Logmanager\n</center>";
//        $this->mylibrary->dataArray = $allrecordsset;
//        $this->mylibrary->generateXLSfile();
//    }
//
//    public function delete() {
//
//        $this->module_model->delete_row();
//        $this->load_data();
//        echo $this->parser->parse($this->logmanager_url, $this->viewData);
//        exit;
//    }
//    
//    public function deleteAll() {
//        
//        $this->module_model->delete_All();
//        $this->load_data();
//        echo $this->parser->parse($this->logmanager_url, $this->viewData);
//        exit;
//    }


    /*     * ********************************************************************************* */

   public function set_message() {
        $msg = $this->session->flashdata('msg');
        $msg1 = $this->input->get_post('msg');
        if (!empty($msg)) {
            if ($msg == 'add') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully saved.");
            } else if ($msg == 'edit') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully edited and saved.");
            }
        }
        if (!empty($msg1)) {
            if ($msg1 == 'add') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully saved.");
            } else if ($msg1 == 'edit') {
                $this->viewData['messagebox'] = $this->mylibrary->message("Congrats! The record has been successfully edited and saved.");
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
    
    function HitDelete() 
    { 
       echo $this->module_model->DeleteHits();
       exit;
    }

}

?>