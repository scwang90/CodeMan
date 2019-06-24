package ${packageName}.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import ${packageName}.model.${className};
import ${packageName}.dao.base.BaseDaoMybatisMYSQLImpl.MybatisMultiDao;

<#macro single_line>
<@compress single_line=true>
	<#nested>
</@compress>

</#macro>

/**
 * ${table.remark}的mapper接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface ${className}Mapper extends MybatisMultiDao<${className}>{

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
	int insert(${className} model);
	/**
	 * 根据ID删除
	 * @param id 数据的主键ID
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	int delete(@Param("id") Object id);
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
	int update(${className} model);
	/**
	 * 统计全部出数据
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL}")
	int countAll();
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
	${className} findById(@Param("id") Object id);
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
	List<${className}> findAll(@Param("order") String order);
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
	List<${className}> findByPage(@Param("order") String order,@Param("limit") int limit,@Param("start") int start);
	/**
	 * 选择性删除
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} ${r"${where}"}")
	int deleteWhere(@Param("where") String where);
	/**
	 * 根据属性值删除
	 * @param property 数据库列名
	 * @param value 值
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"}")
	int deleteByPropertyName(@Param("property") String property,@Param("value") Object value);
	/**
	 * 选择性统计
	 * @param where SQL条件语句
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} ${r"${where}"}")
	int countWhere(@Param("where") String where);
	/**
	 * 根据属性统计
	 * @param property 数据库列名
	 * @param value 值
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"}")
	int countByPropertyName(@Param("property") String property,@Param("value") Object value);
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
	List<${className}> findWhere(@Param("order") String order,@Param("where") String where);
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
	List<${className}> findWhereByPage(@Param("order") String order,@Param("where") String where,@Param("limit") int limit,@Param("start") int start);
	/**
	 * 根据属性查询
	 * @param property 数据库列名
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
		FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"} ${r"${order}"}")
	</@single_line>
	List<${className}> findByPropertyName(@Param("order") String order,@Param("property") String property,@Param("value") Object value);
}