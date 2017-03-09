package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.graphics.Color;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;

import org.json.JSONObject;

/**
 * Created by etiloxadmin on 31/8/15.
 */
public class PostFavoriteStatus_AsynceTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    TextView tv_favorite;
    String status;


    public PostFavoriteStatus_AsynceTask(Context contex, TextView tv_favorite) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.tv_favorite =tv_favorite;

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


            status = (params[2]);


            JSONObject json = new JSONObject();
            json.put("post_id", Integer.parseInt(params[0]));
            json.put("user_id", Integer.parseInt(params[1]));
            json.put("status", (params[2]));


            String response = Utility.postRequest(Comman.URL+"make_favorite", json.toString(),context);
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


            if (result.getString("status").trim().equalsIgnoreCase("204"))
            {



                if (status.trim().equalsIgnoreCase("1"))
                {
                    tv_favorite.setTextColor(Color.parseColor("#57B65B"));
                    tv_favorite.setText(context.getString(R.string.fa_star));



                    Toast toast= Toast.makeText(context, context.getString(R.string.server_favorite_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();


                }
                else
                {
                    tv_favorite.setTextColor(Color.parseColor("#ffffff"));
                    tv_favorite.setText(context.getString(R.string.fa_star_o));


                    Toast toast=  Toast.makeText(context, context.getString(R.string.server_unfavorite_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();

                }




            }
            else
            {


                Toast toast=  Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
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
