package com.codesmither.apidoc;

import com.codesmither.apidoc.factory.ConfigFactory;
import org.junit.Test;

/**
 * EngineTester
 * Created by SCWANG on 2016/8/19.
 */
public class EngineTester {

    @Test
    public void engine(){
        try {
            ApidocConfig config = ConfigFactory.loadConfig("config.properties");
            ApidocEngine engine = new ApidocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }


}
