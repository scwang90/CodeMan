package com.code.smither.project.base.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.JdbcLang;
import com.code.smither.project.base.model.DatabaseJdbc;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.PinYinUtil;
import com.code.smither.project.base.util.StringUtil;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("WeakerAccess")
public class RootModelBuilder implements ModelBuilder {

	protected final ProjectConfig config;
	protected final TableSource tableSource;
	protected final TableFilter tableFilter;
	protected final WordBreaker wordBreaker;
	protected final ClassConverter classConverter;
	protected final JdbcLang jdbcLang = new JdbcLang();

	public RootModelBuilder(ProjectConfig config, TableSource tableSource) {
		this.config = config;
		this.tableSource = tableSource;
		this.tableFilter = config.getTableFilter();
		this.classConverter = config.getClassConverter();
		this.wordBreaker = config.getWordBreaker();
	}

	@Override
	public RootModel build() throws Exception {
		return build(new SourceModel(), config, buildTables());
	}

	public static SourceModel build(SourceModel model, ProjectConfig config, List<Table> tables) {
		model.setUpNow(config.getNow());
		model.setAuthor(config.getTargetProjectAuthor());
		model.setCharset(config.getTargetCharset());
		model.setPackageName(config.getTargetProjectPackage());
		model.setProjectName(config.getTargetProjectName());
		model.setJdbc(new DatabaseJdbc());
		model.setTables(tables);
		return model;
	}

	protected List<Table> buildTables() throws Exception {
		List<? extends MetaDataTable> listMetaData = tableSource.queryTables();
		List<Table> tables = new ArrayList<>(listMetaData.size());
		for (MetaDataTable metaData : listMetaData) {
			System.out.println();
			if (tableFilter != null && tableFilter.isNeedFilterTable(metaData.getName())) {
				System.out.println("跳过表【" + metaData.getName() + "】");
				continue;
			}
			System.out.println("构建表【"+metaData.getName()+"】模型开始（" + tables.size() + "）");
			tables.add(tableCompute(tableSource.buildTable(metaData), metaData));
			System.out.println("构建表【"+metaData.getName()+"】模型完成（" + tables.size() + "）");
		}
		return tables;
	}

	protected Table tableCompute(Table table, MetaDataTable tableMate) throws Exception {
		String name = this.convertIfNeed(table.getName());
		table.setClassName(this.classConverter.converterClassName(name));
		table.setClassNameUpper(table.getClassName().toUpperCase());
		table.setClassNameLower(table.getClassName().toLowerCase());
		table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));

		String division = this.config.getTableDivision();
		if (division == null || division.length() == 0) {
			division = "_";
		}
		table.setUrlPathName(table.getName().toLowerCase().replace(division,"-"));

		if (table.getRemark() == null || table.getRemark().trim().length()==0) {
			table.setRemark(tableSource.queryTableRemark(tableMate));
		}
		if (table.getRemark() == null || table.getRemark().trim().length()==0) {
			table.setRemark(tableMate.getName());
		}

		return tableComputeColumn(table, tableMate);
	}

	protected Table tableComputeColumn(Table table, MetaDataTable tableMate) throws Exception {
		List<String> keys = tableSource.queryPrimaryKeys(tableMate);

		List<? extends MetaDataColumn> listMetaData = tableSource.queryColumns(tableMate);
		List<TableColumn> columns = new ArrayList<>(listMetaData.size());
		for (MetaDataColumn columnMate : listMetaData) {
			TableColumn column = tableSource.buildColumn(columnMate);
			if (keys.contains(column.getName()) || (keys.isEmpty() && column.getName().toLowerCase().endsWith("id"))) {
				if (table.getIdColumn() == null) {
					table.setIdColumn(column);
				}
				if (column.getTypeInt() == Types.DECIMAL || column.getTypeInt() == Types.NUMERIC) {
					column.setTypeInt(Types.BIGINT);
				}
			}
			column.setPrimaryKey(keys.contains(columnMate.getName()));
			columns.add(columnCompute(column, columnMate));
			System.out.println("构建列【" + table.getName() + "】【" + column.getName() + "】模型完成（" + columns.size() + "）");
		}
		if (table.getIdColumn() == null) {
			table.setIdColumn(columnKeyDefault(columns));
		}
		table.setColumns(columns);
		return table;
	}

	protected TableColumn columnCompute(TableColumn column, MetaDataColumn columnMate) throws Exception {
		String name = this.convertIfNeed(column.getName());
		column.setTypeJdbc(jdbcLang.getType(column.getTypeInt()));
		column.setFieldName(this.classConverter.converterFieldName(name));
		column.setFieldType(this.classConverter.converterFieldType(column.getTypeInt()));
		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

		if (column.getRemark() == null || column.getRemark().trim().length() == 0) {
			column.setRemark(tableSource.queryColumnRemark(columnMate));
		}
		if (column.getRemark() == null || column.getRemark().trim().length() == 0) {
			column.setRemark(columnMate.getName());
		}
		return column;
	}

	protected String convertIfNeed(String name) {
		name = ifNeedChineseSpell(name);
		name = ifNeedWordBreak(name);
		return name;
	}

	private String ifNeedChineseSpell(String name) {
		return PinYinUtil.getInstance().getSelling(name, config.getTableDivision());
	}

	protected String ifNeedWordBreak(String name) {
		if (wordBreaker != null && name.matches("^[A-Z]{5,}$")) {
			return wordBreaker.breaks(name, config.getTableDivision());
		}
		return name;
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

}