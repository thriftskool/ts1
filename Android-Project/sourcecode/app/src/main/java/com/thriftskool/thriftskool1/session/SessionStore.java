package com.thriftskool.thriftskool1.session;

import java.util.HashMap;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;



public class SessionStore {

 
 public static final String USER_ID = "login_id";
 public static final String UNIVERSITY_ID = "university_id";
 public static final String USER_NAME = "user_Name";
 public static final String UNIVERSITY_NAME = "university_Name";
 public static final String UNIVERSITY_IMAGE = "university_Image";
 public static final String USER_EMAIL= "user_Email";
 public static final String PROFILE_IMG= "profile_img";
 public static final String PROFILEIMG_PATH= "profileImg_path";
 public static final String CLASS_ID= "class_id";
 public static final String PERSON_NAME= "person_name";






 public static boolean save(Context context,String pre_Name, String user_ID,String university_ID, String user_Name, String university_Name, String university_Image, String user_Email,String profile_img,String class_id,String profileImg_path,String person_name) {


  Editor editor =context.getSharedPreferences(pre_Name, Context.MODE_PRIVATE).edit();
  editor.putString(USER_ID,user_ID );
  editor.putString(UNIVERSITY_ID,university_ID );
  editor.putString(USER_NAME,user_Name );
  editor.putString(UNIVERSITY_NAME, university_Name);
  editor.putString(UNIVERSITY_IMAGE, university_Image);
  editor.putString(USER_EMAIL, user_Email);
  editor.putString(PROFILEIMG_PATH, profileImg_path);
  editor.putString(PROFILE_IMG, profile_img);
  editor.putString(CLASS_ID, class_id);
  editor.putString(PERSON_NAME, person_name);




  return editor.commit();


 }
 
 
 public static HashMap<String, String> getUserDetails(Context context,String name)
 {
  SharedPreferences  pref = context.getSharedPreferences(name, Context.MODE_PRIVATE);
  HashMap<String, String> user = new HashMap<String, String>();
 
  user.put(USER_ID, pref.getString(USER_ID, null));
  user.put(UNIVERSITY_ID, pref.getString(UNIVERSITY_ID, null));
  user.put(USER_NAME, pref.getString(USER_NAME, null));
  user.put(UNIVERSITY_NAME, pref.getString(UNIVERSITY_NAME, null));
  user.put(USER_EMAIL, pref.getString(USER_EMAIL, null));
  user.put(UNIVERSITY_IMAGE, pref.getString(UNIVERSITY_IMAGE, null));
  user.put(CLASS_ID, pref.getString(CLASS_ID, null));
  user.put(PROFILEIMG_PATH, pref.getString(PROFILEIMG_PATH, null));
  user.put(PROFILE_IMG, pref.getString(PROFILE_IMG, null));
  user.put(PERSON_NAME, pref.getString(PERSON_NAME, null));


  // return user
  return user;
 }

 public static void clear(Context context, String name ) {
  Editor editor = context.getSharedPreferences(name, Context.MODE_PRIVATE).edit();
  editor.clear();
  editor.commit();
 }

}
