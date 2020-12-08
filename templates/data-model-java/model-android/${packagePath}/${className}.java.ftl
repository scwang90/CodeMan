package ${packageName};

/**
 * ${table.remark}
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
//@Table("${table.name}")
public class ${className}{

	<#list table.columns as column>
	/**
	 * ${column.remark}
	 */
	<#if column == table.idColumn>
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