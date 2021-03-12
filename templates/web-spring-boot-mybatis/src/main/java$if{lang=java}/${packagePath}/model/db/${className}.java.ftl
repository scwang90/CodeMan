package ${packageName}.model.db;

import ${packageName}.model.Entity;

import io.swagger.annotations.ApiModelProperty;

<#assign hasStringType=false>
<#assign hasStringRequired=false>
<#list table.columns as column>
<#--	<#if column.stringType && !column.nullable && hasStringRequired==false>-->
<#--import javax.validation.constraints.NotEmpty;-->
<#--        <#assign hasStringRequired=true>-->
<#--	</#if>-->
	<#if column.stringType && hasStringType==false>
import javax.validation.constraints.Size;
        <#assign hasStringType=true>
	</#if>
</#list>

/**
 * ${table.remark}
	<#list table.descriptions as description>
 * ${description}
	</#list>
    <#if table.name!=table.className>
 * 数据库名称 ${table.name}
    </#if>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ${className} extends Entity {

	<#list table.columns as column>
	/**
	 * ${column.remark}<#if column == table.idColumn>【数据库主键】</#if>
		<#list column.descriptions as description>
	 * ${description}
		</#list>
		<#if column.name!=column.fieldName>
	 * 数据库名称 ${column.name}
		</#if>
	 */
	<#if column.stringType>
	@Size(max = ${column.length?c}, message = "${column.remark}不能超过${column.length}个字符")
	</#if>
	<#if column == table.createColumn || column == table.updateColumn>
	@com.fasterxml.jackson.annotation.JsonIgnore
	@ApiModelProperty(value = "${column.remark}"<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if><#if column.nullable!=true>, hidden = true</#if>)
	<#else>
	@ApiModelProperty(value = "${column.remark}"<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if><#if column.nullable!=true>, required = true</#if>)
	</#if>
	private ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
	}
	<#list table.columns as column>

	public ${column.fieldType} get${column.fieldNameUpper}() {
		return this.${column.fieldName};
	}

	public void set${column.fieldNameUpper}(${column.fieldType} ${column.fieldName}) {
		this.${column.fieldName} = ${column.fieldName};
	}
	</#list>
}
