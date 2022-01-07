package ${packageName}.mapper.auto;

import ${packageName}.mapper.intent.api.Query;
import ${packageName}.mapper.intent.api.WhereQuery;
import ${packageName}.mapper.intent.tables.${table.classNameUpper};
import ${packageName}.model.db.${className};
<#if table.hasCascadeKey>
import ${packageName}.model.db.${className}Bean;
</#if>

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Component;

import java.util.List;

<#assign beans = ['']/>
<#if table.hasCascadeKey>
	<#assign beans = ['', 'Bean']/>
</#if>
/**
 * ${table.remark} 的 mapper 接口
<#list table.descriptions as description>
 * ${description}
</#list>
 *
 * 由代码生成器生成，不要修改
 * 当数据库有更新，使用生成器再次生成时，会覆盖所有修改
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
public interface ${className}AutoMapper {

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
	int deleteWhere(WhereQuery<${table.className}> where);

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
	int countWhere(WhereQuery<${table.className}> where);
<#list beans as bean>
	<#if table.hasId>

	/**
	 * 根据ID获取<#if bean?length gt 0>（包括外键）</#if>
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	${className}${bean} find${bean}ById(@Param("id") Object id);
	</#if>

	/**
	 * 单条查询（灵活构建查询条件<#if bean?length gt 0>，包括外键</#if>）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	${className}${bean} select${bean}OneWhere(Query<${table.className}> where);

	/**
	 * 批量查询（灵活构建查询条件<#if bean?length gt 0>，包括外键</#if>）
	 * @param where 查询条件
	 * @return null 或者 匹配条件的数据
	 */
	List<${className}${bean}> select${bean}Where(Query<${table.className}> where);

	/**
	 * 批量查询（灵活构建查询条件<#if bean?length gt 0>，包括外键</#if>，分页）
	 * @param where 查询条件
	 * @param rows 分页参数
	 * @return null 或者 匹配条件的数据
	 */
	List<${className}${bean}> select${bean}Where(Query<${table.className}> where, RowBounds rows);
	<#list table.importedKeys as key>

	/**
	 * 批量查询（<#if bean?length gt 0>包括外键，</#if>根据${key.pkTable.remarkName}）
	 * @param ${key.fkColumn.fieldName} 关联条件
	 * @return empty 或者 匹配条件的数据
	 */
	List<${table.className}${bean}> select${bean}By${key.fkColumn.fieldNameUpper}(@Param("${key.fkColumn.fieldName}") ${key.fkColumn.fieldType} ${key.fkColumn.fieldName});

	/**
	 * 批量查询（<#if bean?length gt 0>包括外键，</#if>根据${key.pkTable.remarkName}，分页）
	 * @param ${key.fkColumn.fieldName} 关联条件
 	 * @param rows 分页参数
	 * @return empty 或者 匹配条件的数据
	 */
	List<${table.className}${bean}> select${bean}By${key.fkColumn.fieldNameUpper}(@Param("${key.fkColumn.fieldName}") ${key.fkColumn.fieldType} ${key.fkColumn.fieldName}, RowBounds rows);
	</#list>
	<#list table.relateCascadeKeys as key>

	/**
	 * 级联查询（<#if bean?length gt 0>包括外键，</#if>根据${key.targetTable.remarkName}${key.targetColumn.remarkName}）
	 * @param ${key.relateTargetColumn.fieldName} 关联条件
	 * @return empty 或者 匹配条件的数据
	 */
	List<${table.className}${bean}> select${bean}ByRelate${key.relateTargetColumn.fieldNameUpper}(@Param("${key.relateTargetColumn.fieldName}") ${key.relateTargetColumn.fieldType} ${key.relateTargetColumn.fieldName});

	/**
	 * 级联查询（<#if bean?length gt 0>包括外键，</#if>根据${key.targetTable.remarkName}${key.targetColumn.remarkName}，分页）
	 * @param ${key.relateTargetColumn.fieldName} 关联条件
	 * @param rows 分页参数
	 * @return empty 或者 匹配条件的数据
	 */
	List<${table.className}${bean}> select${bean}ByRelate${key.relateTargetColumn.fieldNameUpper}(@Param("${key.relateTargetColumn.fieldName}") ${key.relateTargetColumn.fieldType} ${key.relateTargetColumn.fieldName}, RowBounds rows);
	</#list>
</#list>
<#if table.idColumn.autoIncrement && (dbType!"")=="mysql">

	/**
	 * 重置表自增编号
	 */
	@Update("alter table ${table.nameSql} auto_increment = 0")
	void resetAutoIncrement();
</#if>

}
