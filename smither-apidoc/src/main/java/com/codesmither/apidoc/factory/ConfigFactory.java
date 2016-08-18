package com.codesmither.apidoc.factory;

import com.codesmither.apidoc.ApidocConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static ApidocConfig loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties propty = new Properties();
		propty.load(stream);

		ApidocConfig config = new ApidocConfig();

		config.setTemplatePath(propty.getProperty("codesmither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(propty.getProperty("codesmither.template.charset",config.getTemplateCharset()));

		config.setTargetPath(propty.getProperty("codesmither.target.path",config.getTargetPath()));
		config.setTargetCharset(propty.getProperty("codesmither.target.charset",config.getTargetCharset()));

		return config;
	}

}
