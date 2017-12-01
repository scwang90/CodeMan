package com.codesmither.project.database;

import com.codesmither.engine.Config;
import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.base.api.TableSource;
import com.codesmither.project.database.factory.C3P0Factory;
import com.codesmither.project.database.factory.TableSourceFactory;
import com.codesmither.project.database.impl.DbTableSource;

/**
 * 带数据库的配置
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class DataBaseConfig extends ProjectConfig {

    protected String dbConfigName;

    protected transient DbFactory dbFactory = null;
    protected transient DbTableSource tableSource = null;

    @Override
    public Config initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (dbFactory == null) {
            dbFactory = C3P0Factory.getInstance(getDbConfigName());
        }
        if (tableSource == null) {
            tableSource = TableSourceFactory.getInstance(this, dbFactory);
        }
        return this;
    }

    public String getDbConfigName() {
        return dbConfigName;
    }

    public void setDbConfigName(String dbConfigName) {
        this.dbConfigName = dbConfigName;
    }

    public DbFactory getDbFactory() {
        return dbFactory;
    }

    public void setDbFactory(DbFactory dbFactory) {
        this.dbFactory = dbFactory;
    }

    public DbTableSource getTableSource() {
        return tableSource;
    }

    public void setTableSource(DbTableSource tableSource) {
        this.tableSource = tableSource;
    }
}
