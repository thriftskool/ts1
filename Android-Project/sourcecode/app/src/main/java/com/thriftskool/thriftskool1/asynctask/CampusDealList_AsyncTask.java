package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.CampusBuzzList_Adapter;
import com.thriftskool.thriftskool1.adapter.CampusDealList_Adapter;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.CampusDealList_Been;
import com.thriftskool.thriftskool1.campus_deal_list.CampusDealListScreen_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list.Home_ListScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<CampusDealList_Been> campusDealsList = new ArrayList<CampusDealList_Been>();
    TextView tv_alert;
    private ArrayAdapter<CampusDealList_Been> adapter;

    private String str_start="0",str_end="0";
    private View footerView;
    private int filterflage=0;



    public CampusDealList_AsyncTask(Context contex,  List<CampusDealList_Been> campusDealsList, ListView lv_listView,TextView tv_alert,View footerView,String start, String end,int filterflage) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.campusDealsList = campusDealsList;
        this.lv_listView =lv_listView;
        this.tv_alert =tv_alert;
        this.footerView = footerView;
        str_start = start;
        str_end = end;
        this.filterflage=filterflage;

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
            json.put("university_id", Integer.parseInt(params[1]));
            json.put("start", (params[2]));
            json.put("end", (params[3]));





            String response = Utility.postRequest(Comman.URL+"campus_deal_list", json.toString(),context);
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

        if (str_start.equalsIgnoreCase("0"))
            if(progressDialog!=null && !progressDialog.isShowing())
        {
            progressDialog.show();
        }

    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
        if (str_start.equalsIgnoreCase("0"))
            progressDialog.dismiss();

        try
        {


            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {
                tv_alert.setVisibility(View.GONE);
                int position = lv_listView.getFirstVisiblePosition();

                //campusDealsList.clear();
                JSONArray detailArray = result.getJSONArray("Details");



                if (detailArray.length()<10)
                {
                    lv_listView.removeFooterView(footerView);
                    CampusDealListScreen_Activity.dealloadmoreFlage=true;

                }else{

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                    CampusDealListScreen_Activity.dealloadmoreFlage=false;

                }


                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    campusDealsList.add(new CampusDealList_Been(detailItem.getString("deal_id"),detailItem.getString("user_id"),detailItem.getString("deal_name"),detailItem.getString("deal_code"),detailItem.getString("description"),detailItem.getString("create_date"),detailItem.getString("expirydate"),detailItem.getString("image"),result.getString("imagepath")));


                }
                adapter = new CampusDealList_Adapter(context,R.layout.home_list_row,campusDealsList);
                lv_listView.setAdapter(adapter);

                if (filterflage==1){

                    ((CampusDealList_Adapter)adapter).sortByExpiryDateAse();
                    lv_listView.setAdapter(adapter);

                }else if(filterflage==2){

                    ((CampusDealList_Adapter)adapter).sortByExpiryDateDes();
                    lv_listView.setAdapter(adapter);

                }



                lv_listView.setSelectionFromTop(position,0);




            }else if (result.getString("status").trim().equalsIgnoreCase("4041")){

                CampusDealListScreen_Activity.dealloadmoreFlage=true;
                lv_listView.removeFooterView(footerView);


            }
            else
            {
                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_deallist_alert));

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
