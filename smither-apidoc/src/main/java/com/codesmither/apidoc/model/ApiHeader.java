package com.codesmither.apidoc.model;

/**
 * Api头部信息
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class ApiHeader extends HtmlModel {
    private String name;
    private String type = "String";
    private String sample;
    private String description;
    private boolean nullable = false;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSample() {
        return sample;
    }

    public void setSample(String sample) {
        this.sample = sample;
    }

    public boolean isNullable() {
        return nullable;
    }

    public void setNullable(boolean nullable) {
        this.nullable = nullable;
    }
}
