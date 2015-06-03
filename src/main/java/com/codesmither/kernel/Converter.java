package com.codesmither.kernel;

import com.codesmither.util.StringUtil;

public class Converter {

	public String converterClassName(String tableName) {
		// TODO Auto-generated method stub
		String classname = StringUtil.upperFirst(tableName);
		if (JavaKeyword.isJavaKeyword(classname)) {
			classname = classname + "Ex";
		}
		return classname;
	}

	public String converterFieldName(String columnName) {
		// TODO Auto-generated method stub
		String fieldName = StringUtil.lowerFirst(columnName);
		if (JavaKeyword.isJavaKeyword(fieldName)) {
			fieldName = fieldName + "Ex";
		}
		return fieldName;
	}

	public String converterfieldType(int columnType) {
		// TODO Auto-generated method stub
		return JavaType.getType(columnType);
	}

}
