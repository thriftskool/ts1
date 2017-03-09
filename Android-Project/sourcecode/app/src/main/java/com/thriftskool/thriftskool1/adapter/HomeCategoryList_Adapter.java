package com.thriftskool.thriftskool1.adapter;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.widgets.RoundedTransformation;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 10/8/15.
 */
public class HomeCategoryList_Adapter extends BaseAdapter {

    Context context;
    private List<HomeCategory_List_Been> categotyList = new ArrayList<HomeCategory_List_Been>();


    public  HomeCategoryList_Adapter(Context context, List<HomeCategory_List_Been> categotyList)
    {
        this.context=context;
        this.categotyList=categotyList;

    }

    @Override
    public int getCount() {
        return categotyList.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {

        LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.home_gridview_row, null);

        SquareImageView iv_image = (SquareImageView)view.findViewById(R.id.HomeGridViewRow_image);
        SquareImageView iv_bgimage = (SquareImageView)view.findViewById(R.id.HomeGridViewRow_bgimage);
        SquareImageView iv_bgimagetran = (SquareImageView)view.findViewById(R.id.HomeGridViewRow_bgimagetran);
        TextView tv_name = (TextView)view.findViewById(R.id.HomeGridViewRow_Name);



        iv_bgimage.setAlpha((float)0.25);
        tv_name.setText(categotyList.get(position).getPost_category_name());

        if (!categotyList.get(position).getBackground_image().trim().equalsIgnoreCase("null") && !categotyList.get(position).getBackground_image().trim().equalsIgnoreCase("")) {
       //     Picasso.with(context).load(categotyList.get(position).getImagepath()+categotyList.get(position).getBackground_image()).transform(new RoundedTransformation(12, 0)).into(iv_image);
            Picasso.with(context).load(categotyList.get(position).getImagepath()+categotyList.get(position).getBackground_image()).into(iv_bgimage);
        }
        else
        {
            Picasso.with(context).load(R.drawable.ic_launcher).into(iv_bgimage);

        }


        LinearLayout.LayoutParams myParams = new LinearLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        iv_image.setLayoutParams(myParams);


        if (!categotyList.get(position).getPost_cat_image().equalsIgnoreCase("null") && !categotyList.get(position).getPost_cat_image().trim().equalsIgnoreCase("")) {
            //     Picasso.with(context).load(categotyList.get(position).getImagepath()+categotyList.get(position).getPost_cat_image()).transform(new RoundedTransformation(12, 0)).into(iv_image);
            Picasso.with(context).load(categotyList.get(position).getImagepath() + categotyList.get(position).getPost_cat_image()).resize(Comman.DEVICE_WIDTH/6, Comman.DEVICE_WIDTH/6).into(iv_image);
        }
        else
        {
            Picasso.with(context).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(iv_image);

        }


        iv_bgimage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (CheckInterNetConnection.isNetworkAvailable(context))
                {

                Intent intent =  new Intent(context, Home_List_Tab.class);
                intent.putExtra("ID",categotyList.get(position).getPost_cat_id());
                intent.putExtra("Name",categotyList.get(position).getPost_category_name());

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


        return view;
    }
}
