package com.thriftskool.thriftskool1.adapter;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.SwipeListView.SwipeListView;
import com.thriftskool.thriftskool1.asynctask.DeleteThried_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.InBoxList_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeCategory_List_Been;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.MyPostList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.home_list.Home_List_Tab;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.inbox.InBoxListScreen_Activity;
import com.thriftskool.thriftskool1.inbox_detail.InBoxDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.widgets.SquareImageView;
import com.thriftskool.thriftskool1.widgets.TextAwesome;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 24/8/15.
 */
public class InBoxList_Adapter extends BaseAdapter {

    private List<HomeList_Been> inboxList = new ArrayList<HomeList_Been>();
    private Context context;
    HashMap<String, String> hashMap = new HashMap<String, String>();
    TextAwesome tv_delete, tv_selectAll;
   static List<String> thridList = new ArrayList<String>();
    TextAwesome DeleteMsg;
    public int chkValue,delValue,editValue;


    public InBoxList_Adapter(Context context,List<HomeList_Been> inboxList, int delValue, int chkValue,int editValue)
    {


        this.inboxList = inboxList;
        this.context = context;
        this.delValue=delValue;
        this.chkValue=chkValue;
        this.editValue=editValue;

        Log.e("Delvalue "," "+this.delValue);
        Log.e("Selvalue "," "+this.chkValue);
        Log.e("editValue "," "+this.editValue);

        hashMap = SessionStore.getUserDetails(context, Comman.PRIFRENS_NAME);

    }


    @Override
    public int getCount() {
        return inboxList.size();
    }

    @Override
    public Object getItem(int position) {
        return position ;
    }


    @Override
    public long getItemId(int position) {
        return 0;
    }


    @Override
    public View getView( final int position, final View convertView, final ViewGroup parent)
    {


            LayoutInflater layoutInflater = (LayoutInflater) context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
            final View view = layoutInflater.inflate(R.layout.home_list_row, null);

          // final View layoutMain = (View)view.findViewById(R.id.HomeListRow_Row_Layout);

          final View  DelMsgs = (View)view.findViewById(R.id.HomeListRow_SliderDeleteMsg);

        for(int i=1;i<=inboxList.size();i++)
        {
            Log.e("position..."," "+inboxList.get(position).getFinalName());
            Log.e("position...value"," "+position);


        }
        sortByExpiryDateAse();

            LinearLayout ll_layout = (LinearLayout) view.findViewById(R.id.HomeListRow);
            SquareImageView image = (SquareImageView) view.findViewById(R.id.HomeListRow_image);
            TextView tv_title = (TextView) view.findViewById(R.id.HomeListRow_title);
            TextView tv_expDate = (TextView) view.findViewById(R.id.HomeListRow_expDate);
            TextView tv_price = (TextView) view.findViewById(R.id.HomeListRow_price);
            TextView ratingBar = (TextView) view.findViewById(R.id.HomeListRow_faverat);

           final CheckBox chkMsg =(CheckBox) view.findViewById(R.id.MessageScreen_CheckMsg);
           final TextView DeleteMsg=(TextView) view.findViewById(R.id.HomeListRow_DeleteMessage);


        tv_price.setTextSize(12);
        tv_expDate.setTextSize(12);

        tv_title.setText(inboxList.get(position).getPost_name().trim());
        ratingBar.setVisibility(View.GONE);
        tv_price.setText("~" + inboxList.get(position).getDescription());

        tv_expDate.setText(DateCoversion.getSelectedDate(inboxList.get(position).getExpirydate().trim()));

       // sortByExpiryDateAse();
        LinearLayout.LayoutParams lp2 = new LinearLayout.LayoutParams(SwipeListView.mRightViewWidth , LinearLayout.LayoutParams.MATCH_PARENT);

        DelMsgs.setLayoutParams(lp2);


/*
        if (!hashMap.get(SessionStore.USER_NAME).trim().equalsIgnoreCase(inboxList.get(position).getUsername().trim())){


            Log.e("Hiiiiiii", "Not Equallllllllll: User NAme: " + hashMap.get(SessionStore.USER_NAME).trim() + "     Owner Name: " + inboxList.get(position).getUsername() + "  Status: " + inboxList.get(position).getStatus() + "  Faverit: " + inboxList.get(position).getFavorite());


            if (inboxList.get(position).getStatus().trim().equalsIgnoreCase("0")){

                tv_title.setTextColor(context.getResources().getColor(R.color.color_greenheader));

            }else{

                tv_title.setTextColor(context.getResources().getColor(R.color.color_textcolor));

            }

        }
        else{

            Log.e("Hiiiiiii","Equallllllllll: User NAme: "+hashMap.get(SessionStore.USER_NAME).trim()+"     Owner Name: "+inboxList.get(position).getUsername()+"  Status: "+inboxList.get(position).getStatus()+"  Faverit: "+inboxList.get(position).getFavorite());


            if (inboxList.get(position).getFavorite().trim().equalsIgnoreCase("0")){

                tv_title.setTextColor(context.getResources().getColor(R.color.color_greenheader));

            }else{

                tv_title.setTextColor(context.getResources().getColor(R.color.color_textcolor));

            }

        }*/



//////////////////// Delete Msg //////////

        if(editValue==2)
        {
                DeleteMsg.setVisibility(View.VISIBLE);
        }

    DeleteMsg.setOnTouchListener(new View.OnTouchListener() {
        @Override
        public boolean onTouch(View v, MotionEvent event)
        {
            Log.e("Touch...."," "+position);

            SwipeListView.mFirstX=200;
            SwipeListView.mFirstY=14;
            SwipeListView.motionPosition=position;

            DelMsgs.setVisibility(View.VISIBLE);
            return true;
        }
    });

        DelMsgs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                thridList.clear();

                thridList.add(inboxList.get(position).getPrice());

                DeleteThried_AsyncTask mess = new DeleteThried_AsyncTask(context, thridList);
                mess.execute(hashMap.get(SessionStore.USER_ID));

            }
        });


        if(chkValue==2)
        {
            Log.e("Selvalue "," "+chkValue);

            DeleteMsg.setVisibility(View.GONE);
            chkMsg.setVisibility(View.VISIBLE);
           // chkMsg.setChecked(true);

       //     thridList.clear();

/*
            for(int i=0;i<inboxList.size();i++)
            {
                thridList.add(inboxList.get(i).getPrice());
            }
*/
            Log.e("Thrread Select", " " + thridList);

        }

        chkMsg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(chkMsg.isChecked())
                {
                    thridList.add(inboxList.get(position).getPrice());

                    Log.e("Thrid List Add ", " " + thridList);

                }
                else
                {
                    thridList.remove(inboxList.get(position).getPrice());

                    Log.e("Thrid List Remove ", " " + thridList);

                }
            }
        });


       if(delValue==2)
        {
                delValue=0;

                if(thridList.isEmpty())
                {
                    Toast toast=  Toast.makeText(context, "Please Select Any Message", Toast.LENGTH_SHORT);
                    toast.setGravity(Gravity.CENTER,0,0);
                    toast.show();

                }
                else
                {
                    Log.e("Thrid List Of Selected 2", " " + thridList);

                    DeleteThried_AsyncTask mess = new DeleteThried_AsyncTask(context, thridList);
                    mess.execute(hashMap.get(SessionStore.USER_ID));
                }

            chkMsg.setVisibility(View.VISIBLE);

            chkMsg.setChecked(false);
        }




