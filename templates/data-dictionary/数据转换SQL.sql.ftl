<#list tables as table>
    <#list table.columns as column>
        <#if column.name != column.nameSql>
alter table ${table.name} rename column ${column.name} to ${column.nameSql}
        </#if>
        <#if (column.nameSqlInStr?length > 0) >
comment on column ${table.name}.${column.nameSql} is '${column.nameSqlInStr}'
        </#if>
    </#list>
    <#if table.name != table.nameSql>
rename ${table.name} to ${table.nameSql}
    </#if>
    <#if (table.nameSqlInStr?length > 0) >
comment on table ${table.nameSql} is '${table.nameSqlInStr}'
    </#if>
    ;
</#list>


