package com.code.smither.engine.tools;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 自定义Model工具类
 *
 * @author 树朾
 * @since 2022-02-02
 */
public class CustomModel {

    public static void load(Map<String, Object> model, Properties properties, String keyCustom) {
        for (Map.Entry<Object, Object> entry : properties.entrySet()) {
            if (entry.getKey().toString().startsWith(keyCustom + '.')) {
                String key = entry.getKey().toString().substring(keyCustom.length() + 1);
                int index = key.indexOf('.');
                if (index <= 0) {
                    model.put(key, entry.getValue().toString());
                } else {
                    String name = key.substring(0, index);
                    Object value = model.get(name);
                    Map<?, ?> map;
                    if (value instanceof Map) {
                        map = (Map<?, ?>)value;
                    } else {
                        map = new LinkedHashMap<>();
                        model.put(name, map);
                    }
                    //noinspection unchecked
                    load((Map<String, Object>) map, properties, keyCustom + '.' + name);
                }
            }
        }
    }
}
