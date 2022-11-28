package ${packageName}.model.db

<#assign hasJsonIgnore=false>
<#list table.columns as column>
	<#if hasJsonIgnore==false && column.hiddenForClient>
import com.fasterxml.jackson.annotation.JsonIgnore
		<#assign hasJsonIgnore=true>
	</#if>
</#list>
<#assign hasLong2String=false>
<#list table.columns as column>
	<#if hasLong2String==false && column.longType>
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer
		<#assign hasLong2String=true>
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
 * 数据库表【${table.name}】
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
	<#if column.longType && !column.forceUseLong>
	@JsonSerialize(using = ToStringSerializer::class)// Long返回前端JS，与 number 精度不匹配，会导致信息丢失，需要序列化为String
	</#if>
	<#if column.stringType && (column.length > 0)>
	@Size(max = ${column.length?c}, message = "【${tools.toInStr(column.remark)}】不能超过${column.length}个字符")
	</#if>
	@ApiModelProperty(value = "${tools.toInStr(column.remark)}"<@compress single_line=true>
		<#if column.nullable != true && (!column.hiddenForSubmit || column == table.idColumn)>, required = true</#if>
		<#if column.hiddenForClient>, hidden = true</#if>
		<#if !column.hiddenForSubmit><#if column.dateType>, example = "yyyy-MM-dd HH:mm:ss"<#elseif column.defValue?length != 0>, example = "${column.defValue?trim}"<#elseif column.intType && !column.primaryKey>, example = "0"</#if></#if>
		<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if>
	</@compress>)
	<#if column == table.idColumn>
	var ${column.fieldName}: ${column.fieldType} = <#if column.stringType>""<#else>0</#if>
	<#else>
	var ${column.fieldName}: ${column.fieldType}? = null
	</#if>
	</#list>

}