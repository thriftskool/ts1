package com.thriftskool.thriftskool1.reply_messag_detail;

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
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.InBoxDetailList_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.ReplyMessageDetail_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.SendMessage_AsyncTask;
import com.thriftskool.thriftskool1.been.InBoxDetaiList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.inbox_detail.InBoxDetail_Tab_Activity;
import com.thriftskool.thriftskool1.inbox_post_detail.InBoxPostDetail_Tab_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.search_category.SearchCategory_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.widgets.AmazingListView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 1/10/15.
 */
public class ReplyMessageDetailScreen_Activity extends Activity implements View.OnKeyListener{

    private EditText et_message;
    private TextView tv_send, tv_back, tv_maintitle, tv_title, tv_save,tv_countNotification;
    private AmazingListView lv_listView;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();
    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();
    private List<InBoxDetaiList_Been> messageList1 = new ArrayList<InBoxDetaiList_Been>();
    private List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList = new ArrayList<Pair<String, List<InBoxDetaiList_Been>>>();

    int value=0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_in_box_detail_screen_);

        hashMap = SessionStore.getUserDetails(ReplyMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(ReplyMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);

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
        int abc=Integer.parseInt(hasMapcount.get(sessionsCount.COUNT));

        if(abc<=0)        {
            tv_countNotification.setVisibility(View.INVISIBLE);
        }
        else
        {
            tv_countNotification.setText(hasMapcount.get(sessionsCount.COUNT));
        }

        tv_title.setText("MESSAGES DETAIL");
        //tv_maintitle.setText(ReplyMessageDetail_Tab_Activity.str_postName);

        ReplyMessageDetail_AsyncTask mess = new ReplyMessageDetail_AsyncTask(ReplyMessageDetailScreen_Activity.this, messageList, lv_listView,tv_maintitle ,ReplyMessageDetail_Tab_Activity.str_postName,messageList1,pairMessageList);
        mess.execute(hashMap.get(SessionStore.USER_ID), ReplyMessageDetail_Tab_Activity.str_PostId);



        tv_save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (CheckInterNetConnection.isNetworkAvailable(ReplyMessageDetailScreen_Activity.this)) {
                    Intent intent = new Intent(ReplyMessageDetailScreen_Activity.this, NotificationListScreen_Activity.class);
                    startActivity(intent);
                } else {

                    new AlertDialog.Builder(ReplyMessageDetailScreen_Activity.this)
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



        tv_maintitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (CheckInterNetConnection.isNetworkAvailable(ReplyMessageDetailScreen_Activity.this)) {
                    Intent intent = new Intent(ReplyMessageDetailScreen_Activity.this, InBoxPostDetail_Tab_Activity.class);
                    intent.putExtra("ID",ReplyMessageDetail_Tab_Activity.str_PostId.trim());
                    intent.putExtra("UserId",ReplyMessageDetail_Tab_Activity.str_userId.trim());
                    intent.putExtra("PostUserId",ReplyMessageDetail_Tab_Activity.str_postUserid.trim());
                    intent.putExtra("PostName",ReplyMessageDetail_Tab_Activity.str_postName.trim());

                    startActivity(intent);
                } else {

                    new AlertDialog.Builder(ReplyMessageDetailScreen_Activity.this)
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


        et_message.setOnKeyListener(ReplyMessageDetailScreen_Activity.this);


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

        hashMap = SessionStore.getUserDetails(ReplyMessageDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
    }




    @Override
    public boolean onKey(View v, int keyCode, KeyEvent event) {



        if ((event.getAction() == KeyEvent.ACTION_DOWN) && (keyCode == KeyEvent.KEYCODE_ENTER)) {

            SendMessage_AsyncTask messa = new SendMessage_AsyncTask(ReplyMessageDetailScreen_Activity.this, et_message, lv_listView, messageList,tv_send,tv_maintitle,ReplyMessageDetail_Tab_Activity.str_postName,ReplyMessageDetail_AsyncTask.str_ThreadId,messageList1,pairMessageList);
            messa.execute(ReplyMessageDetail_Tab_Activity.str_PostId, hashMap.get(SessionStore.USER_ID), hashMap.get(SessionStore.USER_NAME), et_message.getText().toString().trim(), DateCoversion.getUTCDateTime(),ReplyMessageDetail_Tab_Activity.str_postName,ReplyMessageDetail_Tab_Activity.str_ThreadId,ReplyMessageDetail_Tab_Activity.str_userId);

            return true;

        }



        InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(v.getWindowToken(), 0);


        return false;
    }


    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(ReplyMessageDetailScreen_Activity.this);
    }

}
