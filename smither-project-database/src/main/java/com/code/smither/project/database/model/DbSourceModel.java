package com.code.smither.project.database.model;

import com.code.smither.project.base.model.SourceModel;

public class DbSourceModel extends SourceModel {

    public DbSourceModel(String type) {
        setDbType(type);
    }

}
