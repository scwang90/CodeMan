using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ${packageName}
{
	/// <summary>
    /// ${table.remark}
	/// 创建者：${author}
    /// </summary>
	[Table("${table.name}")]
	public class ${className} : CustomerServiceModelBase
	{
	<#list table.columns as column>
	<#if column.name!=table.idColumn.name>
    	/// <summary>
        ///${column.remark}
        /// </summary>
		<#if column.length!=-1>
        [Column(TypeName = "${column.type}")]
        [StringLength(${column.length})]
		</#if>
    	public virtual ${column.fieldType} ${column.fieldName} { get; set; }
	</#if>
	</#list>

	}
}