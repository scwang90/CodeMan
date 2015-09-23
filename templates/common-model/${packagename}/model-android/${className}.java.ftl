package ${packagename}.model;

/**
 * ${table.remark}
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
//@Table("${table.name}")
public class ${className}{

	<#list table.columns as column>
	/**
	 * ${column.remark}
	 */
	<#if column.name==table.idColumn.name>
	//@Id
	</#if>
	<#if column.name!=column.fieldName>
	//@Column("${column.name}")
	</#if>
	public ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
	}

}