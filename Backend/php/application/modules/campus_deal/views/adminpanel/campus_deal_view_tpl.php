<link rel="stylesheet" type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide.css" />
<script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide-full.js"></script>
<script type="text/javascript">

    hs.graphicsDir = '<?php echo ADMIN_MEDIA_URL; ?>js/highslide/graphics/';
    hs.outlineType = 'rounded-white';
    hs.showCredits = false;
    hs.wrapperClassName = 'draggable-header';
    hs.align = 'center';
    hs.width = '400';


    function verify()
    {
        SendGridBindRequest('<?php echo MODULE_PAGE_NAME ?>', 'gridbody', 'D', 'chkgrow', '');
    }




</script>

<script type="text/javascript">
    function verifyview(record_id) {

        var conf = confirm("Caution! The selected records will be deleted. Press OK to confirm.");

        $.ajax({
            type: "GET",
            url: "<?php echo SITE_PATH ?>adminpanel/campus_deal/deleterecord?recordid=" + record_id,
            async: true,
            success: function (data) {
                alert("Campus deal has been deleted successfully.");
                window.location.assign("<?php echo SITE_PATH; ?>adminpanel/campus_deal/")
//                location.reload("<?php echo SITE_PATH; ?>user_management/accesscontrol/");
//                    UnsetBackground();
            }
        });
    }
</script>
<div id="gridbody">
    <div class="breadcrumbs">
        <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp;
        <a href="<?php echo SITE_PATH ?>adminpanel/campus_deal">Manage Campus Deals </a>&nbsp;&gt;&nbsp;
        <span class="current">View Campus Deal </span>
        <a href="<?php echo SITE_PATH ?>adminpanel/campus_deal" style="float: right; font-size: 16px"><b>Back </b></a>
    </div>


    <div id="page-inner">
        <div class="row">
            <div style="color: red;" >
                <?php echo $this->session->flashdata('errorMsg'); ?>
            </div>

            <?php
            if (!empty($messagebox)) {
                echo $messagebox;
            }
            ?>

            <?php echo $HeaderPanel; ?>

        </div>

        <div class="row">

            <?php
            $tickimg = ($select_View_deal_data['chr_block'] == '0') ? "unblock.png" : "block.png";
            if ($select_View_deal_data['chr_block'] == '0') {
                $title = "Block me";
            } else {
                $title = "Unblock me";
            }
            ?>
            <div class="col-lg-8 mar50" style="margin-top: 20px; margin-bottom: 15px">  
                <!--<a class="btn btn-primary btn-sm" href="allocation_list.php?action=add"><i class="fa fa-plus "></i> Add </a>-->
                <a class="btn btn-info btn-sm" href="<?php echo SITE_PATH ?>adminpanel/campus_deal/add?eid=<?= $select_View_deal_data['int_glcode']; ?>"><i class="fa fa-pencil "></i> Edit </a>
                <?php if ($select_View_deal_data['chr_block'] != '1') { ?>   
                    <?php if ($select_View_deal_data['chr_status'] == '0') { ?>
                                                    <!--<a class="btn btn-success btn-sm" href="allocation_list.php?action=active&amp;lists=5"><i class="fa fa-check "></i> Block </a>-->
                        <a class="btn  btn-sm"  href="javascript:void(0);">

                            <img id="tick-<?php echo $select_View_deal_data['int_glcode'] ?>" height="25" width="75" alt="<?= $title ?>" title="<?= $title ?>" src="<?php echo ADMIN_MEDIA_URL . 'images/' ?><?php echo $tickimg ?>" style="vertical-align:center;cursor:pointer;" onclick="UpdatePublishView('campus_deal', '<?php echo 'campus_deal' ?>', 'chr_block', '<?php echo $select_View_deal_data['int_glcode'] ?>', '', '<?php echo SITE_PATH . 'adminpanel/'; ?>', '<?php echo SITE_PATH; ?>');">
                        </a>
                        <?php
                    }
                }
                ?>

                <a onclick="return verifyview(<?php echo $select_View_deal_data['int_glcode']; ?>);" class="btn btn-danger btn-sm delete" id="5" href="javascript:;"><i class="fa fa-trash-o "></i> Delete </a>

            </div><!-- /.col-lg-6 -->

            <div class="col-md-13">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-10">
                                <div class="form-group">
                                    <label style="text-align:center" for="var_name" class="col-sm-4 control-label">Title </label>
                                    <div class="col-sm-6">
<?php echo $select_View_deal_data['var_title']; ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Description</label>
                                    <div class="col-sm-6">
<?php echo nl2br($select_View_deal_data['var_description']); ?>
                                    </div>
                                </div>
                                <br>
                                <br>
                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Deal code</label>
                                    <div class="col-sm-6">
                                        <?php
                                        if ($select_View_deal_data['var_dealcode'] != '') {
                                            echo $select_View_deal_data['var_dealcode'];
                                        } else {
                                            echo "N/A";
                                        }
                                        ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Creation date</label>
                                    <div class="col-sm-6">
<?php echo $select_View_deal_data['dt_createdate']; ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Expiry date</label>
                                    <div class="col-sm-6">
<?php echo $select_View_deal_data['dt_expiredate']; ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">University name</label>
                                    <div class="col-sm-6">
<?php echo $select_View_deal_data['university_name']; ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Deal code count</label>
                                    <div class="col-sm-6">
<?php echo $select_View_deal_data['code_count']; ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Deal status</label>
                                    <div class="col-sm-6">
                                        <?php // echo $select_View_deal_data['chr_status']; ?>
                                        <?php
                                        if ($select_View_deal_data['chr_status'] == '0') {
                                            echo "Active";
                                        } elseif ($select_View_deal_data['chr_status'] == '1') {
                                            echo "Expire";
                                        } else {
                                            echo "Close";
                                        }
                                        ?>
                                    </div>
                                </div>

                                <div style="height:15px; width:100%;"></div>
                                <div class="form-group" style="padding-top:  10px">
                                    <label style="text-align:center" for="var_domain" class="col-sm-4 control-label">Images</label>
                                    <div class="col-sm-6">
                                        <a href="<?php echo SITE_PATH ?>adminpanel/campus_gallery?cid=<?= $select_View_deal_data['int_glcode']; ?>">View Gallery</a>

                                        <?php
                                        $imagesdata = $this->module_model->get_deal_images($select_View_deal_data['int_glcode']);
                                        foreach ($imagesdata as $value) {
//                                   echo $value['var_image']; die;
                                            ?>
                                            <td>
                                                <?php
                                                $imagename = $value['var_image'];
                                                if ($imagename != "") {

                                                    $imagepath = 'upimages/campus_gallery/images/' . $imagename;
                                                    ?>
                                                    <div class="highslide-gallery" >
                                                        <a onClick="return hs.expand(this);" href="<?php echo SITE_PATH . $imagepath; ?>">
                                                            <img style="height: 70px; width: 70px; float: left; padding: 10px" border="0" src="<?php echo SITE_PATH . $imagepath; ?>" title="<?= $value['var_image']; ?>"></a>
                                                    </div>
                                                    <?php
                                                } else {
                                                    echo "N/A";
                                                }
                                                ?>
                                            </td>
                                        <?php }
                                        ?>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>


                </div>
            </div>

        </div>

        <div class="row">


            <?php if ($counttotal > 0) { ?>
                <a onclick="return verify();" class="btn btn-primary" href="#">Delete</a>
<?php } ?>
        </div>
    </div>
</div>