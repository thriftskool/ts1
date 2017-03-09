package com.thriftskool.thriftskool1.been;

import java.io.Serializable;

/**
 * Created by etiloxadmin on 4/9/15.
 */
public class Image_Been  implements Serializable{

    String image_id, title,image,imagepath;


    public Image_Been(String image_id, String title, String image, String imagepath) {
        this.image_id = image_id;
        this.title = title;
        this.image = image;
        this.imagepath = imagepath;
    }

    public String getImage_id() {
        return image_id;
    }

    public void setImage_id(String image_id) {
        this.image_id = image_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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
