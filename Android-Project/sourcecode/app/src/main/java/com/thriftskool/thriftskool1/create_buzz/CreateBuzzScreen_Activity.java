package com.thriftskool.thriftskool1.create_buzz;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.net.Uri;
import android.provider.MediaStore;
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
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.CreateBuzz_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.Post_AsyncTask;
import com.thriftskool.thriftskool1.category.CategoryScreen_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.privacy_policy.PrivacyPolicyScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.terms_and_condition.TermsAndConditionScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

public class CreateBuzzScreen_Activity extends Activity implements View.OnClickListener {

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



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_buzz_screen_);
        calender = Calendar.getInstance();

        hashMap = SessionStore.getUserDetails(CreateBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(CreateBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();
    }


    //********** Maping ***********************************************************************************************************************************************************************
    private void maping()
    {

        //Edit Text
        et_title = (EditText)findViewById(R.id.CreateBuzzScreen_Title);
        et_description = (EditText)findViewById(R.id.CreateBuzzScreen_Description);


        //Text View
        tv_addPhoto = (TextView)findViewById(R.id.CreateBuzzScreen_AddPhotoText);
        tv_postSubmit = (TextView)findViewById(R.id.CreateBuzzScreen_PostSubmit);
        tv_expirydate = (TextView)findViewById(R.id.CreateBuzzScreen_ExpiryDate);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //ImageView
        iv_photo1 = (ImageView)findViewById(R.id.CreateBuzzScreen_AddPhoto1);
        iv_photo2 = (ImageView)findViewById(R.id.CreateBuzzScreen_AddPhoto2);
        iv_photo3 = (ImageView)findViewById(R.id.CreateBuzzScreen_AddPhoto3);
        iv_photo4 = (ImageView)findViewById(R.id.CreateBuzzScreen_AddPhoto4);

        //CheckBox
        chb_privacyPolicy = (CheckBox)findViewById(R.id.CreateBuzzScreen_PrivacyPolicy);


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
        ss_privacyPolicy = new SpannableString(getString(R.string.privacypolicy_createbuzzscreen));
        ss_privacyPolicy.setSpan(new MyClickableSpanForPrivacyPolicy(), 16, 30, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        chb_privacyPolicy.setText(ss_privacyPolicy);
        chb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());


        ss_privacyPolicy.setSpan(new MyClickableSpanForTermsOfUse(), 48, 60, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        chb_privacyPolicy.setText(ss_privacyPolicy);
        chb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());


        //tv_save.setText(getString(R.string.fa_bell_o));
        tv_title.setText("Create Buzz");
        //tv_back.setText(getString(R.string.fa_chevron_left));



        iv_photo2.setEnabled(false);
        iv_photo3.setEnabled(false);
        iv_photo4.setEnabled(false);



        iv_photo1.setOnClickListener(CreateBuzzScreen_Activity.this);
        iv_photo2.setOnClickListener(CreateBuzzScreen_Activity.this);
        iv_photo3.setOnClickListener(CreateBuzzScreen_Activity.this);
        iv_photo4.setOnClickListener(CreateBuzzScreen_Activity.this);
        tv_back.setOnClickListener(CreateBuzzScreen_Activity.this);
        tv_save.setOnClickListener(CreateBuzzScreen_Activity.this);
        tv_expirydate.setOnClickListener(CreateBuzzScreen_Activity.this);
        tv_postSubmit.setOnClickListener(CreateBuzzScreen_Activity.this);



    }//end of setValue

//***** On CLick *********************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {

        switch (v.getId())
        {

            case R.id.CreateBuzzScreen_AddPhoto1:
                int_photopos =1;

                Image_Picker_Dialog();


                break;
            case R.id.CreateBuzzScreen_AddPhoto2:
                int_photopos = 2;
                Image_Picker_Dialog();

                break;


            case R.id.CreateBuzzScreen_AddPhoto3:
                int_photopos= 3;
                Image_Picker_Dialog();

                break;


            case R.id.CreateBuzzScreen_AddPhoto4:
                int_photopos=4;
                Image_Picker_Dialog();

                break;


            case R.id.CreateBuzzScreen_ExpiryDate:

                showDialog(0);

                break;



            case R.id.Header_Back:

                onBackPressed();

                break;


            case R.id.Header_Save:

                Intent intent = new Intent(CreateBuzzScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;



            case R.id.CreateBuzzScreen_PostSubmit:


                if (CheckInterNetConnection.isNetworkAvailable(CreateBuzzScreen_Activity.this))
                {

                    post();
                }
                else
                {

                    new AlertDialog.Builder(CreateBuzzScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {



                                }
                            }).show();


                }
                break;


        }// End Of switch

    }//end of on click



    //*********** Post  ******************************************************************************************************************

    private void post()
    {

            if (imageList.size()>0)
            {

                if (!et_title.getText().toString().trim().equalsIgnoreCase(""))
                {

                    if (!et_description.getText().toString().trim().equalsIgnoreCase(""))
                    {


                          /*  if (chb_privacyPolicy.isChecked())
                            {*/
                                try {
                                    JSONObject json = new JSONObject();
                                    json.put("user_id", Integer.parseInt(hashMap.get(SessionStore.USER_ID)));
                                    json.put("buzz_title", et_title.getText().toString().trim());
                                    json.put("university_id", Integer.parseInt(hashMap.get(SessionStore.UNIVERSITY_ID)));
                                   // json.put("post_cat_id", Integer.parseInt(str_categoryId));
                                    json.put("description", et_description.getText().toString().trim());
                                    //json.put("price", et_price.getText().toString().trim());
                                    //json.put("create_date", DateCoversion.getCurrentData());
                                    json.put("expirydate", tv_expirydate.getText().toString().trim()+" "+DateCoversion.getUTCTime());

                                    JSONArray jarray = new JSONArray();
                                    JSONObject jj = new JSONObject();

                                    for (int i = 0; i < imageList.size(); i++) {
                                        jarray.put(imageList.get(i));

                                    }

                                    json.put("images", jarray);




                                    CreateBuzz_AsyncTask po = new CreateBuzz_AsyncTask(CreateBuzzScreen_Activity.this);
                                    po.execute(json.toString());

                                }catch(Exception e)
                                {
                                    Log.e("Exception ", "Post Exception: " + e.getMessage());
                                }

                        /*    }
                            else
                            {


                                Toast toast=  Toast.makeText(CreateBuzzScreen_Activity.this, getString(R.string.blank_privacypolicy_alert), Toast.LENGTH_SHORT);
                                toast.setGravity(Gravity.CENTER,0,0);
                                toast.show();
                            }*/

                    }
                    else
                    {


                        Toast toast=  Toast.makeText(CreateBuzzScreen_Activity.this, getString(R.string.description_alert_postscreen), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }
                }
                else
                {


                    Toast toast= Toast.makeText(CreateBuzzScreen_Activity.this, getString(R.string.blank_title_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }
            }
            else
            {


                Toast toast=  Toast.makeText(CreateBuzzScreen_Activity.this, getString(R.string.photo_alert_postscreen), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
            }



    }



    // ********************* Date Picker **************************************************************************************************

    @Override
    protected Dialog onCreateDialog(int id) {

        if (id==0 || id==1) {

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
           // c.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH),(calender.get(Calendar.DATE)+30));
            c.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH),(calender.get(Calendar.DATE)+30));
           // _date.getDatePicker().setMaxDate(c.getTimeInMillis());

            _date.getDatePicker().setMinDate(System.currentTimeMillis() - 1000);

            return _date;


        }
        else if (id==2 || id==3) {
            //return new TimePickerDialog(this, timePickerListener,  calender.get(Calendar.HOUR_OF_DAY), calender.get(Calendar.MINUTE),false);
        }


        return null;

    }

    private DatePickerDialog.OnDateSetListener datePickerListener = new DatePickerDialog.OnDateSetListener()
    {

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

                Intent i = new Intent(
                        Intent.ACTION_PICK,
                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

                startActivityForResult(i, 100);

            }
        });

        myAlertDialog.setNegativeButton("Camera", new DialogInterface.OnClickListener()
        {
            public void onClick(DialogInterface arg0, int arg1)
            {
                Intent cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                startActivityForResult(cameraIntent, 200);

                // getParent().startActivityForResult(cameraIntent, Settings.Global.CAMERA_PIC_REQUEST);
            }
        });
        myAlertDialog.show();

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);



        // For Gating Image From Camara or Gallary
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

            Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);

            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            resized = getResizedBitmap(resized,300,300);
            resized.compress(Bitmap.CompressFormat.PNG, 90, stream);
            byte[] byteArray = stream.toByteArray();

            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

            Log.e("dsdasd", "sfsafdf "+encoded);

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

            Log.e("helllll ","dsdsadasd: pankaj saad saad saad saad: "+int_photopos);

            Uri selectedImage = data.getData();

            //Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);
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

        // Geting Result fro choose Category


        if (requestCode == 2020) {
            if (resultCode == RESULT_OK) {

                str_categoryId = data.getStringExtra("ID");
                str_categoryName= data.getStringExtra("DemainName");
                tv_chooseCategory.setText(str_categoryName.trim());




            }
            if (resultCode == RESULT_CANCELED) {

            }
        }


        Log.e("dsdasd", "List llddldlsd:  " + imageList.size());


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


        hashMap = SessionStore.getUserDetails(CreateBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);
    }




    //***************** on Click on particular  word ****************************************************************************************************************

    class MyClickableSpanForPrivacyPolicy extends ClickableSpan { //clickable span
        public void onClick(View textView) {


            Intent intent = new Intent(CreateBuzzScreen_Activity.this, PrivacyPolicyScreen_Activity.class);
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


            Intent intent = new Intent(CreateBuzzScreen_Activity.this, TermsAndConditionScreen_Activity.class);
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
        CrearCashMemmory.trimCache(CreateBuzzScreen_Activity.this);
    }

}
