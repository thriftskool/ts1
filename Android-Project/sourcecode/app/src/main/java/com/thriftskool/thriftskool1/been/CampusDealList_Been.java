package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 13/8/15.
 */
public class CampusDealList_Been {

    String deal_id, user_id, deal_name,deal_code, description, crate_date, expirydate, image, imagepath;


    public CampusDealList_Been(String deal_id,String user_id, String deal_name, String deal_code, String description, String crate_date, String expirydate, String image, String imagepath) {
        this.deal_id = deal_id;
        this.deal_name = deal_name;
        this.deal_code = deal_code;
        this.description = description;
        this.crate_date = crate_date;
        this.expirydate = expirydate;
        this.image = image;
        this.imagepath = imagepath;
        this.user_id =user_id;
    }

    public String getDeal_code() {
        return deal_code;
    }

    public void setDeal_code(String deal_code) {
        this.deal_code = deal_code;
    }

    public String getDeal_id() {
        return deal_id;
    }

    public void setDeal_id(String deal_id) {
        this.deal_id = deal_id;
    }

    public String getDeal_name() {
        return deal_name;
    }

    public void setDeal_name(String deal_name) {
        this.deal_name = deal_name;
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
