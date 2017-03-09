package com.thriftskool.thriftskool1.profile;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.SpleshScreen_Activity;
import com.thriftskool.thriftskool1.asynctask.ClassList_AsyncTask;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.changepassword.ChangePassword_Tab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.contact_aap_admin.ContactAppAdmin_Tab_Activity;
import com.thriftskool.thriftskool1.edit_profile.EditProfile_Tab_Activity;
import com.thriftskool.thriftskool1.inbox.InBox_Tab_Activity;
import com.thriftskool.thriftskool1.login.LoginScreen_Activity;
import com.thriftskool.thriftskool1.login_signup.LoginSignupScreen_Activity;
import com.thriftskool.thriftskool1.mypost.MyPostList_Tab_Activity;
import com.thriftskool.thriftskool1.notofication_list.NotificationListScreen_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.session.sessionsCount;
import com.thriftskool.thriftskool1.watch_list.WatchList_Tab_Activity;

import java.util.HashMap;

public class ProfileScreen_Activity extends Activity implements View.OnClickListener
{

    private TextView tv_back, tv_title, tv_Save, tv_userName, tv_universityName, tv_signout,tv_countNotification;
    private ImageView iv_logo;
    private LinearLayout ll_myProfile, ll_watchList, ll_editProfile, ll_inbox, ll_changePassword, ll_contactAppAdmin,ll_signout, ll_logoLayout,ll_invite_friend;
    private HashMap<String , String> hashMap = new HashMap<String , String>();
    private HashMap<String, String> hasMapcount = new HashMap<String, String>();

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile_screen_);

        hashMap = SessionStore.getUserDetails(ProfileScreen_Activity.this, Comman.PRIFRENS_NAME);
        hasMapcount = sessionsCount.getCount(ProfileScreen_Activity.this, Comman.PRIFRENS_NAME);


        ClassList_AsyncTask asyncTask=new ClassList_AsyncTask(ProfileScreen_Activity.this);
        asyncTask.execute();

        maping();
    }


    //********** Maping ************************************************************************************************************************************************************************

    private void maping()
    {

        //TextView
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_Save  = (TextView)findViewById(R.id.Header_Save);
        tv_userName  = (TextView)findViewById(R.id.ProfileScreen_userName);
        tv_universityName  = (TextView)findViewById(R.id.ProfileScreen_universityName);
        tv_signout  = (TextView)findViewById(R.id.ProfileScreen_signout);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        //ImageView
        iv_logo = (ImageView)findViewById(R.id.ProfileScreen_logo);


        //Linear Layout
        ll_myProfile = (LinearLayout)findViewById(R.id.ProfileScreen_myPostLayout);
        ll_watchList = (LinearLayout)findViewById(R.id.ProfileScreen_watchlistLayout);
        ll_inbox = (LinearLayout)findViewById(R.id.ProfileScreen_inboxLayout);
        ll_editProfile = (LinearLayout)findViewById(R.id.ProfileScreen_editProfileLayout);
        ll_changePassword = (LinearLayout)findViewById(R.id.ProfileScreen_changePasswordLayout);
        ll_contactAppAdmin = (LinearLayout)findViewById(R.id.ProfileScreen_contactAppAdminLayout);
        ll_signout = (LinearLayout)findViewById(R.id.ProfileScreen_signoutLayout);
        ll_logoLayout = (LinearLayout)findViewById(R.id.ProfileScreen_logoLayout);
        ll_invite_friend = (LinearLayout)findViewById(R.id.ProfileScreen_invite_friend);

        setValue();
    }

    //************ Set Value *******************************************************************************************************************************************************************

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


        tv_title.setText(getString(R.string.title_profilescreen));
        tv_universityName.setText(hashMap.get(SessionStore.UNIVERSITY_NAME));
        tv_userName.setText(hashMap.get(SessionStore.USER_NAME));


        iv_logo.setMaxWidth(Comman.DEVICE_WIDTH / 5);
        iv_logo.setMaxHeight(Comman.DEVICE_WIDTH / 5);
        iv_logo.setMinimumWidth(Comman.DEVICE_WIDTH / 5);
        iv_logo.setMinimumHeight(Comman.DEVICE_WIDTH / 5);


        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 5, Comman.DEVICE_WIDTH / 5);
        iv_logo.setLayoutParams(myParams);

        if (!hashMap.get(SessionStore.PROFILE_IMG).equalsIgnoreCase("") || !hashMap.get(SessionStore.PROFILE_IMG).equalsIgnoreCase("null") || hashMap.get(SessionStore.PROFILE_IMG)!=null)
        {
            Picasso.with(ProfileScreen_Activity.this).load(hashMap.get(SessionStore.PROFILEIMG_PATH)+hashMap.get(SessionStore.PROFILE_IMG)).resize(Comman.DEVICE_WIDTH/5,Comman.DEVICE_WIDTH/5).into(iv_logo);
            Log.e("PAth....","  if "+hashMap.get(SessionStore.PROFILEIMG_PATH)+hashMap.get(SessionStore.PROFILE_IMG));

        }
        else
        {
            Picasso.with(ProfileScreen_Activity.this).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH/5,Comman.DEVICE_WIDTH/5).into(iv_logo);
            Log.e("PAth....", "  else " + hashMap.get(SessionStore.PROFILEIMG_PATH) + hashMap.get(SessionStore.PROFILE_IMG));

        }


        ll_myProfile.setOnClickListener(ProfileScreen_Activity.this);
        ll_watchList.setOnClickListener(ProfileScreen_Activity.this);
        ll_inbox.setOnClickListener(ProfileScreen_Activity.this);
        ll_editProfile.setOnClickListener(ProfileScreen_Activity.this);
        ll_changePassword.setOnClickListener(ProfileScreen_Activity.this);
        ll_contactAppAdmin.setOnClickListener(ProfileScreen_Activity.this);
        ll_signout.setOnClickListener(ProfileScreen_Activity.this);
        ll_invite_friend.setOnClickListener(ProfileScreen_Activity.this);
        tv_Save.setOnClickListener(ProfileScreen_Activity.this);


    }


    //********* On Click ***********************************************************************************************************************************************************************
    @Override
    public void onClick(View v) {

        Intent intent = null;




        switch (v.getId())
        {

            case R.id.ProfileScreen_myPostLayout:

                if (CheckInterNetConnection.isNetworkAvailable(ProfileScreen_Activity.this))
                {
                  intent = new Intent(ProfileScreen_Activity.this, MyPostList_Tab_Activity.class);
                  startActivity(intent);
                  overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                }
                else
                {

                    new AlertDialog.Builder(ProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            }).show();
                }

                break;



            case R.id.ProfileScreen_watchlistLayout:
                if (CheckInterNetConnection.isNetworkAvailable(ProfileScreen_Activity.this))
                {
                intent = new Intent(ProfileScreen_Activity.this, WatchList_Tab_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                }
                else
                {

                    new AlertDialog.Builder(ProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {



                                }
                            }).show();
                }

                break;




            case R.id.ProfileScreen_inboxLayout:

                if (CheckInterNetConnection.isNetworkAvailable(ProfileScreen_Activity.this))
                {
                intent = new Intent(ProfileScreen_Activity.this, InBox_Tab_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                }
                else
                {

                    new AlertDialog.Builder(ProfileScreen_Activity.this)
                            .setTitle("Alert!")
                            .setMessage(getString(R.string.internetconnection_alert))
                            .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                }
                            }).show();
                }

                break;


            case R.id.ProfileScreen_editProfileLayout:

                intent = new Intent(ProfileScreen_Activity.this, EditProfile_Tab_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);


                break;




            case R.id.ProfileScreen_changePasswordLayout:

                intent = new Intent(ProfileScreen_Activity.this, ChangePassword_Tab_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                break;




            case R.id.ProfileScreen_contactAppAdminLayout:


                intent = new Intent(ProfileScreen_Activity.this, ContactAppAdmin_Tab_Activity.class);
                startActivity(intent);
                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);

                break;

            case R.id.ProfileScreen_invite_friend:

                Uri uri = Uri.parse("smsto:0");

                Intent intent1 = new Intent(Intent.ACTION_SENDTO,uri);
               // intent.setData(Uri.parse("smsto:" + Uri.encode("1223")));
             //   intent1.setType("vnd.android-dir/mms-sms");
                intent1.putExtra("sms_body","“Hey! Download ThriftSkool :) https://play.google.com/store/apps/details?id=com.thriftskool.thriftskool1");
                startActivity(intent1);
