package com.thriftskool.thriftskool1.gsm_meassge;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class GCMReceiver extends BroadcastReceiver
{
	Context context;
	String TAG = "GCM receiver";
	
	@Override
	public void onReceive(Context context, Intent intent) {
		
		Log.v(TAG, "Registration Receiver called");

		Log.v("#############"+TAG+"###############", "Receiver3: "+intent.getStringExtra("notification_type"));
		Log.v("#############"+TAG+"###############", "Receiver3: "+intent.getExtras());



		this.context = context;
		
		MyIntentService.runIntentInService(context, intent);
        setResult(Activity.RESULT_OK, null, null);
		

	}

	
}
