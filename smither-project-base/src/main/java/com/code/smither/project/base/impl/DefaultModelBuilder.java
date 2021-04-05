package com.code.smither.project.base.impl;

import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.*;
import com.code.smither.project.base.api.internel.*;
import com.code.smither.project.base.constant.JdbcLang;
import com.code.smither.project.base.model.DatabaseJdbc;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.PinYinUtil;
import com.code.smither.project.base.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SuppressWarnings("WeakerAccess")
public class DefaultModelBuilder implements ModelBuilder {

	protected final ProjectConfig config;
	protected final TableSource tableSource;
	protected final TableFilter tableFilter;
	protected final WordBreaker wordBreaker;
	protected final WordReplacer wordReplacer;
	protected final ClassConverter classConverter;
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
//		model.setOrgColumn(findOrgColumn(tables));
//		model.setCodeColumn(findCodeColumn(tables));
		model.setLoginTable(findLoginTable(tables, config.getTableLogin(), model::setHasLogin));
		model.setHasOrg(findColumn(tables, Table::isHasOrg, Table::getOrgColumn, model::setOrgColumn));
		model.setHasCode(findColumn(tables, Table::isHasCode, Table::getCodeColumn, model::setCodeColumn));
		return model;
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

//	private static TableColumn findCodeColumn(List<Table> tables) {
//		TableColumn column = null;
//		for (Table table : tables) {
//			if (table.isHasCode()) {
//				TableColumn org = table.getCodeColumn();
//				if (column == null) {
//					column = org;
//				} else if (org.getComment() != null && (column.getComment() == null || org.getComment().length() > column.getComment().length())) {
//					column = org;
//				}
//			}
//		}
//		return column;
//	}
//
//	private static TableColumn findOrgColumn(List<Table> tables) {
//		TableColumn column = null;
//		for (Table table : tables) {
//			if (table.isHasOrg()) {
//				TableColumn org = table.getOrgColumn();
//				if (column == null) {
//					column = org;
//				} else if (org.getComment() != null && (column.getComment() == null || org.getComment().length() > column.getComment().length())) {
//					column = org;
//				}
//			}
//		}
//		return column;
//	}

	private static Table findLoginTable(List<Table> tables, String tableLogin, Action<Boolean> success) {
		Table tableEqualsName = null;
		Table tableEqualsClassName = null;
		Table tableEqualsUser = null;
		Table tableEqualsAdmin = null;
		Table tableEqualsLogin = null;
		Table tableEqualsAccount = null;
		Table tableContainsUser = null;
		Table tableContainsAdmin = null;
		Table tableContainsLogin = null;
		Table tableContainsAccount = null;

		for (Table table : tables) {
			if (tableEqualsName == null && StringUtil.equals(table.getName(), tableLogin)) {
				tableEqualsName = table;
			}
			if (tableEqualsClassName == null && StringUtil.equals(table.getClassName(), tableLogin)) {
				tableEqualsClassName = table;
			}
			if (tableEqualsUser == null && table.getClassNameUpper().equals("USER")) {
				tableEqualsUser = table;
			}
			if (tableEqualsAdmin == null && table.getClassNameUpper().equals("ADMIN")) {
				tableEqualsAdmin = table;
			}
			if (tableEqualsLogin == null && table.getClassNameUpper().equals("LOGIN")) {
				tableEqualsLogin = table;
			}
			if (tableEqualsAccount == null && table.getClassNameUpper().equals("ACCOUNT")) {
				tableEqualsAccount = table;
			}
			if (tableContainsUser == null && table.getClassNameUpper().contains("USER")) {
				tableContainsUser = table;
			}
			if (tableContainsAdmin == null && table.getClassNameUpper().contains("ADMIN")) {
				tableContainsAdmin = table;
			}
			if (tableContainsLogin == null && table.getClassNameUpper().contains("LOGIN")) {
				tableContainsLogin = table;
			}
			if (tableContainsAccount == null && table.getClassNameUpper().contains("ACCOUNT")) {
				tableContainsAccount = table;
			}
		}
		Table[] loginTables = new Table[]{
		    tableEqualsName,
		    tableEqualsClassName,
		    tableEqualsUser,
		    tableEqualsAdmin,
		    tableEqualsLogin,
		    tableEqualsAccount,
		    tableContainsUser,
		    tableContainsAdmin,
		    tableContainsLogin,
		    tableContainsAccount,
		};
		for (Table table : loginTables) {
			if (table != null) {
				success.onAction(true);
				return table;
			}
		}
		return new Table();
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
        }

		initTableColumn(columns, config.getColumnOrg(), table::getOrgColumn, table::setOrgColumn, table::setHasOrg);
		initTableColumn(columns, config.getColumnCode(), table::getCodeColumn, table::setCodeColumn, table::setHasCode);
		initTableColumn(columns, config.getColumnCreate(), table::getCreateColumn, table::setCreateColumn, table::setHasCreate);
		initTableColumn(columns, config.getColumnUpdate(), table::getUpdateColumn, table::setUpdateColumn, table::setHasUpdate);
		initTableColumn(columns, config.getColumnPassword(), table::getPasswordColumn, table::setPasswordColumn, table::setHasPassword);
		initTableColumn(columns, config.getColumnUsername(), table::getUsernameColumn, table::setUsernameColumn, table::setHasUsername);

		table.setColumns(columns);
		return table;
	}

	private void initTableColumn(List<TableColumn> columns, String keys, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		if (!StringUtil.isNullOrBlank(keys)) {
			String[] columnNames = keys.split(",");
			matchColumn(columns, columnNames, get, set, success);
			if (get.get() == null && keys.contains("_")) {
				columnNames = keys.replace("_", "").split(",");
				matchColumn(columns, columnNames, get, set, success);
			}
		}
		if (get.get() == null) {
			set.set(new TableColumn());
		}
	}

	private void matchColumn(List<TableColumn> columns, String[] columnNames, GetTableColumn get, SetTableColumn set, Action<Boolean> success) {
		for (String columnName : columnNames) {
			columns.stream()
					.filter(c->c.getName().equalsIgnoreCase(columnName))
					.findFirst()
					.ifPresent(column -> {
				success.onAction(true);
				set.set(column);
			});
			if (get.get() != null) {
				break;
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

		column.setStringType(column.getTypeJdbc().contains("CHAR"));//是否是字符串类型
		column.setDateType(column.getTypeInt() == Types.DATE || column.getTypeInt() == Types.TIMESTAMP);

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