package com.codesmither.kernel;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.util.StringUtil;

/**
 * 类转换器（可配置）
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigConverter extends Converter {

    public String tablePrefix = ConfigFactory.getTablePrefix();
    public String tableSuffix = ConfigFactory.getTableSuffix();
    public String tableDivision = ConfigFactory.getTableDivision();

    public String columnPrefix = ConfigFactory.getColumnPrefix();
    public String columnSuffix = ConfigFactory.getColumnSuffix();
    public String columnDivision = ConfigFactory.getColumnDivision();

    private String camel(String orgin, String division) {
        String[] divs = orgin.split(division);
        orgin = "";
        for (String div : divs) {
            orgin += StringUtil.upperFirst(div);
        }
        return orgin;
    }

    public String converterClassName(String tableName) {
        if (tablePrefix != null) {
            if (tableName.startsWith(tablePrefix)) {
                tableName = tableName.substring(tablePrefix.length());
            }
        }
        if (tableSuffix != null) {
            if (tableName.endsWith(tableSuffix)) {
                tableName = tableName.substring(0, tableName.length() - tableSuffix.length() - 1);
            }
        }
        if (tableDivision != null) {
            tableName = camel(tableName, tableDivision);
        }
        return super.converterClassName(tableName);
    }

    public String converterFieldName(String columnName) {
        if (columnPrefix != null) {
            if (columnName.startsWith(columnPrefix)) {
                columnName = columnName.substring(columnPrefix.length());
            }
        }
        if (columnSuffix != null) {
            if (columnName.endsWith(columnSuffix)) {
                columnName = columnName.substring(0, columnName.length() - columnSuffix.length() - 1);
            }
        }
        if (columnDivision != null) {
            columnName = camel(columnName, columnDivision);
        }
        return super.converterFieldName(columnName);
    }

}
