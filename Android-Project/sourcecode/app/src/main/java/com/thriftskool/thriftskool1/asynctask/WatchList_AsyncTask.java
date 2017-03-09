package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeCategoryList_Adapter;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.adapter.MyPostList_Adapter;
import com.thriftskool.thriftskool1.adapter.WatchList_Adapter;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.MyPostList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list.Home_ListScreen_Activity;
import com.thriftskool.thriftskool1.watch_list.WatchListScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class WatchList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<MyPostList_Been> myPostList = new ArrayList<MyPostList_Been>();
    TextView tv_alert;
    private ArrayAdapter<MyPostList_Been> adpater;
    private String str_start="0",str_end="0";
    private View footerView;
    private int filterflage=0;



    public WatchList_AsyncTask(Context contex,  List<MyPostList_Been> myPostList , ListView lv_listView, TextView tv_alert,View footerView,String start, String end, int filterflage) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.myPostList = myPostList;
        this.lv_listView = lv_listView;
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
            json.put("chr_fav", 1);
            json.put("start", (params[1]));
            json.put("end", (params[2]));




            String response = Utility.postRequest(Comman.URL+"favorite_list", json.toString(),context);
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

                // myPostList.clear();
                JSONArray detailArray = result.getJSONArray("Details");

                if (detailArray.length()<10)
                {
                    lv_listView.removeFooterView(footerView);
                    WatchListScreen_Activity.watchlistloadmoreFlage=true;

                }else{

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                    WatchListScreen_Activity.watchlistloadmoreFlage=false;

                }


                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    myPostList.add(new MyPostList_Been(detailItem.getString("post_id"), detailItem.getString("user_id"), "Post",detailItem.getString("post_name"), detailItem.getString("description"), detailItem.getString("price"), detailItem.getString("status"), "1", detailItem.getString("expirydate"), detailItem.getString("image"), result.getString("imagepath")));
//                    "post_id":"87","user_id":"14","post_name":"fyhg","description":"ggut","price":"8658","status":"0","expirydate":"2015-09-24 00:00:00","image":"87-1.jpeg"
                }

                adpater = new WatchList_Adapter(context,R.layout.home_list_row, myPostList);

                lv_listView.setAdapter(adpater);

                if (filterflage==1){

                    ((WatchList_Adapter)adpater).sortByPriceAse();
                    lv_listView.setAdapter(adpater);

                }else if (filterflage==2){

                    ((WatchList_Adapter)adpater).sortByPriceDes();
                    lv_listView.setAdapter(adpater);

                }else if (filterflage==3){

                    ((WatchList_Adapter)adpater).sortByExpiryDateAse();
                      lv_listView.setAdapter(adpater);

                }else if (filterflage==4){


                    ((WatchList_Adapter)adpater).sortByExpiryDateDes();
                    lv_listView.setAdapter(adpater);
                }



                lv_listView.setSelectionFromTop(position,0);



            }else if (result.getString("status").trim().equalsIgnoreCase("4041")){

                WatchListScreen_Activity.watchlistloadmoreFlage=true;
                lv_listView.removeFooterView(footerView);


            }
            else
            {
                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_watchlist_alert));

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }


}
