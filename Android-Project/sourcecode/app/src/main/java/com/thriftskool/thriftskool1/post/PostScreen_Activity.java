package com.thriftskool.thriftskool1.post;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.TimePickerDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.provider.Settings;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Base64;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.CropingOption;
import com.thriftskool.thriftskool1.CropingOptionAdapter;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.Post_AsyncTask;
import com.thriftskool.thriftskool1.category.CategoryScreen_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.privacy_policy.PrivacyPolicyScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.terms_and_condition.TermsAndConditionScreen_Activity;
import com.thriftskool.thriftskool1.university.UnivarsityScreen_Activity;
import com.thriftskool.thriftskool1.widgets.RoundedTransformation;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

public class PostScreen_Activity extends Activity implements View.OnClickListener {

    private EditText et_title, et_description, et_price;
    private TextView tv_addPhoto, tv_back, tv_title, tv_save, tv_expirydate, tv_chooseCategory, tv_postSubmit,tv_countNotification;
    private ImageView iv_photo1, iv_photo2, iv_photo3, iv_photo4;
    private CheckBox chb_privacyPolicy;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    public static int int_photopos;
    private Calendar calender;
    private List<String> imageList = new ArrayList<String>();
    private String str_categoryId="", str_categoryName="";
    private SpannableString ss_privacyPolicy,ss_termsOfUse;

    Uri mImageCaptureUri;
    File outPutFile;
    private Uri picUri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post_screen_);

        calender = Calendar.getInstance();

        outPutFile = new File(android.os.Environment.getExternalStorageDirectory(), "temp.jpg");

        hashMap = SessionStore.getUserDetails(PostScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(PostScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();
    }


    //********** Maping ***********************************************************************************************************************************************************************
    private void maping()
    {

        //Edit Text
        et_title = (EditText)findViewById(R.id.PostScreen_Title);
        et_description = (EditText)findViewById(R.id.PostScreen_Description);
        et_price = (EditText)findViewById(R.id.PostScreen_Price);


        //Text View
        tv_addPhoto = (TextView)findViewById(R.id.PostScreen_AddPhotoText);
        tv_postSubmit = (TextView)findViewById(R.id.PostScreen_PostSubmit);
        tv_chooseCategory = (TextView)findViewById(R.id.PostScreen_ChooseCategory);
        tv_expirydate = (TextView)findViewById(R.id.PostScreen_ExpiryDate);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //ImageView
        iv_photo1 = (ImageView)findViewById(R.id.PostScreen_AddPhoto1);
        iv_photo2 = (ImageView)findViewById(R.id.PostScreen_AddPhoto2);
        iv_photo3 = (ImageView)findViewById(R.id.PostScreen_AddPhoto3);
        iv_photo4 = (ImageView)findViewById(R.id.PostScreen_AddPhoto4);

        //CheckBox
        chb_privacyPolicy = (CheckBox)findViewById(R.id.PostScreen_PrivacyPolicy);


        setValue();


    }//end of maping

    //************** Set Value *******************************************************************************************************************************************************************

    private void setValue()
    {

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }


        imageList.clear();


        ss_privacyPolicy = new SpannableString(getString(R.string.privacypolicy_postscreen));
        ss_privacyPolicy.setSpan(new MyClickableSpanForPrivacyPolicy(), 16, 30, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        chb_privacyPolicy.setText(ss_privacyPolicy);
        chb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());


        ss_privacyPolicy.setSpan(new MyClickableSpanForTermsOfUse(), 48, 61, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        chb_privacyPolicy.setText(ss_privacyPolicy);
        chb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());



        //tv_save.setText(getString(R.string.fa_bell_o));
        tv_title.setText(getString(R.string.title_postscreen));
        //tv_back.setText(getString(R.string.fa_chevron_left));



        iv_photo2.setEnabled(false);
        iv_photo3.setEnabled(false);
        iv_photo4.setEnabled(false);



        iv_photo1.setOnClickListener(PostScreen_Activity.this);
        iv_photo2.setOnClickListener(PostScreen_Activity.this);
        iv_photo3.setOnClickListener(PostScreen_Activity.this);
        iv_photo4.setOnClickListener(PostScreen_Activity.this);
        tv_back.setOnClickListener(PostScreen_Activity.this);
        tv_save.setOnClickListener(PostScreen_Activity.this);
        tv_expirydate.setOnClickListener(PostScreen_Activity.this);
        tv_chooseCategory.setOnClickListener(PostScreen_Activity.this);
        tv_postSubmit.setOnClickListener(PostScreen_Activity.this);



    }//end of setValue

