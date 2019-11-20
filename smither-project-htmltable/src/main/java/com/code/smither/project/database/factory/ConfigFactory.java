package com.code.smither.project.database.factory;

import com.code.smither.project.htmltable.HtmlTableConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static HtmlTableConfig loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties properties = new Properties();
		properties.load(stream);

		HtmlTableConfig config = new HtmlTableConfig();

		config.setNow(properties.getProperty("code.smither.now",config.getNow()));

		config.setTemplateFtlOnly("true".equalsIgnoreCase(properties.getProperty("code.smither.template.ftl-only")));
		config.setTemplateLang(properties.getProperty("code.smither.template.lang",config.getTemplateLang()));
		config.setTemplatePath(properties.getProperty("code.smither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(properties.getProperty("code.smither.template.charset",config.getTemplateCharset()));

		config.setTargetPath(properties.getProperty("code.smither.target.path",config.getTargetPath()));
		config.setTargetCharset(properties.getProperty("code.smither.target.charset",config.getTargetCharset()));
		config.setTargetProjectName(properties.getProperty("code.smither.target.project.name",config.getTargetProjectName()));
		config.setTargetProjectAuthor(properties.getProperty("code.smither.target.project.author",config.getTargetProjectAuthor()));
		config.setTargetProjectPackage(properties.getProperty("code.smither.target.project.package",config.getTargetProjectPackage()));


		config.setHtmlTablePath(properties.getProperty("code.smither.htmltable.path",config.getHtmlTablePath()));
		config.setHtmlTableCharset(properties.getProperty("code.smither.htmltable.charset",config.getHtmlTableCharset()));

		config.setTablePrefix(properties.getProperty("code.smither.database.table.prefix",config.getTablePrefix()));
		config.setTableSuffix(properties.getProperty("code.smither.database.table.suffix",config.getTableSuffix()));
		config.setTableDivision(properties.getProperty("code.smither.database.table.division",config.getTableDivision()));

		config.setColumnPrefix(properties.getProperty("code.smither.database.column.prefix",config.getColumnPrefix()));
		config.setColumnSuffix(properties.getProperty("code.smither.database.column.suffix",config.getColumnSuffix()));
		config.setColumnDivision(properties.getProperty("code.smither.database.column.division",config.getColumnDivision()));

		config.setIncludeFile(properties.getProperty("code.smither.template.include.file",config.getIncludeFile()));
		config.setIncludePath(properties.getProperty("code.smither.template.include.path",config.getIncludePath()));
		config.setFilterFile(properties.getProperty("code.smither.template.filter.file",config.getFilterFile()));
		config.setFilterPath(properties.getProperty("code.smither.template.filter.path",config.getFilterPath()));

		return config;
	}

}
