package com.thriftskool.thriftskool1.notofication_list;

import android.app.Activity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.NotificationList_AsyncTask;
import com.thriftskool.thriftskool1.been.NotoficationList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 9/9/15.
 */
public class NotificationListScreen_Activity extends Activity {

    private ListView lv_listView;
    private TextView tv_title, tv_back, tv_save, tv_filter, tv_alert,tv_countNotification;
    private List<NotoficationList_Been> notificationList = new ArrayList<NotoficationList_Been>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home__list_screen_);
        hashMap = SessionStore.getUserDetails(NotificationListScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();

    }


    //************** Maping **********************************************************************************************************************************************************************

    private void maping()
    {
        lv_listView = (ListView)findViewById(R.id.HomeListScreen_ListView);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_filter = (TextView)findViewById(R.id.Header_filter);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);
        tv_alert = (TextView)findViewById(R.id.HomeListScreen_textAlert);

        setValue();
    }


    //********* Set Value *************************************************************************************************************************************************************************

    private void setValue()

    {
        tv_countNotification.setVisibility(View.INVISIBLE);
        tv_title.setText("Notifications");
        tv_filter.setVisibility(View.GONE);
        tv_save.setVisibility(View.GONE);


        NotificationList_AsyncTask home = new NotificationList_AsyncTask(NotificationListScreen_Activity.this, notificationList, lv_listView ,tv_alert);
        home.execute(hashMap.get(SessionStore.USER_ID));



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

        hashMap = SessionStore.getUserDetails(NotificationListScreen_Activity.this, Comman.PRIFRENS_NAME);
    }


    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(NotificationListScreen_Activity.this);
    }

}
