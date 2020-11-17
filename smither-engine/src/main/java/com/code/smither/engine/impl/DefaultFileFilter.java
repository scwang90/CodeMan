package com.code.smither.engine.impl;

import com.code.smither.engine.api.FileFilter;
import com.code.smither.engine.api.FilterConfig;

import java.io.File;

/**
 * 默认的文件过滤器
 * Created by SCWANG on 2016/8/18.
 */
public class DefaultFileFilter implements FileFilter {

    FileExcludeFilter exclude;
    FileIncludeFilter include;

    public DefaultFileFilter(FilterConfig config) {
        if (config != null) {
            String[] filterPaths = regexFilter(config.getFilterPath());
            String[] filterFiles = regexFilter(config.getFilterFile());
            String[] includePaths = regexFilter(config.getIncludePath());
            String[] includeFiles = regexFilter(config.getIncludeFile());
            this.include = new FileIncludeFilter(includeFiles, includePaths);
            this.exclude = new FileExcludeFilter(filterFiles, filterPaths);
        } else {
            this.include = new FileIncludeFilter(new String[]{".*\\..*"}, new String[]{".*"});
            this.exclude = new FileExcludeFilter(new String[0], new String[0]);
        }
    }

    public static String[] regexFilter(String filter) {
        String[] filters = filter.split(";");
        for (int i = 0; i < filters.length; i++) {
            String regex = filters[i];
            if (regex.isEmpty()) {
                regex = "";//".*";
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
    public static class FileExcludeFilter implements FileFilter {

        private String[] fileRegex = {};
        private String[] pathRegex = {};

        FileExcludeFilter(String[] fileRegex, String[] pathRegex){
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
    public static class FileIncludeFilter implements FileFilter {

        FileExcludeFilter exclude;

        FileIncludeFilter(String[] fileRegexs, String[] pathRegexs){
            exclude = new FileExcludeFilter(fileRegexs,pathRegexs);
        }

        @Override
        public boolean isNeedFilterFile(File file) {
            return !exclude.isNeedFilterFile(file);
        }

        @Override
        public boolean isNeedFilterPath(File path) {
            System.out.println("include:"+path.getName());
            return !exclude.isNeedFilterPath(path);
        }
    }
}
