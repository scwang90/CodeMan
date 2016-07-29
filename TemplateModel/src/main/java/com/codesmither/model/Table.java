package com.codesmither.model;

import java.util.List;

/**
 * 模板Model-table
 * Created by SCWANG on 2015-07-04.
 */
public class Table {

	private String name;// 原表名称
	private String remark;// 字段注释

	private String className;// 原类名称
	private String classNameCamel;// 骆驼峰类名
	private String classNameUpper;// 类名全大写
	private String classNameLower;// 类名全小写

	private TableColumn idColumn; // ID列

	private List<TableColumn> columns;// 表字段
	// private List<TableIndex> tableIndexs;// 表索引
	// private List<TableBind> tableBinds;// 表主外键

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

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

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

	public List<TableColumn> getColumns() {
		return columns;
	}

	public void setColumns(List<TableColumn> columns) {
		this.columns = columns;
	}
}
