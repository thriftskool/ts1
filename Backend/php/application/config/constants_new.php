<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/*
  |--------------------------------------------------------------------------
  | File and Directory Modes
  |--------------------------------------------------------------------------
  |
  | These prefs are used when checking and setting modes when working
  | with the file system.  The defaults are fine on servers with proper
  | security, but you may wish (or even need) to change the values in
  | certain environments (Apache running a separate process for each
  | user, PHP under CGI with Apache suEXEC, etc.).  Octal values should
  | always be used to set the mode correctly.
  |
 */
define("GOOGLE_API_KEY", "AIzaSyCmhjpO4hTmgnrpMZHazt4Q6PhqDiQhFlc");


define('FILE_READ_MODE', 0644);
define('FILE_WRITE_MODE', 0666);
define('DIR_READ_MODE', 0755);
define('DIR_WRITE_MODE', 0777);




define('FOPEN_READ', 'rb');
define('FOPEN_READ_WRITE', 'r+b');
define('FOPEN_WRITE_CREATE_DESTRUCTIVE', 'wb'); // truncates existing file data, use with care
define('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE', 'w+b'); // truncates existing file data, use with care
define('FOPEN_WRITE_CREATE', 'ab');
define('FOPEN_READ_WRITE_CREATE', 'a+b');
define('FOPEN_WRITE_CREATE_STRICT', 'xb');
define('FOPEN_READ_WRITE_CREATE_STRICT', 'x+b');
define('DEFAULT_PAGESIZE', '30');


//define('SITE_NAME', 'Thriftskool');
//define('SITE_PATH', 'http://localhost/thriftskool/');
//define('CHR_CLIENT_SEO_FLAG', 'N');
//define('SITE_MAINTENANCE', 'N');
//define('CONTECT_US_EMAIL_ID', '0');
// define('SITE_PATH', 'https://www.thriftskool.com/mobileapps/thriftskool/');

require_once( BASEPATH . 'database/DB' . EXT );
$db = & DB();

$query = $db->get('general_settings');

foreach ($query->result() as $row) {

    define('DEFAULT_DATEFORMAT', $row->var_dateformat);
    define('SITE_NAME', $row->var_sitename);
    define('SITE_PATH', $row->var_sitepath);
    define('CHR_CLIENT_SEO_FLAG', $row->chr_seo_flag);
    define('SITE_MAINTENANCE', $row->chr_maintenance);
    define('CONTECT_US_EMAIL_ID', $row->var_contactusmail);
}

define("SMTP_HOST", "ssl://smtp.googlemail.com"); //Hostname of the mail server
define("SMTP_PORT", 465); //Port of the SMTP like to be 25, 80, 465 or 587
define("SMTP_USER", "no-reply@tskool.com"); //Username for SMTP authentication any valid email created in your domain
define("SMTP_PASSWORD", "Pinkladies2008"); //Password for SMTP authentication

/* * *******    CONSTANT Start  ********* */


define("UNIVERSITY_WIDTH",133);
define("UNIVERSITY_HEIGHT",133);
   
define("CAMPUS_GALLERY_WIDTH",225);
define("CAMPUS_GALLERY_HEIGHT",225);
   

define("PRODUCT_WIDTH",225);
define("PRODUCT_HEIGHT",225);

define('DB_PREFIX', '');
define('SESSION_PREFIX', 'cc_');

define('ADMINPANEL', 'adminpanel');

define('ADMINPANEL_URL', SITE_PATH . ADMINPANEL . '/');
define('ADMINPANEL_HOME_URL', SITE_PATH . ADMINPANEL . '/dashboard');

define('ADMIN_MEDIA_URL', SITE_PATH .'admin-media/');

