package com.thriftskool.thriftskool1.asynctask;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.util.Pair;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.adapter.InBoxDetailList_Adapter;
import com.thriftskool.thriftskool1.been.InBoxDetaiList_Been;
import com.thriftskool.thriftskool1.comman.Comman;
import com.thriftskool.thriftskool1.comman.DateCoversion;
import com.thriftskool.thriftskool1.inbox_detail.InBoxDetailScreen_Activity;
import com.thriftskool.thriftskool1.widgets.AmazingListView;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


public class SendMessage_AsyncTask  extends AsyncTask<String, Integer, JSONObject>
{

    ProgressDialog progressDialog;
    Context context;
    EditText et_message;
    private AmazingListView lv_listView;
    private TextView tv_send;
    private List<InBoxDetaiList_Been> messageList = new ArrayList<InBoxDetaiList_Been>();
    private ArrayAdapter<InBoxDetaiList_Been> adapter;
    private String str_userName="", str_userId="";
    private TextView tv_title;
    private String str_postName="",str_ThreadId="";
    private List<InBoxDetaiList_Been> messageList1 = new ArrayList<InBoxDetaiList_Been>();
    private List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList = new ArrayList<Pair<String, List<InBoxDetaiList_Been>>>();



    public SendMessage_AsyncTask(Context contex, EditText et_message, AmazingListView lv_listView, List<InBoxDetaiList_Been> messageList, TextView tv_send, TextView tv_title,String str_postName, String str_ThreadId,List<InBoxDetaiList_Been> messageList1,List<Pair<String, List<InBoxDetaiList_Been>>> pairMessageList)
    {
        // TODO Auto-generated constructor stub

        this.context=contex;
        this.et_message = et_message;
        this.messageList1 = messageList1;
        this.pairMessageList = pairMessageList;
        this.lv_listView =lv_listView;
        this.messageList = messageList;
        this.tv_send =tv_send;
        this.tv_title =tv_title;
        this.str_postName = str_postName;
        this.str_ThreadId=str_ThreadId;

        progressDialog = new ProgressDialog(contex);
        progressDialog.setMessage("Please wait...");
        progressDialog.setCancelable(false);


    }


    @Override
    protected JSONObject doInBackground(String... params) {
        // TODO Auto-generated method stub


        JSONObject jsonresponse=null;

        try
        {
            str_userName = (params[2]);
            str_userId = (params[1]);


            JSONObject json = new JSONObject();
            json.put("post_id", Integer.parseInt(params[0]));
            json.put("user_id", Integer.parseInt(params[1]));
            json.put("user_name", (params[2]));
            json.put("message", (params[3]));
            json.put("create_date", (params[4]));
            json.put("post_name", (params[5]));
            json.put("thread_id",(params[6]));
          //  json.put("thread_id", messageList1.get(2).getThread_id());
            json.put("reply_id", (params[7]));

            tv_send.setEnabled(true);
            tv_send.setClickable(true);

            Log.e("Example,,,", " " +str_ThreadId);

            String response = Utility.postRequest(Comman.URL + "send_message", json.toString(), context);
            JSONObject jObject = new JSONObject(response);
            jsonresponse = jObject.getJSONObject("Response");





        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Excaption Replay Msg"," "+e.getMessage());
        }



        return jsonresponse;
    }

    @Override
    protected void onPreExecute()
    {
        // TODO Auto-generated method stub
        super.onPreExecute();

        if(progressDialog!=null && !progressDialog.isShowing())
        {
               progressDialog.dismiss();
        }
    }

