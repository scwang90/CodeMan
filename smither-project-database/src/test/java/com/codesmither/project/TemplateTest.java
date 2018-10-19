package com.code.smither.project;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.ConfigFactory;
import org.junit.Test;

/**
 * TemplateTest
 * Created by Administrator on 2015/9/16.
 */
public class TemplateTest {

    @Test
    public void DataBaseTemplete() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("config.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
