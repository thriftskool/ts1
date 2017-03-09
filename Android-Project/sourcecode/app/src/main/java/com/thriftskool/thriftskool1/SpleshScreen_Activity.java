package com.thriftskool.thriftskool1;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;


import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.gsm_meassge.GCMMessaging;
import com.thriftskool.thriftskool1.home_tab.HomeTabScreen_Activity;
import com.thriftskool.thriftskool1.internet_connection.InterNetConnectionScreen_Activity;
import com.thriftskool.thriftskool1.login.LoginScreen_Activity;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.HashMap;
import java.util.TimeZone;


public class SpleshScreen_Activity extends Activity {

    private HashMap<String, String> hashMap = new HashMap<String, String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Fresco.initialize(SpleshScreen_Activity.this);
        setContentView(R.layout.activity_splesh_screen_);

        hashMap = SessionStore.getUserDetails(SpleshScreen_Activity.this, Comman.PRIFRENS_NAME);

        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);


        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        Log.e("Width","Device Width: "+dm.widthPixels);
        Log.e("Height","Device Height: "+dm.heightPixels);


        TimeZone tz = TimeZone.getDefault();
        System.out.println("TimeZone   " + tz.getDisplayName(false, TimeZone.SHORT) + " Timezon id :: " + tz.getID());

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {

            @Override
            public void run() {
                // TODO Auto-generated method stub

                Intent intent =null;

                if (CheckInterNetConnection.isNetworkAvailable(SpleshScreen_Activity.this))
                {
                    if (hashMap.get(SessionStore.USER_ID)!=null)
                {
                    intent = new Intent(SpleshScreen_Activity.this, HomeTabScreen_Activity.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                    finish();
                }
                else
                {
                    intent = new Intent(SpleshScreen_Activity.this, LoginSignupScreen_Activity.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                    finish();
                }
                }
                else
                {
                    intent = new Intent(SpleshScreen_Activity.this, InterNetConnectionScreen_Activity.class);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                    finish();
                }


            }
        }, 2000);

    }




}
