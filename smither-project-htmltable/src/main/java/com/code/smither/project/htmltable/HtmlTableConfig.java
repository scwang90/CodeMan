package com.code.smither.project.htmltable;

import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.database.impl.HtmlTableSource;

/**
 * 带Html的配置
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("WeakerAccess")
public class HtmlTableConfig extends ProjectConfig {

    protected String htmlTablePath = "";
    protected String htmlTableCharset = "UTF-8";

    protected String jdbcUrl;
    protected String jdbcDriver;
    protected String jdbcUsername;
    protected String jdbcPassword;

    protected transient TableSource tableSource;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (tableSource == null) {
            tableSource = new HtmlTableSource(this);
        }
        return this;
    }

    public TableSource getTableSource() {
        return tableSource;
    }

    public void setTableSource(TableSource tableSource) {
        this.tableSource = tableSource;
    }

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

    public String getJdbcUrl() {
        return jdbcUrl;
    }

    public void setJdbcUrl(String jdbcUrl) {
        this.jdbcUrl = jdbcUrl;
    }

    public String getJdbcDriver() {
        return jdbcDriver;
    }

    public void setJdbcDriver(String jdbcDriver) {
        this.jdbcDriver = jdbcDriver;
    }

    public String getJdbcUsername() {
        return jdbcUsername;
    }

    public void setJdbcUsername(String jdbcUsername) {
        this.jdbcUsername = jdbcUsername;
    }

    public String getJdbcPassword() {
        return jdbcPassword;
    }

    public void setJdbcPassword(String jdbcPassword) {
        this.jdbcPassword = jdbcPassword;
    }

}
