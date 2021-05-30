package ${packageName}.service.auto
<#assign beans = ['']/>
<#if table.hasCascadeKey>
	<#assign beans = ['', 'Bean']/>
</#if>

<#if table == organTable && hasLogin>
import ${packageName}.exception.AccessException
</#if>
<#if (table.hasOrgan && hasOrgan) || table == loginTable>
import ${packageName}.exception.ClientException
</#if>
<#if table.hasCode>
import ${packageName}.mapper.CommonMapper
</#if>
<#if table.hasOrgan || table.hasCode || table.hasSearches>
import ${packageName}.mapper.intent.Tables
</#if>
import ${packageName}.mapper.auto.${className}AutoMapper
<#list beans as bean>
<#list table.importCascadeKeys as key>
import ${packageName}.mapper.auto.extensions.select${bean}By${key.fkColumn.fieldNameUpper}
</#list>
</#list>
<#if table.hasRemove>
import ${packageName}.mapper.auto.extensions.update
</#if>
import ${packageName}.model.api.Paged
import ${packageName}.model.api.Paging
import ${packageName}.model.db.${className}
<#if table.hasCascadeKey>
import ${packageName}.model.db.${className}Bean
</#if>
<#if table.hasCode>
import ${packageName}.util.CommonUtil
</#if>
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22
</#if>
<#if table == loginTable || (table.hasOrgan && hasLogin) || (table == organTable  && hasLogin) || (hasLogin && table.hasCreator)>
import ${packageName}.util.JwtUtils
</#if>

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

/**
 * ${table.remark} 的 Service 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
class ${className}AutoService {

<#if table.hasCode>
	@Autowired
	private lateinit var commonMapper: CommonMapper
</#if>
	@Autowired
	private lateinit var mapper: ${className}AutoMapper
<#list beans as bean>

	/**
	 * ${table.remarkName}列表<#if bean?length gt 0>（包括外键）</#if>
	 * @param paging 分页对象
	<#if table.hasSearches>
	 * @param key 搜索关键字
	</#if>
	 */
    fun list${bean}(paging: Paging<#if table.hasSearches>, key: String?</#if>): Paged<${className}${bean}> {
	<#if table.hasSearches || (hasOrgan && table.hasOrgan)>
        return Tables.${table.className}.run {
			var where = where(<#if hasOrgan && table.hasOrgan && !loginTable.orgColumn.nullable>${table.orgColumn.fieldNameUpper}.eq(JwtUtils.currentBearer().${table.orgColumn.fieldName})<#else></#if>)
		<#if hasOrgan && table.hasOrgan && loginTable.orgColumn.nullable>
			val ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName}
			if (${table.orgColumn.fieldName} != null) {
				where = where.and(${table.orgColumn.fieldNameUpper}.eq(${table.orgColumn.fieldName}))
			}
		</#if>
		<#if table.hasRemove>
			<#if table.removeColumn.boolType>
			where = where.and(${table.removeColumn.fieldNameUpper}.isNull.or(${table.removeColumn.fieldNameUpper}.eq(false)))
			<#elseif table.removeColumn.intType>
			where = where.and(${table.removeColumn.fieldNameUpper}.isNull.or(${table.removeColumn.fieldNameUpper}.eq(0)));
			<#else>
			where = where.and(${table.removeColumn.fieldNameUpper}.isNull.or(${table.removeColumn.fieldNameUpper}.ne("removed")));
			</#if>
		</#if>
		<#if table.hasSearches>
			if (!key.isNullOrBlank()) {
				where = where.and(<#list table.searchColumns as column><#if column_index gt 0>.or(</#if>${column.fieldNameUpper}.contains(key)<#if column_index gt 0>)</#if></#list>)
			}
		</#if>
			Paged(paging, mapper.select${bean}Where(where, paging.toRowBounds()))
		}
	<#else >
		return Paged(paging, mapper.select${bean}Where(null, paging.toRowBounds()))
	</#if>
    }
	<#list table.importCascadeKeys as key>

	/**
	 * 根据${key.pkTable.remarkName}获取${table.remarkName}列表<#if bean?length gt 0>（包括外键）</#if>
	 * @param paging 分页对象
	 <#if table.hasSearches>
	 * @param key 搜索关键字
	 </#if>
	 */
	fun list${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}: ${key.fkColumn.fieldType}, paging: Paging<#if table.hasSearches>, key: String?</#if>): Paged<${className}${bean}> {
		<#if table.hasSearches>
		return Tables.${table.className}.run {
			var where = where()
			if (!key.isNullOrBlank()) {
				where = where.and(<#list table.searchColumns as column><#if column_index gt 0>.or(</#if>${column.fieldNameUpper}.contains(key)<#if column_index gt 0>)</#if></#list>)
			}
			Paged(paging, mapper.select${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}, paging.toRowBounds()) { where } )
		}
		<#else>
		return Paged(paging, mapper.select${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}, paging.toRowBounds()))
		</#if>
	}
	</#list>
</#list>

	/**
	 * 添加${table.remarkName}
	 * @param model 实体对象
	 × @return 返回新数据的Id
	 */
	fun insert(model: ${className}): ${table.idColumn.fieldType} {
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType>
		if(model.${table.idColumn.fieldName} == null) {
			model.${table.idColumn.fieldName} = ID22.random()
		}
</#if>
<#if table.hasOrgan && hasOrgan>
		val ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName} ?: throw ClientException("必须指定${table.orgColumn.fieldName}")
