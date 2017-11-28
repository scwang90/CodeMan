package com.codesmither.engine.impl;

import com.codesmither.engine.api.IFileFilter;
import com.codesmither.engine.api.IFilterConfig;

import java.io.File;

/**
 * 默认的文件过滤器
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultFileFilter implements IFileFilter {

    FileFilterExclude exclude;
    FileFilterInclude include;

    public DefaultFileFilter(IFilterConfig config) {
        if (config != null) {
            String[] filterpaths = regxFilter(config.getFilterPath());
            String[] filterfiles = regxFilter(config.getFilterFile());
            String[] includepaths = regxFilter(config.getIncludePath());
            String[] includefiles = regxFilter(config.getIncludeFile());
            this.include = new FileFilterInclude(includefiles, includepaths);
            this.exclude = new FileFilterExclude(filterfiles, filterpaths);
        } else {
            this.include = new FileFilterInclude(new String[0], new String[0]);
            this.exclude = new FileFilterExclude(new String[0], new String[0]);
        }
    }


    private static String[] regxFilter(String filter) {
        String[] filters = filter.split(";");
        for (int i = 0; i < filters.length; i++) {
            String regx = filters[i];
            if (regx.isEmpty()) {
                regx = ".*";
            } else if (regx.startsWith("regex:")) {
                regx = regx.substring(6);// regx -= "regex:";
            } else {
                regx = regx.replace(".", "\\.");
                regx = regx.replace("*", ".*");
                regx = regx.replace("^", "\\^");
                regx = regx.replace("-", "\\-");
                regx = regx.replace("$", "\\$");
                regx = regx.replace("{", "\\{");
                regx = regx.replace("}", "\\}");
                regx = regx.replace("[", "\\]");
                regx = regx.replace("[", "\\]");
            }
            filters[i] = regx;
        }
        return filters;
    }

    @Override
    public boolean isNeedFilteFile(File file) {
        return include.isNeedFilteFile(file) || exclude.isNeedFilteFile(file);
    }

    @Override
    public boolean isNeedFiltePath(File path) {
        return include.isNeedFiltePath(path) || exclude.isNeedFiltePath(path);
    }
    /**
     * 文件过滤 - 排除
     * Created by SCWANG on 2015-07-04.
     */
    public static class FileFilterExclude implements IFileFilter{

        private String[] fileRegexs = {};
        private String[] pathRegexs = {};

        public FileFilterExclude(String[] fileRegexs,String[] pathRegexs){
            this.fileRegexs = fileRegexs;
            this.pathRegexs = pathRegexs;
        }

        @Override
        public boolean isNeedFilteFile(File file) {
            for (String regex : fileRegexs) {
                if (file.getName().matches(regex))
                    return true;
            }
            return false;
        }

        @Override
        public boolean isNeedFiltePath(File path) {
            for (String regex : pathRegexs) {
                if (path.getName().matches(regex))
                    return true;
            }
            return false;
        }
    }
    /**
     * 文件过滤 - 包含
     * Created by SCWANG on 2015-07-04.
     */
    public static class FileFilterInclude implements IFileFilter{

        FileFilterExclude exclude;

        public FileFilterInclude(String[] fileRegexs,String[] pathRegexs){
            exclude = new FileFilterExclude(fileRegexs,pathRegexs);
        }

        @Override
        public boolean isNeedFilteFile(File file) {
            return !exclude.isNeedFilteFile(file);
        }

        @Override
        public boolean isNeedFiltePath(File path) {
            return !exclude.isNeedFiltePath(path);
        }
    }
}
