package com.code.smither.project.database.impl;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.api.DbFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * MySql 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class MySqlTableSource extends DefaultDataSource implements Database {

    public MySqlTableSource(DataBaseConfig config, DbFactory dbFactory) {
        this(config, dbFactory, false);
    }

    public MySqlTableSource(DataBaseConfig config, DbFactory dbFactory, boolean autoclose) {
        super(config, dbFactory, autoclose);
    }

    @Override
    public String name() {
        return "mysql";
    }

    @Override
    public Database getDatabase() {
        return this;
    }

    @Override
    public boolean isKeyword(String value) {
        for (String keyword : keywords) {
            if (keyword.equalsIgnoreCase(value)) {
                return true;
            }
        }
        return value.matches(".*[^\\x00-\\xff].*");
    }

    @Override
    public String wrapperKeyword(String name) {
        return '`' + name + '`';
    }

    private static final String[] keywords = "ADD,ALL,ALTER,ANALYZE,AND,AS,ASC,ASENSITIVE,BEFORE,BETWEEN,BIGINT,BINARY,BLOB,BOTH,BY,CALL,CASCADE,CASE,CHANGE,CHAR,CHARACTER,CHECK,COLLATE,COLUMN,CONDITION,CONNECTION,CONSTRAINT,CONTINUE,CONVERT,CREATE,CROSS,CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,CURSOR,DATABASE,DATABASES,DAY_HOUR,DAY_MICROSECOND,DAY_MINUTE,DAY_SECOND,DEC,DECIMAL,DECLARE,DEFAULT,DELAYED,DELETE,DESC,DESCRIBE,DETERMINISTIC,DISTINCT,DISTINCTROW,DIV,DOUBLE,DROP,DUAL,EACH,ELSE,ELSEIF,ENCLOSED,ESCAPED,EXISTS,EXIT,EXPLAIN,FALSE,FETCH,FLOAT,FLOAT4,FLOAT8,FOR,FORCE,FOREIGN,FROM,FULLTEXT,GOTO,GRANT,GROUP,HAVING,HIGH_PRIORITY,HOUR_MICROSECOND,HOUR_MINUTE,HOUR_SECOND,IF,IGNORE,IN,INDEX,INFILE,INNER,INOUT,INSENSITIVE,INSERT,INT,INT1,INT2,INT3,INT4,INT8,INTEGER,INTERVAL,INTO,IS,ITERATE,JOIN,KEY,KEYS,KILL,LABEL,LEADING,LEAVE,LEFT,LIKE,LIMIT,LINEAR,LINES,LOAD,LOCALTIME,LOCALTIMESTAMP,LOCK,LONG,LONGBLOB,LONGTEXT,LOOP,LOW_PRIORITY,MATCH,MEDIUMBLOB,MEDIUMINT,MEDIUMTEXT,MIDDLEINT,MINUTE_MICROSECOND,MINUTE_SECOND,MOD,MODIFIES,NATURAL,NOT,NO_WRITE_TO_BINLOG,NULL,NUMERIC,ON,OPTIMIZE,OPTION,OPTIONALLY,OR,ORDER,OUT,OUTER,OUTFILE,PRECISION,PRIMARY,PROCEDURE,PURGE,RAID0,RANGE,READ,READS,REAL,REFERENCES,REGEXP,RELEASE,RENAME,REPEAT,REPLACE,REQUIRE,RESTRICT,RETURN,REVOKE,RIGHT,RLIKE,SCHEMA,SCHEMAS,SECOND_MICROSECOND,SELECT,SENSITIVE,SEPARATOR,SET,SHOW,SMALLINT,SPATIAL,SPECIFIC,SQL,SQLEXCEPTION,SQLSTATE,SQLWARNING,SQL_BIG_RESULT,SQL_CALC_FOUND_ROWS,SQL_SMALL_RESULT,SSL,STARTING,STRAIGHT_JOIN,TABLE,TERMINATED,THEN,TINYBLOB,TINYINT,TINYTEXT,TO,TRAILING,TRIGGER,TRUE,UNDO,UNION,UNIQUE,UNLOCK,UNSIGNED,UPDATE,USAGE,USE,USING,UTC_DATE,UTC_TIME,UTC_TIMESTAMP,VALUES,VARBINARY,VARCHAR,VARCHARACTER,VARYING,WHEN,WHERE,WHILE,WITH,WRITE,X509,XOR,YEAR_MONTH,ZEROFILL".split("[,;]");

    @Override
    public String queryTableRemark(MetaDataTable table) throws SQLException {
        try (Statement statement = this.connection.createStatement()) {
            try (ResultSet rs = statement.executeQuery("SHOW CREATE TABLE `" + table.getName() + "`")) {
                if (rs.next()) {
                    String createDDL = rs.getString(2);
                    String comment = null;
                    int index = createDDL.indexOf("COMMENT='");
                    if (index > 0) {
                        comment = createDDL.substring(index + 9);
                        comment = comment.substring(0, comment.length() - 1);
                    }
                    return comment;
                }
            }
        }
        return null;
    }

    @Override
    public <T extends MetaDataColumn> T columnFromResultSet(ResultSet resultSet, T column) throws SQLException {
        column = super.columnFromResultSet(resultSet, column);

        Object is_autoincrement = resultSet.getObject("IS_AUTOINCREMENT");
        column.setAutoIncrement(Boolean.valueOf(true).equals(is_autoincrement) || "YES".equalsIgnoreCase(is_autoincrement + "") || Integer.valueOf("1").equals(is_autoincrement));

        return column;
    }

    // @Override
    // protected TableColumn columnFromResultSet(ResultSet resultSet) throws SQLException {
    //     TableColumn column = super.columnFromResultSet(resultSet);

    //     Object is_autoincrement = resultSet.getObject("IS_AUTOINCREMENT");
    //     column.setAutoIncrement(Boolean.valueOf(true).equals(is_autoincrement) || "YES".equalsIgnoreCase(is_autoincrement + "") || Integer.valueOf("1").equals(is_autoincrement));

    //     return column;
    // }
}

