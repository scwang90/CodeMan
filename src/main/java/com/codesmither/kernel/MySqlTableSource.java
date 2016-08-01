package com.codesmither.kernel;

import com.codesmither.kernel.api.Converter;

import java.sql.Connection;

/**
 * MySql 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class MySqlTableSource extends DbTableSource {

    public MySqlTableSource(Connection connection, Converter converter) {
        this(connection, converter, false);
    }

    public MySqlTableSource(Connection connection, Converter converter, boolean autoclose) {
        super(connection, converter, autoclose);
    }
}
