package ${packageName}.model.db

import io.swagger.annotations.ApiModelProperty

/**
 * ${table.remark} (包含外键数据)
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
open class ${className}Bean : ${className}() {
	<#list table.importCascadeKeys as key>

	/*
	 * 关联${key.pkTable.remarkName}
	 */
	@ApiModelProperty(value = "关联${key.fkTable.remarkName}", notes = "一对一关联")
	<#if key.fkColumn.nullable><#else>lateinit </#if>var ${tools.idToModel(key.fkColumn.fieldName)}: ${key.pkTable.className}<#if key.fkColumn.nullable>? = null</#if>
	</#list>
	<#list table.exportCascadeKeys as key>

	/*
	 * ${key.fkTable.remarkName}列表
	 */
	@ApiModelProperty(value = "${key.fkTable.remarkName}列表", notes = "一对多关联")
	var ${tools.toPlural(key.fkTable.classNameCamel)}: List<${key.fkTable.className}> = listOf()
	</#list>
	<#list table.relateCascadeKeys as key>

	/*
	 * 关联${key.targetTable.remarkName}列表
	 */
	@ApiModelProperty(value = "${key.targetTable.remarkName}列表", notes = "通过${key.relateTable.remarkName}表多对多关联")
	var related${tools.toPlural(key.targetTable.className)}: List<${key.targetTable.className}> = listOf()
	</#list>

}