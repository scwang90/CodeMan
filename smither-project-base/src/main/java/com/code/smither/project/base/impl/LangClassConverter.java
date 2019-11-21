package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.ClassConverter;
import com.code.smither.project.base.constant.AbstractProgramLang;

/**
 * 类转换器
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public abstract class LangClassConverter implements ClassConverter {

	protected AbstractProgramLang lang;

	public LangClassConverter(AbstractProgramLang lang) {
		this.lang = lang;
	}

	public String converterClassName(String tableName) {
		String classname = lang.converterClassName(tableName);
		if (lang.isKeyword(classname)) {
			classname = classname + "Ex";
		}
		return classname;
	}

	public String converterFieldName(String columnName) {
		String fieldName = lang.converterFieldName(columnName);
		if (lang.isKeyword(fieldName)) {
			fieldName = fieldName + "Ex";
		}
		return fieldName;
	}

	public String converterFieldType(int columnType) {
		return lang.getType(columnType);
	}

}
