package com.generator.apidoc;

import com.code.smither.apidoc.ApiDocEngine;
import com.code.smither.apidoc.XmlApiDocConfig;
import com.code.smither.apidoc.factory.ConfigFactory;
import org.junit.Test;

/**
 * EngineTester
 * Created by SCWANG on 2016/8/19.
 */
public class ApiDocEngineTester {

    @Test
    public void engineTestApp() {
        try {
            XmlApiDocConfig config = ConfigFactory.loadConfig("demo-apidoc.properties");
            ApiDocEngine engine = new ApiDocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

}
