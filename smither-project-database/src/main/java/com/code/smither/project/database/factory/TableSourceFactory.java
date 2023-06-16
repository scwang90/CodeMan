package com.code.smither.project.database.factory;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.database.DataBaseConfig;
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
    private static final String PATTERN_POSTGRESQL = "jdbc:postgresql:.*";


    public static DbTableSource getInstance(DataBaseConfig config, DbFactory factory) {
        return new DbTableSource(config, getDataSource(config, factory));
    }

    public static DbDataSource getDataSource(DataBaseConfig config, DbFactory factory) {
        String jdbcUrl = config.getDbUrl();
        if (jdbcUrl.matches(PATTERN_MYSQL)) {
            return new MySqlTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
            return new OracleTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_SQL_SERVER)) {
            return new SqlServerTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_SQL_LITE)) {
            return new SqLiteTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_POSTGRESQL)) {
            return new PostgreSqlTableSource(config, factory);
        }
        return new DefaultDataSource(config, factory);
    }
}
