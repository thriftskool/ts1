package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONObject;

/**
 * Created by etiloxadmin on 14/9/15.
 */
public class ForgotPassword_AsynkTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;



    public ForgotPassword_AsynkTask(Context contex) {
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
            json.put("email", (params[0]));



            String response = Utility.postRequest(Comman.URL+"forgotpassword", json.toString(),context);
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


            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {

                Toast toast= Toast.makeText(context, "Thank you. Please check your email inbox.", Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();


            }
            else
            {


                Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
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
