<script type="text/javascript">
    function validateEmail(email) {

        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        return re.test(email);
    }
    
    function GetExistEmail(email)
    {
        var emailid = email;
        var exist;
        $.ajax({
            type: "POST",
            url: "<?php echo SITE_PATH; ?>pages/check_email_address",
            data: "ajax=Y&emailid="+emailid+"",
            async: false,
            success: function(result)
            {
//                alert(result);
                if(result==1){
                    exist =  false;
                }else{
                    exist =  true;
                }
            }
        }); 
        return exist;
    }
    
    function insert_newslatterleads() {

        var mailid = document.getElementById('var_email').value;
        var mailidconf = document.getElementById('var_emailconform').value;
        if (mailid == 'Enter your email...') {
            alert('Please enter email address.');
            document.getElementById('var_email').focus();
            return false;
        } else {
            if (validateEmail(mailid) == false) {
                alert('Please enter a valid email address.')
                return false;
            }
             if (mailidconf == 'Enter confirm email...') {
                alert('Please enter confirm email address.');
                document.getElementById('var_emailconform').focus();
                return false;
            } if(mailid != mailidconf) {
                alert('Please enter the same value again');
                document.getElementById('var_emailconform').focus();
                return false;
            }
            else {
                if (GetExistEmail(mailid) == false) {
                    alert('The email address you have entered is already subscribed for our newsletter. Please enter another email address.');
                    return false;
                } else {

                    $.ajax({
                        type: "POST",
                        start: SetBackground(),
                        url: "<?= SITE_PATH ?>pages/sendMailtoNewsletterEmail",
                        data: "ajax=Y&var_email=" + mailid + "",
                        async: false,
                        success: function(result)
                        {
//                            alert(result);
                            if (result == 1) {
                                alert("Thank You for subscribing to our Newsletter.");
                                //         document.getElementById('var_newslatterleads').reset();
                                $("#var_email").val('');
                                window.location.href = '<?= SITE_PATH ?>'+'deals';
                            } else {
                                alert("Error in sending mail.");
                                document.getElementById('var_email').reset();
                                return false;
                            }
                            UnsetBackground();

                        }

                    });
                }

            }

        }
        return false;
    }
    
    function SetBackground()
    {
        $("#dvprocessing").show();
    }

    function UnSetBackground()
    {
 
        document.getElementById('dimmer').style.width=110;
        document.getElementById('dimmer').style.height=0;
        document.getElementById('dimmer').style.visibility="";
        document.getElementById('dvprocessing').style.display = 'none';
    }
</script>
    

<section id="main" class="inner-main">
   <header class="page-header">
    <div class="container">
      <h1 class="title"><?php echo $Title;?></h1>
    	<div class="clearfix"></div>
      <hr/>
    </div>	
  </header>
    
    <?php if(RECORD_ID == '44'){ ?>
    
        <section id="Become-member" class="inner-news-set">
            <article class="content">
                <div class="container">
                    <div class="event-poster">
                        <div class="event-wrap">
                            <div class="img-div fl">
                                <img src="<?php echo FRONT_MEDIA_URL; ?>img/home-be-member.jpg" alt="Become A Member">
                            </div>
                            <div class="event-detail">
                                   <div class="left-sing-up">
                                    SIGN UP FOR EMAILS!
                                    <b class="latest-sales">Be the first to know about the latest sales and exclusives!</b>
                                </div>
                                <div class="right-sing-up">
                                   <form method="post" name="frmnewsletter" id="frmnewsletter" onsubmit="return insert_newslatterleads();">
                                   <!--<input type="text" name="var_email" id="var_email" placeholder="Enter your email...">-->
                                   <input type="text" name="var_email" onblur="if(this.value == '') this.value='Enter your email...';" onfocus="if(this.value == 'Enter your email...') this.value=''" id="var_email" value="Enter your email..." autocomplete="off" >    
                                   
                                   <input type="text" name="var_emailconform" onblur="if(this.value == '') this.value='Enter confirm email...';" onfocus="if(this.value == 'Enter confirm email...') this.value=''" id="var_emailconform" value="Enter confirm email..." autocomplete="off" >
                                   <button type="submit" title="JOIN!">Join!</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
        </section>
    <?php } ?>
  <div class="container">
	<div class="row">
      <article class="col-sm-12 col-md-12">
      		<div class="cms">

                    <?php echo $currentPageData_content['text_fulltext']; ?>
                    <div style="height:20px;clear:both"></div>
                   <div class="clearfix"></div>
              </div>
      </article><!-- .content -->
 </div>		
      </div><!-- .content -->
</section><!-- #main End -->
