package com.code.smither.project.base.api;

import com.code.smither.project.base.constant.AbstractProgramLang;
import com.code.smither.project.base.constant.CSharpLang;
import com.code.smither.project.base.constant.JavaLang;
import com.code.smither.project.base.constant.KotlinLang;
import com.code.smither.project.base.model.TableColumn;

/**
 * 程序设计语言 接口
 */
public interface ProgramLang {

    enum Lang {
        Java("java", new JavaLang()), CSharp("C#", new CSharpLang()), Kotlin("kotlin", new KotlinLang()),;

        public final String value;
        public final AbstractProgramLang lang;

        Lang(String value, AbstractProgramLang lang) {
            this.value = value;
            this.lang = lang;
        }
    }

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
     * @param column 数据库列
     * @return 类型全类名
     */
    String getType(TableColumn column);

    /**
     * 把 JDBC 数据库类型转成当前语言的数据类型
     * 尽量转成基本类型 如转成 int 而不是 Integer
     * @param column 数据库列
     * @return 基本类型 或者 类型全类名
     */
    String getBasicType(TableColumn column);

    /**
     * 把 JDBC 数据库类型转成 Java 类对象
     * @param column 数据库列
     * @return Java 类对象
     */
    Class<?> getJavaType(TableColumn column);

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
