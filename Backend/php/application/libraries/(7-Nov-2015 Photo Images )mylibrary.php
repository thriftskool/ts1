<?php

class mylibrary {

    var $notValidForAdminArry = array("13", "1f4", "15", "8", "12");  // for admin

    public function __construct() {
        $this->ci = & get_instance();
        $this->ci->load->helper('url', 'form');
        $this->ci->load->library('session');
        $this->ci->load->library('email');
//   $this->ci->load->library('smarty');
    }

    function generate_pin($pin_submitted) {
        return substr(md5($pin_submitted), 15, 4);
    }

    function decryptPass($pass) {
        $key = "FILEZILLA1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        $pos = (strlen($pass) / 3) % strlen($key);
        $decrypt = '';
        $t = 0;
        for ($i = 0; $i < strlen($pass) / 3; $i++) {
            $num = substr($pass, $i * 3, 3);
            if (substr($num, 0, 1) == 0) {
                $num = substr($num, 1, 2);
            }
            $t = $num ^ ord($key[($i + $pos) % strlen($pass)]);
            $decrypt .= chr($t);
        }
        return $decrypt;
    }

    function send_mail($to, $subject, $html_message) {

//        $this->ci->email->from('etiloxsolution.etilox@gmail.com');
//        $this->ci->email->protocol = 'smtp';
//        $this->ci->email->smtp_host = 'smtp.gmail.com';
//        $this->ci->email->smtp_user = 'etiloxsolution.etilox@gmail.com';
//        $this->ci->email->smtp_pass = 'admin123#';
//        $this->ci->email->smtp_port = 587;
//        $this->ci->email->set_mailtype('html');
//        if (!$this->ci->email->send()) {
//            echo "false";
//            return false;
//        } else {
//            echo "Sucess"; die;
//            return true;
//        }

        include "classes/class.phpmailer.php"; // include the class name


        $email = $to;
        $mail = new PHPMailer; // call the class 
        $mail->IsSMTP();
//            echo SMTP_HOST; die;
        $mail->Host = "smtp.gmail.com"; //Hostname of the mail server
        $mail->Mailer = 'smtp';
        $mail->SMTPAuth = true; // authentication enabled
        $mail->SMTPSecure = 'ssl'; // secure transfer enabled REQUIRED for GMail
        $mail->Port = 465; //Port of the SMTP like to be 25, 80, 465 or 587
        $mail->SMTPAuth = true; //Whether to use SMTP authentication
        $mail->Username = "testbyetilox@gmail.com"; //Username for SMTP authentication any valid email created in your domain
        $mail->Password = "Etilox@123"; //Password for SMTP authentication
        $mail->AddReplyTo("testbyetilox@gmail.com", "Reply name"); //reply-to address
        $mail->SetFrom("testbyetilox@gmail.com", "test"); //From address of the mail
        $mail->Subject = $subject; //Subject od your mail
        $mail->AddAddress($email, "vaibhav"); //To address who will receive this email
        $mail->MsgHTML($html_message);
        $send = $mail->Send(); //Send the mails
//        print_r($send);
//        die;

        if ($send) {
            echo '<center><h3 style="color:#009933;">Mail sent successfully</h3></center>';
            $returndataArray['Response'] = array(
                'status' => '200',
                'message' => 'Success.'
            );
            return $this->response($returndataArray);
        } else {
            $response['Response'] = array(
                'status' => '401',
                'message' => 'mail not sent.'
            );
            return $this->error_response($response);
//            echo '<center><h3 style="color:#FF3300;">Mail error: </h3></center>' . $mail->ErrorInfo;
        }
//        }
    }

    function send_mail1() {
      
        $this->ci->email->from("no-reply@thriftskool.com","Thriftskool");
        $this->ci->email->protocol = "sendmail";
        $this->ci->email->smtp_host = "mail.thriftskool.com";
        $this->ci->email->smtp_user = "no-reply@thriftskool.com";
        $this->ci->email->smtp_pass = "}x#ArGq$[oG-";
        $this->ci->email->smtp_port = "26";
        $this->ci->email->set_mailtype('html');
        if (!$this->ci->email->send()) {
//          echo "false library"; exit;
            return false;
        } else {
//            echo "True"; exit;
            return true;
        }
    }

    function cryptPass($string) {
        $key = "FILEZILLA1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        $pos = strlen($string) % strlen($key);
        $tmp = "";
        $x = "";
        for ($i = 0; $i < strlen($string); $i++) {
            $x = sprintf("%s", $string[$i] ^ $key[($i + $pos) % strlen($key)]);
            if (preg_match("/[^a-z]/", $string[$i])) {
                $min = 3 - strlen(ord($x));
                $z = str_repeat('0', $min) . ord($x);
            } else {
                $z = "0" . ord($x);
            }
            $tmp .= $z;
        }
        return $tmp;
    }

    function getCMSPageDetails($id) {
        $sql = "select * from " . DB_PREFIX . "pages where chr_publish='Y' and int_glcode='" . $id . "'";
        $result = mysql_query($sql);
        $data = mysql_fetch_assoc($result);
        return $data;
    }

    function get_page_records_data() {
        $sql = "SELECT  var_pages_record  FROM " . DB_PREFIX . "general_settings";
        $value = mysql_query($sql);
        $returnArry = mysql_fetch_assoc($value);
        return $returnArry;
    }

    function CounttotalRows() {
        $sqlCountPages = "select * FROM " . DB_PREFIX . "pages where chr_delete='N'";
        $query = mysql_query($sqlCountPages);
        $rs = mysql_num_rows($query);
        return $rs;
    }

    function CountbannerRows() {
        $sqlCountPages = "select * FROM " . DB_PREFIX . "homebanner where chr_delete='N'";
        $query = mysql_query($sqlCountPages);
        $rs = mysql_num_rows($query);
        return $rs;
    }

    function Countmoduleid() {
        $sqlCountPages = "select * FROM " . DB_PREFIX . "modules where chr_delete='N'";
        $query = mysql_query($sqlCountPages);
        $rs = mysql_fetch_array($query);
        return $rs;
    }

    function getfkarray($pageid, $fkstring = '') {
        $sql = "select int_glcode,fk_pages from " . DB_PREFIX . "pages where int_glcode='" . $pageid . "'";
//echo $sql;
        $res2 = mysql_query($sql);
        $res = mysql_fetch_assoc($res2);
//$res2 = $this->configObj->glDbObj->query($sql);
        $count = mysql_num_rows($res2);
        if ($count > 0) {
            if ($res['fk_pages'] != '0') {
                $fkstring.=$res['int_glcode'] . ',';
                return $this->getfkarray($res['fk_pages'], $fkstring);
            } else {
                $fkstring.=$res['int_glcode'];
                return $fkstring;
            }
        } else {
            return $fkstring;
        }
    }

    function getmainparent($pageid) {
        $sql = "select int_glcode as id,fk_pages from " . DB_PREFIX . "pages where int_glcode='" . $pageid . "' ";
        $res2 = mysql_query($sql);
        $count = mysql_num_rows($res2);
        if ($count > 0) {
            while ($row = mysql_fetch_array($res2)) {
                if ($row['fk_pages'] != '0') {
                    $this->fkstring .=$row['id'] . ',';
                    $this->getmainparent($row['fk_pages'], $this->fkstring);
                    $this->fkstring = trim($this->fkstring, ',');
                } else {
                    $this->fkstring .= $pageid;
                }
            }
        }
        return $this->fkstring;
    }

