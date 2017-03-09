package com.thriftskool.thriftskool1.home_list_detail;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.HomeListDetailViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.PostFavoriteStatus_AsynceTask;
import com.thriftskool.thriftskool1.asynctask.PostReportCount_AsyncTask;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.campus_deal_detail.CampusDealDetail_Tab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.contactus.ContactUsScreen_Activity;
import com.thriftskool.thriftskool1.contactus.ContactUs_Tab_Activity;
import com.thriftskool.thriftskool1.edit_post.EditPost_Tab_Activity;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.replay_massage.ReplyMessageScreen_Activity;
import com.thriftskool.thriftskool1.replay_massage.ReplyMessage_Tab_Activity;
import com.thriftskool.thriftskool1.reply_messag_detail.ReplyMessageDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.view_profile.ViewProfileScreen_Activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class HomeListDetailScreen_Activity extends Activity implements View.OnClickListener{


    private TextView tv_title,tv_expdate,tv_expday, tv_description, tv_id, tv_favorite, tv_report, tv_mail, tv_call,  tv_mainTitle, tv_Save,tv_countNotification,tv_profile_show;
    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private boolean favoretFlage =true;
    private FrameLayout fram_layout;
    private LinearLayout ll_replaymailLayout;
    public static String str_replyMessage="";



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_list_detail_screen_);

        hashMap = SessionStore.getUserDetails(HomeListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(HomeListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();

    }



    //*********************** Maping **********************************************************************************************************************************************************

    private void maping()
    {

        tv_title = (TextView)findViewById(R.id.HomelistDetailScreen_title);
        tv_expdate= (TextView)findViewById(R.id.HomelistDetailScreen_expDate);
        tv_expday= (TextView)findViewById(R.id.HomelistDetailScreen_expDay);
        tv_description= (TextView)findViewById(R.id.HomelistDetailScreen_description);
        tv_favorite= (TextView)findViewById(R.id.HomelistDetailScreen_favorite);
        tv_report= (TextView)findViewById(R.id.HomelistDetailScreen_report);
        tv_mail= (TextView)findViewById(R.id.HomelistDetailScreen_mail);
        tv_call= (TextView)findViewById(R.id.HomelistDetailScreen_call);
        tv_profile_show=(TextView)findViewById(R.id.HomelistDetailScreen_profile);


        tv_mainTitle = (TextView)findViewById(R.id.Header_Title);
        tv_Save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);


       // fram_layout = (FrameLayout)findViewById(R.id.HomelistDetailScreen_viewPagerFram);
        ll_replaymailLayout = (LinearLayout)findViewById(R.id.HomelistDetailScreen_mailcallLayOut);

        viewpag_viewPager = (ViewPager)findViewById(R.id.HomelistDetailScreen_viewPager);


    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue()
    {

        tv_profile_show.setVisibility(View.VISIBLE);

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

        if (hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(HomeListDetail_Tab_Activity.str_userId) || HomeListDetail_Tab_Activity.str_userId.equalsIgnoreCase("0"))
        {
            ll_replaymailLayout.setVisibility(View.GONE);
        }

        if (HomeListDetail_Tab_Activity.str_userId.equalsIgnoreCase("0")){

            tv_favorite.setVisibility(View.GONE);
        }

        tv_mainTitle.setText("POST DETAIL");
      //  tv_mainTitle.setText(HomeListDetail_Tab_Activity.str_Name);
        tv_mail.setText(getString(R.string.email_createlistdetailscreen));

        tv_call.setText("Contact  ");
        tv_call. setCompoundDrawablesWithIntrinsicBounds(0, 0, R.drawable.contact15, 0);
        tv_call.setTextColor(R.color.color_titledetailcolor);

        tv_report.setText(getString(R.string.report_createlistdetailscreen));

        tv_title.setText(HomeListDetail_Tab_Activity.str_title);//tv_title.setText("$"+HomeListDetail_Tab_Activity.str_price+" \n"+HomeListDetail_Tab_Activity.str_title);
       // tv_title.setText("$"+HomeListDetail_Tab_Activity.str_price+" \n"+HomeListDetail_Tab_Activity.str_title);//tv_title.setText("$"+HomeListDetail_Tab_Activity.str_price+" \n"+HomeListDetail_Tab_Activity.str_title);
       // tv_expdate.setText(DateCoversion.getSelectedDate(HomeListDetail_Tab_Activity.str_expDate));
       // tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),HomeListDetail_Tab_Activity.str_expDate)+" days");
          tv_description.setText(HomeListDetail_Tab_Activity.str_description);

        tv_expdate.setText("$"+HomeListDetail_Tab_Activity.str_price);

        if (HomeListDetail_Tab_Activity.str_status.trim().equalsIgnoreCase("1"))
        {

            tv_expday.setText("Expired");

        }else if (HomeListDetail_Tab_Activity.str_status.trim().equalsIgnoreCase("2"))
        {

            tv_expday.setText("Closed");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), HomeListDetail_Tab_Activity.str_expDate)==0)
        {
            tv_expday.setText("Expire Today");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),HomeListDetail_Tab_Activity.str_expDate)==1)
        {
            tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),HomeListDetail_Tab_Activity.str_expDate)+" day");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), HomeListDetail_Tab_Activity.str_expDate)<0){

            tv_expday.setText("Expired");


        }else {

            tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),HomeListDetail_Tab_Activity.str_expDate)+" days");

        }





        if (HomeListDetail_Tab_Activity.str_favorite.trim().equalsIgnoreCase("1"))
        {
            tv_favorite.setTextColor(Color.parseColor("#57B65B"));
            tv_favorite.setText(getString(R.string.fa_star));
        }
        else
        {
            tv_favorite.setTextColor(Color.parseColor("#ffffff"));
            tv_favorite.setText(getString(R.string.fa_star_o));
        }


        HomeListDetailViewPager_AsyncTask imag = new HomeListDetailViewPager_AsyncTask(HomeListDetailScreen_Activity.this, imageList, viewpag_viewPager);
