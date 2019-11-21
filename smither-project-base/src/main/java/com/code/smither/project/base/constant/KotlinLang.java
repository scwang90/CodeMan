package com.code.smither.project.base.constant;

import com.code.smither.project.base.util.StringUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Kotlin语言规则实现
 * Created by root on 16-1-28.
 */
public class KotlinLang extends AbstractProgramLang {

    private static final String[] extensions = {
            ".kt"
    };

    private static final String[] keywords = {
            "abstract",
            "annotation",
            "by",
            "class",
            "companion",
            "const",
            "constructor",
            "crossinline",
            "data",
            "enum",
            "field",
            "fun",
            "import",
            "in",
            "init",
            "inline",
            "inner",
            "interface",
            "internal",
            "lateinit",
            "noinline",
            "object",
            "open",
            "operator",
            "out",
            "override",
            "package",
            "private",
            "protected",
            "public",
            "reified",
            "sealed",
            "super",
            "suspend",
            "throw",
            "typealias",
            "val",
            "var",
            "vararg "

    };

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

    @Override
    public String getType(int columnType) {
        switch (columnType) {
            case Types.ARRAY:
                return Array.class.getSimpleName();
            case Types.BLOB:
                return Blob.class.getName();
            case Types.CLOB:
                return Clob.class.getName();
            case Types.TINYINT:
                return Byte.class.getSimpleName();
            case Types.SMALLINT:
                return Short.class.getSimpleName();
            case Types.BIGINT:
                return Long.class.getSimpleName();
            case Types.FLOAT:
            case Types.REAL:
                return Float.class.getSimpleName();
            case Types.DOUBLE:
                return Double.class.getSimpleName();
            case Types.DECIMAL:
                return BigDecimal.class.getName();
            case Types.INTEGER:
                return Integer.class.getSimpleName();
            case Types.JAVA_OBJECT:
                return Object.class.getSimpleName();
            case Types.BIT:
            case Types.BOOLEAN:
                return Boolean.class.getSimpleName();
            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                return "Array<byte>";
            case Types.CHAR:
            case Types.NCHAR:
            case Types.VARCHAR:
            case Types.NVARCHAR:
            case Types.LONGVARCHAR:
            case Types.LONGNVARCHAR:
                return String.class.getSimpleName();
            case Types.NCLOB:
                return NClob.class.getName();
            case Types.NUMERIC:
                return BigDecimal.class.getName();
            case Types.OTHER:
                return Object.class.getSimpleName();
            case Types.ROWID:
                return RowId.class.getName();
            case Types.SQLXML:
                return SQLXML.class.getName();
            case Types.TIME:
                return Time.class.getName();
            case Types.DATE:
            case Types.TIMESTAMP:
                return java.util.Date.class.getName();
            case Types.STRUCT:
            case Types.REF:
            case Types.DISTINCT:
            case Types.NULL:
            default:
                break;
        }
        return "";
    }

    protected static Map<String,String> baseTypeMap = new HashMap<String,String>() {
        {
            put("Integer","Int");
            put("java.lang.Boolean","Boolean");
            put("java.lang.Byte","Byte");
            put("java.lang.Short","Short");
            put("java.lang.Integer","Int");
            put("java.lang.Long","Long");
            put("java.lang.Float","Float");
            put("java.lang.Double","Double");
        }
    } ;

    @Override
    public String getBasicType(int columnType) {
        String type = getType(columnType);
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
        return StringUtil.lowerFirst(columnName);
    }
}
