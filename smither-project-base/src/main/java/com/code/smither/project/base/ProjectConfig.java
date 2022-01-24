package com.code.smither.project.base;

import com.code.smither.engine.EngineConfig;
import com.code.smither.engine.api.FilterConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.impl.ConfigClassConverter;
import com.code.smither.project.base.impl.DefaultTableFilter;
import com.code.smither.project.base.impl.DefaultWordBreaker;
import com.code.smither.project.base.impl.DefaultWordReplacer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 项目配置信息
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings({"unused", "WeakerAccess"})
@Data
@EqualsAndHashCode(callSuper = true)
public class ProjectConfig extends EngineConfig implements FilterConfig, TableFilterConfig {

    protected String tablePrefix = "t_";
    protected String tableSuffix = "";
    protected String tableDivision = "_";
    protected String tableOrgan = "company,organ,hospital,school";        //机构表
    protected String tableLogin = "login,user,admin,account,*user";       //登录表
    protected String tableNoCascade = "*log,log*,*msg,*message,*order,*file";  //不级联查询的表

    protected String columnPrefix = "";
    protected String columnSuffix = "";
    protected String columnDivision = "_";
    protected String columnOrg = "company_id,org_id";
    protected String columnCode = "code,no";
    protected String columnName = "name,*name,title,*title";
    protected String columnCreate = "create_time,create_date,create_at,created_at";
    protected String columnUpdate = "update_time,update_date,update_at,updated_at";
    protected String columnGender = "sex,gender";
    protected String columnRemove = "remove,removed,delete,deleted";
    protected String columnCreator = "creator_id,author_id";
    protected String columnPassword = "password,pwd";
    protected String columnUsername = "account,username,phone*,name";
    protected String columnSearch = "*name,*type,*topic,title,remark,content,*code,account,username,phone*";
    protected String columnHideForTables = "*avatar,*headUrl,content,description,address,update_time,update_date,update_at,updated_at,create_time,create_date,create_at,created_at";
    protected String columnHideForClient = "";
    protected String columnHideForSubmit = "";
    protected String columnForceUseLong = "*time";

    protected String templateLang = ProgramLang.Lang.Auto.value;
    protected String templatePath = "../templates/web-spring-boot-mybatis";
    protected String templateCharset = "UTF-8";

    protected String filterTable = "";
    protected String includeTable = "*";

