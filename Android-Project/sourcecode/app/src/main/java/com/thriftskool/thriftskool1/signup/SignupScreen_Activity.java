package com.thriftskool.thriftskool1.signup;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Matrix;
import android.media.ExifInterface;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.TextUtils;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Base64;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.CropingOption;
import com.thriftskool.thriftskool1.CropingOptionAdapter;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.Signup_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.UniversityList_AsyncTask;
import com.thriftskool.thriftskool1.been.ClassList_Been;
import com.thriftskool.thriftskool1.been.UniversityList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.privacy_policy.PrivacyPolicyScreen_Activity;
import com.thriftskool.thriftskool1.terms_and_condition.TermsAndConditionScreen_Activity;
import com.thriftskool.thriftskool1.university.UnivarsityScreen_Activity;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

public class SignupScreen_Activity extends Activity implements View.OnClickListener {

    private EditText et_email, et_username, et_password, et_confirmpassword,et_class,et_name;
    private TextView tv_submit, tv_university;
    private CheckBox checkb_privacyPolicy;
    public static String str_universityId="0";
    private ImageView iv_logo,iv_prifileImg;
    private SpannableString ss_privacyPolicy,ss_termsOfUse;
    private List<String> imageList = new ArrayList<String>();
    String picturePath;
    Spinner spinner;
    List<String>Class_liast;
    String class_name,claas_id;

