package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordReplacer;

import java.io.File;
import java.util.LinkedHashMap;
import java.util.Map;

public class DefaultWordReplacer implements WordReplacer {

    private String dictPath;
    private Map<String,String> dictonary;

    public DefaultWordReplacer(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public String replace(String str) {
        if (dictonary == null && dictPath != null && dictPath.trim().length() > 0) {
            File file = new File(dictPath);
            if (!file.exists()) {
                throw new RuntimeException("找不到文件：" + dictPath);
            }
            this.dictonary = new LinkedHashMap<>();

        }
        return null;
    }
}
