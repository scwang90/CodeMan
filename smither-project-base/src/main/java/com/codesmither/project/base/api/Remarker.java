package com.codesmither.project.base.api;

/**
 * 备注器
 * Created by SCWANG on 2016/8/1.
 */
public interface Remarker {
    String getTableRemark(String name);
    String getColumnRemark(String name);
}
