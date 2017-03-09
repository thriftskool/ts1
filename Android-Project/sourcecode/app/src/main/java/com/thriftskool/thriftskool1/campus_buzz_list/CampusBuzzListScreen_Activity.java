package com.thriftskool.thriftskool1.campus_buzz_list;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AbsListView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.CampusBuzzList_Adapter;
import com.thriftskool.thriftskool1.asynctask.CampusBuzzList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.HomeList_AsyncTask;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.create_buzz.CreateBuzz_Tab_Activity;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CampusBuzzListScreen_Activity extends Activity implements View.OnClickListener{


    private ListView lv_listView;
    private TextView tv_title, tv_back, tv_save, tv_filter, tv_alert,tv_countNotification;

    private List<CampusBuzzList_Been> campusBuzzList = new ArrayList<CampusBuzzList_Been>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private ArrayAdapter<CampusBuzzList_Been> adapter;
    private int filterflage=0;
    private Dialog dialog;

    private View footerView;
    private int start=0,end=10;
    public static boolean buzzloadmoreFlage=false;





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_campus_buzz_list_screen_);

        hashMap = SessionStore.getUserDetails(CampusBuzzListScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(CampusBuzzListScreen_Activity.this, Comman.PRIFRENS_NAME);


        maping();

    }

    //************** Maping **********************************************************************************************************************************************************************

    private void maping()
    {

        footerView = ((LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.load_more_row, null);


        lv_listView = (ListView)findViewById(R.id.CampusBuzzListScreen_ListView);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_filter = (TextView)findViewById(R.id.Header_filter);
        tv_alert = (TextView)findViewById(R.id.CampusBuzzListScreen_textAlert);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        setValue();

    }



    //********* Set Value *************************************************************************************************************************************************************************

    private void setValue()

    {

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0){
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }

        buzzloadmoreFlage=false;

        tv_title.setText(getString(R.string.title_buzzdetailscreen));
        tv_back.setText(getString(R.string.fa_plus));
        tv_back.setVisibility(View.VISIBLE);
        tv_filter.setVisibility(View.VISIBLE);





        tv_back.setOnClickListener(CampusBuzzListScreen_Activity.this);
        tv_save.setOnClickListener(CampusBuzzListScreen_Activity.this);
        tv_filter.setOnClickListener(CampusBuzzListScreen_Activity.this);





        lv_listView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {


            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {

                if ((firstVisibleItem + visibleItemCount - 1) == campusBuzzList.size() && !(buzzloadmoreFlage)) {

                    buzzloadmoreFlage = true;
                    start = start+10;
                    end = 10;
                    CampusBuzzList_AsyncTask campusBuzzL1 = new CampusBuzzList_AsyncTask(CampusBuzzListScreen_Activity.this, campusBuzzList, lv_listView, tv_alert,footerView, ""+start, ""+end, filterflage);
                    campusBuzzL1.execute(hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.UNIVERSITY_ID), "" + start, "" + end);

                }


            }
        });

    }


    //************ On Click ***********************************************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent=null;

        switch (v.getId())
        {

            case R.id.Header_Back:

                intent = new Intent(CampusBuzzListScreen_Activity.this, CreateBuzz_Tab_Activity.class);
                startActivity(intent);


                break;



            case R.id.Header_Save:
                 intent = new Intent(CampusBuzzListScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;




            case R.id.Header_filter:

                filterPopup();
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

        campusBuzzList.clear();
        start=0;
        end=10;
        hashMap = SessionStore.getUserDetails(CampusBuzzListScreen_Activity.this, Comman.PRIFRENS_NAME);
        CampusBuzzList_AsyncTask campusBuzzL = new CampusBuzzList_AsyncTask(CampusBuzzListScreen_Activity.this, campusBuzzList, lv_listView, tv_alert,footerView, ""+start, ""+end,filterflage);
        campusBuzzL.execute(hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.UNIVERSITY_ID), "" + start, "" + end);



    }
//*****Filter popup *****************************************************************************************************************************************************************************
 private void filterPopup()
 {
     adapter = new CampusBuzzList_Adapter(CampusBuzzListScreen_Activity.this,R.layout.home_list_row,campusBuzzList);


     TextView tv_expiryDateSTL,tv_expiryDateLTS,tv_cancel,tv_expiryDateSTLCheck,tv_expiryDateLTSCheck;

             LayoutInflater layoutInflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);

             View view = layoutInflater.inflate(R.layout.buzzdeal_filter_popup, null);
             dialog = new Dialog(CampusBuzzListScreen_Activity.this,R.style.PauseDialog);

             tv_expiryDateSTL = (TextView)view.findViewById(R.id.BuzzDealFilter_popup_ExpiryDateSTOL);
             tv_expiryDateSTLCheck = (TextView)view.findViewById(R.id.BuzzDealtFilter_popup_ExpiryDateSTOLCheck);
             tv_expiryDateLTS = (TextView)view.findViewById(R.id.BuzzDealFilter_popup_ExpiryDateLTOS);
             tv_expiryDateLTSCheck = (TextView)view.findViewById(R.id.BuzzDealFilter_popup_ExpiryDateLTOSCheck);
             tv_cancel = (TextView)view.findViewById(R.id.BuzzDealFilter_popup_Cancel);




             if (filterflage==0){


             tv_expiryDateSTLCheck .setText("");
             tv_expiryDateLTSCheck.setText("");


             }else if(filterflage==1){

             tv_expiryDateSTLCheck .setText(getString(R.string.fa_check));
             tv_expiryDateLTSCheck.setText("");


             }else if(filterflage==2){

             tv_expiryDateSTLCheck .setText("");
             tv_expiryDateLTSCheck.setText(getString(R.string.fa_check));

             }


             dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
             WindowManager.LayoutParams wmlp = dialog.getWindow().getAttributes();
             dialog.setContentView(view);

             wmlp.gravity = Gravity.BOTTOM | Gravity.CENTER;
             wmlp.x = 0;   //x position
             wmlp.y = 0;

             dialog.show();




             tv_expiryDateSTL.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
            // TODO Auto-generated method stub

            ((CampusBuzzList_Adapter)adapter).sortByExpiryDateAse();
            filterflage = 1;
            dialog.dismiss();
            lv_listView.setAdapter(adapter);
            }
            });


             tv_expiryDateLTS.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
            // TODO Auto-generated method stub

            ((CampusBuzzList_Adapter)adapter).sortByExpiryDateDes();
            filterflage =2;
            dialog.dismiss();

            lv_listView.setAdapter(adapter);
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
        CrearCashMemmory.trimCache(CampusBuzzListScreen_Activity.this);
    }


 }
