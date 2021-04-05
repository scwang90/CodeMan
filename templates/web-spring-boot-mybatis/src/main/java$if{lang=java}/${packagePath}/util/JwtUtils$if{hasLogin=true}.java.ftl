package ${packageName}.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.shiro.model.JwtBearer;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.util.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * JWT 封装工具
 * 创建、读入、写入、解析
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtUtils {

    public static String createToken(JwtBearer bearer, Algorithm jwtAlgorithm, long expires) {
        long now = System.currentTimeMillis();
        return JWT.create()
            .withClaim("userId", bearer.userId)
<#if loginTable.hasOrg>
            .withClaim("${loginTable.orgColumn.fieldName}", bearer.${loginTable.orgColumn.fieldName})
</#if>
            .withIssuedAt(new Date(now))
            .withExpiresAt(new Date(now + expires))
            .sign(jwtAlgorithm);
    }

    public static JwtBearer loadBearer(DecodedJWT jwt) {
<#if loginTable.idColumn.stringType>
        return new JwtBearer(jwt.getClaim("userId").asString()<#if loginTable.hasOrg>, jwt.getClaim("${loginTable.orgColumn.fieldName}").asString()</#if>);
<#else >
        return new JwtBearer(jwt.getClaim("userId").asInt()<#if loginTable.hasOrg>, jwt.getClaim("${loginTable.orgColumn.fieldName}").asInt()</#if>);
</#if>
    }

    public static JwtBearer currentBearer() {
        Subject subject = SecurityUtils.getSubject();
        return subject.getPrincipals().oneByType(JwtBearer.class);
    }

    public static void writeToHeader(String token, HttpServletRequest request, HttpServletResponse response) {
        String path = request.getContextPath();
        Cookie cookie = new Cookie("Bearer", token);
        cookie.setPath(path.isEmpty() ? "/" : path);
        response.addCookie(cookie);
        response.addHeader("x-auth-token", token);
    }

    public static String fromHeader(HttpServletRequest request) {
        String authorization = request.getHeader("Authorization");
        if (!StringUtils.isEmpty(authorization)) {
            return authorization.replace("Bearer ", "");
        }
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie: cookies) {
                if (cookie != null && "Bearer".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
