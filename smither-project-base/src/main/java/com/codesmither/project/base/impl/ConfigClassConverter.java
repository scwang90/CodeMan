package com.codesmither.project.base.impl;


import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.constant.ProgLang;
import com.codesmither.project.base.util.StringUtil;

/**
 * 类转换器（可配置）
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigClassConverter extends LangClassConverter {

    private final ProjectConfig config;

    public ConfigClassConverter(ProjectConfig config) {
        super(ProgLang.getLang(config.getTemplateLang()));
        this.config = config;
    }

    public String converterClassName(String tableName) {
        if (config.getTablePrefix() != null) {
            if (tableName.startsWith(config.getTablePrefix())) {
                tableName = tableName.substring(config.getTablePrefix().length());
            }
        }
        if (config.getTableSuffix() != null) {
            if (tableName.endsWith(config.getTableSuffix())) {
                tableName = tableName.substring(0, tableName.length() - config.getTableSuffix().length() - 1);
            }
        }
        if (config.getTableDivision() != null) {
            tableName = StringUtil.camel(tableName, config.getTableDivision());
        }
        return super.converterClassName(tableName);
    }

    public String converterFieldName(String columnName) {
        if (config.getColumnPrefix() != null) {
            if (columnName.startsWith(config.getColumnPrefix())) {
                columnName = columnName.substring(config.getColumnPrefix().length());
            }
        }
        if (config.getColumnSuffix() != null) {
            if (columnName.endsWith(config.getColumnSuffix())) {
                columnName = columnName.substring(0, columnName.length() - config.getColumnSuffix().length() - 1);
            }
        }
        if (config.getColumnDivision() != null) {
            columnName = StringUtil.camel(columnName, config.getColumnDivision());
        }
        return super.converterFieldName(columnName);
    }

    @Override
    public String converterFieldType(int columnType) {
        return lang.getBasicType(columnType);
    }
}
