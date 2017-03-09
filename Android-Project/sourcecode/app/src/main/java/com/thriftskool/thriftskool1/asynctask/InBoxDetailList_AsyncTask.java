package com.thriftskool.thriftskool1.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.util.Pair;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.HomeLIst_Adapter;
import com.thriftskool.thriftskool1.adapter.InBoxDetailList_Adapter;
import com.thriftskool.thriftskool1.been.HomeList_Been;
import com.thriftskool.thriftskool1.been.InBoxDetaiList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.inbox_detail.InBoxDetail_Tab_Activity;
import com.thriftskool.thriftskool1.session.SessionStore;
import com.thriftskool.thriftskool1.widgets.AmazingListView;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

/**
 * Created by etiloxadmin on 24/8/15.
 */
public class  InBoxDetailList_AsyncTask extends AsyncTask<String, Integer, JSONObject> {

    ProgressDialog progressDialog;
    Context context;
    private AmazingListView lv_listView;
    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();

    private ArrayAdapter<InBoxDetaiList_Been> adapter;
    private TextView tv_title;
    private String str_postName="";
    private List<InBoxDetaiList_Been> messageList1 = new ArrayList<InBoxDetaiList_Been>();
    private List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList = new ArrayList<Pair<String, List<InBoxDetaiList_Been>>>();
    private HashMap<String, String> hashMap = new HashMap<String, String>();



