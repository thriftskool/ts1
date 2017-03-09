package com.thriftskool.thriftskool1.my_post_list_detail;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.asynctask.CampusBuzzDetailsViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ChangeBuzzStatus_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ChangeStatus_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.HomeListDetailViewPager_AsyncTask;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.edit_buzz.EditBuzz_Tab_Activity;
import com.thriftskool.thriftskool1.edit_post.EditPost_Tab_Activity;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class MyPostListDetailScreen_Activity extends Activity implements View.OnClickListener{


    private TextView tv_title,tv_expdate,tv_expday, tv_description, tv_id, tv_favorite, tv_report, tv_mail, tv_call,tv_countNotification;
    private TextView tv_back, tv_headertitle, tv_save,tv_profile;
    private ViewPager viewpag_viewPager;
    private LinearLayout ll_mailcallLayout;
    private ArrayList<String> imageList = new ArrayList<String>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private FrameLayout fram_layout;

    private Dialog dialog;
    private int filterflage=0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_list_detail_screen_);

        hashMap = SessionStore.getUserDetails(MyPostListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(MyPostListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();

    }



    //*********************** Maping **********************************************************************************************************************************************************

    private void maping()
    {


        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_headertitle= (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);



        tv_title = (TextView)findViewById(R.id.HomelistDetailScreen_title);
        tv_expdate= (TextView)findViewById(R.id.HomelistDetailScreen_expDate);
        tv_expday= (TextView)findViewById(R.id.HomelistDetailScreen_expDay);
        tv_description= (TextView)findViewById(R.id.HomelistDetailScreen_description);
        tv_favorite= (TextView)findViewById(R.id.HomelistDetailScreen_favorite);
        tv_report= (TextView)findViewById(R.id.HomelistDetailScreen_report);
        tv_mail= (TextView)findViewById(R.id.HomelistDetailScreen_mail);
        tv_call= (TextView)findViewById(R.id.HomelistDetailScreen_call);
        tv_profile=(TextView)findViewById(R.id.HomelistDetailScreen_profile);

        ll_mailcallLayout= (LinearLayout)findViewById(R.id.HomelistDetailScreen_mailcallLayOut);
      //  fram_layout = (FrameLayout)findViewById(R.id.HomelistDetailScreen_viewPagerFram);

        viewpag_viewPager = (ViewPager)findViewById(R.id.HomelistDetailScreen_viewPager);



    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue()
    {

        tv_profile.setVisibility(View.GONE);

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }

      /*  LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(Comman.DEVICE_WIDTH, Comman.DEVICE_WIDTH/2);
        fram_layout.setLayoutParams(lp);
*/
        if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz")) {

            tv_call.setText(getString(R.string.call_mypostdetailscreenBuzz));
            tv_call.setTextColor(Color.parseColor("#373837"));
            tv_call.setVisibility(View.VISIBLE);

            tv_report.setVisibility(View.INVISIBLE);
            tv_favorite.setVisibility(View.GONE);
        }
        else
        {
            tv_call.setText(getString(R.string.call_mypostdetailscreenPost));
            tv_call.setTextColor(Color.parseColor("#373837"));
            tv_call.setVisibility(View.VISIBLE);

            tv_report.setVisibility(View.INVISIBLE);
            tv_favorite.setVisibility(View.GONE);
        }

        if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz"))
        {
            tv_title.setText(MyPostListDetail_Tab_Activity.str_title);
            ll_mailcallLayout.setVisibility(View.VISIBLE);
            tv_headertitle.setText("Buzz DETAILS");
            tv_mail.setText(getString(R.string.emailbuzz_mypostdetailscreen));


        }else{
            tv_title.setText(MyPostListDetail_Tab_Activity.str_title);
            ll_mailcallLayout.setVisibility(View.VISIBLE);
            tv_headertitle.setText("POST DETAILS");
            tv_mail.setText(getString(R.string.email_mypostdetailscreen));

        }
        tv_expdate.setText("$"+ MyPostListDetail_Tab_Activity.str_price);
      //  tv_expdate.setText(DateCoversion.getSelectedDate(MyPostListDetail_Tab_Activity.str_expDate));
       // tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),MyPostListDetail_Tab_Activity.str_expDate)+" days");
        tv_description.setText(MyPostListDetail_Tab_Activity.str_description);



        if (MyPostListDetail_Tab_Activity.str_userId.equalsIgnoreCase("0")){

            tv_favorite.setVisibility(View.GONE);
        }



        if (MyPostListDetail_Tab_Activity.str_status.trim().equalsIgnoreCase("1"))
        {

            tv_expday.setText("Expired");

        }else if (MyPostListDetail_Tab_Activity.str_status.trim().equalsIgnoreCase("2"))
        {

            tv_expday.setText("Closed");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), MyPostListDetail_Tab_Activity.str_expDate)==0)
        {
            tv_expday.setText("Expire Today");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),MyPostListDetail_Tab_Activity.str_expDate)==1)
        {
            tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),MyPostListDetail_Tab_Activity.str_expDate)+" day");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), MyPostListDetail_Tab_Activity.str_expDate)<0){

            tv_expday.setText("Expired");


        }else {

            tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),MyPostListDetail_Tab_Activity.str_expDate)+" days");

        }


        if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz"))
        {
            CampusBuzzDetailsViewPager_AsyncTask buzz = new CampusBuzzDetailsViewPager_AsyncTask(MyPostListDetailScreen_Activity.this, imageList, viewpag_viewPager);
            buzz.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id);

        }else{

            HomeListDetailViewPager_AsyncTask imag = new HomeListDetailViewPager_AsyncTask(MyPostListDetailScreen_Activity.this, imageList, viewpag_viewPager);
            imag.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id,hashMap.get(SessionStore.USER_ID));
            tv_call.setVisibility(View.VISIBLE);
        }

        if (MyPostListDetail_Tab_Activity.str_status.equalsIgnoreCase("2") || MyPostListDetail_Tab_Activity.str_status.equalsIgnoreCase("1")){
            tv_mail.setVisibility(View.GONE);

        }





        tv_mail.setOnClickListener(MyPostListDetailScreen_Activity.this);
        tv_call.setOnClickListener(MyPostListDetailScreen_Activity.this);
        tv_save.setOnClickListener(MyPostListDetailScreen_Activity.this);


    }

    //*************** On Click *******************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {

        Intent intent = null;

        switch (v.getId())
        {

            case R.id.HomelistDetailScreen_mail:

                if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz")){

                    intent = new Intent(MyPostListDetailScreen_Activity.this, EditBuzz_Tab_Activity.class);
                    intent.putExtra("BuzzId", MyPostListDetail_Tab_Activity.str_Id);
                    intent.putExtra("UserId", MyPostListDetail_Tab_Activity.str_userId);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                }
                else
                {

                    intent = new Intent(MyPostListDetailScreen_Activity.this, EditPost_Tab_Activity.class);
                    intent.putExtra("PostId", MyPostListDetail_Tab_Activity.str_Id);
                    intent.putExtra("UserId", MyPostListDetail_Tab_Activity.str_userId);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                }


                break;



            case R.id.HomelistDetailScreen_call:

               /* if (MyPostListDetail_Tab_Activity.str_status.trim().equalsIgnoreCase("0"))
                {

                    ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                    chagestatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "1");
                }
*/

                filterPopup();



                break;


            case R.id.Header_Save:

                 intent = new Intent(MyPostListDetailScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;



        }//end of switch

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

        hashMap = SessionStore.getUserDetails(MyPostListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        setValue();
    }



    //*****Filter popup *****************************************************************************************************************************************************************************
    private void filterPopup()
    {

        TextView tv_expired, tv_close,tv_delete,tv_cancel,tv_expiredCheck, tv_closeCheck,tv_deleteCheck;

        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.changestatus_popup, null);
        dialog = new Dialog(MyPostListDetailScreen_Activity.this,R.style.PauseDialog);

     //   tv_expired = (TextView)view.findViewById(R.id.ChangeStatusPopup_expired);

     //   tv_close= (TextView)view.findViewById(R.id.ChangeStatusPopup_close);

        tv_delete = (TextView)view.findViewById(R.id.ChangeStatusPopup_delete);

        tv_cancel = (TextView)view.findViewById(R.id.ChangeStatusPopup_cancel);



