package ${packagename}.model;

import ${packagename}.annotations.dbmodel.Id;
import ${packagename}.annotations.dbmodel.Table;

/**
 * ${table.remark}
 * @author ${author}
 */
@Table("${table.name}")
public class ${className}{

	// Fields
	@Id
	<#list table.columns as column>
	/**
	 * ${column.remark}
	 */
	private ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
		// TODO Auto-generated constructor stub
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