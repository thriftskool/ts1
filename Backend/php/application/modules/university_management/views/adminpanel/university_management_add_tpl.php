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

        $("#frmuniversity").validate({
            //            ignore: [],    
            rules: {
                var_name: "required",
//               var_description : {
//                    var_description:true
//                },
//                var_alias: 
//                    {
//                    required:true,
//                    minlength : 2
//                },
                var_domain: {
                    required:true,
//                    email:true
                }
            },
            messages: {
                var_name: '<?php echo UNIVERSITY_TITLE_MSG; ?>',
                var_domain: 'Plase enter domain name.'
//                int_displayorder: {
//                    required: '<?php // COMMON_DISPLAY_ORDER_MSG     ?>'
//                }
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

<div class="breadcrumbs">
    <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp; 
    <!--<a href="<?php echo SITE_PATH ?>adminpanel/university_management">Products </a>&nbsp;&gt;&nbsp;-->
    <a href="<?= MODULE_PAGE_NAME ?>">Manage University </a>&nbsp; &gt;&nbsp; 
    <?php
    if (!empty($eid)) {
        ?><span class="current">Edit University</span>  <?php
    } else {
        ?><span class="current">Add University</span> <?php
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
    if (!empty($row['var_name'])) {
        $edit = ' - ' . $row['var_name'];
    }
    ?>
    <div class="row" >
        <div  class="col-md-12" style="height:60px">
            <h1 style="text-align: left; color: #333333" class="page-header">
                <?php
                if (!empty($eid)) {
                    ?>Edit University   <?php echo $edit; ?><?php
                } else {
                    ?>Add University  <?php
                }
                ?>
            </h1>
        </div>
    </div> 



    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    University Information
                </div>
                <?php
                $attributes = array('name' => 'frmuniversity', 'id' => 'frmuniversity', 'enctype' => 'multipart/form-data');
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

                        
                            <div class="form-group">
                                <label style="text-align:center" for="var_name" class="col-sm-4 control-label">University Name </label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_name" id="var_name" value="<?php echo $row['var_name']; ?>" >
                                </div>
                            </div>



                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_image" class="col-sm-4 control-label">Select Logo</label>
                                <div class="col-sm-6">

                                    <input type="file" maxlength="100" style="width:354px;" class="fl" id="var_image" value="<?php
                                    if (!empty($eid)) {
                                        echo htmlspecialchars($row['var_image']);
                                    }
                                    ?>" name="var_image">
                                           <?php
                                           if (!empty($eid)) {
                                               $imagepath = 'upimages/university_management/images/' . $row['var_image'];
                                               ?>
                                               <?php
                                               $imagename = $row['var_image'];

                                               if ($imagename != "") {
                                                   ?>
                                            <div class="highslide-gallery">
                                                <a id="divdelbro" onClick="return hs.expand(this);" href="<?php echo SITE_PATH.$imagepath; ?>">
                                                    <img border="0" src="<?= ADMIN_MEDIA_URL ?>images/photo-gallery-icon.png" title="View Image"></a>
                                                <?php echo "&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"delete_image('" . $row['int_glcode'] . "','" . $row['var_image'] . "',1);\"><img  src=\"" . ADMIN_MEDIA_URL . "images/_tick_cross.png\" alt=\"Delete\" title=\"Delete\" /></a>" ?>
                                            </div>                    
                                            <?php
                                        }
                                    } ?>

                                </div>
                            </div>

                            <div style="height:15px; width:100%;"></div>
                            <div class="form-group" style="padding-top:  10px">
                                <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Email Domain</label><small style="color: red">*</small>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="var_domain" id="var_domain" value="<?php echo $row['var_domain']; ?>" >
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
