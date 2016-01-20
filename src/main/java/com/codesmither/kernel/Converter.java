package com.codesmither.kernel;

import com.codesmither.util.StringUtil;

/**
 * 类转换器
 * 根据表名和列名转成类名和字段名
 * Created by SCWANG on 2015-07-04.
 */
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
