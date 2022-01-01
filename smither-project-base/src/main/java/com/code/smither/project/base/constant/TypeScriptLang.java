package com.code.smither.project.base.constant;

import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

/**
 * Kotlin语言规则实现
 * Created by root on 16-1-28.
 */
public class TypeScriptLang extends JavaLang {

    private static final String[] extensions = {
            ".ts"
    };

    private static final String[] keywords = {
            "interface",
            "class",
            "let",
            "break",
            "as",
            "any",
            "switch",
            "case",
            "if",
            "throw",
            "else",
            "var",
            "number",
            "string",
            "get",
            "module",
            "type",
            "instanceof",
            "typeof",
            "public",
            "private",
            "enum",
            "export",
            "finally",
            "for",
            "while",
            "void",
            "null",
            "super",
            "this",
            "new",
            "in",
            "extends",
            "static",
            "package",
            "implements",
            "interface",
            "continue",
            "yield",
            "const",
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
            case Types.BLOB:
            case Types.CLOB:
            case Types.JAVA_OBJECT:
            case Types.NCLOB:
            case Types.OTHER:
            case Types.ROWID:
            case Types.SQLXML:
            case Types.STRUCT:
            case Types.REF:
            case Types.DISTINCT:
                return "any";
            case Types.ARRAY:
            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                return "Array<any>";
            case Types.TINYINT:
            case Types.SMALLINT:
            case Types.BIGINT:
            case Types.FLOAT:
            case Types.REAL:
            case Types.DOUBLE:
            case Types.DECIMAL:
            case Types.INTEGER:
            case Types.NUMERIC:
                return "number";
            case Types.BIT:
            case Types.BOOLEAN:
                return "boolean";
            case Types.CHAR:
            case Types.NCHAR:
            case Types.VARCHAR:
            case Types.NVARCHAR:
            case Types.LONGVARCHAR:
            case Types.LONGNVARCHAR:
            case Types.TIME:
            case Types.DATE:
            case Types.TIMESTAMP:
                return "string";
            case Types.NULL:
                return "null";
        }
        return "any";
    }

    @Override
    public String getBasicType(TableColumn column) {
        return getType(column);
    }

}
