package com.codesmither.project;

import com.codesmither.project.base.ProjectEngine;
import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.base.api.TableSource;
import com.codesmither.project.database.DbProjectConfig;
import com.codesmither.project.database.factory.C3P0Factory;
import com.codesmither.project.database.factory.ConfigFactory;
import com.codesmither.project.database.factory.TableSourceFactory;
import org.junit.Test;

/**
 * TempleteTest
 * Created by Administrator on 2015/9/16.
 */
public class TempleteTest {

    @Test
    public void DataBaseTemplete() {
        try {
            DbProjectConfig config = ConfigFactory.loadConfig("config.properties");
            ProjectEngine engine = new ProjectEngine(config);

            DbFactory factory = C3P0Factory.getInstance(config.getDbConfigName());
            TableSource tableSource = TableSourceFactory.getInstance(config, factory);

            engine.launch(factory,tableSource);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
