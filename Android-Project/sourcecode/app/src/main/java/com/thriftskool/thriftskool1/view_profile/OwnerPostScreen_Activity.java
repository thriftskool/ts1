package com.thriftskool.thriftskool1.view_profile;

import android.app.Activity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;

public class OwnerPostScreen_Activity extends Activity {

    ListView lv_listView;
    HomeLIst_Adapter adpater;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_owner_post_screen_);

        lv_listView=(ListView)findViewById(R.id.OwnerPostScreen_ListView);

        Log.e("List post size..."," "+ ViewProfileScreen_Activity.OwnderPostList);

        adpater = new HomeLIst_Adapter(OwnerPostScreen_Activity.this, R.layout.home_list_row,  ViewProfileScreen_Activity.OwnderPostList);
        lv_listView.setAdapter(adpater);
    }


}
