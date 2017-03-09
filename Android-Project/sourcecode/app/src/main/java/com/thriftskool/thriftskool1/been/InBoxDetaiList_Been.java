package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 24/8/15.
 */
public class InBoxDetaiList_Been {

    String message_id, thread_id, user_id, post_id, user_name, message, date,ownerName;

    public InBoxDetaiList_Been(String message_id, String thread_id, String user_id, String post_id, String user_name, String message, String date,String ownerName) {
        this.message_id = message_id;
        this.thread_id = thread_id;
        this.user_id = user_id;
        this.post_id = post_id;
        this.user_name = user_name;
        this.message = message;
        this.date = date;
        this.ownerName=ownerName;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getMessage_id() {
        return message_id;
    }

    public void setMessage_id(String message_id) {
        this.message_id = message_id;
    }

    public String getThread_id() {
        return thread_id;
    }

    public void setThread_id(String thread_id) {
        this.thread_id = thread_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
