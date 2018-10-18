package ${packageName}.mapper.common

import ${packageName}.mapper.TypedMapper
import ${packageName}.model.db.Admin
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
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
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
	fun insert(${className} model): Int

	/**
	 * 根据ID删除
	 * @param id 数据的主键ID
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	fun delete(@Param("id") Object id): Int

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
	fun update(${className} model): Int

	/**
	 * 统计全部出数据
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL}")
	fun countAll(): Int

	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
				${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
				${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	</@single_line>
	fun findById(@Param("id") Object id): ${className}

	/**
	 * 获取全部数据
	 * @return 全部数据列表
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
			${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
			${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} ${r"${order}"}")
	</@single_line>
	fun findAll(@Param("order") String order): List<${className}>

	/**
	 * 分页查询数据
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 分页列表数据
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
			${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
			${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	</@single_line>
	fun findByPage(@Param("order") String order,@Param("limit") int limit,@Param("start") int start): List<${className}>

	/**
	 * 选择性删除
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} ${r"${where}"}")
	fun deleteWhere(@Param("where") String where): Int

	/**
	 * 根据属性值删除
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${r"${propertyName}"}=${r"#{value}"}")
	fun deleteByPropertyName(@Param("propertyName") String propertyName,@Param("value") Object value): Int

	/**
	 * 选择性统计
	 * @param where SQL条件语句
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} ${r"${where}"}")
	fun countWhere(@Param("where") String where): Int

	/**
	 * 根据属性统计
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM WHERE ${r"${propertyName}"}=${r"#{value}"}")
	fun countByPropertyName(@Param("propertyName") String propertyName,@Param("value") Object value): Int

	/**
	 * 选择性查询
	 * @param where SQL条件语句
	 * @return 符合条件的列表数据
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
			${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
			${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"}")
	</@single_line>
	fun findWhere(@Param("order") String order,@Param("where") String where): List<${className}>

	/**
	 * 选择性分页查询
	 * @param where SQL条件语句
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 符合条件的列表数据
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
			${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
			${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	</@single_line>
	fun findWhereByPage(@Param("order") String order,@Param("where") String where,@Param("limit") int limit,@Param("start") int start): List<${className}>

	/**
	 * 根据属性查询
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 返回符合条件的数据列表
	 */
	<@single_line>@Select("SELECT
		<#list table.columns as column>
			<#if column.name==column.fieldName>
			${column.nameSQL}
			</#if>
			<#if column.name!=column.fieldName>
			${column.nameSQL} ${column.fieldName}
			</#if>
			<#if column_has_next>,</#if>
		</#list>
		FROM ${table.nameSQL} WHERE ${r"${propertyName}"}=${r"#{value}"} ${r"${order}"}")
	</@single_line>
	fun findByPropertyName(@Param("order") String order,@Param("propertyName") String propertyName,@Param("value") Object value): List<${className}>
}