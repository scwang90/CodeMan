package com.generator.meteor;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.DbConfigFactory;

import com.generator.poetry.drawable2svg.ReplaceBuilder;
import com.generator.poetry.drawable2svg.ReplaceConfig;
import com.generator.poetry.drawable2svg.ReplaceConfigFactory;
import com.generator.poetry.drawable2svg.ReplaceDictionaryBuilder;
import org.junit.Test;

public class DataBaseEngineTester {

    @Test
    public void DataBaseMedicalPlatform() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("medical-platform.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseTravelerServer() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("traveler-server.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void DataBaseTravelerClient() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("traveler-client.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private final static boolean IS_FILTER_CHINESE_CLOUMN = false;

    @Test
    public void DataBaseHisReplace() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-his.properties");
        config.setFilterFile("*.txt.ftl");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch(new ReplaceBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

    @Test
    public void DataBaseHisDictionary() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-his.properties");
        config.setFilterFile("*.html.ftl;*.sql.ftl;*.json.ftl");
        config.setTargetPath("../templates-datasource/dict-wd-his");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch(new ReplaceDictionaryBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

    @Test
    public void DataBaseEmrReplace() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-emr.properties");
        config.setFilterFile("*.txt.ftl");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch(new ReplaceBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

    @Test
    public void DataBaseEmrDictionary() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-emr.properties");
        config.setFilterFile("*.html.ftl;*.sql.ftl;*.json.ftl");
        config.setTargetPath("../templates-datasource/dict-wd-emr");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch(new ReplaceDictionaryBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }
}
