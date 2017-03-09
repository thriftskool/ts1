package com.thriftskool.thriftskool1.edit_post;

import android.app.TabActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TabHost;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.campus_buzz_list.CampusBuzzListScreen_Activity;
import com.thriftskool.thriftskool1.campus_deal_list.CampusDealListScreen_Activity;
import com.thriftskool.thriftskool1.edit_profile.EditProfileScreen_Activity;
import com.thriftskool.thriftskool1.home.HomeScreen_Activity;
import com.thriftskool.thriftskool1.post.PostScreen_Activity;
import com.thriftskool.thriftskool1.profile.ProfileScreen_Activity;

/**
 * Created by etiloxadmin on 20/8/15.
 */
public class EditPost_Tab_Activity extends TabActivity {

    private TabHost th_tabHost;
    private TabHost.TabSpec ts_home, ts_post, ts_profile, ts_deals, ts_buzz;
    public static String str_postId, str_userId;
    private Intent intent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_tab_screen_);

        intent = getIntent();
        str_postId = intent.getStringExtra("PostId");
        str_userId = intent.getStringExtra("UserId");

        maping();

    }


    //************** Maping **************************************************************************************************************************************************************

    private void maping()
    {

        th_tabHost = getTabHost();

        ts_home = th_tabHost.newTabSpec(getString(R.string.home_hometabscreen));
        ts_home.setIndicator("");
        Intent homeintent = new Intent(EditPost_Tab_Activity.this,HomeScreen_Activity.class);
        // homeintent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        ts_home.setContent(homeintent);
        th_tabHost.addTab(ts_home);
        th_tabHost.getTabWidget().getChildAt(0).setBackgroundResource(R.drawable.home_tab);



        ts_post = th_tabHost.newTabSpec(getString(R.string.post_hometabscreen));
        ts_post.setIndicator("");
        Intent postintent = new Intent(EditPost_Tab_Activity.this,PostScreen_Activity.class);
        //postintent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        ts_post.setContent(postintent);
        th_tabHost.addTab(ts_post);
        th_tabHost.getTabWidget().getChildAt(1).setBackgroundResource(R.drawable.post_tab);




        ts_profile = th_tabHost.newTabSpec(getString(R.string.profile_hometabscreen));
        ts_profile.setIndicator("");
        Intent profileintent = new Intent(EditPost_Tab_Activity.this,EditPostScreen_Activity.class);
        // profileintent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        ts_profile.setContent(profileintent);
        th_tabHost.addTab(ts_profile);
        th_tabHost.getTabWidget().getChildAt(2).setBackgroundResource(R.drawable.profile_tab);




    /*    ts_deals = th_tabHost.newTabSpec(getString(R.string.deals_hometabscreen));
        ts_deals.setIndicator("");
        Intent dealsintent = new Intent(EditPost_Tab_Activity.this,CampusDealListScreen_Activity.class);
        // dealsintent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        ts_deals.setContent(dealsintent);
        th_tabHost.addTab(ts_deals);
        th_tabHost.getTabWidget().getChildAt(3).setBackgroundResource(R.drawable.deals_tab);

*/


        ts_buzz = th_tabHost.newTabSpec(getString(R.string.buzz_hometabscreen));
        ts_buzz.setIndicator("");
        Intent buzzintent = new Intent(EditPost_Tab_Activity.this,CampusBuzzListScreen_Activity.class);
        //buzzintent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        ts_buzz.setContent(buzzintent);
        th_tabHost.addTab(ts_buzz);
        th_tabHost.getTabWidget().getChildAt(3).setBackgroundResource(R.drawable.buzz_tab);


        th_tabHost.setCurrentTab(2);
    }







}
