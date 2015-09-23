package com.codesmither.kernel;

import com.codesmither.util.StringUtil;

public class Converter {

	public String converterClassName(String tableName) {
		String classname = StringUtil.upperFirst(tableName);
		if (JavaKeyword.isJavaKeyword(classname)) {
			classname = classname + "Ex";
		}
		return classname;
	}

	public String converterFieldName(String columnName) {
		String fieldName = StringUtil.lowerFirst(columnName);
		if (JavaKeyword.isJavaKeyword(fieldName)) {
			fieldName = fieldName + "Ex";
		}
		return fieldName;
	}

	public String converterfieldType(int columnType) {
		return JavaType.getType(columnType);
	}

}
