package com.code.smither.project.base.util;

import com.code.smither.engine.tools.Tools;
import com.code.smither.project.base.model.ForeignKey;

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

}
