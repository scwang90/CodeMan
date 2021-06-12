package ${packageName}.shiro

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import ${packageName}.exception.ClientException
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.mapper.auto.${table.className}AutoMapper
    </#list>
<#else >
import ${packageName}.mapper.auto.${loginTable.className}AutoMapper
</#if>
import ${packageName}.mapper.intent.Tables
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className}
    </#list>
<#else >
import ${packageName}.model.db.${loginTable.className}
</#if>
import ${packageName}.model.conf.AuthConfig
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.shiro.model.${table.className}Token
    </#list>
<#else >
import ${packageName}.shiro.model.LoginToken
</#if>
import ${packageName}.shiro.model.JwtToken
import ${packageName}.shiro.model.JwtBearer
import ${packageName}.util.JwtUtils
import org.apache.shiro.authc.*
import org.apache.shiro.authc.credential.CredentialsMatcher
import org.apache.shiro.authc.credential.HashedCredentialsMatcher
import org.apache.shiro.authz.AuthorizationInfo
import org.apache.shiro.authz.SimpleAuthorizationInfo
import org.apache.shiro.realm.AuthorizingRealm
import org.apache.shiro.subject.PrincipalCollection
import org.apache.shiro.util.ByteSource
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component

/**
 * 登录认证实现类
 * 包括 账户密码登录 和 JWT 登录
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
class AuthRealm(private val authConfig: AuthConfig) : AuthorizingRealm(), CredentialsMatcher {

    @Autowired
    private lateinit var jwtAlgorithm: Algorithm
<#if hasMultiLogin>
    <#list loginTables as table>
    @Autowired
    private lateinit var ${table.classNameCamel}Mapper: ${table.className}AutoMapper
    </#list>
<#else >
    @Autowired
    private lateinit var ${loginTable.classNameCamel}Mapper: ${loginTable.className}AutoMapper
</#if>

    private lateinit var matcher: CredentialsMatcher

    init {
        //设置密码匹配位自己，实现了 doCredentialsMatch 方法
        val matcher = HashedCredentialsMatcher()
        matcher.hashIterations = authConfig.password.iterations // 设置散列次数： 意为加密几次
        matcher.hashAlgorithmName = authConfig.password.algorithm // 使用md5 算法进行加密

        this.matcher = matcher
        this.credentialsMatcher = this
    }

    override fun supports(token: AuthenticationToken): Boolean {
        return true
    }

    /**
     * 密码匹配-支持通用密码匹配
     */
    override fun doCredentialsMatch(authenticationToken: AuthenticationToken, authenticationInfo: AuthenticationInfo): Boolean {
        if (authenticationToken is JwtToken) {
            return true //JWT 登录，getAuthenticationInfo 中已经认证过，直接返回成功
        }
        if (!matcher.doCredentialsMatch(authenticationToken, authenticationInfo)) {
            throw ClientException("用户名或密码错误")
        }
        return true
    }

    override fun doGetAuthorizationInfo(principalCollection: PrincipalCollection): AuthorizationInfo? {
        val bearer = principalCollection.oneByType(JwtBearer::class.java)
        val info = SimpleAuthorizationInfo()
        info.addRole(bearer.type)
        return info
    }

    override fun doGetAuthenticationInfo(authenticationToken: AuthenticationToken): AuthenticationInfo? {
        return when (authenticationToken) {
            is JwtToken -> getAuthenticationInfo(authenticationToken)
<#if hasMultiLogin>
    <#list loginTables as table>
            is ${table.className}Token -> getAuthenticationInfo(authenticationToken)
    </#list>
<#else>
            is LoginToken -> getAuthenticationInfo(authenticationToken)
</#if>
            else -> null
        }
    }

