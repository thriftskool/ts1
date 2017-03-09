package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.GridView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.adapter.HomeCategoryList_Adapter;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.session.SessionStore;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 10/8/15.
 */
public class HomeCategoryList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private List<HomeCategory_List_Been> categotyList = new ArrayList<HomeCategory_List_Been>();
    private GridView gv_gridView;



    public HomeCategoryList_AsyncTask(Context contex,  List<HomeCategory_List_Been> categotyList, GridView gv_gridView) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.categotyList = categotyList;
        this.gv_gridView =gv_gridView;

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


            String response = Utility.postRequest(Comman.URL+"post_categorylist", json.toString(),context);
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

                categotyList.clear();
                JSONArray detailArray = result.getJSONArray("Details");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    categotyList.add(new HomeCategory_List_Been(detailItem.getString("post_cat_id"),detailItem.getString("post_category_name"),detailItem.getString("post_cat_image"),result.getString("imagepath"),detailItem.getString("background_image")));


                }

                gv_gridView.setAdapter(new HomeCategoryList_Adapter(context, categotyList));



            }
            else
            {


            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception"," Category List Exception: "+e.getMessage());
        }


    }

}
