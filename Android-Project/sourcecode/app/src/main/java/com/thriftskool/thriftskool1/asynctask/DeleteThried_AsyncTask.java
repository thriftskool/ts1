package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.inbox.InBoxListScreen_Activity;
import com.thriftskool.thriftskool1.inbox.InBox_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 28/10/15.
 */
public class DeleteThried_AsyncTask extends AsyncTask<String, Integer, JSONObject>
{

    ProgressDialog progressDialog;
    List<String> thridList=new ArrayList<String>();
    Context context;

    public DeleteThried_AsyncTask(Context context,List thridList)
    {
        this.context=context;
        this.thridList=thridList;


        progressDialog = new ProgressDialog(context);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);

    }
    @Override
    protected JSONObject doInBackground(String... params) {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;
        Log.e("Thred List ", " "+thridList);
        try
        {

            JSONObject json = new JSONObject();
            json.put("own_id", Integer.parseInt(params[0]));
          //  json.put("thread_id", thridList);

            JSONArray jarray = new JSONArray();

            for (int i = 0; i < thridList.size(); i++) {
                jarray.put(thridList.get(i));

            }

            json.put("thread_id", jarray);


            String response = Utility.postRequest(Comman.URL+"delete_thread", json.toString(),context);
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

                Toast toast=  Toast.makeText(context, R.string.MessageDelete, Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();

                Intent i = new Intent(context,InBox_Tab_Activity.class);
                context.startActivity(i);

                // ((Activity)context).finish();
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