    function footermenu($pageId = '') {
        $selectarray = array();
        if ($pageId != '') {
            $selectstring = $this->getfkarray($pageId, $fkstring);
            $selectarray = explode(",", $selectstring);
        }
        if (SITE_SEO == "Y") {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,
                      case p.var_pagetype WHEN 1 OR 0 THEN CONCAT('" . base_url() . "',p.var_alias)
                      ELSE CONCAT('" . base_url() . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.chr_publish='Y' and p.chr_delete='N' and p.chr_footer_display='Y' and p.chr_previewstatus='N' and p.fk_pages = 0 and p.int_glcode NOT IN (1) order by p.int_displayorder asc";
        } else {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,p.var_viewalias,m.var_modulename,
                      case p.var_pagetype WHEN 1 OR 0 THEN CONCAT('" . base_url() . "pages/',p.int_glcode)
                      ELSE CONCAT('" . base_url() . "',m.var_modulename) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.chr_publish='Y' and p.chr_delete='N' and p.chr_footer_display='Y' and p.chr_previewstatus='N' and p.fk_pages = 0 and p.int_glcode NOT IN (1) order by p.int_displayorder asc";
        }
        $result = mysql_query($msql);
        $count = mysql_num_rows($result);
        $footermenu = "<ul class=\"foot-link\">";
        $j = 0;
        $homeselect = ($pageId == '' || $pageId == '1') ? 'selected' : '';
//    $footermenu.='<li class="' . $homeselect . '"><a href=\"" . base_url() . "\" title="Sailing.ky - ' . $row['var_pagename'] . '">Home</a></li>';
        while ($row = mysql_fetch_array($result)) {
            if ($j < 11) {
                $bmenuselected = ($row['int_glcode'] == $pageId || in_array($row['int_glcode'], $selectarray)) ? 'selected' : '';
                if ($row['int_glcode'] == 1) {
                    $link = base_url();
                } else {
                    $link = $row['link'];
                }
                $last = ($j == $count - 1) ? ' last' : '';
                $footermenu.='<li >
                    <a  href="' . $link . '" class="' . $bmenuselected . '"  title="Sailing.ky - ' . $row['var_pagename'] . '">' . $row['var_pagename'] . '</a>
                        
</li>';
//                <a href='" . $link . "' class='" . $sclass . "'>" . $record['var_pagename'] . "</a>
            }
            $j++;
        }
        $footermenu;
        $footermenu.="</ul>";
        return $footermenu;
    }

    function Gettopmenu($pageId) {
//echo $pageId; 
        $getParentIdList = $this->getParentIdList($pageId);
        $fkstring = '';
        $this->menuString = "";
        $selectstring = $this->getfkarray($pageId, $fkstring);
        $selectarray = explode(",", $selectstring);
        if (SITE_SEO == "Y") {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,
                      case p.var_pagetype WHEN 1 OR 0 THEN CONCAT('" . base_url() . "',p.var_alias)
                      ELSE CONCAT('" . base_url() . "',p.var_alias) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.chr_publish='Y' and p.chr_delete='N' and p.chr_menu_display='Y' and p.chr_previewstatus='N' and p.int_glcode NOT IN (1) order by p.int_displayorder asc";
        } else {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,p.var_viewalias,m.var_modulename,
                      case p.var_pagetype WHEN 1 OR 0 THEN CONCAT('" . base_url() . "pages/',p.int_glcode)
                      ELSE CONCAT('" . base_url() . "',m.var_modulename) end as link
                      from " . DB_PREFIX . "pages p left join " . DB_PREFIX . "modules m on m.int_glcode=p.var_pagetype where p.chr_publish='Y' and p.chr_delete='N' and p.chr_menu_display='Y' and p.chr_previewstatus='N' and p.int_glcode NOT IN (1) order by p.int_displayorder asc";
        }
//echo $msql;
        $result = mysql_query($msql);
        $count = mysql_num_rows($result);
        $i = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_array($result)) {
                $pitems[] = $row;
            }
            if ($pitems) {
                foreach ($pitems as $p) {
                    $pt = $p['fk_pages'];
                    $list = @$children[$pt] ? $children[$pt] : array();
                    array_push($list, $p);
                    $children[$pt] = $list;
                }
            }
            $this->menuString .="<div class=\"main_menu\"> <a href=\"" . base_url() . "\"><span class=\"home_icon fl mgt12 mgr10 mgl2\"></span></a>";
            $this->menuString .= "<ul class=\"menu\" id=\"menu\">";
            /* if (($this->configObj->routes['pageId'] == "" || $this->configObj->routes['pageId'] == '1') && $this->configObj->routes['id'] == '') {
              $this->menuString .= '<li class=""><a href="' . SITE_PATH . '" class="menulink selected "><span>Home</span></a></li>';
              } else {
              $this->menuString .= '<li><a href="' . SITE_PATH . '" class="menulink"><span>Home</span></a></li>';
              } */
            $k = 0;
            foreach ($children[0] as $record) {
                if ($k < 9) {
                    if ($k == 0) {
//$p_class = "btm-arrow";                       
                    }
                    if ($i < 9 && $record['fk_pages'] == 0) {
//if ($record['int_glcode'] == $pageId) {
                        if ($record['int_glcode'] == $pageId || in_array($record['int_glcode'], $getParentIdList)) {
                            $sclass = "selected";
                            $p_class = "btm-arrow";
                        } else {
                            $sclass = "";
                            $p_class = "";
                        }
                        if (SITE_SEO == "Y") {
                            $link = $record['link'];
                        } else {
                            if ($record['chr_custom'] == 'Y') {
                                $link = $record['link'] . "&amp;PageId=" . $record['int_glcode'];
                            } else {
                                if ($record['int_glcode'] == '1') {
                                    $link = "./";
                                } else {
                                    $link = $record['link'];
                                }
                            }
                        }
                        if ($i == count($children) - 1) {
                            $lastclass = 'last';
                        } else {
                            $lastclass = '';
                        }
//echo count($children);
                        if ($i >= 6) {
                            $a = 'class="mlast"';
                        } else {
                            $a = 'class=""';
                        }
                        if (array_key_exists($record['int_glcode'], $children)) {
                            $this->menuString .= "<li class='" . $p_class . "'><a href='" . $link . "' class='" . $sclass . "' ><span>" . $record['var_pagename'] . "</span></a>";
                            $this->menuString .= "<ul> <li class='first'>&nbsp;</li>";
                            $this->menuString .= $this->generateMenuChild($record['int_glcode'], $children, $selectarray, $pageId);
//$this->menuString.="<li class='last1'>&nbsp;</li></ul>";
                            $this->menuString.="</ul></li>";
                        } else {
                            $this->menuString .= "<li class='" . $p_class . "'><a href='" . $link . "' class='" . $sclass . "'>" . $record['var_pagename'] . "</a></li>";
                        }
                    }
                    $k++;
                }
                $i++;
            }
            $this->menuString.="</ul></div>";
        }
        return $this->menuString;
    }

    function generateMenuChild($id, $children, $selectarray, $pageId = '') {
//echo "<pre>";print_r($children);echo"</pre>";
        $i = 0;
        if ($children[$id]) {
            foreach ($children[$id] as $subrecord) {
                if (in_array($subrecord['int_glcode'], $selectarray) || $pageId == $subrecord['int_glcode']) {
                    $subSelclass = "selected";
                } else {
                    $subSelclass = '';
                }
                if (SITE_SEO == "Y") {
                    $link = $subrecord['link'];
                } else {
                    if ($subrecord['chr_custom'] == 'Y') {
                        $link = $subrecord['link'] . "&amp;PageId=" . $subrecord['int_glcode'];
                    } else {
                        $link = $subrecord['link'];
                    }
                }
//send count($children[$id]);
                if ($i == count($children[$id]) - 1) {
                    $subclass = 'last';
                } else {
                    $subclass = '';
                }
//echo "<pre>"; 
//print_r($children); 
//if (array_key_exists($subrecord['int_glcode'], $children)) {
                if (array_key_exists($subrecord['int_glcode'], $children) || $pageId == $subrecord['int_glcode']) {
                    $this->menuString .= "<li><a class='" . $subclass . " " . $subSelclass . "'  href='" . $link . "' ><b class=\"right-arrow fr\"></b>" . $subrecord['var_pagename'] . "</a>";
                    $this->menuString .= "<ul>";
// $this->menuString .= "<li class=\"first\">&nbsp;</li>";
                    $this->menuString .= $this->generateMenuChild($subrecord['int_glcode'], $children, $selectarray);
//$this->menuString .= "<li class=\"last\">&nbsp;</li>";
                    $this->menuString .= "</ul></li>";
                } else {
                    $this->menuString .= "<li><a class='" . $subclass . "' href='" . $link . "'  >" . $subrecord['var_pagename'] . "</a></li>";
                }
                $i++;
            }
        }
    }

    function getPageId() {
//echo $this->ci->uri->segment(1);
        if ($_REQUEST['pageId'] == '') {
            $module = $this->ci->uri->segment(1);
            if ($module == 'pages') {
                return $this->ci->uri->segment(2);
            }
            $condition = "";
            $condition .=!empty($module) ? " and m.var_modulename = '{$module}' " : " and p.int_glcode=1";
//$condition .=!empty($this->configObj->routes['view']) ? " and (p.var_viewalias = '{$this->configObj->routes['view']}' or var_alias='{$this->configObj->routes['view']}' )" : " ";
            $condition .=!empty($_REQUEST['PageId']) ? " and p.int_glcode = '{$_REQUEST['PageId']}' " : " ";
            $sql = "select p.int_glcode as pageid, p.var_pagetype, m.var_modulename,p.var_pagename as pagename from " . DB_PREFIX . "pages p, " . DB_PREFIX . "modules m WHERE m.int_glcode = p.var_pagetype $condition";
//echo $sql; exit;
            $result = mysql_query($sql);
            $rs = mysql_fetch_assoc($result);
            $this->configObj->routes['pagename'] = $rs['pagename'];
            if (!$rs['pageid']) {
                $pageid = 1;
            } else {
                $pageid = $rs['pageid'];
            }
        } else if ($_REQUEST['pageId'] != "") {
            $pageid = $_REQUEST['pageId'];
        }
        return $pageid;
    }

    function getbredcrumdetaildata() {
        switch ($this->pageId) {
            case 115:
                if ($this->ci->uri->segment(2) == TRUE) {
                    $sql = "select var_title as detailpagetitle from " . DB_PREFIX . "news where int_glcode=" . $this->ci->uri->segment(2);
                    $result = mysql_query($sql);
                    $rs = mysql_fetch_assoc($result);
                    return $rs['detailpagetitle'];
                } else {
                    return 'News';
                }
                break;
            case 122:
                if ($this->ci->uri->segment(2) == TRUE) {
                    $sql = "select var_title as detailpagetitle from " . DB_PREFIX . "rental where int_glcode=" . $this->ci->uri->segment(2);
                    $result = mysql_query($sql);
                    $rs = mysql_fetch_assoc($result);
                    return $rs['detailpagetitle'];
                } else {
                    return 'Rental';
                }
                break;
            default:
                break;
        }
    }

    function getbreadcrumdata($id) {
        if (SITE_SEO == "Y") {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,m.var_modulename,
                      case p.var_pagetype WHEN 0 THEN CONCAT('" . BASE . "',p.var_alias)
                      ELSE CONCAT('" . BASE . "',p.var_alias) end as link
                      from pages p left join modules m on m.int_glcode=p.var_pagetype where p.int_glcode IN ($id) order by p.fk_pages asc";
        } else {
            $msql = "select p.int_glcode,p.fk_pages,p.var_pagetype,p.var_pagename,p.var_alias,p.var_viewalias,m.var_modulename,
                      case p.var_pagetype WHEN 1 OR 0 THEN CONCAT('" . base_url() . "index.php?pageId=',p.int_glcode)
                      ELSE CONCAT('" . base_url() . "',m.var_modulename) end as link
                      from pages p left join modules m on m.int_glcode=p.var_pagetype where p.int_glcode IN ($id) order by p.fk_pages asc";
        }
//$sql="select * from ".DB_PREFIX."pages where int_glcode IN($id) order by fk_pages asc";
        $result = mysql_query($msql);
        $count = mysql_num_rows($result);
        if ($count > 0) {
            $data = '<div class="breadcrumbs fl"><a title="Cayman Islands Sailing Club - Home" href="' . base_url() . '">Home</a> &gt; ';
            $i = 1;
            while ($row = mysql_fetch_array($result)) {
                if ($i == $count) {
                    if ($this->ci->uri->segment(2) == TRUE) {
                        $m = '  &gt; <span class="selected">' . $this->getbredcrumdetaildata() . '</span>';
                        $a = '<a title="' . $row['var_pagename'] . '" href="' . $row['link'] . '">';
                        $b = '</a>';
                    }
                    $data .=$a . '<span class="selected">' . $row['var_pagename'] . '</span>' . $b . $m;
                } else {
                    $data .='<a title="' . $row['var_pagename'] . '" href="' . $row['link'] . '"><span>' . $row['var_pagename'] . ' </span></a>&gt; ';
                }
                $i++;
            }
            $data .='</div>';
        }
        return $data;
    }

    function renderoutput($module = 'main', $tpldata = '') {
//$this->getPageId1();
        $this->pageId = $this->getPageId();
        if ($this->pageId != '') {
            $p = $this->getmainparent($this->pageId, $fkstring);
            $bredcrum = $this->getbreadcrumdata($p);
            $this->ci->smarty->assign('bredcrum', $bredcrum);
            $data = $this->getCMSPageDetails($this->pageId);
            $this->ci->smarty->assign('PageTitle', $data['var_pagename']);
            $this->ci->smarty->assign('innercontentdata', $data['text_fulltext']);
//$this->glMetaArray=$this->getmetadetail(DB_PREFIX . 'pages', "int_glcode='" . $this->pageId . "'");
//$this->ci->smarty->assign('glMetaArray', $this->getmetadetail(DB_PREFIX . 'pages', "int_glcode='" . $this->pageId . "'"));
        }
        $topmenudata = $this->Gettopmenu($_REQUEST['pageId']);
        $this->ci->smarty->assign("topmenudata", $topmenudata);
        $this->ci->smarty->setTemplateDir(APPPATH . 'views/main/templates');
        if ($_REQUEST['pageId'] != '') {
            $banner = $this->ci->smarty->fetch('innerbanner.tpl');
            $rightpanel = $this->ci->smarty->fetch('rightpanel.tpl');
            $innerfooter = $this->ci->smarty->fetch('innerfooter.tpl');
//$this->glMetaArray=$this->getmetadetail(DB_PREFIX . 'pages', "int_glcode='" . $this->pageId . "'");
            $this->ci->smarty->assign("rightpanel", $rightpanel);
            $this->ci->smarty->assign("innerfooter", $innerfooter);
            $contentinner = $this->ci->smarty->fetch('contentinner.tpl');
        } else if ($module != 'main') {
            $banner = $this->ci->smarty->fetch('innerbanner.tpl');
            $this->ci->smarty->setTemplateDir(APPPATH . 'views/main/' . $module);
            $innercontentdata = ($tpldata == '') ? '<div class="spacer10"></div>' . $data['text_fulltext'] . '<div class="spacer10"></div>' . $this->ci->smarty->fetch($module . '.tpl') : $this->ci->smarty->fetch($tpldata . '.tpl');
            $this->ci->smarty->assign('innercontentdata', $innercontentdata);
//print_r($this->glMetaArray);
            $this->ci->smarty->setTemplateDir(APPPATH . 'views/main/templates');
            if ($module == 'calendar' || $module == 'sitemap') {
                $rightpanel = '';
                $this->ci->smarty->assign('rightpanel', $rightpanel);
            } else {
                $rightpanel = $this->ci->smarty->fetch('rightpanel.tpl');
                $this->ci->smarty->assign('rightpanel', $rightpanel);
            }
            $innerfooter = $this->ci->smarty->fetch('innerfooter.tpl');
            $this->ci->smarty->assign("innerfooter", $innerfooter);
            $this->ci->smarty->setTemplateDir(APPPATH . 'views/main/templates');
            $contentinner = $this->ci->smarty->fetch('contentinner.tpl');
        } else {
            $this->ci->smarty->setTemplateDir(APPPATH . 'views/main/templates');
            $topmenudata = $this->Gettopmenu($_REQUEST['pageId']);
            $this->ci->smarty->assign("topmenudata", $topmenudata);
            $bannerdata = $this->getbannerdata();
            $this->ci->smarty->assign("bannerdata", $bannerdata);
            $banner = $this->ci->smarty->fetch('banner.tpl');
            $contentinner = $this->ci->smarty->fetch('content.tpl');
        }
//print_r($this->glMetaArray);
//$this->ci->smarty->assign('glMetaArray', $this->glMetaArray);
        $header = $this->ci->smarty->fetch('header.tpl');
        $this->ci->smarty->assign("header", $header);
        $this->ci->smarty->assign("banner", $banner);
        $this->ci->smarty->assign("contentinner", $contentinner);
        $this->ci->smarty->view('output');
    }

    function getbannerdata() {
        $sql = "select * from " . DB_PREFIX . "homebanner where chr_publish='Y' and chr_delete= 'N' order by int_displayorder ASC";
        $myresult = mysql_query($sql);
        if (mysql_num_rows($myresult)) {
            while ($row = mysql_fetch_assoc($myresult)) {
                $results[] = $row;
                $banner.= "{image : 'upimages/homebanner/{$row['var_image']}', title : '" . urlencode($row['var_title']) . "'},";
            }
            $banner = trim($banner, ',');
        } else {
            $banner.= "image : '{$GLOBAL_FRONT_PATH}images/bg1.jpg', title : 'Image Credit: Maria Kazvan'";
        }
        return $banner;
    }

    function getconfigcontent() {
        return $data;
    }

    function load_ckeditor($id, $data, $width1 = '800px', $height1 = '175px', $toolbartype1 = 'Default') {
        $ckid = $id;
        $ckdata = $data;
        $width = $width1;
        $height = $height1;
        $toolbartype = $toolbartype1;

        include_once('ckeditor/ckeditor_load.php');
    }

    function load_ckeditor1($id, $data, $width1 = 'auto', $height1 = '455px', $toolbartype1 = 'Default') {
        $ckid = $id;
        $ckdata = $data;
        $width = $width1;
        $height = $height1;
        $toolbartype = $toolbartype1;
        include_once('ckeditor/ckeditor_load.php');
    }

    function alias_Textbox($paramAlias = array()) {
        define('GLOBAL_ALIAS_NOTE', 'Note : An alias is  an alternative and usually easier-to-understand for more significant name for defined data object.');
        $aliasBoxString = "";
        $aliasLabelData = array(
            'label' => 'Alias',
            'auto' => 'auto',
            'tdoption' => Array('TDDisplay' => 'Y', 'width' => '170')
        );
        $aliasBoxString.=form_input_label($aliasLabelData);
        $hiddenAias = form_hidden('alias_flag', 'A', '', 'id="alias_flag"');
        $width = (!empty($paramAlias['textbox_width'])) ? $paramAlias['textbox_width'] : '350px';
        $aliasBoxdata = array('name' => $paramAlias['name'],
            'id' => 'var_alias',
            'value' => $paramAlias['value'],
            'maxlength' => '255',
            'onpaste' => 'return false;',
            'style' => 'float: left;width:' . $width,
            'onkeypress' => 'return KeycheckAlphaNumeric(event);',
            'onblur' => 'auto_alias();',
            'tdoption' => Array('TDDisplay' => 'Y'),
            'commentNote' => GLOBAL_ALIAS_NOTE,
            'extraDataInTD' => '<label for="var_title" > </label>' . $hiddenAias . '<a ' . $paramAlias['linkEvent'] . ' style="float: left; margin: 10px 0px 0px 12px; cursor: pointer;" herf="javascript:;">Check alias</a><br><div id="aliasmsg" style="margin:-5px 5px 0px 5px;"></div>'
        );
//        'extraDataInTD' => '<label for="var_title" id="aliasnote" class="error"> </label>' . $hiddenAias . '<a ' . $paramAlias['linkEvent'] . ' style="float: left; margin: 10px 0px 0px 12px; cursor: pointer;" herf="javascript:;">Check alias</a><br><div id="aliasmsg"></div>'
        $aliasBoxString.=form_input_ready($aliasBoxdata);
        $aliasContent = '<tr>' . $aliasBoxString . '</tr>';
        return $aliasContent;
    }

    function seo_textdetails($param = array(), $display = 'Y') {

        $seoDetail = "";
        if (CHR_CLIENT_SEO_FLAG == 'N' && ADMIN_ID != 1) {
            $stylemeta_seo = "display:none;";
        } else {
            $stylemeta_seo = "";
        }
        $stylemeta_seo1 = "";
        $seoDetail.='<div class="grid-list-subtitle-bg" style="margin-top:10px; cursor:pointer;' . $stylemeta_seo . '" onClick="javascript:expandcollapsepanel(\'asignbannerseo\');" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                            <td align="left" valign="top" class="grid-td-left" style="' . $stylemeta_seo . '">SEO Information</td>
                            </tr>
                            </table>
                            </div>
                            <div class="information-white-bg" id="asignbannerseo" style="' . $stylemeta_seo1 . '">
                            <div class="clear"></div>
                            <div class="grid-list-inner-table-text">';


        $MTLabelData = array('label' => 'Meta Title',
            'auto' => 'auto',
            'tdoption' => Array('TDDisplay' => 'Y',
                'valign' => 'middle',
                'width' => '20%')
        );
        $MTLabel = form_input_label($MTLabelData);


        $MDLabelData = array('label' => 'Meta Keyword',
            'auto' => 'auto',
            'tdoption' => Array('TDDisplay' => 'Y',
                'valign' => 'middle',
                'width' => '20%')
        );
        $MDLabel = form_input_label($MDLabelData);

        $MKLabelData = array('label' => 'Meta Description',
            'auto' => 'auto',
            'tdoption' => Array('TDDisplay' => 'Y',
                'valign' => 'middle',
                'width' => '20%')
        );
        $MKLabel = form_input_label($MKLabelData);

        $metaTitleBoxString = "";
        $MTHidden = "";
        $MTCountBox = "";
        $MTHidden = form_hidden('hidvar_metatitle', $param['var_metatitle'], '', 'id="hidvar_metatitle"');

        $TitleleftCountBoxdata = array('name' => 'metatitle_left',
            'id' => 'metatitle_left',
            'value' => (200 - strlen($param['var_metatitle'])),
            'style' => 'width:50px;',
            'class' => 'add-new-user-textarea',
            'tabindex' => '-1',
            'readonly' => 'readonly'
        );
        $MTCountBox = form_input($TitleleftCountBoxdata);

        $metaTitleBoxdata = array('name' => 'var_metatitle',
            'id' => 'var_metatitle',
            'value' => $param['var_metatitle'],
            'maxlength' => '200',
            'style' => 'width:65%;',
            'class' => 'fl add-new-user-textarea',
            'onKeyDown' => 'CountLeft(this.form.var_metatitle,this.form.metatitle_left,200);',
            'onKeyUp' => 'CountLeft(this.form.var_metatitle,this.form.metatitle_left,200);',
            'tdoption' => Array('TDDisplay' => 'Y', 'valign' => 'middle'),
            'extraDataInTD' => $MTHidden . $MTCountBox . ' Characters left'
        );

        $metaTitleBoxString.=form_input_ready($metaTitleBoxdata);



        $metaKwdBoxString = "";
        $MKCountBox = "";
//$metaKwdBoxString.=form_hidden('hidvar_metatitle', $param['var_metatitle'],'','id="hidvar_metatitle"');
        $KwdleftCountBoxdata = array('name' => 'metakeyword_left',
            'id' => 'metakeyword_left',
            'value' => (400 - strlen($param['var_metakeyword'])),
            'style' => 'width:50px;',
            'class' => 'add-new-user-textarea',
            'tabindex' => '-1',
            'readonly' => 'readonly'
        );
        $MKCountBox.=form_input($KwdleftCountBoxdata);

        $metaKwdBoxdata = array('name' => 'var_metakeyword',
            'id' => 'var_metakeyword',
            'value' => $param['var_metakeyword'],
            'maxlength' => '500',
            'style' => 'width:65%;',
            'class' => 'fl add-new-user-textarea',
            'onKeyDown' => 'CountLeft(this.form.var_metakeyword,this.form.metakeyword_left,400);',
            'onKeyUp' => 'CountLeft(this.form.var_metakeyword,this.form.metakeyword_left,400);',
            'tdoption' => Array('TDDisplay' => 'Y', 'valign' => 'middle'),
            'extraDataInTD' => $MKCountBox . ' Characters left'
        );

        $metaKwdBoxString.=form_input_ready($metaKwdBoxdata);

        $metaDescBoxString = "";
        $MDHidden = form_hidden('hidvar_metadescription', $param['var_metadescription'], '', 'id="hidvar_metadescription"');
        $DescleftCountBoxdata = array('name' => 'metadescription_left',
            'id' => 'metadescription_left',
            'value' => (400 - strlen($param['var_metadescription'])),
            'style' => 'width:50px;',
            'class' => 'add-new-user-textarea',
            'tabindex' => '-1',
            'readonly' => 'readonly'
        );
        $MDCountBox.=form_input($DescleftCountBoxdata);

        $metaDescBoxdata = array('name' => 'var_metadescription',
            'id' => 'var_metadescription',
            'value' => $param['var_metadescription'],
            'style' => 'width:65%;',
            'rows' => '5',
            'cols' => '75',
            'class' => 'textarea2',
            'onKeyDown' => 'CountLeft(this.form.var_metadescription,this.form.metadescription_left,400);',
            'onKeyUp' => 'CountLeft(this.form.var_metadescription,this.form.metadescription_left,400);',
            'tdoption' => Array('TDDisplay' => 'Y', 'valign' => 'middle'),
            'extraDataInTD' => $MDHidden . $MDCountBox . ' Characters left'
        );

        $metaDescBoxString.=form_input_ready($metaDescBoxdata, 'textarea');


        $seoDetail.= '
                            <table width="100%" border="0" cellspacing="3" cellpadding="3">';
        $seoDetail.='<tr><td></td><td>
                            <div class="new-auto-button-bg">
                            <a style="color:white;text-decoration:none" onclick="copytext(\'a\');" href="javascript:;">Auto Generate</a>
                            </div></td></tr>';
        $seoDetail.= '<tr>' . $MTLabel . $metaTitleBoxString . '</tr>
                                           <tr>' . $MDLabel . $metaKwdBoxString . '</tr>
                                            <tr>' . $MKLabel . $metaDescBoxString . '</tr>
                            </table>
                            ';


        $seoDetail.=' </div>
                            </div>
                            <div class="clear"></div>';

        $content = $seoDetail;



        return $content;
    }

