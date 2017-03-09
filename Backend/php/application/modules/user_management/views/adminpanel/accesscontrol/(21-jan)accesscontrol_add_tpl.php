<script type="text/javascript">
//    hs.graphicsDir = '<?php echo ADMIN_MEDIA_URL; ?>js/highslide/graphics/';
//    hs.align = 'center';

    function Check_user_email() {
    var eid = $('#eid_intglcode').val();
            var user_email = $('#var_emailid').val();
            var domainname = $('#var_domainname').val();
            var user_email_exits;
            $.ajax({
            type: "GET",
                    url: "<?php echo MODULE_PAGE_NAME ?>/Check_Email?&user_email=" + user_email + "&eid=" + eid + "&domainname=" + domainname,
                    async: false,
                    success: function (data) {
//            alert(data);
                    Chkdata = data;
                    }
            });
            return Chkdata;
            //return user_email_exits;
    }
    
    function Check_user_Name() {
    var eid = $('#eid_intglcode').val();
            var user_name = $('#var_username').val();
            var user_name_exits;
            $.ajax({
            type: "GET",
                    url: "<?php echo MODULE_PAGE_NAME ?>/Check_user_Name?&user_name=" + user_name + "&eid=" + eid,
                    async: false,
                    success: function (data) {
//            alert(data);
                    Chkdata1 = data;
                    }
            });
            return Chkdata1;
            //return user_email_exits;
    }
    function displayUserInfo(id)
    {


    $.ajax({
    type: "GET",
            url: "<?php echo MODULE_PAGE_NAME ?>/selectUniversityInfo?&uni_id=" + id,
//            data: "module=business&action=quickuseradd&sub=userinfo&userid="+id,
            async: false,
            success: function (data)
            {
            var resdata = data.split('***');
                    document.getElementById('var_domainname').value = resdata[0];
                    document.getElementById('var_hidemail').value = resdata[0];
//                document.getElementById('var_phone').value=resdata[1];

            }
    });
    }

