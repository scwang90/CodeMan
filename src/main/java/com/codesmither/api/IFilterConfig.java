package com.codesmither.api;

/**
 * 过滤器配置信息接口
 * Created by SCWANG on 2016/8/18.
 */
public interface IFilterConfig {
    /**
     * 获取要过滤的目录配置信息（;分割）
     */
    String getFilterPath();
    /**
     * 获取要过滤的文件配置信息（;分割）
     */
    String getFilterFile();
    /**
     * 获取要包含的目录配置信息（;分割）
     */
    String getIncludePath();
    /**
     * 获取要包含的文件配置信息（;分割）
     */
    String getIncludeFile();
}
