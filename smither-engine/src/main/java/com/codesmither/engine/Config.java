package com.codesmither.engine;

import com.codesmither.engine.api.IFileFilterFactory;
import com.codesmither.engine.api.TaskLoader;
import com.codesmither.engine.factory.DefaultFileFilterFactory;
import com.codesmither.engine.impl.DefaultTaskLoader;

/**
 * 配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Config {

    protected String targetPath;
    protected String templatePath;
    protected String templateCharset;
    protected String targetCharset;

    protected transient TaskLoader taskLoader;
    protected transient IFileFilterFactory fileFilterFactory;

    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    public String getTemplateCharset() {
        return templateCharset;
    }

    public void setTemplateCharset(String templateCharset) {
        this.templateCharset = templateCharset;
    }

    public String getTargetCharset() {
        return targetCharset;
    }

    public void setTargetCharset(String targetCharset) {
        this.targetCharset = targetCharset;
    }

    public TaskLoader getTaskLoader() {
        return taskLoader;
    }

    public void setTaskLoader(TaskLoader taskLoader) {
        this.taskLoader = taskLoader;
    }

    public IFileFilterFactory getFileFilterFactory() {
        return fileFilterFactory;
    }

    public void setFileFilterFactory(IFileFilterFactory fileFilterFactory) {
        this.fileFilterFactory = fileFilterFactory;
    }

    public Config initEmptyFieldsWithDefaultValues() {
        if (taskLoader == null) {
            taskLoader = new DefaultTaskLoader();
        }
        if (fileFilterFactory == null) {
            fileFilterFactory = new DefaultFileFilterFactory();
        }
        return this;
    }
}