</script>
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
            }, 'Please enter valid email ids.');
            
             $.validator.addMethod("passwordvalidation", function(value, element){
            
            var myString=trim(document.getElementById('var_password').value);
            var digitString = myString.replace(/[^0-9]/g , "").length;
            var charString = myString.replace(/[^A-Z]/g, "").length;
            
            if(digitString < 1 || charString < 1){
                return false;
            }else{
                return true;
            }
        },'<?php echo PASSWORD_VALID_VALIDATION ?>');
        
            
              $.validator.addMethod("ExistUserName", function (value, element) {
            var Chkdata1 = Check_user_Name();
                    if (trim(Chkdata1) > 0)
            {
            return false;
            }
            else
            {
            return true;
            }

            }, 'This usename already exits');
            
            
            $(document).ready(function () {

    $.validator.addMethod("ExistEmail", function (value, element) {
    var Chkdata = Check_user_email();
            if (trim(Chkdata) > 0)
    {
    return false;
    }
    else
    {
    return true;
    }

    }, '<?php echo EXIST_EMAIL_ID ?>');
            $("#frmuser").validate({
    rules: {
    fk_university: {
    required: true
    },
            var_emailid: {
            required: true,
//                    email: true,
                    ExistEmail: true
            },
              var_username:{
            required: true,
                    ExistUserName: true
            },
            var_password: {
            required: false,
<?php if (empty($eid)) { ?>
                required: true,
<?php } ?>
//                                                required: false,
            minlength: 8,
                    maxlength: 25,
                    passwordvalidation : true
            },
            var_cnfpassword: {
            required: false,
<?php if (empty($eid)) { ?>
                required: true,
<?php } ?>
//                                                required: false,
            minlength: 8,
                    maxlength: 25,
                    passwordvalidation : true,
                    equalTo: "#var_password"
            }


    },
            messages: {
            fk_university: 'Please select university name',
                    var_emailid: {
                    required: 'Please enter email name',
                            email: '<?php echo CP_PEMAIL_VALID ?>'
                    },
                               var_username: {
                    required: 'Please enter user name',
                    },
                    var_password:{
<?php if (empty($eid)) { ?>
                        required : "<?php echo PASSWORD_VALIDATION ?>",
<?php } ?>
                    minlength : "<?php echo PASSWORD_LIMIT ?>",
                            maxlength : "<?php echo PASSWORD_MAX_LIMIT ?>",
                    },
                    var_cnfpassword:{
<?php if (empty($eid)) { ?>
                        required: "<?php echo CONF_PASSWORD_VALIDATION ?>",
<?php } ?>
                    minlength : "<?php echo PASSWORD_LIMIT ?>",
                            maxlength : "<?php echo PASSWORD_MAX_LIMIT ?>",
                            equalTo : "<?php echo CONF_PASSWORD_EQUAL ?>",
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

<div class="breadcrumbs">
    <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp; 
    <!--<a href="<?php echo SITE_PATH ?>adminpanel/university_management">Products </a>&nbsp;&gt;&nbsp;-->
    <a href="<?= MODULE_PAGE_NAME ?>">Manage Users </a>&nbsp; &gt;&nbsp; 
    <?php
    if (!empty($eid)) {
        ?><span class="current">Edit User</span>  <?php
    } else {
        ?><span class="current">Add User</span> <?php
    }
    ?>

</div>

<div id="page-inner">
    <?php echo validation_errors(); ?>
    <?php
    if ($messagebox != '') {
        echo $messagebox;
    }
    ?>

    <?php
    if (!empty($row['var_emailid'])) {
        $edit = ' - ' . $row['var_emailid'];
    }
    ?>
    <div class="row" >
        <div  class="col-md-12" style="height:75px">
            <h1 style="text-align: left; color: #333333" class="page-header">
                <?php
                if (!empty($eid)) {
                    ?>Edit User   <?php echo $edit; ?><?php
                } else {
                    ?>Add User  <?php
                }
                ?>
            </h1>
        </div>
    </div> 



    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    User Information
                </div>
                <?php
                $attributes = array('name' => 'frmuser', 'id' => 'frmuser', 'enctype' => 'multipart/form-data');
                echo form_open($action, $attributes);
                ?>

                <input type="hidden" id="ehintglcode" name="ehintglcode" value="<?= $eid ?>" />
                <input type="hidden" name="eid_intglcode" id="eid_intglcode" value="<?php echo $row['int_glcode'] ?>"  />


                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-10">

                            <!--                                <div class="form-group" style="padding-top:  10px">
                                                                <label style="text-align:center" for="txtemail" class="col-sm-4 control-label">Login ID</label><small style="color: red">*</small>
                                                                <div class="col-sm-6">
                                                                    <input type="text" class="form-control" name="txtemail" id="txtemail" value="<?php echo htmlspecialchars($var_emailid) ?>" >
                                                                </div>
                                                            </div>-->
                            <div class="form-group">
                                <label style="text-align:center" for="var_emailid" class="col-sm-4 control-label">Select University Name</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <?php echo $University_Combo; ?>
                                </div>
                            </div>
                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_emailid" class="col-sm-4 control-label">Email Address</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <?php
                                    if (!empty($eid)) {
                                        $Email_Id = strstr($row['var_emailid'], "@", true);
                                    }
                                    ?>
                                    <input type="text" class="form-control" name="var_emailid" id="var_emailid" value="<?php echo $Email_Id; ?>">
                                </div>
                            </div>

                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_emailid" class="col-sm-4 control-label"></label>
                                <div class="col-sm-6">
                                    <?php
                                    if (!empty($eid)) {
                                        $Domain_Id = strstr($row['var_emailid'], "@");
                                        ?>
                                        <input name="var_domainname" type="text" disabled="disabled" class="form-control" id="var_domainname" value="<?php echo $Domain_Id; ?>" maxlength="100" />
                                        <input name="var_hidemail"  type="hidden" class="form-control" id="var_hidemail" value="<?php echo $Domain_Id; ?>" maxlength="100" />
                                    <?php } else { ?>
                                        <input name="var_domainname" type="text" disabled="disabled" class="form-control" id="var_domainname" value="<?= $row['var_emailid']; ?>" maxlength="100" />
                                        <input name="var_hidemail"  type="hidden" class="form-control" id="var_hidemail" value="<?= $row['var_emailid']; ?>" maxlength="100" />

                                    <?php }
                                    ?>

                                </div>
                            </div>

                                <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_username" class="col-sm-4 control-label">Username</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_username" id="var_username" value="<?php echo $row['var_username']; ?>">
                                </div>
                            </div>
                            
                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="pwdpassword" class="col-sm-4 control-label">
                                    <?php
                                    $PWDLabelData = array(
                                        'label' => 'New Password',
                                        'tdoption' => Array('TDDisplay' => 'Y')
                                    );
                                    echo form_input_label($PWDLabelData);
                                    ?>
                                </label>

                                <small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <?php
                                    $PWDBoxdata = array(
                                        'name' => 'var_password',
                                        'id' => 'var_password',
                                        'value' => $this->mylibrary->decryptPass($row['var_password']),
                                        'maxlength' => '25',
                                        'tdoption' => Array('TDDisplay' => 'Y'),
                                        'onkeyup' => 'passwordStrength(this.value)',
                                        'class' => 'form-control'
                                    );
                                    echo form_input_ready($PWDBoxdata, 'password');
                                    ?>
                                    <!--<input type="password" class="form-control" name="pwdpassword" type="password" maxlength="20" id="pwdpassword" type="password" onkeyup="passwordStrength(this.value)">-->
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
                                <label style="text-align:center" for="pwdconfirmpassword" class="col-sm-4 control-label">
                                    <?php
                                    $CPWDLabelData = array(
                                        'label' => 'Confirm Password',
                                        'tdoption' => Array('TDDisplay' => 'Y')
                                    );
                                    echo form_input_label($CPWDLabelData);
                                    ?>
                                </label>
                                <div class="col-sm-6">
                                    <?php
                                    $CPWDBoxdata = array(
                                        'name' => 'var_cnfpassword',
                                        'id' => 'var_cnfpassword',
                                        'value' => $this->mylibrary->decryptPass($row['var_password']),
                                        'maxlength' => '25',
                                        'tdoption' => Array('TDDisplay' => 'Y'),
                                        'class' => 'form-control'
                                    );
                                    echo form_input_ready($CPWDBoxdata, 'password');
                                    ?> 
                                    <!--<input maxlength="20"  type="password" class="form-control" name="pwdconfirmpassword" id="pwdconfirmpassword"  >-->                                    
                                </div>
                                <br><br><br><br><span style="color:#0B336A;">
                                    Note: Password should be in between 8 to 20 characters long and
                                    must contain at least one capital, alphabet and numeric. 
                                </span>
                            </div>

                        </div>

                    </div>
                    <!-- /.col-lg-6 (nested) -->
                </div>



            </div>
            <!-- /.panel-body -->

            <div class="panel panel-default">
                <div class="panel-heading" onClick="javascript:expandcollapsepanel('asignproductdisplay');" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="left" valign="top" >Display Information</td>
                        </tr>
                    </table>
                </div>

                <div id="asignproductdisplay" class="information-white-bg" style="display: none">
                    <div class="clear"></div>
                    <div class="grid-list-inner-table-text">
                        <table width="100%" cellspacing="3" cellpadding="3" border="0">
                            <tbody>

                            <div class="form-group">
                                <label><?php
                                    $DisplayLabelData = array(
                                        'label' => 'Display',
                                        'tdoption' => Array('TDDisplay' => 'Y')
                                    );
                                    echo form_input_label($DisplayLabelData);
                                    ?></label>
                                <td width="106" valign="middle" height="30" align="left" class="add-new-user-text2"><table width="100%" cellspacing="0" cellpadding="0" border="0">
                                        <tbody><tr>
                                                <td width="48%">
                                                    <?php
                                                    if (!empty($eid)) {
                                                        $publishYRadio = array(
                                                            'name' => 'chr_publish',
                                                            'id' => 'chr_publishY',
                                                            'value' => 'Y',
                                                            'class' => 'form-rediobutton',
                                                            'checked' => ($row['chr_publish'] == 'Y') ? TRUE : FALSE
                                                        );
                                                        echo form_input_ready($publishYRadio, 'radio');
                                                        ?>
                                                        <a style="text-decoration:none;" onclick="if (document.getElementById('chr_publishY').checked != true)">
                                                            Yes </a>
                                                        <?php
                                                    } else {
                                                        $publishYRadio = array(
                                                            'name' => 'chr_publish',
                                                            'id' => 'chr_publishY',
                                                            'value' => 'Y',
                                                            'class' => 'form-rediobutton',
                                                            'checked' => TRUE
                                                        );
                                                        echo form_input_ready($publishYRadio, 'radio');
                                                        ?>
                                                        <a style ="text-decoration:none;" onclick="if (document.getElementById('chr_publishY').checked != true)
                                                                            document.getElementById('chr_publishY').checked = true;" href="javascript:">
                                                            Yes</a>
                                                    <?php } ?>
                                                </td>
                                                <td width="52%">
                                                    <?php
                                                    if (!empty($eid)) {
                                                        $publishNRadio = array(
                                                            'name' => 'chr_publish',
                                                            'id' => 'chr_publishN',
                                                            'value' => 'N',
                                                            'class' => 'form-rediobutton',
                                                            'checked' => ($row['chr_publish'] == 'N') ? TRUE : FALSE
                                                        );
                                                        echo form_input_ready($publishNRadio, 'radio');
                                                        ?>                                                
                                                        <a style="text-decoration:none;" onclick="if (document.getElementById('chr_publishN').checked != true)
                                                                            document.getElementById('chr_publishN').checked = true;" href="javascript:" />
                                                        No</a>
                                                        <?php
                                                    } else {
                                                        $publishNRadio = array(
                                                            'name' => 'chr_publish',
                                                            'id' => 'chr_publishN',
                                                            'value' => 'N',
                                                            'class' => 'form-rediobutton',
                                                            'checked' => FALSE
                                                        );
                                                        echo form_input_ready($publishNRadio, 'radio');
                                                        ?>
                                                        <a style="text-decoration:none;" onclick="if (document.getElementById('chr_publishN').checked != true)
                                                                            document.getElementById('chr_publishN').checked = true;" href="javascript:">No</a>
                                                       <?php } ?>
                                                </td>
                                            </tr>
                                        </tbody></table></td>
                                <td width="864" valign="middle" align="left" class="add-new-user-text2">
                                </td>
                            </div>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


        </div>
        <!-- /.panel -->
    </div>
    <div class="col-sm-12" style="margin-top: 20px; ">
        <button value="1" type="submit" alt="Submit" class="btn btn-primary" id="btnsaveandc" name="btnsaveandc">Save & Keep Editing</button>
        <button value="2" type="submit" alt="Submit" class="btn btn-primary" id="btnsaveande" name="btnsaveande">Save & Exit</button>
        <a class="btn btn-primary" onClick="SetBackground()" href="<?php echo MODULE_PAGE_NAME; ?>">Cancel</a></button>
    </div>

    <?php echo form_close(); ?>
</div>
