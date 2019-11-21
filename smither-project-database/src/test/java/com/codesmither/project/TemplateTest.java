package com.code.smither.project;

import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;
import com.code.smither.project.database.factory.DbConfigFactory;
import org.junit.Test;

/**
 * TemplateTest
 * Created by Administrator on 2015/9/16.
 */
public class TemplateTest {

    @Test
    public void DataBaseTemplate() {
        try {
            DataBaseConfig config = DbConfigFactory.loadConfig("config.properties");
            DataBaseEngine engine = new DataBaseEngine(config);
            engine.launch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
