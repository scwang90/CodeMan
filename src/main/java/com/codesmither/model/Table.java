package com.codesmither.model;

import java.util.List;

public class Table {
	
	public String className;// 原类名称
//	public String className_u;// 大写类名称
//	public String className_l;// 小写类名称
	
	public String name;// 原表名称
//	public String tableName_u;// 大写表名称
//	public String tableName_l;// 小写表名称

	public String remark;// 字段注释

//	public String modelPackage;// pojo包名称
//	public String daoPackage;// dao包名称
//	public String daoImplPackage;// imp包名称
//	public String servicePackage;// ext包名称
//	public String serviceImplPackage;// xml包名称
//	public List<TableIndex> tableIndexs;// 表索引
//	public List<TableBind> tableBinds;// 表主外键
	public List<TableColumn> columns;// 表字段

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

//	public Set<String> importPojos;// 需要导入的POJO

//	public String stringCarrayNames1;// ","拼接大写字段
//	public String stringCarrayNames2;// int id ,String userCord ,..
//	public String stringCarrayNames3;// ","拼接原字段
//	public String stringCarrayNames4;// "#{%s},"拼接小写字段
//	public String stringCarrayNames5;// "%s=#{%s},"拼接原字段-小写字段

	
}
