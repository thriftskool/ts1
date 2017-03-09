package com.thriftskool.thriftskool1.adapter;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
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
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.SwipeListView.SwipeListView;
import com.thriftskool.thriftskool1.asynctask.DeletePostBuzz_AsyncTask;
import com.thriftskool.thriftskool1.asynctask.DeleteThried_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.MyPostList_Been;
import com.thriftskool.thriftskool1.comman.CheckInterNetConnection;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.my_post_list_detail.MyPostListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.widgets.SquareImageView;
import com.thriftskool.thriftskool1.widgets.TextAwesome;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class MyPostList_Adapter extends ArrayAdapter<MyPostList_Been> {

    private ListView lv_listView;
    private List<MyPostList_Been> homeList = new ArrayList<MyPostList_Been>();
    private Context context;
    int delValue,selValue,editValue;
    static List<String> PostList = new ArrayList<String>();
    static List<String> BuzzList = new ArrayList<String>();
    HashMap<String, String> hashMap = new HashMap<String, String>();
    boolean flage=false;

    public MyPostList_Adapter(Context context, int resource, List<MyPostList_Been> objects,int delValue,int selValue,int editValue) {
        super(context, resource, objects);

        this.homeList = (objects);
        this.context = context;
        this.delValue=delValue;
        this.selValue=selValue;
        this.editValue=editValue;

        Log.e("Delvalue" , " "+this.delValue);
        Log.e("Selvalue" , " "+this.selValue);
        Log.e("Editvalue" , " "+this.editValue);

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

        final View layoutMain = (View)view.findViewById(R.id.HomeListRow_Row_Layout);
        final View  DelMsgs = (View)view.findViewById(R.id.HomeListRow_SliderDeleteMsg);

        LinearLayout ll_layout = (LinearLayout)view.findViewById(R.id.HomeListRow);
        SquareImageView image = (SquareImageView)view.findViewById(R.id.HomeListRow_image);
        TextView tv_title = (TextView)view.findViewById(R.id.HomeListRow_title);
        TextView tv_expDate = (TextView)view.findViewById(R.id.HomeListRow_expDate);
        TextView tv_price = (TextView)view.findViewById(R.id.HomeListRow_price);
        TextView ratingBar = (TextView)view.findViewById(R.id.HomeListRow_faverat);
        final CheckBox chkMsg=(CheckBox)view.findViewById(R.id.MessageScreen_CheckMsg);
        TextAwesome DelteMsg =(TextAwesome)view.findViewById(R.id.HomeListRow_DeleteMessage);

        tv_title.setText(homeList.get(position).getPost_name().trim());
        ratingBar.setVisibility(View.INVISIBLE);


        LinearLayout.LayoutParams lp2 = new LinearLayout.LayoutParams(SwipeListView.mRightViewWidth , LinearLayout.LayoutParams.MATCH_PARENT);

        DelMsgs.setLayoutParams(lp2);

///////// Delete ////////////


        if(editValue==2)
        {
            DelteMsg.setVisibility(View.VISIBLE);
        }

    DelteMsg.setOnTouchListener(new View.OnTouchListener() {
        @Override
        public boolean onTouch(View v, MotionEvent event) {
            Log.e("Touch....", " " + position);

            SwipeListView.mFirstX = 200;
            SwipeListView.mFirstY = 14;
            SwipeListView.motionPosition = position;

            DelMsgs.setVisibility(View.VISIBLE);

            return true;
        }
    });

        DelMsgs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {
                PostList.clear();
                BuzzList.clear();

                if (homeList.get(position).getType().trim().equalsIgnoreCase("Buzz"))
                {
                    BuzzList.add(homeList.get(position).getPost_id());
                }
                if (homeList.get(position).getType().trim().equalsIgnoreCase("Post"))
                {
                    PostList.add(homeList.get(position).getPost_id());
                }

                DeletePostBuzz_AsyncTask mess = new DeletePostBuzz_AsyncTask(context,PostList,BuzzList);
                mess.execute(hashMap.get(SessionStore.USER_ID));

            }
        });


        if(selValue==2)
        {
            Log.e("Selvalue "," "+selValue);

            DelteMsg.setVisibility(View.GONE);
            chkMsg.setVisibility(View.VISIBLE);
          //  chkMsg.setChecked(true);

          /*  PostList.clear();
            BuzzList.clear();
*/
     /*       for(int i=0;i<homeList.size();i++)
            {
                if (homeList.get(i).getType().trim().equalsIgnoreCase("Post")) {
                    PostList.add(homeList.get(i).getPost_id());
                }

                if (homeList.get(i).getType().trim().equalsIgnoreCase("Buzz")) {
                    BuzzList.add(homeList.get(i).getPost_id());
                }
            }*/

        }

      if(delValue==2)
        {

            delValue=0;
            if(PostList.isEmpty() && BuzzList.isEmpty())
            {
                Toast toast=  Toast.makeText(context, "Please Select Any Post", Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();
            }
            else
            {
                DeletePostBuzz_AsyncTask mess = new DeletePostBuzz_AsyncTask(context,PostList,BuzzList);
                mess.execute(hashMap.get(SessionStore.USER_ID));
            }
            chkMsg.setVisibility(View.VISIBLE);

           // chkMsg.setChecked(false);
        }

        chkMsg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {
                if(chkMsg.isChecked())
                {
                    if (homeList.get(position).getType().trim().equalsIgnoreCase("Buzz"))
                    {
                        BuzzList.add(homeList.get(position).getPost_id());
                    }
                    if (homeList.get(position).getType().trim().equalsIgnoreCase("Post"))

                    {
                        PostList.add(homeList.get(position).getPost_id());
                    }
                }
                else
                {
                    if (homeList.get(position).getType().trim().equalsIgnoreCase("Buzz"))
                    {
                        BuzzList.remove(homeList.get(position).getPost_id());
                    }
                    if (homeList.get(position).getType().trim().equalsIgnoreCase("Post"))
                    {
                        PostList.remove(homeList.get(position).getPost_id());
                    }
                }

                Log.e("post List","  "+PostList);
                Log.e("Buzz List ","  "+BuzzList);
            }
        });


