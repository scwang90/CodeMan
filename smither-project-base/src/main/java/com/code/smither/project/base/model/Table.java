package com.code.smither.project.base.model;

import com.code.smither.engine.api.Model;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.util.Remarker;
import com.code.smither.project.base.util.StringUtil;
import lombok.*;

import java.util.*;
import java.util.stream.Stream;

/**
 * 模板Model-table
 * Created by SCWANG on 2016/8/18.
 */
@Data
@SuppressWarnings("unused")
public class Table implements Model, MetaDataTable {

    private String name;                    // 原表名称
    private String nameSql;                 // SQL语句中使用的名称
    private String nameSqlInStr;            // SQL语句中使用的名称（在字符串拼接中使用）

    private String schema;                  //表 schema

    private String schemaName;              //经过处理的 schema 名称，可以在代码中
    private String remark;                  // 字段注释
    private String description;             //详细描述（分析得到）
    private String comment;                 //原始备注（remark+description）
    private String remarkName;              //备注名称（与remark的区别时不已'表'结尾）

    private String urlPathName;                     // 对应的 url 路劲名称

    private String className;                       // 原类名称（首字母大写）
    private String classNameCamel;                  // 骆驼峰类名（首字母小写）
    private String classNameUpper;                  // 类名全大写
    private String classNameLower;                  // 类名全小写
    private TableColumn idColumn;                   // ID列
    private TableColumn orgColumn;                  // 机构列
    private TableColumn codeColumn;                 // 编号构列
    private TableColumn nameColumn;                 // 名称列
    private TableColumn genderColumn;               // 性别列
    private TableColumn createColumn;               // 创建日志列
    private TableColumn updateColumn;               // 更新日志列
    private TableColumn removeColumn;               // 删除列
    private TableColumn creatorColumn;              // 创建者列
    private TableColumn usernameColumn;             // 账户列（登录表）
    private TableColumn passwordColumn;             // 密码列（登录表）

    private boolean hasId = false;                  // 是否有ID列
    private boolean hasIds = false;                 // 是否有联合主键
    private boolean hasOrgan = false;               // 是否有机构列
    private boolean hasCode = false;                // 是否有编号构列
    private boolean hasCreate = false;              // 是否有创建日志列
    private boolean hasUpdate = false;              // 是否有更新日志列
    private boolean hasGender = false;              // 是否有性别列
    private boolean hasRemove = false;              // 是否有删除列
    private boolean hasCreator = false;             // 是否有创建者列
    private boolean hasSearches = false;            // 收费有搜索列
    private boolean relateTable = false;            // 是否是关联表
    private boolean hasUsername = false;            // 是否有账户列（登录表）
    private boolean hasPassword = false;            // 是否有密码列（登录表）
    private boolean isLoginTable = false;           // 是否是登录表

    @ToString.Exclude @EqualsAndHashCode.Exclude private List<TableColumn> columns;              // 表字段
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<TableColumn> idColumns;            // 多主键字段
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<TableColumn> notNullColumns;       // 非空字段
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<IndexedKey> indexKeys;             // 索引（数据库原始）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<ForeignKey> exportedKeys;          // 外键（导出，数据库原始）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<ForeignKey> importedKeys;          // 外键（导入，数据库原始）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<IndexedKey> indexedKeys;           // 索引（排除主键之后的索引）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<ForeignKey> exportCascadeKeys;     // 外键（导出，级联，一对多，配置过滤过的）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<ForeignKey> importCascadeKeys;     // 外键（导入，级联，一对一，配置过滤过的）
    @ToString.Exclude @EqualsAndHashCode.Exclude private List<RelatedKey> relateCascadeKeys;     // 外键（关联，级联，多对多，配置过滤过的）

    @Setter(AccessLevel.PROTECTED)
    @ToString.Exclude @EqualsAndHashCode.Exclude private Set<TableColumn> searchColumns = new LinkedHashSet<>();// 搜索列

    private List<String> descriptions;      // 多行详细描述

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
        this.setNameSql(name);
    }

    public void setNameSql(String nameSql) {
        this.nameSql = nameSql;
        this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
    }

    //    public void setName(String name, Database database) {
