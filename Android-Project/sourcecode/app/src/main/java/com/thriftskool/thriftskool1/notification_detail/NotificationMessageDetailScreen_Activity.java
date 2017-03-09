package com.thriftskool.thriftskool1.notification_detail;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.Pair;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.InBoxDetailList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.NotificationList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.NotificationMessageDetail_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.SendMessage_AsyncTask;
import com.thriftskool.thriftskool1.been.InBoxDetaiList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.gsm_meassge.MyIntentService;
import com.thriftskool.thriftskool1.inbox_detail.InBoxDetail_Tab_Activity;
import com.thriftskool.thriftskool1.inbox_post_detail.InBoxPostDetail_Tab_Activity;
import com.thriftskool.thriftskool1.reply_messag_detail.ReplyMessageDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.widgets.AmazingListView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 15/9/15.
 */
public class NotificationMessageDetailScreen_Activity extends Activity implements View.OnKeyListener {

    private EditText et_message;
    private TextView tv_send, tv_back, tv_maintitle, tv_title, tv_save,tv_countNotification;
    private AmazingListView lv_listView;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();
    private List<InBoxDetaiList_Been> messageList1 = new ArrayList<InBoxDetaiList_Been>();
    private List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList = new ArrayList<Pair<String, List<InBoxDetaiList_Been>>>();
    private String str_postId,str_thredId,str_userId,str_name;
    public static String str_postUserId;
    private Intent intent;
    private ArrayAdapter<InBoxDetaiList_Been> adapter;
    int value=0,abc;
    Context context;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_in_box_detail_screen_);

        hashMap = SessionStore.getUserDetails(NotificationMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(NotificationMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);

        context= NotificationMessageDetailScreen_Activity.this;


        intent = getIntent();
        str_postId = intent.getStringExtra("ID");
        str_userId = intent.getStringExtra("UserID");
        str_thredId = intent.getStringExtra("ThredId");
        str_name = intent.getStringExtra("Name");

        Log.e("uset ID","USer ID: "+str_userId);
        Log.e("uset ID","Post ID: "+str_postId);
        Log.e("uset ID","thred ID: "+str_thredId);
        Log.e("uset ID","Name ID: "+str_name);


        maping();

    }

    //*********** maping ******************************************************************************************************************************************************************

    private void maping()
    {

        //EditText
        et_message = (EditText)findViewById(R.id.InBoxDetailScreen_sendMessage);

        //TextView
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_maintitle = (TextView)findViewById(R.id.InBoxDetailScreen_title);
        tv_send = (TextView)findViewById(R.id.InBoxDetailScreen_send);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);


        //LisrView
        lv_listView = (AmazingListView)findViewById(R.id.InBoxDetailScreen_listView);


        setValue();



    }


    //************ set Value *****************************************************************************************************************************************************************
    private void setValue()
    {
        tv_countNotification.setVisibility(View.INVISIBLE);

        tv_title.setText("MESSAGES DETAIL");
        //tv_maintitle.setText(str_name);
        tv_save.setVisibility(View.GONE);


       abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));
        abc = abc - 1;
        sessionsCount.save(context, Comman.PRIFRENS_NAME,abc);
        Log.e("value Minus"," "+abc);


        NotificationMessageDetail_AsyncTask mess = new NotificationMessageDetail_AsyncTask(NotificationMessageDetailScreen_Activity.this, messageList, lv_listView,tv_maintitle,str_name,messageList1,pairMessageList );
        mess.execute(str_userId, str_thredId, str_postId, null);



        tv_maintitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (CheckInterNetConnection.isNetworkAvailable(NotificationMessageDetailScreen_Activity.this)) {
                    Intent intent = new Intent(NotificationMessageDetailScreen_Activity.this, InBoxPostDetail_Tab_Activity.class);
                    intent.putExtra("ID", str_postId.trim());
                    intent.putExtra("UserId", str_userId.trim());
                    intent.putExtra("PostUserId",str_postUserId.trim());
                    intent.putExtra("PostName", str_name.trim());

                    startActivity(intent);
                } else {

                    new AlertDialog.Builder(NotificationMessageDetailScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {


                                }
                            }).show();


                }


            }


        });

        et_message.setOnKeyListener(NotificationMessageDetailScreen_Activity.this);


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

        hashMap = SessionStore.getUserDetails(NotificationMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
    }




    @Override
    public boolean onKey(View v, int keyCode, KeyEvent event) {


        if ((event.getAction() == KeyEvent.ACTION_DOWN) && (keyCode == KeyEvent.KEYCODE_ENTER)) {
        


            SendMessage_AsyncTask messa = new SendMessage_AsyncTask(NotificationMessageDetailScreen_Activity.this, et_message, lv_listView, messageList, tv_send, tv_maintitle, str_name,ReplyMessageDetail_Tab_Activity.str_ThreadId,messageList1,pairMessageList);
            messa.execute(str_postId, hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.USER_NAME), et_message.getText().toString().trim(), DateCoversion.getUTCDateTime(), str_name,str_thredId,str_userId);


            return true;

        }

        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(v.getWindowToken(), 0);



        return false;
    }


    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(NotificationMessageDetailScreen_Activity.this);
    }

}
