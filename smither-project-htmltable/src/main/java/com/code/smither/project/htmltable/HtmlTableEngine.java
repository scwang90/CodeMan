package com.code.smither.project.htmltable;

import com.code.smither.project.base.ProjectEngine;
import com.code.smither.project.database.impl.HtmlTableModelBuilder;

/**
 * Html表格 生成代码引擎
 * Created by SCWANG on 2016/8/19.
 */
public class HtmlTableEngine extends ProjectEngine<HtmlTableConfig> {

    public HtmlTableEngine(HtmlTableConfig config) {
        super(config);
    }

    public void launch() throws Exception {
        launch(new HtmlTableModelBuilder(config, config.getTableSource()));
    }
}