//        imag.execute(hashMap.get(SessionStore.USER_ID), HomeListDetail_Tab_Activity.str_Id);
        imag.execute(HomeListDetail_Tab_Activity.str_userId, HomeListDetail_Tab_Activity.str_Id,hashMap.get(SessionStore.USER_ID));


        tv_mail.setOnClickListener(HomeListDetailScreen_Activity.this);
        tv_call.setOnClickListener(HomeListDetailScreen_Activity.this);
        tv_report.setOnClickListener(HomeListDetailScreen_Activity.this);
        tv_favorite.setOnClickListener(HomeListDetailScreen_Activity.this);
        tv_Save.setOnClickListener(HomeListDetailScreen_Activity.this);
        tv_profile_show.setOnClickListener(HomeListDetailScreen_Activity.this);



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

        hashMap = SessionStore.getUserDetails(HomeListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        setValue();
    }

    //*************** On Click ********************************************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent = null;


        if (CheckInterNetConnection.isNetworkAvailable(HomeListDetailScreen_Activity.this))
        {

        switch (v.getId())
        {

            case R.id.HomelistDetailScreen_mail:

                if (str_replyMessage.trim().equalsIgnoreCase("0"))
                {

                    intent = new Intent(HomeListDetailScreen_Activity.this, ReplyMessage_Tab_Activity.class);
                    intent.putExtra("ID",HomeListDetail_Tab_Activity.str_Id);
                    intent.putExtra("UserID",HomeListDetail_Tab_Activity.str_userId);
                    intent.putExtra("PostName",HomeListDetail_Tab_Activity.str_title);
                    startActivity(intent);

                }
                else
                {

                    Log.e("Heloooo ","Hiiii: "+HomeListDetail_Tab_Activity.str_userId);
                    intent = new Intent(HomeListDetailScreen_Activity.this, ReplyMessageDetail_Tab_Activity.class);
                    intent.putExtra("PostId",HomeListDetail_Tab_Activity.str_Id);
                    intent.putExtra("UserID",HomeListDetail_Tab_Activity.str_userId);
                    intent.putExtra("PostName",HomeListDetail_Tab_Activity.str_title);
                    startActivity(intent);

                }

                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);


                break;


            case R.id.HomelistDetailScreen_call:

                intent = new Intent(HomeListDetailScreen_Activity.this, ContactUs_Tab_Activity.class);
                intent.putExtra("ID",HomeListDetail_Tab_Activity.str_Id);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);


                break;

            case R.id.HomelistDetailScreen_report:

                new AlertDialog.Builder(HomeListDetailScreen_Activity.this)
                        .setTitle("Alert!")
                        .setMessage("Do you want to report this Post.")
                        .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                PostReportCount_AsyncTask postCount = new PostReportCount_AsyncTask(HomeListDetailScreen_Activity.this);
                                postCount.execute(HomeListDetail_Tab_Activity.str_userId,HomeListDetail_Tab_Activity.str_Id );


                            }
                        }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                }).show();



                break;



            case R.id.HomelistDetailScreen_favorite:

                PostFavoriteStatus_AsynceTask favorte = new PostFavoriteStatus_AsynceTask(HomeListDetailScreen_Activity.this, tv_favorite);

                if (tv_favorite.getText().toString().trim().equalsIgnoreCase(getString(R.string.fa_star)))
                {

                    favorte.execute(HomeListDetail_Tab_Activity.str_Id,hashMap.get(SessionStore.USER_ID), "0");
                    HomeListDetail_Tab_Activity.str_favorite="0";

                }else {

                    favorte.execute(HomeListDetail_Tab_Activity.str_Id, hashMap.get(SessionStore.USER_ID), "1");
                    HomeListDetail_Tab_Activity.str_favorite="1";
                }


                break;

            case R.id.HomelistDetailScreen_profile:

                intent = new Intent(HomeListDetailScreen_Activity.this, ViewProfileScreen_Activity.class);
                startActivity(intent);


                break;
            case R.id.Header_Save:

                 intent = new Intent(HomeListDetailScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;

        }//end of switch

        }
        else
        {

            new AlertDialog.Builder(HomeListDetailScreen_Activity.this)
                    .setTitle("Alert!")
                    .setMessage(getString(R.string.internetconnection_alert))
                    .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                        }
                    }).show();


        }

    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(HomeListDetailScreen_Activity.this);
    }

}
