package com.code.smither.project.base.model;import com.code.smither.project.base.api.MetaDataForegin;import com.code.smither.project.base.api.MetaDataIndex;import lombok.Data;import lombok.EqualsAndHashCode;import lombok.ToString;import java.sql.DatabaseMetaData;/** * 模板Model-jdbc * Created by SCWANG on 2015-07-04. */@Datapublic class IndexedKey implements MetaDataIndex {    private int index;                //外键中的序列号（值 1 表示外键中的第一列，值 2 表示外键中的第二列）    private int deleteRule;           //删除规则    private int updateRule;           //更新规则    private boolean isCascade;        //是否级联查询    private String pkName;            //主键的名称    private String fkName;            //外键的名称    private String pkTableName;       //主表名称    private String pkColumnName;      //主列名称    private String fkTableName;       //外表名称    private String fkColumnName;      //外列名称    @ToString.Exclude @EqualsAndHashCode.Exclude private Table pkTable;    @ToString.Exclude @EqualsAndHashCode.Exclude private Table fkTable;    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn pkColumn;    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn fkColumn;    @Override    public String getName() {        return pkName;    }    public boolean isUpdateNoAction() {        return updateRule == DatabaseMetaData.importedKeyNoAction || updateRule == DatabaseMetaData.importedKeyRestrict;    }    public boolean isUpdateRestrict() {        return updateRule == DatabaseMetaData.importedKeyNoAction || updateRule == DatabaseMetaData.importedKeyRestrict;    }    public boolean isUpdateCascade() {        return updateRule == DatabaseMetaData.importedKeyCascade;    }    public boolean isUpdateSetDefault() {        return updateRule == DatabaseMetaData.importedKeySetDefault;    }    public boolean isUpdateSetNull() {        return updateRule == DatabaseMetaData.importedKeySetNull;    }    public boolean isDeleteNoAction() {        return deleteRule == DatabaseMetaData.importedKeyNoAction || deleteRule == DatabaseMetaData.importedKeyRestrict;    }    public boolean isDeleteRestrict() {        return deleteRule == DatabaseMetaData.importedKeyNoAction || deleteRule == DatabaseMetaData.importedKeyRestrict;    }    public boolean isDeleteCascade() {        return deleteRule == DatabaseMetaData.importedKeyCascade;    }    public boolean isDeleteSetDefault() {        return deleteRule == DatabaseMetaData.importedKeySetDefault;    }    public boolean isDeleteSetNull() {        return deleteRule == DatabaseMetaData.importedKeySetNull;    }//    pktable_name string => 被导入的主键表名称//    pkcolumn_name string => 被导入的主键列名称//    fktable_name string => 外键表名称//    fkcolumn_name string => 外键列名称//    key_seq short => 外键中的序列号//    fk_name string => 外键的名称（可为 null）//    pk_name string => 主键的名称（可为 null）//    update_rule short => 更新主键时外键发生的变化：//              importednoaction - 如果已经被导入，则不允许更新主键//              importedkeycascade - 将导入的键更改为与主键更新一致//              importedkeysetnull - 如果已更新导入键的主键，则将导入键更改为 null//              importedkeysetdefault - 如果已更新导入键的主键，则将导入键更改为默认值//              importedkeyrestrict - 与 importedkeynoaction 相同（为了与 odbc 2.x 兼容）//    delete_rule short => 删除主键时外键发生的变化。//              importedkeynoaction - 如果已经导入，则不允许删除主键//              importedkeycascade - 删除导入删除键的行//              importedkeysetnull - 如果已删除导入键的主键，则将导入键更改为 null//              importedkeyrestrict - 与 importedkeynoaction 相同（为了与 odbc 2.x 兼容）//              importedkeysetdefault - 如果已删除导入键的主键，则将导入键更改为默认值//    deferrability short => 是否可以将对外键约束的评估延迟到提交时间//              importedkeyinitiallydeferred - 有关定义，请参见 sql92//              importedkeyinitiallyimmediate - 有关定义，请参见 sql92//              importedkeynotdeferrable - 有关定义，请参见 sql92}