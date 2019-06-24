package ${packageName}.interceptor

import ${packageName}.constant.UserType
import org.slf4j.LoggerFactory
import org.springframework.web.servlet.HandlerInterceptor
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * 登录拦截器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class LoginInterceptor : HandlerInterceptor {

    private val logger = LoggerFactory.getLogger(LoginInterceptor::class.java)

    override fun preHandle(request: HttpServletRequest, response: HttpServletResponse, handler: Any): Boolean {
        val url = request.requestURI
        val session = request.getSession(true)
        if (session.getAttribute(UserType.Admin.name) == null) {
            logger.info("需要登录-$url")
            if (url.startsWith("/api/")) {
                request.getRequestDispatcher("/api/v1/auth/failed").forward(request, response)
            } else {
                response.sendRedirect("/admin/login")
            }
            return false
        }
        return super.preHandle(request, response, handler)
    }



}