//        this.setName(name);
//        if (database != null && database.isKeyword(name)) {
//            this.nameSql = database.wrapperKeyword(name);
//            this.nameSqlInStr = this.nameSql.replace("\"","\\\"");
//        }
//    }

    @Override
    public void setComment(String comment) {
        this.comment = comment;
        this.setRemark(comment);
    }

    public void setRemark(String remark) {
        if (remark != null) {
            if (remark.endsWith("表") && remark.length() > 1) {
                remark = remark.substring(0, remark.length() - 1);
            }
            if (remark.endsWith("信息") && remark.length() > 2) {
                remark = remark.substring(0, remark.length() - 2);
            }
        }
        this.remark = remark;
        this.remarkName = remark;
    }

    public void setDescription(String description) {
        this.description = description;
        this.descriptions = Remarker.findDescriptions(description);
    }

    public void setIdColumn(TableColumn idColumn) {
//        if (idColumn.getName().toLowerCase().endsWith("id")) {
//            idColumn.setHiddenForSubmit(true);
//        }
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
        createColumn.setDateTimeType(true);
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
        updateColumn.setDateTimeType(true);
        updateColumn.setHiddenForSubmit(true);
        this.updateColumn = updateColumn;
    }

    public void setPasswordColumn(TableColumn passwordColumn) {
        passwordColumn.setHiddenForClient(true);
        this.passwordColumn = passwordColumn;
    }

    public boolean isHasIndexedKey() {
        return indexedKeys != null && indexedKeys.size() > 0;
    }

    public boolean isHasCascadeKey() {
        return isHasExportCascadeKey() || isHasImportCascadeKey() || isHasRelatedCascadeKey();
    }

    public boolean isHasRelatedCascadeKey() {
        return relateCascadeKeys != null && relateCascadeKeys.size() > 0;
    }

    public boolean isHasExportCascadeKey() {
        return exportCascadeKeys != null && exportCascadeKeys.size() > 0;
    }

    public boolean isHasImportCascadeKey() {
        return importCascadeKeys != null && importCascadeKeys.size() > 0;
    }

    public boolean isHasForeignKey() {
        return isHasExportKey() || isHasImportKey();
    }

    public boolean isHasExportKey() {
        return exportedKeys != null && exportedKeys.size() > 0;
    }

    public boolean isHasImportKey() {
        return importedKeys != null && importedKeys.size() > 0;
    }

    public boolean isHasColumnEnums() {
        if (this.columns != null) {
            return this.columns.stream().anyMatch(TableColumn::isHasEnums);
        }
        return false;
    }

    public boolean isHasColumnEnumMap() {
        if (this.columns != null) {
            return this.columns.stream().anyMatch(TableColumn::isHasEnumMap);
        }
        return false;
    }

    public boolean isHasPassword() {
        return hasPassword && isLoginTable;
    }

    public boolean isHasUsername() {
        return hasUsername && isLoginTable;
    }

    /**
     * 包含
     */
    public boolean isContainsColumn(String name) {
        for (TableColumn column : this.columns) {
            if (name.equals(column.getName())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 包含其中一个
     */
    public boolean isContainsOneOfColumns(String... names) {
        for (TableColumn column : this.columns) {
            for (String name : names) {
                if (name.equals(column.getName())) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 包含全部
     */
    public boolean isContainsAllOfColumns(String... names) {
        if (names.length == 0) {
            return false;
        }
        boolean[] findes = new boolean[names.length]; // 初始化 boolean 数组
        Arrays.fill(findes, false); // 将数组中所有元素全部赋值为 false\
        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            for (TableColumn column : this.columns) {
                if (name.equals(column.getName())) {
                    findes[i] = true;
                    break;
                }
            }
        }
        for (boolean finde : findes) {
            if (!finde) {
                return false;
            }
        }
        return true;
    }

    public TableColumn getUsernameColumn() {
        return getLoginTableColumn(usernameColumn);
    }

    public TableColumn getPasswordColumn() {
        return getLoginTableColumn(passwordColumn);
    }

    private TableColumn getLoginTableColumn(TableColumn column) {
        if (!isLoginTable && column != null && !StringUtil.isNullOrBlank(column.getName())) {
            return Stream.of(orgColumn, codeColumn, nameColumn, genderColumn,
                    createColumn, updateColumn, removeColumn,
                    creatorColumn).filter(c -> c!= null&&StringUtil.isNullOrBlank(c.getName())).findFirst().orElse(new TableColumn());
        }
        return column;
    }
}
