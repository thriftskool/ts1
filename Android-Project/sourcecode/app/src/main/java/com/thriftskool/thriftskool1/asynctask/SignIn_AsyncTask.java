package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_tab.HomeTabScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import org.json.JSONObject;

/**
 * Created by etiloxadmin on 30/8/15.
 */
public class SignIn_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;


    public SignIn_AsyncTask(Context contex) {
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
            json.put("username", params[0]);
            json.put("password", params[1]);
            json.put("device_id", params[2]);



            String response = Utility.postRequest(Comman.URL+"login", json.toString(),context);
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

        try
        {


            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {


                Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

                SessionStore.save(context, Comman.PRIFRENS_NAME, result.getString("login_id"), result.getString("university_id"), result.getString("user_name"), result.getString("university_name"),result.getString("imagepath")+""+result.getString("university_image"), result.getString("email_id"),result.getString("profile_img"),result.getString("class"),result.getString("profileimgpath"),result.getString("person_name"));
                ((Activity) context).finish();
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
        }

        progressDialog.dismiss();

    }


}
