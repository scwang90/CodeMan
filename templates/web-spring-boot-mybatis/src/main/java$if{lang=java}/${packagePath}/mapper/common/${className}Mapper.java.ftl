package ${packageName}.mapper.common;

import ${packageName}.mapper.TypedMapper;
import ${packageName}.model.db.${className};

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
public interface ${className}Mapper extends TypedMapper<${className}>{

	/**
	 * 插入一条新数据
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	@Override
	<#if table.idColumn.autoIncrement == true>
	<@single_line>@Options(useGeneratedKeys = false
		<#if table.idColumn.fieldName != "id">
		, keyProperty = "${table.idColumn.fieldName}"
		</#if>
	)
	</@single_line>
	</#if>
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
	@Override
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	int delete(@Param("id") Object id);

	/**
	 * 更新一条数据
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	@Override
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
	@Override
	@Select("SELECT COUNT(*) FROM ${table.nameSQL}")
	int countAll();

	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	@Override
	@ResultMap("${table.name}")
<#if (dbType!"")=="oracle">
	@Select("SELECT * FROM (SELECT ROWNUM AS rn_, t_.* FROM ${table.nameSQL} t_ WHERE ${table.idColumn.name}=${r"#"}{id}) tt_ WHERE tt_.rn_ <= 1")
	${className} findById(@Param("id") Object id);
<#else >
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}")
	${className} findById(@Param("id") Object id);
</#if>

	/**
	 * 获取一条数据
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	@Override
	@ResultMap("${table.name}")
<#if (dbType!"")=="oracle">
	@Select("SELECT * FROM (SELECT ROWNUM AS rn_, t_.* FROM ${table.nameSQL} t_ ${r"${where}"} ${r"${order}"}) tt_ WHERE tt_.rn_ <= 1")
	${className} findOne(@Param("order") String order, @Param("where") String where);
<#else >
	@Select("SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"} LIMIT 1")
	${className} findOne(@Param("order") String order, @Param("where") String where);
</#if>

	/**
	 * 根据属性查询
	 * @param order SQL排序语句
	 * @param property 数据库列名
	 * @param value 值
	 * @return null 或者 匹配条件的数据
	 */
	@Override
	@ResultMap("${table.name}")
<#if (dbType!"")=="oracle">
	@Select("SELECT * FROM (SELECT ROWNUM AS rn_, t_.* FROM ${table.nameSQL} t_ WHERE ${r"${property}"}=${r"#{value}"} ${r"${order}"}) tt_ WHERE tt_.rn_ <= 1")
	${className} findOneByPropertyName(@Param("order") String order, @Param("property") String property, @Param("value") Object value);
<#else >
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"} ${r"${order}"} LIMIT 1")
	${className} findOneByPropertyName(@Param("order") String order, @Param("property") String property, @Param("value") Object value);
</#if>

	/**
	 * 获取全部数据
	 * @param order SQL排序语句
	 * @return 全部数据列表
	 */
	@Override
	@ResultMap("${table.name}")
	@Select("SELECT * FROM ${table.nameSQL} ${r"${order}"}")
	List<${className}> findAll(@Param("order") String order);

	/**
	 * 分页查询数据
	 * @param order SQL排序语句
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 分页列表数据
	 */
	@Override
	@ResultMap("${table.name}")
<#if (dbType!"")=="oracle">
	@Select("SELECT * FROM (SELECT ROWNUM AS rn_, t_.* FROM (SELECT * FROM ${table.nameSQL} ${r"${order}"}) t_ WHERE ROWNUM<=${r"${limit}"}) tt_ WHERE tt_.rn_>=${r"${start}"}")
	List<${className}> findByPage(@Param("order") String order, @Param("limit") int limit, @Param("start") int start);
<#else >
	@Select("SELECT * FROM ${table.nameSQL} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	List<${className}> findByPage(@Param("order") String order, @Param("limit") int limit, @Param("start") int start);
</#if>
	/**
	 * 选择性删除
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	@Override
	@Delete("DELETE FROM ${table.nameSQL} ${r"${where}"}")
	int deleteWhere(@Param("where") String where);

	/**
	 * 根据属性值删除
	 * @param property 数据库列名
	 * @param value 值
	 * @return 改变的行数
	 */
	@Override
	@Delete("DELETE FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"}")
    int deleteByPropertyName(@Param("property") String property, @Param("value") Object value);

	/**
	 * 选择性统计
	 * @param where SQL条件语句
	 * @return 统计数
	 */
	@Override
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} ${r"${where}"}")
	int countWhere(@Param("where") String where);

	/**
	 * 根据属性统计
	 * @param property 数据库列名
	 * @param value 值
	 * @return 统计数
	 */
	@Override
	@Select("SELECT COUNT(*) FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"}")
    int countByPropertyName(@Param("property") String property, @Param("value") Object value);

	/**
	 * 选择性查询
	 * @param order SQL排序语句
	 * @param where SQL条件语句
	 * @return 符合条件的列表数据
	 */
	@Override
	@ResultMap("${table.name}")
	@Select("SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"}")
	List<${className}> findWhere(@Param("order") String order, @Param("where") String where);

	/**
	 * 选择性分页查询
	 * @param order SQL排序语句
	 * @param where SQL条件语句
	 * @param limit 最大返回
	 * @param start 起始返回
	 * @return 符合条件的列表数据
	 */
	@Override
	@ResultMap("${table.name}")
<#if (dbType!"")=="oracle">
	@Select("SELECT * FROM (SELECT ROWNUM AS rn_, t_.* FROM (SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"}) t_ WHERE ROWNUM<=${r"${limit}"}) tt_ WHERE tt_.rn_>=${r"${start}"}")
	List<${className}> findWhereByPage(@Param("order") String order, @Param("where") String where, @Param("limit") int limit, @Param("start") int start);
<#else >
	@Select("SELECT * FROM ${table.nameSQL} ${r"${where}"} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	List<${className}> findWhereByPage(@Param("order") String order, @Param("where") String where, @Param("limit") int limit, @Param("start") int start);
</#if>


	/**
	 * 根据属性查询
	 * @param order SQL排序语句
	 * @param property 数据库列名
	 * @param value 值
	 * @return 返回符合条件的数据列表
	 */
	@Override
	@ResultMap("${table.name}")
	@Select("SELECT * FROM ${table.nameSQL} WHERE ${r"${property}"}=${r"#{value}"} ${r"${order}"}")
	List<${className}> findByPropertyName(@Param("order") String order, @Param("property") String property, @Param("value") Object value);
}