//////////////////////////////////////////////////////////

        if (homeList.get(position).getType().trim().equalsIgnoreCase("Buzz"))
        {
            tv_price.setVisibility(View.GONE);

        }
        else
        {
            tv_price.setText("$"+homeList.get(position).getPrice().trim());

        }


        if(homeList.get(position).getStatus().equalsIgnoreCase("1")){

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
            Picasso.with(context).load(homeList.get(position).getImagepath().trim() + homeList.get(position).getImage().trim()).resize(Comman.DEVICE_WIDTH / 6, Comman.DEVICE_WIDTH / 6).into(image);

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

                    Intent intent =  new Intent(context, MyPostListDetail_Tab_Activity.class);
                    intent.putExtra("ID",homeList.get(position).getPost_id());
                    intent.putExtra("UserId",homeList.get(position).getUser_id());

                    intent.putExtra("Title",homeList.get(position).getPost_name());
                    intent.putExtra("ExpDate",homeList.get(position).getExpirydate());
                    intent.putExtra("Price",homeList.get(position).getPrice());
                    intent.putExtra("Type",homeList.get(position).getType());
                    intent.putExtra("Desc",homeList.get(position).getDescription());
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


        return view;

    }


    /** Sort shopping list by Price */
    //...... Asending
    public void sortByPriceAse() {
        Comparator<MyPostList_Been> comparator = new Comparator<MyPostList_Been>() {

            @Override
            public int compare(MyPostList_Been object1, MyPostList_Been object2) {


                 return object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());

              //  return  new Double(object2.getPrice()).compareTo(new Double((object1.getPrice())));
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByPriceDes() {
        Comparator<MyPostList_Been> comparator = new Comparator<MyPostList_Been>() {

            @Override
            public int compare(MyPostList_Been object2, MyPostList_Been object1) {


                    return  object1.getPrice().trim().compareToIgnoreCase(object2.getPrice().trim());
                //return  new Double(object2.getPrice()).compareTo(new Double((object1.getPrice())));
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }




    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByExpiryDateAse()
    {
        Comparator<MyPostList_Been> comparator = new Comparator<MyPostList_Been>()
        {
            @Override
            public int compare(MyPostList_Been object1, MyPostList_Been object2)
            {
                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }

    //...... Desending
    public void sortByExpiryDateDes() {
        Comparator<MyPostList_Been> comparator = new Comparator<MyPostList_Been>() {

            @Override
            public int compare(MyPostList_Been object2, MyPostList_Been object1) {


                return object1.getExpirydate().trim().compareToIgnoreCase(object2.getExpirydate().trim());
            }
        };
        Collections.sort(homeList, comparator);
        notifyDataSetChanged();
    }

//************** Load More Data ***********************************************************************************************************************************
    public void loadMoreData() {

        notifyDataSetChanged();

    }
}
