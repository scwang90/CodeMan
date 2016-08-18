package com.codesmither.project.database.impl;


import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.Converter;
import com.codesmither.project.base.model.TableColumn;
import com.codesmither.project.base.util.StringUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * SqlServer 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class SqlServerTableSource extends DbTableSource {

    public SqlServerTableSource(ProjectConfig config, Connection connection) {
        this(config, connection, false);
    }

    public SqlServerTableSource(ProjectConfig config, Connection connection, boolean autoclose) {
        super(config, connection, autoclose);
    }

    protected List<TableColumn> buildColumns(String tableName) throws SQLException {
        ResultSet resultSet = databaseMetaData.getColumns(null, "%", tableName, "%");
        List<TableColumn> columns = new ArrayList<>();
        while (resultSet.next()) {
            TableColumn column = new TableColumn();
            column.setName(resultSet.getString("COLUMN_NAME"));
            column.setType(resultSet.getString("TYPE_NAME"));
            column.setTypeInt(resultSet.getInt("DATA_TYPE"));
            column.setLenght(resultSet.getInt("COLUMN_SIZE"));
            column.setDefvalue(resultSet.getString("COLUMN_DEF"));
            column.setNullable(resultSet.getBoolean("NULLABLE"));
            column.setRemark(resultSet.getString("REMARKS"));
            column.setAutoIncrement(!"NO".equals(resultSet.getString("IS_AUTOINCREMENT")));

            column.setFieldName(this.converter.converterFieldName(column.getName()));
            column.setFieldType(this.converter.converterFieldType(column.getTypeInt()));
            column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
            column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

            if (column.getRemark() == null || column.getRemark().trim().length()==0) {
                column.setRemark(remarker.getColumnRemark(column.getName()));
            }
            columns.add(column);
        }
        return columns;
    }
}
