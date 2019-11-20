package com.code.smither.project.base.api;

/**
 * 表名过滤器配置信息接口
 * Created by SCWANG on 2016/8/18.
 */
public interface ITableFilterConfig {
    /**
     * 获取要表名过滤的目录配置信息（;分割）
     */
    String getFilterTable();
    /**
     * 获取要包含的表名配置信息（;分割）
     */
    String getIncludeTable();
}
