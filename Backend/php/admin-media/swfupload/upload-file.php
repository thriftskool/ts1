     <?

    include_once ('../global-header.php');
    include_once ('../includes/class.photo.php');
    include_once ('../includes/class_item.php');
    include_once ('../includes/class.imageprocessing.php');
    $photo = new photo();
$photo->intitialize();
$photo->sessionobj = $session;
     $referencename = add_special_chars($referencename);
                                $listing_name = str_replace(' ', '', trim($referencename));
                                $listing_name = preg_replace('/[^a-zA-Z0-9]/', '', $listing_name);
		 		$uploaded_image = $imgprocess->upload_file($file_photo, $listing_name, $photo->mid, $photo->refid, $photo->thumbsize);
                if(isset($_REQUEST['multi']))
                {

               
                $photo->setfk_referenceglcode($_GET['refid']);
                $photo->setfk_moduleglcode($_GET['mid']);

                $photo->setfk_userglcode($session->value('admin_id'));
                $photo->setvarphotocaption($file_photo);

                $photo->setoldintdisplayorder("1");
                $photo->setintdisplayorder(1);
                $photo->intglcode ="";
                $photo->oldphotoimage = "";

                $photo->setchrcrop("N");


                $photo->setchrdisplay("Y");

                $photo->setchrdelete("N");
                $photo->setdtcreatedate("now()");
                $photo->setdtmodifydate("now()");
                $photo->hdnchrdisplay = "Y";

                $file_photo = $_FILES['varphotoname'];
                $photo->setvarphotoname($uploaded_image);
                $photo->insert();
                if($uploaded_image)
                {
                    echo $uploaded_image;
                }
                else
                {
                    echo "error ".$_FILES['varphotoname']['error']." --- ".$_FILES['varphotoname']['tmp_name']." %%% ".$file."($size)";
                }
                exit;
                }
                ?>