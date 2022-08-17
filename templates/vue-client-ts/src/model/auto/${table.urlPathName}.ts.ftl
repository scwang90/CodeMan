

export default interface ${className} {
<#list table.columns as column>
    <#if !column.hiddenForClient>
        <#assign type="any"/>
        <#if column.stringType || column.timeType || column.dateType || (column.longType && !column.forceUseLong)>
            <#assign type="string"/>
        <#elseif column.boolType>
            <#assign type="boolean"/>
        <#else >
            <#assign type="number"/>
        </#if>
    ${column.fieldName}${column.nullable ? string('?','')}: ${type}      //${column.remark}
    </#if>
</#list>
}