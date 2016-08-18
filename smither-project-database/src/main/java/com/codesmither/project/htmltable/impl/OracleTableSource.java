package com.codesmither.project.htmltable.impl;

import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;

/**
 * Oracle 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class OracleTableSource extends DbTableSource {

    public OracleTableSource(ProjectConfig config, DbFactory dbFactory) {
        this(config, dbFactory, false);
    }

    public OracleTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoclose) {
        super(config, dbFactory, autoclose);
    }

}
