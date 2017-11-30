package com.codesmither.project.base;

import com.codesmither.engine.Config;
import com.codesmither.engine.api.IFilterConfig;
import com.codesmither.project.base.api.ClassConverter;
import com.codesmither.project.base.constant.ProgLang;
import com.codesmither.project.base.impl.ConfigClassConverter;

/**
 * 项目配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class ProjectConfig extends Config implements IFilterConfig {

    protected String tablePrefix = "";
    protected String tableSuffix = "";
    protected String tableDivision = "";

    protected String columnPrefix = "";
    protected String columnSuffix = "";
    protected String columnDivision = "";

    protected String templateLang = ProgLang.Lang.Java.value;
    protected String templatePath = "../templates/dbutil-spring-web";
    protected String templateCharset = "UTF-8";

    protected String templateIncludeFile = "*.*";
    protected String templateIncludePath = "*";
    protected String templateFilterFile = "*.classes;*.jar;";
    protected String templateFilterPath = "bin;build";

    protected String targetPath = "../target/project";
    protected String targetCharset = "UTF-8";
    protected String targetProjectName = "TargetProject";
    protected String targetProjectAuthor = "scwang";
    protected String targetProjectPackage = "com.codesmither.target";

    protected transient ClassConverter classConverter;

    @Override
    public Config initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (classConverter == null) {
            classConverter = new ConfigClassConverter(this);
        }
        return this;
    }

    public void setClassConverter(ClassConverter classConverter) {
        this.classConverter = classConverter;
    }

    public ClassConverter getClassConverter() {
        return classConverter;
    }

    //<editor-fold desc="接口实现">
    @Override
    public String getFilterPath() {
        return templateFilterPath;
    }

    @Override
    public String getFilterFile() {
        return templateFilterFile;
    }

    @Override
    public String getIncludePath() {
        return templateIncludePath;
    }

    @Override
    public String getIncludeFile() {
        return templateIncludeFile;
    }
    //</editor-fold>

    public String getTablePrefix() {
        return tablePrefix;
    }

    public void setTablePrefix(String tablePrefix) {
        this.tablePrefix = tablePrefix;
    }

    public String getTableSuffix() {
        return tableSuffix;
    }

    public void setTableSuffix(String tableSuffix) {
        this.tableSuffix = tableSuffix;
    }

    public String getTableDivision() {
        return tableDivision;
    }

    public void setTableDivision(String tableDivision) {
        this.tableDivision = tableDivision;
    }

    public String getColumnPrefix() {
        return columnPrefix;
    }

    public void setColumnPrefix(String columnPrefix) {
        this.columnPrefix = columnPrefix;
    }

    public String getColumnSuffix() {
        return columnSuffix;
    }

    public void setColumnSuffix(String columnSuffix) {
        this.columnSuffix = columnSuffix;
    }

    public String getColumnDivision() {
        return columnDivision;
    }

    public void setColumnDivision(String columnDivision) {
        this.columnDivision = columnDivision;
    }

    public String getTemplateLang() {
        return templateLang;
    }

    public void setTemplateLang(String templateLang) {
        this.templateLang = templateLang;
    }

    @Override
    public String getTemplatePath() {
        return templatePath;
    }

    @Override
    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    @Override
    public String getTemplateCharset() {
        return templateCharset;
    }

    @Override
    public void setTemplateCharset(String templateCharset) {
        this.templateCharset = templateCharset;
    }

    public String getTemplateIncludeFile() {
        return templateIncludeFile;
    }

    public void setTemplateIncludeFile(String templateIncludeFile) {
        this.templateIncludeFile = templateIncludeFile;
    }

    public String getTemplateIncludePath() {
        return templateIncludePath;
    }

    public void setTemplateIncludePath(String templateIncludePath) {
        this.templateIncludePath = templateIncludePath;
    }

    public String getTemplateFilterFile() {
        return templateFilterFile;
    }

    public void setTemplateFilterFile(String templateFilterFile) {
        this.templateFilterFile = templateFilterFile;
    }

    public String getTemplateFilterPath() {
        return templateFilterPath;
    }

    public void setTemplateFilterPath(String templateFilterPath) {
        this.templateFilterPath = templateFilterPath;
    }

    @Override
    public String getTargetPath() {
        return targetPath;
    }

    @Override
    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    @Override
    public String getTargetCharset() {
        return targetCharset;
    }

    @Override
    public void setTargetCharset(String targetCharset) {
        this.targetCharset = targetCharset;
    }

    public String getTargetProjectName() {
        return targetProjectName;
    }

    public void setTargetProjectName(String targetProjectName) {
        this.targetProjectName = targetProjectName;
    }

    public String getTargetProjectAuthor() {
        return targetProjectAuthor;
    }

    public void setTargetProjectAuthor(String targetProjectAuthor) {
        this.targetProjectAuthor = targetProjectAuthor;
    }

    public String getTargetProjectPackage() {
        return targetProjectPackage;
    }

    public void setTargetProjectPackage(String targetProjectPackage) {
        this.targetProjectPackage = targetProjectPackage;
    }
}
