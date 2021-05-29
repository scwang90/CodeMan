package ${packageName}.service

import com.auth0.jwt.algorithms.Algorithm
import ${packageName}.constant.UserType
import ${packageName}.model.api.LoginInfo
import ${packageName}.model.conf.AuthConfig
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className}
    </#list>
<#else >
import ${packageName}.model.db.${loginTable.className}
</#if>
import ${packageName}.shiro.model.JwtBearer
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.shiro.model.${table.className}Token
    </#list>
<#else >
import ${packageName}.shiro.model.LoginToken
</#if>

import ${packageName}.util.JwtUtils
import org.apache.shiro.SecurityUtils
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

/**
 * 登录认证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
class AuthService {

    @Autowired
    private lateinit var authConfig: AuthConfig
    @Autowired
    private lateinit var jwtAlgorithm: Algorithm

<#if hasMultiLogin>
    <#list loginTables as table>
    @Transactional(rollbackFor = [Throwable::class])
    fun login${table.className}(<#if table.hasOrgan>${table.orgColumn.fieldName}: ${table.orgColumn.fieldType}, </#if>username: String, password: String): LoginInfo<${table.className}> {
        val subject = SecurityUtils.getSubject().apply { login(${table.className}Token(<#if table.hasOrgan>${table.orgColumn.fieldName}, </#if>username, password)) }
        val ${table.classNameCamel} = subject.principals.oneByType(${table.className}::class.java)<#if table.hasPassword>.apply { this.${table.passwordColumn.fieldName} = "" }</#if>
        val bearer = JwtBearer(UserType.${table.className}.name, ${table.classNameCamel}.${table.idColumn.fieldName}<#if table.hasOrgan>, ${table.classNameCamel}.${table.orgColumn.fieldName}</#if>)
        val token = JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.tokenExpiryTime)
        return LoginInfo(token, ${table.classNameCamel})
    }

    </#list>
<#else>
    @Transactional(rollbackFor = [Throwable::class])
    fun login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}: ${loginTable.orgColumn.fieldType}, </#if>username: String, password: String): LoginInfo {
        val subject = SecurityUtils.getSubject().apply { login(LoginToken(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}, </#if>username, password)) }
        val ${loginTable.classNameCamel} = subject.principals.oneByType(${loginTable.className}::class.java)
    <#if loginTable.hasPassword>
        ${loginTable.classNameCamel}.${loginTable.passwordColumn.fieldName} = ""
    </#if>
        return LoginInfo(buildToken(${loginTable.classNameCamel}), ${loginTable.classNameCamel})
    }

    private fun buildToken(${loginTable.classNameCamel}: ${loginTable.className}): String {
        val bearer = JwtBearer(UserType.Admin.name, ${loginTable.classNameCamel}.${loginTable.idColumn.fieldName}<#if loginTable.hasOrgan>, ${loginTable.classNameCamel}.${loginTable.orgColumn.fieldName}</#if>)
        return JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.tokenExpiryTime)
    }
</#if>
}
