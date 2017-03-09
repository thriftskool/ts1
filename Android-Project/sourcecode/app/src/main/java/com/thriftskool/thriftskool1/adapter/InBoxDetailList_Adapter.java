package com.thriftskool.thriftskool1.adapter;

import android.content.Context;
import android.util.Log;
import android.util.Pair;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.InBoxDetaiList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.reply_messag_detail.ReplyMessageDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.widgets.AmazingAdapter;
import com.thriftskool.thriftskool1.widgets.SquareImageView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 24/8/15.
 */
public class InBoxDetailList_Adapter  extends AmazingAdapter {


    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();
    private Context context;
    List<Pair<String, List<InBoxDetaiList_Been>>> all = new ArrayList<Pair<String, List<InBoxDetaiList_Been>>>();
    private TextView tv_title;
    private String str_postName="";
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private int value=0;

    public InBoxDetailList_Adapter(Context context, int resource, List<InBoxDetaiList_Been> objects, List<Pair<String, List<InBoxDetaiList_Been>>> all,TextView tv_title,String str_postName) {
        // TODO Auto-generated constructor stub
        this.messageList = objects;
        this.context = context;
        this.all = all;
        this.tv_title = tv_title;
        this.str_postName = str_postName;
        hashMap = SessionStore.getUserDetails(context, Comman.PRIFRENS_NAME);
    }


    @Override
    public int getCount() {
        int res = 0;
        for (int i = 0; i < all.size(); i++) {
            res += all.get(i).second.size();
        }
        return res;
    }

    @Override
    public InBoxDetaiList_Been getItem(int position) {
        int c = 0;
        for (int i = 0; i < all.size(); i++) {
            if (position >= c && position < c + all.get(i).second.size()) {
                return all.get(i).second.get(position - c);
            }
            c += all.get(i).second.size();
        }
        return null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    protected void onNextPageRequested(int page) {
    }

    @Override
    protected void bindSectionHeader(View view, int position, boolean displaySectionHeader) {
        if (displaySectionHeader) {
            view.findViewById(R.id.header).setVisibility(View.VISIBLE);
            TextView lSectionTitle = (TextView) view.findViewById(R.id.header);
            lSectionTitle.setText(getSections()[getSectionForPosition(position)]);
//            lSectionTitle.setBackgroundColor( (0xEDEDED));
//            lSectionTitle.setTextColor((0x000000));
//            lSectionTitle.setTypeface(OpenHelveticaBold.getInstance(context).getTypeFace());


        } else {
            view.findViewById(R.id.header).setVisibility(View.GONE);
        }
    }

    @Override
    public View getAmazingView(final int position, View convertView, ViewGroup parent) {



        LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.inbox_detail_list_row, null);

        LinearLayout ll_user1 = (LinearLayout)view.findViewById(R.id.InBoxDetail_Row_User1);
        TextView tv_username1= (TextView)view.findViewById(R.id.InBoxDetail_Row_Name);
        TextView tv_userdate1 = (TextView)view.findViewById(R.id.InBoxDetail_Row_Date);
        TextView tv_usermessage1= (TextView)view.findViewById(R.id.InBoxDetail_Row_Message);

        LinearLayout ll_user2 = (LinearLayout)view.findViewById(R.id.InBoxDetail_Row_User2);
        TextView tv_username2= (TextView)view.findViewById(R.id.InBoxDetail_Row_Name1);
        TextView tv_userdate2 = (TextView)view.findViewById(R.id.InBoxDetail_Row_Date1);
        TextView tv_usermessage2= (TextView)view.findViewById(R.id.InBoxDetail_Row_Message1);




        if (!hashMap.get(SessionStore.USER_NAME).trim().equalsIgnoreCase(messageList.get(position).getUser_name())){

            tv_title.setText(messageList.get(position).getUser_name().trim()+" - "+ str_postName.trim());

        }else if (!messageList.get(position).getUser_name().equalsIgnoreCase("")){

            tv_title.setText(messageList.get(position).getOwnerName().trim()+" - "+ str_postName.trim());


        }


            if (!hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(messageList.get(position).getUser_id())){


            ll_user1.setVisibility(View.VISIBLE);
            ll_user2.setVisibility(View.GONE);

            tv_username1.setText(messageList.get(position).getUser_name().trim());
            tv_usermessage1.setText(messageList.get(position).getMessage().trim());
            tv_userdate1.setText(DateCoversion.getTimeAmPm(messageList.get(position).getDate().trim()));


        }else{

            ll_user2.setVisibility(View.VISIBLE);
            ll_user1.setVisibility(View.GONE);


            tv_username2.setText(messageList.get(position).getUser_name().trim());
            tv_usermessage2.setText(messageList.get(position).getMessage().trim());
            tv_userdate2.setText(DateCoversion.getTimeAmPm(messageList.get(position).getDate().trim()));


        }



        return view;

    }