//    function generateHeaderPanel($params, $needactionImg = '') {
//        
//        $tot_recods = $rs->total;
//
//
//        $exitButton = TRUE;
//        $heading = $params['heading'];
//        $pagename = $params['pageurl'];
//        $actionImage = $params['actionImage'];
////        $backbuttonurl = $params['backbuttonurl'];
//        $actionImageHover = $params['actionImageHover'];
//        $actionUrl = $params['actionUrl'];
//        $listImage = $params['listImage'];
//        $altActiontag = "Add New";
//
//        $searcharray = $params['search']['searchArray'];
//        $searchurl = $params['search']['searchUrl'];
//        $searchby = $params['search']['searchBy'];
//        $searchtxt = $params['search']['searchText'];
//
//
//        $searchurl_panel = $params['searchpanel']['searchUrl'];
//        $searchby_panel = $params['searchpanel']['searchBy'];
//        $searchtxt_panel_0 = $params['searchpanel']['searchText0'];
//        $searchtxt_panel_1 = $params['searchpanel']['searchText1'];
//        $searchtxt_panel_2 = $params['searchpanel']['searchText2'];
//        $searchtxt_panel_3 = $params['searchpanel']['searchText3'];
//        $searchtxt_panel4 = $params['searchpanel']['searchText4'];
//        $searchtxt_panel5 = $params['searchpanel']['searchText5'];
//
//        $serachtextarr = array($searchtxt_panel_0, $searchtxt_panel_1, $searchtxt_panel_2, $searchtxt_panel_3);
//
//        if ($needactionImg == "no") {
//            $actionImage = '';
//            $actionImageHover = '';
//            $actionUrl = '';
//            $altActiontag = '';
//        }
//
//        if (!empty($searcharray)) {
//
//            $strselbox = '';
//            $selected = ($searchby_panel == '0') ? 'selected' : '';
//
//            foreach ($searcharray as $key => $value) {
//                $selected = ($key == $searchby) ? 'selected' : '';
//                $strselbox.= "<option value=\"$key\" $selected>$value</option>";
//            }
//            if (MODULE == "contactusleads") {
//                   $style = "style=\"width:490px\"";
//            }else if(MODULE == "settings"){
//                $style = "style=\"width:490px\"";
//            }
////            else if(MODULE == "newsletterleads"){
////                $style = "style=\"width:490px\"";
////            }
//            else if(MODULE == "trashmanager"){
//                $style = "style=\"width:490px\"";
//            }else {
//                 $style = "";
//            }
//
//            $searchtxt = htmlspecialchars_decode(htmlspecialchars($searchtxt));
//
//            $searchBox = "<div class=\"search-button-box\" $style>";
//
//            if (count($searcharray) == 1) {
//                $searchBox.="<div class=\"new-search-show-all \"><select name=\"searchby\" id=\"searchby\" style=\"display:none;\">$strselbox	</select></div>";
//            } else {
//                $searchBox.="<div class=\"new-search-show-all fr\"><select name=\"searchby\" id=\"searchby\" style=\"width:117px;\" class=\"search-textarea\">$strselbox</select></div>";
//            }
//            $searchBox.= "<div class=\"input-append\" >
//                                <label>
//                                    <input name=\"searchtxt1\" id=\"searchtxt1\" type=\"text\"  value=\"$searchtxt\" onkeydown=\"onkeydown_search(event,'$searchurl')\"/>
//                              <button onClick=\"SendGridBindRequest('$searchurl','gridbody','S')\" id=\"search\" class=\"btn\" type=\"button\">Search</button>";
//                          if (!empty($searchtxt)) {
//            $searchBox.= "<button onClick=\"$('#searchtxt1').val('');SendGridBindRequest('$searchurl','gridbody','S')\" id=\"clearsearch\" class=\"btn\" type=\"button\">Clear</button>";
//                          }            
//                    $searchBox.= "</label>";
//               
//                  $searchBox.= "</div>";
////
////            $searchBox.= "</div>";
//
//
//
////            $searchBox.="</div>";
//        }
//
//        $module = $this->ci->router->fetch_class();
//
//        $module = $this->ci->router->fetch_class();
//
//
//        // this condition only for "cruzbaywatersports.com modules namely: (1) activity (2) enquiry (3) blog and (4) event"
//        $addButton = "<div style=\"float:left\"><a href=\"$actionUrl\" onmouseout=\"MM_swapImgRestore()\" onmouseover=\"MM_swapImage('Image49','','" . ADMIN_MEDIA_URL . "images/$actionImageHover',1)\"><img src=\"" . ADMIN_MEDIA_URL . "images/$actionImage\" alt=\"$altActiontag\" name=\"Image49\" height=\"25\" hspace=\"20\" vspace=\"6\" border=\"0\" id=\"Image49\" /></a></div>";
////        if (empty($_REQUEST['fk_category']) && empty($_REQUEST['fk_activity']) && empty($_REQUEST['fk_event'])) {
////
////            $addButton = "<div style=\"float:left\"><a href=\"$actionUrl\" onmouseout=\"MM_swapImgRestore()\" onmouseover=\"MM_swapImage('Image49','','" . ADMIN_MEDIA_URL . "images/$actionImageHover',1)\"><img src=\"" . ADMIN_MEDIA_URL . "images/$actionImage\" alt=\"$altActiontag\" name=\"Image49\" height=\"25\" hspace=\"20\" vspace=\"6\" border=\"0\" id=\"Image49\" /></a></div>";
////        }
//
//        if (!empty($_REQUEST['modulecode'])) {
//
//            $param = array(array($this->moduleArray[$_REQUEST['modulecode']] => 'Edit'));
//        }
//
//        /* add code for access control */
//
//        if (!empty($this->groupAccess)) {
//            $param = array(array($_REQUEST['module'] => "Add"));
//            if ($this->checkAccess($param) == false) {
//                $addButton = "";
//            }
//        }
//
//        /* add code for access control */
//
//        if ($needactionImg == "no") {
//            return "<div class=\"add-new-user-title\">
//                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
//                <tr> 
//                <td>
//                <div style=\"float:left\">
//                <h2>
//        <img src=\"" . ADMIN_MEDIA_URL . "images/$listImage \"  width=\"34\" height=\"31\" />
//            $heading
//                </h2>
//                </div>
//                <div style=\"float:left\"> </div>
//                $searchBox  </td>
//                    </tr>
//                    </table></div>";
//        } else {
//            return "<div class=\"row-fluid\"><div class=\"span12\">  $searchBox  $searchBox_panel </div></div>";
//        }
//    }

    function generateHeaderPanel($params, $needactionImg = '') {

        $tot_recods = $rs->total;


        $exitButton = TRUE;
        $heading = $params['heading'];
        $pagename = $params['pageurl'];
        $actionImage = $params['actionImage'];
//        $backbuttonurl = $params['backbuttonurl'];
        $actionImageHover = $params['actionImageHover'];
        $actionUrl = $params['actionUrl'];
        $listImage = $params['listImage'];
        $altActiontag = "Add New";

        $searcharray = $params['search']['searchArray'];
        $searchurl = $params['search']['searchUrl'];
        $searchby = $params['search']['searchBy'];
        $searchtxt = $params['search']['searchText'];


        $searchurl_panel = $params['searchpanel']['searchUrl'];
        $searchby_panel = $params['searchpanel']['searchBy'];
        $searchtxt_panel_0 = $params['searchpanel']['searchText0'];
        $searchtxt_panel_1 = $params['searchpanel']['searchText1'];
        $searchtxt_panel_2 = $params['searchpanel']['searchText2'];
        $searchtxt_panel_3 = $params['searchpanel']['searchText3'];
        $searchtxt_panel4 = $params['searchpanel']['searchText4'];
        $searchtxt_panel5 = $params['searchpanel']['searchText5'];

        $serachtextarr = array($searchtxt_panel_0, $searchtxt_panel_1, $searchtxt_panel_2, $searchtxt_panel_3);

        if ($needactionImg == "no") {
            $actionImage = '';
            $actionImageHover = '';
            $actionUrl = '';
            $altActiontag = '';
        }

        if (!empty($searcharray)) {

            $strselbox = '';
            $selected = ($searchby_panel == '0') ? 'selected' : '';

            foreach ($searcharray as $key => $value) {
                $selected = ($key == $searchby) ? 'selected' : '';
                $strselbox.= "<option value=\"$key\" $selected>$value</option>";
            }
            if (MODULE == "contactusleads") {
                $style = "style=\"width:490px\"";
            } else if (MODULE == "settings") {
                $style = "style=\"width:490px\"";
            }
//            else if(MODULE == "newsletterleads"){
//                $style = "style=\"width:490px\"";
//            }
            else if (MODULE == "trashmanager") {
                $style = "style=\"width:490px\"";
            } else {
                $style = "";
            }

            $searchtxt = htmlspecialchars_decode(htmlspecialchars($searchtxt));

            $searchBox = "<div class=\"search-button-box\" $style>";

            if (count($searcharray) == 1) {
                $searchBox.="<div class=\"new-search-show-all \"><select name=\"searchby\" id=\"searchby\" style=\"display:none;\">$strselbox	</select></div>";
            } else {
                $searchBox.="<div class=\"new-search-show-all fr\"><select name=\"searchby\" id=\"searchby\" style=\"width:117px;\" class=\"search-textarea\">$strselbox</select></div>";
            }
            $searchBox.= "<div class=\"new-search-show-all\" style=\"padding-bottom:05px\">
                                    <input name=\"searchtxt1\" id=\"searchtxt1\" type=\"text\" value=\"$searchtxt\" onkeydown=\"onkeydown_search(event,'$searchurl')\"/>
                            </div>
                            <div class=\"new-search-button-bg\" style=\"width:490px\">
                                <a href=\"javascript:;\" onClick=\"SendGridBindRequest('$searchurl','gridbody','S')\" class=\"btn btn-primary\" id=\"search\">Search</a>";
            if (!empty($searchtxt)) {
                $searchBox.= "<a class=\"btn btn-primary\" href=\"javascript:;\" id=\"clearsearch\" onClick=\"$('#searchtxt1').val('');SendGridBindRequest('$searchurl','gridbody','S')\" >Clear Search</a>";
            }
            $searchBox.= "</div>";



            $searchBox.="</div>";
        }

        $module = $this->ci->router->fetch_class();

        $module = $this->ci->router->fetch_class();


// this condition only for "cruzbaywatersports.com modules namely: (1) activity (2) enquiry (3) blog and (4) event"
        if ($actionImage != '') {
            $addButton = "<div style=\"float:left; padding-left:15px\"><a class=\"btn btn-primary btn-sm\" href=\"$actionUrl\">$actionImage</a></div>";
        }
//        if (empty($_REQUEST['fk_category']) && empty($_REQUEST['fk_activity']) && empty($_REQUEST['fk_event'])) {
//
//            $addButton = "<div style=\"float:left\"><a href=\"$actionUrl\" onmouseout=\"MM_swapImgRestore()\" onmouseover=\"MM_swapImage('Image49','','" . ADMIN_MEDIA_URL . "images/$actionImageHover',1)\"><img src=\"" . ADMIN_MEDIA_URL . "images/$actionImage\" alt=\"$altActiontag\" name=\"Image49\" height=\"25\" hspace=\"20\" vspace=\"6\" border=\"0\" id=\"Image49\" /></a></div>";
//        }

        if (!empty($_REQUEST['modulecode'])) {

            $param = array(array($this->moduleArray[$_REQUEST['modulecode']] => 'Edit'));
        }

        /* add code for access control */

        if (!empty($this->groupAccess)) {
            $param = array(array($_REQUEST['module'] => "Add"));
            if ($this->checkAccess($param) == false) {
                $addButton = "";
            }
        }

        /* add code for access control */

        if ($needactionImg == "no") {
            return "<div class=\"add-new-user-title\">
                <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
                <tr> 
                <td>
                <div style=\"float:left\">
                <h2>
            $heading
                </h2>
                </div>
                <div style=\"float:left\"> </div>
                $searchBox  </td>
                    </tr>
                    </table></div>";
        } else {
            return "<div class=\"add-new-user-title\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td><div style=\"float:left\"><h2>$heading</h2></div> $addButton $searchBox  $searchBox_panel </td></tr></table></div>";
        }
    }

    function generateXLSfile() {
        $result = mysql_query($this->xlsSQL);
        $totalrecords = mysql_num_rows($result) or die('Unable to run query:' . mysql_error());
//echo $totalrecords;exit;
        $gridbind = "<table border=1>";
        $gridbind .="<tr><b>$this->fileheader</b></tr>";
        $valueis = '';
        if ($totalrecords > 0) {
            while ($row = mysql_fetch_array($result)) {
                if (!$printed_headers) {
//print the headers once:

                    $gridbind .="<tr>";
                    foreach (array_keys($row) AS $header) {
//you have integer keys as well as string keys because of the way PHP
//handles arrays.
                        if (!is_int($header)) {
                            $gridbind .="<th>$header</th>";
                        }
                    }
                    $gridbind .= "</tr>";
                    $printed_headers = true;
                }
//print the data row
                $gridbind .="<tr>";
                foreach ($row AS $key => $value) {
                    if (!is_int($key)) {
                        $gridbind .="<td valign='top'>$value</td>";
                    }
                }
                $gridbind .="</tr>";
            }
        } else {
            $gridbind .="<tr><td>No Records<td></tr>";
        }
        $gridbind .="</table>";
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Content-type: application/vnd.ms-excel");
        header("Content-Disposition: attachment; filename={$this->filename}");
        header("Content-Length: " . strlen($gridbind));
        echo $gridbind;
        exit;
    }

