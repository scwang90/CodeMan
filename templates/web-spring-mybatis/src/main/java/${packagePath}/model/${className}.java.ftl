package ${packageName}.model;

<#list table.columns as column>
<#if column.nameSQL!=column.fieldName>
<#if (columnAdded!false)==false>
import ${packageName}.annotations.dbmodel.Column;
<#assign columnAdded=true>
</#if>
</#if>
</#list>
import ${packageName}.annotations.dbmodel.Id;
import ${packageName}.annotations.dbmodel.Table;
import ${packageName}.model.base.ModelBase;

/**
 * ${table.remark}
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@Table("${table.nameSQL}")
public class ${className} extends ModelBase{

	<#list table.columns as column>
	/**
	 * ${column.remark}
	 */
	<#if column.name==table.idColumn.name>
	@Id
	</#if>
	<#if column.nameSQL!=column.fieldName>
	@Column("${column.nameSQL}")
	</#if>
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