package com.code.smither.project.base.model;

import com.code.smither.engine.api.Model;
import com.code.smither.project.base.api.ClassConverter;
import com.code.smither.project.base.api.LangRootModel;
import com.code.smither.project.base.util.StringUtil;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 模板根 Model
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class SourceModel implements LangRootModel {

    private Table table;
    private Table loginTable;            //用户登录表
    private List<Table> tables;
    private DatabaseJdbc jdbc;
    private String className;
    private String tableName;
    private String author;
    private String packageName;
    private String packagePath;
    private String projectName;
    private String charset;
    private String dbType;
    private String lang;                //程序设计语言
    private Date now = new Date();
    private boolean hasLogin;           //是否有登录功能

    public SourceModel() {
    }

    public SourceModel(String author, String packageName) {
        super();
        this.author = author;
        this.packageName = packageName;
    }

    public SourceModel(Table table) {
        this.table = table;
        this.className = table.getClassName();
    }

    public void setUpNow(String now) {
        if (now != null && now.length() > 0) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                this.now = dateFormat.parse(now);
            } catch (ParseException e) {
                dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    this.now = dateFormat.parse(now);
                } catch (ParseException ex) {
                    ex.printStackTrace();
                    this.now = new Date();
                }
            }
        } else {
            this.now = new Date();
        }
    }

    public Date getNow() {
        return now;
    }

    public void setNow(Date now) {
        this.now = now;
    }

    public List<Table> getTables() {
        return tables;
    }

    public void setTables(List<Table> tables) {
        this.tables = tables;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public Table getTable() {
        return table;
    }

    public void setTable(Table table) {
        this.table = table;
    }

    public Table getLoginTable() {
        return loginTable;
    }

    public void setLoginTable(Table loginTable) {
        this.loginTable = loginTable;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
        this.packagePath = packageName.replace(".", File.separatorChar + "");
//        this.packagePath = packagePath.replace("::", File.separatorChar + "");
    }

    public String getPackagePath() {
        return packagePath;
    }

    public void setPackagePath(String packagePath) {
        this.packagePath = packagePath;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getCharset() {
        return charset;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    public DatabaseJdbc getJdbc() {
        return jdbc;
    }

    public void setJdbc(DatabaseJdbc jdbc) {
        this.jdbc = jdbc;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public boolean isHasLogin() {
        return loginTable != null;
    }

    public void setHasLogin(boolean hasLogin) {
        this.hasLogin = hasLogin;
    }

    //<editor-fold desc="接口实现">
    @Override
    public List<? extends Model> getModels() {
        return tables;
    }

    @Override
    public void bindModel(Model model) {
        if (model instanceof Table) {
            this.table = (Table) model;
            this.tableName = ((Table) model).getName();
            this.className = ((Table) model).getClassName();
        }
    }

    @Override
    public void bindClassConverter(ClassConverter converter) {
        if (tables != null) {
            for (Table table : tables) {
                table.setClassName(converter.converterClassName(table.getName()));
                table.setClassNameUpper(table.getClassName().toUpperCase());
                table.setClassNameLower(table.getClassName().toLowerCase());
                table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));
                if (table.getColumns() != null) {
                    for (TableColumn column : table.getColumns()) {
                        column.setFieldType(converter.converterFieldType(column));
                        column.setFieldName(converter.converterFieldName(column.getName()));
                        column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
                        column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
                    }
                }
            }
        }
    }

    //</editor-fold>
}
