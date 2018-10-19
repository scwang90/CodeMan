package com.code.smither.kernel;

import com.code.smither.kernel.api.Converter;

import java.sql.Connection;

/**
 * Oracle 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class OracleTableSource extends DbTableSource {

    public OracleTableSource(Connection connection, Converter converter) {
        this(connection, converter, false);
    }

    public OracleTableSource(Connection connection, Converter converter, boolean autoclose) {
        super(connection, converter, autoclose);
    }
}
