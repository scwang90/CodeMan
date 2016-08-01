package com.codesmither.kernel.api;

/**
 * Html表源配置
 * Created by SCWANG on 2016/8/1.
 */
public class HtmlTableConfig extends Config {

    protected String htmlTablePath = "";
    protected String htmlTableCharset = "UTF-8";

    public String getHtmlTablePath() {
        return htmlTablePath;
    }

    public void setHtmlTablePath(String htmlTablePath) {
        this.htmlTablePath = htmlTablePath;
    }

    public String getHtmlTableCharset() {
        return htmlTableCharset;
    }

    public void setHtmlTableCharset(String htmlTableCharset) {
        this.htmlTableCharset = htmlTableCharset;
    }
}
