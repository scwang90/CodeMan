package com.code.smither.engine.impl;

import com.code.smither.engine.EngineConfig;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;

import java.io.File;

/**
 * 默认的任务实现
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTask implements Task {

    private static final String tagForce = "${force}";

    private final File templates;
    private final File target;
    private final boolean forceOverWrite;

//    public DefaultTask(File templates, File target) {
//        this.templates = checkPath(templates);
//        this.target = checkPath(target);
//    }

    public DefaultTask(File file, File templates, File target, EngineConfig config, RootModel root) {
        this.templates = checkPath(file);
        this.target = checkPath(new File(file.getAbsolutePath().replace(templates.getAbsolutePath(), target.getAbsolutePath()).replace(tagForce,"")));
        this.forceOverWrite = this.templates.getAbsolutePath().contains(tagForce) || config.isForceOverwrite() || root.isModelTask(this);
    }

    private File checkPath(File file) {
        String path = file.getAbsolutePath();
        while (path.contains("\\..\\")) {
            path = path.replaceAll("[^\\\\|^.]+\\\\\\.\\.\\\\", "");
        }
        while (path.contains("/../")) {
            path = path.replaceAll("[^/|^.]+/\\.\\./", "");
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

    @Override
    public boolean forceOverWrite() {
        return forceOverWrite;
    }
}
