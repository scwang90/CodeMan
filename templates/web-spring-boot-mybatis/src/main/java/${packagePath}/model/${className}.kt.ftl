package ${packageName}.model;

import io.swagger.annotations.ApiModelProperty

/**
 * ${table.remark}
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class ${className} {

	<#list table.columns as column>
	/**
	 * ${column.remark}
		<#if column.nameSQL!=column.fieldName>
     * 数据库名称 ${column.nameSQL}
		</#if>
	 */
    @ApiModelProperty("${column.remark}")
	var ${column.fieldName}: ${column.fieldType}? = null
	</#list>

}