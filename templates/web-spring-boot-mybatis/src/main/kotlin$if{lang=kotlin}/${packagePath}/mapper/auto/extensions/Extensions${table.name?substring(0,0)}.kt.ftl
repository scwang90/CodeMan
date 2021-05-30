package ${packageName}.mapper.auto.extensions

<#list tables as table>
import ${packageName}.mapper.auto.${table.className}AutoMapper
</#list>
import ${packageName}.mapper.intent.Tables
import ${packageName}.mapper.intent.api.Query
import ${packageName}.mapper.intent.api.WhereQuery
<#list tables as table>
import ${packageName}.mapper.intent.tables.${table.classNameUpper}
</#list>
<#list tables as table>
import ${packageName}.model.db.${table.className}
<#if table.hasCascadeKey>
import ${packageName}.model.db.${table.className}Bean
</#if>
</#list>
import org.apache.ibatis.session.RowBounds
<#list tables as table>
    <#assign beans = ['']/>
    <#if table.hasCascadeKey>
        <#assign beans = ['', 'Bean']/>
    </#if>

fun ${table.className}AutoMapper.count(where: ${table.classNameUpper}.()-> WhereQuery<${table.className}>): Int {
    return this.countWhere(where.invoke(Tables.${table.className}))
}

fun ${table.className}AutoMapper.delete(where: ${table.classNameUpper}.()-> WhereQuery<${table.className}>): Int {
    return this.deleteWhere(where.invoke(Tables.${table.className}))
}

fun ${table.className}AutoMapper.update(setter: ${table.classNameUpper}.()-> ${table.classNameUpper}.SetterQuery): Int {
    return this.updateSetter(setter.invoke(Tables.${table.className}))
}
    <#list beans as bean>

fun ${table.className}AutoMapper.select${bean}All(): List<${table.className}${bean}> {
    return this.select${bean}Where(null)
}

fun ${table.className}AutoMapper.select${bean}(where: ${table.classNameUpper}.()-> Query<${table.className}>): List<${table.className}${bean}> {
    return this.select${bean}Where(where.invoke(Tables.${table.className}))
}

fun ${table.className}AutoMapper.select${bean}(rows: RowBounds, where: ${table.classNameUpper}.()-> Query<${table.className}>): List<${table.className}${bean}> {
    return this.select${bean}Where(where.invoke(Tables.${table.className}), rows)
}

fun ${table.className}AutoMapper.select${bean}One(where: ${table.classNameUpper}.()-> Query<${table.className}>): ${table.className}${bean}? {
    return this.select${bean}OneWhere(where.invoke(Tables.${table.className}))
}
        <#list table.importCascadeKeys as key>

            <#assign removeWhere = ''/>
            <#if table.hasRemove>
                <#if table.removeColumn.boolType>
                    <#assign removeWhere = '${table.removeColumn.fieldNameUpper}.eq(false)'/>
                <#elseif table.removeColumn.intType>
                    <#assign removeWhere = '${table.removeColumn.fieldNameUpper}.eq(0)'/>
                <#else>
                    <#assign removeWhere = '${table.removeColumn.fieldNameUpper}.ne("removed")'/>
                </#if>
                <#if table.removeColumn.nullable>
                    <#assign removeWhere = '${removeWhere}.or(${table.removeColumn.fieldNameUpper}.isNull)'/>
                </#if>
                <#assign removeWhere = '.and(${removeWhere})'/>
            </#if>
fun ${table.className}AutoMapper.select${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}: ${key.fkColumn.fieldType}, where: ${table.classNameUpper}.()-> Query<${table.className}>): List<${table.className}${bean}> {
    return this.select${bean}Where(Tables.${table.className}.run { ${key.fkColumn.fieldNameUpper}.eq(${key.fkColumn.fieldName})${removeWhere}.and(where.invoke(this) as WhereQuery<${table.className}>) })
}

fun ${table.className}AutoMapper.select${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}: ${key.fkColumn.fieldType}, rows: RowBounds, where: ${table.classNameUpper}.()-> Query<${table.className}>): List<${table.className}${bean}> {
    return this.select${bean}Where(Tables.${table.className}.run { ${key.fkColumn.fieldNameUpper}.eq(${key.fkColumn.fieldName})${removeWhere}.and(where.invoke(this) as WhereQuery<${table.className}>) }, rows)
}
        </#list>
    </#list>

</#list>