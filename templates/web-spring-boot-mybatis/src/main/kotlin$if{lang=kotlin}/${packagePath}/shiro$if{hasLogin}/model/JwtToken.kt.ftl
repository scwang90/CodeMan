package ${packageName}.shiro.model

import org.apache.shiro.authc.AuthenticationToken

/**
 * Jwt 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
data class JwtToken(val bearer: String) : AuthenticationToken {

    override fun getCredentials(): Any {
        return this
    }

    override fun getPrincipal(): Any {
        return bearer
    }

}