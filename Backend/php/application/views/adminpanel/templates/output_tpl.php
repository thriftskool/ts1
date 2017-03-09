


<?php


$this->load->view($adminHeaderPanel); ?>
<?php

$module = $this->router->fetch_class();

//$excludeLeftPanelArry = array("comments", "revenuereport", "batchreport");

if (!empty($adminLeftPanel) && !in_array($module, $excludeLeftPanelArry) && false) {
    $this->load->view($adminLeftPanel);
} else {
    ?>
    <td align="left" valign="top" width="90%" style="padding-bottom:50px;padding-right: 10px;padding-left: 10px; ">
    <?php

}
?>
     <div id="page-wrapper">   
    <?php $this->load->view($adminContentPanel); ?>
     </div>

    
    </div>
    <?php $this->load->view($adminFooterPanel); ?>
   