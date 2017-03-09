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
    hs.wrapperClassName = 'draggable-header';</script>

<script type="text/javascript">


    $(document).ready(function () {
        $.validator.addMethod("system_image_validation", function (value, element)
        {

            var selection = document.getElementById('var_image').value;
            if (selection != '') {
                var res1 = selection.substring(selection.lastIndexOf(".") + 1);
                var res = res1.toLowerCase();
                if (res == "jpg" || res == "jpeg" || res == "gif" || res == "png" || res == "JPG" || res == "JPEG" || res == "GIF" || res == "PNG") {
                    return true;
                } else {
                    return false;
                }
            } else {
                return true;
            }


        }, 'Only .jpg, .jpeg, .png or .gif image formats are supported.');


        $("#frmdealsgallery").validate({
            //            ignore: [],    
            rules: {
                var_title: "required",
                var_image: {
                    required: {
                        depends: function () {

                            if ($("#hidvar_image").val() == '' && $("#var_image").val() == '')
                            {

                                return true;
                            }
                        }
                    },
                    system_image_validation:
                            {
                                depends: function ()
                                {
                                    return true
                                }
                            }
                }
//                var_image: {
//                    
//                    required: true,
//                    accept: "jpg|jpeg|png|JPG|JPEG|PNG|GIF|gif"
//                    //extension: "jpeg|jpg|png"
//                }


            },
            messages: {
                var_title: 'Please enter image title.',
                var_image: {
                    required: '<?= BM_HB_IMAGE_UPLOAD_MSG ?>',
                    accept: '<?= BM_IMAGE_TYPE_MSG ?>'
                },
//                var_image: 'Please upload image.'

            }
        });
    });
    function checkImage(input, message) {

        if (typeof message === "undefined") {
            message = imageError;
        }

        var validImage = /(\.jpg|\.gif|\.png|\.JPG|\.GIF|\.PNG|\.jpeg|\.JPEG)$/;
        if ($("#" + input).val().trim() != '') {
            if (!($("#" + input).val().trim().match(validImage))) {
                return returnFalse(input, message);
            } else {
                return returnTrue(input);
            }
        } else {
            return true;
        }
    }
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


    });</script>

<div class="breadcrumbs">
    <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp; 
    <!--<a href="<?php echo SITE_PATH ?>adminpanel/post_category">Products </a>&nbsp;&gt;&nbsp;-->
    <a href="<?= SITE_PATH . 'adminpanel/campus_deal'; ?>">Manage Deals</a>&nbsp;&gt;&nbsp;
    <a href="<?= MODULE_PAGE_NAME ?>?cid=<?php echo $this->input->get_post('cid'); ?>">Manage Deals Gallery </a>&nbsp; &gt;&nbsp; 
    <?php
    if (!empty($eid)) {
        ?><span class="current">Edit Deal Image</span>  <?php
    } else {
        ?><span class="current">Add Deal Image</span> <?php
    } ?>
    
    <a href="javascript:history.go(-1)" style="float: right; font-size: 16px"><b>Back </b></a>
    

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
                    ?>Edit Image  <?php echo $edit; ?><?php
                } else {
                    ?>Add New Image  <?php
                }
                ?>
            </h1>
        </div>
    </div> 



    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Image Information
                </div>
                <?php
                $attributes = array('name' => 'frmdealsgallery', 'id' => 'frmdealsgallery', 'enctype' => 'multipart/form-data');
                echo form_open($action, $attributes);
                ?>
                <?php
                if ($eid == '') {
                    $count_photo = $this->module_model->count_photo($this->input->get_post('cid'));
                    if ($count_photo == '0') {
                        $gi = '1';
                    } elseif ($count_photo == '1') {
                        $gi = '2';
                    } elseif ($count_photo == '2') {
                        $gi = '3';
                    } elseif ($count_photo == '3') {
                        $gi = '4';
                    }
                }
                ?>

                <input type="hidden" id="btnsaveandc_x" name="btnsaveandc_x" value="" />
                <input type="hidden" id="ehintglcode" name="ehintglcode" value="<?= $eid ?>" />
                <input type="hidden" id="hidvar_image" name="hidvar_image" value="<?= $row['var_image'] ?>" />
                <input type="hidden" id="pdi" name="cid" value="<?= $this->input->get_post('cid'); ?>" />


                <?php if ($eid == '') { ?>
                    <input type="hidden" id="gi" name="gi" value="<?= $gi; ?>" />
                <?php } ?>

                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-10">
                            <div class="form-group">
                                <label style="text-align:center" for="var_title" class="col-sm-4 control-label">Image Name </label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_title" id="var_title" value="<?php echo $row['var_title']; ?>" >
                                </div>
                            </div>


                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_image" class="col-sm-4 control-label">Image</label>
                                <div class="col-sm-6">

                                    <input type="file" maxlength="100" style="width:354px;" class="fl" id="var_image" onblur="checkImage(this.id)" value="<?php
                if (!empty($eid)) {
                    echo htmlspecialchars($row['var_image']);
                }
                ?>" name="var_image">
                                           <?php
                                           if (!empty($eid)) {
                                               $imagepath = 'upimages/campus_gallery/images/' . $row['var_image'];
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
        <!--<button type="submit" alt="Submit" class="btn btn-primary" id="btnsaveandc" name="btnsaveandc">Save & Keep Editing</button>-->
        <button type="submit" alt="Submit" class="btn btn-primary" id="btnsaveande" name="btnsaveande">Save & Exit</button>
        <a class="btn btn-primary" onClick="SetBackground()" href="<?php echo MODULE_PAGE_NAME; ?>?cid=<?php echo $this->input->get_post('cid'); ?>">Cancel</a></button>
    </div>

    <?php echo form_close(); ?>
</div>
