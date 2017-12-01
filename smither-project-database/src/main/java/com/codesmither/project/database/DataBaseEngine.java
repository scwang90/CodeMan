package com.codesmither.project.database;

import com.codesmither.project.base.ProjectEngine;
import com.codesmither.project.database.model.DbModelBuilder;

/**
 * 数据库生成代码引擎
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class DataBaseEngine extends ProjectEngine {

    private final DataBaseConfig config;

    public DataBaseEngine(DataBaseConfig config) {
        super(config);
        this.config = config;
    }

    public void launch() throws Exception {
        super.launch(new DbModelBuilder(config, config.getDbFactory(), config.getTableSource()));
    }
}
