package ${packageName}.mapper.intent

import ${packageName}.mapper.intent.tables.*

/**
 * Convenience access to all tables in
 */
object Tables {
<#list tables as table>

    /**
     * The table ${table.className}
     */
    val ${table.className} = ${table.classNameUpper}.TABLE
</#list>

}
