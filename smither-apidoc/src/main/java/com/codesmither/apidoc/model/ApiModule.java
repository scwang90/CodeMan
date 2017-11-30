package com.codesmither.apidoc.model;

import com.codesmither.engine.api.IModel;

import java.util.List;

/**
 * APi 模块划分
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class ApiModule extends HtmlModel implements IModel {

    private String name;
    private String displayName;
    private String path;
    private String assistant;
    private String description;
    private List<Api> apis;
    private List<ApiHeader> headers;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
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

    public List<ApiHeader> getHeaders() {
        return headers;
    }

    public void setHeaders(List<ApiHeader> headers) {
        this.headers = headers;
    }
}
