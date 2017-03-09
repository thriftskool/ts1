package com.thriftskool.thriftskool1.gsm_meassge;

import java.util.HashMap;

import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONObject;

import android.app.IntentService;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences.Editor;
import android.net.Uri;
import android.os.PowerManager;
import android.util.Log;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.Utility;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.notification_detail.NotificationMessageDetailScreen_Activity;
import com.thriftskool.thriftskool1.notification_detail.NotificationPostBuzzDetailScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

public class MyIntentService extends IntentService {
							
	@SuppressWarnings("unused")
	private String senderId= Comman.senderId;
	private static int NOTIFICATION_ID = 1;
	private static PowerManager.WakeLock sWakeLock;
	static String TAG = "MyIntentService";
	public static int normalCount;
	HashMap<String,String> hashMap = new HashMap<String,String>();
	Context context;

	 public MyIntentService() {
	        super("MyService");
	        // TODO Auto-generated constructor stub
	    }
	 
    public MyIntentService(String senderId) {
        // senderId is used as base name for threads, etc.
        super(senderId);
        this.senderId = senderId;	
    }
    
    private static final Object LOCK = MyIntentService.class;

    static void runIntentInService(Context context, Intent intent)
	{
    	synchronized(LOCK)
    	{
    		Log.v(TAG, "runIntentInService1");
    		if (sWakeLock == null)
    		{
    			PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
    			sWakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "my_wakelock");
    		}
    	}

    	sWakeLock.acquire();
    	intent.setClassName(context, MyIntentService.class.getName());
    	context.startService(intent);
    	Log.v(TAG, "runIntentInService finish");
    }
    
	@Override
	protected void onHandleIntent(Intent intent) { 
		// TODO Auto-generated method stub
		
		try {

			hashMap = SessionStore.getUserDetails(MyIntentService.this, Comman.PRIFRENS_NAME);

			String action = intent.getAction();
            Log.v(TAG, "onHandleIntent" + action);
            if (action.equals("com.google.android.c2dm.intent.REGISTRATION"))
            {
            	Log.v(TAG, "REGISTRATION");
    			handleRegistration(MyIntentService.this,intent);
    			
    		}
    		else if (action.equals("com.google.android.c2dm.intent.RECEIVE"))
    		{
    			handleMessage(MyIntentService.this,intent);
    			Log.v(TAG, "RECEIVE MESSAGE");
    		}
    		else if (action.equals("com.google.android.c2dm.intent.RETRY")) 
    		{
                GCMMessaging.requestRegistration(MyIntentService.this);
                Log.v(TAG, "RETRY");
            }
        } finally {
            synchronized(LOCK) {
                sWakeLock.release();
            }
        }
	}
	
	private void handleRegistration(Context context, Intent intent)
	{


		String registration = intent.getStringExtra("registration_id");
		
		if (intent.getStringExtra("error") != null)
		{
			// Registration failed, should try again later.
			Log.d("GCM", "registration failed");
			
			String error = intent.getStringExtra("error");
			
			if(error == "SERVICE_NOT_AVAILABLE"){
				Log.d("GCM", "SERVICE_NOT_AVAILABLE");
			}else if(error == "ACCOUNT_MISSING"){
				Log.d("GCM", "ACCOUNT_MISSING");
			}else if(error == "AUTHENTICATION_FAILED"){
				Log.d("GCM", "AUTHENTICATION_FAILED");
			}else if(error == "TOO_MANY_REGISTRATIONS"){
				Log.d("GCM", "TOO_MANY_REGISTRATIONS");
			}else if(error == "INVALID_SENDER"){
				Log.d("GCM", "INVALID_SENDER");
			}else if(error == "PHONE_REGISTRATION_ERROR"){
				Log.d("GCM", "PHONE_REGISTRATION_ERROR");
			}else
			{
				Log.d("GCM", "REGISTRATION_ERROR");
			}
		
			Editor editor = context.getSharedPreferences(Comman.KEY, Context.MODE_PRIVATE).edit();
			editor.putString(Comman.REGISTRATION_KEY, "n/a");
			editor.putString(Comman.ERROR_DESC, error);
			editor.commit();
			
		}
		else if (intent.getStringExtra("unregistered") != null)
		{
			// unregistration done, new messages from the authorized sender will be rejected
			Log.d("GCM", "unregistered");
			
			unregisterWithServer(context);
		}
		else if (registration != null) {

			Log.e("registration...."," "+registration);
			Log.d("GCM registration ! null", registration);
	//		Toast.makeText(this, "GCM registration ! null"+registration, Toast.LENGTH_SHORT).show();
			saveRegistrationId(context,registration);
			
			// Send the registration ID to the 3rd party site that is sending the messages.
			sendRegistrationIdToServer(registration);
			// This should be done in a separate thread.
			// When done, remember that all registration is done.
		}
	}




	private void handleMessage(Context context, Intent intent)
	{
		Log.v("############GCM############","Received message");

		String message = intent.getStringExtra("data");
//        String s=message.toString();


		String data = intent.getExtras().getString("data");
		String type = intent.getStringExtra("type"); 
		String abcd;

		// TODO Send this to my application server to get the real data
		// Lets make something visible to show that we received the message
/*
		Receiver3: Bundle[{notification_type=0, thread_id=46, notification_id=165, user_id=11, id=53, from=166837199692, name=, message=You have new message from 'neham'., collapse_key=do_not_collapse}]
				*/

		Log.v("############GCM##############", "dmControl: message = " + intent.getExtras());

		createNotification(context, intent.getExtras().getString("id"), intent.getExtras().getString("thread_id"), intent.getExtras().getString("notification_type"), intent.getExtras().getString("user_id"), intent.getExtras().getString("name"), intent.getExtras().getString("message"), intent.getExtras().getString("badge"));


		normalCount=Integer.parseInt(intent.getExtras().getString("badge"));

		sessionsCount.save(context, Comman.PRIFRENS_NAME, normalCount);


		Log.e("Count N ", " " + normalCount);

	}


	private void saveRegistrationId(Context context, String registrationId)
	{

		Log.v("GCM saveregistration id", registrationId);
		Comman.DEVICE_REGISTRATION_ID=registrationId;
		Editor editor = context.getSharedPreferences(Comman.KEY, Context.MODE_PRIVATE).edit();
		editor.putString(Comman.REGISTRATION_KEY, registrationId);
		editor.putString(Comman.ERROR_DESC, "null");
		editor.commit(); 
	}


	//public void sendRegistrationIdToServer(String deviceId,String registrationId) 
	public void sendRegistrationIdToServer(String registrationId)
	{
		Log.v("GCM", "Sending registration ID to my application server");

		try
		{

			JSONObject json = new JSONObject();
			json.put("user_id",hashMap.get(SessionStore.USER_ID));
			json.put("gcm_id", registrationId);

			Log.e("Data..."," "+json.toString());

		//	String response = Utility.postRequest(Comman.URL + "update_gcm", json.toString(),context);
			String response = Utility.postReq(Comman.URL + "update_gcm", json.toString(),context);
			Log.e("GCM...."," "+response);

			Log.e("Exception","Send Registration Id to server Response: " + response);

		}
		catch (Exception e)
		{
			Log.e("Exception","Send Registration Id to server Exception: "+e.getMessage());
		}

	}
	
	@SuppressWarnings("deprecation")
	public void createNotification(Context context, String id,String thred_id, String notification_type, String user_id,String name,String message,String Badge)
	{

		NotificationManager notificationManager = (NotificationManager) context
				.getSystemService(Context.NOTIFICATION_SERVICE);
		Notification notification = new Notification(R.mipmap.notification_icon,message, System.currentTimeMillis());
		// Hide the notification after its selected
		notification.flags |= Notification.FLAG_AUTO_CANCEL;

		notification.defaults|=Notification.DEFAULT_SOUND;

		Intent intent =null;

		Log.e("ID",": "+id);
		Log.e("TYPE",": "+notification_type);
		Log.e("Name",": "+name);
		Log.e("Badge",": "+Badge);
		Log.e("Message", ": " + message);

		if (hashMap.get(SessionStore.USER_ID)==null)
		{
			intent = new Intent();
		}
		else if (notification_type.trim().equalsIgnoreCase("0"))
		{
			intent = new Intent(context, NotificationMessageDetailScreen_Activity.class);
		}
		else if (notification_type.trim().equalsIgnoreCase("1") || notification_type.trim().equalsIgnoreCase("2") || notification_type.trim().equalsIgnoreCase("3") || notification_type.trim().equalsIgnoreCase("4"))
		{

			intent = new Intent(context, NotificationPostBuzzDetailScreen_Activity.class);
		}


		intent.putExtra("ID",id);
		intent.putExtra("Name",name);
		intent.putExtra("Notificationtype",notification_type);
		intent.putExtra("UserID",user_id);
		intent.putExtra("ThredId",thred_id);
	//	intent.putExtra("Badge",Badge);

		/*intent = getIntent();
		str_postId = intent.getStringExtra("ID");
		str_userId = intent.getStringExtra("UserID");
		str_thredId = intent.getStringExtra("ThredId");
		str_name = intent.getStringExtra("Name");*/


//		intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
		intent.setFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT);

		intent.setData((Uri.parse("custom://" + System.currentTimeMillis())));
		intent.setAction("actionstring" + System.currentTimeMillis());

		int notif = NOTIFICATION_ID++;
		Log.i("Notif==",""+notif);
    	PendingIntent pendingIntent = PendingIntent.getActivity(context, notif,intent, PendingIntent.FLAG_UPDATE_CURRENT |  PendingIntent.FLAG_ONE_SHOT);

