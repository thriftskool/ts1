package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.Color;
import android.os.AsyncTask;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.searchresult_detail.SearchResultDetailScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by etiloxadmin on 12/9/15.
 */
public class NotificationPostBuzzDetail_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();

    private TextView tv_title,tv_expdate,tv_expday,tv_description, tv_favorite, tv_report, tv_mail, tv_call,  tv_mainTitle, tv_viewCode;
    private String str_value="";


    public NotificationPostBuzzDetail_AsyncTask(Context contex, ArrayList<String> imageList, ViewPager viewpag_viewPager, String str_value, TextView tv_title, TextView tv_expdate, TextView tv_expday, TextView tv_description, TextView tv_favorite, TextView tv_report, TextView tv_mail, TextView tv_call, TextView tv_viewCode) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.imageList = imageList;
        this.viewpag_viewPager =viewpag_viewPager;
        this.tv_title = tv_title;
        this.tv_call= tv_call;
        this.tv_expdate= tv_expdate;
        this.tv_expday= tv_expday;
        this.tv_description= tv_description;
        this.tv_favorite= tv_favorite;
        this.tv_mail= tv_mail;
        this.tv_report= tv_report;
        this.tv_viewCode = tv_viewCode;
        this.tv_title = tv_title;
        this.str_value =str_value;


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


            if (str_value.equalsIgnoreCase("1") || str_value.equalsIgnoreCase("2")){

                json.put("post_id", Integer.parseInt(params[1]));
                json.put("own_uid", Integer.parseInt(params[3]));


            }else if(str_value.equalsIgnoreCase("3") || str_value.equalsIgnoreCase("4")){

                json.put("buzz_id", Integer.parseInt(params[1]));


            }else if(str_value.equalsIgnoreCase("CD")){
                json.put("deal_id", Integer.parseInt(params[1]));

            }






            String response = Utility.postRequest(Comman.URL+params[2], json.toString(),context);
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

                imageList.clear();
                JSONArray detailArray = result.getJSONArray("images");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    imageList.add((result.getString("imagepath")+""+detailItem.getString("image")));
                }

                viewpag_viewPager.setAdapter(new ViewPagerAdapter(context, imageList));


                if (str_value.equalsIgnoreCase("1") || str_value.equalsIgnoreCase("2")){


                    JSONObject detailItem = result.getJSONObject("Details");


                    tv_title.setText("$"+ detailItem.getString("price")+" \n"+detailItem.getString("post_name"));
                    tv_expdate.setText(DateCoversion.getSelectedDate(detailItem.getString("expirydate")));
                    tv_description.setText(detailItem.getString("description"));



                    if (detailItem.getString("status").trim().equalsIgnoreCase("1"))
                    {

                        tv_expday.setText("Expired");

                    }else if (detailItem.getString("status").trim().equalsIgnoreCase("2"))
                    {

                        tv_expday.setText("Close");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), detailItem.getString("expirydate"))==0)
                    {
                        tv_expday.setText("Expire Today");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))==1)
                    {
                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" day");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))<0)
                    {
                        tv_expday.setText("Expired");

                    }else{

                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" days");

                    }

                    if (detailItem.getString("favorite").trim().equalsIgnoreCase("1"))
                    {
                        tv_favorite.setTextColor(Color.parseColor("#57B65B"));
                        tv_favorite.setText(context.getString(R.string.fa_star));
                    }
                    else
                    {
                        tv_favorite.setTextColor(Color.parseColor("#ffffff"));
                        tv_favorite.setText(context.getString(R.string.fa_star_o));
                    }





                }else if (str_value.equalsIgnoreCase("3") || str_value.equalsIgnoreCase("4")){


                    JSONObject detailItem = result.getJSONObject("Details");


                    tv_title.setText(detailItem.getString("buzz_name"));
                    tv_expdate.setText(DateCoversion.getSelectedDate(detailItem.getString("expirydate")));
                    tv_description.setText(detailItem.getString("description"));



                   /* if (detailItem.getString("status").trim().equalsIgnoreCase("1"))
                    {

                        tv_expday.setText("Expired");

                    }else if (detailItem.getString("status").trim().equalsIgnoreCase("2"))
                    {

                        tv_expday.setText("Close");

                    }else */if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), detailItem.getString("expirydate"))==0)
                    {
                        tv_expday.setText("Expire Today");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))==1)
                    {
                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" day");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))<0)
                    {
                        tv_expday.setText("Expired");

                    }else {

                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" days");

                    }



                }else if (str_value.trim().equalsIgnoreCase("CD")){


                    JSONObject detailItem = result.getJSONObject("Details");


                    tv_title.setText(detailItem.getString("deal_name"));
                    tv_expdate.setText(DateCoversion.getSelectedDate(detailItem.getString("expirydate")));
                    tv_description.setText(detailItem.getString("description"));



                   /* if (detailItem.getString("status").trim().equalsIgnoreCase("1"))
                    {

                        tv_expday.setText("Expired");

                    }else if (detailItem.getString("status").trim().equalsIgnoreCase("2"))
                    {

                        tv_expday.setText("Close");

                    }else */if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), detailItem.getString("expirydate"))==0)
                    {
                        tv_expday.setText("Expire Today");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))==1)
                    {
                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" day");

                    }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))<0)
                    {
                        tv_expday.setText("Expired");

                    }else {

                        tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),detailItem.getString("expirydate"))+" days");

                    }

                    SearchResultDetailScreen_Activity.str_viewCode = detailItem.getString("deal_code");
//                    "deal_id":"1","user_id":"11","deal_name":"Deal","description":"Test Deal","deal_code":"0","create_date":"2015-08-30 00:00:00","expirydate":"2015-09-23 00:00:00","image":"1-1.jpg"}}}

                }



            }
            else
            {
                //       Toast.makeText(context, result.getString("message"), Toast.LENGTH_LONG).show();

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }
}
