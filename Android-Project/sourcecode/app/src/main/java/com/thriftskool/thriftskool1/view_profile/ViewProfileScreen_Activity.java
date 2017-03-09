package com.thriftskool.thriftskool1.view_profile;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.asynctask.OwnerProfileView_AsyncTask;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.OwnerDetails_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.home_list_detail.HomeListDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.HashMap;
import java.util.List;

public class ViewProfileScreen_Activity extends Activity {

    TextView tv_Header_Title,tv_username,tv_class,tv_ownerName,Owner_post;
    ImageView iv_ownerIMG;
    private HashMap<String, String> hashMap = new HashMap<String, String>();
    public static List<OwnerDetails_Been> OwnderDetailsList;
    public static List<HomeList_Been> OwnderPostList;
    public static String Dialog_imh="";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_profile_screen_);

        tv_Header_Title=(TextView)findViewById(R.id.Header_Title);
        tv_username=(TextView)findViewById(R.id.Owner_name);
        tv_class=(TextView)findViewById(R.id.Owner_class);
        tv_ownerName=(TextView)findViewById(R.id.Owner_UserName);
        Owner_post=(TextView)findViewById(R.id.Owner_post);

        iv_ownerIMG=(ImageView)findViewById(R.id.OwnerRow_image);

        tv_Header_Title.setText("Post Owner");

        hashMap = SessionStore.getUserDetails(ViewProfileScreen_Activity.this, Comman.PRIFRENS_NAME);

        OwnerProfileView_AsyncTask viewAsyncTask=new OwnerProfileView_AsyncTask(ViewProfileScreen_Activity.this,tv_username,tv_class,tv_ownerName,iv_ownerIMG);
        viewAsyncTask.execute(HomeListDetail_Tab_Activity.str_userId);

        Owner_post.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(ViewProfileScreen_Activity.this, OwnerPostScreen_Activity.class);
                startActivity(intent);
            }
        });

        iv_ownerIMG.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v) {
                imgPoup();
            }
        });
    }

    public void imgPoup()
    {

        LayoutInflater layoutInflater = (LayoutInflater)getBaseContext()
                .getSystemService(LAYOUT_INFLATER_SERVICE);
        View popupView = layoutInflater.inflate(R.layout.view_dialog_row, null);

        Dialog dialog = new Dialog(ViewProfileScreen_Activity.this,R.style.PauseDialog);

     //   LinearLayout lv_pup=(LinearLayout)findViewById(R.id.ll_popup);
        ImageView fullimg=(ImageView)popupView.findViewById(R.id.fullImg);

     /*   fullimg.setMinimumHeight(Comman.DEVICE_WIDTH / 6);
        fullimg.setMaxHeight(Comman.DEVICE_WIDTH / 6);
        fullimg.setMinimumWidth(Comman.DEVICE_WIDTH / 6);
        fullimg.setMaxWidth(Comman.DEVICE_WIDTH / 6);

        LinearLayout.LayoutParams myParams = new LinearLayout.LayoutParams(Comman.DEVICE_WIDTH / 5, Comman.DEVICE_WIDTH / 5);

        fullimg.setLayoutParams(myParams);*/

        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        WindowManager.LayoutParams wmlp = dialog.getWindow().getAttributes();
        dialog.setContentView(popupView);

        wmlp.gravity = Gravity.CENTER | Gravity.CENTER;
        wmlp.x = 0;   //x position
        wmlp.y = 0;

        dialog.show();

        if (!Dialog_imh.trim().equalsIgnoreCase("") && !Dialog_imh.trim().equalsIgnoreCase("null"))
        {
            Picasso.with(ViewProfileScreen_Activity.this).load(Dialog_imh).into(fullimg);

        }
        else
        {
            Picasso.with(ViewProfileScreen_Activity.this).load(R.drawable.lodingicon).into(fullimg);
        }

        //  popupWindow.showAsDropDown(iv_candidateImg, 50, -30);

    }
}
