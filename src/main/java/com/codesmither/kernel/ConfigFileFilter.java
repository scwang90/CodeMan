package com.codesmither.kernel;

import com.codesmither.kernel.api.Config;
import com.codesmither.task.FileFilter;
import com.codesmither.task.FileFilterExclude;
import com.codesmither.task.FileFilterInclude;

import java.io.File;

/**
 * 配置型文件过滤器
 * Created by root on 16-1-28.
 */
public class ConfigFileFilter implements FileFilter{

    FileFilterExclude exclude;
    FileFilterInclude include;

    public ConfigFileFilter(Config config) {
        String[] filterpaths = regxFilter(config.getTemplateFilterPath());
        String[] filterfiles = regxFilter(config.getTemplateFilterFile());
        String[] includepaths = regxFilter(config.getTemplateIncludePath());
        String[] includefiles = regxFilter(config.getTemplateIncludeFile());
        this.include = new FileFilterInclude(includefiles, includepaths);
        this.exclude = new FileFilterExclude(filterfiles, filterpaths);
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