//    function generatepaging($dataObj, $mid) {
//        $flag = 'Y';
////        $init = $dataObj->module_model->initialize_front($flag);
//        $genur = $dataObj->module_model->Generateurl($flag);
//        $pagenumber = $init->pagenumber;
//        $numofpages = $genur->noofpages;
//        $numofrows = $genur->start;
//        $pagingurl = $genur->urlwithpara;
//        $pagename = $genur->pagename;
//
//        $beforedivdata = "<div class=\"fr pagging mgt3\"><ul>";
//        if ($pagenumber > 1) {
//            $page = $pagenumber - 1;
//            $tdfirstpage = "<li><a href=\"javascript:;\"  class='pre-btn' title='Go to Previous Page'  onclick=\"SendpagingBindRequest('" . $init->link . "/page-" . $page . "','$pagename','P','','')\" title='Previous'>PREV</a></li>";
//        }
//        if ($pagenumber < $numofpages) {
//            $page = $pagenumber + 1;
//            $tdlastpage = "<li><a href=\"javascript:;\" class='next-btn' title='Go to Next Page' onclick=\"SendpagingBindRequest('" . $init->link . "/page-" . $page . "','$pagename','P','','')\"  title='Next'>NEXT</a></li>";
//        }
//        $start = ($pagenumber - 1) * $pagesize;
//        $starting_no = $start + 1;
//        if (($numofrows - $start) < $pagesize) {
//            $end_count = $numofrows;
//        } elseif (($numofrows - $start) >= $pagesize) {
//            $end_count = $start + $pagesize;
//        }
//        $pagestring = '';
//        $loopcondtion = 0;
//        $loopcondtion = $noofpage + 1;
//        if ($genur->noofpages > 5) {
//            if ($init->pagenumber > 3 && $init->pagenumber != $genur->noofpages && $genur->pagenumber != $genur->noofpages - 1) {
//                $pagestart = $genur->pagenumber - 2;
//            } else if ($init->pagenumber > 3 && $init->pagenumber == $genur->noofpages) {
//                $pagestart = $pagenumber - 4;
//            } else if ($init->pagenumber > 3 && $init->pagenumber == $genur->noofpages - 1) {
//                $pagestart = $init->pagenumber - 3;
//            } else {
//                $pagestart = 1;
//            }
//            $loopstart = $pagestart;
//            $loopcondtion = $pagestart + 5;
//        } else {
//            $loopstart = 1;
//            $loopcondtion = $genur->noofpages + 1;
//        }
//        for ($i = $loopstart; $i < $loopcondtion; $i++) {
//            if ($i == $pagenumber) {
//                $pagestring.="<li class='selected' title='Go to page " . $i . "'><a class='selected' href='javascript:;'>" . $i . "</a></li>";
//            } else {
//                $pagestring.="<li><a class=\"active\" href=\"javascript:;\" title='Go to Page " . $i . "' onclick=\"SendpagingBindRequest('" . $init->link . "/page-" . $i . "','$pagename','P','$i','')\">" . $i . "</a></li>";
//            }
//        }
//        $afterdivdata = "</ul></div>";
////echo $numofpages;
//        if ($numofpages == 1) {
//            return " ";
//        } else {
//            return $beforedivdata . $tdfirstpage . $pagestring . $tdlastpage . $afterdivdata;
//        }
//    }
//    function generatepaging($dataObj, $position = 'Top') {
//        $flag='Y';
//        $dataObj=$dataObj->module_model->initialize($flag);
//        $dataObj=$dataObj->module_model->Generateurl($flag);
//        $pagenumber = $dataObj->pagenumber;
////        echo $pagenumber;
//        $numofpages = $dataObj->noofpages;
//        $numofrows = $dataObj->numofrows;
//        $pagingurl = $dataObj->urlwithpara;
//        $pagename = $dataObj->pagename;
//        if($pagenumber > 1) {
//            $page = $pagenumber - 1;
//            $tdfirstpage = "<li><a class=\"pre-btn\" href=\"javascript:;\" title='Go to previous page' onclick=\"SendpagingBindRequest('$pagingurl','?pagenumber=$page')\"  >Prev</a></li>";
//        }
//        if($pagenumber < $numofpages) {
//            $page = $pagenumber + 1;
//            $tdlastpage = "<li><a href=\"javascript:;\" class=\"next-btn\" title='Go to next page' onclick=\"SendpagingBindRequest('$pagingurl','?pagenumber=$page')\"  >Next</a></li>";
//        }
//        $start = ($pagenumber - 1) * $pagesize;
//        $starting_no = $start + 1;
//        if(($numofrows - $start) < $pagesize) {
//            $end_count = $numofrows;
//        } else if (($numofrows - $start) >= $pagesize) {
//            $end_count = $start + $pagesize;
//        }
//        $pagestring = '';
//        $loopcondtion = 0;
//        $loopcondtion = $noofpage + 1;
//        if ($dataObj->noofpages > 5) {
//            if ($dataObj->pagenumber > 3 && $dataObj->pagenumber != $dataObj->noofpages && $dataObj->pagenumber != $dataObj->noofpages - 1) {
//                $pagestart = $dataObj->pagenumber - 2;
//            } else if ($dataObj->pagenumber > 3 && $dataObj->pagenumber == $dataObj->noofpages) {
//                $pagestart = $pagenumber - 4;
//            } else if ($dataObj->pagenumber > 3 && $dataObj->pagenumber == $dataObj->noofpages - 1) {
//                $pagestart = $dataObj->pagenumber - 3;
//            } else {
//                $pagestart = 1;
//            }
//            $loopstart = $pagestart;
//            $loopcondtion = $pagestart + 5;
//        } else {
//            $loopstart = 1;
//            $loopcondtion = $dataObj->noofpages + 1;
//        }
//        for ($i = $loopstart; $i < $loopcondtion; $i++) {
//            if ($i == $pagenumber) {
//                $pagestring.="<li title='Go to page " . $i . "'><a class='selected' href='javascript:;'>" . $i . "</a></li>";
//            } else {
//                $pagestring.="<li><a href=\"javascript:;\" title='Go to page " . $i . "' onclick=\"SendpagingBindRequest('$pagingurl','?pagenumber=$i')\">" . $i . "</a></li>";
//            }
//        }
//        if ($numofpages == 1) {
//            return "<div class=\"spacer25\"></div>";
//        } else {
//            return "<div class=\"fr pagging mgt3\">
//                    <ul>".$tdfirstpage."
//                        ".$pagestring."
//                        ".$tdlastpage."
//                        </ul>
//                    </div>";
//        }
//    }
//    function generatePagingPannel($params) {
//
//        $pagenumber = $params['paging']['pagenumber'];
//        $numofpages = $params['paging']['noofpages'];
//
//        $numofrows = $params['paging']['numofrows'];
////$wholeurl = $params['paging']['wholeurl'];
//        $pagingurl = $params['paging']['pagingurl'];
//
//        $pagename = $params['pageurl'];
//        $AutoSearchUrl = $params['AutoSearchUrl'];
//        $rentalcombo = $params['rentalcombo'];
//
//        $amenitiescatcmb = $params['amenitiescatcmb'];
//        $Countrycmb = $params['Countrycmb'];
//        $positioncmb = $params['positioncmb'];
//        $categorycmb = $params['categorycmb'];
//        $pagescmb = $params['pagescmb'];
//        $form_categorycombo = $params['form_categorycombo'];
//        $activity_combo = $params['activity_combo'];
//        $BannerTypeCmb = $params['BannerTypeCmb'];
//
//
// $sccombo = $params['sccombo'];
//        $banner_type = $params['Banner_type'];
//        $filter_pages = $params['filter_pages'];
//        $filterby = $params['filter']['filterby'];
//        $filterPosition = $params['filter']['filterposition'];
//           $month_search = $params['date'];
//           $occasion_search = $params['occasion'];
//        $filterbystatusarray = $params['filterstatus']['filterarray'];
//        $filterurl_sattus = $params['filterstatus']['filterurl'];
//        $filterby_sattus = $params['filterstatus']['filterby'];
//        $filterPosition_sattus = $params['filterstatus']['filterposition'];
//        $Position_sattus = $params['filterstatus']['position'];
//        $VendorCmb = $params['VendorCmb'];
//        $VendorCmb = $params['VendorCmb'];
//         $modcmb = $params['modcmb'];
//        $reasoncmb = $params['reasoncmb'];
//        $StatusCmb = $params['StatusCmb'];
//        $CertificateCmb = $params['CertificateCmb'];
//        $contact_category = $params['contact_category'];
//        $displimitarray = $params['display']['limitarray'];
//        $displimitarray = $params['display']['limitarray'];
//        $displayurl = $params['display']['displayurl'];
//        $pagesize = $params['display']['pagesize'];
//        $tablename = $params['tablename'];
//        $position = $params['position'];
//        $diplayPaging = $params['dispPaging'];
//        $TagCmb = $params['TagCmb'];
//
//
//        if (!empty($filterarray)) {
//            $strfilerbox = '';
//            $selected = ($filterby == '') ? 'selected' : '';
//            $strfilerbox .= "<option value=\"0\" $selected>-- Show all --</option>";
//            foreach ($filterarray as $key => $value) {
//                $selected = ($key == $filterby) ? 'selected' : '';
//                $strfilerbox.= "<option value=\"$key\" $selected>$value</option>";
//            }
//
//            $filterCmb = "<div class=\"new-search-show-all\"><select name=\"filterby$position\" id=\"filterby$position\" style=\"width:auto;\" class=\"more-textarea\" onchange=\"SendGridBindRequest('$filterurl','gridbody','$filterPosition') \"> $strfilerbox  </select> </div>";
//        }
//
//        if (!empty($filterbystatusarray)) {
//            $strfilerbox = '';
//            $selected = ($filterby_sattus == '') ? 'selected' : '';
//            $strfilerbox .= "<option value=\"0\" $selected>Select Status</option>";
//            foreach ($filterbystatusarray as $key => $value) {
//                $selected = ($key == $filterby_sattus) ? 'selected' : '';
//                $strfilerbox.= "<option value=\"$key\" $selected>$value</option>";
//            }
//
//            $filterCmb .= "<div class=\"new-search-show-all\">$Position_sattus <select name=\"filterbystatus\" id=\"filterbystatus\" style=\"width:auto;\" class=\"more-textarea\" onchange=\"SendGridBindRequest('$filterurl_sattus','gridbody','$filterPosition_sattus') \"> $strfilerbox  </select> </div>";
//        }
//
//
//
//        if (!empty($params['typecmb'])) {
//            $typecmb = $params['typecmb'];
//        } else {
//            $typecmb = '';
//        }
//
//        if (!empty($params['modcmb'])) {
//            $modcmb = $params['modcmb'];
//        } else {
//            $modcmb = '';
//        }
//
//
//        if (!empty($params['actioncmb'])) {
//            $actioncmb = $params['actioncmb'];
//        } else {
//            $actioncmb = '';
//        }
//        if (!empty($params['modulescombo'])) {
//            $modulescombo = $params['modulescombo'];
//        } else {
//            $modulescombo = '';
//        }
//
//
//        if ($params['display']) {
//            $dispStr = '';
//
//            if (!empty($displimitarray)) {
//                foreach ($displimitarray as $key => $value) {
//                    $selected = ($value == $pagesize) ? 'selected' : '';
//                    $dispStr.= "<option  value=\"$value\" $selected>Display - $value</option>";
//                }
//            } else {
//                $dispStr = "<option value=\"20\">Display - 20</option><option value=\"30\">Display - 30</option><option value=\"40\">Display - 40</option><option value=\"50\">Display - 50</option>";
//            }
//
//            if ($_REQUEST['rid'] != '') {
//                $dispCmbStr = "<div class=\"new-search-show-all\"><select style=\"width: 110px;\" id=\"cmbdisplay$position\" name=\"cmbdisplay$position\" onchange=\"SendGridBindRequest('$displayurl','gridbody','new_PS$position')\" class=\"more-textarea\"> $dispStr </select></div>";
//            } else {
//                $dispCmbStr = "<div class=\"new-search-show-all\"><select style=\"width: 110px;\" id=\"cmbdisplay$position\" name=\"cmbdisplay$position\" onchange=\"SendGridBindRequest('$displayurl','gridbody','PS$position')\" class=\"more-textarea\"> $dispStr </select></div>";
//            }
//        }
//
//        $tdfirstpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/>";
//        $tdprevpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" />";
//        $tdnextpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/>";
//        $tdlastpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/>";
////
//        if ($pagenumber > 1) {
//            $page = $pagenumber - 1;
//            $tdfirstpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=1','gridbody','P')\">
//            <img src=\"" . ADMIN_MEDIA_URL . "images/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/></a>";
//            $tdprevpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\">
//            <img src=\"" . ADMIN_MEDIA_URL . "images/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" /></a>";
//        }
//
//        if ($pagenumber < $numofpages) {
//            $page = $pagenumber + 1;
//            $tdnextpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\" ><img src=\"" . ADMIN_MEDIA_URL . "images/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/></a>";
//            $tdlastpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$numofpages','gridbody','P')\" ><img src=\"" . ADMIN_MEDIA_URL . "images/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/></a>";
//        }
////
//        $start = ($pagenumber - 1) * $pagesize;
//
//        if ($numofrows == '0') {
//            $starting_no = $start;
//        } else {
//            $starting_no = $start + 1;
//        }
//
//        if (($numofrows - $start) < $pagesize) {
//            $end_count = $numofrows;
//        } elseif (($numofrows - $start) >= $pagesize) {
//            $end_count = $start + $pagesize;
//        }
////
//
//        $tablename = $params['tablename'];
//        if ($params['filter']) {
//            if (isset($params['filter']['filterarray']['chr_read-Y'])) {
//                $filters = "<div class=\"new-search-show-all\"><select id=\"cmbmoreaction$position\" name=\"cmbmoreaction$position\" onchange=\"updatereadstar('communication','updateread','cmbmoreaction$position','$tablename','chkgrow')\" class=\"more-textarea\"><option value=\"0\">More Action</option> <option value=\"r\">Mark as read</option><option value=\"ur\">Mark as unread</option></select></div>";
//            }
//        }
//
//        $pagingStr = "";
//
//        if ($diplayPaging != 'no') {
//            $pagingStr = "<div class=\"pagination-main1\"style=\"\">
//				<div class=\"page-next-icon2\">$tdfirstpage</div>
//				<div class=\"page-next-icon2\">$tdprevpage</div>
//				<div class=\"new-search-pagination-text3\">$starting_no - $end_count of $numofrows</div>
//				<div class=\"page-next-icon2\">$tdnextpage</div>
//				<div class=\"page-next-icon2\">$tdlastpage</div>
//			</div>";
//        }
//        if ($position == "top") {
//            $autosearch = "<input type=\"hidden\" name=\"autosearchurl\" id=\"autosearchurl\" value=\"" . $AutoSearchUrl . "&ajax=Y\" />";
//        }
//       if ($starting_no > 0) {
//        if ($position == "top" && MODULE_ID == 11 && ADMIN_ID == 1) {
//            $delete_all = "<div class=\" delete-button-class fl\" style=\"margin-left:10px\">
//                           <a onmouseover=\"MM_swapImage('Image471','','". ADMIN_MEDIA_URL ."images/Delete-All.png',0)\" onmouseout=\"MM_swapImgRestore()\" href=\"javascript:\"> 
//                           <img src=\"" .ADMIN_MEDIA_URL. "images/Delete-All.png \" alt=\"Delete all\" name=\"Image471\" border=\"0\" id=\"Image471\" onclick=\"return verify1();\" ></div>
//                           </a>";
//        }
//            }
//            if ($starting_no > 0) {
//         if ($position == "top" && MODULE_ID == 10 && ADMIN_ID == 1) {
//             $delete_all = "<div class=\"delete-button-class fl\" style=\"margin-left:10px\">
//                            <a onmouseover=\"MM_swapImage('Image471','','". ADMIN_MEDIA_URL ."images/clear-all-hr.png',0)\" onmouseout=\"MM_swapImgRestore()\" href=\"javascript:\">
//                                <img src=\"" .ADMIN_MEDIA_URL. "images/clear-all.png \" alt=\"Delete all\" name=\"Image471\" border=\"0\" id=\"Image471\" onclick=\"return verify1();\" />
//                            </a>;
//                                      
//                      
//                            </div>";  
//        }
//}
//        return "<div  class=\"row-fluid\"><div style=\" padding-left:15px; padding-top:10px;background:#EDEDED\" class=\"span12\">
//        
//                                $pagingStr
//                                <div>
//                                {$dispCmbStr}{$autosearch}{$typecmb}{$modcmb}{$month_search}{$occasion_search}{$form_categorycombo}{$activity_combo}{$actioncmb}{$filters}{$modulescombo}{$rentalcombo}{$amenitiescatcmb}{$Countrycmb}{$sccombo}{$banner_type}{$filter_pages}{$positioncmb} {$categorycmb} {$pagescmb} {$VendorCmb} {$reasoncmb} {$StatusCmb} {$CertificateCmb}{$contact_category}{$TagCmb}{$BannerTypeCmb}
//                                    
//                                        
//                                <div class=\"new-search-refresh-text\"><a href=\"$pagename\">Refresh</a></div>
//                                     $delete_all
//                                </div><br />
//                </div></div></div>";
//    }

    function generatePagingPannel($params) {

        $pagenumber = $params['paging']['pagenumber'];
        $numofpages = $params['paging']['noofpages'];

        $numofrows = $params['paging']['numofrows'];
//$wholeurl = $params['paging']['wholeurl'];
        $pagingurl = $params['paging']['pagingurl'];

        $pagename = $params['pageurl'];
        $AutoSearchUrl = $params['AutoSearchUrl'];

        $rentalcombo = $params['rentalcombo'];

        $amenitiescatcmb = $params['amenitiescatcmb'];
        $Countrycmb = $params['Countrycmb'];
        $positioncmb = $params['positioncmb'];
        $categorycmb = $params['categorycmb'];
        $pagescmb = $params['pagescmb'];
        $form_categorycombo = $params['form_categorycombo'];
        $activity_combo = $params['activity_combo'];
        $BannerTypeCmb = $params['BannerTypeCmb'];


        $sccombo = $params['sccombo'];
        $pubcombo = $params['pubcombo'];
        $post_category = $params['post_category'];
        $post_university_combo = $params['post_university_combo'];
        $spam_count = $params['spam_count'];

        $select_date = $params['select_date'];
        $status_combo = $params['status_combo'];


        $banner_type = $params['Banner_type'];
        $filter_pages = $params['filter_pages'];
        $filterby = $params['filter']['filterby'];
        $filterPosition = $params['filter']['filterposition'];
        $month_search = $params['date'];
        $occasion_search = $params['occasion'];
        $filterbystatusarray = $params['filterstatus']['filterarray'];
        $filterurl_sattus = $params['filterstatus']['filterurl'];
        $filterby_sattus = $params['filterstatus']['filterby'];
        $filterPosition_sattus = $params['filterstatus']['filterposition'];
        $Position_sattus = $params['filterstatus']['position'];
        $VendorCmb = $params['VendorCmb'];
        $VendorCmb = $params['VendorCmb'];
        $modcmb = $params['modcmb'];
        $reasoncmb = $params['reasoncmb'];
        $StatusCmb = $params['StatusCmb'];
        $CertificateCmb = $params['CertificateCmb'];
        $contact_category = $params['contact_category'];
        $displimitarray = $params['display']['limitarray'];
        $displimitarray = $params['display']['limitarray'];
        $displayurl = $params['display']['displayurl'];
        $pagesize = $params['display']['pagesize'];
        $tablename = $params['tablename'];
        $position = $params['position'];
        $diplayPaging = $params['dispPaging'];
        $TagCmb = $params['TagCmb'];


        if (!empty($filterarray)) {
            $strfilerbox = '';
            $selected = ($filterby == '') ? 'selected' : '';
            $strfilerbox .= "<option value=\"0\" $selected>-- Show all --</option>";
            foreach ($filterarray as $key => $value) {
                $selected = ($key == $filterby) ? 'selected' : '';
                $strfilerbox.= "<option value=\"$key\" $selected>$value</option>";
            }

            $filterCmb = "<div class=\"new-search-show-all\"><select name=\"filterby$position\" id=\"filterby$position\" style=\"width:auto;\" class=\"more-textarea\" onchange=\"SendGridBindRequest('$filterurl','gridbody','$filterPosition') \"> $strfilerbox  </select> </div>";
        }

        if (!empty($filterbystatusarray)) {
            $strfilerbox = '';
            $selected = ($filterby_sattus == '') ? 'selected' : '';
            $strfilerbox .= "<option value=\"0\" $selected>Select Status</option>";
            foreach ($filterbystatusarray as $key => $value) {
                $selected = ($key == $filterby_sattus) ? 'selected' : '';
                $strfilerbox.= "<option value=\"$key\" $selected>$value</option>";
            }

            $filterCmb .= "<div class=\"new-search-show-all\">$Position_sattus <select name=\"filterbystatus\" id=\"filterbystatus\" style=\"width:auto;\" class=\"more-textarea\" onchange=\"SendGridBindRequest('$filterurl_sattus','gridbody','$filterPosition_sattus') \"> $strfilerbox  </select> </div>";
        }



        if (!empty($params['typecmb'])) {
            $typecmb = $params['typecmb'];
        } else {
            $typecmb = '';
        }

        if (!empty($params['modcmb'])) {
            $modcmb = $params['modcmb'];
        } else {
            $modcmb = '';
        }


        if (!empty($params['actioncmb'])) {
            $actioncmb = $params['actioncmb'];
        } else {
            $actioncmb = '';
        }
        if (!empty($params['modulescombo'])) {
            $modulescombo = $params['modulescombo'];
        } else {
            $modulescombo = '';
        }


        if ($params['display']) {
            $dispStr = '';

            if (!empty($displimitarray)) {
                foreach ($displimitarray as $key => $value) {
                    $selected = ($value == $pagesize) ? 'selected' : '';
                    $dispStr.= "<option  value=\"$value\" $selected>Display - $value</option>";
                }
            } else {
                $dispStr = "<option value=\"20\">Display - 20</option><option value=\"30\">Display - 30</option><option value=\"40\">Display - 40</option><option value=\"50\">Display - 50</option>";
            }

            if ($_REQUEST['rid'] != '') {
                $dispCmbStr = "<div class=\"new-search-show-all\"><select style=\"width: 110px;\" id=\"cmbdisplay$position\" name=\"cmbdisplay$position\" onchange=\"SendGridBindRequest('$displayurl','gridbody','new_PS$position')\" class=\"more-textarea\"> $dispStr </select></div>";
            } else {
                $dispCmbStr = "<div class=\"new-search-show-all\"><select style=\"width: 110px;\" id=\"cmbdisplay$position\" name=\"cmbdisplay$position\" onchange=\"SendGridBindRequest('$displayurl','gridbody','PS$position')\" class=\"more-textarea\"> $dispStr </select></div>";
            }
        }

        $tdfirstpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/>";
        $tdprevpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" />";
        $tdnextpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/>";
        $tdlastpage = "<img src=\"" . ADMIN_MEDIA_URL . "images/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/>";
//
        if ($pagenumber > 1) {
            $page = $pagenumber - 1;
            $tdfirstpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=1','gridbody','P')\">
            <img src=\"" . ADMIN_MEDIA_URL . "images/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/></a>";
            $tdprevpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\">
            <img src=\"" . ADMIN_MEDIA_URL . "images/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" /></a>";
        }

        if ($pagenumber < $numofpages) {
            $page = $pagenumber + 1;
            $tdnextpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\" ><img src=\"" . ADMIN_MEDIA_URL . "images/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/></a>";
            $tdlastpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$numofpages','gridbody','P')\" ><img src=\"" . ADMIN_MEDIA_URL . "images/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/></a>";
        }
//
        $start = ($pagenumber - 1) * $pagesize;

        if ($numofrows == '0') {
            $starting_no = $start;
        } else {
            $starting_no = $start + 1;
        }

        if (($numofrows - $start) < $pagesize) {
            $end_count = $numofrows;
        } elseif (($numofrows - $start) >= $pagesize) {
            $end_count = $start + $pagesize;
        }
//

        $tablename = $params['tablename'];
        if ($params['filter']) {
            if (isset($params['filter']['filterarray']['chr_read-Y'])) {
                $filters = "<div class=\"new-search-show-all\"><select id=\"cmbmoreaction$position\" name=\"cmbmoreaction$position\" onchange=\"updatereadstar('communication','updateread','cmbmoreaction$position','$tablename','chkgrow')\" class=\"more-textarea\"><option value=\"0\">More Action</option> <option value=\"r\">Mark as read</option><option value=\"ur\">Mark as unread</option></select></div>";
            }
        }

        $pagingStr = "";

        if ($diplayPaging != 'no') {
            $pagingStr = "<div class=\"pagination-main1\"style=\"\">
				<div class=\"page-next-icon2\">$tdfirstpage</div>
				<div class=\"page-next-icon2\">$tdprevpage</div>
				<div class=\"new-search-pagination-text3\">$starting_no - $end_count of $numofrows</div>
				<div class=\"page-next-icon2\">$tdnextpage</div>
				<div class=\"page-next-icon2\">$tdlastpage</div>
			</div>";
        }
        if ($position == "top") {
            $autosearch = "<input type=\"hidden\" name=\"autosearchurl\" id=\"autosearchurl\" value=\"" . $AutoSearchUrl . "&ajax=Y\" />";
        }
        if ($starting_no > 0) {
            if ($position == "top" && MODULE_ID == 11 && ADMIN_ID == 1) {
                $delete_all = "<div class=\" delete-button-class fl\" style=\"margin-left:10px\">
                           <a onmouseover=\"MM_swapImage('Image471','','" . ADMIN_MEDIA_URL . "images/Delete-All.png',0)\" onmouseout=\"MM_swapImgRestore()\" href=\"javascript:\"> 
                           <img src=\"" . ADMIN_MEDIA_URL . "images/Delete-All.png \" alt=\"Delete all\" name=\"Image471\" border=\"0\" id=\"Image471\" onclick=\"return verify1();\" ></div>
                           </a>";
            }
        }
        if ($starting_no > 0) {
            if ($position == "top" && MODULE_ID == 10 && ADMIN_ID == 1) {
                $delete_all = "<div class=\"delete-button-class fl\" style=\"margin-left:10px\">
                            <a onmouseover=\"MM_swapImage('Image471','','" . ADMIN_MEDIA_URL . "images/clear-all-hr.png',0)\" onmouseout=\"MM_swapImgRestore()\" href=\"javascript:\">
                                <img src=\"" . ADMIN_MEDIA_URL . "images/clear-all.png \" alt=\"Delete all\" name=\"Image471\" border=\"0\" id=\"Image471\" onclick=\"return verify1();\" />
                            </a>;
                                      
                      
                            </div>";
            }
        }
        return "<div class=\"panel-heading\" style=\"padding-left:15px; padding-top:10px\">
        
                                $pagingStr
                                <div>
                                {$dispCmbStr}{$autosearch}{$typecmb}{$modcmb}{$month_search}{$occasion_search}{$form_categorycombo}{$activity_combo}{$actioncmb}{$filters}{$modulescombo}{$rentalcombo}{$amenitiescatcmb}{$Countrycmb}{$sccombo}{$pubcombo}{$post_category}{$post_university_combo}{$spam_count}{$select_date}{$status_combo}{$banner_type}{$filter_pages}{$positioncmb} {$categorycmb} {$pagescmb} {$VendorCmb} {$reasoncmb} {$StatusCmb} {$CertificateCmb}{$contact_category}{$TagCmb}{$BannerTypeCmb}
                                    
                                        
                                <div class=\"new-search-refresh-text\"><a href=\"$pagename\">Refresh</a></div>
                                     $delete_all
                                </div><br />
                </div>";
    }

    function set_display_order_sequence($tablename, $whereCond = "") {
        $sql = 'select int_glcode from ' . $tablename . ' where chr_delete = "N" ' . $whereCond . ' order by int_displayorder asc';
        $query = $this->ci->db->query($sql);
        $total = $query->num_rows();
        $i = 0;
        if ($total > 0) {
            foreach ($query->result() as $row) {
                $i++;
                $ids[$i] = $row->int_glcode;
                $update_syntax .= " WHEN " . $row->int_glcode . " THEN $i ";
            }
        }
        if ($total > 0) {
            $sql = "UPDATE " . $tablename . " SET int_displayorder = (CASE int_glcode " . $update_syntax . " END) WHERE int_glcode BETWEEN " . min($ids) . " AND " . max($ids) . " and chr_delete = 'N' $whereCond";
//            echo $sql;exit;
            $this->ci->db->query($sql);
        }
    }

    function updatedisplay_order($tablename, $intdisplay, $whereClause = "") {
        $tablename = DB_PREFIX . $tablename;
        $updateSql = "UPDATE " . $tablename . " SET int_displayorder=int_displayorder + 1 WHERE int_displayorder >= " . $intdisplay . " and chr_delete = 'N' $whereClause";
        $this->ci->db->query($updateSql);
    }

    function update_display_order($ids, $values, $oldvalues, $flag = '', $table, $whereClause = "") {
        $tablename = "" . DB_PREFIX . $table;

        for ($i = 0; $i < count($ids); $i++) {
// Updation Of the Display Order
            if ($values[$i] != $oldvalues[$i]) {

                $query = $this->ci->db->query("SELECT count(1) as total FROM " . $tablename . " WHERE int_displayorder=" . $values[$i] . " and chr_delete = 'N' $whereClause");
                $rs = $query->row();

                if ($rs->total > 0) {
                    if ($values[$i] > $oldvalues[$i]) {
                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder - 1 WHERE int_displayorder > " . $oldvalues[$i] . " and  int_displayorder <= " . $values[$i] . " and chr_delete = 'N' $whereClause";
                        $this->ci->db->query($updateSql);
                    } else {

                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder + 1 WHERE int_displayorder >= " . $values[$i] . " and  int_displayorder < " . $oldvalues[$i] . " and chr_delete = 'N' $whereClause";
                        $this->ci->db->query($updateSql);
                    }
                }

                $updateSql = "UPDATE $tablename SET int_displayorder=$values[$i] WHERE int_glcode=" . $ids[$i] . " and chr_delete = 'N' $whereClause";
                $this->ci->db->query($updateSql);
            }
// End of updation of Display Order
        }
// End of updation of Display Order
    }

    function update_display_order1($uid, $neworder, $oldorder, $flag = '', $table, $whereClause = "") {
// echo $whereClause;exit;
        $tablename = "" . DB_PREFIX . $table;
        $query3 = $this->ci->db->query("SELECT count(int_glcode) as total FROM " . $tablename . " WHERE  chr_delete = 'N' $whereClause");
        $rs3 = $query3->row();
        $query = $this->ci->db->query("SELECT int_glcode  FROM " . $tablename . " WHERE int_glcode=" . $uid . " AND int_displayorder=" . $oldorder . " AND chr_delete = 'N' $whereClause");
        $rs = $query->row();
        $query2 = $this->ci->db->query("SELECT int_glcode  FROM " . $tablename . " WHERE int_displayorder=" . $neworder . " AND chr_delete = 'N' $whereClause");
        $rs2 = $query2->row();
        if ($neworder == 0) {
            $neworder = 1;
        }
        if ($neworder > $rs3->total) {
            $neworder = $rs3->total;
        }
        if (!empty($rs->int_glcode)) {
            $updateSql = "UPDATE $tablename SET int_displayorder=$neworder WHERE int_glcode=" . $uid . " and chr_delete = 'N' $whereClause";
            echo $updateSql . '</br>';
            $this->ci->db->query($updateSql);
        }
        if (!empty($rs2->int_glcode)) {
            $updateSql2 = "UPDATE $tablename SET int_displayorder=$oldorder WHERE int_glcode=" . $rs2->int_glcode . " and chr_delete = 'N' $whereClause";
            echo $updateSql2 . '</br>';
            $this->ci->db->query($updateSql2);
        }
//                    if ($values[$i] > $oldvalues[$i]) {
//                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder - 1 WHERE int_displayorder > " . $oldvalues[$i] . " and  int_displayorder <= " . $values[$i] . " and chr_delete = 'N' $whereClause";
//                        $this->ci->db->query($updateSql);
//                    } else {
//
//                        $updateSql = "UPDATE $tablename SET int_displayorder=int_displayorder + 1 WHERE int_displayorder >= " . $values[$i] . " and  int_displayorder < " . $oldvalues[$i] . " and chr_delete = 'N' $whereClause";
//                        $this->ci->db->query($updateSql);
//                    }
//}
//                $updateSql = "UPDATE $tablename SET int_displayorder=$values[$i] WHERE int_glcode=" . $ids[$i] . " and chr_delete = 'N' $whereClause";
//                $this->ci->db->query($updateSql);
    }

    function generate_image($filefield, $path = '', $idss) {
        $max_file_size = MAX_FILE_SIZE;
        $sess = time();
        $des_file_photo = basename($_FILES[$filefield]['name']);
        $des_file_photo = str_replace('&nbsp;', '-', $des_file_photo);
        $des_file_photo = str_replace(' ', '-', $des_file_photo);
        $des_file_photo = str_replace('#', '-', $des_file_photo);
        $des_file_photo = str_replace('%', '-', $des_file_photo);
        $des_file_photo = str_replace("'", '-', $des_file_photo);
        $pieces = explode(".", $des_file_photo);
        $lastitem = end($pieces);

        unset($pieces[count($pieces) - 1]);
        $pieces = implode(".", $pieces);

        if (!empty($idss)) {
            if (!empty($_REQUEST['hidvar_image'])) {
                $des_file_photo = $_REQUEST['hidvar_image'];
            } else {
                $des_file_photo = $idss . '-' . $_REQUEST['gi'] . '.' . $lastitem;
            }
        } else {
            $des_file_photo = $pieces . $sess . uniqid() . '.' . $lastitem;
        }
//        echo $des_file_photo; die;
//echo $sess.'.'.$lastitem = end($pieces);
// $des_file_photo = $des_file_photo . $sess;
//die();
        if ($path == '') {
            $uploaddir = $this->configObj->currentModulePath . 'html/uploads/images/';
        } else {
            $uploaddir = $path;
        }
        $source_file = basename($_FILES[$filefield]['name']);
        $file = $uploaddir . $des_file_photo;
        $uploadedfile = $_FILES[$filefield]['tmp_name'];
        $image_info = getimagesize($uploadedfile);
        $imageextension = $image_info['mime'];
//        print_r($image_info);exit;
        $file_size_MB = number_format($_FILES[$filefield]['size'] / pow(1920, 2)); // file size in MB
//       echo $size;
//        echo  $file_size_MB; 
        if ($size < $file_size_MB) {
//            if ($imageextension == "image/pjpeg" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
//                
//                $src = imagecreatefromjpeg($uploadedfile);
            if ($imageextension == "image/pjpeg" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
                $src = imagecreatefromjpeg($uploadedfile);
            } else if ($imageextension == "image/gif" || $imageextension == "image/GIF") {
                $src = imagecreatefromgif($uploadedfile);
            } else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                $src = imagecreatefromwbmp($uploadedfile);
            } else if ($imageextension == "image/x-ms-bmp") {
                $src = $this->imagecreatefrombmp($uploadedfile);
            } else if ($imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/png" || $imageextension == "image/x-png") {
                $src = imagecreatefrompng($uploadedfile);
            }
            list($width, $height) = getimagesize($uploadedfile);
            if ($width >= height && $width >= 1920) {
                $newwidth = 1920;
                $newheight = intval(($newwidth * $height) / $width);
            } else if ($height >= width && $height >= 450) {
                $newheight = 450;
                $newwidth = intval(($newheight * $width) / $height);
            } else {
                $newwidth = $width;
                $newheight = $height;
            }
            $tmp = imagecreatetruecolor($newwidth, $newheight);

            if ($image_info['mime'] == "image/gif" || $image_info['mime'] == "image/png") {
                imagecolortransparent($tmp, imagecolorallocatealpha($tmp, 255, 0, 0, 127));
                imagealphablending($tmp, false);
                imagesavealpha($tmp, true);
            }
            imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
// preserve transparency
            if ($imageextension == "image/gif" || $imageextension == "image/GIF" || $imageextension == "image/png" || $imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/x-png") {
                $background_color = imagecolorallocate($tmp, 255, 255, 255);
                imagefill($tmp, 0, 0, $background_color);
            }
            imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
            if ($imageextension == "image/pjpeg" || $imageextension == "image/x-ms-bmp" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
                imagejpeg($tmp, $file, 100);
            } else if ($imageextension == "image/gif" || $imageextension == "image/GIF") {
                imagegif($tmp, $file);
            } else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                imagewbmp($tmp, $file);
            }
