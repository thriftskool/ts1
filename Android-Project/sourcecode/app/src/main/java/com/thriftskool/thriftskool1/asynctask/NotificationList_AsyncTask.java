package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.NotificationList_Adapter;
import com.thriftskool.thriftskool1.been.NotoficationList_Been;
import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 9/9/15.
 */
public class NotificationList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<NotoficationList_Been> notificationList = new ArrayList<NotoficationList_Been>();
    TextView tv_alert;
    int countNotification=0,i=0,j=0,k=0;


    public NotificationList_AsyncTask(Context contex,  List<NotoficationList_Been> notificationList , ListView lv_listView, TextView tv_alert) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.notificationList = notificationList;
        this.lv_listView = lv_listView;
        this.tv_alert =tv_alert;

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

            String response = Utility.postRequest(Comman.URL+"notification", json.toString(),context);
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

                tv_alert.setVisibility(View.GONE);

                notificationList.clear();
                JSONArray detailArray = result.getJSONArray("Details_post");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    notificationList.add(new NotoficationList_Been(detailItem.getString("notification_id"),detailItem.getString("reference_id"),detailItem.getString("notification_type"),detailItem.getString("id"),detailItem.getString("user_id"),detailItem.getString("name"),detailItem.getString("image"),detailItem.getString("image_id"),result.getString("imagepath_post")));
                    i=i+1;
                }

                detailArray = result.getJSONArray("Details_buzz");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    notificationList.add(new NotoficationList_Been(detailItem.getString("notification_id"),detailItem.getString("reference_id"),detailItem.getString("notification_type"),detailItem.getString("id"),detailItem.getString("user_id"),detailItem.getString("name"),detailItem.getString("image"),detailItem.getString("image_id"),result.getString("imagepath_buzz")));
                    j=j+1;
                }

                detailArray = result.getJSONArray("Result_message");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    notificationList.add(new NotoficationList_Been(detailItem.getString("notification_id"),detailItem.getString("post_name"),detailItem.getString("notification_type"),detailItem.getString("thread_id"),detailItem.getString("user_id"),detailItem.getString("user_name"),detailItem.getString("image"),detailItem.getString("post_id"),result.getString("imagepath_post")));
                    k=k+1;
                }

                countNotification=i+j+k;

            //    Toast.makeText(context,"Number Of Notification "+countNotification,Toast.LENGTH_SHORT).show();

                lv_listView.setAdapter(new NotificationList_Adapter(context, notificationList,countNotification));


        }else{

                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_notificationlist_alert));

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
