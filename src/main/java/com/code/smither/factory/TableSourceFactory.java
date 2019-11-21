package com.code.smither.factory;

import com.code.smither.factory.api.DbFactory;
import com.code.smither.kernel.DbTableSource;
import com.code.smither.kernel.MySqlTableSource;
import com.code.smither.kernel.OracleTableSource;
import com.code.smither.kernel.SqlServerTableSource;
import com.code.smither.kernel.api.Converter;
import com.code.smither.kernel.api.TableSource;

import java.sql.SQLException;

/**
 * 表源工厂
 * Created by SCWANG on 2016/8/1.
 */
public class TableSourceFactory {

    private static final String PATTERN_MYSQL = "jdbc:mysql:.*";
    private static final String PATTERN_ORACLE = "jdbc:oracle:.*";
    private static final String PATTERN_SQL_SERVER = "jdbc:sqlserver:.*";

    public static TableSource getInstance(DbFactory factory, Converter converter) throws SQLException {
        String jdbcUrl = factory.getJdbcUrl();
        if (jdbcUrl.matches(PATTERN_MYSQL)) {
            return new MySqlTableSource(factory.getConnection(), converter);
        } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
            return new OracleTableSource(factory.getConnection(), converter);
        } else if (jdbcUrl.matches(PATTERN_SQL_SERVER)) {
            return new SqlServerTableSource(factory.getConnection(), converter);
        }
        return new DbTableSource(factory.getConnection(), converter);
    }
}