    // corp
     Uri mImageCaptureUri;
     File outPutFile = null;
    private Uri picUri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup_screen_);

        Log.e("imgList size...", " " + imageList.size());
        Log.e("Comment img ..."," "+Comman.EncodeImg);

        outPutFile = new File(android.os.Environment.getExternalStorageDirectory(), "temp.jpg");

        maping();
    }


    //***************** Maping ******************************************************************************************************************************************************************

    private void maping()
    {

        //Edit Text Maping
        et_username = (EditText)findViewById(R.id.SignupScreen_UserName);
        et_email = (EditText)findViewById(R.id.SignupScreen_Email);
        et_password = (EditText)findViewById(R.id.SignupScreen_Password);
        et_confirmpassword = (EditText)findViewById(R.id.SignupScreen_ConfirmPassword);
       // et_class = (EditText)findViewById(R.id.SignupScreen_Class);
        et_name = (EditText)findViewById(R.id.SignupScreen_Name);

        //ImageView
        iv_logo = (ImageView)findViewById(R.id.SignupScreen_logo);
        iv_prifileImg = (ImageView)findViewById(R.id.CandidateProfile_image);

        //TextView Maping
        tv_university = (TextView)findViewById(R.id.SignupScreen_University);
        tv_submit = (TextView)findViewById(R.id.SignupScreen_Submit);

        // CheckBox
        checkb_privacyPolicy = (CheckBox)findViewById(R.id.SignupScreen_PrivacyPolicy);

        //Spiner
        spinner=(Spinner)findViewById(R.id.SignupScreen_Class);
        setValue();
    }


    //******* SetValue mehtod ******************************************************************************************************************************************************************

    private void setValue()
    {



        ss_privacyPolicy = new SpannableString(getString(R.string.privacypolicy_signupscreen));
        ss_privacyPolicy.setSpan(new MyClickableSpanForPrivacyPolicy(), 16, 30, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        checkb_privacyPolicy.setText(ss_privacyPolicy);
        checkb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());


        ss_privacyPolicy.setSpan(new MyClickableSpanForTermsOfUse(), 48, 60, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        checkb_privacyPolicy.setText(ss_privacyPolicy);
        checkb_privacyPolicy.setMovementMethod(LinkMovementMethod.getInstance());



        et_email.setEnabled(false);
        et_username.setEnabled(false);
        et_password.setEnabled(false);
        et_confirmpassword.setEnabled(false);
        //checkb_privacyPolicy.setEnabled(false);


        Picasso.with(SignupScreen_Activity.this).load(R.drawable.logo).into(iv_logo);

        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                class_name = LoginSignupScreen_Activity.class_List.get(position).getClass_name();
                claas_id = LoginSignupScreen_Activity.class_List.get(position).getInt_glcode();
                Log.e("Class ..id,,,","  "+claas_id);

            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        try {
            ArrayAdapter<String> adapter = new ArrayAdapter<String>(SignupScreen_Activity.this, android.R.layout.simple_list_item_1, android.R.id.text1, LoginSignupScreen_Activity.classList_2);
            spinner.setAdapter(adapter);

        } catch (Exception e) {
            // e.printStackTrace();
        }

        tv_submit.setOnClickListener(SignupScreen_Activity.this);
                tv_university.setOnClickListener(SignupScreen_Activity.this);
                iv_prifileImg.setOnClickListener(SignupScreen_Activity.this);

    }


        //*********** OnClick **********************************************************************************************************************************************************************


        @Override
        public void onClick(View v) {

            switch (v.getId())
            {
                case R.id.SignupScreen_Submit:

                saveData();

                break;

            case R.id.SignupScreen_University:

                if (CheckInterNetConnection.isNetworkAvailable(SignupScreen_Activity.this))
                {

                Intent intent = new Intent(SignupScreen_Activity.this, UnivarsityScreen_Activity.class);
                startActivityForResult(intent,2020);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                }
                else
                {

                    new AlertDialog.Builder(SignupScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            }).show();
                }

                break;

                case  R.id.CandidateProfile_image:
                    Image_Picker_Dialog();
                    break;
        }

    }

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
                startActivityForResult(cameraIntent, 200);*/

                mImageCaptureUri=null;

                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                mImageCaptureUri = Uri.fromFile(new File(Environment
                        .getExternalStorageDirectory(), "tmp_avatar_" + String.valueOf(System.currentTimeMillis())
                        + ".jpg"));
                intent.putExtra(android.provider.MediaStore.EXTRA_OUTPUT,
                        mImageCaptureUri);
                startActivityForResult(intent, 100);

            }
        });

        myAlertDialog.show();
    }


    //****** ********************************************************************************************************************************************************************************

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);


        if (requestCode == 2020) {
            if (resultCode == RESULT_OK) {
                str_universityId = data.getStringExtra("ID");
                tv_university.setText(data.getStringExtra("Name"));

                et_username.setEnabled(true);
                et_email.setEnabled(true);
                et_password.setEnabled(true);
                et_confirmpassword.setEnabled(true);
                checkb_privacyPolicy.setEnabled(true);

            }
            if (resultCode == RESULT_CANCELED) {
                //Write your code if there's no result

            }
        }

       /* if (requestCode == 100 && resultCode == RESULT_OK && data!= null)
        {


            Uri selectedImage = data.getData();
            String[] filePathColumn = {MediaStore.Images.Media.DATA };

            Cursor cursor = getContentResolver().query(selectedImage,
                    filePathColumn, null, null, null);
            cursor.moveToFirst();

            int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
            picturePath = cursor.getString(columnIndex);
            cursor.close();

            Bitmap bmp = BitmapFactory.decodeFile(picturePath);

            //  Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);


            bmp = getResizedBitmap(bmp,400,400);
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            bmp.compress(Bitmap.CompressFormat.PNG, 100, stream);

            byte[] byteArray = stream.toByteArray();

            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

            //iv_image1.setVisibility(View.GONE);
            iv_prifileImg.setImageBitmap(bmp);


            if (imageList.size()>=1)
            {

                Comman.EncodeImg="";

                Comman.EncodeImg=encoded;

                imageList.set(0,encoded);

                Log.e("Encode true", " " + imageList.size());

            }
            else
            {

                Comman.EncodeImg=encoded;

                imageList.add(encoded);
                Log.e("Encode false", " " + imageList.size());

            }

        }
        else  if (requestCode == 200 && resultCode == RESULT_OK)
        {

            Bitmap bmp = (Bitmap) data.getExtras().get("data");


            Uri selectedImage = data.getData();

            //Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);
            bmp = getResizedBitmap(bmp,400,400);
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            bmp.compress(Bitmap.CompressFormat.PNG, 100, stream);
            byte[] byteArray = stream.toByteArray();
            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

            //iv_image1.setVisibility(View.GONE);
            iv_prifileImg.setImageBitmap(bmp);


            if (imageList.size()>=1)
            {
                Comman.EncodeImg="";

                Comman.EncodeImg=encoded;

                imageList.set(0,encoded);

            }
            else
            {
                Comman.EncodeImg=encoded;
                imageList.add(encoded);
            }

        }
        Log.e("image List Size", " " + imageList.size());*/

        if (requestCode == 200 && resultCode == RESULT_OK && null != data)
        {
            mImageCaptureUri = data.getData();
            System.out.println("Gallery Image URI : "+mImageCaptureUri);
            CropingIMG();

        } else if (requestCode == 100 && resultCode == Activity.RESULT_OK) {

            System.out.println("Camera Image URI : "+mImageCaptureUri);
            CropingIMG();
        }

        if (requestCode == 200 && resultCode == RESULT_OK && null != data)
        {
            mImageCaptureUri = data.getData();
            System.out.println("Gallery Image URI : "+mImageCaptureUri);
            CropingIMG();

        } else if (requestCode == 100 && resultCode == Activity.RESULT_OK) {

            System.out.println("Camera Image URI : "+mImageCaptureUri);
            CropingIMG();
        }

        else if (requestCode == 301)
        {

            try {
                if(outPutFile.exists())
                {
                    Bitmap photo = decodeFile(outPutFile);
                    iv_prifileImg.setImageBitmap(photo);
                    Uri selectedImage = data.getData();

                    //Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);
                    ByteArrayOutputStream stream = new ByteArrayOutputStream();
                    photo.compress(Bitmap.CompressFormat.PNG, 100, stream);
                    byte[] byteArray = stream.toByteArray();
                    String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

                    Comman.EncodeImg="";
                    Comman.EncodeImg=encoded;

                    if (imageList.size()>=1)
                    {
                        Comman.EncodeImg="";

                        Comman.EncodeImg=encoded;

                        imageList.set(0,encoded);

                    }
                    else
                    {
                        Comman.EncodeImg=encoded;
                        imageList.add(encoded);
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
    }

    ////// Crope image

    private void CropingIMG()
    {

        final ArrayList<CropingOption> cropOptions = new ArrayList<CropingOption>();

        Intent intent = new Intent("com.android.camera.action.CROP");
        intent.setType("image/*");

        List<ResolveInfo> list = getPackageManager().queryIntentActivities( intent, 0 );

        int size = list.size();
        if (size == 0) {
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




    //****************** Save Data *************************************************************************************************************************************************************


    private void saveData()
    {


      /*  if(imageList.size()>=1)
        {*/
            if (!str_universityId.equalsIgnoreCase("0")) {
                if (!et_email.getText().toString().trim().equalsIgnoreCase("")) {
                   /* if (!et_name.getText().toString().trim().equalsIgnoreCase(""))
                    {*/
                        if (isValidEmail(et_email.getText().toString().trim())) {
                            if (!et_username.getText().toString().trim().equalsIgnoreCase("")) {
                                if (!et_password.getText().toString().trim().equalsIgnoreCase("")) {
                                    if (!et_confirmpassword.getText().toString().trim().equalsIgnoreCase("")) {
                                        if (et_confirmpassword.getText().toString().trim().equalsIgnoreCase(et_password.getText().toString().trim())) {
                                            if (checkb_privacyPolicy.isChecked()) {
                                                if (CheckInterNetConnection.isNetworkAvailable(SignupScreen_Activity.this)) {
                                                    Signup_AsyncTask signup = new Signup_AsyncTask(SignupScreen_Activity.this);
                                                    signup.execute(str_universityId, et_email.getText().toString().trim(), et_username.getText().toString(), et_password.getText().toString().trim(), "5", "", "", Comman.EncodeImg);
                                                } else {
                                                    new AlertDialog.Builder(SignupScreen_Activity.this)
                                                            .setTitle("Alert!")
                                                            .setMessage(getString(R.string.internetconnection_alert))
                                                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                                                @Override
                                                                public void onClick(DialogInterface dialog, int which) {
                                                                }
                                                            }).show();
                                                }

                                            } else {
                                                Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_privacypolicy_alert), Toast.LENGTH_SHORT);
                                                toast.setGravity(Gravity.CENTER, 0, 0);
                                                toast.show();
                                            }
                                        } else {


                                            Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.passwordnotmatch_alert_signupscreen), Toast.LENGTH_SHORT);
                                            toast.setGravity(Gravity.CENTER, 0, 0);
                                            toast.show();

                                        }
                                    } else {

                                        Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_confirmpassword_alert), Toast.LENGTH_SHORT);
                                        toast.setGravity(Gravity.CENTER, 0, 0);
                                        toast.show();

                                    }
                                } else {


                                    Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_password_alert), Toast.LENGTH_SHORT);
                                    toast.setGravity(Gravity.CENTER, 0, 0);
                                    toast.show();

                                }
                            } else {

                                Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_username_alert), Toast.LENGTH_SHORT);
                                toast.setGravity(Gravity.CENTER, 0, 0);
                                toast.show();

                            }
                        } else {

                            Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.invalideemailid_alert_signupscreen), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER, 0, 0);
                            toast.show();

                        }

                 /*   } else {


                        Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_selectuniversity_name), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER, 0, 0);
                        toast.show();

                    }*/
                } else {


                    Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_email_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER, 0, 0);
                    toast.show();

                }
            } else {


                Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_selectuniversity_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();

            }
      /* }
        else {

            Toast toast = Toast.makeText(SignupScreen_Activity.this, getString(R.string.blank_editprofileImage_alert), Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER, 0, 0);
            toast.show();

        }*/
    }





    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Intent intent = new Intent(SignupScreen_Activity.this, LoginSignupScreen_Activity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();



    }

    //*********** Email Address Validity Method *************************************************************************************************************************************************

    public final static boolean isValidEmail(CharSequence target) {
        return !TextUtils.isEmpty(target) && android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
    }


    //***************** on Click on particular  word ****************************************************************************************************************


    //***************** on Click on particular  word ****************************************************************************************************************

    class MyClickableSpanForPrivacyPolicy extends ClickableSpan { //clickable span
        public void onClick(View textView) {

            Intent intent = new Intent(SignupScreen_Activity.this, PrivacyPolicyScreen_Activity.class);
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


            Intent intent = new Intent(SignupScreen_Activity.this, TermsAndConditionScreen_Activity.class);
            startActivity(intent);
            overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);

        }
        @Override
        public void updateDrawState(TextPaint ds) {
            //ds.setColor(Color.BLACK);//set text color
            ds.setUnderlineText(true); // set to false to remove underline
        }
    }

    public Bitmap getResizedBitmap(Bitmap bm, int newHeight, int newWidth)
    {
        Matrix matrix = new Matrix();

        try {
            ExifInterface exif = new ExifInterface(picturePath);
            int orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, 1);
            Log.d("EXIF", "Exif: " + orientation);

            if (orientation == 6)
            {
                matrix.postRotate(90);
            }
            else if (orientation == 3)
            {
                matrix.postRotate(180);
            }
            else if (orientation == 8)
            {
                matrix.postRotate(270);
            }
            //  myBitmap = Bitmap.createBitmap(myBitmap, 0, 0, myBitmap.getWidth(), myBitmap.getHeight(), matrix, true); // rotating bitmap
        }
        catch (Exception e)
        {

        }

        int width = bm.getWidth();
        int height = bm.getHeight();
        float scaleWidth = ((float) newWidth) / width;
        float scaleHeight = ((float) newHeight) / height;
        // CREATE A MATRIX FOR THE MANIPULATION
        //    Matrix matrix = new Matrix();
        // RESIZE THE BIT MAP
        matrix.postScale(scaleWidth, scaleHeight);

        // "RECREATE" THE NEW BITMAP
        Bitmap resizedBitmap = Bitmap.createBitmap(bm, 0, 0, width, height, matrix, false);

        return resizedBitmap;
    }


}
