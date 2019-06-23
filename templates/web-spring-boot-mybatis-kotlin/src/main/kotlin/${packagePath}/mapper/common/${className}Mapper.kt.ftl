package ${packageName}.mapper.common

import ${packageName}.mapper.TypedMapper
import ${packageName}.model.db.${className}
import org.apache.ibatis.annotations.*
import org.springframework.stereotype.Component

<#macro single_line>
<@compress single_line=true>
	<#nested>
</@compress>

</#macro>

/**
 * ${table.remark}的mapper接口
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
interface ${className}Mapper : TypedMapper<${className}>{

	/**
	 * 插入一条新数据
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	<@single_line>@Insert("INSERT INTO ${table.nameSQL} (
			<#list table.columns as column>
				${column.nameSQL}
				<#if column_has_next>,</#if>
			</#list>
		) VALUES (
			<#list table.columns as column>
				${r"#"}{${column.fieldName}}
				<#if column_has_next>,</#if>
			</#list>
		)")
	</@single_line>
	override fun insert(model: ${className}): Int

	/**
	 * 根据ID删除
	 * @param id 数据的主键ID
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	override fun delete(@Param("id") id: Any): Int

	/**
	 * 更新一条数据
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	<@single_line>@Update("UPDATE ${table.nameSQL} SET
			<#list table.columns as column>
				${column.nameSQL}=${r"#"}{${column.fieldName}}
				<#if column_has_next>,</#if>
			</#list>
			WHERE ${table.idColumn.name}=${r"#"}{${table.idColumn.fieldName}}
	")
	</@single_line>
	override fun update(model: ${className}): Int

	/**
	 * 统计全部出数据
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL}")
	override fun countAll(): Int

	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	override fun findById(@Param("id") id: Any): ${className}

	/**
	 * 获取全部数据
	 * @return 全部数据列表
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"\${order}"}")
	override fun findAll(@Param("order") order: String): List<${className}>

	/**
	 * 分页查询数据
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 分页列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"\${order}"} LIMIT ${r"\${start}"},${r"\${limit}"}")
	override fun findByPage(@Param("order") order: String, @Param("limit") limit: Int, @Param("start") start: Int): List<${className}>

	/**
	 * 选择性删除
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} ${r"\${where}"}")
	override fun deleteWhere(@Param("where") where: String): Int

	/**
	 * 根据属性值删除
	 * @param property 数据库列名
	 * @param value 值
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${r"\${property}"}=${r"#{value}"}")
	override fun deleteByPropertyName(@Param("property") property: String, @Param("value") value: Any): Int

	/**
	 * 选择性统计
	 * @param where SQL条件语句
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} ${r"\${where}"}")
	override fun countWhere(@Param("where") where: String): Int

	/**
	 * 根据属性统计
	 * @param property 数据库列名
	 * @param value 值
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} WHERE ${r"\${property}"}=${r"#{value}"}")
	override fun countByPropertyName(@Param("property") property: String, @Param("value") value: Any): Int

	/**
	 * 选择性查询
	 * @param where SQL条件语句
	 * @return 符合条件的列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"\${where}"} ${r"\${order}"}")
	override fun findWhere(@Param("order") order: String, @Param("where") where: String): List<${className}>

	/**
	 * 选择性分页查询
	 * @param where SQL条件语句
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 符合条件的列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"\${where}"} ${r"\${order}"} LIMIT ${r"\${start}"},${r"\${limit}"}")
	override fun findWhereByPage(@Param("order") order: String, @Param("where") where: String, @Param("limit") limit: Int, @Param("start") start: Int): List<${className}>

	/**
	 * 根据属性查询
	 * @param property 数据库列名
	 * @param value 值
	 * @return 返回符合条件的数据列表
	 */
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${r"\${property}"}=${r"#{value}"} ${r"\${order}"}")
	override fun findByPropertyName(@Param("order") order: String, @Param("property") property: String, @Param("value") value: Any): List<${className}>
}