<link rel="stylesheet" type="text/css" href="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide.css" />
<script type="text/javascript" src="<?php echo ADMIN_MEDIA_URL; ?>js/highslide/highslide-full.js"></script>
<style>
    .panel-body select {
        height: 215px;
    }
    .unversitylist label {
    float: left;
    margin-right: 2%;
    position: relative;
}
</style>
<div id="gridbody">
    <div class="breadcrumbs">
        <a href="<?= ADMINPANEL_HOME_URL; ?>">Home</a>&nbsp;&gt;&nbsp;
        <!--<a href="<?php echo SITE_PATH ?>adminpanel/product">University </a>&nbsp;&gt;&nbsp;-->
        <span class="current">Manage Users </span>
    </div>

    <div id="page-inner">
        <div class="row">
            <div style="color: red;" >
                <?php echo $this->session->flashdata('errorMsg'); ?>
            </div>
            <?php echo $HeaderPanel; ?>
        </div>
        <?php 
                if(isset($message)){
                    echo $message;
                }
            ?>
        <form method="post" name="university" action="<?php echo MODULE_PAGE_NAME.'/downloadcsv'?>">
        <div class="row">
            <div class="col-md-13">
                <div class="panel panel-default">
                    <div class="panel-body">
                        
                        <div class="unversitylist">
                            <label>Select University</label>
                            <?php echo $University_Combo; ?>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <input type="submit" class="btn btn-primary" name="downloadcsv" value="Download user data">
        </div>
</form>
    </div>
</div>