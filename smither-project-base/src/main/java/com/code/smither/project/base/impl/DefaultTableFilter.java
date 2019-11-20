package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.ITableFilter;
import com.code.smither.project.base.api.ITableFilterConfig;


import static com.code.smither.engine.impl.DefaultFileFilter.regexFilter;

/**
 * 默认的表名过滤器
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTableFilter implements ITableFilter {

    TableFilterExclude exclude;
    TableFilterInclude include;

    public DefaultTableFilter(ITableFilterConfig config) {
        if (config != null) {
            this.include = new TableFilterInclude(regexFilter(config.getIncludeTable()));
            this.exclude = new TableFilterExclude(regexFilter(config.getFilterTable()));
        } else {
            this.include = new TableFilterInclude(new String[]{".*"});
            this.exclude = new TableFilterExclude(new String[0]);
        }
    }

    @Override
    public boolean isNeedFilterTable(String tableName) {
        return include.isNeedFilterTable(tableName) || exclude.isNeedFilterTable(tableName);
    }

    /**
     * 表名过滤 - 排除
     * Created by SCWANG on 2015-07-04.
     */
    public static class TableFilterExclude implements ITableFilter {

        private String[] regex;

        public TableFilterExclude(String[] regex){
            this.regex = regex;
        }

        @Override
        public boolean isNeedFilterTable(String tableName) {
            for (String regex : regex) {
                if (tableName.matches(regex))
                    return true;
            }
            return tableName == null || tableName.trim().length() == 0;
        }

    }
    /**
     * 表名过滤 - 包含
     * Created by SCWANG on 2015-07-04.
     */
    public static class TableFilterInclude implements ITableFilter {

        TableFilterExclude exclude;

        public TableFilterInclude(String[] regex){
            exclude = new TableFilterExclude(regex);
        }

        @Override
        public boolean isNeedFilterTable(String tableName) {
            return !exclude.isNeedFilterTable(tableName);
        }
    }
}
