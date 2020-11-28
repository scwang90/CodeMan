package com.code.smither.model;

import com.code.smither.api.TaskLoader;

/**
 * 模板Model-table-column
 * Created by SCWANG on 2015-07-04.
 */
@SuppressWarnings("unused")
public class TableColumn {
	
	private String name;// 原名称
	private String nameSQL;// SQL语句中使用的名称
	private String type;// 字段类型名称
	private String remark;// 字段注释
	private String defValue;// 字段注释
	private String typeJdbc;// MyBatis XML 字段类型名称
	private String description;//详细描述 (分析得到)

	private int length;//列长度
	private int typeInt;//数据库列类型
	private int decimalDigits;//小数位数

	private String fieldName;// 字段
	private String fieldNameUpper;// 首字母大写
	private String fieldNameLower;// 首字母小写
	private String fieldType;// 字段类型
	private String fieldJavaType;//java 字段类型
	private String fieldCSharpType;//C# 字段类型
	private String fieldKotlinType;//kotlin 字段类型

	private boolean nullable;//允许null
	private boolean autoIncrement;//是否自增
	private boolean primaryKey;//是否是 PrimaryKey
	private boolean stringType;//是否是string类型

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (name == null) {
			name = "";
		}
		this.name = name;
		this.nameSQL = nameSQL == null ? name : nameSQL;
	}

	public void setName(String name, TaskLoader.Database database) {
		this.name = name;
		this.nameSQL = name;
		if (database != null && database.isKeyword(name)) {
			this.nameSQL = database.wrapperKeyword(name);
		}
	}

	public String getNameSQL() {
		return nameSQL;
	}

	public void setNameSQL(String nameSQL) {
		this.nameSQL = nameSQL;
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

	public String getDefValue() {
		return defValue;
	}

	public String getDescription() {
		return description;
	}

	public void setRemark(String remark) {
		if (remark == null) {
			remark = "";
		}
		this.remark = remark;
	}

	public void setDefValue(String defValue) {
		if (defValue == null) {
			defValue = "";
		}
		this.defValue = defValue;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public int getTypeInt() {
		return typeInt;
	}

	public void setTypeInt(int typeInt) {
		this.typeInt = typeInt;
	}

	public String getTypeJdbc() {
		return typeJdbc;
	}

	public void setTypeJdbc(String typeJdbc) {
		this.typeJdbc = typeJdbc;
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

	public String getFieldJavaType() {
		return fieldJavaType;
	}

	public void setFieldJavaType(String fieldJavaType) {
		if (fieldJavaType == null) {
			fieldJavaType = "";
		}
		this.fieldJavaType = fieldJavaType;
	}

	public String getFieldCSharpType() {
		return fieldCSharpType;
	}

	public void setFieldCSharpType(String fieldCSharpType) {
		if (fieldCSharpType == null) {
			fieldCSharpType = "";
		}
		this.fieldCSharpType = fieldCSharpType;
	}

	public String getFieldKotlinType() {
		return fieldKotlinType;
	}

	public void setFieldKotlinType(String fieldKotlinType) {
		this.fieldKotlinType = fieldKotlinType;
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

	public boolean isPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(boolean primaryKey) {
		this.primaryKey = primaryKey;
	}

	public boolean isStringType() {
		return stringType;
	}

	public void setStringType(boolean stringType) {
		this.stringType = stringType;
	}

	public int getDecimalDigits() {
		return decimalDigits;
	}

	public void setDecimalDigits(int decimalDigits) {
		this.decimalDigits = decimalDigits;
	}
}
