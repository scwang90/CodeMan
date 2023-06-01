package com.code.smither.project.base.util;

import com.code.smither.engine.tools.Tools;
import com.code.smither.project.base.model.ForeignKey;

import java.io.File;

public class BaseTools extends Tools {

    /**
     * 构建一对多的字段转换
     */
    public String makeOneManyFiled(ForeignKey key) {
        String table = key.getFkTable().getClassName();
        String fieldName = key.getFkColumn().getFieldName();
        String migc = fieldName.replaceAll("(?i)"+table+"|Id$", "");
        if (migc.isEmpty()) {
            return super.toPlural(key.getFkTable().getClassNameCamel());
        }
        return super.toPlural(migc + table);
    }

    public boolean isNotEmpty(String... strings) {
        return StringUtil.isNotNullAndEmpty(strings);
    }

    public boolean isNotBlank(String... strings) {
        return StringUtil.isNotNullAndBlank(strings);
    }

    public boolean isEmpty(String... strings) {
        return StringUtil.isNullOrEmpty(strings);
    }

    public boolean isBlank(String... strings) {
        return StringUtil.isNullOrBlank(strings);
    }

    public String prefixIfNotEmpty(String string, String prefix) {
        if (isEmpty(string)) {
            return "";
        }
        return prefix + string;
    }
    public String prefixIfNotBlank(String string, String prefix) {
        if (isBlank(string)) {
            return "";
        }
        return prefix + string;
    }

    public String pathPrefixIfNotEmpty(String string) {
        return prefixIfNotEmpty(string, String.valueOf(File.separatorChar));
    }
    public String pathPrefixIfNotBlank(String string) {
        return prefixIfNotBlank(string, String.valueOf(File.separatorChar));
    }
}
