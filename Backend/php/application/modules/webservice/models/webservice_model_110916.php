<?php

class webservice_model extends CI_Model {

    var $key;
    var $responseArray;
    var $errorArray;
    var $returndataArray;

    public function __construct() {
        $this->load->library('user_agent');
        $this->load->library('email');
        $this->load->library('parser');
        $this->load->database();
        $this->load->helper(array('form', 'url'));

        $this->load->library('mylibrary');
        $this->load->helper('form');
        $mylibraryObj = new mylibrary;
        $this->sortvar = '';
    }

    function Get_Login($id, $pwd, $device_id) {

        $username = $this->security->xss_clean($id);
        $password = $this->security->xss_clean($pwd);
        $device_id = $this->security->xss_clean($device_id);
        if ($username != '' && $password != '') {
            $cond = "var_username ILIKE '" . $username . "' and var_password = '" . $this->mylibrary->cryptPass($password) . "' and chr_delete = 'N'";
            $this->db->where($cond);
            $Query = $this->db->get('users_manage');
            $Result = $Query->row_array();
            $Count = $Query->num_rows();
//echo $this->db->last_query(); die;
            if (!empty($Result)) {
                $get_uni_name = "SELECT var_name as university_name, var_image as uni_image from university_management where int_glcode='" . $Result['fk_university'] . "'";
                $get_uni = $this->db->query($get_uni_name);
                $Result_uni_name = $get_uni->row();
            }
//           echo $Result_uni_name->university_name;
//            die;
            if ($Count > 0) {
//               old Start 
//                if ($device_id != '') {
//
//                    $check_device = "SELECT int_glcode  from users_manage where device_id='" . $device_id . "'";
//                    $chk_device = $this->db->query($check_device);
//                    $device_chk_id = $chk_device->row();
//
//                    if ($device_chk_id->int_glcode != '') {
//                        $update_page_hits_sql = "UPDATE users_manage SET device_id= '' WHERE int_glcode='" . $device_chk_id->int_glcode . "'";
//                        $this->db->query($update_page_hits_sql);
//                    }
//                    $update_page_hits_sql1 = "UPDATE users_manage SET device_id= '" . $device_id . "' WHERE int_glcode='" . $Result['int_glcode'] . "'";
//                    $this->db->query($update_page_hits_sql1);
//                }
// ******************* Old End ******************
//                if ($device_id != '') {
//                    $update_page_hits_sql = "UPDATE users_manage SET gcm_code= '' WHERE int_glcode='" . $Result['int_glcode'] . "'";
//                    $this->db->query($update_page_hits_sql);
//                }
//     ******************************************* New Start*******************
                if ($device_id != '') {

                    $check_device = "SELECT int_glcode  from user_devices where device_id='" . $device_id . "'";
                    $chk_device = $this->db->query($check_device);
                    $device_chk_id = $chk_device->row();

                    if ($device_chk_id->int_glcode != '') {
//echo "In"; die;
                        $data_image = array(
                            'device_id' => $device_id,
                            'fk_user' => $Result['int_glcode'],
                        );
                        $this->db->where('int_glcode', $device_chk_id->int_glcode);
                        $this->db->update('user_devices', $data_image);
                    } else {
//                        echo "Out"; die;
                        $data = array(
                            'fk_user' => $Result['int_glcode'],
                            'device_id' => $device_id,
                            'dt_createdate' => date('Y-m-d H:i:s', time())
                        );
                        $this->db->insert('user_devices', $data);
                    }
                }
//  *******************************  New End  ******************************************

                if ($Result['chr_verify'] == 'N') {
                    $response['Response'] = array(
                        'status' => '4011',
                        'message' => 'Please verify your email address to access your account.'
                    );
                    return $this->error_response($response);
                } else if ($Result['chr_publish'] == 'N') {
                    $response['Response'] = array(
                        'status' => '401',
                        'message' => 'Unauthorized access.'
                    );
                    return $this->error_response($response);
                } else {
                    $response['Response'] = array(
                        'status' => '200',
                        'message' => 'Successfully Login',
                        'imagepath' => SITE_PATH . 'upimages/university_management/images/',
                        'login_id' => $Result['int_glcode'],
                        'university_id' => $Result['fk_university'],
                        'email_id' => $Result['var_emailid'],
                        'user_name' => $Result['var_username'],
                        'university_name' => $Result_uni_name->university_name,
                        'university_image' => $Result_uni_name->uni_image
                    );

                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '404',
                    'message' => 'Invalid username or password.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Login_Gcm_id($user_id, $gcm_id) {

        if ($user_id != '' && $gcm_id != '') {
//            $query_user = $this->db->query("SELECT * FROM users_manage where gcm_code='" . $gcm_id . "'");
//            $count = $query_user->num_rows();
//            ********** New Start **********
            $check_gcm_code = "SELECT int_glcode  from manage_gcmcode where gcm_code='" . $gcm_id . "'";
            $chk_gcm_code = $this->db->query($check_gcm_code);
            $gcm_chk_id = $chk_gcm_code->row();
//            echo ; die;
//            print_r($device_chk_id); die;
//  *********** End Start *************

            if ($gcm_chk_id->int_glcode != '') {
//                $update_page_hits_sql = "UPDATE users_manage SET gcm_code='' WHERE gcm_code='" . $gcm_id . "'";
//                $this->db->query($update_page_hits_sql);
                $data_gcm_code = array(
                    'gcm_code' => $gcm_id,
                    'fk_user' => $user_id
                );
                $this->db->where('int_glcode', $gcm_chk_id->int_glcode);
                $this->db->update('manage_gcmcode', $data_gcm_code);
            } else {
                $data = array(
                    'fk_user' => $user_id,
                    'gcm_code' => $gcm_id,
                    'dt_createdate' => date('Y-m-d H:i:s', time())
                );
                $this->db->insert('manage_gcmcode', $data);
            }
//            $update_page_hits_sql = "UPDATE users_manage SET gcm_code='" . $gcm_id . "' WHERE int_glcode='" . $user_id . "'";
//            $this->db->query($update_page_hits_sql);

            $response['Response'] = array(
                'status' => '204',
                'message' => 'Updated'
            );
            return $this->response($response);
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

//    function Get_Login_Gcm_id($user_id, $gcm_id) {
//
//        if ($user_id != '' && $gcm_id != '') {
//            $query_user = $this->db->query("SELECT * FROM users_manage where gcm_code='" . $gcm_id . "'");
//            $count = $query_user->num_rows();
//            if ($count > 0) {
//                $update_page_hits_sql = "UPDATE users_manage SET gcm_code='' WHERE gcm_code='" . $gcm_id . "'";
//                $this->db->query($update_page_hits_sql);
//            }
//            $update_page_hits_sql = "UPDATE users_manage SET gcm_code='" . $gcm_id . "' WHERE int_glcode='" . $user_id . "'";
//            $this->db->query($update_page_hits_sql);
//            $response['Response'] = array(
//                'status' => '204',
//                'message' => 'Updated'
//            );
//            return $this->response($response);
//        } else {
//            $response['Response'] = array(
//                'status' => '400',
//                'message' => 'Bad Request due to invalid parameters.'
//            );
//            return $this->error_response($response);
//        }
//    }

    function Get_University_List() {


        $query = $this->db->query("SELECT int_glcode as university_id,var_name as university_name,var_domain as Domain_name, var_image as image FROM university_management where chr_delete='N' and chr_publish='Y' ORDER BY var_name asc");
        $Result = $query->result_array();
        if (!empty($Result)) {
            $response_Uni_list['Response'] = array(
                'status' => '200',
                'message' => 'Success.',
                'imagepath' => SITE_PATH . 'upimages/university_management/images/',
                "Details" => $Result
            );
            return $this->response($response_Uni_list);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Records Not Found.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Registration($uni_id, $email_id, $username, $password, $device_id) {

        $this->Check_Email($email_id);
        $this->Check_Username($username);

        $data_res = array(
            'fk_university' => $uni_id,
            'var_emailid' => $email_id,
            'var_username' => $username,
            'var_password' => $this->mylibrary->cryptPass($password),
            'device_id' => $device_id,
            'chr_publish' => 'Y',
            'chr_delete' => 'N',
            'chr_verify' => 'N',
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'dt_modifydate' => date('Y-m-d H:i:s', time())
        );
        $this->db->insert('users_manage', $data_res);
        $id = $this->db->insert_id();
        $this->Send_Verification_Link($email_id, $id, $username);
    }

    function Send_Verification_Link($emailid, $idss, $username) {
//echo $emailid .'<pre/>' .$idss . '<pre/>' . $username; die;
        if ($emailid != '') {
            $Regards = str_replace("@SITE_PATH", SITE_PATH);
            $subject = "Verification Link";
            $registor_id = $this->mylibrary->cryptPass($idss);
            $linkss = 'https://thriftskool.com/mobileapps/thriftskool/webservice/verification?id=' . $registor_id;
            $body_admin = $linkss;
            $EMAIL_LOGO_PATH = SITE_PATH . 'admin-media/Email-template/images/';
            $html_message = file_get_contents("admin-media/Email-template/verification_link.html");
            $html_message = str_replace("@DETAILS", $body_admin, $html_message);
            $html_message = str_replace("@LOGO_PATH", $EMAIL_LOGO_PATH, $html_message);
            $html_message = str_replace("@username", $username, $html_message);
            //$html_message = str_replace("@SITE_URL", SITE_PATH, $html_message);
            //$html_message = str_replace("@SITE_PATH", SITE_PATH, $html_message);
            $html_message = str_replace("@YEAR", date('Y'), $html_message);
            $to = $emailid;

            $config = array(
                'protocol' => 'smtp',
                'smtp_host' => SMTP_HOST,
                'smtp_port' => SMTP_PORT,
                'smtp_user' => SMTP_USER,
                'smtp_pass' => SMTP_PASSWORD
            );
            $this->email->clear();
            $config['mailtype'] = "html";
            $this->email->initialize($config);
            $this->email->set_newline("\r\n");
            $this->email->from('no-reply@thriftskool.com', 'Thriftskool');
            $this->email->to($to);
            $data = array();
            $this->email->subject($subject);
            $this->email->message($html_message);

            if ($this->email->send()) {
//                $returndataArray['Response'] = array(
//                    'status' => '200',
//                    'message' => 'Success.'
//                );
//                return $this->response($returndataArray);
                $response['Response'] = array(
                    'status' => '201',
                    'message' => 'Registration Successfully.'
                );
                return $this->response($response);
            } else {
                $returndataArray['Response'] = array(
                    'status' => '4011',
                    'message' => 'Mail not Send.'
                );
                return $this->response($returndataArray);
            }
        } else {
            $response['Response'] = array(
                'status' => '1018',
                'message' => 'The requested email is not found.'
            );
            return $this->error_response($response);
        }
    }

    function Check_Email($user_email) {

        $user_email = $user_email;
        $this->db->where('var_emailid', $user_email);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        if ($query->num_rows() > 0) {
            $response['Response'] = array(
                'status' => '401',
                'message' => 'You have already registered with this email address. Please verify it to access your account.'
            );
            return $this->response($response);
        } else {
            return 1;
        }
    }

    function Check_Username($username) {

        $user_name = $username;
        $this->db->where('var_username', $user_name);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        if ($query->num_rows() > 0) {
            $response_Uni_list['Response'] = array(
                'status' => '208',
                'message' => 'Please use different Username for registration.'
            );
            return $this->response($response_Uni_list);
        } else {
            return 1;
        }
    }

    function Get_Post_Category_List($user_id) {

//        $query = $this->db->query("SELECT chr_publish,int_glcode FROM users_manage where chr_delete='N' and chr_publish='Y' and int_glcode=$user_id");
//        $Result = $query->result_array();
        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {
                $query = $this->db->query("SELECT int_glcode as post_cat_id, var_categoryname as post_category_name, var_image as post_cat_image, var_backimage as background_image FROM post_category where chr_delete='N' and chr_publish='Y' order by int_displayorder ASC ");
                $Result = $query->result_array();
                if (!empty($Result)) {
                    $response_cate_list['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_category/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_cate_list);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Post_List($post_cat_id, $user_id, $university_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
//        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;

                $query = $this->db->query("SELECT pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id,"
                        . " pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.chr_status as status,"
                        . "fv.chr_favorite as favorite,"
                        . "pm.dt_expiredate as expirydate,"
                        . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,"
                        . "(SELECT pg.int_glcode FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id "
                        . "FROM post_management as pm "
                        . "LEFT JOIN favorite as fv on pm.int_glcode=fv.fk_post WHERE "
                        . "pm.dt_expiredate >= DATE(now()) and "
                        . "pm.fk_post_cate =$post_cat_id  and "
                        . "pm.fk_university IN($university_id,0) and "
                        . "pm.chr_status='0' and pm.chr_status!='2'"
                        . "and pm.chr_status!='1' "
                        . "and pm.chr_status!='3' "
                        . "and pm.chr_block ='0' and  pm.chr_delete='N' and pm.chr_publish='Y' order by pm.dt_createdate DESC $limitby");
                $Result = $query->result_array();
//                echo $this->db->last_query(); die;
                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    if ($start == '0') {
                        $response['Response'] = array(
                            'status' => '404',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    } else {
                        $response['Response'] = array(
                            'status' => '4041',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    }
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_latest_Post_List($user_id, $university_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
//        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;

                $query = $this->db->query("SELECT pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id,"
                        . " pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.chr_status as status,"
                        . "fv.chr_favorite as favorite,"
                        . "pm.dt_expiredate as expirydate,"
                        . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,"
                        . "(SELECT pg.int_glcode FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id "
                        . "FROM post_management as pm "
                        . "LEFT JOIN favorite as fv on pm.int_glcode=fv.fk_post WHERE "
                        . "pm.dt_expiredate >= DATE(now()) and "
                        . "pm.fk_university IN($university_id,0) and "
                        . "pm.chr_status='0' and pm.chr_status!='2'"
                        . "and pm.chr_status!='1' "
                        . "and pm.chr_status!='3' "
                        . "and pm.chr_block ='0' and  pm.chr_delete='N' and pm.chr_publish='Y' order by pm.dt_createdate DESC $limitby");
                $Result = $query->result_array();
//                echo $this->db->last_query(); die;
                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    if ($start == '0') {
                        $response['Response'] = array(
                            'status' => '404',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    } else {
                        $response['Response'] = array(
                            'status' => '4041',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    }
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Post_Detail($user_id, $post_id, $own_uid) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');

        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

//                if ($log_id != '') {
//                    $update_status = "UPDATE logmanager SET chr_read='". $read ."' WHERE int_glcode='" . $log_id . "'";
//                    $this->db->query($update_status);
//                }

                $query = $this->db->query("SELECT var_title as title, var_image as image, int_glcode as image_id from post_gallery WHERE  fk_post =$post_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'");
                $Images = $query->result_array();

                if ($own_uid == $user_id) {
                    $Thread_Count = "SELECT int_glcode FROM message_thread WHERE fk_user_id='" . $own_uid . "'  and fk_post='" . $post_id . "' and own_delete='" . $own_uid . "'";
                    $res_thread_cnt = $this->db->query($Thread_Count);
                    $threadcnt = $res_thread_cnt->num_rows();
                } else {
                    $Thread_Count = "SELECT int_glcode FROM message_thread WHERE fk_user_id= '" . $own_uid . "' and fk_post='" . $post_id . "'";

                    $res_thread_cnt = $this->db->query($Thread_Count);
                    $threadcnt = $res_thread_cnt->num_rows();
                }

//echo $this->db->last_query(); die;
//                $User_Id_Code = $res->noofrows();

                $query = $this->db->query("SELECT pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id, "
                        . "pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.chr_status as status,"
                        . "pm.chr_favorite as favorite,"
                        . "pm.dt_expiredate as expirydate"
                        . " FROM post_management as pm WHERE "
                        . " pm.int_glcode =$post_id");
                $Result_detail = $query->row_array();


//$query_post = $this->db->query("SELECT * from post_management where int_glcode =$post_id and fk_user_id = $user_id and chr_delete='N' and chr_publish='Y'");
//$Result_post = $query_post->result_array();
//
//if ($chr_read != '0') {
//$update_read = "UPDATE logmanager SET chr_read= 1 WHERE fk_user_id='" . $user_id . "' and var_referenceid='" . $post_id . "' and chr_delete='N''";
//$this->db->query($update_read);
//}

                if (!empty($Images) || !empty($Result_detail)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        'images' => $Images,
                        'thread_cnt' => $threadcnt,
                        "Details" => $Result_detail
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Insert_Post($user_id, $post_title, $university_id, $post_cat_id, $description, $price, $create_date, $expirydate, $images) {

//        $this->db->where('int_glcode', $user_id);
//        $this->db->where('chr_delete', 'N');
//        $query = $this->db->get('users_manage');

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');

        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $data = array(
                    'fk_post_cate' => $post_cat_id,
                    'var_postname' => $post_title,
                    'var_description' => $description,
                    'var_price' => $price,
                    'fk_user_id' => $user_id,
                    'fk_university' => $university_id,
                    'dt_expiredate' => $expirydate,
                    'dt_createdate' => $create_date,
                    'dt_modifydate' => date('Y-m-d H:i:s', time()),
                    'chr_publish' => 'Y',
                    'chr_delete' => 'N'
                );
                $this->db->insert('post_management', $data);
                $id = $this->db->insert_id();
                if (!empty($images)) {
                    $i = 1;
                    foreach ($images as $val) {
                        $imageData = base64_decode($val);
                        $source = imagecreatefromstring($imageData);
                        $filename = $id . '-' . $i . '.jpeg';
                        $file = 'upimages/post_gallery/images/' . $filename;
                        imagejpeg($source, $file, 100);
                        $data_image = array(
                            'var_image' => $filename,
                            'fk_post' => $id,
                            'fk_user_id' => $user_id,
                            'dt_createdate' => $create_date,
                            'dt_modifydate' => date('Y-m-d H:i:s', time()),
                            'chr_publish' => 'Y',
                            'chr_delete' => 'N'
                        );
                        $this->db->insert('post_gallery', $data_image);
                        $i++;
                    }
//                    $this->insertinlogmanager_post('144', 'post_management', $user_id, $id, "");
                    $data = array(
                        'fk_user_id' => $user_id,
                        'fk_modulename' => '144',
                        'var_tablename' => 'post_management',
                        'var_referenceid' => $id,
                        'dt_createdate' => date('Y-m-d H:i:s', time()),
                        'chr_read' => 'N',
                        'notification_type' => '',
                        'from_where' => '1'
                    );
                    $this->db->insert('logmanager', $data);



                    $response['Response'] = array(
                        'status' => '201',
                        'message' => 'Created.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function insertinlogmanager_post($module, $tablename, $user_id, $lastinsertid, $notification) {
//echo $notification; die;
        $data = array(
            'fk_user_id' => $user_id,
            'fk_modulename' => $module,
            'var_tablename' => $tablename,
            'var_referenceid' => $lastinsertid,
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'chr_read' => 'N',
            'notification_type' => $notification,
            'from_where' => '1'
        );
        $query = $this->db->insert('logmanager', $data);
        return true;
    }

    function insertinlogmanager_buzz($module, $tablename, $user_id, $lastinsertid, $notification) {

        $data = array(
            'fk_user_id' => $user_id,
            'fk_modulename' => $module,
            'var_tablename' => $tablename,
            'var_referenceid' => $lastinsertid,
            'dt_createdate' => date('Y-m-d H:i:s', time()),
            'chr_read' => 'N',
            'notification_type' => $notification,
            'from_where' => '1'
        );
        $query = $this->db->insert('logmanager', $data);
        return true;
    }

    function Get_Campus_Deal_List($user_id, $university_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
//                $orderby = 'order by cd.dt_createdate ASC';
//                . "cd.fk_user_id IN($user_id, 0)"
                $query = $this->db->query("SELECT "
                        . "cd.int_glcode as deal_id,"
                        . "cd.fk_user_id as user_id,"
                        . "cd.var_title as deal_name,"
                        . "cd.var_description as description,"
                        . "cd.var_dealcode as deal_code,"
                        . "cd.dt_createdate as create_date,"
                        . "cd.dt_expiredate as expirydate,"
                        . "(SELECT cg.var_image FROM campus_gallery as cg WHERE "
                        . "cg.fk_campus_deal = cd.int_glcode OFFSET 0 limit 1) AS image "
                        . "FROM campus_deal as cd WHERE"
                        . " cd.fk_university IN($university_id,0) "
                        . "and cd.chr_delete='N' "
                        . "and cd.chr_publish='Y' "
                        . "and cd.chr_status='0' "
                        . "and chr_block='0' ORDER BY cd.dt_createdate ASC $limitby");
                $Result = $query->result_array();
//                echo $this->db->last_query(); die;

                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/campus_gallery/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    if ($start == '0') {
                        $response['Response'] = array(
                            'status' => '404',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    } else {
                        $response['Response'] = array(
                            'status' => '4041',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    }
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Deal_Detail($deal_id, $user_id, $start, $end) {

//        $this->db->where('int_glcode', $user_id);
//        $this->db->where('chr_delete', 'N');
//        $query = $this->db->get('users_manage');
//        $Result_user_check = $query->row_array();
//
//        if (!empty($Result_user_check)) {
//            if ($Result_user_check['chr_publish'] == 'Y') {

        $query = $this->db->query("SELECT var_image as image,fk_user_id as user_id from campus_gallery WHERE  fk_campus_deal IN ($deal_id,0) and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'");
        $images = $query->result_array();

        $query_detail = $this->db->query("SELECT "
                . "cd.int_glcode as deal_id,"
                . "cd.fk_user_id as user_id,"
                . "cd.var_title as deal_name,"
                . "cd.var_description as description,"
                . "cd.var_dealcode as deal_code,"
                . "cd.dt_createdate as create_date,"
                . "cd.dt_expiredate as expirydate,"
                . "(SELECT cg.var_image FROM campus_gallery as cg WHERE "
                . "cg.fk_campus_deal = cd.int_glcode OFFSET 0 limit 1) AS image "
                . "FROM campus_deal as cd WHERE "
                . "cd.int_glcode =$deal_id"
                . "and cd.fk_user_id =$user_id"
                . "and cd.chr_delete='N' "
                . "and cd.chr_publish='Y' "
                . "and cd.chr_status='0' "
                . "and chr_block='0'");
        $Result_detail = $query_detail->row_array();


        if (!empty($Result_detail) || !empty($images)) {
            $response_post['Response'] = array(
                'status' => '200',
                'message' => 'Success.',
                'imagepath' => SITE_PATH . 'upimages/campus_gallery/images/',
                'images' => $images,
                "Details" => $Result_detail
            );
            return $this->response($response_post);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Record not found.'
            );
            return $this->error_response($response);
        }
//            } else {
//                $response['Response'] = array(
//                    'status' => '401',
//                    'message' => 'Unauthorized access.'
//                );
//                return $this->error_response($response);
//            }
//        } else {
//            $response['Response'] = array(
//                'status' => '400',
//                'message' => 'Bad Request.'
//            );
//            return $this->error_response($response);
//        }
    }

    function Get_Campus_Buzz_List($user_id, $university_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
//                . "cb.fk_user_id IN($user_id, 0) "

                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
//                $orderby = 'order by cb.dt_createdate ASC';

                $query = $this->db->query("SELECT "
                        . "cb.int_glcode as buzz_id,"
                        . "cb.var_title as buzz_name,"
                        . "cb.fk_user_id as user_id,"
                        . "cb.var_description as description,"
                        . "cb.dt_createdate as crate_date,"
                        . "cb.dt_expiredate as expirydate,"
                        . "(SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE cbg.fk_campus_buzz = cb.int_glcode OFFSET 0 limit 1) AS image "
                        . "FROM campus_buzz as cb WHERE  "
                        . "cb.fk_university IN($university_id,0) "
                        . "and cb.chr_delete='N' "
                        . "and cb.dt_expiredate >= DATE(now()) "
                        . "and cb.chr_publish='Y' "
                        . "and chr_status='0' "
                        . "and chr_status!='1' "
                        . "and chr_status!='2' "
                        . "and chr_status!='3' "
                        . "and chr_block='0' order by cb.dt_createdate DESC  $limitby");
                $Result = $query->result_array();
                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/campus_buzz_gallery/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    if ($start == '0') {
                        $response['Response'] = array(
                            'status' => '404',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    } else {
                        $response['Response'] = array(
                            'status' => '4041',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    }
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Buzz_Detail($buzz_id, $user_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {
                $query = $this->db->query("SELECT var_image as image,fk_user_id as user_id from campus_buzz_gallery WHERE  fk_campus_buzz IN ($buzz_id,0) and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'");
                $Images = $query->result_array();

                $query_detail = $this->db->query("SELECT "
                        . "cb.int_glcode as buzz_id,"
                        . "cb.var_title as buzz_name,"
                        . "cb.fk_user_id as user_id,"
                        . "cb.var_description as description,"
                        . "cb.dt_createdate as crate_date,"
                        . "cb.dt_expiredate as expirydate"
                        . " FROM campus_buzz as cb WHERE  "
                        . "cb.fk_user_id IN('0', $user_id)"
                        . " and cb.int_glcode = $buzz_id"
                        . "and cb.chr_delete='N' "
                        . "and cb.chr_publish='Y' "
                        . "and chr_block='0'");
                $Result_detail = $query_detail->row_array();
//echo $this->db->last_query(); die;
//                $query_buzz = $this->db->query("SELECT * from campus_buzz where int_glcode =$buzz_id and fk_user_id = $user_id and chr_delete='N' and chr_publish='Y'");
//                $Result_Buzz = $query_buzz->result_array();

                if (!empty($Result_detail) || !empty($Images)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/campus_buzz_gallery/images/',
                        "images" => $Images,
                        "Details" => $Result_detail
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters'
            );
            return $this->error_response($response);
        }
    }

    function Insert_Buzz($user_id, $buzz_title, $university_id, $description, $expirydate, $images) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
                $data = array(
                    'var_title' => $buzz_title,
                    'var_description' => $description,
                    'fk_user_id' => $user_id,
                    'fk_university' => $university_id,
                    'dt_expiredate' => $expirydate,
                    'dt_createdate' => date('Y-m-d H:i:s', time()),
                    'dt_modifydate' => date('Y-m-d H:i:s', time()),
                    'chr_publish' => 'Y',
                    'chr_delete' => 'N'
                );
                $this->db->insert('campus_buzz', $data);
                $id = $this->db->insert_id();

                if (!empty($images)) {
                    $i = 1;
                    foreach ($images as $val) {
                        $imageData = base64_decode($val);
                        $source_img = imagecreatefromstring($imageData);
//                        $filename = uniqid() . '.jpeg';
                        $filename = $id . '-' . $i . '.jpeg';
                        $file = 'upimages/campus_buzz_gallery/images/' . $filename;
                        $test = imagejpeg($source_img, $file, 100);

                        $data_image = array(
                            //'var_title'=> 
                            'var_image' => $filename,
                            'fk_campus_buzz' => $id,
                            'fk_user_id' => $user_id,
                            'dt_createdate' => date('Y-m-d H:i:s', time()),
                            'dt_modifydate' => date('Y-m-d H:i:s', time()),
                            'chr_publish' => 'Y',
                            'chr_delete' => 'N'
                        );
                        $this->db->insert('campus_buzz_gallery', $data_image);
                        $i++;
                    }

                    $this->insertinlogmanager_buzz('149', 'campus_buzz', $user_id, $id, "");
                    $response['Response'] = array(
                        'status' => '201',
                        'message' => 'Created.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Job_List($user_id, $university_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
//                $query = $this->db->query("SELECT cb.int_glcode as buzz_id,cb.var_title as buzz_name,cb.var_description as description,cb.dt_createdate as crate_date,cb.dt_expiredate as expirydate,(SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE cbg.fk_campus_buzz = cb.int_glcode OFFSET 0 limit 1) AS image FROM campus_buzz as cb WHERE  cb.fk_user_id IN($user_id, 0) and cb.fk_university IN($university_id,0) and cb.chr_delete='N' and cb.chr_publish='Y'");

                $query = $this->db->query("SELECT int_glcode as job_id,fk_user_id as user_id,var_jobname as job_name, var_description as description,dt_createdate as crate_date, dt_expiredate as expire_date FROM job_management  WHERE  fk_user_id IN($user_id, 0) and fk_university IN($university_id,0) and chr_delete='N' and chr_publish='Y'");
                $Result = $query->result_array();
                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Insert_Job($user_id, $job_title, $university_id, $description, $createdate, $expirydate) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('fk_university', $university_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
                $data = array(
                    'var_jobname' => $job_title,
                    'var_description' => $description,
                    'fk_user_id' => $user_id,
                    'fk_university' => $university_id,
                    'dt_expiredate' => $expirydate,
                    'dt_createdate' => date('Y-m-d H:i:s', time()),
                    'dt_modifydate' => date('Y-m-d H:i:s', time()),
                    'chr_publish' => 'Y',
                    'chr_delete' => 'N'
                );
                $this->db->insert('job_management', $data);
                $id = $this->db->insert_id();
                $response['Response'] = array(
                    'status' => '201',
                    'message' => 'Created.'
                );
                return $this->response($response);
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request.'
            );
            return $this->error_response($response);
        }
    }

    function Get_My_Post_List($user_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;

                $query = $this->db->query("SELECT pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id,"
                        . " pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.chr_status as status,"
                        . "pm.chr_favorite as favorite,"
                        . "pm.dt_createdate as createdate,"
                        . "pm.dt_expiredate as expirydate,"
                        . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image "
                        . "FROM post_management as pm WHERE  "
                        . "pm.fk_user_id =$user_id"
                        . "and pm.chr_delete='N' "
                        . "and pm.chr_status!='3' "
                        . "and pm.chr_publish='Y' order by pm.dt_createdate DESC $limitby");
                $Result = $query->result_array();

//                echo $this->db->last_query(); die;

                $query1 = $this->db->query("SELECT pm.int_glcode as buzz_id,"
                        . "pm.fk_user_id as user_id,"
                        . "pm.var_title as buzz_name,"
                        . "pm.var_description as description,"
                        . "pm.chr_status as status,"
                        . "pm.chr_block as block,"
                        . "pm.dt_expiredate as expirydate,"
                        . "pm.dt_createdate as createdate,"
                        . "(SELECT pg.var_image FROM campus_buzz_gallery as pg "
                        . "WHERE pg.fk_campus_buzz = pm.int_glcode OFFSET 0 limit 1) AS image "
                        . "FROM campus_buzz as pm WHERE  "
                        . "pm.fk_user_id =$user_id "
                        . "and pm.chr_delete='N' "
                        . "and pm.chr_status!='3' "
                        . "and pm.chr_publish='Y' order by pm.dt_createdate DESC $limitby");
                $Result_buzz = $query1->result_array();
//                echo $this->db->last_query();
//                die;
//                print_r($Result_buzz);
//                die;
                if (!empty($Result) || !empty($Result_buzz)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        'buzz_imagepath' => SITE_PATH . 'upimages/campus_buzz_gallery/images/',
                        "Details" => $Result,
                        "Details_buzz" => $Result_buzz
                    );
                    return $this->response($response_post);
                } else {
                    if ($start == '0') {
                        $response['Response'] = array(
                            'status' => '404',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    } else {
                        $response['Response'] = array(
                            'status' => '4041',
                            'message' => 'Record not found.'
                        );
                        return $this->error_response($response);
                    }
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Post($post_id, $user_id, $post_title, $university_id, $post_cat_id, $description, $price, $modifydate, $expirydate, $images) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $data = array(
                    'fk_post_cate' => $post_cat_id,
                    'var_postname' => $post_title,
                    'var_description' => $description,
                    'var_price' => $price,
                    'fk_user_id' => $user_id,
                    'dt_expiredate' => $expirydate,
                    'dt_modifydate' => $modifydate,
                    'dt_modifydate' => date('Y-m-d H:i:s', time())
                );
                $this->db->where('int_glcode', $post_id);
                $this->db->update('post_management', $data);
//                $id = $this->db->insert_id();

                if (!empty($images)) {

                    $i = 1;
//                    print_r($images);
////                    die;
//                      $response['Response'] = array(
//                    'status' => $images
//                );
//                return $this->error_response($response);
                    foreach ($images as $val) {
//                        $sqlCountPages = "select var_image FROM post_gallery  where chr_delete='N' and int_glcode=$val->image_id";
//                        $query = $this->db->query($sqlCountPages);
//                        $rs = $query->row();
//                        print_r($cntimg); die;
                        if ($val->image_id != '0') {
                            $cntimg = $this->CheckImageAvailable($val->image_id);
//                            echo "fdsaf"; die;
//                            echo $cntimg->var_image; die;
                            $imageData = base64_decode($val->image);
                            $source = imagecreatefromstring($imageData);
//                            $filename = uniqid() . '.jpeg';
//                            $filename = $val->title.'.jpeg';
                            $filename = $cntimg->var_image;
                            $file = 'upimages/post_gallery/images/' . $filename;
                            imagejpeg($source, $file, 100);
                            imagedestroy($source);
                            $data_image = array(
                                'var_image' => $filename,
                                'fk_post' => $post_id,
                                'fk_user_id' => $user_id,
                                'dt_modifydate' => date('Y-m-d H:i:s', time()),
                                'chr_publish' => 'Y',
                                'chr_delete' => 'N'
                            );
                            $this->db->where('int_glcode', $val->image_id);
                            $this->db->update('post_gallery', $data_image);
//                            echo "dfgf"; die;
//                            echo $this->db->last_query();
                        } else {
                            $imageData = base64_decode($val->image);
                            $source = imagecreatefromstring($imageData);
                            $filename = $post_id . '-' . $i . '.jpeg';
                            $file = 'upimages/post_gallery/images/' . $filename;
                            imagejpeg($source, $file, 100);
                            imagedestroy($source);

                            $data_image = array(
                                'var_image' => $filename,
                                'fk_post' => $post_id,
                                'fk_user_id' => $user_id,
                                'dt_createdate' => date('Y-m-d H:i:s', time()),
                                'dt_modifydate' => $modifydate,
                                'chr_publish' => 'Y',
                                'chr_delete' => 'N'
                            );
                            $this->db->insert('post_gallery', $data_image);
                        }
                        $i++;
                    }
//                    else {
//                        foreach ($images as $val) {
//                            $imageData = base64_decode($val);
//                            $source = imagecreatefromstring($imageData);
////                            $filename = uniqid() . '.jpeg';
//                            $filename = $id . '-' . $i . '.jpeg';
//                            $file = 'upimages/post_gallery/images/' . $filename;
//                            imagejpeg($source, $file, 100);
//                            $data_image = array(
//                                'var_image' => $filename,
//                                'fk_post' => $post_id,
//                                'fk_user_id' => $user_id,
//                                'dt_createdate' => $create_date,
//                                'dt_modifydate' => date('Y-m-d'),
//                                'chr_publish' => 'Y',
//                                'chr_delete' => 'N'
//                            );
//                            $this->db->insert('post_gallery', $data_image);
//                        }
//                    }
                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Buzz($buzz_id, $user_id, $buzz_title, $university_id, $description, $modifydate, $expirydate, $images) {
//        print_r($images); die;
        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $data = array(
                    'var_title' => $buzz_title,
                    'var_description' => $description,
                    'fk_university' => $university_id,
                    'fk_user_id' => $user_id,
                    'dt_expiredate' => $expirydate,
                    'dt_modifydate' => $modifydate
                );
                $this->db->where('int_glcode', $buzz_id);
                $this->db->update('campus_buzz', $data);
//                $id = $this->db->insert_id();

                if (!empty($images)) {

                    $i = 1;

                    foreach ($images as $val) {

                        if ($val->image_id != '0') {
                            $cntimg = $this->CheckImageAvailable_Buzz($val->image_id);
                            $imageData = base64_decode($val->image);
//                            echo $imageData; die;
                            $source = imagecreatefromstring($imageData);

                            $filename = $cntimg->var_image;
                            $file = 'upimages/campus_buzz_gallery/images/' . $filename;
                            imagejpeg($source, $file, 100);
                            imagedestroy($source);
                            $data_image = array(
                                'var_image' => $filename,
                                'fk_campus_buzz' => $buzz_id,
                                'fk_user_id' => $user_id,
                                'dt_modifydate' => date('Y-m-d H:i:s', time()),
                                'chr_publish' => 'Y',
                                'chr_delete' => 'N'
                            );
                            $this->db->where('int_glcode', $val->image_id);
                            $this->db->update('campus_buzz_gallery', $data_image);
                        } else {
                            $imageData = base64_decode($val->image);
                            $source = imagecreatefromstring($imageData);
                            $filename = $buzz_id . '-' . $i . '.jpeg';
                            $file = 'upimages/campus_buzz_gallery/images/' . $filename;
                            imagejpeg($source, $file, 100);
                            imagedestroy($source);

                            $data_image = array(
                                'var_image' => $filename,
                                'fk_campus_buzz' => $buzz_id,
                                'fk_user_id' => $user_id,
                                'dt_createdate' => date('Y-m-d H:i:s', time()),
                                'dt_modifydate' => $modifydate,
                                'chr_publish' => 'Y',
                                'chr_delete' => 'N'
                            );
                            $this->db->insert('campus_buzz_gallery', $data_image);
                        }
                        $i++;
                    }

                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Status($post_id, $user_id, $status) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {


                $query_countpost = "select * from post_management WHERE chr_delete='N' and  fk_user_id='" . $user_id . "' and int_glcode='" . $post_id . "'";
                $resultcntpost = $this->db->query($query_countpost);
                $countpost = $resultcntpost->num_rows();
                if ($countpost > 0) {
                    if ($status == '3') {
                        $update_status = "UPDATE post_management SET chr_status= $status, chr_delete='Y'  WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $post_id . "'";
                        $this->db->query($update_status);
                    } else {
                        $update_status = "UPDATE post_management SET chr_status= $status WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $post_id . "' and chr_delete='N' and chr_publish='Y'";
                        $this->db->query($update_status);
                    }

                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record Not Found.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Buzz_Status($buzz_id, $user_id, $status) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $query_countpost = "select * from campus_buzz WHERE chr_delete='N' and  fk_user_id='" . $user_id . "' and int_glcode='" . $buzz_id . "'";
                $resultcntpost = $this->db->query($query_countpost);
                $countpost = $resultcntpost->num_rows();
                if ($countpost > 0) {
                    if ($status == '3') {
                        $update_status = "UPDATE campus_buzz SET chr_status= $status, chr_delete='Y' WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $buzz_id . "'";
                        $this->db->query($update_status);
                    } else {
                        $update_status = "UPDATE campus_buzz SET chr_status= $status WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $buzz_id . "' and chr_delete='N' and chr_publish='Y'";
                        $this->db->query($update_status);
                    }

                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record Not Found.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Deal_Status($deal_id, $user_id, $status) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {


                $query_countpost = "select * from campus_deal WHERE chr_delete='N' and  fk_user_id='" . $user_id . "' and int_glcode='" . $deal_id . "'";
                $resultcntpost = $this->db->query($query_countpost);
                $countpost = $resultcntpost->num_rows();
                if ($countpost > 0) {
                    $update_status = "UPDATE campus_deal SET chr_status= $status WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $deal_id . "' and chr_delete='N' and chr_publish='Y'";
                    $this->db->query($update_status);
                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record Not Found.'
                    );
                    return $this->response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Favorite_Status($post_id, $user_id, $status) {
        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $sqlCountPages = "select * FROM favorite  where fk_post=$post_id";
                $query = $this->db->query($sqlCountPages);
                $rs = $query->num_rows();
//                echo $rs;
//                die;
                if ($rs > 0) {
                    $data_favorite = array(
                        'fk_user_id' => $user_id,
                        'fk_post' => $post_id,
                        'dt_createdate' => date('Y-m-d H:i:s', time()),
                        'chr_favorite' => $status,
                        'type' => '1'
                    );
                    $this->db->where('fk_post', $post_id);
                    $this->db->update('favorite', $data_favorite);
                } else {
                    $data_favorite = array(
                        'fk_user_id' => $user_id,
                        'fk_post' => $post_id,
                        'dt_createdate' => date('Y-m-d H:i:s', time()),
                        'chr_favorite' => $status,
                        'type' => '1'
                    );
                    $this->db->insert('favorite', $data_favorite);
                }
                $response['Response'] = array(
                    'status' => '204',
                    'message' => 'Updated.'
                );
                return $this->response($response);
//                $query_countpost = "select * from post_management WHERE chr_delete='N' and  fk_user_id='" . $user_id . "' and int_glcode='" . $post_id . "'";
//                $resultcntpost = $this->db->query($query_countpost);
//                $countpost = $resultcntpost->num_rows();
//                if ($countpost > 0) {
//                    $update_status = "UPDATE post_management SET chr_favorite= $status WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $post_id . "' and chr_delete='N' and chr_publish='Y'";
//                    $this->db->query($update_status);
//                    $response['Response'] = array(
//                        'status' => '204',
//                        'message' => 'Updated.'
//                    );
//                    return $this->response($response);
//                } else {
//                    $response['Response'] = array(
//                        'status' => '404',
//                        'message' => 'Record Not Found.'
//                    );
//                    return $this->response($response);
//                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function changepassword($user_id, $oldpwd, $newpwd) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $this->db->select('COUNT(1) as total');
                $this->db->where('chr_delete', 'N');
                $this->db->where('chr_publish', 'Y');
                $this->db->where('int_glcode', $user_id);
                $this->db->where('var_password', $this->mylibrary->cryptPass($oldpwd));
                $query = $this->db->get('users_manage');
                $Result = $query->row();
                if ($Result->total > 0) {
                    $data = Array(
                        'var_password' => $this->mylibrary->cryptPass($newpwd),
                    );
                    $this->db->where('chr_delete', 'N');
                    $this->db->where('chr_publish', 'Y');
                    $this->db->where('int_glcode', $user_id);
                    $this->db->update('users_manage', $data);

                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.',
                        'newpassword' => $newpwd
                    );
                    return $this->response($response);
                } else {
                    $response['Response'] = array(
                        'status' => '1021',
                        'message' => 'Please enter correct old password.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function CheckImage($fkpost) {
        $sqlCountPages = "select * FROM post_gallery  where chr_delete='N' and fk_post=$fkpost";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->num_rows();
        return $rs;
    }

    function CheckImageAvailable($imgid) {
        $sqlCountPages = "select var_image FROM post_gallery  where chr_delete='N' and int_glcode=$imgid";
        $query = $this->db->query($sqlCountPages);
        $rs = $query->row();
        return $rs;
    }

    function CheckImageAvailable_Buzz($imgid) {
        $sqlCountPages = "select var_image FROM campus_buzz_gallery  where chr_delete='N' and int_glcode='" . $imgid . "'";
        $query = $this->db->query($sqlCountPages);
//        echo $this->db->last_query(); die;
        $rs = $query->row();
        return $rs;
    }

    function send_post_message($post_id, $user_id, $user_name, $message, $date, $postname, $thread_id, $reply_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

//                $query_countpost = "select * from message_thread WHERE  fk_user_id='" . $user_id . "' and fk_post='" . $post_id . "'";
                $query_countpost = "select * from message_thread WHERE  fk_user_id='" . $user_id . "' and fk_post='" . $post_id . "'";
                $resultcntpost = $this->db->query($query_countpost);
                $result = $resultcntpost->row();
//                print_r($result);
//                die;
                $countpost = $resultcntpost->num_rows();

                $query_check_Id = "select fk_user_id from post_management WHERE  int_glcode='" . $post_id . "'";
                $resultcnt_UID = $this->db->query($query_check_Id);
                $result_UID = $resultcnt_UID->row();

//                if($countpost != '0')
                $query_check_Id1 = "select post_owner_id,int_glcode from message_thread WHERE  post_owner_id='" . $user_id . "' and fk_post= $post_id";
                $resultcnt_UID1 = $this->db->query($query_check_Id1);
                $countpost1 = $resultcnt_UID1->num_rows();
//                echo $countpost; die;
//            }
//                echo $thread_id; die;
                if ($thread_id != '') {
                    $query_check_Id2 = "select post_owner_id,int_glcode,fk_user_id from message_thread WHERE  int_glcode='" . $thread_id . "'";
                    $resultcnt_UID2 = $this->db->query($query_check_Id2);
                    $result2 = $resultcnt_UID2->row();

//                    echo $result2->post_owner_id; die;
//                    print_r($result2);
//                    die;
//                    echo $this->db->last_query(); die;
                }

//                echo $countpost1; die;
//                $countpost1 = $resultcnt_UID1->num_rows();
//                echo $countpost; die;
//                if ($result_UID->fk_user_id == $user_id) {
//                   
//                    if ($countpost1 != '0') {
//                        $fkthread1 = $result2->int_glcode;
//                    } else {
//                        $fkthread1 = $result->int_glcode;
//                    }
//                    
//                    $update_status = "UPDATE message_thread SET own_delete='0' WHERE int_glcode='" . $fkthread1 . "'";
//                    $this->db->query($update_status);
//                } 
//                else {
                if (!empty($result)) {
//                    echo "In"; die;
                    if ($countpost1 != '0') {
                        $fkthread1 = $result2->int_glcode;
                    } else {
                        $fkthread1 = $result->int_glcode;
                    }
                    $update_status = "UPDATE message_thread SET usr_delete='" . $result2->fk_user_id . "' WHERE int_glcode='" . $fkthread1 . "'";

                    $this->db->query($update_status);
                }

                if ($countpost == 0 && $countpost1 == 0) {

//                    if($result_UID1 == 0){
                    $data = array(
                        'fk_user_id' => $user_id,
                        'fk_post' => $post_id,
                        'var_user_name' => $user_name,
                        'var_message' => $message,
                        'dt_createdate' => $date,
                        'post_name' => $postname,
                        'post_owner_id' => $result_UID->fk_user_id,
                        'own_delete' => $result_UID->fk_user_id,
                        'usr_delete' => $user_id
                    );
//                    print_r($data); die;
                    $this->db->insert('message_thread', $data);
                    $id = $this->db->insert_id();
//}
                    $data1 = array(
                        'fk_thread' => $id,
                        'fk_post' => $post_id,
                        'fk_user_id' => $user_id,
                        'var_user_name' => $user_name,
                        'var_message' => $message,
                        'dt_createdate' => $date
                    );
//                    print_r($data1); die;
                    $this->db->insert('message_list', $data1);
                    $idss = $this->db->insert_id();
//echo $idss; die;
                    $this->mylibrary->insertinlogmanager(MODULE_ID, 'message_list', $user_id, $idss, '0');

//                    $logcnt = $this->count_notification($result_UID->fk_user_id);
//                      if ($reply_id != '') {
//                          echo "dfsadsaf"; die;
//                        $logcnt = $this->count_notification($reply_id);
//                    } else {
//                        $logcnt = $this->count_notification($result_UID->fk_user_id);
//                    }
                    if (!empty($idss)) {

                        $this->Send_Gcm_Message_Thread($idss, $post_id, $user_id);
                    }
                } else {

                    if ($countpost1 != '0') {
                        $fkthread = $result2->int_glcode;
                    } else {
                        $fkthread = $result->int_glcode;
                    }
                    if (!empty($thread_id)) {
                        if ($user_id == $reply_id) {
                            $From_update_status = "UPDATE message_thread  SET chr_read= '0' WHERE int_glcode=$thread_id";
                            $this->db->query($From_update_status);
                        } else {

                            $update_status1 = "UPDATE message_thread  SET from_read= '0' WHERE int_glcode=$thread_id";
                            $this->db->query($update_status1);
                        }
                    }

                    $update_date = "UPDATE message_thread  SET dt_createdate= '" . $date . "' WHERE int_glcode=$fkthread";
                    $this->db->query($update_date);

                    $data = array(
                        'fk_thread' => $fkthread,
                        'fk_post' => $post_id,
                        'fk_user_id' => $user_id,
                        'var_user_name' => $user_name,
                        'var_message' => $message,
                        'dt_createdate' => $date
                    );
                    $this->db->insert('message_list', $data);
                    $idss = $this->db->insert_id();

                    $this->mylibrary->insertinlogmanager(MODULE_ID, 'message_list', $user_id, $idss, '0');

//                    if ($reply_id == $user_id) {
////                    $Get_User_Id = "SELECT post_owner_id as userid FROM message_thread WHERE fk_user_id=$user_id group by userid";
////                    $res = $this->db->query($Get_User_Id);
////                    $User_Id_Code = $res->result_array();
//
////                    print_r($User_Id_Code); die;
//                    } 
//                    if ($reply_id != '') {
//                        $logcnt = $this->count_notification($reply_id);
//                    } else {
//                        $logcnt = $this->count_notification($user_id);
//                    }

                    $update_status = "UPDATE message_thread SET own_delete='" . $result2->post_owner_id . "', usr_delete='" . $result2->fk_user_id . "' WHERE int_glcode='" . $fkthread . "'";
                    $this->db->query($update_status);

                    if (!empty($idss)) {

                        $this->Send_Gcm_Message($idss, $post_id, $user_id, $reply_id, $thread_id);
                    }
                }
                //$this->mylibrary->insertinlogmanager(MODULE_ID,'message_list','var_title', $idss,'int_glcode');                 
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {

            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Message_List_From_Reply($post_id, $user_id) {

//        echo $post_id; die;
        $Get_User_Id = "SELECT int_glcode,post_owner_id,fk_user_id FROM message_thread WHERE fk_user_id=$user_id and fk_post=$post_id";
        $res = $this->db->query($Get_User_Id);
        $User_Id_Code = $res->row();



        if ($User_Id_Code->int_glcode == $user_id) {

//            $update_status = "UPDATE message_thread SET own_delete='" . $User_Id_Code->post_owner_id . "' WHERE int_glcode='" . $User_Id_Code->int_glcode . "'";
//            $this->db->query($update_status);


            $query = $this->db->query("SELECT ml.int_glcode as message_id,"
                    . "ml.fk_thread as thread_id,"
                    . "ml.int_glcode as msg_id,"
                    . "ml.fk_user_id as user_id, "
                    . "ml.fk_post as post_id,"
                    . "ml.var_user_name as user_name,"
                    . "ml.var_message as message,"
                    . "ml.chr_read as read_status, "
                    . "pm.fk_user_id as post_user_id, "
                    . "um.var_username as own_username, "
                    . "ml.dt_createdate as date "
                    . "FROM message_list as ml "
                    . "LEFT JOIN post_management as pm on ml.fk_post = pm.int_glcode"
                    . " LEFT JOIN users_manage as um on pm.fk_user_id = um.int_glcode"
                    . " WHERE ml.fk_thread='" . $User_Id_Code->int_glcode . "'");
        } else {

//            $update_status = "UPDATE message_thread SET usr_delete='" . $User_Id_Code->fk_user_id . "' WHERE int_glcode='" . $User_Id_Code->int_glcode . "'";
//            $this->db->query($update_status);

            $query = $this->db->query("SELECT ml.int_glcode as message_id,"
                    . "ml.fk_thread as thread_id,"
                    . "ml.int_glcode as msg_id,"
                    . "ml.fk_user_id as user_id, "
                    . "ml.fk_post as post_id,"
                    . "ml.var_user_name as user_name,"
                    . "ml.var_message as message,"
                    . "ml.chr_read as read_status, "
                    . "pm.fk_user_id as post_user_id, "
                    . "um.var_username as own_username, "
                    . "ml.dt_createdate as date "
                    . "FROM message_list as ml "
                    . "LEFT JOIN post_management as pm on ml.fk_post = pm.int_glcode"
                    . " LEFT JOIN users_manage as um on pm.fk_user_id = um.int_glcode"
                    . " WHERE ml.fk_thread='" . $User_Id_Code->int_glcode . "'");
        }

        $Result = $query->result_array();
//echo $this->db->last_query(); die;
        if (!empty($Result)) {
            $response_post['Response'] = array(
                'status' => '200',
                'message' => 'Success.',
                "Details" => $Result
            );
            return $this->response($response_post);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Records Not Found.'
            );
            return $this->error_response($response);
        }
    }

    function Send_Gcm_Message($idname, $post_id, $user_id, $reply_id, $thread_id) {

        if ($user_id == $reply_id) {
//            $Get_User_Id = "SELECT post_owner_id as userid FROM message_thread WHERE fk_user_id=$user_id group by userid";
            $Get_User_Id = "SELECT post_owner_id as userid FROM message_thread WHERE int_glcode=$thread_id";
            $res = $this->db->query($Get_User_Id);
            $User_Id_Code = $res->result_array();
        } elseif ($reply_id != '') {

            $Get_User_Id = "SELECT fk_user_id as userid FROM message_list WHERE fk_post=$post_id and fk_user_id = $reply_id group by userid";

            $res = $this->db->query($Get_User_Id);
            $User_Id_Code = $res->result_array();
        } else {
//            $Get_User_Id = "SELECT fk_user_id as userid FROM message_list WHERE fk_post=$post_id and fk_user_id = $user_id group by userid";
//            $Get_User_Id = "SELECT fk_user_id as userid FROM message_list WHERE fk_post=$post_id and fk_user_id != $user_id group by userid";
            $Get_User_Id = "SELECT post_owner_id as userid FROM message_thread WHERE fk_post=$post_id and fk_user_id = $user_id group by userid";
            $res = $this->db->query($Get_User_Id);
            $User_Id_Code = $res->result_array();
        }
//  print_r($User_Id_Code); die;
        foreach ($User_Id_Code as $value) {
            $usr_id = $value['userid'];
            if ($usr_id != '' && $usr_id != '0') {
                $logcnt = $this->count_notification($usr_id);
//                    ******** Old Start
//                $Get_User_Reg_Id = "SELECT gcm_code,device_id, int_glcode as user_id FROM users_manage WHERE int_glcode=$usr_id";
//                $query = pg_query($Get_User_Reg_Id);
//                $Gcm_Code = pg_fetch_array($query);
//                    ******** Old End ****
//           ********************* Start New *************     
                $Get_All_Gcm_Id = "SELECT gcm_code FROM manage_gcmcode WHERE fk_user=$usr_id";
                $query_gcm_dis = pg_query($Get_All_Gcm_Id);
                $gcm_Idss = pg_fetch_all($query_gcm_dis);

                $Get_All_Devices_Id = "SELECT device_id FROM user_devices WHERE fk_user=$usr_id";
                $query_devices_dis = pg_query($Get_All_Devices_Id);
                $Devices_Idss = pg_fetch_all($query_devices_dis);

                //           ********************* Start End *************     
                $query_message = "SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.fk_user_id as user_id,
                            msg.fk_post as post_id,
                            msg.fk_thread as thread_id,
                            msg.int_glcode as msg_id,
                            pm.var_postname as post_name,
                            var_message as message,
                            msg.var_user_name as user_name,
                             (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
                            FROM logmanager as log
                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
                            LEFT JOIN post_management as pm on msg.fk_post = pm.int_glcode
                            where log.var_referenceid=$idname and log.var_tablename = 'message_list'
                            and log.notification_type != ''";

                $Result_message = pg_query($query_message);
                $Data_Message = pg_fetch_array($Result_message);

//                $gcmRegIds = array($Gcm_Code['gcm_code']);
//                $DeviceRegIds = $Gcm_Code['device_id'];

                $message = array(
                    "notification_id" => $Data_Message['notification_id'],
                    "notification_type" => $Data_Message['notification_type'],
                    "name" => $Data_Message['post_name'],
                    "id" => $Data_Message['post_id'],
                    "thread_id" => $Data_Message['thread_id'],
                    "user_id" => $Data_Message['user_id'],
                    "message" => "You have new message from " . $Data_Message['user_name'] . "",
                    "badge" => $logcnt
                );

//                if ($Gcm_Code['gcm_code'] != '') {
//                    $this->sendMessageThroughGCM($gcmRegIds, $message, $Gcm_Code['gcm_code']);
//                }
//                if ($Gcm_Code['device_id'] != '') {
//
//                    $this->sendMessageThroughGCM_ios($DeviceRegIds, $message, $logcnt);
//                }
                if (!empty($gcm_Idss)) {
                    foreach ($gcm_Idss as $gcm_value) {
                        $gcmRegIds = array($gcm_value['gcm_code']);
                        $this->sendMessageThroughGCM($gcmRegIds, $message, $gcm_value['gcm_code']);
                    }
                }
                if (!empty($Devices_Idss)) {
//                    $i=0;
                    foreach ($Devices_Idss as $didss) {
                        $this->sendMessageThroughGCM_ios($didss['device_id'], $message);
                        $i++;
                    }
                }
//echo $i; die;
                if ($device_id == '') {
                    $response['Response'] = array(
                        'status' => '201',
                        'message' => 'Message sent.'
                    );
                    return $this->response($response);
                }
            }
        }
    }

    function sendMessageThroughGCM($registatoin_ids, $message, $device_id) {

        //Google cloud messaging GCM-API url
        $url = 'https://android.googleapis.com/gcm/send';
        $fields = array(
            'data' => $message,
            'registration_ids' => $registatoin_ids
        );

        $headers = array(
            'Authorization: key=' . GOOGLE_API_KEY,
            'Content-Type: application/json'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }
        curl_close($ch);
//        if ($device_id == '') {
//            $response['Response'] = array(
//                'status' => '201',
//                'message' => 'Message sent.'
//            );
//            return $this->response($response);
//        }
//        location.reload(); 
        return $result;
    }

    function sendMessageThroughGCM_ios($registatoin_ids, $message, $logcnt) {


        $deviceToken = $registatoin_ids;
//        $message = 'New Push Notification!';
// Create the payload body
//        $body['aps'] = array(
//            'data' => $message
////            'registration_ids' => $registatoin_ids
//        );


        $body['aps'] = array(
            'alert' => $message['message'],
            'notification_id' => $message['notification_id'],
            "notification_type" => $message['notification_type'],
            "name" => $message['name'],
            "id" => $message['id'],
            "thread_id" => $message['thread_id'],
            "user_id" => $message['user_id'],
            "badge" => $message['badge']
        );
//        $body['aps'] = array(
//            'notification_id' => $message['notification_id'],
//            'notification_type' => $message['notification_type'],
//            'name' => $message['name'],
//            'id' => $message['id'],
//            'thread_id' => $message['thread_id'],
//            'user_id' => $message['user_id'],
//            'message' => $message['message']
//        );
//        print_r($body1);
//print_r($body);
//        die; 
        $ctx = stream_context_create();

        //  ***************************** Production Start ***********************************
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'pushcert.pem');
        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');

        $fp = stream_socket_client(
                'ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
//        ******************* Production End *************************
//       **************************** Development Start ******************** 
//        stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
//        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
//
//        $fp = stream_socket_client(
//                'ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
//        ************** Developement End *************************

        $payload = json_encode($body);

// Build the binary notification
        $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
// Send it to the server
//     fwrite($fp, $msg, strlen($msg));
        $result = fwrite($fp, $msg, strlen($msg));
//        if (!$result)
//            echo 'Error, notification not sent' . PHP_EOL;
//        else
//            echo 'notification sent!' . PHP_EOL;
// Close the connection to the server
        fclose($fp);
//        $response['Response'] = array(
//            'status' => '201',
//            'message' => 'Message sent.'
//        );
//        return $this->response($response);
    }

    function Send_Gcm_Message_Thread($idname, $post_id, $user_id) {

        $Get_User_Id = "SELECT fk_user_id as userid FROM post_management WHERE int_glcode=$post_id";
        $query_user = pg_query($Get_User_Id);
        $User_Id_Code = pg_fetch_array($query_user);
        //$query_user = pg_query($Get_User_Id);
        //$User_Id_Code = pg_fetch_array($query_user);
        //foreach ($User_Id_Code as $value) {
        $usr_id = $User_Id_Code['userid'];
//        echo $usr_id; die;

        if ($usr_id != '' && $usr_id != '0') {

            $logcnt = $this->count_notification($usr_id);
//old
//            $Get_User_Reg_Id = "SELECT gcm_code,device_id,int_glcode as user_id FROM users_manage WHERE int_glcode=$usr_id";
//            $query = pg_query($Get_User_Reg_Id);
//            $Gcm_Code = pg_fetch_array($query);
//Old End 
//            ************** New Start ******************
            $Get_All_Gcm_Id = "SELECT gcm_code FROM manage_gcmcode WHERE fk_user=$usr_id";
            $query_gcm_dis = pg_query($Get_All_Gcm_Id);
            $gcm_Idss = pg_fetch_all($query_gcm_dis);

            $Get_All_Devices_Id = "SELECT device_id FROM user_devices WHERE fk_user=$usr_id";
            $query_devices_dis = pg_query($Get_All_Devices_Id);
            $Devices_Idss = pg_fetch_all($query_devices_dis);

//            ************** New End ******************

            $query_message = "SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.fk_user_id as user_id,
                            msg.fk_post as post_id,
                            msg.fk_thread as thread_id,
                            msg.int_glcode as msg_id,
                            pm.var_postname as post_name,
                            var_message as message,
                            msg.var_user_name as user_name,
                             (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
                            FROM logmanager as log
                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
                            LEFT JOIN post_management as pm on msg.fk_post = pm.int_glcode
                            where log.var_referenceid=$idname and log.var_tablename = 'message_list'
                            and log.notification_type != ''";

            $Result_message = pg_query($query_message);
            $Data_Message = pg_fetch_array($Result_message);
            //$Result_message = $query_message->result_array();
//            $gcmRegIds = array($Gcm_Code['gcm_code']);
//            $DevicesRegIds = $Gcm_Code['device_id'];

            $message = array(
                "notification_id" => $Data_Message['notification_id'],
                "notification_type" => $Data_Message['notification_type'],
                "name" => $Data_Message['post_name'],
                "id" => $Data_Message['post_id'],
                "thread_id" => $Data_Message['thread_id'],
                "user_id" => $Data_Message['user_id'],
                "message" => "You have new message from '" . $Data_Message['user_name'] . "'.",
                "badge" => $logcnt
            );

//            if ($Gcm_Code['gcm_code'] != '') {
//                $this->sendMessageThroughGCM($gcmRegIds, $message, $Gcm_Code['gcm_code']);
//            }
//
//            if ($Gcm_Code['device_id'] != '') {
//                $this->sendMessageThroughGCM_ios($DevicesRegIds, $message);
//            }
//                ************* New Start ****************** 
            if (!empty($gcm_Idss)) {
                foreach ($gcm_Idss as $gcm_value) {
                    $gcmRegIds = array($gcm_value['gcm_code']);
                    $this->sendMessageThroughGCM($gcmRegIds, $message, $gcm_value['gcm_code']);
                }
            }

            if (!empty($Devices_Idss)) {
                foreach ($Devices_Idss as $didss) {
                    $this->sendMessageThroughGCM_ios($didss['device_id'], $message);
                }
            }
            //      ************* End Start ****************** 

            $response['Response'] = array(
                'status' => '201',
                'message' => 'Message sent.'
            );
            return $this->response($response);
        }
//        }
    }

    function get_Threadlist_data($fk) {

        $Get = "select post_owner_id,fk_user_id from message_thread WHERE  fk_user_id='" . $fk . "' OR post_owner_id='" . $fk . "' group by post_owner_id,fk_user_id";
        $resultcntpost2 = $this->db->query($Get);
        $count = $resultcntpost2->num_rows;
//        echo $this->db->last_query(); die;
        $result = $resultcntpost2->result();
        return $result;
//        $tes = explode(',', $result);
//         if ($count > 0) {
//         }
//        print_r($tes);
//        die;
//        echo $tes;
//        die;
    }

    function Get_Thread_list($user_id, $start, $end) {
        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $query_countpost = "select post_owner_id,fk_user_id from message_thread WHERE  post_owner_id='" . $user_id . "'";
                $resultcntpost = $this->db->query($query_countpost);
                $result = $resultcntpost->row();
//                echo $result->post_owner_id; die;
//                print_r($result); die;
                $countpost = $resultcntpost->num_rows();

                $get_multi_thread_data = $this->get_Threadlist_data($user_id);

                $cnt = count($get_multi_thread_data);
//                $i = 0;
                if ($cnt > 0) {
                    foreach ($get_multi_thread_data as $key => $value) {
                        $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
                        //      ************* Old ******************

                        if ($value->post_owner_id == $user_id) {
                            $wercsause = "and mt.own_delete='0'";
                        }
                        if ($value->fk_user_id == $user_id) {
                            $wercsause = "and mt.usr_delete='0'";
                        }

                        $query = $this->db->query("SELECT um.var_username as owner_name,mt.int_glcode as thread_id, mt.fk_user_id as user_id,"
                                . "mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.from_read as from_status,mt.post_name as post_name, pm.var_postname as post_namea, "
                                . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image  FROM message_thread mt "
                                . "left join post_management pm on mt.fk_post = pm.int_glcode "
                                . "LEFT JOIN users_manage as um on mt.post_owner_id = um.int_glcode"
                                . " where ((mt.post_owner_id ='" . $value->post_owner_id . "' and mt.fk_user_id ='" . $value->fk_user_id . "') OR (mt.post_owner_id ='" . $value->fk_user_id . "' and mt.fk_user_id ='" . $value->post_owner_id . "')) and (mt.own_delete='" . $user_id . "' OR mt.usr_delete='" . $user_id . "') "
                                . " order by mt.dt_createdate ASC $limitby   ");
//                        echo $this->db->last_query(); die;
                        //  ************* Old ******************
//                        **************************** New **************************
//                        if ($result->post_owner_id == $value->fk_user_id) {
//                            $query = $this->db->query("SELECT um.var_username as owner_name,mt.int_glcode as thread_id, mt.fk_user_id as user_id,"
//                                    . "mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.from_read as from_status,mt.post_name as post_name, pm.var_postname as post_namea, "
//                                    . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image "
//                                    . ",(SELECT ml.var_message FROM message_list as ml WHERE mt.int_glcode = ml.fk_thread order by ml.dt_createdate DESC OFFSET 0 limit 1) as message  FROM message_thread mt "
//                                    . "left join post_management pm on mt.fk_post = pm.int_glcode "
//                                    . "LEFT JOIN users_manage as um on mt.post_owner_id = um.int_glcode"
//                                    . " where  mt.post_owner_id ='" . $value->post_owner_id . "' and mt.fk_user_id ='" . $value->fk_user_id . "' and mt.own_delete='0' "
//                                    . "$limitby ");
//                        } else {
//                            $query = $this->db->query("SELECT um.var_username as owner_name,mt.int_glcode as thread_id, mt.fk_user_id as user_id,"
//                                    . "mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.from_read as from_status,mt.post_name as post_name, pm.var_postname as post_namea, "
//                                    . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image "
//                                    . ",(SELECT ml.var_message FROM message_list as ml WHERE mt.int_glcode = ml.fk_thread order by ml.dt_createdate DESC OFFSET 0 limit 1) as message  FROM message_thread mt "
//                                    . "left join post_management pm on mt.fk_post = pm.int_glcode "
//                                    . "LEFT JOIN users_manage as um on mt.post_owner_id = um.int_glcode"
//                                    . " where   mt.post_owner_id ='" . $value->fk_user_id . "' and mt.fk_user_id ='" . $value->post_owner_id . "' and mt.usr_delete='0'  "
//                                    . "$limitby ");
//                        }
                        // **************************** New **************************
//                        echo $this->db->last_query();
//                        die;
//                                                        . " GROUP BY mt.int_glcode, mt.fk_user_id,mt.fk_post,"
//                                . "mt.var_user_name,mt.dt_createdate,mt.chr_read,"
//                                . "mt.post_name,pm.var_postname "

                        foreach ($query->result_array() as $key => $row) {
//                        foreach ($query->result_array() as $row) {
//                          echo $row['thread_id'];
                            $Result1[] = array(
                                'thread_id' => $row['thread_id'],
                                'user_id' => $row['user_id'],
                                'post_id' => $row['post_id'],
                                'user_name' => $row['user_name'],
                                'create_date' => $row['create_date'],
                                'read_status' => $row['read_status'],
                                'post_name' => $row['post_name'],
                                'post_namea' => $row['post_namea'],
                                'image' => $row['image'],
                                'from_status' => $row['from_status'],
                                'owner_name' => $row['owner_name'],
                                'message' => $row['message']
                            );
                        }
                    }
                    $Result2 = array_unique($Result1, SORT_REGULAR);
                    $Result = array_reverse($Result2);
//                    $Result = array_map('unserialize', array_unique(array_map('serialize', $Result1)));
//                    print_r($Result);
                    if (!empty($Result)) {


                        $response_Uni_list['Response'] = array(
                            'status' => '200',
                            'message' => 'Success.',
                            'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                            "thread" => 'multi',
                            "Details" => $Result
                        );
                        return $this->response($response_Uni_list);
                    } else {
                        if ($start == '0') {
                            $response['Response'] = array(
                                'status' => '404',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        } else {
                            $response['Response'] = array(
                                'status' => '4041',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        }
                    }
//                    $user_id_thrd = implode(',', $get_user);
//                    $Own_id_thrd = implode(',', $get_owner_id);
//
//                    $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
//                    $query = $this->db->query("SELECT mt.int_glcode as thread_id,mt.fk_user_id as user_id, mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.post_name as post_name, pm.var_postname as post_namea, "
//                            . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image  FROM message_thread mt "
//                            . "left join post_management pm on mt.fk_post = pm.int_glcode "
//                            . "where mt.post_owner_id IN($Own_id_thrd) and mt.fk_user_id IN($user_id_thrd) OR mt.post_owner_id IN($user_id_thrd) and mt.fk_user_id IN($Own_id_thrd)  $limitby ");
//                    $Result = $query->result_array();
                } elseif ($result->post_owner_id == $user_id) {

                    $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
                    $query = $this->db->query("SELECT mt.post_owner_id,mt.int_glcode as thread_id,mt.fk_user_id as user_id, mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.post_name as post_name, pm.var_postname as post_namea, "
                            . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image  FROM message_thread mt "
                            . "left join post_management pm on mt.fk_post = pm.int_glcode "
                            . "where mt.post_owner_id=$user_id  $limitby ");
                    $Result = $query->result_array();
                    if (!empty($Result)) {


                        $response_Uni_list['Response'] = array(
                            'status' => '200',
                            'message' => 'Success.',
                            'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                            "Details" => $Result
                        );
                        return $this->response($response_Uni_list);
                    } else {
                        if ($start == '0') {
                            $response['Response'] = array(
                                'status' => '404',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        } else {
                            $response['Response'] = array(
                                'status' => '4041',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        }
                    }
//                    echo $this->db->last_query(); die;
                } else {

                    $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
                    $query = $this->db->query("SELECT mt.post_owner_id,mt.int_glcode as thread_id,mt.fk_user_id as user_id, mt.fk_post as post_id, mt.var_user_name as user_name,mt.dt_createdate as create_date,mt.chr_read as read_status,mt.post_name as post_name, pm.var_postname as post_namea, "
                            . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = mt.fk_post OFFSET 0 limit 1) AS image  FROM message_thread mt "
                            . "left join post_management pm on mt.fk_post = pm.int_glcode "
                            . " where mt.fk_user_id=$user_id  $limitby ");
                    $Result = $query->result_array();
                    if (!empty($Result)) {


                        $response_Uni_list['Response'] = array(
                            'status' => '200',
                            'message' => 'Success.',
                            'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                            "Details" => $Result
                        );
                        return $this->response($response_Uni_list);
                    } else {
                        if ($start == '0') {
                            $response['Response'] = array(
                                'status' => '404',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        } else {
                            $response['Response'] = array(
                                'status' => '4041',
                                'message' => 'Records Not Found.'
                            );
                            return $this->error_response($response);
                        }
                    }
                }
//echo $this->db->last_query(); die;
//                print_r($Result);
//                die;
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Message_List($thread_id, $post_id, $user_id, $read, $owner_name, $own_Id, $notifi_id, $chrlog) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $update_status = "UPDATE message_list SET chr_read= $read WHERE fk_thread=$thread_id and fk_post=$post_id";
                $this->db->query($update_status);
                if ($notifi_id != '') {
                    $update_status = "UPDATE logmanager SET chr_read='" . $chrlog . "' WHERE int_glcode='" . $notifi_id . "'";
                    $this->db->query($update_status);
                }
                if ($user_id == $own_Id) {
                    $From_update_status = "UPDATE message_thread  SET from_read= $read WHERE int_glcode=$thread_id";
                    $this->db->query($From_update_status);
                } else {
                    $update_status1 = "UPDATE message_thread  SET chr_read= $read WHERE int_glcode=$thread_id and fk_post=$post_id and fk_user_id=$user_id  ";
                    $this->db->query($update_status1);
                }

                if ($user_id == $own_Id) {
                    $query = $this->db->query("SELECT ml.int_glcode as message_id,"
                            . "ml.fk_thread as thread_id,"
                            . "ml.fk_user_id as user_id, "
                            . "ml.fk_post as post_id,"
                            . "ml.var_user_name as user_name,"
                            . "ml.var_message as message,"
                            . "ml.chr_read as read_status, "
                            . "pm.fk_user_id as post_user_id, "
                            . "um.var_username as own_username, "
                            . "ml.dt_createdate as date "
                            . "FROM message_list as ml "
                            . "LEFT JOIN post_management as pm on ml.fk_post = pm.int_glcode"
                            . " LEFT JOIN users_manage as um on pm.fk_user_id = um.int_glcode"
                            . " WHERE ml.fk_thread=$thread_id and ml.own_delete='0'");
                    $Result = $query->result_array();
                } else {
                    $query = $this->db->query("SELECT ml.int_glcode as message_id,"
                            . "ml.fk_thread as thread_id,"
                            . "ml.fk_user_id as user_id, "
                            . "ml.fk_post as post_id,"
                            . "ml.var_user_name as user_name,"
                            . "ml.var_message as message,"
                            . "ml.chr_read as read_status, "
                            . "pm.fk_user_id as post_user_id, "
                            . "um.var_username as own_username, "
                            . "ml.dt_createdate as date "
                            . "FROM message_list as ml "
                            . "LEFT JOIN post_management as pm on ml.fk_post = pm.int_glcode"
                            . " LEFT JOIN users_manage as um on pm.fk_user_id = um.int_glcode"
                            . " WHERE ml.fk_thread=$thread_id ");
                    $Result = $query->result_array();
                }
//echo $this->db->last_query(); die;
                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Favorite_List($user_id, $start, $end) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
                $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
                $query = $this->db->query("SELECT "
                        . "pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id,"
                        . "pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.chr_status as status,"
                        . "pm.dt_expiredate as expirydate,"
                        . "(SELECT pg.var_image FROM post_gallery as pg "
                        . "WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image "
                        . " FROM favorite as fv "
                        . "LEFT JOIN post_management as pm ON fv.fk_post=pm.int_glcode "
                        . "WHERE "
                        . "fv.fk_user_id =$user_id "
                        . "and fv.chr_favorite = '1' "
                        . "and pm.chr_delete='N' "
                        . "and pm.chr_block ='0' "
                        . "and pm.chr_publish='Y' $limitby");

                $Result = $query->result_array();

                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_post_data($user_id, $post_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {
                $query = $this->db->query("SELECT var_postname as post_name,"
                        . "pm.fk_post_cate as post_cate_id,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,"
                        . "pm.dt_expiredate as expiry_date,"
                        . "pm.dt_createdate as create_date,"
                        . "pm.fk_university as university_id,"
                        . "pm.chr_status as status,"
                        . "pm.chr_favorite as favorite,"
                        . "pc.var_categoryname as category_name"
                        . " from post_management as pm "
                        . "LEFT JOIN post_category as pc on pm.fk_post_cate = pc.int_glcode  "
                        . "WHERE  pm.int_glcode= $post_id and pm.fk_user_id IN($user_id, 0) and pm.chr_delete='N' and pm.chr_publish='Y'");
                $Result = $query->result_array();
//echo $this->db->last_query(); die;
                $query_photo = $this->db->query("SELECT int_glcode as photo_id, var_image as post_image from post_gallery WHERE fk_post= $post_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'");
                $Result_photo = $query_photo->result_array();

                if (!empty($Result_photo) || !empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/post_gallery/images/',
                        "Details" => $Result,
                        "Gallery" => $Result_photo
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Buzz_Data($user_id, $buzz_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {
                $query = $this->db->query("SELECT "
                        . "pm.var_title as buzz_name,"
                        . "pm.var_description as description,"
                        . "pm.dt_expiredate as expiry_date,"
                        . "pm.dt_createdate as create_date,"
                        . "pm.fk_university as university_id,"
                        . "pm.chr_status as status "
                        . " from campus_buzz as pm "
                        . "WHERE  pm.int_glcode= $buzz_id and pm.fk_user_id IN($user_id, 0) and pm.chr_delete='N' and pm.chr_publish='Y'");
                $Result = $query->result_array();
//echo $this->db->last_query(); die;
                $query_photo = $this->db->query("SELECT int_glcode as photo_id, var_image as buzz_image from campus_buzz_gallery WHERE fk_campus_buzz= $buzz_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'");
                $Result_photo = $query_photo->result_array();

                if (!empty($Result_photo) || !empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath' => SITE_PATH . 'upimages/campus_buzz_gallery/images/',
                        "Details" => $Result,
                        "Gallery" => $Result_photo
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Post_Count($user_id, $post_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
                //$query = $this->db->query("SELECT pm.int_glcode as post_id,pm.fk_user_id as user_id, pm.var_postname as post_name,pm.var_description as description,pm.var_price as price,pm.chr_status as status,pm.chr_favorite as favorite,pm.dt_expiredate as expirydate,(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image FROM post_management as pm WHERE pm.dt_expiredate >= DATE(now()) and  pm.fk_user_id IN($user_id, 0) and pm.chr_favorite = '" . $chr_fav . "' and pm.chr_delete='N' and pm.chr_publish='Y'");
                //$Result = $query->result_array();
                $query = "SELECT * FROM post_management WHERE int_glcode = $post_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'";
                $query1 = $this->db->query($query);
                $count = $query1->num_rows;
                if ($count > 0) {
                    $update_count_sql = "UPDATE post_management SET int_count=int_count+1 WHERE int_glcode='" . $post_id . "'";
                    $this->db->query($update_count_sql);

//                if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.'
//                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Update_Deal_Code_Count($user_id, $deal_id) {

//        $this->db->where('int_glcode', $user_id);
//        $this->db->where('chr_delete', 'N');
//        $query = $this->db->get('users_manage');
//        $Result_user_check = $query->row_array();
//
//        if (!empty($Result_user_check)) {
//            if ($Result_user_check['chr_publish'] == 'Y') {

        $query = "SELECT * FROM campus_deal WHERE int_glcode = $deal_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'";
        $query1 = $this->db->query($query);
        $count = $query1->num_rows;
        if ($count > 0) {
            $update_count_sql = "UPDATE campus_deal SET code_count=code_count+1 WHERE int_glcode='" . $deal_id . "'";
            $this->db->query($update_count_sql);
            $response_post['Response'] = array(
                'status' => '200',
                'message' => 'Success.'
            );
            return $this->response($response_post);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Record not found.'
            );
            return $this->error_response($response);
        }
//            }
//            else {
//                $response['Response'] = array(
//                    'status' => '401',
//                    'message' => 'Unauthorized access.'
//                );
//                return $this->error_response($response);
//            }
//        } else {
//            $response['Response'] = array(
//                'status' => '400',
//                'message' => 'Bad Request due to invalid parameters.'
//            );
//            return $this->error_response($response);
//        }
    }

    function Update_Buzz_Count($user_id, $buzz_id) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {
                //$query = $this->db->query("SELECT pm.int_glcode as post_id,pm.fk_user_id as user_id, pm.var_postname as post_name,pm.var_description as description,pm.var_price as price,pm.chr_status as status,pm.chr_favorite as favorite,pm.dt_expiredate as expirydate,(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image FROM post_management as pm WHERE pm.dt_expiredate >= DATE(now()) and  pm.fk_user_id IN($user_id, 0) and pm.chr_favorite = '" . $chr_fav . "' and pm.chr_delete='N' and pm.chr_publish='Y'");
                //$Result = $query->result_array();
                $query = "SELECT * FROM campus_buzz WHERE int_glcode = $buzz_id and fk_user_id IN($user_id, 0) and chr_delete='N' and chr_publish='Y'";
                $query1 = $this->db->query($query);
                $count = $query1->num_rows;
                if ($count > 0) {

                    $update_count_sql = "UPDATE campus_buzz SET int_count=int_count+1 WHERE int_glcode='" . $buzz_id . "'";
                    $this->db->query($update_count_sql);

                    //if (!empty($Result)) {
                    $response_post['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.'
//                        "Details" => $Result
                    );
                    return $this->response($response_post);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

//    Update_Edit_Profile

    function Update_Edit_Profile($user_id, $university_id, $email_id, $var_username) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $query = "SELECT fk_university FROM users_manage WHERE int_glcode = $user_id";
                $query1 = $this->db->query($query);
                $uni = $query1->row();
//                echo $uni->fk_university;  die;
//                $count = $query1->num_rows;

                if ($uni->fk_university == $university_id) {
                    $data = array(
                        'fk_university' => $university_id,
                        'var_emailid' => $email_id,
                        'var_username' => $var_username
                    );
                    $this->db->where('int_glcode', $user_id);
                    $this->db->update('users_manage', $data);
                    $response_post['Response'] = array(
                        'status' => '204',
                        'message' => 'Updated.'
                    );
                    return $this->response($response_post);
                } else {

                    $update_count_sql = "UPDATE campus_buzz SET chr_delete='Y' WHERE fk_user_id='" . $user_id . "'";
                    $this->db->query($update_count_sql);

                    $update_count_sql = "UPDATE campus_deal SET chr_delete='Y' WHERE fk_user_id='" . $user_id . "'";
                    $this->db->query($update_count_sql);

                    $update_count_sql = "UPDATE post_management SET chr_delete='Y' WHERE fk_user_id='" . $user_id . "'";
                    $this->db->query($update_count_sql);

                    $Delete_Favorite = "DELETE from favorite where fk_user_id='" . $user_id . "'";
                    $this->db->query($Delete_Favorite);

                    $data = array(
                        'fk_university' => $university_id,
                        'var_emailid' => $email_id,
                        'var_username' => $var_username
                    );
                    $this->db->where('int_glcode', $user_id);
                    $this->db->update('users_manage', $data);

                    $response['Response'] = array(
                        'status' => '204',
                        'message' => 'University Updated and All the post, deal and buzz expired.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function validatePassword($oldpwd, $user_id) {
        $olds_pwd = $this->mylibrary->cryptPass($oldpwd);
        $query_countpost = "select * from users_manage WHERE chr_delete='N' and  var_password='" . $olds_pwd . "' and int_glcode='" . $user_id . "'";
        $resultcntpost = $this->db->query($query_countpost);
        $countuser = $resultcntpost->num_rows();
        return $countuser;
    }

    function Delete_Thread($thread_id, $own_id) {

        $cnt = count($thread_id);

        if ($cnt != 0) {
            for ($i = 0; $i < $cnt; $i++) {
//******************* Check both side delete *************************
                $query_dlt = "select int_glcode,fk_user_id from message_thread WHERE int_glcode='" . $thread_id[$i] . "' and own_delete ='' OR usr_delete=''";
                $cntss = $this->db->query($query_dlt);
                $count_delte = $cntss->num_rows();

//echo $count_delte; die;
//******************** Both side **************
                if ($count_delte == 0) {

                    $query_count = "select int_glcode,fk_user_id from message_thread WHERE int_glcode='" . $thread_id[$i] . "' and post_owner_id ='" . $own_id . "'";
                    $resultcnt = $this->db->query($query_count);
                    $threlst = $resultcnt->row();

                    $countss = $resultcnt->num_rows();

                    if ($countss != 0) {
                        $update_count_sql = "UPDATE message_thread SET own_delete='' WHERE int_glcode='" . $thread_id[$i] . "'";
                        $this->db->query($update_count_sql);
//                    $update_count_sql1 = "UPDATE message_list SET own_delete='1' WHERE fk_thread='" . $thread_id[$i] . "'";
//                    $this->db->query($update_count_sql1);
                    } else {
                        $update_count_sql = "UPDATE message_thread SET usr_delete='' WHERE int_glcode='" . $thread_id[$i] . "'";
                        $this->db->query($update_count_sql);
//                    $update_count_sql1 = "UPDATE message_list SET usr_delete='1' WHERE fk_thread='" . $thread_id[$i] . "'";
//                    $this->db->query($update_count_sql1);
                    }
//                if ($usecnt != 0) {
//                    $update_count_sql = "UPDATE message_thread SET usr_delete='1' WHERE int_glcode='" . $thread_id[$i] . "'";
//                    $this->db->query($update_count_sql);
//                }
                } else {

                    $this->db->where('int_glcode', $thread_id[$i]);
                    $this->db->delete('message_thread');

                    $this->db->where('fk_thread', $thread_id[$i]);
                    $this->db->delete('message_list');

//                    echo $this->db->last_query(); die;
                }
            }
//            $this->db->where('fk_thread', $thread_id);
//            $this->db->where('int_glcode', $thread_id);
//            $this->db->delete('message_thread');
//
//            $this->db->where('fk_thread', $thread_id);
//            $this->db->delete('message_list');

            $response['Response'] = array(
                'status' => '200',
                'message' => 'Success.'
            );
            return $this->error_response($response);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Record not found.'
            );
            return $this->error_response($response);
        }
    }

    function Delete_Post($post_id, $buzz_id) {

        $cnt = count($post_id);
        $buzz_cnt = count($buzz_id);

        if ($cnt != 0 || $buzz_cnt != 0) {

            for ($i = 0; $i < $cnt; $i++) {
                if ($post_id[$i] != '') {
                    $update_count_sql1 = "UPDATE post_management SET chr_delete='Y' WHERE int_glcode='" . $post_id[$i] . "'";
                    $this->db->query($update_count_sql1);
//                $query_count = "select int_glcode from message_thread WHERE int_glcode='" . $thread_id[$i] . "' and post_owner_id ='" . $own_id . "'";
//                $resultcnt = $this->db->query($query_count);
//                $countss = $resultcnt->num_rows();
                }
            }


            for ($j = 0; $j < $buzz_cnt; $j++) {
                if ($buzz_id[$j] != '') {
                    $update_count_sql = "UPDATE campus_buzz SET chr_delete='Y' WHERE int_glcode='" . $buzz_id[$j] . "'";
                    $this->db->query($update_count_sql);
                }
//                $query_count = "select int_glcode from message_thread WHERE int_glcode='" . $thread_id[$i] . "' and post_owner_id ='" . $own_id . "'";
//                $resultcnt = $this->db->query($query_count);
//                $countss = $resultcnt->num_rows();
            }
            $response['Response'] = array(
                'status' => '200',
                'message' => 'Success.'
            );
            return $this->error_response($response);
        } else {
            $response['Response'] = array(
                'status' => '404',
                'message' => 'Record not found.'
            );
            return $this->error_response($response);
        }
    }

    function Get_notification($user_id) {

//        $query = $this->db->query("SELECT chr_publish,int_glcode FROM users_manage where chr_delete='N' and chr_publish='Y' and int_glcode=$user_id");
//        $Result = $query->result_array();
        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {


                $query_postdetail = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.dt_createdate as create_date,
                            pm.int_glcode as id,
                            pm.fk_user_id as user_id,
                            pm.var_postname as name,
                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,
                            (SELECT pg.int_glcode FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id
                            FROM logmanager as log
                            LEFT JOIN post_management as pm on log.var_referenceid = pm.int_glcode
                            LEFT JOIN post_category as pc on pm.fk_post_cate = pc.int_glcode
                            LEFT JOIN university_management as uni on pm.fk_university = uni.int_glcode
                            where log.fk_user_id=$user_id and log.var_tablename = 'post_management'
                            and pm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
                $Result_post = $query_postdetail->result_array();
//echo $this->db->last_query(); die;

                $query_Buzzdetail = $this->db->query("SELECT 
                        log.int_glcode as notification_id,
                        log.var_referenceid as reference_id,
                        log.notification_type,
                        log.dt_createdate as create_date,
                        bm.int_glcode as id,
                        bm.fk_user_id as user_id,
                        bm.var_title as name,
                        (SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image,
                        (SELECT cbg.int_glcode FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image_id
                        FROM logmanager as log
                        LEFT JOIN campus_buzz as bm on log.var_referenceid = bm.int_glcode
                        LEFT JOIN university_management as uni on bm.fk_university = uni.int_glcode
                        where log.fk_user_id=$user_id and log.var_tablename = 'campus_buzz'
                        and bm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
                $Result_Buzz = $query_Buzzdetail->result_array();


                $query_dlt = "select own_delete, int_glcode from message_thread WHERE usr_delete='" . $user_id . "'";

                $cntss = $this->db->query($query_dlt);
                $cnnns = $cntss->result_array();
                $countowns = count($cnnns);
                foreach ($cnnns as $key => $value) {
                    $list[] = $value['own_delete'];
                    $list1[] = $value['int_glcode'];
                }
                $own_id = implode(', ', $list);
                $thrId = implode(', ', $list1);

//echo $own_id; "<br>";
//echo $thrId; die;
//                if (!empty($own_id)) {
//                    $getown = " and log.fk_user_id IN($own_id)";
//                }
//                if (!empty($thrId)) {
//                    $Thrd_Ids = " and msg.fk_thread IN($thrId)";
//                }
//                if ($countowns == '0') {

                $query_dlt = "select usr_delete, int_glcode from message_thread WHERE own_delete='" . $user_id . "'";
                $use_dlt = $this->db->query($query_dlt);
                $cnnns_usr = $use_dlt->result_array();
                foreach ($cnnns_usr as $key => $value_usr) {
                    $list2[] = $value_usr['usr_delete'];
                    $list3[] = $value_usr['int_glcode'];
                }
                $usr_id = implode(', ', $list2);
                $lst_usr = implode(', ', $list3);
//echo $usr_id; "<br/>";
//echo $lst_usr; "<br/>"; die;
//                if (!empty($usr_id)) {
//                    $getusr = " and log.fk_user_id IN($usr_id)";
//                }
//                if (!empty($lst_usr)) {
//                    $thrd_usr = " and msg.fk_thread IN($lst_usr)";
//                }
//

                if (!empty($own_id) && !empty($usr_id)) {
                    $getown_or = " and (log.fk_user_id IN($own_id) OR log.fk_user_id IN($usr_id))";
                } else {


                    if (!empty($own_id)) {
                        $getown = " and log.fk_user_id IN($own_id)";
                    }
                    if (!empty($usr_id)) {
                        $getusr = " and log.fk_user_id IN($usr_id)";
                    }
                }


                if (!empty($thrId) && !empty($lst_usr)) {
                    $Thrd_Ids_OR = "and (msg.fk_thread IN($thrId) OR msg.fk_thread IN($lst_usr))";
                } else {

                    if (!empty($thrId)) {
                        $Thrd_Ids = " and msg.fk_thread IN($thrId)";
                    }
                    if (!empty($lst_usr)) {
                        $thrd_usr = " and msg.fk_thread IN($lst_usr)";
                    }
                }

//              echo $own_id; "<br/>";
//              echo $usr_id; "<br/>";
                if (!empty($getown) || !empty($getusr) || !empty($Thrd_Ids) || !empty($thrd_usr) || !empty($Thrd_Ids_OR) || !empty($getown_or)) {

                    $query_message = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.chr_read,
                            msg.fk_post as post_id,
                            msg.int_glcode as message_id,
                            msg.fk_user_id as user_id,
                            msg.fk_thread as thread_id,
                            msg.var_user_name as user_name,
                            pm.var_postname as post_name,
                             (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
                            FROM logmanager as log
                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
                            LEFT JOIN post_management as pm on msg.fk_post = pm.int_glcode
                            where  log.chr_read ='N' and log.var_tablename = 'message_list' $getown_or $Thrd_Ids_OR $getown $getusr $Thrd_Ids $thrd_usr
                             and log.notification_type != '' and log.fk_user_id != $user_id order by log.dt_createdate DESC");
//                   echo $this->db->last_query(); die;
                    $Result_message = $query_message->result_array();
                }

//                echo $this->db->last_query();
//                die;
//                $query_message = $this->db->query("SELECT 
//                            log.int_glcode as notification_id,
//                            log.var_referenceid as reference_id,
//                            log.notification_type,
//                            log.dt_createdate as create_date,
//                            msg.fk_post as post_id,
//                            msg.int_glcode as message_id,
//                            mt.post_name as post_name,
//                            msg.fk_user_id as user_id,
//                            msg.fk_thread as thread_id,
//                            msg.var_user_name as user_name,
//                            mt.fk_post as mt_post_id,
//                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
//                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
//                            FROM logmanager as log
//                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
//                            LEFT JOIN message_thread as mt on msg.fk_thread = mt.int_glcode                            
//                            where  msg.fk_post = mt.fk_post and msg.fk_user_id != $user_id and log.var_tablename = 'message_list'
//                            and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
//                echo $this->db->last_query();
//                die;
//                print "<pre/>";
//                print_r($Result_message);
//                die;

                if (!empty($Result_post) || !empty($Result_Buzz) || !empty($Result_message)) {

                    $response_cate_list['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'imagepath_post' => SITE_PATH . 'upimages/post_gallery/images/',
                        'imagepath_buzz' => SITE_PATH . 'upimages/campus_buzz_gallery/images/',
                        "Details_post" => $Result_post,
                        "Details_buzz" => $Result_Buzz,
                        "Result_message" => $Result_message
                    );
                    return $this->response($response_cate_list);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Detail_notification_post($user_id, $notification__id, $referance_id, $notification_type, $tablename, $chr_read) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $query = $this->db->query("SELECT var_title as title, var_image as image, int_glcode as image_id from post_gallery WHERE  fk_post=$referance_id and fk_user_id = $user_id and chr_delete='N' and chr_publish='Y'");
                $Images = $query->result_array();

//                $query_res = $this->db->query("SELECT * FROM post_management where fk_user_id = $user_id and int_glcode= $referance_id and chr_delete='N'");

                $query_res = $this->db->query("SELECT pm.int_glcode as post_id,"
                        . "pm.fk_user_id as user_id,"
                        . " pm.var_postname as post_name,"
                        . "pm.var_description as description,"
                        . "pm.var_price as price,pm.chr_status as status,"
                        . "pm.chr_favorite as favorite,"
                        . "pm.dt_expiredate as expirydate"
                        . " FROM post_management as pm WHERE  pm.chr_delete='N' and pm.chr_publish='Y' and fk_user_id = $user_id and int_glcode= $referance_id ");
                $Result = $query_res->result_array();

                if ($chr_read != 'N') {
//                    echo "In"; die;
//                    $update_read = "UPDATE logmanager SET chr_read= 'Y' WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $notification__id . "'and var_referenceid='" . $referance_id . "' and chr_delete='N'";
                    $update_read = "UPDATE logmanager SET chr_read= 'Y' WHERE  int_glcode='" . $notification__id . "'and var_referenceid='" . $referance_id . "' and chr_delete='N'";
                    $this->db->query($update_read);
                }

                if (!empty($Result)) {
                    $response_cate_list['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'images' => $Images,
                        "Details" => $Result
                    );
                    return $this->response($response_cate_list);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Get_Detail_notification_Buzz($user_id, $notification__id, $referance_id, $notification_type, $tablename, $chr_read) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();
        if (!empty($Result_user_check)) {

            if ($Result_user_check['chr_publish'] == 'Y') {

                $query = $this->db->query("SELECT var_image as image,fk_user_id as user_id from campus_buzz_gallery WHERE  fk_campus_buzz = $referance_id and fk_user_id = $user_id and chr_delete='N' and chr_publish='Y'");
                $images = $query->result_array();

//                if ($chr_read != 'N') {
//                    $update_read_msg = "UPDATE message_list SET chr_read= 'Y' WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $notification__id . "'and var_referenceid='" . $referance_id . "'";
//                    $this->db->query($update_read_msg);
//                }
//                $query_res = $this->db->query("SELECT * FROM campus_buzz where fk_user_id = $user_id and int_glcode= $referance_id and chr_delete='N'");
//                $Result = $query_res->result_array();

                $query_res = $this->db->query("SELECT "
                        . "cb.int_glcode as buzz_id,"
                        . "cb.var_title as buzz_name,"
                        . "cb.var_description as description,"
                        . "cb.dt_createdate as crate_date,"
                        . "cb.dt_expiredate as expirydate"
                        . " FROM campus_buzz as cb WHERE  "
                        . "cb.fk_user_id = $user_id and cb.int_glcode= $referance_id and cb.chr_delete='N'");
                $Result = $query_res->result_array();
//             echo $this->db->last_query(); die;
                if ($chr_read != 'N') {

                    $update_read = "UPDATE logmanager SET chr_read= 'Y' WHERE fk_user_id='" . $user_id . "' and int_glcode='" . $notification__id . "'and var_referenceid='" . $referance_id . "' and chr_delete='N'";
                    $this->db->query($update_read);
                }

                if (!empty($Result)) {
                    $response_cate_list['Response'] = array(
                        'status' => '200',
                        'message' => 'Success.',
                        'images' => $images,
                        "Details" => $Result
                    );
                    return $this->response($response_cate_list);
                } else {
                    $response['Response'] = array(
                        'status' => '404',
                        'message' => 'Record not found.'
                    );
                    return $this->error_response($response);
                }
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function response($responseArray) {
        echo json_encode($responseArray);
        exit;
    }

    function error_response($errorArray) {
        echo json_encode($errorArray);
        exit;
    }

    function stringchange($str = '') {
        $str = str_replace("&#60", "&lt;", $str);
        $str = str_replace("&#62", "&gt;", $str);
        $str = str_replace("&#38", "&amp;", $str);
        $str = str_replace("&#160", "&nbsp;", $str);
        $str = str_replace("&#162", "&cent;", $str);
        $str = str_replace("&#163", "&pound;", $str);
        $str = str_replace("&#165", "&yen;", $str);
        $str = str_replace("&#8364", "&euro;", $str);
        $str = str_replace("&#169", "&copy;", $str);
        $string = str_replace("&#174", "&reg;", $str);
        return html_entity_decode($string);
    }

    function Search_All_Data($search_text, $uni_id, $start, $end) {

        $Search = trim($search_text);
        if ($Search != '') {
            $value = $Search;
        } else {
            $value = '';
        }
        $value = addslashes($value);


//        $sql[] = "select  'PM' as type,"
//                . "fk_user_id as user_id,"
//                . "int_glcode as id,"
//                . "var_postname as title,"
//                . "var_description as shorttext,"
//                . "'' as extra,"
//                . "'' as extra1 "
//                . "from post_management where "
//                . "(var_postname like '%" . $value . "%' "
//                . "or var_description like '%" . $value . "%') "
//                . "and chr_publish='Y' and chr_delete='N' "
//                . "and chr_status='0'"
//                . "and chr_block ='0'"
//                . "and fk_university = '" . $uni_id . "'";


        $sql[] = "SELECT 'PM' as type,"
                . "pm.int_glcode as id,"
                . "pm.fk_user_id as user_id,"
                . "pm.var_postname as title,"
                . "pm.var_price as price,"
                . "pm.dt_expiredate as expirydate,"
                . "pm.chr_status as status,"
                . "'upimages/post_gallery/images/' as imagepath,"
                . "(SELECT pg.var_image FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,"
                . "(SELECT pg.int_glcode FROM post_gallery as pg WHERE pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id "
                . "FROM post_management as pm WHERE "
                . "(pm.var_postname ILIKE '%" . $value . "%' "
                . "or pm.var_description ILIKE '%" . $value . "%') "
                . "and pm.fk_university IN($uni_id,0) "
                . "and pm.chr_status!='3'"
                . " and pm.dt_expiredate >= DATE(now()) "
                . " and pm.chr_block ='0'"
                . " and  pm.chr_delete='N'"
                . " and pm.chr_publish='Y'";

        $sql[] = "SELECT 'CB' as type, "
                . "cb.int_glcode as id,"
                . "cb.fk_user_id as user_id,"
                . "cb.var_title as title,"
                . "'' as price,"
                . "cb.dt_expiredate as expirydate,"
                . "cb.chr_status as status,"
                . "'upimages/campus_buzz_gallery/images/' as imagepath,"
                . "(SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE cbg.fk_campus_buzz = cb.int_glcode OFFSET 0 limit 1) AS image,"
                . "(SELECT cbg.int_glcode FROM campus_buzz_gallery as cbg WHERE cbg.fk_campus_buzz = cb.int_glcode OFFSET 0 limit 1) AS image_id "
                . "FROM campus_buzz as cb WHERE  "
                . "(cb.var_title ILIKE '%" . $value . "%' "
                . "or cb.var_description ILIKE '%" . $value . "%') "
                . "and cb.fk_university IN($uni_id,0) "
                . "and cb.chr_delete='N' "
                . "and cb.chr_publish='Y' "
                . "and cb.dt_expiredate >= DATE(now()) "
                . "and cb.chr_status!='3' "
                . "and cb.chr_block='0'";

//        $sql[] = "SELECT 'CD' as type, "
//                . "cd.int_glcode as id,"
//                . "cd.fk_user_id as user_id,"
//                . "cd.var_title as title,"
//                . "'' as price,"
//                . "cd.dt_expiredate as expirydate,"
//                . "'' as status,"
//                . "'upimages/campus_gallery/images/' as imagepath,"
//                . "(SELECT cg.var_image FROM campus_gallery as cg WHERE cg.fk_campus_deal = cd.int_glcode OFFSET 0 limit 1) AS image,"
//                . "(SELECT cg.int_glcode FROM campus_gallery as cg WHERE cg.fk_campus_deal = cd.int_glcode OFFSET 0 limit 1) AS image_id "
//                . " FROM campus_deal as cd WHERE"
//                . "(cd.var_title ILIKE '%" . $value . "%' "
//                . "or cd.var_description ILIKE '%" . $value . "%') "
//                . " and cd.fk_university IN($uni_id,0) "
//                . "and cd.chr_delete='N' "
//                . "and cd.chr_publish='Y' "
//                . "and cd.chr_status='0' "
//                . "and chr_block='0'";
//        $sql[] = "select 'CD' as type, "
//                . "fk_user_id as user_id, "
//                . "int_glcode as id, "
//                . "var_title as title, "
//                . "var_description as shorttext, "
//                . "'' as extra, "
//                . "'' as extra1 "
//                . "from campus_buzz where (var_title like '%" . $value . "%' "
//                . "or var_description like '%" . $value . "%' ) "
//                . "and chr_publish = 'Y' and "
//                . "chr_delete = 'N'"
//                . "and chr_status='0'"
//                . "and chr_block ='0'"
//                . "and fk_university = '" . $uni_id . "'";

        
       $mainSQL = implode(" union ", $sql);
//        print_r($sql);
//        exit;
//        $mainSQL = "select if(LOCATE('{$value}', newDB.title)>0, LOCATE('{$value}', newDB.title), 9999999) as sorter, newDB.* from (" . $mainSQL . ") as newDB order by field(type, 'PM', 'CB', 'CD'), sorter ";
//        $limit = "order by type, 'PM', 'CB', 'CD'";
        $limitby = 'OFFSET ' . $start . ' LIMIT ' . $end;
        $mainSQL = $mainSQL . $limitby . $limit;
        $query = $this->db->query($mainSQL);
        $news_row = $query->result_array();

        if (!empty($news_row)) {
            $response['Response'] = array(
                'status' => '201',
                'message' => 'Search Results for  "' . $value . '"',
                'URL' => SITE_PATH,
                'Details' => $news_row
            );
            return $this->response($response);
        } else {
            if ($start == '0') {
                $response['Response'] = array(
                    'status' => '404',
                    'message' => 'Your search "' . $value . '" did not match with any records'
                );
                return $this->error_response($response);
            } else {
                $response['Response'] = array(
                    'status' => '4041',
                    'message' => 'Record not found.'
                );
                return $this->error_response($response);
            }

//            $this->errorArray['status'] = "404";
//            $this->errorArray['message'] = "Your search '" . $value . "' did not match with any records";
//            return $this->error_response($this->errorArray);
        }
    }

    function Get_Restaurant_Detail(
    $rest_id) {

        $query = $this->db->query("SELECT int_glcode as Restaurant_id, var_company as Restaurant_name, var_personname as Person_name, var_image as Image, var_emailid as Emailid, var_address1 as Address, var_phoneno as Phoneno FROM restaurant WHERE chr_delete = 'N' and int_glcode = $rest_id");
//        $rs = $query->row_array();
        $rs = $query->row();
        $pagecount = $query->num_rows();
        if ($pagecount > 0) {
            // $this->returndataArray['Description'] = $rs->Text_Fulltext;
            //$this->returndataArray['Restaurant_detail'] = $rs;
            //$this->response($this->returndataArray);
            //header('Content-Type: application/json');
            return json_encode($rs, 200);
        } else {
            $this->errorArray['status'] = "400";
            $this->errorArray['message'] = "Requested Restaurant is not available.";
            return $this->error_response($this->errorArray);
        }
    }

    function Insert_Contactus(
    $user_name, $user_email, $message, $user_id, $created_date) {

        $this->db->where('int_glcode', $user_id);
        $this->db->where('chr_delete', 'N');
        $query = $this->db->get('users_manage');
        $Result_user_check = $query->row_array();

        if (!empty($Result_user_check)) {
            if ($Result_user_check['chr_publish'] == 'Y') {

                $data = array(
                    'var_name' => $user_name,
                    'var_email' => $user_email,
                    'var_message' => $message,
                    'fk_user_id' => $user_id,
                    'dt_createdate' => $created_date
                );
                $this->db->insert('contactusleads', $data);
                $response['Response'] = array(
                    'status' => '201',
                    'message' => 'Thank you for contacting us, we will get back to you shortly.'
                );
                return $this->response($response);
            } else {
                $response['Response'] = array(
                    'status' => '401',
                    'message' => 'Unauthorized access.'
                );
                return $this->error_response($response);
            }
        } else {
            $response['Response'] = array(
                'status' => '400',
                'message' => 'Bad Request due to invalid parameters.'
            );
            return $this->error_response($response);
        }
    }

    function Insert_new_University($uni_name, $user_email, $created_date) {

        $data = array(
            'var_name' => $uni_name,
            'var_email' => $user_email,
            'dt_createdate' => $created_date
        );
        $this->db->insert('university_leads', $data);
        $response['Response'] = array(
            'status' => '201',
            'message' => 'Thank you for contacting us, we will get back to you shortly.'
        );
        return $this->response($response);
    }

    function error_message() {
        $response['Response'] = array(
            'status' => '400',
            'message' => 'Requested is not available.'
        );
        return $this->error_response($response);
    }

    function Bad_Request_error_message() {
        $response[
                'Response'] = array(
            'status' => '400',
            'message' => 'Bad Request due to invalid parameters.'
        );
        return $this->error_response($response);
    }

    function Send_Forgotpassword($email) {

//         $Email = $this->input->get_post('Email');
//print_r($Email); exit;

//        $this->db->select('var_emailid,var_password,var_username');
//        $this->db->where('chr_delete', 'N');
//        $this->db->where('chr_publish', 'Y');
//        $this->db->where('var_emailid', $email);
//        $query = $this->db->get('users_manage');
//        echo "select var_emailid,var_password,var_username from users_manage where chr_delete = 'N' AND chr_publish = 'Y' AND LOWER(var_emailid) like LOWER('".$email."')";
        $query = $this->db->query("select var_emailid,var_password,var_username from users_manage where chr_delete = 'N' AND chr_publish = 'Y' AND LOWER(var_emailid) like LOWER('".$email."')");
        $count = $query->num_rows();
        $Result = $query->row();
        if ($Result->var_emailid != '') {
            $Regards = str_replace("@SITE_PATH", SITE_PATH);
            $subject = "Your password " . $Result->var_username;
            $pwd = $this->mylibrary->decryptPass($Result->var_password);
            $body_admin = $pwd;
            $EMAIL_LOGO_PATH = SITE_PATH . 'admin-media/Email-template/images/';
            $html_message = file_get_contents("admin-media/Email-template/forgot_pwd.html");
            $html_message = str_replace("@DETAILS", $body_admin, $html_message);
            $html_message = str_replace("@LOGO_PATH", $EMAIL_LOGO_PATH, $html_message);
            $html_message = str_replace("@username", $Result->var_username, $html_message);
            $html_message = str_replace("@YEAR", date('Y'), $html_message);
            $to = $email;
//            $config = array(
//                'protocol' => 'smtp',
//                'smtp_host' => 'ssl://smtp.googlemail.com',
//                'smtp_port' => '465',
//                'smtp_user' => 'no-reply@thriftskool.com',
//                'smtp_pass' => 'Thriftskool22',
////                'smtp_user' => 'donotreply@supporterinc.com',
////                'smtp_pass' => 'supporter1776',
//                'charset' => 'iso-8859-1',
//                'wordwrap' => TRUE
//            );
            $config = array(
                'protocol' => 'smtp',
                'smtp_host' => SMTP_HOST,
                'smtp_port' => SMTP_PORT,
                'smtp_user' => SMTP_USER,
                'smtp_pass' => SMTP_PASSWORD,
                'charset' => 'iso-8859-1',
                'wordwrap' => TRUE
            );

            $this->email->clear();
            $config['mailtype'] = "html";
            $this->email->initialize($config);
            $this->email->set_newline("\r\n");
            $this->email->from('no-reply@thriftskool.com', 'Thriftskool');
            $this->email->to($to);
            $data = array();
            $this->email->subject($subject);
            $this->email->message($html_message);

            if ($this->email->send()) {
                $returndataArray['Response'] = array(
                    'status' => '200',
                    'message' => 'Success.'
                );
                return $this->response($returndataArray);
            } else {
                echo $this->email->print_debugger();
                $returndataArray['Response'] = array(
                    'status' => '401',
                    'message' => 'Mail not Send.'
                );
                return $this->response($returndataArray);
            }
        } else {
            $response['Response'] = array(
                'status' => '1018',
                'message' => 'The requested email is not found.'
            );
            return $this->error_response($response);
        }
    }

//    function Send_Forgotpassword($email) {
//
//        $this->db->select('var_emailid,var_password,var_username');
//        $this->db->where('chr_delete', 'N');
//        $this->db->where('chr_publish', 'Y');
//        $this->db->where('var_emailid', $email);
//        $query = $this->db->get('users_manage');
//        $count = $query->num_rows();
//        $Result = $query->row();
//
//        if ($Result->var_emailid != '') {
//
//            $Regards = str_replace("@SITE_PATH", SITE_PATH);
//
//            $subject = "Your password " . $Result->var_username;
//
//            $pwd = $this->mylibrary->decryptPass($Result->var_password);
//            $body_admin = $pwd;
//
//            $EMAIL_LOGO_PATH = SITE_PATH . 'admin-media/Email-template/images/';
//
//            $html_message = file_get_contents("admin-media/Email-template/forgot_pwd.html");
//
//            $html_message = str_replace("@DETAILS", $body_admin, $html_message);
//            $html_message = str_replace("@LOGO_PATH", $EMAIL_LOGO_PATH, $html_message);
//            $html_message = str_replace("@username", $Result->var_username, $html_message);
//            $html_message = str_replace("@YEAR", date('Y'), $html_message);
//            $to = $email;
//
//            $config = array(
//                'protocol' => 'smtp',
//                'smtp_host' => SMTP_HOST,
//                'smtp_port' => SMTP_PORT,
//                'smtp_user' => SMTP_USER,
//                'smtp_pass' => SMTP_PASSWORD,
//                'charset' => 'iso-8859-1',
//                'wordwrap' => TRUE
//            );
//
//            $this->email->clear();
//            $config['mailtype'] = "html";
//            $this->email->initialize($config);
//            $this->email->set_newline("\r\n");
//            $this->email->from('no-reply@thriftskool.com', 'Thriftskool');
//            $this->email->to($to);
//            $data = array();
////            $htmlMessage = $this->parser->parse('messages/email', $data, true);
//            $this->email->subject($subject);
//            $this->email->message($html_message);
//
//            if ($this->email->send()) {
//                $returndataArray['Response'] = array(
//                    'status' => '200',
//                    'message' => 'Success.'
//                );
//                return $this->response($returndataArray);
//            } else {
//                $returndataArray['Response'] = array(
//                    'status' => '401',
//                    'message' => 'Mail not Send.'
//                );
//                return $this->response($returndataArray);
//            }
//        } else {
//            $response['Response'] = array(
//                'status' => '1018',
//                'message' => 'The requested email is not found.'
//            );
//            return $this->error_response($response);
//        }
//    }

    function Send_ForgotUserName($email) {
//        $this->db->select('var_emailid,var_password,var_username');
//        $this->db->where('chr_delete', 'N');
//        $this->db->where('chr_publish', 'Y');
//        $this->db->where('var_emailid', $email);
//        $query = $this->db->get('users_manage');
        $query = $this->db->query("select var_emailid,var_password,var_username from users_manage where chr_delete = 'N' AND chr_publish = 'Y' AND LOWER(var_emailid) like LOWER('".$email."')");
        $count = $query->num_rows();
        $Result = $query->row();
        if ($Result->var_emailid != '') {
            $Regards = str_replace("@SITE_PATH", SITE_PATH);
            $subject = "Your Username " . $Result->var_username;
            $pwd = $this->mylibrary->decryptPass($Result->var_password);
            $body_admin = $pwd;
            $EMAIL_LOGO_PATH = SITE_PATH . 'admin-media/Email-template/images/';
            $html_message = file_get_contents("admin-media/Email-template/forgot_username.html");
            $html_message = str_replace("@LOGO_PATH", $EMAIL_LOGO_PATH, $html_message);
            $html_message = str_replace("@username", $Result->var_username, $html_message);
            $html_message = str_replace("@YEAR", date('Y'), $html_message);
            $to = $email;
            $config = array(
                'protocol' => 'smtp',
                'smtp_host' => SMTP_HOST,
                'smtp_port' => SMTP_PORT,
                'smtp_user' => SMTP_USER,
                'smtp_pass' => SMTP_PASSWORD
            );
            $this->email->clear();
            $config['mailtype'] = "html";
            $this->email->initialize($config);
            $this->email->set_newline("\r\n");
            $this->email->from('no-reply@thriftskool.com', 'Thriftskool');
            $this->email->to($to);
            $data = array();
            $this->email->subject($subject);
            $this->email->message($html_message);

            if ($this->email->send()) {
                $returndataArray['Response'] = array(
                    'status' => '200',
                    'message' => 'Success.'
                );
                return $this->response($returndataArray);
            } else {
                $returndataArray['Response'] = array(
                    'status' => '401',
                    'message' => 'Mail not Send.'
                );
                return $this->response($returndataArray);
            }
        } else {
            $response['Response'] = array(
                'status' => '1018',
                'message' => 'The requested email is not found.'
            );
            return $this->error_response($response);
        }
    }

    function Verification_users($id) {

        $this->db->select('var_emailid,var_password,var_username');
        $this->db->where('chr_delete', 'N');
        $this->db->where('chr_publish', 'Y');
        $this->db->where('int_glcode', "$id");
        $query = $this->db->get('users_manage');
//        echo $this->db->last_query(); die;
        $count = $query->num_rows();
        $Result = $query->row();
        if ($count > 0) {
            $update_verify = "UPDATE users_manage SET chr_verify= 'Y' WHERE int_glcode='" . $id . "'and chr_delete='N'";
            $this->db->query($update_verify);
            $urlss = SITE_PATH . 'thank_you.php';
            header("Location: $urlss");
        } else {
            $response['Response'] = array(
                'status' => '401',
                'message' => 'The requested user is not found.'
            );
            return $this->error_response($response);
        }
    }

    function count_notification($user_id) {
        $query_postdetail = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.dt_createdate as create_date,
                            pm.int_glcode as id,
                            pm.fk_user_id as user_id,
                            pm.var_postname as name,
                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image,
                            (SELECT pg.int_glcode FROM post_gallery as pg WHERE 
                            pg.fk_post = pm.int_glcode OFFSET 0 limit 1) AS image_id
                            FROM logmanager as log
                            LEFT JOIN post_management as pm on log.var_referenceid = pm.int_glcode
                            LEFT JOIN post_category as pc on pm.fk_post_cate = pc.int_glcode
                            LEFT JOIN university_management as uni on pm.fk_university = uni.int_glcode
                            where log.chr_read ='N' and  log.fk_user_id=$user_id and log.var_tablename = 'post_management'
                            and pm.chr_delete='N' and log.notification_type != '' order by log.dt_createdate DESC");



        $Result_post = $query_postdetail->result_array();
        $cnt_post = count($Result_post);

        $query_Buzzdetail = $this->db->query("SELECT 
                        log.int_glcode as notification_id,
                        log.var_referenceid as reference_id,
                        log.notification_type,
                        log.dt_createdate as create_date,
                        bm.int_glcode as id,
                        bm.fk_user_id as user_id,
                        bm.var_title as name,
                        (SELECT cbg.var_image FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image,
                        (SELECT cbg.int_glcode FROM campus_buzz_gallery as cbg WHERE 
                        cbg.fk_campus_buzz = bm.int_glcode OFFSET 0 limit 1) AS image_id
                        FROM logmanager as log
                        LEFT JOIN campus_buzz as bm on log.var_referenceid = bm.int_glcode
                        LEFT JOIN university_management as uni on bm.fk_university = uni.int_glcode
                        where log.fk_user_id=$user_id and log.var_tablename = 'campus_buzz'
                        and bm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
        $Result_Buzz = $query_Buzzdetail->result_array();
        $cnt_buzz = count($Result_Buzz);


        $query_dlt = "select own_delete, int_glcode from message_thread WHERE usr_delete='" . $user_id . "'";
        $cntss = $this->db->query($query_dlt);
        $cnnns = $cntss->result_array();
        $countowns = count($cnnns);
        foreach ($cnnns as $key => $value) {
            $list[] = $value['own_delete'];
            $list1[] = $value['int_glcode'];
        }
        $own_id = implode(', ', $list);
        $thrId = implode(', ', $list1);

//        if (!empty($own_id)) {
//            $getown = " and log.fk_user_id IN($own_id)";
//        }
//        if (!empty($thrId)) {
//            $Thrd_Ids = " and msg.fk_thread IN($thrId)";
//        }
//        if ($countowns == '0') {
        $query_dlt = "select usr_delete, int_glcode from message_thread WHERE own_delete='" . $user_id . "'";
        $use_dlt = $this->db->query($query_dlt);
        $cnnns_usr = $use_dlt->result_array();
        foreach ($cnnns_usr as $key => $value_usr) {
            $list2[] = $value_usr['usr_delete'];
            $list3[] = $value_usr['int_glcode'];
        }
        $usr_id = implode(', ', $list2);
        $lst_usr = implode(', ', $list3);

//            if (!empty($usr_id)) {
//                $getusr = " and log.fk_user_id IN($usr_id)";
//            }
//
//            if (!empty($lst_usr)) {
//                $thrd_usr = " and msg.fk_thread IN($lst_usr)";
//            }
//        }


        if (!empty($own_id) && !empty($usr_id)) {
            $getown_or = " and (log.fk_user_id IN($own_id) OR log.fk_user_id IN($usr_id))";
        } else {


            if (!empty($own_id)) {
                $getown = " and log.fk_user_id IN($own_id)";
            }
            if (!empty($usr_id)) {
                $getusr = " and log.fk_user_id IN($usr_id)";
            }
        }


        if (!empty($thrId) && !empty($lst_usr)) {
            $Thrd_Ids_OR = "and (msg.fk_thread IN($thrId) OR msg.fk_thread IN($lst_usr))";
        } else {

            if (!empty($thrId)) {
                $Thrd_Ids = " and msg.fk_thread IN($thrId)";
            }
            if (!empty($lst_usr)) {
                $thrd_usr = " and msg.fk_thread IN($lst_usr)";
            }
        }
        if (!empty($getown) || !empty($getusr) || !empty($Thrd_Ids) || !empty($thrd_usr) || !empty($Thrd_Ids_OR) || !empty($getown_or)) {
            $query_message = $this->db->query("SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.dt_createdate as create_date,
                            msg.fk_post as post_id,
                            msg.int_glcode as message_id,
                            mt.post_name as post_name,
                            msg.fk_user_id as user_id,
                            msg.fk_thread as thread_id,
                            msg.var_user_name as user_name,
                            mt.fk_post as mt_post_id,
                            (SELECT pg.var_image FROM post_gallery as pg WHERE 
                            pg.fk_post = msg.fk_post OFFSET 0 limit 1) AS image
                            FROM logmanager as log
                            LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
                            LEFT JOIN message_thread as mt on msg.fk_thread = mt.int_glcode                            
                            where  msg.fk_post = mt.fk_post $getown_or $Thrd_Ids_OR $getown $getusr $Thrd_Ids $thrd_usr and log.var_tablename = 'message_list'
                            and log.chr_read ='N' and log.notification_type != '' and log.fk_user_id!=$user_id order by log.dt_createdate DESC");

//                echo $this->db->last_query();  die;
            // LEFT JOIN message_list as msg on log.var_referenceid = msg.int_glcode
//                            LEFT JOIN post_management as pm on msg.fk_post = pm.int_glcode
//                            where  log.chr_read ='N' and log.var_tablename = 'message_list' $getown_or $Thrd_Ids_OR $getown $getusr $Thrd_Ids $thrd_usr
//                             and log.notification_type != '' and log.fk_user_id != $user_id order by log.dt_createdate DESC");




            $Result_message = $query_message->result_array();
            $cnt_message = count($Result_message);
        }
        if (!empty($Result_post) || !empty($Result_Buzz) || !empty($Result_message)) {
            $sum = $cnt_post + $cnt_buzz + $cnt_message;
//            echo $sum; die;
            return $sum;
        }
    }

}

?>
