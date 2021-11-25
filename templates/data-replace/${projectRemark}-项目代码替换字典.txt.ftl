<#list tables as table>
    <#if table.name != table.replaceName>
regex:(?i)\b${table.name}\b-${table.replaceName}
    </#if>
</#list>