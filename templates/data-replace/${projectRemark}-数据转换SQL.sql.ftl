<#list tables as table>
    <#list table.columns as column>
        <#if column.name != column.replaceName>
alter table ${table.name} rename column ${column.name} to ${column.replaceName};
        </#if>
        <#if (column.replaceRemark?length > 0) >
comment on column ${table.name}.${column.replaceName} is '${column.replaceRemark}';
        </#if>
    </#list>
    <#if table.name != table.replaceName>
rename ${table.name} to ${table.replaceName};
    </#if>
    <#if (table.replaceRemark?length > 0) >
comment on table ${table.replaceName} is '${table.replaceRemark}';
    </#if>

</#list>


