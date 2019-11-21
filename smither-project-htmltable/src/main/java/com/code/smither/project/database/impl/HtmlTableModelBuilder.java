package com.code.smither.project.database.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.impl.RootModelBuilder;

/**
 *
 * Created by SCWANG on 2016/8/18.
 */
public class HtmlTableModelBuilder extends RootModelBuilder implements ModelBuilder {

    public HtmlTableModelBuilder(ProjectConfig config, TableSource source) {
        super(config, source);
    }

}
