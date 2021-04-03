package com.generator.fecred.project;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.DbConfigFactory;
import org.junit.Test;

public class DataBaseEngineTester {

    @Test
    public void DataBaseTemplate() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("trailer-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseCredit() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("credit-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseEnterPark() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("qh-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseExhibition() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("exhibition-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseSimpleCrm() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("simple-crm-project.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseIntegrity() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("qing-zhen-Integrity-manager.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Test
    public void DataBaseMidaier() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("midaier-server.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
