package com.code.smither.engine.impl;

import com.code.smither.engine.api.Task;

import java.io.File;

/**
 * 默认的任务实现
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTask implements Task {

    private final File templates;
    private final File target;

    public DefaultTask(File file, File templates, File target) {
        this.templates = checkPath(file);
        this.target = checkPath(new File(file.getAbsolutePath().replace(templates.getAbsolutePath(), target.getAbsolutePath())));
    }

    private File checkPath(File file) {
        String path = file.getAbsolutePath();
        while (path.contains("\\..\\")) {
            path = path.replaceAll("[^\\\\|^.]+\\\\\\.\\.\\\\", "");
        }
        return new File(path);
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
