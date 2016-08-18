package com.codesmither.project.database;

import com.codesmither.project.base.ProjectEngine;

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
        super.launch(config.getDbFactory(), config.getTableSource());
    }
}
