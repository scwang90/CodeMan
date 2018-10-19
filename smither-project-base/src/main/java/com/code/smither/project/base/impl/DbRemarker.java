package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.Remarker;

/**
 * 数据库备注
 * Created by SCWANG on 2016/8/1.
 */
public class DbRemarker implements Remarker {
    @Override
    public String getTableRemark(String name) {
        return "" + name;
    }

    @Override
    public String getColumnRemark(String name) {
        return "" + name;
    }
}
