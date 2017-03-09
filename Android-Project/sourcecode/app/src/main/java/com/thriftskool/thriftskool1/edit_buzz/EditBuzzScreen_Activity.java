package com.thriftskool.thriftskool1.edit_buzz;

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
import android.provider.MediaStore;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Base64;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.CreateBuzz_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.UpdateBuzz_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.UpdatePost_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.Utility;
import com.thriftskool.thriftskool1.been.EditPostGallary_Been;
import com.thriftskool.thriftskool1.category.CategoryScreen_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.edit_post.EditPost_Tab_Activity;
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

public class EditBuzzScreen_Activity extends Activity implements View.OnClickListener {

    private SquareImageView iv_photo1, iv_photo2, iv_photo3, iv_photo4;
    private TextView  tv_expiryDate, tv_mainTitle, tv_back, tv_save, tv_submit,tv_countNotification;
    private EditText et_title, et_description;
    private LinearLayout  ll_expriyDate;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    public static int int_photopos;
    private String str_categoryId = "", str_categoryName = "";
    private List<EditPostGallary_Been> imageList = new ArrayList<EditPostGallary_Been>();
    private Calendar calender;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_buzz_screen_);
        calender = Calendar.getInstance();

        hashMap = SessionStore.getUserDetails(EditBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(EditBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();
    }


    //************** Maping **************************************************************************************************************************

    private void maping() {

        //TextView
        tv_back = (TextView) findViewById(R.id.Header_Back);
        tv_mainTitle = (TextView) findViewById(R.id.Header_Title);
        tv_save = (TextView) findViewById(R.id.Header_Save);
        tv_expiryDate = (TextView) findViewById(R.id.EditBuzzScreen_ExpiryDate);
        tv_submit = (TextView) findViewById(R.id.EditBuzzScreen_submit);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //EditText
        et_description = (EditText) findViewById(R.id.EditBuzzScreen_description);
        et_title = (EditText) findViewById(R.id.EditBuzzScreen_title);

        //ImageView
        iv_photo1 = (SquareImageView) findViewById(R.id.EditBuzzScreen_photo1);
        iv_photo2 = (SquareImageView) findViewById(R.id.EditBuzzScreen_photo2);
        iv_photo3 = (SquareImageView) findViewById(R.id.EditBuzzScreen_photo3);
        iv_photo4 = (SquareImageView) findViewById(R.id.EditBuzzScreen_photo4);

        //LinearLayout
        ll_expriyDate = (LinearLayout) findViewById(R.id.EditBuzzScreen_ExpiryDateLayout);


        iv_photo1.setOnClickListener(EditBuzzScreen_Activity.this);
        iv_photo2.setOnClickListener(EditBuzzScreen_Activity.this);
        iv_photo3.setOnClickListener(EditBuzzScreen_Activity.this);
        iv_photo4.setOnClickListener(EditBuzzScreen_Activity.this);
        ll_expriyDate.setOnClickListener(EditBuzzScreen_Activity.this);
        tv_submit.setOnClickListener(EditBuzzScreen_Activity.this);
        tv_save.setOnClickListener(EditBuzzScreen_Activity.this);


        setValue();


    }


    //************** Set VAlue **************************************************************************************************************************************

    private void setValue() {

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)
        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }



        tv_mainTitle.setText("Edit Buzz");

        EditBuzz_AsyncTask editpost = new EditBuzz_AsyncTask(EditBuzzScreen_Activity.this);
        editpost.execute(EditBuzz_Tab_Activity.str_userId, EditBuzz_Tab_Activity.str_buzzId);




    }


    //******************** OnClickListener ******************************************************************************************************************************


    @Override
    public void onClick(View v) {

        Intent intent=null;

        switch (v.getId()) {


            case R.id.EditBuzzScreen_ExpiryDateLayout:
                showDialog(0);

                break;


            case R.id.EditBuzzScreen_photo1:
                int_photopos = 1;

                Image_Picker_Dialog();


                break;


            case R.id.EditBuzzScreen_photo2:

                int_photopos = 2;

                Image_Picker_Dialog();

                break;


            case R.id.EditBuzzScreen_photo3:
                int_photopos = 3;

                Image_Picker_Dialog();


                break;


            case R.id.EditBuzzScreen_photo4:
                int_photopos = 4;

                Image_Picker_Dialog();


                break;


            case R.id.EditBuzzScreen_submit:

                if (CheckInterNetConnection.isNetworkAvailable(EditBuzzScreen_Activity.this))
                {

                    post();


                }
                else
                {

                    new AlertDialog.Builder(EditBuzzScreen_Activity.this)
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

                intent = new Intent(EditBuzzScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;



        }


    }



    //*********** Post  ******************************************************************************************************************

    private void post() {


        if (imageList.size()>0)
        {

            if (!et_title.getText().toString().trim().equalsIgnoreCase(""))
            {

                if (!et_description.getText().toString().trim().equalsIgnoreCase(""))
                {



                        try {
                            JSONObject json = new JSONObject();

                            json.put("buzz_id", Integer.parseInt(EditBuzz_Tab_Activity.str_buzzId));
                            json.put("user_id", Integer.parseInt(hashMap.get(SessionStore.USER_ID)));
                            json.put("university_id", Integer.parseInt(hashMap.get(SessionStore.UNIVERSITY_ID)));

                            json.put("buzz_title", et_title.getText().toString().trim());
                            json.put("description", et_description.getText().toString().trim());
                            json.put("expirydate", tv_expiryDate.getText().toString().trim()+" "+DateCoversion.getUTCTime());
                            json.put("dt_modifydate", DateCoversion.getUTCDateTime());



                            JSONArray jarray = new JSONArray();

                            for (int i = 0; i < imageList.size(); i++) {

                                JSONObject jj = new JSONObject();

                                jj.put("image_id", imageList.get(i).getImageId());
                                jj.put("title", EditBuzz_Tab_Activity.str_buzzId+"_"+(i + 1));
                                jj.put("image", imageList.get(i).getImage());

                                jarray.put(jj);

                            }

                            json.put("images", jarray);




                            UpdateBuzz_AsyncTask po = new UpdateBuzz_AsyncTask(EditBuzzScreen_Activity.this);
                            po.execute(json.toString());

                        }catch(Exception e)
                        {
                            Log.e("Exception ", "Post Exception: " + e.getMessage());
                        }



                }
                else
                {


                    Toast toast=  Toast.makeText(EditBuzzScreen_Activity.this, getString(R.string.description_alert_postscreen), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }
            }
            else
            {


                Toast toast= Toast.makeText(EditBuzzScreen_Activity.this, getString(R.string.blank_title_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
            }
        }
        else
        {


            Toast toast=  Toast.makeText(EditBuzzScreen_Activity.this, getString(R.string.photo_alert_postscreen), Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER,0,0);
            toast.show();
        }




    }


    // ********************* Date Picker **************************************************************************************************

    @Override
    protected Dialog onCreateDialog(int id) {

        if (id == 0 || id == 1) {

            DatePickerDialog _date = new DatePickerDialog(this, datePickerListener, calender.get(Calendar.YEAR),calender.get(Calendar.MONTH),calender.get(Calendar.DATE));

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
                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

                startActivityForResult(i, 100);

            }
        });

        myAlertDialog.setNegativeButton("Camera", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface arg0, int arg1) {
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
            resized =  getResizedBitmap(resized,300,300);
            resized.compress(Bitmap.CompressFormat.PNG, 90, stream);
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
            bmp =  getResizedBitmap(bmp,300,300);
            bmp.compress(Bitmap.CompressFormat.PNG, 90, stream);
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


    public class EditBuzz_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

        ProgressDialog progressDialog;
        Context context;


        public EditBuzz_AsyncTask(Context contex) {
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
                json.put("buzz_id", Integer.parseInt(params[1]));


                String response = Utility.postRequest(Comman.URL + "get_buzz_update", json.toString(),context);
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

                        et_title.setText(detailItem.getString("buzz_name"));
                        et_description.setText(detailItem.getString("description"));

                        tv_expiryDate.setText(detailItem.getString("expiry_date"));




                    }

                    detailArray = result.getJSONArray("Gallery");
                    for (int i = 0; i < detailArray.length(); i++) {

                        JSONObject detailItem = detailArray.getJSONObject(i);
                        new DownloadImage().execute(detailItem.getString("photo_id"), result.getString("imagepath") + "" + detailItem.getString("buzz_image"));
                    }


                } else {
                    Toast.makeText(context, result.getString("message"), Toast.LENGTH_LONG).show();

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

            result =  getResizedBitmap(result,300,300);
            result.compress(Bitmap.CompressFormat.PNG, 90, stream);
            byte[] byteArray = stream.toByteArray();
            String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);


            imageList.add(new EditPostGallary_Been(id, encoded));

            byte[] decodedString = Base64.decode(encoded, Base64.DEFAULT);
            Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

            if (imageList.size() == 1) {

                iv_photo1.setImageBitmap(decodedByte);
                iv_photo1.setEnabled(true);
                iv_photo2.setEnabled(true);




            } else if (imageList.size() == 2) {

                iv_photo2.setImageBitmap(decodedByte);
                iv_photo3.setEnabled(true);

            } else if (imageList.size() == 3) {

                iv_photo3.setImageBitmap(decodedByte);
                iv_photo4.setEnabled(true);

            } else if (imageList.size() == 4) {

                iv_photo4.setImageBitmap(decodedByte);

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

        hashMap = SessionStore.getUserDetails(EditBuzzScreen_Activity.this, Comman.PRIFRENS_NAME);

    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(EditBuzzScreen_Activity.this);
    }

}
