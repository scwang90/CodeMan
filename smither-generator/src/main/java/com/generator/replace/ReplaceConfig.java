package com.generator.replace;

import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.api.WordReplacer;
import com.code.smither.project.base.impl.DefaultWordBreaker;
import com.code.smither.project.base.impl.DefaultWordReplacer;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.factory.TableSourceFactory;
import lombok.Data;

import java.util.Collections;
import java.util.Map;

@Data
public class ReplaceConfig extends DataBaseConfig {

    protected String replaceTableIgnore = "";
    protected String replaceTableRemark = "";
    protected String replaceTableName = "";
    protected String replaceColumnName = "";

    private Map<String, String> dictTableIgnore;

    private WordReplacer replacerTableRemark;
    private WordReplacer replacerTableName;
    private WordReplacer replacerColumnName;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (dictTableIgnore == null) {
            if (StringUtil.isNullOrBlank(replaceTableIgnore)) {
                dictTableIgnore = Collections.emptyMap();
            } else {
                dictTableIgnore = DefaultWordBreaker.loadDictionary(replaceTableIgnore);
            }
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
            tableSource = new ReplaceTableSource(this, TableSourceFactory.getDataSource(this, getDbFactory()));
        }
        return this;
    }

}
