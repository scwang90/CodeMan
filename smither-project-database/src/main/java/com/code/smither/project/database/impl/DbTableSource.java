package com.code.smither.project.database.impl;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.constant.JdbcLang;
import com.code.smither.project.base.impl.DbRemarker;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;

import javax.annotation.Nonnull;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


/**
 * 模板Model-Table构建器
 * Created by SCWANG on 2015-07-04.
 */
public class DbTableSource implements TableSource {

	protected boolean autoClose = false;
	protected ProjectConfig config = null;
	protected DbFactory dbFactory = null;
	protected Connection connection = null;
	protected ITableFilter tableFilter = null;
	protected ClassConverter classConverter = null;
	protected DatabaseMetaData databaseMetaData = null;
	protected Remarker remarker = new DbRemarker();
	protected JdbcLang jdbcLang = new JdbcLang();

	public DbTableSource(ProjectConfig config, DbFactory dbFactory) {
		this(config, dbFactory, false);
	}

	DbTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoClose) {
		super();
		this.config = config;
		this.dbFactory = dbFactory;
		this.autoClose = autoClose;
		this.tableFilter = config.getTableFilter();
		this.classConverter = config.getClassConverter();
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

	@Nonnull
	public List<Table> build() throws SQLException {
		if (this.connection == null) {
			this.connection = dbFactory.getConnection();
		}
		if (this.connection != null) {
			databaseMetaData = this.connection.getMetaData();
			ResultSet tableResult = databaseMetaData.getTables(connection.getCatalog(), "%", "%",
					new String[] { "TABLE" });
			return buildTables(tableResult);
		}
		return new ArrayList<>();
	}

	protected List<Table> buildTables(ResultSet tableResult) throws SQLException {
		List<Table> tables = new ArrayList<>();
		while (tableResult.next()) {
			String tableName = tableResult.getString("TABLE_NAME");
			if (tableFilter != null && tableFilter.isNeedFilterTable(tableName)) {
				continue;
			}

			Table table = new Table();
			table.setName(tableName, getDatabase());
			table.setRemark(tableResult.getString("REMARKS"));
			table.setClassName(this.classConverter.converterClassName(table.getName()));
			table.setClassNameUpper(table.getClassName().toUpperCase());
			table.setClassNameLower(table.getClassName().toLowerCase());
			table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));

			String division = this.config.getTableDivision();
			if (division == null || division.length() == 0) {
				division = "_";
			}
			table.setUrlPathName(table.getName().toLowerCase().replace(division,"-"));

			if (table.getRemark() == null || table.getRemark().trim().length()==0) {
				table.setRemark(getTableRemarks(table.getName()));
			}
			if (table.getRemark() == null || table.getRemark().trim().length()==0) {
				table.setRemark(remarker.getTableRemark(table.getName()));
			}
			table.setColumns(buildColumns(table.getName()));
			table.setIdColumn(buildIdColumn(table.getName()));
			for (TableColumn column : table.getColumns()) {
				if (column.getName().equals(table.getIdColumn().getName())) {
					table.setIdColumn(column);
					break;
				}
			}
			tables.add(table);
		}
		return tables;
	}

	protected TableColumn buildIdColumn(String tableName) throws SQLException{
		TableColumn column = new TableColumn();
		ResultSet keySet = databaseMetaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
		if (keySet.next()) {
			column.setName(keySet.getString("COLUMN_NAME"), getDatabase());
		} else {
			column.setName("hasNoPrimaryKey");
			column.setType("VARCHAR");
			column.setLength(256);
			column.setDefValue("");
			column.setNullable(true);
			column.setAutoIncrement(false);
			column.setRemark("没有主键");
			column.setTypeInt(java.sql.Types.VARCHAR);

			column.setFieldName(this.classConverter.converterFieldName(column.getName()));
			column.setFieldType(this.classConverter.converterFieldType(column.getTypeInt()));
			column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
			column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
		}
		return column;
	}

	protected List<TableColumn> buildColumns(String tableName) throws SQLException {
		ResultSet resultSet = databaseMetaData.getColumns(connection.getCatalog(), "%", tableName, "%");
		List<TableColumn> columns = new ArrayList<>();
		while (resultSet.next()) {
			TableColumn column = new TableColumn();
			column.setName(resultSet.getString("COLUMN_NAME"), getDatabase());
			column.setType(resultSet.getString("TYPE_NAME"));
			column.setTypeInt(resultSet.getInt("DATA_TYPE"));
			column.setLength(resultSet.getInt("COLUMN_SIZE"));
			column.setDefValue(resultSet.getString("COLUMN_DEF"));
			column.setNullable(resultSet.getBoolean("NULLABLE"));
			column.setRemark(resultSet.getString("REMARKS"));
			column.setTypeJdbc(jdbcLang.getType(column.getTypeInt()));

			Object is_autoincrement = resultSet.getObject("IS_AUTOINCREMENT");
			column.setAutoIncrement(Boolean.valueOf(true).equals(is_autoincrement) || "YES".equalsIgnoreCase(is_autoincrement + "") || Integer.valueOf("1").equals(is_autoincrement));

			column.setFieldName(this.classConverter.converterFieldName(column.getName()));
			column.setFieldType(this.classConverter.converterFieldType(column.getTypeInt()));
			column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
			column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

			if (column.getRemark() == null || column.getRemark().trim().length()==0) {
				column.setRemark(remarker.getColumnRemark(column.getName()));
			}
			columns.add(column);
		}
		return columns;
	}

	protected String getTableRemarks(String table) throws SQLException {
		return null;
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
