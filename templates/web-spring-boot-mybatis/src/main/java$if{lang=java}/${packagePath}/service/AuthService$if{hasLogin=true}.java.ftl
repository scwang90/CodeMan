package ${packageName}.service;

import com.auth0.jwt.algorithms.Algorithm;
import ${packageName}.model.api.LoginInfo;
import ${packageName}.model.conf.AuthConfig;
import ${packageName}.model.db.${loginTable.className};
import ${packageName}.shiro.model.JwtBearer;
import ${packageName}.shiro.model.LoginToken;
import ${packageName}.util.JwtUtils;
import lombok.AllArgsConstructor;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 登录信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
@AllArgsConstructor
public class AuthService {

    private final Algorithm jwtAlgorithm;
    private final AuthConfig authConfig;

    @Transactional(rollbackFor = Throwable.class)
    public LoginInfo login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldTypePrimitive} ${loginTable.orgColumn.fieldName}, </#if>String username, String password) {
        Subject subject = SecurityUtils.getSubject();
        subject.login(new LoginToken(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}, </#if>username, password));
        ${loginTable.className} ${loginTable.classNameCamel} = subject.getPrincipals().oneByType(${loginTable.className}.class);

        //${loginTable.classNameCamel}.setPassword("");

        return new LoginInfo(buildToken(${loginTable.classNameCamel}), ${loginTable.classNameCamel});
    }

    private String buildToken(${loginTable.className} ${loginTable.classNameCamel}) {
<#if loginTable.hasOrgan>
        JwtBearer bearer = new JwtBearer(${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}(), ${loginTable.classNameCamel}.get${loginTable.orgColumn.fieldNameUpper}());
<#else>
        JwtBearer bearer = new JwtBearer(${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}());
</#if>
        return JwtUtils.createToken(bearer, jwtAlgorithm, authConfig.getExpiryTime());
    }
}
