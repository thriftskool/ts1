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
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.adapter.MyPostList_Adapter;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.MyPostList_Been;
import com.thriftskool.thriftskool1.campus_buzz_list.CampusBuzzListScreen_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.mypost.MyPostListScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class MyPostList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<MyPostList_Been> myPostList = new ArrayList<MyPostList_Been>();
    TextView tv_alert;
    private ArrayAdapter<MyPostList_Been> adpater;
    private String str_start="0",str_end="0";
    private View footerView;
    private int filterflage=0;
    int delValue,selValue,editValue;



    public MyPostList_AsyncTask(Context contex,  List<MyPostList_Been> myPostList , ListView lv_listView, TextView tv_alert,View footerView,String start, String end, int filterflage,int delValue,int selValue,int editValue)
    {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.myPostList = myPostList;
        this.lv_listView = lv_listView;
        this.tv_alert =tv_alert;
        this.footerView = footerView;
        str_start = start;
        str_end = end;
        this.filterflage=filterflage;
        this.delValue=delValue;
        this.selValue=selValue;
        this.editValue=editValue;

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

            json.put("start", (params[1]));
            json.put("end", (params[2]));


            String response = Utility.postRequest(Comman.URL+"my_post_list", json.toString(),context);
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

                int value=0;
                tv_alert.setVisibility(View.GONE);

                int position = lv_listView.getFirstVisiblePosition();
                //myPostList.clear();

                JSONArray detailArray = result.getJSONArray("Details");

                value = detailArray.length();



                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    myPostList.add(new MyPostList_Been(detailItem.getString("post_id"), detailItem.getString("user_id"),"Post", detailItem.getString("post_name"), detailItem.getString("description"), detailItem.getString("price"), detailItem.getString("status"), detailItem.getString("favorite"), detailItem.getString("expirydate"), detailItem.getString("image"), result.getString("imagepath")));
                }


                detailArray = result.getJSONArray("Details_buzz");

                value =value+ detailArray.length();

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    myPostList.add(new MyPostList_Been(detailItem.getString("buzz_id"), detailItem.getString("user_id"),"Buzz",  detailItem.getString("buzz_name"), detailItem.getString("description"), "0", detailItem.getString("status"), detailItem.getString("block"), detailItem.getString("expirydate"), detailItem.getString("image"), result.getString("buzz_imagepath")));

                }


                if (value<10)
                {
                    lv_listView.removeFooterView(footerView);
                    MyPostListScreen_Activity.mypostloadmoreFlage=true;

                }
                else
                {

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                    MyPostListScreen_Activity.mypostloadmoreFlage=false;
                }


                adpater = new MyPostList_Adapter(context, R.layout.home_list_row,myPostList,delValue,selValue,editValue);
                lv_listView.setAdapter(adpater);

                if (filterflage==1){

                    ((MyPostList_Adapter)adpater).sortByPriceAse();
                    lv_listView.setAdapter(adpater);

                }else if(filterflage==2){

                    ((MyPostList_Adapter)adpater).sortByPriceDes();
                    lv_listView.setAdapter(adpater);

                }else if(filterflage==3){

                    ((MyPostList_Adapter)adpater).sortByExpiryDateAse();
                    lv_listView.setAdapter(adpater);

                }else if(filterflage==4){

                    ((MyPostList_Adapter)adpater).sortByExpiryDateDes();
                    lv_listView.setAdapter(adpater);

                }


                lv_listView.setSelectionFromTop(position,0);


            }else if (result.getString("status").trim().equalsIgnoreCase("4041")){

                MyPostListScreen_Activity.mypostloadmoreFlage=true;
                lv_listView.removeFooterView(footerView);

            }
            else
            {
                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_mypostlist_alert));

            }


        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
