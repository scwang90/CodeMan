package com.code.smither.project.database;

import com.code.smither.project.base.ProjectEngine;
import com.code.smither.project.database.factory.DbConfigFactory;
import com.code.smither.project.database.model.DbModelBuilder;

import java.util.Properties;

/**
 * 数据库生成代码引擎
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class DataBaseEngine extends ProjectEngine<DataBaseConfig> {

    public DataBaseEngine(DataBaseConfig config) {
        super(config);
    }

    public DataBaseEngine(String configPath) {
        this(DbConfigFactory.loadConfig(configPath));
    }

    public void launch() throws Exception {
        super.launch(new DbModelBuilder(config, config.getDbFactory(), config.getTableSource()));
    }
}
