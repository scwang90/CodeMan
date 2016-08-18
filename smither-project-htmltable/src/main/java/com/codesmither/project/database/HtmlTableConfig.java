package com.codesmither.project.database;

import com.codesmither.project.base.ProjectConfig;

/**
 * 带Html的配置
 * Created by SCWANG on 2016/8/18.
 */
public class HtmlTableConfig extends ProjectConfig {

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
