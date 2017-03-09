<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <title>AdminPanel</title>

        <!--**************************************** NEW *****************************-->

        <!-- start: CSS -->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/bootstrap.css" rel="stylesheet" />
        <!-- FontAwesome Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/font-awesome.css" rel="stylesheet" />
        <!-- Morris Chart Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
        <!-- Custom Styles-->
        <link href="<?php echo ADMIN_MEDIA_URL; ?>new/css/custom-styles.css" rel="stylesheet" />
        <!-- Google Fonts-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />


        <!-- start: Favicon -->
        <link rel="shortcut icon" href="<?php echo ADMIN_MEDIA_URL; ?>new/img/favicon.ico">
            <!-- end: Favicon -->

            <style type="text/css">
                body { background: url(<?php echo ADMIN_MEDIA_URL; ?>new/img/bg-login.jpg) !important; }
            </style>


<!--<link type="text/css" href="<?= ADMIN_MEDIA_URL ?>css/style.css" rel="stylesheet" />--> 
            <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/jquery-1.4.4.min.js"></script>
            <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/ajaxfunctions.js"></script>
            <script language="JavaScript">


                function checkemail(str)
                {
                    var testresults;
                    var filter = /^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*@[0-9a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){1}[a-zA-Z]{2,4})+$/i

                    if (filter.test(str))
                        testresults = true
                    else
                        testresults = false

                    return (testresults)
                }

                $(document).ready(function () {
                    $("#ss_username").keyup(function () {
                        if ($('#ss_username').val().match(/^.*[^\s{1,}]\s.*/) || ($('#ss_username').val() == '')) {
                            $('#ss_username').val($.trim($('#ss_username').val()));
                            return false;
                        }
                    });
                });


                function ChkValid()
                {
//                    alert("sdfadsf"); 
                    //                if(trim(document.getElementById('ss_username').value)=="")
                    //                {
                    //                    alert("Please enter your Email ID.");
                    //                    document.getElementById('ss_username').focus();
                    //                    return false;
                    //                }
                    //                else if(!checkemail(trim(document.getElementById('ss_username').value)))
                    //                {
                    //                    alert("Please enter valid Email ID.");
                    //                    document.getElementById('ss_username').focus();
                    //                    return false;
                    //                }
                    var email = document.getElementById('ss_username');
                    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

                    if (!filter.test(email.value)) {
                        alert('Please provide a valid email address');
                        email.focus;
                        return false;
                    }
                    else if (document.getElementById('ss_password').value == "")
                    {
                        alert("Please enter your password.");
                        document.getElementById('ss_password').focus();
                        return false;
                    }
                   
                    document.getElementById('h_save').value = 'T';
                    return true;
                }

                function setHeight()
                {
                    var height = document.documentElement.clientHeight;

                    document.getElementById('container').setAttribute('height', height);
                }
            </script>

            <style>
                .display-message{background:#F1B1B4; border:1px solid #CC0000; font:bold 12px Arial,Helvetica,sans-serif; text-align:center; color:#000000; padding:10px 0; display:none;}
            </style>
    </head>
    <body>
        <div id="wrapper" style="background: #e5ebf2; ">
            <div id="page-wrapper" style="min-height:500px !important;" >
                <div id="page-inner" >
                    <?php
                    $LoginCookie = $this->mylibrary->requestGetCookie('tml_CookieLogin', array());
                    $username = "";
                    $passowrd = "";
                    $chkrememberme = "";

                    if (!empty($LoginCookie)) {
                        $username = $LoginCookie['user'];
                        $passowrd = $LoginCookie['pwd'];
                        $chkrememberme = $LoginCookie['chkrememberme'];
                    }
                    ?>


                    <div class="row">
                        <div class="col-md-8">
                            <div class="panel panel-default">
                                <div class="alert alert-info">
                                    <strong>Login to your AdminPanel</strong>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-6">
                                    <!--<form class="form-horizontal" action="index.html" method="post">-->
                                    <form  method="post" name="logform" id="logform" onSubmit="return ChkValid();" action ="<?php echo ADMINPANEL_URL; ?>login/process">

                                        <?php
                                        if (!empty($message)) {

                                            $style = 'style="display:block;"';
                                        } else {
                                            $style = 'style="display:none;"';
                                        }
                                        ?>


                                        <div class="form-group" title="Username">
                                         <label>User Name: </label>
                                            <input class="form-control" name="ss_username" id="ss_username" type="text" placeholder="type username" value="<?php echo $username ?>"/>
                                            <input name="h_save" type="hidden" class="login-textbox" id="h_save" value="F" />
                                            <input type="hidden" name="gotopath" class="login-textbox" value="<?php echo ($this->input->get('gotopath')); ?>" />
                                        </div>

                                        <div class="form-group" title="Password">
                                          <label>Password: </label>
                                            <input class="form-control" name="ss_password" id="ss_password" type="password" value="<?php echo $passowrd; ?>" placeholder="type password"/>
                                        </div>

                                            <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="chkrememberme" id="chkrememberme" <?php echo ($chkrememberme == "1") ? "checked" : ""; ?> /> Remember me</label>
                                            </div>
                                            <button type="submit" id="login" class="btn btn-primary">Login</button>

                                    </form>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="footer-container" style="position:fixed; bottom:0; width:100%; margin:-36px 0 0 0;">

                        <div class="footer">
                            <!--<div class="footer-version">Version 5.0</div>-->
                            <div class="footer-copyright">Copyright &copy; <?php echo date('Y'); ?> &nbsp;&nbsp;Thriftskool</div>
                        </div>
                    </div>

                    <?php
                    if (!empty($message)) {
                        ?>
                        <script type="text/javascript">
                            alert("Login failed. Please try again.");
                        </script>
                    <?php } ?>

                    <script type="text/javascript">
                        document.getElementById("ss_username").focus();
                    </script>

                </div>
            </div>
        </div>  


    </body>
</html>