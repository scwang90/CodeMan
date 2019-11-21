package com.code.smither.project.base.api;

/**
 * 表名过滤器
 * Created by SCWANG on 2016/8/18.
 */
public interface TableFilter {
    /**
     * 是否需要排除文件file
     * @return true 忽略文件 false 保留文件
     */
    boolean isNeedFilterTable(String tableName);
}
