package com.code.smither.project.database.impl;

import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.api.DbDataSource;
import com.code.smither.project.database.api.DbFactory;
import lombok.Data;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

@Data
public class DefaultDataSource implements DbDataSource {

	protected boolean autoClose;
	protected DbFactory dbFactory;
	protected Connection connection = null;
	protected DataBaseConfig dbConfig = null;
	protected DatabaseMetaData databaseMetaData = null;

	public DefaultDataSource(DataBaseConfig config, DbFactory dbFactory) {
		this(config, dbFactory, false);
	}

	public DefaultDataSource(DataBaseConfig config, DbFactory dbFactory, boolean autoClose) {
		super();
		this.dbConfig = config;
		this.dbFactory = dbFactory;
		this.autoClose = autoClose;
	}

    protected DatabaseMetaData ensureMetaData() throws SQLException {
        if (this.connection == null) {
			this.connection = dbFactory.getConnection();
		}
		if (this.connection != null) {
			this.databaseMetaData = this.connection.getMetaData();
		}
        if (this.databaseMetaData == null) {
            throw new RuntimeException("初始化DatabaseMetaData失败！");
        }
        return this.databaseMetaData;
    }

	@Override
	protected void finalize() throws Throwable {
		try {
			if (autoClose && this.connection != null) {
				this.connection.close();
			}
		} finally {
			super.finalize();
		}
	}

	@Override
	public Database getDatabase() {
		return new DefaultDatabase(new String[0]);
	}

	@Override
    public ResultSet queryTables() throws SQLException {
		return ensureMetaData().getTables(connection.getCatalog(), dbConfig.getSchemaTable(), null, new String[] { "TABLE" });
	}

	@Override
    public ResultSet queryPrimaryKeys(String tableName) throws SQLException {
		return ensureMetaData().getPrimaryKeys(connection.getCatalog(), null, tableName);
	}

	@Override
	public ResultSet queryIndexedKeys(String tableName) throws SQLException {
		return ensureMetaData().getIndexInfo(connection.getCatalog(), null, tableName, false, false);
	}

	@Override
    public ResultSet queryImportedKeys(String tableName) throws SQLException {
		return ensureMetaData().getImportedKeys(connection.getCatalog(), null, tableName);
	}

	@Override
    public ResultSet queryExportedKeys(String tableName) throws SQLException {
		return ensureMetaData().getExportedKeys(connection.getCatalog(), null, tableName);
	}

	@Override
    public ResultSet queryColumns(String tableName) throws SQLException {
		return ensureMetaData().getColumns(connection.getCatalog(), "%", tableName, "%");
	}

    @Override
    public String queryTableRemark(MetaDataTable tableMate) throws SQLException {
        return null;
    }

    @Override
    public String queryColumnRemark(MetaDataColumn columnMate) throws SQLException {
        return null;
    }
    
    @Override
	public <T extends MetaDataTable> T tableFromResultSet(ResultSet tableResult, T table) throws SQLException {
		// table.setName(tableResult.getString("TABLE_NAME"), getDatabase());
        table.setName(tableResult.getString("TABLE_NAME"));
		table.setComment(tableResult.getString("REMARKS"));
		table.setSchema(tableResult.getString("table_schem"));
		return table;
	}

    @Override
	public <T extends MetaDataColumn> T columnFromResultSet(ResultSet result, T column) throws SQLException {
        column.setName(result.getString("COLUMN_NAME"));
		column.setType(result.getString("TYPE_NAME"));
		column.setTypeInt(result.getInt("DATA_TYPE"));
		column.setLength(result.getInt("COLUMN_SIZE"));
		column.setDefValue(result.getString("COLUMN_DEF"));
		column.setNullable(result.getBoolean("NULLABLE"));
		column.setComment(result.getString("REMARKS"));
		column.setDecimalDigits(result.getInt("DECIMAL_DIGITS"));
		column.setHasDefValue(result.getObject("COLUMN_DEF") != null);
		column.setAutoIncrement("YES".equals(result.getObject("IS_AUTOINCREMENT")));
		return column;
	}

	public static class DefaultDatabase implements Database {

		private final String[] keywords;

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
