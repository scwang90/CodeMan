package com.codesmither.task;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * 任务加载器
 * Created by SCWANG on 2015-07-04.
 */
public class TaskLoader {

    private String forgin;
    private String target;
    private FileFilter fileFilter;

    public TaskLoader(File forgin, File target, FileFilter fileFilter) {
        // TODO Auto-generated constructor stub
        this.fileFilter = fileFilter;
        this.forgin = forgin.getAbsolutePath();
        this.target = target.getAbsolutePath();
    }

    public List<Task> loadTask() {
        List<Task> tasks = new ArrayList<>();
        File src = new File(forgin);
        if (src.isFile()) {
            if (fileFilter.filterFile(src)) {
                tasks.add(new Task(src, forgin, target));
            }
            return tasks;
        }
        return loadTask(src, tasks);
    }

    protected List<Task> loadTask(File path, List<Task> tasks) {
        for (File file : path.listFiles()) {
            if (file.isFile()) {
                if (fileFilter.filterFile(file)) {
                    tasks.add(new Task(file, forgin, target));
                }
            } else if (file.isDirectory() && fileFilter.filterPath(file)) {
                loadTask(file, tasks);
            }
        }
        return tasks;
    }
}
