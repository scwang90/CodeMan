package com.codesmither.project.htmltable;

import com.codesmither.project.base.ProjectEngine;
import com.codesmither.project.database.impl.HtmlTableModelBuilder;

/**
 * Html表格 生成代码引擎
 * Created by SCWANG on 2016/8/19.
 */
public class HtmlTableEngine extends ProjectEngine {

    private final HtmlTableConfig config;

    public HtmlTableEngine(HtmlTableConfig config) {
        super(config);
        this.config = config;
    }

    public void launch() throws Exception {
        launch(new HtmlTableModelBuilder(config, config.getTableSource()));
    }
}
