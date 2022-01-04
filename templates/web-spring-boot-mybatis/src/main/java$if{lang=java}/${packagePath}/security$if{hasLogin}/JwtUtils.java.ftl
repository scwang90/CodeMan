package ${packageName}.security;

import ${packageName}.constant.ResultCode;
import ${packageName}.exception.ClientException;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.ObjectUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * JWT 封装工具
 * 创建、读入、写入、解析
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtUtils {

    public static String createToken(JwtBearer bearer, Algorithm jwtAlgorithm, long expires) {
        long now = System.currentTimeMillis();
        return JWT.create()
            .withClaim("userId", bearer.userId)
<#if loginTable.hasOrgan>
            .withClaim("${loginTable.orgColumn.fieldName}", bearer.${loginTable.orgColumn.fieldName})
</#if>
            .withIssuedAt(new Date(now))
            .withExpiresAt(new Date(now + expires))
            .sign(jwtAlgorithm);
    }

    public static JwtBearer loadBearer(DecodedJWT jwt) {
<#assign asUserId='asInt'/>
<#assign asOrganId='asInt'/>
<#if loginTable.idColumn.stringType>
    <#assign asUserId='asString'/>
<#elseif loginTable.idColumn.longType>
    <#assign asUserId='asLong'/>
</#if>
<#if loginTable.hasOrgan>
    <#if loginTable.orgColumn.stringType>
        <#assign asOrganId='asString'/>
    <#elseif loginTable.orgColumn.longType>
        <#assign asOrganId='asLong'/>
    </#if>
</#if>
        return new JwtBearer(jwt.getClaim("type").asString(), jwt.getClaim("userId").${asUserId}()<#if loginTable.hasOrgan>, jwt.getClaim("${loginTable.orgColumn.fieldName}").${asOrganId}()</#if>);
    }

    public static JwtBearer currentBearer() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new ClientException(ResultCode.Unauthorized);
        }
        return (JwtBearer)authentication.getPrincipal();
    }

    public static void writeToHeader(String token, HttpServletRequest request, HttpServletResponse response) {
        String path = request.getContextPath();
        Cookie cookie = new Cookie("Bearer", token);
        cookie.setPath(path.isEmpty() ? "/" : path);
        response.addCookie(cookie);
        response.setHeader("x-auth-token", token);
    }

    public static String fromHeader(HttpServletRequest request) {
        String authorization = request.getHeader("Authorization");
        if (!ObjectUtils.isEmpty(authorization)) {
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
