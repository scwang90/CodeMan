package com.code.generator.database;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.DbConfigFactory;
import org.junit.Test;

public class DemoEngineTester {

    @Test
    public void demoTemplate() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("demo.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
