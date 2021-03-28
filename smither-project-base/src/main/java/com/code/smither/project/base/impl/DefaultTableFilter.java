package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.TableFilter;
import com.code.smither.project.base.api.TableFilterConfig;


import static com.code.smither.engine.impl.DefaultFileFilter.regexFilter;

/**
 * 默认的表名过滤器
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultTableFilter implements TableFilter {

    private final TableExcludeFilter exclude;
    private final TableIncludeFilter include;

    public DefaultTableFilter(TableFilterConfig config) {
        if (config != null) {
            this.include = new TableIncludeFilter(regexFilter(config.getIncludeTable()));
            this.exclude = new TableExcludeFilter(regexFilter(config.getFilterTable()));
        } else {
            this.include = new TableIncludeFilter(new String[]{".*"});
            this.exclude = new TableExcludeFilter(new String[0]);
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
    public static class TableExcludeFilter implements TableFilter {

        private final String[] regex;

        TableExcludeFilter(String[] regex){
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
    public static class TableIncludeFilter implements TableFilter {

        TableExcludeFilter exclude;

        TableIncludeFilter(String[] regex){
            exclude = new TableExcludeFilter(regex);
        }

        @Override
        public boolean isNeedFilterTable(String tableName) {
            return !exclude.isNeedFilterTable(tableName);
        }
    }
}
