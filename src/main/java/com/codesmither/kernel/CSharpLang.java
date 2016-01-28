package com.codesmither.kernel;

import com.codesmither.kernel.api.ProgLang;

import java.math.BigDecimal;
import java.sql.*;

/**
 * C#语言规则实现
 * Created by root on 16-1-28.
 */
public class CSharpLang extends ProgLang {

    public static final String[] javakeywords = {
            "event",
            "abstract",
            "new",
            "struct",
            "as",
            "explicit",
            "null",
            "switch",
            "base",
            "extern",
            "object",
            "this",
            "bool",
            "false",
            "operator",
            "throw",
            "break",
            "finally",
            "out",
            "true",
            "byte",
            "fixed",
            "override",
            "try",
            "case",
            "float",
            "params",
            "typeof",
            "catch",
            "for",
            "private",
            "uint",
            "char",
            "foreach",
            "protected",
            "ulong",
            "checked",
            "goto",
            "public",
            "unchecked",
            "class",
            "if",
            "readonly",
            "unsafe",
            "const",
            "implicit",
            "ref",
            "ushort",
            "continue",
            "in",
            "return",
            "using",
            "decimal",
            "int",
            "sbyte",
            "virtual",
            "default",
            "interface",
            "sealed",
            "volatile",
            "delegate",
            "internal",
            "short",
            "void",
            "do",
            "is",
            "sizeof",
            "while",
            "double",
            "lock",
            "stackalloc",
            "else",
            "long",
            "static",
            "enum",
            "namespace",
            "string",
    };

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
            case Types.ARRAY:
                return Array.class.getSimpleName();
            case Types.BIGINT:
                return Long.class.getSimpleName();
            case Types.BINARY:
                return "byte[]";
            case Types.BIT:
                return Boolean.class.getSimpleName();
            case Types.BLOB:
                return Blob.class.getSimpleName();
            case Types.BOOLEAN:
                return Boolean.class.getSimpleName();
            case Types.CHAR:
                return String.class.getSimpleName();
            case Types.CLOB:
                return Clob.class.getSimpleName();
            case Types.DATE:
                return java.util.Date.class.getSimpleName();
            case Types.DECIMAL:
                return BigDecimal.class.getSimpleName();
            case Types.DISTINCT:
                break;
            case Types.DOUBLE:
                return Double.class.getSimpleName();
            case Types.FLOAT:
                return Float.class.getSimpleName();
            case Types.INTEGER:
                return Integer.class.getSimpleName();
            case Types.JAVA_OBJECT:
                return Object.class.getSimpleName();
            case Types.LONGVARCHAR:
                return String.class.getSimpleName();
            case Types.LONGNVARCHAR:
                return String.class.getSimpleName();
            case Types.LONGVARBINARY:
                return "byte[]";
            case Types.NCHAR:
                return String.class.getSimpleName();
            case Types.NCLOB:
                return NClob.class.getSimpleName();
            case Types.NULL:
                break;
            case Types.NUMERIC:
                return BigDecimal.class.getSimpleName();
            case Types.NVARCHAR:
                return String.class.getSimpleName();
            case Types.OTHER:
                return Object.class.getSimpleName();
            case Types.REAL:
                return Double.class.getSimpleName();
            case Types.REF:
                break;
            case Types.ROWID:
                return RowId.class.getSimpleName();
            case Types.SMALLINT:
                return Short.class.getSimpleName();
            case Types.SQLXML:
                return SQLXML.class.getSimpleName();
            case Types.STRUCT:
                break;
            case Types.TIME:
                return Time.class.getSimpleName();
            case Types.TIMESTAMP:
                return java.util.Date.class.getSimpleName();
            case Types.TINYINT:
                return Byte.class.getSimpleName();
            case Types.VARBINARY:
                return "byte[]";
            case Types.VARCHAR:
                return String.class.getSimpleName();
            default:
                break;
        }
        return "";
    }

    @Override
    public String getBasicType(int columnType) {
        String type = getType(columnType);

        if (type.contains("Boolean"))
            type = "boolean";
        else if (type.contains("Byte"))
            type = "byte";
        else if (type.contains("Short"))
            type = "short";
        else if (type.contains("Integer"))
            type = "int";
        else if (type.contains("Long"))
            type = "long";
        else if (type.contains("Float"))
            type = "float";
        else if (type.contains("Double"))
            type = "double";

        return type;
    }
}
