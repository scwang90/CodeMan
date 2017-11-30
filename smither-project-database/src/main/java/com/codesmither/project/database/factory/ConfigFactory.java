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
		Properties propty = new Properties();
		propty.load(stream);

		DataBaseConfig config = new DataBaseConfig();

		config.setDbConfigName(propty.getProperty("codesmither.database.config.name",config.getDbConfigName()));

		config.setTablePrefix(propty.getProperty("codesmither.database.table.prefix",config.getTablePrefix()));
		config.setTableSuffix(propty.getProperty("codesmither.database.table.suffix",config.getTableSuffix()));
		config.setTableDivision(propty.getProperty("codesmither.database.table.division",config.getTableDivision()));

		config.setColumnPrefix(propty.getProperty("codesmither.database.column.prefix",config.getColumnPrefix()));
		config.setColumnSuffix(propty.getProperty("codesmither.database.column.suffix",config.getColumnSuffix()));
		config.setColumnDivision(propty.getProperty("codesmither.database.column.division",config.getColumnDivision()));

		config.setTemplateLang(propty.getProperty("codesmither.template.lang",config.getTemplateLang()));
		config.setTemplatePath(propty.getProperty("codesmither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(propty.getProperty("codesmither.template.charset",config.getTemplateCharset()));

		config.setTemplateIncludeFile(propty.getProperty("codesmither.template.include.file",config.getTemplateIncludeFile()));
		config.setTemplateIncludePath(propty.getProperty("codesmither.template.include.path",config.getTemplateIncludePath()));
		config.setTemplateFilterFile(propty.getProperty("codesmither.template.filter.file",config.getTemplateFilterFile()));
		config.setTemplateFilterPath(propty.getProperty("codesmither.template.filter.path",config.getTemplateFilterPath()));

		config.setTargetPath(propty.getProperty("codesmither.target.path",config.getTargetPath()));
		config.setTargetCharset(propty.getProperty("codesmither.target.charset",config.getTargetCharset()));
		config.setTargetProjectName(propty.getProperty("codesmither.target.project.name",config.getTargetProjectName()));
		config.setTargetProjectAuthor(propty.getProperty("codesmither.target.project.author",config.getTargetProjectAuthor()));
		config.setTargetProjectPackage(propty.getProperty("codesmither.target.project.packagename",config.getTargetProjectPackage()));

		return config;
	}

}
