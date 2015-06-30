package ${packagename}.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import ${packagename}.model.${className};
import ${packagename}.dao.base.BaseDaoMybatisMYSQLImpl.MybatisMultiDao;

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
public interface ${className}Mapper extends MybatisMultiDao<${className}>{

	/**
	 * 插入一条新数据
	 * @param model
	 * @return
	 * @throws Exception
	 */
	<@single_line>@Insert("INSERT INTO ${table.name} (
			<#list table.columns as column>
				${column.name}
				<#if column_has_next>,</#if>
			</#list>
		) VALUES (
			<#list table.columns as column>
				${r"#"}{${column.fieldName}}
				<#if column_has_next>,</#if>
			</#list>
		)")
	</@single_line>
	public int insert(${className} model) throws Exception;
	/**
	 * 根据ID删除
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@Delete("DELETE FROM ${table.name} WHERE ${table.idColumn.name}=${r"#"}{id}")
	public int delete(@Param("id") Object id) throws Exception;
	/**
	 * 更新一条数据
	 * @param model
	 * @return
	 * @throws Exception
	 */
	<@single_line>@Update("UPDATE ${table.name} SET
			<#list table.columns as column>
				${column.name}=${r"#"}{${column.fieldName}}
				<#if column_has_next>,</#if>
			</#list>
			WHERE ${table.idColumn.name}=${r"#"}{${table.idColumn.fieldName}}
	")
	</@single_line>
	public int update(${className} model) throws Exception;
	/**
	 * 统计全部出数据
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT COUNT(*) FROM ${table.name}")
	public int countAll() throws Exception;
	/**
	 * 根据ID获取
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} WHERE ${table.idColumn.name}=${r"#"}{id}")
	public ${className} findById(@Param("id") Object id) throws Exception;
	/**
	 * 获取全部数据
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} ${r"${order}"}")
	public List<${className}> findAll(@Param("order") String order) throws Exception;
	/**
	 * 分页查询数据
	 * @param limit
	 * @param start
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	public List<${className}> findByPage(@Param("order") String order,@Param("limit") int limit,@Param("limit") int start) throws Exception;
	
	/**
	 * 选择性删除
	 * @param where
	 * @return
	 * @throws Exception
	 */
	@Delete("DELETE FROM ${table.name} ${r"${where}"}")
	public int deleteWhere(@Param("where") String where) throws Exception ;
	/**
	 * 根据属性值删除
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	@Delete("DELETE FROM ${table.name} WHERE ${r"${propertyName}"}=${r"#{value}"}")
	public int deleteByPropertyName(@Param("propertyName") String propertyName,@Param("value") Object value) throws Exception;
	/**
	 * 选择性统计
	 * @param where
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT COUNT(*) FROM ${table.name} ${r"${where}"}")
	public int countWhere(@Param("where") String where) throws Exception;
	/**
	 * 根据属性统计
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT COUNT(*) FROM WHERE ${r"${propertyName}"}=${r"#{value}"}")
	public int countByPropertyName(@Param("propertyName") String propertyName,@Param("value") Object value) throws Exception ;
	/**
	 * 选择性查询
	 * @param where
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} ${r"${where}"} ${r"${order}"}")
	public List<${className}> findWhere(@Param("order") String order,@Param("where") String where) throws Exception ;
	/**
	 * 选择性分页查询
	 * @param where
	 * @param limit
	 * @param start
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} ${r"${where}"} ${r"${order}"} LIMIT ${r"${start}"},${r"${limit}"}")
	public List<${className}> findWhereByPage(@Param("order") String order,@Param("where") String where,@Param("limit") int limit,@Param("limit") int start) throws Exception;
	/**
	 * 根据属性查询
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	@Select("SELECT * FROM ${table.name} WHERE ${r"${propertyName}"}=${r"#{value}"} ${r"${order}"}")
	public List<${className}> findByPropertyName(@Param("order") String order,@Param("propertyName") String propertyName,@Param("value") Object value) throws Exception;
}