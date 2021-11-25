package com.generator.replace;

import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.impl.DefaultWordBreaker;
import com.code.smither.project.base.impl.DefaultWordReplacer;
import com.code.smither.project.database.DataBaseConfig;

import java.util.Map;

public class ReplaceConfig extends DataBaseConfig {

    protected String replaceTableIgnore = "";
    protected String replaceTableRemark = "";
    protected String replaceTableDisplace = "";

    private Map<String, String> dictIgnore;
    private Map<String, DefaultWordReplacer.Replace> dictRemark;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (dictIgnore == null) {
            dictIgnore = DefaultWordBreaker.loadDictionary(replaceTableIgnore);
        }
        if (dictRemark == null) {
            dictRemark = DefaultWordReplacer.loadDictionary(replaceTableRemark);
        }
        return this;
    }

    public String getReplaceTableIgnore() {
        return replaceTableIgnore;
    }

    public void setReplaceTableIgnore(String replaceTableIgnore) {
        this.replaceTableIgnore = replaceTableIgnore;
    }

    public String getReplaceTableRemark() {
        return replaceTableRemark;
    }

    public void setReplaceTableRemark(String replaceTableRemark) {
        this.replaceTableRemark = replaceTableRemark;
    }

    public String getReplaceTableDisplace() {
        return replaceTableDisplace;
    }

    public void setReplaceTableDisplace(String replaceTableDisplace) {
        this.replaceTableDisplace = replaceTableDisplace;
    }

    public Map<String, String> getDictIgnore() {
        return dictIgnore;
    }

    public void setDictIgnore(Map<String, String> dictIgnore) {
        this.dictIgnore = dictIgnore;
    }

    public Map<String, DefaultWordReplacer.Replace> getDictRemark() {
        return dictRemark;
    }

    public void setDictRemark(Map<String, DefaultWordReplacer.Replace> dictRemark) {
        this.dictRemark = dictRemark;
    }
}
