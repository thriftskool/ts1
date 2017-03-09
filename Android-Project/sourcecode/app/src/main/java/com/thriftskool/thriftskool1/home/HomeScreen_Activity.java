package com.thriftskool.thriftskool1.home;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.MostRecentPost.MostRecentPost_Tab_Activity;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.HomeCategoryList_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.gsm_meassge.MyIntentService;
import com.thriftskool.thriftskool1.notification_detail.NotificationMessageDetailScreen_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.search_category.SearchCategory_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.thriftskool.thriftskool1.session.sessionsCount;

public class HomeScreen_Activity extends Activity implements View.OnKeyListener{

    private GridView gv_gridView;
    public static  List<HomeCategory_List_Been> categotyList = new ArrayList<HomeCategory_List_Been>();
    private HashMap<String, String> hasMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private EditText et_Search;
    private TextView tv_save,tv_logo,tv_countNotification,tv_mostList;
    private int value=0;
    private  Dialog dialog=null;
    private LinearLayout ll_outside;
    private ImageView iv_clickHear;
    private SharedPreferences prefs;
    private SharedPreferences.Editor editor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_screen_);


        hasMap = SessionStore.getUserDetails(HomeScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(HomeScreen_Activity.this, Comman.PRIFRENS_NAME);

        maping();


    }

    //************ Maping *************************************************************************************************************************************************************************

    private void maping()
    {

        gv_gridView = (GridView)findViewById(R.id.HoneScreen_GridView);
        et_Search = (EditText)findViewById(R.id.Homesearch);
        tv_save = (TextView)findViewById(R.id.Home_save);
        tv_logo = (TextView)findViewById(R.id.Home_logo);
        tv_countNotification=(TextView)findViewById(R.id.badge);
        tv_mostList=(TextView)findViewById(R.id.Home_back);

        setValue();

        tv_mostList.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v) {


                Intent intents =new Intent(HomeScreen_Activity.this, MostRecentPost_Tab_Activity.class);
                startActivity(intents);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

            }
        });

        tv_save.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Intent intent = new Intent(HomeScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);
            }
        });

    }


    //*************** Set Value *******************************************************************************************************************************************************************

    private void setValue()
    {

       /* prefs = getSharedPreferences("UserGuideHome", Context.MODE_PRIVATE);


        if (prefs.getString("Show", "no").equalsIgnoreCase("no")){

            editor = getSharedPreferences("UserGuideHome", Context.MODE_PRIVATE).edit();
            editor.putString("Show", "Yes");
            editor.commit();
            showPopup(tv_save);

        } */

        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)
        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
         else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }


        et_Search.setOnKeyListener(HomeScreen_Activity.this);
       // tv_logo.setText(hasMap.get(SessionStore.UNIVERSITY_NAME) + " ThriftSkool");

        float f = 0;
        //tv_logo.setTextSize(f+((float)(Comman.DEVICE_WIDTH*.10)/100));

        Log.e("fsdfsdf", "fsdfsdfsd: " + ((Comman.DEVICE_WIDTH * 0.25)));
        HomeCategoryList_AsyncTask category = new HomeCategoryList_AsyncTask(HomeScreen_Activity.this, categotyList, gv_gridView);
        category.execute(hasMap.get(SessionStore.USER_ID));

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
    public boolean onKey(View v, int keyCode, KeyEvent event) {



        if (keyCode==4)
        {
        onBackPressed();
        }
        else if (et_Search.getText().toString().trim().equalsIgnoreCase(""))
        {

                Toast.makeText(HomeScreen_Activity.this,getString(R.string.blank_searchbox_alert),Toast.LENGTH_SHORT).show();
        }
        else
        {
            value++;

            if (value==1)
            {
                    Intent intent = new Intent(HomeScreen_Activity.this, SearchCategory_Tab_Activity.class);
                    intent.putExtra("SearchKeyWord", et_Search.getText().toString().trim());
                    startActivity(intent);

            }

        }

        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(v.getWindowToken(), 0);


        return true;
    }


    @Override
    protected void onResume() {
        super.onResume();

        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        hasMap= SessionStore.getUserDetails(HomeScreen_Activity.this, Comman.PRIFRENS_NAME);

        if (hasMap.get(SessionStore.UNIVERSITY_NAME).contains("ThriftSkool")){
            tv_logo.setText(hasMap.get(SessionStore.UNIVERSITY_NAME) + " ThriftSkool");
        //    tv_logo.setText(hasMap.get(SessionStore.UNIVERSITY_NAME));

        }else{

            tv_logo.setText(hasMap.get(SessionStore.UNIVERSITY_NAME) + " ThriftSkool");

        }





        value=0;
    }


    //**************** Popup ***********************************************************************************************************************************************************************
    private void showPopup(View v)
    {


        LayoutInflater layoutInflater = (LayoutInflater)getSystemService(LAYOUT_INFLATER_SERVICE);
        View view = layoutInflater.inflate(R.layout.user_guide_row, null);

        dialog = new Dialog(HomeScreen_Activity.this);

        ll_outside = (LinearLayout)view.findViewById(R.id.UserGuideRow);
        iv_clickHear = (ImageView)view.findViewById(R.id.UserGuideRow_image);

        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));

        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
        lp.copyFrom(dialog.getWindow().getAttributes());
        lp.width = Comman.DEVICE_WIDTH;
        lp.height = Comman.DEVICE_HEIGHT;
        dialog.setContentView(view);
        dialog.show();
        dialog.getWindow().setAttributes(lp);



        ll_outside.setPadding(Comman.DEVICE_WIDTH / 9, Comman.DEVICE_WIDTH / 9, 0, 0);
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

        CrearCashMemmory.trimCache(HomeScreen_Activity.this);

    }



}
