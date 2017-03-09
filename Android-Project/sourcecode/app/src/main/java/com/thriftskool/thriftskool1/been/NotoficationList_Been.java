package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 14/9/15.
 */
public class NotoficationList_Been {


    String notification_id, reference_id, notification_type, id, user_id, name, image, image_id, imagepath;

    public NotoficationList_Been(String notification_id, String reference_id, String notification_type, String id, String user_id, String name, String image, String image_id, String imagepath) {
        this.notification_id = notification_id;
        this.reference_id = reference_id;
        this.notification_type = notification_type;
        this.id = id;
        this.user_id = user_id;
        this.name = name;
        this.image = image;
        this.image_id = image_id;
        this.imagepath = imagepath;
    }

    public String getNotification_id() {
        return notification_id;
    }

    public void setNotification_id(String notification_id) {
        this.notification_id = notification_id;
    }

    public String getReference_id() {
        return reference_id;
    }

    public void setReference_id(String reference_id) {
        this.reference_id = reference_id;
    }

    public String getNotification_type() {
        return notification_type;
    }

    public void setNotification_type(String notification_type) {
        this.notification_type = notification_type;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImage_id() {
        return image_id;
    }

    public void setImage_id(String image_id) {
        this.image_id = image_id;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }
}




