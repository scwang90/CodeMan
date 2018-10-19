package com.code.smither.kernel;

import com.code.smither.kernel.api.Converter;
import com.code.smither.kernel.api.ProgramLang;

/**
 * 类转换器
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public abstract class LangConverter extends Converter {

	protected ProgramLang lang;

	public LangConverter(ProgramLang lang) {
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
