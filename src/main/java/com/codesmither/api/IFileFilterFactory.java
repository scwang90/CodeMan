package com.codesmither.api;

/**
 * 文件过滤器构建工厂接口
 * Created by SCWANG on 2016/8/18.
 */
public interface IFileFilterFactory {
    /**
     * 根据配置信息构建过滤器对象
     * @param filterConfig 配置信息接口
     */
    IFileFilter build(IFilterConfig filterConfig);
}
