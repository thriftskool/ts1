package com.thriftskool.thriftskool1.asynctask;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.Gravity;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.post.PostScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 17/8/15.
 */
public class Post_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;

    private EditText et_title, et_description, et_price;
    private TextView  tv_expirydate, tv_chooseCategory;
    private ImageView iv_photo1, iv_photo2, iv_photo3, iv_photo4;
    private CheckBox chb_privacyPolicy;
    //public static int int_photopos;
    private List<String> imageList = new ArrayList<String>();
    private String str_categoryId="", str_categoryName="";


    public Post_AsyncTask(Context contex, EditText et_title,EditText et_description,EditText et_price, TextView tv_expirydate,TextView tv_chooseCategory,ImageView iv_photo1,ImageView iv_photo2,ImageView iv_photo3,ImageView iv_photo4,CheckBox chb_privacyPolicy, List<String> imageList, String str_categoryId, String str_categoryName ) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.et_description =et_description;
        this.et_price =et_price;
        this.et_title =et_title;

        this.tv_expirydate =tv_expirydate;
        this.tv_chooseCategory =tv_chooseCategory;

        this.iv_photo1 =iv_photo1;
        this.iv_photo2 =iv_photo2;
        this.iv_photo3 =iv_photo3;
        this.iv_photo4 =iv_photo4;

        this.chb_privacyPolicy = chb_privacyPolicy;

        this.imageList = imageList;
        this.str_categoryId = str_categoryId;






        progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);


    }


    @Override
    protected JSONObject doInBackground(String... params)
    {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {


            String response = Utility.postRequest(Comman.URL+"post_insert", params[0].toString(),context);
            JSONObject jObject = new JSONObject(response);
            jsonresponse = jObject.getJSONObject("Response");



        }
        catch(Exception e)
        {

            e.getStackTrace();
        }



        return jsonresponse;
    }

    @Override
    protected void onPreExecute() {
        // TODO Auto-generated method stub
        super.onPreExecute();

        if(progressDialog!=null && !progressDialog.isShowing())
        {
               progressDialog.show();
        }

    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
         progressDialog.dismiss();

        try
        {


            if (result.getString("status").trim().equalsIgnoreCase("201"))
            {



               /// Toast.makeText(context, context.getString(R.string.server_createpost_alert), Toast.LENGTH_LONG).show();

               /* alert_title*/
                new AlertDialog.Builder(context)
                        .setMessage(context.getString(R.string.server_createpost_alert))
                        .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {


                            }
                        }).show();


                PostScreen_Activity.int_photopos=0;
                et_title.setText("");
                et_price.setText("");
                et_description.setText("");
                tv_chooseCategory.setText("Choose category");
                tv_expirydate.setText("");
                str_categoryId = "";
                iv_photo1.setImageResource(android.R.color.transparent);
                iv_photo2.setImageResource(android.R.color.transparent);
                iv_photo3.setImageResource(android.R.color.transparent);
                iv_photo4.setImageResource(android.R.color.transparent);

                imageList.clear();
                chb_privacyPolicy.setChecked(false);



            }
            else
            {

                Toast toast=  Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
