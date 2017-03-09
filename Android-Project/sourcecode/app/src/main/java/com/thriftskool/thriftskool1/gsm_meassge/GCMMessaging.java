package com.thriftskool.thriftskool1.gsm_meassge;

import com.thriftskool.thriftskool1.comman.Comman;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.util.Log;

public class GCMMessaging {
	
	private static final long DEFAULT_BACKOFF = 30000;
	public static final String BACKOFF = "backoff";
	static final String PREFERENCE = "exp_back_off";
	static String tag = "Messaging class";
	
	static long getBackoff(Context context) {
        final SharedPreferences prefs = context.getSharedPreferences(
                PREFERENCE,
                Context.MODE_PRIVATE);
        return prefs.getLong(BACKOFF, DEFAULT_BACKOFF);
    }
   
    static void setBackoff(Context context, long backoff) {
        final SharedPreferences prefs = context.getSharedPreferences(
                PREFERENCE,
                Context.MODE_PRIVATE);
        Editor editor = prefs.edit();
        editor.putLong(BACKOFF, backoff);
        editor.commit();
    }
	
    public static void requestRegistration(Context context) {
		// TODO Auto-generated method stub
		
		Log.v(tag, "requestRegistrationId method called sender id");
		
		//Intent intent = new Intent("com.google.android.c2dm.intent.REGISTER");
		Intent intent = new Intent("com.google.android.c2dm.intent.REGISTER");
		
		intent.putExtra("app",PendingIntent.getBroadcast(context, 0, new Intent(), 0));
		// Sender id - project ID generated when signing up
		intent.putExtra("sender", Comman.senderId);
		intent.putExtra("os_type", "android");
								   
		context.startService(intent);
	}
	
	public static String getRegistrationId(Context context) {
		SharedPreferences prefs = context.getSharedPreferences(Comman.KEY,Context.MODE_PRIVATE);
		String registraionId = prefs.getString(Comman.REGISTRATION_KEY, "n/a");
		return registraionId;
	}

	public static void removeRegistrationId(Context context) {
	
		SharedPreferences settings = context.getSharedPreferences(Comman.KEY,Context.MODE_PRIVATE);
		Editor edit = settings.edit();
		edit.putString(Comman.REGISTRATION_KEY, "n/a"); // registration id
		edit.commit(); //apply
	
	}
}
