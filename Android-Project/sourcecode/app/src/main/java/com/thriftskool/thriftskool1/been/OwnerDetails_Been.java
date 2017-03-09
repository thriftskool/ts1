package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 30/9/16.
 */
public class OwnerDetails_Been
{
    String username,profile_img,person_name,class_name,imagepath;

    public OwnerDetails_Been(String username, String profile_img, String person_name, String class_name, String imagepath) {
        this.username = username;
        this.profile_img = profile_img;
        this.person_name = person_name;
        this.class_name = class_name;
        this.imagepath = imagepath;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProfile_img() {
        return profile_img;
    }

    public void setProfile_img(String profile_img) {
        this.profile_img = profile_img;
    }

    public String getPerson_name() {
        return person_name;
    }

    public void setPerson_name(String person_name) {
        this.person_name = person_name;
    }

    public String getClass_name() {
        return class_name;
    }

    public void setClass_name(String class_name) {
        this.class_name = class_name;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }
}
