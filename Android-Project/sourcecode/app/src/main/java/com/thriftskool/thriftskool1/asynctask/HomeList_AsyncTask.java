package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.Adapter;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeCategoryList_Adapter;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list.Home_ListScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 11/8/15.
 */
public class HomeList_AsyncTask  extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<HomeList_Been> homeList = new ArrayList<HomeList_Been>();
    private TextView tv_alert;
    private ArrayAdapter<HomeList_Been> adpater;
    private String str_start="0",str_end="0";
    private View footerView;
    int filterValue=0;




    public HomeList_AsyncTask(Context contex,  List<HomeList_Been> homeList , ListView lv_listView, TextView tv_alert, ArrayAdapter<HomeList_Been> adapter,View footerView,String start, String end,int filterValue) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.homeList = homeList;
        this.lv_listView = lv_listView;
        this.tv_alert =tv_alert;
        this.adpater = adpater;
        this.footerView = footerView;
        this.str_start = start;
        this.str_end = end;
        this.filterValue = filterValue;

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
            json.put("post_cat_id", Integer.parseInt(params[1]));
            json.put("university_id", Integer.parseInt(params[2]));
            json.put("start", (params[3]));
            json.put("end", (params[4]));



            String response = Utility.postRequest(Comman.URL+"post_list", json.toString(),context);
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

                //homeList.clear();
                JSONArray detailArray = result.getJSONArray("Details");

               // lv_listView.addFooterView(footerView);


                if (detailArray.length()<10)
                    {
                        lv_listView.removeFooterView(footerView);
                        Home_ListScreen_Activity.loadmoreFlage=true;

                    }else{

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                       Home_ListScreen_Activity.loadmoreFlage=false;

                   }




                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    homeList.add(new HomeList_Been(detailItem.getString("post_id"), detailItem.getString("user_id"), detailItem.getString("post_name"), detailItem.getString("description"), detailItem.getString("price"), detailItem.getString("status"), detailItem.getString("favorite"), detailItem.getString("expirydate"), detailItem.getString("image"), detailItem.getString("image_id"), result.getString("imagepath"),"","",true));

                }


                Log.e("Exception", " detailArray.length()== " +detailArray.length() +"  :: "+homeList.size());


                adpater = new HomeLIst_Adapter(context,R.layout.home_list_row, homeList);

                lv_listView.setAdapter(adpater);

                if (filterValue==1)
                {
                    ((HomeLIst_Adapter)adpater).sortByPriceAse();
                    lv_listView.setAdapter(adpater);

                }else if (filterValue==2){
                    ((HomeLIst_Adapter)adpater).sortByPriceDes();
                    lv_listView.setAdapter(adpater);

                }else if (filterValue==3){
                    ((HomeLIst_Adapter)adpater).sortByExpiryDateAse();
                    lv_listView.setAdapter(adpater);

                }else if (filterValue==4){

                    ((HomeLIst_Adapter)adpater).sortByExpiryDateDes();
                    lv_listView.setAdapter(adpater);
                }

                lv_listView.setSelectionFromTop(position,0);


            }else if (result.getString("status").trim().equalsIgnoreCase("4041")){

                Home_ListScreen_Activity.loadmoreFlage=true;
                lv_listView.removeFooterView(footerView);


            }else /*if (result.getString("status").trim().equalsIgnoreCase("404"))*/{

                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_postlist_alert));

            }





        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

}
