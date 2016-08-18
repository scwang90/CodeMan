package com.codesmither.apidoc.model;

import com.codesmither.engine.api.IModel;

import java.util.List;

/**
 * APi 模块划分
 * Created by SCWANG on 2016/8/19.
 */
public class ApiModule implements IModel {

    private String name;
    private String description;
    private List<Api> apis;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Api> getApis() {
        return apis;
    }

    public void setApis(List<Api> apis) {
        this.apis = apis;
    }
}
