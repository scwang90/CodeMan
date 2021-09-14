package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.ClassConverter;
import com.code.smither.project.base.constant.AbstractProgramLang;
import com.code.smither.project.base.model.TableColumn;

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

	@Override
	public String converterClassName(String tableName) {
		String classname = lang.converterClassName(tableName);
		if (lang.isKeyword(classname)) {
			classname = lang.wrapperKeyword(classname);
		}
		return classname;
	}

	@Override
	public String converterFieldName(String columnName) {
		String fieldName = lang.converterFieldName(columnName);
		if (lang.isKeyword(fieldName)) {
			fieldName = lang.wrapperKeyword(fieldName);
		}
		return fieldName;
	}

	@Override
	public String converterFieldType(TableColumn column, DataType... type) {
		if (type.length > 0 && type[0] == DataType.primitive) {
			return lang.getBasicType(column);
		}
		return lang.getType(column);
	}
}