///////////////////////////////////////////////////////////////////

        if (inboxList.get(position).getStatus().equalsIgnoreCase("0"))
        {
            tv_title.setTextColor(context.getResources().getColor(R.color.color_greenheader));
        }
        else
        {
            tv_title.setTextColor(context.getResources().getColor(R.color.color_textcolor));
        }



        image.setMinimumHeight(Comman.DEVICE_WIDTH / 6);
        image.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        image.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        image.setMaxWidth(Comman.DEVICE_WIDTH / 6);

        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6);

        image.setLayoutParams(myParams);

        if (!inboxList.get(position).getImage().trim().equalsIgnoreCase("") && !inboxList.get(position).getImage().trim().equalsIgnoreCase("null")) {
            Picasso.with(context).load(inboxList.get(position).getImagepath().trim() + inboxList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        } else {
            Picasso.with(context).load(R.drawable.ic_launcher).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

        }


        ll_layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (CheckInterNetConnection.isNetworkAvailable(context)) {

                    Intent intent = new Intent(context, InBoxDetail_Tab_Activity.class);
                    intent.putExtra("PostId", inboxList.get(position).getPost_id());
                    intent.putExtra("ThreadId", inboxList.get(position).getPrice());
                    intent.putExtra("PostName", inboxList.get(position).getPost_name());
                    intent.putExtra("UserId", inboxList.get(position).getUser_id());
                    intent.putExtra("OwnerName", inboxList.get(position).getUsername());

                    context.startActivity(intent);

                } else {
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



    public void sortByExpiryDateAse()
    {
        Comparator<HomeList_Been> comparator = new Comparator<HomeList_Been>()
        {
            @Override
            public int compare(HomeList_Been object2, HomeList_Been object1)
            {
                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(inboxList, comparator);
        notifyDataSetChanged();
    }



}