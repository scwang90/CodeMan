package ${packageName}.mapper.auto;

import ${packageName}.mapper.intent.api.Query;
import ${packageName}.mapper.intent.impl.Where;
import ${packageName}.mapper.intent.tables.${table.classNameUpper};
import ${packageName}.model.db.${className};

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
public interface ${className}Mapper {

	/**
	 * 插入新数据（非空插入，不支持批量插入）
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	int insert(${className} model);

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	int insertFull(@Param("models") ${className}... models);

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	int insertFull(@Param("models") List<${className}> models);

	/**
	 * 更新一条数据（非空更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	int update(${className} model);

	/**
	 * 更新一条数据（全更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	int updateFull(${className} model);

	/**
	 * 更新数据（灵活构建查询条件，修改多条）
	 * @param setter 设置器
	 * @return 改变的行数
	 */
	int updateSetter(${table.classNameUpper}.SetterQuery setter);

<#if table.hasId>
	/**
	 * 根据ID删除（支持批量删除）
	 * @param ids 数据的主键ID
	 * @return 改变的行数
	 */
	int deleteById(@Param("ids") Object... ids);

</#if>
	/**
	 * 根据查询条件删除（灵活构建查询条件）
	 * @param where 查询条件
	 * @return 改变的行数
	 */
	int deleteWhere(Where<${table.classNameUpper}> where);

	/**
	 * 统计数量（全部）
	 * @return 统计数
	 */
	int countAll();

	/**
	 * 统计数量（灵活构建意图）
	 * @param where 查询条件
	 * @return 统计行数
	 */
	int countWhere(Where<${table.classNameUpper}> where);

<#if table.hasId>
	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	${className} findById(@Param("id") Object id);

</#if>
	/**
	 * 单条查询（灵活构建查询条件）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	${className} selectOneWhere(Query<${table.classNameUpper}> where);

	/**
	 * 批量查询（灵活构建查询条件）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	List<${className}> selectWhere(Query<${table.classNameUpper}> where);

	/**
	 * 批量查询（灵活构建查询条件，分页）
	 * @param where 查询条件
	 * @param rows 分页参数
	 * @return null 或者 匹配条件的数据
	 */
	List<${className}> selectWhere(Query<${table.classNameUpper}> where, RowBounds rows);

<#if table.idColumn.autoIncrement>
	/**
	 * 重置表自增编号
	 */
	@Update("alter table ${table.nameSql} auto_increment = 0")
	void resetAutoIncrement();

</#if>
}
