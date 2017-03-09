package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;

import org.json.JSONObject;

/**
 * Created by etiloxadmin on 10/8/15.
 */
public class Signup_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    String uri="http://thriftskool.com/mobileapps/test_thriftskool/webservice/";

    public Signup_AsyncTask(Context contex) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);


    }




    @Override
    protected JSONObject doInBackground(String... params) {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {

            JSONObject json = new JSONObject();
            json.put("university_id", params[0]);
            json.put("email_id", params[1]);
            json.put("user_name", params[2]);
            json.put("password", params[3]);
            json.put("device_id", params[4]);
            json.put("person_name", params[5]);
            json.put("class", params[6]);
            json.put("profile_img", params[7]);




            String response = Utility.postRequest(Comman.URL+"registration", json.toString(),context);
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
                Toast toast=  Toast.makeText(context, context.getString(R.string.server_successfulregistration_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
                Intent intent = new Intent(context, LoginSignupScreen_Activity.class);
                context.startActivity(intent);
                ((Activity)context).finish();

/*
                new AlertDialog.Builder(context)
                        .setTitle("Alert!")
                        .setCancelable(false)
                        .setMessage(context.getString(R.string.server_successfulregistration_alert))
                        .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                Intent intent = new Intent(context, LoginSignupScreen_Activity.class);
                                context.startActivity(intent);
                                ((Activity)context).finish();

                            }
                        }).show();*/

            }
            else if (result.getString("status").trim().equalsIgnoreCase("401")){


                Toast toast=  Toast.makeText(context, context.getString(R.string.server_duplicateemail_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }else if (result.getString("status").trim().equalsIgnoreCase("400")){


                Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }else if (result.getString("status").trim().equalsIgnoreCase("208")){

                Toast toast=Toast.makeText(context, context.getString(R.string.server_duplicateusername_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }






        }
        catch(Exception e)
        {

            e.getStackTrace();
        }


    }


}