    public InBoxDetailList_AsyncTask(Context contex,  List<InBoxDetaiList_Been> messageList ,  List<InBoxDetaiList_Been> messageList1 , AmazingListView lv_listView,TextView tv_title,String str_postName,List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList ) {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.messageList = messageList;
        this.messageList1 = messageList1;
        this.pairMessageList = pairMessageList;
        this.lv_listView = lv_listView;
        this.tv_title= tv_title;
        this.str_postName =str_postName;

        progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);
        hashMap = SessionStore.getUserDetails(context, Comman.PRIFRENS_NAME);


    }




    @Override
    protected JSONObject doInBackground(String... params) {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {

            JSONObject json = new JSONObject();
            json.put("user_id", Integer.parseInt(params[0]));
            json.put("thread_id", Integer.parseInt(params[1]));
            json.put("post_id", Integer.parseInt(params[2]));
            json.put("own_id", Integer.parseInt(params[3]));
            json.put("chr_read", "1");


            Log.e("List,,", " " + json.toString());


            String response = Utility.postRequest(Comman.URL+"get_messagelist", json.toString(),context);
            JSONObject jObject = new JSONObject(response);
            jsonresponse = jObject.getJSONObject("Response");





        }
        catch(Exception e)
        {

            e.getStackTrace();
        }



        return jsonresponse;
    }

    @Override
    protected void onPreExecute() {
        // TODO Auto-generated method stub
        super.onPreExecute();

        if(progressDialog!=null && !progressDialog.isShowing())
        {
            progressDialog.show();
        }

    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);

        try
        {


            if (result.getString("status").trim().equalsIgnoreCase("200"))
            {

                int todayCount=0,yesturdayCount=0,laterCount=0,count=0;

                messageList.clear();
                messageList1.clear();
                pairMessageList.clear();
                JSONArray detailArray = result.getJSONArray("Details");

                for (int i=0; i<detailArray.length(); i++)
                {
                    JSONObject detailItem = detailArray.getJSONObject(i);
                    messageList.add(new InBoxDetaiList_Been(detailItem.getString("message_id"), detailItem.getString("thread_id"), detailItem.getString("user_id"), detailItem.getString("post_id"), detailItem.getString("user_name"), detailItem.getString("message"), detailItem.getString("date"),detailItem.getString("own_username")));
/*
                    if (!hashMap.get(SessionStore.USER_ID).equalsIgnoreCase(detailItem.getString("user_id")))
                    {
                        tv_title.setText(detailItem.getString("user_name").trim()+" - "+str_postName.trim());
                    }*/
                        InBoxDetail_Tab_Activity.str_postUserId = detailItem.getString("post_user_id").trim();



                }

            // For later message **********************************************************************************************************************************
               sortByDateAse();

               String str_pastDate="";

                for (int i = 0; i <messageList.size(); i++) {

                    String str_date = DateCoversion.getDateFromString(messageList.get(i).getDate());

                    if (!str_date.equalsIgnoreCase(str_pastDate)){
                        str_pastDate = str_date;


                    int countvalue=0;

                    for (int j = 0; j <messageList.size(); j++) {

                       if((!str_pastDate.equalsIgnoreCase(DateCoversion.getCurrentData())) && !str_pastDate.equalsIgnoreCase(DateCoversion.getYesterdayData())&& str_pastDate.equalsIgnoreCase(DateCoversion.getDateFromString(messageList.get(j).getDate()))){

                            messageList1.add( new InBoxDetaiList_Been(messageList.get(j).getMessage_id(), messageList.get(j).getThread_id(), messageList.get(j).getUser_id(), messageList.get(j).getPost_id(), messageList.get(j).getUser_name(), messageList.get(j).getMessage(),messageList.get(j).getDate(),messageList.get(j).getOwnerName()));
                             countvalue++;


                        }//end of if

                    }//end of inner for loop

                    InBoxDetaiList_Been[][] composerss = new InBoxDetaiList_Been[1][countvalue];
                    for (int j = 0; j <messageList.size(); j++) {

                        if((!str_pastDate.equalsIgnoreCase(DateCoversion.getCurrentData())) && !str_pastDate.equalsIgnoreCase(DateCoversion.getYesterdayData())&& str_pastDate.equalsIgnoreCase(DateCoversion.getDateFromString(messageList.get(j).getDate()))){


                            composerss[0][count] =  new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate(),messageList.get(j).getOwnerName());


                        }//end of if

                    }//end of for loop

                    pairMessageList.add(new Pair<String, List<InBoxDetaiList_Been>>(DateCoversion.getDateddMMMyyFromString(str_pastDate),  Arrays.asList(composerss[0])));
                    }

                }//end of outer for loop



/*

                    // For Past message *********************************************************************************************************************************

                count=0;
                for (int i = 0; i <messageList.size(); i++) {


                    if (!DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getCurrentData()) && !DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getYesterdayData())) {

                        messageList1.add( new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate()));
                        laterCount++;
                    }

                }
                if (laterCount!=0) {

                    //  Log.e("Heloooooo ","Current List: "+HomeScreen_MyJobList_Activity.myJobHeaderList.get(0).getJob_title());
                    InBoxDetaiList_Been[][] composerss = new InBoxDetaiList_Been[1][laterCount];
                    for (int i = 0; i <messageList.size(); i++) {

                        if (!DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getCurrentData()) && !DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getYesterdayData())) {

                            composerss[0][count] =  new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate());
                            count++;
                        }
                    }

                    pairMessageList.add(new Pair<String, List<InBoxDetaiList_Been>>("Past",  Arrays.asList(composerss[0])));

                }

*/


                // For Yesterday message ************************************************************************************************************************************

                count=0;
                for (int i = 0; i <messageList.size(); i++) {


                    if (DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getYesterdayData())) {

                        messageList1.add( new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate(),messageList.get(i).getOwnerName()));
                        yesturdayCount++;
                    }

                }

                if (yesturdayCount!=0) {

                    InBoxDetaiList_Been[][] composerss = new InBoxDetaiList_Been[1][yesturdayCount];
                    for (int i = 0; i <messageList.size(); i++) {

                        if (DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getYesterdayData())) {

                            composerss[0][count] =  new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate(),messageList.get(i).getOwnerName());
                            count++;
                        }
                    }

                    pairMessageList.add(new Pair<String, List<InBoxDetaiList_Been>>("Yesterday",  Arrays.asList(composerss[0])));

                }



                // For Today message ****************************************************************************************************************************************
                count=0;
                for (int i = 0; i <messageList.size(); i++) {

                    if (DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getCurrentData())) {

                        messageList1.add(new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(), messageList.get(i).getDate(),messageList.get(i).getOwnerName()));
                        todayCount++;
                    }

                }
                if (todayCount!=0) {

                    InBoxDetaiList_Been[][] composerss = new InBoxDetaiList_Been[1][todayCount];
                    for (int i = 0; i <messageList.size(); i++) {

                        if (DateCoversion.getDateFromString(messageList.get(i).getDate()).equalsIgnoreCase(DateCoversion.getCurrentData())) {

                            composerss[0][count] =  new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate(),messageList.get(i).getOwnerName());
                            count++;
                        }
                    }

                    pairMessageList.add(new Pair<String, List<InBoxDetaiList_Been>>("Today",  Arrays.asList(composerss[0])));

                }


                lv_listView.setPinnedHeaderView(LayoutInflater.from(context).inflate(R.layout.item_composer_header, lv_listView, false));
                lv_listView.setAdapter(new InBoxDetailList_Adapter(context, R.layout.inbox_detail_list_row,  messageList1, pairMessageList, tv_title, str_postName ));
                lv_listView.setSelection(messageList1.size()-1);



            }
            else
            {

                Toast toast= Toast.makeText(context, result.getString("message"), Toast.LENGTH_LONG);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();
            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }

        progressDialog.dismiss();

    }


    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByDateAse() {
        Comparator<InBoxDetaiList_Been> comparator = new Comparator<InBoxDetaiList_Been>() {

            @Override
            public int compare(InBoxDetaiList_Been object1, InBoxDetaiList_Been object2) {

              //  return object1.getDate().trim().compareToIgnoreCase(object2.getDate().trim());
                return object1.getDate().trim().compareToIgnoreCase(object2.getDate().trim());

            }
        };
        Collections.sort(messageList, comparator);

    }


}
