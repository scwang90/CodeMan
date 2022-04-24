package com.generator.replace;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.DbConfigFactory;
import com.generator.replace.*;
import org.junit.Test;

public class ReplaceEngineTester {

    private final static boolean IS_FILTER_CHINESE_CLOUMN = false;

    @Test
    public void dataHis() throws Exception {
        DataBaseConfig config = DbConfigFactory.loadConfig("wd-his-data.properties");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch();
    }

    @Test
    public void replaceDatabaseHis() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("wd-his-replace.properties");
        config.setFilterFile("*.txt.ftl");
        ReplaceEngine engine = new ReplaceEngine(config);
        engine.launch(new ReplaceBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

    @Test
    public void replaceDatabaseEmr() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("wd-emr-replace.properties");
        config.setFilterFile("*.txt.ftl");
        ReplaceEngine engine = new ReplaceEngine(config);
        engine.launch(new ReplaceBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

    @Test
    public void replaceDictionaryHis() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-his-data.properties");
        config.setFilterFile("*.html.ftl;*.sql.ftl;*.json.ftl");
        config.setTargetPath("../templates-datasource/dict-wd-his");
        DataBaseEngine engine = new DataBaseEngine(config);
        engine.launch(new ReplaceDictionaryBuilder(config, IS_FILTER_CHINESE_CLOUMN));
    }

}
