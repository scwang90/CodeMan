package com.codesmither.model;

public class Model {
	public Table table;
	public String className;
	public String author;
	public String packagename;
	public String projectName;
	
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

	public String getpackagename() {
		return packagename;
	}

	public void setpackagename(String packagename) {
		this.packagename = packagename;
	}

	public String getPackagename() {
		return packagename;
	}

	public void setPackagename(String packagename) {
		this.packagename = packagename;
	}

	public Model() {
		// TODO Auto-generated constructor stub
	}
	
	public Model(String author, String packagename) {
		super();
		this.author = author;
		this.packagename = packagename;
	}

	public Model(Table table) {
		// TODO Auto-generated constructor stub
		this.table = table;
		this.className = table.className;
	}
	
	public void bindTable(Table table) {
		this.table = table;
		this.className = table.className;
	}
}
