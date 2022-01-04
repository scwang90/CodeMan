package ${packageName}.service;

import com.auth0.jwt.algorithms.Algorithm;
import ${packageName}.constant.UserType;
import ${packageName}.exception.ClientException;
<#if hasMultiLogin>
    <#assign hasOrganLogin=false/>
    <#list loginTables as table>
        <#if table.hasOrgan>
            <#assign hasOrganLogin=true/>
        </#if>
import ${packageName}.mapper.auto.${table.className}AutoMapper;
        <#if hasOrganLogin>
import ${packageName}.mapper.intent.api.WhereQuery;
        </#if>
    </#list>
<#else >
import ${packageName}.mapper.auto.${loginTable.className}AutoMapper;
    <#if loginTable.hasOrgan>
import ${packageName}.mapper.intent.api.WhereQuery;
    </#if>
</#if>
import ${packageName}.mapper.intent.Tables;
import ${packageName}.model.api.LoginInfo;
import ${packageName}.model.conf.AuthConfig;
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className};
    </#list>
<#else >
import ${packageName}.model.db.${loginTable.className};
</#if>
import ${packageName}.security.JwtBearer;
import ${packageName}.security.JwtUtils;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
<#list loginTables as table>
    <#if table.hasPassword >

import java.util.Objects;
    </#if>
</#list>

/**
 * 登录认证
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
@AllArgsConstructor
public class AuthService {

    private final AuthConfig config;
    private final Algorithm jwtAlgorithm;
<#if hasMultiLogin>
    <#list loginTables as table>
    private final ${table.className}AutoMapper ${table.classNameCamel}Mapper;
    </#list>
<#else >
    private final ${loginTable.className}AutoMapper ${loginTable.classNameCamel}Mapper;
</#if>

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
    @Transactional(rollbackFor = Throwable.class)
    public LoginInfo<${table.className}> login${table.className}(<#if table.hasOrgan>${table.orgColumn.fieldTypePrimitive} ${table.orgColumn.fieldName}, </#if>String username, String password) {
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
        ${prefix}${table.className} ${table.classNameCamel} = ${table.classNameCamel}Mapper.selectOneWhere(Tables.${table.className}.${table.usernameColumn.fieldNameUpper}.eq(username));
    </#if>
        if (${table.classNameCamel} == null) {
            if ("admin".equals(username) && "654321".equals(password)) {
                //项目刚刚生成，数据库可能没有${table.remarkName}数据，本代码可以提前体登录成功，并体验其他接口
                return new LoginInfo(buildToken(new ${table.className}()), new ${table.className}());
            }
            throw new ClientException("用户名或密码错误");
        }
    <#if table.hasPassword>
        if (!Objects.equals(${table.classNameCamel}.get${table.passwordColumn.fieldNameUpper}(), config.passwordHash(password))) {
            throw new ClientException("用户名或密码错误");
        }
    </#if>

        //if ("1".equals(${table.classNameCamel}.getEfficet())) {
        //    throw new ClientException("当前用户帐号已被停用，请联系技术服务人员！");
        //}
    <#if table.hasPassword>
        ${table.classNameCamel}.set${table.passwordColumn.fieldNameUpper}("");
    </#if>
    <#if table.hasOrgan>
        JwtBearer bearer = new JwtBearer(UserType.${table.className}.name(), ${table.classNameCamel}.get${table.idColumn.fieldNameUpper}(), ${table.classNameCamel}.get${table.orgColumn.fieldNameUpper}());
    <#else>
        JwtBearer bearer = new JwtBearer(UserType.${table.className}.name(), ${table.classNameCamel}.get${table.idColumn.fieldNameUpper}());
    </#if>
        String token = JwtUtils.createToken(bearer, jwtAlgorithm, config.getExpiryTime());
        return new LoginInfo<>(token, ${table.classNameCamel});
    }

    </#list>
<#else>
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
    @Transactional(rollbackFor = Throwable.class)
    public LoginInfo<${loginTable.className}> login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldTypePrimitive} ${loginTable.orgColumn.fieldName}, </#if>String username, String password) {
    <#if hasUsernameColumn>
        <#assign prefix=""/>
    <#else>
        <#assign prefix="//"/>
        ${loginTable.className} ${loginTable.classNameCamel} = null;
    </#if>
    <#if loginTable.hasOrgan>
        ${prefix}WhereQuery<${loginTable.className}> where = Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(username);
        ${prefix}if (token.get${loginTable.orgColumn.fieldNameUpper}()<#if orgColumn.stringType> != null<#else> > 0</#if>) {
        ${prefix}   where.and(Tables.${loginTable.className}.${orgColumn.fieldNameUpper}.eq(token.get${loginTable.orgColumn.fieldNameUpper}()));
        ${prefix}}
        ${prefix}${loginTable.className} ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(where);
    <#else>
        ${prefix}${loginTable.className} ${loginTable.classNameCamel} = ${loginTable.classNameCamel}Mapper.selectOneWhere(Tables.${loginTable.className}.${loginTable.usernameColumn.fieldNameUpper}.eq(username));
    </#if>
        if (${loginTable.classNameCamel} == null) {
            if ("admin".equals(username) && "654321".equals(password)) {
                //项目刚刚生成，数据库可能没有${loginTable.remarkName}数据，本代码可以提前体登录成功，并体验其他接口
                return new LoginInfo<>(buildToken(new ${loginTable.className}()), new ${loginTable.className}());
            }
            throw new ClientException("用户名或密码错误");
        }
    <#if loginTable.hasPassword>
        if (!Objects.equals(${loginTable.classNameCamel}.get${loginTable.passwordColumn.fieldNameUpper}(), config.passwordHash(password))) {
            throw new ClientException("用户名或密码错误");
        }
    </#if>
        //if ("1".equals(${loginTable.classNameCamel}.getEfficet())) {
        //    throw new ClientException("当前用户帐号已被停用，请联系技术服务人员！");
        //}
    <#if table.hasPassword>
        ${loginTable.classNameCamel}.set${table.passwordColumn.fieldNameUpper}("");
    </#if>
        return new LoginInfo<>(buildToken(${loginTable.classNameCamel}), ${loginTable.classNameCamel});
    }

    private String buildToken(${loginTable.className} ${loginTable.classNameCamel}) {
<#if loginTable.hasOrgan>
        JwtBearer bearer = new JwtBearer(UserType.Admin.name(), ${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}(), ${loginTable.classNameCamel}.get${loginTable.orgColumn.fieldNameUpper}());
<#else>
        JwtBearer bearer = new JwtBearer(UserType.Admin.name(), ${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}());
</#if>
        return JwtUtils.createToken(bearer, jwtAlgorithm, config.getExpiryTime());
    }

</#if>
}
