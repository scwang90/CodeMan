package com.codesmither.project.database.factory;

import com.codesmither.project.database.DataBaseConfig;

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

		config.setDbConfigName(property.getProperty("codesmither.database.config.name",config.getDbConfigName()));

		config.setTablePrefix(property.getProperty("codesmither.database.table.prefix",config.getTablePrefix()));
		config.setTableSuffix(property.getProperty("codesmither.database.table.suffix",config.getTableSuffix()));
		config.setTableDivision(property.getProperty("codesmither.database.table.division",config.getTableDivision()));

		config.setColumnPrefix(property.getProperty("codesmither.database.column.prefix",config.getColumnPrefix()));
		config.setColumnSuffix(property.getProperty("codesmither.database.column.suffix",config.getColumnSuffix()));
		config.setColumnDivision(property.getProperty("codesmither.database.column.division",config.getColumnDivision()));

		config.setTemplateLang(property.getProperty("codesmither.template.lang",config.getTemplateLang()));
		config.setTemplatePath(property.getProperty("codesmither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(property.getProperty("codesmither.template.charset",config.getTemplateCharset()));

		config.setTemplateIncludeFile(property.getProperty("codesmither.template.include.file",config.getTemplateIncludeFile()));
		config.setTemplateIncludePath(property.getProperty("codesmither.template.include.path",config.getTemplateIncludePath()));
		config.setTemplateFilterFile(property.getProperty("codesmither.template.filter.file",config.getTemplateFilterFile()));
		config.setTemplateFilterPath(property.getProperty("codesmither.template.filter.path",config.getTemplateFilterPath()));

		config.setTargetPath(property.getProperty("codesmither.target.path",config.getTargetPath()));
		config.setTargetCharset(property.getProperty("codesmither.target.charset",config.getTargetCharset()));
		config.setTargetProjectName(property.getProperty("codesmither.target.project.name",config.getTargetProjectName()));
		config.setTargetProjectAuthor(property.getProperty("codesmither.target.project.author",config.getTargetProjectAuthor()));
		config.setTargetProjectPackage(property.getProperty("codesmither.target.project.packagename",config.getTargetProjectPackage()));

		return config;
	}

}
