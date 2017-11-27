package com.codesmither.project;

import com.codesmither.project.database.DataBaseConfig;
import com.codesmither.project.database.DataBaseEngine;
import com.codesmither.project.htmltable.factory.ConfigFactory;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

/**
 * TempleteTest
 * Created by Administrator on 2015/9/16.
 */
public class TempleteTest {

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
