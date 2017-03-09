
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <title>AdminPanel</title>
        <link href="<?php echo ADMIN_MEDIA_URL; ?>css/style.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo ADMIN_MEDIA_URL; ?>css/general.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript">
            var BASE = '<?php echo base_url(); ?>';
        </script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/jquery-1.4.4.min.js"></script>
<!--        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/popup/popup.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/popup/dragme.js"></script>-->
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/jquery-1.8-ui.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/commonalert.js"></script>
        <link rel="stylesheet" href="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/themes/base/jquery.ui.all.css"/>
        <link type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/themes/base/jquery.ui.autocomplete.css" rel="stylesheet" />
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/ajaxfunctions.js"></script>
        <link rel="stylesheet" type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/themes/base/jquery.ui.tabs.css" />
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/ui/minified/jquery.ui.core.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/ui/minified/jquery.ui.widget.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/ui/minified/jquery.ui.position.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/ui/minified/jquery.ui.autocomplete.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery.validate.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/validation_additional-methods.js"></script>
<!--        <style>
            .ui-dialog-titlebar-close{
                display: none;
            }
        </style>-->

        <!--**************************************** NEW *****************************-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/bootstrap.css" rel="stylesheet" />
        <!-- FontAwesome Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/font-awesome.css" rel="stylesheet" />
        <!-- Morris Chart Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
        <!-- Custom Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/custom-styles.css" rel="stylesheet" />
        <!-- Google Fonts-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />


        <!-- /. WRAPPER  -->
        <!-- JS Scripts-->
        <!-- jQuery Js -->
