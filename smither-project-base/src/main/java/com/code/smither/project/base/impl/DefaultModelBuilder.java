package com.code.smither.project.base.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.api.internel.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.constant.JdbcLang;
import com.code.smither.project.base.model.*;
import com.code.smither.project.base.util.ModelUtil;
import com.code.smither.project.base.util.PinYinUtil;
import com.code.smither.project.base.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.DatabaseMetaData;
import java.sql.Types;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@SuppressWarnings("WeakerAccess")
public class DefaultModelBuilder implements ModelBuilder {

	protected final ProjectConfig config;
	protected final TableSource tableSource;
	protected final TableFilter tableFilter;
	protected final WordBreaker wordBreaker;
	protected final WordReplacer wordReplacer;
	protected final ProgramLang programLang;
	protected final ClassConverter classConverter;
	protected final JdbcLang jdbcLang = new JdbcLang();
	protected final LangClassConverter converterJava = new LangClassConverter(ProgramLang.Lang.Java.lang);
	protected final LangClassConverter converterCSharp = new LangClassConverter(ProgramLang.Lang.CSharp.lang);
	protected final LangClassConverter converterKotlin = new LangClassConverter(ProgramLang.Lang.Kotlin.lang);
	protected final LangClassConverter converterTypeScript = new LangClassConverter(ProgramLang.Lang.TypeScript.lang);

	private static final Logger logger = LoggerFactory.getLogger(DefaultModelBuilder.class);

	private static final Pattern remarkRegex = Pattern.compile("^(\\S{2,}?)((?::\\r?\\n|：\\r?\\n|\\s+|:|：|,|，|\\r?\\n|\\(|（)(?:.|\\r?\\n)+?[)）]?)$");

	public DefaultModelBuilder(ProjectConfig config, TableSource tableSource) {
		this.config = config;
		this.tableSource = tableSource;
		this.tableFilter = config.getTableFilter();
		this.classConverter = config.getClassConverter();
		this.wordBreaker = config.getWordBreaker();
		this.wordReplacer = config.getWordReplacer();
		this.programLang = ProgramLang.Lang.getLang(config.getTemplateLang());
	}

	@Override
	public RootModel build() throws Exception {
		return build(new SourceModel(), config, buildTables());
	}

	@Override
	public void preRunTask(Task task, RootModel root) {
		if (root instanceof SourceModel) {
			classConverter.bindTask(task);
			((SourceModel) root).bindClassConverter(classConverter);
		}
	}

	public static SourceModel build(SourceModel model, ProjectConfig config, List<Table> tables) {
		model.setUpNow(config.getNow());
		model.setAuthor(config.getTargetProjectAuthor());
		model.setCharset(config.getTargetCharset());
		model.setPackageName(config.getTargetProjectPackage());
		model.setProjectName(config.getTargetProjectName());
		model.setProjectClassName(StringUtil.camel(config.getTargetProjectName(),"-|_"));
		model.setProjectRemark(config.getTargetProjectRemark());
		model.setProjectDetail(config.getTargetProjectDetail());
		model.setJdbc(new DatabaseJdbc());
		model.setLang(config.getTemplateLang());
		model.setTables(tables);
		model.setCustom(config.getCustomModel());
		
		model.setFeatures(new Features(Arrays.asList(config.getTargetFeatures().split("[,;]"))));

		model.setOrganTable(findTable(tables, config.getTableOrgan(), model::setHasOrgan));
		model.setLoginTable(findTable(tables, config.getTableLogin(), model::setHasLogin));
		model.setLoginTables(findTables(tables, config.getTableLogin(), size -> model.setHasMultiLogin(size > 1)));
		//标记表为登录表
		model.getLoginTable().setLoginTable(true);
		model.getLoginTables().forEach(t->t.setLoginTable(true));

		model.setHasCode(findColumn(tables, Table::isHasCode, Table::getCodeColumn, model::setCodeColumn));
		model.setHasOrgan(findColumn(tables, Table::isHasOrgan, Table::getOrgColumn, model::setOrgColumn));
		//项目总特性中 是否包含机构，需要同时含有登录、并且登录表中含有机构Id 才算
		model.setHasOrgan(model.isHasOrgan() && (!model.isHasLogin() || model.getLoginTable().isHasOrgan()));
		checkIndexedKey(tables);
		checkForeignKey(model, config, tables);
		return model;
	}

