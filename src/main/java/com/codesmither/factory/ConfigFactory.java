package com.codesmither.factory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigFactory {

	private static String tablePrefix = "";
	private static String tableSuffix = "";
	private static String tableDivision = "";
	
	private static String templatePath = "templates/dbutil-spring-web";
	private static String templateCharset;
	
	private static String targetPath = "target/project";
	private static String targetCharset;
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
		// TODO Auto-generated method stub
		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties properties = new Properties();
		properties.load(stream);

		tablePrefix   = properties.getProperty("codesmither.table.prefix");
		tableSuffix   = properties.getProperty("codesmither.table.suffix");
		tableDivision = properties.getProperty("codesmither.table.division");
		
		templatePath   = properties.getProperty("codesmither.template.path");
		templateCharset   = properties.getProperty("codesmither.template.charset");

		targetPath = properties.getProperty("codesmither.target.path");
		targetCharset = properties.getProperty("codesmither.target.charset");
		targetProjectName = properties.getProperty("codesmither.target.project.name");
		targetProjectAuthor = properties.getProperty("codesmither.target.project.author");
		targetProjectPackage = properties.getProperty("codesmither.target.project.packagename");
		
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
	
}
