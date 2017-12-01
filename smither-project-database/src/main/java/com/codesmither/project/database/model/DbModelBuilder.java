package com.codesmither.project.database.model;

import com.codesmither.engine.api.IRootModel;
import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.base.constant.Database;
import com.codesmither.project.base.impl.ModelBuilder;
import com.codesmither.project.database.impl.DbTableSource;

public class DbModelBuilder extends ModelBuilder {

    private final Database database;

    public DbModelBuilder(ProjectConfig config, DbFactory factory, DbTableSource tableSource) {
        super(config, factory, tableSource);
        database = tableSource.getDatabase();
    }

    @Override
    public IRootModel build() throws Exception {
        return build(new DbModel(database.name()), config, factory, tableSource.build());
    }
}