//***** On CLick *********************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {

        switch (v.getId())
        {

            case R.id.PostScreen_AddPhoto1:
                int_photopos =1;

                Image_Picker_Dialog();


                break;
            case R.id.PostScreen_AddPhoto2:
                int_photopos = 2;
                Image_Picker_Dialog();

                break;


            case R.id.PostScreen_AddPhoto3:
                int_photopos= 3;
                Image_Picker_Dialog();

                break;


            case R.id.PostScreen_AddPhoto4:
                int_photopos=4;
                Image_Picker_Dialog();

                break;



            case R.id.PostScreen_ChooseCategory:

                Intent intent = new Intent(PostScreen_Activity.this, CategoryScreen_Activity.class);
                startActivityForResult(intent,2020);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);


                break;




            case R.id.PostScreen_ExpiryDate:

                showDialog(0);

                break;



            case R.id.Header_Back:

                onBackPressed();

                break;


            case R.id.Header_Save:

                 intent = new Intent(PostScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;


            case R.id.PostScreen_PostSubmit:

                post();

                break;


        }// End Of switch

    }//end of on click



    //*********** Post  ******************************************************************************************************************

    private void post()
    {

        if (!str_categoryId.trim().equalsIgnoreCase("") && !tv_chooseCategory.getText().toString().trim().equalsIgnoreCase("Choose category"))
        {

            if (imageList.size()>0)
            {

                if (!et_title.getText().toString().trim().equalsIgnoreCase(""))
                {

                    if (!et_description.getText().toString().trim().equalsIgnoreCase(""))
                    {

                        if (!et_price.getText().toString().trim().equalsIgnoreCase(""))
                        {

                         /*   if (chb_privacyPolicy.isChecked())
                            {*/
                                try {

                                    JSONObject json = new JSONObject();
                                    json.put("user_id", Integer.parseInt(hashMap.get(SessionStore.USER_ID)));
                                    json.put("post_title", et_title.getText().toString().trim());
                                    json.put("university_id", Integer.parseInt(hashMap.get(SessionStore.UNIVERSITY_ID)));
                                    json.put("post_cat_id", Integer.parseInt(str_categoryId));
                                    json.put("description", et_description.getText().toString().trim());
                                    json.put("price", et_price.getText().toString().trim());
                                    json.put("create_date", DateCoversion.getUTCDateTime());
                                    json.put("expirydate", tv_expirydate.getText().toString().trim()+" "+DateCoversion.getUTCTime());

                                    JSONArray jarray = new JSONArray();
                                    JSONObject jj = new JSONObject();

                                    for (int i = 0; i < imageList.size(); i++) {
                                        jarray.put(imageList.get(i));

                                    }

                                    json.put("images", jarray);

                                    Post_AsyncTask po = new Post_AsyncTask(PostScreen_Activity.this, et_title, et_description, et_price, tv_expirydate, tv_chooseCategory, iv_photo1, iv_photo2, iv_photo3, iv_photo4, chb_privacyPolicy, imageList, str_categoryId, str_categoryName);
                                    po.execute(json.toString());




                                }catch(Exception e)
                                {
                                    Log.e("Exception ","Post Exception: "+e.getMessage());
                                }

                         /*   }
                            else
                            {

                                Toast toast=  Toast.makeText(PostScreen_Activity.this, getString(R.string.blank_privacypolicy_alert), Toast.LENGTH_SHORT);
                                toast.setGravity(Gravity.CENTER,0,0);
                                toast.show();
                            }*/
                        }
                        else
                        {

                            Toast toast= Toast.makeText(PostScreen_Activity.this, getString(R.string.price_alert_postscreen), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER,0,0);
                            toast.show();
                        }
                    }
                    else
                    {

                        Toast toast=  Toast.makeText(PostScreen_Activity.this, getString(R.string.description_alert_postscreen), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }
                }
                else
                {

                    Toast toast=  Toast.makeText(PostScreen_Activity.this, getString(R.string.blank_title_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }
            }
            else
            {

                Toast toast=  Toast.makeText(PostScreen_Activity.this, getString(R.string.photo_alert_postscreen), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
            }
        }
        else
        {

            Toast toast=  Toast.makeText(PostScreen_Activity.this, getString(R.string.blank_choosecategory_alert), Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER,0,0);
            toast.show();
        }



    }



    // ********************* Date Picker **************************************************************************************************

    @Override
    protected Dialog onCreateDialog(int id) {

        if (id==0 || id==1)
        {
            DatePickerDialog _date = new DatePickerDialog(this, datePickerListener, calender.get(Calendar.YEAR),calender.get(Calendar.MONTH),calender.get(Calendar.DATE));

           /* DatePickerDialog _date =   new DatePickerDialog(this, datePickerListener, calender.get(Calendar.YEAR),calender.get(Calendar.MONTH),calender.get(Calendar.DATE)){
                @Override
                public void onDateChanged(DatePicker view, int year, int monthOfYear, int dayOfMonth)
                {

                    view.setMinDate(System.currentTimeMillis() - 1000);

                }
            };
*/


            Calendar c = Calendar.getInstance();
            c.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH),(calender.get(Calendar.DATE)+30));

            _date.getDatePicker().setMaxDate(c.getTimeInMillis());
            _date.getDatePicker().setMinDate(System.currentTimeMillis() - 1000);

            return _date;


        }
        else if (id==2 || id==3) {
            //return new TimePickerDialog(this, timePickerListener,  calender.get(Calendar.HOUR_OF_DAY), calender.get(Calendar.MINUTE),false);
        }


        return null;

    }

    private DatePickerDialog.OnDateSetListener datePickerListener = new DatePickerDialog.OnDateSetListener() {

        // when dialog box is closed, below method will be called.
        public void onDateSet(DatePicker view, int selectedYear,int selectedMonth, int selectedDay) {
            //st_date = DateCoversion.getSelectedCalenderDate(selectedDay + "/" + (selectedMonth + 1) + "/" + selectedYear);
            tv_expirydate.setText(DateCoversion.getDateMMM(selectedDay + "/" + (selectedMonth + 1) + "/" + selectedYear));




        }
    };



    /// ***************** Take Photo ******************************************************************************


    public void Image_Picker_Dialog()
    {

        AlertDialog.Builder myAlertDialog = new AlertDialog.Builder(this);
        myAlertDialog.setTitle("Pictures Option");
        myAlertDialog.setMessage("Select Picture Mode");

        myAlertDialog.setPositiveButton("Gallery", new DialogInterface.OnClickListener()
        {
            public void onClick(DialogInterface arg0, int arg1)
            {

                mImageCaptureUri=null;

                Intent i = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(i, 200);
              /*  Intent i = new Intent(
                        Intent.ACTION_PICK,
                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

                startActivityForResult(i, 100);*/

            }
        });

        myAlertDialog.setNegativeButton("Camera", new DialogInterface.OnClickListener()
        {
            public void onClick(DialogInterface arg0, int arg1)
            {
               /* Intent cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                startActivityForResult(cameraIntent, 200);
*/
               // getParent().startActivityForResult(cameraIntent, Settings.Global.CAMERA_PIC_REQUEST);
              //  mImageCaptureUri=null;

                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                mImageCaptureUri = Uri.fromFile(new File(Environment.getExternalStorageDirectory(), "tmp_avatar_" + String.valueOf(System.currentTimeMillis()) + ".jpg"));
                intent.putExtra(android.provider.MediaStore.EXTRA_OUTPUT, mImageCaptureUri);
                startActivityForResult(intent, 100);
            }
        });
        myAlertDialog.show();

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == 200 && resultCode == RESULT_OK && null != data)
        {
            mImageCaptureUri = data.getData();
            Log.e("Gallery Image URI : " ," "+ mImageCaptureUri);
            CropingIMG();

        } else if (requestCode == 100 && resultCode == Activity.RESULT_OK) {

            Log.e("Camera Image URI : "," "+mImageCaptureUri);
            CropingIMG();
        }


        else if (requestCode == 301)
        {

            try {
                if(outPutFile.exists())
                {
                    Bitmap photo = decodeFile(outPutFile);
                    Uri selectedImage = data.getData();

                    //Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);
                    ByteArrayOutputStream stream = new ByteArrayOutputStream();
                    photo.compress(Bitmap.CompressFormat.PNG, 40, stream);
                    byte[] byteArray = stream.toByteArray();
                    String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

                    Comman.EncodeImg="";
                    Comman.EncodeImg=encoded;

                    if (int_photopos==1)
                    {
                        iv_photo1.setImageBitmap(photo);
                        iv_photo2.setEnabled(true);
                        // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);

                        if (imageList.size()>=1)
                        {
                            imageList.set(0,encoded);
                        }
                        else
                        {
                            imageList.add(encoded);
                        }
                    }
                    if (int_photopos==2)
                    {
                        //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                        iv_photo2.setImageBitmap(photo);
                        iv_photo3.setEnabled(true);

                        if (imageList.size()>=2)
                        {
                            imageList.set(1,encoded);
                        }
                        else
                        {
                            imageList.add(encoded);
                        }

                    }if (int_photopos==3)
                    {
                    //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                    iv_photo3.setImageBitmap(photo);
                    iv_photo4.setEnabled(true);

                    if (imageList.size()>=3)
                    {
                        imageList.set(2,encoded);
                    }
                    else
                    {
                        imageList.add(encoded);
                    }
                    }if (int_photopos==4)
                    {
                        // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                        iv_photo4.setImageBitmap(photo);

                        if (imageList.size()>=4)
                        {
                            imageList.set(3,encoded);
                        }
                        else
                        {
                            imageList.add(encoded);
                        }
                    }
                    Log.e("image List Size", " " + imageList.size());
                    }
                else {
                    Toast.makeText(getApplicationContext(), "Error while save image", Toast.LENGTH_SHORT).show();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


     /*   // For Gating Image From Camara or Gallary
        if (requestCode == 100 && resultCode == RESULT_OK && data!= null) {


            Uri selectedImage = data.getData();
            String[] filePathColumn = {MediaStore.Images.Media.DATA };

            Cursor cursor = getContentResolver().query(selectedImage,
            filePathColumn, null, null, null);
            cursor.moveToFirst();

            int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
            String picturePath = cursor.getString(columnIndex);
            cursor.close();

            Bitmap bmp = BitmapFactory.decodeFile(picturePath);

          //  Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);

            ByteArrayOutputStream stream = new ByteArrayOutputStream();

            bmp = getResizedBitmap(bmp,300,300);
            bmp.compress(Bitmap.CompressFormat.PNG, 90, stream);
            byte[] byteArray = stream.toByteArray();

            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            if (int_photopos==1)
            {

                iv_photo1.setImageBitmap(bmp);
                iv_photo2.setEnabled(true);
               // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);

                if (imageList.size()>=1)
                {
                   imageList.set(0,encoded);

                }
                else
                {

                    imageList.add(encoded);
                }

            }
            if (int_photopos==2)
            {

              //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo2.setImageBitmap(bmp);
                iv_photo3.setEnabled(true);

                if (imageList.size()>=2)
                {
                    imageList.set(1,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }

            }if (int_photopos==3)
            {

              //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo3.setImageBitmap(bmp);
                iv_photo4.setEnabled(true);

                if (imageList.size()>=3)
                {
                    imageList.set(2,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }
            }if (int_photopos==4)
            {
               // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo4.setImageBitmap(bmp);

                if (imageList.size()>=4)
                {
                    imageList.set(3,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }
            }




        }
        else  if (requestCode == 200 && resultCode == RESULT_OK) {

            Bitmap bmp = (Bitmap) data.getExtras().get("data");


            Uri selectedImage = data.getData();

            //Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            bmp = getResizedBitmap(bmp,100,100);
            bmp.compress(Bitmap.CompressFormat.PNG, 90, stream);
            byte[] byteArray = stream.toByteArray();
            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            if (int_photopos==1)
            {

                iv_photo1.setImageBitmap(bmp);
                iv_photo2.setEnabled(true);
                // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);

                if (imageList.size()>=1)
                {
                    imageList.set(0,encoded);

                }
                else
                {

                    imageList.add(encoded);
                }

            }
            if (int_photopos==2)
            {

                //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo2.setImageBitmap(bmp);
                iv_photo3.setEnabled(true);

                if (imageList.size()>=2)
                {
                    imageList.set(1,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }

            }if (int_photopos==3)
            {

                //  Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo3.setImageBitmap(bmp);
                iv_photo4.setEnabled(true);

                if (imageList.size()>=3)
                {
                    imageList.set(2,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }
            }if (int_photopos==4)
            {
                // Picasso.with(PostScreen_Activity.this).load(selectedImage).transform(new RoundedTransformation(50, 0)).into(iv_photo1);
                iv_photo4.setImageBitmap(bmp);

                if (imageList.size()>=4)
                {
                    imageList.set(3,encoded);
                }
                else
                {
                    imageList.add(encoded);
                }
            }

        }
*/
       // Geting Result fro choose Category


        if (requestCode == 2020)
        {
            if (resultCode == RESULT_OK) {

                str_categoryId = data.getStringExtra("ID");
                str_categoryName= data.getStringExtra("DemainName");
                tv_chooseCategory.setText(str_categoryName.trim());
            }
            if (resultCode == RESULT_CANCELED) {
                //Write your code if there's no result
              }
        }

        Log.e("dsdasd", "List llddldlsd:  " + imageList.size());
    }

    private void CropingIMG()
    {
        final ArrayList<CropingOption> cropOptions = new ArrayList<CropingOption>();

        Intent intent = new Intent("com.android.camera.action.CROP");
        intent.setType("image/*");

        List<ResolveInfo> list = getPackageManager().queryIntentActivities(intent, 0 );

        int size = list.size();
        if (size == 0)
        {
            Toast.makeText(this, "Cann't find image croping app", Toast.LENGTH_SHORT).show();
            return;
        } else {
            intent.setData(mImageCaptureUri);
            intent.putExtra("outputX", 512);
            intent.putExtra("outputY", 512);
            intent.putExtra("aspectX", 1);
            intent.putExtra("aspectY", 1);
            intent.putExtra("scale", true);

            //TODO: don't use return-data tag because it's not return large image data and crash not given any message
            //intent.putExtra("return-data", true);

            //Create output file here
            intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(outPutFile));

            if (size == 1)
            {
                Intent i   = new Intent(intent);
                ResolveInfo res = (ResolveInfo) list.get(0);

                i.setComponent( new ComponentName(res.activityInfo.packageName, res.activityInfo.name));

                startActivityForResult(i, 301);
            }
            else
            {
                for (ResolveInfo res : list)
                {
                    final CropingOption co = new CropingOption();

                    co.title  = getPackageManager().getApplicationLabel(res.activityInfo.applicationInfo);
                    co.icon  = getPackageManager().getApplicationIcon(res.activityInfo.applicationInfo);
                    co.appIntent= new Intent(intent);
                    co.appIntent.setComponent( new ComponentName(res.activityInfo.packageName, res.activityInfo.name));
                    cropOptions.add(co);
                }

                CropingOptionAdapter adapter = new CropingOptionAdapter(getApplicationContext(), cropOptions);

                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("Choose Croping App");
                builder.setCancelable(false);
                builder.setAdapter( adapter, new DialogInterface.OnClickListener()
                {
                    public void onClick( DialogInterface dialog, int item ) {
                        startActivityForResult( cropOptions.get(item).appIntent, 301);
                    }
                });

                builder.setOnCancelListener( new DialogInterface.OnCancelListener() {
                    @Override
                    public void onCancel( DialogInterface dialog ) {
                        if (mImageCaptureUri != null ) {
                            getContentResolver().delete(mImageCaptureUri, null, null );
                            mImageCaptureUri = null;
                        }
                    }
                } );

                AlertDialog alert = builder.create();
                alert.show();
            }
        }
    }

    public Bitmap getResizedBitmap(Bitmap bm, int newHeight, int newWidth) {
        int width = bm.getWidth();
        int height = bm.getHeight();
        float scaleWidth = ((float) newWidth) / width;
        float scaleHeight = ((float) newHeight) / height;
        // CREATE A MATRIX FOR THE MANIPULATION
        Matrix matrix = new Matrix();
        // RESIZE THE BIT MAP
        matrix.postScale(scaleWidth, scaleHeight);

        // "RECREATE" THE NEW BITMAP
        Bitmap resizedBitmap = Bitmap.createBitmap(bm, 0, 0, width, height, matrix, false);

        return resizedBitmap;
    }

    private Bitmap decodeFile(File f) {
        try {
            // decode image size
            BitmapFactory.Options o = new BitmapFactory.Options();
            o.inJustDecodeBounds = true;
            BitmapFactory.decodeStream(new FileInputStream(f), null, o);

            // Find the correct scale value. It should be the power of 2.
            final int REQUIRED_SIZE = 512;
            int width_tmp = o.outWidth, height_tmp = o.outHeight;
            int scale = 1;
            while (true) {
                if (width_tmp / 2 < REQUIRED_SIZE || height_tmp / 2 < REQUIRED_SIZE)
                    break;
                width_tmp /= 2;
                height_tmp /= 2;
                scale *= 2;
            }

            // decode with inSampleSize
            BitmapFactory.Options o2 = new BitmapFactory.Options();
            o2.inSampleSize = scale;
            return BitmapFactory.decodeStream(new FileInputStream(f), null, o2);
        } catch (FileNotFoundException e) {
        }
        return null;
    }


    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

    }
    @Override
    protected void onResume() {
        super.onResume();


        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        hashMap = SessionStore.getUserDetails(PostScreen_Activity.this, Comman.PRIFRENS_NAME);
    }
    //***************** on Click on particular  word ****************************************************************************************************************

    class MyClickableSpanForPrivacyPolicy extends ClickableSpan { //clickable span
        public void onClick(View textView) {


            Intent intent = new Intent(PostScreen_Activity.this, PrivacyPolicyScreen_Activity.class);
            startActivity(intent);
            overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);

        }
        @Override
        public void updateDrawState(TextPaint ds) {
            //ds.setColor(Color.BLACK);//set text color
            ds.setUnderlineText(true); // set to false to remove underline
        }
    }
    //***************** on Click on particular  word ****************************************************************************************************************

    class MyClickableSpanForTermsOfUse extends ClickableSpan { //clickable span
        public void onClick(View textView) {


            Intent intent = new Intent(PostScreen_Activity.this, TermsAndConditionScreen_Activity.class);
            startActivity(intent);
            overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);

        }
        @Override
        public void updateDrawState(TextPaint ds) {
            //ds.setColor(Color.BLACK);//set text color
            ds.setUnderlineText(true); // set to false to remove underline
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(PostScreen_Activity.this);
    }

}
