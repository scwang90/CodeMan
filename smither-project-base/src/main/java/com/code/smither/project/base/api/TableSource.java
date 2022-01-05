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

    List<? extends Table> queryTables() throws Exception;
    List<? extends TableColumn> queryColumns(Table table) throws Exception;
    List<? extends IndexedKey> queryIndexKeys(Table table) throws Exception;
    List<? extends ForeignKey> queryImportedKeys(Table table) throws Exception;
    List<? extends ForeignKey> queryExportedKeys(Table table) throws Exception;

    String queryColumnRemark(TableColumn column) throws Exception;
    String queryTableRemark(Table table) throws Exception;

    Set<String> queryPrimaryKeys(Table table) throws Exception;
}