    @Override
    protected void onPostExecute(JSONObject result) {
        // TODO Auto-generated method stub
        super.onPostExecute(result);
        // progressDialog.dismiss();


        try
        {

            Log.e("Error fo msg","   "+result.toString());

            if (result.getString("status").trim().equalsIgnoreCase("201"))
            {

                int pos = lv_listView.getFirstVisiblePosition();
                int todayCount=0,yesturdayCount=0,laterCount=0,count=0;

                messageList1.clear();
                pairMessageList.clear();


                Toast toast=Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

                messageList.add(new InBoxDetaiList_Been("0", "0", str_userId, "0", str_userName, et_message.getText().toString().trim(), DateCoversion.getCurrentData() + " " + DateCoversion.getUTCTime(), ""));
                //messageList.add(new InBoxDetaiList_Been(detailItem.getString("message_id"), detailItem.getString("thread_id"), detailItem.getString("user_id"), detailItem.getString("post_id"), detailItem.getString("user_name"), detailItem.getString("message"), detailItem.getString("date")));

                et_message.setText("");



                // For later message **********************************************************************************************************************************
                sortByDateAse();

                String str_pastDate="";

                for (int i = 0; i <messageList.size(); i++) {

                    String str_date = DateCoversion.getDateFromString(messageList.get(i).getDate());

                    if (!str_date.equalsIgnoreCase(str_pastDate)){
                        str_pastDate = str_date;


                        int countvalue=0;

                        for (int j = 0; j <messageList.size(); j++) {

                            if(!str_pastDate.equalsIgnoreCase(DateCoversion.getCurrentData()) && !str_pastDate.equalsIgnoreCase(DateCoversion.getYesterdayData())&& str_pastDate.equalsIgnoreCase(DateCoversion.getDateFromString(messageList.get(j).getDate()))){

                                messageList1.add( new InBoxDetaiList_Been(messageList.get(j).getMessage_id(), messageList.get(j).getThread_id(), messageList.get(j).getUser_id(), messageList.get(j).getPost_id(), messageList.get(j).getUser_name(), messageList.get(j).getMessage(),messageList.get(j).getDate(),messageList.get(j).getOwnerName()));
                                countvalue++;


                            }//end of if

                        }//end of inner for loop

                        InBoxDetaiList_Been[][] composerss = new InBoxDetaiList_Been[1][countvalue];
                        for (int j = 0; j <messageList.size(); j++) {

                            if(!str_pastDate.equalsIgnoreCase(DateCoversion.getCurrentData()) && !str_pastDate.equalsIgnoreCase(DateCoversion.getYesterdayData())&& str_pastDate.equalsIgnoreCase(DateCoversion.getDateFromString(messageList.get(j).getDate()))){


                                composerss[0][count] =  new InBoxDetaiList_Been(messageList.get(i).getMessage_id(), messageList.get(i).getThread_id(), messageList.get(i).getUser_id(), messageList.get(i).getPost_id(), messageList.get(i).getUser_name(), messageList.get(i).getMessage(),messageList.get(i).getDate(),messageList.get(i).getOwnerName());


                            }//end of if

                        }//end of for loop

                        pairMessageList.add(new Pair<String, List<InBoxDetaiList_Been>>(DateCoversion.getDateddMMMyyFromString(str_pastDate),  Arrays.asList(composerss[0])));
                    }

                }//end of outer for loop





                // For Yesturday

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



                // For Today
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
                lv_listView.setAdapter(new InBoxDetailList_Adapter(context, R.layout.inbox_detail_list_row, messageList1, pairMessageList, tv_title, str_postName));
                lv_listView.setSelection(messageList1.size()-1);



            }
            else
            {



                Toast toast=  Toast.makeText(context, result.getString("message"), Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER,0,0);
                toast.show();

            }



        }
        catch(Exception e)
        {

            e.getStackTrace();
            Log.e("Exception", " Category List Exception: " + e.getMessage());
        }


    }

    /** Sort shopping list by Expiry Date*/
    //...... Expiry date
    public void sortByDateAse() {
        Comparator<InBoxDetaiList_Been> comparator = new Comparator<InBoxDetaiList_Been>() {

            @Override
            public int compare(InBoxDetaiList_Been object1, InBoxDetaiList_Been object2) {


                return object1.getDate().trim().compareToIgnoreCase(object2.getDate().trim());
            }
        };
        Collections.sort(messageList, comparator);

    }


}
