package com.code.smither.project.base.api;

import java.util.List;

/**
 * 程序设计语言 接口
 */
public interface IProgramLang {

    /**
     * 判断value在当前编程语言中是否是关键字
     * @param value 判断值
     * @return true 是
     */
    boolean isKeyword(String value);

    /**
     * 获取文件扩展名
     */
    String[] getFileExtensions();

    /**
     * 把 JDBC 数据库类型转成当前语言的数据类型
     * @param columnType 数据库类型
     * @return 类型全类名
     */
    String getType(int columnType);

    /**
     * 把 JDBC 数据库类型转成当前语言的数据类型
     * 尽量转成基本类型 如转成 int 而不是 Integer
     * @param columnType 数据库类型
     * @return 基本类型 或者 类型全类名
     */
    String getBasicType(int columnType);

    /**
     * 把数据库表名转成类名
     * @param tableName 数据库表明
     * @return 相关编程语言命名规则的 类名
     */
    String converterClassName(String tableName);

    /**
     * 把数据库表名转成列名
     * @param columnName 数据库表明
     * @return 相关编程语言命名规则的 列名
     */
    String converterFieldName(String columnName);

}
