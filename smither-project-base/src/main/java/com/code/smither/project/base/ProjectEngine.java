package com.code.smither.project.base;

import com.code.smither.engine.Engine;
import com.code.smither.engine.tools.Tools;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.impl.DefaultModelBuilder;
import com.code.smither.project.base.util.BaseTools;

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

    @Override
    protected Tools getTools() {
        return new BaseTools();
    }
}
