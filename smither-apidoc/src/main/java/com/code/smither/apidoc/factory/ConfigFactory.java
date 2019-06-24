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

		config.setNow(properties.getProperty("code.smither.now",config.getNow()));

		config.setTemplateFtlOnly("true".equals(properties.getProperty("code.smither.template.ftl-only")));
		config.setTemplatePath(properties.getProperty("code.smither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(properties.getProperty("code.smither.template.charset",config.getTemplateCharset()));

		config.setTargetPath(properties.getProperty("code.smither.target.path",config.getTargetPath()));
		config.setTargetCharset(properties.getProperty("code.smither.target.charset",config.getTargetCharset()));

		config.setXmlSourcePath(properties.getProperty("code.smither.xmlsource.path",config.getXmlSourcePath()));
		config.setXmlSourceCharset(properties.getProperty("code.smither.xmlsource.charset",config.getXmlSourceCharset()));


		return config;
	}

}
