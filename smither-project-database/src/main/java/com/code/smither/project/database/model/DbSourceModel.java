package com.code.smither.project.database.model;

import com.code.smither.project.base.model.SourceModel;

public class DbSourceModel extends SourceModel {

    private String dbType;

    public DbSourceModel(String name) {
        dbType = name;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }
}
