

export default interface ${className} {
<#list table.columns as column>
    <#if column.stringType || column.timeType || column.dateType>
    ${column.fieldName}?: string
    <#else >
    ${column.fieldName}?: number
    </#if>
</#list>
}