	private static void checkIndexedKey(List<Table> tables) {
		for (Table table : tables) {
			table.setIndexedKeys(table.getIndexKeys().stream().filter(i->{
				i.setTable(table);
				i.setColumn(table.getColumns().stream().filter(c->c.getName().equals(i.getColumnName())).findFirst().orElse(null));
				return i.getColumn() != table.getIdColumn() && table.getImportedKeys().stream().noneMatch(k->k.getFkColumnName().equals(i.getColumnName()));
			}).collect(Collectors.toList()));
		}
	}

	private static void checkForeignKey(SourceModel model, ProjectConfig config, List<Table> tables) {
		for (Table table : tables) {
			table.setImportCascadeKeys(table.getImportedKeys().stream().filter(key->{
				key.setFkTable(table);
				table.getColumns().stream().filter(c->c.getName().equals(key.getFkColumnName())).findFirst().ifPresent(key::setFkColumn);
				tables.stream().filter(t->t.getName().equals(key.getPkTableName())).findFirst().ifPresent(pkTable -> {
					key.setPkTable(pkTable);
					pkTable.getColumns().stream().filter(c->c.getName().equals(key.getPkColumnName())).findFirst().ifPresent(key::setPkColumn);
					if (key.getPkColumn().isPrimaryKey() && Arrays.stream(config.getTableNoCascade().split("[,;]")).noneMatch(k -> matchNames(table.getName(), k))) {
						key.setCascade(pkTable != model.getOrganTable() && Arrays.stream(config.getTableNoCascade().split("[,;]")).noneMatch(k -> matchNames(pkTable.getName(), k)));
					}
				});
				if (key.getPkColumn() == null || key.getFkColumn() == null) {
					logger.warn("构建表【"+table.getName()+"】导入外键不匹配（" + key + "）");
					return false;
				}
				return key.isCascade();
			}).collect(Collectors.toList()));
			table.setExportCascadeKeys(table.getExportedKeys().stream().filter(key->{
				key.setPkTable(table);
				table.getColumns().stream().filter(c->c.getName().equals(key.getPkColumnName())).findFirst().ifPresent(key::setPkColumn);
				tables.stream().filter(t->t.getName().equals(key.getFkTableName())).findFirst().ifPresent(fkTable -> {
					key.setFkTable(fkTable);
					fkTable.getColumns().stream().filter(c->c.getName().equals(key.getFkColumnName())).findFirst().ifPresent(key::setFkColumn);
					if (key.getDeleteRule() != DatabaseMetaData.importedKeySetDefault
							|| key.getDeleteRule() != DatabaseMetaData.importedKeySetNull) {
						if (Arrays.stream(config.getTableNoCascade().split("[,;]")).noneMatch(k -> matchNames(table.getName(), k))) {
							key.setCascade(!fkTable.isRelateTable() && table != model.getOrganTable() && Arrays.stream(config.getTableNoCascade().split("[,;]")).noneMatch(k -> matchNames(fkTable.getName(), k)));
						}
					}
				});
				if (key.getPkColumn() == null || key.getFkColumn() == null) {
					logger.warn("构建表【"+table.getName()+"】导出外键不匹配（" + key + "）");
					return false;
				}
				return key.isCascade();
			}).collect(Collectors.toList()));
			table.setImportedKeys(table.getImportedKeys().stream().filter(key -> key.getPkColumn() != null && key.getFkColumn() != null).collect(Collectors.toList()));
			table.setExportedKeys(table.getExportedKeys().stream().filter(key -> key.getPkColumn() != null && key.getFkColumn() != null).collect(Collectors.toList()));
		}
		for (Table table : tables) {
			table.setRelateCascadeKeys(table.getExportedKeys().stream().filter(key->key.getFkTable().isRelateTable()).map(key->{
				RelatedKey relatedKey = new RelatedKey();
				relatedKey.setLocalKey(key);
				relatedKey.setLocalTable(table);
				relatedKey.setLocalColumn(key.getPkColumn());
				relatedKey.setRelateTable(key.getFkTable());
				relatedKey.setRelateLocalColumn(key.getFkColumn());
				key.getFkTable().getImportedKeys().stream().filter(k -> k.getPkTable() != table).findFirst().ifPresent(k-> {
					relatedKey.setTargetKey(k);
					relatedKey.setTargetTable(k.getPkTable());
					relatedKey.setTargetColumn(k.getPkColumn());
					relatedKey.setRelateTargetColumn(k.getFkColumn());
				});
				return relatedKey;
			}).filter(k->k.getRelateTable()!=null).collect(Collectors.toList()));
		}
	}

