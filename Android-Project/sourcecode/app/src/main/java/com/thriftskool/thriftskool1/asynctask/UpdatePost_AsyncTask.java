package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Created by etiloxadmin on 21/8/15.
 */
public class UpdatePost_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private SquareImageView photo1,photo2,photo3,photo4;
    private TextView tv_chooseCategoty, tv_expiryDate, tv_mainTitle, tv_back, tv_save;
    private EditText et_title, et_description, et_price;





    public UpdatePost_AsyncTask(Context contex) {
        // TODO Auto-generated constructor stub

        this.context=contex;

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







            String response = Utility.postRequest(Comman.URL + "post_update", params[0].toString(),context);
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

            /*JSONArray jj = result.getJSONArray("status");

            for (int i=0; i<jj.length();i++)
            {

                JSONObject kk = jj.getJSONObject(i);

                Log.e("Image","ID: "+kk.getString("image_id"));
                Log.e("Image","Title: "+kk.getString("title"));
                Log.e("Image","Image: "+kk.getString("image"));

            }
*/




            if (result.getString("status").trim().equalsIgnoreCase("204"))
            {




                Toast toast=Toast.makeText(context, context.getString(R.string.server_editpost_alert), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();


                ((Activity)context).finish();








            }
            else
            {

                Toast toast=Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
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



