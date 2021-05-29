package ${packageName}.model.conf

import org.apache.shiro.crypto.hash.Md5Hash
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.stereotype.Component

/**
 * 配置类 - 登录认证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix = "app.auth")
class AuthConfig {

    var token: Token = Token()
    var password: Password = Password()

    val tokenExpiryTime: Int
        get() { return token.expiry * 1000 }
    val tokenRefreshTime: Int
        get() { return token.refresh * 1000 }

    fun passwordHash(value: String):String {
        return password.hash(value)
    }

    class Password {
        /** 加密算法 */
        var algorithm = "MD5"
        /** 密码盐值 */
        var salt = "midaier"
        /** 散列次数 */
        var iterations = 2

        fun hash(password: String): String {
            return Md5Hash(password, salt, iterations).toHex()
        }
    }

    class Token {
        /** 凭证有效时间 (秒钟) */
        var expiry = 60*60*10
        /** 凭证刷新间隔 (秒钟) */
        var refresh = 60

        val expiryTime: Int
            get() { return expiry * 1000 }
        val refreshTime: Int
            get() { return refresh * 1000 }

    }
}