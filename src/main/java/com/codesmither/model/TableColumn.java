package com.codesmither.model;

/**
 * 表字段
 * 
 * @author Administrator
 * 
 */
public class TableColumn {
	
	public String name;// 原名称
	public String type;// 字段类型名称
	public String remark;// 字段注释
	public int lenght;//列长度
	public int typeInt;//数据库列类型
	public String fieldName;//java 字段
	public String fieldNameUpper;// 首字母大写
	public String fieldNameLower;// 首字母小写
	public String fieldType;//java 字段类型
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
		this.fieldName = fieldName;
	}
	public String getFieldName_u() {
		return fieldNameUpper;
	}
	public void setFieldName_u(String fieldName_u) {
		this.fieldNameUpper = fieldName_u;
	}
	public String getFieldName_l() {
		return fieldNameLower;
	}
	public void setFieldName_l(String fieldName_l) {
		this.fieldNameLower = fieldName_l;
	}
	public String getFieldType() {
		return fieldType;
	}
	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	
	
}
