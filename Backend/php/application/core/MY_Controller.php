<?php

/**
 * The base controller which is used by the Front and the Admin controllers
 */
class Base_Controller extends MX_Controller {

    var $viewData = "";
    var $main_layout;

    public function __construct() {
        parent::__construct();

        $this->load->database();
        $this->load->library('mylibrary');
        $this->load->library('parser');
        $this->load->library('session');
        $this->load->library('email');
        $this->load->library('form_validation');
        $this->load->model('common_model');
        $this->load->helper('cookie');
        $this->load->helper('text');

        $this->set_module_constant();

        if (ENVIRONMENT == 'development' || ENVIRONMENT == 'testing') {

            if ($this->input->is_ajax_request()) {
                $this->output->enable_profiler(false);
            } else {
                $this->output->enable_profiler(False);
                $sections = array(
                    'config' => true,
                    'queries' => true
                );

                $this->output->set_profiler_sections($sections);
            }
        }
    }
 
    function load_view() {

        $this->load->view($this->main_layout, $this->viewData);
    }

    private function set_module_constant() {

        $module = $this->router->fetch_module();
        $class = $this->router->fetch_class();
        $method = ($this->router->fetch_method() == 'index' || $this->router->fetch_method() == 'add') ? '' : $this->router->fetch_method();

        $module_path = $module . (empty($method) ? '' : '/' . $method);
        $moduleArry = $this->common_model->getModuleName($module_path);

        if (empty($moduleArry)) {
            $moduleArry = $this->common_model->getModuleName($module);
        }

        define('MODULE', $module);      // Module name
        define('MODULE_PATH', $moduleArry->var_modulename);     // module path 
        define('MODULE_ID', $moduleArry->int_glcode);
        define('MODULE_URL', ADMINPANEL_URL . MODULE . '/');
        define('MODULE_PAGE_NAME', ADMINPANEL_URL . MODULE_PATH);
        define('FRONT_MODULE_URL', base_url() . MODULE . '/');
        define('ADMIN_ID', $this->session->userdata('userid'));
        define('ADMIN_NAME', $this->session->userdata('fname'));
        define("CHR_USER", $this->session->userdata('chr_user'));
    }
}

//end Base_Controller

class Front_Controller extends Base_Controller {

    function __construct() {
        parent::__construct();
        
//            echo "dsafsadf"; die;
        $this->load->helper('text');
//        $this->viewData['metadata'] = $this->common_model->set_metadata();
//        $this->viewData['glMetaArray'] = $this->common_model->glMetaArray();
//        $this->common_model->set_page_hits("pages", RECORD_ID);
		
//        $this->viewData['headerMenu'] = $this->common_model->GetHeaderMenuData(RECORD_ID);
//        $this->viewData['seofooterMenu'] = $this->common_model->GetSEOFooterMenuData(RECORD_ID);
//        $this->viewData['HomeBannerData'] = $this->common_model->GetHomeBannerData();
//         $this->viewData['currentPageData_content'] = $this->common_model->getpagedata_content(RECORD_ID);

        $this->viewData['HeaderPanel'] = 'front/templates/header_tpl';
        $this->viewData['FooterPanel'] = 'front/templates/footer_tpl';
        $this->viewData['SEOFooterPanel'] = 'front/templates/seofooter';
        $this->viewData['BannerPanel'] = 'front/templates/banner_tpl';
        $this->main_layout = 'front/templates/output_tpl';
        
//        if (SITE_MAINTENANCE == 'Y') {
//            $main_data = $this->common_model->getmaintaincedata();
//            $this->viewData['main_data'] = $main_data;
//            include_once 'undercunstruction.php';
//            exit;
//        }
    }

}

class AdminPanel_Controller extends Base_Controller {

    var $emaildata = "";
    var $permissionArry = array();

    function __construct() {

        parent::__construct();

        // assign default templates
        
        
        $this->viewData['adminHeaderPanel'] = 'adminpanel/templates/header_tpl';
        $this->viewData['adminLeftPanel'] = 'adminpanel/templates/leftpanel_tpl';
        $this->viewData['adminFooterPanel'] = 'adminpanel/templates/footer_tpl';

        $this->main_layout = 'adminpanel/templates/output_tpl';

        if ($this->input->get_post('action') == 'checksessionstatus') {
            if ($this->session->userdata('userid') != '') {
                echo "1";
            } else {
                echo "0";
            }
            exit;
        }
        if ($this->input->get_post('action') == 'openloginpopup') {
            echo $this->parser->parse('adminpanel/templates/popup_tpl');
            exit;
        }
        if ($this->input->get_post('ajax') != 'Y' && ($this->uri->segment(3) != 'checksessionstatus' && $this->uri->segment(3) != 'openpopup' && $this->input->get_post('sub') != 'validlogin')) {
          
           
            $this->check_isvalidated();
        }

        /// define constant        
        $this->check_access();
    }

    private function check_isvalidated() {
//echo $_SERVER['HTTPS_HOST']; die;
        $goto = "?gotopath=" . urlencode("https://" . $_SERVER['HTTPS_HOST'] . "" . $_SERVER['REQUEST_URI']);
        if (!$this->session->userdata('validated')) {
            redirect(base_url() . 'adminpanel/login' . $goto);
            exit;
        }
    }

    function check_access() {

        $this->permissionArry = $this->session->userdata('permissionArry');
        $this->permissionArry['settings/systemsettings'] =
                Array(
                    'View' => "Y",
                    'View_Own' => "Y",
                    'Add' => "Y",
                    'Edit' => "Y",
                    'Delete' => "N",
                    'Publish' => "N",
                    'Restore' => "N",
        );

        $method = $this->router->fetch_method();
        if (!empty($this->permissionArry[MODULE_PATH])) {

            if ($this->permissionArry[MODULE_PATH]['View'] != 'Y') {
                $this->viewData['adminContentPanel'] = 'adminpanel/templates/restricted_tpl';
                echo $this->parser->parse($this->main_layout, $this->viewData);
                exit;
            }

            if ($method == 'add' && $this->input->get('eid') == '') {
                if ($this->permissionArry[MODULE_PATH]['Add'] != 'Y') {
                    $this->viewData['adminContentPanel'] = 'adminpanel/templates/restricted_tpl';
                    echo $this->parser->parse($this->main_layout, $this->viewData);
                    exit;
                }
            }

            if ($method == 'add' && $this->input->get('eid') != '') {
                if ($this->permissionArry[MODULE_PATH]['Edit'] != 'Y') {
                    $this->viewData['adminContentPanel'] = 'adminpanel/templates/restricted_tpl';
                    echo $this->parser->parse($this->main_layout, $this->viewData);
                    exit;
                }
            }

            if ($method == 'delete') {
                if ($this->permissionArry[MODULE_PATH]['Delete'] != 'Y') {
                    $this->viewData['adminContentPanel'] = 'adminpanel/templates/restricted_tpl';
                    echo $this->parser->parse($this->main_layout, $this->viewData);
                    exit;
                }
            }

            if ($method == 'UpdatePublish') {
                if ($this->permissionArry[MODULE_PATH]['Publish'] != 'Y') {
                    $this->viewData['adminContentPanel'] = 'adminpanel/templates/restricted_tpl';
                    echo $this->parser->parse($this->main_layout, $this->viewData);
                    exit;
                }
            }
        }
    }

    /* ----- END ----   */
}