package com.thriftskool.thriftskool1.been;

/**
 * Created by etiloxadmin on 6/8/15.
 */
public class UniversityList_Been {


    String university_id,university_name,domain_name, image, imagepath;
    boolean isChecked;


    public UniversityList_Been(String university_id, String university_name, String domain_name, String image, String imagepath, boolean isChecked) {
        this.university_id = university_id;
        this.university_name = university_name;
        this.domain_name = domain_name;
        this.image = image;
        this.imagepath = imagepath;
        this.isChecked = isChecked;
    }


    public String getUniversity_id() {
        return university_id;
    }

    public void setUniversity_id(String university_id) {
        this.university_id = university_id;
    }

    public String getUniversity_name() {
        return university_name;
    }

    public void setUniversity_name(String university_name) {
        this.university_name = university_name;
    }

    public String getDomain_name() {
        return domain_name;
    }

    public void setDomain_name(String domain_name) {
        this.domain_name = domain_name;
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

    public boolean isChecked() {
        return isChecked;
    }

    public void setIsChecked(boolean isChecked) {
        this.isChecked = isChecked;
    }
}
