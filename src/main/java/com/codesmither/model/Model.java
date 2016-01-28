package com.codesmither.model;

import java.util.List;

/**
 * 模板根Model
 * Created by SCWANG on 2015-07-04.
 */
public class Model {
	
	private Table table;
	private List<Table> tables;
	private DatabaseJdbc jdbc;
	private String className;
	private String tableName;
	private String author;
	private String packageName;
	private String projectName;
	private String charset;

	public Model() {
	}

	public Model(String author, String packageName) {
		super();
		this.author = author;
		this.packageName = packageName;
	}

	public Model(Table table) {
		this.table = table;
		this.className = table.getClassName();
	}

	public void bindTable(Table table) {
		this.table = table;
		this.tableName = table.getName();
		this.className = table.getClassName();
	}
	
	public List<Table> getTables() {
		return tables;
	}
	
	public void setTables(List<Table> tables) {
		this.tables = tables;
	}
	
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public Table getTable() {
		return table;
	}

	public void setTable(Table table) {
		this.table = table;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getCharset() {
		return charset;
	}

	public void setCharset(String charset) {
		this.charset = charset;
	}

	public DatabaseJdbc getJdbc() {
		return jdbc;
	}

	public void setJdbc(DatabaseJdbc jdbc) {
		this.jdbc = jdbc;
	}
}
