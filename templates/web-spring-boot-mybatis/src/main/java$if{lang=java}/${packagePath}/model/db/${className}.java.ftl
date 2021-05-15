package ${packageName}.model.db;

<#assign hasJsonIgnore=false>
<#list table.columns as column>
	<#if hasJsonIgnore==false && column.hiddenForClient>
import com.fasterxml.jackson.annotation.JsonIgnore;
		<#assign hasJsonIgnore=true>
	</#if>
</#list>
import io.swagger.annotations.ApiModelProperty;
<#assign hasStringType=false>
<#list table.columns as column>
	<#if column.stringType && hasStringType==false>
import javax.validation.constraints.Size;
        <#assign hasStringType=true>
	</#if>
</#list>

/**
 * ${table.remark}
	<#list table.descriptions as description>
 * ${description}
	</#list>
    <#if table.name!=table.className>
 * 数据库名称 ${table.name}
    </#if>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ${className} {

	<#list table.columns as column>
	/**
	 * ${column.remark}<#if column == table.idColumn>【数据库主键】</#if>
		<#list column.descriptions as description>
	 * ${description}
		</#list>
		<#if column.name!=column.fieldName>
	 * 数据库名称 ${column.name}
		</#if>
	 */
	<#if column.hiddenForClient>
	@JsonIgnore
	</#if>
	<#if column.stringType>
	@Size(max = ${column.length?c}, message = "【${column.remark}】不能超过${column.length}个字符")
	</#if>
	@ApiModelProperty(value = "${column.remark}"<@compress single_line=true>
		<#if column.nullable != true>, required = true</#if>
		<#if column.hiddenForClient>, hidden = true</#if>
		<#if column.dateType>, example = "yyyy-MM-dd HH:mm:ss"</#if>
		<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if>
	</@compress>)
	private ${column.fieldType} ${column.fieldName};
	</#list>

	public ${className}() {
	}
	<#list table.columns as column>

	public ${column.fieldType} get${column.fieldNameUpper}() {
		return this.${column.fieldName};
	}

	public void set${column.fieldNameUpper}(${column.fieldType} ${column.fieldName}) {
		this.${column.fieldName} = ${column.fieldName};
	}
	</#list>
}
