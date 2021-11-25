package com.code.smither.project.database.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.factory.ProjectConfigFactory;
import com.code.smither.project.htmltable.HtmlTableConfig;

import java.io.IOException;
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

		config.setHtmlTablePath(properties.getProperty("code.man.html.table.path",config.getHtmlTablePath()));
		config.setHtmlTableCharset(properties.getProperty("code.man.html.table.charset",config.getHtmlTableCharset()));

		config.setJdbcUrl(properties.getProperty("code.man.jdbc.url",config.getJdbcUrl()));
		config.setJdbcDriver(properties.getProperty("code.man.jdbc.driver",config.getJdbcDriver()));
		config.setJdbcUsername(properties.getProperty("code.man.jdbc.username",config.getJdbcUsername()));
		config.setJdbcPassword(properties.getProperty("code.man.jdbc.password",config.getJdbcPassword()));

		return config;
	}

}
