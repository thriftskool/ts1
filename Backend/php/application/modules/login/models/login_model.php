<?php
class login_model extends CI_Model {

    public function __construct() {
        
    }

    public function validate() {
        
        $username = $this->security->xss_clean($this->input->post('ss_username'));
        
        $password = $this->security->xss_clean($this->input->post('ss_password'));
        
        $cond = "var_emailid = '" . $username . "' and var_password = '" . $this->mylibrary->cryptPass($password) . "' and chr_delete = 'N' and chr_publish = 'Y' and chr_usertype in ('N','A','S','O','V')";
        
        $this->db->where($cond);
        $query = $this->db->get('users');
//        echo $this->db->last_query(); die;
        if ($query->num_rows == 1) {
            $row = $query->row();
            $data = array(
                'userid' => $row->int_glcode,
                'username' => $row->var_emailid,
                'chr_user' => $row->chr_usertype,
                'fname' => $row->var_fullname,
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
            return true;
        }

        return false;
    }
    
    
    public function sendpassword($email) {
 
        $userQuery = $this->db->get_where('users', array('var_emailid' => $email));
        $userRow = $userQuery->row_array();
        $query = $this->db->get_where('users', array('int_glcode' => $userRow['int_glcode']));
        $row = $query->row_array();
        
        $logo = FRONT_MEDIA_URL;
        
        $to = $userRow['var_emailid1'];

        $Regards = EMAIL_SIGNATURE;

        $subject = 'Forgot Password: Login details of '.SITE_NAME.' AdminPanel';

        $imgurl = GLOBAL_ADMIN_IMAGES_PATH . "adminpanel_logo.png";
//        echo $imgurl; exit;
        $html_message = file_get_contents(ADMIN_MEDIA_URL . "mailtemplates/forgot_password_adminpanel.html");
        
        $name = $userRow['var_fullname'];
//        if($userRow['var_lname'] != '')
//        {
//            $name = $userRow['var_fname'] . " " . $userRow['var_lname'];
//        }
//        else
//        {
//            $name = $userRow['var_fname'];
//        }
        
        $contact_url = $this->common_model->getUrl('pages', '4', '2', ''); 
        
//        IF($userRow['var_fname'] != '')
//       {
//        $body_admin .='<tr>
//                        <td width="20" height="24" align="left" valign="middle"><img src="'.$logo.'images/arrow_icon.png" style="" alt="" width="4" height="8" vspace="7" /></td>
//                        <td height="24" align="left" valign="middle" style="font-family:Arial, Helvetica, sans-serif; color:#585858; font-size:12px;"><strong style="color:#26262F;">Name: </strong>'.$userRow['var_fname'].'</td>
//                      </tr>';
//       }
       IF($userRow['var_emailid'] != '')
       {
      
        $body_admin .='<tr>
                              <td width="20" height="24" align="left" valign="middle"><img src="' . $logo . 'email-template/images/email_bullat.png" style="margin:5px 0 2px 0;" alt="" width="9" height="13" vspace="7" /></td>
                              <td height="24" align="left" valign="middle" style="font-family:Arial, Helvetica, sans-serif; color:#4C4C4C; font-size:13px;"><strong>User Id: </strong><a href="mailto:'.$userRow['var_emailid'].'" style="color:#AC0000; text-decoration:none;" title="'.$userRow['var_emailid'].'">'.$userRow['var_emailid'].'</a> </td>
                          </tr>';
       }
        IF($userRow['var_password'] != '')
       {
      
          $body_admin .='<tr>
                                <td width="20" height="24" align="left" valign="middle"><img src="' . $logo . 'email-template/images/email_bullat.png" style="margin:5px 0 2px 0;" alt="" width="9" height="13" vspace="7" /></td>
                                <td height="24" align="left" valign="middle" style="font-family:Arial, Helvetica, sans-serif; color:#4C4C4C; font-size:13px;"><strong>Password: </strong>' . $this->mylibrary->decryptPass($userRow['var_password']) . '</td>

                      </tr>';
       }
        
        
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

       
        $copyright="Copyright &copy; " . date(Y) . "  . All Rights Reserved.";
        $content = ' The following are your adminpanel login credentials. Please maintain its confidentiality to ensure security of information.';
        
         if((CHR_FACEBOOK == 'Y') || (CHR_TWITTER == 'Y') || (CHR_PINTEREST == 'Y') || (CHR_LINKEDIN == 'Y')) {
            $follow = "FOLLOW US";
        } else {
            $follow = '';    
        }
        $html_message = str_replace("@DEAR", 'Dear', $html_message);
        $html_message = str_replace("@ADMIN",$name . ",", $html_message);
        $html_message = str_replace("@LOGO", $logo, $html_message);
        $html_message = str_replace("@CONTENT",$content, $html_message);
        $html_message = str_replace("@DETAILS", $body_admin, $html_message);
        $html_message = str_replace("@FOLLOW", $follow, $html_message);
        $html_message = str_replace("@FACEBOOK", $facebook, $html_message);
        $html_message = str_replace("@TWITTER", $twitter, $html_message);
        $html_message = str_replace("@LINKEDIN", $linkedin, $html_message);
        $html_message = str_replace("@PINTEREST", $pinterest, $html_message);
        $html_message = str_replace("@Contactus", $contact_url, $html_message);
        $html_message = str_replace("@SITE_NAME", SITE_NAME, $html_message);
        $html_message = str_replace("@SITE_PATH", SITE_PATH, $html_message);
        $html_message = str_replace("@REGARD_MESSAGE",'Best Regards, ', $html_message);
        $html_message = str_replace("@EMAIL", $Regards, $html_message);
        $html_message = str_replace("@YEAR", date('Y'), $html_message);
        $html_message = str_replace("@COPYRIGHT", $copyright, $html_message);
        
        $this->email->to($to);
        $this->email->subject($subject);
        $this->email->message($html_message);
        if ($email != '') {

            $this->mylibrary->send_mail();
            $message = mysql_real_escape_string($html_message);
            $fk_emailtype = '1';

            $insertSql = "insert into " . DB_PREFIX . "emails (fk_emailtype,var_from,txt_to,txt_subject,txt_body,dt_createdate,dt_modifydate) Values ($fk_emailtype,'" . MAIL_FROM . "', '" . $to . "' ,'" . $subject . "','" . $message . "',now(),now()) ";
            $exec = $this->db->query($insertSql); 

            $message = "Your Mail sent Successfully . We will get you back soon..";
            return 1;
        } else {
            return 0;
        }
    }
    
//    public function sendpassword($email) {
//        
//        $userQuery = $this->db->get_where('users', array('var_emailid' => $email));
//        $userRow = $userQuery->row_array();
//        $query = $this->db->get_where('users', array('int_glcode' => $userRow['int_glcode']));
//        $row = $query->row_array();
//        
//        $to = $userRow['var_emailid1'];
////        echo $to; exit;
//        $Regards = EMAIL_SIGNATURE;
//
//        $subject = 'Forgot Password: Login details of Fresh-as-Air Powerpanel.';
//
//        $imgurl = GLOBAL_ADMIN_IMAGES_PATH . "adminpanellogo.png";
////        echo $imgurl; exit;
//        $html_message = file_get_contents(ADMIN_MEDIA_URL . "mailtemplates/forgot_password_adminpanel.html");
//        if($userRow['var_lname'] != '')
//        {
//            $name = $userRow['var_fname'] . " " . $userRow['var_lname'];
//        }
//        else
//        {
//            $name = $userRow['var_fname'];
//        }
//        
//        $html_message = str_replace("@NAME",$name, $html_message);
//        $html_message = str_replace("@Adminid", '<a href="mailto:' . $_POST['ss_username'] . '" style="text-decoration:none; color:#015293;">' . $_POST['ss_username'] . '</a>', $html_message);
//
//        $html_message = str_replace("@Password", $this->mylibrary->decryptPass($row['var_password']), $html_message);
////        echo EMAIL_LOGO_PATH; exit;
//        $html_message = str_replace("@LOGO_PATH", EMAIL_LOGO_PATH, $html_message);
//        $html_message = str_replace("@SITE_NAME", SITE_NAME, $html_message);
//        $html_message = str_replace("@REGARD_MESSAGE", $Regards, $html_message);
//        $html_message = str_replace("@MAILBOTTOM_LINK", MAILBOTTOM_TEXT, $html_message);
//        $html_message = str_replace("@SITE_URL", base_url(), $html_message);
//        $html_message = str_replace("@YEAR", date('Y'), $html_message);
//        
//        $this->email->to($to);
//        $this->email->subject($subject);
//        $this->email->message($html_message);
//
//        if ($email != '') {
////echo "fff"; exit;
//            $this->mylibrary->send_mail();
//            $message = mysql_real_escape_string($html_message);
//            $fk_emailtype = '1';
//
//            $insertSql = "insert into " . DB_PREFIX . "emails (fk_emailtype,var_from,txt_to,txt_subject,txt_body,dt_createdate,dt_modifydate) Values ($fk_emailtype,'" . MAIL_FROM . "', '" . $to . "' ,'" . $subject . "','" . $message . "',now(),now()) ";
//            $exec = $this->db->query($insertSql); 
//
//            $message = "Your Mail sent Successfully . We will get you back soon..";
//            return 1;
//        } else {
//            return 0;
//        }
//    }

    public function passvalidate($email) {
        
      $query = "select * from " . DB_PREFIX . "users where var_emailid = '" . $email . "'";
        $result = $this->db->query($query);

        if ($result->num_rows == 1) {
            return true;
        }
        return false;
    }

   function logincounter() {

        //generate captcha 
        if ($this->session->userdata('no_tries')) {
            $this->session->set_userdata('no_tries', ($this->session->userdata('no_tries') + 1));
        } else {
            $this->session->set_userdata('no_tries', 1);
        }

        if ($this->session->userdata('no_tries') == 5 || $this->session->userdata('no_tries') > 5) {
            $_SESSION["pin_value"] = md5(rand(2, 99999999));
            $generated_pin = substr(md5($_SESSION["pin_value"]), 15, 4);
            $_SESSION["cpatcha_code"] = $generated_pin;
            //generate captcha 
            $path = 'admin-media/images/login';
            $sessPinvalue = $_SESSION["pin_value"];
            $pin_image_output = $this->mylibrary->show_pin_image($sessPinvalue, $generated_pin, $path, 'Y');


            $captcha = '';
            $captcha .= '<tr><td width="128" align="left" valign="middle" class="add-new-user-text" >&nbsp;&nbsp;<img src="' . $pin_image_output . '" align="left" alt="Captcha Image"/></td>
                                <td  width="220" align="left" valign="middle"><input  class="login-textbox" maxlength="4" id="enqcap" name="enqcap" type="text"  />
                                <input name="pin_value_hdn" type="hidden" class="contentfont" id="pin_value_hdn"  value="' . $generated_pin . '" size="20" />';
        }
        return $captcha;
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
            if(is_array($_POST[$key])){
                $qstr .= "&".$key."=".implode(",",$_POST[$key]);  
                $querystring .= $qstr;  
            }else{
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

function GetAdminPanelBanner(){
        $ImgArray = array();
        $sitename = "http://lserver/craveclothing/nlive/";
        $filename = $sitename . "/rssfeeds.xml";
        $fileContent = file_get_contents($filename);
        $itemArray = explode('<Banner>', $fileContent);
        $displayImg = count($itemArray);
        for($i = 1; $i < $displayImg; $i++){
            $subArray = array();
            $subArray['varTitle'] = $this->get_string_between($itemArray[$i], "<Imgtitle>", "</Imgtitle>");
            $subArray['ImageName'] = $this->get_string_between($itemArray[$i], "<image>", "</image>");
            $subArray['ImagePath'] = $this->get_string_between($itemArray[$i], "<imagepath>", "</imagepath>");
            $subArray['Link'] = $this->get_string_between($itemArray[$i], "<link>", "</link>");
            $subArray['key'] = $i;
            $ImgArray[] = $subArray;
        }
        return $ImgArray;
    }
    
    function get_string_between($string, $start, $end) {
        $string = " " . $string;
        $ini = strpos($string, $start);
        if ($ini == 0)
            return "";
        $ini += strlen($start);
        $len = strpos($string, $end, $ini) - $ini;
        return substr($string, $ini, $len);
    }
    
    

}

?>
