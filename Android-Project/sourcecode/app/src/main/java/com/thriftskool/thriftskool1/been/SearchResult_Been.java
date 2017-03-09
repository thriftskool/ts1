package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 12/9/15.
 */
public class SearchResult_Been {

    String type,id,user_id,title,price,expirydate,status,imagepath,image,image_id;

    public SearchResult_Been(String type, String id, String user_id, String title, String price, String status, String expirydate, String imagepath, String image, String image_id) {
        this.type = type;
        this.id = id;
        this.user_id = user_id;
        this.title = title;
        this.price = price;
        this.expirydate = expirydate;
        this.imagepath = imagepath;
        this.image = image;
        this.status = status;

        this.image_id = image_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(String expirydate) {
        this.expirydate = expirydate;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImage_id() {
        return image_id;
    }

    public void setImage_id(String image_id) {
        this.image_id = image_id;
    }
}
