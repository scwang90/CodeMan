package com.code.smither.project.base.constant;

import com.code.smither.project.base.api.ProgramLang;
import com.code.smither.project.base.model.TableColumn;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.*;

/**
 * 编程语言定义
 * Created by root on 16-1-28.
 */
public abstract class AbstractProgramLang implements ProgramLang {

    @Override
    public Class<?> getJavaType(TableColumn column) {
        switch (column.getTypeInt()) {
            case Types.ARRAY:
                return Array.class;
            case Types.BLOB:
                return Blob.class;
            case Types.CLOB:
                return Clob.class;
            case Types.NCLOB:
                return NClob.class;
            case Types.TINYINT:
                return Byte.class;
            case Types.SMALLINT:
                return Short.class;
            case Types.INTEGER:
                return Integer.class;
            case Types.BIGINT:
                return Long.class;
            case Types.FLOAT:
            case Types.REAL:
                return Float.class;
            case Types.DOUBLE:
                return Double.class;
            case Types.DECIMAL:
                return BigDecimal.class;
            case Types.BIT:
            case Types.BOOLEAN:
                return Boolean.class;
            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                return Byte[].class;
            case Types.CHAR:
            case Types.NCHAR:
            case Types.VARCHAR:
            case Types.NVARCHAR:
            case Types.LONGVARCHAR:
            case Types.LONGNVARCHAR:
                return String.class;
            case Types.ROWID:
                return RowId.class;
            case Types.SQLXML:
                return SQLXML.class;
            case Types.TIME:
                return java.sql.Time.class;
            case Types.DATE:
                return java.sql.Date.class;
            case Types.TIMESTAMP:
                if ("DATETIME".equalsIgnoreCase(column.getType())) {
                    return java.util.Date.class;
                }
                return java.sql.Timestamp.class;
            case Types.OTHER:
            case Types.JAVA_OBJECT:
                return Object.class;
            case Types.NUMERIC:
                if (column.getDecimalDigits() == 0) {
                    if (column.getLength() < 4) {
                        return Short.class;
                    } else if (column.getLength() < 8) {
                        return Integer.class;
                    } else if (column.getLength() < 16) {
                        return Long.class;
                    } else {
                        return BigInteger.class;
                    }
                } else {
                    if (column.getLength() < 8) {
                        return Float.class;
                    } else if (column.getLength() < 16) {
                        return Double.class;
                    } else {
                        return BigDecimal.class;
                    }
                }
            case Types.STRUCT:
                return Struct.class;
            case Types.REF:
                return Ref.class;
            case Types.DISTINCT:
            case Types.NULL:
            default:
                break;
        }
        return Object.class;
    }

    public String wrapperKeyword(String classname) {
        return classname + "Ex";
    }

}
