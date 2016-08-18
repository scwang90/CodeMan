package com.codesmither.engine.factory;

import com.codesmither.engine.impl.DefaultTaskLoader;
import com.codesmither.engine.api.IFileFilter;
import com.codesmither.engine.api.ITaskLoader;
import com.codesmither.engine.api.ITaskLoaderFactory;

import java.io.File;

/**
 * 默认 TaskLoader 工厂
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTaskLoaderFactory implements ITaskLoaderFactory {
    @Override
    public ITaskLoader build(File templates, File target, IFileFilter filter) {
        return new DefaultTaskLoader(templates, target, filter);
    }
}
