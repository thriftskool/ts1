package com.thriftskool.thriftskool1.asynctask;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import com.splunk.mint.Mint;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.MyHttpClient;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.gsm_meassge.GCMMessaging;
import com.thriftskool.thriftskool1.home_tab.HomeTabScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Login_AsyncTask extends AsyncTask<String, Integer, JSONObject>{

	ProgressDialog progressDialog;
	Context context;
	JSONObject jsonresponse;
	String result="";

	public Login_AsyncTask(Context contex)
	{
		// TODO Auto-generated constructor stub

		this.context=contex;
		progressDialog = new ProgressDialog(contex);
		progressDialog.setMessage("Please wait...");
		progressDialog.setCancelable(false);

	}

	
	@Override
	protected JSONObject doInBackground(String... params)
	{
		// TODO Auto-generated method stub



		try
		{

			JSONObject json = new JSONObject();

			json.put("username", params[0]);
			json.put("password", params[1]);
			json.put("device_id", params[2]);

			Log.e("Data", "  " + json.toString());

			String response = Utility.postRequest(Comman.URL + "login", json.toString(),context);

			JSONObject jObject = new JSONObject(response);
			jsonresponse = jObject.getJSONObject("Response");


		}
		catch(Exception e)
		{
			e.getStackTrace();
			Log.e("Excaption LOGIN. ", "  " + e.getMessage());
		}

		Log.e("JSON.... ", "  "+jsonresponse);

		return jsonresponse;

	}

	@Override
	protected void onPreExecute()
	{
		// TODO Auto-generated method stub
		super.onPreExecute();

		if(progressDialog!=null && !progressDialog.isShowing())
		{
			progressDialog.show();
		}
	}

	@Override
	protected void onPostExecute(JSONObject result)
	{
		// TODO Auto-generated method stub
		super.onPostExecute(result);

		try
		{

			if (result.getString("status").trim().equalsIgnoreCase("200"))
			{
				Log.e("Msg Result ", " " + result);

				GCMMessaging.requestRegistration(context);



				Toast toast= Toast.makeText(context, context.getString(R.string.server_successfullogin_alert), Toast.LENGTH_SHORT);
				toast.setGravity(Gravity.CENTER, 0, 0);
				toast.show();


				SessionStore.save(context, Comman.PRIFRENS_NAME, result.getString("login_id"), result.getString("university_id"), result.getString("user_name"), result.getString("university_name"), result.getString("imagepath") + "" + result.getString("university_image"), result.getString("email_id"), result.getString("profile_img"), result.getString("class"),result.getString("profileimgpath"),result.getString("person_name"));

				Mint.initAndStartSession(context, "be9fd6c7");
				Mint.setUserIdentifier(result.getString("user_name"));

				Intent intent = new Intent(context, HomeTabScreen_Activity.class);
				context.startActivity(intent);
				((Activity) context).finish();

			}
			else if (result.getString("status").trim().equalsIgnoreCase("400")){



				Toast toast= Toast.makeText(context, context.getString(R.string.server_badrequest_alert), Toast.LENGTH_SHORT);
				toast.setGravity(Gravity.CENTER,0,0);
				toast.show();

			}else if (result.getString("status").trim().equalsIgnoreCase("404")){


				Toast toast= Toast.makeText(context, context.getString(R.string.server_invalididpasslogin_alert), Toast.LENGTH_SHORT);
				toast.setGravity(Gravity.CENTER,0,0);
				toast.show();

			}else if (result.getString("status").trim().equalsIgnoreCase("4011")){

				//Toast.makeText(context,context.getString(R.string.server_veryfielogin_alert), Toast.LENGTH_LONG).show();
				new AlertDialog.Builder(context)
						.setTitle(context.getString(R.string.alert_title))
						.setMessage(context.getString(R.string.server_veryfielogin_alert))
						.setNeutralButton("Ok", new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog, int which) {

							}
						}).show();

			}else if (result.getString("status").trim().equalsIgnoreCase("401")){


				Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
				toast.setGravity(Gravity.CENTER,0,0);
				toast.show();

			}

		}
		catch(Exception e)
		{

			e.getStackTrace();
		}

		progressDialog.dismiss();

		}

}