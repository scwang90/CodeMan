package com.codesmither.kernel;

import com.codesmither.kernel.api.Config;
import com.codesmither.kernel.api.ProgLang;
import com.codesmither.util.StringUtil;

/**
 * 类转换器（可配置）
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigConverter extends LangConverter {

    private final Config config;

    public ConfigConverter(Config config) {
        super(ProgLang.getLang(config.getTemplateLang()));
        this.config = config;
    }

    private String camel(String orgin, String division) {
        if (division != null && division.length() > 0) {
            String[] divs = orgin.split(division);
            orgin = "";
            for (String div : divs) {
                orgin += StringUtil.upperFirst(div);
            }
        }
        return orgin;
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
            tableName = camel(tableName, config.getTableDivision());
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
            columnName = camel(columnName, config.getColumnDivision());
        }
        return super.converterFieldName(columnName);
    }

    @Override
    public String converterFieldType(int columnType) {
        return lang.getBasicType(columnType);
    }
}
