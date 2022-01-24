package com.code.smither.project.base.impl;


import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.ProgramLang;
import com.code.smither.project.base.constant.AbstractProgramLang;
import com.code.smither.project.base.util.StringUtil;

/**
 * 类转换器（可配置）
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigClassConverter extends LangClassConverter {

    private final ProjectConfig config;

    public ConfigClassConverter(ProjectConfig config) {
        super(ProgramLang.Lang.getLang(config.getTemplateLang()));
        this.config = config;
    }

    public ConfigClassConverter(ProjectConfig config, AbstractProgramLang lang) {
        super(lang);
        this.config = config;
    }

    @Override
    public String converterClassName(String tableName) {
        if (config.getTablePrefix() != null) {
            if (tableName.startsWith(config.getTablePrefix())) {
                tableName = tableName.substring(config.getTablePrefix().length());
            }
        }
        if (config.getTableSuffix() != null) {
            if (tableName.endsWith(config.getTableSuffix())) {
                tableName = tableName.substring(0, tableName.length() - config.getTableSuffix().length());
            }
        }
        if (config.getTableDivision() != null) {
            tableName = StringUtil.camel(tableName, config.getTableDivision());
        }
        return super.converterClassName(tableName);
    }

    @Override
    public String converterFieldName(String columnName) {
        if (config.getColumnPrefix() != null) {
            if (columnName.startsWith(config.getColumnPrefix())) {
                columnName = columnName.substring(config.getColumnPrefix().length());
            }
        }
        if (config.getColumnSuffix() != null) {
            if (columnName.endsWith(config.getColumnSuffix())) {
                columnName = columnName.substring(0, columnName.length() - config.getColumnSuffix().length());
            }
        }
        if (config.getColumnDivision() != null) {
            columnName = StringUtil.camel(columnName, config.getColumnDivision());
        }
        return super.converterFieldName(columnName);
    }

}
