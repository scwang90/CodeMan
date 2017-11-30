package com.generator.fecred.project;

import com.codesmither.project.database.DataBaseConfig;
import com.codesmither.project.database.DataBaseEngine;
import com.codesmither.project.database.factory.ConfigFactory;
import org.junit.Test;

public class DaataBaseEngineTester {

    @Test
    public void DataBaseTemplete() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("trailer-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
