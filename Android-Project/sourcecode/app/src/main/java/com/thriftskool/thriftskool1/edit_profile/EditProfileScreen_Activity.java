package com.thriftskool.thriftskool1.edit_profile;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.drawable.BitmapDrawable;
import android.media.ExifInterface;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Base64;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.CropingOption;
import com.thriftskool.thriftskool1.CropingOptionAdapter;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.ClassList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.EditProfile_AsyncTask;
import com.thriftskool.thriftskool1.been.ClassList_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.university.UnivarsityScreen_Activity;
import com.thriftskool.thriftskool1.view_profile.ViewProfileScreen_Activity;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

public class EditProfileScreen_Activity extends Activity implements View.OnClickListener{

    private TextView tv_university, tv_emailAddtess, tv_userName,tv_title,tv_save,tv_submit,tv_countNotification,tv_name,spiner_name;
    private EditText et_userName, et_emailAddress,et_name;
    private LinearLayout ll_university, ll_usernameMainLayout, ll_userNameLayout, ll_emailAddressMainLayout, ll_emailAddressLayout, ll_perentLayout,ll_EditProfileScreen_NameLayout;
    private HashMap<String,String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private InputMethodManager imm ;
    public static String str_universityId="0",str_domain="",str_universityName="", str_universityImage="";
    private boolean emailflage=false;
    Spinner spinner;
    String class_name,claas_id;
    ImageView iv_ownerImg;
    private List<String> imageList = new ArrayList<String>();
    public static List<String> sortcalss_name;
    String picturePath;

