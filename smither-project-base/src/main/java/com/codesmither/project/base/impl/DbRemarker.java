package com.codesmither.project.base.impl;

import com.codesmither.project.base.api.Remarker;

/**
 * 数据库备注
 * Created by SCWANG on 2016/8/1.
 */
public class DbRemarker implements Remarker {
    @Override
    public String getTableRemark(String name) {
        return "数据库表" + name;
    }

    @Override
    public String getColumnRemark(String name) {
        return "数据库列" + name;
    }
}
