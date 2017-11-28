package com.generator.fecred.apidoc;

import com.codesmither.apidoc.ApidocEngine;
import com.codesmither.apidoc.XmlApidocConfig;
import com.codesmither.apidoc.factory.ConfigFactory;
import org.junit.Test;

import java.text.DecimalFormat;

/**
 * EngineTester
 * Created by SCWANG on 2016/8/19.
 */
public class ApiDocEngineTester {

    @Test
    public void engineTrailerCustom() {
        try {
            XmlApidocConfig config = ConfigFactory.loadConfig("trailer-apidoc-custom.properties");
            ApidocEngine engine = new ApidocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }
}
