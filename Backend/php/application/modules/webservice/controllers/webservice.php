<?php

class webservice extends Front_Controller {

    public function __construct() {
        parent::__construct();

        $this->load->model('webservice_model', 'module_model');
        $this->load->library('user_agent');
        //$this->main_tpl = 'front/welcome_tpl';            // MODULE MAIN VIEW
        //$this->load->library('parser');
        //$this->load->helper(array('form', 'url'));
        $this->headers = $this->input->request_headers();
    }

    function login() {
        $data = json_decode(file_get_contents('php://input'));

//         echo json_encode($data->username);
//        exit;
//        print_r($data);
//        die;
        if ($data->username != '' && $data->password != '') {
            echo $this->module_model->Get_Login($data->username, $data->password, $data->device_id);
            exit;
        } else {
//            echo $this->module_model->error_message();
//            exit;
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function update_gcm() {
        $data_gcmdata = json_decode(file_get_contents('php://input'));
        if (!empty($data_gcmdata)) {
            echo $this->module_model->Get_Login_Gcm_id($data_gcmdata->user_id, $data_gcmdata->gcm_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function university_list() {
        echo $this->module_model->Get_University_List();
        exit;
    }

    function registration() {
        $registation = json_decode(file_get_contents('php://input'));
        if ($registation->university_id != '' && $registation->email_id != '' && $registation->user_name != '' && $registation->password != '' && $registation->device_id != '') {
            echo $this->module_model->Get_Registration($registation->university_id, $registation->email_id, $registation->user_name, $registation->password, $registation->device_id,$registation->person_name,$registation->class,$registation->profile_img);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function verification() {
        $id = $this->input->get_post('id');
        $descrypt_id = $this->mylibrary->decryptPass($id);
        if ($descrypt_id != '') {
            echo $this->module_model->Verification_users($descrypt_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_categorylist() {
        $pst_category = json_decode(file_get_contents('php://input'));

        if ($pst_category->user_id != '') {
            echo $this->module_model->Get_Post_Category_List($pst_category->user_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_list() {
        $post_list = json_decode(file_get_contents('php://input'));
        if ($post_list->post_cat_id != '' && $post_list->user_id != '' && $post_list->university_id != '' && $post_list->start != '' && $post_list->end != '') {
            echo $this->module_model->Get_Post_List($post_list->post_cat_id, $post_list->user_id, $post_list->university_id, $post_list->start, $post_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function latest_post_list() {
        $latest_post_list = json_decode(file_get_contents('php://input'));
        if ($latest_post_list->user_id != '' && $latest_post_list->university_id != '' && $latest_post_list->start != '' && $latest_post_list->end != '') {
            echo $this->module_model->Get_latest_Post_List($latest_post_list->user_id, $latest_post_list->university_id, $latest_post_list->start, $latest_post_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_detail() {

        $post_detail = json_decode(file_get_contents('php://input'));
        if ($post_detail->user_id != '' && $post_detail->post_id != '') {
            echo $this->module_model->Get_Post_Detail($post_detail->user_id, $post_detail->post_id, $post_detail->own_uid);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_insert() {

        $post_insert = json_decode(file_get_contents('php://input'));
        $imagesdata = $post_insert->images;

        if ($post_insert->user_id != '' && $post_insert->post_title != '' && $post_insert->university_id != '' && $post_insert->post_cat_id != '' && $post_insert->description != '' && $post_insert->price != '' && $post_insert->create_date != '' && $post_insert->expirydate != '' && $imagesdata != '') {
            echo $this->module_model->Insert_Post($post_insert->user_id, $post_insert->post_title, $post_insert->university_id, $post_insert->post_cat_id, $post_insert->description, $post_insert->price, $post_insert->create_date, $post_insert->expirydate, $imagesdata);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function get_postupdate() {

        $get_postupdate = json_decode(file_get_contents('php://input'));

        if ($get_postupdate->user_id != '' && $get_postupdate->post_id != '') {
            echo $this->module_model->Get_post_data($get_postupdate->user_id, $get_postupdate->post_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function get_buzz_update() {

        $get_postupdate = json_decode(file_get_contents('php://input'));

        if ($get_postupdate->user_id != '' && $get_postupdate->buzz_id != '') {
            echo $this->module_model->Get_Buzz_Data($get_postupdate->user_id, $get_postupdate->buzz_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function campus_deal_list() {
        $deal_list = json_decode(file_get_contents('php://input'));
        if ($deal_list->user_id != '' && $deal_list->university_id != '' && $deal_list->start != '' && $deal_list->end != '') {
            echo $this->module_model->Get_Campus_Deal_List($deal_list->user_id, $deal_list->university_id, $deal_list->start, $deal_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function deal_detail() {

        $deal_detail = json_decode(file_get_contents('php://input'));
        if ($deal_detail->deal_id != '') {
            echo $this->module_model->Get_Deal_Detail($deal_detail->deal_id, $deal_detail->user_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function campus_buzz_list() {
        $buzz_list = json_decode(file_get_contents('php://input'));
        if ($buzz_list->user_id != '' && $buzz_list->university_id != '' && $buzz_list->start != '' && $buzz_list->end != '') {
            echo $this->module_model->Get_Campus_Buzz_List($buzz_list->user_id, $buzz_list->university_id, $buzz_list->start, $buzz_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function buzz_detail() {

        $buzz_detail = json_decode(file_get_contents('php://input'));
        if ($buzz_detail->buzz_id != '' && $buzz_detail->user_id != '') {
            echo $this->module_model->Get_Buzz_Detail($buzz_detail->buzz_id, $buzz_detail->user_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function buzz_insert() {
        $buzz_insert = json_decode(file_get_contents('php://input'));
        $imagesdata = $buzz_insert->images;

        if ($buzz_insert->user_id != '' && $buzz_insert->buzz_title != '' && $buzz_insert->university_id != '' && $buzz_insert->description != '' && $buzz_insert->expirydate != '' && $imagesdata != '') {
            echo $this->module_model->Insert_Buzz($buzz_insert->user_id, $buzz_insert->buzz_title, $buzz_insert->university_id, $buzz_insert->description, $buzz_insert->expirydate, $imagesdata);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function job_list() {
        $job_list = json_decode(file_get_contents('php://input'));
        if ($job_list->user_id != '' && $job_list->university_id != '') {
            echo $this->module_model->Get_Job_List($job_list->user_id, $job_list->university_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function job_insert() {

        $job_insert = json_decode(file_get_contents('php://input'));
        if ($job_insert->user_id != '' && $job_insert->job_title != '' && $job_insert->university_id != '' && $job_insert->description != '' && $job_insert->createdate != '' && $job_insert->expiredate != '') {
            echo $this->module_model->Insert_Job($job_insert->user_id, $job_insert->job_title, $job_insert->university_id, $job_insert->description, $job_insert->createdate, $job_insert->expiredate);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function my_post_list() {
        $post_list = json_decode(file_get_contents('php://input'));
        if ($post_list->user_id != '' && $post_list->start != '' && $post_list->end != '') {
            echo $this->module_model->Get_My_Post_List($post_list->user_id, $post_list->start, $post_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_update() {
        $post_update = json_decode(file_get_contents('php://input'));
        $imagesdata = $post_update->images;
//        print_r($imagesdata); 
//        die;
        if ($post_update->post_id != '' && $post_update->user_id != '' && $post_update->post_title != '' && $post_update->university_id != '' && $post_update->post_cat_id != '' && $post_update->description != '' && $post_update->price != '' && $post_update->dt_modifydate != '' && $post_update->expirydate != '') {
            echo $this->module_model->Update_Post($post_update->post_id, $post_update->user_id, $post_update->post_title, $post_update->university_id, $post_update->post_cat_id, $post_update->description, $post_update->price, $post_update->dt_modifydate, $post_update->expirydate, $imagesdata);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function buzz_update() {
        $post_update = json_decode(file_get_contents('php://input'));
        $imagesdata = $post_update->images;
//        print_r($post_update); 
//        die;
        if ($post_update->buzz_id != '' && $post_update->user_id != '' && $post_update->buzz_title != '' && $post_update->university_id != '' && $post_update->description != '' && $post_update->dt_modifydate != '' && $post_update->expirydate != '') {
            echo $this->module_model->Update_Buzz($post_update->buzz_id, $post_update->user_id, $post_update->buzz_title, $post_update->university_id, $post_update->description, $post_update->dt_modifydate, $post_update->expirydate, $imagesdata);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function update_status() {
        $post_status_update = json_decode(file_get_contents('php://input'));
        if ($post_status_update->post_id != '' && $post_status_update->user_id != '' && $post_status_update->status != '') {
            echo $this->module_model->Update_Status($post_status_update->post_id, $post_status_update->user_id, $post_status_update->status);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function buzz_status() {
        $post_status_update = json_decode(file_get_contents('php://input'));
        if ($post_status_update->buzz_id != '' && $post_status_update->user_id != '' && $post_status_update->status != '') {
            echo $this->module_model->Buzz_Status($post_status_update->buzz_id, $post_status_update->user_id, $post_status_update->status);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function deal_status() {
        $post_status_update = json_decode(file_get_contents('php://input'));
        if ($post_status_update->deal_id != '' && $post_status_update->user_id != '' && $post_status_update->status != '') {
            echo $this->module_model->Deal_Status($post_status_update->deal_id, $post_status_update->user_id, $post_status_update->status);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function make_favorite() {
        $post_favorite_update = json_decode(file_get_contents('php://input'));
        if ($post_favorite_update->post_id != '' && $post_favorite_update->user_id != '' && $post_favorite_update->status != '') {
            echo $this->module_model->Update_Favorite_Status($post_favorite_update->post_id, $post_favorite_update->user_id, $post_favorite_update->status);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function changepassword() {
        $get_password = json_decode(file_get_contents('php://input'));
        if ($get_password->user_id != '' && $get_password->old_password != '' && $get_password->new_password != '') {
            echo $this->module_model->changepassword($get_password->user_id, $get_password->old_password, $get_password->new_password);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function search() {
        $data = json_decode(file_get_contents('php://input'));
//        print_r($data);
//                die;
//        && $get_threadlist->start != '' && $get_threadlist->end != ''
        if ($data->search_text != '' && $data->university_id != '' && $data->start != '' && $data->end != '') {
            echo $this->module_model->Search_All_Data($data->search_text, $data->university_id, $data->start, $data->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function send_message() {
//echo "dsafsafa"; die;
        $data_message = json_decode(file_get_contents('php://input'));
        if ($data_message->post_id != '' && $data_message->user_id != '' && $data_message->user_name != '' && $data_message->message != '' && $data_message->create_date != '' && $data_message->message != '' && $data_message->post_name != '') {

            echo $this->module_model->send_post_message($data_message->post_id, $data_message->user_id, $data_message->user_name, $data_message->message, $data_message->create_date, $data_message->post_name, $data_message->thread_id, $data_message->reply_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function get_threadlist() {

        $get_threadlist = json_decode(file_get_contents('php://input'));

        if ($get_threadlist->user_id != '' && $get_threadlist->start != '' && $get_threadlist->end != '') {
            echo $this->module_model->Get_Thread_list($get_threadlist->user_id, $get_threadlist->start, $get_threadlist->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function get_messagelist() {
        $data_message = json_decode(file_get_contents('php://input'));
        if ($data_message->thread_id != '' && $data_message->post_id != '' && $data_message->user_id != '' && $data_message->chr_read != '') {
            echo $this->module_model->Get_Message_List($data_message->thread_id, $data_message->post_id, $data_message->user_id, $data_message->chr_read, $data_message->owner_name, $data_message->own_id, $data_message->notification_id, $data_message->chr_log);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function go_to_message_list_from_reply() {
        $data_message_reply = json_decode(file_get_contents('php://input'));
        if ($data_message_reply->post_id != '' && $data_message_reply->user_id != '') {
            echo $this->module_model->Get_Message_List_From_Reply($data_message_reply->post_id, $data_message_reply->user_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function favorite_list() {

        $favorite_list = json_decode(file_get_contents('php://input'));
        if ($favorite_list->user_id != '' && $favorite_list->start != '' && $favorite_list->end != '') {
            echo $this->module_model->Get_Favorite_List($favorite_list->user_id, $favorite_list->start, $favorite_list->end);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function post_count() {

        $postcount_list = json_decode(file_get_contents('php://input'));
        if ($postcount_list->user_id != '' && $postcount_list->post_id != '') {
            echo $this->module_model->Update_Post_Count($postcount_list->user_id, $postcount_list->post_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function dealcode_count() {
        $dealcode_count = json_decode(file_get_contents('php://input'));
        if ($dealcode_count->deal_id != '') {
            echo $this->module_model->Update_Deal_Code_Count($dealcode_count->user_id, $dealcode_count->deal_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function buzz_count() {
        $buzzcount_list = json_decode(file_get_contents('php://input'));
        if ($buzzcount_list->user_id != '' && $buzzcount_list->buzz_id != '') {
            echo $this->module_model->Update_Buzz_Count($buzzcount_list->user_id, $buzzcount_list->buzz_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function edit_profile() {
        $profile_list = json_decode(file_get_contents('php://input'));
        if ($profile_list->user_id != '' && $profile_list->university_id != '' && $profile_list->email_id != '' && $profile_list->var_username != '') {
            echo $this->module_model->Update_Edit_Profile($profile_list->user_id, $profile_list->university_id, $profile_list->email_id, $profile_list->var_username, $profile_list->person_name, $profile_list->class, $profile_list->profile_img);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function notification() {
        $user_notification = json_decode(file_get_contents('php://input'));

        if ($user_notification->user_id != '') {
            echo $this->module_model->Get_notification($user_notification->user_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function notification_postdetail() {
        $detail_notification = json_decode(file_get_contents('php://input'));
//        print_r($detail_notification);
//        die;
        if ($detail_notification->user_id != '' && $detail_notification->notification_id != '' && $detail_notification->reference_id != '' && $detail_notification->notification_type != '' && $detail_notification->chr_read != '') {
            echo $this->module_model->Get_Detail_notification_post($detail_notification->user_id, $detail_notification->notification_id, $detail_notification->reference_id, $detail_notification->notification_type, $detail_notification->chr_read);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function notification_buzzdetail() {
        $detail_notification = json_decode(file_get_contents('php://input'));
//        print_r($detail_notification);
//        die;
        if ($detail_notification->user_id != '' && $detail_notification->notification_id != '' && $detail_notification->reference_id != '' && $detail_notification->notification_type != '' && $detail_notification->chr_read != '') {
            echo $this->module_model->Get_Detail_notification_Buzz($detail_notification->user_id, $detail_notification->notification_id, $detail_notification->reference_id, $detail_notification->notification_type, $detail_notification->chr_read);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function contactus() {

        $contact_us_insert = json_decode(file_get_contents('php://input'));

        if ($contact_us_insert->user_name != '' && $contact_us_insert->user_email != '' && $contact_us_insert->message != '' && $contact_us_insert->user_id != '' && $contact_us_insert->dt_createdate != '') {
            echo $this->module_model->Insert_Contactus($contact_us_insert->user_name, $contact_us_insert->user_email, $contact_us_insert->message, $contact_us_insert->user_id, $contact_us_insert->dt_createdate);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function university_request() {

        $contact_us_insert = json_decode(file_get_contents('php://input'));

        if ($contact_us_insert->university_name != '' && $contact_us_insert->email != '' && $contact_us_insert->dt_createdate != '') {
            echo $this->module_model->Insert_new_University($contact_us_insert->university_name, $contact_us_insert->email, $contact_us_insert->dt_createdate);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function forgotpassword() {

        $contact_us_insert = json_decode(file_get_contents('php://input'));

        if ($contact_us_insert->email != '') {
            echo $this->module_model->Send_Forgotpassword($contact_us_insert->email);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function forgotname() {

        $contact_us_insert = json_decode(file_get_contents('php://input'));

        if ($contact_us_insert->email != '') {
            echo $this->module_model->Send_ForgotUserName($contact_us_insert->email);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function delete_thread() {
        $thread_ids = json_decode(file_get_contents('php://input'));
//        print_r($thread_ids); die;
//        foreach ($thread_ids as $value) {
//            $thrd = explode(',', $value);
//            $i++;
//        }

        if ($thread_ids->thread_id != '' && $thread_ids->own_id != '') {
            echo $this->module_model->Delete_Thread($thread_ids->thread_id, $thread_ids->own_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    function delete_post() {

        $delete_ids = json_decode(file_get_contents('php://input'));

        if ($delete_ids->post_id != '' || $delete_ids->buzz_id != '') {
            echo $this->module_model->Delete_Post($delete_ids->post_id, $delete_ids->buzz_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }

    //to retrive class
    function get_class(){
        $data_message = json_decode(file_get_contents('php://input'));
        echo $this->module_model->get_class();
        exit;
    }
    
    //post owner detail
    function post_owner_detail(){
        $postowner = json_decode(file_get_contents('php://input'));

        if ($postowner->owner_id != '') {
            echo $this->module_model->post_owner_detail($postowner->owner_id, $postowner->user_id,$postowner->post_id);
            exit;
        } else {
            echo $this->module_model->Bad_Request_error_message();
            exit;
        }
    }
//    function updateprofile() {
//        $result = $this->module_model->check_valid_login($this->headers['Cinicoauth']);
//        if ($result == '1') {
//            echo $this->module_model->updateprofile($this->headers['Cinicoauth']);
//            exit;
//        } else {
//            echo $result;
//            exit;
//        }
//    }



    function response() {
        echo json_encode($this->responseArray);
        exit;
    }

    function error_response() {
        echo json_encode($this->errorArray);
        exit;
    }

//    ******************************* GCM ******************************

    function sendMessageThroughGCM($registatoin_ids, $message) {

        //Google cloud messaging GCM-API url
        $url = 'https://android.googleapis.com/gcm/send';
        $fields = array(
            'registration_ids' => $registatoin_ids,
            'data' => $message,
        );
        // Update your Google Cloud Messaging API Key
        define("GOOGLE_API_KEY", "AIzaSyCP-51xal8c_RCUw-ZO3hWfNak6cZybB44");
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
        return $result;
    }

//    ******************************** GCM *******************************
}

?>