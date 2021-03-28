package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordReplacer;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class DefaultWordReplacer implements WordReplacer {

    private static class Replace {
        public final String key;
        public final String value;
        public final boolean isRegex;
        public Map<String, Replace> fines = new LinkedHashMap<>();

        private Replace(String key, String value, boolean isRegex) {
            this.key = key;
            this.value = value;
            this.isRegex = isRegex;
        }
    }

    private String dictPath;
    private Map<String, Replace> dictionary;

    public DefaultWordReplacer(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public String replace(String str, String...divisions) {
        if (dictionary == null && dictPath != null && dictPath.trim().length() > 0) {
            loadDictionary(divisions);
        }
        return replaceInternal(str, dictionary, 0);
    }

    private String replaceInternal(String str, Map<String, Replace> dictionary, int level) {
        String index = "#$@%&*!^-+=";
        if (dictionary != null && !dictionary.isEmpty()) {
            int i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                Replace replace = dictionary.get(key);
                String old = str;
                if (replace.isRegex) {
                    str = str.replaceAll(key, replace.value);
                } else {
                    str = str.replaceAll(key, index.charAt(level) + "{" + i + "}");
                }
                if (old.equals(str) && !replace.fines.isEmpty()) {
                    str = replaceInternal(str, replace.fines, level + 1);
                }
//                if (key.startsWith("regex:")) {
//                    str = str.replaceAll(key.substring(6), dictionary.get(key));
//                } else {
//                    str = str.replaceAll(key, "#{" + i + "}");
//                }
            }
            i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                str = str.replace(index.charAt(level) + "{" + i + "}", dictionary.get(key).value);
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
        Set<String> keySetRegex = new LinkedHashSet<>();
        Map<String, Replace> dict = new LinkedHashMap<>();
        Map<String, Replace> dictRegex = new LinkedHashMap<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))){
            String line;
            String division = (divisions.length > 0) ? divisions[0] : "";
            while ((line = reader.readLine()) != null) {
                String[] split = line.split("-");
                if (split.length == 2) {
                    String key = split[0];
                    if (key.startsWith("regex:")) {
                        key = key.substring(6);
                        keySetRegex.add(key);
                        dictRegex.put(key, new Replace(key, division + split[1], true));
                    } else {
                        keySet.add(key);
                        dict.put(key, new Replace(key, division + split[1], false));
                    }
                } else if (split.length == 1 && line.endsWith("-")) {
                    String key = split[0];
                    if (key.startsWith("regex:")) {
                        key = key.substring(6);
                        keySetRegex.add(key);
                        dictRegex.put(key, new Replace(key, "", true));
                    } else {
                        keySet.add(key);
                        dict.put(key, new Replace(key, "", false));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String> keys = keySet.stream().sorted((l, r) -> Integer.compare(length(r), length(l))).collect(Collectors.toList());

        this.dictionary = new LinkedHashMap<>();
        for (String key : keys) {
            this.dictionary.put(key, dict.get(key));
        }
        List<String> keysRegex = keySetRegex.stream().sorted((l, r) -> Integer.compare(length(r), length(l))).collect(Collectors.toList());
        for (String key : keysRegex) {
            this.dictionary.put(key, dictRegex.get(key));
        }
    }

    private int length(String key) {
        if (key.startsWith("regex:")) {
            return key.replaceAll("(?<!\\\\)\\\\","").length() - 6;
        }
        return key.length();
    }
}
