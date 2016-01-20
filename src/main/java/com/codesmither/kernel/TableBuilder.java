package com.codesmither.kernel;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.codesmither.model.Table;
import com.codesmither.model.TableColumn;
import com.codesmither.util.StringUtil;

/**
 * 模板Model-Table构建器
 * Created by SCWANG on 2015-07-04.
 */
public class TableBuilder {

	private boolean autoclose = true;
	private Converter converter = null;
	private Connection connection = null;
	private DatabaseMetaData databaseMetaData = null;
	

	public TableBuilder(Connection connection) {
		super();
		this.connection = connection;
		this.converter = new Converter();
	}

	public TableBuilder(Connection connection,Converter converter) {
		super();
		this.connection = connection;
		this.converter = converter;
	}

	public TableBuilder(Connection connection,Converter converter, boolean autoclose) {
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
			ResultSet tableset = databaseMetaData.getTables(null, "%", "%",
					new String[] { "TABLE" });
			return buildTables(tableset);
		}
		return new ArrayList<>();
	}

	private List<Table> buildTables(ResultSet tableset) throws SQLException {
		List<Table> tables = new ArrayList<Table>();
		while (tableset.next()) {
			Table table = new Table();
			table.name = tableset.getString("TABLE_NAME");
			table.remark = tableset.getString("REMARKS");
			table.className = this.converter.converterClassName(table.name);
			table.classNameCamel = StringUtil.lowerFirst(table.className);
			table.classNameUpper = table.className.toUpperCase();
			table.classNameLower = table.className.toLowerCase();
			if (table.remark == null || table.remark.trim().length()==0) {
				table.remark = "数据库表"+table.name;
			}
			table.columns = buildColumns(table.name);
			table.idColumn = buildIdColumn(table.name);
			for (TableColumn column : table.columns) {
				if (column.name.equals(table.idColumn.name)) {
					table.idColumn = column;
					break;
				}
			}
			tables.add(table);
		}
		return tables;
	}

	private TableColumn buildIdColumn(String tableName) throws SQLException{
		TableColumn column = new TableColumn();
		ResultSet keyset = databaseMetaData.getPrimaryKeys(null, null, tableName);
		while (keyset.next()) {
			column.name = keyset.getString("COLUMN_NAME");
			break;
		}
		return column;
	}

	private List<TableColumn> buildColumns(String tableName) throws SQLException {
		ResultSet resultSet = databaseMetaData.getColumns(null, "%", tableName, "%");
		List<TableColumn> columns = new ArrayList<TableColumn>();
		while (resultSet.next()) {
			TableColumn column = new TableColumn();
			column.name = resultSet.getString("COLUMN_NAME");
			column.type = resultSet.getString("TYPE_NAME");
			column.typeInt = resultSet.getInt("DATA_TYPE");
			column.lenght = resultSet.getInt("COLUMN_SIZE");
			column.remark = resultSet.getString("REMARKS");
			column.fieldName = this.converter.converterFieldName(column.name);
			column.fieldType = this.converter.converterfieldType(column.typeInt);
			column.fieldNameUpper = StringUtil.upperFirst(column.fieldName);
			column.fieldNameLower = StringUtil.lowerFirst(column.fieldName);
			if (column.remark == null || column.remark.trim().length()==0) {
				column.remark = "数据库列"+column.name;
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
