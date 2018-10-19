package com.code.smither.project.database.model;

import com.code.smither.engine.api.IRootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.DbFactory;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.impl.ModelBuilder;
import com.code.smither.project.database.impl.DbTableSource;

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
