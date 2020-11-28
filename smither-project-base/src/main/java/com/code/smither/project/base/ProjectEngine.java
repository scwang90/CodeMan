package com.code.smither.project.base;

import com.code.smither.engine.Engine;
import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.impl.DefaultModelBuilder;

import java.util.Properties;

/**
 * 项目代码生成引擎
 * Created by SCWANG on 2016/8/18.
 */
public class ProjectEngine<T extends ProjectConfig> extends Engine<T> {

    public ProjectEngine(T config) {
        super(config);
    }

    public void launch(TableSource tableSource) throws Exception {
        launch(new DefaultModelBuilder(config,tableSource));
    }
}
