SET NAMES utf8mb4;

<#list tables as table>

CREATE TABLE ${table.nameSql}
(
    <#assign maxName = 0/>
    <#assign maxType = 0/>
    <#assign hasNullble = false/>
    <#assign hasNonNullble = false/>
    <#list table.columns as column>
        <#if maxName lt column.nameSql?length>
            <#assign maxName = column.nameSql?length/>
        </#if>
        <#assign tempType = column.type?length/>
        <#if column.length gt 0 && column.stringType && column.typeInt != -1>
            <#assign tempType = tempType + (column.length?c)?length + '()'?length/>
        </#if>
        <#if column.defValue??>
            <#if column.stringType || column.dateType || column.timeType>
                <#assign tempType = tempType + column.defValue?length + ' DEFAULT ""'?length/>
            <#else >
                <#assign tempType = tempType + column.defValue?length + ' DEFAULT '?length/>
            </#if>
        </#if>
        <#if maxType lt tempType>
            <#assign maxType = tempType/>
        </#if>
        <#if column.notNull && column.primaryKey == false>
            <#assign hasNonNullble = true/>
        <#else>
            <#assign hasNullble = true/>
        </#if>
    </#list>
    <#list table.columns as column>
        <#assign name = column.nameSql?right_pad(maxName)/>
        <#assign type = column.type/>
        <#assign tempType = column.type?length/>
        <#if column.length gt 0 && column.stringType && column.typeInt != -1>
            <#assign type = type + '(${column.length?c})'/>
            <#assign tempType = tempType + (column.length?c)?length + '()'?length/>
        </#if>
        <#if column.hasDefValue>
            <#if column.stringType || column.dateType || column.timeType>
                <#assign type = type + " DEFAULT '${column.defValue}'"/>
                <#assign tempType = tempType + column.defValue?length + ' DEFAULT ""'?length/>
            <#else >
                <#assign type = type + ' DEFAULT ${column.defValue}'/>
                <#assign tempType = tempType + column.defValue?length + ' DEFAULT '?length/>
            </#if>
        </#if>
        <#assign end = ''/>
        <#if column.primaryKey && table.idColumns?size == 1>
<#--            <#if hasNonNullble && hasNullble>-->
<#--                <#assign end = end + '    '/>-->
<#--            </#if>-->
            <#if column.autoIncrement>
                <#assign end = '${end} AUTO_INCREMENT'/>
            </#if>
            <#assign end = '${end} PRIMARY KEY'/>
        <#else >
            <#if column.nullable>
                <#if column.defValue?length == 0>
                    <#if hasNonNullble>
                        <#assign end = end + '     NULL'/>
                    <#else>
                        <#assign end = end + ' NULL'/>
                    </#if>
                </#if>
            <#else>
                <#assign end = end + ' NOT NULL'/>
            </#if>
        </#if>
        <#if column.comment?length gt 0>
            <#assign end = "${end} COMMENT '${column.comment}'"/>
        </#if>
    ${name} ${type}${''?right_pad(maxType-tempType)} ${end}<#if column_has_next || table.idColumns?size &gt; 1>,</#if>
    </#list>
    <#if table.idColumns?size &gt; 1>
        PRIMARY KEY (<#list table.idColumns as idColumn>${idColumn.name}<#if idColumn_has_next>, </#if></#list>)
    </#if>
)
COMMENT '${table.comment}' COLLATE = utf8mb4_unicode_ci;

</#list>

# 开始添加索引
<#list tables as table>
    <#list table.indexedKeys as index>

CREATE<#if index.nonUnique> UNIQUE</#if> INDEX ${index.name} ON ${table.nameSql} (${index.columnName});
    </#list>
</#list>

# 开始添加外健
<#list tables as table>
    <#if table.importedKeys?size gt 0>

# ${table.remarkName} 外键定义
        <#list table.importedKeys as key>
            <#assign updateRule = ''/>
            <#assign deleteRule = ''/>
            <#if key.deleteCascade>
                <#assign deleteRule = 'ON DELETE CASCADE'/>
            <#elseif key.deleteSetDefault>
                <#assign deleteRule = 'ON DELETE SET DEFAULT'/>
            <#elseif key.deleteSetNull>
                <#assign deleteRule = 'ON DELETE SET NULL'/>
            </#if>
            <#if key.updateCascade>
                <#assign deleteRule = 'ON UPDATE CASCADE'/>
            <#elseif key.updateSetDefault>
                <#assign deleteRule = 'ON UPDATE SET DEFAULT'/>
            <#elseif key.updateSetNull>
                <#assign deleteRule = 'ON UPDATE SET NULL'/>
            </#if>
ALTER TABLE ${table.nameSql}
    ADD CONSTRAINT ${key.fkName}
        FOREIGN KEY (${key.fkColumnName}) REFERENCES ${key.pkTable.nameSql} (${key.pkColumnName})<#if updateRule?length==0&&deleteRule?length==0>;</#if>
            <#if updateRule?length gt 0 || deleteRule?length gt 0>
                ${updateRule} ${deleteRule};
            </#if>
        </#list>

    </#if>
</#list>