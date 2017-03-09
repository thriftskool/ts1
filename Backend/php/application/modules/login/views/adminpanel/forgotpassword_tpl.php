<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>AdminPanel</title>
        <link rel="stylesheet" type="text/css" href="<?= ADMIN_MEDIA_URL; ?>css/style.css" />
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/jquery/jquery-1.4.4.min.js"></script>
        <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/ajaxfunctions.js"></script>
        <script language="JavaScript">
            function checkemail(str)
            {
                var testresults;
               
                var filter=/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/i;

                if (filter.test(str))
                    testresults=true
                else
                    testresults=false

                return (testresults)
            }
            
            $(document).ready(function() { 
            $("#ss_username").keyup(function() {
                if($('#ss_username').val().match(/^.*[^\s{1,}]\s.*/)||($('#ss_username').val()=='')) {
                    $('#ss_username').val($.trim($('#ss_username').val()));
                     return false;
                }
             });
        });

            function ChkValid()
            {
                if(document.getElementById('ss_username').value=="")
                {
                    alert("Please enter Email ID.");
                    document.getElementById('ss_username').focus();
                    return false;
                }
                else if(!checkemail(document.getElementById('ss_username').value))
                {
                    alert("Please enter valid Email ID.");
                    document.getElementById('ss_username').focus();
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
        <div id="page-container">
            <div id="logo">
                <!--<div class="logo">
                <a href="<?php echo ADMINPANEL_URL; ?>"><img src="<?= ADMIN_MEDIA_URL; ?>images/powerpanel_logo.png"  alt="adminpanel" /></a></div>-->
                <div class="links" > <br />
                    <br />
                    <div class="welcome-main" style="width:255px;">
                        <div class="welcome-text">
                            <?= date("d-F-Y"); ?>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div class="middle-main">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>

                        <td width="5%" align="left" valign="top">&nbsp;</td>
                        <td width="1%" align="left" valign="top">&nbsp;</td>
                        <td align="left" valign="top" width="93%">

                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="40" align="left" valign="top">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center" valign="top" class="login-heading-text" style="padding-bottom: 20px">Welcome To Adminpanel</td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>

                                                
                                                <td width="13%">&nbsp;</td>
                                                <td width="27%">

                                                    <form method="post" name="logform" id="logform" onSubmit="return ChkValid();" action="<?php echo POWERPANEL_URL; ?>login/forgetpassprocess">
                                                        <table width="400" border="0" align="center" cellpadding="0" cellspacing="0" class="login-border">
                                                            <tr>
                                                                <td height="35" colspan="2" align="left" valign="middle" class="login-top">Forgot Password</td>
                                                            </tr>
                                                           
                                                            <tr>
                                                                <td width="128" align="left" valign="middle" class="add-new-user-text"><br />
                                                                    Email ID: <span>(required)</span></td>
                                                                <td width="220" align="left" valign="middle"><br />
                                                                    <input name="ss_username" type="text" class="login-textbox" id="ss_username" />
                                                                    <input name="h_save" type="hidden" class="login-textbox" id="h_save" value="F" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" valign="middle">&nbsp;</td>
                                                                <td align="left" valign="middle" style="padding-top:10px;">
                                                                    <input name="login" type="image" id="login" src="<?= ADMIN_MEDIA_URL; ?>images/submitforgot.jpg" border="0" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" valign="middle">&nbsp;</td>
                                                                <td align="left" valign="middle" class="login-text1"><a href="<?php echo ADMINPANEL_URL; ?>">Click here to Login</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="left" valign="middle">&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </form>
                                                </td>
                                                <td width="12%"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
           <div class="spacer30"></div>
            <div class="w85pr">
                 <link rel="stylesheet" type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>css/slider/jquery.bxslider.css" />
            <script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/slider/jquery.bxslider.js"></script>

            <script type="text/javascript">
                $(document).ready(function(){
                    $('#adv-banner').bxSlider({
                        mode: 'fade',
                        auto: true,
                        autoControls: false,
                        pause: 5000,
                        controls:false,
                        pager:false
                    });
                });
            </script>   
           
     </div>
     </div>
        </div>
       
        <div id="footer-container" style="position:fixed; bottom:0; width:100%;">

            <div class="footer">
                <!--<div class="footer-version">Version 5.0</div>-->
                <div class="footer-copyright">Copyright &copy; <?= date('Y'); ?> &nbsp;&nbsp;<a href="http://www.etilox.com/" target="_blank" style="font-size: 14px">Etilox</a></div>
            </div>
        </div>
        
                <?php
        if ($message != '') {
            ?>
            <script type="text/javascript">
                alert('<?=$message?>');
                document.getElementById("ss_username").focus(); 
            </script>
        <?php } ?>

        <script type="text/javascript"> 
            document.getElementById("ss_username").focus(); 
        </script>
    </body>
</html>
