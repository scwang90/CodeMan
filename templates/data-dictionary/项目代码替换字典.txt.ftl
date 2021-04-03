<#list tables as table>
    <#if table.name != table.nameSql>
regex:(?i)\b${table.name}\b-${table.nameSql}
    </#if>
</#list>