/*
        if (MyPostListDetail_Tab_Activity.str_status.equalsIgnoreCase("1")){


            tv_expired.setVisibility(View.GONE);




        }else if(MyPostListDetail_Tab_Activity.str_status.equalsIgnoreCase("2")){

            tv_expired.setVisibility(View.GONE);
            tv_close.setVisibility(View.GONE);


        }
*/



        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        WindowManager.LayoutParams wmlp = dialog.getWindow().getAttributes();
        dialog.setContentView(view);

        wmlp.gravity = Gravity.BOTTOM | Gravity.CENTER;
        wmlp.x = 0;   //x position
        wmlp.y = 0;

        dialog.show();


/*
        tv_expired.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz")){

                    ChangeBuzzStatus_AsyncTask chagebuzzstatus = new ChangeBuzzStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                    chagebuzzstatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "1");



                }else{

                    ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                    chagestatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "1");


                }


                tv_expday.setText("Expired");
                tv_mail.setVisibility(View.GONE);
                MyPostListDetail_Tab_Activity.str_status="1";

                dialog.dismiss();

            }
        });


        tv_close.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub
                if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz")){


                    ChangeBuzzStatus_AsyncTask chagebuzzstatus = new ChangeBuzzStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                    chagebuzzstatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "2");

                }else{

                    ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                    chagestatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "2");


                }

                tv_expday.setText("Closed");
                tv_mail.setVisibility(View.GONE);
                MyPostListDetail_Tab_Activity.str_status="2";
                dialog.dismiss();

            }
        });

*/
        tv_delete.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                if(MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz"))
                {
                    new AlertDialog.Builder(MyPostListDetailScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.Alert_msgBuzz))
                            .setNeutralButton("Yes", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {


                                    if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz")) {

                                        ChangeBuzzStatus_AsyncTask chagebuzzstatus = new ChangeBuzzStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                                        chagebuzzstatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "3");


                                    } else {

                                        ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                                        chagestatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "3");


                                    }
                                    dialog.dismiss();

                                }
                            })
                            .setNegativeButton("No", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    dialog.dismiss();
                                }
                            }).show();

                }
                else
                {
                    new AlertDialog.Builder(MyPostListDetailScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.Alert_msgPost))
                            .setNeutralButton("Yes", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which)
                                {

                                    if (MyPostListDetail_Tab_Activity.str_type.trim().equalsIgnoreCase("Buzz"))
                                    {

                                        ChangeBuzzStatus_AsyncTask chagebuzzstatus = new ChangeBuzzStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                                        chagebuzzstatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "3");


                                    }
                                    else
                                    {

                                        ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(MyPostListDetailScreen_Activity.this);
                                        chagestatus.execute(MyPostListDetail_Tab_Activity.str_userId, MyPostListDetail_Tab_Activity.str_Id, "3");


                                    }
                                    dialog.dismiss();

                                }
                            })
                            .setNegativeButton("No", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    dialog.dismiss();
                                }
                            }).show();

                }



            }
        });





        tv_cancel.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                dialog.dismiss();
            }
        });




    }


    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(MyPostListDetailScreen_Activity.this);
    }

}
