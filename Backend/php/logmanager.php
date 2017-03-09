<?php

date_default_timezone_set('UTC');
$current_date = date('Y-m-d');

$connect = pg_connect("host=localhost port=5432 dbname=thriftskool_mobileapp user=thriftskool_mobileappuser password=3(+J^}[oF[ry");

if ($connect) {
    $date = date('Y-m-d',(strtotime ( '-1 day' , strtotime ( $current_date) ) ));
//    date_default_timezone_set("UTC");
//    $current_date = date('Y-m-d') - 'INTERVAL 1 day';
//    echo $current_date; die;
     $post_sql = "SELECT * FROM post_management WHERE dt_expiredate = '". $date ."' and chr_delete='N'";

    $query = pg_query($post_sql);
    $post_array = pg_fetch_all($query);
    if (!empty($post_array)) {
        foreach ($post_array as $row_post) {

            $update_status = "UPDATE post_management SET chr_status= '1' WHERE int_glcode='" . $row_post['int_glcode'] . "'";
            $Querysts = pg_query($update_status);

            $user_id = $row_post['fk_user_id'];
            $fk_module = '144';
            $table_name = 'post_management';
            $chr_read = 'N';
            $dt_createdate = date('Y-m-d H:i:s', time());
            $referenceid = $row_post['int_glcode'];
            $notification = '1';
//            echo $table_name['var_postname']; die;
            $Insert_post = "INSERT INTO logmanager (fk_user_id, fk_modulename, var_tablename,chr_read,dt_createdate,var_referenceid,notification_type)"
                    . " VALUES ('" . $user_id . "',"
                    . "'" . $fk_module . "', '" . $table_name . "', '" . $chr_read . "','" . $dt_createdate . "','" . $referenceid . "','" . $notification . "')";
            $result = pg_query($Insert_post);
        }
    }

//    ******************************* Buzz Code *********************************

    $buzz_sql = "SELECT * FROM campus_buzz WHERE dt_expiredate = '". $date ."' and chr_delete='N'";
    $query_buzz = pg_query($buzz_sql);
    $buzz_array = pg_fetch_all($query_buzz);
    if (!empty($buzz_array)) {
        foreach ($buzz_array as $row_buzz) {

            $update_cmps_status = "UPDATE campus_buzz SET chr_status= '1' WHERE int_glcode='" . $row_buzz['int_glcode'] . "'";
            $Querysts = pg_query($update_cmps_status);

            $user_id = $row_buzz['fk_user_id'];
            $fk_module = '149';
            $table_name = 'campus_buzz';
            $chr_read = 'N';
            $dt_createdate = date('Y-m-d H:i:s', time());
            $referenceid = $row_buzz['int_glcode'];
            $notification = '1';

            $Insert_buzz = "INSERT INTO logmanager (fk_user_id, fk_modulename, var_tablename,chr_read,dt_createdate,var_referenceid,notification_type)"
                    . " VALUES ('" . $user_id . "',"
                    . "'" . $fk_module . "', '" . $table_name . "', '" . $chr_read . "','" . $dt_createdate . "','" . $referenceid . "','" . $notification . "')";
            $resultbuzz = pg_query($Insert_buzz);
        }
        //********************************** End Deal Code ************************
    }

//      ******************** Deal Code ************************
    $deal_sql = "SELECT * FROM campus_deal WHERE dt_expiredate = '". $date ."' and chr_delete='N'";
    $query_deal = pg_query($deal_sql);
    $deal_array = pg_fetch_all($query_deal);
    if (!empty($deal_array)) {
        foreach ($deal_array as $row_deal) {
            $update_cmps_status = "UPDATE campus_deal SET chr_status= '1' WHERE int_glcode='" . $row_deal['int_glcode'] . "'";
            $Querysts = pg_query($update_cmps_status);
        }
    }
//    ********************************** End Deal Code ************************
    pg_close();
} else {
    header('Location:index.php');
}
?>