package ${packageName}.shiro.model

import org.apache.shiro.authc.AuthenticationToken

/**
 * 管理员 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class LoginToken(val username: String, val password: String) : AuthenticationToken {

    override fun getPrincipal(): Any {
        return username
    }

    override fun getCredentials(): Any {
        return password
    }

}