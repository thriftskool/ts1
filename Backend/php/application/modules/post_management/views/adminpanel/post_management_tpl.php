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
<script>
    $(document).ready(function () {
        $(function () {
            $('#create_date').datepicker({
//            maxDate: "+30d",
                changeMonth: true,
                changeYear: true,
//            minDate: 0,
            });
        });
    });
</script>

<div id="gridbody">
    <div class="breadcrumbs">
        <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp;
        <!--<a href="<?php echo SITE_PATH ?>adminpanel/product">University </a>&nbsp;&gt;&nbsp;-->
        <span class="current">Manage Posts </span>
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
            <div class="panel panel-info">
                <?php echo $PagingTop; ?>
            </div>
        </div>

        <div class="row">
            <div class="col-md-13">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">

                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" onclick="checkall('chkgrow')" id="chkall" name="chkall"></th>
                                        <th>

                                            <a href="javascript:;" onclick="SendGridBindRequest('<?= $this->module_model->urlwithoutsort ?>&orderby=var_postname&sorting=Y', 'gridbody', 'ST')">Post Title
                                                <?php echo $setsortimgvar_postname; ?>
                                            </a>
                                        </th>   
                                        <th>
                                            Post Category
                                        </th>
                                        <th>
                                            University Name
                                        </th>
                                        <th>
                                            <a href="javascript:;" onclick="SendGridBindRequest('<?= $this->module_model->urlwithoutsort ?>&orderby=int_count&sorting=Y', 'gridbody', 'ST')">
                                                Spam Counter
                                                <?php echo $setsortimgint_count; ?>
                                            </a>
                                        </th>

                                        <th> Gallery View / Add</th>
                                        <th>
                                            <a href="javascript:;" onclick="SendGridBindRequest('<?= $this->module_model->urlwithoutsort ?>&orderby=dt_createdate&sorting=Y', 'gridbody', 'ST')">
                                                Post Creation Date
                                                <?php echo $setsortimgdt_createdate; ?>
                                            </a>
                                        </th>
                                        <th>Post Status</th>
                                        <th>
                                            <a href="javascript:;" onclick="SendGridBindRequest('<?= $this->module_model->urlwithoutsort ?>&orderby=chr_publish&sorting=Y', 'gridbody', 'ST')">Publish
                                                <?php echo $setsortimgchr_publish; ?></a>
                                        </th>

                                        <th>Action</th>
                                    </tr>
                                </thead>

                                <!--</div>-->
                                <tbody>
                                    <?php
                                    $rowcount = 0;
                                    if ($counttotal > 0) {
                                        foreach ($selectAll as $row) {
//                                            print_r($row);

                                            $type = $row->Category;
                                            $tickimg = ($row->chr_publish == 'Y') ? "tick.png" : "tick_cross.png";
                                            if ($row->chr_publish == 'Y') {
                                                $title = "Hide me";
                                            } else {
                                                $title = "Display me";
                                            }

                                            if ($type != $previoustype) {
                                                ?>
                                                <tr>
                                                    <td colspan="16" style="color: #21759B;background-color: #EEF8FF; "><span style=" margin-left:20px;line-height:30px"><b><?php echo $type; ?></b></span></td></tr>  

                                                <?php
                                                $previoustype = $type;
                                            }
                                            ?>
                                            <tr class="even gradeC"> 
                                                <td width="3%" valign="middle" align="left" class="grid-td-left delete-class ">
                                                    <input type="checkbox" value="<?= $row->int_glcode; ?>" id="chkgrow" name="chkgrow">
                                                </td>

                                                <td>
                                                    <a href="<?= $this->module_model->addurlwithpara ?>&eid=<?= $row->int_glcode; ?>" class="edit-link-class">
                                                        <?= $row->var_postname; ?>
                                                    </a>
                                                </td>
                                                <td>
                                                    <?php echo $row->category_name; ?>
                                                </td>

                                                <td>
                                                    <?php echo $row->university_name; ?>
                                                </td>
                                                <td>
                                                    <?php echo $row->int_count; ?>
                                                </td>
                                                <td>
                                                    <?php
                                                    $gall_count = $this->module_model->Count_Gallery($row->int_glcode);
                                                    ?>
                                                    (<?php echo $gall_count; ?>)<a href="<?php echo SITE_PATH ?>adminpanel/post_gallery?pid=<?= $row->int_glcode; ?>" class="edit-link-class">
                                                        View
                                                    </a><?php if ($gall_count < 4) { ?> / <a href="<?php echo SITE_PATH . 'adminpanel/post_gallery/add?pid=' . $row->int_glcode ?>" class="edit-link-class">
                                                            Add
                                                        </a> <?php } ?>

                                                </td>

                                                <td>
                                                    <?php echo $row->dt_createdate ?>
                                                </td>
                                                <td>
                                                     <?php
                                        if ($row->chr_status == '0') {
                                            echo "Active";
                                        } elseif ($row->chr_status == '1') {
                                            echo "Expire";
                                        } else {
                                            echo "Close";
                                        }
                                        ?>
                                                    
                                                  </td>
                                                <td>
                                                    <a href="javascript:void(0);">
                                                        <img id="tick-<?= $row->int_glcode ?>" height="16" width="16" alt="<?= $title ?>" title="<?= $title ?>" src="<?= ADMIN_MEDIA_URL . 'images/' ?><?= $tickimg ?>" style="vertical-align:middle;cursor:pointer;" onclick="UpdatePublish('post_management', '<?= DB_PREFIX . 'post_management' ?>', 'chr_publish', '<?= $row->int_glcode ?>', '');">
                                                    </a>
                                                </td>

                                                <td>
                                                    <!--<a href="<?php echo SITE_PATH ?>adminpanel/post_management/view?pid=<?= $row->int_glcode; ?>" class="edit-link-class"> View</a>-->
                                                    <a href="<?php echo SITE_PATH ?>adminpanel/post_management/view?pid=<?= $row->int_glcode; ?>" class="btn btn-xs btn-primary"> <i class="fa fa-search "></i> View</a>
                                                </td>

                                            </tr>
                                            <?php
                                            $rowcount++;
                                        }
                                    } else {
                                        ?>
                                        <tr>
                                            <td colspan="10" align="center"><strong>No Records Found</strong></td>
                                        </tr>
                                        <?php
                                    }
                                    ?>

                                <input type="hidden" value="<?= $rowcount; ?>" id="ptrecords" name="ptrecords">
                                </tbody>
                            </table>
                            <!--                            </div>
                                                    </div>-->
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <div class="row">
            <div class="panel panel-info" style="margin-top: 15px">
                <?php echo $PagingBottom; ?></div>

            <?php if ($counttotal > 0) { ?>
                <a onclick="return verify();" class="btn btn-primary" href="#">Delete</a>
            <?php } ?>
        </div>
    </div>
</div>