package com.codesmither.task;

import java.io.File;

/**
 * 文件包含实现
 * Created by SCWANG on 2015-07-04.
 */
public class FileFilterInclude implements FileFilter{

    private String[] fileRegexs = {".*"};
    private String[] pathRegexs = {".*"};

    public FileFilterInclude(String[] fileRegexs,String[] pathRegexs){
        this.fileRegexs = fileRegexs;
        this.pathRegexs = pathRegexs;
    }

    @Override
    public boolean filterFile(File file) {
        for (String regex : fileRegexs) {
            if (file.getName().matches(regex))
                return true;
        }
        return false;
    }

    @Override
    public boolean filterPath(File file) {
        for (String regex : pathRegexs) {
            if (file.getName().matches(regex))
                return true;
        }
        return false;
    }
}
