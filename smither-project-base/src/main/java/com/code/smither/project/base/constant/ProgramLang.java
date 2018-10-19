package com.code.smither.project.base.constant;

import com.code.smither.project.base.api.IProgramLang;

/**
 * 编程语言定义
 * Created by root on 16-1-28.
 */
public abstract class ProgramLang implements IProgramLang {

    public enum Lang {
        Java("java", new JavaLang()), CSharp("C#", new CSharpLang()), Kotlin("kotlin", new KotlinLang()),;

        public final String value;
        public final ProgramLang lang;

        Lang(String value, ProgramLang lang) {
            this.value = value;
            this.lang = lang;
        }
    }

    public static ProgramLang getLang(String programLang) {
        for (ProgramLang.Lang lang : ProgramLang.Lang.values()) {
            if (lang.value.equalsIgnoreCase(programLang) || lang.name().equalsIgnoreCase(programLang)) {
                return lang.lang;
            }
        }
        return ProgramLang.Lang.Java.lang;
    }

}
