package ${packageName}.shiro.model;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * Jwt 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtToken extends UsernamePasswordToken {

    public final String bearer;

    public JwtToken(String bearer) {
        this.bearer = bearer;
    }

    @Override
    public Object getCredentials() {
        return this;
    }

    @Override
    public Object getPrincipal() {
        return bearer;
    }
}
