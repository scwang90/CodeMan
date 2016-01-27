package com.codesmither.model;

import java.util.List;

/**
 * 模板Model-table
 * Created by SCWANG on 2015-07-04.
 */
public class Table {

	public String className;// 原类名称
	public String classNameCamel;// 骆驼峰类名
	public String classNameUpper;// 类名全大写
	public String classNameLower;// 类名全小写

	public String name;// 原表名称
	// public String tableName_u;// 大写表名称
	// public String tableName_l;// 小写表名称

	public String remark;// 字段注释

	public TableColumn idColumn; // ID列

	// public String modelPackage;// pojo包名称
	// public String daoPackage;// dao包名称
	// public String daoImplPackage;// imp包名称
	// public String servicePackage;// ext包名称
	// public String serviceImplPackage;// xml包名称
	// public List<TableIndex> tableIndexs;// 表索引
	// public List<TableBind> tableBinds;// 表主外键
	public List<TableColumn> columns;// 表字段

	public String getClassNameCamel() {
		return classNameCamel;
	}

	public void setClassNameCamel(String classNameCamel) {
		this.classNameCamel = classNameCamel;
	}

	public String getClassNameUpper() {
		return classNameUpper;
	}

	public void setClassNameUpper(String classNameUpper) {
		this.classNameUpper = classNameUpper;
	}

	public String getClassNameLower() {
		return classNameLower;
	}

	public void setClassNameLower(String classNameLower) {
		this.classNameLower = classNameLower;
	}

	public TableColumn getIdColumn() {
		return idColumn;
	}

	public void setIdColumn(TableColumn idColumn) {
		this.idColumn = idColumn;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<TableColumn> getColumns() {
		return columns;
	}

	public void setColumns(List<TableColumn> columns) {
		this.columns = columns;
	}

	// public Set<String> importPojos;// 需要导入的POJO

	// public String stringCarrayNames1;// ","拼接大写字段
	// public String stringCarrayNames2;// int id ,String userCord ,..
	// public String stringCarrayNames3;// ","拼接原字段
	// public String stringCarrayNames4;// "#{%s},"拼接小写字段
	// public String stringCarrayNames5;// "%s=#{%s},"拼接原字段-小写字段

}
