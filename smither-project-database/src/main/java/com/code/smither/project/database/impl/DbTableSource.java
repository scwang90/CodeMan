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
import java.util.LinkedList;
import java.util.List;


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
	protected ITableFilter tableFilter;
	protected ClassConverter classConverter;
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

	protected ResultSet queryTables() throws SQLException {
		return databaseMetaData.getTables(connection.getCatalog(), "%", "%", new String[] { "TABLE" });
	}

	protected ResultSet queryPrimaryKeys(String tableName) throws SQLException {
		return databaseMetaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
	}

	protected ResultSet queryColumns(String tableName) throws SQLException {
		return databaseMetaData.getColumns(connection.getCatalog(), "%", tableName, "%");
	}

	protected String queryTableRemarks(String table) throws SQLException {
		return null;
	}

	@Nonnull
	public List<Table> build() throws SQLException {
		if (this.connection == null) {
			this.connection = dbFactory.getConnection();
		}
		if (this.connection != null) {
			this.databaseMetaData = this.connection.getMetaData();
			return buildTables(queryTables());
		}
		return new ArrayList<>();
	}

	protected List<Table> buildTables(ResultSet tableResult) throws SQLException {
		List<Table> tables = new ArrayList<>();
		while (tableResult.next()) {
			System.out.println();
			Table table = tableFromResultSet(tableResult);
            if (table == null) {
                continue;
            }
//			table.setName("特殊预交金表");
//            if (tables.size() > 0) {
//                return tables;
//            }
			System.out.println("构建表【"+table.getName()+"】模型开始（" + tables.size() + "）");
			tables.add(tableCompute(table));
			System.out.println("构建表【"+table.getName()+"】模型完成（" + tables.size() + "）");
		}
		tableResult.close();
		return tables;
	}

	protected Table tableFromResultSet(ResultSet tableResult) throws SQLException {
		String tableName = tableResult.getString("TABLE_NAME");
		if (tableFilter != null && tableFilter.isNeedFilterTable(tableName)) {
			System.out.println("跳过表【"+tableName+"】");
			return null;
		}

		Table table = new Table();
		table.setName(tableName, getDatabase());
		table.setRemark(tableResult.getString("REMARKS"));
		return table;
	}

	protected Table tableCompute(Table table) throws SQLException {
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
			table.setRemark(queryTableRemarks(table.getName()));
		}
		if (table.getRemark() == null || table.getRemark().trim().length()==0) {
			table.setRemark(remarker.getTableRemark(table.getName()));
		}

		return tableComputeColumn(table);
	}

    protected Table tableComputeColumn(Table table) throws SQLException {
	    List<String> keys = new LinkedList<>();
        ResultSet resultKey = queryPrimaryKeys(table.getName());
        while (resultKey.next()) {
            keys.add(resultKey.getString("COLUMN_NAME"));
        }
        resultKey.close();

        List<TableColumn> columns = new LinkedList<>();
        ResultSet resultColumn = queryColumns(table.getName());
        while (resultColumn.next()) {
            TableColumn column = columnFromResultSet(resultColumn);
            if (keys.contains(column.getName()) || (keys.isEmpty() && column.getName().toLowerCase().endsWith("id"))) {
                if (table.getIdColumn() == null) {
                    table.setIdColumn(column);
                }
                if (column.getTypeInt() == Types.DECIMAL || column.getTypeInt() == Types.NUMERIC) {
                    column.setTypeInt(Types.BIGINT);
                }
            }
            columns.add(columnCompute(column));
            System.out.println("构建列【" + table.getName() + "】【" + column.getName() + "】模型完成（" + columns.size() + "）");
        }
        if (table.getIdColumn() == null) {
            table.setIdColumn(columnKeyDefault(columns));
        }
        resultColumn.close();
        table.setColumns(columns);
        return table;
    }

    protected TableColumn columnKeyDefault(List<TableColumn> columns) {
        if (columns.size() > 0) {
            return columns.get(0);
        }
        TableColumn column = new TableColumn();
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
        return column;
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
		return column;
	}

	protected TableColumn columnCompute(TableColumn column) {
		column.setTypeJdbc(jdbcLang.getType(column.getTypeInt()));
		column.setFieldName(this.classConverter.converterFieldName(column.getName()));
		column.setFieldType(this.classConverter.converterFieldType(column.getTypeInt()));
		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

		if (column.getRemark() == null || column.getRemark().trim().length()==0) {
			column.setRemark(remarker.getColumnRemark(column.getName()));
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
