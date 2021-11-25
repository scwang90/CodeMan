package com.code.smither.project.base.constant;

import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

/**
 * Java语言规则实现
 * Created by root on 16-1-28.
 */
public class JavaLang extends AbstractProgramLang {

    private static final String[] extensions = {
            ".java"
    };

    private static final String[] keywords = {"abstract", "assert",
            "boolean", "break", "byte", "case", "catch", "char", "class",
            "const", "continue", "default", "do", "double", "else", "enum",
            "extends", "final", "finally", "float", "for", "goto", "if",
            "implements", "import", "instanceof", "int", "interface", "long",
            "native", "new", "package", "private", "protected", "public",
            "return", "strictfp", "short", "static", "super", "switch",
            "synchronized", "this", "throw", "throws", "transient", "try",
            "void", "volatile", "while",};

    @Override
    public boolean isKeyword(String value) {
        for (String keyword : keywords) {
            if (keyword.equals(value)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String[] getFileExtensions() {
        return extensions;
    }

    protected static Map<String,String> baseTypeMap = new HashMap<String,String>() {
        {
            put("Boolean","boolean");
            put("Byte","byte");
            put("Short","short");
            put("Integer","int");
            put("Long","long");
            put("Float","float");
            put("Double","double");
            put("java.lang.Boolean","boolean");
            put("java.lang.Byte","byte");
            put("java.lang.Short","short");
            put("java.lang.Integer","int");
            put("java.lang.Long","long");
            put("java.lang.Float","float");
            put("java.lang.Double","double");
            put("Byte[]","byte[]");
        }
    } ;

    @Override
    public String getType(TableColumn column) {
        Class<?> clazz = super.getJavaType(column);
//        if (java.sql.Timestamp.class.equals(clazz)) {
//            clazz = java.util.Date.class;
//        } if (java.sql.Time.class.equals(clazz)) {
//            clazz = java.util.Date.class;
//        } if (java.sql.Date.class.equals(clazz)) {
//            clazz = java.util.Date.class;
//        }
        if (java.sql.Clob.class.equals(clazz)) {
            clazz = java.lang.String.class;
        } if (java.sql.Blob.class.equals(clazz)) {
            clazz = java.lang.Object.class;
        } if (java.sql.RowId.class.equals(clazz)) {
            clazz = java.lang.String.class;
        } if (java.sql.SQLXML.class.equals(clazz)) {
            clazz = java.lang.String.class;
        } if (Byte.class.equals(clazz)) {
            clazz = java.lang.Integer.class;
        } if (Short.class.equals(clazz)) {
            clazz = java.lang.Integer.class;
        } if (BigInteger.class.equals(clazz)) {
            clazz = java.lang.Long.class;
        } if (BigDecimal.class.equals(clazz)) {
            clazz = java.lang.Double.class;
        }
        if (clazz.isArray()) {
            return clazz.getComponentType().getName().replaceAll("java.lang.","")+"[]";
        }
        return clazz.getName().replaceAll("java.lang.","");
    }

    @Override
    public String getBasicType(TableColumn column) {
        String type = getType(column);
        String base = baseTypeMap.get(type);
        if (base != null) {
            return base;
        }
        return type;
    }

    @Override
    public String converterClassName(String tableName) {
        return StringUtil.upperFirst(tableName);
    }

    @Override
    public String converterFieldName(String columnName) {
        if (columnName.matches("^[A-Z]+$")) {
            return columnName.toLowerCase();
        }
        return StringUtil.lowerFirst(columnName);
    }
}
