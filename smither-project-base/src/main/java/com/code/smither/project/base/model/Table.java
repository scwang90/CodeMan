package com.code.smither.project.base.model;

import com.code.smither.engine.api.Model;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.constant.Database;
import lombok.AccessLevel;
import lombok.Data;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 模板Model-table
 * Created by SCWANG on 2016/8/18.
 */
@Data
@ToString(exclude = {"exportedTables","exportedKeys","importedKeys"})
@SuppressWarnings("unused")
public class Table implements Model, MetaDataTable {

    private String name;// 原表名称
    private String nameSql;// SQL语句中使用的名称
    private String nameSqlInStr;// SQL语句中使用的名称（在字符串拼接中使用）
    private String remark;// 字段注释
    private String description;//详细描述（分析得到）
    private String comment;//原始备注（remark+description）
    private String remarkName;//备注名称（与remark的区别时不已'表'结尾）

    private String urlPathName;// 对应的 url 路劲名称

    private String className;// 原类名称（首字母大写）
    private String classNameCamel;// 骆驼峰类名（首字母小写）
    private String classNameUpper;// 类名全大写
    private String classNameLower;// 类名全小写

    private TableColumn idColumn;           // ID列
    private TableColumn orgColumn;          // 机构列
    private TableColumn codeColumn;         // 编号构列
    private TableColumn genderColumn;       // 性别列
    private TableColumn createColumn;       // 创建日志列
    private TableColumn updateColumn;       // 更新日志列
    private TableColumn removeColumn;       // 删除列
    private TableColumn creatorColumn;      // 创建者列
    private TableColumn usernameColumn;     // 账户列
    private TableColumn passwordColumn;     // 密码列

    private boolean hasId = false;          // 是否有ID列
    private boolean hasOrgan = false;       // 是否有机构列
    private boolean hasCode = false;        // 是否有编号构列
    private boolean hasCreate = false;      // 是否有创建日志列
    private boolean hasUpdate = false;      // 是否有更新日志列
    private boolean hasGender = false;      // 是否有性别列
    private boolean hasRemove = false;      // 是否有删除列
    private boolean hasCreator = false;     // 是否有创建者列
    private boolean hasUsername = false;    // 是否有账户列
    private boolean hasPassword = false;    // 是否有密码列
    private boolean hasSearches = false;    // 收费有搜索列
    private boolean isRelateTable = false;  // 是否是关联表

    private List<TableColumn> columns;      // 表字段
    private List<ForeignKey> exportedKeys;  // 外键（导出）
    private List<ForeignKey> importedKeys;  // 外键（导入）

    private List<TableColumn> searchColumns = new ArrayList<>();// 搜索列

    @Setter(AccessLevel.PROTECTED)
    private List<Table> exportedTables = new ArrayList<>();//  引用键值对（与外键相反）

    private List<String> descriptions;      // 多行详细描述

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        this.nameSql = name;
        this.nameSqlInStr = name;
    }

    public void setName(String name, Database database) {
        this.setName(name);
        if (database != null && database.isKeyword(name)) {
            this.nameSql = database.wrapperKeyword(name);
            this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
        }
    }

    public void setRemark(String remark) {
        this.remark = remark;
        this.remarkName = remark;
        if (remark != null && remark.endsWith("表")) {
            this.remarkName = remark.substring(0, remark.length() - 1);
        }
    }

    public void setDescription(String description) {
        this.description = description;
        this.descriptions = Arrays.asList(description.split("\n"));
    }

    public void setIdColumn(TableColumn idColumn) {
        if (idColumn.getName().toLowerCase().endsWith("id")) {
            idColumn.setHiddenForSubmit(true);
        }
        this.idColumn = idColumn;
    }

    public void setOrgColumn(TableColumn orgColumn) {
        orgColumn.setHiddenForClient(true);
        orgColumn.setHiddenForSubmit(true);
        this.orgColumn = orgColumn;
    }

    public void setCodeColumn(TableColumn codeColumn) {
        codeColumn.setHiddenForSubmit(true);
        this.codeColumn = codeColumn;
    }

    public void setCreateColumn(TableColumn createColumn) {
        createColumn.setHiddenForSubmit(true);
        this.createColumn = createColumn;
    }

    public void setRemoveColumn(TableColumn removeColumn) {
        removeColumn.setHiddenForSubmit(true);
        removeColumn.setHiddenForClient(true);
        this.removeColumn = removeColumn;
    }

    public void setCreatorColumn(TableColumn creatorColumn) {
        creatorColumn.setHiddenForSubmit(true);
        this.creatorColumn = creatorColumn;
    }

    public void setUpdateColumn(TableColumn updateColumn) {
        updateColumn.setHiddenForSubmit(true);
        this.updateColumn = updateColumn;
    }

    public void setPasswordColumn(TableColumn passwordColumn) {
        passwordColumn.setHiddenForClient(true);
        this.passwordColumn = passwordColumn;
    }

    public void pushExportedTable(Table table) {
        exportedTables.add(table);
    }

}
