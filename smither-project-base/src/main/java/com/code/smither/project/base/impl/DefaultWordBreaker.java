package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordBreaker;
import com.code.smither.project.base.util.WordFilter;

import java.io.File;
import java.util.Set;

public class DefaultWordBreaker implements WordBreaker {

    private String dictPath;
    private WordFilter wordFilter;

    public DefaultWordBreaker(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public String breaks(String str, String division) {
        if (wordFilter == null && dictPath != null && dictPath.trim().length() > 0) {
            File file = new File(dictPath);
            if (!file.exists()) {
                throw new RuntimeException("找不到文件：" + dictPath);
            }
            wordFilter = new WordFilter(new File(dictPath));
        }
        if (wordFilter != null) {
            Set<String> keys = wordFilter.judge(str);
            if (!keys.isEmpty()) {
                for (String key : keys) {
                    str = str.replace(key, division + key + division);
                }
                str = str.replace(division + division, division);
            }
        }
        return str;
    }

}
