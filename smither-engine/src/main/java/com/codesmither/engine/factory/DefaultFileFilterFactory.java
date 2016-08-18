package com.codesmither.engine.factory;

import com.codesmither.engine.impl.DefaultFileFilter;
import com.codesmither.engine.api.IFileFilter;
import com.codesmither.engine.api.IFileFilterFactory;
import com.codesmither.engine.api.IFilterConfig;

/**
 *
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultFileFilterFactory implements IFileFilterFactory {
    @Override
    public IFileFilter build(IFilterConfig config) {
        return new DefaultFileFilter(config);
    }
}
