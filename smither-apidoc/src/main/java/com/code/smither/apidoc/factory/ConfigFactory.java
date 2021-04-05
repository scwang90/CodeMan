package com.code.smither.apidoc.factory;

import com.code.smither.apidoc.XmlApiDocConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static XmlApiDocConfig loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties properties = new Properties();
		properties.load(stream);

		XmlApiDocConfig config = new XmlApiDocConfig();

		config.setNow(properties.getProperty("code.man.now",config.getNow()));

		config.setTemplateProcessAll("true".equals(properties.getProperty("code.man.template.process-all")));
		config.setTemplatePath(properties.getProperty("code.man.template.path",config.getTemplatePath()));
		config.setTemplateCharset(properties.getProperty("code.man.template.charset",config.getTemplateCharset()));

		config.setTargetPath(properties.getProperty("code.man.target.path",config.getTargetPath()));
		config.setTargetCharset(properties.getProperty("code.man.target.charset",config.getTargetCharset()));

		config.setXmlSourcePath(properties.getProperty("code.man.xmlsource.path",config.getXmlSourcePath()));
		config.setXmlSourceCharset(properties.getProperty("code.man.xmlsource.charset",config.getXmlSourceCharset()));


		return config;
	}

}
