package com.code.smither.apidoc.model;

/**
 * Api 实体信息
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class ApiBody extends HtmlModel {
    private String example;
    private String contentType;

    public String getExample() {
        return example;
    }

    public void setExample(String example) {
        this.example = example;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}
