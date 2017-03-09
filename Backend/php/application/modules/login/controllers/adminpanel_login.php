<?php

class Adminpanel_login extends Base_Controller {

    //public static $Fail_Counter = 0;    

    function __construct() {        
        parent::__construct();
        
        $this->load->library('session');                
        $this->load->library('mylibrary');        
        $this->load->library('email');
        
        $this->email->initialize();
        $this->load->helper('cookie');        
        $this->load->helper(array('form', 'url'));
        
        $this->load->model('login_model');
        
        if ($this->session->userdata('username') != '') {
            redirect(base_url() . 'adminpanel/dashboard');
        }
    }

    function index() {
        
        $LoginCookie = $this->mylibrary->requestGetCookie('tml_CookieLogin', array());

        if (!empty($LoginCookie)) {
            $username = $LoginCookie['user'];
            $passowrd = $LoginCookie['pwd'];
            $chkrememberme = $LoginCookie['chkrememberme'];
            $new_data = array('username' => $username, 'passowrd' => $password, 'chkrememberme' => $chkrememberme);
        }

        $this->load->view('adminpanel/login_tpl');
    }

    function forgotpassword() {

        $this->load->view('adminpanel/forgotpassword_tpl');
    }

    function forgetpassprocess() {


        $result = $this->login_model->passvalidate($_REQUEST['ss_username']);

        if ($result == false) {

            $msg = array('message' => "The email address you have entered is not in our database.");
        } else {
            $verify = $this->login_model->sendpassword($_REQUEST['ss_username']);

            if ($verify == true) {
                $msg = array('message' => 'Your password has been sent successfully on your (personal) email account.');
             } else {
                $msg = array('message' => 'Sorry! There is some error while sending mail. Please try again.');
             }
        }
        $this->load->view('adminpanel/forgotpassword_tpl', $msg);
    }

    public function process() {
//        echo "fdsaff"; die;
        $result = $this->login_model->validate();
        if ($result == false) {
            $data_cap = $this->login_model->logincounter();
            $new_data = array('captcha' => $data_cap, 'message' => 'Invalid Username or Password');
            $this->load->view('adminpanel/login_tpl', $new_data);
        } else {
            $gotoPath = $this->input->post('gotopath');
            $takemeto = (!empty($gotoPath)) ? $gotoPath : base_url() . 'adminpanel/dashboard';
           
             
            // Show Love Popup// 
            redirect(urldecode($takemeto));
        }
    }
    
    // Show Love Popup//
    function loginrestapicounter($user_id) 
    {
        $whmusername = REST_API_ADMIN_USERNAME;       
        $whmpassword = REST_API_ADMIN_PASSWORD; 
        $query = REST_API_LOGINCOUNTER_URL;    
        $querystring = ""; 
            if(!empty($_POST)){
                foreach($_POST as $key => $val)
                {
                    $qstr ="";
                    if(is_array($_POST[$key]))   
                    {
                        $qstr .= "&".$key."=".implode(",",$_POST[$key]);  
                        $querystring .= $qstr;  
                    }
                    else
                    {
                        $querystring.="&".$key."=".$val; 
                    }
                }
            }
            
            $querystring .= "&rest=y";
            
            if(!empty($user_id)){
                $querystring .= "&fk_user=$user_id";
            }

            $querystring .= "&var_domain=".$_SERVER['HTTP_HOST'];
            $data['url'] = REST_API_LOGINCOUNTER_URL;  
            $data['data'] = $querystring;
            
            $curl = curl_init();		 
            # Create Curl Object
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER,0); 	
            # Allow self-signed certs
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST,0); 	  
            # Allow certs that do not match the hostname
            curl_setopt($curl, CURLOPT_HEADER,0);			
            # Do not include header in output
            curl_setopt($curl, CURLOPT_RETURNTRANSFER,1); 	 
            # Return contents of transfer on curl_exec 
            $header[0] = "Authorization: Basic " . base64_encode($whmusername.":".$whmpassword) . ""; 
           //echo $header[0];exit; 
            curl_setopt($curl, CURLOPT_HTTPHEADER, $header);  
            # set the username and password
            curl_setopt($curl, CURLOPT_URL, $query);	
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS,$data['data']);        
            # execute the query
            $server_output = curl_exec($curl);
            $data_collection = json_decode($server_output);
            
            return $data_collection;
    }
    // Show Love Popup//

}

?>