package com.thriftskool.thriftskool1.internet_connection;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.BuzzReportCount_AsyncTask;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_tab.HomeTabScreen_Activity;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.HashMap;

public class InterNetConnectionScreen_Activity extends Activity {

    private TextView tv_tryAgain;
    private HashMap<String, String> hashMap = new HashMap<String, String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_inter_net_connection_screen_);

        hashMap = SessionStore.getUserDetails(InterNetConnectionScreen_Activity.this, Comman.PRIFRENS_NAME);

        tv_tryAgain = (TextView)findViewById(R.id.InternetConnectionScreen_tryAgain);


        tv_tryAgain.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (CheckInterNetConnection.isNetworkAvailable(InterNetConnectionScreen_Activity.this))
                {

                    Intent intent =null;


                    if (hashMap.get(SessionStore.USER_ID)!=null)
                    {
                        intent = new Intent(InterNetConnectionScreen_Activity.this, HomeTabScreen_Activity.class);
                        startActivity(intent);
                        overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                        finish();


                    }
                    else
                    {
                        intent = new Intent(InterNetConnectionScreen_Activity.this, LoginSignupScreen_Activity.class);
                        startActivity(intent);
                        overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                        finish();

                    }

                }
                else
                {

                    new AlertDialog.Builder(InterNetConnectionScreen_Activity.this)
                            .setTitle("!Alert")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {


                                }
                            }).show();


                }





            }
        });

    }


    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

    }

}
