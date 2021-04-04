package ${packageName}.mapper.auto;

import ${packageName}.mapper.TypedMapper;
import ${packageName}.mapper.intent.impl.Condition;
import ${packageName}.mapper.intent.tables.${table.classNameUpper};
import ${packageName}.model.db.${className};
import ${packageName}.util.SqlIntent;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * ${table.remark} 的 mapper 接口
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component("auto${className}Mapper")
public interface ${className}Mapper extends TypedMapper<${className}>{

	/**
	 * 插入新数据（非空插入，不支持批量插入）
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	@Override
	int insert(${className} model);

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	@Override
	int insertFull(@Param("models") ${className}... models);

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	@Override
	int insertFull(@Param("models") List<${className}> models);

	/**
	 * 更新一条数据（非空更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	@Override
	int update(${className} model);

	/**
	 * 更新一条数据（全更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	@Override
	int updateFull(${className} model);

	/**
	 * 更新一条数据（灵活构建意图，修改多条）
	 * @param intent 意图
	 * @return 改变的行数
	 */
	@Override
	int updateIntent(SqlIntent intent);

	/**
	 * 根据ID删除（支持批量删除）
	 * @param ids 数据的主键ID
	 * @return 改变的行数
	 */
	@Override
	int deleteById(@Param("ids") Object... ids);

	/**
	 * 根据条件删除（Where 拼接）
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Override
	int deleteWhere(@Param("where") String where);

	/**
	 * 根据条件删除（灵活构建意图）
	 * @param intent 意图
	 * @return 改变的行数
	 */
	@Override
	int deleteIntent(SqlIntent intent);

	/**
	 * 统计数量（全部）
	 * @return 统计数
	 */
	@Override
	int countAll();

	/**
	 * 统计数量（Where 拼接）
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Override
	int countWhere(@Param("where") String where);

	/**
	 * 统计数量（灵活构建意图）
	 * @param intent 意图
	 * @return 改变的行数
	 */
	@Override
	int countIntent(SqlIntent intent);

	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	@Override
	${className} findById(@Param("id") Object id);

	/**
	 * 单条查询（Where 拼接 Order 拼接）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	@Override
	${className} findOneWhere(@Param("where") String where, @Param("order") String order);

	/**
	 * 单条查询（灵活构建意图）
	 * @param intent 意图
	 */
	@Override
	${className} findOneIntent(SqlIntent intent);

	/**
	 * 批量查询（Where 拼接 Order 拼接）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	@Override
	List<${className}> findListWhere(@Param("where") String where, @Param("order") String order);

	/**
	 * 批量查询（灵活构建意图）
	 * @param intent 意图
	 */
	@Override
	List<${className}> findListIntent(SqlIntent intent);

	/**
	 * 批量查询（Where 拼接 Order 拼接，分页）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	@Override
	List<${className}> findListWhere(@Param("where") String where, @Param("order") String order, RowBounds rows);

	/**
	 * 批量查询（灵活构建意图，分页）
	 * @param intent 意图
	 */
	@Override
	List<${className}> findListIntent(SqlIntent intent, RowBounds rows);

	/**
	 * 统计数量（灵活构建条件）
	 * @param condition 条件
	 * @return 统计数量
	 */
	int countCondition(Condition<${table.classNameUpper}> condition);

	/**
	 * 根据条件删除（灵活构建条件）
	 * @param condition 条件
	 * @return 改变的行数
	 */
	int deleteCondition(Condition<${table.classNameUpper}> condition);

	/**
	 * 单条查询（灵活构建条件）
  	 * @param condition 条件
	 */
	${className} findOneCondition(Condition<${table.classNameUpper}> condition);

	/**
	 * 批量查询（灵活构建条件）
	 * @param condition 条件
	 */
	List<${className}> findListCondition(Condition<${table.classNameUpper}> condition);

	/**
	 * 批量查询（灵活构建条件，分页）
	 * @param condition 条件
	 */
	List<${className}> findListCondition(RowBounds rows, Condition<${table.classNameUpper}> condition);

	<#if table.idColumn.autoIncrement>
	/**
	 * 重置表自增编号
	 */
	@Update("alter table ${table.nameSql} auto_increment = 0")
	void resetAutoIncrement();

	</#if>
}
