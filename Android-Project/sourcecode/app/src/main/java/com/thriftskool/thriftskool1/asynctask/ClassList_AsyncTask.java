package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.thriftskool.thriftskool1.been.ClassList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by etiloxadmin on 30/9/16.
 */
public class ClassList_AsyncTask  extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
  //  String URL = "http://thriftskool.com/mobileapps/test_thriftskool/webservice/get_class"; //client url



    public ClassList_AsyncTask(Context contex) {
        // TODO Auto-generated constructor stub

        this.context=contex;

   /*     progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);*/


    }




    @Override
    protected JSONObject doInBackground(String... params) {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {

            String response = Utility.postRequest(Comman.URL+"get_class", context);
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

     /*   if(progressDialog!=null && !progressDialog.isShowing())
        {
            progressDialog.show();
        }*/

    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
      //  progressDialog.dismiss();

        try
        {

            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {
                LoginSignupScreen_Activity.class_List=new ArrayList<>();
                LoginSignupScreen_Activity.classList_2=new ArrayList<String>();

                JSONArray jsonArray=result.getJSONArray("Details");

                for (int i=0;i<=jsonArray.length();i++)
                {
                    JSONObject object=jsonArray.getJSONObject(i);

                    ClassList_Been doc = new ClassList_Been();

                    String class_id = object.getString("int_glcode");
                    String class_name = object.getString("class_name");

                    doc.setClass_name(class_name);
                    doc.setInt_glcode(class_id);

                    LoginSignupScreen_Activity.class_List.add(doc);
                   // LoginSignupScreen_Activity.class_List.add(new ClassList_Been(object.getString("int_glcode"),object.getString("class_name")))
                    LoginSignupScreen_Activity.classList_2.add(class_name);
                }

                Log.e("List of class size...."," "+LoginSignupScreen_Activity.class_List.size());
            }
            else
            {


                Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
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
