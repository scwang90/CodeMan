package com.code.smither.project.database.impl;

import com.code.smither.engine.Engine;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.ForeignKey;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.database.api.DbFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;


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

	private static final Logger logger = LoggerFactory.getLogger(DbTableSource.class);

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
		return metaData.getTables(connection.getCatalog(), null, null, new String[] { "TABLE" });
	}

	protected ResultSet queryPrimaryKeys(DatabaseMetaData metaData, String tableName) throws SQLException {
		return metaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
	}

	protected ResultSet queryImportedKeys(DatabaseMetaData metaData, String tableName) throws SQLException {
		return metaData.getImportedKeys(connection.getCatalog(), null, tableName);
	}

	protected ResultSet queryExportedKeys(DatabaseMetaData metaData, String tableName) throws SQLException {
		return metaData.getExportedKeys(connection.getCatalog(), null, tableName);
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
		ResultSet result = queryPrimaryKeys(databaseMetaData, table.getName());
		while (result.next()) {
			keys.add(result.getString("COLUMN_NAME"));
		}
		result.close();
		return keys;
	}

	@Override
	public List<? extends MetaDataForegin> queryImportedKeys(MetaDataTable table) throws Exception {
		List<ForeignKey> keys = new LinkedList<>();
		try (ResultSet result = queryImportedKeys(databaseMetaData, table.getName())) {
			while (result.next()) {
				keys.add(foreginFromResultSet(result));
			}
		}
		List<ForeignKey> list = keys.stream().distinct().collect(Collectors.toList());
		if (list.size() != keys.size()) {
			logger.warn("表【" + table.getName() + "】导入外键出现重复，已经排重：" + keys.size() + "->" + list.size());
			return list;
		}
		return keys;
	}

	@Override
	public List<? extends MetaDataForegin> queryExportedKeys(MetaDataTable table) throws Exception {
		List<ForeignKey> keys = new LinkedList<>();
		try (ResultSet result = queryExportedKeys(databaseMetaData, table.getName())) {
			while (result.next()) {
				keys.add(foreginFromResultSet(result));
			}
		}
		List<ForeignKey> list = keys.stream().distinct().collect(Collectors.toList());
		if (list.size() != keys.size()) {
			logger.warn("表【" + table.getName() + "】导出外键出现重复，已经排重：" + keys.size() + "->" + list.size());
			return list;
		}
		return keys;
	}

	private ForeignKey foreginFromResultSet(ResultSet result) throws SQLException {
		ForeignKey foregin = new ForeignKey();
		foregin.setIndex(result.getInt("KEY_SEQ"));
		foregin.setFkName(result.getString("FK_NAME"));
		foregin.setPkName(result.getString("PK_NAME"));
		foregin.setPkTableName(result.getString("PKTABLE_NAME"));
		foregin.setPkColumnName(result.getString("PKCOLUMN_NAME"));
		foregin.setFkTableName(result.getString("FKTABLE_NAME"));
		foregin.setFkColumnName(result.getString("FKCOLUMN_NAME"));
		foregin.setUpdateRule(result.getInt("UPDATE_RULE"));
		foregin.setDeleteRule(result.getInt("DELETE_RULE"));
		return foregin;
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
	public ForeignKey buildForeginKey(MetaDataForegin foregin) {
		if (foregin instanceof ForeignKey) {
			return ((ForeignKey) foregin);
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
		table.setComment(tableResult.getString("REMARKS"));
		return table;
	}

	protected TableColumn columnFromResultSet(ResultSet result) throws SQLException {
		TableColumn column = new TableColumn();
		column.setName(result.getString("COLUMN_NAME"), getDatabase());
		column.setType(result.getString("TYPE_NAME"));
		column.setTypeInt(result.getInt("DATA_TYPE"));
		column.setLength(result.getInt("COLUMN_SIZE"));
		column.setDefValue(result.getString("COLUMN_DEF"));
		column.setNullable(result.getBoolean("NULLABLE"));
		column.setRemark(result.getString("REMARKS"));
		column.setComment(result.getString("REMARKS"));
		column.setDecimalDigits(result.getInt("DECIMAL_DIGITS"));
		return column;
	}

	@SuppressWarnings("unused")
	public void printResultSet(ResultSet result) throws SQLException {
		ResultSetMetaData metaData = result.getMetaData(); 
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
        	System.out.println(metaData.getColumnName(i)+"="+result.getObject(i));
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
