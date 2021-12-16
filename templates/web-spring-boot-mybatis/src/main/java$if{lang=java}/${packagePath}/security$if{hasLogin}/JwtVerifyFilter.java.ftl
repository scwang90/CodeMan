package ${packageName}.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.model.conf.AuthConfig;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.ObjectUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtVerifyFilter extends BasicAuthenticationFilter {

    private final AuthConfig authConfig;
    private final Algorithm jwtAlgorithm;

    public JwtVerifyFilter(AuthenticationManager authenticationManager,Algorithm jwtAlgorithm, AuthConfig authConfig) {
        super(authenticationManager);
        this.authConfig = authConfig;
        this.jwtAlgorithm = jwtAlgorithm;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String token = JwtUtils.fromHeader(request);
        if (!ObjectUtils.isEmpty(token)) {
            try {
                /*
                 * 验证Token
                 */
                DecodedJWT jwt = JWT.require(jwtAlgorithm).build().verify(token);
                JwtBearer bearer = JwtUtils.loadBearer(jwt);
                Authentication auth = new RememberMeAuthenticationToken(token, bearer, null);
                auth.setAuthenticated(true);
                SecurityContextHolder.getContext().setAuthentication(auth);

                /*
                 * 刷新Token
                 */
                Date issuedAt = jwt.getIssuedAt();
                if (System.currentTimeMillis() - issuedAt.getTime() > authConfig.getRefreshTime() && authConfig.getRefreshTime() > 0) {
                    String jwtToken = JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.getExpiryTime());
                    JwtUtils.writeToHeader(jwtToken, request, response);
                }

            } catch (TokenExpiredException e) {
                request.getRequestDispatcher("/api/v1/auth/expired").forward(request, response);
                return;
            } catch (JWTVerificationException e) {
                request.getRequestDispatcher("/api/v1/auth/failed").forward(request, response);
                return;
            }
        }
        chain.doFilter(request, response);
    }
}