define('FORM_TYPE_MSG', 'Only .doc, .docx, .pdf, .xls and .xlsx file formats are supported.');
define('FILE_RADIO_BUTTON_MSG', 'Please select any one option to upload a file.');
define('FILE_UPLOAD_MSG', 'Please select the file.');
define('LINK_EXT_URL_MSG', 'Please enter the valid link.(Eg: http://www.example.com)');
define('FILE_TYPE_MSG', 'Only .doc, .docx, .pdf, .rar, .xls, .xlsx, .ppt, .pptx and .zip  file formats are supported.');
define('FILE_TYPE_PAGES_MSG', 'Only .doc, .docx, .pdf, .xls and .xlsx  file formats are supported.');
define('FILE_UPLOAD_DROP_MSG', 'Please upload file from dropbox.');
define('FILE_EXT_URL_MSG', 'Please enter the valid link.  (Eg. http://www.mywebsite.com/mydocument.pdf)');
define('FILE_EXT_URL_MSG1', 'Please enter the valid link. (Eg. http://www.mywebsite.com/myimage.jpg)');
define('TEAM_TYPE_MSG', 'Only .doc, .docx and .pdf  file formats are supported.');
define('CF_TEAM_TYPE_MSG', 'Only .doc, .docx and .pdf  file formats are supported.');
define('SYSTEM_IMG_VALID', 'Please upload system image.');

define('DESCRIPTION_MSG', "Please enter description.");
define('SHORT_DESC_MSG', "Please enter short description.");



define('IMAGE_MSG', 'Please upload image.');

/* Vendor Module Constant */

define('CAREER_TITLE_MSG', 'Please enter title.');
define('BANNER_TITLE_MSG', 'Please enter Title.');
define('PRODUCT_TITLE_MSG', 'Please enter Title.');
define('C_NAME_MSG', 'Please enter Title.');

define('UNIVERSITY_TITLE_MSG', 'Please enter name.');


