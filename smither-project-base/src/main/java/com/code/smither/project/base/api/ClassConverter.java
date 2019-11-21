package com.code.smither.project.base.api;

/**
 * 类转换器
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2016/8/18.
 */
public interface ClassConverter {

    /**
     * 根据表名转换成类名
     * @param tableName 表名
     * @return 类名
     */
    String converterClassName(String tableName);

    /**
     * 根据列名转换成类名
     * @param columnName 列名
     * @return 字段名
     */
    String converterFieldName(String columnName);

    /**
     * 数据类型转成编程语言数据类型
     * @param columnType 数据库数据类型
     * @return 编程语言数据类型
     */
    String converterFieldType(int columnType);
}
