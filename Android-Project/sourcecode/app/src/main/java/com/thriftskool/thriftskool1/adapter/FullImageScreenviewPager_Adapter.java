package com.thriftskool.thriftskool1.adapter;

import android.content.Context;
import android.content.Intent;
import android.os.Parcelable;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.full_Image.FullImageScreen_Activity;

import java.util.ArrayList;

/**
 * Created by etiloxadmin on 4/9/15.
 */
public class FullImageScreenviewPager_Adapter extends PagerAdapter {

    Context context;
    private ArrayList<String> imageList = new ArrayList<String>();


    public FullImageScreenviewPager_Adapter(Context act, ArrayList<String> imageList) {
        this.imageList = imageList;
        context = act;
    }

    public int getCount() {
        return imageList.size();
    }

    public Object instantiateItem(View collection, final int position) {

        LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.full_image_row, null);


        ImageView image = (ImageView)view.findViewById(R.id.FullImageViewPager_Row_image);


//		Picasso.with(context).load(imageList.get(position).getImagepath()+""+imageList.get(position).getImage()).fit().centerCrop().into(image);

        if (!imageList.get(position).equalsIgnoreCase("") || !imageList.get(position).equalsIgnoreCase("null"))
        {
            Picasso.with(context).load(imageList.get(position)).into(image);

        }else{

            Picasso.with(context).load(R.drawable.lodingicon).into(image);

        }


        ((ViewPager) collection).addView(view, 0);
        return view;
    }

    @Override
    public void destroyItem(View arg0, int arg1, Object arg2) {
        ((ViewPager) arg0).removeView((View) arg2);
    }

    @Override
    public boolean isViewFromObject(View arg0, Object arg1) {
        return arg0 == ((View) arg1);
    }

    @Override
    public Parcelable saveState() {
        return null;
    }
}
