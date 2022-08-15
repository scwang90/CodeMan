

export default interface ${className} {
<#list table.columns as column>
    <#assign options=column.nullable ? string('?','')/>
    <#if !column.hiddenForClient>
        <#if column.stringType || column.timeType || column.dateType || (column.longType && !column.forceUseLong)>
    ${column.fieldName}${options}: string
        <#elseif column.boolType>
    ${column.fieldName}${options}: boolean
        <#else >
    ${column.fieldName}${options}: number
        </#if>
    </#if>
</#list>
}