package com.thriftskool.thriftskool1.adapter;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Parcelable;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.Image_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.full_Image.FullImageScreen_Activity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ViewPagerAdapter extends PagerAdapter {

	Context context;
	private ArrayList<String> imageList = new ArrayList<String>();


	public ViewPagerAdapter(Context act, ArrayList<String> imageList) {
		this.imageList = imageList;
		context = act;
	}

	public int getCount() {
		return imageList.size();
	}

	public Object instantiateItem(View collection, final int position) {

		LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

		View view = layoutInflater.inflate(R.layout.viewpager_row, null);


		ImageView image = (ImageView)view.findViewById(R.id.ViewPager_Row_image);


//		Picasso.with(context).load(imageList.get(position).getImagepath()+""+imageList.get(position).getImage()).fit().centerCrop().into(image);


		Log.e("heloooo","czczxczxczxc: "+imageList.get(position));

		if (!imageList.get(position).equalsIgnoreCase("") && !imageList.get(position).equalsIgnoreCase("null") && imageList.get(position)!=null)
		{
			Picasso.with(context).load(imageList.get(position)).fit().centerCrop().into(image);

		}else{

			Picasso.with(context).load(R.drawable.lodingicon).fit().centerCrop().into(image);

		}




		/*image.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {

				if (CheckInterNetConnection.isNetworkAvailable(context))
				{

				Intent intent = new Intent(context, FullImageScreen_Activity.class);
				intent.putExtra("Position", position);
				//intent.putExtra("ImageList",  ArrayList<Image_Been>imageList);
				//intent.getSerializableExtra("ImageList",  imageList);
				intent.putStringArrayListExtra("ImageList", imageList);
				context.startActivity(intent);

				}
				else
				{

					new AlertDialog.Builder(context)
							.setTitle(context.getString(R.string.alert_title))
							.setMessage(context.getString(R.string.internetconnection_alert))
							.setNeutralButton("Ok", new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog, int which) {



								}
							}).show();


				}

			}
		});
*/
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
