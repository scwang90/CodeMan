package com.generator.yxtech.serviceapi.worker;

import com.code.smither.apidoc.ApiDocEngine;
import com.code.smither.apidoc.XmlApiDocConfig;
import com.code.smither.apidoc.factory.ConfigFactory;
import org.junit.Test;

/**
 * EngineTester
 * Created by SCWANG on 2016/8/19.
 */
public class EngineTester {

    @Test
    public void engineTestApp() {
        try {
            XmlApiDocConfig config = ConfigFactory.loadConfig("testapp.properties");
            ApiDocEngine engine = new ApiDocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

    @Test
    public void engineWorker() {
        try {
            XmlApiDocConfig config = ConfigFactory.loadConfig("worker.properties");
            ApiDocEngine engine = new ApiDocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

    @Test
    public void engineFitment() {
        try {
            XmlApiDocConfig config = ConfigFactory.loadConfig("fitment.properties");
            ApiDocEngine engine = new ApiDocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

}
