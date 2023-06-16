package com.code.smither.project.database.model;

import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.impl.DefaultModelBuilder;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.api.DbFactory;
import com.code.smither.project.database.impl.DbTableSource;

public class DbModelBuilder extends DefaultModelBuilder {

    protected final DbFactory factory;
    protected final Database database;
    protected final DataBaseConfig dbConfig;

    public DbModelBuilder(DataBaseConfig config, DbFactory factory, DbTableSource tableSource) {
        super(config, tableSource);
        this.factory = factory;
        this.dbConfig = config;
        this.database = tableSource.getDatabase();
    }

    @Override
    public RootModel build() throws Exception {
        SourceModel model = build(new DbSourceModel(database.name()), config, buildTables());
        model.getJdbc().setUrl(dbConfig.getDbUrl());
        model.getJdbc().setDriver(dbConfig.getDbDriver());
        model.getJdbc().setUsername(dbConfig.getDbUsername());
        model.getJdbc().setPassword(dbConfig.getDbPassword());
        return model;
    }
}
