package com.codesmither.project.database.impl;

import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.Converter;

import java.sql.Connection;

/**
 * Oracle 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class OracleTableSource extends DbTableSource {

    public OracleTableSource(ProjectConfig config, Connection connection) {
        this(config, connection, false);
    }

    public OracleTableSource(ProjectConfig config, Connection connection, boolean autoclose) {
        super(config, connection, autoclose);
    }
}
