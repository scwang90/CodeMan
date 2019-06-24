package ${packageName}.interceptor;

import ${packageName}.constant.UserType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class LoginInterceptor implements HandlerInterceptor {

    private Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request , HttpServletResponse response , Object handler) throws ServletException, IOException {
        String url = request.getRequestURI();
        HttpSession session = request.getSession(true);
        if (session.getAttribute(UserType.Admin.name()) == null) {
            logger.info("需要登录-$url");
            if (url.startsWith("/api/")) {
                request.getRequestDispatcher("/api/v1/auth/failed").forward(request, response);
            } else {
                response.sendRedirect("/admin/login");
            }
            return false;
        }
        return true;
    }



}
