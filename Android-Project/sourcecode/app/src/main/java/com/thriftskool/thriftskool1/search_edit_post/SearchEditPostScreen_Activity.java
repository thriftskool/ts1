package com.thriftskool.thriftskool1.search_edit_post;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.UpdatePost_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.Utility;
import com.thriftskool.thriftskool1.been.EditPostGallary_Been;
import com.thriftskool.thriftskool1.category.CategoryScreen_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

public class SearchEditPostScreen_Activity extends Activity implements View.OnClickListener {

    private SquareImageView iv_photo1, iv_photo2, iv_photo3, iv_photo4;
    private TextView tv_chooseCategoty, tv_expiryDate, tv_mainTitle, tv_back, tv_save, tv_submit,tv_countNotification;
    private EditText et_title, et_description, et_price;
    private LinearLayout ll_ChoseCategory, ll_expriyDate;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    public static int int_photopos;
    private String str_categoryId = "", str_categoryName = "";
    private List<EditPostGallary_Been> imageList = new ArrayList<EditPostGallary_Been>();
    private Calendar calender;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_post_screen_);
        calender = Calendar.getInstance();

        hashMap = SessionStore.getUserDetails(SearchEditPostScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(SearchEditPostScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();
    }


    //************** Maping **************************************************************************************************************************

    private void maping() {

        //TextView
        tv_back = (TextView) findViewById(R.id.Header_Back);
        tv_mainTitle = (TextView) findViewById(R.id.Header_Title);
        tv_save = (TextView) findViewById(R.id.Header_Save);
        tv_chooseCategoty = (TextView) findViewById(R.id.EditPostScreen_chooseCategorytext);
        tv_expiryDate = (TextView) findViewById(R.id.EditPostScreen_ExpiryDate);
        tv_submit = (TextView) findViewById(R.id.EditPostScreen_submit);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //EditText
        et_description = (EditText) findViewById(R.id.EditPostScreen_description);
        et_title = (EditText) findViewById(R.id.EditPostScreen_title);
        et_price = (EditText) findViewById(R.id.EditPostScreen_Price);

        //ImageView
        iv_photo1 = (SquareImageView) findViewById(R.id.EditPostScreen_photo1);
        iv_photo2 = (SquareImageView) findViewById(R.id.EditPostScreen_photo2);
        iv_photo3 = (SquareImageView) findViewById(R.id.EditPostScreen_photo3);
        iv_photo4 = (SquareImageView) findViewById(R.id.EditPostScreen_photo4);

        //LinearLayout
        ll_ChoseCategory = (LinearLayout) findViewById(R.id.EditPostScreen_chooseCategory);
        ll_expriyDate = (LinearLayout) findViewById(R.id.EditPostScreen_ExpiryDateLayout);


        iv_photo1.setOnClickListener(SearchEditPostScreen_Activity.this);
        iv_photo2.setOnClickListener(SearchEditPostScreen_Activity.this);
        iv_photo3.setOnClickListener(SearchEditPostScreen_Activity.this);
        iv_photo4.setOnClickListener(SearchEditPostScreen_Activity.this);
        ll_ChoseCategory.setOnClickListener(SearchEditPostScreen_Activity.this);
        ll_expriyDate.setOnClickListener(SearchEditPostScreen_Activity.this);
        tv_submit.setOnClickListener(SearchEditPostScreen_Activity.this);
        tv_save.setOnClickListener(SearchEditPostScreen_Activity.this);


        setValue();


    }


    //************** Set VAlue **************************************************************************************************************************************

    private void setValue() {
        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }


        tv_mainTitle.setText("Edit Post");

        EditPost_AsyncTask editpost = new EditPost_AsyncTask(SearchEditPostScreen_Activity.this);
        editpost.execute(SearchEditPost_Tab_Activity.str_userId, SearchEditPost_Tab_Activity.str_postId);




    }


    //******************** OnClickListener ******************************************************************************************************************************


    @Override
    public void onClick(View v) {

        switch (v.getId()) {

            case R.id.EditPostScreen_chooseCategory:

                Intent intent = new Intent(SearchEditPostScreen_Activity.this, CategoryScreen_Activity.class);
                startActivityForResult(intent, 2020);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                break;

            case R.id.EditPostScreen_ExpiryDateLayout:
                showDialog(0);

                break;


            case R.id.EditPostScreen_photo1:
                int_photopos = 1;

                Image_Picker_Dialog();


                break;


            case R.id.EditPostScreen_photo2:

                int_photopos = 2;

                Image_Picker_Dialog();

                break;


            case R.id.EditPostScreen_photo3:
                int_photopos = 3;

                Image_Picker_Dialog();


                break;


            case R.id.EditPostScreen_photo4:
                int_photopos = 4;

                Image_Picker_Dialog();


                break;


            case R.id.EditPostScreen_submit:

                        if (CheckInterNetConnection.isNetworkAvailable(SearchEditPostScreen_Activity.this))
                        {

                        post();


                        }
                        else
                        {

                        new AlertDialog.Builder(SearchEditPostScreen_Activity.this)
                        .setTitle("Alert!")
                        .setMessage(getString(R.string.internetconnection_alert))
                        .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {



                        }
                        }).show();


                        }
                break;


            case R.id.Header_Save:

                 intent = new Intent(SearchEditPostScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;



        }


    }



    //*********** Post  ******************************************************************************************************************

    private void post() {

        if (!str_categoryId.trim().equalsIgnoreCase("")) {

            if (imageList.size() > 0) {

                if (!et_title.getText().toString().trim().equalsIgnoreCase("")) {

                    if (!et_description.getText().toString().trim().equalsIgnoreCase("")) {

                        if (!et_price.getText().toString().trim().equalsIgnoreCase("")) {

                            // if (chb_privacyPolicy.isChecked())
                            {
                                try {
                                    JSONObject json = new JSONObject();

                                    json.put("post_id", Integer.parseInt(SearchEditPost_Tab_Activity.str_postId));
                                    json.put("user_id", Integer.parseInt(hashMap.get(SessionStore.USER_ID)));
                                    json.put("post_title", et_title.getText().toString().trim());
                                    json.put("university_id", Integer.parseInt(hashMap.get(SessionStore.UNIVERSITY_ID)));
                                    json.put("post_cat_id", Integer.parseInt(str_categoryId));
                                    json.put("description", et_description.getText().toString().trim());
                                    json.put("price", et_price.getText().toString().trim());
                                    json.put("dt_modifydate", DateCoversion.getUTCDateTime());
                                    json.put("expirydate", tv_expiryDate.getText().toString().trim()+" "+DateCoversion.getUTCTime());


                                    Log.e("Exception ", "JJJJJJJJJ: " + json.toString());


                                    JSONArray jarray = new JSONArray();

                                    for (int i = 0; i < imageList.size(); i++) {

                                        JSONObject jj = new JSONObject();

                                        jj.put("image_id", imageList.get(i).getImageId());
                                        jj.put("title", SearchEditPost_Tab_Activity.str_postId+"_"+(i + 1));
                                        jj.put("image", imageList.get(i).getImage());


                                        jarray.put(jj);

                                    }

                                    json.put("images", jarray);

                                    UpdatePost_AsyncTask post = new UpdatePost_AsyncTask(SearchEditPostScreen_Activity.this);
                                    post.execute(json.toString());

                                } catch (Exception e) {
                                    Log.e("Exception ", "Post Exception: " + e.getMessage());
                                }

                            }
                            /*else
                            {
                                Toast.makeText(PostScreen_Activity.this,getString(R.string.agreetc_alert_postscreen),Toast.LENGTH_SHORT).show();
                            }*/
                        } else {


                            Toast toast=  Toast.makeText(SearchEditPostScreen_Activity.this, getString(R.string.price_alert_postscreen), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER,0,0);
                            toast.show();
                        }
                    } else {


                        Toast toast= Toast.makeText(SearchEditPostScreen_Activity.this, getString(R.string.description_alert_postscreen), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }
                } else {


                    Toast toast= Toast.makeText(SearchEditPostScreen_Activity.this, getString(R.string.blank_title_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }
            } else {


                Toast toast=  Toast.makeText(SearchEditPostScreen_Activity.this, getString(R.string.photo_alert_postscreen), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
            }
        } else {


            Toast toast= Toast.makeText(SearchEditPostScreen_Activity.this, getString(R.string.blank_choosecategory_alert), Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER,0,0);
            toast.show();
        }


    }


    // ********************* Date Picker **************************************************************************************************

    @Override
    protected Dialog onCreateDialog(int id) {

        if (id == 0 || id == 1) {

            DatePickerDialog _date = new DatePickerDialog(this, datePickerListener, calender.get(Calendar.YEAR),calender.get(Calendar.MONTH),calender.get(Calendar.DATE));


           /* DatePickerDialog _date = new DatePickerDialog(this, datePickerListener, calender.get(Calendar.YEAR), calender.get(Calendar.MONTH), calender.get(Calendar.DATE)) {
                @Override
                public void onDateChanged(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                }
            };*/


            Calendar c = Calendar.getInstance();
            c.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH),(calender.get(Calendar.DATE)+30));

            _date.getDatePicker().setMaxDate(c.getTimeInMillis());

             _date.getDatePicker().setMinDate(System.currentTimeMillis() - 1000);


            return _date;


        } else if (id == 2 || id == 3) {
            //return new TimePickerDialog(this, timePickerListener,  calender.get(Calendar.HOUR_OF_DAY), calender.get(Calendar.MINUTE),false);
        }


        return null;

    }

    private DatePickerDialog.OnDateSetListener datePickerListener = new DatePickerDialog.OnDateSetListener() {

        // when dialog box is closed, below method will be called.
        public void onDateSet(DatePicker view, int selectedYear, int selectedMonth, int selectedDay) {
            //st_date = DateCoversion.getSelectedCalenderDate(selectedDay + "/" + (selectedMonth + 1) + "/" + selectedYear);

            tv_expiryDate.setText(DateCoversion.getDateMMM(selectedDay + "/" + (selectedMonth + 1) + "/" + selectedYear));


        }
    };


    /// ***************** Take Photo ******************************************************************************


    public void Image_Picker_Dialog() {

        AlertDialog.Builder myAlertDialog = new AlertDialog.Builder(this);
        myAlertDialog.setTitle("Pictures Option");
        myAlertDialog.setMessage("Select Picture Mode");

        myAlertDialog.setPositiveButton("Gallery", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface arg0, int arg1) {

                Intent i = new Intent(
                        Intent.ACTION_PICK,
                        MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

                startActivityForResult(i, 100);

            }
        });

        myAlertDialog.setNegativeButton("Camera", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface arg0, int arg1) {
                Intent cameraIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
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
        if (requestCode == 100 && resultCode == RESULT_OK && data != null) {


            Uri selectedImage = data.getData();
            String[] filePathColumn = {MediaStore.Images.Media.DATA};

            Cursor cursor = getContentResolver().query(selectedImage,
                    filePathColumn, null, null, null);
            cursor.moveToFirst();

            int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
            String picturePath = cursor.getString(columnIndex);
            cursor.close();

            Bitmap bmp = BitmapFactory.decodeFile(picturePath);

            Bitmap resized = Bitmap.createScaledBitmap(bmp, iv_photo1.getWidth(), iv_photo1.getWidth(), true);

            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            resized =  getResizedBitmap(resized,100,100);
            resized.compress(Bitmap.CompressFormat.PNG, 70, stream);
            byte[] byteArray = stream.toByteArray();

            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            if (int_photopos == 1) {

                iv_photo1.setImageBitmap(bmp);
                iv_photo2.setEnabled(true);

                if (imageList.size() >= 1) {
                    imageList.set(0, new EditPostGallary_Been(imageList.get(0).getImageId(), encoded));

                } else {

                    imageList.add(new EditPostGallary_Been("0", encoded));
                }

            }
            if (int_photopos == 2) {

                iv_photo2.setImageBitmap(bmp);
                iv_photo3.setEnabled(true);

                if (imageList.size() >= 2) {
                    imageList.set(1, new EditPostGallary_Been(imageList.get(1).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }

            }
            if (int_photopos == 3) {

                iv_photo3.setImageBitmap(bmp);
                iv_photo4.setEnabled(true);

                if (imageList.size() >= 3) {
                    imageList.set(2, new EditPostGallary_Been(imageList.get(2).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }
            }
            if (int_photopos == 4) {

                iv_photo4.setImageBitmap(bmp);

                if (imageList.size() >= 4) {
                    imageList.set(3, new EditPostGallary_Been(imageList.get(3).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }
            }


        } else if (requestCode == 200 && resultCode == RESULT_OK) {

            Bitmap bmp = (Bitmap) data.getExtras().get("data");
            Uri selectedImage = data.getData();

            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            bmp =  getResizedBitmap(bmp,100,100);
            bmp.compress(Bitmap.CompressFormat.PNG, 70, stream);
            byte[] byteArray = stream.toByteArray();
            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            if (int_photopos == 1) {

                iv_photo1.setImageBitmap(bmp);
                iv_photo2.setEnabled(true);

                if (imageList.size() >= 1) {
                    imageList.set(0, new EditPostGallary_Been(imageList.get(0).getImageId(), encoded));

                } else {

                    imageList.add(new EditPostGallary_Been("0", encoded));
                }

            }
            if (int_photopos == 2) {

                iv_photo2.setImageBitmap(bmp);
                iv_photo3.setEnabled(true);

                if (imageList.size() >= 2) {
                    imageList.set(1, new EditPostGallary_Been(imageList.get(1).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }

            }
            if (int_photopos == 3) {

                iv_photo3.setImageBitmap(bmp);
                iv_photo4.setEnabled(true);

                if (imageList.size() >= 3) {
                    imageList.set(2, new EditPostGallary_Been(imageList.get(2).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }
            }
            if (int_photopos == 4) {

                iv_photo4.setImageBitmap(bmp);

                if (imageList.size() >= 4) {
                    imageList.set(3, new EditPostGallary_Been(imageList.get(3).getImageId(), encoded));
                } else {
                    imageList.add(new EditPostGallary_Been("0", encoded));
                }
            }


        }

        // Geting Result fro choose Category


        if (requestCode == 2020) {
            if (resultCode == RESULT_OK) {

                str_categoryId = data.getStringExtra("ID");
                str_categoryName = data.getStringExtra("DemainName");
                tv_chooseCategoty.setText(str_categoryName.trim());


            }
            if (resultCode == RESULT_CANCELED) {

            }
        }




    }

    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

    }

    //******************************* Web Sevice ************************************************************************************************************************************************


    public class EditPost_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

        ProgressDialog progressDialog;
        Context context;


        public EditPost_AsyncTask(Context contex) {
            // TODO Auto-generated constructor stub

            this.context = contex;

            progressDialog = new ProgressDialog(contex);
            progressDialog.setMessage("Please wait...");
            progressDialog.setCancelable(false);


        }


        @Override
        protected JSONObject doInBackground(String... params) {
            // TODO Auto-generated method stub


            JSONObject jsonresponse = null;

            try {


                JSONObject json = new JSONObject();
                json.put("user_id", Integer.parseInt(params[0]));
                json.put("post_id", Integer.parseInt(params[1]));


                String response = Utility.postRequest(Comman.URL + "get_postupdate", json.toString(),context);
                JSONObject jObject = new JSONObject(response);
                jsonresponse = jObject.getJSONObject("Response");


            } catch (Exception e) {

                e.getStackTrace();
            }


            return jsonresponse;
        }

        @Override
        protected void onPreExecute() {
            // TODO Auto-generated method stub
            super.onPreExecute();

            if (progressDialog != null && !progressDialog.isShowing()) {
                progressDialog.show();
            }

        }

        @Override
        protected void onPostExecute(JSONObject result) {
            // TODO Auto-generated method stub
            super.onPostExecute(result);
            progressDialog.dismiss();

            try {


                if (result.getString("status").trim().equalsIgnoreCase("200")) {

                    imageList.clear();
                    JSONArray detailArray = result.getJSONArray("Details");

                    for (int i = 0; i < detailArray.length(); i++) {

                        JSONObject detailItem = detailArray.getJSONObject(i);

                        et_title.setText(detailItem.getString("post_name"));
                        et_price.setText(detailItem.getString("price"));
                        et_description.setText(detailItem.getString("description"));

                        tv_chooseCategoty.setText(detailItem.getString("category_name"));
                        tv_expiryDate.setText(detailItem.getString("expiry_date"));
                        str_categoryId =detailItem.getString("post_cate_id");




                    }

                    detailArray = result.getJSONArray("Gallery");
                    for (int i = 0; i < detailArray.length(); i++) {

                        JSONObject detailItem = detailArray.getJSONObject(i);
                        new DownloadImage().execute(detailItem.getString("photo_id"), result.getString("imagepath") + "" + detailItem.getString("post_image"));
                    }


                } else {

                    Toast toast=  Toast.makeText(context, result.getString("message"), Toast.LENGTH_LONG);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();

                }


            } catch (Exception e) {

                e.getStackTrace();
                Log.e("Exception", " Category List Exception: " + e.getMessage());
            }


        }
    }
//********** Download Image ***********************************************************************************************************************************************************************

    private class DownloadImage extends AsyncTask<String, Void, Bitmap> {

        String id ;
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // Create a progressdialog

        }

        @Override
        protected Bitmap doInBackground(String... URL) {
            Log.e("Post ID","IDIDIDIDIID: "+URL[1] );


            id = URL[0];
            String imageURL = URL[1];

            Bitmap bitmap = null;
            try {
                // Download Image from URL
                /*InputStream input = new java.net.URL(imageURL).openStream();
                // Decode Bitmap
                bitmap = BitmapFactory.decodeStream(input);
                input.close();*/

                java.net.URL url = new java.net.URL(imageURL);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setDoInput(true);
                connection.connect();
                InputStream input = connection.getInputStream();
                bitmap = BitmapFactory.decodeStream(input);


            } catch (Exception e) {
                e.printStackTrace();
            }
            return bitmap;
        }

        @Override
        protected void onPostExecute(Bitmap result) {
            // Set the bitmap into ImageView

            ByteArrayOutputStream stream = new ByteArrayOutputStream();

            result =  getResizedBitmap(result,100,100);
            result.compress(Bitmap.CompressFormat.PNG, 70, stream);
            byte[] byteArray = stream.toByteArray();
            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            imageList.add(new EditPostGallary_Been(id, encoded));

           byte[] decodedString = Base64.decode(encoded, Base64.DEFAULT);
            Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

            if (imageList.size() == 1) {

                iv_photo1.setImageBitmap(decodedByte);

               // Picasso.with(context).load(result.getString("imagepath") + "" + detailItem.getString("post_image")).into(iv_photo1);

            } else if (imageList.size() == 2) {

                iv_photo2.setImageBitmap(decodedByte);
                //Picasso.with(context).load(result.getString("imagepath") + "" + detailItem.getString("post_image")).into(iv_photo2);

            } else if (imageList.size() == 3) {

                iv_photo3.setImageBitmap(decodedByte);
                //Picasso.with(context).load(result.getString("imagepath") + "" + detailItem.getString("post_image")).into(iv_photo3);

            } else if (imageList.size() == 4) {

                iv_photo4.setImageBitmap(decodedByte);
                //Picasso.with(context).load(result.getString("imagepath") + "" + detailItem.getString("post_image")).into(iv_photo4);

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

    //************ On Resume **********************************************************************************************************************************************************************


    @Override
    protected void onResume() {
        super.onResume();


        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        hashMap = SessionStore.getUserDetails(SearchEditPostScreen_Activity.this, Comman.PRIFRENS_NAME);

    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(SearchEditPostScreen_Activity.this);
    }

}
