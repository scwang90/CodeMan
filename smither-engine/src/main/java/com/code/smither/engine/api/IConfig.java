package com.code.smither.engine.api;

public interface IConfig extends IFilterConfig {

    String getTargetPath();
    String getTemplatePath();
    String getTemplateCharset();
    String getTargetCharset();
    boolean isTemplateFtlOnly();

    ITaskLoader getTaskLoader();
    IFieldFiller getFieldFiller();
    IFileFilter getFileFilter();

    IConfig initEmptyFieldsWithDefaultValues();
}
