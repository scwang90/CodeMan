package com.code.smither.engine.tools;

import java.util.Arrays;
import java.util.stream.Stream;

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
}
