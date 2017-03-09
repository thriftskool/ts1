package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.OwnerDetails_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.view_profile.ViewProfileScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by etiloxadmin on 30/9/16.
 */
public class OwnerProfileView_AsyncTask  extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    ImageView iv_ownerIMG;
   // String URL = "http://thriftskool.com/mobileapps/test_thriftskool/webservice/post_owner_detail"; //client url
    TextView tv_username,tv_class,tv_ownername;


    public OwnerProfileView_AsyncTask(Context contex,TextView tv_username,TextView tv_class,TextView tv_ownername,ImageView iv_ownerIMG) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.tv_username=tv_username;
        this.tv_class=tv_class;
        this.tv_ownername=tv_ownername;
        this.iv_ownerIMG=iv_ownerIMG;

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
            json.put("owner_id", Integer.parseInt(params[0]));

            String response = Utility.postRequest(Comman.URL+"post_owner_detail",json.toString() ,context);
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
                ViewProfileScreen_Activity.OwnderPostList=new ArrayList<>();
                ViewProfileScreen_Activity.OwnderPostList.clear();

                ViewProfileScreen_Activity.OwnderDetailsList=new ArrayList<>();
                ViewProfileScreen_Activity.OwnderDetailsList.clear();


                ViewProfileScreen_Activity.OwnderDetailsList.add(new OwnerDetails_Been(result.getString("var_username"), result.getString("profile_img"), result.getString("person_name"), result.getString("class_name"), result.getString("imagepath")));

                if (result.getString("class_name").equalsIgnoreCase("Select") || result.getString("class_name").equalsIgnoreCase("0")|| result.getString("class_name").equalsIgnoreCase("") || result.getString("class_name").equalsIgnoreCase("null"))
                {

                }
                else
                {
                    tv_class.setVisibility(View.VISIBLE);
                    tv_class.setText(result.getString("class_name"));
                }
                if (result.getString("person_name").equalsIgnoreCase("") || result.getString("person_name").equalsIgnoreCase("null"))
                {

                }
                else
                {
                    tv_username.setVisibility(View.VISIBLE);
                    tv_username.setText(result.getString("person_name"));
                }

                tv_ownername.setText(result.getString("var_username"));


                ViewProfileScreen_Activity.Dialog_imh=result.getString("imagepath")+result.getString("profile_img");

                Log.e("Profile imag poster..","  "+result.getString("imagepath")+result.getString("profile_img"));

                Picasso.with(context).load(result.getString("imagepath")+result.getString("profile_img")).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(iv_ownerIMG);

                JSONArray resultJSONArray=result.getJSONArray("Details");
                Log.e("Post array...", " " + resultJSONArray.toString());

                final int numberOfItemsInResp = resultJSONArray.length();
                for (int j=0;j<=numberOfItemsInResp;j++)
                {
                    JSONObject detailItem = resultJSONArray.getJSONObject(j);

                   if (detailItem.getString("status").equals("1") || DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), detailItem.getString("expiredate").trim())<0)
                   {

                   }
                    else
                   {
                       ViewProfileScreen_Activity.OwnderPostList.add(new HomeList_Been(detailItem.getString("post_id"), detailItem.getString("user_id"), detailItem.getString("post_name"), detailItem.getString("description"), detailItem.getString("price"), detailItem.getString("status"), detailItem.getString("favorite"), detailItem.getString("expiredate"), detailItem.getString("image"), detailItem.getString("image_id"), result.getString("imagepath"), "", "", true));
                   }
                }

            }
            else
            {


                Toast toast = Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();


            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }
}
