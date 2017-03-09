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
import com.thriftskool.thriftskool1.adapter.SearchResult_Adapter;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.SearchResult_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list.Home_ListScreen_Activity;
import com.thriftskool.thriftskool1.search_category.SearchCategoryScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 7/9/15.
 */
public class SearchCategory_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private TextView tv_alert;
    private List<SearchResult_Been> searchList = new ArrayList<SearchResult_Been>();

    private ArrayAdapter<SearchResult_Been> adpater;
    private String str_start="0",str_end="0";
    private View footerView;
    private int filterflage=0;




    public SearchCategory_AsyncTask(Context contex, ListView lv_listView,TextView tv_alert, List<SearchResult_Been> searchList,View footerView,String start, String end , int filterflage) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.lv_listView = lv_listView;
        this.tv_alert = tv_alert;
        this.searchList = searchList;
        this.footerView = footerView;
        str_start = start;
        str_end = end;
        this.filterflage =filterflage;

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

            //searchList.clear();

            JSONObject json = new JSONObject();
            json.put("university_id", Integer.parseInt(params[0]));
            json.put("search_text", (params[1]));
            json.put("start", (params[2]));
            json.put("end", (params[3]));


            String response = Utility.postRequest(Comman.URL+"search", json.toString(),context);
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

Log.e("dfdsfsdf","Heloooooooo: "+result);

            if (result.getString("status").trim().equalsIgnoreCase("201"))
            {

                int position = lv_listView.getFirstVisiblePosition();

                tv_alert.setVisibility(View.GONE);

                JSONArray detailArray = result.getJSONArray("Details");


                if (detailArray.length()<10)
                {
                    lv_listView.removeFooterView(footerView);
                    SearchCategoryScreen_Activity.searchresultloadmoreFlage=true;

                }else{

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                    SearchCategoryScreen_Activity.searchresultloadmoreFlage=false;

                }



                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);

                    String price=detailItem.getString("price");

                    if (price.trim().equalsIgnoreCase("")){
                        price="0";
                    }

                    searchList.add(new SearchResult_Been(detailItem.getString("type"), detailItem.getString("id"), detailItem.getString("user_id"), detailItem.getString("title"),price, detailItem.getString("status"), detailItem.getString("expirydate"), result.getString("URL") + detailItem.getString("imagepath"), detailItem.getString("image"), detailItem.getString("image_id")));

                }



                adpater = new SearchResult_Adapter(context,R.layout.home_list_row,  searchList);
                lv_listView.setAdapter(adpater);


                if (filterflage==1){
                    ((SearchResult_Adapter)adpater).sortByPriceAse();
                    lv_listView.setAdapter(adpater);

                }else if (filterflage==2){

                    ((SearchResult_Adapter)adpater).sortByPriceDes();
                    lv_listView.setAdapter(adpater);

                }else if (filterflage==3){

                    ((SearchResult_Adapter)adpater).sortByExpiryDateAse();
                    lv_listView.setAdapter(adpater);

                }else if (filterflage==4){

                    ((SearchResult_Adapter)adpater).sortByExpiryDateDes();
                    lv_listView.setAdapter(adpater);

                }

                lv_listView.setSelectionFromTop(position,0);




            }else if (result.getString("status").trim().equalsIgnoreCase("4041")){

                SearchCategoryScreen_Activity.searchresultloadmoreFlage=true;
                lv_listView.removeFooterView(footerView);


            }else if (result.getString("status").trim().equalsIgnoreCase("404")){

                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_searchresultlist_alert));

            }


        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
