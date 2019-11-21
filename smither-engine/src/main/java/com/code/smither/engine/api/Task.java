package com.code.smither.engine.api;

import java.io.File;

/**
 * 引擎的单位任务
 * 拆分多个任务方便计算进度,一个文件的生成算一个任务
 * 任务是指定用【模版文件】生成【目标文件】
 * Created by SCWANG on 2016/8/18.
 */
public interface Task {
    /**
     * 获取模版文件
     */
    File getTemplateFile();

    /**
     * 获取目标文件
     */
    File getTargetFile();
}
