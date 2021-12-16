package ${packageName}.shiro.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.apache.shiro.authc.AuthenticationToken;

/**
 * 用户登录 凭证
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@AllArgsConstructor
public class ${className}Token implements AuthenticationToken {

    <#if table.hasOrgan>
    private ${table.orgColumn.fieldTypePrimitive} ${table.orgColumn.fieldName};
    </#if>
    private String username;
    private String password;

    @Override
    public Object getPrincipal() {
        return username;
    }

    @Override
    public Object getCredentials() {
        return password;
    }
}
