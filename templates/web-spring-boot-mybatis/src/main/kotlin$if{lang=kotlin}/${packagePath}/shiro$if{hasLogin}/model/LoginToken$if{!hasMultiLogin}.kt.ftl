package ${packageName}.shiro.model

import org.apache.shiro.authc.AuthenticationToken

<#if hasMultiLogin>
    <#list loginTables as table>
/**
 * ${table.remarkName}登录 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class ${table.className}Token(<#if table.hasOrgan>val ${table.orgColumn.fieldName}: ${table.orgColumn.fieldType}, </#if>val username: String, val password: String) : AuthenticationToken {

    override fun getPrincipal(): Any {
        return username
    }

    override fun getCredentials(): Any {
        return password
    }

}

    </#list>
<#else >
/**
 * 用户登录 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class LoginToken(<#if loginTable.hasOrgan>val ${loginTable.orgColumn.fieldName}: ${loginTable.orgColumn.fieldType}, </#if>val username: String, val password: String) : AuthenticationToken {

    override fun getPrincipal(): Any {
        return username
    }

    override fun getCredentials(): Any {
        return password
    }

}
</#if>
