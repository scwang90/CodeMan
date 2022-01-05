package com.code.smither.project.database.api;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.constant.Database;

public interface DbDataSource {

    Database getDatabase();

    ResultSet queryTables() throws SQLException;

    ResultSet queryColumns(String name) throws SQLException;

    ResultSet queryPrimaryKeys(String name) throws SQLException;

    ResultSet queryIndexedKeys(String name) throws SQLException;

    ResultSet queryImportedKeys(String name) throws SQLException;

    ResultSet queryExportedKeys(String name) throws SQLException;
    
    <T extends MetaDataTable> T  tableFromResultSet(ResultSet tableResult, T table) throws SQLException;

    <T extends MetaDataColumn> T columnFromResultSet(ResultSet resultColumn, T column) throws SQLException;

    String queryTableRemark(MetaDataTable tableMate) throws SQLException;

    String queryColumnRemark(MetaDataColumn columnMate) throws SQLException;
    
}