	private static Table findTable(List<Table> tables, String tableKey, Action<Boolean> success) {
		Table table = matchTable(tables, tableKey.split("[,;]"));
		if (table.getName() != null) {
			success.onAction(true);
		}
		return table;
	}

	private static List<Table> findTables(List<Table> tables, String tableKey, Action<Integer> success) {
		List<Table> find = Arrays.stream(tableKey.split("[,;]")).map(key ->
				tables.stream().filter(t -> matchNames(t.getName(), key)).findFirst().orElse(null))
				.filter(Objects::nonNull).collect(Collectors.toList());
		success.onAction(find.size());
		return find;
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
		List<? extends Table> listMetaData = tableSource.queryTables();
		List<Table> tables = new ArrayList<>(listMetaData.size());
		for (Table table : listMetaData) {
			logger.info("");
			if (tableFilter != null && tableFilter.isNeedFilterTable(table.getName())) {
				logger.info("跳过表【" + table.getName() + "】");
				continue;
			}
			logger.debug("构建表【"+table.getName()+"】模型开始（" + (tables.size() + 1) + "）");
			tables.add(tableCompute(table));
			logger.info("构建表【"+table.getName()+"】模型完成（" + tables.size() + "）");
		}

		return ModelUtil.distinctTables(tables);
	}

