package com.codesmither.project.database.model;

import com.codesmither.project.base.model.Model;

public class DbModel extends Model {

    private String dbType;

    public DbModel(String name) {
        dbType = name;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }
}
