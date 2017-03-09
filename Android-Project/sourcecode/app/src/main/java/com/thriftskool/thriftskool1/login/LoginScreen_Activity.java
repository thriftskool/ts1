package com.thriftskool.thriftskool1.login;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.ForgotPassword_AsynkTask;
import com.thriftskool.thriftskool1.asynctask.ForgotUsurname_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.Login_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ViewDealCodeCount_AsynckTask;
import com.thriftskool.thriftskool1.campus_deal_detail.CampusDealDetail_Tab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.widgets.EditTextMyriadProRegular;

public class LoginScreen_Activity extends Activity implements View.OnClickListener{

    private EditText et_username, et_password, et_forgotpass;
    private TextView tv_login, tv_forgotpassword, tv_forgotUserName, tv_submit;
    private ImageView iv_logo;
    private  Dialog dialog=null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login_screen_);

        maping();
    }


    //****************** Maping *****************************************************************************************************************************************************************

    private void maping()
    {

        //EditText maping
        et_username = (EditText)findViewById(R.id.LoginScreen_userName);
        et_password= (EditText)findViewById(R.id.LoginScreen_password);

        //Button Maping
        tv_login = (TextView)findViewById(R.id.LoginScreen_submit);
        tv_forgotpassword = (TextView)findViewById(R.id.LoginScreen_ForgotPassword);
        tv_forgotUserName = (TextView)findViewById(R.id.LoginScreen_ForgotUserName);



        iv_logo = (ImageView)findViewById(R.id.LoginScreen_logo);

        Picasso.with(LoginScreen_Activity.this).load(R.drawable.logo).into(iv_logo);

        tv_login.setOnClickListener(LoginScreen_Activity.this);
        tv_forgotpassword.setOnClickListener(LoginScreen_Activity.this);
        tv_forgotUserName.setOnClickListener(LoginScreen_Activity.this);

    }


    //******** On Click *************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {



        ///Switch Case
        switch(v.getId())
        {

            case R.id.LoginScreen_submit:

                if (!(et_username.getText().toString().trim()).equalsIgnoreCase(""))
                {
                    if (!et_password.getText().toString().trim().equalsIgnoreCase(""))
                    {
                        if (isValidEmail(et_username.getText().toString().trim()))
                        {
                            if (CheckInterNetConnection.isNetworkAvailable(LoginScreen_Activity.this))
                            {

                                Login_AsyncTask login = new Login_AsyncTask(LoginScreen_Activity.this);
                                login.execute(et_username.getText().toString().trim(),et_password.getText().toString().trim(),"");
                            }
                            else
                            {

                                new AlertDialog.Builder(LoginScreen_Activity.this)
                                        .setTitle("Alert!")
                                        .setMessage(getString(R.string.internetconnection_alert))
                                        .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                            }
                                        }).show();

                            }
                        }else{
                            Toast toast=Toast.makeText(LoginScreen_Activity.this, getString(R.string.invalideemailid_alert_signupscreen), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER,0,0);
                            toast.show();
                        }
                    }
                    else
                    {
                        Toast toast=Toast.makeText(LoginScreen_Activity.this, getString(R.string.blank_password_alert), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }
                }
                else
                {
                    Toast toast=Toast.makeText(LoginScreen_Activity.this, getString(R.string.blank_email_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();
                }


                break;



            case R.id.LoginScreen_ForgotPassword:

                showPopup(0);


                break;


            case R.id.LoginScreen_ForgotUserName:

                showPopup(1);


                break;





        }
    }


    //**************** Popup ***********************************************************************************************************************************************************************
    private void showPopup(final int value)
    {

        Log.e("fsdfsdf","INT INT INT : "+value);
       // RelativeLayout ll_layout;

        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.forgotpassusername_popup, null);
        dialog = new Dialog(LoginScreen_Activity.this);

        tv_submit = (TextView)view.findViewById(R.id.ForgotPassUser_Popup_submit);
        et_forgotpass = (EditText)view.findViewById(R.id.ForgotPassUser_Popup_Email);

       // ll_layout = (RelativeLayout)view.findViewById(R.id.ForgotPassUser_Popup);

        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        WindowManager.LayoutParams wmlp = dialog.getWindow().getAttributes();


        dialog.setContentView(view);

        wmlp.width = WindowManager.LayoutParams.MATCH_PARENT;
        wmlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        wmlp.gravity = Gravity.CENTER;
        wmlp.x = 0;   //x position
        wmlp.y = 0;



       // ll_layout.setAlpha((float)0.5);

        dialog.show();


        tv_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (!et_forgotpass.getText().toString().trim().equalsIgnoreCase(""))
                {

                    if (isValidEmail(et_forgotpass.getText().toString().trim()))
                    {

                        if (CheckInterNetConnection.isNetworkAvailable(LoginScreen_Activity.this))
                        {


                            if (value == 0)
                            {

                                ForgotPassword_AsynkTask passforgot = new ForgotPassword_AsynkTask(LoginScreen_Activity.this);
                                passforgot.execute(et_forgotpass.getText().toString().trim());

                            }
                            else
                            {

                                ForgotUsurname_AsyncTask userforgot = new ForgotUsurname_AsyncTask(LoginScreen_Activity.this);
                                userforgot.execute(et_forgotpass.getText().toString().trim());

                            }

                            dialog.dismiss();

                        }
                        else
                        {

                            new AlertDialog.Builder(LoginScreen_Activity.this)
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

                        Toast toast=Toast.makeText(LoginScreen_Activity.this, getString(R.string.invalideemailid_alert_signupscreen), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();
                    }


                } else {


                    Toast toast= Toast.makeText(LoginScreen_Activity.this, getString(R.string.blank_email_alert), Toast.LENGTH_SHORT);
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
        Intent intent = new Intent(LoginScreen_Activity.this, LoginSignupScreen_Activity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

        finish();

    }



    //*********** Email Address Validity Method *************************************************************************************************************************************************

    public final static boolean isValidEmail(CharSequence target) {
        return !TextUtils.isEmpty(target) && android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
    }


}
