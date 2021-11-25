package com.generator.replace;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.project.base.ProjectEngine;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.DataBaseEngine;

public class ReplaceEngine extends ProjectEngine<ReplaceConfig> {

    public ReplaceEngine(ReplaceConfig config) {
        super(config);
    }

    public void launch(boolean isFilterChineseCloumn) throws Exception {
        super.launch(new ReplaceBuilder(config, isFilterChineseCloumn));
    }
}
