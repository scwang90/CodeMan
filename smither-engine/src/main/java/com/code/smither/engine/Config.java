package com.code.smither.engine;

import com.code.smither.engine.api.IConfig;
import com.code.smither.engine.api.IFieldFiller;
import com.code.smither.engine.api.IFileFilter;
import com.code.smither.engine.api.ITaskLoader;
import com.code.smither.engine.impl.DefaultEmptyFieldFiller;
import com.code.smither.engine.impl.DefaultFileFilter;
import com.code.smither.engine.impl.DefaultTaskLoader;

/**
 * 配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Config implements IConfig {

    private String targetPath;
    private String templatePath;
    private String templateCharset;
    private String targetCharset;

    private String includeFile = "*.*";
    private String includePath = "*";
    private String filterFile = "*.classes;*.jar;";
    private String filterPath = "bin;build";

    private transient ITaskLoader taskLoader;
    private transient IFieldFiller fieldFiller;
    private transient IFileFilter fileFilter;

    @Override
    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    @Override
    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    @Override
    public String getTemplateCharset() {
        return templateCharset;
    }

    public void setTemplateCharset(String templateCharset) {
        this.templateCharset = templateCharset;
    }

    @Override
    public String getTargetCharset() {
        return targetCharset;
    }

    public void setTargetCharset(String targetCharset) {
        this.targetCharset = targetCharset;
    }

    @Override
    public String getFilterFile() {
        return filterFile;
    }

    public void setFilterFile(String filterFile) {
        this.filterFile = filterFile;
    }

    @Override
    public String getFilterPath() {
        return filterPath;
    }

    public void setFilterPath(String filterPath) {
        this.filterPath = filterPath;
    }

    @Override
    public String getIncludeFile() {
        return includeFile;
    }

    public void setIncludeFile(String includeFile) {
        this.includeFile = includeFile;
    }

    @Override
    public String getIncludePath() {
        return includePath;
    }

    public void setIncludePath(String includePath) {
        this.includePath = includePath;
    }

    @Override
    public ITaskLoader getTaskLoader() {
        return taskLoader;
    }

    public void setTaskLoader(ITaskLoader taskLoader) {
        this.taskLoader = taskLoader;
    }

    @Override
    public IFieldFiller getFieldFiller() {
        return fieldFiller;
    }

    public void setFieldFiller(IFieldFiller fieldFiller) {
        this.fieldFiller = fieldFiller;
    }

    @Override
    public IFileFilter getFileFilter() {
        return null;
    }

    public void setFileFilter(IFileFilter fileFilter) {
        this.fileFilter = fileFilter;
    }

    @Override
    public Config initEmptyFieldsWithDefaultValues() {
        if (taskLoader == null) {
            taskLoader = new DefaultTaskLoader();
        }
        if (fileFilter == null) {
            fileFilter = new DefaultFileFilter(this);
        }
        if (fieldFiller == null) {
            fieldFiller = new DefaultEmptyFieldFiller();
        }
        return this;
    }
}
