package com.code.smither.project.replace.kernel;

import com.code.smither.engine.EngineConfig;

public class ReplaceConfig extends EngineConfig {

    protected String replaceDictPath = "";

    protected transient Replacer replacer;

    public String getReplaceDictPath() {
        return replaceDictPath;
    }

    public void setReplaceDictPath(String replaceDictPath) {
        this.replaceDictPath = replaceDictPath;
    }

    public Replacer getReplacer() {
        return replacer;
    }

    public void setReplacer(Replacer replacer) {
        this.replacer = replacer;
    }

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (replacer == null) {
            replacer = new Replacer(replaceDictPath);
        }
        return this;
    }
}
