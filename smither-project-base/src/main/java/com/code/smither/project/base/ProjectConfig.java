package com.code.smither.project.base;

import com.code.smither.engine.EngineConfig;
import com.code.smither.engine.api.FilterConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.impl.ConfigClassConverter;
import com.code.smither.project.base.impl.DefaultTableFilter;
import com.code.smither.project.base.impl.DefaultWordBreaker;
import com.code.smither.project.base.impl.DefaultWordReplacer;

/**
 * 项目配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings({"unused", "WeakerAccess"})
public class ProjectConfig extends EngineConfig implements FilterConfig, TableFilterConfig {

    protected String tablePrefix = "";
    protected String tableSuffix = "";
    protected String tableDivision = "";
    protected String tableLogin = "";           //登陆表

    protected String columnPrefix = "";
    protected String columnSuffix = "";
    protected String columnDivision = "";
    protected String columnCreate = "create_time,create_date";
    protected String columnUpdate = "update_time,update_date";
    protected String columnPassword = "password,pwd";

    protected String templateLang = ProgramLang.Lang.Java.value;
    protected String templatePath = "../templates/web-spring-boot-mybatis";
    protected String templateCharset = "UTF-8";

    protected String filterTable = "";
    protected String includeTable = "*";

    protected String targetPath = "../target/project";
    protected String targetCharset = "UTF-8";
    protected String targetProjectName = "TargetProject";
    protected String targetProjectAuthor = "unset";
    protected String targetProjectPackage = "com.code.smither.target";

    protected String wordBreakDictPath = "";
    protected String wordReplaceDictPath = "";

    protected transient TableFilter tableFilter;
    protected transient WordBreaker wordBreaker;
    protected transient WordReplacer wordReplacer;
    protected transient ClassConverter classConverter;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (tableFilter == null) {
            tableFilter = new DefaultTableFilter(this);
        }
        if (wordBreaker == null) {
            wordBreaker = new DefaultWordBreaker(wordBreakDictPath);
        }
        if (wordReplacer == null) {
            wordReplacer = new DefaultWordReplacer(wordReplaceDictPath);
        }
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

    public void setTableFilter(TableFilter tableFilter) {
        this.tableFilter = tableFilter;
    }

    public TableFilter getTableFilter() {
        return tableFilter;
    }

    public void setWordBreaker(WordBreaker wordBreaker) {
        this.wordBreaker = wordBreaker;
    }

    public WordBreaker getWordBreaker() {
        return wordBreaker;
    }

    public void setWordReplacer(WordReplacer wordReplacer) {
        this.wordReplacer = wordReplacer;
    }

    public WordReplacer getWordReplacer() {
        return wordReplacer;
    }

    //<editor-fold desc="接口实现">

    @Override
    public String getFilterTable() {
        return filterTable;
    }

    @Override
    public String getIncludeTable() {
        return includeTable;
    }

    public void setIncludeTable(String includeTable) {
        this.includeTable = includeTable;
    }

    public void setFilterTable(String filterTable) {
        this.filterTable = filterTable;
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

    public String getTableLogin() {
        return tableLogin;
    }

    public void setTableLogin(String tableLogin) {
        this.tableLogin = tableLogin;
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

    public String getColumnCreate() {
        return columnCreate;
    }

    public void setColumnCreate(String columnCreate) {
        this.columnCreate = columnCreate;
    }

    public String getColumnUpdate() {
        return columnUpdate;
    }

    public void setColumnUpdate(String columnUpdate) {
        this.columnUpdate = columnUpdate;
    }

    public String getColumnPassword() {
        return columnPassword;
    }

    public void setColumnPassword(String columnPassword) {
        this.columnPassword = columnPassword;
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

    public String getWordBreakDictPath() {
        return wordBreakDictPath;
    }

    public void setWordBreakDictPath(String wordBreakDictPath) {
        this.wordBreakDictPath = wordBreakDictPath.replaceAll(";?&#x","\\u");
    }

    public String getWordReplaceDictPath() {
        return wordReplaceDictPath;
    }

    public void setWordReplaceDictPath(String wordReplaceDictPath) {
        this.wordReplaceDictPath = wordReplaceDictPath;
    }

}
