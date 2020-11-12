package com.code.smither.project.base.constant;

import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

/**
 * C#语言规则实现
 * Created by root on 16-1-28.
 */
public class CSharpLang extends AbstractProgramLang {

    private static final String[] extensions = {
            ".cs"
    };

    private static final String[] keywords = {
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
    public String getType(TableColumn column) {
        switch (column.getTypeInt()) {
            case Types.DISTINCT:
            case Types.REF:
            case Types.NULL:
            case Types.STRUCT:
                break;
            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                return "byte[]";
            case Types.DATE:
                return "DateTime";
            case Types.ARRAY:
                return Array.class.getSimpleName();
            case Types.BIGINT:
                return Long.class.getSimpleName();
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
            case Types.DECIMAL:
                return BigDecimal.class.getSimpleName();
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
            case Types.NCHAR:
                return String.class.getSimpleName();
            case Types.NCLOB:
                return NClob.class.getSimpleName();
            case Types.NUMERIC:
                return BigDecimal.class.getSimpleName();
            case Types.NVARCHAR:
                return String.class.getSimpleName();
            case Types.OTHER:
                return Object.class.getSimpleName();
            case Types.REAL:
                return Float.class.getSimpleName();
            case Types.ROWID:
                return RowId.class.getSimpleName();
            case Types.SMALLINT:
                return Short.class.getSimpleName();
            case Types.SQLXML:
                return SQLXML.class.getSimpleName();
            case Types.TIME:
                return Time.class.getSimpleName();
            case Types.TIMESTAMP:
                return java.util.Date.class.getSimpleName();
            case Types.TINYINT:
                return Byte.class.getSimpleName();
            case Types.VARCHAR:
                return String.class.getSimpleName();
            default:
                break;
        }
        return "";
    }

    protected static Map<String,String> baseTypeMap = new HashMap<String,String>() {
        {
            put("Boolean","bool");
            put("Byte","byte");
            put("Short","short");
            put("Integer","int");
            put("Long","long");
            put("Float","float");
            put("Double","double");
            put("String","string");
        }
    } ;

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
        return StringUtil.upperFirst(columnName);
    }

}
