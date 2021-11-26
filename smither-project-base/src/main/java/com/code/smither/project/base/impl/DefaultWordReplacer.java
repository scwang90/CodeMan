package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordReplacer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class DefaultWordReplacer implements WordReplacer {

    public static class Replace {
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

    private final String dictPath;
    private Map<String, Replace> dictionary;

    public DefaultWordReplacer(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public boolean containsKey(String name) {
        ensureDictionary();
        if (dictionary != null) {
            return dictionary.containsKey(name);
        }
        return false;
    }

    @Override
    public String replace(String str, String...divisions) {
        ensureDictionary();
        String division = (divisions.length > 0) ? divisions[0] : "";
        return replaceInternal(str, dictionary, division, 0);
    }

    private void ensureDictionary() {
        if (dictionary == null && dictPath != null && dictPath.trim().length() > 0) {
            dictionary = loadDictionary(dictPath);
        }
    }

    private String replaceInternal(String str, Map<String, Replace> dictionary, String division, int level) {
        String index = "#$@%&*!^-+=";
        if (dictionary != null && !dictionary.isEmpty()) {
            int i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                Replace replace = dictionary.get(key);
                String old = str;
                if (replace.isRegex) {
                    str = str.replaceAll(key, division + replace.value);
                } else {
                    str = str.replaceAll(key, index.charAt(level) + "{" + i + "}");
                }
                if (old.equals(str) && !replace.fines.isEmpty()) {
                    str = replaceInternal(str, replace.fines, division, level + 1);
                }
            }
            i = 0;
            for (String key : dictionary.keySet()) {
                i++;
                str = str.replaceAll(index.charAt(level) + "\\{" + i + "}", division + dictionary.get(key).value);
            }
        }
        return str;
    }

    public static Map<String, Replace> loadDictionary(String dictPath) {
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
            while ((line = reader.readLine()) != null) {
                String[] split = line.split("-");
                if (split.length == 2) {
                    String key = split[0];
                    if (key.startsWith("regex:")) {
                        key = key.substring(6);
                        keySetRegex.add(key);
                        dictRegex.put(key, new Replace(key, split[1], true));
                    } else {
                        keySet.add(key);
                        dict.put(key, new Replace(key, split[1], false));
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

        Map<String, Replace> dictionary = new LinkedHashMap<>();
        for (String key : keys) {
            dictionary.put(key, dict.get(key));
        }
        List<String> keysRegex = keySetRegex.stream().sorted((l, r) -> Integer.compare(length(r), length(l))).collect(Collectors.toList());
        for (String key : keysRegex) {
            dictionary.put(key, dictRegex.get(key));
        }
        return dictionary;
    }

    private static int length(String key) {
        if (key.startsWith("regex:")) {
            return key.replaceAll("(?<!\\\\)\\\\","").length() - 6;
        }
        return key.length();
    }
}
