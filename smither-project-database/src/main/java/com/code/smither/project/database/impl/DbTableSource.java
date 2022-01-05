package com.code.smither.project.database.impl;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.ForeignKey;
import com.code.smither.project.base.model.IndexedKey;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.database.api.DbDataSource;
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

	protected ProjectConfig config;
    protected DbDataSource dataSource;

	private static final Logger logger = LoggerFactory.getLogger(DbTableSource.class);

	public DbTableSource(ProjectConfig config, DbDataSource dataSource) {
		super();
		this.config = config;
		this.dataSource = dataSource;
	}

    @Override
    public Database getDatabase() {
        return dataSource.getDatabase();
    }

	@Override
	public List<? extends Table> queryTables() throws SQLException {
		ResultSet resultTable = this.dataSource.queryTables();
        List<Table> tables = new ArrayList<>();
		while (resultTable.next()) {
			tables.add(this.dataSource.tableFromResultSet(resultTable, newMetaDataTable()));
		}
		resultTable.close();
		return tables;
	}

	@Override
	public List<? extends TableColumn> queryColumns(Table table) throws SQLException {
		List<TableColumn> columns = new LinkedList<>();
		// ResultSet resultColumn = queryColumns(databaseMetaData, table.getName());
		ResultSet resultColumn = this.dataSource.queryColumns(table.getName());
		while (resultColumn.next()) {
			columns.add(this.dataSource.columnFromResultSet(resultColumn, newMetaDataColumn()));
		}
		resultColumn.close();
		return columns;
	}

    @Override
	public Set<String> queryPrimaryKeys(Table table) throws SQLException {
		Set<String> keys = new LinkedHashSet<>();
		// ResultSet result = queryPrimaryKeys(databaseMetaData, table.getName());
		ResultSet result =  this.dataSource.queryPrimaryKeys(table.getName());
		while (result.next()) {
			keys.add(result.getString("COLUMN_NAME"));
		}
		result.close();
		return keys;
	}

	@Override
	public List<? extends IndexedKey> queryIndexKeys(Table table) throws Exception {
		List<IndexedKey> keys = new LinkedList<>();
		try (ResultSet result = this.dataSource.queryIndexedKeys(table.getName())) {
			while (result.next()) {
				keys.add(indexFromResultSet(result));
			}
		}
		List<IndexedKey> list = keys.stream().distinct().collect(Collectors.toList());
		if (list.size() != keys.size()) {
			logger.warn("表【" + table.getName() + "】索引出现重复，已经排重：" + keys.size() + "->" + list.size());
			return list;
		}
		return keys;
	}

	@Override
	public List<? extends ForeignKey> queryImportedKeys(Table table) throws Exception {
		List<ForeignKey> keys = new LinkedList<>();
        try (ResultSet result = this.dataSource.queryImportedKeys(table.getName())) {
			while (result.next()) {
				keys.add(foreignFromResultSet(result));
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
	public List<? extends ForeignKey> queryExportedKeys(Table table) throws Exception {
		List<ForeignKey> keys = new LinkedList<>();
		try (ResultSet result = this.dataSource.queryExportedKeys(table.getName())) {
			while (result.next()) {
				keys.add(foreignFromResultSet(result));
			}
		}
		List<ForeignKey> list = keys.stream().distinct().collect(Collectors.toList());
		if (list.size() != keys.size()) {
			logger.warn("表【" + table.getName() + "】导出外键出现重复，已经排重：" + keys.size() + "->" + list.size());
			return list;
		}
		return keys;
	}

	private IndexedKey indexFromResultSet(ResultSet result) throws SQLException {
		IndexedKey index = new IndexedKey();

		index.setTableCat(result.getString("TABLE_CAT"));							//(FIELD_TYPE_CHAR)
		index.setTableSchem(result.getString("TABLE_SCHEM"));							//(FIELD_TYPE_CHAR)
		index.setTableName(result.getString("TABLE_NAME"));							//(FIELD_TYPE_CHAR)
		index.setNonUnique(result.getBoolean("NON_UNIQUE"));							//(FIELD_TYPE_BOOLEAN)
		index.setIndexQualifier(result.getString("INDEX_QUALIFIER"));							//(FIELD_TYPE_CHAR)
		index.setIndexName(result.getString("INDEX_NAME"));							//(FIELD_TYPE_CHAR)
		index.setType(result.getInt("TYPE"));							//(FIELD_TYPE_SMALLINT)
		index.setOrdinalPosition(result.getInt("ORDINAL_POSITION"));							//(FIELD_TYPE_SMALLINT)
		index.setColumnName(result.getString("COLUMN_NAME"));							//(FIELD_TYPE_CHAR)
		index.setAscOrDesc(result.getString("ASC_OR_DESC"));							//(FIELD_TYPE_CHAR)
		index.setCardinality(result.getLong("CARDINALITY"));							//(FIELD_TYPE_BIGINT)
		index.setPages(result.getLong("PAGES"));							//(FIELD_TYPE_BIGINT)
		index.setFilterCondition(result.getString("FILTER_CONDITION"));							//(FIELD_TYPE_CHAR)

		return index;
	}

	private ForeignKey foreignFromResultSet(ResultSet result) throws SQLException {
		ForeignKey foreign = new ForeignKey();
		foreign.setIndex(result.getInt("KEY_SEQ"));
		foreign.setFkName(result.getString("FK_NAME"));
		foreign.setPkName(result.getString("PK_NAME"));
		foreign.setPkTableName(result.getString("PKTABLE_NAME"));
		foreign.setPkColumnName(result.getString("PKCOLUMN_NAME"));
		foreign.setFkTableName(result.getString("FKTABLE_NAME"));
		foreign.setFkColumnName(result.getString("FKCOLUMN_NAME"));
		foreign.setUpdateRule(result.getInt("UPDATE_RULE"));
		foreign.setDeleteRule(result.getInt("DELETE_RULE"));
		return foreign;
	}

	@Override
	public String queryTableRemark(Table tableMate) throws SQLException {
		return this.dataSource.queryTableRemark(tableMate);
	}

	@Override
	public String queryColumnRemark(TableColumn columnMate) throws SQLException {
		return this.dataSource.queryColumnRemark(columnMate);
	}

	protected Table newMetaDataTable() {
        return new Table();
    }

	protected TableColumn newMetaDataColumn() {
        return new TableColumn();
    }

    @SuppressWarnings("unused")
	public void printResultSet(ResultSet result) throws SQLException {
		ResultSetMetaData metaData = result.getMetaData(); 
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
        	System.out.println(metaData.getColumnName(i)+"="+result.getObject(i));
		}
	}

}
