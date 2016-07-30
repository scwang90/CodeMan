package com.codesmither.kernel.api;

/**
 * 模板生成配置信息
 * Created by root on 16-1-28.
 */
public abstract class Config {

    protected String dbConfigName;

    protected String tablePrefix = "";
    protected String tableSuffix = "";
    protected String tableDivision = "";

    protected String columnPrefix = "";
    protected String columnSuffix = "";
    protected String columnDivision = "";

    protected String templateLang = ProgLang.Lang.Java.value;
    protected String templatePath = "templates/dbutil-spring-web";
    protected String templateCharset = "UTF-8";

    protected String templateIncludeFile = "*.*";
    protected String templateIncludePath = "*";
    protected String templateFilterFile = "*.classes;*.jar;";
    protected String templateFilterPath = "bin;build";

    protected String targetPath = "target/project";
    protected String targetCharset = "UTF-8";
    protected String targetProjectName = "TargetProject";
    protected String targetProjectAuthor = "scwang";
    protected String targetProjectPackage = "com.codesmither";

//    public abstract Converter getConverter();
    public abstract ProgLang getProgramLanguage();

    public String getDbConfigName() {
        return dbConfigName;
    }

    public void setDbConfigName(String dbConfigName) {
        this.dbConfigName = dbConfigName;
    }

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

    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    public String getTemplateCharset() {
        return templateCharset;
    }

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

    public String getTargetPath() {
        return targetPath;
    }

    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

    public String getTargetCharset() {
        return targetCharset;
    }

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
