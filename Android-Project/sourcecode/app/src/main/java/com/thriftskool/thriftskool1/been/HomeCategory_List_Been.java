package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 10/8/15.
 */
public class HomeCategory_List_Been {


   String post_cat_id, post_category_name, post_cat_image, imagepath,background_image;


    public HomeCategory_List_Been(String post_cat_id, String post_category_name, String post_cat_image, String imagepath, String background_image) {
        this.post_cat_id = post_cat_id;
        this.post_category_name = post_category_name;
        this.post_cat_image = post_cat_image;
        this.imagepath = imagepath;
        this.background_image = background_image;

    }


    public String getPost_cat_id() {
        return post_cat_id;
    }

    public void setPost_cat_id(String post_cat_id) {
        this.post_cat_id = post_cat_id;
    }

    public String getPost_category_name() {
        return post_category_name;
    }

    public void setPost_category_name(String post_category_name) {
        this.post_category_name = post_category_name;
    }

    public String getPost_cat_image() {
        return post_cat_image;
    }

    public void setPost_cat_image(String post_cat_image) {
        this.post_cat_image = post_cat_image;
    }

    public String getImagepath() {
        return imagepath;
    }

    public String getBackground_image() {
        return background_image;
    }

    public void setBackground_image(String background_image) {
        this.background_image = background_image;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

}
