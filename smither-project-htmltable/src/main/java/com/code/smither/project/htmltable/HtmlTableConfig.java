package com.code.smither.project.htmltable;

import com.code.smither.engine.Config;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.database.impl.HtmlTableSource;

/**
 * 带Html的配置
 * Created by SCWANG on 2016/8/18.
 */
public class HtmlTableConfig extends ProjectConfig {

    protected String htmlTablePath = "";
    protected String htmlTableCharset = "UTF-8";

    protected transient TableSource tableSource;

    @Override
    public Config initEmptyFieldsWithDefaultValues() {
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

}
