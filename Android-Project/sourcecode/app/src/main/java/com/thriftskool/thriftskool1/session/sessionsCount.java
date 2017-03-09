package com.thriftskool.thriftskool1.session;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.HashMap;

/**
 * Created by etiloxadmin on 17/11/15.
 */
public class sessionsCount
{
    public static final String COUNT=null;


    public static boolean save(Context context,String pre_Name,int NOTI_COUNT)
    {

        SharedPreferences.Editor editor =context.getSharedPreferences(pre_Name, Context.MODE_PRIVATE).edit();
        editor.putInt(COUNT, NOTI_COUNT);

        return editor.commit();

    }


    public static HashMap<String, String> getCount(Context context,String name)
    {
        SharedPreferences  pref = context.getSharedPreferences(name, Context.MODE_PRIVATE);
        HashMap<String, String> user = new HashMap<String, String>();

         user.put(COUNT, String.valueOf(pref.getInt(COUNT, 0)));

        // return user
        return user;
    }

    public static void clear(Context context, String name ) {
    SharedPreferences.Editor editor = context.getSharedPreferences(name, Context.MODE_PRIVATE).edit();
    editor.clear();
    editor.commit();
}

}
