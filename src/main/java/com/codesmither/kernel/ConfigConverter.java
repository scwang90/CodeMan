package com.codesmither.kernel;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.util.StringUtil;

public class ConfigConverter extends Converter{

	public String tablePrefix = ConfigFactory.getTablePrefix();
	public String tableSuffix = ConfigFactory.getTableSuffix();
	public String tableDivision = ConfigFactory.getTableDivision();
	
	public String converterClassName(String tableName) {
		// TODO Auto-generated method stub
		if (tablePrefix != null) {
			if (tableName.startsWith(tablePrefix)) {
				tableName = tableName.substring(tablePrefix.length());
			}
		}
		if (tableSuffix != null) {
			if (tableName.endsWith(tableSuffix)) {
				tableName = tableName.substring(0,tableName.length()-tablePrefix.length()-1);
			}
		}
		if (tableDivision != null) {
			String[] divs = tableName.split(tableDivision);
			tableName = "";
			for (String div : divs) {
				tableName += StringUtil.upperFirst(div);
			}
		}
		return StringUtil.upperFirst(tableName);
	}

	public String converterFieldName(String columnName) {
		// TODO Auto-generated method stub
		return StringUtil.lowerFirst(columnName);
	}

}
