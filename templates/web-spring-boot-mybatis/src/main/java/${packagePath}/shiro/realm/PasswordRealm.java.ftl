package ${packageName}.shiro.realm;

import ${packageName}.shiro.provider.AccountProvider;
import ${packageName}.shiro.token.PasswordToken;
import ${packageName}.util.Md5Util;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

/**
 * 这里是登录认证realm
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class PasswordRealm extends AuthorizingRealm {


    private AccountProvider accountProvider;

    /**
     * description 此Realm只支持PasswordToken
     *
     * @return java.lang.Class<?>
     */
    @Override
    public Class<?> getAuthenticationTokenClass() {
        return PasswordToken.class;
    }


    /**
     * description 这里只需要认证登录，成功之后派发 json web token 授权在那里进行
     *
     * @param principalCollection 1
     * @return org.apache.shiro.authz.AuthorizationInfo
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        if (!(authenticationToken instanceof PasswordToken)) {
            return null;
        }

        if(null==authenticationToken.getPrincipal()||null==authenticationToken.getCredentials()){
            throw new UnknownAccountException();
        }
        String appId = (String)authenticationToken.getPrincipal();
        com.wudi.hm.model.api.common.Account account = accountProvider.loadAccount(appId);
        if (account != null) {
            // 用盐对密码进行MD5加密
            ((PasswordToken) authenticationToken).setPassword(Md5Util.md5(((PasswordToken) authenticationToken).getPassword()+account.getSalt()));
            return new SimpleAuthenticationInfo(appId, account.getPassword(), getName());
        } else {
            return new SimpleAuthenticationInfo(appId,"", getName());
        }

    }

    public void setAccountProvider(AccountProvider accountProvider) {
        this.accountProvider = accountProvider;
    }
}
