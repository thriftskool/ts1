package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 18/8/15.
 */
public class MyPostList_Been {


    String post_id, user_id, type, post_name, description, price, status, favorite, expirydate, image, imagepath;


    public MyPostList_Been(String post_id, String user_id,String type,  String post_name, String description, String price, String status, String favorite, String expirydate, String image, String imagepath) {
        this.post_id = post_id;
        this.user_id = user_id;
        this.post_name = post_name;
        this.description = description;
        this.price = price;
        this.status = status;
        this.favorite = favorite;
        this.expirydate = expirydate;
        this.image = image;
        this.imagepath = imagepath;
        this.type= type;

    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPost_name() {
        return post_name;
    }

    public void setPost_name(String post_name) {
        this.post_name = post_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFavorite() {
        return favorite;
    }

    public void setFavorite(String favorite) {
        this.favorite = favorite;
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

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }
}
