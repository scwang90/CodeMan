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
import java.util.stream.Collectors;

@SuppressWarnings("WeakerAccess")
public class DefaultModelBuilder implements ModelBuilder {

	protected final ProjectConfig config;
	protected final TableSource tableSource;
	protected final TableFilter tableFilter;
	protected final WordBreaker wordBreaker;
	protected final ClassConverter classConverter;
	protected final JdbcLang jdbcLang = new JdbcLang();

	public DefaultModelBuilder(ProjectConfig config, TableSource tableSource) {
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

		table.setUrlPathName(buildUrlPath(table));

		if (table.getRemark() == null || table.getRemark().trim().length()==0) {
			table.setRemark(tableSource.queryTableRemark(tableMate));
		}
		if (table.getRemark() == null || table.getRemark().trim().length()==0) {
			table.setRemark(tableMate.getName());
		}

		return tableComputeColumn(table, tableMate);
	}

    protected String buildUrlPath(Table table) {
        String division = this.config.getTableDivision();
        if (division == null || division.length() == 0) {
            division = "_";
        }
        if (table.getName().contains(division)) {
            return table.getName().toLowerCase().replace(division, "-");
        }
        StringBuilder builder = new StringBuilder();
        String className = table.getClassName();
        for (int i = 0, lc = 0; i < className.length(); i++) {
            char c = className.charAt(i);
            int cc = c & 0b00100000;
            if (cc == 0 && lc != cc) {
                builder.append('-');
            }
            builder.append((char)(c | 0b00100000));
            lc = cc;
        }
        return builder.toString();
    }

    protected Table tableComputeColumn(Table table, MetaDataTable tableMate) throws Exception {
		List<String> keys = tableSource.queryPrimaryKeys(tableMate);

		List<? extends MetaDataColumn> listMetaData = tableSource.queryColumns(tableMate);
		List<TableColumn> columns = new ArrayList<>(listMetaData.size());
		for (MetaDataColumn columnMate : listMetaData) {
			TableColumn column = tableSource.buildColumn(columnMate);
			if (keys.contains(column.getName())) {
				if (table.getIdColumn() == null) {
					table.setIdColumn(column);
				}
				if (column.getTypeInt() == Types.DECIMAL || column.getTypeInt() == Types.NUMERIC || column.getTypeInt() == Types.DOUBLE) {
					column.setTypeInt(Types.BIGINT);
				}
			}
			column.setPrimaryKey(keys.contains(columnMate.getName()));
			columns.add(columnCompute(column, columnMate));
			System.out.println("构建列【" + table.getName() + "】【" + column.getName() + "】模型完成（" + columns.size() + "）");
		}
        if (table.getIdColumn() == null) {
            columns.stream().filter(c->!c.isNullable()&&c.getName().toLowerCase().endsWith("id")).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null) {
            columns.stream().filter(c->!c.isNullable()).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null) {
            columns.stream().filter(c->c.getName().toLowerCase().endsWith("id")).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null) {
            if (columns.size() > 0) {
                table.setIdColumn(columns.get(0));
            } else {
                table.setIdColumn(columnKeyDefault(columns));
            }
        }
        TableColumn id = table.getIdColumn();
        if (id != null) {
            if (id.getTypeInt() == Types.DECIMAL || id.getTypeInt() == Types.NUMERIC || id.getTypeInt() == Types.DOUBLE) {
                id.setTypeInt(Types.BIGINT);
            }
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