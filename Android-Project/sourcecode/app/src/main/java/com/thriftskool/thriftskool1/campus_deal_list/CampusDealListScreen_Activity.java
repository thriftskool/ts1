package com.thriftskool.thriftskool1.campus_deal_list;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AbsListView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.CampusBuzzList_Adapter;
import com.thriftskool.thriftskool1.adapter.CampusDealList_Adapter;
import com.thriftskool.thriftskool1.asynctask.CampusBuzzList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.CampusDealList_AsyncTask;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.CampusDealList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.create_buzz.CreateBuzz_Tab_Activity;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealListScreen_Activity extends Activity implements View.OnClickListener{


    private ListView lv_listView;
    private TextView tv_title, tv_back, tv_save, tv_filter, tv_alert;
    private List<CampusDealList_Been> campusDealsList = new ArrayList<CampusDealList_Been>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private ArrayAdapter<CampusDealList_Been> adapter;
    private int filterflage=0;
    private Dialog dialog;


    private View footerView;
    private int start=0,end=10;
    public static boolean dealloadmoreFlage=false;





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_campus_buzz_list_screen_);
        hashMap = SessionStore.getUserDetails(CampusDealListScreen_Activity.this, Comman.PRIFRENS_NAME);


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

        setValue();

    }



    //********* Set Value *************************************************************************************************************************************************************************

    private void setValue()

    {
        dealloadmoreFlage=false;

        tv_title.setText("Campus Deals");
        tv_filter.setVisibility(View.VISIBLE);


        CampusDealList_AsyncTask campusDealL = new CampusDealList_AsyncTask(CampusDealListScreen_Activity.this, campusDealsList, lv_listView, tv_alert,footerView,""+start, ""+end,filterflage);
        campusDealL.execute(hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.UNIVERSITY_ID),""+start, ""+end);




        lv_listView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {


            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {

                if ((firstVisibleItem + visibleItemCount - 1) == campusDealsList.size() && !(dealloadmoreFlage)) {

                    dealloadmoreFlage = true;
                    start = start+10;
                    end = 10;
                    CampusDealList_AsyncTask campusDealL = new CampusDealList_AsyncTask(CampusDealListScreen_Activity.this, campusDealsList, lv_listView, tv_alert,footerView,""+start, ""+end, filterflage);
                    campusDealL.execute(hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.UNIVERSITY_ID),""+start, ""+end);

                }


            }
        });





        tv_save.setOnClickListener(CampusDealListScreen_Activity.this);
        tv_filter.setOnClickListener(CampusDealListScreen_Activity.this);

    }

    //************ On Click ***********************************************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent=null;

        switch (v.getId())
        {



            case R.id.Header_Save:

                 intent = new Intent(CampusDealListScreen_Activity.this, NotificationListScreen_Activity.class);
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
        hashMap = SessionStore.getUserDetails(CampusDealListScreen_Activity.this, Comman.PRIFRENS_NAME);
    }

    //*****Filter popup *****************************************************************************************************************************************************************************
    private void filterPopup()
    {
        adapter = new CampusDealList_Adapter(CampusDealListScreen_Activity.this,R.layout.home_list_row,campusDealsList);


        TextView tv_expiryDateSTL,tv_expiryDateLTS,tv_cancel,tv_expiryDateSTLCheck,tv_expiryDateLTSCheck;

        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.buzzdeal_filter_popup, null);
        dialog = new Dialog(CampusDealListScreen_Activity.this,R.style.PauseDialog);

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

                ((CampusDealList_Adapter)adapter).sortByExpiryDateAse();
                filterflage = 1;
                dialog.dismiss();
                lv_listView.setAdapter(adapter);
            }
        });


        tv_expiryDateLTS.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                ((CampusDealList_Adapter)adapter).sortByExpiryDateDes();
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
        CrearCashMemmory.trimCache(CampusDealListScreen_Activity.this);
    }

}
