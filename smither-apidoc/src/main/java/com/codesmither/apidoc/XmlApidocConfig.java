package com.codesmither.apidoc;

import com.codesmither.engine.Config;

/**
 * APi文档配置信息
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class XmlApidocConfig extends Config {

    protected String xmlSourcePath = "";
    protected String xmlSourceCharset = "UTF-8";

    public String getXmlSourcePath() {
        return xmlSourcePath;
    }

    public void setXmlSourcePath(String xmlSourcePath) {
        this.xmlSourcePath = xmlSourcePath;
    }

    public String getXmlSourceCharset() {
        return xmlSourceCharset;
    }

    public void setXmlSourceCharset(String xmlSourceCharset) {
        this.xmlSourceCharset = xmlSourceCharset;
    }
}
