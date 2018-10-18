package com.codesmither.api;

import java.io.File;
import java.util.List;

/**
 * 任务加载（器）
 * Created by SCWANG on 2016/8/18.
 */
public interface TaskLoader {
    /**
     * 分析 模版目录 和 目标目录 根据 文件过滤器 加载任务列表
     * @param templates 模版目录
     * @param target 目标目录
     * @param filter 文件过滤器
     */
    List<ITask> loadTask(File templates, File target, IFileFilter filter);
}
