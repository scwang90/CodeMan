package ${packageName}.model.db;

<#assign hasJsonIgnore=false>
<#list table.columns as column>
	<#if hasJsonIgnore==false && column.hiddenForClient>
import com.fasterxml.jackson.annotation.JsonIgnore;
		<#assign hasJsonIgnore=true>
	</#if>
</#list>
<#assign hasLong2String=false>
<#list table.columns as column>
	<#if hasLong2String==false && column.longType>
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
		<#assign hasLong2String=true>
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
<#assign hasDateTimeType=false>
<#list table.columns as column>
	<#if (column.dateType || column.timeType) && hasDateTimeType==false>
import org.springframework.format.annotation.DateTimeFormat;
		<#assign hasDateTimeType=true>
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
		<#list table.importCascadeKeys as key>
			<#if key.fkColumn == column>
	 * 数据库外健 ${key.name} ${key.pkTable.className}.${key.pkColumn.fieldName}
			</#if>
		</#list>
		<#list table.relateCascadeKeys as key>
			<#if key.localColumn == column>
	 * 数据库关联 ${key.relateTable.className} ${key.targetTable.className}.${key.targetColumn.fieldName}
			</#if>
		</#list>
	 */
	<#if column.hiddenForClient>
	@JsonIgnore
	</#if>
	<#if column.timeType>
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	<#elseif column.dateType>
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	</#if>
	<#if column.stringType>
	@Size(max = ${column.length?c}, message = "【${column.remark}】不能超过${column.length}个字符")
	</#if>
	<#if column.longType && !column.forceUseLong>
	@JsonSerialize(using = ToStringSerializer.class)// Long返回前端JS，与 number 精度不匹配，会导致信息丢失，需要序列化为String
	</#if>
	@ApiModelProperty(value = "${column.remark}"<@compress single_line=true>
		<#if column.nullable != true>, required = true</#if>
		<#if column.hiddenForClient>, hidden = true</#if>
		<#if column.dateType>, example = "yyyy-MM-dd HH:mm:ss"<#elseif column.defValue?length != 0>, example = "${column.defValue?trim}"<#elseif column.intType && !column.primaryKey>, example = "0"</#if>
		<#if (column.description?trim?length > 0)>, notes = "${column.description?replace("\n","\\n")}"</#if>
	</@compress>)
	private <#if column == table.idColumn>${column.fieldTypePrimitive}<#else>${column.fieldTypeObject}</#if> ${column.fieldName};
	</#list>

	public ${className}() {
	}
	<#list table.columns as column>

	public <#if column == table.idColumn>${column.fieldTypePrimitive}<#else>${column.fieldTypeObject}</#if> get${column.fieldNameUpper}() {
		return this.${column.fieldName};
	}

	public void set${column.fieldNameUpper}(<#if column == table.idColumn>${column.fieldTypePrimitive}<#else>${column.fieldTypeObject}</#if> ${column.fieldName}) {
		this.${column.fieldName} = ${column.fieldName};
	}
	</#list>
}
