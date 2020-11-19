package com.code.smither.engine.api;

import java.io.File;

/**
 * 任务构建器
 */
public interface TaskBuilder {
    /**
     * 构建任务
     * @param file 任务
     * @return null 将跳过该文件
     */
    Task build(File file, File templates, File target);
}
