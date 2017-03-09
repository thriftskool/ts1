package com.thriftskool.thriftskool1.create_new_university;

import android.app.Activity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.CreatenewUniversity_AsyncTask;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.session.SessionStore;

public class CreaneNewUniversityScreen_Activity extends Activity implements View.OnClickListener{

    private TextView tv_title, tv_save,tv_send,tv_countNotification;
    private EditText et_name, et_email;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_creane_new_university_screen_);

        maping();
    }

    //********** Maping **************************************************************************************************************************************************************************
    private void maping()
    {

        //textview
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_send = (TextView)findViewById(R.id.CreateNewUnivercityScreen_Send);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //EditText
        et_email = (EditText)findViewById(R.id.CreateNewUnivercityScreen_ContactEmailAdd);
        et_name = (EditText)findViewById(R.id.CreateNewUnivercityScreen_Name);

        setValue();


    }


    //************** setValue *********************************************************************************************************************************************************************
    private void setValue()
    {
        tv_countNotification.setVisibility(View.INVISIBLE);
        tv_title.setText(getString(R.string.title_createnewuniversityscreen));

        tv_send.setOnClickListener(CreaneNewUniversityScreen_Activity.this);
    }


    //********** onClick *********************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {

        switch (v.getId()){

            case R.id.CreateNewUnivercityScreen_Send:

                if (!et_name.getText().toString().trim().equalsIgnoreCase("")){


                    if (!et_email.getText().toString().trim().equalsIgnoreCase("")){


                        if (isValidEmail(et_email.getText().toString().trim())){

                            CreatenewUniversity_AsyncTask create =  new CreatenewUniversity_AsyncTask(CreaneNewUniversityScreen_Activity.this);
                            create.execute(et_name.getText().toString().trim(), et_email.getText().toString().trim(), DateCoversion.getUTCDateTime());

                        }else{



                            Toast toast=  Toast.makeText(CreaneNewUniversityScreen_Activity.this, getString(R.string.invalideemailid_alert_signupscreen), Toast.LENGTH_SHORT);
                            toast.setGravity(Gravity.CENTER,0,0);
                            toast.show();

                        }



                    }else{



                        Toast toast= Toast.makeText(CreaneNewUniversityScreen_Activity.this, getString(R.string.blank_universitycontactemail_alert), Toast.LENGTH_SHORT);
                        toast.setGravity(Gravity.CENTER,0,0);
                        toast.show();

                    }



                }else{



                    Toast toast= Toast.makeText(CreaneNewUniversityScreen_Activity.this, getString(R.string.blank_universityname_alert), Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();

                }



                break;






        }///end of switch




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


    }

    //*********** Email Address Validity Method *************************************************************************************************************************************************

    public final static boolean isValidEmail(CharSequence target) {
        return !TextUtils.isEmpty(target) && android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(CreaneNewUniversityScreen_Activity.this);
    }

}