//            else if($imageextension == "image/x-ms-bmp")
//            {
//                imagewbmp($tmp,$file);
//            }
            else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                imagewbmp($tmp, $file);
            } else if ($imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/png" || $imageextension == "image/x-png") {
                imagepng($tmp, $file);
            }
            imagedestroy($src);
            imagedestroy($tmp);
// NOTE: PHP will clean up the temp file it created when the request  // has completed.
        } else {
            $img_upload = move_uploaded_file($_FILES[$filefield]['tmp_name'], $file);
        }
        return $des_file_photo;
    }

    function generate_image_webservice($filefield, $path = '', $filename) {
        $max_file_size = MAX_FILE_SIZE;
        $sess = time();
        $des_file_photo = basename($_FILES[$filefield]['name']);
        $des_file_photo = str_replace('&nbsp;', '-', $des_file_photo);
        $des_file_photo = str_replace(' ', '-', $des_file_photo);
        $des_file_photo = str_replace('#', '-', $des_file_photo);
        $des_file_photo = str_replace('%', '-', $des_file_photo);
        $des_file_photo = str_replace("'", '-', $des_file_photo);
        $pieces = explode(".", $des_file_photo);
        $lastitem = end($pieces);

        unset($pieces[count($pieces) - 1]);
        $pieces = implode(".", $pieces);

//        if (!empty($idss)) {
//            $piecesss = rand(1,4);
//            $des_file_photo = $idss . '-' . $piecesss . '.' . $lastitem;
//        } else {
        $des_file_photo = $filename;
//        }
//echo $des_file_photo; die;
//echo $sess.'.'.$lastitem = end($pieces);
// $des_file_photo = $des_file_photo . $sess;
//die();
        if ($path == '') {
            $uploaddir = $this->configObj->currentModulePath . 'html/uploads/images/';
        } else {
            $uploaddir = $path;
        }
        $source_file = basename($_FILES[$filefield]['name']);
        $file = $uploaddir . $des_file_photo;
        $uploadedfile = $_FILES[$filefield]['tmp_name'];
        $image_info = getimagesize($uploadedfile);
        $imageextension = $image_info['mime'];
//        print_r($image_info);exit;
        $file_size_MB = number_format($_FILES[$filefield]['size'] / pow(1920, 2)); // file size in MB
//       echo $size;
//        echo  $file_size_MB; 
        if ($size < $file_size_MB) {
//            if ($imageextension == "image/pjpeg" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
//                
//                $src = imagecreatefromjpeg($uploadedfile);
            if ($imageextension == "image/pjpeg" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
                $src = imagecreatefromjpeg($uploadedfile);
            } else if ($imageextension == "image/gif" || $imageextension == "image/GIF") {
                $src = imagecreatefromgif($uploadedfile);
            } else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                $src = imagecreatefromwbmp($uploadedfile);
            } else if ($imageextension == "image/x-ms-bmp") {
                $src = $this->imagecreatefrombmp($uploadedfile);
            } else if ($imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/png" || $imageextension == "image/x-png") {
                $src = imagecreatefrompng($uploadedfile);
            }
            list($width, $height) = getimagesize($uploadedfile);
            if ($width >= height && $width >= 1920) {
                $newwidth = 1920;
                $newheight = intval(($newwidth * $height) / $width);
            } else if ($height >= width && $height >= 450) {
                $newheight = 450;
                $newwidth = intval(($newheight * $width) / $height);
            } else {
                $newwidth = $width;
                $newheight = $height;
            }
            $tmp = imagecreatetruecolor($newwidth, $newheight);

            if ($image_info['mime'] == "image/gif" || $image_info['mime'] == "image/png") {
                imagecolortransparent($tmp, imagecolorallocatealpha($tmp, 255, 0, 0, 127));
                imagealphablending($tmp, false);
                imagesavealpha($tmp, true);
            }
            imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
// preserve transparency
            if ($imageextension == "image/gif" || $imageextension == "image/GIF" || $imageextension == "image/png" || $imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/x-png") {
                $background_color = imagecolorallocate($tmp, 255, 255, 255);
                imagefill($tmp, 0, 0, $background_color);
            }
            imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
            if ($imageextension == "image/pjpeg" || $imageextension == "image/x-ms-bmp" || $imageextension == "image/jpeg" || $imageextension == "image/jpeg" || $imageextension == "image/JPG" || $imageextension == "image/jpg") {
                imagejpeg($tmp, $file, 100);
            } else if ($imageextension == "image/gif" || $imageextension == "image/GIF") {
                imagegif($tmp, $file);
            } else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                imagewbmp($tmp, $file);
            }
//            else if($imageextension == "image/x-ms-bmp")
//            {
//                imagewbmp($tmp,$file);
//            }
            else if ($imageextension == "image/bmp" || $imageextension == "image/BMP") {
                imagewbmp($tmp, $file);
            } else if ($imageextension == "image/X-PNG" || $imageextension == "image/PNG" || $imageextension == "image/png" || $imageextension == "image/x-png") {
                imagepng($tmp, $file);
            }
            imagedestroy($src);
            imagedestroy($tmp);
