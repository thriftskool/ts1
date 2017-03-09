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
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RatingBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.asynctask.PostFavoriteStatus_AsynceTask;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 11/8/15.
 */
public class HomeLIst_Adapter extends ArrayAdapter<HomeList_Been> {

    private ListView lv_listView;
    private List<HomeList_Been> homeList = new ArrayList<HomeList_Been>();
    private Context context;
    private HashMap<String, String> hashMap = new HashMap<String, String>();




    public HomeLIst_Adapter(Context context, int resource, List<HomeList_Been> objects) {
        super(context, resource, objects);

        this.homeList=(objects);
        this.context = context;

        hashMap = SessionStore.getUserDetails(context, Comman.PRIFRENS_NAME);
    }

    @Override
    public int getCount() {
        return homeList.size();
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
        final TextView ratingBar = (TextView)view.findViewById(R.id.HomeListRow_faverat);


        tv_title.setText(homeList.get(position).getPost_name().trim());
        tv_price.setText("$"+homeList.get(position).getPrice().trim());

        if (homeList.get(position).getFavorite().trim().equalsIgnoreCase("1"))
        {
            ratingBar.setText(context.getString(R.string.fa_star));
            ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));

        }
        else
        {
            ratingBar.setText(context.getString(R.string.fa_star_o));
            ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));

        }




        if(homeList.get(position).getStatus().equalsIgnoreCase("1"))
        {

            tv_expDate.setText("Expired");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else  if(homeList.get(position).getStatus().equalsIgnoreCase("2")){

            tv_expDate.setText("Closed");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),homeList.get(position).getExpirydate().trim())>1) {

            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), homeList.get(position).getExpirydate().trim()) + " days");

        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),homeList.get(position).getExpirydate().trim())==0) {

            tv_expDate.setText("Expired Today");
        }else if (DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(),homeList.get(position).getExpirydate().trim())<0) {

            tv_expDate.setText("Expired");
            tv_expDate.setTextColor(context.getResources().getColor(R.color.profile_mypost));

        }else{

            tv_expDate.setText("Exp. in " + DateCoversion.getDiffrenceOfData(DateCoversion.getCurrentData(), homeList.get(position).getExpirydate().trim()) + " day");

        }


        image.setMinimumHeight(Comman.DEVICE_WIDTH/6);
        image.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        image.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        image.setMaxWidth(Comman.DEVICE_WIDTH / 6);


        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        image.setLayoutParams(myParams);

        if (!homeList.get(position).getImage().trim().equalsIgnoreCase("") && !homeList.get(position).getImage().trim().equalsIgnoreCase("null"))
        {
            Picasso.with(context).load(Comman.img_path.trim() + homeList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);
           // Picasso.with(context).load(homeList.get(position).getImagepath().trim() + homeList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);
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


                    Intent intent =  new Intent(context, HomeListDetail_Tab_Activity.class);
                    intent.putExtra("ID",homeList.get(position).getPost_id());
                    intent.putExtra("UserId",homeList.get(position).getUser_id());

                    intent.putExtra("Title",homeList.get(position).getPost_name());
                    intent.putExtra("ExpDate",homeList.get(position).getExpirydate());
                    intent.putExtra("Price",homeList.get(position).getPrice());
                    intent.putExtra("Desc",homeList.get(position).getDescription());
                    intent.putExtra("Name",Home_List_Tab.str_name);
                    intent.putExtra("Favorite",homeList.get(position).getFavorite());
                    intent.putExtra("Status",homeList.get(position).getStatus());


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



        ratingBar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                PostFavoriteStatus_AsynceTask favorte = new PostFavoriteStatus_AsynceTask(context, ratingBar);

                if (!homeList.get(position).getFavorite().trim().equalsIgnoreCase("1"))
                {
                    ratingBar.setText(context.getString(R.string.fa_star));
                    ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));
                    homeList.set(position, new HomeList_Been(homeList.get(position).getPost_id(), homeList.get(position).getUser_id(), homeList.get(position).getPost_name(), homeList.get(position).getDescription(), homeList.get(position).getPrice(), homeList.get(position).getStatus(), "1", homeList.get(position).getExpirydate(), homeList.get(position).getImage(), homeList.get(position).getImage_id(), homeList.get(position).getImagepath(),"",homeList.get(position).getFinalName(),homeList.get(position).isCheck()));
                    favorte.execute(homeList.get(position).getPost_id(), hashMap.get(SessionStore.USER_ID), "1");

                    Log.e("dfdsfsd","HIIIIIII: "+1);

                }
                else
                {
                    ratingBar.setText(context.getString(R.string.fa_star_o));
                    ratingBar.setTextColor(context.getResources().getColor(R.color.color_greenheader));

                    homeList.set(position, new HomeList_Been(homeList.get(position).getPost_id(), homeList.get(position).getUser_id(), homeList.get(position).getPost_name(), homeList.get(position).getDescription(), homeList.get(position).getPrice(), homeList.get(position).getStatus(), "0", homeList.get(position).getExpirydate(), homeList.get(position).getImage(), homeList.get(position).getImage_id(), homeList.get(position).getImagepath(),"",homeList.get(position).getFinalName(),homeList.get(position).isCheck()));
                    favorte.execute(homeList.get(position).getPost_id(), hashMap.get(SessionStore.USER_ID), "0");

                    Log.e("dfdsfsd","HIIIIIII: "+0);

                }


                notifyDataSetChanged();



            }
        });



        return view;
    }


    /** Sort shopping list by Price */
   //...... Asending
    public void sortByPriceAse() {
        Comparator<HomeList_Been> comparator = new Comparator<HomeList_Been>() {

            @Override
            public int compare(HomeList_Been object1, HomeList_Been object2) {

              //  return object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());

                return  new Double(object2.getPrice()).compareTo (new Double((object1.getPrice())));
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByPriceDes() {
        Comparator<HomeList_Been> comparator = new Comparator<HomeList_Been>() {

            @Override
            public int compare(HomeList_Been object2, HomeList_Been object1) {


           //     return object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());
                return  new Double(object2.getPrice()).compareTo (new Double((object1.getPrice())));
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }



    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByExpiryDateAse() {
        Comparator<HomeList_Been> comparator = new Comparator<HomeList_Been>() {

            @Override
            public int compare(HomeList_Been object1, HomeList_Been object2) {

                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByExpiryDateDes() {
        Comparator<HomeList_Been> comparator = new Comparator<HomeList_Been>() {

            @Override
            public int compare(HomeList_Been object2, HomeList_Been object1) {

                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }



}