<!--        <script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/jquery-1.10.2.js"></script>
         Bootstrap Js 
        <script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/bootstrap.min.js"></script>-->
        <!-- Metis Menu Js -->
        <!--<script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/jquery.metisMenu.js"></script>-->
        <!-- Morris Chart Js -->
    <!--    <script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/morris/raphael-2.1.0.min.js"></script>
        <script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/morris/morris.js"></script>-->
        <!-- Custom Js -->
        <!--<script src="<?php echo ADMIN_MEDIA_URL; ?>new/js/custom-scripts.js"></script>-->

        <!--********************* New End ******************************-->



        <script type="text/javascript">

            function restricted_access() {

<?php
if (ADMIN_ID != '1' && ADMIN_ID != '2') {

    if ($this->permissionArry[MODULE_PATH]['Add'] != 'Y') {
        ?>
                        $("#Image49").remove();
        <?php
    }


    if ($this->permissionArry[MODULE_PATH]['Delete'] != 'Y') {
        ?>
                        $(".delete-class").remove();
                        $(".delete-button-class").remove();
        <?php
    }

    if ($this->permissionArry[MODULE_PATH]['Publish'] != 'Y') {
        ?>
                        $(".publish-class").find('img').removeAttr('onclick');
                        $(".publish-tr-class").hide();
        <?php
    }

    if ($this->permissionArry[MODULE_PATH]['Edit'] != 'Y') {
        ?>
                        $(".edit-link-class").contents().unwrap();
        <?php
    }

// dashboard

    if (MODULE_PATH == "dashboard") {
        if ($this->permissionArry['reservation']['Edit'] != 'Y') {
            ?>
                            $(".dashboard-res-edit-class").contents().unwrap();
            <?php
        }

        if ($this->permissionArry['owner_property']['Edit'] != 'Y') {
            ?>
                            $(".dashboard-prop-edit-class").contents().unwrap();
            <?php
        }

        if ($this->permissionArry['reminders']['Edit'] != 'Y') {
            ?>
                            $(".dashboard-reminder-edit-class").contents().unwrap();
            <?php
        }
    }
}
?>

            }


            $(document).ready(function () {

                restricted_access();

                $(document).ajaxComplete(function () {
                    restricted_access();
                });


            });
        </script>


    </head>
    <body onload="focus();">
        <div id="wrapper">
            <input type="hidden" name="hid_userid" id="hid_userid" value="<?php echo $this->session->userdata('userid'); ?>" />
            <input type="hidden" name="chr_Log_popup" id="chr_Log_popup" value="N" />

            <div id="dvregisterfrm" class="select-freenew"  style="width:373;height:450;display:none;position:absolute;z-index:9999999;"> </div>
            <div id="dimmer" class="dimmer" style="z-index:999999;"> </div>
            <div id="popupContact" class="dragme"  style="z-index:9999"></div>
            <div id="backgroundPopup" style="z-index: 101;"></div>
            <div id="backgroundloader" style="z-index:999999;display:none;left:100px;top:100px;"></div>
            <div id="dvprocessing" style="display:none;">
                <div class="UpdateProgress123" id="loadertext">
                    <img src="<?php echo ADMIN_MEDIA_URL; ?>images/xajax-loader.gif"/>
                </div>
            </div>
            <div id="dimmer" class="dimmer" style="z-index:999999"> </div>
            <!--*************************** New **************-->

            <nav class="navbar navbar-default top-navbar" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="javascript:;">AdminPanel</a>
                </div>

                <ul class="nav navbar-top-links navbar-right">
                    <!-- /.dropdown -->
                    <li class="dropdown">
                        <span style="color:white">
                            Welcome <?php
                            echo $this->session->userdata('fname');
                            ?>
                        </span>
                    </li>
                    </li>
                    <li class="dropdown">
                        <a style="font-size: 18px; " href="<?php echo base_url() . ADMINPANEL; ?>/dashboard/do_logout">Logout</a>
                        <!-- /.dropdown-user -->
                    </li>

                    <li class="dropdown">
                        <a style="font-size: 18px; color: white " href="<?php echo base_url() . ADMINPANEL; ?>/settings/">Change Profile</a>
                        <!-- /.dropdown-user -->
                    </li>
                    <!-- /.dropdown -->
                </ul>
            </nav>


            <!-- start: Main Menu -->
            <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">

                        <?php $module = $this->router->fetch_module() ?>
                        <?php $method = $this->router->fetch_method() ?>


                        <?php
                        $moduleArry = array();
                        $childArry = array();

                        $showOnlyModuleArry = array();

                        foreach ($this->session->userdata('menuModuleArry') as $row) {

                            if (!empty($row->fk_module)) {
                                $childArry[$row->fk_module][] = $row->var_modulename;

                                if ($this->permissionArry[$row->var_modulename]['Add'] == 'N') {
                                    $row->var_module_form_listing = '';
                                }

                                if ($this->permissionArry[$row->var_modulename]['View'] == 'Y') {
                                    $showOnlyModuleArry[] = $row->fk_module;
                                }

                                $moduleArry[$row->fk_module]['child'][] = $row;
                            } else {
                                if ($this->permissionArry[$row->var_modulename]['Add'] == 'N') {
                                    $row->var_module_form_listing = '';
                                }

                                $moduleArry[$row->int_glcode]['parent'] = $row;
                                $childArry[$row->int_glcode][] = $row->var_modulename;
                            }
                        }


                        if (!empty($showOnlyModuleArry)) {
                            foreach ($showOnlyModuleArry as $showOnlyModule) {
                                if ($moduleArry[$showOnlyModule]['parent']->chr_assign != 'Y') {
                                    $moduleArry[$showOnlyModule]['parent']->show_only = true;
                                }
                            }
                        }


                        foreach ($moduleArry as $moduleID => $moduleMenu) {

                            if (!empty($moduleMenu['parent']) && !empty($moduleMenu['parent']->var_header_text)) {
                                $selected_page = '';
                                if (in_array($module, $childArry[$moduleMenu['parent']->int_glcode]) || in_array($module . '/' . $method, $childArry[$moduleMenu['parent']->int_glcode])) {
//                                                                    $selected_page = 'active';
                                }

//                        
                                if (($moduleMenu['parent']->chr_assign != 'Y' && !$moduleMenu['parent']->show_only)) {     // permission condition
                                } else {
                                    ?>

                                    <li class="<?php echo $selected_page; ?><?= $cls_selected ?>">
                                        <?php
//                                      print_r($moduleMenu);
                                        if ($moduleMenu['parent']->show_only) {
                                            ?>
                                            <a href="javascript:void(0);">
                                                <i class="<?php echo $moduleMenu['parent']->var_header_class; ?>"></i>

                                                <?php echo $moduleMenu['parent']->var_header_text; ?>
                                            </a>
                                            <?php
                                        } else {
                                            ?>
                                            <?php
                                            // start Bannner menu hide for client side 
//                                        $style = "";
                                            if ($moduleMenu['parent']->var_modulename == 'user_management/accesscontrol') {
                                                if ($this->session->userdata('userid') != 1) {
//                                                    $style = "display:none";
                                                }
                                            }


                                            // end   
                                            ?>
                                            <a href="<?php echo base_url() . 'adminpanel/' . $moduleMenu['parent']->var_modulename; ?>" style="<?php echo $style ?>">
                                                <i class="fa fa-dashboard"></i>
                                                <?php echo $moduleMenu['parent']->var_header_text; ?>
                                            </a> 
                                            <?php
                                        }
                                        ?>   

                                        <?php
                                        if (!empty($moduleMenu['parent']->var_module_listing)) {
                                            $selectedClass = '';
                                            if (strstr($moduleMenu['parent']->var_modulename, '/')) {
                                                $module_arry = explode("/", $moduleMenu['parent']->var_modulename);
                                                if ($module == $module_arry[0] && $method == $module_arry[1] && $this->uri->segment(4) != 'add') {
                                                    $selectedClass = 'active-menu';
                                                }
                                            } else if ($module == $moduleMenu['parent']->var_modulename && $method == 'index') {
                                                $selectedClass = 'active-menu';
                                            }
//                                            else if ($module == $moduleMenu['parent']->var_modulename && $method == 'add') {
//                                                $selectedClass = 'active-menu';
//                                            }

                                            $alsoParentClass = '';
                                            if (!empty($moduleMenu['parent']->var_module_form_listing)) {

                                                $alsoParentClass = 'dropdown_parent';
                                            }

                                            if ($moduleMenu['parent']->var_modulename != 'post_category' && $moduleMenu['parent']->var_modulename != 'campus_deal' && $moduleMenu['parent']->var_modulename == 'post_management' && MODULE == 'post_management' && $module == 'post_management' && $method == 'view') {
//                                            echo "dfafdsaf";
                                                $selectedClass1 = 'active-menu';
                                            }
                                            
                                             if ( $moduleMenu['parent']->var_modulename == 'campus_deal' && $moduleMenu['parent']->var_modulename != 'post_management' && MODULE == 'campus_deal' && $module == 'campus_deal' && $method == 'view') {
                                            
                                                $selectedClass1 = 'active-menu';
                                            }
                                            
                                              if ( $moduleMenu['parent']->var_modulename == 'campus_buzz' && $moduleMenu['parent']->var_modulename != 'post_management' && MODULE == 'campus_buzz' && $module == 'campus_buzz' && $method == 'view') {
                                            
                                                $selectedClass1 = 'active-menu';
                                            }
                                            
                                              if ($moduleMenu['parent']->var_modulename == 'post_management' && $module == 'post_gallery') {
//                                            echo "dfafdsaf";
                                                $selectedClass = 'active-menu';
                                            }
                                             if ($moduleMenu['parent']->var_modulename == 'campus_deal' && $module == 'campus_gallery') {
                                                $selectedClass = 'active-menu';
                                            }
                                            
                                             if ($moduleMenu['parent']->var_modulename == 'campus_buzz' && $module == 'campus_buzz_gallery') {
                                            
                                                $selectedClass = 'active-menu';
                                            }
                                            ?>


                                            <?php
                                            if ($this->session->userdata('userid') != 1) {
                                                $totalpagerow = $this->mylibrary->get_page_records_data();
                                                $totalrow = $this->mylibrary->CounttotalRows();
                                            }
                                            if ($this->session->userdata('userid') == 1) {
                                                $totalbannerrow = $this->mylibrary->CountbannerRows();
                                            }
//                                      // end
                                            ?>
                                            <!--<div class="dropdown_2columns dropdown_container">-->
                                            <ul class="nav nav-second-level">

                                                <?php
                                                if ($moduleMenu['parent']->chr_assign != 'Y') {
                                                    // permission condition
                                                } else {
//                                                    if ($module == 'photogallery') {
//                                                        $selectedClass = ($module == 'photogallery' && $moduleMenu['parent']->int_glcode == 120) ? 'active' : '';
//                                                    }
//                                                    if ($module == 'menus' && $_REQUEST['fk_category'] != '') {
//                                                        $selectedClass = ($module == 'menus' && $moduleMenu['parent']->int_glcode == 122) ? 'active' : '';
//                                                    }
//                                                    if ($module == 'videogallery') {
//                                                        $selectedClass = ($module == 'videogallery' && $moduleMenu['parent']->int_glcode == 119) ? 'active' : '';
//                                                    }
                                                    ?>

                                                    <?php if ($moduleMenu['parent']->var_modulename != 'post_category' && $moduleMenu['parent']->var_modulename != 'campus_deal' && $moduleMenu['parent']->var_modulename == 'post_management' && MODULE == 'post_management' && $module == 'post_management' && $method == 'view') { ?>
                                                        <li class=" <?php echo $alsoParentClass . ' ' . $selectedClass1 ?>">
                                                        <?php }elseif( $moduleMenu['parent']->var_modulename == 'campus_deal' && $moduleMenu['parent']->var_modulename != 'post_management' && MODULE == 'campus_deal' && $module == 'campus_deal' && $method == 'view'){ ?>
                                                        <li class=" <?php echo $alsoParentClass . ' ' . $selectedClass1 ?>"> 
                                                        <?php }elseif( $moduleMenu['parent']->var_modulename == 'campus_buzz' && $moduleMenu['parent']->var_modulename != 'post_management' && MODULE == 'campus_buzz' && $module == 'campus_buzz' && $method == 'view'){ ?>
                                                        <li class=" <?php echo $alsoParentClass . ' ' . $selectedClass1 ?>"> 
                                                        <?php } else { ?>
                                                            <li class=" <?php echo $alsoParentClass . ' ' . $selectedClass ?>">     
                                                            <?php } ?>        

                                                            <a href="<?php echo base_url() . 'adminpanel/' . $moduleMenu['parent']->var_modulename; ?>">
                                                                <i class="icon-angle-right"></i>
                                                                <?php echo $moduleMenu['parent']->var_module_listing; ?></a>
                                                            <?php
                                                            if (!empty($moduleMenu['parent']->var_module_form_listing)) {
//                                                            echo $module; die;
                                                                $selectedClass = '';
                                                                $style = '';
//                                                            echo $moduleMenu['parent']->var_modulename; die;
//                                                            user_management/accesscontrol

                                                                if ($module == $moduleMenu['parent']->var_modulename && $method == 'add') {
                                                                    $selectedClass = 'active-menu';
                                                                }

                                                                if ($moduleMenu['parent']->var_modulename == 'user_management/accesscontrol' && $method == 'accesscontrol' && $this->uri->segment(4) == 'add') {
                                                                    $selectedClass = 'active-menu';
                                                                }
                                                                ?>

                                                                <!--<ul class="dropdown_flyout_level">-->
                                                                <li>

                                                                    <a class="submenu <?= $selectedClass ?>" href="<?php echo base_url() . 'adminpanel/' . $moduleMenu['parent']->var_modulename . '/add'; ?>" style="<?= $style ?>">
                                                                        <i class="icon-angle-right"></i>
                                                                        <?php echo $moduleMenu['parent']->var_module_form_listing; ?>
                                                                    </a>
                                                                </li>
                                                                <!--</ul>-->

                                                                <?php
                                                            }
//                                                     
                                                            ?>
                                                        </li>

                                                        <?php
                                                    }
                                                    ?>


                                                    <?php
                                                    if (!empty($moduleMenu['child'])) {
                                                        foreach ($moduleMenu['child'] as $childMenu) {
                                                            $selectedClass = '';
//                                                                echo $module_arry[0] ;
                                                            if (strstr($childMenu->var_modulename, '/')) {
                                                                $module_arry = explode("/", $childMenu->var_modulename);
                                                                if ($module == $module_arry[0] && $method == $module_arry[1]) {
                                                                    $selectedClass = 'active-menu';
                                                                }
                                                            } else if ($module == $childMenu->var_modulename && $method == 'index') {
                                                                $selectedClass = 'active-menu';
                                                            } else if ($module == $childMenu->var_modulename && $method == 'add') {
                                                                $selectedClass = 'active-menu';
                                                            }

                                                            $alsoParentClass = '';
                                                            if (!empty($childMenu->var_module_form_listing)) {
//                                                                                            $alsoParentClass = 'dropdown_parent';
                                                            }

                                                            if ($childMenu->chr_assign != 'Y') {   // permission condition
                                                            } else {
//                                                            if ($this->session->userdata('userid') != 1) {
//                                                                if ($childMenu->var_module_listing == "Manage Email Templates" || $childMenu->var_module_listing == "Manage Trash Manager" || $childMenu->var_module_listing == "Manage Powerpanel Banners") {
//                                                                    $style = 'style="display:none;"';
//                                                                } else {
//                                                                    $style = '';
//                                                                }
////                                                            }
//                                                            if ($module == 'photogallery') {
//                                                                $selectedClass = ($module == 'photogallery' && $childMenu->int_glcode == 120) ? 'active' : '';
//                                                            }
//                                                      if ($module == 'menus' && $_REQUEST['fk_category'] != '') {
//                                                        $selectedClass = ($module == 'menus' && $moduleMenu['parent']->int_glcode == 122) ? 'active' : '';
//                                                    }
//                                                            if ($module == 'videogallery') {
//                                                                $selectedClass = ($module == 'videogallery' && $childMenu->int_glcode == 119) ? 'active' : '';
//                                                            }
                                                                ?>

                                                                <li class="<?php echo $alsoParentClass . ' ' . $selectedClass ?>" <?php echo $style; ?> >
                                                                    <a <?php echo $style; ?> href="<?php echo base_url() . 'adminpanel/' . $childMenu->var_modulename; ?>"><i class="icon-angle-right"></i><?php echo $childMenu->var_module_listing; ?></a>
                                                                    <?php
                                                                    if (!empty($childMenu->var_module_form_listing)) {
                                                                        $selectedClass = '';
                                                                        if ($module == $childMenu->var_modulename && $method == 'add') {
                                                                            $selectedClass = 'active';
                                                                        }
                                                                        ?>
                                                                        <ul class="dropdown_flyout_level">
                                                                            <li class="<?= $selectedClass ?>"><a href="<?php echo base_url() . 'adminpanel/' . $childMenu->var_modulename . '/add'; ?>"><b class="icon-angle-right"></b><?php echo $childMenu->var_module_form_listing; ?></a></li>
                                                                        </ul>

                                                                        <?php
                                                                    }
                                                                    ?>  
                                                                </li>
                                                                <?php
                                                            }
                                                        }
                                                    }
                                                    ?>

                                            </ul>                       
                                            <!--</div>-->


                                            <?php
                                        }
                                        ?>
                                    </li>
                                    <?php
                                }  // permission condition end 
                            }
                        }
                        ?>



                    </ul>

                </div>
            </nav>
