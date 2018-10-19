package com.code.smither.apidoc.model;

import java.util.List;

/**
 * Api 返回信息
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class ApiResponse extends ApiBody{
    private List<ApiHeader> headers;

    public List<ApiHeader> getHeaders() {
        return headers;
    }

    public void setHeaders(List<ApiHeader> headers) {
        this.headers = headers;
    }
}
