<link rel="stylesheet" type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide.css" />
<script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide-full.js"></script>
<script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide-with-gallery.js"></script>
<link type="text/css" href="<?= ADMIN_MEDIA_URL; ?>css/style.css" rel="stylesheet" /> 
<!--<script src="<?php echo ADMIN_MEDIA_URL; ?>js/site.js"></script>-->
<!--<script src="<?php echo ADMIN_MEDIA_URL; ?>js/commonalert.js"></script>-->
<script type="text/javascript">
    hs.graphicsDir = '<?php echo ADMIN_MEDIA_URL; ?>js/highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.showCredits = false;
    hs.wrapperClassName = 'draggable-header';
</script>

<script type="text/javascript">


    $(document).ready(function () {

        $("#frmpostcategory").validate({
            //            ignore: [],    
            rules: {
                var_categoryname: "required"
            },
            messages: {
                var_categoryname: 'Please enter category name.'

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
//echo $date_careers1; exit;
?>
<!--<script type="text/javascript">
    $(function() {
        $('#dt_expiredate').datepicker({
            changeMonth: true,
            changeYear: true,
//            minDate:  $("#dt_startdate").datepicker("getDate") ,
            dateFormat:'<?php echo $date_careers1; ?>'
        });
    });
</script>-->

<script>
    $(function () {

        $('#dt_expiredate').datepicker({
            maxDate: "+30d",
            changeMonth: true,
            changeYear: true,
            minDate: 0,
        });

//        $("#dt_expiredate").datepicker();


    });


</script>

<div class="breadcrumbs">
    <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp; 
    <!--<a href="<?php echo SITE_PATH ?>adminpanel/post_category">Products </a>&nbsp;&gt;&nbsp;-->
    <a href="<?= MODULE_PAGE_NAME ?>">Manage Post Category </a>&nbsp; &gt;&nbsp; 
    <?php
    if (!empty($eid)) {
        ?><span class="current">Edit Post Category</span>  <?php
    } else {
        ?><span class="current">Add Post Category</span> <?php
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
    if (!empty($row['var_categoryname'])) {
        $edit = ' - ' . $row['var_categoryname'];
    }
    ?>
    <div class="row" >
        <div  class="col-md-12" style="height:75px">
            <h1 style="text-align: left; color: #333333" class="page-header">
                <?php
                if (!empty($eid)) {
                    ?>Edit Post Category   <?php echo $edit; ?><?php
                } else {
                    ?>Add Post Category  <?php
                }
                ?>
            </h1>
        </div>
    </div> 



    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Post Category Information
                </div>
                <?php
                $attributes = array('name' => 'frmpostcategory', 'id' => 'frmpostcategory', 'enctype' => 'multipart/form-data');
                echo form_open($action, $attributes);
                
                ?>
                <input type="hidden" id="btnsaveandc_x" name="btnsaveandc_x" value="" />
                <input type="hidden" id="ehintglcode" name="ehintglcode" value="<?= $eid ?>" />
                <input type="hidden" id="hidvar_image" name="hidvar_image" value="<?= $row['var_image'] ?>" />
                <input type="hidden" id="hidvar_backimage" name="hidvar_backimage" value="<?php echo  $row['var_backimage'] ?>" />

                


                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-10">
                            <div class="form-group">
                                <label style="text-align:center" for="var_categoryname" class="col-sm-4 control-label">Post Category Name </label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_categoryname" id="var_categoryname" value="<?php echo $row['var_categoryname']; ?>" >
                                </div>
                            </div>


                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_image" class="col-sm-4 control-label">Category Icon</label>
                                <div class="col-sm-6">

                                    <input type="file" maxlength="100" style="width:354px;" class="fl" id="var_image" value="<?php
                                    if (!empty($eid)) {
                                        echo htmlspecialchars($row['var_image']);
                                    }
                                    ?>" name="var_image">
                                           <?php
                                           if (!empty($eid)) {
                                               $imagepath = 'upimages/post_category/images/' . $row['var_image'];
                                               ?>
                                               <?php
                                               $imagename = $row['var_image'];

                                               if ($imagename != "") {
                                                   ?>
                                            <div class="highslide-gallery">
                                                <a id="divdelbro" onClick="return hs.expand(this);" href="<?php echo SITE_PATH . $imagepath; ?>">
                                                    <img border="0" src="<?= ADMIN_MEDIA_URL ?>images/photo-gallery-icon.png" title="View Image"></a>
                                                <?php echo "&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"delete_image('" . $row['int_glcode'] . "','" . $row['var_image'] . "',1);\"><img  src=\"" . ADMIN_MEDIA_URL . "images/_tick_cross.png\" alt=\"Delete\" title=\"Delete\" /></a>" ?>
                                            </div>                    
                                            <?php
                                        }
                                    }
                                    ?>

                                </div>
                            </div>

                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_backimage" class="col-sm-4 control-label">Backgroud Image</label>
                                <div class="col-sm-6">

                                    <input type="file" maxlength="100" style="width:354px;" class="fl" id="var_backimage" value="<?php
                                    if (!empty($eid)) {
                                        echo htmlspecialchars($row['var_backimage']);
                                    }
                                    ?>" name="var_backimage">
                                           <?php
                                           if (!empty($eid)) {
                                               $imagepath = 'upimages/post_category/images/' . $row['var_backimage'];
                                               ?>
                                               <?php
                                               $imagename = $row['var_backimage'];

                                               if ($imagename != "") {
                                                   ?>
                                            <div class="highslide-gallery">
                                                <a id="divdelbro" onClick="return hs.expand(this);" href="<?php echo SITE_PATH . $imagepath; ?>">
                                                    <img border="0" src="<?= ADMIN_MEDIA_URL ?>images/photo-gallery-icon.png" title="View Image"></a>
                                                <?php echo "&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"delete_image('" . $row['int_glcode'] . "','" . $row['var_backimage'] . "',1);\"><img  src=\"" . ADMIN_MEDIA_URL . "images/_tick_cross.png\" alt=\"Delete\" title=\"Delete\" /></a>" ?>
                                            </div>                    
                                            <?php
                                        }
                                    }
                                    ?>

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

</div>

<?php echo form_close(); ?>