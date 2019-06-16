package ${packageName}.mapper.common;

import ${packageName}.mapper.TypedMapper;
import ${packageName}.model.db.${className};
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import java.util.List;

<#macro single_line>
<@compress single_line=true>
	<#nested>
</@compress>

</#macro>

/**
 * ${table.remark}的mapper接口
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
public interface ${className}Mapper extends TypedMapper<${className}>{

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
	@Override
    int insert(${className} model);

	/**
	 * 根据ID删除
	 * @param id 数据的主键ID
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	@Override
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
	@Override
    int update(${className} model);

	/**
	 * 统计全部出数据
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL}")
	@Override
    int countAll();
	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	@Override
    ${className} findById(@Param("id") Object id);

	/**
	 * 获取全部数据
	 * @return 全部数据列表
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"${order}"}")
	@Override
    List<${className}> findAll(@Param("order") String order);

	/**
	 * 分页查询数据
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 分页列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	@Override
    List<${className}> findByPage(@Param("order") String order, @Param("limit") int limit, @Param("start") int start);

	/**
	 * 选择性删除
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} ${r"${where}"}")
	@Override
    int deleteWhere(@Param("where") String where);
	/**
	 * 根据属性值删除
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 改变的行数
	 */
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${r"${propertyName}"}=${r"#{value}"}")
	@Override
    int deleteByPropertyName(@Param("propertyName") String propertyName, @Param("value") Object value);
	/**
	 * 选择性统计
	 * @param where SQL条件语句
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} ${r"${where}"}")
	@Override
    int countWhere(@Param("where") String where);
	/**
	 * 根据属性统计
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 统计数
	 */
	@Select("SELECT COUNT(*) FROM WHERE ${r"${propertyName}"}=${r"#{value}"}")
	@Override
    int countByPropertyName(@Param("propertyName") String propertyName, @Param("value") Object value);
	/**
	 * 选择性查询
	 * @param where SQL条件语句
	 * @return 符合条件的列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"}")
	@Override
    List<${className}> findWhere(@Param("order") String order, @Param("where") String where);

	/**
	 * 选择性分页查询
	 * @param where SQL条件语句
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 符合条件的列表数据
	 */
	@Select("SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	@Override
    List<${className}> findWhereByPage(@Param("order") String order, @Param("where") String where, @Param("limit") int limit, @Param("start") int start);

	/**
	 * 根据属性查询
	 * @param propertyName 数据库列名
	 * @param value 值
	 * @return 返回符合条件的数据列表
	 */
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${r"${propertyName}"}=${r"#{value}"} ${r"${order}"}")
	@Override
    List<${className}> findByPropertyName(@Param("order") String order, @Param("propertyName") String propertyName, @Param("value") Object value);
}
