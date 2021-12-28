
<#list tables as table>
/**
 * ${table.remark}
    <#list table.descriptions as description>
 * ${description}
    </#list>
 */
export interface ${table.className} {
    <#list table.columns as column>
        <#if !column.hiddenForClient>
            <#if column.stringType || column.timeType || column.dateType || (column.longType && !column.forceUseLong)>
    ${column.fieldName}?: string
            <#else >
    ${column.fieldName}?: number
            </#if>
        </#if>
    </#list>
}
</#list>
