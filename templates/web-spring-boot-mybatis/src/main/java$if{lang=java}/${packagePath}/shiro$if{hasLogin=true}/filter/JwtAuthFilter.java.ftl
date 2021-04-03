package ${packageName}.shiro.filter;

import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.shiro.JwtToken;
import ${packageName}.shiro.JwtBearer;
import ${packageName}.util.JwtUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * JWT认证拦截器
 * JWT认证的服务器是无状态的，每次请求都要对客户端发送对jwt token 进行重新认证
 * 继承 AuthenticatingFilter 可以方便对实现 拦截认证功能
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtAuthFilter extends AuthenticatingFilter {

    private Logger logger = LoggerFactory.getLogger(JwtAuthFilter.class);

    private final Algorithm jwtAlgorithm;
    private final AuthTokenConfig tokenConfig;

    public JwtAuthFilter(Algorithm jwtAlgorithm, AuthTokenConfig tokenConfig) {
        this.jwtAlgorithm = jwtAlgorithm;
        this.tokenConfig = tokenConfig;
    }

    /**
     * 从请求头中获取 Jwt凭证
     */
    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) throws Exception {
        if (request instanceof HttpServletRequest) {
            String bearer = JwtUtils.fromHeader(((HttpServletRequest) request));
            if (!StringUtils.isEmpty(bearer)) {
                return new JwtToken(bearer);
            }
        }
        return null;
    }

    /**
     * 执行 Jwt 认证
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        if(this.isLoginRequest(request, response))
            return true;
        boolean allowed = false;
        try {
            allowed = executeLogin(request, response);
        } catch (IllegalStateException e) {
            logger.debug("请求未携带jwt 判断为无效请求", e);
        } catch (Exception e) {
            logger.warn("JWT认证异常", e);
        }
        return allowed || super.isPermissive(mappedValue);
    }

    /**
     * 登录成功之后，需要监测 token 的创建时间，如果距离当前时间超过配置的 token 刷新时间，则生成新的 token
     */
    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        if (response instanceof HttpServletResponse && request instanceof HttpServletRequest) {
            JwtBearer jwtBearer = subject.getPrincipals().oneByType(JwtBearer.class);
            DecodedJWT jwt = subject.getPrincipals().oneByType(DecodedJWT.class);
            Date issuedAt = jwt.getIssuedAt();
            if (System.currentTimeMillis() - issuedAt.getTime() > tokenConfig.getRefreshTime() && tokenConfig.getRefresh() > 0) {
                String jwtToken = JwtUtils.createToken(jwtBearer, jwtAlgorithm, tokenConfig.getExpiryTime());
                JwtUtils.writeToHeader(jwtToken, (HttpServletRequest) request, (HttpServletResponse) response);
            }
        }
        return super.onLoginSuccess(token, subject, request, response);
    }

    /**
     * Jwt登录失败之后，监测异常类型，判断是否是 token 过期导致，并标记到 request 中，后面用于重定向跳转依据
     */
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        if (e.getCause() instanceof TokenExpiredException) {
            request.setAttribute("jwt-expired", true);
        }
        return false;
    }

    /**
     * 认证失败之后，重定向到指定接口提示错误
     */
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        if (request.getAttribute("jwt-expired") != null) {
            request.getRequestDispatcher("/api/v1/auth/expired").forward(request, response);
        } else {
            request.getRequestDispatcher("/api/v1/auth/failed").forward(request, response);
        }
        return false;
    }
}
