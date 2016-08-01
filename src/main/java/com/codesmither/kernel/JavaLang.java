package com.codesmither.kernel;

import com.codesmither.kernel.api.ProgLang;
import com.codesmither.util.StringUtil;

import java.math.BigDecimal;
import java.sql.*;

/**
 * Java语言规则实现
 * Created by root on 16-1-28.
 */
public class JavaLang extends ProgLang{

    public static final String[] javakeywords = { "abstract", "assert",
            "boolean", "break", "byte", "case", "catch", "char", "class",
            "const", "continue", "default", "do", "double", "else", "enum",
            "extends", "final", "finally", "float", "for", "goto", "if",
            "implements", "import", "instanceof", "int", "interface", "long",
            "native", "new", "package", "private", "protected", "public",
            "return", "strictfp", "short", "static", "super", "switch",
            "synchronized", "this", "throw", "throws", "transient", "try",
            "void", "volatile", "while", };

    @Override
    public boolean isKeyword(String value) {
        for (String keyword : javakeywords) {
            if (keyword.equals(value)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String getType(int columnType) {
        switch (columnType) {
            case java.sql.Types.ARRAY:
                return Array.class.getSimpleName();
            case java.sql.Types.BIGINT:
                return Long.class.getSimpleName();
            case java.sql.Types.BINARY:
                return "byte[]";
            case java.sql.Types.BIT:
                return Boolean.class.getSimpleName();
            case java.sql.Types.BLOB:
                return Blob.class.getName();
            case java.sql.Types.BOOLEAN:
                return Boolean.class.getSimpleName();
            case java.sql.Types.CHAR:
                return String.class.getSimpleName();
            case java.sql.Types.CLOB:
                return Clob.class.getName();
            case java.sql.Types.DATE:
                return java.util.Date.class.getName();
            case java.sql.Types.DECIMAL:
                return BigDecimal.class.getName();
            case java.sql.Types.DISTINCT:
                break;
            case java.sql.Types.DOUBLE:
                return Double.class.getSimpleName();
            case java.sql.Types.FLOAT:
                return Float.class.getSimpleName();
            case java.sql.Types.INTEGER:
                return Integer.class.getSimpleName();
            case java.sql.Types.JAVA_OBJECT:
                return Object.class.getSimpleName();
            case java.sql.Types.LONGVARCHAR:
                return String.class.getSimpleName();
            case java.sql.Types.LONGNVARCHAR:
                return String.class.getSimpleName();
            case java.sql.Types.LONGVARBINARY:
                return "byte[]";
            case java.sql.Types.NCHAR:
                return String.class.getName();
            case java.sql.Types.NCLOB:
                return NClob.class.getName();
            case java.sql.Types.NULL:
                break;
            case java.sql.Types.NUMERIC:
                return BigDecimal.class.getName();
            case java.sql.Types.NVARCHAR:
                return String.class.getSimpleName();
            case java.sql.Types.OTHER:
                return Object.class.getSimpleName();
            case java.sql.Types.REAL:
                return Double.class.getSimpleName();
            case java.sql.Types.REF:
                break;
            case java.sql.Types.ROWID:
                return RowId.class.getName();
            case java.sql.Types.SMALLINT:
                return Short.class.getSimpleName();
            case java.sql.Types.SQLXML:
                return SQLXML.class.getName();
            case java.sql.Types.STRUCT:
                break;
            case java.sql.Types.TIME:
                return Time.class.getName();
            case java.sql.Types.TIMESTAMP:
                return java.util.Date.class.getName();
            case java.sql.Types.TINYINT:
                return Byte.class.getSimpleName();
            case java.sql.Types.VARBINARY:
                return "byte[]";
            case java.sql.Types.VARCHAR:
                return String.class.getSimpleName();
            default:
                break;
        }
        return "";
    }

    @Override
    public String getBasicType(int columnType) {
        String type = getType(columnType);

        if (type.equals("Boolean") || type.equals("java.lang.Boolean"))
            type = "boolean";
        else if (type.equals("Byte") || type.equals("java.lang.Byte"))
            type = "byte";
        else if (type.equals("Short") || type.equals("java.lang.Short"))
            type = "short";
        else if (type.equals("Integer") || type.equals("java.lang.Integer"))
            type = "int";
        else if (type.equals("Long") || type.equals("java.lang.Long"))
            type = "long";
        else if (type.equals("Float") || type.equals("java.lang.Float"))
            type = "float";
        else if (type.equals("Double") || type.equals("java.lang.Double"))
            type = "double";

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
