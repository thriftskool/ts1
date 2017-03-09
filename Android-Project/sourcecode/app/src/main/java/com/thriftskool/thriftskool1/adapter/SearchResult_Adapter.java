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
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.MyPostList_Been;
import com.thriftskool.thriftskool1.been.SearchResult_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.searchresult_detail.SearchResultDetail_Tab_Activity;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by etiloxadmin on 12/9/15.
 */
public class SearchResult_Adapter extends ArrayAdapter<SearchResult_Been> {

    private ListView lv_listView;
    private List<SearchResult_Been> searchList = new ArrayList<SearchResult_Been>();
    private Context context;



    public SearchResult_Adapter(Context context, int resource, List<SearchResult_Been> objects) {
        super(context, resource, objects);
        this.searchList = objects;
        this.context = context;
    }

    @Override
    public int getCount() {
        return searchList.size();
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

        ratingBar.setVisibility(View.GONE);


        tv_title.setText(searchList.get(position).getTitle().trim());

        if (searchList.get(position).getType().trim().equalsIgnoreCase("PM")){

            tv_price.setText("$"+searchList.get(position).getPrice().trim());


        }else {

            tv_price.setVisibility(View.GONE);


        }

       /* if (homeList.get(position).get.trim().equalsIgnoreCase("1"))
        {
            ratingBar.setText(context.getString(R.string.fa_star));
            ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));

        }
        else
        {
            ratingBar.setText(context.getString(R.string.fa_star_o));
            ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));

        }
*/



        if(searchList.get(position).getStatus().equalsIgnoreCase("1")){

            tv_expDate.setText("Expired");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else  if(searchList.get(position).getStatus().equalsIgnoreCase("2")){

            tv_expDate.setText("Closed");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), searchList.get(position).getExpirydate().trim())>1) {

            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), searchList.get(position).getExpirydate().trim()) + " days");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),searchList.get(position).getExpirydate().trim())==0) {

            tv_expDate.setText("Expired Today");
        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),searchList.get(position).getExpirydate().trim())<0) {

            tv_expDate.setText("Expired");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else{

            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), searchList.get(position).getExpirydate().trim()) + " day");

        }


        image.setMinimumHeight(Comman.DEVICE_WIDTH/6);
        image.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        image.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        image.setMaxWidth(Comman.DEVICE_WIDTH / 6);


        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        image.setLayoutParams(myParams);


        if (!searchList.get(position).getImage().trim().equalsIgnoreCase("") && !searchList.get(position).getImage().trim().equalsIgnoreCase("null"))
        {
            Picasso.with(context).load(searchList.get(position).getImagepath().trim() + searchList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        }
        else
        {
            Picasso.with(context).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        }

        ll_layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (CheckInterNetConnection.isNetworkAvailable(context))
                {


                    Intent intent =  new Intent(context, SearchResultDetail_Tab_Activity.class);
                    intent.putExtra("ID",searchList.get(position).getId());
                    intent.putExtra("UserId",searchList.get(position).getUser_id());
                    intent.putExtra("Type",searchList.get(position).getType());
                    intent.putExtra("PostName",searchList.get(position).getTitle());
                    intent.putExtra("Status",searchList.get(position).getStatus());



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


    /** Sort shopping list by Price */
    //...... Asending
    public void sortByPriceAse() {
        Comparator<SearchResult_Been> comparator = new Comparator<SearchResult_Been>() {

            @Override
            public int compare(SearchResult_Been object1, SearchResult_Been object2) {


                //  return object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());

                return  new Double(object2.getPrice()).compareTo(new Double((object1.getPrice())));
            }
        };
        Collections.sort(searchList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByPriceDes() {
        Comparator<SearchResult_Been> comparator = new Comparator<SearchResult_Been>() {

            @Override
            public int compare(SearchResult_Been object2, SearchResult_Been object1) {


                //     return object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());
                return  new Double(object2.getPrice()).compareTo(new Double((object1.getPrice())));
            }
        };
        Collections.sort(searchList, comparator);
        notifyDataSetChanged();
    }




    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByExpiryDateAse() {
        Comparator<SearchResult_Been> comparator = new Comparator<SearchResult_Been>() {

            @Override
            public int compare(SearchResult_Been object1, SearchResult_Been object2) {


                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(searchList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByExpiryDateDes() {
        Comparator<SearchResult_Been> comparator = new Comparator<SearchResult_Been>() {

            @Override
            public int compare(SearchResult_Been object2, SearchResult_Been object1) {


                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(searchList, comparator);
        notifyDataSetChanged();
    }

}
