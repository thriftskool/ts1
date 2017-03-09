package com.thriftskool.thriftskool1.full_Image;

import android.app.Activity;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.Window;
import android.widget.LinearLayout;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.FullImageScreenviewPager_Adapter;
import com.thriftskool.thriftskool1.adapter.ViewPagerAdapter;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;

import java.util.ArrayList;
import java.util.List;


public class FullImageScreen_Activity extends Activity {

    private ViewPager viewpag_viewPager;
    private ArrayList<String> imageList = new ArrayList<String>();
    private int pos=0;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_full_image_screen_);


        imageList = getIntent().getStringArrayListExtra("ImageList");
        pos = getIntent().getIntExtra("Position",0);

        Log.e("size","Size of full image: "+imageList.size());

        maping();

    }



    //*********************** Maping **********************************************************************************************************************************************************

    private void maping()
    {

        viewpag_viewPager = (ViewPager)findViewById(R.id.FullIMageScreen_viewPager);


    }


    //************** Set Value ****************************************************************************************************************************************************************


    private void setValue(){

        viewpag_viewPager.setAdapter(new FullImageScreenviewPager_Adapter(FullImageScreen_Activity.this, imageList));

        viewpag_viewPager.setCurrentItem(pos);
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

        setValue();
    }

    @Override
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(FullImageScreen_Activity.this);
    }


    }
