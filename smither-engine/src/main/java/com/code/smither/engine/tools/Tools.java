package com.code.smither.engine.tools;

import java.util.Arrays;

public class Tools {

    public boolean or(Boolean... conditions) {
        return Arrays.stream(conditions).anyMatch(c->c);
    }

    public boolean and(Boolean... conditions) {
        return Arrays.stream(conditions).allMatch(c->c);
    }

    /**
     * 根据ID列名转换Model名称（表名）
     */
    public String idToModel(String key) {
        if (key == null) {
            return null;
        }
        String low = key.toLowerCase();
        if (low.endsWith("id") && key.length() > 2) {
            return key.replaceAll("_?(id|Id|ID)$", "");
        }
        else if (low.endsWith("no") && key.length() > 2) {
            return key.replaceAll("_?(no|No|NO)$", "");
        }
        else if (low.endsWith("code") && key.length() > 4) {
            return key.replaceAll("_?(code|Code|CODE)$", "");
        }
        return key + "Model";
    }

    /**
     * 英文单词变复数
     */
    public String toPlural(String name) {
        if (name == null) {
            return null;
        }
        return Inflector.getInstance().pluralize(name);
    }

    /**
     * 模板字符串出现在字符串内部是，特殊支付需要转义
     */
    public String toInStr(String value) {
        if (value == null) {
            return null;
        }
        return value.replace("\"","\\\"")
                .replace("\\","\\\\");
    }

    public int max(int l, int r) {
        return Math.max(l, r);
    }

    public int min(int l, int r) {
        return Math.min(l, r);
    }

}
