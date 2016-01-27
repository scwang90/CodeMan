package com.codesmither.model;

/**
 * 模板Model-table-column
 * Created by SCWANG on 2015-07-04.
 */
public class TableColumn {
	
	private String name;// 原名称
	private String type;// 字段类型名称
	private String remark;// 字段注释
	private String defvalue;// 字段注释
	private int lenght;//列长度
	private int typeInt;//数据库列类型
	private String fieldName;//java 字段
	private String fieldNameUpper;// 首字母大写
	private String fieldNameLower;// 首字母小写
	private String fieldType;//java 字段类型
	private boolean nullable;//允许null
	private boolean autoIncrement;//是否自增

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (name == null) {
			name = "";
		}
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		if (type == null) {
			type = "";
		}
		this.type = type;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		if (remark == null) {
			remark = "";
		}
		this.remark = remark;
	}

	public String getDefvalue() {
		return defvalue;
	}

	public void setDefvalue(String defvalue) {
		if (defvalue == null) {
			defvalue = "";
		}
		this.defvalue = defvalue;
	}

	public int getLenght() {
		return lenght;
	}

	public void setLenght(int lenght) {
		this.lenght = lenght;
	}

	public int getTypeInt() {
		return typeInt;
	}

	public void setTypeInt(int typeInt) {
		this.typeInt = typeInt;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		if (fieldName == null) {
			fieldName = "";
		}
		this.fieldName = fieldName;
	}

	public String getFieldNameUpper() {
		return fieldNameUpper;
	}

	public void setFieldNameUpper(String fieldNameUpper) {
		if (fieldNameUpper == null) {
			fieldNameUpper = "";
		}
		this.fieldNameUpper = fieldNameUpper;
	}

	public String getFieldNameLower() {
		return fieldNameLower;
	}

	public void setFieldNameLower(String fieldNameLower) {
		if (fieldNameLower == null) {
			fieldNameLower = "";
		}
		this.fieldNameLower = fieldNameLower;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		if (fieldType == null) {
			fieldType = "";
		}
		this.fieldType = fieldType;
	}

	public boolean isNullable() {
		return nullable;
	}

	public void setNullable(boolean nullable) {
		this.nullable = nullable;
	}

	public boolean isAutoIncrement() {
		return autoIncrement;
	}

	public void setAutoIncrement(boolean autoIncrement) {
		this.autoIncrement = autoIncrement;
	}
}
