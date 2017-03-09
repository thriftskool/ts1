package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class CHnagePassword_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;



    public CHnagePassword_AsyncTask(Context contex) {
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
            json.put("user_id", Integer.parseInt(params[0]));
            json.put("old_password", (params[1]));
            json.put("new_password", (params[2]));





            String response = Utility.postRequest(Comman.URL+"changepassword", json.toString(),context);
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
            //   progressDialog.show();
        }

    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
        // progressDialog.dismiss();

        try
        {


            if (result.getString("status").trim().equalsIgnoreCase("204"))
            {

                Toast toast= Toast.makeText(context, context.getString(R.string.server_changepassword_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

                ((Activity)context).finish();

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
