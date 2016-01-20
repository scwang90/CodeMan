package com.codesmither.task;

import java.io.File;

/**
 * 文件过滤接口
 * Created by SCWANG on 2015-07-04.
 */
public interface FileFilter {

    boolean filterFile(File file);

    boolean filterPath(File file);
}