</#if>
<#if table.hasCode>
	<#if table.hasOrgan && hasOrgan>
		val code = commonMapper.maxCodeByTableAndOrg(Tables.${table.className}.name, ${table.orgColumn.fieldName})
	<#else>
		val code = commonMapper.maxCodeByTable(Tables.${table.className}.name)
	</#if>
		model.${table.codeColumn.fieldName} = CommonUtil.formatCode(code)
</#if>
<#if table.hasOrgan && hasLogin>
		model.${table.orgColumn.fieldName} = ${table.orgColumn.fieldName}
</#if>
<#if table.hasCreator && hasLogin>
		model.${table.creatorColumn.fieldName} = JwtUtils.currentBearer().userId
</#if>
<#list table.columns as column>
	<#if column == table.updateColumn || column == table.createColumn>
		<#if column.fieldType == 'Long'>
		model.${column.fieldName} = System.currentTimeMillis()
		<#elseif column.fieldType == 'java.util.Date'>
		model.${column.fieldName} = java.util.Date()
		</#if>
	</#if>
</#list>
        mapper.insert(model)
		return model.${table.idColumn.fieldName}
	}

<#if table.hasId>
	/**
	 * 更新${table.remarkName}
	 * @param model 实体对象
	 × @return 返回数据修改的行数
	 */
    fun update(model: ${className}): Int {
	<#if organTable == table && hasOrgan>
		val ${orgColumn.fieldName} = JwtUtils.currentBearer().${orgColumn.fieldName}
		<#if hasLogin && loginTable.orgColumn.nullable>
		if (${orgColumn.fieldName} != null && ${orgColumn.fieldName} != model.${table.idColumn.fieldName}) {
		<#else>
		if (model.${table.idColumn.fieldName} != ${orgColumn.fieldName}) {
		</#if>
			throw AccessException("权限不足")
		}
	</#if>
	<#list table.columns as column>
		<#if column == table.updateColumn>
			<#if column.fieldType == 'Long'>
		model.${column.fieldName} = System.currentTimeMillis()
			<#elseif column.fieldType == 'java.util.Date'>
		model.${column.fieldName} = java.util.Date()
			</#if>
		</#if>
	</#list>
		return mapper.update(model)
	}
	<#list beans as bean>

	/**
	 * 获取${table.remarkName}<#if bean?length gt 0>（包括外键）</#if>
	 * @param id 数据主键
	 × @return 数据实体对象
	 */
    fun find${bean}ById(id: Any): ${className}${bean}? {
	<#if table.hasOrgan && hasOrgan>
		val model = mapper.find${bean}ById(id) ?: throw ClientException("无效的${table.remarkName}Id")
		<#if loginTable.orgColumn.nullable>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} == null || JwtUtils.currentBearer().${table.orgColumn.fieldName} != model.${table.orgColumn.fieldName}) {
		<#elseif table.orgColumn.stringType>
		if (model.${table.orgColumn.fieldName} == null || model.${table.orgColumn.fieldName} != JwtUtils.currentBearer().${table.orgColumn.fieldName}) {
		<#else>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} != model.${table.orgColumn.fieldName}) {
		</#if>
			throw ClientException("无效的${table.remarkName}Id")
		}
		return model
	<#else>
		return mapper.find${bean}ById(id)
	</#if>
	}
	</#list>

	/**
	 * 获取${table.remarkName}
	 * @param ids 数据主键
	 × @return 返回数据修改的行数
	 */
    fun deleteById(ids: String): Int {
	<#if (table.hasOrgan && hasOrgan) || table == loginTable>
		if (!ids.contains(",")) {
		<#if table == loginTable>
			val model = this.findById(ids) ?: throw ClientException("无效的${table.remarkName}Id")
			if (JwtUtils.currentBearer().userId == model.${table.idColumn.fieldName}) {
				throw ClientException("不能删除自己！")
			}
		} else {
			<#if table.idColumn.stringType>
			if (ids.split(',').any { id -> JwtUtils.currentBearer().userId == id }) {
			<#else>
			if (ids.split(',').any { id -> JwtUtils.currentBearer().userId == id.toInt() }) {
			</#if>
				throw ClientException("不能删除自己！")
			}
		<#else >
			this.findById(ids)
		</#if>
		}
	</#if>
	<#if table.hasRemove>
		val list = ids.split(",")<#if table.idColumn.intType>.map { it.toInt() }</#if>.toList()
		<#if table.removeColumn.boolType>
		return mapper.update { set${table.removeColumn.fieldNameUpper}(true).where(${table.idColumn.fieldNameUpper}.inList(list)) }
		<#elseif table.removeColumn.intType>
		return mapper.update { set${table.removeColumn.fieldNameUpper}(1).where(${table.idColumn.fieldNameUpper}.inList(list)) }
		<#else>
		return mapper.update { set${table.removeColumn.fieldNameUpper}("removed").where(${table.idColumn.fieldNameUpper}.inList(list)) }
		</#if>
	<#else>
		return mapper.deleteById(*ids.split(",").toTypedArray())
	</#if>
	}

</#if>
}
