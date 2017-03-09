package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.inbox.InBoxListScreen_Activity;
import com.thriftskool.thriftskool1.inbox.InBox_Tab_Activity;
import com.thriftskool.thriftskool1.mypost.MyPostListScreen_Activity;
import com.thriftskool.thriftskool1.mypost.MyPostList_Tab_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class DeletePostBuzz_AsyncTask extends AsyncTask<String, Integer, JSONObject>
{
    ProgressDialog progressDialog;
    List<String> PostList=new ArrayList<String>();
    List<String> BuzzList=new ArrayList<String>();

    Context context;

    public DeletePostBuzz_AsyncTask(Context context,List PostList,List BuzzList)
    {
        this.context=context;
        this.PostList=PostList;
        this.BuzzList=BuzzList;

        progressDialog = new ProgressDialog(context);
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

            JSONArray jarrayPost = new JSONArray();
            JSONArray jarrayBuzz = new JSONArray();

            for (int i = 0; i < PostList.size(); i++)
            {
                jarrayPost.put(PostList.get(i));
            }
            for (int i = 0; i < BuzzList.size(); i++)
            {
                   jarrayBuzz.put(BuzzList.get(i));

            }

            json.put("post_id", jarrayPost);
            json.put("buzz_id", jarrayBuzz);

            String response = Utility.postRequest(Comman.URL+"delete_post", json.toString(),context);
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
    protected void onPreExecute()
    {
        // TODO Auto-generated method stub
        super.onPreExecute();

        if(progressDialog!=null && !progressDialog.isShowing())
        {
            progressDialog.show();
        }


    }

    @Override
    protected void onPostExecute(JSONObject result)
    {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
        progressDialog.dismiss();

        try
        {

            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {

                Toast toast=  Toast.makeText(context, "Successfully deleted.", Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();

                Intent i = new Intent(context,MyPostListScreen_Activity.class);
                context.startActivity(i);

//                ((Activity)context).finish();

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