package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 31/8/15.
 */
public class EditPostGallary_Been {

    String imageId, Image;


    public EditPostGallary_Been(String imageId, String image) {
        this.imageId = imageId;
        Image = image;
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }
}
