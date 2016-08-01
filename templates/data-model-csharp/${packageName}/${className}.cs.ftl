using System;

namespace ${packageName}
{
	/// <summary>
    /// ${table.remark}
	/// 创建者：${author}
    /// </summary>
	//[Table("${table.name}")]
	public class ${className}
	{
	<#list table.columns as column>
    	/// <summary>
        ///${column.remark}
        /// </summary>
    	//[Column(TypeName = "${column.type}")]
    	public virtual ${column.fieldType} ${column.fieldName} { get; set; }
	</#list>

	}
}