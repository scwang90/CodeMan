package com.code.smither.project.database.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.impl.RootModelBuilder;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.htmltable.HtmlTableConfig;

/**
 *
 * Created by SCWANG on 2016/8/18.
 */
public class HtmlTableModelBuilder extends RootModelBuilder implements ModelBuilder {

    private final HtmlTableConfig config;

    public HtmlTableModelBuilder(HtmlTableConfig config, TableSource source) {
        super(config, source);
        this.config = config;
    }

    @Override
    public RootModel build() throws Exception {
        SourceModel model = build(new SourceModel(), config, buildTables());
        model.setDbType(Database.Type.fromJdbcUrl(config.getJdbcUrl()).remark);
        model.getJdbc().setUrl(config.getJdbcUrl());
        model.getJdbc().setDriver(config.getJdbcDriver());
        model.getJdbc().setUsername(config.getJdbcUsername());
        model.getJdbc().setPassword(config.getJdbcPassword());
        return model;
    }

}