//		PendingIntent pendingIntent = PendingIntent.getActivity(context, notif,intent, PendingIntent.FLAG_ONE_SHOT);
//				intent, PendingIntent.FLAG_CANCEL_CURRENT);
//		notification.setLatestEventInfo(context,"Advertisement received "+message,"Advertisement received "+message, pendingIntent);
		notification.setLatestEventInfo(context, "ThriftSkool", "" + message, pendingIntent);

		notificationManager.notify(notif, notification);

	}


	private void unregisterWithServer(Context context)
	{
		// TODO Auto-generated method stub
		//String deviceId = getDeviceId();

		//connect with 3rd party server and unregister the device
		//TODO: do this on a thread
		try
		{
			Log.d(TAG, "attempting to unregister with 3rd party app server...");
			HttpClient client = new DefaultHttpClient();
			HttpGet request = new HttpGet();
		//	request.setURI(new URI(APP_SERVER_URL + UNREGISTER_URI + "?deviceId=" + deviceId));
			HttpResponse response = client.execute(request);
			StatusLine status = response.getStatusLine();
			if (status == null) 
				throw new IllegalStateException("no status from request");
			if (status.getStatusCode() != 200)
				throw new IllegalStateException(status.getReasonPhrase());
		}
		catch (Exception e)
		{
			Log.e(TAG, "unable to unregister: " + e.getMessage());
			//TODO: notify the user
			return;
		}
		
       //remove local key so app doesn't try to accidentally use it
		GCMMessaging.removeRegistrationId(context);
		
		Log.d(TAG, "succesfully unregistered with 3rd party app server");

	}

}