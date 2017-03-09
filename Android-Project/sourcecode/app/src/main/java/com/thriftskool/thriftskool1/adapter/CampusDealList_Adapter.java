package com.thriftskool.thriftskool1.adapter;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.CampusDealList_Been;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.campus_deal_detail.CampusDealDetail_Tab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealList_Adapter extends ArrayAdapter<CampusDealList_Been> {

    private ListView lv_listView;
    private List<CampusDealList_Been> campusDealsList = new ArrayList<CampusDealList_Been>();
    private Context context;




    public CampusDealList_Adapter(Context context, int resource, List<CampusDealList_Been> objects) {
        super(context, resource, objects);

        this.campusDealsList = objects;
        this.context = context;

    }

    @Override
    public int getCount() {
        return campusDealsList.size();
    }


    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {

        LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.home_list_row, null);

        LinearLayout ll_layout = (LinearLayout)view.findViewById(R.id.HomeListRow);
        SquareImageView image = (SquareImageView)view.findViewById(R.id.HomeListRow_image);
        TextView tv_title = (TextView)view.findViewById(R.id.HomeListRow_title);
        TextView tv_expDate = (TextView)view.findViewById(R.id.HomeListRow_expDate);
        TextView tv_price = (TextView)view.findViewById(R.id.HomeListRow_price);
        TextView ratingBar = (TextView)view.findViewById(R.id.HomeListRow_faverat);



        tv_title.setText(campusDealsList.get(position).getDeal_name().trim());
        //tv_expDate.setText("Exp. in "+DateCoversion.getSelectedDate(campusBuzzList.get(position).getExpirydate().trim()));

        ratingBar.setVisibility(View.GONE);
        tv_price.setVisibility(View.GONE);


       /* if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),campusDealsList.get(position).getExpirydate().trim())>1) {
            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), campusDealsList.get(position).getExpirydate().trim()) + " days");
        }
        else
        {
            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), campusDealsList.get(position).getExpirydate().trim()) + " day");

        }*/




       if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),campusDealsList.get(position).getExpirydate().trim())>1) {

            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), campusDealsList.get(position).getExpirydate().trim()) + " days");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),campusDealsList.get(position).getExpirydate().trim())==0) {

            tv_expDate.setText("Expired Today");
        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),campusDealsList.get(position).getExpirydate().trim())<0) {

           tv_expDate.setText("Expired");
           tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

       }else
        {
            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), campusDealsList.get(position).getExpirydate().trim()) + " day");

        }




        image.setMinimumHeight(Comman.DEVICE_WIDTH/6);
        image.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        image.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        image.setMaxWidth(Comman.DEVICE_WIDTH / 6);

        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        image.setLayoutParams(myParams);



        if (!campusDealsList.get(position).getImage().trim().equalsIgnoreCase("") && !campusDealsList.get(position).getImage().trim().equalsIgnoreCase("null"))
        {
            Picasso.with(context).load(campusDealsList.get(position).getImagepath().trim() + campusDealsList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        }
        else
        {
            Picasso.with(context).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);


        }

        ll_layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (CheckInterNetConnection.isNetworkAvailable(context)) {


                    Intent intent = new Intent(context, CampusDealDetail_Tab_Activity.class);
                    intent.putExtra("ID", campusDealsList.get(position).getDeal_id());
                    intent.putExtra("UserId", campusDealsList.get(position).getUser_id());
                    intent.putExtra("Title", campusDealsList.get(position).getDeal_name());
                    intent.putExtra("ExpDate", campusDealsList.get(position).getExpirydate());
                    intent.putExtra("Desc", campusDealsList.get(position).getDescription());
                    intent.putExtra("CreatDate", campusDealsList.get(position).getCrate_date());
                    intent.putExtra("DealCode", campusDealsList.get(position).getDeal_code());


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




    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByExpiryDateAse() {
        Comparator<CampusDealList_Been> comparator = new Comparator<CampusDealList_Been>() {

            @Override
            public int compare(CampusDealList_Been object1, CampusDealList_Been object2) {


                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(campusDealsList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByExpiryDateDes() {
        Comparator<CampusDealList_Been> comparator = new Comparator<CampusDealList_Been>() {

            @Override
            public int compare(CampusDealList_Been object2, CampusDealList_Been object1) {


                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(campusDealsList, comparator);
        notifyDataSetChanged();
    }

}
