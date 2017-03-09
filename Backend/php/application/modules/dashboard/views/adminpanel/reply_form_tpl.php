<?php
  $GlobalTotalGiftCard=$this->module_model->Check_GCNumber($reply_id,$GlobalId='');
  
  if($GlobalTotalGiftCard=='0'){
   echo '1';
   exit;
  } else{
      
     $VendorTotalGiftCard=$this->module_model->Check_GCNumber($reply_id,$GlobalId='1'); 
  
      if($VendorTotalGiftCard=='0'){ 
        echo '2';
        exit;
   }else{
    $Avail_bal_GiftCard=$this->module_model->Check_GCAvalibleBalance($reply_id);  
    
//        This part is used as codition in dashboard listing ( Start ) 
    if($Avail_bal_GiftCard>='1'){
      
        
    $Last_Date_Redeemed=$this->module_model->Check_GCLast_Date($reply_id);    
   
    foreach($Last_Date_Redeemed as $last_Redeemed){
         $Last_Redeemed_Date= $last_Redeemed->dt_redeemdate;
         $Last_Redeemed_Day =date('dS F Y', strtotime($Last_Redeemed_Date));
         $Last_Redeemed_Month =date('g:i A', strtotime($Last_Redeemed_Date));
         
         echo 'This Gift Card was redeemed on '.$Last_Redeemed_Day.' at '.$Last_Redeemed_Month.'.';
         ?>
         
         
         <?php
         
    //        This part is used as codition in dashboard listing ( End )     
         }
// return false;
 exit;
    
    }
    else{
    
       
?>
<script src="<?php echo ADMIN_MEDIA_URL; ?>js/ariy.validator.js" type="text/javascript"></script>
         <script type="text/javascript">

    
    function CheckRedeemed(){
    document.getElementById('chr_redeemed_flag2').checked=true;
    document.getElementById('PriceTag').style.display='';
    
    }
    function CheckFullRedeemed(){
    document.getElementById('chr_redeemed_flag1').checked=true;
    document.getElementById('PriceTag').style.display='none';
        
    }
    
    function KeycheckOnlynumber(e)
    {
    var _dom = 0;
    _dom=document.all?3:(document.getElementById?1:(document.layers?2:0));
    if(document.all) e=window.event; // for IE
    var ch='';
    var KeyID = '';
    if(_dom==2){ // for NN4
        if(e.which>0) ch='('+String.fromCharCode(e.which)+')';
        KeyID=e.which;
    }
    else
    {
        if(_dom==3){ // for IE
            KeyID = (window.event) ? event.keyCode : e.which;
        }
        else { // for Mozilla
            if(e.charCode>0) ch='('+String.fromCharCode(e.charCode)+')';
            KeyID=e.charCode;
        }
    }
    if((KeyID >= 65 && KeyID <= 90) || (KeyID >= 97 && KeyID <= 122) || (KeyID >= 33 && KeyID <= 39) || (KeyID >= 40 && KeyID <= 43) || (KeyID >= 44 && KeyID <= 45) || (KeyID >= 58 && KeyID <= 64) || (KeyID >= 91 && KeyID <= 96) || (KeyID >= 123 && KeyID <= 126) || (KeyID==47))
    {
        return false;
    }
    return true;
    }
    
    function SubmitGiftform(){
     
          var CardID=document.getElementById('userid').value;
          
          var AvailPRICE =parseFloat(document.getElementById('rmainprice').value);
          var RedeemPRICE=parseFloat(document.getElementById('var_RedeemedPrice').value);
          
          if(document.getElementById('chr_redeemed_flag1').checked==false)
          {
              if(document.getElementById('var_RedeemedPrice').value ==''){
                alert('Please Enter Redeem Price.');
                return false;
              }
              if(AvailPRICE <= RedeemPRICE){
                 alert('Please Enter Valid Redeem Price.');
                 return false;
              }
          }
          
         var str = $("#frmcarddetails").serialize(); 
          $.ajax({
            type: "GET",
            url:  "<?php echo MODULE_URL ?>openpopup?sub=CardDetail&cardid="+CardID,
            data:str,
            async: false,
            success: function(data){
                
                alert('Your Gift Card is Successfully Redeemed.');  
                $('#dialog-modal5').html('');
                $('#dialog-modal5').dialog('close');
                $('#var_giftnumber').val('');
                
                return false;
            }
            })
        }
        
     function CancelGiftform(){
      $('#dialog-modal5').html('');
      $('#dialog-modal5').dialog('close');
      $('#var_giftnumber').val('');
               
     }   

        $(document).ready(function(){

        //alert('in');
        $('#var_RedeemedPrice').ariyValidate({
        type: "float",
        error_message: "Not Allowed."
        });

        });


</script>

<div id="dialog-modal9"></div>
<?php if ($this->input->get_post('action') != '') $action = ucwords($this->input->get_post('action')); ?>

<?php echo $messagebox; ?>


<?php 
// $actiondata = MODULE_URL . "openpopup?sub=CardDetail&cardid=" . $reply_id; 
$actiondata='';
?>

<?php
    $attributes = array('name' => 'frmcarddetails', 'id' => 'frmcarddetails', 'enctype' => 'multipart/form-data', 'onsubmit' => 'return false');
    echo form_open($actiondata, $attributes);
?>

<input type="hidden" name="h_save" id="h_save" value="F">
<input type="hidden" name="userid" id="userid" value="<?php echo $reply_id; ?>" />

<div class="web-booking-main">
    <div class="grid-list-subtitle-bg" style="margin-top:10px; " >
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="left" valign="top" class="grid-td-left">Gift Card Details</td>
            </tr>
        </table>
    </div>
    <div class="information-white-bg" id="messages">
        <div class="clear"></div>
        <div class="grid-list-inner-table-text">
            <table style="margin-left:30px;" width="100%" border="0" cellspacing="3" cellpadding="3">
                <?php $Gift_card_details = $this->module_model->Gift_Card_Details($reply_id);

                foreach($Gift_card_details as $GCDetails)
                {  
                  $data = array(
                 'OrderId' => $GCDetails->OREDERID,     
                 'Userglcode' => $GCDetails->USERID,
                 'CardNumber' => $reply_id,
                 'Avail_bal' => $GCDetails->dec_remain_price,
                 'Redeem_bal' => $GCDetails->dec_redeemed_price,    
                 'Total_bal'   => $GCDetails->dec_total_price
                 );
  
              echo form_hidden($data);
                    ?>
                <input type="hidden" name="rmainprice" id="rmainprice" value="<?php echo $GCDetails->dec_remain_price; ?>" />
                <tr>
                   <td><div  style="margin-left: 10px;">Gift Card Number:</div></td>
                   <td><?php echo $reply_id;?> </td>
                </tr>
                
                <tr>
                   <td><div  style="margin-left: 10px;">Gift Card Name:</div></td>
                   <td><?php echo $GCDetails->CertiName;?> </td>
                </tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Vendor:</div></td>
                   <td><?php echo $GCDetails->var_fullname;?> </td>
                </tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Category:</div></td>
                   <td><?php echo $GCDetails->var_title;?> </td>
                </tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Order Price:</div></td>
                   <td><?php echo $GCDetails->dec_total_price;?> </td>
                </tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Available Balance:</div></td>
                   <td><?php echo $GCDetails->dec_remain_price; ?> </td>
                </tr>
                <tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Buyer:</div></td>
                   <td><?php echo $GCDetails->first_name." ".$GCDetails->last_name;?> </td>
                </tr>
                
                <?php 
                 }
               $Last_Date_Total=$this->module_model->Check_GCLast_Total($reply_id); 
                 
              if($Last_Date_Total>'0')
              {
               $Last_Date_Redeemed=$this->module_model->Check_GCLast_Date($reply_id); 
               foreach($Last_Date_Redeemed as $GCDateDetails){
                 ?>
                <tr>
                   <td><div  style="margin-left: 10px;">Last Redeemed Price:</div></td>
                   <td><?php echo $GCDateDetails->dec_redeemed_price;?> </td>
                </tr>
                <tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Last Redeemed Date:</div></td>
                   <td><?php echo $this->mylibrary->ConvertDateFormatdefault($GCDateDetails->dt_redeemdate);?> </td>
                </tr>
                <?php }
                }else { ?>
                    <tr>
                   <td><div  style="margin-left: 10px;">Last Redeemed Price:</div></td>
                   <td><?php echo "N/A"; ?>
                   </td>
                </tr>
                <tr>
                <tr>
                   <td><div  style="margin-left: 10px;">Last Redeemed Date:</div></td>
                   <td><?php echo "N/A"; ?> </td>
                </tr>
              <?php  }  ?>   
                            <tr>
                                    <?php
                                        $CommLabelData = array(
                                            'label' => 'Make Redeemed',
                                            'required' => 'required',
                                            'tdoption' => Array('TDDisplay' => 'Y')
                                        );
                                        echo form_input_label($CommLabelData);
                                        ?>                                            
                                
                                <td colspan="2" align="left" valign="middle" >
                                            <?php
                                            $CommYRadio = array(
                                                'name' => 'chr_redeemed_flag',
                                                'id' => 'chr_redeemed_flag1',
                                                'value' => 'Y',
                                                'onclick' => 'CheckFullRedeemed()',
                                                'class' => 'form-rediobutton',
                                                'checked' => TRUE 
                                            );
                                            echo form_input_ready($CommYRadio, 'radio');
                                            ?>

                                            &nbsp; <a style="text-decoration: none;" onclick="javascript: CheckFullRedeemed()"> Fully Redeemed</a><br/>
                                            <?php
                                            $CommNRadio = array(
                                                'name' => 'chr_redeemed_flag',
                                                'id' => 'chr_redeemed_flag2',
                                                'value' => 'N',
                                                'onclick' => 'CheckRedeemed()',
                                                'class' => 'form-rediobutton',
                                                );
                                            echo form_input_ready($CommNRadio, 'radio');
                                            ?>

                                            &nbsp; <a  style="text-decoration: none;" href="javascript:" onclick="javascript: CheckRedeemed()"> Partially Redeemed </a>                                                
                                        </td>
                                  </tr>
                                   <tr id="PriceTag" style="display: none;">
                                 <td>
                                    <?php
                                    $ByPLabelData = array(
                                        'label' => '',
                                        'required' => '',
//                                        'tdoption' => Array('TDDisplay' => 'Y'),
                                        
                                    );
                                    echo form_input_label($ByPLabelData); ?>
                                 </td>
                                 
                                  <td>
                                 <span class="fl" style="margin: 5px 0 0 0px !important;"><?php echo "CI$ &nbsp;"; ?> </span>    
                                      <?php   $ByRedeemBoxdata = array(
                                        'name' => 'var_RedeemedPrice',
                                        'style' => 'width:120px;class:add-new-user-textarea;'.$Pricestyle,
                                        'id' => 'var_RedeemedPrice',
                                        'maxlength'=>'25',
                                        'onkeypress' => 'return KeycheckWithDecimal(event);',
                                        'extraDataInTD' => ''
                                          );
                                    echo form_input_ready($ByRedeemBoxdata);
                                    ?>
                                   </td>  
                                </tr>
          
            </table>
        </div>
    </div>
    <br/>&nbsp;
    <div class="clear"></div>
    <div class="add-new-user-button" style="padding-bottom: 30px;">
        <input width="81" type="image" hspace="5" height="25" border="0" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('btnsaveande','','<?= ADMIN_MEDIA_URL; ?>images/submit-button-blue-hover.gif',1)" src="<?= ADMIN_MEDIA_URL; ?>images/submit-button-blue.gif" alt="submit" id="btnsaveande" onclick="SubmitGiftform()" name="btnsaveande" value="1">
        <a>
            <img width="81" type="image" hspace="5" height="25" border="0" src="<?= ADMIN_MEDIA_URL; ?>images/cancel-button.jpg" alt="cancel" name="Image35" id="Image35" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image35','','<?= ADMIN_MEDIA_URL; ?>/images/cancel-button-hover.jpg',1)" onclick="CancelGiftform()" />
        </a>
    </div>
</div>
<?php echo form_close(); 
    }
  }
  }
?>