// NOTE: PHP will clean up the temp file it created when the request  // has completed.
        } else {
            $img_upload = move_uploaded_file($_FILES[$filefield]['tmp_name'], $file);
        }
        return $des_file_photo;
    }

    function generate_valid_thumb($thumb_array) {
        $source_filename = $thumb_array['sourcefilename'];
        $thumb_x = $thumb_array['thumb_x'];
        $square = $thumb_array['square'];
        $border = $thumb_array['border'];
        $cache_output = $thumb_array['cache_output'];
        $watermark = $thumb_array['watermark'];
        $watermark_text = $thumb_array['watermark_text'];
        $req_width = $thumb_array['req_width'];
        $req_height = $thumb_array['req_height'];
        $keepfixed = $thumb_array['$keepfixed'];
        $image_info = getimagesize($source_filename);
        $image_width = $image_info[0];
        $image_height = $image_info[1];
        if ($req_width != '' || $req_height != '') {
            $img_create = 'ImageCreateFromJPEG';
            switch ($image_info['mime']) {
                case 'image/gif':
                    $img_create = 'ImageCreateFromGIF';
                    break;
                case 'image/jpeg':
                    $img_create = 'ImageCreateFromJPEG';
                    break;
                case 'image/png':
                    $img_create = 'ImageCreateFromPNG';
                    break;
                case 'image/bmp':
                    $img_create = 'ImageCreateFromBMP';
                    break;
            }
            if (($image_width >= $req_width ) && ($image_height >= $req_height)) {
                $pref_height = intval(($req_width / $image_width) * $image_height);
                $pref_width = intval(($req_height / $image_height) * $image_width);
                if ($pref_height >= $req_height) {
                    $size = $req_width . "*" . $pref_height;
//                    $shtWidth=$req_width;
//                    $shtHeight=$pref_height;
                    $shtWidth = $pref_width;
                    $shtHeight = $req_height;
                } else if ($pref_width >= $req_width) {
                    $size = $pref_width . "*" . $req_height;
//                    $shtWidth=$pref_width;
//                    $shtHeight=$req_height;
                    $shtWidth = $req_width;
                    $shtHeight = $pref_height;
//$returnmsg= 'true';
                }
                if (($shtWidth >= $req_width ) && ($shtHeight >= $req_height)) {
                    $returnmsg = 'true';
                } else {
                    $returnmsg = 'false';
                }
            } else if (($image_width >= $req_width ) && ($image_height < $req_height)) {
                $pref_height = intval(($req_width * $image_height) / $image_width);
                $size = $pref_width . "*" . $req_height;
                $shtWidth = $req_width;
                $shtHeight = $pref_height;
                $returnmsg = 'false';
            } else if (($image_height >= $req_height ) && ($image_width < $req_width)) {
                $pref_width = intval(($req_height * $image_width) / $image_height);
                $size = $pref_width . "*" . $req_height;
                $shtWidth = $pref_width;
                $shtHeight = $req_height;
                $returnmsg = 'false';
            } else {
                $shtWidth = $image_width;
                $shtHeight = $image_height;
                $returnmsg = 'false';
            }
            $start_x = 0;
            $start_y = 0;
            $thumb_input = @$img_create($source_filename);
            if (!$thumb_input) /* See if it failed */ {
                $thumb_input = imagecreate($thumb_x, $thumb_y); /* Create a blank image */
                $white_color = imagecolorallocate($thumb_input, 255, 255, 255);
                $black_color = imagecolorallocate($thumb_input, 0, 0, 0);
                imagefilledrectangle($thumb_input, 0, 0, 150, 30, $white_color);
                imagestring($thumb_input, 1, 5, 5, 'Error loading ' . $source_filename, $black_color); /* Output an errmsg */
                imagejpeg($thumb_input, '', 100);
                imagedestroy($thumb_input);
            } else {
                $thumb_output = $this->image_create_function($shtWidth, $shtHeight);
                $border_x = $thumb_x - 1;
                $border_y = $thumb_y - 1;
                $background_color = imagecolorallocate($thumb_output, 255, 255, 255);
                imagefill($thumb_output, 0, 0, $background_color);
                $this->image_copy_function($thumb_output, $thumb_input, $start_x, $start_y, 0, 0, $shtWidth, $shtHeight, $image_width, $image_height);
                if ($border) {
                    $border_color = imagecolorallocate($thumb_output, 0, 0, 0);
                    imagerectangle($thumb_output, 0, 0, $border_x, $border_y, $border_color);
                }
                if ($watermark) {
// Get identifier for white
                    $white = imagecolorallocate($thumb_output, 255, 255, 255);
// Add text to image
                    imagestring($thumb_output, 20, 5, $thumb_y - 20, $watermark_text, $white);
                }
                touch($cache_output);
                imagejpeg($thumb_output, $cache_output, 100);
                imagedestroy($thumb_output);
            }
        }
        return $returnmsg;
    }

    function create_image($thumb_width, $thumb_height, $prefix, $large_width, $large_height, $uploadedfile, $filefield = 'Filedata', $thumbdir) {
        $sess = time();
        $tmp = $_FILES[$filefield]['tmp_name'];
        $image_info = getimagesize($uploadedfile);
        switch ($image_info['mime']) {
            case 'image/gif':
                $img_create = 'ImageCreateFromGIF';
                break;
            case 'image/jpeg':
                $img_create = 'ImageCreateFromJPEG';
                break;
            case 'image/png':
                $img_create = 'ImageCreateFromPNG';
                break;
            case 'image/bmp':
                $img_create = 'ImageCreateFromBMP';
                break;
        }
        $src = @$img_create($uploadedfile);
        list($width, $height) = getimagesize($uploadedfile);
        $newwidth = $width;
        $newheight = $height;
        $tmp = imagecreatetruecolor($newwidth, $newheight);
// preserve transparency
        if ($image_info['mime'] == "image/gif" || $image_info['mime'] == "image/png") {
            imagecolortransparent($tmp, imagecolorallocatealpha($tmp, 255, 0, 0, 127));
            imagealphablending($tmp, false);
            imagesavealpha($tmp, true);
        }
        imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
        $file = $uploadedfile;
//imagejpeg($tmp,$file,90);
        switch ($image_info['mime']) {
            case 'image/bmp':
                imagewbmp($tmp, $file);
                break;
            case 'image/gif':
                imagegif($tmp, $file);
                break;
            case 'image/jpg':
                imagejpeg($tmp, $file);
                break;
            case 'image/jpeg':
                imagejpeg($tmp, $file);
                break;
            case 'image/png':
                imagepng($tmp, $file);
                break;
        }
        imagejpeg($tmp, $file, 100);
        imagedestroy($src);
        imagedestroy($tmp);
        $source1 = $uploadedfile;
        $file_photo = basename($source1);
        $thumbfilename = $prefix . $sess . $file_photo;
        $uploaddir = dirname($source1);
        $target1 = $thumbdir . '/' . $prefix . $file_photo;
        $img_name = $file_photo;
        $thumb_array1 = array(
            'sourcefilename' => $source1,
            'thumb_x' => $thumb_width,
            'square' => false,
            'border' => false,
            'cache_output' => $target1,
            'watermark' => false,
            'watermark_text' => null,
            'req_width' => $large_width,
            'req_height' => $large_height,
            '$keepfixed' => null
        );
// echo "<pre>";
// print_r($thumb_array1);exit;
        if ($large_width > 0) {
            $returnthumbmsg1 = $this->generate_valid_thumb($thumb_array1);
        }
        if ($returnthumbmsg1 == 'false' || $returnthumbmsg2 == 'false') {
            return 'false';
        } else {
            return $img_name;
        }
//chmod($uploaddir.$imagename,0777);
    }

    function GetAutoSearch($sqlAutoComplete) {
        $jsonStr = "";
        $jsonStr .= '[';


//        $result = mysql_query($sqlAutoComplete);
        $rs = $sqlAutoComplete->num_rows();
//        $rs = mysql_num_rows($result);
        if ($rs) {
//            $results = mysql_query(trim($sqlAutoComplete));

            foreach ($sqlAutoComplete->result_array() as $row) {

//echo $row['autoval'];
//            while ($row = mysql_fetch_array($results)) {
                if (!empty($row['autoval'])) {
// $finalsearch=htmlspecialchars_decode($row['AutoVal'], ENT_QUOTES);
//$jsonStr .= '{"id": "'.$finalsearch.'", "value": "'.$finalsearch.'", "label": "'.$finalsearch.'"}, ';
// $row['AutoVal'] = htmlspecialchars_decode($row['AutoVal'], ENT_QUOTES);
//  $jsonStr .= '{"id": "' . $row['AutoVal'] . '", "value": "' . $row['AutoVal'] . '", "label": "' . $row['AutoVal'] . '"}, ';
                    $finalsearch = htmlspecialchars_decode($row['autoval'], ENT_QUOTES);
                    $jsonStr .= '{"id": "' . str_replace('"', '\"', $finalsearch) . '", "value": "' . str_replace('"', '\"', $finalsearch) . '", "label": "' . str_replace('"', '\"', $finalsearch) . '"}, ';
                }
            }
            $jsonStr = substr($jsonStr, 0, -1);
        } else {
            $jsonStr .= '{"id": "", "value": "", "label": "No Record Found"}';
        }
// remove last character , if exists
        if (substr($jsonStr, -1) == ',') {
            $jsonStr = substr($jsonStr, 0, -1);
        }
        $jsonStr .= ']';
        echo htmlspecialchars_decode($jsonStr, ENT_QUOTES);
//        echo $jsonStr;
//echo  html_entity_decode($jsonStr);
        exit;
    }

