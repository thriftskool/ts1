package com.thriftskool.thriftskool1.profile;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.Login_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.SignIn_AsyncTask;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;

/**
 * Created by etiloxadmin on 30/8/15.
 */
public class SignInScreen_Activity extends Activity implements View.OnClickListener{

    private EditText et_username, et_password;
    private TextView tv_login, tv_forgotpassword, tv_forgotUserName;

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




        tv_login.setOnClickListener(SignInScreen_Activity.this);
        tv_forgotpassword.setOnClickListener(SignInScreen_Activity.this);
        tv_forgotUserName.setOnClickListener(SignInScreen_Activity.this);

    }


    //******** On Click *************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {

        Log.e("Status", " Status: ");
        ///Switch Case
        switch(v.getId())
        {

            case R.id.LoginScreen_submit:

                if (!(et_username.getText().toString().trim()).equalsIgnoreCase(""))
                {
//                if (isValidEmail(et_username.getText().toString().trim()))
//                {
                    if (!et_password.getText().toString().trim().equalsIgnoreCase(""))
                    {

                        SignIn_AsyncTask login = new SignIn_AsyncTask(SignInScreen_Activity.this);
                        login.execute(et_username.getText().toString().trim(),et_password.getText().toString().trim(),"5");

                    }
                    else
                    {
                        Toast.makeText(SignInScreen_Activity.this, getString(R.string.blankpassword_alert_loginscreen), Toast.LENGTH_SHORT).show();
                    }


//                }
//                else
//                {
//                    Toast.makeText(SignInScreen_Activity.this,getString(R.string.invalideemailid_alert_signupscreen),Toast.LENGTH_SHORT).show();
//                }
                }
                else
                {
                    Toast.makeText(SignInScreen_Activity.this,getString(R.string.blankemail_alert_loginscreen),Toast.LENGTH_SHORT).show();
                }


                break;



            case R.id.LoginScreen_ForgotPassword:



                break;


            case R.id.LoginScreen_ForgotUserName:



                break;





        }
    }





    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

    }




    //*********** Email Address Validity Method *************************************************************************************************************************************************

    public final static boolean isValidEmail(CharSequence target) {
        return !TextUtils.isEmpty(target) && android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
    }
}
