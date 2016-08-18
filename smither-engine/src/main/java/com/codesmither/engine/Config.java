package com.codesmither.engine;

import com.codesmither.engine.api.IFileFilterFactory;
import com.codesmither.engine.api.ITaskLoaderFactory;
import com.codesmither.engine.factory.DefaultFileFilterFactory;
import com.codesmither.engine.factory.DefaultTaskLoaderFactory;

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
    protected ITaskLoaderFactory taskLoaderFactory;
    protected IFileFilterFactory fileFilterFactory;

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

    public ITaskLoaderFactory getTaskLoaderFactory() {
        return taskLoaderFactory;
    }

    public void setTaskLoaderFactory(ITaskLoaderFactory taskLoaderFactory) {
        this.taskLoaderFactory = taskLoaderFactory;
    }

    public IFileFilterFactory getFileFilterFactory() {
        return fileFilterFactory;
    }

    public void setFileFilterFactory(IFileFilterFactory fileFilterFactory) {
        this.fileFilterFactory = fileFilterFactory;
    }

    public Config initEmptyFieldsWithDefaultValues() {
        if (taskLoaderFactory == null) {
            taskLoaderFactory = new DefaultTaskLoaderFactory();
        }
        if (fileFilterFactory == null) {
            fileFilterFactory = new DefaultFileFilterFactory();
        }
        return this;
    }
}
