package com.thriftskool.thriftskool1.changepassword;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.CHnagePassword_AsyncTask;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import org.w3c.dom.Text;

import java.util.HashMap;

public class ChangePasswordScreen_Activity extends Activity {

    private TextView tv_back, tv_title, tv_save, tv_changePassword,tv_countNotification;
    private EditText et_oldPassword, et_newPassword, et_confirmPassword;
    HashMap<String, String>  hashMap = new HashMap<String, String>();
    HashMap<String, String> hasMapcount = new HashMap<String, String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_change_password_screen_);


        hashMap = SessionStore.getUserDetails(ChangePasswordScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(ChangePasswordScreen_Activity.this, Comman.PRIFRENS_NAME);
        maping();



    }


    //*********** Maping ********************************************************************************************************************************************************************

    private void maping()
    {

        //TextView
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_changePassword = (TextView)findViewById(R.id.ChangePasswordScreen_ChangePassword);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //EditText
        et_oldPassword = (EditText)findViewById(R.id.ChangePasswordScreen_OldPassword);
        et_newPassword = (EditText)findViewById(R.id.ChangePasswordScreen_NewPassword);
        et_confirmPassword = (EditText)findViewById(R.id.ChangePasswordScreen_ConfirmPassword);



        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)
        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }

        tv_title.setText(getString(R.string.title_changepasswordscreen));


        tv_save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(ChangePasswordScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


            }
        });

        tv_changePassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (!et_oldPassword.getText().toString().trim().equalsIgnoreCase(""))
                {
                    if (!et_newPassword.getText().toString().trim().equalsIgnoreCase(""))
                    {
                        if (!et_confirmPassword.getText().toString().trim().equalsIgnoreCase(""))
                        {
                            if (et_newPassword.getText().toString().trim().equalsIgnoreCase(et_confirmPassword.getText().toString().trim()))
                            {

                                if (CheckInterNetConnection.isNetworkAvailable(ChangePasswordScreen_Activity.this))
                                {


                                    CHnagePassword_AsyncTask pass = new CHnagePassword_AsyncTask(ChangePasswordScreen_Activity.this);
                                    pass.execute(hashMap.get(SessionStore.USER_ID), et_oldPassword.getText().toString().trim(),et_newPassword.getText().toString().trim());

                                }
                                else
                                {

                                    new AlertDialog.Builder(ChangePasswordScreen_Activity.this)
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


                                Toast toast=Toast.makeText(ChangePasswordScreen_Activity.this, getString(R.string.blank_newoldpassmatch_alert), Toast.LENGTH_SHORT);
                                toast.setGravity(Gravity.CENTER,0,0);
                                toast.show();


                            }

                        }
                        else
                        {


                            Toast toast=Toast.makeText(ChangePasswordScreen_Activity.this, getString(R.string.blank_confirmnewpassword_alert), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER,0,0);
                            toast.show();
                        }

                    }
                    else
                    {

                        Toast toast=Toast.makeText(ChangePasswordScreen_Activity.this, getString(R.string.blank_newpassword_alert), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();

                    }

                }
                else
                {


                    Toast toast= Toast.makeText(ChangePasswordScreen_Activity.this, getString(R.string.blank_oldpassword_alert), Toast.LENGTH_SHORT);
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
        hashMap = SessionStore.getUserDetails(ChangePasswordScreen_Activity.this, Comman.PRIFRENS_NAME);
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(ChangePasswordScreen_Activity.this);
    }

}
