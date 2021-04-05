package com.code.smither.engine;

import com.code.smither.engine.api.Config;
import com.code.smither.engine.api.FieldFiller;
import com.code.smither.engine.api.FileFilter;
import com.code.smither.engine.api.TaskLoader;
import com.code.smither.engine.impl.DefaultEmptyFieldFiller;
import com.code.smither.engine.impl.DefaultFileFilter;
import com.code.smither.engine.impl.DefaultTaskLoader;

/**
 * 配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class EngineConfig implements Config {

    private String now;

    private String targetPath;
    private String templatePath;
    private String templateCharset;
    private String targetCharset;
    private boolean forceOverwrite = false;         //强制覆盖所有文件
    private boolean templateProcessAll = false;     //对所有文件执行模板替换

    private String includeFile = "*.*";
    private String includePath = "*";
    private String filterFile = "*.classes;*.jar;";
    private String filterPath = "bin;build";

    private transient TaskLoader taskLoader;
    private transient FieldFiller fieldFiller;
    private transient FileFilter fileFilter;


    @Override
    public boolean isTemplateProcessAll() {
        return templateProcessAll;
    }

    public void setTemplateProcessAll(boolean templateProcessAll) {
        this.templateProcessAll = templateProcessAll;
    }

    public boolean isForceOverwrite() {
        return forceOverwrite;
    }

    public void setForceOverwrite(boolean forceOverwrite) {
        this.forceOverwrite = forceOverwrite;
    }

    @Override
    public String getNow() {
        return now;
    }

    public void setNow(String now) {
        this.now = now;
    }

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
    public TaskLoader getTaskLoader() {
        return taskLoader;
    }

    public void setTaskLoader(TaskLoader taskLoader) {
        this.taskLoader = taskLoader;
    }

    @Override
    public FieldFiller getFieldFiller() {
        return fieldFiller;
    }

    public void setFieldFiller(FieldFiller fieldFiller) {
        this.fieldFiller = fieldFiller;
    }

    @Override
    public FileFilter getFileFilter() {
        return fileFilter;
    }

    public void setFileFilter(FileFilter fileFilter) {
        this.fileFilter = fileFilter;
    }

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
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