	public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
		Map<Object,Boolean> seen = new ConcurrentHashMap<>();
		return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
	}

	/**
	 * 完善 table 模型
	 * 根据配置文件完善：类名、小写、大写、骆驼峰、列模型 等信息
	 * @param table 根据数据库表信息初步构建的 table 模型
	 * @return 返回完整信息的 table 模型
	 * @throws Exception 数据库读取异常
	 */
	protected Table tableCompute(Table table) throws Exception {
		String name = this.convertTableIfNeed(table.getName());
		table.setClassName(this.classConverter.converterClassName(name));
		table.setClassNameUpper(table.getClassName().toUpperCase());
		table.setClassNameLower(table.getClassName().toLowerCase());
		table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));

		table.setUrlPathName(buildUrlPath(table));

		Database database = this.tableSource.getDatabase();
		if (database != null && database.isKeyword(table.getName())) {
			table.setNameSql(database.wrapperKeyword(table.getName()));
		}

		if (StringUtil.isNullOrBlank(table.getRemark())) {
			table.setRemark(tableSource.queryTableRemark(table));
		}

		String remark = table.getRemark();
		if (StringUtil.isNullOrBlank(remark)) {
			table.setRemark(table.getName());
		} else {
			Matcher matcher = remarkRegex.matcher(remark);
			if (matcher.find()) {
				table.setRemark(matcher.group(1));
				table.setDescription(matcher.group(2));
			} else if (table.getName().matches("[^\\x00-\\xff]+")) {
				table.setDescription(table.getRemark());
				table.setRemark(table.getName());
			}
		}
		//继续完善 数据表列名数据
		return tableComputeColumn(table);
	}

	/**
	 * 根据表名和配置信息构建 API url 路径
	 * @param table 表模型
	 * @return url 路径
	 */
    protected String buildUrlPath(Table table) {
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
	 * @return 表模型
	 * @throws Exception 数据库读取异常
	 */
    protected Table tableComputeColumn(Table table) throws Exception {
		Set<String> keys = tableSource.queryPrimaryKeys(table);
		table.setIndexKeys(tableSource.queryIndexKeys(table).stream().map(k->(IndexedKey)k).collect(Collectors.toList()));
		table.setImportedKeys(tableSource.queryImportedKeys(table).stream().map(k->(ForeignKey)k).collect(Collectors.toList()));
		table.setExportedKeys(tableSource.queryExportedKeys(table).stream().map(k->(ForeignKey)k).collect(Collectors.toList()));

		Map<String, ForeignKey> importedKeyMap = new LinkedHashMap<>();
		Map<String, ForeignKey> exportedKeyMap = new LinkedHashMap<>();

		Map<String, ForeignKey> importedKeyReduced = table.getImportedKeys().stream().reduce(importedKeyMap, (BiFunction<Map<String, ForeignKey>, ForeignKey, Map<String, ForeignKey>>) (map, key) -> {
			map.put(key.getFkName(), key);
			return map;
		}, (map1, map2) -> {
			map1.putAll(map2);
			return map1;
		});
		if (table.getImportedKeys().size() != importedKeyReduced.size()) {
			logger.info("构建表【" + table.getName() + "】imported 排重（" + table.getImportedKeys().size() + " -> " + importedKeyReduced.size() + "）");
		}

		Map<String, ForeignKey> exportedKeyReduced = table.getExportedKeys().stream().reduce(exportedKeyMap, (BiFunction<Map<String, ForeignKey>, ForeignKey, Map<String, ForeignKey>>) (map, key) -> {
			map.put(key.getFkName(), key);
			return map;
		}, (map1, map2) -> {
			map1.putAll(map2);
			return map1;
		});
		if (table.getExportedKeys().size() != exportedKeyReduced.size()) {
			logger.info("构建表【" + table.getName() + "】exported 排重（" + table.getImportedKeys().size() + " -> " + importedKeyReduced.size() + "）");
		}

		table.setImportedKeys(new ArrayList<>(importedKeyReduced.values()));
		table.setExportedKeys(new ArrayList<>(exportedKeyReduced.values()));

		List<? extends TableColumn> listMetaData = tableSource.queryColumns(table);
		List<TableColumn> columns = new ArrayList<>(listMetaData.size());
		List<TableColumn> idColumns = new ArrayList<>(listMetaData.size());
		for (TableColumn column : listMetaData) {
			if (keys.contains(column.getName())) {
				if (table.getIdColumn() == null) {
					table.setIdColumn(column);
				}
				idColumns.add(column);
//				if (column.getTypeInt() == Types.DECIMAL || column.getTypeInt() == Types.NUMERIC || column.getTypeInt() == Types.DOUBLE) {
//					//主键不应该是小数
//					column.setTypeInt(Types.BIGINT);
//				}
			}
			column.setPrimaryKey(keys.contains(column.getName()));
			columns.add(columnCompute(column));
			logger.info("构建列【" + table.getName() + "】【" + column.getName() + "】模型完成（" + columns.size() + "）");
		}
        if (table.getIdColumn() == null && config.isSmartFindId()) {
            columns.stream().filter(c->!c.isNullable()&&c.getName().toLowerCase().endsWith("id")).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null && config.isSmartFindId()) {
            columns.stream().filter(c->!c.isNullable()).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null && config.isSmartFindId()) {
            columns.stream().filter(c->c.getName().toLowerCase().endsWith("id")).findFirst().ifPresent(table::setIdColumn);
        }
        if (table.getIdColumn() == null && config.isSmartFindId() && columns.size() > 0) {
			/*
			 * 主键是一定要有到
			 */
			table.setIdColumn(columns.get(0));
        }
        TableColumn id = table.getIdColumn();
        if (id != null) {
            if (id.getTypeInt() == Types.DECIMAL || (id.getTypeInt() == Types.NUMERIC && !id.isLongType() && !id.isIntType()) || id.getTypeInt() == Types.DOUBLE) {
				logger.warn("构建列【" + table.getName() + "】【" + id.getName() + "】主键纠正为LONG（" + id.getFieldType() + "）");
				id.setTypeInt(Types.BIGINT);
				bindColumnFieldType(id);
            }
            table.setHasId(true);
        } else {
			table.setIdColumn(columnKeyDefault());
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

		initTableColumn(columns, config.getColumnForceUseLong(), null, column -> column.setForceUseLong(true), null);
		initTableColumn(columns, config.getColumnHideForTables(), null, column -> column.setHiddenForTables(true), null);
		initTableColumn(columns, config.getColumnHideForClient(), null, column -> column.setHiddenForClient(true), null);
		initTableColumn(columns, config.getColumnHideForSubmit(), null, column -> column.setHiddenForSubmit(true), null);
		initTableColumn(columns, config.getColumnSearch(), null, column -> {
			if (column.isStringType()) {
				if (column != table.getOrgColumn()) {
					table.getSearchColumns().add(column);
					table.setHasSearches(true);
				} else {
					logger.warn("【" + table.getRemarkName() + "表】【" + column.getRemarkName() + "列】已经是机构列，不能成为搜索列");
				}
			} else {
				logger.warn("【" + table.getRemarkName() + "表】【" + column.getRemarkName() + "列】不是字符串类型，不能成为搜索列");
			}
		}, null);

		//初始化名称列表
		initTableColumn(columns, config.getColumnName(), table::getNameColumn, table::setNameColumn, value -> {});
		if ((table.getNameColumn() == null || table.getNameColumn().getName() == null) && columns.size() > 0) {
			table.setNameColumn(columns.get(columns.size()-1));
		}

		if (table.isHasRemove()) {
			Class<?> javaType = programLang.getJavaType(table.getRemoveColumn());
			if (!Integer.class.equals(javaType) && !Boolean.class.equals(javaType) && !String.class.equals(javaType)) {
				table.setHasRemove(false);//类型不符：不能设置为删除列
			}
		}

		table.setIdColumns(idColumns);
		table.setColumns(ModelUtil.distinctColumns(columns));
		table.setHasIds(idColumns.size() > 1);

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
		return columns.size() == 0 && table.getImportedKeys().size() == 2;
	}

	private void initTableColumn(List<TableColumn> columns, String keys, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		if (!StringUtil.isNullOrBlank(keys)) {
			String[] columnNames = keys.split("[,;]");
			matchColumn(columns, columnNames, get, set, success);
			if (get != null && get.get() == null && keys.contains("_")) {
				columnNames = keys.replace("_", "").split("[,;]");
				matchColumn(columns, columnNames, get, set, success);
			}
		}
		if (get != null && set != null && get.get() == null) {
			set.set(new TableColumn());
		}
	}

	private static boolean matchNames(String name, String pattern) {
		boolean startWith = pattern.endsWith("*");
		boolean endWith = pattern.startsWith("*");
		pattern = pattern.replaceAll("^\\*|\\*$", "");
		if (startWith && endWith) {
			return name.toLowerCase().contains(pattern.toLowerCase());
		}
		if (startWith) {
			return name.toLowerCase().startsWith(pattern.toLowerCase());
		}
		if (endWith) {
			return name.toLowerCase().endsWith(pattern.toLowerCase());
		}
		return name.equalsIgnoreCase(pattern);
	}

	private static Table matchTable(List<Table> tables, String[] tablesNames) {
		for (String tableName : tablesNames) {
			Optional<Table> stream = tables.stream().filter(t ->  matchNames(t.getName(), tableName)).findFirst();
			if (stream.isPresent()) {
				return stream.get();
			}
		}
		return new Table();
	}

	private static void matchColumn(List<TableColumn> columns, String[] columnNames, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		for (String columnName : columnNames) {
			Stream<TableColumn> stream = columns.stream().filter(c ->  matchNames(c.getName(), columnName));
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
	 * @return 返回 完整列模型
	 * @throws Exception 数据库读取异常
	 */
	protected TableColumn columnCompute(TableColumn column) throws Exception {
		String name = this.convertColumnIfNeed(column.getName());
		column.setTypeJdbc(jdbcLang.getType(column));
		column.setFieldName(this.classConverter.converterFieldName(name));
		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));
		bindColumnFieldType(column);

		Database database = this.tableSource.getDatabase();
		if (database != null && database.isKeyword(column.getName())) {
			column.setNameSql(database.wrapperKeyword(column.getName()));
		}

		if (column.isNullable()) {
			column.setFieldType(column.getFieldTypeObject());
		} else {
			column.setFieldType(column.getFieldTypePrimitive());
		}

		Class<?> javaType = programLang.getJavaType(column);
		column.setStringType(String.class.equals(javaType));//(column.getTypeJdbc().contains("CHAR"));//是否是字符串类型
		column.setDateType(Date.class.isAssignableFrom(javaType));//(column.getTypeInt() == Types.DATE || column.getTypeInt() == Types.TIMESTAMP);
		column.setLongType(Long.class.equals(javaType) || long.class.equals(javaType));
		column.setIntType(Integer.class.equals(javaType) || int.class.equals(javaType));
		column.setBoolType(Boolean.class.equals(javaType) || boolean.class.equals(javaType));

		if (column.getDefValue() != null) {
			column.setDefValue(column.getDefValue().replaceAll("\n$", ""));
		}

		if (StringUtil.isNullOrBlank(column.getRemark())) {
			column.setRemark(tableSource.queryColumnRemark(column));
		}

		String remark = column.getRemark();
		if (StringUtil.isNullOrBlank(remark)) {
			column.setRemark(column.getName());
		} else {
			Matcher matcher = remarkRegex.matcher(remark);
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

		column.setTimeType(column.isDateType()&&(column.getName().toLowerCase().contains("time")
				||column.getRemarkName().toLowerCase().contains("time")
				||column.getRemarkName().toLowerCase().contains("时间")));
		return column;
	}

	private void bindColumnFieldType(TableColumn column) {
		column.setFieldType(this.classConverter.converterFieldType(column));
		column.setFieldTypeObject(this.classConverter.converterFieldType(column, ClassConverter.DataType.object));
		column.setFieldTypePrimitive(this.classConverter.converterFieldType(column, ClassConverter.DataType.primitive));
		column.setFieldJavaType(this.converterJava.converterFieldType(column));
		column.setFieldCSharpType(this.converterCSharp.converterFieldType(column));
		column.setFieldKotlinType(this.converterKotlin.converterFieldType(column));
		column.setFieldTypeScriptType(this.converterTypeScript.converterFieldType(column));
		column.setFieldJavaTypePrimitive(this.converterJava.converterFieldType(column, ClassConverter.DataType.primitive));
		column.setFieldCSharpTypePrimitive(this.converterCSharp.converterFieldType(column, ClassConverter.DataType.primitive));
		column.setFieldKotlinTypePrimitive(this.converterKotlin.converterFieldType(column, ClassConverter.DataType.primitive));
		column.setFieldTypeScriptTypePrimitive(this.converterTypeScript.converterFieldType(column, ClassConverter.DataType.primitive));
	}

	protected String convertTableIfNeed(String name) {
        return convertIfNeed(name);
    }

    protected String convertColumnIfNeed(String name) {
        return convertIfNeed(name);   
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
		if (wordBreaker != null && origin.matches("^[_A-Z0-9]{5,}$")) {
			return wordBreaker.breaks(name, config.getTableDivision());
		}
		return name;
	}

	/**
	 * 构建默认的 主键列
	 * @return 主键列
	 */
	protected TableColumn columnKeyDefault() {
		TableColumn column = new TableColumn();
		column.setName("hasNoPrimaryKey");
		column.setType("VARCHAR");
		column.setLength(256);
		column.setDefValue("");
		column.setNullable(true);
		column.setAutoIncrement(false);
		column.setRemark("没有主键");
		column.setTypeInt(java.sql.Types.VARCHAR);

		column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
		column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

		bindColumnFieldType(column);
		return column;
	}

}