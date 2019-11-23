package com.code.smither.project.base.api;

import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;

import javax.annotation.Nullable;

import java.util.List;
import java.util.Set;

/**
 * 表源
 * Created by SCWANG on 2016/8/1.
 */
public interface TableSource {

    @Nullable Database getDatabase();

    Table buildTable(MetaDataTable tableMate);
    TableColumn buildColumn(MetaDataColumn columnMate);

    List<? extends MetaDataTable> queryTables() throws Exception;
    List<? extends MetaDataColumn> queryColumns(MetaDataTable tableMate) throws Exception;

    String queryColumnRemark(MetaDataColumn columnMate) throws Exception;
    String queryTableRemark(MetaDataTable tableMate) throws Exception;
    Set<String> queryPrimaryKeys(MetaDataTable tableMate) throws Exception;
}