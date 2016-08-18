package com.codesmither.apidoc.model;

import java.util.List;

/**
 * Api 基本信息
 * Created by SCWANG on 2016/8/19.
 */
public class Api {

    private String name;
    private String path;
    private String description;
    private List<ApiHeader> headers;
    private List<ApiParam> params;
    private ApiBody body;
    private ApiResponse response;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ApiHeader> getHeaders() {
        return headers;
    }

    public void setHeaders(List<ApiHeader> headers) {
        this.headers = headers;
    }

    public List<ApiParam> getParams() {
        return params;
    }

    public void setParams(List<ApiParam> params) {
        this.params = params;
    }

    public ApiBody getBody() {
        return body;
    }

    public void setBody(ApiBody body) {
        this.body = body;
    }

    public ApiResponse getResponse() {
        return response;
    }

    public void setResponse(ApiResponse response) {
        this.response = response;
    }
}
