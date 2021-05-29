package ${packageName}.shiro;

<#assign hasUsernameColumn=false/>
<#assign hasPasswordColumn=false/>
<#list loginTable.columns as column>
    <#if column == loginTable.passwordColumn>
        <#assign hasPasswordColumn=true/>
    </#if>
    <#if column == loginTable.usernameColumn>
        <#assign hasUsernameColumn=true/>
    </#if>
</#list>
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.exception.ClientException;
import ${packageName}.mapper.auto.${loginTable.className}Mapper;
<#if hasUsernameColumn && hasOrgan>
import ${packageName}.mapper.intent.api.WhereQuery;
import ${packageName}.mapper.intent.Tables;
</#if>
import ${packageName}.model.conf.AuthConfig;
import ${packageName}.model.db.${loginTable.className};
import ${packageName}.shiro.model.JwtToken;
import ${packageName}.shiro.model.JwtBearer;
import ${packageName}.shiro.model.LoginToken;
import ${packageName}.util.JwtUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Component;

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
    private final CredentialsMatcher matcher;
    private final AuthConfig authConfig;

    public AuthRealm(${loginTable.className}Mapper ${loginTable.classNameCamel}Mapper, Algorithm jwtAlgorithm, AuthConfig authConfig) {
        this.${loginTable.classNameCamel}Mapper = ${loginTable.classNameCamel}Mapper;
        this.authConfig = authConfig;
        this.jwtAlgorithm = jwtAlgorithm;

        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
        matcher.setHashIterations(authConfig.getPassword().getIterations());// 设置散列次数： 意为加密几次
        matcher.setHashAlgorithmName(authConfig.getPassword().getAlgorithm());// 使用md5 算法进行加密
        this.matcher = matcher;
        //设置密码匹配位自己，实现了 doCredentialsMatch 方法
        this.setCredentialsMatcher(this);
    }

    @Override
    public boolean supports(AuthenticationToken token) {
        return super.supports(token) || token instanceof JwtToken || token instanceof LoginToken;
    }

    /**
     * 密码匹配-支持通用密码匹配
     */
    @Override
    public boolean doCredentialsMatch(AuthenticationToken authenticationToken, AuthenticationInfo authenticationInfo) {
        Object credentials = authenticationInfo.getCredentials();
        if (authenticationToken instanceof JwtToken) {
            //JWT 认证能运行到匹配这里，说明JWT 已经验证通过，直接返回 true 即可
            return true;
        }
        if (!this.matcher.doCredentialsMatch(authenticationToken, authenticationInfo)) {
            throw new ClientException("用户名或密码错误");
        }
        return true;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        if (authenticationToken instanceof JwtToken) {
            return getAuthenticationInfo((JwtToken) authenticationToken);
        } else if (authenticationToken instanceof LoginToken) {
            return getAuthenticationInfo((LoginToken) authenticationToken);
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

    private AuthenticationInfo getAuthenticationInfo(LoginToken token) {
    <#if hasUsernameColumn>
        <#assign prefix=""/>
    <#else>
        <#assign prefix="//"/>
        ${loginTable.className} ${loginTable.classNameCamel} = null;
    </#if>
    <#if loginTable.hasOrgan>
        ${prefix}WhereQuery<${loginTable.className}> where = Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(token.getUsername());
        ${prefix}if (token.get${loginTable.orgColumn.fieldNameUpper}()<#if orgColumn.stringType> != null<#else> > 0</#if>) {
        ${prefix}   where.and(Tables.${loginTable.className}.${orgColumn.fieldNameUpper}.eq(token.get${loginTable.orgColumn.fieldNameUpper}()));
        ${prefix}}
        ${prefix}${loginTable.className} ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(where);
    <#else>
        ${prefix}${loginTable.className} ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(token.getUsername()));
    </#if>
        if (${loginTable.classNameCamel} == null) {
            throw new ClientException("用户名或密码错误");
        }
        //if ("1".equals(${loginTable.classNameCamel}.getEfficet())) {
        //    throw new ClientException("当前用户帐号已被停用，请联系技术服务人员！");
        //}
        ByteSource salt = ByteSource.Util.bytes(authConfig.getPassword().getSalt());
    <#if hasPasswordColumn>
        return new SimpleAuthenticationInfo(${loginTable.classNameCamel}, ${loginTable.classNameCamel}.get${loginTable.passwordColumn.fieldNameUpper}(), salt, "authRealm");
    <#else>
        return new SimpleAuthenticationInfo(${loginTable.classNameCamel}, "password"/*${loginTable.classNameCamel}.getPassword()*/, salt, "authRealm");
    </#if>
    }
}
