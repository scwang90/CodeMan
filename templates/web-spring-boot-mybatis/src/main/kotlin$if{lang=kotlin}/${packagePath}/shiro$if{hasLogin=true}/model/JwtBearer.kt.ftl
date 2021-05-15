package ${packageName}.shiro.model

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
<#if loginTable.hasOrgan>
    <#assign orgFieldType=orgColumn.fieldType/>
    <#if loginTable.orgColumn.nullable>
        <#assign orgFieldType=orgColumn.fieldTypeObject/>
    </#if>
data class JwtBearer(val type: String, val ${loginTable.orgColumn.fieldName}: ${orgFieldType}, val userId: ${loginTable.idColumn.fieldType})
<#else >
data class JwtBearer(val type: String, val userId: ${loginTable.idColumn.fieldType})
</#if>