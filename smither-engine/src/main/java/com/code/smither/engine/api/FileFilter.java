package com.code.smither.engine.api;

import java.io.File;

/**
 * 文件过滤器
 * Created by SCWANG on 2016/8/18.
 */
public interface FileFilter {
    /**
     * 是否需要排除文件file
     * @return true 忽略文件 false 保留文件
     */
    boolean isNeedFilterFile(File file);

    /**
     * 是否需要排除目录path
     * @return true 忽略文件 false 保留文件
     */
    boolean isNeedFilterPath(File path);
}
