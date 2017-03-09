package com.thriftskool.thriftskool1.campus_buzz_details;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.BuzzReportCount_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.CampusBuzzDetailsViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.HomeListDetailViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.PostReportCount_AsyncTask;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.campus_buzz_list.CampusBuzzListScreen_Activity;
import com.thriftskool.thriftskool1.campus_deal_detail.CampusDealDetailScreen_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusBuzzDetailsScreen_Activity extends Activity implements View.OnClickListener {


    private TextView tv_title,tv_expdate,tv_expday, tv_description, tv_id, tv_favorite, tv_report, tv_mail, tv_call, tv_filter,tv_back,tv_mainTitel, tv_save,tv_countNotification;
    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private FrameLayout fram_layout;
    private LinearLayout ll_replaymailLayout;
    private Calendar calender;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_list_detail_screen_);

        hashMap = SessionStore.getUserDetails(CampusBuzzDetailsScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(CampusBuzzDetailsScreen_Activity.this, Comman.PRIFRENS_NAME);
        calender = Calendar.getInstance();

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
        tv_filter = (TextView)findViewById(R.id.Header_filter);
        tv_back= (TextView)findViewById(R.id.Header_Back);
        tv_mainTitel = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        ll_replaymailLayout = (LinearLayout)findViewById(R.id.HomelistDetailScreen_mailcallLayOut);
       // fram_layout = (FrameLayout)findViewById(R.id.HomelistDetailScreen_viewPagerFram);

        viewpag_viewPager = (ViewPager)findViewById(R.id.HomelistDetailScreen_viewPager);





    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue()
    {

        tv_expday.setVisibility(View.GONE);

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)
        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }


      /*  LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(Comman.DEVICE_WIDTH, Comman.DEVICE_WIDTH/2);
        fram_layout.setLayoutParams(lp);*/


        if (hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(CampusBuzzDetailsTab_Activity.str_userId) || CampusBuzzDetailsTab_Activity.str_userId.equalsIgnoreCase("0"))
        {
            ll_replaymailLayout.setVisibility(View.GONE);
        }


        tv_mainTitel.setText("Buzz Detail");

        tv_title.setText(CampusBuzzDetailsTab_Activity.str_title);
       // tv_expdate.setText(DateCoversion.getBuzzExpDate(CampusBuzzDetailsTab_Activity.str_expDate));
        tv_expdate.setText(DateCoversion.getSelectedDate(CampusBuzzDetailsTab_Activity.str_expDate));
        tv_description.setText(CampusBuzzDetailsTab_Activity.str_description);

        if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusBuzzDetailsTab_Activity.str_expDate)==0)
        {
            tv_expday.setText("Today");

        /*    calender.set(calender.get(Calendar.YEAR),calender.get(Calendar.YEAR),calender.get(Calendar.DATE));
            tv_expday.setText(DateCoversion.getBuzzExpDate(calender.get(Calendar.YEAR)+"-"+calender.get(Calendar.MONTH)+"-"+calender.get(Calendar.DATE)));
*/

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusBuzzDetailsTab_Activity.str_expDate)==1)
        {
          //  tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusBuzzDetailsTab_Activity.str_expDate)+" day");
            tv_expday.setText("Expires. on " + DateCoversion.getEEEFormat(CampusBuzzDetailsTab_Activity.str_expDate));

          /*  calender.set(calender.get(Calendar.YEAR),calender.get(Calendar.YEAR),(calender.get(Calendar.DATE)+(int)DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), CampusBuzzDetailsTab_Activity.str_expDate)));
            tv_expday.setText(DateCoversion.getBuzzExpDate(calender.get(Calendar.YEAR)+"-"+calender.get(Calendar.MONTH)+"-"+calender.get(Calendar.DATE)));
*/
        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusBuzzDetailsTab_Activity.str_expDate)<0){

            tv_expday.setText("Expired");


        }else {

          //  tv_expday.setText("Expires in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), CampusBuzzDetailsTab_Activity.str_expDate)+" days");
            tv_expday.setText("Expires. on " + DateCoversion.getEEEFormat(CampusBuzzDetailsTab_Activity.str_expDate));

           /* Log.e("dsadsadas","Datattatatat : : : "+(int)DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), CampusBuzzDetailsTab_Activity.str_expDate));
           // calender.set(calender.get(Calendar.YEAR),calender.get(Calendar.YEAR),(calender.get(Calendar.DATE)+((int)DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), CampusBuzzDetailsTab_Activity.str_expDate))));
            tv_expday.setText(DateCoversion.getBuzzExpDate(calender.get(Calendar.YEAR) + "-" + calender.get(Calendar.MONTH) + "-" + calender.get(Calendar.DATE)));
            Log.e("dsadsadas","Datattatatat : : : "+calender.get(Calendar.YEAR) + "-" + calender.get(Calendar.MONTH) + "-" + calender.get(Calendar.DATE));*/

        }




        tv_mail.setVisibility(View.INVISIBLE);
        tv_call.setVisibility(View.INVISIBLE);
        tv_favorite.setVisibility(View.GONE);
        tv_report.setText(getString(R.string.report_createlistdetailscreen));


        CampusBuzzDetailsViewPager_AsyncTask imag = new CampusBuzzDetailsViewPager_AsyncTask(CampusBuzzDetailsScreen_Activity.this, imageList, viewpag_viewPager);
        imag.execute(CampusBuzzDetailsTab_Activity.str_userId, CampusBuzzDetailsTab_Activity.str_Id);


        tv_report.setOnClickListener(CampusBuzzDetailsScreen_Activity.this);
        tv_save.setOnClickListener(CampusBuzzDetailsScreen_Activity.this);

    }

    // ********************* On Click **************************************************************************************************************************************************************


        @Override
        public void onClick(View v) {


            if (CheckInterNetConnection.isNetworkAvailable(CampusBuzzDetailsScreen_Activity.this))
            {

                switch (v.getId())
                {

                    case R.id.HomelistDetailScreen_report:

                        new AlertDialog.Builder(CampusBuzzDetailsScreen_Activity.this)
                                .setTitle("Alert!")
                                .setMessage("Do you want to report this Post.")
                                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {

                                        BuzzReportCount_AsyncTask postCount = new BuzzReportCount_AsyncTask(CampusBuzzDetailsScreen_Activity.this);
                                        postCount.execute(CampusBuzzDetailsTab_Activity.str_userId,CampusBuzzDetailsTab_Activity.str_Id );


                                    }
                                }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                            }
                        }).show();



                        break;


                    case R.id.Header_Save:

                        Intent intent = new Intent(CampusBuzzDetailsScreen_Activity.this, NotificationListScreen_Activity.class);
                        startActivity(intent);

                        break;


                }



            }
            else
            {

                new AlertDialog.Builder(CampusBuzzDetailsScreen_Activity.this)
                        .setTitle("Alert!")
                        .setMessage(getString(R.string.internetconnection_alert))
                        .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {



                            }
                        }).show();


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

    @Override
    protected void onResume() {
        super.onResume();

        hashMap = SessionStore.getUserDetails(CampusBuzzDetailsScreen_Activity.this, Comman.PRIFRENS_NAME);
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);


        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        setValue();
    }


    @Override
    protected void onPause() {
        super.onPause();

        CrearCashMemmory.trimCache(CampusBuzzDetailsScreen_Activity.this);

    }


}
