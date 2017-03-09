<?php

//$connect = pg_connect("host=localhost port=5432 dbname=thriftt1_mobileapp user=thriftt1_mobileappuser password=3(+J^}[oF[ry");
//   Localhost
//$connect = pg_connect("host=localhost port=5432 dbname=thriftskool user=postgres password=admin123#");
// My device token here (without spaces):
//
//$Get_All_Data = "SELECT * FROM logmanager WHERE  chr_isend='N' and notification_type IN ('1','3') and notification_type != ''";
//$query = pg_query($Get_All_Data);
//$Data_Array = pg_fetch_all($query);

$deviceToken = '015ca64ec97df6b005d0c0ee6ce3275424a09a832d02e0481b48083e777504da';

$message = 'New Push Notification!';
// Create the payload body
$body['aps'] = array(
    'alert' => $message,
    'badge' => $badge
);

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', 'admin123#');
// Open a connection to the APNS server
$fp = stream_socket_client(
        'ssl://gateway.sandbox.push.apple.com:2195', $err,
        $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp){
    exit("Failed to connect: $err $errstr" . PHP_EOL);
    return;
}else{
    echo 'Connected to APNS' . PHP_EOL;
}
// Encode the payload as JSON
$payload = json_encode($body);
// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
    echo 'Error, notification not sent' . PHP_EOL;
else
    echo 'notification sent!' . PHP_EOL;
// Close the connection to the server
fclose($fp);
//fwrite()
?>