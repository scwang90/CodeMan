package com.fecred.midaier.shiro

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.interfaces.DecodedJWT
import com.fecred.midaier.constant.SmsAction
import com.fecred.midaier.exception.ClientException
import com.fecred.midaier.exception.ServiceException
import com.fecred.midaier.mapper.auto.AdminMapper
import com.fecred.midaier.mapper.auto.AppUserMapper
import com.fecred.midaier.mapper.auto.AppletUserMapper
import com.fecred.midaier.mapper.auto.SmsRecordMapper
import com.fecred.midaier.mapper.intent.Tables
import com.fecred.midaier.model.conf.AppletConfig
import com.fecred.midaier.model.conf.AuthConfig
import com.fecred.midaier.model.conf.SmsConfig
import com.fecred.midaier.model.db.AppletUser
import com.fecred.midaier.network.WeChatApi
import com.fecred.midaier.service.app.AppAuthService
import com.fecred.midaier.service.common.SmsService
import com.fecred.midaier.shiro.model.*
import com.fecred.midaier.util.JwtUtils.loadBearer
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.AuthenticationInfo
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.authc.SimpleAuthenticationInfo
import org.apache.shiro.authc.credential.CredentialsMatcher
import org.apache.shiro.authc.credential.HashedCredentialsMatcher
import org.apache.shiro.authz.AuthorizationInfo
import org.apache.shiro.realm.AuthorizingRealm
import org.apache.shiro.subject.PrincipalCollection
import org.apache.shiro.util.ByteSource
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import retrofit2.HttpException

/**
 * 登录认证实现类
 * 包括 账户密码登录 和 JWT 登录
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component("authRealm")
class AuthRealm(private final val authConfig: AuthConfig) : AuthorizingRealm(), CredentialsMatcher {

    @Autowired
    private lateinit var jwtAlgorithm: Algorithm
//    @Autowired
//    private lateinit var adminMapper: AdminMapper

    private lateinit var matcher: CredentialsMatcher

    init {
        //设置密码匹配位自己，实现了 doCredentialsMatch 方法
        val matcher = HashedCredentialsMatcher()
        matcher.hashIterations = authConfig.iterations // 设置散列次数： 意为加密几次
        matcher.hashAlgorithmName = authConfig.algorithm // 使用md5 算法进行加密

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
        val password = authenticationToken.credentials
        val credentials = authenticationInfo.credentials
        if (credentials is DecodedJWT && password is JwtToken) {
            return true //JWT 登录，getAuthenticationInfo 中已经认证过，直接返回成功
        }
        if (!matcher.doCredentialsMatch(authenticationToken, authenticationInfo)) {
            throw ClientException("用户名或密码错误")
        }
        return true
    }

    override fun doGetAuthorizationInfo(principalCollection: PrincipalCollection): AuthorizationInfo? {
        return null
    }

    override fun doGetAuthenticationInfo(authenticationToken: AuthenticationToken): AuthenticationInfo? {
        return when (authenticationToken) {
            is JwtToken -> {
                getAuthenticationInfo(authenticationToken)
            }
            is AdminToken -> {
                getAuthenticationInfo(authenticationToken)
            }
            else -> null
        }
    }

    /**
     * 后台管理员登录
     */
    private fun getAuthenticationInfo(token: AdminToken): AuthenticationInfo {
//        val admin = adminMapper.selectOneWhere(Tables.Admin.Username.eq(token.username))
//            ?: throw ClientException("用户名或密码错误")

        val salt: ByteSource = ByteSource.Util.bytes(authConfig.salt)
//        return SimpleAuthenticationInfo(admin, admin.password, salt, "authRealm")
        return SimpleAuthenticationInfo(token, "admin", salt, "authRealm")
    }

    /**
     * Jwt用户 自动登录
     */
    private fun getAuthenticationInfo(token: JwtToken): AuthenticationInfo {
        val jwt = JWT.require(jwtAlgorithm).build().verify(token.bearer)
        val bearer = loadBearer(jwt)
        return SimpleAuthenticationInfo(listOf(bearer, jwt), jwt, "authRealm")
    }

}