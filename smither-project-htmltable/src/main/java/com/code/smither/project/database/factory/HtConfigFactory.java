package com.code.smither.project.database.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.factory.ProjectConfigFactory;
import com.code.smither.project.htmltable.HtmlTableConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class HtConfigFactory {

	public static HtmlTableConfig loadConfig(String path) throws IOException {
		HtmlTableConfig config = new HtmlTableConfig();
		Properties properties = ConfigFactory.loadProperties(path);
		ProjectConfigFactory.loadConfig(properties, config);

		config.setHtmlTablePath(properties.getProperty("code.smither.html.table.path",config.getHtmlTablePath()));
		config.setHtmlTableCharset(properties.getProperty("code.smither.html.table.charset",config.getHtmlTableCharset()));

		config.setJdbcDriver(properties.getProperty("code.smither.jdbc.driver",config.getJdbcDriver()));
		config.setJdbcUrl(properties.getProperty("code.smither.jdbc.url",config.getJdbcUrl()));
		config.setJdbcUsername(properties.getProperty("code.smither.jdbc.username",config.getJdbcUsername()));
		config.setJdbcPassword(properties.getProperty("code.smither.jdbc.password",config.getJdbcPassword()));

		return config;
	}

}
