package com.code.smither.project.base.api;

public interface MetaDataTable extends MetaData {

    void setName(String string);

    void setComment(String string);

    void setSchema(String schema);
}
