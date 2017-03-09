<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <!--<link type="text/css" href="<?= base_url(); ?>admin-media/css/style.css" rel="stylesheet" />--> 
    <script type="text/javascript">
        $.validator.addMethod('mypassword', function (value, element) {
            return this.optional(element) || (value.match(/[a-zA-Z]/) && value.match(/[0-9]/) && (value.match(/[!-/]/) || value.match(/[:-@]/) || value.match(/[[-`]/) || value.match(/[{-~]/)));
        },
                '<?php echo CP_PASSWORD ?>');

        $.validator.addMethod('checkmultipleemail', function (value, element) {

            var Email = value.split(",");
            var count = Email.length;
            var flag = true;
            var i;
            for (i = 0; i < count; i++) {

                if (!checkemail(Email[i])) {
                    flag = false;
                }
            }
            return flag;
        },
                'Please enter valid email ids.');
        $.validator.addMethod("passwordvalidation", function (value, element) {

            var myString = trim(document.getElementById('pwdpassword').value);
            var digitString = myString.replace(/[^0-9]/g, "").length;
            var charString = myString.replace(/[^A-Z]/g, "").length;

            //            if($("#pwdpassword").val() = ''){
            //                return true;
            //            }
            if (digitString < 1 || charString < 1) {
                return false;
            } else {
                return true;
            }
        }, '<?php echo PASSWORD_VALID_VALIDATION ?>');



        $(document).ready(function () {


            $("#frmchangeprofile").validate({
                rules: {
                    var_fullname: {
                        required: true
                    },
                    txtemail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    txtemail1: {
                        required: true,
                        checkmultipleemail: true
                    },
                    var_suppliername: {
                        required: true
                    },
                    var_suppliarmail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    var_orderleadsemail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    var_contactusmail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    var_newsletteremail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    var_careermail: {
                        required: true,
                        checkmultipleemail: true
                    },
                    pwdpassword: {
                        minlength: 8,
                        maxlength: 20,
                        passwordvalidation: {
                            depends: function () {
                                if ($("#pwdpassword").val() == '' && $("#pwdconfirmpassword").val() == '')
                                {
                                    return false;
                                }
                                else
                                {
                                    return true;
                                }
                            }
                        }

                    },
                    pwdconfirmpassword: {
                        minlength: 8,
                        maxlength: 20,
                        equalTo: "#pwdpassword"
                    }
                },
                messages: {
                    var_fullname: '<?= CP_FULL_NAME ?>',
//                    txtfname :'<?= CP_FIRST_NAME ?>',
                    txtemail: {
                        required: '<?= CP_EMAIL ?>',
                        email: '<?php echo CP_EMAIL_VALID ?>'
                    },
                    txtemail1: {
                        required: '<?= CP_PEMAIL ?>',
                        email: '<?php echo CP_PEMAIL_VALID ?>'
                    },
                    /*var_defaultemailid: {
                     required: '<?= CP_DEFAULT_EMAIL ?>',
                     email: '<?php echo CP_DEFAULT_EMAIL_VALID ?>'
                     },*/
                    var_suppliername: {
                        required: 'Please enter supplier name.'

                    },
                    var_suppliarmail: {
                        required: '<?= CP_SUPPLIER_EMAIL ?>',
                        email: '<?php echo CP_SUPPLIER_EMAIL_VALID ?>'
                    },
                    var_orderleadsemail: {
                        required: 'Please enter order/reorder email id.',
                        email: 'Please enter valid order/reorder email id'
                    },
                    var_contactusmail: {
                        required: '<?= CP_CONTACT_EMAIL ?>',
                        email: '<?php echo CP_CONTACT_EMAIL_VALID ?>'
                    },
                    var_newsletteremail: {
                        required: '<?= CP_NEWS_EMAIL ?>',
                        email: '<?php echo CP_NEWS_EMAIL_VALID ?>'
                    },
                    var_careermail: {
                        required: 'Please enter career email id',
                        email: 'Please enter valid email ids'
                    },
                    pwdpassword: {
                        minlength: "<?php echo PASSWORD_LIMIT ?>",
                        maxlength: "<?php echo PASSWORD_MAX_LIMIT ?>"

                    },
                    pwdconfirmpassword: {
                        minlength: "<?php echo PASSWORD_LIMIT ?>",
                        maxlength: "<?php echo PASSWORD_MAX_LIMIT ?>",
                        equalTo: "<?php echo CONF_PASSWORD_EQUAL ?>"
                    }
                }
            });
        });

        function validemail(str)
        {
            var email = new Array();
            email = str.split(',');

            for (i = 0; i < email.length; i++)
            {
                if (!checkemail(email[i]))
                {
                    return false;
                }

            }
            return true;
        }


        function checkuser(userid, eid)
        {
            xmlHttp = GetXmlHttpObject();
            if (xmlHttp == null)
            {
                alert("Browser does not support HTTP Request.");
                return;
            }
            var url = "adminpanel?module=settings&view=system&action=checksame&userid=" + userid + "&eid=" + eid;
            xmlHttp.open("GET", url, false);
            xmlHttp.send(null);
            return trim(xmlHttp.responseText);
        }

    </script>
    <!--===========================================Password policy validation ==============================================-->
    <style>

        a:hover
        {
            color:#fff;
        }

        #user_registration
        {
            border:1px solid #cccccc;
            margin:auto auto;
            /*margin-top:100px;*/
            /*width:400px;*/
        }


        #user_registration label
        {
            display: block;   block float the labels to left column, set a width 
            /*float: left;*/ 
            /*width: 70px;*/
            /*margin: 0px 10px 0px 5px;*/ 
            text-align: right; 
            line-height:1em;
            font-weight:bold;
        }

        #user_registration input
        {
            /*width:250px;*/
        }

        #user_registration p
        {
            clear:both;
        }

        #submit
        {
            border:1px solid #cccccc;
            width:100px !important;
            margin:10px;
        }

        h1
        {
            text-align:center;
        }

        #passwordStrength
        {
            height:10px;
            /*  display:block;
              float:left;*/
        }

        .strength0
        {
            width:250px;
            background:#cccccc;
        }

        .strength1
        {
            width:50px;
            background:#ff0000;
        }

        .strength2
        {
            width:100px;	
            background:#ff5f5f;
        }

        .strength3
        {
            width:150px;
            background:#FF4500;
        }

        .strength4
        {
            background:#4dcd00;
            width:200px;
        }

        .strength5
        {
            background:#399800;
            width:250px;
        }


    </style>
    <script>
        function passwordStrength(password)
        {

            if (password == '')
            {

                document.getElementById("passworddisplay").style.display = 'none';
            }
            else {
                document.getElementById("passworddisplay").style.display = '';
            }
            var desc = new Array();
            desc[0] = "Very Weak";
            desc[1] = "Weak";
            desc[2] = "Better";
            desc[3] = "Medium";
            desc[4] = "Strong";
            desc[5] = "Strongest";


            var score = 0;

            //if password bigger than 6 give 1 point
            if (password.length > 6)
                score++;

            //if password has both lower and uppercase characters give 1 point	
            if ((password.match(/[a-z]/)) && (password.match(/[A-Z]/)))
                score++;

            //if password has at least one number give 1 point
            if (password.match(/\d+/))
                score++;

            //if password has at least one special caracther give 1 point
            if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/))
                score++;

            //if password bigger than 12 give another 1 point
            if (password.length > 12)
                score++;

            document.getElementById("passwordDescription").innerHTML = desc[score];
            document.getElementById("passwordStrength").className = "strength" + score;
        }
    </script>
    <!--====================================================================================================================================-->
    <style>

        .textarea1{

            height:17px;   
        }
    </style>    
    <!--============================================================================================-->
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h1 style="text-align: left" class="page-header">
                    Change Profile
                </h1>
            </div>
        </div> 


        <?php echo validation_errors(); ?>
        <?php
        if ($messagebox != '') {
            echo $messagebox;
        }
        ?>



        <?php
        $action = MODULE_URL . 'insert_changeprofile';
        ?>   

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Personal Information
                    </div>
                    <?php
                    $attributes = array('name' => 'frmchangeprofile', 'id' => 'frmchangeprofile', 'enctype' => 'multipart/form-data');
                    echo form_open($action, $attributes);
                    ?>

                    <input type="hidden" name="int_glcode" id="int_glcode" value="" />
                    <input type="hidden" name="eid" id="eid" value="" />


                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-10">

                                <div class="form-group">
                                    <label style="text-align:center" for="var_fullname" class="col-sm-4 control-label">Full Name </label><small style="color: red">*</small>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="var_fullname" id="var_fullname" value="<?php echo trim($var_fullname) ?>" >
                                    </div>
                                </div>
                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="txtemail" class="col-sm-4 control-label">Login ID</label><small style="color: red">*</small>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="txtemail" id="txtemail" value="<?php echo htmlspecialchars($var_emailid) ?>" >
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="txtemail1" class="col-sm-4 control-label">Personal Email ID</label><small style="color: red">*</small>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="txtemail1" id="txtemail1" value="<?php echo htmlspecialchars($var_emailid1); ?>">
                                    </div>
                                </div>


                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="pwdpassword" class="col-sm-4 control-label">New Password</label><small style="color: red">*</small>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control" name="pwdpassword" type="password" maxlength="20" id="pwdpassword" type="password" onkeyup="passwordStrength(this.value)">
                                            <br><div id="passworddisplay" style="display:none;">
                                                    <td>
                                                        <table style="width: 250px;">
                                                            <tr>
                                                                <td  for="passwordStrength">Password strength - </td>
                                                                <td id="passwordDescription">Password not entered
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" id="passwordStrength" class="strength0"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </div>
                                                </div>

                                                </div>


                                                <div style="height:15px; width:100%;"></div>
                                                <div class="form-group" style="padding-top:  43px">
                                                    <label style="text-align:center" for="pwdconfirmpassword" class="col-sm-4 control-label">Confirm Password</label>
                                                    <div class="col-sm-6">
                                                        <input maxlength="20"  type="password" class="form-control" name="pwdconfirmpassword" id="pwdconfirmpassword"  >
                                                    </div>
                                                    <br><br><span style="color:#0B336A;">
                                                                Note: Password should be in between 8 to 20 characters long and
                                                                must contain at least one capital, alphabet and numeric. 
                                                            </span>
                                                            </div>

                                                            <div class="form-group" >
                                                                <label for="var_phoneno" style="text-align:center" class="col-sm-4 control-label">Phone#</label>
                                                                <div class="col-sm-6">
                                                                    <input type="text" class="form-control" name="var_phoneno" id="var_phoneno" value="<?php echo $rowadminData['var_phoneno']; ?>" >
                                                                </div>
                                                            </div>
                                                <div class="col-sm-12" style="margin-top: 50px; " align="center">
                                                  <button type="submit" alt="Submit" class="btn btn-default">Submit Button</button>
                                                      <a class="btn btn-default" href="<?php echo ADMINPANEL_HOME_URL; ?>">Reset Button</a></button>
                                                 </div>
                                                            </div>

                                                            </div>
                                                            <!-- /.col-lg-6 (nested) -->
                                                            </div>
                                                            <!-- /.row (nested) -->

                                                           
<!--                                                            <table width="160" border="0" align="center" cellpadding="2" cellspacing="2">
     <tr>
         <td height="30" align="center" valign="middle">
             <input type="image"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image34', '', '<?= ADMIN_MEDIA_URL; ?>images/submit-button-blue-hover.gif', 1)" src="<?= ADMIN_MEDIA_URL ?>images/submit-button-blue.gif" alt="Submit" name="Image34" width="81" height="25" border="0" id="Image34"/>       
             
             <div class="clear"></div>
         </td>
         <td width="30" align="center" valign="middle">&nbsp;</td>
         <td align="center" valign="middle">
             <a href="<?php echo ADMINPANEL_HOME_URL; ?>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image35', '', '<?= ADMIN_MEDIA_URL ?>images/cancel-button.jpg', 1)"><img src="<?= ADMIN_MEDIA_URL ?>images/cancel-button.jpg" alt="Reset" name="Image35" border="0" id="Image35" /></a></td>
     </tr>
 </table>-->

                                                            </form>
                                                            </div>
                                                            <!-- /.panel-body -->
                                                            </div>
                                                            <!-- /.panel -->
                                                            </div>
                                                            <!-- /.col-lg-12 -->
                                                            </div>

                                                            </div>



