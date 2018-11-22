package com.code.smither.model;

import com.code.smither.api.IModel;
import com.code.smither.api.TaskLoader;

import java.util.List;

/**
 * 模板Model-table
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Table implements IModel {

    private String name;// 原表名称
    private String nameSQL;// SQL语句中使用的名称
    private String remark;// 字段注释

    private String urlPathName;// 对应的 url 路劲名称

    private String className;// 原类名称
    private String classNameCamel;// 骆驼峰类名
    private String classNameUpper;// 类名全大写
    private String classNameLower;// 类名全小写

    private TableColumn idColumn; // ID列

    private List<TableColumn> columns;// 表字段

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setName(String name, TaskLoader.Database database) {
        this.name = name;
        this.nameSQL = name;
        if (database != null && database.isKeyword(name)) {
            this.nameSQL = database.wrapperKeyword(name);
        }
    }

    public String getNameSQL() {
        return nameSQL;
    }

    public void setNameSQL(String nameSQL) {
        this.nameSQL = nameSQL;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassNameCamel() {
        return classNameCamel;
    }

    public void setClassNameCamel(String classNameCamel) {
        this.classNameCamel = classNameCamel;
    }

    public String getClassNameUpper() {
        return classNameUpper;
    }

    public void setClassNameUpper(String classNameUpper) {
        this.classNameUpper = classNameUpper;
    }

    public String getClassNameLower() {
        return classNameLower;
    }

    public void setClassNameLower(String classNameLower) {
        this.classNameLower = classNameLower;
    }

    public TableColumn getIdColumn() {
        return idColumn;
    }

    public void setIdColumn(TableColumn idColumn) {
        this.idColumn = idColumn;
    }

    public List<TableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<TableColumn> columns) {
        this.columns = columns;
    }

    public String getUrlPathName() {
        return urlPathName;
    }

    public void setUrlPathName(String urlPathName) {
        this.urlPathName = urlPathName;
    }
}
