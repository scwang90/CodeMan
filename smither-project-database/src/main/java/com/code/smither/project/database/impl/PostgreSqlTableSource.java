package com.code.smither.project.database.impl;

import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.database.api.DbFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * MySql 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class PostgreSqlTableSource extends DefaultDataSource implements Database {

    public PostgreSqlTableSource(DbFactory dbFactory) {
        this(dbFactory, false);
    }

    public PostgreSqlTableSource(DbFactory dbFactory, boolean autoclose) {
        super(dbFactory, autoclose);
    }

    @Override
    public String name() {
        return "postgresql";
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

    /**
     * TODO: 目前使用MYSQL关键之，后面需要更换
     */
    private static final String[] keywords = "ADD,ALL,ALTER,ANALYZE,AND,AS,ASC,ASENSITIVE,BEFORE,BETWEEN,BIGINT,BINARY,BLOB,BOTH,BY,CALL,CASCADE,CASE,CHANGE,CHAR,CHARACTER,CHECK,COLLATE,COLUMN,CONDITION,CONNECTION,CONSTRAINT,CONTINUE,CONVERT,CREATE,CROSS,CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,CURSOR,DATABASE,DATABASES,DAY_HOUR,DAY_MICROSECOND,DAY_MINUTE,DAY_SECOND,DEC,DECIMAL,DECLARE,DEFAULT,DELAYED,DELETE,DESC,DESCRIBE,DETERMINISTIC,DISTINCT,DISTINCTROW,DIV,DOUBLE,DROP,DUAL,EACH,ELSE,ELSEIF,ENCLOSED,ESCAPED,EXISTS,EXIT,EXPLAIN,FALSE,FETCH,FLOAT,FLOAT4,FLOAT8,FOR,FORCE,FOREIGN,FROM,FULLTEXT,GOTO,GRANT,GROUP,HAVING,HIGH_PRIORITY,HOUR_MICROSECOND,HOUR_MINUTE,HOUR_SECOND,IF,IGNORE,IN,INDEX,INFILE,INNER,INOUT,INSENSITIVE,INSERT,INT,INT1,INT2,INT3,INT4,INT8,INTEGER,INTERVAL,INTO,IS,ITERATE,JOIN,KEY,KEYS,KILL,LABEL,LEADING,LEAVE,LEFT,LIKE,LIMIT,LINEAR,LINES,LOAD,LOCALTIME,LOCALTIMESTAMP,LOCK,LONG,LONGBLOB,LONGTEXT,LOOP,LOW_PRIORITY,MATCH,MEDIUMBLOB,MEDIUMINT,MEDIUMTEXT,MIDDLEINT,MINUTE_MICROSECOND,MINUTE_SECOND,MOD,MODIFIES,NATURAL,NOT,NO_WRITE_TO_BINLOG,NULL,NUMERIC,ON,OPTIMIZE,OPTION,OPTIONALLY,OR,ORDER,OUT,OUTER,OUTFILE,PRECISION,PRIMARY,PROCEDURE,PURGE,RAID0,RANGE,READ,READS,REAL,REFERENCES,REGEXP,RELEASE,RENAME,REPEAT,REPLACE,REQUIRE,RESTRICT,RETURN,REVOKE,RIGHT,RLIKE,SCHEMA,SCHEMAS,SECOND_MICROSECOND,SELECT,SENSITIVE,SEPARATOR,SET,SHOW,SMALLINT,SPATIAL,SPECIFIC,SQL,SQLEXCEPTION,SQLSTATE,SQLWARNING,SQL_BIG_RESULT,SQL_CALC_FOUND_ROWS,SQL_SMALL_RESULT,SSL,STARTING,STRAIGHT_JOIN,TABLE,TERMINATED,THEN,TINYBLOB,TINYINT,TINYTEXT,TO,TRAILING,TRIGGER,TRUE,UNDO,UNION,UNIQUE,UNLOCK,UNSIGNED,UPDATE,USAGE,USE,USING,UTC_DATE,UTC_TIME,UTC_TIMESTAMP,VALUES,VARBINARY,VARCHAR,VARCHARACTER,VARYING,WHEN,WHERE,WHILE,WITH,WRITE,X509,XOR,YEAR_MONTH,ZEROFILL".split("[,;]");

    @Override
    public <T extends MetaDataColumn> T columnFromResultSet(ResultSet result, T column) throws SQLException {
        column = super.columnFromResultSet(result, column);
        if ("numeric".equals(result.getString("TYPE_NAME")) && result.getInt("DECIMAL_DIGITS") == 0) {
            // 不知道为什么 PostgreSQL 的 numeric 获取的 DecimalDigits 总是 0，导致 本应该是 float 的变成了 int
            // 暂时还不知道怎么去获取 证券的 DecimalDigits，现在的方案是发现是 numeric 类型直接设置设置小数位数为 6
            // 防止 出现 浮点型变整形的问题
            column.setDecimalDigits(6);
        }
        return column;
    }

}

