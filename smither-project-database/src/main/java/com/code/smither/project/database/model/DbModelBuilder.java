package com.code.smither.project.database.model;

import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.impl.RootModelBuilder;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.database.api.DbFactory;
import com.code.smither.project.database.impl.DbTableSource;

public class DbModelBuilder extends RootModelBuilder {

    protected final DbFactory factory;
    protected final Database database;

    public DbModelBuilder(ProjectConfig config, DbFactory factory, DbTableSource tableSource) {
        super(config, tableSource);
        this.factory = factory;
        this.database = tableSource.getDatabase();
    }

    @Override
    public RootModel build() throws Exception {
        SourceModel model = build(new DbSourceModel(database.name()), config, buildTables());
        model.getJdbc().setUrl(factory.getJdbcUrl());
        model.getJdbc().setDriver(factory.getDriverClass());
        model.getJdbc().setUsername(factory.getUser());
        model.getJdbc().setPassword(factory.getPassword());
        return model;
    }
}
