package ${packageName}.model.db;

import ${packageName}.model.Entity;

import io.swagger.annotations.ApiModelProperty;

/**
 * ${table.remark}
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public class ${className} extends Entity {

	<#list table.columns as column>
	/**
	 * ${column.remark}
		<#if column.nameSQL!=column.fieldName>
	 * 数据库名称 ${column.nameSQL}
		</#if>
	 */
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
