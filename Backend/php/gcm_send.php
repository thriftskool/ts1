<?php

$connect = pg_connect("host=localhost port=5432 dbname=thriftskool_mobileapp user=thriftskool_mobileappuser password=3(+J^}[oF[ry");
define("GOOGLE_API_KEY", "AIzaSyCmhjpO4hTmgnrpMZHazt4Q6PhqDiQhFlc");
if ($connect) {

    function sendMessageThroughGCM($registatoin_ids, $message) {
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
        return $result;
    }

    function sendMessageThroughGCM_ios($registatoin_ids, $message) {

        $deviceToken = $registatoin_ids;
        $body['aps'] = array(
            'alert' => $message['message'],
            "badge" => $message['badge']
        );
        $ctx = stream_context_create();

        //***************************** Developement Start ***********************************
//        stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
//        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
//        $fp = stream_socket_client(
//                'ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
        //***************************** Developement End ***********************************
        //***************************** Production Start ***********************************
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'pushcert.pem');
        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
        $fp = stream_socket_client(
                'ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
//******************* Production End *************************

        $payload = json_encode($body);
        $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
        $result = fwrite($fp, $msg, strlen($msg));
        fclose($fp);
    }

    function sendMessageThroughGCM_ios_Buzz($registatoin_ids, $message) {

        $deviceToken = $registatoin_ids;
        $body['aps'] = array(
            'alert' => $message['message'],
            "badge" => $message['badge']
        );
        $ctx = stream_context_create();
        //***************************** Developement Start ***********************************
//        stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
//        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
//        $fp = stream_socket_client(
//                'ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
        //***************************** Development End  ***********************************       
        //***************************** Production Start ***********************************
        stream_context_set_option($ctx, 'ssl', 'local_cert', 'pushcert.pem');
        stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
        $fp = stream_socket_client(
                'ssl://gateway.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
//******************* Production End *************************


        $payload = json_encode($body);
        $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
        $result = fwrite($fp, $msg, strlen($msg));
        fclose($fp);
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
                            where log.fk_user_id=$user_id and log.var_tablename = 'post_management'
                            and pm.chr_delete='N' and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
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
                            where  msg.fk_post = mt.fk_post and msg.fk_user_id != $user_id and log.var_tablename = 'message_list'
                            and log.chr_read ='N' and log.notification_type != '' order by log.dt_createdate DESC");
//                echo $this->db->last_query();  die;
        $Result_message = $query_message->result_array();
        $cnt_message = count($Result_message);

        if (!empty($Result_post) || !empty($Result_Buzz) || !empty($Result_message)) {
            $sum = $cnt_post + $cnt_buzz + $cnt_message;
//            echo $sum; die;
            return $sum;
        }
    }

    function sendMessageThroughGCM_buzz($registatoin_ids, $message) {
        //Google cloud messaging GCM-API url
        $url = 'https://android.googleapis.com/gcm/send';
        $fields = array(
            'data' => $message,
            'registration_ids' => $registatoin_ids
        );
//        echo json_encode($fields);
//        die;
//        print "<pre/>";
//        print_r($fields);
//        die;
        // Update your Google Cloud Messaging API Key

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

    $Get_All_Data = "SELECT * FROM logmanager WHERE  chr_send='N' and notification_type IN ('1','3') and notification_type != ''";

    $query = pg_query($Get_All_Data);
    $Data_Array = pg_fetch_all($query);

//    print "<pre/>";
//    print_r($Data_Array);
//    die;

    if (!empty($Data_Array)) {

        foreach ($Data_Array as $row_post) {
//            print "<pre/>";
//            print_r($row_post);
//            die;
            if ($row_post['notification_type'] == '1' && $row_post['var_tablename'] == 'post_management') {

                $userid = $row_post['fk_user_id'];
                $ref_id = $row_post['var_referenceid'];
                $tablename = $row_post['var_tablename'];

                $logcnt = $this->count_notification($userid);

//                $Get_User_Reg_Id = "SELECT gcm_code,device_id, int_glcode as user_id FROM users_manage WHERE int_glcode=$userid";
//                $query = pg_query($Get_User_Reg_Id);
//                $Gcm_Code = pg_fetch_array($query);

                $Get_All_Gcm_Id = "SELECT gcm_code FROM manage_gcmcode WHERE fk_user=$userid";
                $query_gcm_dis = pg_query($Get_All_Gcm_Id);
                $gcm_Idss = pg_fetch_all($query_gcm_dis);

                $Get_All_Devices_Id = "SELECT device_id FROM user_devices WHERE fk_user=$userid";
                $query_devices_dis = pg_query($Get_All_Devices_Id);
                $Devices_Idss = pg_fetch_all($query_devices_dis);

                $query_postdetail = "SELECT 
                            log.int_glcode as notification_id,
                            log.var_referenceid as reference_id,
                            log.notification_type,
                            log.fk_user_id as user_id,
                            log.var_tablename as tablename,
                            pm.int_glcode as post_id,
                            pm.fk_user_id as user_id,
                            pm.var_postname as post_name,
                            pm.var_description as description,
                            pm.var_price as price,
                            pm.chr_status as status,
                            pm.chr_favorite as favorite,
                            pm.dt_expiredate as expirydate
                            FROM logmanager as log
                            LEFT JOIN post_management as pm on log.var_referenceid = pm.int_glcode
                            where log.fk_user_id=$userid and log.var_tablename = 'post_management'
                            and pm.chr_delete='N' and log.chr_send='N' and log.notification_type != ''";

                $Result_post = pg_query($query_postdetail);
                $Data_Array = pg_fetch_array($Result_post);

//                $gcmRegIds = array("APA91bG0rXL25CKl5U-3ZgFJd9QNq4JNbc5lICVn1wqh59Sm4a7Irvqdn8mZkWUOlvxJ4PqhcJIRR8Paq44isPm27etS_OXbfYoPP3pezD47GKDgvj2iS3kHF7UpXrnSZ7vft-UJWjRj");
                $gcmRegIds = array($Gcm_Code['gcm_code']);
                $Device_ios_RegIds = $Gcm_Code['device_id'];
                $message = array(
                    "notification_id" => $Data_Array['notification_id'],
                    "notification_type" => $Data_Array['notification_type'],
                    "name" => $Data_Array['post_name'],
                    "id" => $Data_Array['post_id'],
                    "user_id" => $Data_Array['user_id'],
                    "message" => "Your post '" . $Data_Array['post_name'] . "' has been expired.",
                    "badge" => $logcnt
                );

//                if (!empty($gcmRegIds)) {
//                    sendMessageThroughGCM($gcmRegIds, $message);
//                }
//                if (!empty($Device_ios_RegIds)) {
//                    sendMessageThroughGCM_ios($Device_ios_RegIds, $message);
//                }
                if (!empty($gcm_Idss)) {
                    foreach ($gcm_Idss as $gcm_value) {
                        $gcmRegIds = array($gcm_value['gcm_code']);
                        sendMessageThroughGCM($gcmRegIds, $message);
                    }
                }

                if (!empty($Devices_Idss)) {
                    foreach ($Devices_Idss as $didss) {
                        sendMessageThroughGCM_ios($didss['device_id'], $message);
                    }
                }


                if (!empty($Data_Array['notification_id'])) {
                    $update_status = "UPDATE logmanager SET chr_send= 'Y' WHERE int_glcode='" . $Data_Array['notification_id'] . "'";
                    $Query = pg_query($update_status);
                }
//                $post_detail = array($Result_post);
            }

            if ($row_post['notification_type'] == '3' && $row_post['var_tablename'] == 'campus_buzz') {

                $userid = $row_post['fk_user_id'];
                $ref_id = $row_post['var_referenceid'];
                $tablename = $row_post['var_tablename'];

                $query_Buzzdetail = "SELECT 
                        log.int_glcode as notification_id,
                        log.var_referenceid as reference_id,
                        log.notification_type,
                        log.fk_user_id as user_id,
                        log.var_tablename as tablename,
                        bm.int_glcode as buzz_id,
                        bm.fk_user_id as user_id,
                        bm.var_title as buzz_name
                        FROM logmanager as log
                        LEFT JOIN campus_buzz as bm on log.var_referenceid = bm.int_glcode
                        where log.fk_user_id=$userid and log.var_tablename = 'campus_buzz'
                        and bm.chr_delete='N' and log.notification_type != ''";

                $Result_Buzz = pg_query($query_Buzzdetail);
                $Data_Array1 = pg_fetch_array($Result_Buzz);

//                $gcmRegIds = array("APA91bG0rXL25CKl5U-3ZgFJd9QNq4JNbc5lICVn1wqh59Sm4a7Irvqdn8mZkWUOlvxJ4PqhcJIRR8Paq44isPm27etS_OXbfYoPP3pezD47GKDgvj2iS3kHF7UpXrnSZ7vft-UJWjRj");
//                $gcmRegIds = array($Gcm_Code['gcm_code']);
//                $Device_ios_RegIds = $Gcm_Code['device_id'];

                $message = array(
                    "notification_id" => $Data_Array1['notification_id'],
                    "notification_type" => $Data_Array1['notification_type'],
                    "name" => $Data_Array1['buzz_name'],
                    "id" => $Data_Array1['buzz_id'],
                    "user_id" => $Data_Array1['user_id'],
                    "message" => "Your buzz '" . $Data_Array1['buzz_name'] . "' has been expired.",
                    "badge" => $logcnt
                );

//                if (!empty($gcmRegIds)) {
//                    sendMessageThroughGCM_buzz($gcmRegIds, $message);
//                }
//                if (!empty($Device_ios_RegIds)) {
//                    sendMessageThroughGCM_ios_Buzz($Device_ios_RegIds, $message);
//                }
//                
                if (!empty($gcm_Idss)) {
                    foreach ($gcm_Idss as $gcm_value) {
                        $gcmRegIds = array($gcm_value['gcm_code']);
                        sendMessageThroughGCM($gcmRegIds, $message);
                    }
                }

                if (!empty($Devices_Idss)) {
                    foreach ($Devices_Idss as $didss) {
                        sendMessageThroughGCM_ios($didss['device_id'], $message);
                    }
                }

//                sendMessageThroughGCM_buzz($gcmRegIds, $message);

                if (!empty($Data_Array1['notification_id'])) {
                    $update_status = "UPDATE logmanager SET chr_send= 'Y' WHERE int_glcode='" . $Data_Array1['notification_id'] . "'";
                    $Query = pg_query($update_status);
                }
            }


//
//            $update_status = "UPDATE logmanager SET notification_type= '1' WHERE var_referenceid=$idname and var_tablename='post_management'";
//            $this->db->query($update_status);
//            $user_id = $row_post['fk_user_id'];
//            $fk_module = '144';
//            $table_name = 'post_management';
//            $chr_read = 'N';
//            $dt_createdate = date('Y-m-d H:i:s', time());
//            $referenceid = $row_post['int_glcode'];
//            $notification = '1';
////            echo $table_name['var_postname']; die;
//            $Insert_post = "INSERT INTO logmanager (fk_user_id, fk_modulename, var_tablename,chr_read,dt_createdate,var_referenceid,notification_type)"
//                    . " VALUES ('" . $user_id . "',"
//                    . "'" . $fk_module . "', '" . $table_name . "', '" . $chr_read . "','" . $dt_createdate . "','" . $referenceid . "','" . $notification . "')";
//            $result = pg_query($Insert_post);
        }
    }
//    ********************************** End Buzz Code ************************
    //Generic php function to send GCM push notification

    pg_close();
} else {
    header('Location:index.php');
}
?>