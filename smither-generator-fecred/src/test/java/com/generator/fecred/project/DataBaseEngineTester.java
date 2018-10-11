package com.generator.fecred.project;

import com.codesmither.project.database.DataBaseConfig;
import com.codesmither.project.database.DataBaseEngine;
import com.codesmither.project.database.factory.ConfigFactory;
import org.junit.Test;

public class DataBaseEngineTester {

    @Test
    public void DataBaseTemplate() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("trailer-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseCredit() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("credit-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseExhibition() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("exhibition-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
