
<script type="text/javascript">

    $(document).ready(function () {
        $("#frmcampusbuzz").validate({
            ignore: [],    
            rules: {
                fk_university: "required",
                var_title: "required",
//              var_description : {
//              var_description:true
//              },
//              var_alias: 
//              {
//              required:true,
//              minlength : 2
//              },
                var_description: {
                    required: true,
//                    email:true
                }, 
                dt_expiredate:"required"
            },
            messages: {
                fk_university: 'Please select university.',
                var_title: 'Please enter buzz title.',
                var_description: 'Please enter description.',
                dt_expiredate: 'Please select expiry date.'
                  //int_displayorder: {
                  //required: '<?php // COMMON_DISPLAY_ORDER_MSG?>'
                  //}
            }
        });

    });

    function delete_image()
    {
        var conf = confirm("The selected image will be deleted. Press OK to confirm");
        if (conf == true)
        {
            document.getElementById('divdelbro').innerHTML = '';
            document.getElementById('hidvar_image').value = '';
            alert('Image is deleted successfully');
        }
    }


</script>
<?php
if ($date_careers == "%d/%m/%Y") {
    $date_careers1 = "dd/mm/yy";
}
if ($date_careers == "%m/%d/%Y") {
    $date_careers1 = "mm/dd/yy";
}
if ($date_careers == "%Y/%m/%d") {
    $date_careers1 = "yy/mm/dd";
}
if ($date_careers == "%Y/%d/%m") {
    $date_careers1 = "yy/dd/mm";
}
?>
<script>
    $(function () {
        $('#dt_expiredate').datepicker({
//            maxDate: "+30d",
            changeMonth: true,
            changeYear: true,
            minDate: 0,
        });
    });
</script>

<div class="breadcrumbs">
    <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp; 
    <a href="<?= MODULE_PAGE_NAME ?>">Manage Campus Buzz </a>&nbsp; &gt;&nbsp; 
    <?php
    if (!empty($eid)) {
        ?><span class="current">Edit Buzz</span>  <?php
    } else {
        ?><span class="current">Add Buzz</span> <?php
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
    if (!empty($row['var_title'])) {
        $edit = ' - ' . $row['var_title'];
    }
    ?>
    <div class="row" >
        <div  class="col-md-12" style="height:75px">
            <h1 style="text-align: left; color: #333333" class="page-header">
                <?php
                if (!empty($eid)) {
                    ?>Edit Buzz   <?php echo $edit; ?><?php
                } else {
                    ?>Add Buzz  <?php
                }
                ?>
            </h1>
        </div>
    </div> 



    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Campus Buzz Information
                </div>
                <?php
                $attributes = array('name' => 'frmcampusbuzz', 'id' => 'frmcampusbuzz', 'enctype' => 'multipart/form-data');
                echo form_open($action, $attributes);
                ?>


                <input type="hidden" id="ehintglcode" name="ehintglcode" value="<?= $eid ?>" />
                <input type="hidden" id="btnsaveandc_x" name="btnsaveandc_x" value="" />
                <input type="hidden" id="hidvar_image" name="hidvar_image" value="<?= $row['var_image'] ?>" />

                <input type="hidden" name="int_glcode" id="int_glcode" value="" />
                <input type="hidden" name="eid" id="eid" value="" />


                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-10">

                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top: 10px; padding-bottom: 10px">
                                <label style="text-align:center" for="fk_university" class="col-sm-4 control-label">Select University Name</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <?php echo $University_Combo; ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <label style="text-align:center" for="var_title" class="col-sm-4 control-label">Title </label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_title" id="var_title" value="<?php echo $row['var_title']; ?>" >
                                </div>
                            </div>

                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top: 10px; padding-bottom: 30px">
                                <label style="text-align:center" for="var_description" class="col-sm-4 control-label">Description</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <?php
                                    $DescBoxdata = array(
                                        'name' => 'var_description',
                                        'id' => 'var_description',
                                        'style' => 'width:375px;height:80px;',
                                        'value' => ($row['var_description']),
                                        'tdoption' => Array('TDDisplay' => 'Y'),
                                        'class' => 'form-control',
                                        'extraDataInTD' => form_input_ready($Desccounter)
                                    );
                                    echo form_input_ready($DescBoxdata, 'textarea');
                                    ?>
                                </div>
                            </div>

                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="dt_expiredate" class="col-sm-4 control-label">Expiry Date</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input name="dt_expiredate" class="form-control" type="text" id="dt_expiredate" value="<?= ($row['dt_expiredate'] != '') ? $row['dt_expiredate'] : '' ?>">
                                </div>
                            </div>
                            
                        </div>
                    </div>
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
