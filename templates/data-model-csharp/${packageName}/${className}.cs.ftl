using System;

namespace ${packageName}.Model
{
	/// <summary>
    /// ${table.remark}
	/// 创建者：${author}
    /// </summary>
	[Table("${table.name}")]
	public class ${className} : CustomerServiceModelBase
	{
	<#list table.columns as column>
    	/// <summary>
        ///${column.remark}
        /// </summary>
    	public virtual ${column.fieldType} ${column.fieldName} { get; set; }
	</#list>

	}
}