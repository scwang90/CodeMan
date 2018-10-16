package com.codesmither.project.database.impl;


import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.base.constant.Database;
import com.codesmither.project.base.model.TableColumn;
import com.codesmither.project.base.util.StringUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * SqlServer 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class SqlServerTableSource extends DbTableSource implements Database {

    public SqlServerTableSource(ProjectConfig config, DbFactory dbFactory) {
        this(config, dbFactory, false);
    }

    public SqlServerTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoclose) {
        super(config, dbFactory, autoclose);
    }

    protected List<TableColumn> buildColumns(String tableName) throws SQLException {
        ResultSet resultSet = databaseMetaData.getColumns(null, "%", tableName, "%");
        List<TableColumn> columns = new ArrayList<>();
        while (resultSet.next()) {
            TableColumn column = new TableColumn();
            column.setName(resultSet.getString("COLUMN_NAME"), getDatabase());
            column.setType(resultSet.getString("TYPE_NAME"));
            column.setTypeInt(resultSet.getInt("DATA_TYPE"));
            column.setLength(resultSet.getInt("COLUMN_SIZE"));
            column.setDefValue(resultSet.getString("COLUMN_DEF"));
            column.setNullable(resultSet.getBoolean("NULLABLE"));
            column.setRemark(resultSet.getString("REMARKS"));
            column.setAutoIncrement(!"NO".equals(resultSet.getString("IS_AUTOINCREMENT")));

            column.setFieldName(this.classConverter.converterFieldName(column.getName()));
            column.setFieldType(this.classConverter.converterFieldType(column.getTypeInt()));
            column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
            column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

            if (column.getRemark() == null || column.getRemark().trim().length() == 0) {
                column.setRemark(remarker.getColumnRemark(column.getName()));
            }
            columns.add(column);
        }
        return columns;
    }

    @Override
    public String name() {
        return "sqlite";
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
        return false;
    }

    @Override
    public String wrapperKeyword(String name) {
        return '`' + name + '`';
    }

    private static final String[] keywords = "ADD,EXCEPT,PERCENT,ALL,EXEC,PLAN,ALTER,EXECUTE,PRECISION,AND,EXISTS,PRIMARY,ANY,EXIT,PRINT,AS,FETCH,PROC,ASC,FILE,PROCEDURE,AUTHORIZATION,FILLFACTOR,PUBLIC,BACKUP,FOR,RAISERROR,BEGIN,FOREIGN,READ,BETWEEN,FREETEXT,READTEXT,BREAK,FREETEXTTABLE,RECONFIGURE,BROWSE,FROM,REFERENCES,BULK,FULL,REPLICATION,BY,FUNCTION,RESTORE,CASCADE,GOTO,RESTRICT,CASE,GRANT,RETURN,CHECK,GROUP,REVOKE,CHECKPOINT,HAVING,RIGHT,CLOSE,HOLDLOCK,ROLLBACK,CLUSTERED,IDENTITY,ROWCOUNT,COALESCE,IDENTITY_INSERT,ROWGUIDCOL,COLLATE,IDENTITYCOL,RULE,COLUMN,IF,SAVE,COMMIT,IN,SCHEMA,COMPUTE,INDEX,SELECT,CONSTRAINT,INNER,SESSION_USER,CONTAINS,INSERT,SET,CONTAINSTABLE,INTERSECT,SETUSER,CONTINUE,INTO,SHUTDOWN,CONVERT,IS,SOME,CREATE,JOIN,STATISTICS,CROSS,KEY,SYSTEM_USER,CURRENT,KILL,TABLE,CURRENT_DATE,LEFT,TEXTSIZE,CURRENT_TIME,LIKE,THEN,CURRENT_TIMESTAMP,LINENO,TO,CURRENT_USER,LOAD,TOP,CURSOR,NATIONAL,TRAN,DATABASE,NOCHECK,TRANSACTION,DBCC,NONCLUSTERED,TRIGGER,DEALLOCATE,NOT,TRUNCATE,DECLARE,NULL,TSEQUAL,DEFAULT,NULLIF,UNION,DELETE,OF,UNIQUE,DENY,OFF,UPDATE,DESC,OFFSETS,UPDATETEXT,DISK,ON,USE,DISTINCT,OPEN,USER,DISTRIBUTED,OPENDATASOURCE,VALUES,DOUBLE,OPENQUERY,VARYING,DROP,OPENROWSET,VIEW,DUMMY,OPENXML,WAITFOR,DUMP,OPTION,WHEN,ELSE,OR,WHERE,END,ORDER,WHILE,ERRLVL,OUTER,WITH,ESCAPE,OVER,WRITETEXT".split(",");


}

