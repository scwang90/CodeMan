package ${packageName}.mapper.auto

import ${packageName}.mapper.intent.api.Query
import ${packageName}.mapper.intent.api.WhereQuery
import ${packageName}.mapper.intent.tables.${table.classNameUpper}
import ${packageName}.model.db.${className}

import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Param
import org.apache.ibatis.annotations.Update
import org.apache.ibatis.session.RowBounds
import org.springframework.stereotype.Component

/**
 * ${table.remark} 的 mapper 接口
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
interface ${className}AutoMapper {

	/**
	 * 插入新数据（非空插入，不支持批量插入）
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	fun insert(model: ${className}): Int

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	fun insertFull(@Param("models") models: List<${className}>): Int
	
	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	fun insertFull(@Param("models") vararg models: ${className}): Int
	
	/**
	 * 更新一条数据（非空更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	fun update(model: ${className}): Int
	
	/**
	 * 更新一条数据（全更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	fun updateFull(model: ${className}): Int
	
	/**
	 * 更新数据（灵活构建查询条件，修改多条）
	 * @param setter 设置器
	 * @return 改变的行数
	 */
	fun updateSetter(setter: ${table.classNameUpper}.SetterQuery): Int
	
	/**
	 * 根据ID删除（支持批量删除）
	 * @param ids 数据的主键ID
	 * @return 改变的行数
	 */
	fun deleteById(@Param("ids") vararg ids: Any): Int

	/**
	 * 根据查询条件删除（灵活构建查询条件）
	 * @param where 查询条件
	 * @return 改变的行数
	 */
	fun deleteWhere(where: WhereQuery<${table.className}>): Int
	
	/**
	 * 统计数量（全部）
	 * @return 统计数
	 */
	fun countAll(): Int
	
	/**
	 * 统计数量（灵活构建意图）
	 * @param where 查询条件
	 * @return 统计行数
	 */
	fun countWhere(where: WhereQuery<${table.className}>): Int

<#if table.hasId>
	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	fun findById(@Param("id") id: Any?): ${className}?

</#if>
	/**
	 * 单条查询（灵活构建查询条件）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	fun selectOneWhere(where: Query<${table.className}>): ${className}?
	
	/**
	 * 批量查询（灵活构建查询条件）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	fun selectWhere(where: Query<${table.className}>?): List<${className}>

	/**
	 * 批量查询（灵活构建查询条件，分页）
	 * @param where 查询条件
 	 * @param rows 分页参数
	 * @return null 或者 匹配条件的数据
	 */
	fun selectWhere(where: Query<${table.className}>?, rows: RowBounds): List<${className}>

<#if table.idColumn.autoIncrement>
	/**
	 * 重置表自增编号
	 */
	@Update("alter table ${table.nameSql} auto_increment = 0")
	fun resetAutoIncrement()

</#if>
}
