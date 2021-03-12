package com.code.smither.factory;

import com.code.smither.kernel.api.Config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static Config loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties properties = new Properties();
		properties.load(stream);

		Config config = new Config();

		config.setTemplateFtlOnly("true".equalsIgnoreCase(properties.getProperty("code.man.template.ftl-only")));
		config.setTemplateLang(properties.getProperty("code.man.template.lang",config.getTemplateLang()));
		config.setTemplatePath(properties.getProperty("code.man.template.path",config.getTemplatePath()));
		config.setTemplateCharset(properties.getProperty("code.man.template.charset",config.getTemplateCharset()));

		config.setTemplateIncludeFile(properties.getProperty("code.man.template.include.file",config.getTemplateIncludeFile()));
		config.setTemplateIncludePath(properties.getProperty("code.man.template.include.path",config.getTemplateIncludePath()));
		config.setTemplateFilterFile(properties.getProperty("code.man.template.filter.file",config.getTemplateFilterFile()));
		config.setTemplateFilterPath(properties.getProperty("code.man.template.filter.path",config.getTemplateFilterPath()));

		config.setTargetPath(properties.getProperty("code.man.target.path",config.getTargetPath()));
		config.setTargetCharset(properties.getProperty("code.man.target.charset",config.getTargetCharset()));
		config.setTargetProjectName(properties.getProperty("code.man.target.project.name",config.getTargetProjectName()));
		config.setTargetProjectAuthor(properties.getProperty("code.man.target.project.author",config.getTargetProjectAuthor()));
		config.setTargetProjectPackage(properties.getProperty("code.man.target.project.package",config.getTargetProjectPackage()));


		config.setDbConfigName(properties.getProperty("code.man.database.config.name",config.getDbConfigName()));

		config.setTablePrefix(properties.getProperty("code.man.database.table.prefix",config.getTablePrefix()));
		config.setTableSuffix(properties.getProperty("code.man.database.table.suffix",config.getTableSuffix()));
		config.setTableDivision(properties.getProperty("code.man.database.table.division",config.getTableDivision()));

		config.setColumnPrefix(properties.getProperty("code.man.database.column.prefix",config.getColumnPrefix()));
		config.setColumnSuffix(properties.getProperty("code.man.database.column.suffix",config.getColumnSuffix()));
		config.setColumnDivision(properties.getProperty("code.man.database.column.division",config.getColumnDivision()));

		return config;
	}

}
