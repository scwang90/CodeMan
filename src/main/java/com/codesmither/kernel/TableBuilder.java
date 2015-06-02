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

public class TableBuilder {

	private Converter converter = null;
	private Connection connection = null;
	private boolean autoclose = true;
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
		// TODO Auto-generated method stub
		if (autoclose) {
			this.connection.close();
		}
		super.finalize();
	}

	public List<Table> build() throws SQLException {
		databaseMetaData = this.connection.getMetaData();
		ResultSet resultSet = databaseMetaData.getTables(null, "%", "%",
				new String[] { "TABLE" });
		return buildTables(resultSet);
	}

	private List<Table> buildTables(ResultSet resultSet) throws SQLException {
		// TODO Auto-generated method stub
		List<Table> tables = new ArrayList<Table>();
		while (resultSet.next()) {
			Table table = new Table();
			table.name = resultSet.getString("TABLE_NAME");
			table.remark = resultSet.getString("REMARKS");
			table.className = this.converter.converterClassName(table.name);
			if (table.remark == null || table.remark.trim().length()==0) {
				table.remark = table.remark;
			}
			table.columns = buildColumns(table.name);
			tables.add(table);
		}
		return tables;
	}

	private List<TableColumn> buildColumns(String tableName) throws SQLException {
		// TODO Auto-generated method stub
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
			column.fieldName_u = StringUtil.upperFirst(column.fieldName);
			column.fieldName_l = StringUtil.lowerFirst(column.fieldName);
			if (column.remark == null || column.remark.trim().length()==0) {
				column.remark = column.remark;
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
