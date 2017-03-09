package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusBuzzList_Been {


    String buzz_id, user_id, buzz_name, description, crate_date, expirydate, image, imagepath;


    public CampusBuzzList_Been(String buzz_id,String user_id, String buzz_name, String description, String crate_date, String expirydate, String image, String imagepath) {
        this.buzz_id = buzz_id;
        this.buzz_name = buzz_name;
        this.description = description;
        this.crate_date = crate_date;
        this.expirydate = expirydate;
        this.image = image;
        this.imagepath = imagepath;
        this.user_id = user_id;
    }


    public String getBuzz_id() {
        return buzz_id;
    }

    public void setBuzz_id(String buzz_id) {
        this.buzz_id = buzz_id;
    }

    public String getBuzz_name() {
        return buzz_name;
    }

    public void setBuzz_name(String buzz_name) {
        this.buzz_name = buzz_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCrate_date() {
        return crate_date;
    }

    public void setCrate_date(String crate_date) {
        this.crate_date = crate_date;
    }

    public String getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(String expirydate) {
        this.expirydate = expirydate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImagepath() {
        return imagepath;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }
}
