package com.codesmither.kernel;

import com.codesmither.util.StringUtil;

public class Converter {

	public String converterClassName(String tableName) {
		// TODO Auto-generated method stub
		return StringUtil.upperFirst(tableName);
	}

	public String converterFieldName(String columnName) {
		// TODO Auto-generated method stub
		return StringUtil.lowerFirst(columnName);
	}

	public String converterfieldType(int columnType) {
		// TODO Auto-generated method stub
		return JavaType.getType(columnType);
	}

}
