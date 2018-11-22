package com.code.smither.project.base.constant;

import com.code.smither.project.base.util.StringUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

/**
 * Mybatis 语言规则实现
 * Created by root on 16-1-28.
 */
public class JdbcLang extends ProgramLang {

    private static final String[] extensions = {
            ".xml"
    };

    private static final String[] keywords = new String[0];
    private Field[] mFields = null;

    @Override
    public boolean isKeyword(String value) {
        return false;
    }

    @Override
    public String[] getFileExtensions() {
        return extensions;
    }

    @Override
    public String getType(int columnType) {
        try {
            for (Field field: getFields(Types.class)) {
                if (Objects.equals(field.get(Types.class), columnType)) {
                    return field.getName();
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return "";
    }

    private Field[] getFields(Class<Types> clazz) {
        if (mFields == null) {
            List<Field> fields = new ArrayList<>();
            for (Field field: clazz.getFields()) {
                if (Modifier.isStatic(field.getModifiers()) && field.getType().equals(int.class)) {
                    fields.add(field);
                }
            }
            mFields = fields.toArray(new Field[0]);
        }
        return mFields;
    }

    @Override
    public String getBasicType(int columnType) {
        return getType(columnType);
    }

    @Override
    public String converterClassName(String tableName) {
        return StringUtil.upperFirst(tableName);
    }

    @Override
    public String converterFieldName(String columnName) {
        return StringUtil.lowerFirst(columnName);
    }
}
