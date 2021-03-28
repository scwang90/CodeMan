package com.code.smither.project.replace.kernel;

import com.code.smither.engine.factory.ConfigFactory;

import java.util.Properties;

public class ReplaceConfigFactory {

    public static ReplaceConfig loadConfig(String path) {
        ReplaceConfig config = new ReplaceConfig();
        Properties properties = ConfigFactory.loadProperties(path);
        loadConfig(properties, config);
        return config;
    }

    public static <T extends ReplaceConfig> T loadConfig(Properties properties, T config) {
        ConfigFactory.loadConfig(properties, config);
        config.setReplaceDictPath(properties.getProperty("code.man.replace.dict.path", config.getReplaceDictPath()));
        return config;
    }
}
