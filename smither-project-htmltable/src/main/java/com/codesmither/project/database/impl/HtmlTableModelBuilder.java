package com.codesmither.project.database.impl;

import com.codesmither.engine.api.IModelBuilder;
import com.codesmither.engine.api.IRootModel;
import com.codesmither.project.base.model.DatabaseJdbc;
import com.codesmither.project.base.model.Model;
import com.codesmither.project.database.HtmlTableConfig;

/**
 *
 * Created by SCWANG on 2016/8/18.
 */
public class HtmlTableModelBuilder implements IModelBuilder {

    private final HtmlTableConfig config;
    private final HtmlTableSource source;

    public HtmlTableModelBuilder(HtmlTableConfig config, HtmlTableSource source) {
        this.config = config;
        this.source = source;
    }

    @Override
    public IRootModel build() throws Exception {
        return build(config,source);
    }

    private Model build(HtmlTableConfig config, HtmlTableSource source) throws Exception {
        Model model = new Model();
        model.setAuthor(config.getTargetProjectAuthor());
        model.setCharset(config.getTargetCharset());
        model.setPackageName(config.getTargetProjectPackage());
        model.setProjectName(config.getTargetProjectName());
        model.setJdbc(new DatabaseJdbc());
        model.getJdbc().setUrl("");
        model.getJdbc().setDriver("");
        model.getJdbc().setUsename("");
        model.getJdbc().setPassword("");
        model.setTables(source.build());
        return model;
    }
}
