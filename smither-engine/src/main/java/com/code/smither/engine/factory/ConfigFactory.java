package com.code.smither.engine.factory;

import com.code.smither.engine.EngineConfig;
import com.code.smither.engine.tools.CustomModel;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConfigFactory {

    private static final Logger logger = Logger.getLogger(ConfigFactory.class.getName());

    public static Properties loadProperties(String path) {
        try (InputStream stream = ClassLoader.getSystemResourceAsStream(path)) {
            if (stream == null) {
                throw new RuntimeException("找不到配置文件：" + path);
            }
            Properties property = new Properties();
            try (Reader reader = new InputStreamReader(stream, StandardCharsets.UTF_8)) {
                property.load(reader);
            }
            logger.log(Level.CONFIG, "加载配置文件：{0}", path);
            return property;
        } catch (IOException e) {
            throw new RuntimeException("读取配置文件失败");
        }
    }

    public static <T extends EngineConfig> T loadConfig(Properties properties, T config) {

        config.setNow(properties.getProperty("code.man.now",config.getNow()));

        config.setTemplateProcessAll("true".equalsIgnoreCase(properties.getProperty("code.man.template.process-all")));
        config.setForceOverwrite("true".equalsIgnoreCase(properties.getProperty("code.man.task.force-overwrite")));

        config.setTemplatePath(properties.getProperty("code.man.template.path",config.getTemplatePath()));
        config.setTemplateCharset(properties.getProperty("code.man.template.charset",config.getTemplateCharset()));

        config.setTargetPath(properties.getProperty("code.man.target.path",config.getTargetPath()));
        config.setTargetCharset(properties.getProperty("code.man.target.charset",config.getTargetCharset()));

        config.setIncludeFile(properties.getProperty("code.man.template.include.file",config.getIncludeFile()));
        config.setIncludePath(properties.getProperty("code.man.template.include.path",config.getIncludePath()));
        config.setFilterFile(properties.getProperty("code.man.template.exclude.file",config.getFilterFile()));
        config.setFilterPath(properties.getProperty("code.man.template.exclude.path",config.getFilterPath()));

        CustomModel.load(config.getCustomModel(), properties, "code.man.model.custom");

        return config;
    }

}
