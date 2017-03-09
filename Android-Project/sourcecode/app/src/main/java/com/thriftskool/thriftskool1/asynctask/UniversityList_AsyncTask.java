package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.ListView;
import android.widget.Spinner;

import com.thriftskool.thriftskool1.adapter.UniversityRow_Adapter;
import com.thriftskool.thriftskool1.been.UniversityList_Been;
import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 6/8/15.
 */
public class UniversityList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    private ProgressDialog progressDialog;
    private  Context context;
    private List<UniversityList_Been> universityList = new ArrayList<UniversityList_Been>();
    private ListView lv_listView;

    public UniversityList_AsyncTask(Context contex, List<UniversityList_Been> universityList,ListView lv_listView ) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.universityList = universityList;
        this.lv_listView = lv_listView;
        progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);


    }




    @Override
    protected JSONObject doInBackground(String... params)
    {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {
            universityList.clear();

            String response = Utility.postRequest(Comman.URL+"university_list",context);

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

        try {

            if (result.getString("status").equalsIgnoreCase("200"))
            {

                JSONArray Details = result.getJSONArray("Details");

                for (int i = 0; i < Details.length(); i++)
                {

                    JSONObject DetailRow = Details.getJSONObject(i);

                    universityList.add(new UniversityList_Been(DetailRow.getString("university_id"), DetailRow.getString("university_name"), DetailRow.getString("domain_name"), DetailRow.getString("image"), result.getString("imagepath"), false));
                }

                universityList.add(new UniversityList_Been("0", "University not listed?", "", "", "", false));

                lv_listView.setAdapter(new UniversityRow_Adapter(context, universityList));

                Log.e("size Total", " " + universityList.size());

            }
            else
            {
                universityList.add(new UniversityList_Been("0", "University not listed?", "", "", "", false));

                lv_listView.setAdapter(new UniversityRow_Adapter(context, universityList));

            }
        }catch (Exception e){

            Log.e("Exception ","Exception: "+e.getMessage());
        }


    }


}