/*
                Intent intent1 =new Intent(intent.ACTION_VIEW);
                intent1.setType("vnd.android-dir/mms-sms");

               // intent1.putExtra("address", "121212");
                intent1.putExtra("sms_body","“Hey! Download ThriftSkool :) https://www.thriftskool.com");
                startActivity(intent1);
*/
                break;




            case R.id.ProfileScreen_signoutLayout:


                new AlertDialog.Builder(ProfileScreen_Activity.this)
                        .setTitle("Alert!")
                        .setCancelable(false)
                        .setMessage(getString(R.string.signoutalert_profilescreen))
                        .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                SessionStore.clear(ProfileScreen_Activity.this, Comman.PRIFRENS_NAME);
                                Intent intent = new Intent(ProfileScreen_Activity.this, LoginSignupScreen_Activity.class);
                                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                startActivity(intent);
                                overridePendingTransition(R.anim.right_slide_in, R.anim.left_side_out);
                                finish();

                            }
                        }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                }).show();



                break;




            case R.id.Header_Save:

                intent = new Intent(ProfileScreen_Activity.this, NotificationListScreen_Activity.class);
                startActivity(intent);


                break;




        }//end of switch


    }


    @Override
    protected void onResume() {
        super.onResume();


        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        Comman.DEVICE_HEIGHT = dm.heightPixels;
        Comman.DEVICE_WIDTH = dm.widthPixels;

        hashMap = SessionStore.getUserDetails(ProfileScreen_Activity.this, Comman.PRIFRENS_NAME);

        tv_universityName.setText(hashMap.get(SessionStore.UNIVERSITY_NAME));
        tv_userName.setText(hashMap.get(SessionStore.USER_NAME));

        Log.e("PAth....", "  resume " + hashMap.get(SessionStore.PROFILEIMG_PATH) + hashMap.get(SessionStore.PROFILE_IMG));

        Picasso.with(ProfileScreen_Activity.this).load(hashMap.get(SessionStore.PROFILEIMG_PATH)+hashMap.get(SessionStore.PROFILE_IMG)).resize(Comman.DEVICE_WIDTH/5,Comman.DEVICE_WIDTH/5).into(iv_logo);

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
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(ProfileScreen_Activity.this);
    }

}
