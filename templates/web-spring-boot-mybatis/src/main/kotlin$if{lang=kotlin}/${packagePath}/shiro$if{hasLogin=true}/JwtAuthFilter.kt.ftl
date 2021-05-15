package ${packageName}.shiro

import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.exceptions.TokenExpiredException
import com.auth0.jwt.interfaces.DecodedJWT

import ${packageName}.model.conf.AuthConfig
import ${packageName}.shiro.model.JwtBearer
import ${packageName}.shiro.model.JwtToken
import ${packageName}.util.JwtUtils

import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.AuthenticationToken
import org.apache.shiro.subject.Subject
import org.apache.shiro.web.filter.authc.AuthenticatingFilter
import org.slf4j.LoggerFactory
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * JWT认证拦截器
 * JWT认证的服务器是无状态的，每次请求都要对客户端发送对jwt token 进行重新认证
 * 继承 AuthenticatingFilter 可以方便对实现 拦截认证功能
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class JwtAuthFilter(private val jwtAlgorithm: Algorithm, private val authConfig: AuthConfig) : AuthenticatingFilter() {

    private val logger = LoggerFactory.getLogger(JwtAuthFilter::class.java)

    /**
     * 从请求头中获取 Jwt凭证
     */
    @Throws(Exception::class)
    override fun createToken(request: ServletRequest, response: ServletResponse): AuthenticationToken? {
        if (request is HttpServletRequest) {
            val bearer = JwtUtils.fromHeader(request)
            bearer?.apply {
                return JwtToken(bearer)
            }
        }
        return null
    }

    /**
     * 执行 Jwt 认证
     */
    override fun isAccessAllowed(request: ServletRequest, response: ServletResponse, mappedValue: Any?): Boolean {
        if (isLoginRequest(request, response)) return true
        var allowed = false
        try {
            allowed = executeLogin(request, response)
        } catch (e: IllegalStateException) {
            logger.debug("请求未携带jwt 判断为无效请求", e)
        } catch (e: Exception) {
            logger.warn("JWT认证异常", e)
        }
        return allowed || super.isPermissive(mappedValue)
    }

    /**
     * 登录成功之后，需要监测 token 的创建时间，如果距离当前时间超过配置的 token 刷新时间，则生成新的 token
     */
    override fun onLoginSuccess(token: AuthenticationToken, subject: Subject, request: ServletRequest, response: ServletResponse): Boolean {
        if (response is HttpServletResponse && request is HttpServletRequest) {
            val jwtBearer = subject.principals.oneByType(JwtBearer::class.java)
            val jwt = subject.principals.oneByType(DecodedJWT::class.java)
            val issuedAt = jwt.issuedAt
            if (System.currentTimeMillis() - issuedAt.time > authConfig.refreshTime && authConfig.refresh > 0) {
                val jwtToken = JwtUtils.createToken(jwtBearer, jwtAlgorithm, authConfig.expiryTime)
                JwtUtils.writeToHeader(jwtToken, request, response)
            }
        }
        return super.onLoginSuccess(token, subject, request, response)
    }

    /**
     * Jwt登录失败之后，监测异常类型，判断是否是 token 过期导致，并标记到 request 中，后面用于重定向跳转依据
     */
    override fun onLoginFailure(token: AuthenticationToken, e: AuthenticationException, request: ServletRequest, response: ServletResponse): Boolean {
        if (e.cause is TokenExpiredException) {
            request.setAttribute("jwt-expired", true)
        }
        return false
    }

    /**
     * 认证失败之后，重定向到指定接口提示错误
     */
    @Throws(Exception::class)
    override fun onAccessDenied(request: ServletRequest, response: ServletResponse): Boolean {
        if (request.getAttribute("jwt-expired") != null) {
            request.getRequestDispatcher("/api/v1/auth/expired").forward(request, response)
        } else {
            request.getRequestDispatcher("/api/v1/auth/failed").forward(request, response)
        }
        return false
    }
}