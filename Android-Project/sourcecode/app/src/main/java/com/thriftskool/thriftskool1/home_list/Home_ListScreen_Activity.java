package com.thriftskool.thriftskool1.home_list;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AbsListView;
import android.widget.Adapter;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.asynctask.HomeList_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.home.HomeScreen_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Home_ListScreen_Activity extends Activity implements View.OnClickListener{

    private ListView lv_listView;
    private TextView tv_title, tv_back, tv_save, tv_filter, tv_alert,tv_countNotification;
    private List<HomeList_Been> homeList = new ArrayList<HomeList_Been>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private ArrayAdapter<HomeList_Been> adapter;

    private View footerView;
    private int start=0,end=10;
    public static boolean loadmoreFlage=false;

    private LinearLayout ll_outside;
    private ImageView iv_clickHear;
    private SharedPreferences prefs;
    private SharedPreferences.Editor editor;

    private Dialog dialog;
    private int filterflage=0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home__list_screen_);

        hashMap = SessionStore.getUserDetails(Home_ListScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(Home_ListScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();

    }


    //************** Maping **********************************************************************************************************************************************************************

    private void maping()
    {

        footerView = ((LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.load_more_row, null);


        lv_listView = (ListView)findViewById(R.id.HomeListScreen_ListView);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_filter = (TextView)findViewById(R.id.Header_filter);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        tv_alert = (TextView)findViewById(R.id.HomeListScreen_textAlert);



    }



    //********* Set Value *************************************************************************************************************************************************************************

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

/*

        prefs = getSharedPreferences("UserGuideHomeList", Context.MODE_PRIVATE);

        showPopup();

        if (prefs.getString("Show", "no").equalsIgnoreCase("no")){

            editor = getSharedPreferences("UserGuideHomeList", Context.MODE_PRIVATE).edit();
            editor.putString("Show", "Yes");
            editor.commit();
            showPopup();

        }

*/

        loadmoreFlage=false;

        tv_title.setText(Home_List_Tab.str_name);
        tv_filter.setVisibility(View.VISIBLE);


        HomeList_AsyncTask home = new HomeList_AsyncTask(Home_ListScreen_Activity.this, homeList, lv_listView ,tv_alert,adapter,footerView,""+start, ""+end,filterflage);
        home.execute(hashMap.get(SessionStore.USER_ID), Home_List_Tab.ID, hashMap.get(SessionStore.UNIVERSITY_ID), ""+start, ""+end);


        tv_filter.setOnClickListener(Home_ListScreen_Activity.this);
        tv_save.setOnClickListener(Home_ListScreen_Activity.this);


        //lv_listView.addFooterView(footerView);




        lv_listView.setOnScrollListener(new AbsListView.OnScrollListener() {
                @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {


            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {

                if ((firstVisibleItem + visibleItemCount - 1) == homeList.size() && !(loadmoreFlage))
                {

                    loadmoreFlage=true;
                    start = start+10;
                    end = 10;

                    HomeList_AsyncTask home1 = new HomeList_AsyncTask(Home_ListScreen_Activity.this, homeList, lv_listView ,tv_alert,adapter,footerView,""+start, ""+end,filterflage);
                    home1.execute(hashMap.get(SessionStore.USER_ID), Home_List_Tab.ID, hashMap.get(SessionStore.UNIVERSITY_ID), ""+start, ""+end);


                }


            }
        });
    }

//********* on Click *************************************************************************************************************************************************************************************


    @Override
    public void onClick(View v) {


        switch (v.getId()){

            case R.id.Header_filter:

                filterPopup();
                break;

            case R.id.Header_Save:

                Intent intent = new Intent(Home_ListScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);
                break;






        }//end of Switch


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

        start=0;
        end=10;

        homeList.clear();
        hashMap = SessionStore.getUserDetails(Home_ListScreen_Activity.this, Comman.PRIFRENS_NAME);
        setValue();


    }

//*****Filter popup *****************************************************************************************************************************************************************************
    private void filterPopup()
    {
        adapter= new HomeLIst_Adapter(Home_ListScreen_Activity.this,R.layout.home_list_row, homeList);


        TextView tv_priceHTL, tv_priceLTH,tv_expiryDateSTL,tv_expiryDateLTS,tv_cancel,tv_priceHTLCheck, tv_priceLTHCheck,tv_expiryDateSTLCheck,tv_expiryDateLTSCheck;

        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.postlistfilter_row, null);
        dialog = new Dialog(Home_ListScreen_Activity.this,R.style.PauseDialog);

        tv_priceHTL = (TextView)view.findViewById(R.id.PostListFilter_popup_PriceHTOL);
        tv_priceHTLCheck = (TextView)view.findViewById(R.id.PostListFilter_popup_PriceHTOLCheck);
        tv_priceLTH = (TextView)view.findViewById(R.id.PostListFilter_popup_PriceLTOH);
        tv_priceLTHCheck = (TextView)view.findViewById(R.id.PostListFilter_popup_PriceLTOHCheck);
        tv_expiryDateSTL = (TextView)view.findViewById(R.id.PostListFilter_popup_ExpiryDateSTOL);
        tv_expiryDateSTLCheck = (TextView)view.findViewById(R.id.PostListFilter_popup_ExpiryDateSTOLCheck);
        tv_expiryDateLTS = (TextView)view.findViewById(R.id.PostListFilter_popup_ExpiryDateLTOS);
        tv_expiryDateLTSCheck = (TextView)view.findViewById(R.id.PostListFilter_popup_ExpiryDateLTOSCheck);
        tv_cancel = (TextView)view.findViewById(R.id.PostListFilter_popup_Cancel);



        if (filterflage==0)
        {
            tv_priceHTLCheck.setText("");
            tv_priceLTHCheck.setText("");
            tv_expiryDateSTLCheck .setText("");
            tv_expiryDateLTSCheck.setText("");


        }
        else if(filterflage==1)
        {

            tv_priceHTLCheck.setText(getString(R.string.fa_check));
            tv_priceLTHCheck.setText("");
            tv_expiryDateSTLCheck .setText("");
            tv_expiryDateLTSCheck.setText("");


        }
        else if(filterflage==2)
        {
            tv_priceHTLCheck.setText("");
            tv_priceLTHCheck.setText(getString(R.string.fa_check));
            tv_expiryDateSTLCheck .setText("");
            tv_expiryDateLTSCheck.setText("");

        }else if(filterflage==3){

            tv_priceHTLCheck.setText("");
            tv_priceLTHCheck.setText("");
            tv_expiryDateSTLCheck .setText(getString(R.string.fa_check));
            tv_expiryDateLTSCheck.setText("");

        }else if(filterflage==4){

            tv_priceHTLCheck.setText("");
            tv_priceLTHCheck.setText("");
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



        tv_priceHTL.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                ((HomeLIst_Adapter)adapter).sortByPriceAse();
                filterflage = 1;
                dialog.dismiss();
                lv_listView.setAdapter(adapter);


            }
        });


        tv_priceLTH.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                ((HomeLIst_Adapter)adapter).sortByPriceDes();

                filterflage = 2;
                dialog.dismiss();
                lv_listView.setAdapter(adapter);
            }
        });


        tv_expiryDateSTL.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                ((HomeLIst_Adapter)adapter).sortByExpiryDateAse();
                filterflage = 3;
                dialog.dismiss();
                lv_listView.setAdapter(adapter);
            }
        });


        tv_expiryDateLTS.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub

                ((HomeLIst_Adapter)adapter).sortByExpiryDateDes();
                filterflage =4;
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

    //**************** Popup ***********************************************************************************************************************************************************************
    private void showPopup()
    {



        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(LAYOUT_INFLATER_SERVICE);
        View view = layoutInflater.inflate(R.layout.user_guide_row, null);

        dialog = new Dialog(Home_ListScreen_Activity.this);

        ll_outside = (LinearLayout)view.findViewById(R.id.UserGuideRow);
        iv_clickHear = (ImageView)view.findViewById(R.id.UserGuideRow_image);

        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));



        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(view);
        WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
        lp.copyFrom(dialog.getWindow().getAttributes());
        lp.width = Comman.DEVICE_WIDTH;
        lp.height = Comman.DEVICE_HEIGHT;


        dialog.show();
        dialog.getWindow().setAttributes(lp);



        ll_outside.setPadding(Comman.DEVICE_WIDTH /5, Comman.DEVICE_WIDTH / 5, 0, 0);
        ll_outside.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });

    }



    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(Home_ListScreen_Activity.this);
    }


}
