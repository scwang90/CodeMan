package ${packageName}.service.auto

<#if table.hasOrgan || table == loginTable>
import ${packageName}.exception.ClientException
</#if>
<#if table.hasCode>
import ${packageName}.mapper.CommonMapper
</#if>
<#if table.hasOrgan || table.hasCode || table.hasSearches>
import ${packageName}.mapper.intent.Tables
</#if>
import ${packageName}.mapper.auto.${className}AutoMapper
import ${packageName}.model.api.Paged
import ${packageName}.model.api.Paging
import ${packageName}.model.db.${className}
<#if table.hasCode>
import ${packageName}.util.CommonUtil
</#if>
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22
</#if>
<#if table.hasOrgan || table == loginTable || (hasLogin && table.hasCreator)>
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

	/**
	 * ${table.remarkName}列表
	 * @param paging 分页对象
<#if table.hasSearches>
	 * @param key 搜索关键字
</#if>
	 */
    fun list(paging: Paging<#if table.hasSearches>, key: String?</#if>): Paged<${className}> {
<#if table.hasSearches || (hasOrgan && table.hasOrgan)>
        return Tables.${table.className}.run {
			var where = where(<#if hasOrgan && table.hasOrgan && !loginTable.orgColumn.nullable>${table.orgColumn.fieldNameUpper}.eq(JwtUtils.currentBearer().${table.orgColumn.fieldName})<#else></#if>)
			<#if hasOrgan && table.hasOrgan && loginTable.orgColumn.nullable>
			val ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName}
			if (${table.orgColumn.fieldName} != null) {
				where = where.and(${table.orgColumn.fieldNameUpper}.eq(${table.orgColumn.fieldName}))
			}
			</#if>
			<#if table.hasSearches>
			if (!key.isNullOrBlank()) {
				where = where.and(<#list table.searchColumns as column><#if column_index gt 0>.or(</#if>${column.fieldNameUpper}.like("%$key%")<#if column_index gt 0>)</#if></#list>)
			}
			</#if>
			Paged(paging, mapper.selectWhere(where, paging.toRowBounds()))
		}
<#else >
		return Paged(paging, mapper.selectWhere(null, paging.toRowBounds()))
</#if>
    }

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
<#if table.hasOrgan>
		val ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName}
</#if>
<#if table.hasCode>
	<#if table.hasOrgan>
		val code = commonMapper.maxCodeByTableAndOrg(Tables.${table.className}.name, ${table.orgColumn.fieldName})
	<#else>
		val code = commonMapper.maxCodeByTable(Tables.${table.className}.name)
	</#if>
		model.${table.codeColumn.fieldName} = CommonUtil.formatCode(code)
</#if>
<#if table.hasOrgan>
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

	/**
	 * 获取${table.remarkName}
	 * @param id 数据主键
	 × @return 数据实体对象
	 */
    fun findById(id: Any): ${className}? {
	<#if table.hasOrgan>
		val model = mapper.findById(id) ?: throw ClientException("无效的${table.remarkName}Id")
		<#if hasLogin && loginTable.orgColumn.nullable>
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
		return mapper.findById(id)
	</#if>
	}

	/**
	 * 获取${table.remarkName}
	 * @param ids 数据主键
	 × @return 返回数据修改的行数
	 */
    fun deleteById(ids: String): Int {
	<#if table.hasOrgan || table == loginTable>
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
		return mapper.deleteById(*ids.split(",").toTypedArray())
	}

</#if>
}
