package ${packageName}.model.db;

import ${packageName}.model.Entity;

import io.swagger.annotations.ApiModelProperty;

<#assign hasStringType=false>
<#list table.columns as column>
	<#if column.nameSQL!=column.fieldName>
		<#if hasStringType==false>
import javax.validation.constraints.Size;
			<#assign hasStringType=true>
		</#if>
	</#if>
</#list>
/**
 * ${table.remark}
	<#if ((table.description!"")?trim?length > 0)>
 * 详细描述：${table.description?replace("\n","\\n")}
	</#if>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ${className} extends Entity {

	<#list table.columns as column>
	/**
	 * ${column.remark}
		<#if ((column.description!"")?trim?length > 0)>
	 * 详细描述：${column.description?replace("\n","\\n")}
		</#if>
		<#if column.nameSQL!=column.fieldName>
	 * 数据库名称 ${column.nameSQL}
		</#if>
	 */
	<#if column.isStringType()>
	@Size(max = ${column.length?c}, message = "${column.remark}不能超过${column.length}个字符")
	</#if>
	@ApiModelProperty(value = "${column.remark}"<#if column.nullable!=true>, required = true</#if>)
	private ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
	}
	<#list table.columns as column>

	public ${column.fieldType} get${column.fieldNameUpper}(){
		return this.${column.fieldName};
	}

	public void set${column.fieldNameUpper}(${column.fieldType} ${column.fieldName}) {
		this.${column.fieldName} = ${column.fieldName};
	}
	</#list>
}
