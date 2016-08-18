package com.codesmither.engine.api;

import java.io.File;

/**
 * 构建TaskLoader的工厂接口
 * Created by SCWANG on 2016/8/18.
 */
public interface ITaskLoaderFactory {
    ITaskLoader build(File templates, File target, IFileFilter filter);
}