    protected String targetFeatures = "";
    protected String targetPath = "../target/project";
    protected String targetCharset = "UTF-8";
    protected String targetProjectName = "TargetProject";
    protected String targetProjectRemark = "";
    protected String targetProjectDetail = "";
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

//    public void setClassConverter(ClassConverter classConverter) {
//        this.classConverter = classConverter;
//    }
//
//    public ClassConverter getClassConverter() {
//        return classConverter;
//    }
//
//    public void setTableFilter(TableFilter tableFilter) {
//        this.tableFilter = tableFilter;
//    }
//
//    public TableFilter getTableFilter() {
//        return tableFilter;
//    }
//
//    public void setWordBreaker(WordBreaker wordBreaker) {
//        this.wordBreaker = wordBreaker;
//    }
//
//    public WordBreaker getWordBreaker() {
//        return wordBreaker;
//    }
//
//    public void setWordReplacer(WordReplacer wordReplacer) {
//        this.wordReplacer = wordReplacer;
//    }
//
//    public WordReplacer getWordReplacer() {
//        return wordReplacer;
//    }

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

//    public String getTablePrefix() {
//        return tablePrefix;
//    }
//
//    public void setTablePrefix(String tablePrefix) {
//        this.tablePrefix = tablePrefix;
//    }
//
//    public String getTableSuffix() {
//        return tableSuffix;
//    }
//
//    public void setTableSuffix(String tableSuffix) {
//        this.tableSuffix = tableSuffix;
//    }
//
//    public String getTableDivision() {
//        return tableDivision;
//    }
//
//    public void setTableDivision(String tableDivision) {
//        this.tableDivision = tableDivision;
//    }
//
//    public String getTableOrgan() {
//        return tableOrgan;
//    }
//
//    public void setTableOrgan(String tableOrgan) {
//        this.tableOrgan = tableOrgan;
//    }
//
//    public String getTableLogin() {
//        return tableLogin;
//    }
//
//    public void setTableLogin(String tableLogin) {
//        this.tableLogin = tableLogin;
//    }
//
//    public String getColumnPrefix() {
//        return columnPrefix;
//    }
//
//    public void setColumnPrefix(String columnPrefix) {
//        this.columnPrefix = columnPrefix;
//    }
//
//    public String getColumnSuffix() {
//        return columnSuffix;
//    }
//
//    public void setColumnSuffix(String columnSuffix) {
//        this.columnSuffix = columnSuffix;
//    }
//
//    public String getColumnDivision() {
//        return columnDivision;
//    }
//
//    public void setColumnDivision(String columnDivision) {
//        this.columnDivision = columnDivision;
//    }
//
//    public String getColumnCreate() {
//        return columnCreate;
//    }
//
//    public void setColumnCreate(String columnCreate) {
//        this.columnCreate = columnCreate;
//    }
//
//    public String getColumnUpdate() {
//        return columnUpdate;
//    }
//
//    public void setColumnUpdate(String columnUpdate) {
//        this.columnUpdate = columnUpdate;
//    }
//
//    public String getColumnRemove() {
//        return columnRemove;
//    }
//
//    public void setColumnGender(String columnGender) {
//        this.columnGender = columnGender;
//    }
//
//    public String getColumnGender() {
//        return columnGender;
//    }
//
//    public void setColumnRemove(String columnRemove) {
//        this.columnRemove = columnRemove;
//    }
//
//    public String getColumnCreator() {
//        return columnCreator;
//    }
//
//    public void setColumnCreator(String columnCreator) {
//        this.columnCreator = columnCreator;
//    }
//
//    public String getColumnOrg() {
//        return columnOrg;
//    }
//
//    public void setColumnOrg(String columnOrg) {
//        this.columnOrg = columnOrg;
//    }
//
//    public String getColumnCode() {
//        return columnCode;
//    }
//
//    public void setColumnCode(String columnCode) {
//        this.columnCode = columnCode;
//    }
//
//    public String getColumnPassword() {
//        return columnPassword;
//    }
//
//    public void setColumnPassword(String columnPassword) {
//        this.columnPassword = columnPassword;
//    }
//
//    public String getColumnUsername() {
//        return columnUsername;
//    }
//
//    public void setColumnUsername(String columnUsername) {
//        this.columnUsername = columnUsername;
//    }
//
//    public String getColumnHideForClient() {
//        return columnHideForClient;
//    }
//
//    public void setColumnHideForClient(String columnHideForClient) {
//        this.columnHideForClient = columnHideForClient;
//    }
//
//    public String getColumnHideForSubmit() {
//        return columnHideForSubmit;
//    }
//
//    public void setColumnHideForSubmit(String columnHideForSubmit) {
//        this.columnHideForSubmit = columnHideForSubmit;
//    }
//
    public String getTemplateLang() {
        int index = templateLang.indexOf(',');
        if (index > 0) {
            return templateLang.substring(0, index);
        }
        return templateLang;
    }

    public String getTemplateSecondaryLang() {
        int index = templateLang.indexOf(',');
        if (index > 0) {
            return templateLang.substring(index + 1);
        }
        return templateLang;
    }
//
//    public void setTemplateLang(String templateLang) {
//        this.templateLang = templateLang;
//    }
//
//    @Override
//    public String getTemplatePath() {
//        return templatePath;
//    }
//
//    @Override
//    public void setTemplatePath(String templatePath) {
//        this.templatePath = templatePath;
//    }
//
//    @Override
//    public String getTemplateCharset() {
//        return templateCharset;
//    }
//
//    @Override
//    public void setTemplateCharset(String templateCharset) {
//        this.templateCharset = templateCharset;
//    }
//
//    @Override
//    public String getTargetPath() {
//        return targetPath;
//    }
//
//    @Override
//    public void setTargetPath(String targetPath) {
//        this.targetPath = targetPath;
//    }
//
//    @Override
//    public String getTargetCharset() {
//        return targetCharset;
//    }
//
//    @Override
//    public void setTargetCharset(String targetCharset) {
//        this.targetCharset = targetCharset;
//    }
//
//    public String getTargetProjectName() {
//        return targetProjectName;
//    }
//
//    public void setTargetProjectName(String targetProjectName) {
//        this.targetProjectName = targetProjectName;
//    }
//
//    public String getTargetProjectAuthor() {
//        return targetProjectAuthor;
//    }
//
//    public void setTargetProjectAuthor(String targetProjectAuthor) {
//        this.targetProjectAuthor = targetProjectAuthor;
//    }
//
//    public String getTargetProjectPackage() {
//        return targetProjectPackage;
//    }
//
//    public void setTargetProjectPackage(String targetProjectPackage) {
//        this.targetProjectPackage = targetProjectPackage;
//    }
//
//    public String getWordBreakDictPath() {
//        return wordBreakDictPath;
//    }

    public void setWordBreakDictPath(String wordBreakDictPath) {
        this.wordBreakDictPath = wordBreakDictPath.replaceAll(";?&#x","\\u");
    }

//    public String getWordReplaceDictPath() {
//        return wordReplaceDictPath;
//    }
//
//    public void setWordReplaceDictPath(String wordReplaceDictPath) {
//        this.wordReplaceDictPath = wordReplaceDictPath;
//    }

}
