package com.generator.replace;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.database.factory.DbConfigFactory;

import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ReplaceConfigFactory {

	public static ReplaceConfig loadConfig(String path) {
		ReplaceConfig config = new ReplaceConfig();
		Properties properties = ConfigFactory.loadProperties(path);
		loadConfig(properties, config);
		return config;
	}

	public static void loadConfig(Properties properties, ReplaceConfig config) {
		DbConfigFactory.loadConfig(properties, config);
		config.setReplaceTableIgnore(properties.getProperty("code.man.replace.table.ignore", config.getReplaceTableIgnore()));
		config.setReplaceTableRemark(properties.getProperty("code.man.replace.table.remark", config.getReplaceTableRemark()));
        config.setReplaceTableName(properties.getProperty("code.man.replace.table.replace", config.getReplaceTableName()));
        config.setReplaceColumnName(properties.getProperty("code.man.replace.column.replace", config.getReplaceColumnName()));
	}

}