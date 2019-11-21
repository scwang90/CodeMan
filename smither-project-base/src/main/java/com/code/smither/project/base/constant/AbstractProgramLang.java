package com.code.smither.project.base.constant;

import com.code.smither.project.base.api.ProgramLang;

/**
 * 编程语言定义
 * Created by root on 16-1-28.
 */
public abstract class AbstractProgramLang implements ProgramLang {

    public static AbstractProgramLang getLang(String programLang) {
        for (Lang lang : Lang.values()) {
            if (lang.value.equalsIgnoreCase(programLang) || lang.name().equalsIgnoreCase(programLang)) {
                return lang.lang;
            }
        }
        return Lang.Java.lang;
    }

}
