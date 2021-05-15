package ${packageName}.util

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.interfaces.DecodedJWT
import ${packageName}.shiro.model.JwtBearer
import io.netty.util.internal.StringUtil
import org.apache.shiro.SecurityUtils
import java.util.*
import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * JWT 封装工具
 * 创建、读入、写入、解析
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
object JwtUtils {

    @JvmStatic
    fun createToken(bearer: JwtBearer, jwtAlgorithm: Algorithm?, expires: Int): String {
        val now = System.currentTimeMillis()
        return JWT.create()
                .withClaim("type", bearer.type)
                .withClaim("userId", bearer.userId)
                .withIssuedAt(Date(now))
                .withExpiresAt(Date(now + expires))
                .sign(jwtAlgorithm)
    }

    @JvmStatic
    fun loadBearer(jwt: DecodedJWT): JwtBearer {
        return JwtBearer(jwt.getClaim("type").asString(), jwt.getClaim("userId").asInt(), jwt.getClaim("authId").asInt())
    }

    fun currentBearer(): JwtBearer {
        val subject = SecurityUtils.getSubject()
        return subject.principals.oneByType(JwtBearer::class.java)
    }

    fun writeToHeader(token: String, request: HttpServletRequest, response: HttpServletResponse) {
        val path = request.contextPath
        val cookie = Cookie("Bearer", token)
        cookie.path = path.ifEmpty { "/" }
        response.addCookie(cookie)
        response.setHeader("x-auth-token", token)
    }

    fun fromHeader(request: HttpServletRequest): String? {
        val authorization = request.getHeader("Authorization")
        if (!StringUtil.isNullOrEmpty(authorization)) {
            return authorization.replace("Bearer ", "")
        }
        val cookies = request.cookies
        if (cookies != null) {
            for (cookie in cookies) {
                if (cookie != null && "Bearer" == cookie.name) {
                    return cookie.value
                }
            }
        }
        return null
    }
}