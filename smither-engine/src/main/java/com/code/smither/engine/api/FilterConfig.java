package com.code.smither.engine.api;

/**
 * 过滤器配置信息接口
 * Created by SCWANG on 2016/8/18.
 */
public interface FilterConfig {
    /**
     * 获取路径根目录（用于Path判断时，向上搜索，时达到root停止搜索）
     */
    String getPathRoot();
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
