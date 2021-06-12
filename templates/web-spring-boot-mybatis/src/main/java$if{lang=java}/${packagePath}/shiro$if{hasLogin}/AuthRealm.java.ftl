package ${packageName}.shiro;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import ${packageName}.exception.ClientException;
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.mapper.auto.${table.className}AutoMapper;
    </#list>
<#else >
import ${packageName}.mapper.auto.${loginTable.className}AutoMapper;
</#if>
import ${packageName}.mapper.intent.api.WhereQuery;
import ${packageName}.mapper.intent.Tables;
import ${packageName}.model.conf.AuthConfig;
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className};
    </#list>
    <#list loginTables as table>
import ${packageName}.shiro.model.${table.className}Token;
    </#list>
<#else >
import ${packageName}.model.db.${loginTable.className};
import ${packageName}.shiro.model.LoginToken;
</#if>
import ${packageName}.shiro.model.JwtToken;
import ${packageName}.shiro.model.JwtBearer;
import ${packageName}.util.JwtUtils;
import lombok.RequiredArgsConstructor;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;

/**
 * 登录认证实现类
 * 包括 账户密码登录 和 JWT 登录
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component("authRealm")
@RequiredArgsConstructor
public class AuthRealm extends AuthorizingRealm implements CredentialsMatcher {

    private final Algorithm jwtAlgorithm;
<#if hasMultiLogin>
    <#list loginTables as table>
    private final ${table.className}AutoMapper ${table.classNameCamel}Mapper;
    </#list>
<#else >
    private final ${loginTable.className}AutoMapper ${loginTable.classNameCamel}Mapper;
</#if>

    private AuthConfig authConfig;
    private CredentialsMatcher matcher;

    @Autowired
    public void setAuthConfig(AuthConfig authConfig) {
        this.authConfig = authConfig;

        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
        matcher.setHashIterations(authConfig.getPassword().getIterations());// 设置散列次数： 意为加密几次
        matcher.setHashAlgorithmName(authConfig.getPassword().getAlgorithm());// 使用md5 算法进行加密
        this.matcher = matcher;
        //设置密码匹配位自己，实现了 doCredentialsMatch 方法
        this.setCredentialsMatcher(this);
    }

    @Override
    public boolean supports(AuthenticationToken token) {
        return true;
    }

    /**
     * 密码匹配-支持通用密码匹配
     */
    @Override
    public boolean doCredentialsMatch(AuthenticationToken authenticationToken, AuthenticationInfo authenticationInfo) {
        if (authenticationToken instanceof JwtToken) {
            return true; //JWT 认证能运行到匹配这里，说明JWT 已经验证通过，直接返回 true 即可
        }
        if (!this.matcher.doCredentialsMatch(authenticationToken, authenticationInfo)) {
            throw new ClientException("用户名或密码错误");
        }
        return true;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        JwtBearer bearer = principalCollection.oneByType(JwtBearer.class);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addRole(bearer.type);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        if (authenticationToken instanceof JwtToken) {
            return getAuthenticationInfo((JwtToken) authenticationToken);
<#if hasMultiLogin>
<#list loginTables as table>
        } else if (authenticationToken instanceof ${table.className}Token) {
            return getAuthenticationInfo((${table.className}Token) authenticationToken);
</#list>
<#else>
        } else if (authenticationToken instanceof LoginToken) {
            return getAuthenticationInfo((LoginToken) authenticationToken);
</#if>
        }
        return null;
    }

    /**
     * Jwt用户 自动登录
     */
    private AuthenticationInfo getAuthenticationInfo(JwtToken token) {
//        if ("null".equals(token.bearer)) {
//            throw new ClientException("");
//        }
        DecodedJWT jwt = JWT.require(jwtAlgorithm).build().verify(token.bearer);
        JwtBearer bearer = JwtUtils.loadBearer(jwt);
        return new SimpleAuthenticationInfo(Arrays.asList(bearer, jwt), jwt, "authRealm");
    }
<#if hasMultiLogin>
    <#list loginTables as table>
        <#assign hasUsernameColumn=false/>
        <#assign hasPasswordColumn=false/>
        <#list table.columns as column>
            <#if column == table.passwordColumn>
                <#assign hasPasswordColumn=true/>
            </#if>
            <#if column == table.usernameColumn>
                <#assign hasUsernameColumn=true/>
            </#if>
        </#list>
    /**
     * ${table.remarkName}登录
     */
    private AuthenticationInfo getAuthenticationInfo(${table.className}Token token) {
    <#if hasUsernameColumn>
        <#assign prefix=""/>
    <#else>
        <#assign prefix="//"/>
        ${table.className} ${table.classNameCamel};
    </#if>
    <#if table.hasOrgan>
        ${prefix}WhereQuery<${table.className}> where = Tables.${table.className}.${table.usernameColumn.fieldNameUpper}.eq(token.getUsername());
        ${prefix}if (token.get${table.orgColumn.fieldNameUpper}()<#if orgColumn.stringType> != null<#else> > 0</#if>) {
        ${prefix}   where.and(Tables.${table.className}.${orgColumn.fieldNameUpper}.eq(token.get${table.orgColumn.fieldNameUpper}()));
        ${prefix}}
        ${prefix}${table.className} ${table.classNameCamel} = ${table.classNameCamel}Mapper.selectOneWhere(where);
    <#else>
        ${prefix}${table.className} ${table.classNameCamel} = ${table.classNameCamel}Mapper.selectOneWhere(Tables.${table.className}.${table.usernameColumn.fieldNameUpper}.eq(token.getUsername()));
    </#if>
        if (${table.classNameCamel} == null) {
            if ("admin".equals(token.getUsername()) && "654321".equals(token.getPassword())) {
                //项目刚刚生成，数据库可能没有${table.remarkName}数据，本代码可以提前体登录成功，并体验其他接口
                ByteSource salt = ByteSource.Util.bytes(authConfig.getPassword().getSalt());
                return new SimpleAuthenticationInfo(new ${table.className}(), authConfig.passwordHash(token.getPassword()), salt, "authRealm");
            }
            throw new ClientException("用户名或密码错误");
        }
        //if ("1".equals(${table.classNameCamel}.getEfficet())) {
        //    throw new ClientException("当前用户帐号已被停用，请联系技术服务人员！");
        //}
        ByteSource salt = ByteSource.Util.bytes(authConfig.getPassword().getSalt());
        <#if hasPasswordColumn>
        return new SimpleAuthenticationInfo(${table.classNameCamel}, ${table.classNameCamel}.get${table.passwordColumn.fieldNameUpper}(), salt, "authRealm");
        <#else>
        return new SimpleAuthenticationInfo(${table.classNameCamel}, "password"/*${table.classNameCamel}.getPassword()*/, salt, "authRealm");
        </#if>
    }
    </#list>
<#else >
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
            if ("admin".equals(token.getUsername()) && "654321".equals(token.getPassword())) {
                //项目刚刚生成，数据库可能没有${table.remarkName}数据，本代码可以提前体登录成功，并体验其他接口
                ByteSource salt = ByteSource.Util.bytes(authConfig.getPassword().getSalt());
                return new SimpleAuthenticationInfo(new ${table.className}(), authConfig.passwordHash(token.password), salt, "authRealm");
            }
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

</#if>
}
