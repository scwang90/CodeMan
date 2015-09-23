package com.codesmither.factory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigFactory {

	private static String dbConfigName;

	private static String tablePrefix = "";
	private static String tableSuffix = "";
	private static String tableDivision = "";

	private static String columnPrefix = "";
	private static String columnSuffix = "";
	private static String columnDivision = "";
	
	private static String templatePath = "templates/dbutil-spring-web";
	private static String templateCharset = "UTF-8";
	
	private static String targetPath = "target/project";
	private static String targetCharset = "UTF-8";
	private static String targetProjectName = "TargetProject";
	private static String targetProjectAuthor = "scwang";
	private static String targetProjectPackage = "com.codesmither";
	
	static{
		try {
			loadConfig("config.properties");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	private static void loadConfig(String path) throws IOException {
		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties propty = new Properties();
		propty.load(stream);
		
		dbConfigName = propty.getProperty("codesmither.database.config.name",dbConfigName);

		tablePrefix   = propty.getProperty("codesmither.database.table.prefix",tablePrefix);
		tableSuffix   = propty.getProperty("codesmither.database.table.suffix",tableSuffix);
		tableDivision = propty.getProperty("codesmither.database.table.division",tableDivision);

		columnPrefix   = propty.getProperty("codesmither.database.column.prefix",columnPrefix);
		columnSuffix   = propty.getProperty("codesmither.database.column.suffix",columnSuffix);
		columnDivision = propty.getProperty("codesmither.database.column.division",columnDivision);
		
		templatePath   = propty.getProperty("codesmither.template.path",templatePath);
		templateCharset   = propty.getProperty("codesmither.template.charset",templateCharset);

		targetPath = propty.getProperty("codesmither.target.path",targetPath);
		targetCharset = propty.getProperty("codesmither.target.charset",targetCharset);
		targetProjectName = propty.getProperty("codesmither.target.project.name",targetProjectName);
		targetProjectAuthor = propty.getProperty("codesmither.target.project.author",targetProjectAuthor);
		targetProjectPackage = propty.getProperty("codesmither.target.project.packagename",targetProjectPackage);
		
	}

	public static String getDbConfigName() {
		return dbConfigName;
	}

	public static void setDbConfigName(String dbConfigName) {
		ConfigFactory.dbConfigName = dbConfigName;
	}

	public static String getTargetProjectPackage() {
		return targetProjectPackage;
	}

	public static void setTargetProjectPackage(String targetProjectPackage) {
		ConfigFactory.targetProjectPackage = targetProjectPackage;
	}

	public static String getTargetProjectAuthor() {
		return targetProjectAuthor;
	}

	public static void setTargetProjectAuthor(String targetProjectAuthor) {
		ConfigFactory.targetProjectAuthor = targetProjectAuthor;
	}

	public static String getTemplatePath() {
		return templatePath;
	}

	public static void setTemplatePath(String templatePath) {
		ConfigFactory.templatePath = templatePath;
	}

	public static String getTemplateCharset() {
		return templateCharset;
	}

	public static void setTemplateCharset(String templateCharset) {
		ConfigFactory.templateCharset = templateCharset;
	}

	public static String getTargetPath() {
		return targetPath;
	}

	public static void setTargetPath(String targetPath) {
		ConfigFactory.targetPath = targetPath;
	}

	public static String getTargetCharset() {
		return targetCharset;
	}

	public static void setTargetCharset(String targetCharset) {
		ConfigFactory.targetCharset = targetCharset;
	}

	public static String getTargetProjectName() {
		return targetProjectName;
	}

	public static void setTargetProjectName(String targetProjectName) {
		ConfigFactory.targetProjectName = targetProjectName;
	}

	public static String getTablePrefix() {
		return tablePrefix;
	}

	public static void setTablePrefix(String tablePrefix) {
		ConfigFactory.tablePrefix = tablePrefix;
	}

	public static String getTableSuffix() {
		return tableSuffix;
	}

	public static void setTableSuffix(String tableSuffix) {
		ConfigFactory.tableSuffix = tableSuffix;
	}

	public static String getTableDivision() {
		return tableDivision;
	}

	public static void setTableDivision(String tableDivision) {
		ConfigFactory.tableDivision = tableDivision;
	}

	public static String getColumnPrefix() {
		return columnPrefix;
	}

	public static void setColumnPrefix(String columnPrefix) {
		ConfigFactory.columnPrefix = columnPrefix;
	}

	public static String getColumnSuffix() {
		return columnSuffix;
	}

	public static void setColumnSuffix(String columnSuffix) {
		ConfigFactory.columnSuffix = columnSuffix;
	}

	public static String getColumnDivision() {
		return columnDivision;
	}

	public static void setColumnDivision(String columnDivision) {
		ConfigFactory.columnDivision = columnDivision;
	}

}
