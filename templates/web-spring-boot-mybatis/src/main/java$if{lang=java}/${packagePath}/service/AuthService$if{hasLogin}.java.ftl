package ${packageName}.service;

import com.auth0.jwt.algorithms.Algorithm;
import ${packageName}.constant.UserType;
import ${packageName}.model.api.LoginInfo;
import ${packageName}.model.conf.AuthConfig;
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className};
    </#list>
<#else >
import ${packageName}.model.db.${loginTable.className}
</#if>
import ${packageName}.shiro.model.JwtBearer;
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.shiro.model.${table.className}Token;
    </#list>
<#else >
import ${packageName}.shiro.model.LoginToken;
</#if>
import ${packageName}.util.JwtUtils;
import lombok.AllArgsConstructor;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 登录认证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
@AllArgsConstructor
public class AuthService {

    private final Algorithm jwtAlgorithm;
    private final AuthConfig authConfig;

<#if hasMultiLogin>
    <#list loginTables as table>
    @Transactional(rollbackFor = Throwable.class)
    public LoginInfo<${table.className}> login${table.className}(<#if table.hasOrgan>${table.orgColumn.fieldTypePrimitive} ${table.orgColumn.fieldName}, </#if>String username, String password) {
        Subject subject = SecurityUtils.getSubject();
        subject.login(new ${table.className}Token(<#if table.hasOrgan>${table.orgColumn.fieldName}, </#if>username, password));
        ${table.className} ${table.classNameCamel} = subject.getPrincipals().oneByType(${table.className}.class);
    <#if table.hasPassword>
        ${table.classNameCamel}.set${table.passwordColumn.fieldNameUpper}("");
    </#if>
    <#if table.hasOrgan>
        JwtBearer bearer = new JwtBearer(UserType.${table.className}.name(), ${table.classNameCamel}.get${table.idColumn.fieldNameUpper}(), ${table.classNameCamel}.get${table.orgColumn.fieldNameUpper}());
    <#else>
        JwtBearer bearer = new JwtBearer(UserType.${table.className}.name(), ${table.classNameCamel}.get${table.idColumn.fieldNameUpper}());
    </#if>
        String token = JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.getExpiryTime());
        return new LoginInfo<>(token, ${table.classNameCamel});
    }

    </#list>
<#else>
    @Transactional(rollbackFor = Throwable.class)
    public LoginInfo login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldTypePrimitive} ${loginTable.orgColumn.fieldName}, </#if>String username, String password) {
        Subject subject = SecurityUtils.getSubject();
        subject.login(new LoginToken(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}, </#if>username, password));
        ${loginTable.className} ${loginTable.classNameCamel} = subject.getPrincipals().oneByType(${loginTable.className}.class);
    <#if table.hasPassword>
        ${loginTable.classNameCamel}.set${table.passwordColumn.fieldNameUpper}("");
    </#if>
        return new LoginInfo(buildToken(${loginTable.classNameCamel}), ${loginTable.classNameCamel});
    }

    private String buildToken(${loginTable.className} ${loginTable.classNameCamel}) {
<#if loginTable.hasOrgan>
        JwtBearer bearer = new JwtBearer(UserType.Admin.name(), ${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}(), ${loginTable.classNameCamel}.get${loginTable.orgColumn.fieldNameUpper}());
<#else>
        JwtBearer bearer = new JwtBearer(UserType.Admin.name(), ${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}());
</#if>
        return JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.getExpiryTime());
    }

</#if>
}
