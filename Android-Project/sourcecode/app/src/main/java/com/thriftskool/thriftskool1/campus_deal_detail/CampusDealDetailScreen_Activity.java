package com.thriftskool.thriftskool1.campus_deal_detail;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.util.DisplayMetrics;
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
import com.thriftskool.thriftskool1.asynctask.CampusBuzzDetailsViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.CampusDealsDetailsViewPager_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ViewDealCodeCount_AsynckTask;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealDetailScreen_Activity extends Activity implements View.OnClickListener{


    private TextView tv_title,tv_expdate,tv_expday, tv_description, tv_id, tv_favorite, tv_report, tv_mail, tv_call, tv_maintitel, tv_back, tv_save,tv_viewCode,tv_countNotification;
    private ViewPager viewpag_viewPager;
    private LinearLayout ll_layout;
    private ArrayList<String> imageList = new ArrayList<String>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    Dialog dialog=null;
    private FrameLayout fram_layout;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_list_detail_screen_);

        hashMap = SessionStore.getUserDetails(CampusDealDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(CampusDealDetailScreen_Activity.this, Comman.PRIFRENS_NAME);


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
        tv_viewCode = (TextView)findViewById(R.id.HomelistDetailScreen_viewCode);

        tv_maintitel= (TextView)findViewById(R.id.Header_Title);
        tv_back= (TextView)findViewById(R.id.Header_Back);
        tv_save= (TextView)findViewById(R.id.Header_Save);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        ll_layout = (LinearLayout)findViewById(R.id.HomelistDetailScreen_mailcallLayOut);
        //fram_layout = (FrameLayout)findViewById(R.id.HomelistDetailScreen_viewPagerFram);


        viewpag_viewPager = (ViewPager)findViewById(R.id.HomelistDetailScreen_viewPager);


        setValue();

    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue()
    {


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


        tv_mail.setVisibility(View.INVISIBLE);
        tv_call.setVisibility(View.INVISIBLE);
        tv_favorite.setVisibility(View.INVISIBLE);

        tv_maintitel.setText("Deal Detail");
        tv_call.setVisibility(View.GONE);
        tv_mail.setVisibility(View.GONE);
        tv_report.setVisibility(View.GONE);
        tv_viewCode.setVisibility(View.VISIBLE);

        ll_layout.setVisibility(View.INVISIBLE);

        tv_title.setText(CampusDealDetail_Tab_Activity.str_title);
       // tv_expdate.setText(DateCoversion.getSelectedDate(CampusDealDetail_Tab_Activity.str_title));
        tv_expdate.setText(DateCoversion.getSelectedDate(CampusDealDetail_Tab_Activity.str_expDate));
        //tv_expday.setText("Expire in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)+" days");
        tv_description.setText(CampusDealDetail_Tab_Activity.str_description);

       if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)==0)
        {
            tv_expday.setText("Expire Today");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)==1)
        {
            tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)+" day");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)<0){

            tv_expday.setText("Expired");


        }else {

            tv_expday.setText("Expires in "+DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),CampusDealDetail_Tab_Activity.str_expDate)+" days");

        }




        CampusDealsDetailsViewPager_AsyncTask imag = new CampusDealsDetailsViewPager_AsyncTask(CampusDealDetailScreen_Activity.this, imageList, viewpag_viewPager);
        imag.execute(CampusDealDetail_Tab_Activity.str_userId, CampusDealDetail_Tab_Activity.str_Id);


        tv_viewCode.setOnClickListener(CampusDealDetailScreen_Activity.this);
        tv_save.setOnClickListener(CampusDealDetailScreen_Activity.this);

    }

    //************ On Click **************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {


        Button cancel;
        TextView tv_code;

        switch (v.getId())
        {

            case R.id.HomelistDetailScreen_viewCode:


                LayoutInflater layoutInflater = (LayoutInflater)getSystemService(LAYOUT_INFLATER_SERVICE);

                View view = layoutInflater.inflate(R.layout.dealcode_popup_row, null);
                dialog = new Dialog(CampusDealDetailScreen_Activity.this);

                cancel = (Button)view.findViewById(R.id.Dealecode_popup_Cancel);
                tv_code = (TextView)view.findViewById(R.id.Dealecode_popup_Code);

                tv_code.setText(CampusDealDetail_Tab_Activity.str_dealCode);

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


                ViewDealCodeCount_AsynckTask deal = new ViewDealCodeCount_AsynckTask(CampusDealDetailScreen_Activity.this);
                deal.execute(CampusDealDetail_Tab_Activity.str_userId,CampusDealDetail_Tab_Activity.str_Id);

                break;




            case R.id.Header_Save:

                Intent intent = new Intent(CampusDealDetailScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


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


    @Override
    protected void onResume() {
        super.onResume();
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);


        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;
        hashMap = SessionStore.getUserDetails(CampusDealDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
    }




    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(CampusDealDetailScreen_Activity.this);
    }

}
