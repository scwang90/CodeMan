package com.code.smither.project.base.impl;

import com.code.smither.project.base.api.WordBreaker;
import com.code.smither.project.base.util.WordFilter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class DefaultWordBreaker implements WordBreaker {

    private String dictPath;
//    private WordFilter wordFilter;
    private Map<String,String> dictionary;

    public DefaultWordBreaker(String dictPath) {
        this.dictPath = dictPath;
    }

    @Override
    public String breaks(String str, String division) {
        if (dictionary == null && dictPath != null && dictPath.trim().length() > 0) {
            loadDictionary();
        }
        if (dictionary != null && !dictionary.isEmpty()) {
            int i = 0;
            for (String key : dictionary.keySet()) {
                if (key.startsWith("regex:")) {
                    str = str.replaceAll(key.substring(6), "#{" + (++i) + "}");
                } else {
                    str = str.replaceAll(key, "#{" + (++i) + "}");
                }
            }
            i = 0;
            for (String key : dictionary.keySet()) {
                str = str.replace("#{" + (++i) + "}", division + dictionary.get(key) + division);
            }
            str = str.replace(division + division, division);
        }
        return str;
    }

    private void loadDictionary() {
        File file = new File(dictPath);
        Set<String> keySet = new LinkedHashSet<>();
        Map<String,String> dict = new LinkedHashMap<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))){
            for (String line; (line = reader.readLine()) != null; ) {
                line = line.trim();
                String[] split = line.split("-");
                if (split.length == 2) {
                    keySet.add(split[0]);
                    dict.put(split[0], split[1]);
                } else if (line.length() > 0) {
                    keySet.add(line);
                    dict.put(line, line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String> keys = keySet.stream().sorted((l, r) -> Integer.compare(r.length(), l.length())).collect(Collectors.toList());
        this.dictionary = new LinkedHashMap<>();
        for (String key : keys) {
            this.dictionary.put(key, dict.get(key));
        }
    }

}
