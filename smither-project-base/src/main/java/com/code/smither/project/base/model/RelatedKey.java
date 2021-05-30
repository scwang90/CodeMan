package com.code.smither.project.base.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * 模板Model-jdbc
 * 多对多关联
 * Created by SCWANG on 2021-5-30
 */
@Data
public class RelatedKey {

    @ToString.Exclude @EqualsAndHashCode.Exclude private Table localTable;              //目标表
    @ToString.Exclude @EqualsAndHashCode.Exclude private Table relateTable;              //关联表（中间表）
    @ToString.Exclude @EqualsAndHashCode.Exclude private Table targetTable;              //目标表
    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn localColumn;        //当前列
    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn targetColumn;       //目标列（目标表）
    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn relateLocalColumn;  //关联列（中间表 - 指向当前表）
    @ToString.Exclude @EqualsAndHashCode.Exclude private TableColumn relateTargetColumn; //关联列（中间表 - 指向目标表）
    @ToString.Exclude @EqualsAndHashCode.Exclude private ForeignKey localKey;
    @ToString.Exclude @EqualsAndHashCode.Exclude private ForeignKey targetKey;

}
