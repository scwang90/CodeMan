package com.code.smither.project.database.impl;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.database.api.DbFactory;

import java.sql.*;
import java.util.*;


/**
 * 模板Model-Table构建器
 * Created by SCWANG on 2015-07-04.
 */
@SuppressWarnings("WeakerAccess")
public class DbTableSource implements TableSource {

	protected boolean autoClose;
	protected ProjectConfig config;
	protected DbFactory dbFactory;
	protected Connection connection = null;
	protected DatabaseMetaData databaseMetaData = null;

	public DbTableSource(ProjectConfig config, DbFactory dbFactory) {
		this(config, dbFactory, false);
	}

	DbTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoClose) {
		super();
		this.config = config;
		this.dbFactory = dbFactory;
		this.autoClose = autoClose;
	}

	@Override
	protected void finalize() throws Throwable {
		if (autoClose && this.connection != null) {
			this.connection.close();
		}
		super.finalize();
	}

	@Override
	public Database getDatabase() {
		return new DefaultDatabase(new String[0]);
	}

	protected ResultSet queryTables(DatabaseMetaData metaData) throws SQLException {
		return metaData.getTables(connection.getCatalog(), "%", "%", new String[] { "TABLE" });
	}

	protected ResultSet queryPrimaryKeys(DatabaseMetaData metaData, String tableName) throws SQLException {
		return metaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
	}

	protected ResultSet queryColumns(DatabaseMetaData metaData, String tableName) throws SQLException {
		return metaData.getColumns(connection.getCatalog(), "%", tableName, "%");
	}
	@Override
	public List<? extends MetaDataTable> queryTables() throws SQLException {
		if (this.connection == null) {
			this.connection = dbFactory.getConnection();
		}
		if (this.connection != null) {
			this.databaseMetaData = this.connection.getMetaData();
			return buildTables(queryTables(databaseMetaData));
		}
		return new LinkedList<>();
	}

	@Override
	public List<? extends MetaDataColumn> queryColumns(MetaDataTable table) throws SQLException {
		List<TableColumn> columns = new LinkedList<>();
		ResultSet resultColumn = queryColumns(databaseMetaData, table.getName());
		while (resultColumn.next()) {
			columns.add(columnFromResultSet(resultColumn));
		}
		resultColumn.close();
		return columns;
	}

	@Override
	public Set<String> queryPrimaryKeys(MetaDataTable table) throws SQLException {
		Set<String> keys = new LinkedHashSet<>();
		ResultSet resultKey = queryPrimaryKeys(databaseMetaData, table.getName());
		while (resultKey.next()) {
			keys.add(resultKey.getString("COLUMN_NAME"));
		}
		resultKey.close();
		return keys;
	}

	@Override
	public Table buildTable(MetaDataTable tableMate) {
		if (tableMate instanceof Table) {
			return ((Table) tableMate);
		}
		return null;
	}

	@Override
	public TableColumn buildColumn(MetaDataColumn columnMate) {
		if (columnMate instanceof TableColumn) {
			return ((TableColumn) columnMate);
		}
		return null;
	}

	@Override
	public String queryTableRemark(MetaDataTable tableMate) throws SQLException {
		return null;
	}

	@Override
	public String queryColumnRemark(MetaDataColumn columnMate) throws SQLException {
		return null;
	}


	protected List<Table> buildTables(ResultSet tableResult) throws SQLException {
		List<Table> tables = new ArrayList<>();
		while (tableResult.next()) {
			tables.add(tableFromResultSet(tableResult));
		}
		tableResult.close();
		return tables;
	}

	protected Table tableFromResultSet(ResultSet tableResult) throws SQLException {
		Table table = new Table();
		table.setName(tableResult.getString("TABLE_NAME"), getDatabase());
		table.setRemark(tableResult.getString("REMARKS"));
		return table;
	}

	protected TableColumn columnFromResultSet(ResultSet resultSet) throws SQLException {
		TableColumn column = new TableColumn();
		column.setName(resultSet.getString("COLUMN_NAME"), getDatabase());
		column.setType(resultSet.getString("TYPE_NAME"));
		column.setTypeInt(resultSet.getInt("DATA_TYPE"));
		column.setLength(resultSet.getInt("COLUMN_SIZE"));
		column.setDefValue(resultSet.getString("COLUMN_DEF"));
		column.setNullable(resultSet.getBoolean("NULLABLE"));
		column.setRemark(resultSet.getString("REMARKS"));

		if (column.getDefValue() != null) {
			column.setDefValue(column.getDefValue().replaceAll("\n$", ""));
		}
		return column;
	}

	@SuppressWarnings("unused")
	public void printResultSet(ResultSet resultSet) throws SQLException {
		ResultSetMetaData metaData = resultSet.getMetaData(); 
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
        	System.out.println(metaData.getColumnName(i)+"="+resultSet.getObject(i));
		}
	}

	public static class DefaultDatabase implements Database {

		private String[] keywords;

		DefaultDatabase(String[] keywords) {
			this.keywords = keywords;
		}

		@Override
		public String name() {
			return "";
		}

		@Override
		public boolean isKeyword(String value) {
			for (String keyword : keywords) {
				if (keyword.equalsIgnoreCase(value)) {
					return true;
				}
			}
			return false;
		}

		@Override
		public String wrapperKeyword(String name) {
			return name;
		}
	}
}
