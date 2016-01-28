package com.codesmither.engine;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.kernel.api.Config;
import org.junit.Test;

/**
 * TempleteTest
 * Created by Administrator on 2015/9/16.
 */
public class TempleteTest {

    @Test
    public void Templete() {
        try {
            Config config = ConfigFactory.loadConfig("config.properties");
            Engine engine = new Engine(config);
            engine.doInBackground(System.out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
