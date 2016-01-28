package com.codesmither.kernel.api;

import com.codesmither.kernel.CSharpLang;
import com.codesmither.kernel.JavaLang;

/**
 * 编程语言定义
 * Created by root on 16-1-28.
 */
public abstract class ProgLang {

    public enum Lang{
        Java("java",new JavaLang()),CSharp("C#",new CSharpLang());

        public final String value;
        public final ProgLang lang;

        Lang(String value,ProgLang lang) {
            this.value = value;
            this.lang = lang;
        }
    }

    /**
     * 判断value在当前编程语言中是否是关键字
     * @param value 判断值
     * @return true 是
     */
    public abstract boolean isKeyword(String value);

    /**
     * 把 JDBC 数据库类型转成当前语言的数据类型
     * @param columnType 数据库类型
     * @return 类型全类名
     */
    public abstract String getType(int columnType);

    /**
     * 把 JDBC 数据库类型转成当前语言的数据类型
     * 尽量转成基本类型 如转成int 而不是 Intger
     * @param columnType 数据库类型
     * @return 基本类型 或者 类型全类名
     */
    public abstract String getBasicType(int columnType);

}
