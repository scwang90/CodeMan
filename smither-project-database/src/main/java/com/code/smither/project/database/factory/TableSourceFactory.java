package com.code.smither.project.database.factory;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.database.api.DbDataSource;
import com.code.smither.project.database.api.DbFactory;
import com.code.smither.project.database.impl.*;

/**
 * 表源工厂
 * Created by SCWANG on 2016/8/1.
 */
public class TableSourceFactory {

    private static final String PATTERN_MYSQL = "jdbc:mysql:.*";
    private static final String PATTERN_ORACLE = "jdbc:oracle:.*";
    private static final String PATTERN_SQL_LITE = "jdbc:sqlite:.*";
    private static final String PATTERN_SQL_SERVER = "jdbc:sqlserver:.*";


    public static DbTableSource getInstance(ProjectConfig config, DbFactory factory) {
        return new DbTableSource(config, getDataSource(factory));
    }

    public static DbDataSource getDataSource(DbFactory factory) {
        String jdbcUrl = factory.getJdbcUrl();
        if (jdbcUrl.matches(PATTERN_MYSQL)) {
            return new MySqlTableSource(factory);
        } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
            return new OracleTableSource(factory);
        } else if (jdbcUrl.matches(PATTERN_SQL_SERVER)) {
            return new SqlServerTableSource(factory);
        } else if (jdbcUrl.matches(PATTERN_SQL_LITE)) {
            return new SqLiteTableSource(factory);
        }
        return new DefaultDataSource(factory);
    }
}
