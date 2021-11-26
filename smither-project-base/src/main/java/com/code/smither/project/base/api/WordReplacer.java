package com.code.smither.project.base.api;

public interface WordReplacer {
    boolean containsKey(String name);
    String replace(String str, String...divisions);
}
