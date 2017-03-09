package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.session.SessionStore;

import org.json.JSONObject;

import java.util.HashMap;

/**
 * Created by etiloxadmin on 31/8/15.
 */
public class EditProfile_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private String university_id,email_id,var_username,university_Name,university_Image,profileImh,class_id,personName;
    private HashMap<String, String> hashMap = new HashMap<String, String>();;

    public EditProfile_AsyncTask(Context contex) {
        // TODO Auto-generated constructor stub

        hashMap = SessionStore.getUserDetails(contex, Comman.PRIFRENS_NAME);
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

            university_id = params[1];
            email_id = params[2];
            var_username = params[3];
            university_Name = params[7];
            university_Image = params[8];
            personName=params[5];
            class_id=params[4];

            JSONObject json = new JSONObject();

            json.put("user_id", Integer.parseInt(params[0]));
            json.put("university_id", Integer.parseInt(params[1]));
            json.put("email_id", params[2]);
            json.put("var_username", params[3]);
            json.put("class", params[4]);
            json.put("person_name", params[5]);
            json.put("profile_img", params[6]);


            String response = Utility.postRequest(Comman.URL+"edit_profile", json.toString(),context);
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
            if (result.getString("status").trim().equalsIgnoreCase("204"))
            {

                Toast toast= Toast.makeText(context, context.getString(R.string.server_editprofile_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();

                profileImh=result.getString("profileimg");

                SessionStore.save(context, Comman.PRIFRENS_NAME, hashMap.get(SessionStore.USER_ID), university_id, var_username, university_Name, university_Image, email_id,profileImh,class_id,result.getString("profileimgpath"),personName);
                ((Activity) context).finish();
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
        }

        progressDialog.dismiss();

    }


}
