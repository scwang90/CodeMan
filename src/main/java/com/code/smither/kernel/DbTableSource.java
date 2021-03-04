package com.code.smither.kernel;

import com.code.smither.kernel.api.Converter;
import com.code.smither.kernel.api.Remarker;
import com.code.smither.kernel.api.TableSource;
import com.code.smither.model.Table;
import com.code.smither.model.TableColumn;
import com.code.smither.util.StringUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 模板Model-Table构建器
 * Created by SCWANG on 2015-07-04.
 */
public class DbTableSource implements TableSource {

	protected boolean autoclose = false;
	protected Converter converter = null;
	protected Connection connection = null;
	protected DatabaseMetaData databaseMetaData = null;
	protected Remarker remarker = new DbRemarker();

	public DbTableSource(Connection connection, Converter converter) {
		this(connection, converter, false);
	}

	public DbTableSource(Connection connection, Converter converter, boolean autoclose) {
		super();
		this.connection = connection;
		this.autoclose = autoclose;
		this.converter = converter;
	}

	@Override
	protected void finalize() throws Throwable {
		if (autoclose && this.connection != null) {
			this.connection.close();
		}
		super.finalize();
	}

	public List<Table> build() throws SQLException {
		if (this.connection != null) {
			databaseMetaData = this.connection.getMetaData();
			ResultSet tableResult = databaseMetaData.getTables(null, "%", "%",
					new String[] { "TABLE" });
			return buildTables(tableResult);
		}
		return new ArrayList<>();
	}

	protected List<Table> buildTables(ResultSet tableResult) throws SQLException {
		List<Table> tables = new ArrayList<Table>();
		while (tableResult.next()) {
			Table table = new Table();
			table.setName(tableResult.getString("TABLE_NAME"));
			table.setRemark(tableResult.getString("REMARKS"));
			table.setClassName(this.converter.converterClassName(table.getName()));
			table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));
			table.setClassNameUpper(table.getClassName().toUpperCase());
			table.setClassNameLower(table.getClassName().toLowerCase());
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
		ResultSet keyset = databaseMetaData.getPrimaryKeys(null, null, tableName);
		if (keyset.next()) {
			column.setName(keyset.getString("COLUMN_NAME"));
		} else {
			column.setName("hasNoPrimaryKey");

			column.setName("hasNoPrimaryKey");
			column.setType("VARCHAR");
			column.setTypeInt(java.sql.Types.VARCHAR);
			column.setLength(256);
			column.setDefValue("");
			column.setNullable(true);
			column.setAutoIncrement(false);
			column.setRemark("没有主键");

			column.setFieldName(this.converter.converterFieldName(column.getName()));
			column.setFieldType(this.converter.converterFieldType(column.getTypeInt()));
			column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
			column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
		}
		return column;
	}

	protected List<TableColumn> buildColumns(String tableName) throws SQLException {
		ResultSet resultSet = databaseMetaData.getColumns(null, "%", tableName, "%");
		List<TableColumn> columns = new ArrayList<>();
		while (resultSet.next()) {
			TableColumn column = new TableColumn();
			column.setName(resultSet.getString("COLUMN_NAME"));
			column.setType(resultSet.getString("TYPE_NAME"));
			column.setTypeInt(resultSet.getInt("DATA_TYPE"));
			column.setLength(resultSet.getInt("COLUMN_SIZE"));
			column.setDefValue(resultSet.getString("COLUMN_DEF"));
			column.setNullable(resultSet.getBoolean("NULLABLE"));
			column.setAutoIncrement(resultSet.getBoolean("IS_AUTOINCREMENT"));
			column.setRemark(resultSet.getString("REMARKS"));

			column.setFieldName(this.converter.converterFieldName(column.getName()));
			column.setFieldType(this.converter.converterFieldType(column.getTypeInt()));
			column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
			column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

			if (column.getRemark() == null || column.getRemark().trim().length()==0) {
				column.setRemark(remarker.getColumnRemark(column.getName()));
			}
			columns.add(column);
		}
		return columns;
	}
	
	public void printResultSet(ResultSet resultSet) throws SQLException {
		ResultSetMetaData metaData = resultSet.getMetaData(); 
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
        	System.out.println(metaData.getColumnName(i)+"="+resultSet.getObject(i));
		}
	}
}
