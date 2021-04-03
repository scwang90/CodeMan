package ${packageName}.shiro.realm;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.mapper.auto${loginTable.className}Mapper;
import ${packageName}.model.db.${loginTable.className};
import ${packageName}.shiro.JwtToken;
import ${packageName}.shiro.JwtBearer;
import ${packageName}.util.JwtUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.codec.CodecSupport;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.stereotype.Component;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * 登录认证实现类
 * 包括 账户密码登录 和 JWT 登录
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component("authRealm")
public class AuthRealm extends AuthorizingRealm implements CredentialsMatcher {

    private final Algorithm jwtAlgorithm;
    private final ${loginTable.className}Mapper ${loginTable.classNameCamel}Mapper;

    public AuthRealm(${loginTable.className}Mapper ${loginTable.classNameCamel}Mapper, Algorithm jwtAlgorithm) {
        this.${loginTable.classNameCamel}Mapper = ${loginTable.classNameCamel}Mapper;
        this.jwtAlgorithm = jwtAlgorithm;
        //设置密码匹配位自己，实现了 doCredentialsMatch 方法
        this.setCredentialsMatcher(this);
    }

    /**
     * 密码匹配-支持通用密码匹配
     */
    @Override
    public boolean doCredentialsMatch(AuthenticationToken authenticationToken, AuthenticationInfo authenticationInfo) {
        Object password = authenticationToken.getCredentials();
        Object credentials = authenticationInfo.getCredentials();
        if (credentials instanceof DecodedJWT && password instanceof JwtToken) {
            return true;
        } else if (credentials instanceof PrincipalCollection) {
            byte[] bytes = CodecSupport.toBytes((char[]) password);
            return MessageDigest.isEqual(bytes, CodecSupport.toBytes(((PrincipalCollection) credentials).oneByType(String.class)));
        }
        return password.equals(credentials);
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        if (authenticationToken instanceof JwtToken) {
            return getAuthenticationInfo((JwtToken) authenticationToken);
        } else if (authenticationToken instanceof UsernamePasswordToken) {
            return getAuthenticationInfo((UsernamePasswordToken) authenticationToken);
        }
        return null;
    }
    private AuthenticationInfo getAuthenticationInfo(JwtToken token) {
//        if ("null".equals(token.bearer)) {
//            throw new ClientException("");
//        }
        DecodedJWT jwt = JWT.require(jwtAlgorithm).build().verify(token.bearer);
        JwtBearer bearer = JwtUtils.loadBearer(jwt);
        return new SimpleAuthenticationInfo(Arrays.asList(bearer, jwt), jwt, "authRealm");
    }

    private AuthenticationInfo getAuthenticationInfo(UsernamePasswordToken token) {
        //${loginTable.className} ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.findOneByPropertyName("","USERACCOUNT", token.getUsername());
        ${loginTable.className} ${loginTable.classNameCamel} = new ${loginTable.className}();
        if (${loginTable.classNameCamel} == null) {
            return null;
        }
        //if ("1".equals(${loginTable.classNameCamel}.getEfficet())) {
        //    throw new ClientException("当前用户帐号已被停用，请联系技术服务人员！");
        //}
        SimplePrincipalCollection principals = new SimplePrincipalCollection();
        principals.add(${loginTable.classNameCamel}, "authRealm");
        SimplePrincipalCollection credentials = new SimplePrincipalCollection();
        //credentials.add(${loginTable.classNameCamel}.getPassword(), "authRealm");
        credentials.add(token.getPassword(), "authRealm");
        return new SimpleAuthenticationInfo(principals, credentials);
    }
}
