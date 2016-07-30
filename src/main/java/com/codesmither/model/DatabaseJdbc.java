package com.codesmither.model;

/**
 * 模板Model-jdbc
 * Created by SCWANG on 2015-07-04.
 */
public class DatabaseJdbc {

    private String driver;
    private String url;
    private String usename;
    private String password;

    public DatabaseJdbc() {
    }

    public String getUsename() {
        return usename;
    }

    public void setUsename(String usename) {
        this.usename = usename;
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