<#if hasMultiLogin>
    <#list loginTables as table>
        <#assign hasUsernameColumn=false/>
        <#assign hasPasswordColumn=false/>
        <#list table.columns as column>
            <#if column == table.passwordColumn>
                <#assign hasPasswordColumn=true/>
            </#if>
            <#if column == table.usernameColumn>
                <#assign hasUsernameColumn=true/>
            </#if>
        </#list>
    /**
     * ${table.remarkName}登录
     */
    private fun getAuthenticationInfo(token: ${table.className}Token): AuthenticationInfo {
        <#if hasUsernameColumn>
            <#assign prefix=""/>
        <#else>
            <#assign prefix="//"/>
        var ${table.classNameCamel}: ${table.className}? = null
        </#if>
        <#if table.hasOrgan>
        ${prefix}val where = Tables.${table.className}.${table.usernameColumn.fieldNameUpper}.eq(token.username)
        ${prefix}if (token.${table.orgColumn.fieldName}<#if orgColumn.stringType> != null<#else> > 0</#if>) {
        ${prefix}   where.and(Tables.${table.className}.${orgColumn.fieldNameUpper}.eq(token.${table.orgColumn.fieldName}))
        ${prefix}}
        ${prefix}val ${table.classNameCamel} = ${table.classNameCamel}Mapper.selectOneWhere(where)
        <#else>
        ${prefix}val ${table.classNameCamel} = ${table.classNameCamel}Mapper.selectOneWhere(Tables.${table.className}.${table.usernameColumn.fieldNameUpper}.eq(token.username))
        </#if>
        if (${table.classNameCamel} == null) {
            if (token.username == "admin" && token.password == "654321") {
                //项目刚刚生成，数据库可能没有${table.remarkName}数据，本代码可以提前体登录成功，并体验其他接口
                val salt = ByteSource.Util.bytes(authConfig.password.salt)
                return SimpleAuthenticationInfo(${table.className}(), authConfig.passwordHash(token.password), salt, "authRealm")
            }
            throw ClientException("用户名或密码错误")
        }
        //if ("1".equals(${table.classNameCamel}.efficet)) {
        //    throw ClientException("当前用户帐号已被停用，请联系技术服务人员！")
        //}
        val salt = ByteSource.Util.bytes(authConfig.password.salt)
        <#if hasPasswordColumn>
        return SimpleAuthenticationInfo(${table.classNameCamel}, ${table.classNameCamel}.${table.passwordColumn.fieldName}, salt, "authRealm")
        <#else>
        return SimpleAuthenticationInfo(${table.classNameCamel}, "password"/*${table.classNameCamel}.getPassword()*/, salt, "authRealm")
        </#if>
    }

    </#list>
<#else >
    <#assign hasUsernameColumn=false/>
    <#assign hasPasswordColumn=false/>
    <#list loginTable.columns as column>
        <#if column == loginTable.passwordColumn>
            <#assign hasPasswordColumn=true/>
        </#if>
        <#if column == loginTable.usernameColumn>
            <#assign hasUsernameColumn=true/>
        </#if>
    </#list>
    /**
     * 用户登录
     */
    private fun getAuthenticationInfo(token: LoginToken): AuthenticationInfo {
    <#if hasUsernameColumn>
        <#assign prefix=""/>
    <#else>
        <#assign prefix="//"/>
        var ${loginTable.classNameCamel}: ${loginTable.className}? = null
    </#if>
    <#if loginTable.hasOrgan>
        ${prefix}val where = Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(token.username)
        ${prefix}if (token.${loginTable.orgColumn.fieldName}<#if orgColumn.stringType> != null<#else> > 0</#if>) {
        ${prefix}   where.and(Tables.${loginTable.className}.${orgColumn.fieldNameUpper}.eq(token.${loginTable.orgColumn.fieldName}))
        ${prefix}}
        ${prefix}val ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(where)
    <#else>
        ${prefix}val ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(token.username))
    </#if>
        if (${loginTable.classNameCamel} == null) {
            if (token.username == "admin" && token.password == "654321") {
                val salt = ByteSource.Util.bytes(authConfig.password.salt)
                return SimpleAuthenticationInfo(${loginTable.className}(), authConfig.passwordHash(token.password), salt, "authRealm")
            }
            throw ClientException("用户名或密码错误")
        }
        //if ("1".equals(${loginTable.classNameCamel}.efficet)) {
        //    throw ClientException("当前用户帐号已被停用，请联系技术服务人员！")
        //}
        val salt = ByteSource.Util.bytes(authConfig.password.salt)
    <#if hasPasswordColumn>
        return SimpleAuthenticationInfo(${loginTable.classNameCamel}, ${loginTable.classNameCamel}.${loginTable.passwordColumn.fieldName}, salt, "authRealm")
    <#else>
        return SimpleAuthenticationInfo(${loginTable.classNameCamel}, "password"/*${loginTable.classNameCamel}.getPassword()*/, salt, "authRealm")
    </#if>
    }

</#if>
    /**
     * Jwt用户 自动登录
     */
    private fun getAuthenticationInfo(token: JwtToken): AuthenticationInfo {
        val jwt = JWT.require(jwtAlgorithm).build().verify(token.bearer)
        val bearer = JwtUtils.loadBearer(jwt)
        return SimpleAuthenticationInfo(listOf(bearer, jwt), jwt, "authRealm")
    }

}