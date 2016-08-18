package com.codesmither.apidoc.model;

/**
 * Api 实体信息
 * Created by SCWANG on 2016/8/19.
 */
public class ApiBody {
    private String sample;
    private String contentType;

    public String getSample() {
        return sample;
    }

    public void setSample(String sample) {
        this.sample = sample;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}
