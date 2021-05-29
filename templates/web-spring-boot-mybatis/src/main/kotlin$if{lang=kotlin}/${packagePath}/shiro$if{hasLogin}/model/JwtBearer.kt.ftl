package ${packageName}.shiro.model

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
<#if loginTable.hasOrgan>
data class JwtBearer(val type: String, val userId: ${loginTable.idColumn.fieldType}, val ${loginTable.orgColumn.fieldName}: ${orgColumn.fieldType}<#if loginTable.orgColumn.nullable>?</#if>)
<#else >
data class JwtBearer(val type: String, val userId: ${loginTable.idColumn.fieldType})
</#if>