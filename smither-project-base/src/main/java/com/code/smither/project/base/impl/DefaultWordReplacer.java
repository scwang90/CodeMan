package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordReplacer;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class DefaultWordReplacer implements WordReplacer {

    private String dictPath;
    private Map<String,String> dictionary;

    public DefaultWordReplacer(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public String replace(String str, String...divisions) {
        if (dictionary == null && dictPath != null && dictPath.trim().length() > 0) {
            loadDictionary(divisions);
        }
        if (dictionary != null && !dictionary.isEmpty()) {
            int i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                if (key.startsWith("regex:")) {
                    str = str.replaceAll(key.substring(6), dictionary.get(key));
                } else {
                    str = str.replaceAll(key, "#{" + i + "}");
                }
            }
            i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                str = str.replace("#{" + i + "}", dictionary.get(key));
            }
        }
        return str;
    }

    protected void loadDictionary(String[] divisions) {
        File file = new File(dictPath);
        if (!file.exists()) {
            throw new RuntimeException("找不到文件：" + dictPath);
        }
        Set<String> keySet = new LinkedHashSet<>();
        Map<String,String> dict = new LinkedHashMap<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))){
            String line;
            while ((line = reader.readLine()) != null) {
                String[] split = line.split("-");
                if (split.length == 2) {
                    keySet.add(split[0]);
                    if (divisions.length > 0) {
                        dict.put(split[0], divisions[0] + split[1]);
                    } else {
                        dict.put(split[0], split[1]);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String> keys = keySet.stream().sorted((l, r) -> {

            return Integer.compare(length(r), length(l));
        }).collect(Collectors.toList());
        this.dictionary = new LinkedHashMap<>();
        for (String key : keys) {
            this.dictionary.put(key, dict.get(key));
        }
    }

    private int length(String key) {
        if (key.startsWith("regex:")) {
            return key.replaceAll("(?<!\\\\)\\\\","").length() - 6;
        }
        return key.length();
    }
}
