package com.code.smither.engine.api;

public interface Config extends FilterConfig {

    String getNow();
    String getTargetPath();
    String getTemplatePath();
    String getTemplateCharset();
    String getTargetCharset();

    /**
     * 是否只对 ftl 模板文件进行数据模型匹配
     */
    boolean isTemplateFtlOnly();

    TaskLoader getTaskLoader();
    FieldFiller getFieldFiller();
    FileFilter getFileFilter();

    Config initEmptyFieldsWithDefaultValues();
}
