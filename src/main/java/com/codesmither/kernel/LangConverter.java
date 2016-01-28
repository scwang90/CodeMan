package com.codesmither.kernel;

import com.codesmither.kernel.api.Converter;
import com.codesmither.kernel.api.ProgLang;
import com.codesmither.util.StringUtil;

/**
 * 类转换器
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
public abstract class LangConverter extends Converter {

	protected ProgLang lang;

	public LangConverter(ProgLang lang) {
		this.lang = lang;
	}

	public String converterClassName(String tableName) {
		String classname = StringUtil.upperFirst(tableName);
		if (lang.isKeyword(classname)) {
			classname = classname + "Ex";
		}
		return classname;
	}

	public String converterFieldName(String columnName) {
		String fieldName = StringUtil.lowerFirst(columnName);
		if (lang.isKeyword(fieldName)) {
			fieldName = fieldName + "Ex";
		}
		return fieldName;
	}

	public String converterFieldType(int columnType) {
		return lang.getType(columnType);
	}

}
