package com.code.smither.project.database.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.factory.ProjectConfigFactory;
import com.code.smither.project.database.DataBaseConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class DbConfigFactory {

	public static DataBaseConfig loadConfig(String path) {
		DataBaseConfig config = new DataBaseConfig();
		Properties properties = ConfigFactory.loadProperties(path);
		loadConfig(properties, config);
		return config;
	}

	public static void loadConfig(Properties properties, DataBaseConfig config) {
		ProjectConfigFactory.loadConfig(properties, config);
		config.setDbConfigName(properties.getProperty("code.smither.database.config.name", config.getDbConfigName()));
	}

}
