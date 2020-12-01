package ${packageName}.service;

import com.auth0.jwt.algorithms.Algorithm;
import ${packageName}.model.api.LoginInfo;
import ${packageName}.model.db.${loginTable.className};
import ${packageName}.shiro.JwtBearer;
import ${packageName}.util.JwtUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.annotation.Transient;
import org.springframework.stereotype.Service;

/**
 * 登录信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
public class AuthService {

    private final Algorithm jwtAlgorithm;

    @Value("${r"${token.time.expiry:1}"}")
    private double tokenExpiryTime = 1;

    public AuthService(Algorithm jwtAlgorithm) {
        this.jwtAlgorithm = jwtAlgorithm;
    }

    @Transient
    public LoginInfo login(String username, String password) {
        Subject subject = SecurityUtils.getSubject();
        subject.login(new UsernamePasswordToken(username, password));
        ${loginTable.className} ${loginTable.classNameCamel} = subject.getPrincipals().oneByType(${loginTable.className}.class);

        //${loginTable.classNameCamel}.setPassword("");

        return new LoginInfo(buildToken(${loginTable.classNameCamel}), ${loginTable.classNameCamel});
    }

    private String buildToken(${loginTable.className} ${loginTable.classNameCamel}) {
        JwtBearer bearer = new JwtBearer(${loginTable.classNameCamel}.get${loginTable.idColumn.fieldNameUpper}() + "", "${loginTable.classNameCamel}.getUserName()");
        return JwtUtils.createToken(bearer, jwtAlgorithm, (int)(tokenExpiryTime*60*1000));
    }
}