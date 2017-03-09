package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.widget.Toast;

import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealsDetailsViewPager_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();



    public CampusDealsDetailsViewPager_AsyncTask(Context contex,  ArrayList<String> imageList, ViewPager viewpag_viewPager) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.imageList = imageList;
        this.viewpag_viewPager =viewpag_viewPager;

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
            json.put("deal_id", Integer.parseInt(params[1]));





            String response = Utility.postRequest(Comman.URL+"deal_detail", json.toString(),context);
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


            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {

                imageList.clear();
                JSONArray detailArray = result.getJSONArray("images");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                //    imageList.add(new Image_Been(detailItem.getString("image_id"),detailItem.getString("title"),detailItem.getString("image"),result.getString("imagepath")));
                    imageList.add((result.getString("imagepath")+""+detailItem.getString("image")));

                }

                viewpag_viewPager.setAdapter(new ViewPagerAdapter(context, imageList));



            }
            else
            {
//                Toast.makeText(context, result.getString("message"), Toast.LENGTH_LONG).show();

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
