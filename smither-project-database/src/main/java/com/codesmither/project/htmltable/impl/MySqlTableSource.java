package com.codesmither.project.htmltable.impl;

import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;

/**
 * MySql 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class MySqlTableSource extends DbTableSource {

    public MySqlTableSource(ProjectConfig config, DbFactory dbFactory) {
        this(config, dbFactory, false);
    }

    public MySqlTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoclose) {
        super(config, dbFactory, autoclose);
    }

}
