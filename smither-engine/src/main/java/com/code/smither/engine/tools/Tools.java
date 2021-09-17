package com.code.smither.engine.tools;

public class Tools {

    public String idToModel(String key) {
        if (key == null) {
            return null;
        }
        String low = key.toLowerCase();
        if (low.endsWith("id") && key.length() > 2) {
            return key.replaceAll("_?(id|Id|ID)$", "");
        }
        return key;
    }

    public String toPlural(String name) {
        if (name == null) {
            return null;
        }
        return Inflector.getInstance().pluralize(name);
//        if (name.endsWith("y")) {
//            return name.replaceAll("y$", "ies");
//        }
//        if (name.matches(".+?(ch|sh|s|x|o)$")) {
//            return name + "es";
//        }
//        if (name.matches(".+?e?f$")) {
//            return name.replaceAll("e?f$", "ves");
//        }
//        return name + 's';
    }
}
