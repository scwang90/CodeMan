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

    ResultSet querIndexedKeys(String name) throws SQLException;

    ResultSet queryImportedKeys(String name) throws SQLException;

    ResultSet queryExportedKeys(String name) throws SQLException;
    
    MetaDataTable tableFromResultSet(ResultSet tableResult, MetaDataTable table) throws SQLException;
    
    MetaDataColumn columnFromResultSet(ResultSet resultColumn, MetaDataColumn column) throws SQLException;

    String queryTableRemark(MetaDataTable tableMate) throws SQLException;

    String queryColumnRemark(MetaDataColumn columnMate) throws SQLException;
    
}
