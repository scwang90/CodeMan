package com.codesmither.task;

import java.io.File;

/**
 * 任务
 * Created by SCWANG on 2015-07-04.
 */
public class Task {

    File file;
    File target;

    public Task(File file, File target) {
        this.target = target;
        this.file = file;
    }

    public Task(File file, String orgin, String target) {
        this.file = file;
        this.target = new File(file.getAbsolutePath().replace(orgin, target));
    }

    public File getFile() {
        return file;
    }

    public File getTarget() {
        return target;
    }
}
