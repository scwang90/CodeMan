package com.codesmither.project.base.model;

/**
 * 模板Model-jdbc
 * Created by SCWANG on 2015-07-04.
 */
@SuppressWarnings("unused")
public class DatabaseJdbc {

    private String driver;
    private String url;
    private String username;
    private String password;

    public DatabaseJdbc() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
