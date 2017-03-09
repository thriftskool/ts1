package com.thriftskool.thriftskool1.edit_profile;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.UniversityRow_Adapter;
import com.thriftskool.thriftskool1.asynctask.UniversityList_AsyncTask;
import com.thriftskool.thriftskool1.been.UniversityList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.session.SessionStore;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 7/9/15.
 */
public class EditProfileUniversityScreen_Activity extends Activity {

    private ListView lv_listView;
    private TextView tv_back, tv_title, tv_save,tv_countNotification;
    public static List<UniversityList_Been> universityList = new ArrayList<UniversityList_Been>();
    private String str_id="", str_domainName="";
    public static boolean listflag=false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_univarsity_screen_);




        maping();


    }


    //************** Maping ***********************************************************************************************************************************************************************

    private void maping()
    {

        //ListView
        lv_listView = (ListView)findViewById(R.id.UnivarsityScreen_listView);

        //TExtView
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        tv_countNotification.setVisibility(View.INVISIBLE);
        tv_back.setText(getString(R.string.fa_chevron_left));
        tv_save.setText("Done");
        tv_title.setText("SELECT UNIVERSITY");

        tv_save.setTextSize(15);

        if (universityList.size()==0)
        {
            UniversityList_AsyncTask unive = new UniversityList_AsyncTask(EditProfileUniversityScreen_Activity.this,universityList,lv_listView);
            unive.execute();
            listflag = true;
        }
        else
        {
            lv_listView.setAdapter(new UniversityRow_Adapter(EditProfileUniversityScreen_Activity.this, universityList));

        }



        tv_save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent returnIntent = new Intent();

                for (int i = 0; i < universityList.size(); i++) {
                    if (universityList.get(i).isChecked()) {
                        str_domainName = universityList.get(i).getDomain_name();
                        str_id = universityList.get(i).getUniversity_id();
                        returnIntent.putExtra("Name", universityList.get(i).getUniversity_name());
                        returnIntent.putExtra("Image", universityList.get(i).getImagepath()+""+universityList.get(i).getImage());


                    }

                }


                if (str_id.trim().equalsIgnoreCase("")) {
                    onBackPressed();
                } else {

                    returnIntent.putExtra("DemainName", str_domainName);
                    returnIntent.putExtra("ID", str_id);

                    setResult(RESULT_OK, returnIntent);
                    onBackPressed();
                }


            }
        });


        tv_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                onBackPressed();
            }
        });


    }


    @Override
    public void onBackPressed() {
        super.onBackPressed();

       /* Intent returnIntent = new Intent();
        setResult(RESULT_CANCELED, returnIntent);*/
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();


    }


    @Override
    protected void onResume() {
        super.onResume();

        //hashMap = SessionStore.getUserDetails(WatchListDetailScreen_Activity.this, Comman.PRIFRENS_NAME);
    }
}
