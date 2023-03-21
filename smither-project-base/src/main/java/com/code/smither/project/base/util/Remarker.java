package com.code.smither.project.base.util;

import com.code.smither.project.base.model.EnumValue;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 备注解析器
 *
 * @author SCWANG
 * @since 2022/11/15
 */
public class Remarker {


    private static Pattern enumPattern = Pattern.compile("(\\d+)[ :：]?(\\S+?)\\b");

    private static Pattern enumMapPattern = Pattern.compile("(\\w+)[ :：]?(\\S+?)\\b");
    // 单行 description 优化
    private static Pattern[] descriptionPatterns = new Pattern[] {
            Pattern.compile("^\\s*[(（]([^)）]+)[)）]\\s*$"),
            Pattern.compile("^(?::\\r?\\n|：\\r?\\n|\\s+|:|：|,|，|\\r?\\n)(.+)$")
    };
    //多行 description 优化
    private static Pattern[] descriptionsPatterns = new Pattern[]{
            Pattern.compile("((^|\\s)(\\d+)[.、](.+?)(?=\\s\\d+[.、]|$))"),
            Pattern.compile("[(（]([^)）]+)[)）]"),
    };


    public static List<String> findDescriptions(String description) {
        List<String> list = Arrays.asList(description.split("\r?\n"));
        if (list.size() == 1) {
            //多行匹配
            for (Pattern descriptionPattern : descriptionsPatterns) {
                List<String> matchs = new ArrayList<>();
                Matcher matcher = descriptionPattern.matcher(description);
                while (matcher.find()) {
                    matchs.add(matcher.group(1));
                }
                if (matchs.size() > 1 && matchs.stream().anyMatch(m->m.length() > 5)) {
                    return matchs;
                }
            }//（正常：0；已删除：1）同步的数据不可物理删除，如需删除，标志记为1。
            //多行匹配失败开始匹配单行
            for (Pattern descriptionPattern : descriptionPatterns) {
                Matcher matcher = descriptionPattern.matcher(description);
                if (matcher.find()) {
                    return Collections.singletonList(matcher.group(1));
                }
            }
        }
        return list;
    }

    public static List<EnumValue> findEnums(List<String> descriptions) {
        //操作类型(1注册,2登录,3重置密码,4修改手机)
        List<EnumValue> enums = new LinkedList<>();
        for (String desc : descriptions) {
            Matcher matcher = enumPattern.matcher(desc);
            while (matcher.find()) {
                enums.add(new EnumValue(Integer.parseInt(matcher.group(1)), matcher.group(2)));
            }
            if (enums.size() > 1) {
                break;
            } else {
                enums.clear();
            }
        }
        return enums;
    }

    public static Map<String, String> findEnumMap(List<String> descriptions) {
        //操作类型(app:手机应用,applet:小程序)
        Map<String, String> map = new LinkedHashMap<>();
        for (String desc : descriptions) {
            Matcher matcher = enumMapPattern.matcher(desc);
            while (matcher.find()) {
                map.put(matcher.group(1), matcher.group(2));
            }
            if (map.size() > 1) {
                break;
            } else {
                map.clear();
            }
        }
        return map;
    }

}
