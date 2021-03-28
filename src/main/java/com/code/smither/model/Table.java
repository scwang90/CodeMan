package com.code.smither.model;

import com.code.smither.api.IModel;

import java.util.List;

/**
 * 模板Model-table
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Table implements IModel {

    private String name;// 原表名称
    private String nameSql;// SQL语句中使用的名称
    private String nameSqlInStr;// SQL语句中使用的名称(在字符串拼接中使用)
    private String remark;// 字段注释
    private String description;//详细描述 (分析得到)
    private String comment;//原始备注（remark+description）
    private String remarkName;//备注名称（与remark的区别时不已'表'结尾）

    private String urlPathName;// 对应的 url 路劲名称

    private String className;// 原类名称 (首字母大写)
    private String classNameCamel;// 骆驼峰类名 （首字母小写）
    private String classNameUpper;// 类名全大写
    private String classNameLower;// 类名全小写

    private TableColumn idColumn; // ID列
    private TableColumn createColumn;//创建日志列
    private TableColumn updateColumn;//更新日志列
    private TableColumn passwordColumn;//更新日志列

    private List<TableColumn> columns;// 表字段
    private List<String> descriptions;// 多行详细描述

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        this.nameSql = name;
        this.nameSqlInStr = name;
    }

//    public void setName(String name, Database database) {
//        this.name = name;
//        this.nameSql = name;
//        if (database != null && database.isKeyword(name)) {
//            this.nameSql = database.wrapperKeyword(name);
//            this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
//        }
//    }

    public String getNameSql() {
        return nameSql;
    }

    public void setNameSql(String nameSql) {
        this.nameSql = nameSql;
    }

    public String getNameSqlInStr() {
        return nameSqlInStr;
    }

    public void setNameSqlInStr(String nameSqlInStr) {
        this.nameSqlInStr = nameSqlInStr;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(List<String> descriptions) {
        this.descriptions = descriptions;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getRemarkName() {
        return remarkName;
    }

    public void setRemarkName(String remarkName) {
        this.remarkName = remarkName;
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

    public TableColumn getUpdateColumn() {
        return updateColumn;
    }

    public void setUpdateColumn(TableColumn updateColumn) {
        this.updateColumn = updateColumn;
    }

    public TableColumn getCreateColumn() {
        return createColumn;
    }

    public void setCreateColumn(TableColumn createColumn) {
        this.createColumn = createColumn;
    }

    public TableColumn getPasswordColumn() {
        return passwordColumn;
    }

    public void setPasswordColumn(TableColumn passwordColumn) {
        this.passwordColumn = passwordColumn;
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
