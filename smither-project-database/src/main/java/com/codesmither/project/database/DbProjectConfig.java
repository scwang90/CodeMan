package com.codesmither.project.database;

import com.codesmither.project.base.ProjectConfig;

/**
 * 带数据库的配置
 * Created by SCWANG on 2016/8/18.
 */
public class DbProjectConfig extends ProjectConfig {

    protected String dbConfigName;

    public String getDbConfigName() {
        return dbConfigName;
    }

    public void setDbConfigName(String dbConfigName) {
        this.dbConfigName = dbConfigName;
    }
}
