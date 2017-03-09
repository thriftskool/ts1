<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');
/* load the MX_Router class */
require APPPATH . "third_party/MX/Router.php";

class MY_Router extends MX_Router {

    public function __construct() {
        parent::__construct();

        $this->table_array = array("pages");
        require_once( BASEPATH . 'database/DB' . EXT );
        $this->db = & DB();
        
    }

    private function getmodule($alias) {

        if (!empty($alias)) {
            foreach ($this->table_array as $key => $value) {
                $alias1 = $alias;
                $query = $this->db->get_where($value, array('var_alias' => var_alias, 'chr_delete' => 'N', 'chr_publish' => 'Y'));
//              echo $this->db->last_query(); die;
                if ($query->num_rows > 0) {
                    
                    $result = $query->row();
                    $this->record_id = $result->int_glcode;
                    if ($value == "pages") {
                        $this->var_pagetype = $result->var_pagetype;
                    }
                    return $value;
                    break;
                }
            }
        }
    }

    private function getseopara($segments) {
      
        if (!empty($segments[0]) && $segments[1] == '') {
            
            $segment1 = $this->getmodule($segments[0]);
            $this->main_record_id = $this->record_id;
        } elseif ($segments[1] == '') {
            $segment1 = $this->getmodule($segments[1]);
            $this->main_record_id = $this->record_id;
        }

        switch ($segment1) {
            case 'pages' :
                $segments[0] = $this->var_pagetype;
                    $segments[1] = "index";
                $segments[2] = $this->main_record_id;
                $segments[3] = $this->table_array[0];
                break;

            default :
                $segments[2] = 1;
                break;
        }
        return $segments;
    }

    public function locate($segments) {
//        echo "in"; die;
//echo SITE_SEO; die;
        $module_ID = 0;
        $record_ID = 1;
        if (!empty($segments[0]) && $segments[0] != 'fronthome') {
            
            $tableName = $this->getmodule($segments[0]);
        }
        if ($segments[1] == ADMINPANEL && !empty($segments[0])) {       // set adminpanel route
            $segments[1] = $segments[1] . '_' . $segments[0];
        } else if (SITE_SEO == "Y") {
            
            $segments = $this->getseopara($segments);
            if (!empty($segments[0]) && $segments[0] != 'user_management') {
//                if($segments[0] !='fronthome'){
//                $moduleQry = $this->db->get_where('modules', array('int_glcode' => $segments[0]));
//                }
                if ($moduleQry->num_rows > 0) {
                    $moduleRes = $moduleQry->row();
                    $segments[0] = $moduleRes->var_modulename;
                    $record_ID = $this->main_record_id;
//                    echo $record_ID;
                }
            }
        } else {

            $this->db->select('p.int_glcode,m.int_glcode as moduleid');
            $this->db->from('modules m');
            $this->db->join('pages p', 'm.int_glcode=p.var_pagetype', 'left');
            $this->db->where('m.var_modulename ', $segments[0]);
            $query = $this->db->get();
            if ($query->num_rows > 0) {
                $result = $query->row();
                $module_ID = $result->moduleid;
                $record_ID = $result->int_glcode;
            }
        }

        if ($tableName == '') {
            $tableName = 'pages';
        }
        define('RECORD_ID', $record_ID);
        define('SEO_TABLE', $tableName);

        $segments[1] = $segments[1];

        ksort($segments);

        $this->module = '';
        $this->directory = '';
        $ext = $this->config->item('controller_suffix') . EXT;

        /* use module route if available */
        if (isset($segments[0]) AND $routes = Modules::parse_routes($segments[0], implode('/', $segments))) {
            $segments = $routes;
        }

        /* get the segments array elements */
        list($module, $directory, $controller) = array_pad($segments, 3, NULL);

        /* check modules */
        foreach (Modules::$locations as $location => $offset) {

            /* module exists? */

            if (is_dir($source = $location . $module . '/controllers/')) {

                $this->module = $module;

                $this->directory = $offset . $module . '/controllers/';

                /* module sub-controller exists? */
                if ($directory AND is_file($source . $directory . $ext)) {
                    //  print_r(array_slice($segments, 1)); exit;
                    return array_slice($segments, 1);
                }

                /* module sub-directory exists? */
                if ($directory AND is_dir($source . $directory . '/')) {

                    $source = $source . $directory . '/';
                    $this->directory .= $directory . '/';

                    /* module sub-directory controller exists? */

                    if (is_file($source . $directory . $ext)) {
                        return array_slice($segments, 1);
                    }

                    /* module sub-directory sub-controller exists? */
                    if ($controller AND is_file($source . $controller . $ext)) {
                        return array_slice($segments, 2);
                    }
                }

                if (is_file($source . $module . $ext)) {
                    return $segments;
                }
            }
        }

        /* application controller exists? */
        if (is_file(APPPATH . 'controllers/' . $module . $ext)) {
            return $segments;
        }

        /* application sub-directory controller exists? */
        if ($directory AND is_file(APPPATH . 'controllers/' . $module . '/' . $directory . $ext)) {
            $this->directory = $module . '/';
            return array_slice($segments, 1);
        }

        /* application sub-directory default controller exists? */
        if (is_file(APPPATH . 'controllers/' . $module . '/' . $this->default_controller . $ext)) {
            $this->directory = $module . '/';


            return array($this->default_controller);
        }
    }

}
