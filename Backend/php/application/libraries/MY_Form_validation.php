<?php

/**
* MY_Form_validation Class
*
* This library extends the native Form validation library.

*/

class MY_Form_validation extends CI_form_validation
{

    function __construct()
    {
        parent::__construct();

$this->CI =& get_instance();
    }

// --------------------------------------------------------------------

function requiredif($str, $field)
{
if ($_POST[$field] == '')
{
return TRUE; // the related form is blank
}

// the related form is set proceed with normal required

if (!is_array($str))
{
return (trim($str) == '') ? FALSE : TRUE;
     }
else
{
return ( ! empty($str));
     }
}

function run($module = '', $group = '') {
 (is_object($module)) AND $this->CI =& $module;
 return parent::run($group);
 }

// --------------------------------------------------------------------
}
?>