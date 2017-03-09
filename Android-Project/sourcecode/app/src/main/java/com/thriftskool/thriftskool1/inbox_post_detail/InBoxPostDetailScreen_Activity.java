package com.thriftskool.thriftskool1.inbox_post_detail;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.BuzzReportCount_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ChangeStatus_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.NotificationPostBuzzDetail_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.PostFavoriteStatus_AsynceTask;
import com.thriftskool.thriftskool1.asynctask.PostReportCount_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.SearchResultDetail_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ViewDealCodeCount_AsynckTask;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.contactus.ContactUs_Tab_Activity;
import com.thriftskool.thriftskool1.my_post_list_detail.MyPostListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.replay_massage.ReplyMessage_Tab_Activity;
import com.thriftskool.thriftskool1.reply_messag_detail.ReplyMessageDetail_Tab_Activity;
import com.thriftskool.thriftskool1.search_edit_post.SearchEditPost_Tab_Activity;
import com.thriftskool.thriftskool1.searchresult_detail.SearchResultDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by etiloxadmin on 3/10/15.
 */
public class InBoxPostDetailScreen_Activity extends Activity implements View.OnClickListener{


    private TextView tv_title,tv_expdate,tv_expday, tv_description, tv_id, tv_favorite, tv_report, tv_mail, tv_call,  tv_mainTitle, tv_Save,tv_viewCode,tv_countNotification;
    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private boolean favoretFlage =true;
    private FrameLayout fram_layout;
    public static String str_viewCode="",str_replyMessage="";
    private  Dialog  dialog;
    private LinearLayout ll_layout;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_list_detail_screen_);

        hashMap = SessionStore.getUserDetails(InBoxPostDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(InBoxPostDetailScreen_Activity.this, Comman.PRIFRENS_NAME);


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
        tv_viewCode= (TextView)findViewById(R.id.HomelistDetailScreen_viewCode);

        tv_mainTitle = (TextView)findViewById(R.id.Header_Title);
        tv_Save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

       // fram_layout = (FrameLayout)findViewById(R.id.HomelistDetailScreen_viewPagerFram);

        ll_layout = (LinearLayout)findViewById(R.id.HomelistDetailScreen_mailcallLayOut);

        viewpag_viewPager = (ViewPager)findViewById(R.id.HomelistDetailScreen_viewPager);



        setValue();

    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue()
    {
        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }



      /*  LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(Comman.DEVICE_WIDTH, Comman.DEVICE_WIDTH/2);
        fram_layout.setLayoutParams(lp);*/

        if (hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(InBoxPostDetail_Tab_Activity.str_postUserId))
        {


            tv_mail.setText(getString(R.string.email_mypostdetailscreen));


            tv_call.setText(getString(R.string.call_mypostdetailscreen));
            tv_call.setVisibility(View.VISIBLE);
            tv_call.setTextColor(getResources().getColor(R.color.color_textcolor));
            tv_report.setVisibility(View.GONE);

        }else  if (InBoxPostDetail_Tab_Activity.str_postUserId.equalsIgnoreCase("0")) {

            ll_layout.setVisibility(View.GONE);


        }else{

            tv_mail.setText(getString(R.string.email_createlistdetailscreen));

            tv_call.setText("Contact  ");
            tv_call. setCompoundDrawablesWithIntrinsicBounds(0, 0, R.drawable.contact15, 0);
            tv_call.setTextColor(R.color.color_titledetailcolor);
            tv_mail.setVisibility(View.GONE);
            tv_report.setText(getString(R.string.report_createlistdetailscreen));
        }



        if (InBoxPostDetail_Tab_Activity.str_postUserId.equalsIgnoreCase("0")){

            tv_favorite.setVisibility(View.GONE);

        }





        //tv_mainTitle.setText(HomeListDetail_Tab_Activity.str_Name);


        SearchResultDetail_AsyncTask imag = new SearchResultDetail_AsyncTask(InBoxPostDetailScreen_Activity.this, imageList, viewpag_viewPager,InBoxPostDetail_Tab_Activity.str_type, tv_title,tv_expdate,tv_expday,tv_description,tv_favorite,tv_report,tv_mail,tv_call,tv_viewCode);

        if (InBoxPostDetail_Tab_Activity.str_type.equalsIgnoreCase("PM")){


            tv_mainTitle.setText("Post Detail");


            imag.execute(InBoxPostDetail_Tab_Activity.str_postUserId, InBoxPostDetail_Tab_Activity.str_Id,"post_detail",hashMap.get(SessionStore.USER_ID));


        }else if (InBoxPostDetail_Tab_Activity.str_type.equalsIgnoreCase("CB")){

            imag.execute(InBoxPostDetail_Tab_Activity.str_userId, InBoxPostDetail_Tab_Activity.str_Id,"buzz_detail");
            tv_mail.setVisibility(View.INVISIBLE);
            tv_call.setVisibility(View.INVISIBLE);
            tv_favorite.setVisibility(View.GONE);
            tv_report.setText(getString(R.string.report_createlistdetailscreen));
            tv_favorite.setVisibility(View.GONE);



        }else if (InBoxPostDetail_Tab_Activity.str_type.equalsIgnoreCase("CD")){

            imag.execute(InBoxPostDetail_Tab_Activity.str_userId, InBoxPostDetail_Tab_Activity.str_Id,"deal_detail");

            ll_layout.setVisibility(View.GONE);
            tv_viewCode.setVisibility(View.VISIBLE);
            tv_favorite.setVisibility(View.GONE);

        }




        tv_mail.setOnClickListener(InBoxPostDetailScreen_Activity.this);
        tv_call.setOnClickListener(InBoxPostDetailScreen_Activity.this);
        tv_report.setOnClickListener(InBoxPostDetailScreen_Activity.this);
        tv_favorite.setOnClickListener(InBoxPostDetailScreen_Activity.this);
        tv_viewCode.setOnClickListener(InBoxPostDetailScreen_Activity.this);
        tv_Save.setOnClickListener(InBoxPostDetailScreen_Activity.this);






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

        hashMap = SessionStore.getUserDetails(InBoxPostDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
    }

    //*************** On Click ********************************************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent = null;

        Button cancel;
        TextView tv_code;

        if (CheckInterNetConnection.isNetworkAvailable(InBoxPostDetailScreen_Activity.this))
        {

            switch (v.getId())
            {
                case R.id.HomelistDetailScreen_viewCode:


                    LayoutInflater layoutInflater = (LayoutInflater)getSystemService(LAYOUT_INFLATER_SERVICE);

                    View view = layoutInflater.inflate(R.layout.dealcode_popup_row, null);
                    dialog = new Dialog(InBoxPostDetailScreen_Activity.this);

                    cancel = (Button)view.findViewById(R.id.Dealecode_popup_Cancel);
                    tv_code = (TextView)view.findViewById(R.id.Dealecode_popup_Code);

                    tv_code.setText(str_viewCode);

                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
                    WindowManager.LayoutParams wmlp = dialog.getWindow().getAttributes();
                    dialog.setContentView(view);

                    wmlp.gravity = Gravity.CENTER;
                    wmlp.x = 0;   //x position
                    wmlp.y = 0;

                    dialog.show();


                    cancel.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {

                            dialog.dismiss();
                        }
                    });


                    ViewDealCodeCount_AsynckTask deal = new ViewDealCodeCount_AsynckTask(InBoxPostDetailScreen_Activity.this);
                    deal.execute(InBoxPostDetail_Tab_Activity.str_userId,InBoxPostDetail_Tab_Activity.str_Id);

                    break;


                case R.id.HomelistDetailScreen_mail:

                    if (tv_mail.getText().toString().trim().contains("Edit")){

                        intent = new Intent(InBoxPostDetailScreen_Activity.this, SearchEditPost_Tab_Activity.class);
                        intent.putExtra("PostId", InBoxPostDetail_Tab_Activity.str_Id);
                        intent.putExtra("UserId", InBoxPostDetail_Tab_Activity.str_userId);
                        startActivity(intent);
                        overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                    }else{

                        if (str_replyMessage.trim().equalsIgnoreCase("0")){

                            intent = new Intent(InBoxPostDetailScreen_Activity.this, ReplyMessage_Tab_Activity.class);
                            intent.putExtra("ID",InBoxPostDetail_Tab_Activity.str_Id);
                            intent.putExtra("UserID",InBoxPostDetail_Tab_Activity.str_userId);
                            intent.putExtra("PostName",InBoxPostDetail_Tab_Activity.str_title);


                            startActivity(intent);

                        }else {

                            intent = new Intent(InBoxPostDetailScreen_Activity.this, ReplyMessageDetail_Tab_Activity.class);
                            intent.putExtra("PostId",InBoxPostDetail_Tab_Activity.str_Id);
                            intent.putExtra("UserID",InBoxPostDetail_Tab_Activity.str_userId);
                            intent.putExtra("PostName",InBoxPostDetail_Tab_Activity.str_title);

                            startActivity(intent);


                        }

                    }



                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                    break;


                case R.id.HomelistDetailScreen_call:

                  /*  intent = new Intent(InBoxPostDetailScreen_Activity.this, ContactUs_Tab_Activity.class);
                    intent.putExtra("ID",InBoxPostDetail_Tab_Activity.str_Id);
                    startActivity(intent);
                    overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);*/


                    ChangeStatus_AsyncTask chagestatus = new ChangeStatus_AsyncTask(InBoxPostDetailScreen_Activity.this);
                    chagestatus.execute(InBoxPostDetail_Tab_Activity.str_postUserId, InBoxPostDetail_Tab_Activity.str_Id, "1");




                    break;

                case R.id.HomelistDetailScreen_report:

                    new AlertDialog.Builder(InBoxPostDetailScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage("Do you want to report this Post.")
                            .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                    if (InBoxPostDetail_Tab_Activity.str_type.equalsIgnoreCase("PM")) {

                                        PostReportCount_AsyncTask postCount = new PostReportCount_AsyncTask(InBoxPostDetailScreen_Activity.this);
                                        postCount.execute(InBoxPostDetail_Tab_Activity.str_userId, InBoxPostDetail_Tab_Activity.str_Id);

                                    }else {


                                        BuzzReportCount_AsyncTask postCount = new BuzzReportCount_AsyncTask(InBoxPostDetailScreen_Activity.this);
                                        postCount.execute(InBoxPostDetail_Tab_Activity.str_userId,InBoxPostDetail_Tab_Activity.str_Id );

                                    }




                                }
                            }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                        }
                    }).show();



                    break;



                case R.id.HomelistDetailScreen_favorite:

                    PostFavoriteStatus_AsynceTask favorte = new PostFavoriteStatus_AsynceTask(InBoxPostDetailScreen_Activity.this, tv_favorite);

                    if (tv_favorite.getText().toString().trim().equalsIgnoreCase(getString(R.string.fa_star))){

                        favorte.execute(InBoxPostDetail_Tab_Activity.str_Id,hashMap.get(SessionStore.USER_ID), "0");

                    }else {

                        favorte.execute(InBoxPostDetail_Tab_Activity.str_Id, hashMap.get(SessionStore.USER_ID), "1");

                    }


                    break;




                case R.id.Header_Save:

                    intent = new Intent(InBoxPostDetailScreen_Activity.this, NotificationListScreen_Activity.class);
                    startActivity(intent);


                    break;
            }//end of switch

        }
        else
        {

            new AlertDialog.Builder(InBoxPostDetailScreen_Activity.this)
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
        CrearCashMemmory.trimCache(InBoxPostDetailScreen_Activity.this);
    }

}
