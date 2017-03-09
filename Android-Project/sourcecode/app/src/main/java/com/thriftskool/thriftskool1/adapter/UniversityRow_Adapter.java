package com.thriftskool.thriftskool1.adapter;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;
import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.been.UniversityList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.create_new_university.CreaneNewUniversityScreen_Activity;
import com.thriftskool.thriftskool1.widgets.SquareImageView;
import com.thriftskool.thriftskool1.widgets.TextAwesome;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by etiloxadmin on 6/8/15.
 */
public class UniversityRow_Adapter extends BaseAdapter {

    Context context;
    private List<UniversityList_Been> universityList = new ArrayList<UniversityList_Been>();

    public UniversityRow_Adapter(Context context, List<UniversityList_Been> universityList)
    {
        this.context = context;
        this.universityList = universityList;
    }

    @Override
    public int getCount() {
        return universityList.size();
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
        View view = layoutInflater.inflate(R.layout.university_row, null);

        LinearLayout ll_layout = (LinearLayout)view.findViewById(R.id.University_Row);
        TextView tv_name = (TextView)view.findViewById(R.id.University_Row_name);
        SquareImageView iv_image = (SquareImageView)view.findViewById(R.id.University_Row_image);
        TextAwesome iv_isCheck = (TextAwesome)view.findViewById(R.id.University_Row_isCkecked);

        tv_name.setText(universityList.get(position).getUniversity_name());





        RelativeLayout.LayoutParams myParams = new RelativeLayout.LayoutParams(Comman.DEVICE_WIDTH / 8, Comman.DEVICE_WIDTH / 8);

        iv_image.setLayoutParams(myParams);

        if (!universityList.get(position).getImage().equalsIgnoreCase("null") && !universityList.get(position).getImage().equalsIgnoreCase("") )
        {
           // Picasso.with(context).load(universityList.get(position).getImagepath() + universityList.get(position).getImage()).placeholder(R.drawable.lodingicon).into(iv_image);
            Picasso.with(context).load(universityList.get(position).getImagepath() + universityList.get(position).getImage()).resize(Comman.DEVICE_WIDTH / 8, Comman.DEVICE_WIDTH / 8).placeholder(R.drawable.lodingicon).into(iv_image);
        }
        else
        {
            if (universityList.get(position).getUniversity_id().equalsIgnoreCase("0"))
            {
                Picasso.with(context).load(R.drawable.help).resize(Comman.DEVICE_WIDTH / 8, Comman.DEVICE_WIDTH / 8).into(iv_image);
            }
            else
            {
                Picasso.with(context).load(R.drawable.lodingicon).resize(Comman.DEVICE_WIDTH / 8, Comman.DEVICE_WIDTH / 8).into(iv_image);
            }

        }


        if (universityList.get(position).isChecked())
        {
            iv_isCheck.setText(context.getString(R.string.fa_check));

        }
        else
        {
            iv_isCheck.setText("");

        }



        ll_layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {

                if (universityList.get(position).getUniversity_id().trim().equalsIgnoreCase("0"))
                {

                    Intent intent = new Intent(context, CreaneNewUniversityScreen_Activity.class);
                    context.startActivity(intent);


                }
                else
                {

                for (int i=0; i< universityList.size(); i++ )
                {

                    if (i==position)
                    {

                        universityList.set(i, new UniversityList_Been(universityList.get(i).getUniversity_id(),universityList.get(i).getUniversity_name(),universityList.get(i).getDomain_name()
                                ,universityList.get(i).getImage(),universityList.get(i).getImagepath(),true));
                        Log.e("size true"," "+universityList.size());

                    }
                    else
                    {
                        universityList.set(i, new UniversityList_Been(universityList.get(i).getUniversity_id(),universityList.get(i).getUniversity_name(),universityList.get(i).getDomain_name()
                                ,universityList.get(i).getImage(),universityList.get(i).getImagepath(),false));

                    }


                }


                notifyDataSetChanged();
                }


            }
        });


        return view;
    }
}