    // corp
    private Uri mImageCaptureUri;
    private File outPutFile = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_profile_screen_);

        imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);

        outPutFile = new File(android.os.Environment.getExternalStorageDirectory(), "temp.jpg");

        hashMap = SessionStore.getUserDetails(EditProfileScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(EditProfileScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();

    }


    //*********** MAping ***************************************************************************************************************************************************************************


    private void maping()
    {

        //TextView
        tv_university = (TextView)findViewById(R.id.EditProfileScreen_University);
        tv_emailAddtess = (TextView)findViewById(R.id.EditProfileScreen_EmailAddresstext);
        tv_userName= (TextView)findViewById(R.id.EditProfileScreen_UserNameText);
        tv_submit = (TextView)findViewById(R.id.EditProfileScreen_Submit);
        tv_title= (TextView)findViewById(R.id.Header_Title);
        tv_save= (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);
        tv_name=(TextView)findViewById(R.id.EditProfileScreen_Nametext);
        spiner_name=(TextView)findViewById(R.id.spiner_name);

        //EditText
        et_emailAddress = (EditText)findViewById(R.id.EditProfileScreen_EmailAddress);
        et_userName = (EditText)findViewById(R.id.EditProfileScreen_UserName);
        et_name = (EditText)findViewById(R.id.EditProfileScreen_Name);

        //LinearLayout
        ll_university = (LinearLayout)findViewById(R.id.EditProfileScreen_UniversityLayout);
        ll_emailAddressMainLayout= (LinearLayout)findViewById(R.id.EditProfileScreen_EmailAddressMainLayout);
        ll_emailAddressLayout= (LinearLayout)findViewById(R.id.EditProfileScreen_EmailAddressLayout);
        ll_usernameMainLayout= (LinearLayout)findViewById(R.id.EditProfileScreen_UserNameMainLayout);
        ll_userNameLayout= (LinearLayout)findViewById(R.id.EditProfileScreen_UserNameLayout);
        ll_perentLayout = (LinearLayout)findViewById(R.id.EditProfileScreen_PerentLayout);
        ll_EditProfileScreen_NameLayout=(LinearLayout)findViewById(R.id.EditProfileScreen_NameLayout);

        //spinner
        spinner=(Spinner)findViewById(R.id.EditprofileScreen_spiner);

        //imageview
        iv_ownerImg=(ImageView)findViewById(R.id.OwnderProfile_image);

        setValue();


    }

    //************************* Set VAlue **************************************************************************************************************************************************

    private void setValue()
    {

        Log.e("Profile img...", " " + hashMap.get(SessionStore.PROFILEIMG_PATH) + hashMap.get(SessionStore.PROFILE_IMG));

        if (hashMap.get(SessionStore.PROFILE_IMG).equalsIgnoreCase("") ||  hashMap.get(SessionStore.PROFILE_IMG).equalsIgnoreCase("null") ||  hashMap.get(SessionStore.PROFILE_IMG).equalsIgnoreCase(" "))
        {
            Picasso.with(EditProfileScreen_Activity.this).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).placeholder(R.drawable.lodingicon).into(iv_ownerImg);
        }
        else
        {
            Picasso.with(EditProfileScreen_Activity.this).load(hashMap.get(SessionStore.PROFILEIMG_PATH) + hashMap.get(SessionStore.PROFILE_IMG)).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).placeholder(R.drawable.lodingicon).into(iv_ownerImg);
        }

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)
        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }


        if (hashMap.get(SessionStore.USER_ID)!=null)
        {
            String domain[] = hashMap.get(SessionStore.USER_EMAIL).split("@");
            et_emailAddress.setText(domain[0]);
            et_emailAddress.setSelection(domain[0].length());
            str_domain ="@"+domain[1];


            str_universityId= hashMap.get(SessionStore.UNIVERSITY_ID);
            str_universityName = hashMap.get(SessionStore.UNIVERSITY_NAME);
            str_universityImage = hashMap.get(SessionStore.UNIVERSITY_IMAGE);


            Log.e("helooo","dfdsfsdf Pnkaj: "+str_universityId);

        }


        for(int i=0;i<LoginSignupScreen_Activity.class_List.size();i++)
        {
            if (LoginSignupScreen_Activity.class_List.get(i).getInt_glcode().equals(hashMap.get(SessionStore.CLASS_ID)))
            {
                spiner_name.setVisibility(View.VISIBLE);
                spiner_name.setText(LoginSignupScreen_Activity.class_List.get(i).getClass_name());

                Log.e("class name...","  "+LoginSignupScreen_Activity.class_List.get(i).getClass_name());

               // sortcalss_name.add(LoginSignupScreen_Activity.classList_2.get(i));
            }
        }
        tv_title.setText("Edit Profile");

        tv_emailAddtess.setText(hashMap.get(SessionStore.USER_EMAIL));
        tv_university.setText(hashMap.get(SessionStore.UNIVERSITY_NAME));
        tv_userName.setText(hashMap.get(SessionStore.USER_NAME));
        et_userName.setText(hashMap.get(SessionStore.USER_NAME));
        tv_name.setText(hashMap.get(SessionStore.PERSON_NAME));
        et_name.setText(hashMap.get(SessionStore.PERSON_NAME));

        tv_emailAddtess.setVisibility(View.VISIBLE);
        tv_university.setVisibility(View.VISIBLE);
        tv_userName.setVisibility(View.VISIBLE);
        tv_name.setVisibility(View.VISIBLE);


        spiner_name.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                spiner_name.setVisibility(View.GONE);
                spinner.setVisibility(View.VISIBLE);
            }
        });
        et_emailAddress.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {


                tv_emailAddtess.setText(s + str_domain);

                if (et_emailAddress.getText().toString().equalsIgnoreCase("")) {

                    tv_emailAddtess.setVisibility(View.GONE);

                } else {
                    tv_emailAddtess.setVisibility(View.VISIBLE);


                }


            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        et_userName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

                tv_userName.setText(s);

                if (et_userName.getText().toString().equalsIgnoreCase("")) {

                    tv_userName.setVisibility(View.GONE);

                } else {
                    tv_userName.setVisibility(View.VISIBLE);

                }


            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        et_name.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {


                tv_name.setText(s);

                if (et_name.getText().toString().equalsIgnoreCase("")) {

                    tv_name.setVisibility(View.GONE);

                } else {
                    tv_name.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });


        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                class_name = LoginSignupScreen_Activity.class_List.get(position).getClass_name();
                claas_id = LoginSignupScreen_Activity.class_List.get(position).getInt_glcode();

                Log.e("class id...selected","   "+claas_id);

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
        sortcalss_name=new ArrayList<>();

      /*  if (hashMap.get(SessionStore.CLASS_ID).equals("0"))
        {*/
           /* for(int i=LoginSignupScreen_Activity.classList_2.size()-1; i>=0; i--)
            {
                sortcalss_name.add(LoginSignupScreen_Activity.classList_2.get(i));
            }*/
       //}
      /*  else
        {
            for(int i=0;i<LoginSignupScreen_Activity.classList_2.size()-1;i++)
            {
               if (LoginSignupScreen_Activity.class_List.get(i).equals(hashMap.get(SessionStore.CLASS_ID)))
               {
                   sortcalss_name.add(LoginSignupScreen_Activity.classList_2.get(i));
               }
            }
        }*/

       /* try {
         *//*   for (int k=0;k<LoginSignupScreen_Activity.classList_2.size();k++)
            {
                if (class_name.equals(LoginSignupScreen_Activity.classList_2.get(k).get))
            }*//*

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(EditProfileScreen_Activity.this, android.R.layout.simple_list_item_1, android.R.id.text1, sortcalss_name);
            spinner.setAdapter(adapter);


        } catch (Exception e) {
            // e.printStackTrace();
            Log.e("sort array..."," "+e.getMessage());
        }
*/


        // Initializing an ArrayAdapter
        final ArrayAdapter<String> spinnerArrayAdapter = new ArrayAdapter<String>(
                this,R.layout.spinner_item,LoginSignupScreen_Activity.classList_2){
            @Override
            public boolean isEnabled(int position){
                if(position == 0)
                {
                    // Disable the first item from Spinner
                    // First item will be use for hint
                    return false;
                }
                else
                {
                    return true;
                }
            }
            @Override
            public View getDropDownView(int position, View convertView,
                                        ViewGroup parent) {
                View view = super.getDropDownView(position, convertView, parent);
                TextView tv = (TextView) view;
                if(position == 0){
                    // Set the hint text color gray
                    tv.setTextColor(Color.GRAY);
                }
                else {
                    tv.setTextColor(Color.BLACK);
                }
                return view;
            }
        };
        spinnerArrayAdapter.setDropDownViewResource(R.layout.spinner_item);
        spinner.setAdapter(spinnerArrayAdapter);

       /* spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String selectedItemText = (String) parent.getItemAtPosition(position);
                // If user change the default selection
                // First item is disable and it is used for hint
                if(position > 0){
                    // Notify the selected item text
                    Toast.makeText
                            (getApplicationContext(), "Selected : " + selectedItemText, Toast.LENGTH_SHORT)
                            .show();
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });*/


        ll_university.setOnClickListener(EditProfileScreen_Activity.this);
        ll_emailAddressMainLayout.setOnClickListener(EditProfileScreen_Activity.this);
        ll_usernameMainLayout.setOnClickListener(EditProfileScreen_Activity.this);
        ll_perentLayout.setOnClickListener(EditProfileScreen_Activity.this);
        ll_EditProfileScreen_NameLayout.setOnClickListener(EditProfileScreen_Activity.this);
        tv_submit.setOnClickListener(EditProfileScreen_Activity.this);
        tv_save.setOnClickListener(EditProfileScreen_Activity.this);
        iv_ownerImg.setOnClickListener(EditProfileScreen_Activity.this);

    }

    //*********** OnClickListener ************************************************************************************************************************************************************

    @Override
    public void onClick(View v) {

        switch (v.getId())
        {

            case R.id.EditProfileScreen_PerentLayout:

                ll_userNameLayout.setVisibility(View.VISIBLE);
                et_userName.setVisibility(View.GONE);
                ll_emailAddressLayout.setVisibility(View.VISIBLE);
                et_emailAddress.setVisibility(View.GONE);

                ll_EditProfileScreen_NameLayout.setVisibility(View.VISIBLE);
                et_name.setVisibility(View.GONE);

                spiner_name.setVisibility(View.VISIBLE);
                spinner.setVisibility(View.GONE);

//                Toast.makeText(EditProfileScreen_Activity.this,"sdfdsfdsf ",Toast.LENGTH_SHORT).show();

                break;

            case R.id.EditProfileScreen_NameLayout:

                ll_emailAddressLayout.setVisibility(View.VISIBLE);
                et_emailAddress.setVisibility(View.GONE);

                ll_userNameLayout.setVisibility(View.VISIBLE);
                et_userName.setVisibility(View.GONE);

                ll_EditProfileScreen_NameLayout.setVisibility(View.GONE);
                et_name.setVisibility(View.VISIBLE);

                et_name.setFocusable(true);
                et_name.setFocusableInTouchMode(true);
                et_name.setCursorVisible(true);
                et_name.setText(tv_name.getText().toString().trim());
                et_name.setSelection(tv_name.getText().toString().trim().length());
                et_name.requestFocus();

                spiner_name.setVisibility(View.VISIBLE);
                spinner.setVisibility(View.GONE);

                imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
                imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
                break;


            case R.id.EditProfileScreen_Submit:

                if (CheckInterNetConnection.isNetworkAvailable(EditProfileScreen_Activity.this))
                {
                submitDate();
                }
                else
                {

                    new AlertDialog.Builder(EditProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            }).show();


                }
                break;



            case R.id.EditProfileScreen_UniversityLayout:


                if (CheckInterNetConnection.isNetworkAvailable(EditProfileScreen_Activity.this))
                {

                    new AlertDialog.Builder(EditProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.university_alert_editprofilescreen))
                            .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                    Intent intent = new Intent(EditProfileScreen_Activity.this, EditProfileUniversityScreen_Activity.class);
                                    startActivityForResult(intent,2020);
                                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                                }
                            }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                        }
                    }).show();




                }
                else
                {

                    new AlertDialog.Builder(EditProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {



                                }
                            }).show();

                }

                ll_userNameLayout.setVisibility(View.VISIBLE);
                et_userName.setVisibility(View.GONE);

                ll_emailAddressLayout.setVisibility(View.VISIBLE);
                et_emailAddress.setVisibility(View.GONE);

                ll_EditProfileScreen_NameLayout.setVisibility(View.VISIBLE);
                et_name.setVisibility(View.GONE);

                spiner_name.setVisibility(View.VISIBLE);
                spinner.setVisibility(View.GONE);

                break;

            case R.id.EditProfileScreen_EmailAddressMainLayout:

                ll_emailAddressLayout.setVisibility(View.GONE);
                et_emailAddress.setVisibility(View.VISIBLE);

                ll_userNameLayout.setVisibility(View.VISIBLE);
                et_userName.setVisibility(View.GONE);

                ll_EditProfileScreen_NameLayout.setVisibility(View.VISIBLE);
                et_name.setVisibility(View.GONE);

                et_emailAddress.setFocusable(true);
                et_emailAddress.setFocusableInTouchMode(true);
                et_emailAddress.setCursorVisible(true);
                et_emailAddress.requestFocus();

                spiner_name.setVisibility(View.VISIBLE);
                spinner.setVisibility(View.GONE);

                imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
                imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);


                break;


            case R.id.EditProfileScreen_UserNameMainLayout:


                ll_emailAddressLayout.setVisibility(View.VISIBLE);
                et_emailAddress.setVisibility(View.GONE);

                ll_EditProfileScreen_NameLayout.setVisibility(View.VISIBLE);
                et_name.setVisibility(View.GONE);

                ll_userNameLayout.setVisibility(View.GONE);
                et_userName.setVisibility(View.VISIBLE);

                spiner_name.setVisibility(View.VISIBLE);
                spinner.setVisibility(View.GONE);

                et_userName.setFocusable(true);
                et_userName.setFocusableInTouchMode(true);
                et_userName.setCursorVisible(true);
                et_userName.setText(tv_userName.getText().toString().trim());
                et_userName.setSelection(tv_userName.getText().toString().trim().length());
                et_userName.requestFocus();

                imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
                imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);


                break;



            case R.id.Header_Save:

                Intent intent = new Intent(EditProfileScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;

            case  R.id.OwnderProfile_image:
                Image_Picker_Dialog();
                break;

        }//end of switch


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

                Intent i = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(i, 200);
             /*   Intent i = new Intent(
                        Intent.ACTION_PICK,
                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

                startActivityForResult(i, 100);*/

            }
        });

        myAlertDialog.setNegativeButton("Camera", new DialogInterface.OnClickListener()
        {
            public void onClick(DialogInterface arg0, int arg1)
            {

                Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                mImageCaptureUri = Uri.fromFile(new File(Environment
                        .getExternalStorageDirectory(), "tmp_avatar_" + String.valueOf(System.currentTimeMillis())
                        + ".jpg"));
                intent.putExtra(android.provider.MediaStore.EXTRA_OUTPUT,
                        mImageCaptureUri);
                startActivityForResult(intent, 100);

              /*  Intent cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                startActivityForResult(cameraIntent, 200);
*/
                // getParent().startActivityForResult(cameraIntent, Settings.Global.CAMERA_PIC_REQUEST);
            }
        });
        myAlertDialog.show();

    }

    public void sameImg_Encode()
    {
        Bitmap bitmap = ((BitmapDrawable)iv_ownerImg.getDrawable()).getBitmap();

        Log.e("bitmap..", " " + bitmap);


        // bitmap = getResizedBitmap(bitmap,400,400);
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        byte[] byteArray = stream.toByteArray();

        Comman.EncodeImg = Base64.encodeToString(byteArray, Base64.DEFAULT);

        Log.e("Encode ..", " " + Comman.EncodeImg);

    }



    //******** Submit Date *****************************************************************************************************************************************************************
    private void submitDate()
    {

        if (!str_universityId.trim().equalsIgnoreCase("")){

            if (!et_emailAddress.getText().toString().trim().equalsIgnoreCase("")){

                if (!et_userName.getText().toString().trim().equalsIgnoreCase(""))
                {
                   /* if (!et_name.getText().toString().trim().equalsIgnoreCase("")) {*/
                        sameImg_Encode();

                        EditProfile_AsyncTask profile = new EditProfile_AsyncTask(EditProfileScreen_Activity.this);
                        profile.execute(hashMap.get(SessionStore.USER_ID), str_universityId, et_emailAddress.getText().toString().trim() + "" + str_domain, et_userName.getText().toString().trim(),  claas_id, et_name.getText().toString().trim(), Comman.EncodeImg,str_universityName, str_universityImage);
                  /*  }else{

                        Toast toast=Toast.makeText(EditProfileScreen_Activity.this, getString(R.string.blank_editprofileName_alert), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }*/

                }else{

                    Toast toast=Toast.makeText(EditProfileScreen_Activity.this, getString(R.string.blank_universitycontactusername_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }

            }else{


                Toast toast=Toast.makeText(EditProfileScreen_Activity.this, getString(R.string.blank_universitycontactemail_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }

        }else{

            Toast toast=Toast.makeText(EditProfileScreen_Activity.this, getString(R.string.blank_selectuniversity_alert), Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER,0,0);
            toast.show();
        }
    }



    //****** ********************************************************************************************************************************************************************************

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);


        if (requestCode == 2020)
        {
            if (resultCode == RESULT_OK)
            {
                str_universityId = data.getStringExtra("ID");
                //tv_emailtext.setText("@"+data.getStringExtra("DemainName"));
                tv_university.setText(data.getStringExtra("Name"));



                String email[] = tv_emailAddtess.getText().toString().trim().split("@");
                str_domain = "@"+data.getStringExtra("DemainName");

//                et_emailAddress.setText(email[0]);
               // tv_emailAddtess.setText(email[0]+"@"+data.getStringExtra("DemainName"));

                et_emailAddress.setText("");
                tv_emailAddtess.setText("");

                str_universityName = data.getStringExtra("Name");
                str_universityImage = data.getStringExtra("Image");

            }
            if (resultCode == RESULT_CANCELED) {
                //Write your code if there's no result

            }
        }

     /*   if (requestCode == 100 && resultCode == RESULT_OK && data!= null)
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
            iv_ownerImg.setImageBitmap(bmp);

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
            iv_ownerImg.setImageBitmap(bmp);


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
        } else if (requestCode == 301) {

            try {
                if(outPutFile.exists())
                {
                    Bitmap photo = decodeFile(outPutFile);
                    iv_ownerImg.setImageBitmap(photo);
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

            if (size == 1) {
                Intent i   = new Intent(intent);
                ResolveInfo res = (ResolveInfo) list.get(0);

                i.setComponent( new ComponentName(res.activityInfo.packageName, res.activityInfo.name));

                startActivityForResult(i, 301);
            } else {
                for (ResolveInfo res : list) {
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
                builder.setAdapter( adapter, new DialogInterface.OnClickListener() {
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


        hashMap = SessionStore.getUserDetails(EditProfileScreen_Activity.this, Comman.PRIFRENS_NAME);
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


    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(EditProfileScreen_Activity.this);
    }


}
