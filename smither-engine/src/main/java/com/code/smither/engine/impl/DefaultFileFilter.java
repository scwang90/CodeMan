package com.code.smither.engine.impl;

import com.code.smither.engine.api.IFileFilter;
import com.code.smither.engine.api.IFilterConfig;

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
            String[] filterPaths = regexFilter(config.getFilterPath());
            String[] filterFiles = regexFilter(config.getFilterFile());
            String[] includePaths = regexFilter(config.getIncludePath());
            String[] includeFiles = regexFilter(config.getIncludeFile());
            this.include = new FileFilterInclude(includeFiles, includePaths);
            this.exclude = new FileFilterExclude(filterFiles, filterPaths);
        } else {
            this.include = new FileFilterInclude(new String[]{".*\\..*"}, new String[]{".*"});
            this.exclude = new FileFilterExclude(new String[0], new String[0]);
        }
    }

    public static String[] regexFilter(String filter) {
        String[] filters = filter.split(";");
        for (int i = 0; i < filters.length; i++) {
            String regex = filters[i];
            if (regex.isEmpty()) {
                regex = ".*";
            } else if (regex.startsWith("regex:")) {
                regex = regex.substring(6);// regex -= "regex:";
            } else {
                regex = regex.replace(".", "\\.");
                regex = regex.replace("*", ".*");
                regex = regex.replace("^", "\\^");
                regex = regex.replace("-", "\\-");
                regex = regex.replace("$", "\\$");
                regex = regex.replace("{", "\\{");
                regex = regex.replace("}", "\\}");
                regex = regex.replace("[", "\\]");
                regex = regex.replace("[", "\\]");
            }
            filters[i] = regex;
        }
        return filters;
    }

    @Override
    public boolean isNeedFilterFile(File file) {
        return include.isNeedFilterFile(file) || exclude.isNeedFilterFile(file);
    }

    @Override
    public boolean isNeedFilterPath(File path) {
        return include.isNeedFilterPath(path) || exclude.isNeedFilterPath(path);
    }
    /**
     * 文件过滤 - 排除
     * Created by SCWANG on 2015-07-04.
     */
    public static class FileFilterExclude implements IFileFilter{

        private String[] fileRegex = {};
        private String[] pathRegex = {};

        public FileFilterExclude(String[] fileRegex, String[] pathRegex){
            this.fileRegex = fileRegex;
            this.pathRegex = pathRegex;
        }

        @Override
        public boolean isNeedFilterFile(File file) {
            for (String regex : fileRegex) {
                if (file.getName().matches(regex))
                    return true;
            }
            return false;
        }

        @Override
        public boolean isNeedFilterPath(File path) {
            for (String regex : pathRegex) {
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
    public static class FileFilterInclude implements IFileFilter {

        FileFilterExclude exclude;

        public FileFilterInclude(String[] fileRegexs,String[] pathRegexs){
            exclude = new FileFilterExclude(fileRegexs,pathRegexs);
        }

        @Override
        public boolean isNeedFilterFile(File file) {
            return !exclude.isNeedFilterFile(file);
        }

        @Override
        public boolean isNeedFilterPath(File path) {
            return !exclude.isNeedFilterPath(path);
        }
    }
}
