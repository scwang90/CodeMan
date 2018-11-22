package com.code.smither.project.database.factory;

import com.code.smither.project.database.DataBaseConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static DataBaseConfig loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties property = new Properties();
		property.load(stream);

		DataBaseConfig config = new DataBaseConfig();

		config.setDbConfigName(property.getProperty("code.smither.database.config.name",config.getDbConfigName()));

		config.setTemplateFtlOnly("true".equalsIgnoreCase(property.getProperty("code.smither.template.ftl-only")));
		config.setTemplateLang(property.getProperty("code.smither.template.lang",config.getTemplateLang()));
		config.setTemplatePath(property.getProperty("code.smither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(property.getProperty("code.smither.template.charset",config.getTemplateCharset()));

		config.setTargetPath(property.getProperty("code.smither.target.path",config.getTargetPath()));
		config.setTargetCharset(property.getProperty("code.smither.target.charset",config.getTargetCharset()));
		config.setTargetProjectName(property.getProperty("code.smither.target.project.name",config.getTargetProjectName()));
		config.setTargetProjectAuthor(property.getProperty("code.smither.target.project.author",config.getTargetProjectAuthor()));
		config.setTargetProjectPackage(property.getProperty("code.smither.target.project.packagename",config.getTargetProjectPackage()));

		config.setTablePrefix(property.getProperty("code.smither.database.table.prefix",config.getTablePrefix()));
		config.setTableSuffix(property.getProperty("code.smither.database.table.suffix",config.getTableSuffix()));
		config.setTableDivision(property.getProperty("code.smither.database.table.division",config.getTableDivision()));

		config.setColumnPrefix(property.getProperty("code.smither.database.column.prefix",config.getColumnPrefix()));
		config.setColumnSuffix(property.getProperty("code.smither.database.column.suffix",config.getColumnSuffix()));
		config.setColumnDivision(property.getProperty("code.smither.database.column.division",config.getColumnDivision()));

		config.setIncludeFile(property.getProperty("code.smither.template.include.file",config.getIncludeFile()));
		config.setIncludePath(property.getProperty("code.smither.template.include.path",config.getIncludePath()));
		config.setFilterFile(property.getProperty("code.smither.template.filter.file",config.getFilterFile()));
		config.setFilterPath(property.getProperty("code.smither.template.filter.path",config.getFilterPath()));

		return config;
	}

}
