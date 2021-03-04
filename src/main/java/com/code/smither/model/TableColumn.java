package com.code.smither.model;

import java.util.Arrays;
import java.util.List;

/**
 * 模板Model-table-column
 * Created by SCWANG on 2015-07-04.
 */
@SuppressWarnings("unused")
public class TableColumn {


	private String name;// 原名称
	private String nameSQL;// SQL语句中使用的名称
	private String nameSqlInStr;// SQL语句中使用的名称（在字符串拼接中使用）
	private String type;// 字段类型名称（数据库返回的值）
	private String typeJdbc;// 字段类型名称（JDBC 枚举，所有数据库一致性，java.sql.Types 枚举所有的类型）
	private String remark;// 字段注释
	private String defValue;// 字段注释
	private String description;//详细描述（分析得到）

	private int length;//列长度
	private int typeInt;//数据库列类型
	private int decimalDigits;//小数位数

	private String fieldName;// 字段
	private String fieldNameUpper;// 首字母大写
	private String fieldNameLower;// 首字母小写
	private String fieldType;// 字段类型
	private String fieldTypeObject;// 字段类型-对象类型（如 Integer Short）
	private String fieldTypePrimitive;// 字段类型-基础类型（如 int short）
	private String fieldJavaType;//java 字段类型
	private String fieldCSharpType;//C# 字段类型
	private String fieldKotlinType;//kotlin 字段类型

	private boolean nullable;//允许null
	private boolean autoIncrement;//是否自增
	private boolean primaryKey;//是否是 PrimaryKey
	private boolean stringType;//是否是 string类型

	private List<String> descriptions;// 多行详细描述

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (name == null) {
			name = "";
		}
		this.name = name;
		this.nameSQL = nameSQL == null ? name : nameSQL;
		this.nameSqlInStr = nameSQL;
	}

	public String getNameSQL() {
		return nameSQL;
	}

	public void setNameSQL(String nameSQL) {
		this.nameSQL = nameSQL;
	}

	public String getNameSqlInStr() {
		return nameSqlInStr;
	}

	public void setNameSqlInStr(String nameSqlInStr) {
		this.nameSqlInStr = nameSqlInStr;
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

	public String getTypeJdbc() {
		return typeJdbc;
	}

	public void setTypeJdbc(String typeJdbc) {
		if (typeJdbc == null) {
			typeJdbc = "";
		}
		this.typeJdbc = typeJdbc;
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

	public List<String> getDescriptions() {
		return descriptions;
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
		this.descriptions = Arrays.asList(description.split("\n"));
	}

	public void setDescriptions(List<String> descriptions) {
		this.descriptions = descriptions;
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

	public String getFieldTypeObject() {
		return fieldTypeObject;
	}

	public void setFieldTypeObject(String fieldTypeObject) {
		this.fieldTypeObject = fieldTypeObject;
	}

	public String getFieldTypePrimitive() {
		return fieldTypePrimitive;
	}

	public void setFieldTypePrimitive(String fieldTypePrimitive) {
		this.fieldTypePrimitive = fieldTypePrimitive;
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

	public int getDecimalDigits() {
		return decimalDigits;
	}

	public void setDecimalDigits(int decimalDigits) {
		this.decimalDigits = decimalDigits;
	}

	public boolean isStringType() {
		return stringType;
	}

	public void setStringType(boolean stringType) {
		this.stringType = stringType;
	}
}
