package com.code.smither.project.base.constant;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.model.TableColumn;

import java.util.Arrays;

/**
 * Java语言规则实现
 * Created by root on 16-1-28.
 */
public class AutoLang extends AbstractProgramLang {

    private AbstractProgramLang def = new JavaLang();
    private AbstractProgramLang lang = def;

    @Override
    public boolean isKeyword(String value) {
        return lang.isKeyword(value);
    }

    @Override
    public String[] getFileExtensions() {
        return new String[0];
    }

    @Override
    public Class<?> getJavaType(TableColumn column) {
        return lang.getJavaType(column);
    }

    @Override
    public String getType(TableColumn column) {
        return lang.getType(column);
    }

    @Override
    public String getBasicType(TableColumn column) {
        return lang.getBasicType(column);
    }

    @Override
    public String converterClassName(String tableName) {
        return lang.converterClassName(tableName);
    }

    @Override
    public String converterFieldName(String columnName) {
        return lang.converterFieldName(columnName);
    }

    @Override
    public void bindFileExtension(String fileExtension) {
        lang = def;
        for (Lang value : Lang.values()) {
            if (Arrays.asList(value.lang.getFileExtensions()).contains(fileExtension)) {
                lang = value.lang;
                return;
            }
        }
    }

    @Override
    public void bindConfig(ProjectConfig config) {
        def = Lang.getLang(config.getTemplateSecondaryLang());
    }

}
