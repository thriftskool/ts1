package com.thriftskool.thriftskool1.contact_aap_admin;


import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.ContectUs_AsyncTask;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.HashMap;

public class ContactAppAdminScreen_Activity extends Activity {


    private EditText et_message;
    private TextView tv_send,tv_title, tv_back, tv_save, tv_text,tv_countNotification;
    private HashMap<String,String> hashMap = new HashMap<String,String>();
    private Intent intent;
    private  String str_ID="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reply_message_screen_);


        hashMap = SessionStore.getUserDetails(ContactAppAdminScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();
    }


    //*************** Maping    *************************************************************************************************************************************************************

    private void maping()
    {

        et_message = (EditText)findViewById(R.id.ReplyMessageScreen_Massage);
        tv_text = (TextView)findViewById(R.id.ReplyMessageScreen_text);
        tv_send = (TextView)findViewById(R.id.ReplyMessageScreen_send);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);


        tv_countNotification.setVisibility(View.INVISIBLE);
        tv_title.setText("CONTACT US");
        tv_save.setVisibility(View.INVISIBLE);
        tv_text.setVisibility(View.VISIBLE);


        tv_send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (!et_message.getText().toString().trim().equalsIgnoreCase(""))
                {

                    if (CheckInterNetConnection.isNetworkAvailable(ContactAppAdminScreen_Activity.this))
                    {

                        ContectUs_AsyncTask reply = new ContectUs_AsyncTask(ContactAppAdminScreen_Activity.this);
                        reply.execute(hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.USER_NAME),hashMap.get(SessionStore.USER_EMAIL), et_message.getText().toString().trim(), DateCoversion.getCurrentData());



                    }
                    else
                    {

                        new AlertDialog.Builder(ContactAppAdminScreen_Activity.this)
                                .setTitle("Alert!")
                                .setMessage(getString(R.string.internetconnection_alert))
                                .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {



                                    }
                                }).show();


                    }


                }
                else
                {

                    Toast toast=  Toast.makeText(ContactAppAdminScreen_Activity.this, "Message can not be blank.", Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();

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

    @Override
    protected void onResume() {
        super.onResume();
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);


        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;
        hashMap = SessionStore.getUserDetails(ContactAppAdminScreen_Activity.this, Comman.PRIFRENS_NAME);
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(ContactAppAdminScreen_Activity.this);
    }

}
