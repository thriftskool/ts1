<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Adminpanel_user_management extends AdminPanel_Controller {
    
    

    function __construct() {
        parent::__construct();
    
        
        
        if ($this->session->userdata('chr_user') != 'N') {
            redirect(ADMINPANEL_HOME_URL);
        }
    }
    
    public function index(){
        
        
        redirect(MODULE_URL.'accesscontrol');
    }

    public function accesscontrol($method='index'){
        
        echo Modules::run('user_management/accesscontrol/'.$method);
    }

    
    

}

?>