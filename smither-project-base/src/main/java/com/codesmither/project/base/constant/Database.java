package com.codesmither.project.base.constant;

public interface Database {

    String name();
    boolean isKeyword(String value);
    String wrapperKeyword(String name);

}
