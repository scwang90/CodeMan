package com.generator.replace;

import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.api.WordReplacer;
import com.code.smither.project.base.impl.DefaultWordBreaker;
import com.code.smither.project.base.impl.DefaultWordReplacer;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.factory.TableSourceFactory;

import java.util.Map;

public class ReplaceConfig extends DataBaseConfig {

    protected String replaceTableIgnore = "";
    protected String replaceTableRemark = "";
    protected String replaceTableName = "";
    protected String replaceColumnName = "";

    private Map<String, String> dictTableIgnore;
    private Map<String, DefaultWordReplacer.Replace> dictTableName;
    private Map<String, DefaultWordReplacer.Replace> dictTableRemark;
    private Map<String, DefaultWordReplacer.Replace> dictColumnName;


    private WordReplacer replacerTableRemark;
    private WordReplacer replacerTableName;
    private WordReplacer replacerColumnName;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (dictColumnName == null) {
            dictColumnName = DefaultWordReplacer.loadDictionary(replaceColumnName);
        }
        if (dictTableName == null) {
            dictTableName = DefaultWordReplacer.loadDictionary(replaceTableName);
        }
        if (dictTableRemark == null) {
            dictTableRemark = DefaultWordReplacer.loadDictionary(replaceTableRemark);
        }
        if (dictTableIgnore == null) {
            dictTableIgnore = DefaultWordBreaker.loadDictionary(replaceTableIgnore);
        }
        if (replacerColumnName == null) {
            replacerColumnName = new DefaultWordReplacer(replaceColumnName);
        }
        if (replacerTableName == null) {
            replacerTableName = new DefaultWordReplacer(replaceTableName);
        }
        if (replacerTableRemark == null) {
            replacerTableRemark = new DefaultWordReplacer(replaceTableRemark);
        }
        if (!(tableSource instanceof ReplaceTableSource)) {
            tableSource = new ReplaceTableSource(this, TableSourceFactory.getDataSource(getDbFactory()));
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

    public String getReplaceTableName() {
        return replaceTableName;
    }

    public void setReplaceTableName(String replaceTableName) {
        this.replaceTableName = replaceTableName;
    }

    public String getReplaceColumnName() {
        return replaceColumnName;
    }

    public void setReplaceColumnName(String replaceColumnName) {
        this.replaceColumnName = replaceColumnName;
    }

    public Map<String, String> getDictTableIgnore() {
        return dictTableIgnore;
    }

    public void setDictTableIgnore(Map<String, String> dictTableIgnore) {
        this.dictTableIgnore = dictTableIgnore;
    }

    public Map<String, DefaultWordReplacer.Replace> getDictTableRemark() {
        return dictTableRemark;
    }

    public void setDictTableRemark(Map<String, DefaultWordReplacer.Replace> dictTableRemark) {
        this.dictTableRemark = dictTableRemark;
    }

    public Map<String, DefaultWordReplacer.Replace> getDictTableName() {
        return dictTableName;
    }

    public void setDictTableName(Map<String, DefaultWordReplacer.Replace> dictTableName) {
        this.dictTableName = dictTableName;
    }

    public Map<String, DefaultWordReplacer.Replace> getDictColumnName() {
        return dictColumnName;
    }

    public void setDictColumnName(Map<String, DefaultWordReplacer.Replace> dictColumnName) {
        this.dictColumnName = dictColumnName;
    }

    public WordReplacer getReplacerColumnName() {
        return replacerColumnName;
    }

    public WordReplacer getReplacerTableName() {
        return replacerTableName;
    }

    public WordReplacer getReplacerTableRemark() {
        return replacerTableRemark;
    }
}
