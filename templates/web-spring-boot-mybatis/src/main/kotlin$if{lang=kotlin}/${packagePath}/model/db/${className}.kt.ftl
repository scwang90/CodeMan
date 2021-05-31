package ${packageName}.model.db

<#assign hasJsonIgnore=false>
<#list table.columns as column>
	<#if hasJsonIgnore==false && column.hiddenForClient>
import com.fasterxml.jackson.annotation.JsonIgnore
		<#assign hasJsonIgnore=true>
	</#if>
</#list>
import io.swagger.annotations.ApiModelProperty
<#assign hasStringType=false>
<#list table.columns as column>
	<#if column.stringType && hasStringType==false>
import javax.validation.constraints.Size
		<#assign hasStringType=true>
	</#if>
</#list>

/**
 * ${table.remark}
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
open class ${className} {

	<#list table.columns as column>
	/**
	 * ${column.remark}<#if column == table.idColumn>【数据库主键】</#if>
		<#list column.descriptions as description>
	 * ${description}
		</#list>
		<#if column.nameSql!=column.fieldName>
     * 数据库名称 ${column.nameSql}
		</#if>
	 */
	<#if column.hiddenForClient>
	@JsonIgnore
	</#if>
	<#if column.stringType>
	@Size(max = ${column.length?c}, message = "【${column.remark}】不能超过${column.length}个字符")
	</#if>
	@ApiModelProperty(value = "${column.remark}"<@compress single_line=true>
		<#if column.nullable != true>, required = true</#if>
		<#if column.hiddenForClient>, hidden = true</#if>
		<#if column.dateType>, example = "yyyy-MM-dd HH:mm:ss"<#elseif column.defValue?length != 0>, example = "${column.defValue?trim}"<#elseif column.intType && !column.primaryKey>, example = "0"</#if>
		<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if>
	</@compress>)
	<#if column == table.idColumn>
	var ${column.fieldName}: ${column.fieldType} = <#if column.stringType>""<#else>0</#if>
	<#else>
	var ${column.fieldName}: ${column.fieldType}? = null
	</#if>
	</#list>

}