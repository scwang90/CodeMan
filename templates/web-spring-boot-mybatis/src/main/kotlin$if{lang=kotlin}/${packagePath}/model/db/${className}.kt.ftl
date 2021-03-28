package ${packageName}.model.db;

import ${packageName}.model.Entity
import io.swagger.annotations.ApiModelProperty

/**
 * ${table.remark}
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ${className} : Entity() {

	<#list table.columns as column>
	/**
	 * ${column.remark}
		<#if column.nameSql!=column.fieldName>
     * 数据库名称 ${column.nameSql}
		</#if>
	 */
    @ApiModelProperty("${column.remark}")
	var ${column.fieldName}: ${column.fieldType}? = null
	</#list>

}