//    function show_pin_image($full_pin, $generated_pin, $image_url = '', $in_powerpanel = 'N') {
//        include_once "DayyanConfirmImageClass.php";
//        $DayyanConfirmImage = null;
//        $DayyanConfirmImage = new DayyanConfirmImage($generated_pin, $full_pin, $image_url);
////        echo CAPTCHA_IMAGE_PATH; exit;
//        $DayyanConfirmImage->imagepath = CAPTCHA_IMAGE_PATH;
//        $output_img = $DayyanConfirmImage->ShowImage();
//        return $output_img;
//    }

    function auto_alias($title) {
//echo html_entity_decode($title);exit;
        $pattern = "/[^a-zA-Z0-9]+/i";
        $alias_generated = preg_replace($pattern, '-', html_entity_decode($title));
        $alias_generated = preg_replace('/-$/', '', $alias_generated);
        $alias = $this->getalias($alias_generated, 'Y');
        return $alias;
    }

    function getalias($alias = '', $return = '') {
        $alias = $alias == '' ? $this->ci->input->get_post('alias') : $alias;
        $flag = 'Y';
        $res = $this->issameAlias($flag, $alias);
        if ($res == 0) {
            $i = 1;
            while ($i <= 100) {
                $ralias = $alias . "-" . $i;
                $res = $this->issameAlias('Y', $ralias);
                if ($res == 1) {
                    break;
                }
                $i++;
            }
            if ($return == 'Y') {
                return $ralias;
            } else {
                echo $ralias;
                die;
            }
        } else {
            if ($return == 'Y') {
                return $alias;
            } else {
                echo $alias;
                die;
            }
        }
    }

    function issameAlias($flag = 'N', $alias = '') {
        $param = array("tables" => array(
                DB_PREFIX . "pages" => "var_alias",
            ),
            "alias" => $alias == '' ? $this->ci->input->get_post("alias", TRUE) : $alias
        );
        if (($this->ci->input->get_post('table')) != '') {
            $param['NRfield'] = $this->ci->input->get_post('mode');
        }
        if (($this->ci->input->get_post('eid')) != '') {
            $param['NRid'] = $this->ci->input->get_post('eid');
        }
        $same = $this->checkAlias($param);
        if ($flag == 'Y') {
            return $same;
        } else {
            echo $same;
            exit();
        }
    }

    function checkAlias($param = array()) {
//print_r($param);exit;
        if (($this->ci->input->get_post('table')) != '') {
            $param['NRtable'] = base64_decode($this->ci->input->get_post('table'));
            if (!empty($param['NRfield'])) {
                $param['NRfield'] = base64_decode($param['NRfield']);
            } else {
                $param['NRfield'] = "int_glcode";
            }
        }
        if (($this->ci->input->get_post('eid')) != '') {
            $param['NRid'] = base64_decode($param['NRid']);
        }
//      echo "<pre>";print_r($_REQUEST);print_r($param);exit;
        if (!empty($param)) {
            foreach ($param['tables'] as $key => $value) {
                if (empty($value)) {
                    if (!empty($param['defaultField'])) {
                        $value = $param['defaultField'];
                    } else {
                        $value = "var_alias";
                    }
                }
                if (!empty($param['NRtable']) && !empty($param['NRid']) && $param['NRtable'] == $key) {
                    $whereCondition = " and not(" . $param['NRfield'] . "=" . $param['NRid'] . ")";
                } else {
                    $whereCondition = "";
                }
                $sql = "select count(*) as counter from " . $key . " where UPPER(" . $value . ")='" . strtoupper($param['alias']) . "'" . $whereCondition;
                $rs = mysql_query($sql);
                if (!empty($rs)) {
                    $result = mysql_fetch_array($rs);
                    if ($result['counter'] > 0) {
// echo $sql;
                        return 0;
                    }
                }
            }
            return 1;
        } else {
            return 0;
        }
    }

    function autoAlias2($tagName) {
        $replace = "-";
        $pattern = "/[^A-Za-z0-9]/";
        $alias = preg_replace($pattern, $replace, strtolower($tagName));
        $i = 1;
        $tempAlias = $alias;
        $param ["tables"] = array("tables" => array(
                DB_PREFIX . "pages" => "var_alias",
            ),
            "alias" => $this->ci->input->get_post('alias'));
        $param ["alias"] = $tempAlias;
//     print_r($param);exit;
        while (1) {
//$param = array("tables" => array(DB_PREFIX . "news" => "var_alias"), "alias" => $_REQUEST['alias']) ;
            $param = array("tables" => array(
                    DB_PREFIX . "pages" => "var_alias",
                ),
                "alias" => $this->ci->input->get_post('alias')
            );
            $param['alias'] = $tempAlias;
            if ($this->checkAlias($param) == 1) {
                break;
            }
            $tempAlias = $alias . $i;
            $i++;
        }
        return $tempAlias;
    }

    function upload_image($filefield, $thumb_width, $thumb_height, $prefix, $thumb_width2, $thumb_height2, $prefix2 = '', $uploaddir = '') {
        $sess = time();
        $file_photo = basename($_FILES[$filefield]['name']);
        $imagename = $sess . $file_photo;
//echo $uploaddir;exit;
        $file_photo = $sess . basename($_FILES[$filefield]['name']);
        $file = $uploaddir . $file_photo;
        $tmp = $_FILES[$filefield]['tmp_name'];
        $uploadedfile = $_FILES[$filefield]['tmp_name'];
// Create an Image from it so we can do the resize
        $image_info = getimagesize($uploadedfile);
        switch ($image_info['mime']) {
            case 'image/gif':
                $img_create = 'ImageCreateFromGIF';
                break;
            case 'image/jpeg':
                $img_create = 'ImageCreateFromJPEG';
                break;
            case 'image/png':
                $img_create = 'ImageCreateFromPNG';
                break;
            case 'image/bmp':
                $img_create = 'ImageCreateFromBMP';
                break;
        }
// $src = imagecreatefromjpeg($uploadedfile);
        $src = @$img_create($uploadedfile);
// Capture the original size of the uploaded image
        list($width, $height) = getimagesize($uploadedfile);
        if ($width >= height && $width >= 1000) {
            $newwidth = 950;
            $newheight = intval(($newwidth * $height) / $width);
        } else if ($height >= width && $height >= 750) {
            $newheight = 700;
            $newwidth = intval(($newheight * $width) / $height);
        } else {
            $newwidth = $width;
            $newheight = $height;
        }
        $tmp = imagecreatetruecolor($newwidth, $newheight);
// this line actually does the image resizing, copying from the original // image into the $tmp image
        imagecopyresampled($tmp, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
// now write the resized image to disk.
        imagejpeg($tmp, $file, 90);
        imagedestroy($src);
        imagedestroy($tmp); // NOTE: PHP will clean up the temp file it created when the request  // has completed.
        $source1 = $uploaddir . $file_photo;
//$sess = time();
        $thumbfilename = $prefix . $sess . $file_photo;
        $target1 = $uploaddir . $prefix . $file_photo;
        $target2 = $uploaddir . $prefix2 . $file_photo;
        $thumbstatus = $this->generate_thumb($source1, $thumb_width, false, false, $target1, false, null, $thumb_width, $thumb_height);
        if ($thumbstatus == 'invalid filesize') {
            $errstatus.=":" . "invalid1";
        }
        if ($thumb_width2 > 0) {
            $thumbstatus = $this->generate_thumb($source1, $thumb_width2, false, false, $target2, false, null, $thumb_width2, $thumb_height2);
            if ($thumbstatus == 'invalid filesize') {
                $errstatus.=":" . "invalid2";
            }
        }
        if ($returnthumbmsg1 == 'INVALID' || $returnthumbmsg2 == 'INVALID') {
            $this->chr_validthumb = 'N';
        } else {
            $this->chr_validthumb = 'Y';
        }
        return $imagename;
    }

    function generate_thumb($source_filename, $thumb_x, $square = false, $border = false, $cache_output = null, $watermark = false, $watermark_text = null, $req_width, $req_height) {
        $image_info = getimagesize($source_filename);
        $image_width = $image_info[0];
        $image_height = $image_info[1];
        if ($req_width != '' || $req_height != '') {
// workaround for v1.6.2 where the GIF images arent recognized.
            $img_create = 'ImageCreateFromJPEG';
//print_r($image_info);exit;
            switch ($image_info['mime']) {
                case 'image/gif':
                    $img_create = 'ImageCreateFromGIF';
                    break;
                case 'image/jpeg':
                    $img_create = 'ImageCreateFromJPEG';
                    break;
                case 'image/png':
                    $img_create = 'ImageCreateFromPNG';
                    break;
                case 'image/bmp':
                    $img_create = 'ImageCreateFromBMP';
                    break;
            }
            if (($image_width >= $req_width ) && ($image_height >= $req_height)) {
                $pref_height = intval(($req_width / $image_width) * $image_height);
                $pref_width = intval(($req_height / $image_height) * $image_width);
                if ($pref_height >= $req_height) {
                    $size = $req_width . "*" . $pref_height;
//                    $shtWidth=$req_width;
//                    $shtHeight=$pref_height;
                    $shtWidth = $pref_width;
                    $shtHeight = $req_height;
                    $returnmsg = 'true';
                } else if ($pref_width >= $req_width) {
                    $size = $pref_width . "*" . $req_height;
//                    $shtWidth=$pref_width;
//                    $shtHeight=$req_height;
                    $shtWidth = $req_width;
                    $shtHeight = $pref_height;
//$returnmsg= 'true';
                    $returnmsg = 'true';
                }
            } else if (($image_width >= $req_width ) && ($image_height < $req_height)) {
                $pref_height = intval(($req_width * $image_height) / $image_width);
                $size = $pref_width . "*" . $req_height;
                $shtWidth = $req_width;
                $shtHeight = $pref_height;
                $returnmsg = 'INVALID';
            } else if (($image_height >= $req_height ) && ($image_width < $req_width)) {
                $pref_width = intval(($req_height * $image_width) / $image_height);
                $size = $pref_width . "*" . $req_height;
                $shtWidth = $pref_width;
                $shtHeight = $req_height;
                $returnmsg = 'INVALID';
            } else {
                $shtWidth = $image_width;
                $shtHeight = $image_height;
                $returnmsg = 'INVALID';
            }
            $start_x = 0;
            $start_y = 0;
            $thumb_input = @$img_create($source_filename);
            if (!$thumb_input) /* See if it failed */ {
                $thumb_input = imagecreate($thumb_x, $thumb_y); /* Create a blank image */
                $white_color = imagecolorallocate($thumb_input, 255, 255, 255);
                $black_color = imagecolorallocate($thumb_input, 0, 0, 0);
                imagefilledrectangle($thumb_input, 0, 0, 150, 30, $white_color);
                imagestring($thumb_input, 1, 5, 5, 'Error loading ' . $source_filename, $black_color); /* Output an errmsg */
                imagejpeg($thumb_input, '', 90);
                imagedestroy($thumb_input);
            } else {
                $thumb_output = $this->image_create_function($shtWidth, $shtHeight);
                $border_x = $thumb_x - 1;
                $border_y = $thumb_y - 1;
                $background_color = imagecolorallocate($thumb_output, 255, 255, 255);
                imagefill($thumb_output, 0, 0, $background_color);
                $this->image_copy_function($thumb_output, $thumb_input, $start_x, $start_y, 0, 0, $shtWidth, $shtHeight, $image_width, $image_height);
                if ($border) {
                    $border_color = imagecolorallocate($thumb_output, 0, 0, 0);
                    imagerectangle($thumb_output, 0, 0, $border_x, $border_y, $border_color);
                }
                if ($watermark) {
// Get identifier for white
                    $white = imagecolorallocate($thumb_output, 255, 255, 255);
// Add text to image
                    imagestring($thumb_output, 20, 5, $thumb_y - 20, $watermark_text, $white);
                }
                touch($cache_output);
                imagejpeg($thumb_output, $cache_output, 90);
                imagedestroy($thumb_output);
            }
        }
        return $returnmsg;
    }

    function image_create_function($x_size, $y_size) {
        $image_create_function = 'ImageCreate';
        if ($this->gd_version() >= 2.0) {
            $image_create_function = 'ImageCreateTrueColor';
        }
        if (!function_exists($image_create_function)) {
            return false;
        }
        return $image_create_function($x_size, $y_size);
    }

    function gd_version() {
        global $code;
        if (empty($result)) {
            if (!function_exists('gd_info')) {
                $gd_info = $this->gd_info_alternate();
            } else {
                $gd_info = gd_info();
            }
            if (substr($gd_info['GD Version'], 0, strlen('bundled (')) == 'bundled (') {
                $result = (float) substr($gd_info['GD Version'], strlen('bundled ('), 3);
            } else {
                $result = (float) substr($gd_info['GD Version'], 0, 3);
            }
        }
        return $result;
    }

    function image_copy_function($dst_im, $src_im, $dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h) {
        $image_copy_function = 'ImageCopyResized';
        if ($this->gd_version() >= 2.0) {
            $image_copy_function = 'ImageCopyResampled';
        }
        if (!function_exists($image_copy_function)) {
            return false;
        }
        return $image_copy_function($dst_im, $src_im, $dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h);
    }

    function file_extension($input_file) {
        $file_array = explode('.', $input_file);
        $nb_array = count($file_array);
        $ext_cnt = $nb_array - 1;
        $extension = ($nb_array <= 1) ? '' : $file_array[$ext_cnt];
        $extension = strtolower($extension);
        $extensions_array = array('gif', 'jpg', 'jpeg', 'png', 'bmp', 'avi', 'mpg', 'mpeg', 'mov', 'wmv', 'pdf', 'doc', 'docx', 'mp3');
        $extension = (!in_array($extension, $extensions_array)) ? 'img' : $extension;
        return $extension;
    }

// set cookie
    function requestSetCookie($cookieName, $cookieValue, $expiry = 0) {
        $value = @serialize($cookieValue);
        if ($value === false) {
            return false;
        }
        $expiry = intval(abs($expiry));
        if ($expiry != 0) {
            $expiry += time();
        }
        return @setcookie($cookieName, base64_encode($value), $expiry, '/');
    }

// set cookie
    function requestRemoveCookie($cookieName) {
        return @setcookie($cookieName, '', time() - 100000, '/');
    }

    function requestGetCookie($cookieName, $devaultValue = '') {
        $value = $devaultValue;
        if (isset($_COOKIE) && array_key_exists($cookieName, $_COOKIE)) {
            $value = @unserialize(base64_decode($_COOKIE[$cookieName]));
        }
        return $value;
    }

    function message($msg = '') {
        (string) $display_output = null;
        if ($msg != "") {
            $display_output .="<div class=\"panel panel-success\"><div class=\"panel-heading\">$msg</div></div>";
        }
        return $display_output;
    }

//    function date_convert($dt_date) {
//        if (DEFAULT_DATEFORMAT == '%d/%m/%Y') {
//            return $date = $this->dtConvertDMYtoYMD($dt_date);
//        }
//        if (DEFAULT_DATEFORMAT == '%m/%d/%Y') {
//            return $date = $this->dtConvertMDYtoYMD($dt_date);
//        }
//        if (DEFAULT_DATEFORMAT == '%Y/%m/%d') {
//            return $date = $this->dtConvertYMDtoYMD($dt_date);
//        }
//        if (DEFAULT_DATEFORMAT == '%Y/%d/%m') {
//            return $date = $this->dtConvertYDMtoYMD($dt_date);
//        }
//    }

    function date_convert($dt_date) {
        if (DEFAULT_DATEFORMAT == '%d %M %Y') {
            return $date = $this->dtConvertDMYtoYMD($dt_date);
        }
        if (DEFAULT_DATEFORMAT == '%M %d %Y') {
            return $date = $this->dtConvertMDYtoYMD($dt_date);
        }
        if (DEFAULT_DATEFORMAT == '%Y %M %d') {
            return $date = $this->dtConvertYMDtoYMD($dt_date);
        }
        if (DEFAULT_DATEFORMAT == '%Y %d %M') {

            return $date = $this->dtConvertYDMtoYMD($dt_date);
        }
    }

    function dtConvertDMYtoYMD($date) {
        if ($date != '' && $date != '00/00/0000') {
            $date = explode("/", $date);
            $day = $date[0];
            $month = $date[1];
            $year = $date[2];
            $ymdarray = array(trim($year), $month, $day);
//            $ymdformat = date('Y-M-d', mktime(0, 0, 0, $month, $day, $year));
            $ymdformat = date('Y-m-d', mktime(0, 0, 0, $month, $day, $year));
        }
        return $ymdformat;
    }

    function dtConvertMDYtoYMD($date) {
        if ($date != '' && $date != '00/00/0000') {
            $date = explode("/", $date);
            $month = $date[0];
            $day = $date[1];
            $year = $date[2];
            $ymdarray = array(trim($year), $month, $day);
//            $ymdformat = date('Y-M-d', mktime(0, 0, 0, $month, $day, $year));
            $ymdformat = date('Y-m-d', mktime(0, 0, 0, $month, $day, $year));
        }
        return $ymdformat;
    }

    function dtConvertYMDtoYMD($date) {
        if ($date != '') {
            $date = explode("/", $date);
            $year = $date[0];
            $month = $date[1];
            $day = $date[2];
            $mdyarray = array($year, $month, $day);
            $mdyformat = implode("-", $mdyarray);
        }
        return $mdyformat;
    }

    function dtConvertYDMtoYMD($date) {
        if ($date != '' && $date != '00/00/0000') {
            $date = explode("/", $date);
            $year = $date[0];
            $day = $date[1];
            $month = $date[2];
            $ymdarray = array(trim($year), $month, $day);
//            $ymdformat = date('Y-M-d', mktime(0, 0, 0, $month, $day, $year));
            $ymdformat = date('Y-m-d', mktime(0, 0, 0, $month, $day, $year));
        }
        return $ymdformat;
    }

    function insertinlogmanager($module, $tablename, $user_id, $lastinsertid, $notification) {

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
        $query = $this->ci->db->insert('logmanager', $data);
        return true;
    }

    function generatePagingPannel_zipbackupdata($params) {
        $pagenumber = $params['paging']['pagenumber'];
        $numofpages = $params['paging']['noofpages'];
        $numofrows = $params['paging']['numofrows'];
        $wholeurl = $params['paging']['wholeurl'];
        $pagingurl = $params['paging']['pagingurl'];
        $pagename = $params['pageurl'];
        $rentalcombo = $params['rentalcombo'];
//        print_r($VendorCmb);
        $filterarray = $params['filter']['filterarray'];
        $filterurl = $params['filter']['filterurl'];
        $filterby = $params['filter']['filterby'];
        $filterPosition = $params['filter']['filterposition'];
        $displimitarray = $params['display']['limitarray'];
        $displayurl = $params['display']['displayurl'];
        $pagesize = $params['display']['pagesize'];
        $tablename = $params['tablename'];
        $position = $params['position'];
        $cat_type = $params['cat_type'];
        $modulescombo = $params['modulescombo'];
        $contractcombo = $params['contractcombo'];
        $logmodulescombo = $params['logmodulescombo'];
        if (!empty($filterarray)) {
            $strfilerbox = '';
            $selected = ($filterby == '') ? 'selected' : '';
            $strfilerbox .= "<option value=\"0\" $selected>-- Show all --</option>";
            foreach ($filterarray as $key => $value) {
                $selected = ($key == $filterby) ? 'selected' : '';
                $strfilerbox.= "<option value=\"$key\" $selected>$value</option>";
            }
            $filterCmb = "<div class=\"new-search-show-all\">
                                <select name=\"filterby$position\" id=\"filterby$position\" style=\"width:auto;\" class=\"more-textarea\" onchange=\"SendGridBindRequest('$filterurl','gridbody','$filterPosition') \">
                $strfilerbox
                                 </select>
                         </div>";
        }
        if ($params['display']) {
            $dispStr = '';
            if (!empty($displimitarray)) {
                foreach ($displimitarray as $key => $value) {
                    $selected = ($value == $pagesize) ? 'selected' : '';
                    $dispStr.= "<option value=\"$value\" $selected>Display - $value</option>";
                }
            } else {
                $dispStr = "<option value=\"20\">Display - 20</option>
                              <option value=\"30\">Display - 30</option>
                              <option value=\"40\">Display - 40</option>
                              <option value=\"50\">Display - 50</option>";
            }
            $dispCmbStr = "<div class=\"new-search-show-all\"><select id=\"cmbdisplay$position\" name=\"cmbdisplay$position\" onchange=\"SendGridBindRequest('$displayurl','gridbody','PS$position')\" class=\"more-textarea\"> $dispStr </select></div>";
        }
        $tdfirstpage = "<img src=\"" . ADMIN_MEDIA_URL . "/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/>";
        $tdprevpage = "<img src=\"" . ADMIN_MEDIA_URL . "/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" />";
        $tdnextpage = "<img src=\"" . ADMIN_MEDIA_URL . "/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/>";
        $tdlastpage = "<img src=\"" . ADMIN_MEDIA_URL . "/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/>";
        if ($pagenumber > 1) {
            $page = $pagenumber - 1;
            $tdfirstpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=1','gridbody','P')\">
           				 <img src=\"" . ADMIN_MEDIA_URL . "/prev-one.jpg\" width=\"19\" height=\"19\" alt=\"First page\" title=\"First page\"/></a>";
            $tdprevpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\">
          				 <img src=\"" . ADMIN_MEDIA_URL . "/prev.jpg\" width=\"19\" height=\"19\" alt=\"Previous Page\" title=\"Previous Page\" /></a>";
        }
        if ($pagenumber < $numofpages) {
            $page = $pagenumber + 1;
            $tdnextpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$page','gridbody','P')\" >
                           <img src=\"" . ADMIN_MEDIA_URL . "/next.jpg\" width=\"19\" height=\"19\" alt=\"Next page\" title=\"Next page\"/></a>";
            $tdlastpage = "<a href=\"javascript:;\" onclick=\"SendGridBindRequest('$pagingurl&pagenumber=$numofpages','gridbody','P')\" >
                           <img src=\"" . ADMIN_MEDIA_URL . "/next-last.jpg\" width=\"19\" height=\"19\" alt=\"Last page\" title=\"Last page\"/></a>";
        }
        $start = ($pagenumber - 1) * $pagesize;
        $starting_no = $start + 1;
        if ($numofrows == 0) {
            $starting_no = '0';
        }
        if (($numofrows - $start) < $pagesize) {
            $end_count = $numofrows;
        } elseif (($numofrows - $start) >= $pagesize) {
            $end_count = $start + $pagesize;
        }
//echo "==".$this->showaction."==";exit;
        if ($this->showaction == 'Y') {
            $dis_no = "style='display:none;'";
        }
        if ($params['filter']) {
            $filters = "
            <div class=\"new-search-show-all\">
                        <select id=\"cmbmoreaction$position\" name=\"cmbmoreaction$position\" onchange=\"updatereadstar('cmbmoreaction$position','$tablename','chkgrow')\" class=\"more-textarea\">
                                  <option value=\"0\">More Action</option>
                                  <option value=\"r\">Mark as read</option>
                                  <option value=\"ur\">Mark as unread</option>
                                  <option value=\"as\">Add Star</option>
                                  <option value=\"rs\">Remove Star</option>
                                  </select>
                        </div>
            ";
        }
        /* ------------------------Don't remove below code it is for paging go to button------------------------------------------- */
        return "<div class=\"blue-bg\" style=\"padding-left:15px; padding-top:10px\"><div class=\"pagination-main1\">
                        <div class=\"page-next-icon2\"></div>
                                  </div>
                        <div class=\"new-search-area2\" $dis_no>
							$filterCmb
							$filters
							$dispCmbStr
							$extraCmbStr
							$modulescombo
                                                            $rentalcombo
                                                              
                                                         $cat_type
							$contractcombo
							$logmodulescombo
                                                        
                            <div class=\"new-search-refresh-text\">
                                  <a href=\"javascript:;\" onclick=\"dbbackup()\">Generate New Backup</a></div>
                          </div>
                        </div>";
    }

    function get_topmenu() {
        $data = "<ul class=\"ddsubmenustyle\">";
        $sql_pdt = "SELECT * FROM " . DB_PREFIX . "racing WHERE chr_delete='N'";
        $rs_pdt = mysql_query($sql_pdt);
        while ($rw_pdt = mysql_fetch_array($rs_pdt)) {
            $innerdata = $this->getSubParams($rw_pdt['fk_product_type'], $rw_pdt['int_glcode']);
            if ($innerdata != '') {
                $url = 'index.php?module=product_detail&action=add&eid=' . $rw_pdt['int_glcode'] . '&producttype=' . $rw_pdt['fk_product_type'] . '&tabid=1';
                $data.='<li><a href="' . $url . '">' . $rw_pdt['var_title'] . '</a>' . $innerdata . '</li> ';
            }
        }
        $data.='</ul>';
    }

    function getParentIdList($parentid) {
        $temp = $parentid;
        $getParentIdList = array();
        while ($temp != 0) {
            $sql = "select fk_pages from " . DB_PREFIX . "pages where int_glcode = " . $temp;
            $result = mysql_query($sql);
            $row = mysql_fetch_array($result);
            if ($row['fk_pages'] != 0) {
                $getParentIdList[] = $row['fk_pages'];
            }
            $temp = $row['fk_pages'];
        }
        return $getParentIdList;
    }

////////////
    function ConvertDateFormatdefault($date) {
        if (DEFAULT_DATEFORMAT == '%d/%m/%Y') {
            if ($date != '' && $date != '0000-00-00') {
                $date = explode("-", $date);
                $year = $date[0];
                $month = $date[1];
                $day = $date[2];
                $defaultformat = date('d/m/Y', mktime(0, 0, 0, $month, $day, $year));
            }
        }
        if (DEFAULT_DATEFORMAT == '%m/%d/%Y') {
            if ($date != '' && $date != '0000-00-00') {
                $date = explode("-", $date);
                $year = $date[0];
                $month = $date[1];
                $day = $date[2];
                $defaultformat = date('m/d/Y', mktime(0, 0, 0, $month, $day, $year));
            }
        }
        if (DEFAULT_DATEFORMAT == '%Y/%m/%d') {
            if ($date != '' && $date != '0000-00-00') {
                $date = explode("-", $date);
                $year = $date[0];
                $month = $date[1];
                $day = $date[2];
                $defaultformat = date('Y/m/d', mktime(0, 0, 0, $month, $day, $year));
            }
        }
        if (DEFAULT_DATEFORMAT == '%Y/%d/%m') {
            if ($date != '' && $date != '0000-00-00') {
                $date = explode("-", $date);
                $year = $date[0];
                $month = $date[1];
                $day = $date[2];
                $defaultformat = date('Y/d/m', mktime(0, 0, 0, $month, $day, $year));
            }
        }
        return $defaultformat;
    }

    function float_price_remove_zero($price) {
        $price_format = number_format($price, 2);
        $explode_price = explode('.', $price_format);
        if ($explode_price[1] == 0) {
            $actual_price = $explode_price[0];
        } else {
            $actual_price = $price_format;
        }
        return $actual_price;
    }

    function getYoutubeThumb($url, $dst_img, $dst_path, $dst_w, $dst_h, $dst_quality) {
        $img_name = str_replace(" ", "_", $dst_img);
        $img_name = $img_name . '.jpg';
        $dst_img = str_replace(" ", "_", $dst_img);
        $dst_img = $dst_img . '.jpg';
        $src_embed = $this->get_youtubevideo($url, $dst_w, $dst_h);
        preg_match('~http://[^/]+/v/([^&/]+)~', $src_embed, $match);
        $youtube_id = $match[1];
        $YouTubeThumbURL = 'http://img.youtube.com/vi/';
        $src_cpl = $YouTubeThumbURL . $youtube_id . '/0.jpg';
        $dst_cpl = $dst_path . "/" . basename($dst_img);
        try {
            if (!$src_cpl) {
                throw new Exception("No such file or directory");
            } else {
                list($src_w, $src_h) = getimagesize($src_cpl);
                $src_img = imagecreatefromjpeg($src_cpl);
// throw new TestException();
            }
        } catch (Exception $e) {
// echo 'Message: ' . $e->getMessage();
        }
//Get heights and width so the image keeps its ratio.
        $x_ratio = $dst_w / $src_w;
        $y_ratio = $dst_h / $src_h;
        if ((($x_ratio > 1) || ($y_ratio > 1)) && ($x_ratio > $y_ratio)) {
//If one of the sizes of the image is smaller than the destination (normal: more height than width).
            $dst_w = ceil($y_ratio * $src_w);
            $dst_h = $dst_h;
        } elseif ((($x_ratio > 1) || ($y_ratio > 1)) && ($y_ratio > $x_ratio)) {
//If one of the sizes of the image is smaller than the destination (landscape: more width than height).
            $dst_w = $dst_w;
            $dst_h = ceil($x_ratio * $src_h);
        } elseif (($x_ratio * $src_h) < $dst_h) {
//if the image is landscape (more width than height).
            $dst_h = ceil($x_ratio * $src_h);
            $dst_w = $dst_w;
        } elseif (($x_ratio * $src_h) > $dst_h) {
//if the image is normal (more height than width).
            $dst_h = ceil($x_ratio * $src_h);
            $dst_w = $dst_w;
        } else {
//if the image is normal (more height than width).
            $dst_w = ceil($y_ratio * $src_w);
            $dst_h = $dst_h;
        }
// Creating the resized image.
        $dst_img = imagecreatetruecolor($dst_w, $dst_h);
        imagecopyresampled($dst_img, $src_img, 0, 0, 0, 0, $dst_w, $dst_h, $src_w, $src_h);
// Saving the resized image.
        imagejpeg($dst_img, $dst_cpl, $dst_quality);
// Cleaning the memory.
        imagedestroy($src_img);
        imagedestroy($dst_img);
        return $img_name;
    }

    function check_youtube_validurl($url) {
        preg_match("/v=([^&]+)/i", $url, $matches);
        $id = $matches[1];
        if ($id == '') {
            return '1';
        } else {
            $headers = get_headers('http://gdata.youtube.com/feeds/api/videos/' . $id);
            if (!strpos($headers[0], '200')) {
                return '1';
            }
            $myFile = "http://gdata.youtube.com/feeds/api/videos/" . $id;
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $myFile);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $content = curl_exec($ch);
            curl_close($ch);
            if ($content == 'Invalid id') {
                return '1';
            } else {
                return '0';
            }
        }
    }

    function get_youtubevideo($url, $height, $width) {
        preg_match("/v=([^&]+)/i", $url, $matches);
        $id = $matches[1];
        $YouTubeVideoURL = 'http://www.youtube.com/v/';
        $code = '<object width="' . $width . '" height="' . $height . '">';
        $code .= '<param name="movie" value="' . $YouTubeVideoURL . '{id}&hl=en_US&fs=1&" ></param>';
        $code .='<param name="allowFullScreen" value="true" ></param>';
        $code .='<param name="allowscriptaccess" value="always"></param>';
        $code .='<embed src="' . $YouTubeVideoURL . '{id}&hl=en_US&fs=1&" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="' . $width . '" height="' . $height . '">';
        $code .='</embed></object>';
        $code = str_replace('{id}', $id, $code);
        return $code;
    }

    /**
     *    HTML to PDF Function
     *
     *    Convert html to pdf
     *
     *    @param string $html HTML to be converted
     *    @param string $name name of PDF
     *    @param string $type
     *    @param string $author
     *    @param string $subject
     *    @param string $savePath     
     *    @return void
     */
    function gen_pdf($html, $name, $type = 'P', $author = '', $subject = '', $savePath = '', $pagetype = 'P') {
        $this->ci->load->library('MYPDF');
        $pdf = new MYPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor($author);
        $pdf->SetSubject($subject);
        $pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);
