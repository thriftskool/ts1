<?php

class dashboard_model extends MY_Model {

    public function __construct() {
        parent::__construct();
    }
    
//    function GetPowerPanelBanner(){
//        $ImgArray = array();
//        $sitename = "http://lserver/craveclothing/nlive/";
//        $filename = $sitename . "/rssfeeds.xml";
//        $fileContent = file_get_contents($filename);
//        $itemArray = explode('<Banner>', $fileContent);
//        $displayImg = count($itemArray);
//        for($i = 1; $i < $displayImg; $i++){
//            $subArray = array();
//            $subArray['varTitle'] = $this->get_string_between($itemArray[$i], "<Imgtitle>", "</Imgtitle>");
//            $subArray['ImageName'] = $this->get_string_between($itemArray[$i], "<image>", "</image>");
//            $subArray['ImagePath'] = $this->get_string_between($itemArray[$i], "<imagepath>", "</imagepath>");
//            $subArray['Link'] = $this->get_string_between($itemArray[$i], "<link>", "</link>");
//            $subArray['key'] = $i;
//            $ImgArray[] = $subArray;
//        }
//        return $ImgArray;
//    }
    
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
