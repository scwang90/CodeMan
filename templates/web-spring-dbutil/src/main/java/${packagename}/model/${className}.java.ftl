package ${packagename}.model;

<#list table.columns as column>
<#if column.name!=column.fieldName>
<#assign needColumn=true>
</#if>
</#list>

import ${packagename}.annotations.dbmodel.Id;
import ${packagename}.annotations.dbmodel.Table;
<#if needColumn!false>
import ${packagename}.annotations.dbmodel.Column;
</#if>
/**
 * ${table.remark}
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@Table("${table.name}")
public class ${className}{

	// Fields
	@Id
	<#list table.columns as column>
	/**
	 * ${column.remark}
	 */<#if column.name!=column.fieldName>${"\n"}	@Column("${column.name}")</#if>
	private ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
	}
	
	<#list table.columns as column>
	public ${column.fieldType} get${column.fieldName_u}(){
		return this.${column.fieldName};
	}

	public void set${column.fieldName_u}(${column.fieldType} ${column.fieldName}) {
		this.${column.fieldName} = ${column.fieldName};
	}
		
	</#list>

}