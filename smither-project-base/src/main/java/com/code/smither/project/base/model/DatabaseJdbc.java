package com.code.smither.project.base.model;

import lombok.Data;

/**
 * 模板Model-jdbc
 * Created by SCWANG on 2015-07-04.
 */
@Data
@SuppressWarnings("unused")
public class DatabaseJdbc {

    private String driver;
    private String url;
    private String username;
    private String password;

    public void setUrl(String url) {
        this.url = url.replaceAll("[?|&]\\w+=\\w+","");
    }
}
