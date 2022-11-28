package com.code.smither.engine.impl;

import com.code.smither.engine.api.FileFilter;
import com.code.smither.engine.api.Task;
import com.code.smither.engine.api.TaskBuilder;
import com.code.smither.engine.api.TaskLoader;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * 默认的任务加载实现
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTaskLoader implements TaskLoader {

    @Override
    public List<Task> loadTask(File templates, File target, FileFilter filter, TaskBuilder builder) {
        List<Task> tasks = new ArrayList<>();
        if (templates.isFile()) {
//            throw new RuntimeException("模板必须是目录！" + templates.getAbsolutePath());
            if ((filter == null || !filter.isNeedFilterFile(templates))) {
                Task task = builder.build(templates, templates.getParentFile(), target);
                if (task != null) {
                    tasks.add(task);
                }
            }
            return tasks;
        }
        return loadTask(templates, target, filter, templates, tasks, builder);
    }

    protected List<Task> loadTask(File templates, File target, FileFilter filter, File path, List<Task> tasks, TaskBuilder builder) {
//        return loadTask(templates, target, filter, path, tasks, builder, true);
        boolean run = filter == null || !filter.isNeedFilterPath(path) || path == templates;
        File[] files = path.listFiles();
        if (files != null && files.length > 0) {
            for (File file : files) {
                if (file.isFile()) {
                    if (run && (filter == null || !filter.isNeedFilterFile(file))) {
                        Task task = builder.build(file, templates, target);
                        if (task != null) {
                            tasks.add(task);
                        }
                    }
                } else {
                    loadTask(templates, target, filter, file, tasks, builder);
                }
            }
        }
        return tasks;
    }

//    protected List<Task> loadTask(File templates, File target, FileFilter filter, File path, List<Task> tasks, TaskBuilder builder, boolean loadfile) {
//        File[] files = path.listFiles();
//        if (files != null && files.length > 0) {
//            for (File file : files) {
//                if (file.isFile()) {
//                    if (filter == null || !filter.isNeedFilterFile(file)) {
//                        Task task = builder.build(file, templates, target);
//                        if (task != null) {
//                            tasks.add(task);
//                        }
//                    }
//                } else if (file.isDirectory()) {
//                    if (filter == null || !filter.isNeedFilterPath(file)) {
//                        loadTask(templates, target, filter, file, tasks, builder);
//                    } else {
//                        File[] listFiles = file.listFiles();
//                        if (listFiles != null) {
//                            for (File listFile : listFiles) {
//                                if (listFile.isDirectory()) {
//                                    loadTask(templates, target, filter, file, tasks, builder, false);
//                                    break;
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        return tasks;
//    }
}