// set header and footer fonts
        $pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
        $pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
// set default monospaced font
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
//set margins
        $pdf->SetMargins(10, PDF_MARGIN_TOP, 10);
        $pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
        $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
//set auto page breaks
        $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
//set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
//set some language-dependent strings
        $pdf->setLanguageArray($l);
// set font
        $pdf->SetFont('helvetica', '', 7);
        if ($pagetype == 'P') {
            $pdf->AddPage('P', 'A4');
        } else if ($pagetype == 'L') {
            $pdf->AddPage('L');
        }
        $pdf->setCellPaddings(0, 0, 0, 0);
        $pdf->writeHTML($html, true, 0, true, 0);
        if ($type == 'P') {
            $pdf->Output($name, 'I');
        } else if ($type == 'S') {
            $pdf->Output($name, 'D', $savePath);
        } else {
            $pdf->Output($name, 'D');
        }
        exit;
    }

    /**
     *    Text to image Function
     *
     *    Convert text to a image
     *
     *    @param string $text Text to be converted
     *    @param string $configArray Optional configuration array allows you to set: 'background-color', 'color', 'font-size', 'font-file', 'params'
     *    @param string $filepath Directory where generated images are stored
     *    @return void
     */
    function text2image($text, $configArray = array(), $filepath) {
        $text = trim($text);
        if (trim($text) == "")
            return "";
        $conf = array();
        $conf['color'] = isset($configArray['color']) ? $configArray['color'] : '#0175D3';
        $conf['font-size'] = isset($configArray['font-size']) ? $configArray['font-size'] : '2';
        $conf['font-file'] = isset($configArray['font-file']) ? $configArray['font-file'] : 'front-media/fonts/titilliumweb-regular-webfont.ttf';
        $conf['params'] = isset($configArray['params']) ? $configArray['params'] : '';
// calculate a hash out of the configuration array-> image is only generated if its not found in the filepath
        $str = $text;
        foreach ($conf as $key => $val) {
            $str .= $key . "=" . $val;
        }
        $hash = md5($str);
        $imagepath = $filepath . '/' . $hash . '.png';
//        echo $imagepath;
        if (!file_exists($imagepath)) {
            $data = imagettfbbox($conf['font-size'], 0, $conf['font-file'], $text);

            $x = 0 - $data[6];
            $y = 0 - $data[7] - $data[3];
            $y *= 1.1;  //dunno why - but without this line the area will be a bit too small in hight
            $res = imagecreatetruecolor($data[2] * 1.05, 2 * $data[3] + $y);
            imagealphablending($res, true);
            imagesavealpha($res, true);
            imagefill($res, 0, 0, 0x7fff0000);
            $r = hexdec(substr($conf['color'], 1, 2));
            $g = hexdec(substr($conf['color'], 3, 2));
            $b = hexdec(substr($conf['color'], 5, 2));
            $textcolor = imagecolorallocate($res, $r, $g, $b);
            imagettftext($res, $conf['font-size'], 0, 0, $conf['font-size'], $textcolor, $conf['font-file'], $text);
            imagepng($res, $imagepath);
        }

        return '<img  src="' . base_url() . $imagepath . '" alt="' . SITE_NAME . '"/>';
    }

    /* ----- GET MODULE ACCESS CONTROL START ----   */

    function getAllmoduleAccess() {
        if ($this->ci->session->userdata('chr_user') == 'N' || $this->ci->session->userdata('chr_user') == 'A') {
            $MainAdminLogin = "YES";
        }
        $query = "select int_glcode as moduleId,var_modulename as moduleName, 'N' as chrcustom from " . DB_PREFIX . "modules where chr_adminpanel_module='Y' and chr_delete='N' and chr_publish='Y' union select int_glcode as moduleId,var_pagename as moduleName, 'Y' as chrcustom from pages where chr_custom='Y' and chr_delete='N' and chr_publish='Y'";
        $result = $this->ci->db->query($query);
        if ($MainAdminLogin != "YES") {
            $AlluseraccessModule = $this->getAlluseraccessModule();
        }
        $allAction = $this->getAllAction();
        $this->allAction = $allAction;
        $i = 0;
        foreach ($result->result_array() as $row) {
            foreach ($allAction as $Action) {
                $moduleaction = $row['moduleId'] . "-" . $Action['actionId'] . "-" . $row['chrcustom'];
                if ($MainAdminLogin == "YES") {
                    if ($this->ci->session->userdata('chr_user') == 'A' && in_array($row['moduleId'], $this->notValidForAdminArry)) {
                        $moduleactionarray[$row['moduleName']][$Action['actionName']] = 'N';
                    } else {
                        $moduleactionarray[$row['moduleName']][$Action['actionName']] = 'Y';
                    }
                    $moduleactionarray[$row['moduleName']]['View_Own'] = 'N';
                } else {
                    if (!empty($AlluseraccessModule) && in_array($moduleaction, $AlluseraccessModule)) {
                        $moduleactionarray[$row['moduleName']][$Action['actionName']] = 'Y';
                    } else {
                        $moduleactionarray[$row['moduleName']][$Action['actionName']] = 'N';
                    }
                }
            }
        }

        return $moduleactionarray;
    }

    function getAlluseraccessModule() {
        $query_module = "SELECT mu.fk_modules as moduleid
                        ,mu.fk_useraction as actionid
                        ,mu.chr_custom as custom 
                        FROM useraccess ua join module_useraction mu on mu.int_glcode = ua.fk_module_useraction 
                        WHERE mu.chr_delete='N' and  ua.chr_assign='Y' and ua.fk_groups ='" . $this->ci->session->userdata('group_id') . "' ";
        $result = $this->ci->db->query($query_module);
        foreach ($result->result_array() as $row) {
            $accessarray[] = $row['moduleid'] . '-' . $row['actionid'] . '-' . $row['custom'];
        }
        return $accessarray;
    }

    function getmodulename() {
        $module = $this->ci->router->fetch_class();
        $module = (!empty($module)) ? $module : 'dashboard';
        $sql = "select var_modulename as modulename from modules where chr_delete='N' and chr_publish = 'Y' and chr_adminpanel_module = 'Y' and var_modulename = '" . $module . "'";
        $rs = $this->ci->db->query($sql);
        $result = $rs->row();
        return $result->modulename;
    }

    function getAllAction() {
        $sql = "SELECT array_to_string(array_agg(int_glcode), ',') as action,array_to_string(array_agg(var_action),'') as actionName FROM useraction WHERE chr_delete='N'";
        $result = $this->ci->db->query($sql);
        $rs = $result->row();
        $tempAction = explode(",", $rs->action);
        $tempActionName = explode(",", $rs->actionName);
        for ($i = 0; $i < count($tempAction); $i++) {
            $action[$i]['actionId'] = $tempAction[$i];
            $action[$i]['actionName'] = $tempActionName[$i];
        }
        return $action;
    }

    function get_usertype() {
        $GetUsertype = "SELECT chr_usertype from " . DB_PREFIX . "users where chr_delete='N' and int_glcode = '" . $this->ci->session->userdata('userid') . "'";
        $UsertypeResult = $this->ci->db->query($GetUsertype);
        $Usertype = $UsertypeResult->row($UsertypeResult);
        return $Usertype->chr_usertype;
    }

    function DeleteModule_Releted_Entry($ChildArray) {
        /* Delete Child Entry */
        foreach ($ChildArray as $ChildValue) {
            $ChildTableName = DB_PREFIX . $ChildValue['tablename'];
            $ChildRecordId = $ChildValue['id'];
            $sql = "DELETE from $ChildTableName where fk_certificate='$ChildRecordId'";
            $this->ci->db->query($sql);
        }
        /* END */
    }

    function getMenuModules() {
        $menuModuleArry = array();
//        $notValidForAdminArry = array("13", "14", "15", "8", "12");  // for admin
        if ($this->ci->session->userdata('userid') == '1') {
            $query_module = "SELECT *,'Y' as chr_assign FROM " . DB_PREFIX . "modules WHERE chr_delete = 'N' and chr_publish = 'Y' and chr_adminpanel_module = 'Y' and chr_menu = 'Y'  order by int_glcode asc";
        } else if ($this->ci->session->userdata('userid') == '2') {
//            $query_module = "SELECT *,if(int_glcodeint_displayorder in (" . implode(',', $notValidForAdminArry) . "),'N','Y') as chr_assign FROM " . DB_PREFIX . "modules WHERE chr_delete = 'N' and chr_publish = 'Y' and chr_adminpanel_module = 'Y' and chr_menu = 'Y' order by int_displayorder asc";
            $query_module = "SELECT *,'Y' as chr_assign FROM " . DB_PREFIX . "modules WHERE chr_delete = 'N' and chr_publish = 'Y' and chr_adminpanel_module = 'Y' and chr_menu = 'Y'  order by int_glcode asc";
//            echo $query_module; die;
        } else {
            $query_module = " SELECT m.*,ua.chr_assign FROM " . DB_PREFIX . "modules m
                                LEFT JOIN " . DB_PREFIX . "module_useraction mu on mu.fk_modules =  m.int_glcode
                                LEFT JOIN " . DB_PREFIX . "useraccess ua on ua.fk_module_useraction = mu.int_glcode and ua.fk_groups = '" . $this->ci->session->userdata('group_id') . "'
                                WHERE mu.fk_useraction = 1 and m.chr_delete = 'N' and m.chr_publish = 'Y' and m.chr_adminpanel_module = 'Y' and m.chr_menu = 'Y' order by m.int_displayorder asc";
        }
        $result = $this->ci->db->query($query_module);
        if ($result->num_rows() > 0) {
            $menuModuleArry = $result->result();
        }
        return $menuModuleArry;
    }

    function generateSeoUrl($seourl, $originalurl) {
        if (SITE_SEO == "Y") {
            return $seourl;
        } else {
            return $originalurl;
        }
    }

    function get_alias($table, $id) {
        $sql = "select var_alias from " . DB_PREFIX . $table . " where int_glcode='$id'";
        $rs = $this->ci->db->query($sql);
        $result = $rs->row_array();
        return $result['var_alias'];
    }

    function DateTimeConvert($DateTime) {
        list($date, $time) = explode(" ", $DateTime);
        $date = $this->date_convert($date);
        $DateTime = $date . " " . $time;
        return $DateTime;
    }

    function generatepaging($dataObj, $position = 'Top') {

        $flag = 'Y';
        $init = $dataObj->module_model->initialize($flag);

        $genur = $dataObj->module_model->Generateurl($flag);
        $pagenumber = ABS($genur->pagenumber);
//        echo $pagenumber;
        $numofpages = $genur->noofpages;
        $numofrows = $genur->numofrows;
        $pagingurl = $genur->fronturlwithpara;


//        echo $pagingurl;
        $pagename = $genur->pagename;
        $numofrows1 = $dataObj->numofrows;

        if ($pagenumber > 1) {
            $page = $pagenumber - 1;
            $tdfirstpage = "<li><a  style='cursor:pointer;' class=\"disable-pang\" href=\"javascript:;\" title=\"Go to Previous Page\" onclick=\"SendpagingBindRequest('$pagingurl&amp;pagenumber=$page&amp;p=y','$pagename','P','','')\" >previous</a></li>";
        }
        if ($pagenumber < $numofpages) {
            $page = $pagenumber + 1;
            $tdlastpage = "<li><a class=\"selected\" href=\"javascript:;\" title='Go to Next Page' onclick=\"SendpagingBindRequest('$pagingurl&amp;pagenumber=$page&amp;p=y','$pagename','P','','')\" ><span></span>Next</a></li>";
        }
        $start = ($pagenumber - 1) * $pagesize;
        $starting_no = $start + 1;
        if (($numofrows - $start) < $pagesize) {
            $end_count = $numofrows;
        } elseif (($numofrows - $start) >= $pagesize) {
            $end_count = $start + $pagesize;
        }
        $pagestring = '';
        $loopcondtion = 0;
        $loopcondtion = $noofpage + 1;
        if ($genur->noofpages > 4) {
            if ($init->pagenumber > 3 && $init->pagenumber != $genur->noofpages && $this->pagenumber != $genur->noofpages - 1) {
                $pagestart = $init->pagenumber - 2;
            } else if ($init->pagenumber > 3 && $init->pagenumber == $genur->noofpages) {
                $pagestart = $pagenumber - 3;
            } else if ($init->pagenumber > 3 && $init->pagenumber == $genur->noofpages - 1) {
                $pagestart = $init->pagenumber - 3;
            } else {
                $pagestart = 1;
            }
            $loopstart = $pagestart;
            $loopcondtion = $pagestart + 4;
        } else {
            $loopstart = 1;
            $loopcondtion = $genur->noofpages + 1;
        }
        for ($i = $loopstart; $i < $loopcondtion; $i++) {
            if ($i == $pagenumber) {
                $pagestring.="<li  title='Go to Page " . $i . "'><a class=\"selected\" href='javascript:;'>" . $i . "</a></li>";
            } else {
                $pagestring.="<li><a  href=\"javascript:;\" title='Go to Page " . $i . "' onclick=\"SendpagingBindRequest('$pagingurl&amp;pagenumber=$i&amp;p=y','$pagename','P','$i','')\">" . $i . "</a></li>";
            }
        }
        if ($numofpages == 1) {
            
        } else {
            if (MODULE == 'newsletter') {
                $dclass = '';
            } else {
                $dclass = 'demo';
            }
            return "<div class=\"pagger\"><ul>" . $tdfirstpage . $pagestring . $tdlastpage . "</ul></div>";
        }
    }

    /* END */
    /* ----- END ----   */
}

?>