define('C_CATEGORY_NAME', 'Please select category.');
define('CAT_REQUIRED', 'Please select category.');
define('C_PRICE', 'Please enter atleast one Price.');
define('C_PRICE_VALID', 'Please enter valid Price value.');
define('C_MAX_PRICE', 'Please enter Maximum Price.');
define('C_MIN_PRICE', 'Please enter Minimun Price.');
define('C_EXP_DATE', 'Please select Expiry Date.');
define('C_FEEXP_DATE', 'Please select Featured Expiry Date.');
define('VENDOR_LOGO_MSG', 'Please upload the logo.');
define('EXIST_EMAIL_ID', 'This email id already in use. Please enter another email id.');
define('FULL_NAME_VALIDATION', 'Please enter Company Name.');
define('EMPTY_EMAIL_VALIDATION', 'Please enter Company Email ID.');
define('VALID_EMAIL_VALIDATION', 'Please enter valid email address.');
define('CMT_MSG', 'Please enter comment.');
define('PASSWORD_VALIDATION', 'Please enter Password.');
define('PASSWORD_LIMIT', 'Password must be atleast 8 characters in length.');
define('PASSWORD_MAX_LIMIT', 'Password must be maximum 20 characters in length.');
define('PASSWORD_LIMIT1', 'Confirm password must be atleast 8 characters in length.');
define('PASSWORD_MAX_LIMIT1', 'Confirm password must be maximum 20 characters in length.');
define('PASSWORD_VALID_VALIDATION', 'Password must contain at least one capital,alphabet and numeric.');
define('CONF_PASSWORD_VALIDATION', 'Please enter confirm password.');
define('CONF_PASSWORD_EQUAL', 'Confirm Password does not match with new password.');
define('SECONDARY_EMAIL_ID', 'Please enter valid Secondary Email address.');
define('IMAGE_VALIDATION', 'Only .jpg, .jpeg, .png image formats are supported.');
define('GROUP_NAME', 'Please select your group name.');
define('FIRST_NAME', 'Please enter your first name.');
define('VENDOR_EMAIL_NOTE', 'This email id will be used for Company Admin Panel <br/> login purpose 
    ,for Forgot Password feature of the admin <br/> panel and other administrative email communication.');
define('SECONDARY_EMAIL_NOTE', 'This email id will be used for administrative email <br/> communication. You can enter multiple secondary email <br/> addresses by seperating them using Comma.');
/* Vendor Module Constant End */

/* email communication start */
define('EMAIL_SUBJECT_VALIDATION', 'Please enter Email subject.');
define('DESCRIPTION_FOR_MAIL_TEMPLATE', 'Please enter description.');
/* email communication End */


/* email User Management start */
define('EMPTY_USER_VALIDATION', 'Please enter User ID/Email ID.');
define('VALID_USER_VALIDATION', 'Please enter valid User ID/Email ID.');
define('CP_PASSWORD_VALIDATION_MATCH', 'The Confirm Password field does not match the Password field.');
define('CP_PASSWORD_CON', 'Please Enter Confirm Password.');
/* email User Management start */

/* Contact us lead Messages */

define('CONTACT_REPLY_VALIDATION', 'Please enter the message.');
/* Contact us lead Messages End */

/* Master Bottle Formate Module Validation Messages Start */
define('MST_BOT_TITLE_MSG', 'Please enter bottle name.');
define('MST_BOT_SIZE_MSG', 'Please enter Bottle Size.');
/* Master Bottle Formate Module Validation Messages End */

/* video album Module Validation Messages Start */
define('VIDEO_TITLE_MSG', 'Please enter title.');
define('VIDEO_IMAGE_UPLOAD_MSG', 'Please upload image.');
define('VIDEO_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
//define('AB_VALID_IMG_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
/* Video album Module Validation Messages End */

/* * *******    CONSTANT End  ********* */

/* Commonpdf lead Messages */
define('CP_VALID_UPLOAD', 'Please upload valid common file.');
define('CP_UPLOAD', 'Please upload common file.');

/* Commonpdf lead Messages */

/* videogallery lead Messages */
define('DI_URL', 'Please enter url.');

/* Reach at maximum limit */
define('ML_MSG', 'You have reached at maximum limit');

/* AdminPanel Alias Note Start */
define('VENDOR_SEC_EMAILS_NOTE', 'You can add the multiple address by comma separated.');
define('GLOBAL_CATEGORY_NOTE', 'Category name insert for provide Product Hierarchy. ');
define('CF_FILE_TYPE_pdfMSG', 'Only .doc, .docx, .pdf file formats are supported.');
define('VE_PRODUCTCATEGORY_PARENT_SELECT', 'please select product category. ');
define('PRODUCT_NAME_MSG', 'Please enter product name.');
define('GLOBAL_TITLE_NOTE', 'Title of the page is basically the name of the page, this name is seen by the users as well as search engines please make sure the title is appropriate to the content of the page. ');
define('GLOBAL_ALIAS_NOTE', 'Website Alias are custom URL which you have the ability to create so it gets easier for the users to navigate directly to a certain page. An alias is  the URL extensions you create for a new page. E.G. lets suppose you added an history page under about us a suitable alias for that would be ' . SITE_PATH . 'aboutus/history. ');
/* AdminPanel Alias Note End */


/* AdminPanel - Validation Messages */

define('CATEGORY_NAME_MSG', 'Please enter category title.');
define('COMMON_ALIAS_MSG', 'Please enter alias.');
define('PRICE_MSG', 'Please enter price.');
define('COMMON_ALIAS_EXISTS_MSG', 'Alias already exists. Please change the alias.');
define('GLOBAL_PRODUCT_NOTE', 'Product name insert according to category under follow the tree structure. ');
define('COMMON_DISPLAY_ORDER_MSG', 'Please enter display order.');
define('COMMON_DISPLAY_ORDER_VALID_MSG', 'The display order value cannot be zero or blank.');
define('URL_EG', 'Please enter URL like: </br><u>"http://www.linkedin.com/company"</u>');

/* Pages Module Validation Messages Start */
define('PAGES_PARENT_SELECT', 'Please select parent page.');
define('PAGES_TITLE_MSG', 'Please enter title.');

/* Pages Module Validation Messages End */

define('CLIENT_NAME_MSG', 'Please enter name.');

/* Common File Module Validation Messages Start */
define('CF_TITLE_MSG', 'Please enter title.');
define('CF_FILE_UPLOAD_MSG', 'Please upload common file.');
define('CF_FILE_TYPE_MSG', 'Only .doc, .docx, .pdf, .rar , .xls ,.xlsx , .ppt , .pptx and .zip  file formats are supported.');

define('CF_FILE_TYPE', 'Only .pdf  file formats are supported.');
/* Common File Module Validation Messages End */


/* Dashboard File Module Validation Messages End */
define('SET_PRICE_VALUE', 'Please enter your Price value.');
define('VALID_PRICE_VALUE', 'Please enter valid Price value.');
/* Dashboard File Module Validation Messages End */

/* Certificate Category Module Validation Messages Start */
define('CC_TITLE_MSG', 'Please enter the title.');
define('CC_PARENT_MSG', 'Please select Parent Page.');
define('CC_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
/* Certificate Category Module Validation Messages End */

/* Contact Us Page Details Module Validation Messages Start */
define('CPD_NAME_MSG', 'Please enter name.');
define('CPD_PHONE_MSG', 'Please enter phone number.');
define('CPD_EMAIL_MSG', 'Please enter email address.');
define('SHORT_PHONE_MSG', 'Please enter phone.');
define('SHORT_EMAIL_MSG', 'Please enter email.');
define('CPD_VALID_EMAIL_MSG', 'Please enter valid email address.');
define('CPD_VALID_EMAIL_MSG1', 'Please enter valid email address.');
define('CPD_FAX_MSG', 'Please enter fax.');
/* Contact Us Page Details Module Validation Messages End */

/* Menucategory Module Validation message Start */

define('MENU_CATEGORY_TITLE_MSG', 'Please enter title.');
define('MENU_CATEGORY_RECORD_TITLE', 'Please enter title of video.');
define('MENU_CATEGORY_IMAGE_UPLOAD_MSG', 'Please select the image.');

/* Certificate Module Validation Messages Start */

define('CF_BG_IMG_MSG', 'Please select the background image.');
define('CF_IMG_MSG', 'Please upload the unique gift card.');
define('CF_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
define('TIME_NOTE', 'Time is based on 11:59 EST.');
/* Certificate Module Validation Messages End */


/* Master Producer Module Validation Messages Start */
define('MST_PRO_TITLE_MSG', 'Please enter Producer Name.');
/* Master Producer Module Validation Messages End */


/* Settings Module Validation Messages Start */
define('SET_SITENAME_MSG', 'Please specify your site name.');
define('SET_MARGIN_US', 'Please specify Margin between US and CI.');
define('SET_SITEPATH_MSG', 'Please specify your site path.');
define('SET_PAGESIZE_MSG', 'Please enter page size.');
define('SET_PRICE_MSG', 'Please specify your Commision by Price value.');
define('SET_PERC_MSG', 'Please specify your Commision by Percentage value.');
define('SET_VALID_PAGESIZE_MSG', 'Page size should be between 10 and 50.');
define('SET_VALID_PERG_MSG', 'Commision By Percentage should be between 0 and 100.');
define('SET_VALID_URL_MSG', 'Please specify valid url (i.e http://....).');

define('SET_MAILER_MSG', 'Please select mailer type.');
define('SET_SMTP_SERVER_MSG', 'Please enter SMTP server name.');
define('SET_SMTP_USERNAME_MSG', 'Please enter  SMTP username.');
define('SET_SMTP_USERNAME_MSG_VALID', 'Please enter valid SMTP username.');
define('SET_SMTP_PWD_MSG', 'Please enter SMTP Password.');
define('SET_SMTP_PWD_MSG_LENTH', 'SMTP Password must be at least 5 characters in length.');
define('SET_SENDER_EMAIL_MSG', 'Please enter valid sender email id.');

define('CP_FULL_NAME', 'Please enter full name.');
define('CP_FIRST_NAME', 'Please enter first name.');
define('CP_EMAIL', 'Please enter Login ID.');
define('CP_EMAIL_VALID', 'Please enter valid Login ID.');
define('CP_PEMAIL', 'Please enter Personal ID.');
define('CP_PEMAIL_VALID', 'Please enter valid Personal ID.');
define('CP_DEFAULT_EMAIL', 'Please enter reservation email id.');
define('CP_DEFAULT_EMAIL_VALID', 'Please enter valid reservation email id.');
define('CP_NEWS_EMAIL', 'Please enter newsletter email id.');
define('CP_NEWS_EMAIL_VALID', 'Please enter valid newsletter email id.');
define('CP_SUPPLIER_EMAIL', 'Please enter supplier email id.');
define('CP_SUPPLIER_EMAIL_VALID', 'Please enter valid supplier email id.');
define('CP_CONTACT_EMAIL', 'Please enter contactus email id.');
define('CP_CONTACT_EMAIL_VALID', 'Please enter valid contactus email id.');
define('CP_BOOKING_EMAIL', 'Please enter booking email id.');
define('CP_BOOKING_EMAIL_VALID', 'Please enter valid booking email id.');
define('CP_PASSWORD', 'Password must contain at least one numeric,one alphabetic and one special character.');
/* Settings Module Validation Messages End */


/* * ********  Calendar Date Format ************* */


//if (DEFAULT_DATEFORMAT == "%d/%m/%Y") {
//    define('CALENDAR_DATE_FORMAT', "dd/mm/yy");
//} else if (DEFAULT_DATEFORMAT == "%m/%d/%Y") {
//    define('CALENDAR_DATE_FORMAT', "mm/dd/yy");
//} else if (DEFAULT_DATEFORMAT == "%Y/%m/%d") {
//    define('CALENDAR_DATE_FORMAT', "yy/mm/dd");
//} else if (DEFAULT_DATEFORMAT == "%Y/%d/%m") {
//    define('CALENDAR_DATE_FORMAT', "yy/dd/mm");
//}

/* End of file constants.php */
/* Location: ./application/config/constants.php */

define('BM_HB_IMAGE_UPLOAD_MSG', 'Please upload image from system.');
define('BM_HB_BANNER_UPLOAD_MSG', 'Please upload image from system.');
define('BM_IMAGE_UPLOAD_MSG', 'Please upload image.');
define('BM_BANNER_UPLOAD_MSG', 'Please upload image.');
define('BM_HB_IMAGE_UPLOAD_MSG1', 'Please upload image from dropbox.');
define('BM_HB_BANNER_UPLOAD_MSG1', 'Please upload image from dropbox.');



define('BM_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
define('BM_BANNER_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');

define('BM_IMAGE_TYPE_MSG1', 'Only .jpg, .jpeg, .png , .gif or .pdf image formats are supported.');
define('BM_BANNER_TYPE_MSG1', 'Only .jpg, .jpeg, .png , .gif or .pdf image formats are supported.');

define('BM_CLIENT_LOGOIMAGE_UPLOAD_MSG', 'Please upload Logo image.');
define('BM_CLIENT_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');
/* Color Module Validation Messages End */


define('BM_RECENTDESIGN_IMAGE_TYPE_MSG', 'Only .jpg, .jpeg, .png or .gif image formats are supported.');

define('BM_EXT_URL_MSG', 'Please enter the valid external link.');
define('BM_INT_LINK_MSG', 'Please select any page for the internal link.');
define('BM_TITLE_MSG', 'Please enter title.');
define('BM_EXT_MSG)', 'Please enter the link.');
