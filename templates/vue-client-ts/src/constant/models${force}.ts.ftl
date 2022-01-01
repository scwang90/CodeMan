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
            <#if column.longType && !column.forceUseLong>
    ${column.fieldName}?: string
            <#else >
    ${column.fieldName}?: ${column.fieldType}
            </#if>
        </#if>
    </#list>
}
    <#if table.hasCascadeKey>

/**
 * ${table.remark} (包含外键数据)
<#list table.descriptions as description>
 * ${description}
</#list>
 */
export interface ${table.className}Bean extends ${table.className} {
        <#list table.importCascadeKeys as key>

    /*
     * 关联${key.pkTable.remarkName}(一对一关联)
     */
    ${tools.idToModel(key.fkColumn.fieldName)}: ${key.pkTable.className}
        </#list>
        <#list table.exportCascadeKeys as key>

    /*
     * ${key.fkTable.remarkName}列表(一对多关联)
     */
    ${tools.makeOneManyFiled(key)}: Array<${key.fkTable.className}>
        </#list>
        <#list table.relateCascadeKeys as key>

    /*
     * 关联${key.targetTable.remarkName}列表(通过${key.relateTable.remarkName}表多对多关联)
     */
    related${tools.toPlural(key.targetTable.className)}: Array<${key.targetTable.className}>
        </#list>
}
    </#if>
</#list>
