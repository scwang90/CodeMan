package com.codesmither.factory;

import com.codesmither.factory.api.DbFactory;
import com.codesmither.kernel.DbTableSource;
import com.codesmither.kernel.MySqlTableSource;
import com.codesmither.kernel.OracleTableSource;
import com.codesmither.kernel.SqlServerTableSource;
import com.codesmither.kernel.api.Converter;
import com.codesmither.kernel.api.TableSource;
import com.sun.org.apache.xalan.internal.xsltc.compiler.Pattern;

import java.sql.SQLException;

/**
 * 表源工厂
 * Created by SCWANG on 2016/8/1.
 */
public class TableSourceFactory {

    private static final String PATTERN_MYSQL = "jdbc:mysql:.*";
    private static final String PATTERN_SQLERVER = "jdbc:sqlserver:.*";
    private static final String PATTERN_ORACLE = "jdbc:oracle:.*";

    public static TableSource getInstance(DbFactory factory, Converter converter) throws SQLException {
        String jdbcUrl = factory.getJdbcUrl();
        if (jdbcUrl.matches(PATTERN_MYSQL)) {
            return new MySqlTableSource(factory.getConnection(), converter);
        } else if (jdbcUrl.matches(PATTERN_SQLERVER)) {
            return new SqlServerTableSource(factory.getConnection(), converter);
        } else if (jdbcUrl.matches(PATTERN_ORACLE)) {
            return new OracleTableSource(factory.getConnection(), converter);
        }
        return new DbTableSource(factory.getConnection(), converter);
    }
}
