package com.code.smither.project.base;

import com.code.smither.engine.Engine;
import com.code.smither.project.base.api.DbFactory;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.impl.ModelBuilder;

/**
 * 项目代码生成引擎
 * Created by SCWANG on 2016/8/18.
 */
public class ProjectEngine extends Engine {

    private final ProjectConfig config;

    public ProjectEngine(ProjectConfig config) {
        super(config);
        this.config = config;
    }

    public void launch(DbFactory factory, TableSource tableSource) throws Exception {
        launch(new ModelBuilder(config,factory,tableSource));
    }
}
