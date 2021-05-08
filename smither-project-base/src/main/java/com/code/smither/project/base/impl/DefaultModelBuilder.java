package com.code.smither.project.base.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.api.internel.*;
import com.code.smither.project.base.constant.AbstractProgramLang;
import com.code.smither.project.base.constant.JdbcLang;
import com.code.smither.project.base.model.*;
import com.code.smither.project.base.util.PinYinUtil;
import com.code.smither.project.base.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.DatabaseMetaData;
import java.sql.Types;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

@SuppressWarnings("WeakerAccess")
public class DefaultModelBuilder implements ModelBuilder {

	protected final ProjectConfig config;
	protected final TableSource tableSource;
	protected final TableFilter tableFilter;
	protected final WordBreaker wordBreaker;
	protected final WordReplacer wordReplacer;
	protected final ClassConverter classConverter;
	protected final ProgramLang programLang;
	protected final JdbcLang jdbcLang = new JdbcLang();

	private static final Logger logger = LoggerFactory.getLogger(DefaultModelBuilder.class);
	private static final Pattern regex = Pattern.compile("^(\\S{2,}?)(?::\\n|：\\n|\\s+|:|：|,|，|\\n|\\(|（)((?:.|\\n)+?)[)）]?$");

	public DefaultModelBuilder(ProjectConfig config, TableSource tableSource) {
		this.config = config;
		this.tableSource = tableSource;
		this.tableFilter = config.getTableFilter();
		this.classConverter = config.getClassConverter();
		this.wordBreaker = config.getWordBreaker();
		this.wordReplacer = config.getWordReplacer();
		this.programLang = AbstractProgramLang.getLang(config.getTemplateLang());
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
		model.setLang(config.getTemplateLang());
		model.setTables(tables);
//		model.setLoginTable(findLoginTable(tables, config.getTableLogin(), model::setHasLogin));

		model.setLoginTable(findTable(tables, config.getTableLogin(), model::setHasLogin));
		model.setOrganTable(findTable(tables, config.getTableOrgan(), model::setHasOrgan));

		model.setHasCode(findColumn(tables, Table::isHasCode, Table::getCodeColumn, model::setCodeColumn));
		model.setHasOrgan(findColumn(tables, Table::isHasOrgan, Table::getOrgColumn, model::setOrgColumn));
		checkForeginKey(tables);
		return model;
	}

	private static void checkForeginKey(List<Table> tables) {
		for (Table table : tables) {
			for (ForeignKey key : table.getImportedKeys()) {
				key.setPkTable(table);
				tables.stream().filter(t->t.getName().equals(key.getFkName())).findFirst().ifPresent(key::setFkTable);
			}
			for (ForeignKey key : table.getExportedKeys()) {
				key.setPkTable(table);
				tables.stream().filter(t->t.getName().equals(key.getFkName())).findFirst().ifPresent(pkTable -> {
					key.setPkTable(pkTable);
					if (key.getDeleteRule() == DatabaseMetaData.importedKeyNoAction
							|| key.getDeleteRule() == DatabaseMetaData.importedKeyRestrict) {
						table.pushExportedTable(pkTable);
					}
				});
			}
		}
	}

	private static Table findTable(List<Table> tables, String tableKey, Action<Boolean> success) {
		Stream<String> keys = Arrays.stream(tableKey.split(","));
		Optional<Table> find = keys.map(key -> {
			return tables.stream().filter(t -> t.getName().equalsIgnoreCase(key)).findFirst().orElse(null);
		}).filter(Objects::nonNull).findFirst();
		if (find.isPresent()) {
			success.onAction(true);
			return find.get();
		}
		keys = Arrays.stream(tableKey.split(","));
		find = keys.map(key -> {
			return tables.stream().filter(t -> t.getName().toLowerCase().contains(key.toLowerCase())).findFirst().orElse(null);
		}).filter(Objects::nonNull).findFirst();
		if (find.isPresent()) {
			success.onAction(true);
			return find.get();
		}
		return new Table();
	}

