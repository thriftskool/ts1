package com.thriftskool.thriftskool1.adapter;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.CampusBuzzList_Been;
import com.thriftskool.thriftskool1.been.NotoficationList_Been;
import com.thriftskool.thriftskool1.campus_buzz_details.CampusBuzzDetailsTab_Activity;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.notification_detail.NotificationMessageDetailScreen_Activity;
import com.thriftskool.thriftskool1.notification_detail.NotificationPostBuzzDetailScreen_Activity;
import com.thriftskool.thriftskool1.searchresult_detail.SearchResultDetail_Tab_Activity;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 14/9/15.
 */
public class NotificationList_Adapter extends BaseAdapter {

    private ListView lv_listView;
    private List<NotoficationList_Been> notoficationList = new ArrayList<NotoficationList_Been>();
    private Context context;
    int countNotification;

    public NotificationList_Adapter( Context context, List<NotoficationList_Been> notoficationList,int countNotification) {
        this.lv_listView = lv_listView;
        this.notoficationList = notoficationList;
        this.context = context;
        this.countNotification=countNotification;
    }


    @Override
    public int getCount() {
        return notoficationList.size();
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

        View view = layoutInflater.inflate(R.layout.notification_list_row, null);

        LinearLayout ll_layout = (LinearLayout)view.findViewById(R.id.NotificationLisr_Row);
        SquareImageView image = (SquareImageView)view.findViewById(R.id.NotificationLisr_Row_Image);
        TextView tv_title = (TextView)view.findViewById(R.id.NotificationLisr_Row_Name);


        if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("0")){

            tv_title.setText("You have new message from " + notoficationList.get(position).getName());

        }else if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("1")){

            tv_title.setText("Your " + notoficationList.get(position).getName()+" has been expired");

        }else if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("2")){

            tv_title.setText("Your " + notoficationList.get(position).getName()+" has been blocked");

        }else if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("3")){

            tv_title.setText("Your " + notoficationList.get(position).getName()+" has been expired");

        }else if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("4")){

            tv_title.setText("Your " + notoficationList.get(position).getName()+" has been blocked");

        }


        image.setMinimumHeight(Comman.DEVICE_WIDTH/6);
        image.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        image.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        image.setMaxWidth(Comman.DEVICE_WIDTH / 6);


        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        image.setLayoutParams(myParams);


        if (!notoficationList.get(position).getImage().trim().equalsIgnoreCase("") && !notoficationList.get(position).getImage().trim().equalsIgnoreCase("null"))
        {
            Picasso.with(context).load(notoficationList.get(position).getImagepath().trim() + notoficationList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH/6,Comman.DEVICE_WIDTH/6).into(image);

        }
        else
        {
            Picasso.with(context).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        }

        ll_layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent=null;

                if (CheckInterNetConnection.isNetworkAvailable(context)) {

                    if (notoficationList.get(position).getNotification_type().trim().equalsIgnoreCase("0")){

                        intent = new Intent(context, NotificationMessageDetailScreen_Activity.class);
                        intent.putExtra("ID",notoficationList.get(position).getImage_id());
                        intent.putExtra("UserID",notoficationList.get(position).getUser_id());
                        intent.putExtra("ThredId",notoficationList.get(position).getId());
                        intent.putExtra("Name",notoficationList.get(position).getReference_id());

                        context.startActivity(intent);

                    }else{

                        intent = new Intent(context, NotificationPostBuzzDetailScreen_Activity.class);
                        intent.putExtra("ID",notoficationList.get(position).getId());
                        intent.putExtra("Notificationtype",notoficationList.get(position).getNotification_type());
                        intent.putExtra("UserID",notoficationList.get(position).getUser_id());
                        intent.putExtra("Name", notoficationList.get(position).getName());
                        context.startActivity(intent);

                    }







                }
                else {

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
