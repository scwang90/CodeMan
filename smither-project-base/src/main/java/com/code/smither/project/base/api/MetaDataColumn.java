package com.code.smither.project.base.api;

public interface MetaDataColumn extends MetaData {

    void setName(String string);

    void setType(String string);

    void setTypeInt(int int1);

    void setLength(int int1);

    void setDefValue(String string);

    void setNullable(boolean boolean1);

    void setComment(String string);

    void setDecimalDigits(int int1);

    void setAutoIncrement(boolean b);

}
