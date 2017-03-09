package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.InBoxList_Adapter;
import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.campus_buzz_list.CampusBuzzListScreen_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.widgets.TextAwesome;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 21/8/15.
 */
public class InBoxList_AsyncTask  extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ListView lv_listView;
    private List<HomeList_Been> inboxList = new ArrayList<HomeList_Been>();
    TextView tv_alert;
    private String str_start="0",str_end="0";
    private View footerView;
    public int chkValue=1,delValue=1,editValue=1;


    public InBoxList_AsyncTask(Context contex,  List<HomeList_Been> inboxList, ListView lv_listView, TextView tv_alert,View footerView,String start, String end,int delValue,int chkValue,int editValue) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.inboxList = inboxList;
        this.lv_listView =lv_listView;
        this.tv_alert =tv_alert;
        this.footerView = footerView;
        this.delValue=delValue;
        this.chkValue=chkValue;
        this.editValue=editValue;
        str_start = start;
        str_end = end;


        Log.e("Delvalue Asynk"," "+this.delValue);
        Log.e("Selvalue Asynk"," "+this.chkValue);
        Log.e("editValue Asynk"," "+this.editValue);

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


            String response = Utility.postRequest(Comman.URL+"get_threadlist", json.toString(),context);
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

                int position = lv_listView.getFirstVisiblePosition();
                tv_alert.setVisibility(View.GONE);
                //inboxList.clear();
                JSONArray detailArray = result.getJSONArray("Details");


                if (detailArray.length()<10)
                {
                    lv_listView.removeFooterView(footerView);
                    CampusBuzzListScreen_Activity.buzzloadmoreFlage=true;

                }
                else
                {

                    if (str_start.equalsIgnoreCase("0"))
                        lv_listView.addFooterView(footerView);

                    CampusBuzzListScreen_Activity.buzzloadmoreFlage=false;

                }


                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    //imageList.add(result.getString("imagepath")+""+detailItem.getString("image"));
                   // inboxList.add(new HomeList_Been(detailItem.getString("post_id"),detailItem.getString("user_id"),detailItem.getString("post_name"),detailItem.getString("user_name"), detailItem.getString("thread_id"),detailItem.getString("read_status"),detailItem.getString("from_status"),detailItem.getString("create_date"),detailItem.getString("image"),"",result.getString("imagepath"),detailItem.getString("owner_name")));
                    inboxList.add(new HomeList_Been(detailItem.getString("post_id"),detailItem.getString("user_id"),detailItem.getString("post_name"),detailItem.getString("user_name"), detailItem.getString("thread_id"),detailItem.getString("read_status"),"",detailItem.getString("create_date"),detailItem.getString("image"),"",result.getString("imagepath"),detailItem.getString("owner_name"),detailItem.getString("post_namea"),true));

                }

                lv_listView.setAdapter(new InBoxList_Adapter(context,inboxList,delValue,chkValue,editValue));
                lv_listView.setSelectionFromTop(position,0);


            }
            else if (result.getString("status").trim().equalsIgnoreCase("4041"))
            {

                CampusBuzzListScreen_Activity.buzzloadmoreFlage=true;
                lv_listView.removeFooterView(footerView);

            }
            else
            {
                tv_alert.setVisibility(View.VISIBLE);
                tv_alert.setText(context.getString(R.string.blank_mymessagelist_alert));

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception 134: " + e.getMessage());
        }

    }

}
