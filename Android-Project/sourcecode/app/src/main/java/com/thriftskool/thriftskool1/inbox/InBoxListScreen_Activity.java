package com.thriftskool.thriftskool1.inbox;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AbsListView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.InBoxList_Adapter;
import com.thriftskool.thriftskool1.asynctask.CampusBuzzList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.InBoxList_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.widgets.TextAwesome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class InBoxListScreen_Activity extends Activity {

    private ListView lv_listView;
    private TextView tv_back,tv_title,tv_save,tv_alert,tv_Edit,tv_countNotification;
    TextAwesome tv_delete,tv_selectAll;
    private HashMap<String,String> hashMap = new HashMap<String,String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private List<HomeList_Been> inboxList = new ArrayList<HomeList_Been>();
    private View footerView;
    private int start=0,end=10;
    public static boolean inboxloadmoreFlage=false;
    Context context;
    public int chkValue,delValue,editValue;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_in_boc_list_screen_);

        hashMap = SessionStore.getUserDetails(InBoxListScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(InBoxListScreen_Activity.this, Comman.PRIFRENS_NAME);

        context=InBoxListScreen_Activity.this;

        maping();

    }

    //********* MAping -***********************************************************************************************************************************************************************

    private void maping()
    {
        footerView = ((LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.load_more_row, null);

        lv_listView  = (ListView)findViewById(R.id.InBoxScreen_listView);

        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_delete = (TextAwesome)findViewById(R.id.Header_Delte);
        tv_selectAll = (TextAwesome)findViewById(R.id.Header_SelectAll);
        tv_alert = (TextView)findViewById(R.id.InBoxScreen_textAlert);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        setValue();

    }

    //********** setValue    **********************************************************************************************************************************************************************

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


        inboxloadmoreFlage=false;

        tv_selectAll.setVisibility(View.VISIBLE);
        tv_back.setVisibility(View.VISIBLE);
        tv_title.setText("My Messages");

        Log.e("Delvalue Activity", " " + this.delValue);
        Log.e("Selvalue Activity", " " + this.chkValue);
        Log.e("editValue Activity", " " + this.editValue);

        InBoxList_AsyncTask mess = new InBoxList_AsyncTask(InBoxListScreen_Activity.this,inboxList, lv_listView, tv_alert,footerView, "" + start, "" + end,delValue,chkValue,editValue);
        mess.execute(hashMap.get(SessionStore.USER_ID), "" + start, "" + end);



        lv_listView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {


            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {

                if ((firstVisibleItem + visibleItemCount - 1) == inboxList.size() && !(inboxloadmoreFlage)) {

                    inboxloadmoreFlage = true;
                    start = start + 10;
                    end = 10;

                    InBoxList_AsyncTask mess = new InBoxList_AsyncTask(InBoxListScreen_Activity.this, inboxList, lv_listView, tv_alert, footerView, "" + start, "" + end, delValue, chkValue,editValue);
                    mess.execute(hashMap.get(SessionStore.USER_ID), "" + start, "" + end);

                }

            }
        });

        tv_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {


                editValue=2;
                  //  chkValue=0;
                   // delValue=0;

                lv_listView.setAdapter(new InBoxList_Adapter(context,inboxList, delValue, chkValue, editValue));
              //  lv_listView.setSelectionFromTop(position, 0);


            }
        });

        tv_selectAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
              // int position = lv_listView.getFirstVisiblePosition();

                 chkValue = 2;
                //    editValue=0;
                lv_listView.setAdapter(new InBoxList_Adapter(context,inboxList, delValue, chkValue, editValue));
            //   lv_listView.setSelectionFromTop(position, 0);

                tv_selectAll.setVisibility(View.GONE);
                tv_delete.setVisibility(View.VISIBLE);
            }
        });

        tv_delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {
              //  int position = lv_listView.getFirstVisiblePosition();

                delValue=2;
              //  chkValue=0;
              //  editValue=0;

                lv_listView.setAdapter(new InBoxList_Adapter(context,inboxList, delValue, chkValue, editValue));
             //  lv_listView.setSelectionFromTop(position, 0);

            }
        });


        tv_save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                Intent intent = new Intent(InBoxListScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


            }
        });

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


        hashMap = SessionStore.getUserDetails(InBoxListScreen_Activity.this, Comman.PRIFRENS_NAME);
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(InBoxListScreen_Activity.this);
    }

}
