package com.codesmither.factory;

import com.codesmither.task.FileFilter;
import com.codesmither.task.FileFilterExclude;
import com.codesmither.task.FileFilterInclude;

import java.io.File;

/**
 * 文件过滤工程
 * Created by SCWANG on 2015-07-04.
 */
public class FilterFactory implements FileFilter {

    FileFilterExclude exclude;
    FileFilterInclude include;

    public static FileFilter getFilter() {
        String[] filterpaths = regxFilter(ConfigFactory.getTemplateFilterPath());
        String[] filterfiles = regxFilter(ConfigFactory.getTemplateFilterFile());
        String[] includepaths = regxFilter(ConfigFactory.getTemplateIncludePath());
        String[] includefiles = regxFilter(ConfigFactory.getTemplateIncludeFile());
        FilterFactory factory = new FilterFactory();
        factory.include = new FileFilterInclude(includefiles, includepaths);
        factory.exclude = new FileFilterExclude(filterfiles, filterpaths);
        return factory;
    }

    private static String[] regxFilter(String filter) {
        String[] filters = filter.split(";");
        for (int i = 0; i < filters.length; i++) {
            String regx = filters[i];
            if (regx.isEmpty()) {
                regx = ".*";
            } else if (regx.startsWith("regex:")) {
//                regx -= "regex:";
                regx.substring(6);
            } else {
                regx = regx.replace(".", "\\.");
                regx = regx.replace("*", ".*");
                regx = regx.replace("$", "\\$");
                regx = regx.replace("{", "\\{");
                regx = regx.replace("}", "\\}");
                regx = regx.replace("[", "\\]");
                regx = regx.replace("[", "\\]");
                regx = regx.replace("^", "\\^");
                regx = regx.replace("-", "\\-");
            }
            filters[i] = regx;
        }
        return filters;
    }

    @Override
    public boolean filterFile(File file) {
        return include.filterFile(file) && exclude.filterFile(file);
    }

    @Override
    public boolean filterPath(File file) {
        return include.filterPath(file) && exclude.filterPath(file);
    }
}
