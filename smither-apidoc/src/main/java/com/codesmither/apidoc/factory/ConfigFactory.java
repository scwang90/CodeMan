package com.codesmither.apidoc.factory;

import com.codesmither.apidoc.XmlApidocConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 生成配置工厂
 * Created by SCWANG on 2015-07-04.
 */
public class ConfigFactory {

	public static XmlApidocConfig loadConfig(String path) throws IOException {

		InputStream stream = ClassLoader.getSystemResourceAsStream(path);
		Properties propty = new Properties();
		propty.load(stream);

		XmlApidocConfig config = new XmlApidocConfig();

		config.setXmlSourcePath(propty.getProperty("codesmither.xmlsource.path",config.getXmlSourcePath()));
		config.setXmlSourceCharset(propty.getProperty("codesmither.xmlsource.charset",config.getXmlSourceCharset()));

		config.setTemplatePath(propty.getProperty("codesmither.template.path",config.getTemplatePath()));
		config.setTemplateCharset(propty.getProperty("codesmither.template.charset",config.getTemplateCharset()));

		config.setTargetPath(propty.getProperty("codesmither.target.path",config.getTargetPath()));
		config.setTargetCharset(propty.getProperty("codesmither.target.charset",config.getTargetCharset()));

		return config;
	}

}
