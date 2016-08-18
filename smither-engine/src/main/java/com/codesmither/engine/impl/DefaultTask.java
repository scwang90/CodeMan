package com.codesmither.engine.impl;

import com.codesmither.engine.api.ITask;

import java.io.File;

/**
 * 默认的任务实现
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTask implements ITask {

    private final File templates;
    private final File target;

    public DefaultTask(File file, File templates, File target) {
        this.templates = file;
        this.target = new File(file.getAbsolutePath().replace(templates.getAbsolutePath(),target.getAbsolutePath()));
    }

    @Override
    public File getTemplateFile() {
        return templates;
    }

    @Override
    public File getTargetFile() {
        return target;
    }
}
