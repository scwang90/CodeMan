package com.code.smither.project.base.api;

import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.ForeignKey;
import com.code.smither.project.base.model.IndexedKey;
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

    Table buildTable(MetaDataTable table);
    TableColumn buildColumn(MetaDataColumn column);
    IndexedKey buildIndexedKey(MetaDataIndex index);
    ForeignKey buildForeignKey(MetaDataForegin foregin);

    List<? extends MetaDataTable> queryTables() throws Exception;
    List<? extends MetaDataColumn> queryColumns(MetaDataTable table) throws Exception;
    List<? extends MetaDataIndex> queryIndexKeys(MetaDataTable table) throws Exception;
    List<? extends MetaDataForegin> queryImportedKeys(MetaDataTable table) throws Exception;

    List<? extends MetaDataForegin> queryExportedKeys(MetaDataTable table) throws Exception;
    String queryColumnRemark(MetaDataColumn column) throws Exception;
    String queryTableRemark(MetaDataTable table) throws Exception;

    Set<String> queryPrimaryKeys(MetaDataTable table) throws Exception;
}