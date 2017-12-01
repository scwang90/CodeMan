package com.codesmither.project.database.factory;

import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.base.api.TableSource;
import com.codesmither.project.database.impl.*;

/**
 * 表源工厂
 * Created by SCWANG on 2016/8/1.
 */
public class TableSourceFactory {

    private static final String PATTERN_MYSQL = "jdbc:mysql:.*";
    private static final String PATTERN_SQLERVER = "jdbc:sqlserver:.*";
    private static final String PATTERN_ORACLE = "jdbc:oracle:.*";
    private static final String PATTERN_SQLITE = "jdbc:sqlite:.*";

    public static DbTableSource getInstance(ProjectConfig config, DbFactory factory) {
        String jdbcUrl = factory.getJdbcUrl();
        if (jdbcUrl.matches(PATTERN_MYSQL)) {
            return new MySqlTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
            return new OracleTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_SQLERVER)) {
            return new SqlServerTableSource(config, factory);
        } else if (jdbcUrl.matches(PATTERN_SQLITE)) {
            return new SqliteTableSource(config, factory);
        }
        return new DbTableSource(config, factory);
    }
}
