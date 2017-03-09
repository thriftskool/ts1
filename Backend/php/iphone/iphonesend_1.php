<?php
$payload['aps'] = array('alert' => 'Test alert', 'badge' => 1, 'sound' => 'default');
 
$payload = json_encode($payload);
 
$apnsHost = 'gateway.sandbox.push.apple.com';
$apnsPort = 2195;
$apnsCert = 'http://thriftskool.com/mobileapps/thriftskool/iphone/apns_cert.pem';
$deviceToken = '015ca64ec97df6b005d0c0ee6ce3275424a09a832d02e0481b48083e777504da';
$streamContext = stream_context_create();
stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);

$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);

$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', $deviceToken)) . chr(0) . chr(strlen($payload)) . $payload;
$result = fwrite($apns, $apnsMessage);
if (!$result)
    echo 'Error, notification not sent' . PHP_EOL;
else
    echo 'notification sent!' . PHP_EOL;

socket_close($apns);
fclose($apns);

?> 