package com.thriftskool.thriftskool1.category;

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
import com.thriftskool.thriftskool1.comman.CrearCashMemmory;
import com.thriftskool.thriftskool1.home.HomeScreen_Activity;
import com.thriftskool.thriftskool1.post.PostScreen_Activity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 17/8/15.
 */
public class CategoryScreen_Activity extends Activity {

    private ListView lv_listView;
    private TextView tv_back, tv_title, tv_save,tv_notification;
    private List<UniversityList_Been> categoryList = new ArrayList<UniversityList_Been>();
    public static String str_id="", str_domainName="";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_univarsity_screen_);




        maping();


    }


    //************** Maping ***********************************************************************************************************************************************************************

    private void maping()
    {

        categoryList.clear();


        //ListView
        lv_listView = (ListView)findViewById(R.id.UnivarsityScreen_listView);

        //TExtView
        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        tv_back = (TextView)findViewById(R.id.Header_Back);
        tv_notification=(TextView)findViewById(R.id.Headerbadge);

        tv_notification.setVisibility(View.INVISIBLE);
        tv_back.setText(getString(R.string.fa_chevron_left));
        tv_save.setText("Done");
        tv_title.setText("CHOOSE CATEGORY");

        tv_save.setTextSize(15);


        for (int i=0; i< HomeScreen_Activity.categotyList.size(); i++)
        {
            if (str_id.trim().equalsIgnoreCase(HomeScreen_Activity.categotyList.get(i).getPost_cat_id().trim()))
            {
                categoryList.add(new UniversityList_Been(HomeScreen_Activity.categotyList.get(i).getPost_cat_id(),HomeScreen_Activity.categotyList.get(i).getPost_category_name(),"",HomeScreen_Activity.categotyList.get(i).getPost_cat_image(),HomeScreen_Activity.categotyList.get(i).getImagepath(),true));

            }
            else
            {
                categoryList.add(new UniversityList_Been(HomeScreen_Activity.categotyList.get(i).getPost_cat_id(),HomeScreen_Activity.categotyList.get(i).getPost_category_name(),"",HomeScreen_Activity.categotyList.get(i).getPost_cat_image(),HomeScreen_Activity.categotyList.get(i).getImagepath(),false));

            }

        }






        lv_listView.setAdapter(new UniversityRow_Adapter(CategoryScreen_Activity.this, categoryList));



        tv_save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                for (int i = 0; i < categoryList.size(); i++) {
                    if (categoryList.get(i).isChecked()) {
                        str_domainName = categoryList.get(i).getUniversity_name();
                        str_id = categoryList.get(i).getUniversity_id();

                    }

                }


                if (str_id.trim().equalsIgnoreCase("")) {
                    onBackPressed();
                } else {
                    Intent returnIntent = new Intent();
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
    protected void onPause() {
        super.onPause();
        CrearCashMemmory.trimCache(CategoryScreen_Activity.this);
    }

}