    @Override
    public void configurePinnedHeader(View header, int position, int alpha) {
        TextView lSectionHeader = (TextView) header;
        lSectionHeader.setText(getSections()[getSectionForPosition(position)]);
		lSectionHeader.setBackgroundColor(alpha << 24 | (0xEDEDED));
//		lSectionHeader.setTextColor(alpha << 24 | (0x000000));
 //       lSectionHeader.setTypeface(OpenHelveticaBold.getInstance(context).getTypeFace());
    }

    @Override
    public int getPositionForSection(int section) {
        if (section < 0) section = 0;
        if (section >= all.size()) section = all.size() - 1;
        int c = 0;
        for (int i = 0; i < all.size(); i++) {
            if (section == i) {
                return c;
            }
            c += all.get(i).second.size();
        }
        return 0;
    }

    @Override
    public int getSectionForPosition(int position) {
        int c = 0;
        for (int i = 0; i < all.size(); i++) {
            if (position >= c && position < c + all.get(i).second.size()) {
                return i;
            }
            c += all.get(i).second.size();
        }
        return -1;
    }

    @Override
    public String[] getSections() {
        String[] res = new String[all.size()];
        for (int i = 0; i < all.size(); i++) {
            res[i] = all.get(i).first;
        }
        return res;
    }
}




/*extends ArrayAdapter<InBoxDetaiList_Been> {

    private ListView lv_listView;
    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();
    private Context context;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    private TextView tv_title;
    private String str_postName="";




    public InBoxDetailList_Adapter(Context context, int resource, List<InBoxDetaiList_Been> objects,TextView tv_title,String str_postName) {
        super(context, resource, objects);

        this.messageList = objects;
        this.context = context;
        this.tv_title = tv_title;
        this.str_postName = str_postName;
        hashMap = SessionStore.getUserDetails(context, Comman.PRIFRENS_NAME);

    }

    @Override
    public int getCount() {
        return messageList.size();
    }


    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {

        LayoutInflater layoutInflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.inbox_detail_list_row, null);

        LinearLayout ll_user1 = (LinearLayout)view.findViewById(R.id.InBoxDetail_Row_User1);
        TextView tv_username1= (TextView)view.findViewById(R.id.InBoxDetail_Row_Name);
        TextView tv_userdate1 = (TextView)view.findViewById(R.id.InBoxDetail_Row_Date);
        TextView tv_usermessage1= (TextView)view.findViewById(R.id.InBoxDetail_Row_Message);

        LinearLayout ll_user2 = (LinearLayout)view.findViewById(R.id.InBoxDetail_Row_User2);
        TextView tv_username2= (TextView)view.findViewById(R.id.InBoxDetail_Row_Name1);
        TextView tv_userdate2 = (TextView)view.findViewById(R.id.InBoxDetail_Row_Date1);
        TextView tv_usermessage2= (TextView)view.findViewById(R.id.InBoxDetail_Row_Message1);


*//*
        LinearLayout.LayoutParams myParams = new LinearLayout.LayoutParams((Comman.DEVICE_WIDTH-(Comman.DEVICE_WIDTH /4)), ViewGroup.LayoutParams.WRAP_CONTENT);
        LinearLayout.LayoutParams myParams1 = new LinearLayout.LayoutParams((Comman.DEVICE_WIDTH /4), ViewGroup.LayoutParams.WRAP_CONTENT);
*//*

        if (!hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(messageList.get(position).getUser_id())){

            tv_title.setText(messageList.get(position).getUser_name()+" "+ str_postName);

            ll_user1.setVisibility(View.VISIBLE);
            ll_user2.setVisibility(View.GONE);

            tv_username1.setText(messageList.get(position).getUser_name().trim());
            tv_usermessage1.setText(messageList.get(position).getMessage().trim());
            tv_userdate1.setText(DateCoversion.getTimeAmPm(messageList.get(position).getDate().trim()));


        }else{

            ll_user2.setVisibility(View.VISIBLE);
            ll_user1.setVisibility(View.GONE);

            tv_username2.setText(messageList.get(position).getUser_name().trim());
            tv_usermessage2.setText(messageList.get(position).getMessage().trim());
            tv_userdate2.setText(DateCoversion.getTimeAmPm(messageList.get(position).getDate().trim()));


        }








        return view;
    }
}*/