	private static boolean findColumn(List<Table> tables, IsTableHas tableHas, GetColumn get, SetTableColumn set) {
		TableColumn column = null;
		for (Table table : tables) {
			if (tableHas.has(table)) {
				TableColumn col = get.get(table);
				if (column == null) {
					column = col;
				} else if (col.getComment() != null && (column.getComment() == null || col.getComment().length() > column.getComment().length())) {
					column = col;
				}
			}
		}
		if (column != null) {
			set.set(column);
		}
		return column != null;
	}

	protected List<Table> buildTables() throws Exception {
		List<? extends MetaDataTable> listMetaData = tableSource.queryTables();
		List<Table> tables = new ArrayList<>(listMetaData.size());
		for (MetaDataTable metaData : listMetaData) {
			logger.info("");
			if (tableFilter != null && tableFilter.isNeedFilterTable(metaData.getName())) {
				logger.info("跳过表【" + metaData.getName() + "】");
				continue;
			}
			logger.trace("构建表【"+metaData.getName()+"】模型开始（" + tables.size() + "）");
			tables.add(tableCompute(tableSource.buildTable(metaData), metaData));
			logger.trace("构建表【"+metaData.getName()+"】模型完成（" + tables.size() + "）");
		}
		return tables;
	}

	/**
	 * 完善 table 模型
	 * 根据配置文件完善：类名、小写、大写、骆驼峰、列模型 等信息
	 * @param table 根据数据库表信息初步构建的 table 模型
	 * @param tableMate JDBC 查询出的 表元数据
	 * @return 返回完整信息的 table 模型
	 * @throws Exception 数据库读取异常
	 */
	protected Table tableCompute(Table table, MetaDataTable tableMate) throws Exception {
		String name = this.convertIfNeed(table.getName());
		table.setClassName(this.classConverter.converterClassName(name));
		table.setClassNameUpper(table.getClassName().toUpperCase());
		table.setClassNameLower(table.getClassName().toLowerCase());
		table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));

		table.setUrlPathName(buildUrlPath(table));

		if (StringUtil.isNullOrBlank(table.getRemark())) {
			table.setRemark(tableSource.queryTableRemark(tableMate));
		}

		String remark = table.getRemark();
		if (StringUtil.isNullOrBlank(remark)) {
			table.setRemark(tableMate.getName());
		} else {
			Matcher matcher = regex.matcher(remark);
			if (matcher.find()) {
				table.setRemark(matcher.group(1));
				table.setDescription(matcher.group(2));
			} else if (table.getName().matches("[^\\x00-\\xff]+")) {
				table.setDescription(table.getRemark());
				table.setRemark(table.getName());
			}
		}
		//继续完善 数据表列名数据
		return tableComputeColumn(table, tableMate);
	}

	/**
	 * 根据表名和配置信息构建 API url 路径
	 * @param table 表模型
	 * @return url 路径
	 */
    protected String buildUrlPath(Table table) {
//        String division = this.config.getTableDivision();
//        if (division == null || division.length() == 0) {
//            division = "_";
//        }
//        if (table.getName().contains(division)) {
//            return table.getName().toLowerCase().replace(division, "-");
//        }
        StringBuilder builder = new StringBuilder();
        String className = table.getClassName();
        for (int i = 0, lc = 0; i < className.length(); i++) {
            char c = className.charAt(i);
            int cc = c & 0b00100000;//计算是否小写
            if (cc == 0 && lc != cc) {
                builder.append('-');
            }
            builder.append((char)(c | 0b00100000));//转换成小写
            lc = cc;
        }
        return builder.toString();
    }

	/**
	 * 完善表模型的列列表
	 * 根据 表模型 元数据 构建 列模型列表 并完善列模型
	 * @param table 表模型
	 * @param tableMate 表元数据
	 * @return 表模型
	 * @throws Exception 数据库读取异常
	 */
    protected Table tableComputeColumn(Table table, MetaDataTable tableMate) throws Exception {
		Set<String> keys = tableSource.queryPrimaryKeys(tableMate);
		List<? extends MetaDataForegin> importedKeys = tableSource.queryImportedKeys(tableMate);
		List<ForeignKey> importedForeignKeys = new ArrayList<>(importedKeys.size());
		for (MetaDataForegin key : importedKeys) {
			importedForeignKeys.add(tableSource.buildForeginKey(key));
		}
		table.setImportedKeys(importedForeignKeys);
		List<? extends MetaDataForegin> exportedKeys = tableSource.queryExportedKeys(tableMate);
		List<ForeignKey> exportedForeignKeys = new ArrayList<>(exportedKeys.size());
		for (MetaDataForegin key : exportedKeys) {
			exportedForeignKeys.add(tableSource.buildForeginKey(key));
		}
		table.setExportedKeys(exportedForeignKeys);
		List<? extends MetaDataColumn> listMetaData = tableSource.queryColumns(tableMate);
		List<TableColumn> columns = new ArrayList<>(listMetaData.size());
		for (MetaDataColumn columnMate : listMetaData) {
			TableColumn column = tableSource.buildColumn(columnMate);
			if (keys.contains(column.getName())) {
				if (table.getIdColumn() == null) {
					table.setIdColumn(column);
				}
				if (column.getTypeInt() == Types.DECIMAL || column.getTypeInt() == Types.NUMERIC || column.getTypeInt() == Types.DOUBLE) {
					//主键不应该是小数
					column.setTypeInt(Types.BIGINT);
				}
			}
			column.setPrimaryKey(keys.contains(columnMate.getName()));
			columns.add(columnCompute(column, columnMate));
			logger.info("构建列【" + table.getName() + "】【" + column.getName() + "】模型完成（" + columns.size() + "）");
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
			/*
			 * 主键是一定要有到
			 */
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
				id.setFieldType(this.classConverter.converterFieldType(id));
            }
            table.setHasId(true);
        }

		initTableColumn(columns, config.getColumnOrg(), table::getOrgColumn, table::setOrgColumn, table::setHasOrgan);
		initTableColumn(columns, config.getColumnCode(), table::getCodeColumn, table::setCodeColumn, table::setHasCode);
		initTableColumn(columns, config.getColumnCreate(), table::getCreateColumn, table::setCreateColumn, table::setHasCreate);
		initTableColumn(columns, config.getColumnUpdate(), table::getUpdateColumn, table::setUpdateColumn, table::setHasUpdate);
		initTableColumn(columns, config.getColumnGender(), table::getGenderColumn, table::setGenderColumn, table::setHasGender);
		initTableColumn(columns, config.getColumnRemove(), table::getRemoveColumn, table::setRemoveColumn, table::setHasRemove);
		initTableColumn(columns, config.getColumnCreator(), table::getCreatorColumn, table::setCreatorColumn, table::setHasCreator);
		initTableColumn(columns, config.getColumnPassword(), table::getPasswordColumn, table::setPasswordColumn, table::setHasPassword);
		initTableColumn(columns, config.getColumnUsername(), table::getUsernameColumn, table::setUsernameColumn, table::setHasUsername);

		initTableColumn(columns, config.getColumnHideForClient(), null, column -> column.setHiddenForClient(true), null);
		initTableColumn(columns, config.getColumnHideForSubmit(), null, column -> column.setHiddenForSubmit(true), null);
		if (table.isHasRemove()) {
			Class<?> javaType = programLang.getJavaType(table.getRemoveColumn());
			if (!Integer.class.equals(javaType) && !Boolean.class.equals(javaType) && !String.class.equals(javaType)) {
				table.setHasRemove(false);//类型不符：不能设置为删除列
			}
		}

		table.setColumns(columns);

		table.setRelateTable(isRelateTable(table));
		return table;
	}

	private boolean isRelateTable(Table table) {
		List<TableColumn> columns = new ArrayList<>(table.getColumns().size());
		for (TableColumn column : table.getColumns()) {
			if (!column.isPrimaryKey() && !column.isHiddenForClient() && table.getImportedKeys().stream().noneMatch(k -> column.getName().equals(k.getFkColumnName()))) {
				columns.add(column);
			}
		}
		return columns.size() == 0 && table.getImportedKeys().size() >= 2;
	}

	private void initTableColumn(List<TableColumn> columns, String keys, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		if (!StringUtil.isNullOrBlank(keys)) {
			String[] columnNames = keys.split(",");
			matchColumn(columns, columnNames, get, set, success);
			if (get != null && get.get() == null && keys.contains("_")) {
				columnNames = keys.replace("_", "").split(",");
				matchColumn(columns, columnNames, get, set, success);
			}
		}
		if (get != null && set != null && get.get() == null) {
			set.set(new TableColumn());
		}
	}

	private void matchColumn(List<TableColumn> columns, String[] columnNames, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		for (String columnName : columnNames) {
			Stream<TableColumn> stream = columns.stream().filter(c -> c.getName().equalsIgnoreCase(columnName));
			if (get != null) {
				stream.findFirst().ifPresent(column -> {
					success.onAction(true);
					set.set(column);
				});
				if (get.get() != null) {
					break;
				}
			} else if (set != null) {
				stream.forEach(set::set);
			}
		}
	}

	/**
	 * 完善列模型
	 * 根据 初始列模型 和 列元数据 完善列模型
	 * @param column 初始列模型
	 * @param columnMate 列元数据
	 * @return 返回 完整列模型
	 * @throws Exception 数据库读取异常
	 */
	protected TableColumn columnCompute(TableColumn column, MetaDataColumn columnMate) throws Exception {
		String name = this.convertIfNeed(column.getName());
		column.setTypeJdbc(jdbcLang.getType(column));
		column.setFieldName(this.classConverter.converterFieldName(name));
		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
		column.setFieldType(this.classConverter.converterFieldType(column));
		column.setFieldTypeObject(this.classConverter.converterFieldType(column, ClassConverter.DataType.object));
		column.setFieldTypePrimitive(this.classConverter.converterFieldType(column, ClassConverter.DataType.primitive));
		if (column.isNullable()) {
			column.setFieldType(column.getFieldTypeObject());
		} else {
			column.setFieldType(column.getFieldTypePrimitive());
		}

		Class<?> javaType = programLang.getJavaType(column);
		column.setStringType(String.class.equals(javaType));//(column.getTypeJdbc().contains("CHAR"));//是否是字符串类型
		column.setDateType(Date.class.equals(javaType));//(column.getTypeInt() == Types.DATE || column.getTypeInt() == Types.TIMESTAMP);
		column.setBoolType(Boolean.class.equals(javaType));
		column.setIntType(Integer.class.equals(javaType));

		if (column.getDefValue() != null) {
			column.setDefValue(column.getDefValue().replaceAll("\n$", ""));
		}

		if (StringUtil.isNullOrBlank(column.getRemark())) {
			column.setRemark(tableSource.queryColumnRemark(columnMate));
		}

		String remark = column.getRemark();
		if (StringUtil.isNullOrBlank(remark)) {
			column.setRemark(columnMate.getName());
		} else {
			Matcher matcher = regex.matcher(remark);
			if (matcher.find()) {
				column.setRemark(matcher.group(1));
				column.setDescription(matcher.group(2));
				if (column.getDescription().length() < column.getRemark().length()) {
					column.setDescription(remark);
					column.setDescriptions(null);
				}
			} else if (column.getName().matches("[^\\x00-\\xff]+")) {
				column.setDescription(column.getRemark());
				column.setRemark(column.getName());
			}
		}
		return column;
	}

	/**
	 * 转换如果必要
	 * 根据配置的信息 进行拼音转换、单词打散、词语替换
	 * @param name 数据库名称
	 * @return 替换后的名称
	 */
	protected String convertIfNeed(String name) {
		String origin = name;
		name = ifNeedReplace(name);
		name = ifNeedChineseSpell(name);
		name = ifNeedWordBreak(name, origin);
		return name;//regex:(\d+)\B-$1_
	}

	protected String ifNeedReplace(String name) {
		if (wordReplacer != null) {
			return wordReplacer.replace(name, config.getTableDivision());
		}
		return name;
	}

	protected String ifNeedChineseSpell(String name) {
		return PinYinUtil.getInstance().getSelling(name, config.getTableDivision());
	}

	protected String ifNeedWordBreak(String name, String origin) {
		if (wordBreaker != null && origin.matches("^[A-Z0-9]{5,}$")) {
			return wordBreaker.breaks(name, config.getTableDivision());
		}
		return name;
	}

	/**
	 * 构建默认的 主键列
	 * @param columns 表模型列列表
	 * @return 主键列
	 */
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
		column.setFieldType(this.classConverter.converterFieldType(column));
		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
		return column;
	}

}