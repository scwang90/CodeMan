package ${packageName}.shiro.matcher;

import ${packageName}.model.api.common.JwtAccount;
import ${packageName}.util.JsonWebTokenUtil;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.springframework.stereotype.Component;


/**
 * JWT 验证器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
public class JwtMatcher implements CredentialsMatcher {

    @Override
    public boolean doCredentialsMatch(AuthenticationToken authenticationToken, AuthenticationInfo authenticationInfo) {

        String jwt = (String) authenticationInfo.getCredentials();
        JwtAccount jwtAccount = null;
        try{
            jwtAccount = JsonWebTokenUtil.parseJwt(jwt,JsonWebTokenUtil.SECRET_KEY);
        } catch(SignatureException | UnsupportedJwtException | MalformedJwtException | IllegalArgumentException e){
            // 令牌错误
            throw new AuthenticationException("errJwt");
        } catch(ExpiredJwtException e){
            // 令牌过期
            throw new AuthenticationException("expiredJwt");
        } catch(Exception e){
            throw new AuthenticationException("errJwt");
        }
        if(null == jwtAccount){
            throw new AuthenticationException("errJwt");
        }

        return true;
    }
}
