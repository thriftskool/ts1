package com.thriftskool.thriftskool1.login_signup;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.JsonObjectRequest;
import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.AppController;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.ClassList_AsyncTask;
import com.thriftskool.thriftskool1.been.ClassList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.login.LoginScreen_Activity;
import com.thriftskool.thriftskool1.signup.SignupScreen_Activity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class LoginSignupScreen_Activity extends Activity implements View.OnClickListener {

    private TextView tv_login, tv_signup, tv_forgotpassword;
    private ImageView iv_logo;
    public static List<ClassList_Been> class_List;
    public static List<String> classList_2;
    String tag_json_obj = "json_obj_req";
   // String URL = "http://thriftskool.com/mobileapps/test_thriftskool/webservice/get_class"; //client url


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_login_signup_screen_);

        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);


        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        // android:background="@drawable/logo"
        maping();
    }


    //***************** Maping *******************************************************************************************************************************************************************

    private void maping() {


        /// TextView maping
        tv_login = (TextView) findViewById(R.id.LoginSignupScreen_Login);
        tv_signup = (TextView) findViewById(R.id.LoginSignupScreen_Signup);
        tv_forgotpassword = (TextView) findViewById(R.id.LoginSignupScreen_ForgotPassword);


        iv_logo = (ImageView) findViewById(R.id.LoginSignupScreen_Logo);


        Picasso.with(LoginSignupScreen_Activity.this).load(R.drawable.logo).into(iv_logo);

//        iv_logo.setImageResource(R.drawable.logo);

        /// Click event
        tv_login.setOnClickListener(LoginSignupScreen_Activity.this);
        tv_signup.setOnClickListener(LoginSignupScreen_Activity.this);
        tv_forgotpassword.setOnClickListener(LoginSignupScreen_Activity.this);


        ClassList_AsyncTask asyncTask=new ClassList_AsyncTask(LoginSignupScreen_Activity.this);
        asyncTask.execute();

      //  JSONClassList();
    }

    public void JSONClassList()
    {
        JsonObjectRequest jsonObjReq = new JsonObjectRequest(Request.Method.GET,
                Comman.URL, null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response)
                    {
                        Log.d("Responce....", response.toString());
                        try {

                          /*  if (response.getString("status").trim().equalsIgnoreCase("200"))
                            {
                              */
                            class_List=new ArrayList<>();

                                JSONArray jsonArray=response.getJSONArray("Details");

                                for (int i=0;i<=jsonArray.length();i++)
                                {
                                    JSONObject object=jsonArray.getJSONObject(i);

                                   // class_List.add(new ClassList_Been(object.getString("int_glcode"),object.getString("class_name")));


                                }

                                Log.e("List of class size...."," "+class_List.size());
                        } catch (JSONException e) {
                            e.printStackTrace();
                            Log.e("Excaption of class....", " " + e.getMessage());

                        }
                    }
                }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d("", "Error: " + error.getMessage());
                // hide the progress dialog
            }
        });

// Adding request to request queue
        AppController.getInstance().addToRequestQueue(jsonObjReq, tag_json_obj);
    }



 //********************************* onClick Method *********************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent = null;

        ///Switch case

        switch (v.getId())
        {
            case R.id.LoginSignupScreen_Login:

                intent = new Intent(LoginSignupScreen_Activity.this, LoginScreen_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                finish();

                break;

            case R.id.LoginSignupScreen_Signup:

                intent = new Intent(LoginSignupScreen_Activity.this, SignupScreen_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                finish();

                break;


            case R.id.LoginSignupScreen_ForgotPassword:

                intent = new Intent(LoginSignupScreen_Activity.this, LoginSignupScreen_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                finish();

                break;


        }



    }

    //****************************** On Back  Press*******************************************************************************************************************************************************


    @Override
    public void onBackPressed() {
        Intent intent = new Intent();
        intent.setAction(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        startActivity(intent);
//        super.onBackPressed();

    }
}
