package com.generator.meteor;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.ConfigFactory;

import org.junit.Test;

public class DataBaseEngineTester {

    @Test
    public void DataBaseMedicalPlatform() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("medical-platform.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseCreditChina() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("credit-china.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseMedicalWxHis() {
        try {
            DataBaseConfig config = ConfigFactory.loadConfig("medical-wxhis.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
